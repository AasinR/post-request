export default class Message {
    public ID : number;
    public Content : string;
    public TimeStamp : string;
    public ToUser : number;
    public FromUser : number;

    constructor() {
        this.ID = null;
        this.Content = null;
        this.TimeStamp = null;
        this.ToUser = null;
        this.FromUser = null;
    }
}