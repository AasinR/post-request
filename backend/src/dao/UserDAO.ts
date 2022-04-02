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

    // insert user
    async save(user: User): Promise<User> {
        const INSERT_USER = `INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('${user.PASSWORD}', '${user.EMAIL}', 0, '${user.FIRSTNAME}', '${user.LASTNAME}') RETURNING id INTO :id`;
        try {
            const result = await ConnectionConfig.modify(INSERT_USER, true);
            user.ID = result;
            return user;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new UserDAO();