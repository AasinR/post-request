import { Request, Response, NextFunction } from "express";
import PublicCommentDAO from "../dao/PublicCommentDAO";
import GroupCommentDAO from "../dao/GroupCommentDAO";

class CommentController {

    // get all public comments
    async findAllPublic(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await PublicCommentDAO.findAll();
            if (result === null) {
                throw new Error("Failed to execute query!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "result": result
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // get all group comments
    async findAllGroup(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await GroupCommentDAO.findAll();
            if (result === null) {
                throw new Error("Failed to execute query!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "result": result
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }
}

export default new CommentController();