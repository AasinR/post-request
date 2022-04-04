import dotenv from "dotenv";

class EnvConfig {
    private _NODE_ENV: string;
    private _SERVER_PORT: number;
    private _CLIENT_URL: string;
    private _SESSION_LIFETIME: number;
    private _SESSION_NAME: string;
    private _SESSION_SECRET: string;
    private _DB_HOST: string;
    private _DB_PORT: number;
    private _DB_SID: string;
    private _DB_USER: string;
    private _DB_PASS: string;
    private _ICLIENT_PATH: string;

    constructor() {
        dotenv.config();

        // default env setting
        const {
            // server
            NODE_ENV = "development",
            SERVER_PORT = "5376",

            // client
            CLIENT_URL = "http://localhost:8080",

            // session
            SESSION_LIFETIME = "86400000",
            SESSION_NAME="sid",
            SESSION_SECRET="I/have%no%idea%what%to%put/here",

            // database
            DB_HOST = "localhost",
            DB_PORT = "1521",
            DB_SID = "xe",
            DB_USER = "ADMIN",
            DB_PASS = "admin01",
            ICLIENT_PATH = "C:\\Oracle\\instantclient_21_3"
        } = process.env;

        this._NODE_ENV = NODE_ENV;
        this._SERVER_PORT = parseInt(SERVER_PORT, 10);

        this._CLIENT_URL = CLIENT_URL;

        this._SESSION_LIFETIME = parseInt(SESSION_LIFETIME, 10);
        this._SESSION_NAME = SESSION_NAME;
        this._SESSION_SECRET = SESSION_SECRET;

        this._DB_HOST = DB_HOST;
        this._DB_PORT = parseInt(DB_PORT, 10);
        this._DB_SID = DB_SID;
        this._DB_USER = DB_USER;
        this._DB_PASS = DB_PASS;
        this._ICLIENT_PATH = ICLIENT_PATH;
    }

    get NODE_ENV() {
        return this._NODE_ENV;
    }
    get SERVER_PORT() {
        return this._SERVER_PORT;
    }
    get CLIENT_URL() {
        return this._CLIENT_URL;
    }
    get SESSION_LIFETIME() {
        return this._SESSION_LIFETIME;
    }
    get SESSION_NAME() {
        return this._SESSION_NAME;
    }
    get SESSION_SECRET() {
        return this._SESSION_SECRET;
    }
    get DB_HOST() {
        return this._DB_HOST;
    }
    get DB_PORT() {
        return this._DB_PORT;
    }
    get DB_SID() {
        return this._DB_SID;
    }
    get DB_USER() {
        return this._DB_USER;
    }
    get DB_PASS() {
        return this._DB_PASS;
    }
    get ICLIENT_PATH() {
        return this._ICLIENT_PATH;
    }
}

export default new EnvConfig();