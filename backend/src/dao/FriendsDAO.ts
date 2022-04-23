import ConnectionConfig from "../config/ConnectionConfig";
import Friends from "../models/Friends";

class FriendsDAO {
    // get all friend
    async findAll(): Promise<Friends[]> {
        const FIND_ALL = 'SELECT * FROM friends';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: Friends[] = [];
            query.rows.forEach((data: Friends) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get all friend by userID
    async getAll(ID: number): Promise<{[k: string]: any}[]> {
        const GET_ALL =
            "SELECT Friends.USER1, Friends.USER2, User1.FIRSTNAME, User1.LASTNAME, Data1.PROFILEPICTURE, User2.FIRSTNAME, User2.LASTNAME, Data2.PROFILEPICTURE "+
            "FROM Friends, \"User\" User1, UserData Data1, \"User\" User2, UserData Data2 "+
            "WHERE Friends.USER1 = User1.ID AND Friends.USER2 = User2.ID AND User1.ID = Data1.USERID AND User2.ID = Data2.USERID AND "+
            `Friends.USER1 = ${ID} `+
            "OR Friends.USER1 = User1.ID AND Friends.USER2 = User2.ID AND User1.ID = Data1.USERID AND User2.ID = Data2.USERID AND "+
            `Friends.USER2 = ${ID}`;

        try {
            const query = await ConnectionConfig.query(GET_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: {[k: string]: any}[] = [];
            query.rows.forEach((data: {[k: string]: any}) => {
                const friend = {
                    USER1: {
                        ID: data.USER1,
                        FIRSTNAME: data.FIRSTNAME,
                        LASTNAME: data.LASTNAME,
                        PROFILEPICTURE: data.PROFILEPICTURE
                    },
                    USER2: {
                        ID: data.USER2,
                        FIRSTNAME: data.FIRSTNAME_1,
                        LASTNAME: data.LASTNAME_1,
                        PROFILEPICTURE: data.PROFILEPICTURE_1
                    }
                }

                result.push(friend);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new FriendsDAO();