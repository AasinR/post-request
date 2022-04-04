import express from "express";
import bodyParser from "body-parser";
import cors from "cors";

import EnvConfig from "./config/EnvConfig";
import SessionConfig from "./config/SessionConfig";
import UserRoutes from "./routes/UserRoutes"
import PostRoutes from "./routes/PostRoutes";
import MessageRoutes from "./routes/MessageRoutes";
import GroupRoutes from "./routes/GroupRoutes";
import CommentRoutes from "./routes/CommentRoutes";
import AlbumRoutes from "./routes/AlbumRoutes";
import AuthRoutes from "./routes/AuthRoutes";
import PictureRoutes from "./routes/PictureRoutes";
import FriendRoutes from "./routes/FriendRoutes";

const server = express();

// allow Cross-Origin Resource Sharing
server.use(cors());

// use bodyParser to read post body
server.use(bodyParser.urlencoded({ extended: true }));
server.use(express.json());

// setup session cookie
server.use(SessionConfig.session);

// add route to server
server.use(AuthRoutes.Router);
server.use("/user", UserRoutes.Router);
server.use("/post", PostRoutes.Router);
server.use("/img", PictureRoutes.Router);
server.use("/message", MessageRoutes.Router);
server.use("/group", GroupRoutes.Router);
server.use("/friend", FriendRoutes.Router);
server.use("/comment", CommentRoutes.Router);
server.use("/album", AlbumRoutes.Router);

// start server
server.listen(EnvConfig.SERVER_PORT, () => {
    console.log(`Server started at: http://localhost:${EnvConfig.SERVER_PORT}`);
})