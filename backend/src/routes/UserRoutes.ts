import { Router } from "express";
import UserController from "../controllers/UserController";

class UserRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();

        this._Router.get("/all", UserController.findAll);
    }

    get Router() {
        return this._Router;
    }
}

export default new UserRoutes();