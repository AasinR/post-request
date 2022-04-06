import ConnectionConfig from "../config/ConnectionConfig";
import MediaAlbum from "../models/MediaAlbum";

class MediaAlbumDAO {
    // get all album
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

    // get album by ID
    async get(ID: number): Promise<MediaAlbum> {
        const GET_ALBUM = `SELECT * FROM mediaalbum WHERE id = ${ID}`;

        try {
            const query: {[k: string]: any} = await ConnectionConfig.query(GET_ALBUM);
            if (query === null) {
                throw new Error("Query failed!");
            }
            if (query.rows.length === 0) {
                throw new Error("No data found!");
            }
            const result = new MediaAlbum();
            result.ID = query.rows[0].ID;
            result.NAME = query.rows[0].NAME;
            result.USERID = query.rows[0].USERID;

            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new MediaAlbumDAO();