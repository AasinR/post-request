-- creates empty user data to a new user
CREATE OR REPLACE TRIGGER add_data
    AFTER INSERT ON "User"
    FOR EACH ROW
BEGIN
    INSERT INTO UserData (userid) VALUES (:new.id);
END;