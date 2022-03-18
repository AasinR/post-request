import { Router, Request, Response, NextFunction } from "express";
import oracledb from "oracledb";

if(process.platform === "win32") {
    try {
        oracledb.initOracleClient({libDir: "C:\\Oracle\\instantclient_21_3"});
    } catch(error) {
        // tslint:disable-next-line:no-console
        console.error("ClientNotFound: "+error);
    }
}
const host = "localhost";
const port = 1521;
const dbName = "xe"

class UserController {

    // get all users
    findAll(req : Request, res : Response, next : NextFunction) {
        oracledb.getConnection(
            {
                user: "ADMIN",
                password: "admin01",
                connectString: `(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=${host})(Port=${port}))(CONNECT_DATA=(SID=${dbName})))`
            },
            (err, connction) => {
                if(err) {
                    // tslint:disable-next-line:no-console
                    console.error("NoDatabase: "+err.message);
                    return;
                }
                connction.execute(
                    'SELECT * FROM "User"',
                    (connError, result) => {
                        if(connError) {
                            // tslint:disable-next-line:no-console
                            console.error("FailedRequest: "+connError.message);
                            connction.close(closeError => {
                                if(closeError) {
                                    // tslint:disable-next-line:no-console
                                    console.error("FailedToClose: "+closeError.message);
                                }
                            })
                        }
                        res.json({
                            "result": result
                        });
                    }
                );
            }
        )
    }

    // get user by ID

    // get userData by userID

    // update user and UserData by ID

    // delete user by ID

    // delete userData by userID

    // get friends by ID

    // get friend requests by ID

    // add friend request

    // update friend requests

    // delete friend by ID
}

export default new UserController();