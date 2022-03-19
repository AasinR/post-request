export default class User {
    public ID : number;
    public PASSWORD : string;
    public EMAIL : string;
    public PERMISSION : number;
    public FIRSTNAME : string;
    public LASTNAME : string;

    constructor() {
        this.ID = null;
        this.PASSWORD = null;
        this.EMAIL = null;
        this.PERMISSION = null;
        this.FIRSTNAME = null;
        this.LASTNAME = null;
    }
}