import { Router, Request, Response, NextFunction } from "express";

class UserController {
    testRouter(req : Request, res : Response, next : NextFunction) {
        const data = req.body.test;
        res.json({
            "test": "router",
            "input": data
        });
    }

    // get all users

    // get user by ID

    // get userData by userID

    // update user and UserData by ID

    // delete user by ID

    // delete userData by userID

    // get friends by ID

    // get friend requests by ID

    // add friend request

    // update friend requests

    // delete friend by ID
}

export default new UserController();