import ConnectionConfig from "../config/ConnectionConfig";
import GroupMember from "../models/GroupMember";

class GroupMembersDAO {
    async findAll(): Promise<GroupMember[]> {
        const FIND_ALL = 'SELECT * FROM groupmembers';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: GroupMember[] = [];
            query.rows.forEach((data: GroupMember) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new GroupMembersDAO();