import google from "googleapis";

class CloudConfig {
    private _auth: google.Auth.GoogleAuth

    constructor() {
        // account cred key
        const KEYFILE_PATH = "service-account.json";

        // grant full access to google drive
        const SCOPES = ["https://www.googleapis.com/auth/drive"];

        this._auth = new google.Auth.GoogleAuth({
            keyFile: KEYFILE_PATH,
            scopes: SCOPES
        })
    }

    get auth() {
        return this._auth;
    }

    // create and upload a file to google drive
    upload() {
        //
    }

    // delete a file from google drive
    delete() {
        //
    }
}

export default new CloudConfig();