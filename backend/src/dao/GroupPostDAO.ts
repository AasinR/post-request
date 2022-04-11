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
    async getAll(ID: number): Promise<{[k: string]: any}[]> {
        const GET_ALL =
            "SELECT GroupPost.ID, GroupPost.TEXT, GroupPost.TIMESTAMP, GroupPost.PICTURE, GroupPost.GROUPID, \"User\".ID, \"User\".FIRSTNAME, \"User\".LASTNAME, UserData.PROFILEPICTURE "+
            "FROM GroupPost, \"User\", UserData "+
            "WHERE GroupPost.USERID = \"User\".ID AND \"User\".ID = UserData.USERID AND "+
                `GroupPost.GROUPID = ${ID} `+
            "ORDER BY GroupPost.TIMESTAMP DESC";

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
                    GROUPID: data.GROUPID,
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

    // get group post by id
    async get(ID: number): Promise<{[k: string]: any}> {
        const GET_POST =
            "SELECT GroupPost.ID, GroupPost.TEXT, GroupPost.TIMESTAMP, GroupPost.PICTURE, GroupPost.GROUPID, \"User\".ID, \"User\".FIRSTNAME, \"User\".LASTNAME, UserData.PROFILEPICTURE "+
            "FROM GroupPost, \"User\", UserData "+
            "WHERE GroupPost.USERID = \"User\".ID AND \"User\".ID = UserData.USERID AND "+
                `GroupPost.ID = ${ID} `;

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
                GROUPID: query.rows[0].GROUPID,
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