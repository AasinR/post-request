import { Router } from "express";
import PictureController from "../controllers/PictureController";

class PictureRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();
        this._Router.get("/all", PictureController.findAll);
    }

    get Router() {
        return this._Router;
    }
}

export default new PictureRoutes();