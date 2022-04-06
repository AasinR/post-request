import { Router } from "express";
import PictureController from "../controllers/PictureController";
import SessionController from "../controllers/SessionController";

class PictureRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();

        this._Router.get("/all", SessionController.isAdmin, PictureController.findAll);
        this._Router.get("/get/:id", SessionController.isUser, PictureController.get);
        this._Router.get("/getall/:id", SessionController.isUser, PictureController.getAll);
        this._Router.post("/add/:id", SessionController.isUser, PictureController.update);
        this._Router.get("/delete/:id", SessionController.isUser, PictureController.delete);
    }

    get Router() {
        return this._Router;
    }
}

export default new PictureRoutes();