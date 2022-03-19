import { Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";
import User from "../models/User";

class UserController {

    // get all users
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM "User"'
        let connection;
        const oracledb = require('oracledb');
        try {
            connection = await ConnectionConfig.connect();
            const query = await connection.execute(FIND_ALL, [], {outFormat: oracledb.OBJECT});
            const result: User[] = [];
            query.rows.forEach((data: User) => {
                result.push(data);
            })
            res.json({
                "result": result
            });
        } catch(error) {
            console.error("Error: "+error);
        } finally {
            try {
                connection.close();
            } catch(closeError) {
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