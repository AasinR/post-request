import { Request, Response, NextFunction } from "express";
import UserDAO from "../dao/UserDAO";
import UserDataDAO from "../dao/UserDataDAO";
import CloudConfig from "../config/CloudConfig";

class UserController {

    // get all users
    async findAll(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await UserDAO.findAll();
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

    // get all user data
    async findAllData(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await UserDataDAO.findAll();
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

    // upload profile picture
    async uploadImg(req : Request, res : Response, next : NextFunction) {
        console.log(req.file)
        /* const link = await CloudConfig.upload(req.body.folder);
        res.send(link); */
    }
}

export default new UserController();