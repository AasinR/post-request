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

    async sendMessage(message: Message): Promise<Message> {
        const SEND = `INSERT INTO privatemessage (Content, TimeStamp, ToUser, FromUser) VALUES ('${message.CONTENT}', ${message.TIMESTAMP}, ${message.TOUSER}, ${message.FROMUSER})`;
        try {
            const query = await ConnectionConfig.modify(SEND, true);
            if (query === null) {
                throw Error("Query failed!");
            }
            return message;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    async getMessage(id: number): Promise<Message> {
        const FIND_ALL = `SELECT * FROM privatemessage WHERE ID = ${id}`;
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            return query.rows[0] as Message;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    async getMessaging(user1: number, user2: number): Promise<Message[]> {
        const FIND_ALL = `SELECT * FROM privatemessage WHERE FromUser = ${user1} AND ToUser = ${user2}`;
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

    async deleteMessage(id: number, fromUser: number)
    {
        const DELETE = `DELETE FROM privatemessage WHERE ID = ${id} AND FromUser = ${fromUser}`;
        try {
            const query = await ConnectionConfig.modify(DELETE, true);
            if (query === null) {
                throw Error("Query failed!");
            }
            return query;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new MessageDAO();