import ConnectionConfig from "../config/ConnectionConfig";
import GroupPost from "../models/GroupPost";

class GroupPostDAO {
    // get all group post
    async findAll(): Promise<GroupPost[]> {
        const FIND_ALL = 'SELECT * FROM grouppost';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: GroupPost[] = [];
            query.rows.forEach((data: GroupPost) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get all group post by groupId
    async getAll(ID: number): Promise<GroupPost[]> {
        const GET_ALL = `SELECT * FROM grouppost WHERE groupid = ${ID}`;

        try {
            const query = await ConnectionConfig.query(GET_ALL);
            if (query === null) {
                throw new Error("Query failed!");
            }
            const result: GroupPost[] = [];
            query.rows.forEach((data: GroupPost) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get group post by id
    async get(ID: number): Promise<GroupPost> {
        const GET_POST = `SELECT * FROM grouppost WHERE id = ${ID}`;

        try {
            const query: {[k: string]: any} = await ConnectionConfig.query(GET_POST);
            if (query === null) {
                throw new Error("Query failed!");
            }
            if (query.rows.length === 0) {
                throw new Error("No data found!");
            }
            const result = new GroupPost();
            result.ID = query.rows[0].ID;
            result.TEXT = query.rows[0].TEXT;
            result.TIMESTAMP = query.rows[0].TIMESTAMP;
            result.PICTURE = query.rows[0].PICTURE;
            result.USERID = query.rows[0].USERID;
            result.GROUPID = query.rows[0].GROUPID;

            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // insert group post
    async create(post: GroupPost): Promise<GroupPost> {
        const text = post.TEXT ? `q'[${post.TEXT}]'` : null;
        const picture = post.PICTURE ? `'${post.PICTURE}'` : null;

        const INSERT_POST = `INSERT INTO grouppost (text, picture, timestamp, groupid, userid) VALUES (${text}, ${picture}, CURRENT_TIMESTAMP, '${post.GROUPID}', '${post.USERID}') RETURNING id INTO :id`;

        try {
            const result = await ConnectionConfig.modify(INSERT_POST, true);
            post.ID = result;

            return post;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // delete group post
    async delete(ID: number): Promise<number> {
        const DELETE_POST = `DELETE FROM grouppost WHERE id = ${ID}`;

        try {
            ConnectionConfig.modify(DELETE_POST, false);
            return ID;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new GroupPostDAO();