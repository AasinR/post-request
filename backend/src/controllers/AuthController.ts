import { Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";
import EnvConfig from "../config/EnvConfig";
import User from "../models/User";

class AuthController {
    // register
    async register(req : Request, res : Response, next : NextFunction) {
        const user = {
            firstName: req.body.firstName,
            lastName: req.body.lastName,
            email: req.body.email,
            password: req.body.password
        };

        const FIND_ALL = 'SELECT * FROM "User"';
        const INSERT_USER = `INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('${user.password}', '${user.email}', 0, '${user.firstName}', '${user.lastName}')`;

        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            query.rows.forEach((data: User) => {
                if(data.EMAIL === user.email) {
                    throw 520;
                }
            });

            ConnectionConfig.insert(INSERT_USER);
            throw 200;

        } catch(error) {
            switch(error) {
                case 200:
                    res.send("Success!");
                    break;
                case 500:
                    res.sendStatus(500);
                    break;
                case 520:
                    res.status(520).send("Email is already in use!");
                    break;
                default:
                    console.log(error);
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
            const FIND_ALL = 'SELECT * FROM "User"';
            const query = await ConnectionConfig.query(FIND_ALL);
            query.rows.forEach((data: User) => {
                if(data.EMAIL === reqData.email && data.PASSWORD === reqData.password) {
                    req.session.userId = data.ID;
                    throw 200;
                }
            });
            throw 520;
        } catch(error) {
            switch(error) {
                case 200:
                    res.send("Success!");
                    break;
                case 500:
                    res.sendStatus(500);
                    break;
                case 520:
                    res.status(520).send("Invalid email or password!");
                    break;
                default:
                    console.log(error);
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