import ConnectionConfig from "../config/ConnectionConfig";
import Friends from "../models/Friends";

class FriendsDAO {
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
}

export default new FriendsDAO();