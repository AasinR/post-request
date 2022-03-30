import { Request, Response, NextFunction } from "express";
import GroupPost from "../models/GroupPost";
import ConnectionConfig from "../config/ConnectionConfig";
import PublicPost from "../models/PublicPost";

class PostController {
    // create public post

    // create group post

    // get all public post
    async findAllPublic(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM publicpost'
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            const result: PublicPost[] = [];
            query.rows.forEach((data: PublicPost) => {
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

    // get all group post
    async findAllGroup(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM GroupPost'
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            const result: GroupPost[] = [];
            query.rows.forEach((data: GroupPost) => {
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

    // get public post by ID

    // get group post by ID

    // get public posts by userID

    // get group post by groupID

    // delete public post by ID

    // delete group post by ID
}

export default new PostController();