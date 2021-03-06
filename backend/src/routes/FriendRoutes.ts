import { Router } from "express";
import FriendController from "../controllers/FriendController";
import SessionController from "../controllers/SessionController";

class FriendRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();

        this._Router.get("/all", SessionController.isAdmin, FriendController.findAll);
        this._Router.get("/getall/:id", SessionController.isUser, FriendController.getAllFriend);

        this._Router.get("/request/all", SessionController.isAdmin, FriendController.findAllRequest);
        this._Router.get("/request/getall/:id", SessionController.isUser, FriendController.getAllRequest);
        this._Router.get("/request/accept/:id", SessionController.isUser, FriendController.acceptRequest);
        this._Router.get("/request/reject/:id", SessionController.isUser, FriendController.rejectRequest);
        this._Router.get("/request/send/:id", SessionController.isUser, FriendController.askForFriend);
    }

    get Router() {
        return this._Router;
    }
}

export default new FriendRoutes();