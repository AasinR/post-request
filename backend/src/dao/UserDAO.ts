import ConnectionConfig from "../config/ConnectionConfig";
import User from "../models/User";

class UserDAO {
    // get all users
    async findAll(): Promise<User[]> {
        const FIND_ALL = 'SELECT * FROM "User"';
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
    async get(ID: number): Promise<User> {
        const FIND_USER = `SELECT * FROM "User" WHERE id = ${ID}`;
        try {
            const query: {[k: string]: any} = await ConnectionConfig.query(FIND_USER);
            if (query === null) {
                throw new Error("Query failed!");
            }
            if (query.rows.length === 0) {
                throw new Error("No data found!");
            }
            const result = new User();
            result.ID = query.rows[0].ID;
            result.PASSWORD = query.rows[0].PASSWORD;
            result.EMAIL = query.rows[0].EMAIL;
            result.PERMISSION = query.rows[0].PERMISSION;
            result.FIRSTNAME = query.rows[0].FIRSTNAME;
            result.LASTNAME = query.rows[0].LASTNAME;

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
}

export default new UserDAO();