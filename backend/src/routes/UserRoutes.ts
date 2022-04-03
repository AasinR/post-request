import { Router } from "express";
import UserController from "../controllers/UserController";
import multer from "multer";

class UserRoutes {
    private _Router : Router;

    constructor() {
        const storage = multer.memoryStorage();
        const upload = multer({
            storage
        });

        this._Router = Router();

        this._Router.get("/all", UserController.findAll);
        this._Router.get("/get", UserController.getUser);
        this._Router.post("/save", UserController.saveUser);
        this._Router.post("/permission", UserController.permission);
        this._Router.get("/delete", UserController.deleteUser);

        this._Router.get("/data/all", UserController.findAllData);
        this._Router.get("/data/get", UserController.getData);
        this._Router.post("/data/save", upload.single("image"), UserController.saveData);
    }

    get Router() {
        return this._Router;
    }
}

export default new UserRoutes();