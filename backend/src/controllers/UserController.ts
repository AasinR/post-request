import { Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";
import User from "../models/User";

class UserController {

    // get all users
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM "User"'
        let connection;
        try {
            connection = await ConnectionConfig.connect();
            const query = await connection.execute(FIND_ALL);
            const result: User[] = [];
            query.rows.forEach((data: (string|number)[]) => {
                const user = new User();
                user.ID = data[0];
                user.Password = data[1];
                user.Email = data[2];
                user.Permission = data[3];
                user.FirstName = data[4];
                user.LastName = data[5];
                result.push(user);
            })
            res.json({
                "result": result
            });
        } catch(error) {
            // tslint:disable-next-line:no-console
            console.error("Error: "+error);
        } finally {
            try {
                connection.close();
            } catch(closeError) {
                // tslint:disable-next-line:no-console
                console.error("CloseError: "+closeError)
            }
        }
    }

    // get user by ID

    // get userData by userID

    // update user and UserData by ID

    // delete user by ID

    // delete userData by userID

    // get friends by ID

    // get friend requests by ID

    // add friend request

    // update friend requests

    // delete friend by ID
}

export default new UserController();