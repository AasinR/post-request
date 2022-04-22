import ConnectionConfig from "../config/ConnectionConfig";
import Group from "../models/Group";

class GroupDAO {
    // get all group
    async findAll(): Promise<Group[]> {
        const FIND_ALL = 'SELECT * FROM "Group"';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: Group[] = [];
            query.rows.forEach((data: Group) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get all group by userID
    async getAll(ID: number): Promise<{[k: string]: any}[]> {
        const GET_ALL =
            "SELECT GroupMembers.GROUPID, GroupMembers.USERID, \"Group\".NAME, \"Group\".LOGO, \"Group\".OWNERID, \"User\".FIRSTNAME, \"User\".LASTNAME, UserData.PROFILEPICTURE "+
            "FROM GroupMembers, \"Group\", \"User\", USERDATA "+
            "WHERE GroupMembers.GROUPID = \"Group\".ID AND GroupMembers.USERID = \"User\".ID AND \"User\".ID = UserData.USERID AND "+
            `GroupMembers.USERID = ${ID}`;

        try {
            const query = await ConnectionConfig.query(GET_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: {[k: string]: any}[] = [];
            query.rows.forEach((data: {[k: string]: any}) => {
                const group = {
                    GROUP: {
                        ID: data.GROUPID,
                        NAME: data.NAME,
                        LOGO: data.LOGO,
                        OWNERID: data.OWNERID
                    },
                    USER: {
                        ID: data.USERID,
                        FIRSTNAME: data.FIRSTNAME,
                        LASTNAME: data.LASTNAME,
                        PROFILEPICTURE: data.PROFILEPICTURE
                    }
                }

                result.push(group);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    async createGroup(newGroup: Group) : Promise<Group>
    {
        const INSERT = `INSERT INTO "Group" (Name, Logo, OwnerID) VALUES ('${newGroup.NAME}', '${newGroup.LOGO}', ${newGroup.OWNERID}) RETURNING id INTO :id`;
        try {
            const query = await ConnectionConfig.modify(INSERT, true);
            if (query === null) {
                throw Error("Query failed!");
            }
            newGroup.ID = query;
            return newGroup;
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new GroupDAO();