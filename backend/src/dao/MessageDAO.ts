import ConnectionConfig from "../config/ConnectionConfig";
import Message from "../models/Message";

class MessageDAO {
    async findAll(): Promise<Message[]> {
        const FIND_ALL = 'SELECT * FROM privatemessage';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: Message[] = [];
            query.rows.forEach((data: Message) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new MessageDAO();