CREATE TABLE user (
	id				VARCHAR(20)		NOT NULL,
	password		VARCHAR(20),
	grade			VARCHAR(2),
	name			VARCHAR(10),
	emailid			VARCHAR(20),
	emaildomain		VARCHAR(20),
	tel1			VARCHAR(3),
    tel2			VARCHAR(4),
    tel3			VARCHAR(4),
    zip_code		VARCHAR(10),
	address			VARCHAR(256),
    detail_address	VARCHAR(256),
	naver_id		VARCHAR(20),
	kakao_id		VARCHAR(20)
);

CREATE TABLE student (
	id				int			NOT NULL,
    name			VARCHAR(10),
	class			VARCHAR(10),
    birth 			DATE,
	rfid_key		VARCHAR(20)
);

CREATE TABLE relation (
	student_id		int			NOT NULL,
    parents_id		VARCHAR(20)	NOT NULL
);

CREATE TABLE in_out (
	id				int			NOT NULL,
	student_id		int			NOT NULL,
    time			DATETIME default CURRENT_TIMESTAMP,
    in_out_flag		VARCHAR(5),
    code			VARCHAR(5)
);

CREATE TABLE notice (
	id			int,
	writer_id	VARCHAR(20)	NOT NULL,
    class		VARCHAR(10),
    title		VARCHAR(30),
	content		TEXT,
	time		DATETIME default CURRENT_TIMESTAMP
);

CREATE TABLE board (
	id			int,
	writer_id	VARCHAR(20)	NOT NULL,
    title		VARCHAR(30),
	content		TEXT,
	time		DATETIME default CURRENT_TIMESTAMP,
	hit			int default 0
);

CREATE TABLE comments (
	id			int,
	board_id	int	NOT NULL,
	writer_id	VARCHAR(20)	NOT NULL,
	content		TEXT,
	time		DATETIME default CURRENT_TIMESTAMP
);

CREATE TABLE chat (
	id			int,
	writer_id	VARCHAR(20)	NOT NULL,
    class		VARCHAR(10),
	content		TEXT,
	time		DATETIME default CURRENT_TIMESTAMP
);

CREATE TABLE photo (
	id				int,
	writer_id		VARCHAR(20)	NOT NULL,
    title			VARCHAR(30),    
    savefolder 		varchar(6),
	originalname 	varchar(50),
    savename 		varchar(50),
	hit				int default 0,
	time			DATETIME default CURRENT_TIMESTAMP
);

CREATE TABLE photo_comments (
	id			int,
	photo_id	int	NOT NULL,
	writer_id	VARCHAR(20)	NOT NULL,
	content		TEXT,
	time		DATETIME default CURRENT_TIMESTAMP
);

CREATE TABLE environment (
	time		DATETIME default CURRENT_TIMESTAMP,
	temperature	float,
	humidity	float,
	dust		float	
);

CREATE TABLE calendar (
	id			int,
	content		TEXT,
	time		DATETIME default CURRENT_TIMESTAMP
);

ALTER TABLE user ADD CONSTRAINT PK_USER PRIMARY KEY (id);
ALTER TABLE student ADD CONSTRAINT PK_STUDENT PRIMARY KEY (id);
ALTER TABLE relation ADD CONSTRAINT PK_RELATION PRIMARY KEY (student_id, parents_id);
ALTER TABLE in_out ADD CONSTRAINT PK_IN_OUT PRIMARY KEY (id);
ALTER TABLE notice ADD CONSTRAINT PK_NOTICE PRIMARY KEY (id);
ALTER TABLE board ADD CONSTRAINT PK_BOARD PRIMARY KEY (id);
ALTER TABLE comments ADD CONSTRAINT PK_COMMENTS PRIMARY KEY (id);
ALTER TABLE chat ADD CONSTRAINT PK_CHAT PRIMARY KEY (id);
ALTER TABLE photo ADD CONSTRAINT PK_PHOTO PRIMARY KEY (id);
ALTER TABLE photo_comments ADD CONSTRAINT PK_PHOTO_COMMENTS PRIMARY KEY (id);
ALTER TABLE environment ADD CONSTRAINT PK_ENVIRONMENT PRIMARY KEY (time);
ALTER TABLE calendar ADD CONSTRAINT PK_CALENDAR PRIMARY KEY (id);

ALTER TABLE student MODIFY id int not null auto_increment;
ALTER TABLE in_out MODIFY id int not null auto_increment;
ALTER TABLE notice MODIFY id int not null auto_increment;
ALTER TABLE board MODIFY id int not null auto_increment;
ALTER TABLE comments MODIFY id int not null auto_increment;
ALTER TABLE chat MODIFY id int not null auto_increment;
ALTER TABLE photo MODIFY id int not null auto_increment;
ALTER TABLE photo_comments MODIFY id int not null auto_increment;
ALTER TABLE calendar MODIFY id int not null auto_increment;

ALTER TABLE relation ADD CONSTRAINT FK_RELATION_STUDENT_ID FOREIGN KEY (student_id) REFERENCES student(id);
ALTER TABLE relation ADD CONSTRAINT FK_RELATION_PARENTS_ID FOREIGN KEY (parents_id) REFERENCES user(id);
ALTER TABLE in_out ADD CONSTRAINT FK_IN_OUT_STUDENT_ID FOREIGN KEY (student_id) REFERENCES student(id);
ALTER TABLE notice ADD CONSTRAINT FK_NOTICE_WRITER_ID FOREIGN KEY (writer_id) REFERENCES user(id);
ALTER TABLE board ADD CONSTRAINT FK_BOARD_WRITER_ID FOREIGN KEY (writer_id) REFERENCES user(id);
ALTER TABLE comments ADD CONSTRAINT FK_COMMENTS_BORAD_ID FOREIGN KEY (board_id) REFERENCES board(id);
ALTER TABLE comments ADD CONSTRAINT FK_COMMENTS_WRITER_ID FOREIGN KEY (writer_id) REFERENCES user(id);
ALTER TABLE chat ADD CONSTRAINT FK_CHAT_WRITER_ID FOREIGN KEY (writer_id) REFERENCES user(id);
ALTER TABLE photo ADD CONSTRAINT FK_PHOTO_WRITER_ID FOREIGN KEY (writer_id) REFERENCES user(id);
ALTER TABLE photo_comments ADD CONSTRAINT FK_PHOTO_COMMENTS_PHOTO_ID FOREIGN KEY (photo_id) REFERENCES photo(id);
ALTER TABLE photo_comments ADD CONSTRAINT FK_PHOTO_COMMENTS_WRITER_ID FOREIGN KEY (writer_id) REFERENCES user(id);