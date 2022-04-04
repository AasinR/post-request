import ConnectionConfig from "../config/ConnectionConfig";
import GroupPost from "../models/GroupPost";

class GroupPostDAO {
    async findAll(): Promise<GroupPost[]> {
        const FIND_ALL = 'SELECT * FROM grouppost';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: GroupPost[] = [];
            query.rows.forEach((data: GroupPost) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new GroupPostDAO();