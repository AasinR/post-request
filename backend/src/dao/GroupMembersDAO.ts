import ConnectionConfig from "../config/ConnectionConfig";
import GroupMember from "../models/GroupMember";

class GroupMembersDAO {
    // find all members
    async findAll(): Promise<GroupMember[]> {
        const FIND_ALL = 'SELECT * FROM groupmembers';
        try {
            const query = await ConnectionConfig.query(FIND_ALL);
            if (query === null) {
                throw Error("Query failed!");
            }
            const result: GroupMember[] = [];
            query.rows.forEach((data: GroupMember) => {
                result.push(data);
            });
            return result;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get all members by groupID
    async getAll(ID: number): Promise<{[k: string]: any}[]> {
        const GET_ALL =
            `SELECT GroupMembers.GROUPID, GroupMembers.USERID, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
            FROM GroupMembers, "User", UserData
            WHERE GroupMembers.USERID = "User".ID AND
                "User".ID = UserData.USERID AND
                GroupMembers.GROUPID = ${ID}
            ORDER BY "User".FIRSTNAME, "User".LASTNAME`;

        try {
            const query = await ConnectionConfig.query(GET_ALL);
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

    // add member
    async add(member: GroupMember): Promise<GroupMember> {
        const ADD = `INSERT INTO groupmembers (groupid, userid) VALUES (${member.GROUPID}, ${member.USERID})`;

        try {
            const result = await ConnectionConfig.modify(ADD, false);
            if (result === null) {
                throw new Error("Insert failed!");
            }
            return member;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // delete member
    async delete(member: GroupMember): Promise<GroupMember> {
        const DELETE = `DELETE FROM groupmembers WHERE groupid = ${member.GROUPID} AND userid = ${member.USERID}`;

        try {
            const result = await ConnectionConfig.modify(DELETE, false);
            if (result === null) {
                throw new Error("Delete failed!");
            }
            return member;
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // get number of members by groupID
    async getMemberCount(id: number) : Promise<{[k: string]: any}>
    {
        const SELECT =
            `SELECT GroupMembers.GroupID, "Group".NAME, COUNT(GroupMembers.GroupID) AS MEMBERCOUNT
             FROM GroupMembers, "Group"
             WHERE "Group".ID = ${id} AND "Group".ID = GroupMembers.GroupID
             GROUP BY GroupMembers.GroupID, "Group".NAME`;
        try {
            const query = await ConnectionConfig.query(SELECT);
            if (query === null) {
                throw Error("Query failed!");
            }
            if (query.rows.length === 0)
            {
                throw Error("No data found!");
            }
            return query.rows[0];

        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new GroupMembersDAO();