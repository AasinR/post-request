import { Router } from "express";
import AuthController from "../controllers/AuthController";

class AuthRoutes {
    private _Router: Router

    constructor() {
        this._Router = Router();

        this._Router.post("/register", AuthController.register);

        this._Router.post("/login", AuthController.login);

        this._Router.get("/logout", AuthController.logout);
    }

    get Router() {
        return this._Router;
    }
}

export default new AuthRoutes();