-- register user
CREATE OR REPLACE FUNCTION register_user(
    v_password IN VARCHAR2,
    v_email IN VARCHAR2,
    v_firstname IN VARCHAR2,
    v_lastname IN VARCHAR2
)
    RETURN NUMBER
IS
    userID NUMBER;
BEGIN
    SELECT id INTO userID FROM "User" WHERE email = v_email;
    RETURN 0;
EXCEPTION
    WHEN no_data_found THEN
        INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES (v_password, v_email, 0, v_firstname, v_lastname) RETURNING id INTO userID;
        RETURN userID;
    WHEN others THEN
        RETURN null;
END;
/

-- login user
CREATE OR REPLACE FUNCTION login_check(
    v_password IN VARCHAR2,
    v_email IN VARCHAR2
)
    RETURN NUMBER
IS
    userID NUMBER;
BEGIN
    SELECT id INTO userID FROM "User"
    WHERE email = v_email AND password = v_password;
    RETURN userID;
EXCEPTION
    WHEN no_data_found THEN
        RETURN 0;
    WHEN others THEN
        RETURN null;
END;
/
