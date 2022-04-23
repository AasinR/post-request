import { Router } from "express";
import CommentController from "../controllers/CommentController";
import SessionController from "../controllers/SessionController";

class CommentRoutes {
    private _Router : Router;

    constructor() {
        this._Router = Router();

        this._Router.get("/public/all", SessionController.isAdmin, CommentController.findAllPublic);
        this._Router.get("/public/get/:id", SessionController.isUser, CommentController.getPublic);
        this._Router.get("/public/getall/:id", SessionController.isUser, CommentController.getAllPublic);
        this._Router.post("/public/create", SessionController.isUser, CommentController.createPublic);
        this._Router.post("/public/update/:id", SessionController.isUser, CommentController.updatePublic);
        this._Router.get("/public/delete/:id", SessionController.isUser, CommentController.deletePublic);

        this._Router.get("/group/all", SessionController.isAdmin, CommentController.findAllGroup);
        this._Router.get("/group/get/:id", SessionController.isUser, CommentController.getGroup);
        this._Router.get("/group/getall/:id", SessionController.isUser, CommentController.getAllGroup);
        this._Router.post("/group/create", SessionController.isUser, CommentController.createGroup);
        this._Router.post("/group/update/:id", SessionController.isUser, CommentController.updateGroup);
        this._Router.get("/group/delete/:id", SessionController.isUser, CommentController.deleteGroup);
    }

    get Router() {
        return this._Router;
    }
}

export default new CommentRoutes();