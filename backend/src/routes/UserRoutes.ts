import { Router } from "express";
import multer from "multer";
import UserController from "../controllers/UserController";
import SessionController from "../controllers/SessionController";

class UserRoutes {
    private _Router : Router;

    constructor() {
        const storage = multer.memoryStorage();
        const upload = multer({
            storage
        });

        this._Router = Router();

        this._Router.get("/all", SessionController.isAdmin, UserController.findAll);
        this._Router.get("/get", SessionController.isUser, UserController.getUser);
        this._Router.post("/save", SessionController.isUser, UserController.saveUser);
        this._Router.post("/permission", SessionController.isAdmin, UserController.permission);
        this._Router.get("/delete", SessionController.isUser, UserController.deleteUser);

        this._Router.get("/data/all", SessionController.isAdmin, UserController.findAllData);
        this._Router.get("/data/get", SessionController.isUser, UserController.getData);
        this._Router.post("/data/save", SessionController.isUser, upload.single("image"), UserController.saveData);
    }

    get Router() {
        return this._Router;
    }
}

export default new UserRoutes();