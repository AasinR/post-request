import oracledb from "oracledb";
import EnvConfig from "./EnvConfig";

class DatabaseConfig {
    constructor() {
        try {
            oracledb.initOracleClient({libDir: EnvConfig.ICLIENT_PATH});
        } catch(error) {
            console.error("ClientNotFound: "+error);
        }
    }

    // connect to the database
    connect() {
        try {
            const connection = oracledb.getConnection({
                user: EnvConfig.DB_USER,
                password: EnvConfig.DB_PASS,
                connectString: `(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=${EnvConfig.DB_HOST})(Port=${EnvConfig.DB_PORT}))(CONNECT_DATA=(SID=${EnvConfig.DB_SID})))`
            });
            return connection;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // returns the results of a query
    async query(sql : string) {
        let connection;
        const db = require("oracledb");
        try {
            connection = await this.connect();
            if(connection === null) {
                throw new Error("Failed to connect to database!");
            }
            const result = await connection.execute(sql, [], {outFormat: db.OBJECT});
            return result;
        } catch(error) {
            console.error(error);
            return 500;
        } finally {
            try {
                connection.close();
            } catch(closeError) {
                console.log(closeError);
            }
        }
    }

    async insert(sql: string) {
        let connection;
        try {
            connection = await this.connect();
            if(connection === null) {
                throw new Error("Failed to connect to database!");
            }
            connection.execute(sql, [], {autoCommit: true});
        } catch(error) {
            console.log(error);
            throw error;
        } finally {
            try {
                connection.close();
            } catch(closeError) {
                console.log(closeError);
            }
        }
    }
}

export default new DatabaseConfig();