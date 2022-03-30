import { Request, Response, NextFunction } from "express";
import UserData from "../models/UserData";
import ConnectionConfig from "../config/ConnectionConfig";

class UserDataController {

    // get all users
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM userdata';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            const result: UserData[] = [];
            query.rows.forEach((data: UserData) => {
                result.push(data);
            });
            res.json({
                "result": result
            });
        } catch(error) {
            switch(error) {
                case 500:
                    res.sendStatus(500);
                    break;
                default:
                    console.error(error);
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

export default new UserDataController();