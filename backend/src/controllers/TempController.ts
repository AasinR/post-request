import { Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";
import Friends from "../models/Friends";
import FriendRequest from "../models/FriendRequests";
import Picture from "../models/Picture";
import GroupMember from "../models/GroupMember";

class TempController {
    async f_findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM friends';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            const result: Friends[] = [];
            query.rows.forEach((data: Friends) => {
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

    async fr_findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM friendrequest';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            const result: FriendRequest[] = [];
            query.rows.forEach((data: FriendRequest) => {
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

    async p_findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM publicpicture';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            const result: Picture[] = [];
            query.rows.forEach((data: Picture) => {
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

    async gm_findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM groupmembers';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            const result: GroupMember[] = [];
            query.rows.forEach((data: GroupMember) => {
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
}

export default new TempController();