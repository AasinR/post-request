import express from "express";
import dotenv from "dotenv";

// initialize configuration
dotenv.config();

const server = express();
const port = process.env.SERVER_PORT;

// route handler
server.get("/", (req, res) => {
    res.json({
        "hello": "world!"
    });
})


// start server
server.listen(port, () => {
    // tslint:disable-next-line:no-console
    console.log(`Server started at: http://localhost:${port}`);
})