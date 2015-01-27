BEGIN TRANSACTION;

CREATE TABLE "courses_backup" ("id" INTEGER PRIMARY KEY NOT NULL,"name" varchar(255) ,
  "company_id" integer ,
  "order_flg" boolean DEFAULT 'f' ,
  "book_flg" boolean DEFAULT 'f' ,
  "resume_flg" boolean DEFAULT 'f' ,
  "created_at" datetime,
  "updated_at" datetime,
  "diploma_flg" boolean DEFAULT 'f' ,
  "address" varchar(255),
  "station" varchar(255),
  "responsible" varchar(255),
  "tel" varchar(255),
  "observe_flg" boolean DEFAULT 'f' ,
  "students" integer,
  "attendee_table_flg" boolean DEFAULT 'f' ,
  "memo" text,
  "user_id" integer,
  "status" text DEFAULT 'draft');


INSERT INTO courses_backup SELECT id,name,company_id,order_flg,book_flg,resume_flg,created_at,updated_at,diploma_flg,address,station,responsible,tel,observe_flg,students,attendee_table_flg,memo,user_id,status FROM courses;

DROP TABLE courses;


CREATE TABLE "courses" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "name" varchar(255) ,
  "company_id" integer ,
  "order_flg" boolean DEFAULT 'f' ,
  "book_flg" boolean DEFAULT 'f' ,
  "resume_flg" boolean DEFAULT 'f' ,
  "created_at" datetime,
  "updated_at" datetime,
  "diploma_flg" boolean DEFAULT 'f' ,
  "address" varchar(255),
  "station" varchar(255),
  "responsible" varchar(255),
  "tel" varchar(255),
  "observe_flg" boolean DEFAULT 'f' ,
  "students" integer,
  "attendee_table_flg" boolean DEFAULT 'f' ,
  "memo" text,
  "user_id" integer,
  "status" varchar(255) DEFAULT 'draft');

INSERT INTO courses SELECT id,name,company_id,order_flg,book_flg,resume_flg,created_at,updated_at,diploma_flg,address,station,responsible,tel,observe_flg,students,attendee_table_flg,memo,user_id,status FROM courses_backup;

DROP TABLE courses_backup;
COMMIT;

