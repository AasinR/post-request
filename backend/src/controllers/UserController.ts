import { Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";
import CloudConfig from "../config/CloudConfig";
import User from "../models/User";

class UserController {

    // get all users
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM "User"';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            const result: User[] = [];
            query.rows.forEach((data: User) => {
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

    // upload profile picture
    async uploadImg(req : Request, res : Response, next : NextFunction) {
        console.log(req.file)
        /* const link = await CloudConfig.upload(req.body.folder);
        res.send(link); */
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