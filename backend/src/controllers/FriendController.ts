import { Request, Response, NextFunction } from "express";
import FriendsDAO from "../dao/FriendsDAO";
import FriendRequestDAO from "../dao/FriendRequestDAO";
import FriendRequest from "../models/FriendRequests";

class FriendController {

    // get all friends
    async findAll(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await FriendsDAO.findAll();
            if (result === null) {
                throw new Error("Failed to execute query!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "result": result
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // get all friend requests
    async findAllRequest(req : Request, res : Response, next : NextFunction) {
        let result;
        try {
            result = await FriendRequestDAO.findAll();
            if (result === null) {
                throw new Error("Failed to execute query!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "result": result
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // get all friend by userID
    async getAllFriend(req : Request, res : Response, next : NextFunction) {
        const userId = parseInt(req.params.id, 10);
        const result: {[k: string]: any}[] = [];

        try {
            const friends = await FriendsDAO.getAll(userId);
            if (friends === null) {
                throw new Error("Failed to execute query!");
            }

            friends.forEach((data: {[k: string]: any}) => {
                let friend;

                if (data.USER1.ID !== userId) {
                    friend = {
                        ID: data.USER1.ID,
                        FIRSTNAME: data.USER1.FIRSTNAME,
                        LASTNAME: data.USER1.LASTNAME,
                        PROFILEPICTURE: data.USER1.PROFILEPICTURE
                    }
                }
                else {
                    friend = {
                        ID: data.USER2.ID,
                        FIRSTNAME: data.USER2.FIRSTNAME,
                        LASTNAME: data.USER2.LASTNAME,
                        PROFILEPICTURE: data.USER2.PROFILEPICTURE
                    }
                }

                result.push(friend);
            });

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "result": result
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // get all friend request by userID
    async getAllRequest(req : Request, res : Response, next : NextFunction) {
        const userId = parseInt(req.params.id, 10);
        const result: {[k: string]: any}[] = [];

        try {
            const requests = await FriendRequestDAO.getAll(userId);
            if (requests === null) {
                throw new Error("Failed to execute query!");
            }

            requests.forEach((data: {[k: string]: any}) => {
                let friend;

                if (data.USER1.ID !== userId) {
                    friend = {
                        ID: data.USER1.ID,
                        FIRSTNAME: data.USER1.FIRSTNAME,
                        LASTNAME: data.USER1.LASTNAME,
                        PROFILEPICTURE: data.USER1.PROFILEPICTURE
                    }
                }
                else {
                    friend = {
                        ID: data.USER2.ID,
                        FIRSTNAME: data.USER2.FIRSTNAME,
                        LASTNAME: data.USER2.LASTNAME,
                        PROFILEPICTURE: data.USER2.PROFILEPICTURE
                    }
                }

                result.push(friend);
            });

            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.json({
                        "result": result
                    });
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // send friendRequest
    async askForFriend(req : Request, res : Response, next : NextFunction)
    {
        const user1 = req.session.userId;
        const user2 = parseInt(req.params.id, 10);

        try
        {
            const result = await FriendRequestDAO.sendFriendRequest(user1, user2);
            if (result === null)
            {
                throw new Error("Failed to send friend request!");
            }
            throw 200;
        }
        catch(status)
        {
            switch(status)
            {
                case 200:
                    res.send("Friend request sent!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // accept request
    async acceptRequest(req : Request, res : Response, next : NextFunction) {
        const request = new FriendRequest();
        request.USER1 = parseInt(req.params.id, 10);
        request.USER2 = req.session.userId;
        request.APPROVED = 1;

        try {
            const result = await FriendRequestDAO.update(request);
            if (result === null) {
                throw new Error("Failed to update friend request!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Friend request accepted!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }

    // reject request
    async rejectRequest(req : Request, res : Response, next : NextFunction) {
        const request = new FriendRequest();
        request.USER1 = parseInt(req.params.id, 10);
        request.USER2 = req.session.userId;
        request.APPROVED = -1;

        try {
            const result = await FriendRequestDAO.update(request);
            if (result === null) {
                throw new Error("Failed to update friend request!");
            }
            throw 200;
        } catch(status) {
            switch(status) {
                case 200:
                    res.send("Friend request rejected!");
                    break;
                default:
                    res.sendStatus(500);
                    console.error(status);
                    break;
            }
        }
    }
}

export default new FriendController();