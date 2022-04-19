import { Router } from "express";
import MessageController from "../controllers/MessageController";
import SessionController from "../controllers/SessionController";

class MessageRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();
        this._Router.get("/all", SessionController.isAdmin, MessageController.findAll);

        this._Router.get("/:id", SessionController.isUser, MessageController.getMessage);
        this._Router.get("/delete", SessionController.isUser, MessageController.deleteMessage);
        this._Router.get("/get", SessionController.isUser, MessageController.getMessaging);
        this._Router.post("/send", SessionController.isUser, MessageController.sendMessage);
    }

    get Router() {
        return this._Router;
    }
}

export default new MessageRoutes();