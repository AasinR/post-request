import ConnectionConfig from "../config/ConnectionConfig";
import Group from "../models/Group";

class GroupDAO {
    async findAll(): Promise<Group[]> {
        const FIND_ALL = 'SELECT * FROM "Group"';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: Group[] = [];
            query.rows.forEach((data: Group) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new GroupDAO();