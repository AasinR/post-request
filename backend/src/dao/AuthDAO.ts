import ConnectionConfig from "../config/ConnectionConfig";
import User from "../models/User";

class AuthDAO {
    // register new user
    async register(user: User): Promise<number> {
        const REGISTER =
            "BEGIN "+
                `:result := register_user('${user.PASSWORD}', '${user.EMAIL}', '${user.FIRSTNAME}', '${user.LASTNAME}'); `+
            "END;";

        try {
            const result = await ConnectionConfig.executeFunc(REGISTER);
            if (result === null) {
                throw new Error("Failed to execute function!");
            }
            return parseInt(result, 10);
        } catch(error) {
            console.error(error);
            return null;
        }
    }

    // login user
    async login(user: User): Promise<number> {
        const LOGIN =
            `BEGIN
                :result := login_check('${user.PASSWORD}', '${user.EMAIL}');
            END;`;

        try {
            const result = await ConnectionConfig.executeFunc(LOGIN);
            if (result === null) {
                throw new Error("Failed to execute function!");
            }
            return parseInt(result, 10);
        } catch(error) {
            console.error(error);
            return null;
        }
    }
}

export default new AuthDAO();