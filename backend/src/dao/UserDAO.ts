import ConnectionConfig from "../config/ConnectionConfig";
import User from "../models/User";

class UserDAO {
    // get all users
    async findAll(): Promise<{[k: string]: any}[]> {
        const FIND_ALL =
            `SELECT "User".ID, "User".PASSWORD, "User".EMAIL, "User".PERMISSION, "User".FIRSTNAME, "User".LASTNAME, COUNT(Friends.USER1) as FRIENDS_COUNT
            FROM "User" LEFT JOIN Friends ON
                "User".ID = Friends.USER1 OR
                "User".ID = Friends.USER2
            GROUP BY "User".ID, "User".PASSWORD, "User".EMAIL, "User".PERMISSION, "User".FIRSTNAME, "User".LASTNAME`;
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: User[] = [];
            query.rows.forEach((data: User) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get user by ID
    async get(ID: number): Promise<{[k: string]: any}> {
        const FIND_USER =
            `SELECT "User".ID, "User".PASSWORD, "User".EMAIL, "User".PERMISSION, "User".FIRSTNAME, "User".LASTNAME, COUNT(Friends.USER1) as FRIENDS_COUNT
            FROM "User" LEFT JOIN Friends ON
                "User".ID = Friends.USER1 OR
                "User".ID = Friends.USER2
            WHERE "User".ID = ${ID}
            GROUP BY "User".ID, "User".PASSWORD, "User".EMAIL, "User".PERMISSION, "User".FIRSTNAME, "User".LASTNAME`;
        try {
            const query: {[k: string]: any} = await ConnectionConfig.query(FIND_USER);
            if (query === null) {
                throw new Error("Query failed!");
            }
            if (query.rows.length === 0) {
                throw new Error("No data found!");
            }
            const result = {
                ID: query.rows[0].ID,
                PASSWORD: query.rows[0].PASSWORD,
                EMAIL: query.rows[0].EMAIL,
                PERMISSION: query.rows[0].PERMISSION,
                FIRSTNAME: query.rows[0].FIRSTNAME,
                LASTNAME: query.rows[0].LASTNAME,
                FRIENDS_COUNT: query.rows[0].FRIENDS_COUNT
            };

            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // insert user
    async create(user: User): Promise<User> {
        const INSERT_USER = `INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES (q'[${user.PASSWORD}]', q'[${user.EMAIL}]', 0, q'[${user.FIRSTNAME}]', q'[${user.LASTNAME}]') RETURNING id INTO :id`;
        try {
            const result = await ConnectionConfig.modify(INSERT_USER, true);
            user.ID = result;
            return user;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // update user by ID;
    async update(user: User): Promise<User> {
        const UPDATE_USER = `UPDATE "User" SET password = q'[${user.PASSWORD}]', email = q'[${user.EMAIL}]', permission = '${user.PERMISSION}', firstname = q'[${user.FIRSTNAME}]', lastname = q'[${user.LASTNAME}]' WHERE id = ${user.ID}`;

        try {
            ConnectionConfig.modify(UPDATE_USER, false);
            return user;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // delete user by ID
    async delete(ID: number): Promise<number> {
        const DELETE_USER = `DELETE FROM "User" WHERE id = ${ID}`;

        try {
            ConnectionConfig.modify(DELETE_USER, false);
            return ID;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get user activity statistics
    async stat(): Promise<{[k: string]: any}[]> {
        const GET_STAT =
            `SELECT "User".ID, "User".FIRSTNAME, "User".LASTNAME,
            (
                SELECT COUNT(ID)
                FROM PublicPost
                WHERE USERID = "User".ID
            ) PP_COUNT,
            (
                SELECT COUNT(ID)
                FROM PublicComment
                WHERE USERID = "User".ID
            ) PC_COUNT,
            (
                SELECT COUNT(ID)
                FROM GroupPost
                WHERE USERID = "User".ID
            ) GP_COUNT,
            (
                SELECT COUNT(ID)
                FROM GroupComment
                WHERE USERID = "User".ID
            ) GC_COUNT
        FROM "User"
        ORDER BY (PP_COUNT + PC_COUNT + GP_COUNT + GC_COUNT) DESC`;

        try {
            const query = await ConnectionConfig.query(GET_STAT);
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
}

export default new UserDAO();