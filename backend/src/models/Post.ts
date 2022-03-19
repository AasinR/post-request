export default class Post {
    public ID : number;
    public TEXT : string;
    public TIMESTAMP : string;
    public PICTURE : string;
    public USERID : number;

    constructor() {
        this.ID = null;
        this.TEXT = null;
        this.TIMESTAMP = null;
        this.PICTURE = null;
        this.USERID = null;
    }
}