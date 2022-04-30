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
    async getAll(ID: number): Promise<{[k: string]: any}[]> {
        const GET_ALL =
            `SELECT MediaAlbum.ID, MediaAlbum.NAME, MediaAlbum.USERID, COUNT(PublicPicture.ID) as IMG_COUNT
            FROM MediaAlbum LEFT JOIN PublicPicture ON MediaAlbum.ID = PublicPicture.ALBUMID AND MediaAlbum.USERID = PublicPicture.USERID
            WHERE MediaAlbum.USERID = ${ID}
            GROUP BY MediaAlbum.ID, MediaAlbum.NAME, MediaAlbum.USERID
            ORDER BY IMG_COUNT DESC, MediaAlbum.NAME`;

        try {
            const query = await ConnectionConfig.query(GET_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: {[k: string]: any}[] = [];
            query.rows.forEach((data: {[k: string]: any}) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get album by ID
    async get(ID: number): Promise<{[k: string]: any}> {
        const GET_ALBUM =
            `SELECT MediaAlbum.ID, MediaAlbum.NAME, MediaAlbum.USERID, COUNT(PublicPicture.ID) as IMG_COUNT
            FROM MediaAlbum LEFT JOIN PublicPicture ON MediaAlbum.ID = PublicPicture.ALBUMID AND MediaAlbum.USERID = PublicPicture.USERID
            WHERE MediaAlbum.ID = ${ID}
            GROUP BY MediaAlbum.ID, MediaAlbum.NAME, MediaAlbum.USERID`;

        try {
            const query: {[k: string]: any} = await ConnectionConfig.query(GET_ALBUM);
            if (query === null) {
                throw new Error("Query failed!");
            }
            if (query.rows.length === 0) {
                throw new Error("No data found!");
            }
            const result = {
                ID: query.rows[0].ID,
                NAME: query.rows[0].NAME,
                USERID: query.rows[0].USERID,
                IMG_COUNT: query.rows[0].IMG_COUNT
            }

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
        const DELETE_ALBUM =
            `BEGIN
                delete_album(${ID});
            END;`;

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