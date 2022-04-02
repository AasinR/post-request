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
        this._Router.get("/data/all", UserController.findAllData);

        this._Router.post("/data/save", upload.single("image"), UserController.saveData);
    }

    get Router() {
        return this._Router;
    }
}

export default new UserRoutes();