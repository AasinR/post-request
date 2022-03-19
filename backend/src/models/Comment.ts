export default class Comment {
    public ID : number;
    public CONTENT : string;
    public TIMESTAMP : string;
    public POSTID : number;
    public USERID : number;

    constructor() {
        this.ID = null;
        this.CONTENT = null;
        this.TIMESTAMP = null;
        this.POSTID = null;
        this.USERID = null;
    }
}