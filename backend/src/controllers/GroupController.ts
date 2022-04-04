import { Request, Response, NextFunction } from "express";
import GroupDAO from "../dao/GroupDAO";
import GroupMembersDAO from "../dao/GroupMembersDAO";

class GroupController {

    // get all groups
    async findAll(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await GroupDAO.findAll();
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

    // get all group members
    async findAllMember(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await GroupMembersDAO.findAll();
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

export default new GroupController();