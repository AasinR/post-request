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

-- update user and user data
CREATE OR REPLACE FUNCTION update_user(
    v_id IN NUMBER,
    v_password IN VARCHAR2,
    v_email IN VARCHAR2,
    v_firstname IN VARCHAR2,
    v_lastname IN VARCHAR2,
    v_gender IN VARCHAR2,
    v_img IN VARCHAR2,
    v_birthdate IN DATE,
    v_phone IN VARCHAR2,
    v_profession IN VARCHAR2
)
    RETURN VARCHAR2
IS
    img VARCHAR2(128);
BEGIN
    SELECT profilepicture INTO img FROM UserData WHERE userid = v_id;
    IF img is null THEN
        UPDATE "User" SET password = v_password, email = v_email, firstname = v_firstname, lastname = v_lastname WHERE id = v_id;
        UPDATE userdata SET gender = v_gender, profilepicture = v_img, birthdate = v_birthdate, phonenumber = v_phone, profession = v_profession WHERE userid = v_id;
        RETURN 0;
    ELSIF v_img is null THEN
        UPDATE "User" SET password = v_password, email = v_email, firstname = v_firstname, lastname = v_lastname WHERE id = v_id;
        UPDATE userdata SET gender = v_gender, profilepicture = img, birthdate = v_birthdate, phonenumber = v_phone, profession = v_profession WHERE userid = v_id;
        RETURN 0;
    ELSE
        UPDATE "User" SET password = v_password, email = v_email, firstname = v_firstname, lastname = v_lastname WHERE id = v_id;
        UPDATE userdata SET gender = v_gender, profilepicture = v_img, birthdate = v_birthdate, phonenumber = v_phone, profession = v_profession WHERE userid = v_id;
        RETURN img;
    END IF;
EXCEPTION
    WHEN others THEN
        RETURN null;
END;
/

-- set image timestamp to null after album delete
CREATE OR REPLACE PROCEDURE delete_album(
    v_albumid IN NUMBER
)
IS
BEGIN
    UPDATE PublicPicture SET timestamp = null WHERE albumid = v_albumid;
    DELETE FROM MediaAlbum WHERE id = v_albumid;
END;
/