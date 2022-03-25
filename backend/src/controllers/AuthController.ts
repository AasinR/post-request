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
            if(query === 500) {
                res.sendStatus(500);
                return;
            }
            query.rows.forEach((data: User) => {
                if(data.EMAIL === user.email) {
                    res.status(500).send("Email is already in use!");
                    return;
                }
            });

            ConnectionConfig.insert(INSERT_USER);
            res.send("Successful registration!");

        } catch(error) {
            console.log(error);
            res.sendStatus(500);
        }
    }

    // login
    async login(req : Request, res : Response, next : NextFunction) {
        const user = {
            email: req.body.email,
            password: req.body.password
        };

        const FIND_ALL = 'SELECT * FROM "User"';
        const query = await ConnectionConfig.query(FIND_ALL);
        if(query === 500) {
            res.sendStatus(500);
            return;
        }
        query.rows.forEach((data: User) => {
            if(data.EMAIL === user.email && data.PASSWORD === user.password) {
                req.session.userId = data.ID;
                return;
            }
        });
        res.send("Invalid email or password!").status(500);
    }

    // logout
    logout(req : Request, res : Response, next : NextFunction) {
        req.session.destroy(err => {
            if(err) {
                res.send("Failed to logout!").status(500);
                return;
            }
            res.clearCookie(EnvConfig.SESSION_NAME);
            res.send("User has logged out!").status(200);
        });
    }
}

export default new AuthController();