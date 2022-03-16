export default class Post {
    public ID : number;
    public Text : string;
    public TimeStamp : string;
    public Picture : string;
    public UserID : number;

    constructor() {
        this.ID = null;
        this.Text = null;
        this.TimeStamp = null;
        this.Picture = null;
        this.UserID = null;
    }
}