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
            console.error("ConnectionFailed: "+error);
        }
    }
}

export default new DatabaseConfig();