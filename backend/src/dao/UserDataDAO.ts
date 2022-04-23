import ConnectionConfig from "../config/ConnectionConfig";
import UserData from "../models/UserData";
import User from "../models/User";
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
        const FIND_DATA = `SELECT id, gender, profilepicture, to_char(birthdate, 'yyyy/mm/dd') as birthdate, phonenumber, profession, userid FROM userdata WHERE userid = ${ID}`;
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

    // save user and user data
    async save(user: User, userData: UserData): Promise<UserData> {
        const gender = userData.GENDER ? `'${userData.GENDER}'` : null;
        const birthdate = userData.BIRTHDATE ? `TO_DATE('${userData.BIRTHDATE}', 'yyyy/mm/dd')` : null;
        const phonenumber = userData.PHONENUMBER ? `q'[${userData.PHONENUMBER}]'` : null;
        const profession = userData.PROFESSION ? `q'[${userData.PROFESSION}]'` : null;
        const profilepicture = userData.PROFILEPICTURE ? `'${userData.PROFILEPICTURE}'` : null;

        try {
            const UPDATE_DATA =
                `BEGIN
                    :result := update_user(${user.ID}, q'[${user.PASSWORD}]', q'[${user.EMAIL}]', q'[${user.FIRSTNAME}]', q'[${user.LASTNAME}]', ${gender}, ${profilepicture}, ${birthdate}, ${phonenumber}, ${profession});
                END;`;

            const result = await ConnectionConfig.executeFunc(UPDATE_DATA);
            if (result === null) {
                throw new Error("Failed to execute function!");
            }
            if (result !== '0') {
                const fileID = result.split("=")[2];
                CloudConfig.delete(fileID);
            }

            return userData;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new UserDataDAO();