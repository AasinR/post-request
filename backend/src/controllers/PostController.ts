import { Router, Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";
import PublicPost from "../models/PublicPost";

class PostController {
    // create public post

    // create group post

    // get all public post
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM publicpost'
        let connection;
        const oracledb = require('oracledb');
        try {
            connection = await ConnectionConfig.connect();
            const query = await connection.execute(FIND_ALL, [], {outFormat: oracledb.OBJECT});
            const result: PublicPost[] = [];
            query.rows.forEach((data : PublicPost) => {
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

    // get all group post

    // get public post by ID

    // get group post by ID

    // get public posts by userID

    // get group post by groupID

    // delete public post by ID

    // delete group post by ID
}

export default new PostController();