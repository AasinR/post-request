import {google, Auth, drive_v3, Common} from "googleapis";
import fs from "fs";

class CloudConfig {
    private _auth: Auth.GoogleAuth
    private _drive: drive_v3.Drive

    constructor() {
        // account cred key
        const KEYFILE_PATH = "src\\config\\service-account.json";

        // grant full access to google drive
        const SCOPES = ["https://www.googleapis.com/auth/drive"];

        this._auth = new Auth.GoogleAuth({
            keyFile: KEYFILE_PATH,
            scopes: SCOPES
        });

        this._drive = google.drive({
            version:"v3",
            auth: this._auth
        });
    }

    // create and upload a file to google drive
    async upload(type: string) {
        let folder;
        switch(type) {
            case "user":
                folder = "11FQdiGrqnfoNetwWrN-401JUMz2dLSGN";
                break;
            case "group":
                folder = "1UVzOzf0jxxB2m_iUVW88jkNqC-VJVFQ0";
                break;
            case "publicPost":
                folder = "1wgCoiNKXqYk6Tpn9UrJsHjttVNQZJzNA";
                break;
            case "groupPost":
                folder = "1JrmeOulZHptIpl--nMcc6k36jNlxZ7tM";
                break;
            default:
                throw new Error("Incorrect type input!");
        }
        const fileMetaData = {
            "name": "image.png",
            "parents": [folder]
        };
        const media = {
            mimeType: "image/png",
            body: fs.createReadStream("C:\\Users\\bazsi\\Desktop\\duck.png")
        }
        const response = await this._drive.files.create({
            requestBody: fileMetaData,
            media,
            fields: "id"
        })

        switch(response.status) {
            case 200:
                this._drive.permissions.create({
                    fileId: response.data.id,
                    requestBody: {
                        role: "reader",
                        type: "anyone"
                    }
                }, error => {
                    if(error) {
                        throw new Error("Failed to grant permission!");
                    }
                });
                return `https://drive.google.com/uc?export=view&id=${response.data.id}`;
            default:
                console.error(response);
        }
    }

    // delete a file from google drive
    delete() {
        //
    }
}

export default new CloudConfig();