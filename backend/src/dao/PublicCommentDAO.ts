import ConnectionConfig from "../config/ConnectionConfig";
import Comment from "../models/Comment";

class PublicCommentDAO {
    async findAll(): Promise<Comment[]> {
        const FIND_ALL = 'SELECT * FROM publiccomment';
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

export default new PublicCommentDAO();