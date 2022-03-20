import { Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";
import Group from "../models/Group";

class GroupController {
    // create group

    // get all groups
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM "Group"';
        const query = await ConnectionConfig.query(FIND_ALL);
        if(query === 500) {
            res.sendStatus(500);
            return;
        }
        const result: Group[] = [];
        query.rows.forEach((data: Group) => {
            result.push(data);
        })
        res.json({
            "result": result
        });
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