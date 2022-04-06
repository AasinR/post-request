import ConnectionConfig from "../config/ConnectionConfig";
import Picture from "../models/Picture";

class PictureDAO {
    // get all picture
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

    // get picture by id
    async get(ID: number): Promise<Picture> {
        const GET_IMG = `SELECT * FROM publicpicture WHERE id = ${ID}`;

        try {
            const query: {[k: string]: any} = await ConnectionConfig.query(GET_IMG);
            if (query === null) {
                throw new Error("Query failed!");
            }
            if (query.rows.length === 0) {
                throw new Error("No data found!");
            }
            const result = new Picture();
            result.ID = query.rows[0].ID;
            result.CONTENT = query.rows[0].CONTENT;
            result.ALBUMID = query.rows[0].ALBUMID;
            result.USERID = query.rows[0].USERID;

            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // insert picture
    async create(img: Picture): Promise<Picture> {
        const INSERT_IMG = `INSERT INTO publicpicture (content, userid) VALUES ('${img.CONTENT}', '${img.USERID}') RETURNING id INTO :id`;

        try {
            const result = await ConnectionConfig.modify(INSERT_IMG, true);
            img.ID = result;

            return img;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // update picture
    async update(img: Picture): Promise<Picture> {
        const UPDATE_IMG = `UPDATE publicpicture SET albumid = ${img.ALBUMID} WHERE id = ${img.ID}`;

        try {
            ConnectionConfig.modify(UPDATE_IMG, false);
            return img;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // delete picture
    async delete(ID: number): Promise<number> {
        const DELETE_IMG = `DELETE FROM publicpicture WHERE id = ${ID}`;

        try {
            ConnectionConfig.modify(DELETE_IMG, false);
            return ID;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new PictureDAO();