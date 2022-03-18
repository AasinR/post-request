import { Router } from "express";
import UserController from "../controllers/UserController";

class UserRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();

        this._Router.post("/testRouter", UserController.testRouter);
    }

    get Router() {
        return this._Router;
    }
}

export default new UserRoutes();