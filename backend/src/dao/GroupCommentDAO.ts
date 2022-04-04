import ConnectionConfig from "../config/ConnectionConfig";
import Comment from "../models/Comment";

class GroupCommentDAO {
    async findAll(): Promise<Comment[]> {
        const FIND_ALL = 'SELECT * FROM groupcomment';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: Comment[] = [];
            query.rows.forEach((data: Comment) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new GroupCommentDAO();