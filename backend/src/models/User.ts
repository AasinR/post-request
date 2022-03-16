export default class User {
    public ID : number;
    public Password : string;
    public Email : string;
    public Permission : number;
    public FirstName : string;
    public LastName : string;

    constructor() {
        this.ID = null;
        this.Password = null;
        this.Email = null;
        this.Permission = null;
        this.FirstName = null;
        this.LastName = null;
    }
}