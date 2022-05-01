-- get all public posts by userID
SELECT PublicPost.ID, PublicPost.TEXT, TO_CHAR(PublicPost.TIMESTAMP, 'yyyy/mm/dd hh24:mi') as TIMESTAMP, PublicPost.PICTURE, "User".ID, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM PublicPost, "User", UserData
WHERE PublicPost.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    PublicPost.USERID = 1080
ORDER BY PublicPost.TIMESTAMP DESC;

-- get public post by ID
SELECT PublicPost.ID, PublicPost.TEXT, TO_CHAR(PublicPost.TIMESTAMP, 'yyyy/mm/dd hh24:mi') as TIMESTAMP, PublicPost.PICTURE, "User".ID, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM PublicPost, "User", UserData
WHERE PublicPost.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    PublicPost.ID = 1000;

-- get all group posts by groupID
SELECT GroupPost.ID, GroupPost.TEXT, TO_CHAR(GroupPost.TIMESTAMP, 'yyyy/mm/dd hh24:mi') as TIMESTAMP, GroupPost.PICTURE, GroupPost.GROUPID, "User".ID, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM GroupPost, "User", UserData
WHERE GroupPost.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    GroupPost.GROUPID = 1000
ORDER BY GroupPost.TIMESTAMP DESC;

-- get group post by ID
SELECT GroupPost.ID, GroupPost.TEXT, TO_CHAR(GroupPost.TIMESTAMP, 'yyyy/mm/dd hh24:mi') as TIMESTAMP, GroupPost.PICTURE, GroupPost.GROUPID, "User".ID, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM GroupPost, "User", UserData
WHERE GroupPost.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    GroupPost.ID = 1000;

-- get all public comment by postID
SELECT PublicComment.*, TO_CHAR(PublicComment.TIMESTAMP, 'yyyy/mm/dd hh24:mi') as C_TIMESTAMP, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM PublicComment, "User", UserData
WHERE PublicComment.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    PublicComment.POSTID = 1001
ORDER BY PublicComment.TIMESTAMP;

-- get public comment by ID
SELECT PublicComment.*, TO_CHAR(PublicComment.TIMESTAMP, 'yyyy/mm/dd hh24:mi') as C_TIMESTAMP, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM PublicComment, "User", UserData
WHERE PublicComment.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    PublicComment.ID = 1001;

-- get all group comment by postID
SELECT GroupComment.*, TO_CHAR(GroupComment.TIMESTAMP, 'yyyy/mm/dd hh24:mi') as C_TIMESTAMP, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM GroupComment, "User", UserData
WHERE GroupComment.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    GroupComment.POSTID = 1002
ORDER BY GroupComment.TIMESTAMP;

-- get group comment by ID
SELECT GroupComment.*, TO_CHAR(GroupComment.TIMESTAMP, 'yyyy/mm/dd hh24:mi') as C_TIMESTAMP, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM GroupComment, "User", UserData
WHERE GroupComment.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    GroupComment.ID = 1002;

-- get all group by userID
SELECT GroupMembers.GROUPID, GroupMembers.USERID, "Group".NAME, "Group".LOGO, "Group".OWNERID, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM GroupMembers, "Group", "User", UserData
WHERE GroupMembers.GROUPID = "Group".ID AND
    GroupMembers.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    GroupMembers.USERID = 1003;

-- get all friend by userID
SELECT Friends.USER1, Friends.USER2, User1.FIRSTNAME, User1.LASTNAME, Data1.PROFILEPICTURE, User2.FIRSTNAME, User2.LASTNAME, Data2.PROFILEPICTURE
FROM Friends, "User" User1, UserData Data1, "User" User2, UserData Data2
WHERE Friends.USER1 = User1.ID AND
    Friends.USER2 = User2.ID AND
    User1.ID = Data1.USERID AND
    User2.ID = Data2.USERID AND
    Friends.USER1 = 1000
OR Friends.USER1 = User1.ID AND
    Friends.USER2 = User2.ID AND
    User1.ID = Data1.USERID AND
    User2.ID = Data2.USERID AND
    Friends.USER2 = 1000;

-- get all friend request by userID
SELECT FriendRequest.USER1, FriendRequest.USER2, User1.FIRSTNAME, User1.LASTNAME, Data1.PROFILEPICTURE
FROM FriendRequest, "User" User1, UserData Data1
WHERE FriendRequest.USER1 = User1.ID AND
    User1.ID = Data1.USERID AND
    FriendRequest.USER2 = 1000;

-- get all group members by groupID
SELECT GroupMembers.GROUPID, GroupMembers.USERID, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM GroupMembers, "User", UserData
WHERE GroupMembers.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    GroupMembers.GROUPID = 1000
ORDER BY "User".FIRSTNAME, "User".LASTNAME;

-- get messaging by users
SELECT PrivateMessage.*, TO_CHAR(PrivateMessage.TIMESTAMP, 'yyyy/mm/dd hh24:mi') as C_TIMESTAMP, User1.FIRSTNAME, User1.LASTNAME, UserData1.PROFILEPICTURE, User2.FIRSTNAME, User2.LASTNAME, UserData2.PROFILEPICTURE
FROM PrivateMessage, "User" User1, UserData UserData1, "User" User2, UserData UserData2
WHERE PrivateMessage.FromUser = User1.id AND
    PrivateMessage.ToUser = User2.id AND
    User1.id = UserData1.userid AND
    User2.id = UserData2.userid AND
    PrivateMessage.FromUser = 1000 AND
    PrivateMessage.ToUser = 1001
OR PrivateMessage.FromUser = User1.id AND
    PrivateMessage.ToUser = User2.id AND
    User2.id = UserData2.userid AND
    User1.id = UserData1.userid AND
    PrivateMessage.ToUser = 1000 AND
    PrivateMessage.FromUser = 1001
ORDER BY PrivateMessage.TIMESTAMP DESC;

-- get all albums by userId with image count
SELECT MediaAlbum.ID, MediaAlbum.NAME, MediaAlbum.USERID, COUNT(PublicPicture.ID) as IMG_COUNT
FROM MediaAlbum LEFT JOIN PublicPicture ON MediaAlbum.ID = PublicPicture.ALBUMID AND MediaAlbum.USERID = PublicPicture.USERID
WHERE MediaAlbum.USERID = 1000
GROUP BY MediaAlbum.ID, MediaAlbum.NAME, MediaAlbum.USERID
ORDER BY IMG_COUNT DESC, MediaAlbum.NAME;

-- get album by ID with img count
SELECT MediaAlbum.ID, MediaAlbum.NAME, MediaAlbum.USERID, COUNT(PublicPicture.ID) as IMG_COUNT
FROM MediaAlbum LEFT JOIN PublicPicture ON MediaAlbum.ID = PublicPicture.ALBUMID AND MediaAlbum.USERID = PublicPicture.USERID
WHERE MediaAlbum.ID = 1020
GROUP BY MediaAlbum.ID, MediaAlbum.NAME, MediaAlbum.USERID;

-- get all users with friend count
SELECT "User".ID, "User".PASSWORD, "User".EMAIL, "User".PERMISSION, "User".FIRSTNAME, "User".LASTNAME, COUNT(Friends.USER1) as FRIENDS_COUNT
FROM "User" LEFT JOIN Friends ON
    "User".ID = Friends.USER1 OR
    "User".ID = Friends.USER2
GROUP BY "User".ID, "User".PASSWORD, "User".EMAIL, "User".PERMISSION, "User".FIRSTNAME, "User".LASTNAME
ORDER BY "User".ID;

-- get user by ID with friend count
SELECT "User".ID, "User".PASSWORD, "User".EMAIL, "User".PERMISSION, "User".FIRSTNAME, "User".LASTNAME, COUNT(Friends.USER1) as FRIENDS_COUNT
FROM "User" LEFT JOIN Friends ON
    "User".ID = Friends.USER1 OR
    "User".ID = Friends.USER2
WHERE "User".ID = 1000
GROUP BY "User".ID, "User".PASSWORD, "User".EMAIL, "User".PERMISSION, "User".FIRSTNAME, "User".LASTNAME;

-- get groups with more than average members
SELECT "Group".ID, "Group".NAME, "Group".LOGO, "Group".OWNERID, COUNT(GroupMembers.GROUPID) as MEMBER_COUNT
FROM "Group" LEFT JOIN GroupMembers ON
    "Group".ID = GroupMembers.GROUPID
HAVING COUNT(GroupMembers.GROUPID) >= (
    SELECT AVG(COUNT(GroupMembers.GROUPID))
    FROM GroupMembers
    GROUP BY GroupMembers.GROUPID
)
GROUP BY "Group".ID, "Group".NAME, "Group".LOGO, "Group".OWNERID
ORDER BY MEMBER_COUNT DESC, "Group".NAME;

-- get user statistics
SELECT "User".ID, "User".FIRSTNAME, "User".LASTNAME,
    (
        SELECT COUNT(ID)
        FROM PublicPost
        WHERE USERID = "User".ID
    ) PP_COUNT,
    (
        SELECT COUNT(ID)
        FROM PublicComment
        WHERE USERID = "User".ID
    ) PC_COUNT,
    (
        SELECT COUNT(ID)
        FROM GroupPost
        WHERE USERID = "User".ID
    ) GP_COUNT,
    (
        SELECT COUNT(ID)
        FROM GroupComment
        WHERE USERID = "User".ID
    ) GC_COUNT
FROM "User"
ORDER BY (PP_COUNT + PC_COUNT + GP_COUNT + GC_COUNT) DESC;

-- get user's longer conversations
SELECT FromUser.ID F_ID, FromUser.FIRSTNAME F_FIRSTNAME, FromUser.LASTNAME F_LASTNAME,
    ToUser.ID T_ID, ToUser.FIRSTNAME T_FIRSTNAME, ToUser.LASTNAME T_LASTNAME, COUNT(PrivateMessage.ID) MSG_COUNT
FROM "User" FromUser, "User" ToUser, PrivateMessage
WHERE PrivateMessage.FROMUSER = FromUser.ID AND
    PrivateMessage.TOUSER = ToUser.ID AND
    FromUser.ID = 1000
HAVING COUNT(PrivateMessage.ID) > (
    SELECT AVG(COUNT(PrivateMessage.ID))
    FROM PrivateMessage
    GROUP BY PrivateMessage.ID
)
GROUP BY FromUser.ID, FromUser.FIRSTNAME, FromUser.LASTNAME,
    ToUser.ID, ToUser.FIRSTNAME, ToUser.LASTNAME
ORDER BY MSG_COUNT DESC;

-- most active poster in a group
SELECT "User".ID, "User".FIRSTNAME, "User".LASTNAME, "Group".ID, "Group".NAME, COUNT(GroupPost.ID) GP_COUNT
FROM "User", "Group", GroupPost
WHERE "User".ID = GroupPost.USERID AND
    "Group".ID = GroupPost.GROUPID AND
    "Group".ID = 1000
HAVING COUNT(GroupPost.ID) = (
    SELECT MAX(COUNT(GroupPost.USERID))
    FROM GroupPost, "Group"
    WHERE "Group".ID = GroupPost.GROUPID AND
        "Group".ID = 1000
    GROUP BY GroupPost.USERID
)
GROUP BY "User".ID, "User".FIRSTNAME, "User".LASTNAME, "Group".ID, "Group".NAME
ORDER BY "User".ID, "User".FIRSTNAME, "User".LASTNAME;

-- get latest picture of an album
SELECT PublicPicture.ID, PublicPicture.CONTENT, PublicPicture.TIMESTAMP, MediaAlbum.NAME G_NAME
FROM PublicPicture, MediaAlbum
WHERE PublicPicture.ALBUMID = MediaAlbum.ID AND
    MediaAlbum.ID = 1001
HAVING PublicPicture.TIMESTAMP = (
    SELECT MAX(TIMESTAMP)
    FROM PublicPicture
    WHERE PublicPicture.ALBUMID = 1001
)
GROUP BY PublicPicture.ID, PublicPicture.CONTENT, PublicPicture.TIMESTAMP, MediaAlbum.NAME;

-- age of users
SELECT "User".ID, "User".FIRSTNAME, "User".LASTNAME,
    TRUNC((CURRENT_DATE - UserData.BIRTHDATE)/365.25) AGE,
    (
        SELECT AVG(TRUNC((CURRENT_DATE - UserData.BIRTHDATE)/365.25))
        FROM UserData
        WHERE UserData.BIRTHDATE IS NOT NULL
    ) AVG_AGE
FROM UserData, "User"
WHERE "User".ID = UserData.USERID AND
    UserData.BIRTHDATE IS NOT NULL
ORDER BY TRUNC((CURRENT_DATE - UserData.BIRTHDATE)/365.25), "User".ID;

--group member count
SELECT GroupMembers.GroupID, "Group".NAME, COUNT(GroupMembers.GroupID) AS MEMBERCOUNT
FROM "Group" LEFT JOIN GroupMembers ON "Group".ID = GroupMembers.GroupID
WHERE "Group".ID = 1001
GROUP BY GroupMembers.GroupID, "Group".NAME