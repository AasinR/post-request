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
}

export default new FriendRequestDAO();