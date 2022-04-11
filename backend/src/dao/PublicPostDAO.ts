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
    async getAll(ID: number): Promise<{[k: string]: any}[]> {
        const GET_ALL =
            "SELECT PublicPost.ID, PublicPost.TEXT, PublicPost.TIMESTAMP, PublicPost.PICTURE, \"User\".ID, \"User\".FIRSTNAME, \"User\".LASTNAME, UserData.PROFILEPICTURE "+
            "FROM PublicPost, \"User\", UserData "+
            "WHERE PublicPost.USERID = \"User\".ID AND \"User\".ID = UserData.USERID AND "+
                `PublicPost.USERID = ${ID} `+
            "ORDER BY PublicPost.TIMESTAMP DESC";

        try {
            const query = await ConnectionConfig.query(GET_ALL);
            if (query === null) {
                throw new Error("Query failed!");
            }
            const result: {[k: string]: any}[] = [];
            query.rows.forEach((data: {[k: string]: any}) => {
                const post = {
                    ID: data.ID,
                    TEXT: data.TEXT,
                    TIMESTAMP: data.TIMESTAMP,
                    PICTURE: data.PICTURE,
                    USER: {
                        ID: data.ID_1,
                        FIRSTNAME: data.FIRSTNAME,
                        LASTNAME: data.LASTNAME,
                        PROFILEPICTURE: data.PROFILEPICTURE
                    }
                };

                result.push(post);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get public post by id
    async get(ID: number): Promise<{[k: string]: any}> {
        const GET_POST =
            "SELECT PublicPost.ID, PublicPost.TEXT, PublicPost.TIMESTAMP, PublicPost.PICTURE, \"User\".ID, \"User\".FIRSTNAME, \"User\".LASTNAME, UserData.PROFILEPICTURE "+
            "FROM PublicPost, \"User\", UserData "+
            "WHERE PublicPost.USERID = \"User\".ID AND \"User\".ID = UserData.USERID AND "+
                `PublicPost.ID = ${ID} `;

        try {
            const query: {[k: string]: any} = await ConnectionConfig.query(GET_POST);
            if (query === null) {
                throw new Error("Query failed!");
            }
            if (query.rows.length === 0) {
                throw new Error("No data found!");
            }
            const result = {
                ID: query.rows[0].ID,
                TEXT: query.rows[0].TEXT,
                TIMESTAMP: query.rows[0].TIMESTAMP,
                PICTURE: query.rows[0].PICTURE,
                USER: {
                    ID: query.rows[0].ID_1,
                    FIRSTNAME: query.rows[0].FIRSTNAME,
                    LASTNAME: query.rows[0].LASTNAME,
                    PROFILEPICTURE: query.rows[0].PROFILEPICTURE
                }
            };

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