import { Request, Response, NextFunction } from "express";
import PublicPostDAO from "../dao/PublicPostDAO";
import GroupPostDAO from "../dao/GroupPostDAO";
import PictureDAO from "../dao/PictureDAO";
import CloudConfig from "../config/CloudConfig";
import PublicPost from "../models/PublicPost";
import Picture from "../models/Picture";
import GroupPost from "../models/GroupPost";

class PostController {

    // get all public post
    async findAllPublic(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await PublicPostDAO.findAll();
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

    // get all group post
    async findAllGroup(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await GroupPostDAO.findAll();
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

    // get all public post by userId
    async getAllPublic(req : Request, res : Response, next : NextFunction) {
        const id = parseInt(req.params.id, 10);
        const result: {[k: string]: any}[] = [];

        try {
            const posts: {[k: string]: any}[] = await PublicPostDAO.getAll(id);
            if (posts === null) {
                throw new Error("Failed to get public posts!");
            }

            for (const data of posts) {
                let link;
                if (data.PICTURE) {
                    const img = await PictureDAO.get(data.PICTURE);
                    if (img === null) {
                        throw new Error("Failed to get image!");
                    }
                    link = img.CONTENT;
                }
                data.PICTURE = link ? link : null;

                result.push(data);
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

    // get all group post by groupId
    async getAllGroup(req : Request, res : Response, next : NextFunction) {
        const id = parseInt(req.params.id, 10);
        let result;

        try {
            result = await GroupPostDAO.getAll(id);
            if (result === null) {
                throw new Error("Failed to get group posts!");
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

    // get public post by id
    async getPublic(req : Request, res : Response, next : NextFunction) {
        const id = parseInt(req.params.id, 10);
        let result;

        try {
            result = await PublicPostDAO.get(id);
            if (result === null) {
                throw new Error("Failed to execute query!");
            }

            let link;
            if (result.PICTURE) {
                const img = await PictureDAO.get(result.PICTURE);
                if (img === null) {
                    throw new Error("Failed to get image!");
                }
                link = img.CONTENT;
            }
            link = link ? link : null;

            result.PICTURE = link;

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

    // get group post by id
    async getGroup(req : Request, res : Response, next : NextFunction) {
        const id = parseInt(req.params.id, 10);
        let result;

        try {
            result = await GroupPostDAO.get(id);
            if (result === null) {
                throw new Error("Failed to get post!");
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

    // create a public post
    async createPublic(req : Request, res : Response, next : NextFunction) {
        const post = new PublicPost();
        post.TEXT = req.body.text;
        post.USERID = req.session.userId;

        const file = (req.file === undefined) ? null : req.file.buffer;
        let link;

        try {
            if (file) {
                link = await CloudConfig.upload("publicPost", file);

                const img = new Picture();
                img.CONTENT = link;
                img.USERID = req.session.userId;

                const fileRes = await PictureDAO.create(img);
                if (fileRes === null) {
                    throw new Error("Failed to save image!");
                }
                post.PICTURE = fileRes.ID;
            }

            const result = await PublicPostDAO.create(post);
            if (result === null) {
                throw new Error("Failed to save post!");
            }
            post.ID = result.ID;
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        postId: post.ID
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);

                    const fileId = link.split("=")[2];
                    CloudConfig.delete(fileId);
                    break;
            }
        }
    }

    // create a group post
    async createGroup(req : Request, res : Response, next : NextFunction) {
        const post = new GroupPost();
        post.TEXT = req.body.text;
        post.GROUPID = req.body.groupId;
        post.USERID = req.session.userId;

        const file = (req.file === undefined) ? null : req.file.buffer;
        let link;

        try {
            if (file) {
                link = await CloudConfig.upload("groupPost", file);
                post.PICTURE = link;
            }

            const result = await GroupPostDAO.create(post);
            if (result === null) {
                throw new Error("Failed to save post!");
            }
            post.ID = result.ID;
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        postId: post.ID
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);

                    const fileId = link.split("=")[2];
                    CloudConfig.delete(fileId);
                    break;
            }
        }
    }

    // delete public post
    async deletePublic(req : Request, res : Response, next : NextFunction) {
        try {
            const postId = parseInt(req.params.id, 10);
            const post = await PublicPostDAO.get(postId);
            if (post === null) {
                throw new Error("Failed to get post!");
            }
            if (post.USER.ID !== req.session.userId) {
                throw 400;
            }

            const result = await PublicPostDAO.delete(post.ID);
            if (result === null) {
                throw new Error("Failed to delete post!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Post deleted!");
                    break;
                case 400:
                    res.status(400).send("Not authorized to delete other's post!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // delete group post
    async deleteGroup(req : Request, res : Response, next : NextFunction) {
        try {
            const postId = parseInt(req.params.id, 10);
            const post = await GroupPostDAO.get(postId);
            if (post === null) {
                throw new Error("Failed to get post!");
            }
            if (post.USER.ID !== req.session.userId) {
                throw 400;
            }

            const result = await GroupPostDAO.delete(post.ID);
            if (result === null) {
                throw new Error("Failed to delete post!");
            }

            if (post.PICTURE) {
                const fileId = post.PICTURE.split("=")[2];
                CloudConfig.delete(fileId);
            }

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Post deleted!");
                    break;
                case 400:
                    res.status(400).send("Not authorized to delete other's post!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }
}

export default new PostController();