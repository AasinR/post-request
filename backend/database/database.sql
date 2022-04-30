-- data tables
CREATE TABLE "User" (
    ID NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1000 INCREMENT BY 1),
    Password VARCHAR2(128) NOT NULL,
    Email VARCHAR2(128) NOT NULL,
    Permission NUMBER(1) NOT NULL,
    FirstName VARCHAR2(128) NOT NULL,
    LastName VARCHAR2(128) NOT NULL,
    CONSTRAINT pk_user PRIMARY KEY (ID),
    CONSTRAINT u_user UNIQUE (Email)
);

CREATE TABLE UserData (
    ID NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1000 INCREMENT BY 1),
    Gender VARCHAR2(6),
    ProfilePicture VARCHAR2(128),
    BirthDate DATE,
    PhoneNumber VARCHAR2(32),
    Profession VARCHAR2(128),
    UserID NUMBER,
    CONSTRAINT pk_userData PRIMARY KEY (ID),
    CONSTRAINT fk_userData FOREIGN KEY (UserID) REFERENCES "User" (ID) ON DELETE CASCADE
);

CREATE TABLE Friends (
    User1 NUMBER,
    User2 NUMBER,
    CONSTRAINT pk_friends PRIMARY KEY (User1, User2),
    CONSTRAINT fk_friends1 FOREIGN KEY (User1) REFERENCES "User" (ID) ON DELETE CASCADE,
    CONSTRAINT fk_friends2 FOREIGN KEY (User2) REFERENCES "User" (ID) ON DELETE CASCADE
);

CREATE TABLE FriendRequest (
    User1 NUMBER,
    User2 NUMBER,
    Approved NUMBER(1) NOT NULL,
    CONSTRAINT pk_friendRequest PRIMARY KEY (User1, User2),
    CONSTRAINT fk_friendRequest1 FOREIGN KEY (User1) REFERENCES "User" (ID) ON DELETE CASCADE,
    CONSTRAINT fk_friendRequest2 FOREIGN KEY (User2) REFERENCES "User" (ID) ON DELETE CASCADE
);

CREATE TABLE PrivateMessage (
    ID NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1000 INCREMENT BY 1),
    Content VARCHAR2(256) NOT NULL,
    TimeStamp TIMESTAMP NOT NULL,
    ToUser NUMBER NOT NULL,
    FromUser NUMBER NOT NULL,
    CONSTRAINT pk_privateMessage PRIMARY KEY (ID),
    CONSTRAINT fk_privateMessage1 FOREIGN KEY (ToUser) REFERENCES "User" (ID) ON DELETE CASCADE,
    CONSTRAINT fk_privateMessage2 FOREIGN KEY (FromUser) REFERENCES "User" (ID) ON DELETE CASCADE
);

CREATE TABLE MediaAlbum (
    ID NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1000 INCREMENT BY 1),
    Name VARCHAR2(128) NOT NULL,
    UserID NUMBER NOT NULL,
    CONSTRAINT pk_mediaAlbum PRIMARY KEY (ID),
    CONSTRAINT fk_mediaAlbum FOREIGN KEY (UserID) REFERENCES "User" (ID) ON DELETE CASCADE
);

CREATE TABLE PublicPicture (
    ID NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1000 INCREMENT BY 1),
    Content VARCHAR2(256) NOT NULL,
    TimeStamp TIMESTAMP,
    AlbumID NUMBER,
    UserID NUMBER NOT NULL,
    CONSTRAINT pk_publicPicture PRIMARY KEY (ID),
    CONSTRAINT fk_publicPicture1 FOREIGN KEY (AlbumID) REFERENCES MediaAlbum (ID) ON DELETE SET NULL,
    CONSTRAINT fk_publicPicture2 FOREIGN KEY (UserID) REFERENCES "User" (ID) ON DELETE CASCADE
);

CREATE TABLE PublicPost (
    ID NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1000 INCREMENT BY 1),
    Text VARCHAR2(256),
    TimeStamp TIMESTAMP NOT NULL,
    Picture NUMBER,
    UserID NUMBER NOT NULL,
    CONSTRAINT pk_publicPost PRIMARY KEY (ID),
    CONSTRAINT fk_publicPost1 FOREIGN KEY (Picture) REFERENCES PublicPicture (ID) ON DELETE CASCADE,
    CONSTRAINT fk_publicPost2 FOREIGN KEY (UserID) REFERENCES "User" (ID) ON DELETE CASCADE
);

CREATE TABLE PublicComment (
    ID NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1000 INCREMENT BY 1),
    Content VARCHAR2(256) NOT NULL,
    TimeStamp TIMESTAMP NOT NULL,
    PostID NUMBER NOT NULL,
    UserID NUMBER NOT NULL,
    CONSTRAINT pk_publicComment PRIMARY KEY (ID),
    CONSTRAINT fk_publicComment1 FOREIGN KEY (PostID) REFERENCES PublicPost (ID) ON DELETE CASCADE,
    CONSTRAINT fk_publicComment2 FOREIGN KEY (UserID) REFERENCES "User" (ID) ON DELETE CASCADE
);

CREATE TABLE "Group" (
    ID NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1000 INCREMENT BY 1),
    Name VARCHAR2(128) NOT NULL,
    Logo VARCHAR2(256),
    OwnerID NUMBER NOT NULL,
    CONSTRAINT pk_group PRIMARY KEY (ID),
    CONSTRAINT fk_group FOREIGN KEY (OwnerID) REFERENCES "User" (ID) ON DELETE CASCADE
);

CREATE TABLE GroupMembers (
    UserID NUMBER,
    GroupID NUMBER,
    CONSTRAINT pk_groupMembers PRIMARY KEY (UserID, GroupID),
    CONSTRAINT fk_groupMembers1 FOREIGN KEY (UserID) REFERENCES "User" (ID) ON DELETE CASCADE,
    CONSTRAINT fk_groupMembers2 FOREIGN KEY (GroupID) REFERENCES "Group" (ID) ON DELETE CASCADE
);

CREATE TABLE GroupPost (
    ID NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1000 INCREMENT BY 1),
    Text VARCHAR2(256),
    Picture VARCHAR2(256),
    TimeStamp TIMESTAMP NOT NULL,
    GroupID NUMBER NOT NULL,
    UserID NUMBER NOT NULL,
    CONSTRAINT pk_groupPost PRIMARY KEY (ID),
    CONSTRAINT fk_groupPost1 FOREIGN KEY (GroupID) REFERENCES "Group" (ID) ON DELETE CASCADE,
    CONSTRAINT fk_groupPost2 FOREIGN KEY (UserID) REFERENCES "User" (ID) ON DELETE CASCADE
);

CREATE TABLE GroupComment (
    ID NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1000 INCREMENT BY 1),
    Content VARCHAR2(256) NOT NULL,
    TimeStamp TIMESTAMP NOT NULL,
    PostID NUMBER NOT NULL,
    UserID NUMBER NOT NULL,
    CONSTRAINT pk_groupComment PRIMARY KEY (ID),
    CONSTRAINT fk_groupComment1 FOREIGN KEY (PostID) REFERENCES GroupPost (ID) ON DELETE CASCADE,
    CONSTRAINT fk_groupComment2 FOREIGN KEY (UserID) REFERENCES "User" (ID) ON DELETE CASCADE
);


-- test data
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('admin01', 'admin.user@test.com', 1, 'Admin', 'User');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('test01', 'test.user@test.com', 0, 'Test', 'User');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('W2C6B3VTMOW5K1KN', 'Murdo.Siddhant@citromail.hu', 0, 'Murdo', 'Siddhant');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('PJLL5WQ4Q3CG', 'Dmitri.Carl@freemail.hu', 0, 'Dmitri', 'Carl');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('BQ1IRXM4I', 'Arfin.Josiah@yahoo.com', 0, 'Arfin', 'Josiah');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('BMHKQCQ8CQH', 'Niraj.Ramit@yahoo.com', 0, 'Niraj', 'Ramit');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('VJKS3TCF4K', 'Sukhpal.Danish@freemail.hu', 0, 'Sukhpal', 'Danish');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('M4VQ8J3T', 'Harikrishna.Jayden-Thomas@citromail.hu', 0, 'Harikrishna', 'Jayden-Thomas');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('0HDSNYNAO5LWWB', 'Meyzhward.Rohit@stud.u-szeged.hu', 0, 'Meyzhward', 'Rohit');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('FX82XLI4BET', 'Marcos.Blyth@gmail.com', 0, 'Marcos', 'Blyth');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('89HLNZE77JXMG', 'Tyelor.Prentice@freemail.hu', 0, 'Tyelor', 'Prentice');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('B6BPUPQB8GTQ', 'Samir.Zion@citromail.hu', 0, 'Samir', 'Zion');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('ZYB0LJ5ME0LYIY', 'Vithujan.Lockey@gmail.com', 0, 'Vithujan', 'Lockey');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('Z4UJT9MJVQIFCG2A', 'Mikey.Franklin@yahoo.com', 0, 'Mikey', 'Franklin');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('W3EGCREPFDOWPKG', 'Nikash.Dylan-John@stud.u-szeged.hu', 0, 'Nikash', 'Dylan-John');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('M1NGBK4GFXLK', 'Etienne.Tyrone@yahoo.com', 0, 'Etienne', 'Tyrone');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('M4JBOZZ4RJAI1', 'Jole.Raza@citromail.hu', 0, 'Jole', 'Raza');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('QWVLWZBTA8', 'Conrad.Calean@citromail.hu', 0, 'Conrad', 'Calean');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('0C9EL3N42ID8H7', 'JJ.Mason@yahoo.com', 0, 'JJ', 'Mason');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('17GCJ90M9SN', 'Ryleigh.Benji@yahoo.com', 0, 'Ryleigh', 'Benji');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('9PK2CJR6', 'Jahid.Zuriel@gmail.com', 0, 'Jahid', 'Zuriel');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('HYZHOSIYXM0KO', 'Ciann.Abhinav@freemail.hu', 0, 'Ciann', 'Abhinav');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('595IY7DYNKF', 'Jaydyn.Maxim@freemail.hu', 0, 'Jaydyn', 'Maxim');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('FQZ5N39FPADOLM9', 'Jonatan.Woyenbrakemi@yahoo.com', 0, 'Jonatan', 'Woyenbrakemi');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('I72KDDF0HB', 'Girijan.Ines@yahoo.com', 0, 'Girijan', 'Ines');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('T8UGCG7UJVDA', 'Rajan.Kristoffer@citromail.hu', 0, 'Rajan', 'Kristoffer');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('OADW4ZE15V4Y', 'Yousif.Tegan@stud.u-szeged.hu', 0, 'Yousif', 'Tegan');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('WGLIL8QFFL', 'Jakub.Dion@citromail.hu', 0, 'Jakub', 'Dion');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('ZGHWNAKF', 'Lorenzo.Hately@citromail.hu', 0, 'Lorenzo', 'Hately');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('J84956J1ZYUJDFF', 'Rafferty.Torrin@yahoo.com', 0, 'Rafferty', 'Torrin');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('GCXKLX9SKEB9KB8J', 'Jayse.Khai@gmail.com', 0, 'Jayse', 'Khai');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('ELSXI6CER3SJ5CVF', 'Crispin.Austen@yahoo.com', 0, 'Crispin', 'Austen');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('IKSP6OV1S', 'Taylor.Yong@gmail.com', 0, 'Taylor', 'Yong');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('KRXE1YBIVGSE', 'Ayden.Karson@citromail.hu', 0, 'Ayden', 'Karson');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('V1C6A76QM4S8', 'Emerson.Joris@citromail.hu', 0, 'Emerson', 'Joris');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('YDJHWNIXRZWX', 'Kit.Jean@citromail.hu', 0, 'Kit', 'Jean');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('SD059NLWEJ', 'Sandy.Bilal@yahoo.com', 0, 'Sandy', 'Bilal');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('UPZNALZLUWD', 'Sudais.Isa@gmail.com', 0, 'Sudais', 'Isa');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('JEGBX7O1IW3QLNI8', 'Forbes.Taonga@yahoo.com', 0, 'Forbes', 'Taonga');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('0K2C18FAR4IKRTUS', 'Mobeen.Ian@gmail.com', 0, 'Mobeen', 'Ian');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('R9C16DEXQ486IZUI', 'Efan.Arunas@yahoo.com', 0, 'Efan', 'Arunas');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('RR95JVGH8K8', 'Caelen.Jackson@citromail.hu', 0, 'Caelen', 'Jackson');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('FK9DO8EH9WQFG', 'Keison.Matas@yahoo.com', 0, 'Keison', 'Matas');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('J77XDE0INST4S', 'Gurardass.Santiago@gmail.com', 0, 'Gurardass', 'Santiago');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('OJZOIXAP', 'Damian.Valo@citromail.hu', 0, 'Damian', 'Valo');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('RSWKDZP257', 'Airidas.Reng@freemail.hu', 0, 'Airidas', 'Reng');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('7O3KNHW91HJT8DM', 'Masood.Mobeen@gmail.com', 0, 'Masood', 'Mobeen');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('ZZJI4MRR', 'Charly.Rhys-Bernard@yahoo.com', 0, 'Charly', 'Rhys-Bernard');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('B40B48AGKRA4A', 'Zuriel.Blessing@citromail.hu', 0, 'Zuriel', 'Blessing');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('1SK4XWDV9XQ', 'Ngonidzashe.Blaine@freemail.hu', 0, 'Ngonidzashe', 'Blaine');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('ILKN8VV0HO6OPY5Q', 'Dalong.Noel@yahoo.com', 0, 'Dalong', 'Noel');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('V3MVO6CIUXOTMB2', 'Gurardass.Alhaji@stud.u-szeged.hu', 0, 'Gurardass', 'Alhaji');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('W30VW133KTPAREIF', 'Clarke.Nathaniel@gmail.com', 0, 'Clarke', 'Nathaniel');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('7BPDY9H00DK', 'Eamon.Kaidyn@freemail.hu', 0, 'Eamon', 'Kaidyn');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('J8ERR0N5PGGZDTX', 'Drew.Fiachra@yahoo.com', 0, 'Drew', 'Fiachra');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('BRM2ENAD4TFD', 'Calum-James.Davy@stud.u-szeged.hu', 0, 'Calum-James', 'Davy');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('ZU6L2P2H', 'Precious.Ryleigh@yahoo.com', 0, 'Precious', 'Ryleigh');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('RLIL6AS0HVLBZ', 'Koden.Havila@yahoo.com', 0, 'Koden', 'Havila');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('676D183AJHHE', 'Cambell.Montague@yahoo.com', 0, 'Cambell', 'Montague');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('RRO1ZTWX9PN78', 'Denny.Diesel@stud.u-szeged.hu', 0, 'Denny', 'Diesel');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('VPW2RP1W59KVDM', 'Harnek.Roger@citromail.hu', 0, 'Harnek', 'Roger');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('UUQ7TWASF', 'Murray.Zakariya@yahoo.com', 0, 'Murray', 'Zakariya');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('5DPYLLBJ13F1NNC', 'Pranav.Idahosa@yahoo.com', 0, 'Pranav', 'Idahosa');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('V7RYW1F66C86O5BW', 'Bradley.Frank@citromail.hu', 0, 'Bradley', 'Frank');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('ZPH288HLO05JC', 'Aydan.Bevin@yahoo.com', 0, 'Aydan', 'Bevin');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('UP3ULDEL3Q', 'Spondon.Baron@gmail.com', 0, 'Spondon', 'Baron');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('G65I731I5X', 'Binod.Farhan@gmail.com', 0, 'Binod', 'Farhan');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('H68JYZ3518B89', 'Mathu.Heyden@stud.u-szeged.hu', 0, 'Mathu', 'Heyden');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('GUT2O5DFV97I3', 'Eroni.LLeyton@yahoo.com', 0, 'Eroni', 'LLeyton');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('W30P5M240HNS', 'Kinneil.Allan@freemail.hu', 0, 'Kinneil', 'Allan');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('CW0M1LHY', 'Fahad.Aryian@yahoo.com', 0, 'Fahad', 'Aryian');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('3JUDT1ZU03SC8D', 'Tarik.Arunas@stud.u-szeged.hu', 0, 'Tarik', 'Arunas');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('K2TSZD81J', 'Jeswin.Haseeb@yahoo.com', 0, 'Jeswin', 'Haseeb');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('57Z22B31TCWB', 'Aden.Ewen@stud.u-szeged.hu', 0, 'Aden', 'Ewen');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('5T2RW8E4HK', 'Finnlay.Jasper@freemail.hu', 0, 'Finnlay', 'Jasper');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('YLZX0RKVHZ7', 'Kyel.Rehaan@yahoo.com', 0, 'Kyel', 'Rehaan');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('2ZEJB35TQQCGF9', 'Jace.Tyson@yahoo.com', 0, 'Jace', 'Tyson');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('7Z9D72E2R3', 'Kane.Lewin@stud.u-szeged.hu', 0, 'Kane', 'Lewin');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('AEU7LKBRKHU', 'Darryn.Jai@stud.u-szeged.hu', 0, 'Darryn', 'Jai');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('WL8TDFAVEOZ6IANE', 'Saifaddine.Barrie@freemail.hu', 0, 'Saifaddine', 'Barrie');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('MBPDBOCEBQSCB', 'Calan.Ayden@citromail.hu', 0, 'Calan', 'Ayden');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('SVGXF5GBFS1', 'Jagat.Yang@freemail.hu', 0, 'Jagat', 'Yang');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('KO4TNQGT8HOV3BVK', 'Jomuel.Brian@gmail.com', 0, 'Jomuel', 'Brian');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('C656W5KUFRJ', 'Kenlin.Kael@yahoo.com', 0, 'Kenlin', 'Kael');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('R9H9EA4D9', 'Kenzo.Ari@gmail.com', 0, 'Kenzo', 'Ari');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('DVBYYC9LKQMSV', 'Casper.Kaidinn@citromail.hu', 0, 'Casper', 'Kaidinn');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('I6OFTRHREBBN', 'Jerrick.Kiaran@stud.u-szeged.hu', 0, 'Jerrick', 'Kiaran');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('GR2L4O9L35IR', 'Marvin.Thomas@freemail.hu', 0, 'Marvin', 'Thomas');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('0LMFSJHD4NM', 'Tibet.Akan@gmail.com', 0, 'Tibet', 'Akan');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('7DY0KCV9QX72', 'Diego.Heyden@stud.u-szeged.hu', 0, 'Diego', 'Heyden');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('YREYMHPYJ5S', 'Alber.Amrit@freemail.hu', 0, 'Alber', 'Amrit');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('J4TJO49IYB', 'Denzel.Aonghus@gmail.com', 0, 'Denzel', 'Aonghus');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('4YBNXXWJJN', 'Roshan.Rahim@citromail.hu', 0, 'Roshan', 'Rahim');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('NOMFKR78O33VAIQ', 'Wen.Edison@freemail.hu', 0, 'Wen', 'Edison');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('0DYWOICBBN8ZZ', 'Zechariah.Roan@citromail.hu', 0, 'Zechariah', 'Roan');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('J869SNI8GIDI2', 'Ammar.Johannes@citromail.hu', 0, 'Ammar', 'Johannes');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('WY8Z1782', 'Calum.Sahil@citromail.hu', 0, 'Calum', 'Sahil');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('OSBKO8H11VIXS', 'Aun.Lomond@freemail.hu', 0, 'Aun', 'Lomond');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('CN1H75K1', 'Donnie.Leven@freemail.hu', 0, 'Donnie', 'Leven');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('IY9J64TOPYGBOGOB', 'Ilyas.Keiryn@citromail.hu', 0, 'Ilyas', 'Keiryn');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('D6SV4HA7C1MPSVG', 'Kerr.Basile@freemail.hu', 0, 'Kerr', 'Basile');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('23C0RSVF4D87SQ', 'Kyral.Azzedine@citromail.hu', 0, 'Kyral', 'Azzedine');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('9E798R2WIB', 'Moore.Linton@yahoo.com', 0, 'Moore', 'Linton');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('1UZPK8OQVF77R', 'Zakk.Ieuan@yahoo.com', 0, 'Zakk', 'Ieuan');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('ES7OMZCMKGI', 'Yadgor.Lionel@freemail.hu', 0, 'Yadgor', 'Lionel');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('Y5PN3T57OVNLZ', 'Rory.Zaine@citromail.hu', 0, 'Rory', 'Zaine');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('QYA4WWLMH', 'Masood.Cejay@stud.u-szeged.hu', 0, 'Masood', 'Cejay');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('LGFWNMH09D2XJH', 'Alasdair.Osesenagha@stud.u-szeged.hu', 0, 'Alasdair', 'Osesenagha');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('FVY58PFBNKW', 'Keeton.Argyle@yahoo.com', 0, 'Keeton', 'Argyle');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('GKOT0GNIY5', 'Mohammad-Bilal.Phoenix@stud.u-szeged.hu', 0, 'Mohammad-Bilal', 'Phoenix');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('J7ZGIPULOH9', 'Kealon.Conan@citromail.hu', 0, 'Kealon', 'Conan');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('4ZV9KFXE89DE', 'Kian.Arturo@gmail.com', 0, 'Kian', 'Arturo');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('FPU3WJOHF6VNE4HE', 'Rooke.Kaidyn@citromail.hu', 0, 'Rooke', 'Kaidyn');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('DDQE23OGX79QKS', 'Chester.Boedyn@citromail.hu', 0, 'Chester', 'Boedyn');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('WKMOCVH0XCS', 'Gordon.Niro@gmail.com', 0, 'Gordon', 'Niro');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('2MJSOQ1FFPBIAB', 'Sofian.Valentin@freemail.hu', 0, 'Sofian', 'Valentin');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('2XLC7X2NGIMFD', 'Leonard.Benoit@yahoo.com', 0, 'Leonard', 'Benoit');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('3RS55RE9FJI96', 'Lochlan-Oliver.Folarinwa@gmail.com', 0, 'Lochlan-Oliver', 'Folarinwa');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('NDMER9QGGTP', 'Forgan.Musse@yahoo.com', 0, 'Forgan', 'Musse');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('ANZ2YHSV', 'Faizaan.Ricky@freemail.hu', 0, 'Faizaan', 'Ricky');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('KUBFORS6MSIR', 'Awwal.Zaid@yahoo.com', 0, 'Awwal', 'Zaid');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('MXYWE60S44J1', 'Zack.Laurence@gmail.com', 0, 'Zack', 'Laurence');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('UWIYER5F30LKHQ', 'Teydren.Sameer@citromail.hu', 0, 'Teydren', 'Sameer');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('ATAHGV824QT', 'Cain.Blaike@yahoo.com', 0, 'Cain', 'Blaike');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('6O2UYJZ7XHR', 'Aronas.Leon@freemail.hu', 0, 'Aronas', 'Leon');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('TKU4PZW95QYUBYP', 'Jaxson.Marios@gmail.com', 0, 'Jaxson', 'Marios');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('JVY8M3A86DX', 'Reice.Henri@freemail.hu', 0, 'Reice', 'Henri');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('NG3IE8NVW', 'Malachai.Karsyn@gmail.com', 0, 'Malachai', 'Karsyn');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('FBZVXJBEDXX0Y', 'Maciej.Aryn@citromail.hu', 0, 'Maciej', 'Aryn');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('YQ25HQFKEVIBK6KB', 'Abdul-Aziz.Blazey@freemail.hu', 0, 'Abdul-Aziz', 'Blazey');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('7XQ1FWGC3X913JF', 'Cathal.Comghan@freemail.hu', 0, 'Cathal', 'Comghan');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('DARS825C6Y558X', 'Kacper.Talorcan@stud.u-szeged.hu', 0, 'Kacper', 'Talorcan');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('XLA8SA03VG3', 'Arturo.Alastair@freemail.hu', 0, 'Arturo', 'Alastair');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('S1BHXH4P', 'Santino.Jaydon@stud.u-szeged.hu', 0, 'Santino', 'Jaydon');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('BFUYMVWYI4', 'Gytis.Wilson@citromail.hu', 0, 'Gytis', 'Wilson');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('X42ZUE97ZTG', 'Ker.Heidar@gmail.com', 0, 'Ker', 'Heidar');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('AO2NSP2Y', 'Jensen.Sylvain@gmail.com', 0, 'Jensen', 'Sylvain');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('NXIMGO6TSXOMW', 'Kyie.Dakota@stud.u-szeged.hu', 0, 'Kyie', 'Dakota');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('1QOW90T3VJICK', 'Siergiej.Tymoteusz@freemail.hu', 0, 'Siergiej', 'Tymoteusz');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('9E0H5PA8H', 'Faheem.Remo@gmail.com', 0, 'Faheem', 'Remo');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('6CPJSGUKROM', 'Danny.Kia@freemail.hu', 0, 'Danny', 'Kia');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('U5DWW8LHF', 'Cullen.Rhuan@freemail.hu', 0, 'Cullen', 'Rhuan');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('ENO1F2V22Y0QPF', 'Hansen.Musse@gmail.com', 0, 'Hansen', 'Musse');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('TBZ9E1VGE', 'Rhyan.Arian@gmail.com', 0, 'Rhyan', 'Arian');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('043J7BGH3S', 'Uzayr.Keir@gmail.com', 0, 'Uzayr', 'Keir');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('W7A3JF0C8YG', 'Shayne.Maneet@citromail.hu', 0, 'Shayne', 'Maneet');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('3ELB773Y69', 'Jeyun.Finan@citromail.hu', 0, 'Jeyun', 'Finan');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('XUNL8GTNTLA0W', 'Madison-Jake.Daithi@citromail.hu', 0, 'Madison-Jake', 'Daithi');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('R7ZBI4A8O5D5B', 'Kia.Zohair@citromail.hu', 0, 'Kia', 'Zohair');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('74DY65XY63WRBL2', 'Hopkin.Kile@stud.u-szeged.hu', 0, 'Hopkin', 'Kile');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('VXIU3ZF1NE3X', 'Fynlay.Aulay@freemail.hu', 0, 'Fynlay', 'Aulay');
INSERT INTO "User" (password, email, permission, firstname, lastname) VALUES ('8TQPZDQYUP', 'Kelso.Jincheng@stud.u-szeged.hu', 0, 'Kelso', 'Jincheng');

INSERT INTO userdata (userid) VALUES ('1000');
INSERT INTO userdata (userid) VALUES ('1001');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1990/1/19', 'yyyy/mm/dd'), '+36502130985', 'Camera operator', '1002');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1999/4/24', 'yyyy/mm/dd'), '+36701886341', 'Cartographer', '1003');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2002/9/28', 'yyyy/mm/dd'), '+36307185830', 'Chemical engineer', '1004');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2001/2/24', 'yyyy/mm/dd'), '+36302905385', 'Nature conservation officer', '1005');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1991/3/31', 'yyyy/mm/dd'), '+36700499289', 'Meteorologist', '1006');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1997/2/1', 'yyyy/mm/dd'), '+36300258332', 'Plant breeder', '1007');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1993/8/18', 'yyyy/mm/dd'), '+36506650613', 'Software developer', '1008');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2001/3/25', 'yyyy/mm/dd'), '+36319452015', 'Tour operator', '1009');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1992/7/19', 'yyyy/mm/dd'), '+36708893912', 'Civil engineer', '1010');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1990/11/18', 'yyyy/mm/dd'), '+36703400870', 'Paramedic', '1011');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2002/11/11', 'yyyy/mm/dd'), '+36702050033', 'Materials engineer', '1012');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1995/12/24', 'yyyy/mm/dd'), '+36706311088', 'Housing adviser', '1013');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1993/8/4', 'yyyy/mm/dd'), '+36312129675', 'Design engineer', '1014');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1990/1/21', 'yyyy/mm/dd'), '+36500319207', 'Trader', '1015');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1992/5/8', 'yyyy/mm/dd'), '+36505806228', 'Structural engineer', '1016');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1999/9/5', 'yyyy/mm/dd'), '+36301626534', 'Trader', '1017');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1993/12/14', 'yyyy/mm/dd'), '+36301983414', 'Systems analyst', '1018');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2000/8/8', 'yyyy/mm/dd'), '+36505309520', 'Herbalist', '1019');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2002/6/4', 'yyyy/mm/dd'), '+36319039923', 'Architect', '1020');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1997/1/7', 'yyyy/mm/dd'), '+36504856016', 'Archaeologist', '1021');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2002/8/17', 'yyyy/mm/dd'), '+36305534023', 'Production manager', '1022');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1996/8/15', 'yyyy/mm/dd'), '+36700502297', 'Company secretary', '1023');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1993/6/27', 'yyyy/mm/dd'), '+36209105416', 'Paramedic', '1024');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2004/5/17', 'yyyy/mm/dd'), '+36700280556', 'Public house manager', '1025');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1999/12/15', 'yyyy/mm/dd'), '+36701497811', 'Travel agent', '1026');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1990/1/6', 'yyyy/mm/dd'), '+36509631231', 'Curator', '1027');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1998/3/24', 'yyyy/mm/dd'), '+36202120774', 'Doctor', '1028');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1992/3/28', 'yyyy/mm/dd'), '+36700087733', 'Curator', '1029');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1993/1/1', 'yyyy/mm/dd'), '+36319216374', 'Mobile developer', '1030');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1994/2/4', 'yyyy/mm/dd'), '+36300917996', 'Graphic designer', '1031');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1991/3/29', 'yyyy/mm/dd'), '+36507707810', 'Accountant', '1032');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1999/1/11', 'yyyy/mm/dd'), '+36203959955', 'Network administrator', '1033');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1999/8/4', 'yyyy/mm/dd'), '+36503404125', 'Police officer', '1034');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1991/1/22', 'yyyy/mm/dd'), '+36505656497', 'Social worker', '1035');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1999/9/4', 'yyyy/mm/dd'), '+36309065151', 'Microbiologist', '1036');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2004/6/4', 'yyyy/mm/dd'), '+36307569509', 'Computer scientist', '1037');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2001/7/24', 'yyyy/mm/dd'), '+36315084848', 'Firefighter', '1038');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2002/7/16', 'yyyy/mm/dd'), '+36208029792', 'Archaeologist', '1039');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2003/12/26', 'yyyy/mm/dd'), '+36707914473', 'Homeless worker', '1040');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2000/4/18', 'yyyy/mm/dd'), '+36706337181', 'Tour operator', '1041');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1996/1/18', 'yyyy/mm/dd'), '+36509973145', 'Company secretary', '1042');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2003/11/22', 'yyyy/mm/dd'), '+36705153472', 'Firefighter', '1043');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1990/7/25', 'yyyy/mm/dd'), '+36303659012', 'Water engineer', '1044');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1995/12/24', 'yyyy/mm/dd'), '+36509029627', 'Physiotherapist', '1045');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1998/4/15', 'yyyy/mm/dd'), '+36202097794', 'Meteorologist', '1046');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2003/11/25', 'yyyy/mm/dd'), '+36204239322', 'Data analyst', '1047');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1990/11/16', 'yyyy/mm/dd'), '+36201255623', 'Photographer', '1048');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2004/8/26', 'yyyy/mm/dd'), '+36319493344', 'Chemical engineer', '1049');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2000/3/8', 'yyyy/mm/dd'), '+36315848767', 'Toxicologist', '1050');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1998/7/18', 'yyyy/mm/dd'), '+36319891977', 'Chemical engineer', '1051');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2001/6/10', 'yyyy/mm/dd'), '+36502862247', 'Microbiologist', '1052');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1992/5/7', 'yyyy/mm/dd'), '+36311596732', 'Careers consultant', '1053');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2000/3/20', 'yyyy/mm/dd'), '+36500984215', 'Building surveyor', '1054');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2004/9/11', 'yyyy/mm/dd'), '+36707319368', 'Toxicologist', '1055');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1993/10/25', 'yyyy/mm/dd'), '+36301804727', 'Colour technologist', '1056');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1991/10/28', 'yyyy/mm/dd'), '+36500399415', 'Personal assistant', '1057');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2004/10/8', 'yyyy/mm/dd'), '+36303468831', 'Mechanical engineer', '1058');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2000/1/21', 'yyyy/mm/dd'), '+36507112069', 'Video game designer', '1059');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1998/3/4', 'yyyy/mm/dd'), '+36703666282', 'Secretary', '1060');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1990/11/3', 'yyyy/mm/dd'), '+36318952560', 'Brand manager', '1061');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2000/1/17', 'yyyy/mm/dd'), '+36707980531', 'Materials engineer', '1062');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2002/8/22', 'yyyy/mm/dd'), '+36501916047', 'Systems analyst', '1063');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1992/1/13', 'yyyy/mm/dd'), '+36709802759', 'Social worker', '1064');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1999/1/26', 'yyyy/mm/dd'), '+36705661583', 'Estate agent', '1065');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1999/11/4', 'yyyy/mm/dd'), '+36318728502', 'Electronics engineer', '1066');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1999/12/21', 'yyyy/mm/dd'), '+36204683133', 'Firefighter', '1067');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2002/7/14', 'yyyy/mm/dd'), '+36201772269', 'Community worker', '1068');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1993/2/9', 'yyyy/mm/dd'), '+36700067463', 'Network administrator', '1069');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1994/5/7', 'yyyy/mm/dd'), '+36204987007', 'Economist', '1070');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1998/2/23', 'yyyy/mm/dd'), '+36312160907', 'Accountant', '1071');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1999/8/29', 'yyyy/mm/dd'), '+36505613753', 'Investment analyst', '1072');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1995/7/3', 'yyyy/mm/dd'), '+36505932016', 'Brand manager', '1073');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1996/11/10', 'yyyy/mm/dd'), '+36319047212', 'Tax inspector', '1074');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2000/1/24', 'yyyy/mm/dd'), '+36203387462', 'Network administrator', '1075');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1995/2/24', 'yyyy/mm/dd'), '+36200990335', 'Computer scientist', '1076');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2001/3/9', 'yyyy/mm/dd'), '+36506975739', 'Toxicologist', '1077');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2001/1/18', 'yyyy/mm/dd'), '+36303898297', 'Marine scientist', '1078');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1995/9/19', 'yyyy/mm/dd'), '+36505888674', 'Electronics engineer', '1079');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1995/3/31', 'yyyy/mm/dd'), '+36302008497', 'Doctor', '1080');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2001/9/13', 'yyyy/mm/dd'), '+36209975300', 'Estate agent', '1081');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2003/5/12', 'yyyy/mm/dd'), '+36304226731', 'Research scientist', '1082');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2004/8/31', 'yyyy/mm/dd'), '+36315828918', 'Psychologist', '1083');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1998/1/26', 'yyyy/mm/dd'), '+36504531711', 'Writer', '1084');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1993/4/14', 'yyyy/mm/dd'), '+36704740179', 'Design engineer', '1085');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1997/4/26', 'yyyy/mm/dd'), '+36312609022', 'Archaeologist', '1086');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2000/11/21', 'yyyy/mm/dd'), '+36314931460', 'Electronics engineer', '1087');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1992/7/9', 'yyyy/mm/dd'), '+36702305870', 'Plant breeder', '1088');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2003/10/30', 'yyyy/mm/dd'), '+36508743461', 'Dentist', '1089');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1999/9/15', 'yyyy/mm/dd'), '+36302007357', 'Forensic scientist', '1090');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1996/4/1', 'yyyy/mm/dd'), '+36700248982', 'Picture researcher', '1091');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2003/10/5', 'yyyy/mm/dd'), '+36207597828', 'Biotechnologist', '1092');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2000/9/2', 'yyyy/mm/dd'), '+36508045164', 'Cartographer', '1093');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2000/6/30', 'yyyy/mm/dd'), '+36305265759', 'Microbiologist', '1094');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1992/11/23', 'yyyy/mm/dd'), '+36506355983', 'Production manager', '1095');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1998/2/3', 'yyyy/mm/dd'), '+36200276061', 'Video game developer', '1096');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1995/2/19', 'yyyy/mm/dd'), '+36308913672', 'Homeless worker', '1097');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2002/12/13', 'yyyy/mm/dd'), '+36502193820', 'Curator', '1098');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1995/2/4', 'yyyy/mm/dd'), '+36500944233', 'Brand manager', '1099');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1995/7/3', 'yyyy/mm/dd'), '+36505696524', 'Nature conservation officer', '1100');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1993/11/29', 'yyyy/mm/dd'), '+36206051643', 'Estate agent', '1101');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1996/10/1', 'yyyy/mm/dd'), '+36319331843', 'Animator', '1102');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2001/5/26', 'yyyy/mm/dd'), '+36703382062', 'Network administrator', '1103');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1996/6/25', 'yyyy/mm/dd'), '+36208504101', 'Statistician', '1104');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2004/11/30', 'yyyy/mm/dd'), '+36201947865', 'Photographer', '1105');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1998/1/8', 'yyyy/mm/dd'), '+36706113636', 'Software developer', '1106');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1995/9/10', 'yyyy/mm/dd'), '+36708132439', 'Graphic designer', '1107');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1992/2/1', 'yyyy/mm/dd'), '+36319351890', 'Herbalist', '1108');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1995/7/12', 'yyyy/mm/dd'), '+36709554340', 'Homeless worker', '1109');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1997/3/28', 'yyyy/mm/dd'), '+36318269988', 'Tour operator', '1110');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1997/3/14', 'yyyy/mm/dd'), '+36708252903', 'Chemical engineer', '1111');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1997/12/28', 'yyyy/mm/dd'), '+36206454140', 'Petroleum engineer', '1112');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2002/4/9', 'yyyy/mm/dd'), '+36307476839', 'Analytical chemist', '1113');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1990/3/7', 'yyyy/mm/dd'), '+36207643350', 'Pension scheme manager', '1114');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1991/4/15', 'yyyy/mm/dd'), '+36201557298', 'Microbiologist', '1115');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2001/5/31', 'yyyy/mm/dd'), '+36701850691', 'Systems analyst', '1116');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1995/7/7', 'yyyy/mm/dd'), '+36205179178', 'Commissioning engineer', '1117');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1991/10/5', 'yyyy/mm/dd'), '+36505778541', 'Mobile developer', '1118');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2001/4/27', 'yyyy/mm/dd'), '+36307554016', 'Doctor', '1119');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1999/6/29', 'yyyy/mm/dd'), '+36318768974', 'Secretary', '1120');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2002/3/25', 'yyyy/mm/dd'), '+36317045438', 'Trader', '1121');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1994/3/8', 'yyyy/mm/dd'), '+36307030321', 'Picture researcher', '1122');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2002/9/19', 'yyyy/mm/dd'), '+36302820173', 'Statistician', '1123');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1997/4/25', 'yyyy/mm/dd'), '+36316185539', 'Pharmacist', '1124');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1995/2/5', 'yyyy/mm/dd'), '+36310371437', 'Public librarian', '1125');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2000/12/1', 'yyyy/mm/dd'), '+36304663763', 'Commissioning engineer', '1126');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1994/5/12', 'yyyy/mm/dd'), '+36313379138', 'Brand manager', '1127');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1990/5/27', 'yyyy/mm/dd'), '+36700954579', 'Doctor', '1128');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1996/1/18', 'yyyy/mm/dd'), '+36307551414', 'Firefighter', '1129');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1996/8/20', 'yyyy/mm/dd'), '+36501735970', 'Graphic designer', '1130');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1994/7/7', 'yyyy/mm/dd'), '+36202389113', 'Psychologist', '1131');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1997/7/26', 'yyyy/mm/dd'), '+36704618500', 'Mechanical engineer', '1132');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1997/3/8', 'yyyy/mm/dd'), '+36501241630', 'Investment analyst', '1133');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1999/6/2', 'yyyy/mm/dd'), '+36502353099', 'Electrical engineer', '1134');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2004/1/9', 'yyyy/mm/dd'), '+36704395760', 'Curator', '1135');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('2003/3/23', 'yyyy/mm/dd'), '+36312643373', 'Cyber security specialist', '1136');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2000/3/10', 'yyyy/mm/dd'), '+36318019892', 'Psychotherapist', '1137');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1991/5/4', 'yyyy/mm/dd'), '+36505356361', 'Cartographer', '1138');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1992/3/17', 'yyyy/mm/dd'), '+36203959048', 'Animator', '1139');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1998/7/22', 'yyyy/mm/dd'), '+36700074578', 'Biotechnologist', '1140');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1991/12/21', 'yyyy/mm/dd'), '+36206651491', 'Building surveyor', '1141');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1996/7/13', 'yyyy/mm/dd'), '+36315854307', 'Oceanographer', '1142');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1995/9/20', 'yyyy/mm/dd'), '+36207895104', 'Personal assistant', '1143');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2003/3/24', 'yyyy/mm/dd'), '+36500766903', 'Firefighter', '1144');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2002/8/17', 'yyyy/mm/dd'), '+36508259633', 'Housing adviser', '1145');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1998/3/1', 'yyyy/mm/dd'), '+36302196766', 'Data analyst', '1146');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2003/8/28', 'yyyy/mm/dd'), '+36506406865', 'Herbalist', '1147');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('1998/8/5', 'yyyy/mm/dd'), '+36200755524', 'Brand manager', '1148');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Male', TO_DATE('1992/2/13', 'yyyy/mm/dd'), '+36705694284', 'Production manager', '1149');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2001/3/30', 'yyyy/mm/dd'), '+36508048044', 'Marine scientist', '1150');
INSERT INTO userdata (gender, birthdate, phonenumber, profession, userid) VALUES ('Female', TO_DATE('2000/10/21', 'yyyy/mm/dd'), '+36505811601', 'Design engineer', '1151');

INSERT INTO publicpost (text, timestamp, userid) VALUES ('Carpe diem. Seize the day, boys.', TO_TIMESTAMP('2022/1/12 12:2', 'yyyy/mm/dd hh24:mi'), '1091');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Im bored...', TO_TIMESTAMP('2022/2/11 22:21', 'yyyy/mm/dd hh24:mi'), '1080');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Let me speak, please', TO_TIMESTAMP('2022/2/20 11:58', 'yyyy/mm/dd hh24:mi'), '1054');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Houston, we have a problem', TO_TIMESTAMP('2022/3/22 9:9', 'yyyy/mm/dd hh24:mi'), '1056');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Go ahead, make my day.', TO_TIMESTAMP('2022/1/6 4:42', 'yyyy/mm/dd hh24:mi'), '1094');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('What''s up?', TO_TIMESTAMP('2022/2/7 2:57', 'yyyy/mm/dd hh24:mi'), '1066');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('There''s no place like home.', TO_TIMESTAMP('2022/2/12 14:56', 'yyyy/mm/dd hh24:mi'), '1064');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/1/1 0:14', 'yyyy/mm/dd hh24:mi'), '1089');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('How high is it?', TO_TIMESTAMP('2022/2/6 22:26', 'yyyy/mm/dd hh24:mi'), '1052');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('aaaaaaaaaaaaaaa', TO_TIMESTAMP('2022/3/15 5:51', 'yyyy/mm/dd hh24:mi'), '1006');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Let me speak, please', TO_TIMESTAMP('2022/2/17 2:41', 'yyyy/mm/dd hh24:mi'), '1040');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Mama says, ''Stupid is as stupid does.', TO_TIMESTAMP('2022/1/11 14:43', 'yyyy/mm/dd hh24:mi'), '1033');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('How are you?', TO_TIMESTAMP('2022/2/12 23:14', 'yyyy/mm/dd hh24:mi'), '1080');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('I bought it for you', TO_TIMESTAMP('2022/1/4 15:4', 'yyyy/mm/dd hh24:mi'), '1082');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Boiler for sale!', TO_TIMESTAMP('2022/3/18 2:48', 'yyyy/mm/dd hh24:mi'), '1121');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('I asked them to stop.', TO_TIMESTAMP('2022/3/5 23:49', 'yyyy/mm/dd hh24:mi'), '1079');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('We''re sleepy', TO_TIMESTAMP('2022/2/20 3:35', 'yyyy/mm/dd hh24:mi'), '1064');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Boiler for sale!', TO_TIMESTAMP('2022/2/20 8:57', 'yyyy/mm/dd hh24:mi'), '1120');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/2/16 1:53', 'yyyy/mm/dd hh24:mi'), '1046');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Life moves pretty fast. If you don''t stop and look around once in a while, you could miss it.', TO_TIMESTAMP('2022/2/7 16:0', 'yyyy/mm/dd hh24:mi'), '1034');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('We must leave right away.', TO_TIMESTAMP('2022/1/14 1:39', 'yyyy/mm/dd hh24:mi'), '1042');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Did you break it?', TO_TIMESTAMP('2022/2/14 20:22', 'yyyy/mm/dd hh24:mi'), '1012');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('I followed you.', TO_TIMESTAMP('2022/1/21 12:29', 'yyyy/mm/dd hh24:mi'), '1077');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('What''s your wife''s name?', TO_TIMESTAMP('2022/2/17 0:5', 'yyyy/mm/dd hh24:mi'), '1068');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Hello!', TO_TIMESTAMP('2022/3/15 1:7', 'yyyy/mm/dd hh24:mi'), '1073');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Go ahead, make my day.', TO_TIMESTAMP('2022/2/20 7:33', 'yyyy/mm/dd hh24:mi'), '1104');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Why so serious?', TO_TIMESTAMP('2022/2/15 22:41', 'yyyy/mm/dd hh24:mi'), '1049');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Why so serious?', TO_TIMESTAMP('2022/2/5 9:46', 'yyyy/mm/dd hh24:mi'), '1032');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('You talking to me?', TO_TIMESTAMP('2022/3/17 8:37', 'yyyy/mm/dd hh24:mi'), '1150');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Hello there!', TO_TIMESTAMP('2022/2/5 0:1', 'yyyy/mm/dd hh24:mi'), '1022');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Heeyy', TO_TIMESTAMP('2022/3/6 17:23', 'yyyy/mm/dd hh24:mi'), '1040');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Nothing is better than health!', TO_TIMESTAMP('2022/3/12 20:48', 'yyyy/mm/dd hh24:mi'), '1067');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Did you break it?', TO_TIMESTAMP('2022/2/16 14:20', 'yyyy/mm/dd hh24:mi'), '1026');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Show me yours!', TO_TIMESTAMP('2022/3/8 4:56', 'yyyy/mm/dd hh24:mi'), '1101');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Show me yours!', TO_TIMESTAMP('2022/2/1 6:10', 'yyyy/mm/dd hh24:mi'), '1052');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Go ahead, make my day.', TO_TIMESTAMP('2022/3/15 1:23', 'yyyy/mm/dd hh24:mi'), '1106');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Is this working?', TO_TIMESTAMP('2022/2/6 2:34', 'yyyy/mm/dd hh24:mi'), '1004');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('You agreed to it', TO_TIMESTAMP('2022/3/4 11:24', 'yyyy/mm/dd hh24:mi'), '1101');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('That''s our train.', TO_TIMESTAMP('2022/1/17 7:7', 'yyyy/mm/dd hh24:mi'), '1134');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('How high is it?', TO_TIMESTAMP('2022/2/3 17:38', 'yyyy/mm/dd hh24:mi'), '1049');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Nobody''s perfect', TO_TIMESTAMP('2022/3/13 20:57', 'yyyy/mm/dd hh24:mi'), '1013');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('I bought it for you', TO_TIMESTAMP('2022/1/3 8:22', 'yyyy/mm/dd hh24:mi'), '1028');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('I don''t want to survive. I want to live.', TO_TIMESTAMP('2022/1/30 13:3', 'yyyy/mm/dd hh24:mi'), '1040');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('I''m still excited', TO_TIMESTAMP('2022/2/26 5:27', 'yyyy/mm/dd hh24:mi'), '1130');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('It must be very bad.', TO_TIMESTAMP('2022/1/16 2:16', 'yyyy/mm/dd hh24:mi'), '1003');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Wololo', TO_TIMESTAMP('2022/2/11 13:32', 'yyyy/mm/dd hh24:mi'), '1033');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Why so serious?', TO_TIMESTAMP('2022/2/15 22:48', 'yyyy/mm/dd hh24:mi'), '1117');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Heh?', TO_TIMESTAMP('2022/2/25 0:3', 'yyyy/mm/dd hh24:mi'), '1082');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('I bought it for you', TO_TIMESTAMP('2022/3/1 14:19', 'yyyy/mm/dd hh24:mi'), '1072');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('I''m the king of the world!', TO_TIMESTAMP('2022/1/21 21:29', 'yyyy/mm/dd hh24:mi'), '1044');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('When you realize you want to spend the rest of your life with somebody, you want the rest of your life to start as soon as possible.', TO_TIMESTAMP('2022/3/21 12:41', 'yyyy/mm/dd hh24:mi'), '1009');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Isn''t that against the law?', TO_TIMESTAMP('2022/1/4 14:24', 'yyyy/mm/dd hh24:mi'), '1042');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('What is this site?', TO_TIMESTAMP('2022/1/6 1:45', 'yyyy/mm/dd hh24:mi'), '1092');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Nobody''s perfect', TO_TIMESTAMP('2022/3/15 6:29', 'yyyy/mm/dd hh24:mi'), '1121');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Let me speak, please', TO_TIMESTAMP('2022/2/3 23:19', 'yyyy/mm/dd hh24:mi'), '1059');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Why me?', TO_TIMESTAMP('2022/1/30 7:25', 'yyyy/mm/dd hh24:mi'), '1118');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Carpe diem. Seize the day, boys.', TO_TIMESTAMP('2022/2/18 7:15', 'yyyy/mm/dd hh24:mi'), '1020');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Nobody''s perfect', TO_TIMESTAMP('2022/2/28 11:47', 'yyyy/mm/dd hh24:mi'), '1007');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Houston, we have a problem', TO_TIMESTAMP('2022/1/16 17:48', 'yyyy/mm/dd hh24:mi'), '1132');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Did you break it?', TO_TIMESTAMP('2022/3/14 15:25', 'yyyy/mm/dd hh24:mi'), '1062');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('We''re sleepy', TO_TIMESTAMP('2022/2/2 10:55', 'yyyy/mm/dd hh24:mi'), '1122');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('You talking to me?', TO_TIMESTAMP('2022/2/16 1:56', 'yyyy/mm/dd hh24:mi'), '1071');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('It must be very bad.', TO_TIMESTAMP('2022/3/9 2:44', 'yyyy/mm/dd hh24:mi'), '1027');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('OK! Bring it on!', TO_TIMESTAMP('2022/2/18 14:21', 'yyyy/mm/dd hh24:mi'), '1118');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Why does luck hate you?', TO_TIMESTAMP('2022/1/16 15:58', 'yyyy/mm/dd hh24:mi'), '1087');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('What''s your wife''s name?', TO_TIMESTAMP('2022/2/27 18:0', 'yyyy/mm/dd hh24:mi'), '1126');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('They call it a Royale with cheese.', TO_TIMESTAMP('2022/1/1 20:40', 'yyyy/mm/dd hh24:mi'), '1033');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Why so serious?', TO_TIMESTAMP('2022/1/1 19:6', 'yyyy/mm/dd hh24:mi'), '1054');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('I have some great news', TO_TIMESTAMP('2022/1/21 13:10', 'yyyy/mm/dd hh24:mi'), '1142');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Tell them you lied', TO_TIMESTAMP('2022/3/6 9:33', 'yyyy/mm/dd hh24:mi'), '1065');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('How high is it?', TO_TIMESTAMP('2022/1/19 17:30', 'yyyy/mm/dd hh24:mi'), '1070');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('What''s up?', TO_TIMESTAMP('2022/3/10 0:32', 'yyyy/mm/dd hh24:mi'), '1146');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('I''m still excited', TO_TIMESTAMP('2022/3/2 5:11', 'yyyy/mm/dd hh24:mi'), '1048');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Tell them you lied', TO_TIMESTAMP('2022/2/13 7:38', 'yyyy/mm/dd hh24:mi'), '1077');
INSERT INTO publicpost (text, timestamp, userid) VALUES ('Where''s my horse?', TO_TIMESTAMP('2022/3/12 22:2', 'yyyy/mm/dd hh24:mi'), '1099');

INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I''m still excited', TO_TIMESTAMP('2022/1/20 23:6', 'yyyy/mm/dd hh24:mi'), '1021', '1074');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('What''s your wife''s name?', TO_TIMESTAMP('2022/3/3 22:22', 'yyyy/mm/dd hh24:mi'), '1013', '1022');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Carpe diem. Seize the day, boys.', TO_TIMESTAMP('2022/3/10 22:8', 'yyyy/mm/dd hh24:mi'), '1054', '1119');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Nothing is better than health!', TO_TIMESTAMP('2022/2/11 17:55', 'yyyy/mm/dd hh24:mi'), '1050', '1034');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Today is a beautiful day', TO_TIMESTAMP('2022/2/7 1:1', 'yyyy/mm/dd hh24:mi'), '1020', '1077');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('How are you?', TO_TIMESTAMP('2022/3/13 9:23', 'yyyy/mm/dd hh24:mi'), '1015', '1101');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Do what needs to be done', TO_TIMESTAMP('2022/3/13 9:42', 'yyyy/mm/dd hh24:mi'), '1046', '1074');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Just when I thought I was out, they pull me back in', TO_TIMESTAMP('2022/1/9 13:16', 'yyyy/mm/dd hh24:mi'), '1013', '1093');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I asked them to stop.', TO_TIMESTAMP('2022/1/30 8:53', 'yyyy/mm/dd hh24:mi'), '1067', '1128');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Carpe diem. Seize the day, boys.', TO_TIMESTAMP('2022/2/7 16:33', 'yyyy/mm/dd hh24:mi'), '1063', '1149');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Let''s not tell anybody.', TO_TIMESTAMP('2022/3/17 13:56', 'yyyy/mm/dd hh24:mi'), '1004', '1003');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Nothing is better than health!', TO_TIMESTAMP('2022/1/24 17:45', 'yyyy/mm/dd hh24:mi'), '1019', '1078');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('We must leave right away.', TO_TIMESTAMP('2022/1/7 10:35', 'yyyy/mm/dd hh24:mi'), '1044', '1022');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Heeyy', TO_TIMESTAMP('2022/3/16 11:58', 'yyyy/mm/dd hh24:mi'), '1044', '1047');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('a', TO_TIMESTAMP('2022/3/13 23:45', 'yyyy/mm/dd hh24:mi'), '1017', '1045');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('It made me happy', TO_TIMESTAMP('2022/2/20 20:38', 'yyyy/mm/dd hh24:mi'), '1017', '1104');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('OK! Bring it on!', TO_TIMESTAMP('2022/1/16 4:49', 'yyyy/mm/dd hh24:mi'), '1023', '1049');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('aaaaaaaaaaaaaaa', TO_TIMESTAMP('2022/2/14 13:57', 'yyyy/mm/dd hh24:mi'), '1061', '1017');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('It must be very bad.', TO_TIMESTAMP('2022/2/7 16:1', 'yyyy/mm/dd hh24:mi'), '1017', '1129');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I followed you.', TO_TIMESTAMP('2022/2/27 2:18', 'yyyy/mm/dd hh24:mi'), '1060', '1110');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I followed you.', TO_TIMESTAMP('2022/1/30 17:36', 'yyyy/mm/dd hh24:mi'), '1012', '1070');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Why so serious?', TO_TIMESTAMP('2022/1/24 1:40', 'yyyy/mm/dd hh24:mi'), '1030', '1151');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('They call it a Royale with cheese.', TO_TIMESTAMP('2022/3/7 0:40', 'yyyy/mm/dd hh24:mi'), '1002', '1116');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('We must leave right away.', TO_TIMESTAMP('2022/1/31 5:45', 'yyyy/mm/dd hh24:mi'), '1062', '1068');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('How are you?', TO_TIMESTAMP('2022/2/28 22:57', 'yyyy/mm/dd hh24:mi'), '1071', '1098');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Show me yours!', TO_TIMESTAMP('2022/2/5 9:49', 'yyyy/mm/dd hh24:mi'), '1073', '1077');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Get busy living, or get busy dying.', TO_TIMESTAMP('2022/3/6 17:30', 'yyyy/mm/dd hh24:mi'), '1068', '1034');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Show me what you bought.', TO_TIMESTAMP('2022/2/23 12:58', 'yyyy/mm/dd hh24:mi'), '1008', '1094');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Just keep swimming.', TO_TIMESTAMP('2022/3/22 14:38', 'yyyy/mm/dd hh24:mi'), '1055', '1049');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('What''s your wife''s name?', TO_TIMESTAMP('2022/3/18 16:52', 'yyyy/mm/dd hh24:mi'), '1023', '1079');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('We are grilling sausage.', TO_TIMESTAMP('2022/2/28 7:21', 'yyyy/mm/dd hh24:mi'), '1065', '1145');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Tell them you lied', TO_TIMESTAMP('2022/3/6 18:57', 'yyyy/mm/dd hh24:mi'), '1023', '1143');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Just keep swimming.', TO_TIMESTAMP('2022/1/28 20:1', 'yyyy/mm/dd hh24:mi'), '1013', '1145');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Did you break it?', TO_TIMESTAMP('2022/2/16 10:58', 'yyyy/mm/dd hh24:mi'), '1053', '1021');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Take my glasses', TO_TIMESTAMP('2022/2/6 17:6', 'yyyy/mm/dd hh24:mi'), '1003', '1148');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I''m still excited', TO_TIMESTAMP('2022/1/13 5:5', 'yyyy/mm/dd hh24:mi'), '1048', '1094');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('What is this site?', TO_TIMESTAMP('2022/2/12 17:40', 'yyyy/mm/dd hh24:mi'), '1029', '1105');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I swam in the river', TO_TIMESTAMP('2022/3/15 11:49', 'yyyy/mm/dd hh24:mi'), '1049', '1141');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('How high is it?', TO_TIMESTAMP('2022/1/20 12:37', 'yyyy/mm/dd hh24:mi'), '1005', '1080');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I followed you.', TO_TIMESTAMP('2022/2/20 19:46', 'yyyy/mm/dd hh24:mi'), '1035', '1125');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Carpe diem. Seize the day, boys.', TO_TIMESTAMP('2022/2/24 13:28', 'yyyy/mm/dd hh24:mi'), '1050', '1045');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('We''re sleepy', TO_TIMESTAMP('2022/1/3 6:45', 'yyyy/mm/dd hh24:mi'), '1014', '1148');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('They call it a Royale with cheese.', TO_TIMESTAMP('2022/2/13 18:56', 'yyyy/mm/dd hh24:mi'), '1001', '1038');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('You agreed to it', TO_TIMESTAMP('2022/2/1 15:40', 'yyyy/mm/dd hh24:mi'), '1063', '1076');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Is this working?', TO_TIMESTAMP('2022/3/7 21:35', 'yyyy/mm/dd hh24:mi'), '1074', '1108');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Where''s my horse?', TO_TIMESTAMP('2022/1/23 6:56', 'yyyy/mm/dd hh24:mi'), '1039', '1089');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Hello there!', TO_TIMESTAMP('2022/1/27 3:49', 'yyyy/mm/dd hh24:mi'), '1046', '1087');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I followed you.', TO_TIMESTAMP('2022/2/9 8:43', 'yyyy/mm/dd hh24:mi'), '1033', '1135');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('We are grilling sausage.', TO_TIMESTAMP('2022/1/9 0:54', 'yyyy/mm/dd hh24:mi'), '1029', '1003');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Why am I here?', TO_TIMESTAMP('2022/2/22 20:8', 'yyyy/mm/dd hh24:mi'), '1007', '1150');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Where''s my horse?', TO_TIMESTAMP('2022/1/1 5:58', 'yyyy/mm/dd hh24:mi'), '1031', '1130');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('You don''t speak English', TO_TIMESTAMP('2022/2/18 3:8', 'yyyy/mm/dd hh24:mi'), '1008', '1116');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Just when I thought I was out, they pull me back in', TO_TIMESTAMP('2022/1/2 8:13', 'yyyy/mm/dd hh24:mi'), '1022', '1044');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Heh?', TO_TIMESTAMP('2022/1/11 11:29', 'yyyy/mm/dd hh24:mi'), '1066', '1113');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I followed you.', TO_TIMESTAMP('2022/1/6 2:30', 'yyyy/mm/dd hh24:mi'), '1016', '1098');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('It made me happy', TO_TIMESTAMP('2022/3/17 17:46', 'yyyy/mm/dd hh24:mi'), '1001', '1112');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Just when I thought I was out, they pull me back in', TO_TIMESTAMP('2022/1/11 11:47', 'yyyy/mm/dd hh24:mi'), '1024', '1084');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I followed you.', TO_TIMESTAMP('2022/1/2 6:59', 'yyyy/mm/dd hh24:mi'), '1064', '1056');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Life moves pretty fast. If you don''t stop and look around once in a while, you could miss it.', TO_TIMESTAMP('2022/1/21 19:49', 'yyyy/mm/dd hh24:mi'), '1068', '1120');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Carpe diem. Seize the day, boys.', TO_TIMESTAMP('2022/2/16 1:7', 'yyyy/mm/dd hh24:mi'), '1056', '1033');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('OK! Bring it on!', TO_TIMESTAMP('2022/3/1 22:9', 'yyyy/mm/dd hh24:mi'), '1045', '1010');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('What is this site?', TO_TIMESTAMP('2022/2/9 6:21', 'yyyy/mm/dd hh24:mi'), '1015', '1016');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Did you break it?', TO_TIMESTAMP('2022/2/6 11:43', 'yyyy/mm/dd hh24:mi'), '1050', '1111');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Why so serious?', TO_TIMESTAMP('2022/1/5 8:39', 'yyyy/mm/dd hh24:mi'), '1072', '1027');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I have some great news', TO_TIMESTAMP('2022/2/19 18:46', 'yyyy/mm/dd hh24:mi'), '1066', '1143');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Today is a beautiful day', TO_TIMESTAMP('2022/1/2 8:19', 'yyyy/mm/dd hh24:mi'), '1023', '1102');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('aaaaaaaaaaaaaaa', TO_TIMESTAMP('2022/2/12 6:23', 'yyyy/mm/dd hh24:mi'), '1040', '1083');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I''m having an old friend for dinner', TO_TIMESTAMP('2022/1/18 9:46', 'yyyy/mm/dd hh24:mi'), '1023', '1109');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Wololo', TO_TIMESTAMP('2022/1/10 0:39', 'yyyy/mm/dd hh24:mi'), '1008', '1025');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Go ahead, make my day.', TO_TIMESTAMP('2022/1/6 15:32', 'yyyy/mm/dd hh24:mi'), '1001', '1148');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Where''s my horse?', TO_TIMESTAMP('2022/2/3 3:0', 'yyyy/mm/dd hh24:mi'), '1057', '1075');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Do what needs to be done', TO_TIMESTAMP('2022/1/22 4:23', 'yyyy/mm/dd hh24:mi'), '1052', '1143');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Where''s my horse?', TO_TIMESTAMP('2022/3/20 5:9', 'yyyy/mm/dd hh24:mi'), '1039', '1038');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('It looks like a duck', TO_TIMESTAMP('2022/2/27 15:10', 'yyyy/mm/dd hh24:mi'), '1030', '1031');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Here''s Johnny!', TO_TIMESTAMP('2022/1/9 15:18', 'yyyy/mm/dd hh24:mi'), '1062', '1005');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('It made me happy', TO_TIMESTAMP('2022/2/9 2:17', 'yyyy/mm/dd hh24:mi'), '1007', '1032');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('That''s our train.', TO_TIMESTAMP('2022/1/8 20:59', 'yyyy/mm/dd hh24:mi'), '1021', '1139');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I''m the king of the world!', TO_TIMESTAMP('2022/2/16 5:34', 'yyyy/mm/dd hh24:mi'), '1064', '1056');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I have some great news', TO_TIMESTAMP('2022/2/2 0:38', 'yyyy/mm/dd hh24:mi'), '1008', '1090');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I don''t want to survive. I want to live.', TO_TIMESTAMP('2022/2/10 14:1', 'yyyy/mm/dd hh24:mi'), '1016', '1124');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/2/15 8:43', 'yyyy/mm/dd hh24:mi'), '1048', '1073');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('How high is it?', TO_TIMESTAMP('2022/1/25 6:14', 'yyyy/mm/dd hh24:mi'), '1023', '1142');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I bought it for you', TO_TIMESTAMP('2022/1/7 18:45', 'yyyy/mm/dd hh24:mi'), '1067', '1048');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I''m having an old friend for dinner', TO_TIMESTAMP('2022/2/18 21:29', 'yyyy/mm/dd hh24:mi'), '1012', '1126');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Wololo', TO_TIMESTAMP('2022/3/14 19:12', 'yyyy/mm/dd hh24:mi'), '1040', '1004');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('It looks like a duck', TO_TIMESTAMP('2022/1/30 7:42', 'yyyy/mm/dd hh24:mi'), '1006', '1088');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I don''t want to survive. I want to live.', TO_TIMESTAMP('2022/1/23 17:23', 'yyyy/mm/dd hh24:mi'), '1050', '1012');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I swam in the river', TO_TIMESTAMP('2022/1/20 13:2', 'yyyy/mm/dd hh24:mi'), '1040', '1076');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('a', TO_TIMESTAMP('2022/1/2 11:0', 'yyyy/mm/dd hh24:mi'), '1054', '1064');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Is this working?', TO_TIMESTAMP('2022/1/4 9:32', 'yyyy/mm/dd hh24:mi'), '1074', '1027');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I''m the king of the world!', TO_TIMESTAMP('2022/1/16 4:8', 'yyyy/mm/dd hh24:mi'), '1005', '1145');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('How are you?', TO_TIMESTAMP('2022/3/19 1:44', 'yyyy/mm/dd hh24:mi'), '1065', '1071');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Why does luck hate you?', TO_TIMESTAMP('2022/2/13 4:43', 'yyyy/mm/dd hh24:mi'), '1021', '1040');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('What is this site?', TO_TIMESTAMP('2022/3/15 6:10', 'yyyy/mm/dd hh24:mi'), '1052', '1067');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Why does luck hate you?', TO_TIMESTAMP('2022/2/25 20:53', 'yyyy/mm/dd hh24:mi'), '1027', '1080');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Go ahead, make my day.', TO_TIMESTAMP('2022/2/28 9:44', 'yyyy/mm/dd hh24:mi'), '1067', '1032');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Show me what you bought.', TO_TIMESTAMP('2022/3/13 23:1', 'yyyy/mm/dd hh24:mi'), '1005', '1057');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I asked them to stop.', TO_TIMESTAMP('2022/1/14 7:32', 'yyyy/mm/dd hh24:mi'), '1043', '1058');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Nobody''s perfect', TO_TIMESTAMP('2022/2/2 12:31', 'yyyy/mm/dd hh24:mi'), '1069', '1006');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I''m just one stomach flu away from my goal weight', TO_TIMESTAMP('2022/1/8 12:40', 'yyyy/mm/dd hh24:mi'), '1046', '1015');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('How high is it?', TO_TIMESTAMP('2022/1/20 21:28', 'yyyy/mm/dd hh24:mi'), '1061', '1086');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Let me speak, please', TO_TIMESTAMP('2022/3/18 9:33', 'yyyy/mm/dd hh24:mi'), '1067', '1005');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('How are you?', TO_TIMESTAMP('2022/3/5 17:34', 'yyyy/mm/dd hh24:mi'), '1053', '1135');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('You don''t speak English', TO_TIMESTAMP('2022/1/13 2:30', 'yyyy/mm/dd hh24:mi'), '1067', '1078');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I don''t want to survive. I want to live.', TO_TIMESTAMP('2022/1/20 15:29', 'yyyy/mm/dd hh24:mi'), '1064', '1079');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/2/1 7:13', 'yyyy/mm/dd hh24:mi'), '1015', '1071');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Is this working?', TO_TIMESTAMP('2022/1/13 6:57', 'yyyy/mm/dd hh24:mi'), '1001', '1102');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I''m just one stomach flu away from my goal weight', TO_TIMESTAMP('2022/2/4 1:34', 'yyyy/mm/dd hh24:mi'), '1027', '1131');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Why so serious?', TO_TIMESTAMP('2022/1/2 11:48', 'yyyy/mm/dd hh24:mi'), '1010', '1125');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('You talking to me?', TO_TIMESTAMP('2022/3/11 19:1', 'yyyy/mm/dd hh24:mi'), '1033', '1103');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I bought it for you', TO_TIMESTAMP('2022/2/14 1:23', 'yyyy/mm/dd hh24:mi'), '1062', '1015');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Mama says, ''Stupid is as stupid does.', TO_TIMESTAMP('2022/3/9 12:54', 'yyyy/mm/dd hh24:mi'), '1045', '1049');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Why so serious?', TO_TIMESTAMP('2022/3/22 20:9', 'yyyy/mm/dd hh24:mi'), '1025', '1052');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('What''s your wife''s name?', TO_TIMESTAMP('2022/3/6 21:34', 'yyyy/mm/dd hh24:mi'), '1017', '1079');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I''m having an old friend for dinner', TO_TIMESTAMP('2022/3/5 1:1', 'yyyy/mm/dd hh24:mi'), '1025', '1138');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('How are you?', TO_TIMESTAMP('2022/2/7 8:2', 'yyyy/mm/dd hh24:mi'), '1021', '1016');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('a', TO_TIMESTAMP('2022/2/1 6:46', 'yyyy/mm/dd hh24:mi'), '1056', '1121');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Today is a beautiful day', TO_TIMESTAMP('2022/3/5 22:27', 'yyyy/mm/dd hh24:mi'), '1037', '1076');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('We''re sleepy', TO_TIMESTAMP('2022/2/16 4:42', 'yyyy/mm/dd hh24:mi'), '1061', '1097');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Let us agree to disagree', TO_TIMESTAMP('2022/1/27 13:29', 'yyyy/mm/dd hh24:mi'), '1046', '1091');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Take my glasses', TO_TIMESTAMP('2022/2/4 4:19', 'yyyy/mm/dd hh24:mi'), '1054', '1022');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I''m still excited', TO_TIMESTAMP('2022/1/22 19:38', 'yyyy/mm/dd hh24:mi'), '1025', '1055');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Carpe diem. Seize the day, boys.', TO_TIMESTAMP('2022/2/28 9:52', 'yyyy/mm/dd hh24:mi'), '1030', '1036');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Please put the book on the shelf', TO_TIMESTAMP('2022/3/13 13:3', 'yyyy/mm/dd hh24:mi'), '1006', '1036');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Isn''t that against the law?', TO_TIMESTAMP('2022/2/21 20:47', 'yyyy/mm/dd hh24:mi'), '1032', '1041');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Please put the book on the shelf', TO_TIMESTAMP('2022/2/23 20:33', 'yyyy/mm/dd hh24:mi'), '1049', '1106');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Here''s Johnny!', TO_TIMESTAMP('2022/1/26 14:15', 'yyyy/mm/dd hh24:mi'), '1032', '1151');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Let us agree to disagree', TO_TIMESTAMP('2022/3/12 6:36', 'yyyy/mm/dd hh24:mi'), '1030', '1098');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('You don''t speak English', TO_TIMESTAMP('2022/1/26 8:9', 'yyyy/mm/dd hh24:mi'), '1013', '1002');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('What is this site?', TO_TIMESTAMP('2022/2/22 4:59', 'yyyy/mm/dd hh24:mi'), '1071', '1045');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('We are grilling sausage.', TO_TIMESTAMP('2022/3/15 12:9', 'yyyy/mm/dd hh24:mi'), '1055', '1034');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Wololo', TO_TIMESTAMP('2022/2/14 15:43', 'yyyy/mm/dd hh24:mi'), '1012', '1002');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Is this working?', TO_TIMESTAMP('2022/2/1 0:29', 'yyyy/mm/dd hh24:mi'), '1000', '1071');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('You don''t speak English', TO_TIMESTAMP('2022/1/15 18:38', 'yyyy/mm/dd hh24:mi'), '1042', '1124');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Hello there!', TO_TIMESTAMP('2022/2/11 11:59', 'yyyy/mm/dd hh24:mi'), '1022', '1054');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('There''s no place like home.', TO_TIMESTAMP('2022/2/19 16:18', 'yyyy/mm/dd hh24:mi'), '1026', '1025');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('What? Where?', TO_TIMESTAMP('2022/2/17 8:36', 'yyyy/mm/dd hh24:mi'), '1040', '1102');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('What''s your wife''s name?', TO_TIMESTAMP('2022/2/3 5:44', 'yyyy/mm/dd hh24:mi'), '1068', '1059');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Hello there!', TO_TIMESTAMP('2022/1/31 5:37', 'yyyy/mm/dd hh24:mi'), '1008', '1090');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('How high is it?', TO_TIMESTAMP('2022/2/15 22:42', 'yyyy/mm/dd hh24:mi'), '1048', '1077');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Today is a beautiful day', TO_TIMESTAMP('2022/2/25 8:43', 'yyyy/mm/dd hh24:mi'), '1005', '1058');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('I asked them to stop.', TO_TIMESTAMP('2022/1/31 23:38', 'yyyy/mm/dd hh24:mi'), '1003', '1118');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Tell them you lied', TO_TIMESTAMP('2022/2/25 5:44', 'yyyy/mm/dd hh24:mi'), '1025', '1135');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('a', TO_TIMESTAMP('2022/2/18 15:49', 'yyyy/mm/dd hh24:mi'), '1067', '1124');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Hello there!', TO_TIMESTAMP('2022/1/23 16:19', 'yyyy/mm/dd hh24:mi'), '1000', '1011');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('It must be very bad.', TO_TIMESTAMP('2022/2/27 11:47', 'yyyy/mm/dd hh24:mi'), '1014', '1016');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/2/12 13:45', 'yyyy/mm/dd hh24:mi'), '1047', '1086');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('When you realize you want to spend the rest of your life with somebody, you want the rest of your life to start as soon as possible.', TO_TIMESTAMP('2022/1/8 6:26', 'yyyy/mm/dd hh24:mi'), '1029', '1072');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('Houston, we have a problem', TO_TIMESTAMP('2022/2/6 9:32', 'yyyy/mm/dd hh24:mi'), '1051', '1116');
INSERT INTO publiccomment (content, timestamp, postid, userid) VALUES ('That''s our train.', TO_TIMESTAMP('2022/3/17 5:59', 'yyyy/mm/dd hh24:mi'), '1001', '1136');

INSERT INTO friends (user1, user2) VALUES ('1002', '1003');
INSERT INTO friends (user1, user2) VALUES ('1003', '1004');
INSERT INTO friends (user1, user2) VALUES ('1004', '1005');
INSERT INTO friends (user1, user2) VALUES ('1005', '1006');
INSERT INTO friends (user1, user2) VALUES ('1006', '1007');
INSERT INTO friends (user1, user2) VALUES ('1007', '1008');
INSERT INTO friends (user1, user2) VALUES ('1008', '1009');
INSERT INTO friends (user1, user2) VALUES ('1009', '1010');
INSERT INTO friends (user1, user2) VALUES ('1010', '1011');
INSERT INTO friends (user1, user2) VALUES ('1011', '1012');
INSERT INTO friends (user1, user2) VALUES ('1012', '1013');
INSERT INTO friends (user1, user2) VALUES ('1013', '1014');
INSERT INTO friends (user1, user2) VALUES ('1014', '1015');
INSERT INTO friends (user1, user2) VALUES ('1015', '1016');
INSERT INTO friends (user1, user2) VALUES ('1016', '1017');
INSERT INTO friends (user1, user2) VALUES ('1017', '1018');
INSERT INTO friends (user1, user2) VALUES ('1018', '1019');
INSERT INTO friends (user1, user2) VALUES ('1019', '1020');
INSERT INTO friends (user1, user2) VALUES ('1020', '1021');
INSERT INTO friends (user1, user2) VALUES ('1021', '1022');
INSERT INTO friends (user1, user2) VALUES ('1022', '1023');
INSERT INTO friends (user1, user2) VALUES ('1023', '1024');
INSERT INTO friends (user1, user2) VALUES ('1024', '1025');
INSERT INTO friends (user1, user2) VALUES ('1025', '1026');
INSERT INTO friends (user1, user2) VALUES ('1026', '1027');
INSERT INTO friends (user1, user2) VALUES ('1027', '1028');
INSERT INTO friends (user1, user2) VALUES ('1028', '1029');
INSERT INTO friends (user1, user2) VALUES ('1029', '1030');
INSERT INTO friends (user1, user2) VALUES ('1030', '1031');
INSERT INTO friends (user1, user2) VALUES ('1031', '1032');
INSERT INTO friends (user1, user2) VALUES ('1032', '1033');
INSERT INTO friends (user1, user2) VALUES ('1033', '1034');
INSERT INTO friends (user1, user2) VALUES ('1034', '1035');
INSERT INTO friends (user1, user2) VALUES ('1035', '1036');
INSERT INTO friends (user1, user2) VALUES ('1036', '1037');
INSERT INTO friends (user1, user2) VALUES ('1037', '1038');
INSERT INTO friends (user1, user2) VALUES ('1038', '1039');
INSERT INTO friends (user1, user2) VALUES ('1039', '1040');
INSERT INTO friends (user1, user2) VALUES ('1040', '1041');
INSERT INTO friends (user1, user2) VALUES ('1041', '1042');
INSERT INTO friends (user1, user2) VALUES ('1042', '1043');
INSERT INTO friends (user1, user2) VALUES ('1043', '1044');
INSERT INTO friends (user1, user2) VALUES ('1044', '1045');
INSERT INTO friends (user1, user2) VALUES ('1045', '1046');
INSERT INTO friends (user1, user2) VALUES ('1046', '1047');
INSERT INTO friends (user1, user2) VALUES ('1047', '1048');
INSERT INTO friends (user1, user2) VALUES ('1048', '1049');
INSERT INTO friends (user1, user2) VALUES ('1049', '1050');
INSERT INTO friends (user1, user2) VALUES ('1050', '1051');
INSERT INTO friends (user1, user2) VALUES ('1051', '1052');
INSERT INTO friends (user1, user2) VALUES ('1052', '1053');
INSERT INTO friends (user1, user2) VALUES ('1053', '1054');
INSERT INTO friends (user1, user2) VALUES ('1054', '1055');
INSERT INTO friends (user1, user2) VALUES ('1055', '1056');
INSERT INTO friends (user1, user2) VALUES ('1056', '1057');
INSERT INTO friends (user1, user2) VALUES ('1057', '1058');
INSERT INTO friends (user1, user2) VALUES ('1058', '1059');
INSERT INTO friends (user1, user2) VALUES ('1059', '1060');
INSERT INTO friends (user1, user2) VALUES ('1060', '1061');
INSERT INTO friends (user1, user2) VALUES ('1061', '1062');
INSERT INTO friends (user1, user2) VALUES ('1062', '1063');
INSERT INTO friends (user1, user2) VALUES ('1063', '1064');
INSERT INTO friends (user1, user2) VALUES ('1064', '1065');
INSERT INTO friends (user1, user2) VALUES ('1065', '1066');
INSERT INTO friends (user1, user2) VALUES ('1066', '1067');
INSERT INTO friends (user1, user2) VALUES ('1067', '1068');
INSERT INTO friends (user1, user2) VALUES ('1068', '1069');
INSERT INTO friends (user1, user2) VALUES ('1069', '1070');
INSERT INTO friends (user1, user2) VALUES ('1070', '1071');
INSERT INTO friends (user1, user2) VALUES ('1071', '1072');
INSERT INTO friends (user1, user2) VALUES ('1072', '1073');
INSERT INTO friends (user1, user2) VALUES ('1073', '1074');
INSERT INTO friends (user1, user2) VALUES ('1074', '1075');
INSERT INTO friends (user1, user2) VALUES ('1075', '1076');
INSERT INTO friends (user1, user2) VALUES ('1076', '1077');
INSERT INTO friends (user1, user2) VALUES ('1077', '1078');
INSERT INTO friends (user1, user2) VALUES ('1078', '1079');
INSERT INTO friends (user1, user2) VALUES ('1079', '1080');
INSERT INTO friends (user1, user2) VALUES ('1080', '1081');
INSERT INTO friends (user1, user2) VALUES ('1081', '1082');
INSERT INTO friends (user1, user2) VALUES ('1082', '1083');
INSERT INTO friends (user1, user2) VALUES ('1083', '1084');
INSERT INTO friends (user1, user2) VALUES ('1084', '1085');
INSERT INTO friends (user1, user2) VALUES ('1085', '1086');
INSERT INTO friends (user1, user2) VALUES ('1086', '1087');
INSERT INTO friends (user1, user2) VALUES ('1087', '1088');
INSERT INTO friends (user1, user2) VALUES ('1088', '1089');
INSERT INTO friends (user1, user2) VALUES ('1089', '1090');
INSERT INTO friends (user1, user2) VALUES ('1090', '1091');
INSERT INTO friends (user1, user2) VALUES ('1091', '1092');
INSERT INTO friends (user1, user2) VALUES ('1092', '1093');
INSERT INTO friends (user1, user2) VALUES ('1093', '1094');
INSERT INTO friends (user1, user2) VALUES ('1094', '1095');
INSERT INTO friends (user1, user2) VALUES ('1095', '1096');
INSERT INTO friends (user1, user2) VALUES ('1096', '1097');
INSERT INTO friends (user1, user2) VALUES ('1097', '1098');
INSERT INTO friends (user1, user2) VALUES ('1098', '1099');
INSERT INTO friends (user1, user2) VALUES ('1099', '1100');
INSERT INTO friends (user1, user2) VALUES ('1100', '1101');
INSERT INTO friends (user1, user2) VALUES ('1101', '1102');
INSERT INTO friends (user1, user2) VALUES ('1102', '1103');
INSERT INTO friends (user1, user2) VALUES ('1103', '1104');
INSERT INTO friends (user1, user2) VALUES ('1104', '1105');
INSERT INTO friends (user1, user2) VALUES ('1105', '1106');
INSERT INTO friends (user1, user2) VALUES ('1106', '1107');
INSERT INTO friends (user1, user2) VALUES ('1107', '1108');
INSERT INTO friends (user1, user2) VALUES ('1108', '1109');
INSERT INTO friends (user1, user2) VALUES ('1109', '1110');
INSERT INTO friends (user1, user2) VALUES ('1110', '1111');
INSERT INTO friends (user1, user2) VALUES ('1111', '1112');
INSERT INTO friends (user1, user2) VALUES ('1112', '1113');
INSERT INTO friends (user1, user2) VALUES ('1113', '1114');
INSERT INTO friends (user1, user2) VALUES ('1114', '1115');
INSERT INTO friends (user1, user2) VALUES ('1115', '1116');
INSERT INTO friends (user1, user2) VALUES ('1116', '1117');
INSERT INTO friends (user1, user2) VALUES ('1117', '1118');
INSERT INTO friends (user1, user2) VALUES ('1118', '1119');
INSERT INTO friends (user1, user2) VALUES ('1119', '1120');
INSERT INTO friends (user1, user2) VALUES ('1120', '1121');
INSERT INTO friends (user1, user2) VALUES ('1121', '1122');
INSERT INTO friends (user1, user2) VALUES ('1122', '1123');
INSERT INTO friends (user1, user2) VALUES ('1123', '1124');
INSERT INTO friends (user1, user2) VALUES ('1124', '1125');
INSERT INTO friends (user1, user2) VALUES ('1125', '1126');
INSERT INTO friends (user1, user2) VALUES ('1126', '1127');
INSERT INTO friends (user1, user2) VALUES ('1127', '1128');
INSERT INTO friends (user1, user2) VALUES ('1128', '1129');
INSERT INTO friends (user1, user2) VALUES ('1129', '1130');
INSERT INTO friends (user1, user2) VALUES ('1130', '1131');
INSERT INTO friends (user1, user2) VALUES ('1131', '1132');
INSERT INTO friends (user1, user2) VALUES ('1132', '1133');
INSERT INTO friends (user1, user2) VALUES ('1133', '1134');
INSERT INTO friends (user1, user2) VALUES ('1134', '1135');
INSERT INTO friends (user1, user2) VALUES ('1135', '1136');
INSERT INTO friends (user1, user2) VALUES ('1136', '1137');
INSERT INTO friends (user1, user2) VALUES ('1137', '1138');
INSERT INTO friends (user1, user2) VALUES ('1138', '1139');
INSERT INTO friends (user1, user2) VALUES ('1139', '1140');
INSERT INTO friends (user1, user2) VALUES ('1140', '1141');
INSERT INTO friends (user1, user2) VALUES ('1141', '1142');
INSERT INTO friends (user1, user2) VALUES ('1142', '1143');
INSERT INTO friends (user1, user2) VALUES ('1143', '1144');
INSERT INTO friends (user1, user2) VALUES ('1144', '1145');
INSERT INTO friends (user1, user2) VALUES ('1145', '1146');
INSERT INTO friends (user1, user2) VALUES ('1146', '1147');
INSERT INTO friends (user1, user2) VALUES ('1147', '1148');
INSERT INTO friends (user1, user2) VALUES ('1148', '1149');
INSERT INTO friends (user1, user2) VALUES ('1149', '1150');
INSERT INTO friends (user1, user2) VALUES ('1150', '1151');
INSERT INTO friends (user1, user2) VALUES ('1151', '1002');

INSERT INTO friendrequest (user1, user2, approved) VALUES ('1002', '1004', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1003', '1005', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1004', '1006', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1005', '1007', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1006', '1008', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1007', '1009', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1008', '1010', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1009', '1011', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1010', '1012', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1011', '1013', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1012', '1014', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1013', '1015', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1014', '1016', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1015', '1017', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1016', '1018', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1017', '1019', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1018', '1020', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1019', '1021', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1020', '1022', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1021', '1023', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1022', '1024', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1023', '1025', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1024', '1026', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1025', '1027', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1026', '1028', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1027', '1029', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1028', '1030', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1029', '1031', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1030', '1032', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1031', '1033', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1032', '1034', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1033', '1035', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1034', '1036', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1035', '1037', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1036', '1038', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1037', '1039', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1038', '1040', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1039', '1041', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1040', '1042', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1041', '1043', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1042', '1044', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1043', '1045', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1044', '1046', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1045', '1047', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1046', '1048', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1047', '1049', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1048', '1050', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1049', '1051', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1050', '1052', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1051', '1053', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1052', '1054', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1053', '1055', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1054', '1056', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1055', '1057', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1056', '1058', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1057', '1059', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1058', '1060', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1059', '1061', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1060', '1062', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1061', '1063', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1062', '1064', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1063', '1065', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1064', '1066', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1065', '1067', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1066', '1068', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1067', '1069', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1068', '1070', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1069', '1071', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1070', '1072', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1071', '1073', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1072', '1074', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1073', '1075', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1074', '1076', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1075', '1077', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1076', '1078', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1077', '1079', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1078', '1080', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1079', '1081', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1080', '1082', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1081', '1083', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1082', '1084', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1083', '1085', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1084', '1086', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1085', '1087', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1086', '1088', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1087', '1089', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1088', '1090', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1089', '1091', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1090', '1092', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1091', '1093', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1092', '1094', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1093', '1095', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1094', '1096', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1095', '1097', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1096', '1098', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1097', '1099', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1098', '1100', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1099', '1101', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1100', '1102', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1101', '1103', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1102', '1104', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1103', '1105', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1104', '1106', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1105', '1107', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1106', '1108', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1107', '1109', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1108', '1110', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1109', '1111', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1110', '1112', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1111', '1113', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1112', '1114', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1113', '1115', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1114', '1116', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1115', '1117', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1116', '1118', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1117', '1119', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1118', '1120', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1119', '1121', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1120', '1122', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1121', '1123', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1122', '1124', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1123', '1125', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1124', '1126', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1125', '1127', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1126', '1128', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1127', '1129', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1128', '1130', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1129', '1131', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1130', '1132', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1131', '1133', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1132', '1134', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1133', '1135', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1134', '1136', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1135', '1137', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1136', '1138', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1137', '1139', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1138', '1140', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1139', '1141', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1140', '1142', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1141', '1143', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1142', '1144', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1143', '1145', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1144', '1146', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1145', '1147', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1146', '1148', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1147', '1149', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1148', '1150', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1149', '1151', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1150', '1002', '0');
INSERT INTO friendrequest (user1, user2, approved) VALUES ('1151', '1003', '0');

INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('When you realize you want to spend the rest of your life with somebody, you want the rest of your life to start as soon as possible.', TO_TIMESTAMP('2022/1/21 19:34', 'yyyy/mm/dd hh24:mi'), '1002', '1003');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Get busy living, or get busy dying.', TO_TIMESTAMP('2022/2/19 19:15', 'yyyy/mm/dd hh24:mi'), '1003', '1004');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('There''s no place like home.', TO_TIMESTAMP('2022/1/29 19:21', 'yyyy/mm/dd hh24:mi'), '1004', '1005');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Well, that''s it', TO_TIMESTAMP('2022/3/12 9:23', 'yyyy/mm/dd hh24:mi'), '1005', '1006');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Where''s my horse?', TO_TIMESTAMP('2022/1/18 16:25', 'yyyy/mm/dd hh24:mi'), '1006', '1007');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/1/19 6:11', 'yyyy/mm/dd hh24:mi'), '1007', '1008');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/2/19 22:27', 'yyyy/mm/dd hh24:mi'), '1008', '1009');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('They call it a Royale with cheese.', TO_TIMESTAMP('2022/2/20 6:22', 'yyyy/mm/dd hh24:mi'), '1009', '1010');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/2/2 10:34', 'yyyy/mm/dd hh24:mi'), '1010', '1011');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I''m just one stomach flu away from my goal weight', TO_TIMESTAMP('2022/3/17 10:8', 'yyyy/mm/dd hh24:mi'), '1011', '1012');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Why does luck hate you?', TO_TIMESTAMP('2022/2/26 5:58', 'yyyy/mm/dd hh24:mi'), '1012', '1013');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Show me yours!', TO_TIMESTAMP('2022/1/10 11:0', 'yyyy/mm/dd hh24:mi'), '1013', '1014');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Heeyy', TO_TIMESTAMP('2022/2/8 15:4', 'yyyy/mm/dd hh24:mi'), '1014', '1015');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Let me speak, please', TO_TIMESTAMP('2022/2/15 15:45', 'yyyy/mm/dd hh24:mi'), '1015', '1016');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('You don''t speak English', TO_TIMESTAMP('2022/3/22 1:42', 'yyyy/mm/dd hh24:mi'), '1016', '1017');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Let''s not tell anybody.', TO_TIMESTAMP('2022/1/14 17:48', 'yyyy/mm/dd hh24:mi'), '1017', '1018');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('What? Where?', TO_TIMESTAMP('2022/1/3 8:13', 'yyyy/mm/dd hh24:mi'), '1018', '1019');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Is this working?', TO_TIMESTAMP('2022/3/7 12:52', 'yyyy/mm/dd hh24:mi'), '1019', '1020');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Just keep swimming.', TO_TIMESTAMP('2022/1/9 5:49', 'yyyy/mm/dd hh24:mi'), '1020', '1021');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Heeyy', TO_TIMESTAMP('2022/2/23 10:44', 'yyyy/mm/dd hh24:mi'), '1021', '1022');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('What''s up?', TO_TIMESTAMP('2022/1/18 3:6', 'yyyy/mm/dd hh24:mi'), '1022', '1023');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Let us agree to disagree', TO_TIMESTAMP('2022/1/28 18:51', 'yyyy/mm/dd hh24:mi'), '1023', '1024');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Why am I here?', TO_TIMESTAMP('2022/2/3 15:57', 'yyyy/mm/dd hh24:mi'), '1024', '1025');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I don''t want to survive. I want to live.', TO_TIMESTAMP('2022/2/21 21:44', 'yyyy/mm/dd hh24:mi'), '1025', '1026');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Here''s Johnny!', TO_TIMESTAMP('2022/1/15 19:51', 'yyyy/mm/dd hh24:mi'), '1026', '1027');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('That''s our train.', TO_TIMESTAMP('2022/2/26 4:15', 'yyyy/mm/dd hh24:mi'), '1027', '1028');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Here''s Johnny!', TO_TIMESTAMP('2022/1/30 6:25', 'yyyy/mm/dd hh24:mi'), '1028', '1029');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('<insert random text here>', TO_TIMESTAMP('2022/2/13 0:49', 'yyyy/mm/dd hh24:mi'), '1029', '1030');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Get busy living, or get busy dying.', TO_TIMESTAMP('2022/3/18 7:19', 'yyyy/mm/dd hh24:mi'), '1030', '1031');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I''m the king of the world!', TO_TIMESTAMP('2022/1/25 7:27', 'yyyy/mm/dd hh24:mi'), '1031', '1032');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Tell them you lied', TO_TIMESTAMP('2022/3/21 8:15', 'yyyy/mm/dd hh24:mi'), '1032', '1033');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('a', TO_TIMESTAMP('2022/2/12 13:57', 'yyyy/mm/dd hh24:mi'), '1033', '1034');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Hello there!', TO_TIMESTAMP('2022/1/29 19:46', 'yyyy/mm/dd hh24:mi'), '1034', '1035');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('There''s no place like home.', TO_TIMESTAMP('2022/3/2 18:58', 'yyyy/mm/dd hh24:mi'), '1035', '1036');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('We must leave right away.', TO_TIMESTAMP('2022/2/15 4:52', 'yyyy/mm/dd hh24:mi'), '1036', '1037');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/2/21 1:42', 'yyyy/mm/dd hh24:mi'), '1037', '1038');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Nothing is better than health!', TO_TIMESTAMP('2022/3/14 17:45', 'yyyy/mm/dd hh24:mi'), '1038', '1039');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Do what needs to be done', TO_TIMESTAMP('2022/1/5 15:54', 'yyyy/mm/dd hh24:mi'), '1039', '1040');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('We must leave right away.', TO_TIMESTAMP('2022/3/3 0:13', 'yyyy/mm/dd hh24:mi'), '1040', '1041');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('You don''t speak English', TO_TIMESTAMP('2022/3/9 13:54', 'yyyy/mm/dd hh24:mi'), '1041', '1042');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Today is a beautiful day', TO_TIMESTAMP('2022/1/28 17:9', 'yyyy/mm/dd hh24:mi'), '1042', '1043');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('It must be very bad.', TO_TIMESTAMP('2022/1/15 13:7', 'yyyy/mm/dd hh24:mi'), '1043', '1044');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('When you realize you want to spend the rest of your life with somebody, you want the rest of your life to start as soon as possible.', TO_TIMESTAMP('2022/1/24 17:2', 'yyyy/mm/dd hh24:mi'), '1044', '1045');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('We''re sleepy', TO_TIMESTAMP('2022/2/22 12:5', 'yyyy/mm/dd hh24:mi'), '1045', '1046');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Tell them you lied', TO_TIMESTAMP('2022/2/22 20:20', 'yyyy/mm/dd hh24:mi'), '1046', '1047');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Why me?', TO_TIMESTAMP('2022/1/23 21:52', 'yyyy/mm/dd hh24:mi'), '1047', '1048');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Heh?', TO_TIMESTAMP('2022/3/21 4:15', 'yyyy/mm/dd hh24:mi'), '1048', '1049');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Houston, we have a problem', TO_TIMESTAMP('2022/1/24 15:46', 'yyyy/mm/dd hh24:mi'), '1049', '1050');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Im bored...', TO_TIMESTAMP('2022/2/26 20:41', 'yyyy/mm/dd hh24:mi'), '1050', '1051');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('They call it a Royale with cheese.', TO_TIMESTAMP('2022/1/7 14:51', 'yyyy/mm/dd hh24:mi'), '1051', '1052');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Boiler for sale!', TO_TIMESTAMP('2022/3/1 5:13', 'yyyy/mm/dd hh24:mi'), '1052', '1053');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Today is a beautiful day', TO_TIMESTAMP('2022/1/27 12:7', 'yyyy/mm/dd hh24:mi'), '1053', '1054');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Houston, we have a problem', TO_TIMESTAMP('2022/2/13 6:53', 'yyyy/mm/dd hh24:mi'), '1054', '1055');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/2/25 20:53', 'yyyy/mm/dd hh24:mi'), '1055', '1056');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Here''s Johnny!', TO_TIMESTAMP('2022/2/1 23:37', 'yyyy/mm/dd hh24:mi'), '1056', '1057');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Isn''t that against the law?', TO_TIMESTAMP('2022/2/7 4:37', 'yyyy/mm/dd hh24:mi'), '1057', '1058');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I''m still excited', TO_TIMESTAMP('2022/3/21 15:20', 'yyyy/mm/dd hh24:mi'), '1058', '1059');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Take my glasses', TO_TIMESTAMP('2022/2/5 3:55', 'yyyy/mm/dd hh24:mi'), '1059', '1060');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I asked them to stop.', TO_TIMESTAMP('2022/3/4 5:17', 'yyyy/mm/dd hh24:mi'), '1060', '1061');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Let us agree to disagree', TO_TIMESTAMP('2022/2/4 21:59', 'yyyy/mm/dd hh24:mi'), '1061', '1062');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Today is a beautiful day', TO_TIMESTAMP('2022/1/18 7:44', 'yyyy/mm/dd hh24:mi'), '1062', '1063');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I followed you.', TO_TIMESTAMP('2022/2/27 10:48', 'yyyy/mm/dd hh24:mi'), '1063', '1064');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I bought it for you', TO_TIMESTAMP('2022/2/24 12:59', 'yyyy/mm/dd hh24:mi'), '1064', '1065');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('You talking to me?', TO_TIMESTAMP('2022/2/25 4:7', 'yyyy/mm/dd hh24:mi'), '1065', '1066');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Heh?', TO_TIMESTAMP('2022/1/17 19:8', 'yyyy/mm/dd hh24:mi'), '1066', '1067');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/2/19 19:6', 'yyyy/mm/dd hh24:mi'), '1067', '1068');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I asked them to stop.', TO_TIMESTAMP('2022/3/13 4:40', 'yyyy/mm/dd hh24:mi'), '1068', '1069');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('That''s our train.', TO_TIMESTAMP('2022/2/3 11:18', 'yyyy/mm/dd hh24:mi'), '1069', '1070');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('They call it a Royale with cheese.', TO_TIMESTAMP('2022/2/12 5:45', 'yyyy/mm/dd hh24:mi'), '1070', '1071');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('It made me happy', TO_TIMESTAMP('2022/1/9 16:51', 'yyyy/mm/dd hh24:mi'), '1071', '1072');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Here''s Johnny!', TO_TIMESTAMP('2022/1/29 1:18', 'yyyy/mm/dd hh24:mi'), '1072', '1073');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I''m the king of the world!', TO_TIMESTAMP('2022/1/18 1:36', 'yyyy/mm/dd hh24:mi'), '1073', '1074');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('When you realize you want to spend the rest of your life with somebody, you want the rest of your life to start as soon as possible.', TO_TIMESTAMP('2022/2/12 11:20', 'yyyy/mm/dd hh24:mi'), '1074', '1075');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('They call it a Royale with cheese.', TO_TIMESTAMP('2022/1/18 4:18', 'yyyy/mm/dd hh24:mi'), '1075', '1076');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('OK! Bring it on!', TO_TIMESTAMP('2022/2/18 20:40', 'yyyy/mm/dd hh24:mi'), '1076', '1077');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('You agreed to it', TO_TIMESTAMP('2022/2/7 19:54', 'yyyy/mm/dd hh24:mi'), '1077', '1078');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/1/6 7:7', 'yyyy/mm/dd hh24:mi'), '1078', '1079');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('What''s your wife''s name?', TO_TIMESTAMP('2022/2/5 19:50', 'yyyy/mm/dd hh24:mi'), '1079', '1080');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('You agreed to it', TO_TIMESTAMP('2022/3/9 18:14', 'yyyy/mm/dd hh24:mi'), '1080', '1081');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Do what needs to be done', TO_TIMESTAMP('2022/1/20 5:29', 'yyyy/mm/dd hh24:mi'), '1081', '1082');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('You don''t speak English', TO_TIMESTAMP('2022/1/28 14:23', 'yyyy/mm/dd hh24:mi'), '1082', '1083');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Hello!', TO_TIMESTAMP('2022/2/21 0:24', 'yyyy/mm/dd hh24:mi'), '1083', '1084');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Why am I here?', TO_TIMESTAMP('2022/3/14 3:28', 'yyyy/mm/dd hh24:mi'), '1084', '1085');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Get busy living, or get busy dying.', TO_TIMESTAMP('2022/1/14 20:59', 'yyyy/mm/dd hh24:mi'), '1085', '1086');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('What? Where?', TO_TIMESTAMP('2022/1/18 17:41', 'yyyy/mm/dd hh24:mi'), '1086', '1087');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Im bored...', TO_TIMESTAMP('2022/2/27 11:1', 'yyyy/mm/dd hh24:mi'), '1087', '1088');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('What is this site?', TO_TIMESTAMP('2022/2/4 5:47', 'yyyy/mm/dd hh24:mi'), '1088', '1089');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Wololo', TO_TIMESTAMP('2022/2/26 9:29', 'yyyy/mm/dd hh24:mi'), '1089', '1090');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Heh?', TO_TIMESTAMP('2022/2/4 6:3', 'yyyy/mm/dd hh24:mi'), '1090', '1091');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Go ahead, make my day.', TO_TIMESTAMP('2022/3/4 6:5', 'yyyy/mm/dd hh24:mi'), '1091', '1092');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Hello there!', TO_TIMESTAMP('2022/1/20 13:27', 'yyyy/mm/dd hh24:mi'), '1092', '1093');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Is this working?', TO_TIMESTAMP('2022/1/17 12:43', 'yyyy/mm/dd hh24:mi'), '1093', '1094');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Why am I here?', TO_TIMESTAMP('2022/3/5 8:21', 'yyyy/mm/dd hh24:mi'), '1094', '1095');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('There''s no place like home.', TO_TIMESTAMP('2022/1/3 17:30', 'yyyy/mm/dd hh24:mi'), '1095', '1096');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('It looks like a duck', TO_TIMESTAMP('2022/2/21 19:9', 'yyyy/mm/dd hh24:mi'), '1096', '1097');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('It looks like a duck', TO_TIMESTAMP('2022/1/25 16:52', 'yyyy/mm/dd hh24:mi'), '1097', '1098');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('How high is it?', TO_TIMESTAMP('2022/2/16 16:28', 'yyyy/mm/dd hh24:mi'), '1098', '1099');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Mama says, ''Stupid is as stupid does.', TO_TIMESTAMP('2022/1/31 20:54', 'yyyy/mm/dd hh24:mi'), '1099', '1100');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/1/9 23:47', 'yyyy/mm/dd hh24:mi'), '1100', '1101');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Heh?', TO_TIMESTAMP('2022/1/29 2:43', 'yyyy/mm/dd hh24:mi'), '1101', '1102');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('OK! Bring it on!', TO_TIMESTAMP('2022/3/6 17:14', 'yyyy/mm/dd hh24:mi'), '1102', '1103');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Life moves pretty fast. If you don''t stop and look around once in a while, you could miss it.', TO_TIMESTAMP('2022/2/24 3:20', 'yyyy/mm/dd hh24:mi'), '1103', '1104');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Wololo', TO_TIMESTAMP('2022/3/18 7:18', 'yyyy/mm/dd hh24:mi'), '1104', '1105');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Hello!', TO_TIMESTAMP('2022/1/6 13:56', 'yyyy/mm/dd hh24:mi'), '1105', '1106');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Did you break it?', TO_TIMESTAMP('2022/2/23 16:43', 'yyyy/mm/dd hh24:mi'), '1106', '1107');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Do what needs to be done', TO_TIMESTAMP('2022/2/10 5:4', 'yyyy/mm/dd hh24:mi'), '1107', '1108');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('aaaaaaaaaaaaaaa', TO_TIMESTAMP('2022/2/24 12:54', 'yyyy/mm/dd hh24:mi'), '1108', '1109');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Hello there!', TO_TIMESTAMP('2022/1/7 23:2', 'yyyy/mm/dd hh24:mi'), '1109', '1110');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Just when I thought I was out, they pull me back in', TO_TIMESTAMP('2022/3/17 9:45', 'yyyy/mm/dd hh24:mi'), '1110', '1111');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('They call it a Royale with cheese.', TO_TIMESTAMP('2022/1/11 14:15', 'yyyy/mm/dd hh24:mi'), '1111', '1112');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Show me yours!', TO_TIMESTAMP('2022/1/15 0:40', 'yyyy/mm/dd hh24:mi'), '1112', '1113');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('OK! Bring it on!', TO_TIMESTAMP('2022/3/14 6:35', 'yyyy/mm/dd hh24:mi'), '1113', '1114');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('That''s our train.', TO_TIMESTAMP('2022/3/2 23:52', 'yyyy/mm/dd hh24:mi'), '1114', '1115');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Nobody''s perfect', TO_TIMESTAMP('2022/1/12 20:47', 'yyyy/mm/dd hh24:mi'), '1115', '1116');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Houston, we have a problem', TO_TIMESTAMP('2022/2/14 3:58', 'yyyy/mm/dd hh24:mi'), '1116', '1117');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Here''s Johnny!', TO_TIMESTAMP('2022/2/23 5:57', 'yyyy/mm/dd hh24:mi'), '1117', '1118');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('We must leave right away.', TO_TIMESTAMP('2022/1/26 8:5', 'yyyy/mm/dd hh24:mi'), '1118', '1119');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Just keep swimming.', TO_TIMESTAMP('2022/2/1 15:4', 'yyyy/mm/dd hh24:mi'), '1119', '1120');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I''m still excited', TO_TIMESTAMP('2022/2/25 13:18', 'yyyy/mm/dd hh24:mi'), '1120', '1121');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I swam in the river', TO_TIMESTAMP('2022/1/24 15:47', 'yyyy/mm/dd hh24:mi'), '1121', '1122');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Just when I thought I was out, they pull me back in', TO_TIMESTAMP('2022/1/17 23:55', 'yyyy/mm/dd hh24:mi'), '1122', '1123');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Just keep swimming.', TO_TIMESTAMP('2022/3/10 4:4', 'yyyy/mm/dd hh24:mi'), '1123', '1124');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Just keep swimming.', TO_TIMESTAMP('2022/3/10 20:20', 'yyyy/mm/dd hh24:mi'), '1124', '1125');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Hello!', TO_TIMESTAMP('2022/1/26 6:49', 'yyyy/mm/dd hh24:mi'), '1125', '1126');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('When you realize you want to spend the rest of your life with somebody, you want the rest of your life to start as soon as possible.', TO_TIMESTAMP('2022/1/4 3:14', 'yyyy/mm/dd hh24:mi'), '1126', '1127');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Tell them you lied', TO_TIMESTAMP('2022/2/28 1:24', 'yyyy/mm/dd hh24:mi'), '1127', '1128');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Life moves pretty fast. If you don''t stop and look around once in a while, you could miss it.', TO_TIMESTAMP('2022/1/6 12:51', 'yyyy/mm/dd hh24:mi'), '1128', '1129');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('What is this site?', TO_TIMESTAMP('2022/3/18 7:21', 'yyyy/mm/dd hh24:mi'), '1129', '1130');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Boiler for sale!', TO_TIMESTAMP('2022/1/5 14:59', 'yyyy/mm/dd hh24:mi'), '1130', '1131');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I followed you.', TO_TIMESTAMP('2022/2/13 14:35', 'yyyy/mm/dd hh24:mi'), '1131', '1132');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('When you realize you want to spend the rest of your life with somebody, you want the rest of your life to start as soon as possible.', TO_TIMESTAMP('2022/2/25 4:17', 'yyyy/mm/dd hh24:mi'), '1132', '1133');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('What? Where?', TO_TIMESTAMP('2022/1/13 16:30', 'yyyy/mm/dd hh24:mi'), '1133', '1134');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('a', TO_TIMESTAMP('2022/3/16 10:21', 'yyyy/mm/dd hh24:mi'), '1134', '1135');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('You talking to me?', TO_TIMESTAMP('2022/1/19 17:48', 'yyyy/mm/dd hh24:mi'), '1135', '1136');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('<insert random text here>', TO_TIMESTAMP('2022/2/7 18:38', 'yyyy/mm/dd hh24:mi'), '1136', '1137');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/1/7 13:20', 'yyyy/mm/dd hh24:mi'), '1137', '1138');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('That''s our train.', TO_TIMESTAMP('2022/3/10 8:23', 'yyyy/mm/dd hh24:mi'), '1138', '1139');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Heh?', TO_TIMESTAMP('2022/2/3 2:44', 'yyyy/mm/dd hh24:mi'), '1139', '1140');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('What is this site?', TO_TIMESTAMP('2022/1/9 18:37', 'yyyy/mm/dd hh24:mi'), '1140', '1141');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Why does luck hate you?', TO_TIMESTAMP('2022/3/20 10:7', 'yyyy/mm/dd hh24:mi'), '1141', '1142');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Houston, we have a problem', TO_TIMESTAMP('2022/2/16 4:31', 'yyyy/mm/dd hh24:mi'), '1142', '1143');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/1/14 0:41', 'yyyy/mm/dd hh24:mi'), '1143', '1144');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Take my glasses', TO_TIMESTAMP('2022/2/6 15:12', 'yyyy/mm/dd hh24:mi'), '1144', '1145');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Hello there!', TO_TIMESTAMP('2022/1/22 10:21', 'yyyy/mm/dd hh24:mi'), '1145', '1146');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('Nobody''s perfect', TO_TIMESTAMP('2022/1/13 12:53', 'yyyy/mm/dd hh24:mi'), '1146', '1147');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I''m having an old friend for dinner', TO_TIMESTAMP('2022/1/2 1:13', 'yyyy/mm/dd hh24:mi'), '1147', '1148');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('How are you?', TO_TIMESTAMP('2022/3/17 5:4', 'yyyy/mm/dd hh24:mi'), '1148', '1149');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I''m the king of the world!', TO_TIMESTAMP('2022/1/9 17:12', 'yyyy/mm/dd hh24:mi'), '1149', '1150');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I asked them to stop.', TO_TIMESTAMP('2022/2/2 11:11', 'yyyy/mm/dd hh24:mi'), '1150', '1151');
INSERT INTO privatemessage (content, timestamp, touser, fromuser) VALUES ('I''m having an old friend for dinner', TO_TIMESTAMP('2022/3/16 16:4', 'yyyy/mm/dd hh24:mi'), '1151', '1002');

INSERT INTO "Group" (name, ownerid) VALUES ('Ruthless Giraffes', '1095');
INSERT INTO groupmembers (userid, groupid) VALUES ('1095', '1000');
INSERT INTO groupmembers (userid, groupid) VALUES ('1027', '1000');
INSERT INTO groupmembers (userid, groupid) VALUES ('1114', '1000');
INSERT INTO groupmembers (userid, groupid) VALUES ('1082', '1000');
INSERT INTO groupmembers (userid, groupid) VALUES ('1072', '1000');
INSERT INTO groupmembers (userid, groupid) VALUES ('1028', '1000');
INSERT INTO groupmembers (userid, groupid) VALUES ('1112', '1000');
INSERT INTO groupmembers (userid, groupid) VALUES ('1108', '1000');
INSERT INTO groupmembers (userid, groupid) VALUES ('1046', '1000');
INSERT INTO groupmembers (userid, groupid) VALUES ('1123', '1000');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Mama says, ''Stupid is as stupid does.', TO_TIMESTAMP('2022/1/10 1:17', 'yyyy/mm/dd hh24:mi'), '1000', '1072');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Well, that''s it', TO_TIMESTAMP('2022/1/30 3:41', 'yyyy/mm/dd hh24:mi'), '1000', '1123');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Isn''t that against the law?', TO_TIMESTAMP('2022/2/16 16:23', 'yyyy/mm/dd hh24:mi'), '1000', '1112');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('That''s our train.', TO_TIMESTAMP('2022/1/6 23:4', 'yyyy/mm/dd hh24:mi'), '1000', '1114');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/2/19 19:57', 'yyyy/mm/dd hh24:mi'), '1002', '1108');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('It looks like a duck', TO_TIMESTAMP('2022/1/5 9:15', 'yyyy/mm/dd hh24:mi'), '1003', '1072');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Just when I thought I was out, they pull me back in', TO_TIMESTAMP('2022/1/10 12:25', 'yyyy/mm/dd hh24:mi'), '1000', '1095');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Well, that''s it', TO_TIMESTAMP('2022/3/5 23:55', 'yyyy/mm/dd hh24:mi'), '1002', '1046');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Carpe diem. Seize the day, boys.', TO_TIMESTAMP('2022/1/16 0:43', 'yyyy/mm/dd hh24:mi'), '1001', '1082');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('When you realize you want to spend the rest of your life with somebody, you want the rest of your life to start as soon as possible.', TO_TIMESTAMP('2022/2/1 12:57', 'yyyy/mm/dd hh24:mi'), '1002', '1112');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('a', TO_TIMESTAMP('2022/2/27 23:35', 'yyyy/mm/dd hh24:mi'), '1000', '1072');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('a', TO_TIMESTAMP('2022/1/13 22:2', 'yyyy/mm/dd hh24:mi'), '1002', '1072');

INSERT INTO "Group" (name, ownerid) VALUES ('Ireland Owls', '1002');
INSERT INTO groupmembers (userid, groupid) VALUES ('1002', '1001');
INSERT INTO groupmembers (userid, groupid) VALUES ('1144', '1001');
INSERT INTO groupmembers (userid, groupid) VALUES ('1107', '1001');
INSERT INTO groupmembers (userid, groupid) VALUES ('1151', '1001');
INSERT INTO groupmembers (userid, groupid) VALUES ('1090', '1001');
INSERT INTO groupmembers (userid, groupid) VALUES ('1113', '1001');
INSERT INTO groupmembers (userid, groupid) VALUES ('1092', '1001');
INSERT INTO groupmembers (userid, groupid) VALUES ('1020', '1001');
INSERT INTO groupmembers (userid, groupid) VALUES ('1062', '1001');
INSERT INTO groupmembers (userid, groupid) VALUES ('1066', '1001');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Mama says, ''Stupid is as stupid does.', TO_TIMESTAMP('2022/1/2 2:26', 'yyyy/mm/dd hh24:mi'), '1001', '1066');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('We''re sleepy', TO_TIMESTAMP('2022/3/18 0:45', 'yyyy/mm/dd hh24:mi'), '1001', '1113');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Well, that''s it', TO_TIMESTAMP('2022/1/27 7:32', 'yyyy/mm/dd hh24:mi'), '1001', '1151');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Why does luck hate you?', TO_TIMESTAMP('2022/2/4 18:41', 'yyyy/mm/dd hh24:mi'), '1001', '1092');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Why so serious?', TO_TIMESTAMP('2022/1/23 22:42', 'yyyy/mm/dd hh24:mi'), '1007', '1092');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Why am I here?', TO_TIMESTAMP('2022/2/14 12:20', 'yyyy/mm/dd hh24:mi'), '1007', '1002');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Here''s Johnny!', TO_TIMESTAMP('2022/1/7 5:31', 'yyyy/mm/dd hh24:mi'), '1007', '1144');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Get busy living, or get busy dying.', TO_TIMESTAMP('2022/1/5 21:23', 'yyyy/mm/dd hh24:mi'), '1007', '1090');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Today is a beautiful day', TO_TIMESTAMP('2022/1/16 5:4', 'yyyy/mm/dd hh24:mi'), '1004', '1066');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Did you break it?', TO_TIMESTAMP('2022/2/27 18:4', 'yyyy/mm/dd hh24:mi'), '1006', '1002');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('How high is it?', TO_TIMESTAMP('2022/1/29 10:54', 'yyyy/mm/dd hh24:mi'), '1004', '1113');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Show me what you bought.', TO_TIMESTAMP('2022/3/3 19:1', 'yyyy/mm/dd hh24:mi'), '1005', '1151');

INSERT INTO "Group" (name, ownerid) VALUES ('Cornwall Giraffes', '1120');
INSERT INTO groupmembers (userid, groupid) VALUES ('1120', '1002');
INSERT INTO groupmembers (userid, groupid) VALUES ('1012', '1002');
INSERT INTO groupmembers (userid, groupid) VALUES ('1021', '1002');
INSERT INTO groupmembers (userid, groupid) VALUES ('1005', '1002');
INSERT INTO groupmembers (userid, groupid) VALUES ('1018', '1002');
INSERT INTO groupmembers (userid, groupid) VALUES ('1029', '1002');
INSERT INTO groupmembers (userid, groupid) VALUES ('1028', '1002');
INSERT INTO groupmembers (userid, groupid) VALUES ('1006', '1002');
INSERT INTO groupmembers (userid, groupid) VALUES ('1123', '1002');
INSERT INTO groupmembers (userid, groupid) VALUES ('1047', '1002');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Show me yours!', TO_TIMESTAMP('2022/1/25 19:48', 'yyyy/mm/dd hh24:mi'), '1002', '1047');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Mama says, ''Stupid is as stupid does.', TO_TIMESTAMP('2022/2/6 17:43', 'yyyy/mm/dd hh24:mi'), '1002', '1006');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Boiler for sale!', TO_TIMESTAMP('2022/1/26 4:29', 'yyyy/mm/dd hh24:mi'), '1002', '1028');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Go ahead, make my day.', TO_TIMESTAMP('2022/3/17 4:23', 'yyyy/mm/dd hh24:mi'), '1002', '1018');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Mama says, ''Stupid is as stupid does.', TO_TIMESTAMP('2022/3/5 4:28', 'yyyy/mm/dd hh24:mi'), '1009', '1047');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('We are grilling sausage.', TO_TIMESTAMP('2022/2/5 9:24', 'yyyy/mm/dd hh24:mi'), '1011', '1029');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/2/5 18:59', 'yyyy/mm/dd hh24:mi'), '1010', '1120');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Where''s my horse?', TO_TIMESTAMP('2022/2/27 11:22', 'yyyy/mm/dd hh24:mi'), '1009', '1018');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('There''s no place like home.', TO_TIMESTAMP('2022/1/6 20:50', 'yyyy/mm/dd hh24:mi'), '1009', '1028');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Why does luck hate you?', TO_TIMESTAMP('2022/2/2 0:14', 'yyyy/mm/dd hh24:mi'), '1008', '1123');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Heh?', TO_TIMESTAMP('2022/2/26 15:11', 'yyyy/mm/dd hh24:mi'), '1008', '1006');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Please put the book on the shelf', TO_TIMESTAMP('2022/1/25 23:19', 'yyyy/mm/dd hh24:mi'), '1011', '1028');

INSERT INTO "Group" (name, ownerid) VALUES ('Devon Athletic', '1052');
INSERT INTO groupmembers (userid, groupid) VALUES ('1052', '1003');
INSERT INTO groupmembers (userid, groupid) VALUES ('1050', '1003');
INSERT INTO groupmembers (userid, groupid) VALUES ('1060', '1003');
INSERT INTO groupmembers (userid, groupid) VALUES ('1115', '1003');
INSERT INTO groupmembers (userid, groupid) VALUES ('1076', '1003');
INSERT INTO groupmembers (userid, groupid) VALUES ('1090', '1003');
INSERT INTO groupmembers (userid, groupid) VALUES ('1078', '1003');
INSERT INTO groupmembers (userid, groupid) VALUES ('1117', '1003');
INSERT INTO groupmembers (userid, groupid) VALUES ('1084', '1003');
INSERT INTO groupmembers (userid, groupid) VALUES ('1126', '1003');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('I swam in the river', TO_TIMESTAMP('2022/1/1 20:50', 'yyyy/mm/dd hh24:mi'), '1003', '1078');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Mama says, ''Stupid is as stupid does.', TO_TIMESTAMP('2022/3/3 16:59', 'yyyy/mm/dd hh24:mi'), '1003', '1060');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Just when I thought I was out, they pull me back in', TO_TIMESTAMP('2022/2/26 17:28', 'yyyy/mm/dd hh24:mi'), '1003', '1115');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('You agreed to it', TO_TIMESTAMP('2022/1/1 2:25', 'yyyy/mm/dd hh24:mi'), '1003', '1126');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Why am I here?', TO_TIMESTAMP('2022/3/17 5:38', 'yyyy/mm/dd hh24:mi'), '1014', '1052');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Today is a beautiful day', TO_TIMESTAMP('2022/1/17 1:55', 'yyyy/mm/dd hh24:mi'), '1012', '1076');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Show me what you bought.', TO_TIMESTAMP('2022/1/7 23:42', 'yyyy/mm/dd hh24:mi'), '1012', '1052');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Where''s my horse?', TO_TIMESTAMP('2022/1/28 13:36', 'yyyy/mm/dd hh24:mi'), '1014', '1117');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I have some great news', TO_TIMESTAMP('2022/3/19 5:35', 'yyyy/mm/dd hh24:mi'), '1013', '1084');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/1/19 4:46', 'yyyy/mm/dd hh24:mi'), '1012', '1050');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Where''s my horse?', TO_TIMESTAMP('2022/3/1 15:49', 'yyyy/mm/dd hh24:mi'), '1014', '1126');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I bought it for you', TO_TIMESTAMP('2022/1/20 1:6', 'yyyy/mm/dd hh24:mi'), '1014', '1050');

INSERT INTO "Group" (name, ownerid) VALUES ('Devon Tortoises', '1041');
INSERT INTO groupmembers (userid, groupid) VALUES ('1041', '1004');
INSERT INTO groupmembers (userid, groupid) VALUES ('1139', '1004');
INSERT INTO groupmembers (userid, groupid) VALUES ('1029', '1004');
INSERT INTO groupmembers (userid, groupid) VALUES ('1068', '1004');
INSERT INTO groupmembers (userid, groupid) VALUES ('1081', '1004');
INSERT INTO groupmembers (userid, groupid) VALUES ('1098', '1004');
INSERT INTO groupmembers (userid, groupid) VALUES ('1107', '1004');
INSERT INTO groupmembers (userid, groupid) VALUES ('1064', '1004');
INSERT INTO groupmembers (userid, groupid) VALUES ('1085', '1004');
INSERT INTO groupmembers (userid, groupid) VALUES ('1119', '1004');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Let us agree to disagree', TO_TIMESTAMP('2022/1/8 0:56', 'yyyy/mm/dd hh24:mi'), '1004', '1098');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('I''m still excited', TO_TIMESTAMP('2022/2/17 18:27', 'yyyy/mm/dd hh24:mi'), '1004', '1081');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Im bored...', TO_TIMESTAMP('2022/2/28 16:22', 'yyyy/mm/dd hh24:mi'), '1004', '1085');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Go ahead, make my day.', TO_TIMESTAMP('2022/3/3 8:20', 'yyyy/mm/dd hh24:mi'), '1004', '1119');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('What''s up?', TO_TIMESTAMP('2022/3/7 22:8', 'yyyy/mm/dd hh24:mi'), '1018', '1029');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Let us agree to disagree', TO_TIMESTAMP('2022/2/3 6:6', 'yyyy/mm/dd hh24:mi'), '1017', '1098');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('It looks like a duck', TO_TIMESTAMP('2022/2/6 6:8', 'yyyy/mm/dd hh24:mi'), '1018', '1029');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Show me what you bought.', TO_TIMESTAMP('2022/3/10 19:47', 'yyyy/mm/dd hh24:mi'), '1016', '1139');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('When you realize you want to spend the rest of your life with somebody, you want the rest of your life to start as soon as possible.', TO_TIMESTAMP('2022/1/4 3:1', 'yyyy/mm/dd hh24:mi'), '1016', '1085');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('We must leave right away.', TO_TIMESTAMP('2022/1/8 12:30', 'yyyy/mm/dd hh24:mi'), '1017', '1119');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I have some great news', TO_TIMESTAMP('2022/1/10 18:48', 'yyyy/mm/dd hh24:mi'), '1018', '1085');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Hello!', TO_TIMESTAMP('2022/1/1 19:57', 'yyyy/mm/dd hh24:mi'), '1019', '1085');

INSERT INTO "Group" (name, ownerid) VALUES ('Green Dogs', '1080');
INSERT INTO groupmembers (userid, groupid) VALUES ('1080', '1005');
INSERT INTO groupmembers (userid, groupid) VALUES ('1023', '1005');
INSERT INTO groupmembers (userid, groupid) VALUES ('1060', '1005');
INSERT INTO groupmembers (userid, groupid) VALUES ('1031', '1005');
INSERT INTO groupmembers (userid, groupid) VALUES ('1053', '1005');
INSERT INTO groupmembers (userid, groupid) VALUES ('1008', '1005');
INSERT INTO groupmembers (userid, groupid) VALUES ('1130', '1005');
INSERT INTO groupmembers (userid, groupid) VALUES ('1026', '1005');
INSERT INTO groupmembers (userid, groupid) VALUES ('1099', '1005');
INSERT INTO groupmembers (userid, groupid) VALUES ('1061', '1005');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('I''m having an old friend for dinner', TO_TIMESTAMP('2022/2/17 23:24', 'yyyy/mm/dd hh24:mi'), '1005', '1023');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Let us agree to disagree', TO_TIMESTAMP('2022/2/18 18:16', 'yyyy/mm/dd hh24:mi'), '1005', '1008');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('It must be very bad.', TO_TIMESTAMP('2022/2/20 6:53', 'yyyy/mm/dd hh24:mi'), '1005', '1053');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Show me yours!', TO_TIMESTAMP('2022/2/15 19:21', 'yyyy/mm/dd hh24:mi'), '1005', '1053');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I have some great news', TO_TIMESTAMP('2022/3/14 8:13', 'yyyy/mm/dd hh24:mi'), '1021', '1026');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Is this working?', TO_TIMESTAMP('2022/2/2 22:41', 'yyyy/mm/dd hh24:mi'), '1020', '1026');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('It made me happy', TO_TIMESTAMP('2022/3/13 16:26', 'yyyy/mm/dd hh24:mi'), '1021', '1099');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Why does luck hate you?', TO_TIMESTAMP('2022/2/11 18:25', 'yyyy/mm/dd hh24:mi'), '1023', '1080');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('You agreed to it', TO_TIMESTAMP('2022/2/6 5:37', 'yyyy/mm/dd hh24:mi'), '1022', '1053');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Show me yours!', TO_TIMESTAMP('2022/3/1 11:0', 'yyyy/mm/dd hh24:mi'), '1023', '1061');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Carpe diem. Seize the day, boys.', TO_TIMESTAMP('2022/3/1 15:51', 'yyyy/mm/dd hh24:mi'), '1022', '1099');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('You don''t speak English', TO_TIMESTAMP('2022/3/1 7:33', 'yyyy/mm/dd hh24:mi'), '1021', '1080');

INSERT INTO "Group" (name, ownerid) VALUES ('Wobbly Vikings', '1086');
INSERT INTO groupmembers (userid, groupid) VALUES ('1086', '1006');
INSERT INTO groupmembers (userid, groupid) VALUES ('1059', '1006');
INSERT INTO groupmembers (userid, groupid) VALUES ('1084', '1006');
INSERT INTO groupmembers (userid, groupid) VALUES ('1003', '1006');
INSERT INTO groupmembers (userid, groupid) VALUES ('1134', '1006');
INSERT INTO groupmembers (userid, groupid) VALUES ('1031', '1006');
INSERT INTO groupmembers (userid, groupid) VALUES ('1049', '1006');
INSERT INTO groupmembers (userid, groupid) VALUES ('1109', '1006');
INSERT INTO groupmembers (userid, groupid) VALUES ('1105', '1006');
INSERT INTO groupmembers (userid, groupid) VALUES ('1063', '1006');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('aaaaaaaaaaaaaaa', TO_TIMESTAMP('2022/2/9 9:13', 'yyyy/mm/dd hh24:mi'), '1006', '1105');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('I swam in the river', TO_TIMESTAMP('2022/1/3 10:35', 'yyyy/mm/dd hh24:mi'), '1006', '1134');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('aaaaaaaaaaaaaaa', TO_TIMESTAMP('2022/1/14 7:18', 'yyyy/mm/dd hh24:mi'), '1006', '1086');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Why am I here?', TO_TIMESTAMP('2022/1/17 9:48', 'yyyy/mm/dd hh24:mi'), '1006', '1049');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Is this working?', TO_TIMESTAMP('2022/2/18 5:10', 'yyyy/mm/dd hh24:mi'), '1024', '1105');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('It made me happy', TO_TIMESTAMP('2022/2/17 13:33', 'yyyy/mm/dd hh24:mi'), '1027', '1003');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('We are grilling sausage.', TO_TIMESTAMP('2022/2/13 15:13', 'yyyy/mm/dd hh24:mi'), '1026', '1063');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('We are grilling sausage.', TO_TIMESTAMP('2022/1/7 5:19', 'yyyy/mm/dd hh24:mi'), '1027', '1003');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Do what needs to be done', TO_TIMESTAMP('2022/3/19 19:24', 'yyyy/mm/dd hh24:mi'), '1026', '1003');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/3/11 11:12', 'yyyy/mm/dd hh24:mi'), '1026', '1003');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I''m still excited', TO_TIMESTAMP('2022/1/24 6:10', 'yyyy/mm/dd hh24:mi'), '1024', '1063');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('You talking to me?', TO_TIMESTAMP('2022/3/6 2:25', 'yyyy/mm/dd hh24:mi'), '1027', '1063');

INSERT INTO "Group" (name, ownerid) VALUES ('Articulate Gerbils', '1101');
INSERT INTO groupmembers (userid, groupid) VALUES ('1101', '1007');
INSERT INTO groupmembers (userid, groupid) VALUES ('1059', '1007');
INSERT INTO groupmembers (userid, groupid) VALUES ('1047', '1007');
INSERT INTO groupmembers (userid, groupid) VALUES ('1090', '1007');
INSERT INTO groupmembers (userid, groupid) VALUES ('1010', '1007');
INSERT INTO groupmembers (userid, groupid) VALUES ('1042', '1007');
INSERT INTO groupmembers (userid, groupid) VALUES ('1125', '1007');
INSERT INTO groupmembers (userid, groupid) VALUES ('1113', '1007');
INSERT INTO groupmembers (userid, groupid) VALUES ('1044', '1007');
INSERT INTO groupmembers (userid, groupid) VALUES ('1009', '1007');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('We must leave right away.', TO_TIMESTAMP('2022/2/26 13:21', 'yyyy/mm/dd hh24:mi'), '1007', '1044');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('I swam in the river', TO_TIMESTAMP('2022/1/7 17:20', 'yyyy/mm/dd hh24:mi'), '1007', '1101');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('What is this site?', TO_TIMESTAMP('2022/2/15 22:9', 'yyyy/mm/dd hh24:mi'), '1007', '1047');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/1/27 17:4', 'yyyy/mm/dd hh24:mi'), '1007', '1125');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I bought it for you', TO_TIMESTAMP('2022/1/22 7:31', 'yyyy/mm/dd hh24:mi'), '1028', '1047');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I''m the king of the world!', TO_TIMESTAMP('2022/3/15 19:4', 'yyyy/mm/dd hh24:mi'), '1029', '1047');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I don''t want to survive. I want to live.', TO_TIMESTAMP('2022/1/30 23:40', 'yyyy/mm/dd hh24:mi'), '1028', '1042');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('They call it a Royale with cheese.', TO_TIMESTAMP('2022/2/1 10:33', 'yyyy/mm/dd hh24:mi'), '1031', '1044');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('How high is it?', TO_TIMESTAMP('2022/3/6 12:10', 'yyyy/mm/dd hh24:mi'), '1030', '1059');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Why me?', TO_TIMESTAMP('2022/1/8 1:2', 'yyyy/mm/dd hh24:mi'), '1028', '1047');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I swam in the river', TO_TIMESTAMP('2022/2/5 20:13', 'yyyy/mm/dd hh24:mi'), '1028', '1059');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/3/21 16:1', 'yyyy/mm/dd hh24:mi'), '1031', '1113');

INSERT INTO "Group" (name, ownerid) VALUES ('Hopeful Blue Bottles', '1007');
INSERT INTO groupmembers (userid, groupid) VALUES ('1007', '1008');
INSERT INTO groupmembers (userid, groupid) VALUES ('1145', '1008');
INSERT INTO groupmembers (userid, groupid) VALUES ('1079', '1008');
INSERT INTO groupmembers (userid, groupid) VALUES ('1018', '1008');
INSERT INTO groupmembers (userid, groupid) VALUES ('1100', '1008');
INSERT INTO groupmembers (userid, groupid) VALUES ('1003', '1008');
INSERT INTO groupmembers (userid, groupid) VALUES ('1032', '1008');
INSERT INTO groupmembers (userid, groupid) VALUES ('1061', '1008');
INSERT INTO groupmembers (userid, groupid) VALUES ('1129', '1008');
INSERT INTO groupmembers (userid, groupid) VALUES ('1013', '1008');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Boiler for sale!', TO_TIMESTAMP('2022/2/10 6:30', 'yyyy/mm/dd hh24:mi'), '1008', '1145');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('aaaaaaaaaaaaaaa', TO_TIMESTAMP('2022/1/4 12:0', 'yyyy/mm/dd hh24:mi'), '1008', '1013');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('You talking to me?', TO_TIMESTAMP('2022/3/14 8:20', 'yyyy/mm/dd hh24:mi'), '1008', '1003');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Why does luck hate you?', TO_TIMESTAMP('2022/2/28 13:53', 'yyyy/mm/dd hh24:mi'), '1008', '1100');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Life moves pretty fast. If you don''t stop and look around once in a while, you could miss it.', TO_TIMESTAMP('2022/3/11 17:1', 'yyyy/mm/dd hh24:mi'), '1032', '1079');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I don''t want to survive. I want to live.', TO_TIMESTAMP('2022/3/15 22:56', 'yyyy/mm/dd hh24:mi'), '1032', '1061');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Is this working?', TO_TIMESTAMP('2022/3/7 1:46', 'yyyy/mm/dd hh24:mi'), '1034', '1018');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('a', TO_TIMESTAMP('2022/2/9 9:38', 'yyyy/mm/dd hh24:mi'), '1034', '1003');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Isn''t that against the law?', TO_TIMESTAMP('2022/1/18 15:3', 'yyyy/mm/dd hh24:mi'), '1035', '1032');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('They call it a Royale with cheese.', TO_TIMESTAMP('2022/3/19 3:41', 'yyyy/mm/dd hh24:mi'), '1035', '1061');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Today is a beautiful day', TO_TIMESTAMP('2022/1/1 15:28', 'yyyy/mm/dd hh24:mi'), '1035', '1003');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('What? Where?', TO_TIMESTAMP('2022/3/17 6:35', 'yyyy/mm/dd hh24:mi'), '1035', '1145');

INSERT INTO "Group" (name, ownerid) VALUES ('Snotty Owls', '1057');
INSERT INTO groupmembers (userid, groupid) VALUES ('1057', '1009');
INSERT INTO groupmembers (userid, groupid) VALUES ('1002', '1009');
INSERT INTO groupmembers (userid, groupid) VALUES ('1077', '1009');
INSERT INTO groupmembers (userid, groupid) VALUES ('1032', '1009');
INSERT INTO groupmembers (userid, groupid) VALUES ('1028', '1009');
INSERT INTO groupmembers (userid, groupid) VALUES ('1095', '1009');
INSERT INTO groupmembers (userid, groupid) VALUES ('1014', '1009');
INSERT INTO groupmembers (userid, groupid) VALUES ('1089', '1009');
INSERT INTO groupmembers (userid, groupid) VALUES ('1005', '1009');
INSERT INTO groupmembers (userid, groupid) VALUES ('1111', '1009');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Go ahead, make my day.', TO_TIMESTAMP('2022/1/2 16:9', 'yyyy/mm/dd hh24:mi'), '1009', '1014');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Let''s not tell anybody.', TO_TIMESTAMP('2022/1/5 22:45', 'yyyy/mm/dd hh24:mi'), '1009', '1095');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Why me?', TO_TIMESTAMP('2022/1/11 13:17', 'yyyy/mm/dd hh24:mi'), '1009', '1028');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('I''m having an old friend for dinner', TO_TIMESTAMP('2022/1/19 2:50', 'yyyy/mm/dd hh24:mi'), '1009', '1111');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I''m having an old friend for dinner', TO_TIMESTAMP('2022/3/11 12:6', 'yyyy/mm/dd hh24:mi'), '1038', '1089');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('We are grilling sausage.', TO_TIMESTAMP('2022/1/23 1:46', 'yyyy/mm/dd hh24:mi'), '1038', '1002');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Houston, we have a problem', TO_TIMESTAMP('2022/2/5 3:46', 'yyyy/mm/dd hh24:mi'), '1037', '1057');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Why am I here?', TO_TIMESTAMP('2022/2/28 12:46', 'yyyy/mm/dd hh24:mi'), '1039', '1077');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Life moves pretty fast. If you don''t stop and look around once in a while, you could miss it.', TO_TIMESTAMP('2022/2/16 6:33', 'yyyy/mm/dd hh24:mi'), '1039', '1057');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('We''re sleepy', TO_TIMESTAMP('2022/2/11 13:2', 'yyyy/mm/dd hh24:mi'), '1039', '1032');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Heeyy', TO_TIMESTAMP('2022/2/27 14:0', 'yyyy/mm/dd hh24:mi'), '1038', '1077');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/1/16 9:41', 'yyyy/mm/dd hh24:mi'), '1039', '1014');

INSERT INTO "Group" (name, ownerid) VALUES ('Ireland United', '1098');
INSERT INTO groupmembers (userid, groupid) VALUES ('1098', '1010');
INSERT INTO groupmembers (userid, groupid) VALUES ('1080', '1010');
INSERT INTO groupmembers (userid, groupid) VALUES ('1031', '1010');
INSERT INTO groupmembers (userid, groupid) VALUES ('1096', '1010');
INSERT INTO groupmembers (userid, groupid) VALUES ('1013', '1010');
INSERT INTO groupmembers (userid, groupid) VALUES ('1048', '1010');
INSERT INTO groupmembers (userid, groupid) VALUES ('1010', '1010');
INSERT INTO groupmembers (userid, groupid) VALUES ('1035', '1010');
INSERT INTO groupmembers (userid, groupid) VALUES ('1086', '1010');
INSERT INTO groupmembers (userid, groupid) VALUES ('1099', '1010');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Hello!', TO_TIMESTAMP('2022/1/18 15:34', 'yyyy/mm/dd hh24:mi'), '1010', '1048');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Houston, we have a problem', TO_TIMESTAMP('2022/1/7 11:26', 'yyyy/mm/dd hh24:mi'), '1010', '1099');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('It made me happy', TO_TIMESTAMP('2022/3/14 12:17', 'yyyy/mm/dd hh24:mi'), '1010', '1048');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('<insert random text here>', TO_TIMESTAMP('2022/2/21 10:14', 'yyyy/mm/dd hh24:mi'), '1010', '1086');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('We must leave right away.', TO_TIMESTAMP('2022/1/10 18:15', 'yyyy/mm/dd hh24:mi'), '1042', '1096');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Hello!', TO_TIMESTAMP('2022/3/2 12:1', 'yyyy/mm/dd hh24:mi'), '1041', '1010');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Get busy living, or get busy dying.', TO_TIMESTAMP('2022/1/20 21:34', 'yyyy/mm/dd hh24:mi'), '1042', '1099');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I have some great news', TO_TIMESTAMP('2022/1/27 20:23', 'yyyy/mm/dd hh24:mi'), '1041', '1048');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Nothing is better than health!', TO_TIMESTAMP('2022/1/16 23:30', 'yyyy/mm/dd hh24:mi'), '1040', '1099');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Let''s not tell anybody.', TO_TIMESTAMP('2022/2/21 13:44', 'yyyy/mm/dd hh24:mi'), '1043', '1096');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Hello there!', TO_TIMESTAMP('2022/1/10 18:46', 'yyyy/mm/dd hh24:mi'), '1043', '1013');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Life moves pretty fast. If you don''t stop and look around once in a while, you could miss it.', TO_TIMESTAMP('2022/1/1 5:39', 'yyyy/mm/dd hh24:mi'), '1042', '1080');

INSERT INTO "Group" (name, ownerid) VALUES ('Cornwall Dogs', '1014');
INSERT INTO groupmembers (userid, groupid) VALUES ('1014', '1011');
INSERT INTO groupmembers (userid, groupid) VALUES ('1131', '1011');
INSERT INTO groupmembers (userid, groupid) VALUES ('1107', '1011');
INSERT INTO groupmembers (userid, groupid) VALUES ('1126', '1011');
INSERT INTO groupmembers (userid, groupid) VALUES ('1120', '1011');
INSERT INTO groupmembers (userid, groupid) VALUES ('1069', '1011');
INSERT INTO groupmembers (userid, groupid) VALUES ('1068', '1011');
INSERT INTO groupmembers (userid, groupid) VALUES ('1067', '1011');
INSERT INTO groupmembers (userid, groupid) VALUES ('1101', '1011');
INSERT INTO groupmembers (userid, groupid) VALUES ('1043', '1011');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Carpe diem. Seize the day, boys.', TO_TIMESTAMP('2022/3/7 5:35', 'yyyy/mm/dd hh24:mi'), '1011', '1043');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Hello!', TO_TIMESTAMP('2022/1/15 15:45', 'yyyy/mm/dd hh24:mi'), '1011', '1107');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('It must be very bad.', TO_TIMESTAMP('2022/1/26 18:20', 'yyyy/mm/dd hh24:mi'), '1011', '1068');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/3/5 20:31', 'yyyy/mm/dd hh24:mi'), '1011', '1014');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Let''s not tell anybody.', TO_TIMESTAMP('2022/1/12 1:36', 'yyyy/mm/dd hh24:mi'), '1044', '1067');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Why does luck hate you?', TO_TIMESTAMP('2022/1/16 2:19', 'yyyy/mm/dd hh24:mi'), '1045', '1069');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/1/18 11:58', 'yyyy/mm/dd hh24:mi'), '1046', '1101');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Do what needs to be done', TO_TIMESTAMP('2022/1/15 19:17', 'yyyy/mm/dd hh24:mi'), '1047', '1120');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('You agreed to it', TO_TIMESTAMP('2022/1/30 19:56', 'yyyy/mm/dd hh24:mi'), '1044', '1068');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('It looks like a duck', TO_TIMESTAMP('2022/1/19 9:33', 'yyyy/mm/dd hh24:mi'), '1045', '1131');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('It must be very bad.', TO_TIMESTAMP('2022/1/7 9:1', 'yyyy/mm/dd hh24:mi'), '1044', '1043');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Carpe diem. Seize the day, boys.', TO_TIMESTAMP('2022/3/21 22:45', 'yyyy/mm/dd hh24:mi'), '1047', '1107');

INSERT INTO "Group" (name, ownerid) VALUES ('Cornwall Dogs', '1078');
INSERT INTO groupmembers (userid, groupid) VALUES ('1078', '1012');
INSERT INTO groupmembers (userid, groupid) VALUES ('1102', '1012');
INSERT INTO groupmembers (userid, groupid) VALUES ('1133', '1012');
INSERT INTO groupmembers (userid, groupid) VALUES ('1136', '1012');
INSERT INTO groupmembers (userid, groupid) VALUES ('1151', '1012');
INSERT INTO groupmembers (userid, groupid) VALUES ('1104', '1012');
INSERT INTO groupmembers (userid, groupid) VALUES ('1077', '1012');
INSERT INTO groupmembers (userid, groupid) VALUES ('1049', '1012');
INSERT INTO groupmembers (userid, groupid) VALUES ('1076', '1012');
INSERT INTO groupmembers (userid, groupid) VALUES ('1148', '1012');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/1/27 5:6', 'yyyy/mm/dd hh24:mi'), '1012', '1151');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('I followed you.', TO_TIMESTAMP('2022/2/4 1:29', 'yyyy/mm/dd hh24:mi'), '1012', '1133');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Just when I thought I was out, they pull me back in', TO_TIMESTAMP('2022/1/17 5:33', 'yyyy/mm/dd hh24:mi'), '1012', '1151');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Isn''t that against the law?', TO_TIMESTAMP('2022/1/19 13:55', 'yyyy/mm/dd hh24:mi'), '1012', '1133');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Do what needs to be done', TO_TIMESTAMP('2022/3/8 12:30', 'yyyy/mm/dd hh24:mi'), '1050', '1077');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Go ahead, make my day.', TO_TIMESTAMP('2022/3/2 11:59', 'yyyy/mm/dd hh24:mi'), '1048', '1104');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I''m having an old friend for dinner', TO_TIMESTAMP('2022/2/20 17:48', 'yyyy/mm/dd hh24:mi'), '1051', '1104');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Hello there!', TO_TIMESTAMP('2022/1/22 6:58', 'yyyy/mm/dd hh24:mi'), '1051', '1104');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Heeyy', TO_TIMESTAMP('2022/3/3 18:6', 'yyyy/mm/dd hh24:mi'), '1051', '1148');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('It looks like a duck', TO_TIMESTAMP('2022/1/9 4:6', 'yyyy/mm/dd hh24:mi'), '1050', '1078');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Hello!', TO_TIMESTAMP('2022/1/18 12:56', 'yyyy/mm/dd hh24:mi'), '1048', '1049');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('When you realize you want to spend the rest of your life with somebody, you want the rest of your life to start as soon as possible.', TO_TIMESTAMP('2022/2/1 0:41', 'yyyy/mm/dd hh24:mi'), '1049', '1136');

INSERT INTO "Group" (name, ownerid) VALUES ('Ireland Monkeys', '1031');
INSERT INTO groupmembers (userid, groupid) VALUES ('1031', '1013');
INSERT INTO groupmembers (userid, groupid) VALUES ('1086', '1013');
INSERT INTO groupmembers (userid, groupid) VALUES ('1014', '1013');
INSERT INTO groupmembers (userid, groupid) VALUES ('1044', '1013');
INSERT INTO groupmembers (userid, groupid) VALUES ('1023', '1013');
INSERT INTO groupmembers (userid, groupid) VALUES ('1119', '1013');
INSERT INTO groupmembers (userid, groupid) VALUES ('1129', '1013');
INSERT INTO groupmembers (userid, groupid) VALUES ('1050', '1013');
INSERT INTO groupmembers (userid, groupid) VALUES ('1112', '1013');
INSERT INTO groupmembers (userid, groupid) VALUES ('1041', '1013');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Hello!', TO_TIMESTAMP('2022/3/20 22:23', 'yyyy/mm/dd hh24:mi'), '1013', '1023');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('It looks like a duck', TO_TIMESTAMP('2022/1/16 18:13', 'yyyy/mm/dd hh24:mi'), '1013', '1044');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Today is a beautiful day', TO_TIMESTAMP('2022/1/31 1:31', 'yyyy/mm/dd hh24:mi'), '1013', '1050');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Go ahead, make my day.', TO_TIMESTAMP('2022/1/23 17:29', 'yyyy/mm/dd hh24:mi'), '1013', '1119');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I followed you.', TO_TIMESTAMP('2022/3/7 7:52', 'yyyy/mm/dd hh24:mi'), '1052', '1112');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Just when I thought I was out, they pull me back in', TO_TIMESTAMP('2022/3/21 14:26', 'yyyy/mm/dd hh24:mi'), '1054', '1112');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Mama says, ''Stupid is as stupid does.', TO_TIMESTAMP('2022/1/16 2:49', 'yyyy/mm/dd hh24:mi'), '1053', '1044');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I asked them to stop.', TO_TIMESTAMP('2022/2/16 12:19', 'yyyy/mm/dd hh24:mi'), '1055', '1086');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Show me what you bought.', TO_TIMESTAMP('2022/3/15 23:5', 'yyyy/mm/dd hh24:mi'), '1054', '1014');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('That''s our train.', TO_TIMESTAMP('2022/3/6 3:5', 'yyyy/mm/dd hh24:mi'), '1054', '1119');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Why me?', TO_TIMESTAMP('2022/3/11 3:35', 'yyyy/mm/dd hh24:mi'), '1054', '1112');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('<insert random text here>', TO_TIMESTAMP('2022/2/13 22:13', 'yyyy/mm/dd hh24:mi'), '1054', '1112');

INSERT INTO "Group" (name, ownerid) VALUES ('Articulate Gerbils', '1120');
INSERT INTO groupmembers (userid, groupid) VALUES ('1120', '1014');
INSERT INTO groupmembers (userid, groupid) VALUES ('1095', '1014');
INSERT INTO groupmembers (userid, groupid) VALUES ('1080', '1014');
INSERT INTO groupmembers (userid, groupid) VALUES ('1117', '1014');
INSERT INTO groupmembers (userid, groupid) VALUES ('1102', '1014');
INSERT INTO groupmembers (userid, groupid) VALUES ('1119', '1014');
INSERT INTO groupmembers (userid, groupid) VALUES ('1122', '1014');
INSERT INTO groupmembers (userid, groupid) VALUES ('1126', '1014');
INSERT INTO groupmembers (userid, groupid) VALUES ('1101', '1014');
INSERT INTO groupmembers (userid, groupid) VALUES ('1086', '1014');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Do what needs to be done', TO_TIMESTAMP('2022/3/16 9:35', 'yyyy/mm/dd hh24:mi'), '1014', '1095');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Hello there!', TO_TIMESTAMP('2022/3/9 7:1', 'yyyy/mm/dd hh24:mi'), '1014', '1095');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('We are grilling sausage.', TO_TIMESTAMP('2022/3/15 5:37', 'yyyy/mm/dd hh24:mi'), '1014', '1122');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('I''m still excited', TO_TIMESTAMP('2022/3/6 3:5', 'yyyy/mm/dd hh24:mi'), '1014', '1095');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Let''s not tell anybody.', TO_TIMESTAMP('2022/3/8 6:38', 'yyyy/mm/dd hh24:mi'), '1059', '1119');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Take my glasses', TO_TIMESTAMP('2022/2/28 12:9', 'yyyy/mm/dd hh24:mi'), '1057', '1117');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Please put the book on the shelf', TO_TIMESTAMP('2022/1/22 11:52', 'yyyy/mm/dd hh24:mi'), '1057', '1086');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Where''s my horse?', TO_TIMESTAMP('2022/1/6 3:4', 'yyyy/mm/dd hh24:mi'), '1058', '1080');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('aaaaaaaaaaaaaaa', TO_TIMESTAMP('2022/1/19 14:20', 'yyyy/mm/dd hh24:mi'), '1058', '1122');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Im bored...', TO_TIMESTAMP('2022/2/19 8:30', 'yyyy/mm/dd hh24:mi'), '1058', '1122');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('We are grilling sausage.', TO_TIMESTAMP('2022/3/12 2:55', 'yyyy/mm/dd hh24:mi'), '1057', '1117');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I''m still excited', TO_TIMESTAMP('2022/2/26 22:34', 'yyyy/mm/dd hh24:mi'), '1057', '1080');

INSERT INTO "Group" (name, ownerid) VALUES ('Wobbly Vikings', '1088');
INSERT INTO groupmembers (userid, groupid) VALUES ('1088', '1015');
INSERT INTO groupmembers (userid, groupid) VALUES ('1116', '1015');
INSERT INTO groupmembers (userid, groupid) VALUES ('1006', '1015');
INSERT INTO groupmembers (userid, groupid) VALUES ('1007', '1015');
INSERT INTO groupmembers (userid, groupid) VALUES ('1131', '1015');
INSERT INTO groupmembers (userid, groupid) VALUES ('1026', '1015');
INSERT INTO groupmembers (userid, groupid) VALUES ('1148', '1015');
INSERT INTO groupmembers (userid, groupid) VALUES ('1040', '1015');
INSERT INTO groupmembers (userid, groupid) VALUES ('1134', '1015');
INSERT INTO groupmembers (userid, groupid) VALUES ('1047', '1015');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('How are you?', TO_TIMESTAMP('2022/1/25 18:54', 'yyyy/mm/dd hh24:mi'), '1015', '1131');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('It looks like a duck', TO_TIMESTAMP('2022/2/4 8:58', 'yyyy/mm/dd hh24:mi'), '1015', '1088');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/3/10 16:58', 'yyyy/mm/dd hh24:mi'), '1015', '1088');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('I can''t bear that fellow', TO_TIMESTAMP('2022/1/8 23:22', 'yyyy/mm/dd hh24:mi'), '1015', '1148');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('You talking to me?', TO_TIMESTAMP('2022/1/2 9:58', 'yyyy/mm/dd hh24:mi'), '1062', '1007');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('What''s your wife''s name?', TO_TIMESTAMP('2022/3/4 6:25', 'yyyy/mm/dd hh24:mi'), '1061', '1116');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('a', TO_TIMESTAMP('2022/3/8 10:46', 'yyyy/mm/dd hh24:mi'), '1060', '1040');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('What? Where?', TO_TIMESTAMP('2022/3/3 2:31', 'yyyy/mm/dd hh24:mi'), '1060', '1047');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('This is the beginning of a beautiful friendship', TO_TIMESTAMP('2022/2/27 17:45', 'yyyy/mm/dd hh24:mi'), '1062', '1116');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('We are grilling sausage.', TO_TIMESTAMP('2022/3/21 6:11', 'yyyy/mm/dd hh24:mi'), '1063', '1006');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Im bored...', TO_TIMESTAMP('2022/1/5 8:29', 'yyyy/mm/dd hh24:mi'), '1061', '1116');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Im bored...', TO_TIMESTAMP('2022/3/6 23:3', 'yyyy/mm/dd hh24:mi'), '1061', '1007');

INSERT INTO "Group" (name, ownerid) VALUES ('Ireland Owls', '1002');
INSERT INTO groupmembers (userid, groupid) VALUES ('1002', '1016');
INSERT INTO groupmembers (userid, groupid) VALUES ('1056', '1016');
INSERT INTO groupmembers (userid, groupid) VALUES ('1095', '1016');
INSERT INTO groupmembers (userid, groupid) VALUES ('1026', '1016');
INSERT INTO groupmembers (userid, groupid) VALUES ('1025', '1016');
INSERT INTO groupmembers (userid, groupid) VALUES ('1003', '1016');
INSERT INTO groupmembers (userid, groupid) VALUES ('1046', '1016');
INSERT INTO groupmembers (userid, groupid) VALUES ('1023', '1016');
INSERT INTO groupmembers (userid, groupid) VALUES ('1096', '1016');
INSERT INTO groupmembers (userid, groupid) VALUES ('1097', '1016');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Let us agree to disagree', TO_TIMESTAMP('2022/2/16 18:5', 'yyyy/mm/dd hh24:mi'), '1016', '1056');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('OK! Bring it on!', TO_TIMESTAMP('2022/1/3 12:5', 'yyyy/mm/dd hh24:mi'), '1016', '1023');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('You agreed to it', TO_TIMESTAMP('2022/1/27 21:22', 'yyyy/mm/dd hh24:mi'), '1016', '1025');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('I followed you.', TO_TIMESTAMP('2022/2/21 0:1', 'yyyy/mm/dd hh24:mi'), '1016', '1026');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Did you break it?', TO_TIMESTAMP('2022/3/6 7:57', 'yyyy/mm/dd hh24:mi'), '1066', '1025');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Mama says, ''Stupid is as stupid does.', TO_TIMESTAMP('2022/3/9 5:37', 'yyyy/mm/dd hh24:mi'), '1066', '1097');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I don''t want to survive. I want to live.', TO_TIMESTAMP('2022/3/2 13:43', 'yyyy/mm/dd hh24:mi'), '1066', '1056');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Well, that''s it', TO_TIMESTAMP('2022/2/13 18:14', 'yyyy/mm/dd hh24:mi'), '1067', '1095');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('How are you?', TO_TIMESTAMP('2022/1/26 4:39', 'yyyy/mm/dd hh24:mi'), '1066', '1096');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Hello there!', TO_TIMESTAMP('2022/2/21 17:41', 'yyyy/mm/dd hh24:mi'), '1065', '1097');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I''m having an old friend for dinner', TO_TIMESTAMP('2022/1/11 11:28', 'yyyy/mm/dd hh24:mi'), '1066', '1095');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I asked them to stop.', TO_TIMESTAMP('2022/2/9 19:50', 'yyyy/mm/dd hh24:mi'), '1066', '1056');

INSERT INTO "Group" (name, ownerid) VALUES ('Wild Independents', '1139');
INSERT INTO groupmembers (userid, groupid) VALUES ('1139', '1017');
INSERT INTO groupmembers (userid, groupid) VALUES ('1085', '1017');
INSERT INTO groupmembers (userid, groupid) VALUES ('1029', '1017');
INSERT INTO groupmembers (userid, groupid) VALUES ('1040', '1017');
INSERT INTO groupmembers (userid, groupid) VALUES ('1102', '1017');
INSERT INTO groupmembers (userid, groupid) VALUES ('1052', '1017');
INSERT INTO groupmembers (userid, groupid) VALUES ('1098', '1017');
INSERT INTO groupmembers (userid, groupid) VALUES ('1010', '1017');
INSERT INTO groupmembers (userid, groupid) VALUES ('1120', '1017');
INSERT INTO groupmembers (userid, groupid) VALUES ('1059', '1017');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('What is this site?', TO_TIMESTAMP('2022/3/1 0:57', 'yyyy/mm/dd hh24:mi'), '1017', '1040');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('You talking to me?', TO_TIMESTAMP('2022/3/3 10:10', 'yyyy/mm/dd hh24:mi'), '1017', '1059');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Im bored...', TO_TIMESTAMP('2022/2/16 1:26', 'yyyy/mm/dd hh24:mi'), '1017', '1029');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('What''s your wife''s name?', TO_TIMESTAMP('2022/2/10 8:48', 'yyyy/mm/dd hh24:mi'), '1017', '1102');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('It looks like a duck', TO_TIMESTAMP('2022/3/12 9:12', 'yyyy/mm/dd hh24:mi'), '1069', '1040');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Is this working?', TO_TIMESTAMP('2022/3/8 21:47', 'yyyy/mm/dd hh24:mi'), '1069', '1085');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Let''s not tell anybody.', TO_TIMESTAMP('2022/2/9 7:53', 'yyyy/mm/dd hh24:mi'), '1069', '1010');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('It made me happy', TO_TIMESTAMP('2022/1/31 7:0', 'yyyy/mm/dd hh24:mi'), '1070', '1085');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Why am I here?', TO_TIMESTAMP('2022/1/31 22:39', 'yyyy/mm/dd hh24:mi'), '1068', '1029');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Heh?', TO_TIMESTAMP('2022/1/6 22:36', 'yyyy/mm/dd hh24:mi'), '1069', '1085');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Go ahead, make my day.', TO_TIMESTAMP('2022/2/15 18:20', 'yyyy/mm/dd hh24:mi'), '1070', '1102');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Is this working?', TO_TIMESTAMP('2022/2/24 7:34', 'yyyy/mm/dd hh24:mi'), '1069', '1098');

INSERT INTO "Group" (name, ownerid) VALUES ('Ireland Purples', '1090');
INSERT INTO groupmembers (userid, groupid) VALUES ('1090', '1018');
INSERT INTO groupmembers (userid, groupid) VALUES ('1138', '1018');
INSERT INTO groupmembers (userid, groupid) VALUES ('1094', '1018');
INSERT INTO groupmembers (userid, groupid) VALUES ('1078', '1018');
INSERT INTO groupmembers (userid, groupid) VALUES ('1076', '1018');
INSERT INTO groupmembers (userid, groupid) VALUES ('1046', '1018');
INSERT INTO groupmembers (userid, groupid) VALUES ('1106', '1018');
INSERT INTO groupmembers (userid, groupid) VALUES ('1075', '1018');
INSERT INTO groupmembers (userid, groupid) VALUES ('1073', '1018');
INSERT INTO groupmembers (userid, groupid) VALUES ('1002', '1018');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('How high is it?', TO_TIMESTAMP('2022/2/21 12:25', 'yyyy/mm/dd hh24:mi'), '1018', '1078');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('I swam in the river', TO_TIMESTAMP('2022/3/16 1:42', 'yyyy/mm/dd hh24:mi'), '1018', '1073');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Let me speak, please', TO_TIMESTAMP('2022/1/25 3:49', 'yyyy/mm/dd hh24:mi'), '1018', '1106');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('I asked them to stop.', TO_TIMESTAMP('2022/3/22 23:32', 'yyyy/mm/dd hh24:mi'), '1018', '1046');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Is this working?', TO_TIMESTAMP('2022/3/14 11:19', 'yyyy/mm/dd hh24:mi'), '1075', '1046');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Let me speak, please', TO_TIMESTAMP('2022/3/1 7:32', 'yyyy/mm/dd hh24:mi'), '1074', '1094');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('You talking to me?', TO_TIMESTAMP('2022/2/9 3:39', 'yyyy/mm/dd hh24:mi'), '1073', '1094');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I swam in the river', TO_TIMESTAMP('2022/3/11 13:55', 'yyyy/mm/dd hh24:mi'), '1074', '1106');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('You don''t speak English', TO_TIMESTAMP('2022/2/24 22:26', 'yyyy/mm/dd hh24:mi'), '1073', '1073');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('That''s our train.', TO_TIMESTAMP('2022/3/15 15:5', 'yyyy/mm/dd hh24:mi'), '1072', '1075');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Why does luck hate you?', TO_TIMESTAMP('2022/3/2 10:29', 'yyyy/mm/dd hh24:mi'), '1074', '1090');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Why am I here?', TO_TIMESTAMP('2022/1/15 16:17', 'yyyy/mm/dd hh24:mi'), '1074', '1138');

INSERT INTO "Group" (name, ownerid) VALUES ('Cornwall Giraffes', '1127');
INSERT INTO groupmembers (userid, groupid) VALUES ('1127', '1019');
INSERT INTO groupmembers (userid, groupid) VALUES ('1022', '1019');
INSERT INTO groupmembers (userid, groupid) VALUES ('1136', '1019');
INSERT INTO groupmembers (userid, groupid) VALUES ('1083', '1019');
INSERT INTO groupmembers (userid, groupid) VALUES ('1057', '1019');
INSERT INTO groupmembers (userid, groupid) VALUES ('1069', '1019');
INSERT INTO groupmembers (userid, groupid) VALUES ('1076', '1019');
INSERT INTO groupmembers (userid, groupid) VALUES ('1050', '1019');
INSERT INTO groupmembers (userid, groupid) VALUES ('1006', '1019');
INSERT INTO groupmembers (userid, groupid) VALUES ('1091', '1019');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('You agreed to it', TO_TIMESTAMP('2022/2/14 21:49', 'yyyy/mm/dd hh24:mi'), '1019', '1076');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('Life moves pretty fast. If you don''t stop and look around once in a while, you could miss it.', TO_TIMESTAMP('2022/1/15 9:20', 'yyyy/mm/dd hh24:mi'), '1019', '1069');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('aaaaaaaaaaaaaaa', TO_TIMESTAMP('2022/1/4 17:55', 'yyyy/mm/dd hh24:mi'), '1019', '1091');
INSERT INTO grouppost (text, timestamp, groupid, userid) VALUES ('What is this site?', TO_TIMESTAMP('2022/3/14 0:52', 'yyyy/mm/dd hh24:mi'), '1019', '1057');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I have some great news', TO_TIMESTAMP('2022/2/11 1:19', 'yyyy/mm/dd hh24:mi'), '1079', '1022');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Let us agree to disagree', TO_TIMESTAMP('2022/1/20 10:36', 'yyyy/mm/dd hh24:mi'), '1078', '1083');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('How high is it?', TO_TIMESTAMP('2022/3/10 10:19', 'yyyy/mm/dd hh24:mi'), '1077', '1076');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('What''s up?', TO_TIMESTAMP('2022/1/3 4:28', 'yyyy/mm/dd hh24:mi'), '1076', '1083');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('Hello there!', TO_TIMESTAMP('2022/2/2 7:59', 'yyyy/mm/dd hh24:mi'), '1079', '1022');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('It made me happy', TO_TIMESTAMP('2022/2/6 16:12', 'yyyy/mm/dd hh24:mi'), '1076', '1069');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('I''m still excited', TO_TIMESTAMP('2022/3/8 19:59', 'yyyy/mm/dd hh24:mi'), '1079', '1127');
INSERT INTO groupcomment (content, timestamp, postid, userid) VALUES ('You don''t speak English', TO_TIMESTAMP('2022/1/4 16:55', 'yyyy/mm/dd hh24:mi'), '1079', '1006');


-- functions and procedures
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


-- triggers
-- creates empty user data to a new user
CREATE OR REPLACE TRIGGER add_data
    AFTER INSERT ON "User"
    FOR EACH ROW
BEGIN
    INSERT INTO UserData (userid) VALUES (:new.id);
END;
/

-- accept existing request before insert
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
        END IF;
    END LOOP;
END;
/

-- handle friend request
CREATE OR REPLACE TRIGGER acceptFriendRequest
AFTER INSERT OR UPDATE
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
        ELSIF rekord.approved = -1 THEN
            DELETE FROM friendrequest WHERE (rekord.user1 = user1 AND rekord.user2 = user2) OR (rekord.user1 = user2 AND rekord.user2 = user1);
            EXIT;
        END IF;
    END LOOP;
END;
/