import { Router } from "express";
import FriendController from "../controllers/FriendController";

class FriendRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();
        this._Router.get("/all", FriendController.findAll);
        this._Router.get("/request/all", FriendController.findAllRequest);
    }

    get Router() {
        return this._Router;
    }
}

export default new FriendRoutes();