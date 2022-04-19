import { Request, Response, NextFunction } from "express";
import AuthDAO from "../dao/AuthDAO";
import EnvConfig from "../config/EnvConfig";
import User from "../models/User";

class AuthController {
    // register
    async register(req : Request, res : Response, next : NextFunction) {
        const user = new User();
        user.FIRSTNAME = req.body.firstName;
        user.LASTNAME = req.body.lastName;
        user.EMAIL = req.body.email;
        user.PASSWORD = req.body.password;

        try {
            const result = await AuthDAO.register(user);
            if (result === null) {
                throw new Error("Failed to register user!");
            }
            if (result === 0) {
                throw 400;
            }

            throw 200;
        } catch(error) {
            switch(error) {
                case 200:
                    res.send("Successful registration!");
                    break;
                case 400:
                    res.status(400).send("Email is already in use!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(error);
                    break;
            }
        }
    }

    // login
    async login(req : Request, res : Response, next : NextFunction) {
        const user = new User();
        user.EMAIL = req.body.email;
        user.PASSWORD = req.body.password;

        try {
            const result = await AuthDAO.login(user);
            if (result === null) {
                throw new Error("Failed to register user!");
            }
            if (result === 0) {
                throw 400;
            }

            req.session.userId = result;
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "UserID": req.session.userId
                    });
                    break;
                case 400:
                    res.status(400).send("Invalid email or password!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // logout
    logout(req : Request, res : Response, next : NextFunction) {
        req.session.destroy(err => {
            if(err) {
                return res.status(500).send("Failed to logout!");
            }
            else {
                res.clearCookie(EnvConfig.SESSION_NAME);
                res.send("User has logged out!");
            }
        });
    }
}

export default new AuthController();