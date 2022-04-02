import { Request, Response, NextFunction } from "express";
import UserDAO from "../dao/UserDAO";
import UserDataDAO from "../dao/UserDataDAO";
import CloudConfig from "../config/CloudConfig";
import UserData from "../models/UserData";

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

    // upload user data
    async saveData(req : Request, res : Response, next : NextFunction) {
        const userData = new UserData();
        userData.USERID = req.session.userId;
        userData.GENDER = req.body.gender;
        userData.BIRTHDATE = req.body.birthDate;
        userData.PHONENUMBER = req.body.phoneNumber;
        userData.PROFESSION = req.body.profession;

        const file = (req.file === undefined) ? null : req.file.buffer;

        try {
            if (file) {
                const link = await CloudConfig.upload("user", file);
                userData.PROFILEPICTURE = link;
            }

            const result = await UserDataDAO.save(userData);
            if (result === null) {
                throw new Error("Failed to save user data!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Success!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }
}

export default new UserController();