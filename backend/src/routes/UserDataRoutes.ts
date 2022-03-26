import { Router } from "express";
import UserDataController from "../controllers/UserDataController";

class UserDataRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();

        this._Router.get("/all", UserDataController.findAll);
    }

    get Router() {
        return this._Router;
    }
}

export default new UserDataRoutes();