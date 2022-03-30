import express from "express";
import bodyParser from "body-parser";
import session from "express-session";
import cors from "cors";

import EnvConfig from "./config/EnvConfig";
import UserRoutes from "./routes/UserRoutes"
import UserDataRoutes from "./routes/UserDataRoutes";
import PostRoutes from "./routes/PostRoutes";
import MessageRoutes from "./routes/MessageRoutes";
import GroupRoutes from "./routes/GroupRoutes";
import CommentRoutes from "./routes/CommentRoutes";
import AlbumRoutes from "./routes/AlbumRoutes";
import AuthRoutes from "./routes/AuthRoutes";

const server = express();

// allow Cross-Origin Resource Sharing
server.use(cors());

// use bodyParser to read post body
server.use(bodyParser.urlencoded({ extended: true }));
server.use(express.json());

// setup session cookie
const inProd = EnvConfig.NODE_ENV === "production";
server.use(session({
    name: EnvConfig.SESSION_NAME,
    resave: false,
    saveUninitialized: false,
    secret: EnvConfig.SESSION_SECRET,
    cookie: {
        maxAge: EnvConfig.SESSION_LIFETIME,
        sameSite: true,
        secure: inProd
    }
}));

// add route to server
server.use(AuthRoutes.Router);
server.use("/user", UserRoutes.Router);
server.use("/post", PostRoutes.Router);
server.use("/message", MessageRoutes.Router);
server.use("/group", GroupRoutes.Router);
server.use("/comment", CommentRoutes.Router);
server.use("/album", AlbumRoutes.Router);
server.use("/userdata", UserDataRoutes.Router);

// start server
server.listen(EnvConfig.SERVER_PORT, () => {
    // tslint:disable-next-line:no-console
    console.log(`Server started at: http://localhost:${EnvConfig.SERVER_PORT}`);
})