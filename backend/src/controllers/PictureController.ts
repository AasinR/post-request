import { Request, Response, NextFunction } from "express";
import Picture from "../models/Picture";
import PictureDAO from "../dao/PictureDAO";
import MediaAlbumDAO from "../dao/MediaAlbumDAO";
import CloudConfig from "../config/CloudConfig";

class PictureController {

    // get all pictures
    async findAll(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await PictureDAO.findAll();
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

    // get all image by userID
    async getAll(req : Request, res : Response, next : NextFunction) {
        const userId = parseInt(req.params.id, 10);
        let result;

        try {
            result = await PictureDAO.getAll(userId);
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

    // get all image by albumID
    async getAlbum(req : Request, res : Response, next : NextFunction) {
        const albumId = parseInt(req.params.id, 10);
        let result;

        try {
            result = await PictureDAO.getAlbum(albumId);
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

    // get image by ID
    async get(req : Request, res : Response, next : NextFunction) {
        const imgId = parseInt(req.params.id, 10);
        let result;

        try {
            result = await PictureDAO.get(imgId);
            if (result === null) {
                throw new Error("Failed to get image!");
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

    // change image's album
    async update(req : Request, res : Response, next : NextFunction) {
        const img = new Picture();
        img.ID = parseInt(req.params.id, 10);
        img.ALBUMID = req.body.albumId;

        try {
            const imgRes = await PictureDAO.get(img.ID);
            if (imgRes === null) {
                throw new Error("Failed to get image!");
            }
            if (imgRes.USERID !== req.session.userId) {
                throw 400;
            }

            if (img.ALBUMID) {
                const album = await MediaAlbumDAO.get(img.ALBUMID);
                if (album === null) {
                    throw new Error("Failed to get album!");
                }
                if (album.USERID !== req.session.userId) {
                    throw 400;
                }
            }

            const result = await PictureDAO.update(img);
            if (result === null) {
                throw new Error("Failed to add image to album!");
            }

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Success!");
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

    // delete image
    async delete(req : Request, res : Response, next : NextFunction) {
        const imgId = parseInt(req.params.id, 10);

        try {
            const img = await PictureDAO.get(imgId);
            if (img === null) {
                throw new Error("Failed to get image!");
            }
            if (img.USERID !== req.session.userId) {
                throw 400;
            }

            const result = await PictureDAO.delete(imgId);
            if (result === null) {
                throw new Error("Failed to delete image!");
            }

            const fileId = img.CONTENT.split("=")[2];
            CloudConfig.delete(fileId);

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Image deleted!");
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

export default new PictureController();