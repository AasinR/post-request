import ConnectionConfig from "../config/ConnectionConfig";
import Comment from "../models/Comment";

class GroupCommentDAO {
    // get all group comment
    async findAll(): Promise<Comment[]> {
        const FIND_ALL = 'SELECT * FROM groupcomment';
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

    // get all group comment by postID
    async getAll(ID: number): Promise<Comment[]> {
        const GET_ALL = `SELECT * FROM groupcomment WHERE postid = ${ID}`;

        try {
            const query = await ConnectionConfig.query(GET_ALL);
            if (query === null) {
                throw new Error("Query failed!");
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

    // get group comment by ID
    async get(ID: number): Promise<Comment> {
        const GET_COMMENT = `SELECT * FROM groupcomment WHERE id = ${ID}`;

        try {
            const query: {[k: string]: any} = await ConnectionConfig.query(GET_COMMENT);
            if (query === null) {
                throw new Error("Query failed!");
            }
            if (query.rows.length === 0) {
                throw new Error("No data found!");
            }
            const result = new Comment();
            result.ID = query.rows[0].ID;
            result.CONTENT = query.rows[0].CONTENT;
            result.TIMESTAMP = query.rows[0].TIMESTAMP;
            result.POSTID = query.rows[0].POSTID;
            result.USERID = query.rows[0].USERID;

            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // insert group comment
    async create(comment: Comment): Promise<Comment> {
        const INSERT_COMMENT = `INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES (q'[${comment.CONTENT}]', CURRENT_TIMESTAMP, '${comment.POSTID}', '${comment.USERID}') RETURNING id INTO :id`;

        try {
            const result = await ConnectionConfig.modify(INSERT_COMMENT, true);
            comment.ID = result;

            return comment;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // delete group comment
    async delete(ID: number): Promise<number> {
        const DELETE_COMMENT = `DELETE FROM groupcomment WHERE id = ${ID}`;

        try {
            ConnectionConfig.modify(DELETE_COMMENT, false);
            return ID;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new GroupCommentDAO();