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
}

export default new FriendRequestDAO();