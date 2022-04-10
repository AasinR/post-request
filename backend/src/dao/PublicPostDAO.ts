import ConnectionConfig from "../config/ConnectionConfig";
import PublicPost from "../models/PublicPost";

class PublicPostDAO {
    // get all public post
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

    // get all public post by userId
    async getAll(ID: number): Promise<PublicPost[]> {
        const GET_ALL = `SELECT * FROM publicpost WHERE userid = ${ID}`;

        try {
            const query = await ConnectionConfig.query(GET_ALL);
            if (query === null) {
                throw new Error("Query failed!");
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

    // get public post by id
    async get(ID: number): Promise<PublicPost> {
        const GET_POST = `SELECT * FROM publicpost WHERE id = ${ID}`;

        try {
            const query: {[k: string]: any} = await ConnectionConfig.query(GET_POST);
            if (query === null) {
                throw new Error("Query failed!");
            }
            if (query.rows.length === 0) {
                throw new Error("No data found!");
            }
            const result = new PublicPost();
            result.ID = query.rows[0].ID;
            result.TEXT = query.rows[0].TEXT;
            result.TIMESTAMP = query.rows[0].TIMESTAMP;
            result.PICTURE = query.rows[0].PICTURE;
            result.USERID = query.rows[0].USERID;

            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // insert public post
    async create(post: PublicPost): Promise<PublicPost> {
        const text = post.TEXT ? `q'[${post.TEXT}]'` : null;
        const picture = post.PICTURE ? `'${post.PICTURE}'` : null;

        const INSERT_POST = `INSERT INTO publicpost (text, timestamp, picture, userid) VALUES (${text}, CURRENT_TIMESTAMP, ${picture}, '${post.USERID}') RETURNING id INTO :id`;

        try {
            const result = await ConnectionConfig.modify(INSERT_POST, true);
            post.ID = result;

            return post;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // delete public post
    async delete(ID: number): Promise<number> {
        const DELETE_POST = `DELETE FROM publicpost WHERE id = ${ID}`;

        try {
            ConnectionConfig.modify(DELETE_POST, false);
            return ID;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new PublicPostDAO();