import { Request, Response, NextFunction } from "express";
import ConnectionConfig from "../config/ConnectionConfig";
import MediaAlbum from "../models/MediaAlbum";

class AlbumController {
    // create album

    // get all albums
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM MediaAlbum';
        const query = await ConnectionConfig.query(FIND_ALL);
        if(query === 500) {
            res.sendStatus(500);
            return;
        }
        const result: MediaAlbum[] = [];
        query.rows.forEach((data: MediaAlbum) => {
            result.push(data);
        })
        res.json({
            "result": result
        });
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