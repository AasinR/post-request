import ConnectionConfig from "../config/ConnectionConfig";
import MediaAlbum from "../models/MediaAlbum";

class MediaAlbumDAO {
    async findAll(): Promise<MediaAlbum[]> {
        const FIND_ALL = 'SELECT * FROM mediaalbum';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: MediaAlbum[] = [];
            query.rows.forEach((data: MediaAlbum) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new MediaAlbumDAO();