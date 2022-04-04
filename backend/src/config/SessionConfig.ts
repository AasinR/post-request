import session from "express-session";
import EnvConfig from "./EnvConfig";

declare module "express-session" {
    interface SessionData {
        userId: number
    }
}

class SessionConfig {
    private _session : any;

    constructor() {
        const inProd = EnvConfig.NODE_ENV === "production";
        this._session = session({
            name: EnvConfig.SESSION_NAME,
            resave: false,
            saveUninitialized: false,
            secret: EnvConfig.SESSION_SECRET,
            cookie: {
                maxAge: EnvConfig.SESSION_LIFETIME,
                sameSite: true,
                secure: inProd
            }
        });
    }

    get session() {
        return this._session;
    }
}

export default new SessionConfig();