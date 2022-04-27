import { Request, Response, NextFunction } from "express";
import Group from "../models/Group";
import GroupDAO from "../dao/GroupDAO";
import GroupMembersDAO from "../dao/GroupMembersDAO";
import CloudConfig from "../config/CloudConfig";
import GroupMember from "../models/GroupMember";
import Picture from "../models/Picture";
import PictureDAO from "../dao/PictureDAO";
import { debug } from "console";

class GroupController {

    // get all groups
    async findAll(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await GroupDAO.findAll();
            if (result === null) {
                throw new Error("Failed to execute query!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "result": result
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // get all group members
    async findAllMember(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await GroupMembersDAO.findAll();
            if (result === null) {
                throw new Error("Failed to execute query!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "result": result
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // get all group by userID
    async getAllGroup(req : Request, res : Response, next : NextFunction) {
        const userId = parseInt(req.params.id, 10);
        let result;

        try {
            result = await GroupDAO.getAll(userId);
            if (result === null) {
                throw new Error("Failed to execute query!");
            }

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "result": result
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // create group
    async createGroup(req : Request, res : Response, next : NextFunction)
    {
        const group = new Group();
        group.NAME = req.body.name;
        group.OWNERID = req.session.userId;

        const file = (req.file === undefined) ? null : req.file.buffer;
        let link;

        try {
            if (file) {
                link = await CloudConfig.upload("group", file)
                group.LOGO = link;
            }

            const result = await GroupDAO.createGroup(group);
            if (result === null) {
                throw new Error("Failed to create group!");
            }
            group.ID = result.ID;

            const member = new GroupMember();
            member.GROUPID = group.ID;
            member.USERID = group.OWNERID;
            const addMember = await GroupMembersDAO.add(member);
            if (addMember === null) {
                throw new Error("Failed to add owner to group!");
            }

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "groupId": group.ID
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);

                    if (link) {
                        const fileId = link.split("=")[2];
                        CloudConfig.delete(fileId);
                    }
                    break;
            }
        }
    }

    async editGroup(req : Request, res : Response, next : NextFunction)
    {
        const group = new Group();
        group.ID = parseInt(req.params.id, 10);
        group.NAME = req.body.name;

        const file = (req.file === undefined) ? null : req.file.buffer;
        let link;

        try {
            const groupRes = await GroupDAO.getGroupById(group.ID);
            if (groupRes === null)
            {
                throw new Error("Failed to get group!");
            }
            if (groupRes.OWNERID !== req.session.userId)
            {
                throw 400;
            }
            if (file) {
                link = await CloudConfig.upload("group", file)
                group.LOGO = link;
            }

            const result = await GroupDAO.editGroup(group);
            if (result === null) {
                throw new Error("Failed to edit group!");
            }
            group.ID = result.ID;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "groupId": group.ID
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);

                    if (link) {
                        const fileId = link.split("=")[2];
                        CloudConfig.delete(fileId);
                    }
                    break;
            }
        }
    }

    // get group by ID
    async getGroupById(req : Request, res : Response, next : NextFunction)
    {
        const groupId = parseInt(req.params.id, 10);
        let result;

        try {
            result = await GroupDAO.getGroupById(groupId);
            if (result === null) {
                throw new Error("Failed to execute query!");
            }

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "result": result
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // get group by Name
    async getGroupByName(req : Request, res : Response, next : NextFunction)
    {
        const groupName = req.params.name;
        let result;

        try {
            result = await GroupDAO.getGroupByName(groupName);
            if (result === null) {
                throw new Error("Failed to execute query!");
            }

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "result": result
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // get all member by groupID
    async getAllMember(req : Request, res : Response, next : NextFunction) {
        const groupId = parseInt(req.params.id, 10);
        let result;

        try {
            result = await GroupMembersDAO.getAll(groupId);
            if (result === null) {
                throw new Error("Failed to get members!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "result": result
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // add member to group
    async addMember(req : Request, res : Response, next : NextFunction) {
        const member = new GroupMember();
        member.GROUPID = parseInt(req.params.id, 10);
        member.USERID = req.session.userId;

        try {
            const result = await GroupMembersDAO.add(member);
            if (result === null) {
                throw new Error("Failed to add member to group!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Member added to group!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // remove member from group
    async removeMember(req : Request, res : Response, next : NextFunction) {
        const member = new GroupMember();
        member.GROUPID = parseInt(req.params.id, 10);
        member.USERID = req.body.user;

        try {
            const result = await GroupMembersDAO.delete(member);
            if (result === null) {
                throw new Error("Failed to remove member!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Member removed from group!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }
}

export default new GroupController();