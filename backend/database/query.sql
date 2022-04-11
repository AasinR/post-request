-- get all public posts by userID
SELECT PublicPost.ID, PublicPost.TEXT, PublicPost.TIMESTAMP, PublicPost.PICTURE, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM PublicPost, "User", UserData
WHERE PublicPost.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    PublicPost.USERID = 1080
ORDER BY PublicPost.TIMESTAMP;

-- get all group posts by groupID
SELECT GroupPost.ID, GroupPost.TEXT, GroupPost.TIMESTAMP, GroupPost.PICTURE, "User".FIRSTNAME, "User".LASTNAME, UserData.PROFILEPICTURE
FROM GroupPost, "User", UserData
WHERE GroupPost.USERID = "User".ID AND
    "User".ID = UserData.USERID AND
    GroupPost.GROUPID = 1000
ORDER BY GroupPost.TIMESTAMP;