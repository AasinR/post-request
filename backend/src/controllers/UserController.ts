import { Request, Response, NextFunction } from "express";
import UserDAO from "../dao/UserDAO";
import UserDataDAO from "../dao/UserDataDAO";
import CloudConfig from "../config/CloudConfig";
import UserData from "../models/UserData";
import User from "../models/User";

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

    // get user by ID
    async getUser(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await UserDAO.get(req.session.userId);
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

    // get user data by userID
    async getData(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await UserDataDAO.getByUserID(req.session.userId);
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

    // update user
    async saveUser(req : Request, res : Response, next : NextFunction) {
        try {
            const user = await UserDAO.get(req.session.userId);
            if (user === null) {
                throw new Error("Failed to get user!");
            }
            user.PASSWORD = req.body.password;
            user.EMAIL = req.body.email;
            user.FIRSTNAME = req.body.firstName;
            user.LASTNAME = req.body.lastName;

            const result = await UserDAO.update(user);
            if (result === null) {
                throw new Error("Failed to save user!");
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

    // update permission
    async permission(req : Request, res : Response, next : NextFunction) {
        const data = {
            id: req.body.id,
            permission: req.body.permission
        };

        try {
            const user = await UserDAO.get(data.id);
            if (user === null) {
                throw new Error("Failed to get user!");
            }
            user.PERMISSION = data.permission;
            const result = await UserDAO.update(user);
            if (result === null) {
                throw new Error("Failed to grant permission!");
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

    // upload user data
    async saveData(req : Request, res : Response, next : NextFunction) {
        const userData = new UserData();
        userData.USERID = req.session.userId;
        userData.GENDER = req.body.gender;
        userData.BIRTHDATE = req.body.birthDate;
        userData.PHONENUMBER = req.body.phoneNumber;
        userData.PROFESSION = req.body.profession;

        const file = (req.file === undefined) ? null : req.file.buffer;
        let link;

        try {
            if (file) {
                link = await CloudConfig.upload("user", file);
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

                    const fileID = link.split("=")[2];
                    CloudConfig.delete(fileID);
                    break;
            }
        }
    }

    // delete user
    async deleteUser(req : Request, res : Response, next : NextFunction) {
        try {
            const result = await UserDAO.delete(req.session.userId);
            if (result === null) {
                throw new Error("Failed to delete user!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("User deleted!");
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