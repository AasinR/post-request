import { Router } from "express";
import AlbumController from "../controllers/AlbumController";

class AlbumRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();

        this._Router.get("/all", AlbumController.findAll);
    }

    get Router() {
        return this._Router;
    }
}

export default new AlbumRoutes();