import { Request, Response, NextFunction } from "express";
import UserDAO from "../dao/UserDAO";

class SessionController {
    // checks if user is logged in
    async isUser(req : Request, res : Response, next : NextFunction) {
        try {
            const session = req.session.userId;
            if (session) {
                throw 200;
            }
            throw 400;
        } catch(status) {
            switch(status) {
                case 200:
                    next();
                    break;
                case 400:
                    res.status(400).send("Not authorized!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // checks if user is admin
    async isAdmin(req : Request, res : Response, next : NextFunction) {
        try {
            const session = req.session.userId;
            if (session) {
                const user = await UserDAO.get(session);
                if (user === null) {
                    throw new Error("Failed to find user!");
                }
                if (user.PERMISSION === 1) {
                    throw 200;
                }
            }
            throw 400;
        } catch(status) {
            switch(status) {
                case 200:
                    next();
                    break;
                case 400:
                    res.status(400).send("Not authorized!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }
}

export default new SessionController();