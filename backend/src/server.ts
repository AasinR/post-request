import express from "express";
import dotenv from "dotenv";
import bodyParser from "body-parser";
import session from "express-session";
import UserRoutes from "./routes/UserRoutes"
import PostRoutes from "./routes/PostRoutes";
import MessageRoutes from "./routes/MessageRoutes";
import GroupRoutes from "./routes/GroupRoutes";

// initialize configuration
dotenv.config();

const server = express();
const {
    NODE_ENV = "development",
    SERVER_PORT = 8080,
    SESSION_LIFETIME = 86400000,
    SESSION_NAME = "sid",
    SESSION_SECRET = "I/have%no%idea%what%to%put/here"
} = process.env;
const inProd = NODE_ENV === "production"

// use bodyParser to read post body
server.use(bodyParser.urlencoded({ extended: true }));
server.use(express.json());

// setup session cookie
server.use(session({
    name: SESSION_NAME,
    resave: false,
    saveUninitialized: false,
    secret: SESSION_SECRET,
    cookie: {
        maxAge: 86400000,
        sameSite: true,
        secure: inProd
    }
}))

// route handler
server.get("/", (req, res) => {
    res.json({
        "hello": "world!"
    });
})

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
        res.clearCookie(SESSION_NAME);
        res.status(200).send("Successful logout");
    })
})

// add route to server
server.use("/user", UserRoutes.Router);
server.use("/post", PostRoutes.Router);
server.use("/message", MessageRoutes.Router);
server.use("/group", GroupRoutes.Router);


// start server
server.listen(SERVER_PORT, () => {
    // tslint:disable-next-line:no-console
    console.log(`Server started at: http://localhost:${SERVER_PORT}`);
})