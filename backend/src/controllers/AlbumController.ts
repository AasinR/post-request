import { Request, Response, NextFunction } from "express";
import MediaAlbum from "../models/MediaAlbum";
import MediaAlbumDAO from "../dao/MediaAlbumDAO";

class AlbumController {

    // get all albums
    async findAll(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await MediaAlbumDAO.findAll();
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

    // get all album by userID
    async getAll(req : Request, res : Response, next : NextFunction) {
        const userId = parseInt(req.params.id, 10);
        let result;

        try {
            result = await MediaAlbumDAO.getAll(userId);
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

    // get album by ID
    async get(req : Request, res : Response, next : NextFunction) {
        const albumId = parseInt(req.params.id, 10);
        let result;

        try {
            result = await MediaAlbumDAO.get(albumId);
            if (result === null) {
                throw new Error("Failed to get album!");
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

    // create album
    async create(req : Request, res : Response, next : NextFunction) {
        const album = new MediaAlbum();
        album.NAME = req.body.name;
        album.USERID = req.session.userId;

        try {
            const result = await MediaAlbumDAO.create(album);
            if (result === null) {
                throw new Error("Failed to create album!");
            }
            album.ID = result.ID;
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "AlbumID": album.ID
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // update album
    async update(req : Request, res : Response, next : NextFunction) {
        const album = new MediaAlbum();
        album.ID = parseInt(req.params.id, 10);
        album.NAME = req.body.name;
        album.USERID = req.session.userId;

        try {
            const albumRes = await MediaAlbumDAO.get(album.ID);
            if (albumRes.USERID !== album.USERID) {
                throw 400;
            }

            const result = await MediaAlbumDAO.update(album);
            if (result === null) {
                throw new Error("Failed to save album!");
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

    // delete album
    async delete(req : Request, res : Response, next : NextFunction) {
        const albumId = parseInt(req.params.id, 10);

        try {
            const album = await MediaAlbumDAO.get(albumId);
            if (album.USERID !== req.session.userId) {
                throw 400;
            }

            const result = await MediaAlbumDAO.delete(albumId);
            if (result === null) {
                throw new Error("Failed to delete album!");
            }

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Album deleted!");
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

export default new AlbumController();