import { Router, Request, Response, NextFunction } from "express";
import MediaAlbum from "../models/MediaAlbum";
import ConnectionConfig from "../config/ConnectionConfig";

class AlbumController {
    // create album

    // get all albums
    async findAll(req : Request, res : Response, next : NextFunction) {
        const FIND_ALL = 'SELECT * FROM MediaAlbum';
        let connection;
        const oracledb = require('oracledb');
        try {
            connection = await ConnectionConfig.connect();
            const query = await connection.execute(FIND_ALL, [], {outFormat: oracledb.OBJECT});
            const result: MediaAlbum[] = [];
            query.rows.forEach((data : MediaAlbum) => {
                result.push(data);
            })
            res.json({
                "result": result
            });
        } catch(error) {
            console.error("Error: "+error);
        } finally {
            try {
                connection.close();
            } catch(closeError) {
                console.error("CloseError: "+closeError)
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