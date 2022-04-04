import { Request, Response, NextFunction } from "express";
import FriendsDAO from "../dao/FriendsDAO";
import FriendRequestDAO from "../dao/FriendRequestDAO";

class FriendController {

    // get all friends
    async findAll(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await FriendsDAO.findAll();
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

    // get all friend requests
    async findAllRequest(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await FriendRequestDAO.findAll();
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

export default new FriendController();