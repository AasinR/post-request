import { Router } from "express";
import MessageController from "../controllers/MessageController";
import SessionController from "../controllers/SessionController";

class MessageRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();
        this._Router.get("/all", SessionController.isAdmin, MessageController.findAll);

        this._Router.get("/getMessaging/:toId", SessionController.isUser, MessageController.getMessaging);
        this._Router.get("/get/:id", SessionController.isUser, MessageController.getMessage);
        this._Router.get("/delete/:id", SessionController.isUser, MessageController.deleteMessage);
        this._Router.post("/send", SessionController.isUser, MessageController.sendMessage);
        this._Router.post("/update/:id", SessionController.isUser, MessageController.update);
        this._Router.get("/stat/:id", SessionController.isAdmin, MessageController.getStat);
    }

    get Router() {
        return this._Router;
    }
}

export default new MessageRoutes();