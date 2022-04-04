import { Request, Response, NextFunction } from "express";
import PublicPostDAO from "../dao/PublicPostDAO";
import GroupPostDAO from "../dao/GroupPostDAO";

class PostController {

    // get all public post
    async findAllPublic(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await PublicPostDAO.findAll();
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

    // get all group post
    async findAllGroup(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await GroupPostDAO.findAll();
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

export default new PostController();