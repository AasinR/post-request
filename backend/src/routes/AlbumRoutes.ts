import { Router } from "express";
import AlbumController from "../controllers/AlbumController";
import SessionController from "../controllers/SessionController";

class AlbumRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();

        this._Router.get("/all", SessionController.isAdmin, AlbumController.findAll);
    }

    get Router() {
        return this._Router;
    }
}

export default new AlbumRoutes();