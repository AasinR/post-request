import { Router } from "express";
import GroupController from "../controllers/GroupController";
import SessionController from "../controllers/SessionController";

class GroupRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();

        this._Router.get("/all", SessionController.isUser, GroupController.findAll);
        this._Router.get("/getall/:id", SessionController.isUser, GroupController.getAllGroup);
        this._Router.post("/create", SessionController.isUser, GroupController.createGroup);
        this._Router.get("/member/all", SessionController.isAdmin, GroupController.findAllMember);
    }

    get Router() {
        return this._Router;
    }
}

export default new GroupRoutes();