import { Request, Response, NextFunction } from "express";
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
}

export default new AlbumController();