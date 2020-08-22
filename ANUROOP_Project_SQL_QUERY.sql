
create table DEPT(
DEPTNO number(10)
constraint depn_PKey Primary Key,
DNAME Varchar2(20),
LOC Varchar2(20));
insert into DEPT values(&DEPTNO,'&DNAME','&LOC');

create table EMP(
EMPNO  number(10)
constraint empn_Pkey Primary Key,
ENAME  Varchar2(20),
JOBNAME   CHAR(20),
MGR number(20),
HIREDATE Date,
SAL number(10),
COMM number(10),
DEPTNO number(10)
constraint depn_FKey REFERENCES
DEPT(DEPTNO));
insert into EMP values(&EMPNO,'&ENAME','&JOBNAME',&MGR,'&HIREDATE',&SAL,&COMM,&DEPTNO);


select * from emp;
select ename from emp where jobname in('Analysts','Salesman');
select * from EMP where HIREDATE < '30-SEP-1981';
select ename from emp where jobname !='Manager';
select ename from emp where empno in (7369,7521,7839,7934,7788);
select ename from emp where deptno not in (30,40,10);
select ename from emp where hiredate between '30-JUN-1981' and '30-DEC-1981';
select  unique jobname from emp;
select comm from emp;
select ename from emp where comm is null;
select ename,jobname from emp where mgr is null;
select * from emp;
select ename from emp where deptno is null;
select * from emp where comm is not null;
select ename from EMP where ename LIKE ('S%') or ename LIKE('%s');
select ename from emp where ename like ('_i%');
select * from dept;
select count(*) FROM emp;
select count(distinct jobname) from emp;
select sum(sal) from emp;
select max(sal) from emp;
select min(sal) from emp;
select avg(sal) from emp;
select max(sal) from emp where jobname ='Salesman';


select count(*),avg(sal) from emp where deptno = 20;
select * from emp;
select ename,sal,sal*.10PF from emp;
select * from emp where to_char(sysdate,'yyyy')-to_char(hiredate,'yyyy')>=25;
select * from emp  ORDER BY sal;
select * from emp order by sal desc;
select ename,hiredate from emp order by hiredate desc;
select ename,sal,sal*.10PF,sal*.50HRA,sal*.30DA,sal+sal*.10+sal*.50+sal*.30 as gross from emp order by gross;
SELECT count(empno),deptno from emp group by deptno;
select count(*),deptno from emp where deptno=20 group by deptno;
select deptno, sum(sal) from emp group by deptno;
select jobname, count(*) from emp group by jobname order by jobname desc;
select sum(sal),min(sal),max(sal),avg(sal),jobname from emp group by jobname;
select sum(sal),min(sal),max(sal),avg(sal), deptno from emp where deptno=20 group by deptno;
select avg(sal),jobname,deptno from emp where deptno=20 and sal>1000 group by jobname,deptno;
select sal,jobname,deptno from emp where deptno=20 and sal>1000 group by sal,jobname,deptno;


create table Trainer(
TrainerID number(2) constraint TID_Pkey primary key,
TrainerName Varchar2(10) constraint TN not null,
EmailID varchar2(10) constraint EID unique,
Phone varchar2(10));

insert into Trainer values(&TrainerID,'&TrainerName','&EmailID','&Phone');
select * from trainer;
create table Course_Details(
CourseID char(3) constraint Cid_Pkey primary key,
CourseName Varchar2(30) constraint CN not null);
insert into Course_Details values('&CourseID','&CourseName');
select * from course_details;

create table Batch_Schedule(
BatchName varchar2(8),
CourseID char(3) constraint cid_Fkey references Course_Details(CourseID),
Start_Date DATE constraint SD1 not null,
End_Date DATE constraint ED1 not null,
constraint check1 check(End_Date>=Start_Date),
constraint Batch_Pkey primary key(BatchName,CourseID));
select * from batch_schedule;
insert into batch_schedule values('&BatchName','&CourseID','&Start_Date','&End_Date');

create table FeedBack(
TrainerID number(2) constraint TID_Fkey references Trainer(TrainerID),
CourseID char(3),
BatchName varchar2(8),
FBRate number(4,2) constraint FBR not null,constraint FBR_check check(FBRate between 0 and 5),
constraint FB_Fkey foreign key (BatchName,CourseID) references Batch_Schedule(BatchName,CourseID),
constraint FB_Pkey primary key(TrainerID,BatchName,CourseID));
desc FeedBack;
insert into FeedBack values(&TrainerID,'&CourseID','&BatchName',&FBRate)
select * FROM feedback;
select TrainerName,CourseID,BatchName,FBRate from Trainer,FeedBack where Trainer.TrainerID=Feedback.TrainerID;
select coursename,fbrate from course_details,feedback where course_details.courseid=feedback.courseid;
select Trainername,coursename,batchname,fbrate from trainer,course_details,feedback where feedback.trainerid=trainer.trainerid and feedback.courseid=course_details.courseid;
select Trainername,count(FeedBack.TrainerID) from Trainer,FeedBack where Trainer.TrainerID=FeedBack.TrainerID group by trainername having count(FeedBack.TrainerID)>1;
select feedback.trainerid,Trainername,avg(FeedBack.FBRate) from Trainer,FeedBack where Trainer.TrainerID=FeedBack.TrainerID group by Trainername,feedback.trainerid having avg(FeedBack.FBRate)>4.3;
select trainer.trainername,feedback.trainerid,course_details.coursename,feedback.courseid,count(feedback.courseid) FROM trainer,feedback,course_details where course_details.courseid=feedback.courseid and feedback.trainerid=trainer.trainerid group by trainer.trainername,feedback.trainerid,course_details.coursename,feedback.courseid;
select a.batchname,a.courseid,a.start_date from batch_schedule a,batch_schedule b where a.start_date= b.start_date group by a.batchname, a.courseid, a.start_date having count(a.start_date)>1;
select batch_schedule.batchname,feedback.trainerid,trainer.trainername,course_details.coursename,batch_schedule.start_date from batch_schedule,course_details,trainer,feedback where batch_schedule.start_date='10-JAN-2008' and (batch_schedule.courseid=course_details.courseid)and(feedback.batchname=batch_schedule.batchname)and(feedback.trainerid=trainer.trainerid)and(feedback.courseid=batch_schedule.courseid);
select course_details.coursename,avg(feedback.FBRate) FROM course_details,feedback where course_details.courseid=feedback.courseid group by course_details.coursename;
select courseid,avg(fbrate)from feedback group by courseid order by avg(fbrate) desc;
select feedback.trainerid,feedback.courseid,course_details.coursename,course_details.courseid from feedback,course_details where feedback.courseid(+)=course_details.courseid;


create table customer(
cust_id number(3) constraint Pkey primary key,constraint cust_check check(cust_id between 100 and 10000),
cust_name varchar2(20),
annual_revenue number(10),
cust_type varchar2(20)
);
desc customer;
insert into customer values(&cust_id,'&cust_name','&annual_revenue','&cust_type');
select * FROM customer;
create table truck(
truck_no number(3) constraint truck_Pkey primary key, 
driver_name varchar2(20));
insert into truck values(&truck_no,'&drivername');
select * from truck;
create table city(
city_name varchar2(20) constraint city_PKey primary key, 
population number(15));
insert into city values('&city_name',&population);
select * from city;
create table shipment(
shipment_no number(3) constraint sno_Pkey primary key,
cust_id number(3) constraint Fkey references customer(cust_id)on delete cascade,
weight number(4) constraint wt_check check(weight between 10 and 1000),
truck_no number(3) constraint Fkey1 references truck(truck_no) on delete set null,
destination varchar2(20) constraint Fkey2 references city(city_name) on delete set null);
insert into shipment values(&shipment_no,&cust_id,&weight,&truck_no,'&destination');
select * from shipment;


select truck.driver_name,shipment.destination from truck,shipment where truck.truck_no=shipment.truck_no and shipment.destination='Rome';
select customer.cust_name,shipment.cust_id,count(shipment.shipment_no) FROM customer,shipment where customer.cust_id=shipment.cust_id group by customer.cust_name,shipment.cust_id having count(shipment.shipment_no)>1;
select truck.driver_name,sum(shipment.weight) FROM truck,shipment where truck.truck_no=shipment.truck_no group by truck.driver_name having sum(weight)>1000;
select cust_name,annual_revenue from customer where not exists (select * from shipment where customer.cust_id=shipment.cust_id);
select population,shipment.destination from city,shipment where city.city_name=shipment.destination  group by population, shipment.destination having population>100000000 and count(destination)>1;
select truck.driver_name,sum(shipment.weight) FROM truck,shipment where truck.truck_no=shipment.truck_no group by truck.driver_name having sum(weight)>1000;
select customer.cust_name,sum(shipment.weight) from customer,shipment where customer.cust_id=shipment.cust_id group by customer.cust_name having sum(shipment.weight)=max(shipment.weight);


select cust_id,count(truck_no) from shipment group by cust_id having count(truck_no)>3;
select truck.driver_name from truck where not exists(select* FROM city where not EXISTS(select * from shipment where shipment.destination=city.city_name and truck.truck_no=shipment.truck_no));
select city.city_name from city where not exists (select * from shipment where not exists(select * from customer where shipment.cust_id!=customer.cust_id));
select cust_name FROM customer where not exists (select * from truck where not exists(select * from shipment where truck.truck_no=shipment.truck_no));