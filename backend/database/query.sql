-- get all public posts by userID
SELECT PublicPost.ID, PublicPost.TEXT, PublicPost.TIMESTAMP, PublicPost.PICTURE, "User".ID, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM PublicPost, "User", UserData
WHERE PublicPost.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    PublicPost.USERID = 1080
ORDER BY PublicPost.TIMESTAMP;

-- get all group posts by groupID
SELECT GroupPost.ID, GroupPost.TEXT, GroupPost.TIMESTAMP, GroupPost.PICTURE, GroupPost.GROUPID, "User".ID, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM GroupPost, "User", UserData
WHERE GroupPost.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    GroupPost.GROUPID = 1000
ORDER BY GroupPost.TIMESTAMP;

-- get all group by userID
SELECT GroupMembers.GROUPID, GroupMembers.USERID, "Group".NAME, "Group".LOGO, "Group".OWNERID, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM GroupMembers, "Group", "User", USERDATA
WHERE GroupMembers.GROUPID = "Group".ID AND
    GroupMembers.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    GroupMembers.USERID = 1003;