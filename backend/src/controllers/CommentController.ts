import { Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";
import Comment from "../models/Comment";

class CommentController {
    // create public comment

    // create group comment

    // get all public comments
    async findAllPublic(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM PublicComment';
        const query = await ConnectionConfig.query(FIND_ALL);
        if(query === 500) {
            res.sendStatus(500);
            return;
        }
        const result: Comment[] = [];
        query.rows.forEach((data: Comment) => {
            result.push(data);
        })
        res.json({
            "result": result
        });
    }

    // get all group comments
    async findAllGroup(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM GroupComment';
        const query = await ConnectionConfig.query(FIND_ALL);
        if(query === 500) {
            res.sendStatus(500);
            return;
        }
        const result: Comment[] = [];
        query.rows.forEach((data: Comment) => {
            result.push(data);
        })
        res.json({
            "result": result
        });
    }

    // get public comments by postID

    // get group comments by postID

    // delete public comment

    // delete group comment
}

export default new CommentController();