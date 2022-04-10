import { Router } from "express";
import multer from "multer";
import PostController from "../controllers/PostController";
import SessionController from "../controllers/SessionController";

class PostRoutes {
    private _Router : Router;

    constructor() {
        const storage = multer.memoryStorage();
        const upload = multer({
            storage
        });

        this._Router = Router();

        this._Router.get("/public/all", SessionController.isAdmin, PostController.findAllPublic);
        this._Router.get("/public/get/:id", SessionController.isUser, PostController.getPublic);
        this._Router.get("/public/getall/:id", SessionController.isUser, PostController.getAllPublic);
        this._Router.post("/public/create", SessionController.isUser, upload.single("image"), PostController.createPublic);
        this._Router.get("/public/delete/:id", SessionController.isUser, PostController.deletePublic);

        this._Router.get("/group/all", SessionController.isAdmin, PostController.findAllGroup);
        this._Router.get("/group/get/:id", SessionController.isUser, PostController.getGroup);
        this._Router.get("/group/getall/:id", SessionController.isUser, PostController.getAllGroup);
        this._Router.post("/group/create", SessionController.isUser, upload.single("image"), PostController.createGroup);
        this._Router.get("/group/delete/:id", SessionController.isUser, PostController.deleteGroup);
    }

    get Router() {
        return this._Router;
    }
}

export default new PostRoutes();