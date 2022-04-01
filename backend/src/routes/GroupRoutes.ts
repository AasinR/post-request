import { Router } from "express";
import GroupController from "../controllers/GroupController";

class GroupRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();
        this._Router.get("/all", GroupController.findAll);
        this._Router.get("/member/all", GroupController.findAllMember);
    }

    get Router() {
        return this._Router;
    }
}

export default new GroupRoutes();