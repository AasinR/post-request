import { Router } from "express";
import CommentController from "../controllers/CommentController";
import SessionController from "../controllers/SessionController";

class CommentRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();
        this._Router.get("/public/all", SessionController.isAdmin, CommentController.findAllPublic);
        this._Router.get("/group/all", SessionController.isAdmin, CommentController.findAllGroup);
    }

    get Router() {
        return this._Router;
    }
}

export default new CommentRoutes();