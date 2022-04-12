-- get all public posts by userID
SELECT PublicPost.ID, PublicPost.TEXT, PublicPost.TIMESTAMP, PublicPost.PICTURE, "User".ID, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM PublicPost, "User", UserData
WHERE PublicPost.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    PublicPost.USERID = 1080
ORDER BY PublicPost.TIMESTAMP DESC;

-- get all group posts by groupID
SELECT GroupPost.ID, GroupPost.TEXT, GroupPost.TIMESTAMP, GroupPost.PICTURE, GroupPost.GROUPID, "User".ID, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM GroupPost, "User", UserData
WHERE GroupPost.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    GroupPost.GROUPID = 1000
ORDER BY GroupPost.TIMESTAMP DESC;

-- get all public comment by postID
SELECT PublicComment.*, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM PublicComment, "User", UserData
WHERE PublicComment.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    PublicComment.POSTID = 1001
ORDER BY PublicComment.TIMESTAMP DESC;

-- get all group comment by postID
SELECT GroupComment.*, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM GroupComment, "User", UserData
WHERE GroupComment.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    GroupComment.POSTID = 1002
ORDER BY GroupComment.TIMESTAMP DESC;

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