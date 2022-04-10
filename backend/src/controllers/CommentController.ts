import { Request, Response, NextFunction } from "express";
import PublicCommentDAO from "../dao/PublicCommentDAO";
import GroupCommentDAO from "../dao/GroupCommentDAO";
import Comment from "../models/Comment";

class CommentController {

    // get all public comments
    async findAllPublic(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await PublicCommentDAO.findAll();
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

    // get all group comments
    async findAllGroup(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await GroupCommentDAO.findAll();
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

    // get all public comment by postID
    async getAllPublic(req : Request, res : Response, next : NextFunction) {
        const postId = parseInt(req.params.id, 10);
        let result;

        try {
            result = await PublicCommentDAO.getAll(postId);
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

    // get all group comment by postID
    async getAllGroup(req : Request, res : Response, next : NextFunction) {
        const postId = parseInt(req.params.id, 10);
        let result;

        try {
            result = await GroupCommentDAO.getAll(postId);
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

    // get public comment by ID
    async getPublic(req : Request, res : Response, next : NextFunction) {
        const commentId = parseInt(req.params.id, 10);
        let result;

        try {
            result = await PublicCommentDAO.get(commentId);
            if (result === null) {
                throw new Error("Failed to get comment!");
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

    // get group comment by ID
    async getGroup(req : Request, res : Response, next : NextFunction) {
        const commentId = parseInt(req.params.id, 10);
        let result;

        try {
            result = await GroupCommentDAO.get(commentId);
            if (result === null) {
                throw new Error("Failed to get comment!");
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

    // create public comment
    async createPublic(req : Request, res : Response, next : NextFunction) {
        const comment = new Comment();
        comment.CONTENT = req.body.content;
        comment.POSTID = req.body.postId;
        comment.USERID = req.session.userId;

        try {
            const result = await PublicCommentDAO.create(comment);
            if (result === null) {
                throw new Error("Failed to save public comment!");
            }
            comment.ID = result.ID;

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "commentId": comment.ID
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // create group comment
    async createGroup(req : Request, res : Response, next : NextFunction) {
        const comment = new Comment();
        comment.CONTENT = req.body.content;
        comment.POSTID = req.body.postId;
        comment.USERID = req.session.userId;

        try {
            const result = await GroupCommentDAO.create(comment);
            if (result === null) {
                throw new Error("Failed to save group comment!");
            }
            comment.ID = result.ID;

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "commentId": comment.ID
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // delete public comment by ID
    async deletePublic(req : Request, res : Response, next : NextFunction) {
        const commentId = parseInt(req.params.id, 10);

        try {
            const comment = await PublicCommentDAO.get(commentId);
            if (comment === null) {
                throw new Error("Failed to get comment!");
            }
            if (comment.USERID !== req.session.userId) {
                throw 400;
            }

            const result = await PublicCommentDAO.delete(commentId);
            if (result === null) {
                throw new Error("Failed to delete public comment!");
            }

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Comment deleted!");
                    break;
                case 400:
                    res.status(400).send("Not authorized to do this!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // delete group comment by ID
    async deleteGroup(req : Request, res : Response, next : NextFunction) {
        const commentId = parseInt(req.params.id, 10);

        try {
            const comment = await GroupCommentDAO.get(commentId);
            if (comment === null) {
                throw new Error("Failed to get comment!");
            }
            if (comment.USERID !== req.session.userId) {
                throw 400;
            }

            const result = await GroupCommentDAO.delete(commentId);
            if (result === null) {
                throw new Error("Failed to delete group comment!");
            }

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Comment deleted!");
                    break;
                case 400:
                    res.status(400).send("Not authorized to do this!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }
}

export default new CommentController();