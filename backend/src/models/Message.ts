export default class Message {
    public ID : number;
    public CONTENT : string;
    public TIMESTAMP : string;
    public TOUSER : number;
    public FROMUSER : number;

    constructor() {
        this.ID = null;
        this.CONTENT = null;
        this.TIMESTAMP = null;
        this.TOUSER = null;
        this.FROMUSER = null;
    }
}