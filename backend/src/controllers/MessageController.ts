import { Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";
import Message from "../models/Message";

class MessageController {
    // send message

    // get all messages
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM PrivateMessage'
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            const result: Message[] = [];
            query.rows.forEach((data: Message) => {
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

    // get messages by userID

    // delete message
}

export default new MessageController();