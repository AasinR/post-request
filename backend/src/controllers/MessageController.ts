import { Request, Response, NextFunction } from "express";
import Message from "../models/Message";
import MessageDAO from "../dao/MessageDAO";
import { datacatalog } from "googleapis/build/src/apis/datacatalog";
import { time } from "console";

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

    async sendMessage(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            const message = new Message();
            message.CONTENT = req.body.content;
            message.TOUSER = req.body.touser;
            message.TIMESTAMP = Date.now().toString();
            message.FROMUSER = req.session.userId;
            result = await MessageDAO.sendMessage(message);
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

    async getMessage(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await MessageDAO.getMessage(parseInt(req.params.id, 10));
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

    async getMessaging(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await MessageDAO.getMessaging(req.body.user1, req.body.user2);
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

    async deleteMessage(req : Request, res : Response, next : NextFunction) {
        try {
            const messageId = parseInt(req.body.id, 10);
            const message = await MessageDAO.getMessage(messageId);
            if (message === null) {
                throw new Error("Failed to get message!");
            }
            if (message.FROMUSER !== req.session.userId) {
                throw 400;
            }

            const result = await MessageDAO.deleteMessage(message.ID, req.session.userId);
            if (result === null) {
                throw new Error("Failed to delete message!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Message deleted!");
                    break;
                case 400:
                    res.status(400).send("Not authorized to delete other's message!");
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