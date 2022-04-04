import ConnectionConfig from "../config/ConnectionConfig";
import Picture from "../models/Picture";

class PictureDAO {
    async findAll(): Promise<Picture[]> {
        const FIND_ALL = 'SELECT * FROM publicpicture';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: Picture[] = [];
            query.rows.forEach((data: Picture) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new PictureDAO();