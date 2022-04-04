import {google, Auth, drive_v3, Common} from "googleapis";
import { Duplex } from "stream";

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

    // select google drive folder
    private selectFolder(folder: string): string {
        switch(folder) {
            case "user":
                return "11FQdiGrqnfoNetwWrN-401JUMz2dLSGN";
            case "group":
                return "1UVzOzf0jxxB2m_iUVW88jkNqC-VJVFQ0";
            case "publicPost":
                return "1wgCoiNKXqYk6Tpn9UrJsHjttVNQZJzNA";
            case "groupPost":
                return "1JrmeOulZHptIpl--nMcc6k36jNlxZ7tM";
            default:
                throw new Error("Incorrect folder type!");
        }
    }

    // convert binary buffer to readable file
    private bufferToStream(buffer: Buffer) {
        const file = new Duplex();
        file.push(buffer);
        file.push(null);
        return file;
    }

    // create and upload a file to google drive
    async upload(type: string, file: Buffer): Promise<string> {
        const folder = this.selectFolder(type);
        const fileMetaData = {
            "name": "image.png",
            "parents": [folder]
        };
        const media = {
            mimeType: "image/png",
            body: this.bufferToStream(file)
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
                throw new Error("Failed to upload file!");
        }
    }

    // delete a file from google drive
    async delete(ID: string): Promise<string> {
        const response = await this._drive.files.delete({
            fileId: ID
        });

        switch(response.status) {
            case 204:
                return "File deleted!";
            default:
                console.error(response);
                throw new Error("Failed to delete file!");
        }
    }
}

export default new CloudConfig();