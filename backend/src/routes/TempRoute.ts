import { Router } from "express";
import TempController from "../controllers/TempController";

class TempRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();
        this._Router.get("/friends/all", TempController.f_findAll);
        this._Router.get("/friendrequests/all", TempController.fr_findAll);
        this._Router.get("/groupmembers/all", TempController.gm_findAll);
        this._Router.get("/pictures/all", TempController.p_findAll);
    }

    get Router() {
        return this._Router;
    }
}

export default new TempRoutes();