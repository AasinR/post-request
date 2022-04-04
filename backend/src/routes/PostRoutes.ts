import { Router } from "express";
import PostController from "../controllers/PostController";
import SessionController from "../controllers/SessionController";

class PostRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();
        this._Router.get("/public/all", SessionController.isAdmin, PostController.findAllPublic);
        this._Router.get("/group/all", SessionController.isAdmin, PostController.findAllGroup);
    }

    get Router() {
        return this._Router;
    }
}

export default new PostRoutes();