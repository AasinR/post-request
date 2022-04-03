import { Request, Response, NextFunction } from "express";
import UserDAO from "../dao/UserDAO";
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
            const users = await UserDAO.findAll();
            if (users === null) {
                throw new Error("Failed to execute query!");
            }
            users.forEach((data: User) => {
                if(data.EMAIL === user.EMAIL) {
                    throw 400;
                }
            });

            const result = UserDAO.create(user);
            if (result === null) {
                throw new Error("Failed to save user!");
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
        const reqData = {
            email: req.body.email,
            password: req.body.password
        };

        try {
            const users = await UserDAO.findAll();
            if (users === null) {
                throw new Error("Failed to execute query!");
            }
            users.forEach((data: User) => {
                if(data.EMAIL === reqData.email && data.PASSWORD === reqData.password) {
                    req.session.userId = data.ID;
                    throw 200;
                }
            });
            throw 400;
        } catch(status) {
            switch(status) {
                case 200:
                    res.status(200).send("User has logged in!");
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
            res.clearCookie(EnvConfig.SESSION_NAME);
            res.send("User has logged out!");
        });
    }
}

export default new AuthController();