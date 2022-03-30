import { Router } from "express";
import MessageController from "../controllers/MessageController";

class MessageRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();
        this._Router.get("/all", MessageController.findAll);
    }

    get Router() {
        return this._Router;
    }
}

export default new MessageRoutes();