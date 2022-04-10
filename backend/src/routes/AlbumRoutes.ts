import { Router } from "express";
import AlbumController from "../controllers/AlbumController";
import SessionController from "../controllers/SessionController";

class AlbumRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();

        this._Router.get("/all", SessionController.isAdmin, AlbumController.findAll);
        this._Router.get("/get/:id", SessionController.isUser, AlbumController.get);
        this._Router.get("/getall/:id", SessionController.isUser, AlbumController.getAll);
        this._Router.post("/create", SessionController.isUser, AlbumController.create);
        this._Router.post("/update/:id", SessionController.isUser, AlbumController.update);
        this._Router.get("/delete/:id", SessionController.isUser, AlbumController.delete);
    }

    get Router() {
        return this._Router;
    }
}

export default new AlbumRoutes();