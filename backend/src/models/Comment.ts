export default class Comment {
    public ID : number;
    public Content : string;
    public TimeStamp : string;
    public PostID : number;
    public UserID : number;

    constructor() {
        this.ID = null;
        this.Content = null;
        this.TimeStamp = null;
        this.PostID = null;
        this.UserID = null;
    }
}