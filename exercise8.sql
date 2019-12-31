select user from dual;

create table visitor(
   name   VARCHAR2(18),
   writedate   DATE,
   memo   varchar2(180)                                
   ); 
   
insert into visitor (writedate) values (sysdate);
insert into visitor (writedate) values (to_date('171225', 'rrmmdd'));
insert into visitor (writedate) values (to_date('990811', 'rrmmdd'));

create table member(
  m_id      VARCHAR2(12) PRIMARY KEY,
  m_pwd     VARCHAR2(12) NOT NULL,
  name      VARCHAR2(18) NOT NULL,
  joindate  DATE DEFAULT SYSDATE
);

create table news (
  id             NUMBER(8) PRIMARY KEY,
  writer         VARCHAR2(18) NOT NULL,
  title          VARCHAR2(120) NOT NULL,
  content        VARCHAR2(900),
  writedate      DATE,
  cnt            NUMBER(8)
);

create table meeting (
  id            NUMBER(8) PRIMARY KEY,
  name          VARCHAR2(18),
  title         VARCHAR2(120),
  meetingdate   DATE
);

select * from meeting;

commit;

create table imgtest (
  name         VARCHAR2(18) PRIMARY KEY,
  imgcontent   BLOB
);

select * from imgtest;

commit;

select * from tab;