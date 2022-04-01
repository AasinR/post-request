import ConnectionConfig from "../config/ConnectionConfig";
import UserData from "../models/UserData";

class UserDataDAO {
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
}

export default new UserDataDAO();