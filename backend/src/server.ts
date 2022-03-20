import express from "express";
import EnvConfig from "./config/EnvConfig";

import bodyParser from "body-parser";
import session from "express-session";
import UserRoutes from "./routes/UserRoutes"
import PostRoutes from "./routes/PostRoutes";
import MessageRoutes from "./routes/MessageRoutes";
import GroupRoutes from "./routes/GroupRoutes";
import CommentRoutes from "./routes/CommentRoutes";
import AlbumRoutes from "./routes/AlbumRoutes";

const server = express();
const inProd = EnvConfig.NODE_ENV === "production"

// use bodyParser to read post body
server.use(bodyParser.urlencoded({ extended: true }));
server.use(express.json());

// setup session cookie
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
}))

// test login
server.post("/testPost", (req, res) => {
    const { id, name } = req.body;
    req.session.userId = id;
    res.json({
        "id": id,
        "name": name,
        "success": true
    });
})
// logout test
server.post("/testLogout", (req, res) => {
    req.session.destroy(err => {
        if(err) {
            res.status(500).send("Login failed");
        }
        res.clearCookie(EnvConfig.SESSION_NAME);
        res.status(200).send("Successful logout");
    })
})

// add route to server
server.use("/user", UserRoutes.Router);
server.use("/post", PostRoutes.Router);
server.use("/message", MessageRoutes.Router);
server.use("/group", GroupRoutes.Router);
server.use("/comment", CommentRoutes.Router);
server.use("/album", AlbumRoutes.Router);


// start server
server.listen(EnvConfig.SERVER_PORT, () => {
    // tslint:disable-next-line:no-console
    console.log(`Server started at: http://localhost:${EnvConfig.SERVER_PORT}`);
})