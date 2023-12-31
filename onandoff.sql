---------- userinfo 수정완료
CREATE TABLE USERINFO (
    NUM NUMBER NOT NULL , 
    USER_ID VARCHAR2(50) NOT NULL , 
    PW VARCHAR2(50) NOT NULL , 
    NAME VARCHAR2(20) NOT NULL, 
    EMAIL VARCHAR2(100) NOT NULL , 
    SAVE_NAME VARCHAR2(200) DEFAULT 'default.png' NOT NULL , 
    MSG VARCHAR2(2000) , 
    ALERT VARCHAR2(2000) , 
    POINT NUMBER DEFAULT 0 NOT NULL ,
    CONSTRAINT USERINFO_PK PRIMARY KEY  (
    NUM
    )  
    ENABLE ); 
    
ALTER TABLE USERINFO 
ADD CONSTRAINT USERINFO_UK1 UNIQUE 
(
    USER_ID
) 
ENABLE;

ALTER TABLE USERINFO 
ADD (BIRTHDAY DATE NOT NULL);

COMMENT ON COLUMN USERINFO.BIRTHDAY IS '생년월일';

ALTER TABLE USERINFO 
ADD (SOM_TITLE VARCHAR2(2000) );

ALTER TABLE USERINFO
ADD CONSTRAINT USERINFO_FK1 FOREIGN KEY
(
  SOM_TITLE 
)
REFERENCES SOMOIM
(
  SOM_TITLE 
)
ENABLE;

COMMENT ON COLUMN USERINFO.SOM_TITLE IS '해당 유저가 가입한 소모임';


COMMENT ON COLUMN USERINFO.NUM IS 'pk'; 
COMMENT ON COLUMN USERINFO.USER_ID IS '아이디'; 
COMMENT ON COLUMN USERINFO.PW IS '비밀번호'; 
COMMENT ON COLUMN USERINFO.NAME IS '이름'; 
COMMENT ON COLUMN USERINFO.EMAIL IS '이메일'; 
COMMENT ON COLUMN USERINFO.SAVE_NAME IS '프로필사진명'; 
COMMENT ON COLUMN USERINFO.MSG IS '쪽지'; 
COMMENT ON COLUMN USERINFO.ALERT IS '알림'; 
COMMENT ON COLUMN USERINFO.POINT IS '포인트';  
ALTER TABLE USERINFO 
ADD (INTEREST VARCHAR2(100) DEFAULT '(해당사항 없음)' NOT NULL);

COMMENT ON COLUMN USERINFO.INTEREST IS '관심 태그';
--drop table userinfo; 

create sequence seq_userinfo;
--drop sequence seq_userinfo; 

insert into userinfo (num, user_id, pw, name, email, point, birthday) 
values (seq_userinfo.nextval, 'tester', 'hi111', 'kim12', 'ddjsjdf@naver.com', 300, sysdate); 
select * from userinfo where user_id = 'tester' and pw = 'hi111';

insert into userinfo (num, user_id, pw, name, email, birthday)
values (seq_userinfo.nextval, 'tester1', 'hi111', 'park1134', 'parkeeda@google.com', sysdate);

insert into userinfo (num, user_id, pw, name, email, birthday)
values (seq_userinfo.nextval, 'admin', 'hi111', 'park1134', 'parkeeda@google.com', sysdate);

insert into userinfo (num, user_id, pw, name, email, birthday, save_name)
values (seq_userinfo.nextval, 'sssun19', 'hi111', 'kim', 'djdjdj@google.com', sysdate, '스크린샷 2023-06-17 135449');


------------point
CREATE TABLE POINT 
(
  USER_ID VARCHAR2(20 BYTE) NOT NULL 
, POINT VARCHAR2(20 BYTE) 
, ITEM VARCHAR2(20 BYTE) 
, CASH VARCHAR2(20 BYTE) 
, CATEGORY VARCHAR2(20 BYTE) 
, CONSTRAINT POINT_PK PRIMARY KEY 
  (
    USER_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX POINT_PK ON POINT (USER_ID ASC) 
      LOGGING 
      TABLESPACE SYSTEM 
      PCTFREE 10 
      INITRANS 2 
      STORAGE 
      ( 
        INITIAL 65536 
        NEXT 1048576 
        MINEXTENTS 1 
        MAXEXTENTS UNLIMITED 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT 
      ) 
      NOPARALLEL 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE SYSTEM 
PCTFREE 10 
PCTUSED 40 
INITRANS 1 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  FREELISTS 1 
  FREELIST GROUPS 1 
  BUFFER_POOL DEFAULT 
) 
NOPARALLEL;



--------------------------myfeed 
CREATE TABLE MYFEED (  
NUM NUMBER NOT NULL , 
USER_ID VARCHAR2(50) NOT NULL , 
SAVE_NAME VARCHAR2(100) DEFAULT 'default_profile.png' NOT NULL ,
GOOD_COUNT NUMBER DEFAULT 0 NOT NULL , 
HATE_COUNT NUMBER DEFAULT 0 NOT NULL ,
CONSTRAINT MYFEED_PK PRIMARY KEY  (NUM)  ENABLE ); 

ALTER TABLE MYFEED ADD CONSTRAINT MYFEED_FK1 FOREIGN KEY (USER_ID) REFERENCES USERINFO (USER_ID) ENABLE; 

COMMENT ON COLUMN MYFEED.NUM IS 'pk'; 
COMMENT ON COLUMN MYFEED.USER_ID IS '아이디'; 
COMMENT ON COLUMN MYFEED.SAVE_NAME IS '프로필사진'; 
COMMENT ON COLUMN MYFEED.GOOD_COUNT IS '좋아요'; 
COMMENT ON COLUMN MYFEED.HATE_COUNT IS '신고'; 

--drop table myfeed; 

create sequence seq_myfeed; 
--drop sequence seq_myfeed; 

----------------------------somoim
CREATE TABLE SOMOIM (  
NUM NUMBER NOT NULL , 
SOM_TITLE VARCHAR2(100) NOT NULL , 
CATEGORY VARCHAR2(100) NOT NULL , 
CONSTRAINT SOMOIM_PK PRIMARY KEY  (NUM)  ENABLE ); 

ALTER TABLE SOMOIM ADD CONSTRAINT SOMOIM_UK1 UNIQUE (SOM_TITLE) ENABLE; 

COMMENT ON COLUMN SOMOIM.NUM IS 'pk';
COMMENT ON COLUMN SOMOIM.SOM_TITLE IS '소모임이름'; 
COMMENT ON COLUMN SOMOIM.CATEGORY IS '소모임 카테고리';

ALTER TABLE SOMOIM 
ADD (MAX_MEMBER NUMBER DEFAULT 50 NOT NULL);

ALTER TABLE SOMOIM 
ADD (CREATE_DATE DATE DEFAULT sysdate NOT NULL);

ALTER TABLE SOMOIM 
ADD (AREA VARCHAR2(20));

COMMENT ON COLUMN SOMOIM.MAX_MEMBER IS '멤버정원';
COMMENT ON COLUMN SOMOIM.CREATE_DATE IS '개설날짜';
COMMENT ON COLUMN SOMOIM.AREA IS '지역';

ALTER TABLE SOMOIM 
ADD (SOM_CONTENT VARCHAR2(2000) NOT NULL);

ALTER TABLE SOMOIM  
MODIFY (AREA NOT NULL);

COMMENT ON COLUMN SOMOIM.SOM_CONTENT IS '소모임 소개';

ALTER TABLE SOMOIM 
ADD (SAVE_NAME VARCHAR2(200) DEFAULT '0112.png' NOT NULL);

COMMENT ON COLUMN SOMOIM.SAVE_NAME IS '소모임 대표사진';

ALTER TABLE SOMOIM RENAME COLUMN SAVE_NAME TO SOMOIM_IMG;

ALTER TABLE SOMOIM 
ADD (SOMOIM_MASTER VARCHAR2(100) NOT NULL);

ALTER TABLE SOMOIM
ADD CONSTRAINT SOMOIM_FK1 FOREIGN KEY
(
  SOMOIM_MASTER 
)
REFERENCES USERINFO
(
  USER_ID 
)
ENABLE;

COMMENT ON COLUMN SOMOIM.SOMOIM_MASTER IS '모임장 아이디';

ALTER TABLE SOMOIM_MEMBER 
DROP CONSTRAINT SOMOIM_MEMBER_FK3;


--drop table somoim; 

create sequence seq_somoim; 
--drop sequence seq_somoim; 

----------------------somoim_member
CREATE TABLE SOMOIM_MEMBER 
(
  NUM NUMBER NOT NULL 
, USER_ID VARCHAR2(100) NOT NULL 
, JOIN_DATE DATE DEFAULT SYSDATE NOT NULL 
, POSITION VARCHAR2(100) DEFAULT '모임원' NOT NULL 
, SOM_TITLE VARCHAR2(200) NOT NULL 
, SAVE_NAME VARCHAR2(200) DEFAULT 'default.png' NOT NULL
, CONSTRAINT SOMOIM_MEMBER_PK PRIMARY KEY 
  (
    NUM 
  )
  ENABLE 
);

ALTER TABLE SOMOIM_MEMBER
ADD CONSTRAINT SOMOIM_MEMBER_FK1 FOREIGN KEY
(
  USER_ID 
)
REFERENCES USERINFO
(
  USER_ID 
)
ENABLE;

ALTER TABLE SOMOIM_MEMBER
ADD CONSTRAINT SOMOIM_MEMBER_FK2 FOREIGN KEY
(
  SOM_TITLE 
)
REFERENCES SOMOIM
(
  SOM_TITLE 
)
ENABLE;

ALTER TABLE SOMOIM_MEMBER 
ADD (SOMOIM_NUM NUMBER );

ALTER TABLE SOMOIM_MEMBER
ADD CONSTRAINT SOMOIM_MEMBER_FK3 FOREIGN KEY
(
  SOMOIM_NUM 
)
REFERENCES SOMOIM
(
  NUM 
)
ENABLE;

COMMENT ON COLUMN SOMOIM_MEMBER.SOMOIM_NUM IS '소모임 고유번호';

COMMENT ON COLUMN SOMOIM_MEMBER.NUM IS 'pk';
COMMENT ON COLUMN SOMOIM_MEMBER.USER_ID IS '아이디';
COMMENT ON COLUMN SOMOIM_MEMBER.JOIN_DATE IS '가입날짜';
COMMENT ON COLUMN SOMOIM_MEMBER.POSITION IS '직급';
COMMENT ON COLUMN SOMOIM_MEMBER.SOM_TITLE IS '소모임이름';
COMMENT ON COLUMN SOMOIM_MEMBER.SAVE_NAME IS '이미파일명';

--drop table somoim_member;

create sequence seq_somoim_member;
--drop sequence seq_somoim_member;

select * from somoim_member;

select * from userinfo a join somoim_member b on a.user_id=b.user_id where b.somoim_num=40;
select save_name from userinfo where user_id='admin1';

----------------------------somoim_question_vote
CREATE TABLE SOMOIM_QUESTION_VOTE ( 
NUM NUMBER NOT NULL , 
SOM_MEMBER_NUM NUMBER NOT NULL, 
QUESTION VARCHAR2(100),
CONSTRAINT SOMOIM_QUESTION_VOTE_PK PRIMARY KEY  (NUM)  ENABLE ); 

ALTER TABLE SOMOIM_QUESTION_VOTE 
ADD CONSTRAINT SOMOIM_QUESTION_VOTE_FK1 FOREIGN KEY 
(
    SOM_MEMBER_NUM
)
REFERENCES SOMOIM_MEMBER
(
    NUM
) 
ENABLE;

COMMENT ON COLUMN SOMOIM_QUESTION_VOTE.NUM IS 'pk'; 
COMMENT ON COLUMN SOMOIM_QUESTION_VOTE.SOM_MEMBER_NUM IS '투표 생성자 고유번호'; 
COMMENT ON COLUMN SOMOIM_QUESTION_VOTE.QUESTION IS '투표 제목'; 

--drop table somoim_question_vote; 

create sequence seq_somoim_question_vote; 
--drop sequence seq_somoim_question_vote; 

select * from somoim_question_vote;


----------------------------somoim_choice_vote
CREATE TABLE SOMOIM_CHOICE_VOTE (  
NUM NUMBER NOT NULL , 
SOM_QVOTE_NUM NUMBER NOT NULL, 
CHOICE VARCHAR2(50) NOT NULL, 
COUNT NUMBER DEFAULT 0 NOT NULL ,
CONSTRAINT SOMOIM_CHOICE_VOTE_PK PRIMARY KEY  (NUM)  ENABLE ); 

ALTER TABLE SOMOIM_CHOICE_VOTE 
ADD CONSTRAINT SOMOIM_CHOICE_VOTE_FK1 FOREIGN KEY 
(
    SOM_QVOTE_NUM
) 
REFERENCES SOMOIM_QUESTION_VOTE 
(
    NUM
) 
ENABLE;

COMMENT ON COLUMN SOMOIM_CHOICE_VOTE.NUM IS 'pk'; 
COMMENT ON COLUMN SOMOIM_CHOICE_VOTE.SOM_QVOTE_NUM IS '투표 제목'; 
COMMENT ON COLUMN SOMOIM_CHOICE_VOTE.CHOICE IS '투표 항목'; 
COMMENT ON COLUMN SOMOIM_CHOICE_VOTE.COUNT IS '투표수'; 

--drop table somoim_choice_vote; 

create sequence seq_somoim_choice_vote; 
--drop sequence seq_somoim_choice_vote; 

select * from somoim_choice_vote;

-----------------------------somoim_board
CREATE TABLE SOMOIM_BOARD 
(
  NUM NUMBER NOT NULL 
, TITLE VARCHAR2(200) NOT NULL 
, CONTENT VARCHAR2(2000) NOT NULL 
, SAVE_NAME VARCHAR2(200) 
, WRITE_DATE DATE DEFAULT SYSDATE NOT NULL 
, VIEW_COUNT NUMBER DEFAULT 0 NOT NULL 
, GOOD_COUNT NUMBER DEFAULT 0 NOT NULL 
, VOTE_NUM NUMBER 
, SOM_MEMBER_NUM NUMBER NOT NULL 
, CONSTRAINT SOMOIM_BOARD_PK PRIMARY KEY 
  (
    NUM 
  )
  ENABLE 
);

ALTER TABLE SOMOIM_BOARD
ADD CONSTRAINT SOMOIM_BOARD_FK1 FOREIGN KEY
(
  SOM_MEMBER_NUM 
)
REFERENCES SOMOIM_MEMBER
(
  NUM 
)
ENABLE;

ALTER TABLE SOMOIM_BOARD 
DROP CONSTRAINT SOMOIM_BOARD_FK2;

COMMENT ON COLUMN SOMOIM_BOARD.NUM IS 'pk';
COMMENT ON COLUMN SOMOIM_BOARD.TITLE IS '글제목';
COMMENT ON COLUMN SOMOIM_BOARD.CONTENT IS '글내용';
COMMENT ON COLUMN SOMOIM_BOARD.SAVE_NAME IS '사진이름';
COMMENT ON COLUMN SOMOIM_BOARD.WRITE_DATE IS '작성시간';
COMMENT ON COLUMN SOMOIM_BOARD.VIEW_COUNT IS '조회수';
COMMENT ON COLUMN SOMOIM_BOARD.GOOD_COUNT IS '좋아요';
COMMENT ON COLUMN SOMOIM_BOARD.VOTE_NUM IS '투표테이블번호';
COMMENT ON COLUMN SOMOIM_BOARD.SOM_MEMBER_NUM IS '게시글 작성자 고유번호';

--drop table somoim_board;

create sequence seq_somoim_board;
--drop sequence seq_somoim_board;

select * from somoim_board;

---------- somoim_board_comments
CREATE TABLE SOMOIM_BOARD_COMMENTS (  
NUM NUMBER NOT NULL , 
SOM_MEMBER_NUM NUMBER NOT NULL, 
CONTENT VARCHAR2(2000 BYTE) NOT NULL, 
WRITE_DATE DATE DEFAULT sysdate NOT NULL , 
GOOD_COUNT NUMBER DEFAULT 0 NOT NULL , 
SOM_BOARD_NUM NUMBER NOT NULL, 
CONSTRAINT SOMOIM_BOARD_COMMENTS_PK PRIMARY KEY  (NUM)  ENABLE ); 

ALTER TABLE SOMOIM_BOARD_COMMENTS 
ADD CONSTRAINT SOMOIM_BOARD_COMMENTS_FK1 FOREIGN KEY
(
    SOM_BOARD_NUM
) 
REFERENCES SOMOIM_BOARD
(
    NUM
) 
ENABLE; 

ALTER TABLE SOMOIM_BOARD_COMMENTS 
ADD CONSTRAINT SOMOIM_BOARD_COMMENTS_FK2 
FOREIGN KEY (SOM_MEMBER_NUM) 
REFERENCES SOMOIM_MEMBER
(
    NUM
) 
ENABLE; 

COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.NUM IS 'PK'; 
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.SOM_MEMBER_NUM IS '댓글 작성자 고유번호'; 
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.CONTENT IS '댓글 내용'; 
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.WRITE_DATE IS '댓글 작성 날짜'; 
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.GOOD_COUNT IS '좋아요'; 
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.SOM_BOARD_NUM IS '게시글 번호';

--drop table somoim_board_comments; 

create sequence seq_somoim_board_comments; 
--drop sequence seq_somoim_board_comments; 

select * from somoim_board_comments;


----------------------notice
CREATE TABLE NOTICE 
(
  NUM NUMBER NOT NULL 
, USER_ID VARCHAR2(100) NOT NULL 
, TITLE VARCHAR2(200) NOT NULL 
, CONTENT VARCHAR2(2000) NOT NULL 
, WRITE_DATE DATE DEFAULT SYSDATE NOT NULL 
, SAVE_NAME VARCHAR2(200)
, CONSTRAINT NOTICE_PK PRIMARY KEY 
  (
    NUM 
  )
  ENABLE 
);

ALTER TABLE NOTICE
ADD CONSTRAINT NOTICE_FK1 FOREIGN KEY
(
  USER_ID 
)
REFERENCES USERINFO
(
  USER_ID 
)
ENABLE;

COMMENT ON COLUMN NOTICE.NUM IS 'pk';
COMMENT ON COLUMN NOTICE.USER_ID IS '아이디';
COMMENT ON COLUMN NOTICE.TITLE IS '글제목';
COMMENT ON COLUMN NOTICE.CONTENT IS '글내용';
COMMENT ON COLUMN NOTICE.WRITE_DATE IS '글작성시간';
COMMENT ON COLUMN NOTICE.SAVE_NAME IS '이지미파일명';

--drop table notice;

create sequence seq_notice;
--drop sequence seq_notice;


----------------------------schedule // 참가자 칼럼(PARTICIPANT)은 데이터가 중복될 수도 있어서 UK 지정 불가 
CREATE TABLE SOMOIM_SCHEDULE ( 
NUM NUMBER NOT NULL , 
SCHEDULE_DATE VARCHAR2(100) NOT NULL, 
SCHEDULE_TIME VARCHAR2(100) NOT NULL, 
SCHEDULE_TITLE VARCHAR2(100) NOT NULL , 
PLACE VARCHAR2(100) NOT NULL , 
MONEY NUMBER, 
SOM_MEMBER_NUM NUMBER NOT NULL, 
PARTICIPANT VARCHAR2(2000 BYTE) , 
PARTICIPANT_COUNT NUMBER,
SOMOIM_NUM NUMBER , 
CONSTRAINT SOMOIM_SCHEDULE_PK PRIMARY KEY  (NUM)  ENABLE ); 
 
ALTER TABLE SOMOIM_SCHEDULE 
ADD CONSTRAINT SOMOIM_SCHEDULE_FK1 FOREIGN KEY 
(
    SOM_MEMBER_NUM
) 
REFERENCES SOMOIM_MEMBER
(
    NUM
) 
ENABLE;

ALTER TABLE SOMOIM_SCHEDULE 
ADD (MAX_PARTICIPANT NUMBER NOT NULL);

COMMENT ON COLUMN SOMOIM_SCHEDULE.MAX_PARTICIPANT IS '해당 일정 최대정원';


COMMENT ON COLUMN SOMOIM_SCHEDULE.NUM IS 'pk'; 
COMMENT ON COLUMN SOMOIM_SCHEDULE.SCHEDULE_DATE IS '일정 날짜'; 
COMMENT ON COLUMN SOMOIM_SCHEDULE.SCHEDULE_TIME IS '일정 시간'; 
COMMENT ON COLUMN SOMOIM_SCHEDULE.SCHEDULE_TITLE IS  '일정 이름'; 
COMMENT ON COLUMN SOMOIM_SCHEDULE.PLACE IS '일정 장소'; 
COMMENT ON COLUMN SOMOIM_SCHEDULE.MONEY IS '참가비'; -- 삭제하기로 함, 논의 필요
COMMENT ON COLUMN SOMOIM_SCHEDULE.SOM_MEMBER_NUM IS '일정 작성자 고유번호';
COMMENT ON COLUMN SOMOIM_SCHEDULE.PARTICIPANT IS '참가자 목록';
COMMENT ON COLUMN SOMOIM_SCHEDULE.PARTICIPANT_COUNT IS '참가자 수';
COMMENT ON COLUMN SOMOIM_SCHEDULE.SOMOIM_NUM IS '해당 소모임 고유번호';

--drop table somoim_schedule;

create sequence seq_somoim_schedule; 
--drop sequence seq_somoim_schedule; 

select * from somoim_schedule;


----------------------------pay // 참가자 데이터 문제 논의 필요
CREATE TABLE SOMOIM_PAY (  
NUM NUMBER NOT NULL , 
MONEY NUMBER NOT NULL, 
SOM_SCHEDULE_NUM NUMBER NOT NULL, 
BANK_ACCOUNT VARCHAR2(50) NOT NULL, 
PAY_COMPLETE_PARTICIPANT VARCHAR2(200), 
PARTICIPANT VARCHAR2(200) NOT NULL, 
SADARI VARCHAR2(30),
CONSTRAINT SOMOIM_PAY_PK PRIMARY KEY  
(
    NUM
)  
ENABLE); 

ALTER TABLE SOMOIM_PAY 
ADD CONSTRAINT SOMOIM_PAY_FK1 FOREIGN KEY 
(
    SOM_SCHEDULE_NUM
) 
REFERENCES SOMOIM_SCHEDULE 
(
    NUM
) 
ENABLE;

COMMENT ON COLUMN SOMOIM_PAY.NUM IS 'pk'; 
COMMENT ON COLUMN SOMOIM_PAY.MONEY IS '정산 금액'; 
COMMENT ON COLUMN SOMOIM_PAY.SOM_SCHEDULE_NUM IS '일정 고유번호'; 
COMMENT ON COLUMN SOMOIM_PAY.BANK_ACCOUNT IS '일정 생성자 계좌번호';
COMMENT ON COLUMN SOMOIM_PAY.PAY_COMPLETE_PARTICIPANT IS '정산 완료자 목록';
COMMENT ON COLUMN SOMOIM_PAY.SADARI IS '사다리타기';
COMMENT ON COLUMN SOMOIM_PAY.PARTICIPANT IS '참여자 목록';

--drop table somoim_pay; 

create sequence seq_somoim_pay; 
--drop sequence seq_somoim_pay; 

----------------------------following
CREATE TABLE FOLLOWING
(
  NUM NUMBER NOT NULL
, USER_ID VARCHAR2(50) NOT NULL 
, FOLLOWING_ID VARCHAR2(500) 
, FOLLOWING_COUNT NUMBER DEFAULT 0 NOT NULL 
, CONSTRAINT FOLLOWING_PK PRIMARY KEY
  (
    NUM
  )
  ENABLE
);
ALTER TABLE FOLLOWING
ADD CONSTRAINT FOLLOWING_FK1 FOREIGN KEY
(
  FOLLOWING_ID
)
REFERENCES USERINFO
(
  USER_ID
)
ENABLE;

COMMENT ON COLUMN FOLLOWING.USER_ID IS '내 아이디';
COMMENT ON COLUMN FOLLOWING.FOLLOWING_ID IS '팔로잉 아이디';
COMMENT ON COLUMN FOLLOWING.FOLLOWING_COUNT IS '팔로잉 수';

--drop table following;

create sequence seq_following;
--drop sequence seq_following;

select * from following;

------------------------------follower
CREATE TABLE FOLLOWER
(
  NUM NUMBER NOT NULL 
, FOLLOWER_ID VARCHAR2(200) 
, USER_ID VARCHAR2(100) NOT NULL 
, follower_COUNT NUMBER DEFAULT 0 NOT NULL 
, CONSTRAINT FOLLOWER_PK PRIMARY KEY
  (
    NUM
  )
  ENABLE
);
ALTER TABLE FOLLOWER
ADD CONSTRAINT FOLLOWER_FK1 FOREIGN KEY
(
  follower_id
)
REFERENCES USERINFO
(
  USER_ID
)
ENABLE;


COMMENT ON COLUMN FOLLOWER.USER_ID IS '내 아이디';
COMMENT ON COLUMN FOLLOWER.FOLLOWER_ID IS '팔로워 아이디';
COMMENT ON COLUMN FOLLOWER.NUM IS 'pk';
COMMENT ON COLUMN FOLLOWER.follower_COUNT IS '팔로워 수';

--drop table follower;

create sequence seq_follower;
--drop sequence seq_follower;

select * from follower;

------------------------------community board
create table community_board
(
 num number not null
, title varchar2(200) not null
, user_id varchar2(50) not null
, content varchar2(2000) not null
, save_name varchar2(200)
, write_date date default sysdate not null
, view_count number default 0 not null
, good_count number default 0 not null
, constraint community_board_pk primary key
(
    NUM
)  
    ENABLE
);
ALTER TABLE community_BOARD
ADD CONSTRAINT community_BOARD_FK1 FOREIGN KEY
(
  USER_ID
)
REFERENCES USERINFO
(
  USER_ID
)
ENABLE;
COMMENT ON COLUMN community_BOARD.NUM IS 'pk';
COMMENT ON COLUMN community_BOARD.TITLE IS '글제목';
COMMENT ON COLUMN community_BOARD.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN community_BOARD.CONTENT IS '글내용';
COMMENT ON COLUMN community_BOARD.SAVE_NAME IS '사진이름';
COMMENT ON COLUMN community_BOARD.WRITE_DATE IS '작성시간';
COMMENT ON COLUMN community_BOARD.VIEW_COUNT IS '조회수';
COMMENT ON COLUMN community_BOARD.GOOD_COUNT IS '좋아요';
--drop table community_board;
create sequence seq_community_board;
--drop sequence seq_community_board;

select * from community_board;

---------------------alert
CREATE TABLE ALERT 
(
  NUM NUMBER NOT NULL 
, ALERT_CONTENT VARCHAR2(200) DEFAULT '알림이 존재하지 않습니다.' NOT NULL 
, USER_ID VARCHAR2(20) NOT NULL 
, CONSTRAINT ALERT_PK PRIMARY KEY 
  (
    NUM 
  )
  ENABLE 
);

COMMENT ON COLUMN ALERT.NUM IS 'pk';
COMMENT ON COLUMN ALERT.ALERT_CONTENT IS '알림내용';
COMMENT ON COLUMN ALERT.USER_ID IS '받는사람';

--drop table alert;

create sequence seq_alert;
--drop sequence seq_alert;

select * from alert;

-------------community_comments
create table community_comments (
num number not null,
user_id varchar(50) not null,
content varchar(2000) not null,
write_date date default sysdate not null,
good_count number default 0 not null,
constraint community_comments_pk primary key
(
    NUM
)  
    ENABLE
);

ALTER TABLE community_comments
ADD CONSTRAINT community_comments_FK1 FOREIGN KEY
(
  USER_ID
)
REFERENCES USERINFO
(
  USER_ID
)
ENABLE;

ALTER TABLE COMMUNITY_COMMENTS 
ADD (BOARD_NUM NUMBER );

ALTER TABLE COMMUNITY_COMMENTS
ADD CONSTRAINT COMMUNITY_COMMENTS_FK2 FOREIGN KEY
(
  BOARD_NUM 
)
REFERENCES COMMUNITY_BOARD
(
  NUM 
)
ENABLE;

COMMENT ON COLUMN COMMUNITY_COMMENTS.BOARD_NUM IS '게시글넘버';

COMMENT ON COLUMN community_comments.NUM IS 'pk';
COMMENT ON COLUMN community_comments.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN community_comments.CONTENT IS '댓글내용';
COMMENT ON COLUMN community_comments.WRITE_DATE IS '작성시간';
COMMENT ON COLUMN community_comments.GOOD_COUNT IS '좋아요';
--drop table community_comments;
create sequence seq_community_comments;
--drop sequence seq_community_commments;

--insert into community_comments (num, USER_ID, content,GOOD_COUNT)
--values (seq_community_comments.nextval, 'tester', '테스트 댓글',5);

select * from community_comments;

--------------------------------msg
CREATE TABLE MESSAGE 
(
  NUM NUMBER NOT NULL 
, MSG_TITLE VARCHAR2(50) NOT NULL 
, RECEIVER_ID VARCHAR2(50) NOT NULL 
, GUBUN NUMBER DEFAULT 0 NOT NULL 
, CREATE_DATE VARCHAR2(50) NOT NULL 
, MSG_CONTENT VARCHAR2(500) NOT NULL 
, SENDER_ID VARCHAR2(50) NOT NULL 
, USER_ID VARCHAR2(50) NOT NULL 
, READ_YN NUMBER DEFAULT 0 NOT NULL 
, CONSTRAINT MESSAGE_PK PRIMARY KEY 
  (
    NUM 
  )
  ENABLE 
);

ALTER TABLE MESSAGE
ADD CONSTRAINT MESSAGE_FK1 FOREIGN KEY
(
  RECEIVER_ID 
)
REFERENCES USERINFO
(
  USER_ID 
)
ENABLE;

ALTER TABLE MESSAGE
ADD CONSTRAINT MESSAGE_FK2 FOREIGN KEY
(
  SENDER_ID 
)
REFERENCES USERINFO
(
  USER_ID 
)
ENABLE;

COMMENT ON COLUMN MESSAGE.NUM IS 'pk';
COMMENT ON COLUMN MESSAGE.MSG_TITLE IS '쪽지 제목';
COMMENT ON COLUMN MESSAGE.RECEIVER_ID IS '수신자 아이디';
COMMENT ON COLUMN MESSAGE.GUBUN IS '수신/발신 구분';
COMMENT ON COLUMN MESSAGE.CREATE_DATE IS '수신/발신 날짜';
COMMENT ON COLUMN MESSAGE.MSG_CONTENT IS '쪽지 내용';
COMMENT ON COLUMN MESSAGE.SENDER_ID IS '발신자 아이디';
COMMENT ON COLUMN MESSAGE.USER_ID IS '유저 아이디';
COMMENT ON COLUMN MESSAGE.READ_YN IS '읽음표시';

--drop table message;

create sequence seq_message;
--drop sequence seq_message;

select * from message;

--somoim_gallery(mongoDB)
--myfeed_gallery(mongoDB)


----------------------bug
CREATE TABLE CS_BUG 
(
  NUM NUMBER NOT NULL 
, USER_ID VARCHAR2(50) NOT NULL 
, TITLE VARCHAR2(100) NOT NULL 
, CONTENT VARCHAR2(500) NOT NULL 
, CONSTRAINT CS_BUG_PK PRIMARY KEY 
  (
    NUM 
  )
  ENABLE 
);

ALTER TABLE CS_BUG
ADD CONSTRAINT CS_BUG_FK1 FOREIGN KEY
(
  USER_ID 
)
REFERENCES USERINFO
(
  USER_ID 
)
ENABLE;

COMMENT ON COLUMN CS_BUG.NUM IS 'pk';
COMMENT ON COLUMN CS_BUG.USER_ID IS '신고자 아이디';
COMMENT ON COLUMN CS_BUG.TITLE IS '제목';
COMMENT ON COLUMN CS_BUG.CONTENT IS '내용';

--drop table cs_bug;
create sequence seq_cs_bug;
--drop sequence seq_cs_bug;
select * from cs_bug;
--insert into cs_bug (num, user_id, title, content) 
--values (seq_cs_bug.nextval, 'tester', 'ddd', 'dddd');

CREATE TABLE SOMOIM_BOARD_COMMENTS
(
  NUM NUMBER NOT NULL
, SOM_MEMBER_NUM NUMBER NOT NULL
, CONTENT VARCHAR2(2000 BYTE) NOT NULL
, WRITE_DATE DATE DEFAULT sysdate NOT NULL
, GOOD_COUNT NUMBER DEFAULT 0 NOT NULL
, SOM_BOARD_NUM NUMBER DEFAULT NULL NOT NULL
, PARENT_COM NUMBER DEFAULT 0 NOT NULL
, SOM_COMMENT_DEPTH NUMBER DEFAULT 0 NOT NULL
, SOMOIM_NUM NUMBER
, CONSTRAINT SOMOIM_BOARD_COMMENTS_PK PRIMARY KEY
  (
    NUM
  )
  USING INDEX
  (
      CREATE UNIQUE INDEX SOMOIM_BOARD_COMMENTS_PK ON SOMOIM_BOARD_COMMENTS (NUM ASC)
      LOGGING
      TABLESPACE SYSTEM
      PCTFREE 10
      INITRANS 2
      STORAGE
      (
        INITIAL 65536
        NEXT 1048576
        MINEXTENTS 1
        MAXEXTENTS UNLIMITED
        FREELISTS 1
        FREELIST GROUPS 1
        BUFFER_POOL DEFAULT
      )
      NOPARALLEL
  )
  ENABLE
)
LOGGING
TABLESPACE SYSTEM
PCTFREE 10
PCTUSED 40
INITRANS 1
STORAGE
(
  INITIAL 65536
  NEXT 1048576
  MINEXTENTS 1
  MAXEXTENTS UNLIMITED
  FREELISTS 1
  FREELIST GROUPS 1
  BUFFER_POOL DEFAULT
)
NOPARALLEL;
ALTER TABLE SOMOIM_BOARD_COMMENTS
ADD CONSTRAINT SOMOIM_BOARD_COMMENTS_FK1 FOREIGN KEY
(
  SOM_BOARD_NUM
)
REFERENCES SOMOIM_BOARD
(
  NUM
)
ENABLE;
ALTER TABLE SOMOIM_BOARD_COMMENTS
ADD CONSTRAINT SOMOIM_BOARD_COMMENTS_FK2 FOREIGN KEY
(
  SOM_MEMBER_NUM
)
REFERENCES SOMOIM_MEMBER
(
  NUM
)
ENABLE;
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.NUM IS 'PK';
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.SOM_MEMBER_NUM IS '댓글 작성자 고유번호';
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.CONTENT IS '댓글 내용';
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.WRITE_DATE IS '댓글 작성 날짜';
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.GOOD_COUNT IS '좋아요';
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.SOM_BOARD_NUM IS '게시글 번호';
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.PARENT_COM IS '부모 댓글 num';
COMMENT ON COLUMN SOMOIM_BOARD_COMMENTS.SOM_COMMENT_DEPTH IS '댓글 대댓글 구분';


--select * from somoim_member where user_id='tester' and somoim_num=40;


CREATE TABLE EVENTS
(
  USER_ID VARCHAR2(50 BYTE) NOT NULL
, TITLE VARCHAR2(100 BYTE) NOT NULL
, NUM VARCHAR2(20 BYTE) NOT NULL
, CONTENT VARCHAR2(1000 BYTE) NOT NULL
, EVENT_WDATE DATE DEFAULT sysdate NOT NULL
, SAVE_NAME VARCHAR2(50 BYTE) DEFAULT 123123 NOT NULL
, START_EVENTS DATE
, END_DATE DATE
, WINNER NUMBER DEFAULT 0
, EVENT_TARGET VARCHAR2(100 BYTE)
, PRESENT VARCHAR2(100 BYTE)
, CONSTRAINT EVENTS_PK PRIMARY KEY
  (
    NUM
  )
  USING INDEX
  (
      CREATE UNIQUE INDEX EVENTS_PK ON EVENTS (NUM ASC)
      LOGGING
      TABLESPACE SYSTEM
      PCTFREE 10
      INITRANS 2
      STORAGE
      (
        INITIAL 65536
        NEXT 1048576
        MINEXTENTS 1
        MAXEXTENTS UNLIMITED
        FREELISTS 1
        FREELIST GROUPS 1
        BUFFER_POOL DEFAULT
      )
      NOPARALLEL
  )
  ENABLE
)
LOGGING
TABLESPACE SYSTEM
PCTFREE 10
PCTUSED 40
INITRANS 1
STORAGE
(
  INITIAL 65536
  NEXT 1048576
  MINEXTENTS 1
  MAXEXTENTS UNLIMITED
  FREELISTS 1
  FREELIST GROUPS 1
  BUFFER_POOL DEFAULT
)
NOPARALLEL;
create sequence seq_events;
COMMENT ON COLUMN EVENTS.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN EVENTS.TITLE IS '공지 제목';
COMMENT ON COLUMN EVENTS.NUM IS 'pk';
COMMENT ON COLUMN EVENTS.CONTENT IS '공지 내용';
COMMENT ON COLUMN EVENTS.EVENT_WDATE IS '등록 날짜';
COMMENT ON COLUMN EVENTS.SAVE_NAME IS '등록 사진';
COMMENT ON COLUMN EVENTS.START_EVENTS IS '이벤트 시작 일시';
COMMENT ON COLUMN EVENTS.END_DATE IS '이벤트 종료 일시';
COMMENT ON COLUMN EVENTS.WINNER IS '당첨 인원';
COMMENT ON COLUMN EVENTS.EVENT_TARGET IS '이벤트 대상';
COMMENT ON COLUMN EVENTS.PRESENT IS '당첨 상품';


--------------------------------------------------------
--  DDL for Table GOOD_COUNT_LIST
--------------------------------------------------------

  CREATE TABLE "ONANDOFF"."GOOD_COUNT_LIST" 
   (   "USER_ID" VARCHAR2(200 BYTE), 
   "LIST_NUM" NUMBER, 
   "NUM" NUMBER, 
   "GOOD_COUNT" NUMBER DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table GOOD_COUNT_LIST
--------------------------------------------------------

  ALTER TABLE "ONANDOFF"."GOOD_COUNT_LIST" MODIFY ("GOOD_COUNT" NOT NULL ENABLE);
  ALTER TABLE "ONANDOFF"."GOOD_COUNT_LIST" MODIFY ("NUM" NOT NULL ENABLE);
  ALTER TABLE "ONANDOFF"."GOOD_COUNT_LIST" MODIFY ("LIST_NUM" NOT NULL ENABLE);
  ALTER TABLE "ONANDOFF"."GOOD_COUNT_LIST" MODIFY ("USER_ID" NOT NULL ENABLE);
  
  -------------------------------------------------------
--  DDL for Sequence SEQ_GOOD_COUNT
--------------------------------------------------------

   CREATE SEQUENCE  "ONANDOFF"."SEQ_GOOD_COUNT"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
