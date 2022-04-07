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

    // get all album by userID
    async getAll(ID: number): Promise<MediaAlbum[]> {
        const GET_ALL = `SELECT * FROM mediaalbum WHERE userid = ${ID}`;

        try {
            const query = await ConnectionConfig.query(GET_ALL);
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

    // insert album
    async create(album: MediaAlbum): Promise<MediaAlbum> {
        const INSERT_ALBUM = `INSERT INTO mediaalbum (name, userid) VALUES (q'[${album.NAME}]', ${album.USERID}) RETURNING id INTO :id`;

        try {
            const result = await ConnectionConfig.modify(INSERT_ALBUM, true);
            album.ID = result;

            return album;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // update album
    async update(album: MediaAlbum): Promise<MediaAlbum> {
        const UPDATE_ALBUM = `UPDATE mediaalbum SET name = q'[${album.NAME}]' WHERE id = ${album.ID}`;

        try {
            ConnectionConfig.modify(UPDATE_ALBUM, false);
            return album;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // delete album
    async delete(ID: number): Promise<number> {
        const DELETE_ALBUM = `DELETE FROM mediaalbum WHERE id = ${ID}`;

        try {
            ConnectionConfig.modify(DELETE_ALBUM, false);
            return ID;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new MediaAlbumDAO();