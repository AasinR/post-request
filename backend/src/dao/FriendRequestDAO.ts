import ConnectionConfig from "../config/ConnectionConfig";
import FriendRequest from "../models/FriendRequests";

class FriendRequestDAO {
    async findAll(): Promise<FriendRequest[]> {
        const FIND_ALL = 'SELECT * FROM friendrequest';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: FriendRequest[] = [];
            query.rows.forEach((data: FriendRequest) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get all friend request by userID
    async getAll(ID: number): Promise<{[k: string]: any}[]> {
        const GET_ALL =
            `SELECT FriendRequest.USER1, FriendRequest.USER2, User1.FIRSTNAME, User1.LASTNAME, Data1.PROFILEPICTURE
            FROM FriendRequest, "User" User1, UserData Data1
            WHERE FriendRequest.USER1 = User1.ID AND
                User1.ID = Data1.USERID AND
                FriendRequest.USER2 = ${ID}`;

        try {
            const query = await ConnectionConfig.query(GET_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: {[k: string]: any}[] = [];
            query.rows.forEach((data: {[k: string]: any}) => {
                const request = {
                    USER1: {
                        ID: data.USER1,
                        FIRSTNAME: data.FIRSTNAME,
                        LASTNAME: data.LASTNAME,
                        PROFILEPICTURE: data.PROFILEPICTURE
                    }
                };

                result.push(request);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // ask for friend
    async sendFriendRequest(user1: number, user2: number)
    {
        const ADD_FRIEND_REQUEST = `INSERT INTO friendrequest (user1, user2, approved) VALUES (${user1}, ${user2}, 0)`;
        try
        {
            const ret = await ConnectionConfig.modify(ADD_FRIEND_REQUEST, false);
            if (ret === null)
            {
                throw Error("Failed to send friend request");
            }
            return user2;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // update friend request
    async update(request: FriendRequest): Promise<FriendRequest> {
        const UPDATE = `UPDATE friendrequest SET approved = ${request.APPROVED} WHERE user1 = ${request.USER1} AND user2 = ${request.USER2}`;

        try {
            const result = await ConnectionConfig.modify(UPDATE, false);
            if (result === null) {
                throw new Error("Update failed!");
            }
            return request;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new FriendRequestDAO();