import { Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";
import PublicPost from "../models/PublicPost";

class PostController {
    // create public post

    // create group post

    // get all public post
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM publicpost'
        const query = await ConnectionConfig.query(FIND_ALL);
        if(query === 500) {
            res.sendStatus(500);
            return;
        }
        const result: PublicPost[] = [];
        query.rows.forEach((data: PublicPost) => {
            result.push(data);
        })
        res.json({
            "result": result
        });
    }

    // get all group post

    // get public post by ID

    // get group post by ID

    // get public posts by userID

    // get group post by groupID

    // delete public post by ID

    // delete group post by ID
}

export default new PostController();