import { Router, Request, Response, NextFunction } from "express";
import Group from "../models/Group";
import ConnectionConfig from "../config/ConnectionConfig";

class GroupController {
    // create group

    // get all groups
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM "Group"';
        let connection;
        const oracledb = require('oracledb');
        try {
            connection = await ConnectionConfig.connect();
            const query = await connection.execute(FIND_ALL, [], {outFormat: oracledb.OBJECT});
            const result: Group[] = [];
            console.log(query.rows);
            query.rows.forEach((data : Group) => {
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

    // get group by ID

    // get groups by userID

    // get group members by ID

    // update group by ID

    // delete group by ID

    // add member

    // remove member
}

export default new GroupController();