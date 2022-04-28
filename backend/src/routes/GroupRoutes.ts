import { Router } from "express";
import multer from "multer";
import GroupController from "../controllers/GroupController";
import SessionController from "../controllers/SessionController";

class GroupRoutes {
    private _Router : Router;

    constructor() {
        const storage = multer.memoryStorage();
        const upload = multer({
            storage
        });

        this._Router = Router();

        this._Router.get("/all", SessionController.isUser, GroupController.findAll);
        this._Router.get("/getall/:id", SessionController.isUser, GroupController.getAllGroup);
        this._Router.post("/create", SessionController.isUser, upload.single("image"), GroupController.createGroup);
        this._Router.get("/get/:id", SessionController.isUser, GroupController.getGroupById);
        this._Router.get("/getname/:name", SessionController.isUser, GroupController.getGroupByName);
        this._Router.post("/edit/:id", SessionController.isUser, upload.single("image"), GroupController.editGroup);
        this._Router.post("/delete/:id", SessionController.isUser, GroupController.deleteGroup);

        this._Router.get("/member/all", SessionController.isAdmin, GroupController.findAllMember);
        this._Router.get("/member/getall/:id", SessionController.isUser, GroupController.getAllMember);
        this._Router.get("/member/add/:id", SessionController.isUser, GroupController.addMember);
        this._Router.post("/member/remove/:id", SessionController.isUser, GroupController.removeMember);
    }

    get Router() {
        return this._Router;
    }
}

export default new GroupRoutes();