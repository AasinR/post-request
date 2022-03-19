import { Router, Request, Response, NextFunction } from "express";
import Message from "../models/Message";
import ConnectionConfig from "../config/ConnectionConfig";

class MessageController {
    // send message

    // get all messages
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM PrivateMessage'
        let connection;
        const oracledb = require('oracledb');
        try {
            connection = await ConnectionConfig.connect();
            const query = await connection.execute(FIND_ALL, [], {outFormat: oracledb.OBJECT});
            const result: Message[] = [];
            query.rows.forEach((data : Message) => {
                result.push(data);
            })
            res.json({
                "result": result
            });
        } catch(error) {
            console.error("Error: "+error);
        } finally {
            try {
                connection.close();
            } catch(closeError) {
                console.error("CloseError: "+closeError)
            }
        }
    }

    // get messages by userID

    // delete message
}

export default new MessageController();