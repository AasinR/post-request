import ConnectionConfig from "../config/ConnectionConfig";
import PublicPost from "../models/PublicPost";

class PublicPostDAO {
    async findAll(): Promise<PublicPost[]> {
        const FIND_ALL = 'SELECT * FROM publicpost';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: PublicPost[] = [];
            query.rows.forEach((data: PublicPost) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new PublicPostDAO();