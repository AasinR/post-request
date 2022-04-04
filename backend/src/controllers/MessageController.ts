import { Request, Response, NextFunction } from "express";
import MessageDAO from "../dao/MessageDAO";

class MessageController {

    // get all messages
    async findAll(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await MessageDAO.findAll();
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

export default new MessageController();