
DROP TABLE LIKES;
DROP TABLE REPLY_LIKES;
DROP TABLE REPLY;
DROP TABLE BOARD;
DROP TABLE FOLLOW;
DROP TABLE PROFILE;
DROP TABLE MEMBER;

DROP SEQUENCE PROFILE_SEQ;
DROP SEQUENCE FOLLOW_SEQ;
DROP SEQUENCE REPLY_SEQ;
DROP SEQUENCE BOARD_SEQ;
DROP SEQUENCE MEMBER_SEQ;
DROP SEQUENCE LIKES_SEQ;
DROP SEQUENCE REPLY_LIKES_SEQ;

CREATE SEQUENCE PROFILE_SEQ NOCACHE;
CREATE SEQUENCE FOLLOW_SEQ NOCACHE; 
CREATE SEQUENCE REPLY_SEQ NOCACHE; 
CREATE SEQUENCE BOARD_SEQ NOCACHE; 
CREATE SEQUENCE MEMBER_SEQ NOCACHE; 
CREATE SEQUENCE LIKES_SEQ NOCACHE;
CREATE SEQUENCE REPLY_LIKES_SEQ NOCACHE;


CREATE TABLE board (
    b_no     NUMBER NOT NULL,
    id       VARCHAR2(32 BYTE) NOT NULL,
    content  VARCHAR2(4000 BYTE),
    ip        varchar2(40 byte),
    location  varchar2(200 byte),
    origin   VARCHAR2(100 BYTE),
    saved    VARCHAR2(100 BYTE),
    path     VARCHAR2(200 BYTE),
    likes     NUMBER,
    created  DATE NOT NULL,
    modified DATE NOT NULL,
    state    NUMBER NOT NULL,
    depth    NUMBER(1),
    groupno    NUMBER(1),
    groupord NUMBER(1)
);

ALTER TABLE board ADD CONSTRAINT board_pk PRIMARY KEY ( b_no );


CREATE TABLE member (
    m_no     NUMBER NOT NULL,
    id       VARCHAR2(32 BYTE) NOT NULL,
    pw       VARCHAR2(64 BYTE) NOT NULL,
    name     VARCHAR2(32 BYTE)NOT NULL,
    email    VARCHAR2(100 BYTE) NOT NULL,
    birthday VARCHAR2(10 BYTE) NOT NULL,
    phone    VARCHAR2(12 BYTE) NOT NULL,
    gender   VARCHAR2(2 BYTE) NOT NULL,
    state    NUMBER(1),
    m_created date
);

ALTER TABLE member ADD CONSTRAINT member_pk PRIMARY KEY ( m_no );

ALTER TABLE member ADD CONSTRAINT member__un UNIQUE ( id );

CREATE TABLE profile (
    p_no       NUMBER PRIMARY KEY,
    id         VARCHAR2(32 BYTE) UNIQUE,
    p_content    VARCHAR2(1000 BYTE),
    p_origin   VARCHAR2(100 BYTE),
    p_saved    VARCHAR2(100 BYTE),
    P_PATH     VARCHAR2(200 BYTE)
);


CREATE TABLE follow (
    f_no      NUMBER,
    following_id VARCHAR2(32 BYTE) NOT NULL,
    followed_id  VARCHAR2(32 BYTE) NOT NULL
);

ALTER TABLE follow ADD CONSTRAINT follow_pk PRIMARY KEY ( f_no );
ALTER TABLE follow ADD CONSTRAINT following_id_profile_fk FOREIGN KEY (following_id) REFERENCES profile(id);
ALTER TABLE follow ADD CONSTRAINT followed_id_profile_fk FOREIGN KEY (followed_id) REFERENCES profile(id);
ALTER TABLE follow ADD CONSTRAINT follow_unique UNIQUE (following_id , followed_id);



CREATE TABLE reply (
    r_no     NUMBER NOT NULL,
    id       VARCHAR2(32 BYTE) NOT NULL,
    b_no     NUMBER NOT NULL,
    r_content  VARCHAR2(1000 BYTE) NOT NULL,
    r_likes   NUMBER,
    r_created  DATE NOT NULL,
    r_modified DATE,
    state    NUMBER(1),
    depth    NUMBER(1),
    groupno    NUMBER(1),
    groupord NUMBER(1)
);

ALTER TABLE reply ADD CONSTRAINT reply_pk PRIMARY KEY ( r_no );

ALTER TABLE board
    ADD CONSTRAINT board_member_fk FOREIGN KEY ( id )
        REFERENCES member ( id )
            ON DELETE CASCADE;



ALTER TABLE reply
    ADD CONSTRAINT reply_board_fk FOREIGN KEY ( b_no )
        REFERENCES board ( b_no )
            ON DELETE CASCADE;

ALTER TABLE reply
    ADD CONSTRAINT reply_member_fk FOREIGN KEY ( id )
        REFERENCES member ( id )
            ON DELETE CASCADE;






create table likes (
  like_no   number not null primary key,
  b_no number,
  id varchar2(32 byte),
  like_check number,
  like_date Date
);



create table reply_likes (
  r_like_no   number not null primary key,
  r_no number,
  b_no number,
  id varchar2(32 byte),
  r_like_check number,
  r_like_date Date
);


ALTER TABLE likes
    ADD CONSTRAINT likes_board_fk FOREIGN KEY ( b_no )
        REFERENCES board ( b_no )
            ON DELETE CASCADE;
ALTER TABLE likes
    ADD CONSTRAINT likes_member_fk FOREIGN KEY ( id )
        REFERENCES member ( id )
            ON DELETE CASCADE;            
        
        

ALTER TABLE reply_likes
    ADD CONSTRAINT reply_likes_reply_fk FOREIGN KEY ( r_no )
        REFERENCES reply ( r_no )
            ON DELETE CASCADE;
ALTER TABLE reply_likes
    ADD CONSTRAINT reply_likes_member_fk FOREIGN KEY ( id )
        REFERENCES member ( id )
            ON DELETE CASCADE;            
ALTER TABLE reply_likes
    ADD CONSTRAINT reply_likes_board_fk FOREIGN KEY ( b_no )
        REFERENCES BOARD ( b_no )
            ON DELETE CASCADE;            
        