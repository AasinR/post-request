import { Router } from "express";
import FriendController from "../controllers/FriendController";
import SessionController from "../controllers/SessionController";

class FriendRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();

        this._Router.get("/getall/:id", SessionController.isUser, FriendController.getAllFriend);
        this._Router.get("/request/send", SessionController.isUser, FriendController.askForFriend);

        this._Router.get("/all", SessionController.isAdmin, FriendController.findAll);
        this._Router.get("/request/all", SessionController.isAdmin, FriendController.findAllRequest);
    }

    get Router() {
        return this._Router;
    }
}

export default new FriendRoutes();