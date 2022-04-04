import { Router } from "express";
import PictureController from "../controllers/PictureController";
import SessionController from "../controllers/SessionController";

class PictureRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();
        this._Router.get("/all", SessionController.isAdmin, PictureController.findAll);
    }

    get Router() {
        return this._Router;
    }
}

export default new PictureRoutes();