import oracledb from "oracledb";
import dotenv from "dotenv";

dotenv.config();

const {
    DB_HOST = "localhost",
    DB_PORT = 1521,
    DB_SID = "xe",
    DB_USER = "ADMIN",
    DB_PASS = "admin01",
    ICLIENT_PATH = "C:\\Oracle\\instantclient_21_3"
} = process.env;

class DatabaseConfig {
    constructor() {
        try {
            oracledb.initOracleClient({libDir: ICLIENT_PATH});
        } catch(error) {
            // tslint:disable-next-line:no-console
            console.error("ClientNotFound: "+error);
        }
    }

    connect() {
        try {
            const connection = oracledb.getConnection({
                user: DB_USER,
                password: DB_PASS,
                connectString: `(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=${DB_HOST})(Port=${DB_PORT}))(CONNECT_DATA=(SID=${DB_SID})))`
            });
            return connection;
        } catch(error) {
            // tslint:disable-next-line:no-console
            console.error("ConnectionFailed: "+error);
        }
    }
}

export default new DatabaseConfig();