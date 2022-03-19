import { Router, Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";

class CommentController {
    // create public comment

    // create group comment

    // get all public comments
    async findAllPublic(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM PublicComment';
        let connection;
        const oracledb = require('oracledb');
        try {
            connection = await ConnectionConfig.connect();
            const query = await connection.execute(FIND_ALL, [], {outFormat: oracledb.OBJECT});
            const result: Comment[] = [];
            query.rows.forEach((data : Comment) => {
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

    // get all group comments
    async findAllGroup(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM GroupComment';
        let connection;
        const oracledb = require('oracledb');
        try {
            connection = await ConnectionConfig.connect();
            const query = await connection.execute(FIND_ALL, [], {outFormat: oracledb.OBJECT});
            const result: Comment[] = [];
            query.rows.forEach((data : Comment) => {
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

    // get public comments by postID

    // get group comments by postID

    // delete public comment

    // delete group comment
}

export default new CommentController();