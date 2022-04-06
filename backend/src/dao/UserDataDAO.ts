import ConnectionConfig from "../config/ConnectionConfig";
import UserData from "../models/UserData";
import CloudConfig from "../config/CloudConfig";

class UserDataDAO {
    // get all user data from database
    async findAll(): Promise<UserData[]> {
        const FIND_ALL = 'SELECT * FROM userdata';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: UserData[] = [];
            query.rows.forEach((data: UserData) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get user data by userID
    async getByUserID(ID: number): Promise<UserData> {
        const FIND_DATA = `SELECT * FROM userdata WHERE userid = ${ID}`;
        try {
            const query: {[k: string]: any} = await ConnectionConfig.query(FIND_DATA);
            if (query === null) {
                throw Error("Query failed!");
            }
            if (query.rows.length === 0) {
                throw new Error("No data found!");
            }
            const result = new UserData();
            result.ID = query.rows[0].ID;
            result.GENDER = query.rows[0].GENDER;
            result.PROFILEPICTURE = query.rows[0].PROFILEPICTURE;
            result.BIRTHDATE = query.rows[0].BIRTHDATE;
            result.PHONENUMBER = query.rows[0].PHONENUMBER;
            result.PROFESSION = query.rows[0].PROFESSION;
            result.USERID = query.rows[0].USERID;

            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // save user data
    async save(userData: UserData): Promise<UserData> {
        const gender = userData.GENDER ? `'${userData.GENDER}'` : null;
        const birthdate = userData.BIRTHDATE ? `TO_DATE('${userData.BIRTHDATE}', 'yyyy/mm/dd')` : null;
        const phonenumber = userData.PHONENUMBER ? `'${userData.PHONENUMBER}'` : null;
        const profession = userData.PROFESSION ? `'${userData.PROFESSION}'` : null;
        let profilepicture = userData.PROFILEPICTURE ? `'${userData.PROFILEPICTURE}'` : null;

        try {
            const rowExists = await this.getByUserID(userData.USERID);
            if (rowExists) {
                profilepicture = profilepicture ? profilepicture : ((rowExists.PROFILEPICTURE) ? `'${rowExists.PROFILEPICTURE}'` : null);

                if (profilepicture !== rowExists.PROFILEPICTURE) {
                    const fileID = rowExists.PROFILEPICTURE.split("=")[2];
                    CloudConfig.delete(fileID);
                }

                const UPDATE_DATA = `UPDATE userdata SET gender = ${gender}, profilepicture = ${profilepicture}, birthdate = ${birthdate}, phonenumber = ${phonenumber}, profession = ${profession} WHERE userid = ${userData.USERID}`;

                ConnectionConfig.modify(UPDATE_DATA, false);
            }
            else {
                const INSERT_DATA = `INSERT INTO userdata (gender, profilepicture, birthdate, phonenumber, profession, userid) VALUES (${gender},${profilepicture},${birthdate},${phonenumber},${profession},${userData.USERID})`;

                ConnectionConfig.modify(INSERT_DATA, false);
            }

            return userData;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new UserDataDAO();