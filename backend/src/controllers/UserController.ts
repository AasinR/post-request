import { Request, Response, NextFunction } from "express";
import UserDAO from "../dao/UserDAO";
import UserDataDAO from "../dao/UserDataDAO";
import CloudConfig from "../config/CloudConfig";
import UserData from "../models/UserData";
import User from "../models/User";

class UserController {

    // get all users (admin)
    async findAll(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await UserDAO.findAll();
            if (result === null) {
                throw new Error("Failed to get users!");
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

    // get all users (user)
    async findAllUser(req : Request, res : Response, next : NextFunction) {
        const result: {[k: string]: any}[] = [];

        try {
            const users = await UserDAO.findAll();
            if (users === null) {
                throw new Error("Failed to get users!");
            }

            users.forEach((data: {[k: string]: any}) => {
                result.push({
                    ID: data.ID,
                    EMAIL: data.EMAIL,
                    PERMISSION: data.PERMISSION,
                    FIRSTNAME: data.FIRSTNAME,
                    LASTNAME: data.LASTNAME,
                    FRIENDS_COUNT: data.FRIENDS_COUNT
                });
            });
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
        const id = parseInt(req.params.id, 10);
        let result;

        try {
            result = await UserDAO.get(id);
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
        const id = parseInt(req.params.id, 10);
        let result;

        try {
            result = await UserDataDAO.getByUserID(id);
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
            const userRes = await UserDAO.get(req.session.userId);
            if (userRes === null) {
                throw new Error("Failed to get user!");
            }

            const user = new User();
            user.ID = userRes.ID;
            user.PASSWORD = req.body.password;
            user.EMAIL = req.body.email;
            user.FIRSTNAME = req.body.firstName;
            user.LASTNAME = req.body.lastName;
            user.PERMISSION = userRes.PERMISSION;

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
            const userRes = await UserDAO.get(data.id);
            if (userRes === null) {
                throw new Error("Failed to get user!");
            }
            const user = new User();
            user.ID = userRes.ID;
            user.PASSWORD = userRes.PASSWORD;
            user.EMAIL = userRes.EMAIL;
            user.FIRSTNAME = userRes.FIRSTNAME;
            user.LASTNAME = userRes.LASTNAME;
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
        const user = new User();
        user.ID = req.session.userId;
        user.PASSWORD = req.body.password;
        user.EMAIL = req.body.email;
        user.FIRSTNAME = req.body.firstName;
        user.LASTNAME = req.body.lastName;

        const userData = new UserData();
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

            const result = await UserDataDAO.save(user, userData);
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

    // get user activity statistics
    async getStat(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await UserDAO.stat();
            if (result === null) {
                throw new Error("Failed to get stats!");
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

export default new UserController();