import { Router } from "express";
import PostController from "../controllers/PostController";

class PostRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();
        this._Router.get("/all", PostController.findAll);
    }

    get Router() {
        return this._Router;
    }
}

export default new PostRoutes();