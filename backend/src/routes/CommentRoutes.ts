import { Router } from "express";
import CommentController from "../controllers/CommentController";

class CommentRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();
        this._Router.get("/public/all", CommentController.findAllPublic);
        this._Router.get("/group/all", CommentController.findAllGroup);
    }

    get Router() {
        return this._Router;
    }
}

export default new CommentRoutes();