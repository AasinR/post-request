import { Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";
import MediaAlbum from "../models/MediaAlbum";

class AlbumController {
    // create album

    // get all albums
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM MediaAlbum';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            const result: MediaAlbum[] = [];
            query.rows.forEach((data: MediaAlbum) => {
                result.push(data);
            });
            res.json({
                "result": result
            });
        } catch(error) {
            switch(error) {
                case 500:
                    res.sendStatus(500);
                    break;
                default:
                    console.error(error);
            }
        }
    }

    // get album by ID

    // get albums by userID

    // update album by ID

    // delete album by ID

    // add picture

    // remove picture

    // get pictures by albumID
}

export default new AlbumController();