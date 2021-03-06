import ConnectionConfig from "../config/ConnectionConfig";
import Message from "../models/Message";

class MessageDAO {
    // get all messages
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

    // insert message
    async sendMessage(message: Message): Promise<Message> {
        const SEND = `INSERT INTO privatemessage (Content, TimeStamp, ToUser, FromUser) VALUES ('${message.CONTENT}', CURRENT_TIMESTAMP, ${message.TOUSER}, ${message.FROMUSER}) RETURNING id INTO :id`;
        try {
            const query = await ConnectionConfig.modify(SEND, true);
            if (query === null) {
                throw Error("Query failed!");
            }
            message.ID = query;

            return message;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get message by ID
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

    // get messages by toUser and fromUser
    async getMessaging(user1: number, user2: number): Promise<{[k: string]: any}[]> {
        const FIND_ALL =
            `SELECT PrivateMessage.*, TO_CHAR(PrivateMessage.TIMESTAMP, 'yyyy/mm/dd hh24:mi') as C_TIMESTAMP, User1.FIRSTNAME, User1.LASTNAME, UserData1.PROFILEPICTURE, User2.FIRSTNAME, User2.LASTNAME, UserData2.PROFILEPICTURE
            FROM PrivateMessage, "User" User1, UserData UserData1, "User" User2, UserData UserData2
            WHERE PrivateMessage.FromUser = User1.id AND
                PrivateMessage.ToUser = User2.id AND
                User1.id = UserData1.userid AND
                User2.id = UserData2.userid AND
                PrivateMessage.FromUser = ${user1} AND
                PrivateMessage.ToUser = ${user2}
            OR PrivateMessage.FromUser = User1.id AND
                PrivateMessage.ToUser = User2.id AND
                User2.id = UserData2.userid AND
                User1.id = UserData1.userid AND
                PrivateMessage.ToUser = ${user1} AND
                PrivateMessage.FromUser = ${user2}
            ORDER BY PrivateMessage.TIMESTAMP DESC`;
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: {[k: string]: any}[] = [];
            query.rows.forEach((data: {[k: string]: any}) => {
                const msg = {
                    ID: data.ID,
                    CONTENT: data.CONTENT,
                    TIMESTAMP: data.C_TIMESTAMP,
                    FROMUSER: {
                        ID: data.FROMUSER,
                        FIRSTNAME: data.FIRSTNAME,
                        LASTNAME: data.LASTNAME,
                        PROFILEPICTURE: data.PROFILEPICTURE
                    },
                    TOUSER: {
                        ID: data.TOUSER,
                        FIRSTNAME: data.FIRSTNAME_1,
                        LASTNAME: data.LASTNAME_1,
                        PROFILEPICTURE: data.PROFILEPICTURE_1
                    }
                };

                result.push(msg);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // update message by ID
    async update(message: Message): Promise<Message> {
        const UPDATE_MSG = `UPDATE privatemessage SET content = q'[${message.CONTENT}]' WHERE id = ${message.ID}`;

        try {
            const result = await ConnectionConfig.modify(UPDATE_MSG, false);
            if (result === null) {
                throw new Error("Update failed!");
            }

            return message;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // delete message by ID and fromUser
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

    // get user's longer conversations
    async stat(ID: number): Promise<{[k: string]: any}[]> {
        const GET_STAT =
            `SELECT FromUser.ID F_ID, FromUser.FIRSTNAME F_FIRSTNAME, FromUser.LASTNAME F_LASTNAME,
            ToUser.ID T_ID, ToUser.FIRSTNAME T_FIRSTNAME, ToUser.LASTNAME T_LASTNAME, COUNT(PrivateMessage.ID) MSG_COUNT
        FROM "User" FromUser, "User" ToUser, PrivateMessage
        WHERE PrivateMessage.FROMUSER = FromUser.ID AND
            PrivateMessage.TOUSER = ToUser.ID AND
            FromUser.ID = ${ID}
        HAVING COUNT(PrivateMessage.ID) > (
            SELECT AVG(COUNT(PrivateMessage.ID))
            FROM PrivateMessage
            GROUP BY PrivateMessage.ID
        )
        GROUP BY FromUser.ID, FromUser.FIRSTNAME, FromUser.LASTNAME,
            ToUser.ID, ToUser.FIRSTNAME, ToUser.LASTNAME
        ORDER BY MSG_COUNT DESC`;

        try {
            const query = await ConnectionConfig.query(GET_STAT);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: {[k: string]: any}[] = [];
            query.rows.forEach((data: {[k: string]: any}) => {
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