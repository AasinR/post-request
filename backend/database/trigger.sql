-- creates empty user data to a new user
CREATE OR REPLACE TRIGGER add_data
    AFTER INSERT ON "User"
    FOR EACH ROW
BEGIN
    INSERT INTO UserData (userid) VALUES (:new.id);
END;

CREATE OR REPLACE TRIGGER acceptExistingFriendRequest
BEFORE INSERT
ON friendrequest
FOR EACH ROW
DECLARE
	CURSOR friendReq  IS SELECT user1, user2, approved FROM friendrequest FOR UPDATE OF approved;
BEGIN
	FOR rekord IN friendReq
    LOOP
        IF ((rekord.user2 = :NEW.user1) AND (:NEW.user2 = rekord.user1)) THEN
			:NEW.approved := 1;
			UPDATE friendrequest SET approved = 1 WHERE user1 = rekord.user1 AND user2 = rekord.user2;
        END IF;
    END LOOP;
END;

CREATE OR REPLACE TRIGGER acceptFriendRequest
AFTER INSERT
ON friendrequest
DECLARE
    CURSOR friendReq  IS SELECT user1, user2, approved FROM friendrequest FOR UPDATE;
BEGIN
    FOR rekord IN friendReq
    LOOP
        IF (rekord.approved = 1) THEN
            INSERT INTO friends (user1, user2) VALUES (rekord.user1, rekord.user2);
            DELETE FROM friendrequest WHERE (rekord.user1 = user1 AND rekord.user2 = user2) OR (rekord.user1 = user2 AND rekord.user2 = user1);
            EXIT;
        END IF;
    END LOOP;
END;