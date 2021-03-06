/*
 *  File name:  setup.sql
 *  Function:   to create the initial database schema for the CMPUT 391 project,
 *              Winter Term, 2014
 *  Author:     Prof. Li-Yan Yuan
 */
DROP TABLE family_doctor;
DROP TABLE pacs_images;
DROP TABLE radiology_record;
DROP TABLE users;
DROP TABLE persons;
DROP TABLE log_in;
DROP SEQUENCE pic_id;
/*
 *  To store the personal information
 */
CREATE TABLE persons (
   person_id int,
   first_name varchar(24),
   last_name  varchar(24),
   address    varchar(128),
   email      varchar(128),
   phone      char(10),
   PRIMARY KEY(person_id),
   UNIQUE (email)
);

/*
 *  To store the log-in information
 *  Note that a person may have been assigned different user_name(s), depending
 *  on his/her role in the log-in  
 */
CREATE TABLE users (
   user_name varchar(24),
   password  varchar(24),
   class     char(1),
   person_id int,
   date_registered date,
   CHECK (class in ('a','p','d','r')),
   PRIMARY KEY(user_name),
   FOREIGN KEY (person_id) REFERENCES persons
);

/*
 *  to indicate who is whose family doctor.
 */
CREATE TABLE family_doctor (
   doctor_id    int,
   patient_id   int,
   FOREIGN KEY(doctor_id) REFERENCES persons,
   FOREIGN KEY(patient_id) REFERENCES persons,
   PRIMARY KEY(doctor_id,patient_id)
);

/*
 *  to store the radiology records
 */
CREATE TABLE radiology_record (
   record_id   int,
   patient_id  int,
   doctor_id   int,
   radiologist_id int,
   test_type   varchar(24),
   prescribing_date date,
   test_date    date,
   diagnosis    varchar(128),
   description   varchar(1024),
   PRIMARY KEY(record_id),
   FOREIGN KEY(patient_id) REFERENCES persons,
   FOREIGN KEY(doctor_id) REFERENCES  persons,
   FOREIGN KEY(radiologist_id) REFERENCES  persons
);

/*
 *  to store the pacs images
 */
CREATE TABLE pacs_images (
   record_id   int,
   image_id    int,
   thumbnail   blob,
   regular_size blob,
   full_size    blob,
   PRIMARY KEY(record_id,image_id),
   FOREIGN KEY(record_id) REFERENCES radiology_record
);


CREATE TABLE log_in (
   person_id   int,
   PRIMARY KEY(person_id)
);


Create SEQUENCE pic_id
MINVALUE 1
START WITH 1
INCREMENT BY 1
NOCACHE;


insert into persons values(1,'john','Gao','lister','123@gmail.com','7802545524');
insert into persons values(2,'Yu','Zuo','hub','124@gmail.com','7802545524');
insert into persons values(3,'jeff','Ye','hub9','125@gmail.com','7802132124');
insert into persons values(4,'bill','Jiang','lister','128@gmail.com','7802545524');
insert into persons values(5,'Bqi','Bowen','hub','126@gmail.com','7802545524');
insert into persons values(6,'Yu','Zuo','hub9999','127@gmail.com','7802132124');
insert into persons values(7,'DoctorJ','Ye','hub9','1@gmail.com','7802132124');
insert into persons values(8,'billD','Jiang','lister','328@gmail.com','7802545524');
insert into persons values(9,'BqiD','Bowen','hub','146@gmail.com','7802545524');
insert into persons values(10,'YuD','Zuo','hub9999','227@gmail.com','7802132124');
insert into users values('johnU', '11111','a',1,sysdate);
insert into users values('maryU', '22222','p',2,sysdate);
insert into users values('jeffU', '33333','d',3,sysdate);
insert into users values('billU', '44444','p',4,sysdate);
insert into users values('bqiU', '55555','r',5,sysdate);
insert into users values('yuU', '66666','p',6,sysdate);
insert into users values('jeffDU', '33333','d',7,sysdate);
insert into users values('billDU', '44444','p',8,sysdate);
insert into users values('bqiDU', '55555','r',9,sysdate);
insert into users values('yuDU', '66666','p',10,sysdate);
insert into radiology_record values(1,2,3,5,'xray','01-JAN-2010','05-FEB-2010','dead','totalled dead');
insert into radiology_record values(2,2,3,5,'BloodTest','01-JAN-2011','05-FEB-2011','dead','totalled dead');
insert into radiology_record values(3,4,7,5,'xray','01-JAN-2012','05-FEB-2012','alive','pefect');
insert into radiology_record values(4,8,7,5,'BloodTest','01-JAN-2013','05-APR-2013','dead','totalled dead');
insert into radiology_record values(5,8,7,5,'BloodTest','05-JAN-2013','05-MAY-2013','dead','totalled dead');
insert into radiology_record values(6,8,7,5,'BloodTest','07-JAN-2013','05-JUN-2013','dead','totalled dead');

commit;
