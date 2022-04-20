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
        console.log(message);
        const SEND = `INSERT INTO privatemessage (Content, TimeStamp, ToUser, FromUser) VALUES ('${message.CONTENT}', CURRENT_TIMESTAMP, ${message.TOUSER}, ${message.FROMUSER})`;
        console.log(SEND);
        try {
            const query = await ConnectionConfig.modify(SEND, false);
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
        const FIND_ALL = `SELECT *, TO_CHAR(privatemessage.TIMESTAMP, 'yyyy/mm/dd hh24:mi') as TIMESTAMPFORMATED FROM privatemessage WHERE (FromUser = ${user1} AND ToUser = ${user2}) OR (FromUser = ${user2} AND ToUser = ${user1}) ORDER BY TimeStamp`;
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
            const query = await ConnectionConfig.modify(DELETE, false);
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