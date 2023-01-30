create proc createAllTables
AS
CREATE TABLE SystemUser
(
  username varchar(20) Not null,
  Password varchar(20) Not null,
  constraint SystemUser_PK PRIMARY KEY (username)
);

CREATE TABLE Stadium_Manager
(
  ID INT identity,
  Name varchar(20),
  username varchar(20),
  constraint Stadium_Manager_PK PRIMARY KEY (ID),
  constraint Stadium_Manager_FK FOREIGN KEY (username) REFERENCES SystemUser 
);

CREATE TABLE Club_representative
(
  ID INT identity,
  Name varchar(20),
  username varchar(20),
  constraint Club_representative_PK PRIMARY KEY (ID),
   constraint Club_representative_FK FOREIGN KEY (username) REFERENCES SystemUser
);

CREATE TABLE Fan
(
  National_ID varchar(20) ,
  Phone_Number varchar(20),
  Name varchar(20),
  Address varchar(20),
  Status bit default 1,
  username varchar(20),
  birth_date date,
  constraint Fan_PK PRIMARY KEY (National_ID),
  constraint Fan_FK FOREIGN KEY (username) REFERENCES SystemUser
);

CREATE TABLE Sports_Association_Manager
(
  ID INT identity,
  name varchar(20),
  username varchar(20),
  constraint Sports_Association_Manager_PK PRIMARY KEY (ID),
  constraint Sports_Association_Manager_FK FOREIGN KEY (username) REFERENCES SystemUser
);

CREATE TABLE System_Admin
(
  ID INT identity,
  Name varchar(20),
  username varchar(20),
  constraint System_Admin_PK PRIMARY KEY (ID),
  constraint System_Admin_FK FOREIGN KEY (username) REFERENCES SystemUser
);

CREATE TABLE Club
(
  ID INT identity,
  name varchar(20),
  location varchar(20),
  ID_CR int,
  constraint Club_PK PRIMARY KEY (ID),
  constraint Club_FK FOREIGN KEY (ID_CR) REFERENCES Club_representative ,
  constraint club_name_unique Unique(name)
);

CREATE TABLE Host_request
(
  ID INT identity,
  Status varchar(20) default 'unhandled',
  Match_ID INT ,
  ID_Club_representative int,
  ID_Stadium_Manager int,
  constraint Host_request_PK PRIMARY KEY (ID),
  constraint Host_request_FK_SMID FOREIGN KEY (ID_Stadium_Manager) REFERENCES Stadium_Manager,
  constraint Host_request_FK_CRID FOREIGN KEY (ID_Club_representative) REFERENCES Club_representative
);
CREATE TABLE Stadium
(
  ID INT identity,
  Name varchar(20),
  Capacity INT ,
  Location varchar(20),
  Status bit default 1,
  ID_SM int,
  constraint Stadium_PK PRIMARY KEY (ID),
  constraint Stadium_FK FOREIGN KEY (ID_SM) REFERENCES Stadium_Manager ,
  constraint stadium_name_unique Unique(name)
);

CREATE TABLE Match
(
  ID INT identity,
  End_time datetime not null ,
  Start_time datetime not null,
  ID_C1 INT ,
  ID_C2 INT ,
  ID_S INT ,
  constraint Match_PK PRIMARY KEY (ID),
  constraint Match_FKS FOREIGN KEY (ID_S) REFERENCES Stadium,
  constraint Match_FKC1 FOREIGN KEY (ID_C1) REFERENCES Club,
  constraint Match_FKC2 FOREIGN KEY (ID_C2) REFERENCES Club,
  check(ID_C1<>ID_C2),
  check( End_time>Start_time)
);
CREATE TABLE Ticket
(
  ID INT identity,
  Status bit default 1,
  ID_M INT ,
  ID_F varchar(20),
  constraint Ticket_PK PRIMARY KEY (ID),
  constraint Ticket_FKM FOREIGN KEY (ID_M) REFERENCES Match,
  constraint Ticket_FKF FOREIGN KEY (ID_F) REFERENCES Fan
);
create table tmp3
(
d int primary key
);
create table tmp2
(
di2 int primary key
);
go
create proc dropAllTables
AS
drop table Ticket
drop table Match
drop table Stadium
drop table Host_request
drop table Club
drop table System_Admin
drop table Sports_Association_Manager
drop table Fan
drop table Club_representative
drop table Stadium_Manager
drop table SystemUser
GO
create proc dropAllProceduresFunctionsViews
AS
drop proc createAllTables
drop proc dropAllTables
drop proc clearAllTables
drop view allAssocManagers
drop view allClubRepresentatives
drop view allStadiumManagers
drop view allFans
drop view allMatches
drop view allTickets
drop view allCLubs
drop view allStadiums
drop view allRequests
drop proc addAssociationManager
drop proc addNewMatch
drop view clubsWithNoMatches
drop proc deleteMatch
drop proc deleteMatchesOnStadium
drop proc addClub
drop proc addTicket
drop proc deleteClub
drop proc addStadium
drop proc deleteStadium
drop proc blockFan
drop proc unblockFan
drop proc addRepresentative
drop function viewAvailableStadiumsOn
drop proc addHostRequest
drop function allUnassignedMatches
drop proc addStadiumManager
drop function allPendingRequests
drop proc acceptRequest
drop proc rejectRequest
drop proc addFan
drop function upcomingMatchesOfClub
drop function availableMatchesToAttend
drop proc purchaseTicket
drop proc updateMatchHost
drop view matchesPerTeam
drop view clubsNeverMatched
drop function clubsNeverPlayed
drop function matchWithHighestAttendance
drop function matchesRankedByAttendance
drop function requestsFromClub
GO
create proc clearAllTables
AS
Execute dropAllTables
Execute createAllTables
GO
create view allAssocManagers
AS
select sm.username , su.Password , sm.name
from Sports_Association_Manager sm inner join SystemUser su
on sm.username=su.username 
GO
create view allClubRepresentatives
AS
select cr.username,su.Password,cr.Name as Club_Representative_Name,c.name as Club_Name
from Club_representative cr inner join Club c on cr.ID=c.ID_CR 
inner join SystemUser su on su.username=cr.username
GO
create view allStadiumManagers
AS
select sm.username,su.Password,sm.Name as Stadium_Manager_Name,s.Name as Stadium_Name
from Stadium_Manager sm inner join Stadium s on s.ID_SM=sm.ID
inner join SystemUser su on su.username=sm.username
GO
create view allFans
AS
select f.username,su.Password,f.name,f.National_ID,f.birth_date,f.status
from Fan f 
inner join SystemUser su on su.username=f.username
GO
create view allMatches
AS
select c1.name as 'host club' , c2.name as 'guest club'  , m.Start_time
from Club c1 inner join Match m on c1.ID=m.ID_C1 inner join Club c2 on c2.ID=m.ID_C2 
where m.ID_C1<>m.ID_C2
GO
create view allTickets
AS
select  c1.name as 'host club', c2.name as 'guest club',s.Name AS Stadium_Name ,m.Start_time from (Club c1 inner join Match m on c1.ID=m.ID_C1 inner join Club c2 on c2.ID=m.ID_C2 and m.ID_C1<>m.ID_C2) inner join Stadium s on m.ID_S = s.ID 
GO
create view allCLubs
AS
select c.name,c.location
from Club c
GO
create view allStadiums
AS
select s.Name,s.Location,s.Status,s.capacity
from Stadium s
GO
create view allRequests
AS
select cr.username AS  Club_representative_User_Name, sm.username AS Stadium_Manager_User_Name , hr.Status
from Host_request hr , Club_representative cr , Stadium_Manager sm
where hr.ID_Club_representative=cr.ID and hr.ID_Stadium_Manager = sm.ID 
GO
create proc addAssociationManager
@name varchar(20),
@username varchar(20),
@pass varchar(20)
AS
Declare @check varchar(20);
select @check=Password
from SystemUser
where username=@username;
if(@check is null)
BEGIN

insert into SystemUser (username,Password) Values (@username,@pass);
insert into Sports_Association_Manager (name,username) Values (@name,@username); 

END
else
BEGIN
print ('ERROR , This username already exists in the DataBase');
END
GO
create proc addNewMatch 
@c1n varchar(20),
@c2n varchar(20),
@date datetime,
@enddate datetime
AS
declare @c1_ID int
declare @c2_ID int
 select @c1_ID= c.ID
 from Club c
 where c.name = @c1n; 
 select @c2_ID= c.ID
 from Club c
 where c.name = @c2n; 
insert into Match (ID_C1,ID_C2,Start_time,End_time) Values (@c1_ID,@c2_ID,@date,@enddate); 
GO
create view clubsWithNoMatches
AS
select c.name
from Club c
where c.ID not in (
select cc.ID
from Club cc inner join Match m on cc.ID =m.ID_C1

) and c.ID not in(
select cc2.ID
from Club cc2 inner join Match m on cc2.ID =m.ID_C2



)
GO
create proc deleteMatch
@c1n varchar(20),
@c2n varchar(20)
AS
declare @c1id int
declare @c2id int
 select @c1id= c.ID
 from Club c
 where c.name = @c1n; --get the 1st club ID
 select @c2id= c.ID
 from Club c
 where c.name = @c2n  --get the 2nd club ID
 declare @mid int;
 select @mid=ID
 from Match
 where ID_C1=@c1id and ID_C2=@c2id;
 delete from Ticket 
 where ID_M = @mid;
 delete from Host_request
 where Match_ID=@mid;
 delete from Match
 where ID = @mid;
GO
create proc deleteMatchesOnStadium
@sn varchar(20)
AS
declare @sid int;
select @sid=ID
from Stadium
where Name = @sn;

select m.ID as di into tmp   from Match m where m.ID_S=@sid and m.End_time > CURRENT_TIMESTAMP;
delete from Ticket where ID_M in(select di from tmp);

delete from Match 
Where ID_S = @sid and End_time > CURRENT_TIMESTAMP
GO
create proc addClub
@cn varchar(20),
@cl varchar(20)
AS
insert into Club (name,location) values (@cn,@cl);
GO
create proc addTicket
@hn varchar(20),
@cn varchar(20),
@date datetime 
AS
Declare @mid int;
Declare @sid int;
select @mid=m.ID,@sid=ID_S
from Club c1 inner join Match m on m.ID_C1=c1.ID inner join Club c2 on m.ID_C2=c2.ID 
where c1.ID<>c2.ID and m.Start_time=@date and c1.name=@hn and c2.name=@cn ;

Declare @allow bit;
set @allow = 0;
if(@sid is not null)
BEGIN
Declare @cap int;
select @cap=Capacity
from Stadium
where ID = @sid;
Declare @sub int;
select @sub = count(*)
from Ticket
where ID_M = @mid;
Declare @ans int;
set @ans = @cap - @sub;
if(@ans>0)
BEGIN
set @allow=1;
END
END

if(@mid is not null and @sid is not null and @allow=1)
BEGIN
insert into Ticket (ID_M) values (@mid);
END;
GO


create proc deleteClub
@cn varchar(20)
AS
Declare @cid int;
select @cid=c.ID
from Club c
where c.name=@cn;
insert into tmp2(di2)
select m.ID as di2  from Match m where m.ID_C1=@cid or m.ID_C2 = @cid;
delete from Ticket where ID_M in (select di2 from tmp2);
delete from Host_request where Match_ID in (select di2 from tmp2);
delete from Match where ID in (select di2 from tmp2);
delete from Club where ID=@cid
GO


create proc addStadium
@sn varchar(20),
@sl varchar(20),
@c int
AS
insert into Stadium (Name,Location,Capacity) values(@sn,@sl,@c); 
GO

create proc deleteStadium
@sn varchar(20)
AS
Declare @sid int;
select @sid=ID
from Stadium
where Name=@sn;
insert into tmp3(d)
select m.ID as d  from Match m where m.ID_S=@sid ;
delete from Ticket where ID_M in(select d from tmp3 );
delete from Host_request where Match_ID in(select d from tmp3 );
delete from Match where ID in(select d from tmp3 );
delete from Stadium where ID=@sid;
GO
create proc blockFan
@nid int
AS
update Fan
set Status=0
where National_ID=@nid
GO
create proc unblockFan
@nid int
AS
update Fan
set Status=1
where National_ID=@nid
GO
create proc addRepresentative
@name varchar(20),
@cn varchar(20),
@un varchar(20),
@pass varchar(20)
AS
Declare @check varchar(20);
select @check=Password
from SystemUser
where username=@un;
if(@check is null)
BEGIN

insert into SystemUser (username,Password) values (@un,@pass);
insert into Club_representative (Name,username) values(@name,@un);
DECLARE @crid int
select @crid=ID from Club_representative where username=@un;
update Club
set ID_CR = @crid
where name=@cn;

END
else
BEGIN
print ('ERROR , This username already exists in the DataBase');
END
GO
create function availableMatchesToAttend
(@date datetime)
returns table
AS
return
select distinct c1.name AS host_club , c2.name AS guest_club , m.Start_time,s.Name as Stadium_Name, s.Location as Stadium_Location, m.ID as match_id
from Club c1 inner join Match m on c1.ID=m.ID_C1
inner join Club c2 on m.ID_C2=c2.ID
inner join Stadium s on s.ID=m.ID_S
inner join Ticket t on t.ID_M=m.ID
where m.Start_time >= @date and exists (
select t2.ID
from Ticket t2 inner join Match m2 on t2.ID_M=m2.ID and m2.ID=m.ID
where t2.Status = 1
)
GO
create proc addHostRequest
@club_name varchar(20),
@stad_name varchar(20),
@date datetime
AS
DECLARE @crid int;
DECLARE @smid int;
DECLARE @mid int;
select @crid=ID_CR
from Club
where name=@club_name;
select @smid=ID_SM
from Stadium
where Name=@stad_name;

Declare @idh int;
select @idh=ID
from Club
where name=@club_name;

select @mid=ID
from Match
where Start_time=@date and ID_C1=@idh ; --and ID_S=@smid
insert into Host_request(Match_ID,ID_Club_representative,ID_Stadium_Manager) Values(@mid,@crid,@smid);
GO
create function allUnassignedMatches
(@club varchar(20))
returns table
AS
return 
select c2.name , m.Start_time
from Club c1 inner join Match m on c1.ID=m.ID_C1 inner join Club c2 on m.ID_C2=c2.ID
where m.ID_S is null and c1.name=@club
GO
create proc addStadiumManager
@name varchar(20),
@stad_name varchar(20),
@username varchar(20),
@pass varchar(20)
AS
Declare @check varchar(20);
select @check=Password
from SystemUser
where username=@username;
if(@check is null)
BEGIN

insert into SystemUser(username,Password) VALUES (@username,@pass);
insert into Stadium_Manager (Name,username) VALUES (@name,@username);
DECLARE @smid int ;
select @smid=ID
from Stadium_Manager
where username=@username;
update Stadium
set ID_SM=@smid
where Name=@stad_name;

END
else
BEGIN
print ('ERROR , This username already exists in the DataBase');
END
GO
create function allPendingRequests
(@name varchar(20))
returns table
AS
return
select cr.Name AS 'Club Representitive Name',c2.name AS 'Guest Club Name',m.Start_time
from Stadium_Manager sm inner join Host_request h on sm.ID = h.ID_Stadium_Manager 
inner join Match m on m.ID=h.Match_ID
inner join Club_representative cr on h.ID_Club_representative=cr.ID
inner join Club c1 on m.ID_C1=c1.ID
inner join Club c2 on m.ID_C2=c2.ID 
where h.Status = 'unhandled' and sm.username=@name and c1.ID_CR=cr.ID
GO
create proc acceptRequest
@smn varchar(20),
@hcn varchar(20),
@ccn varchar(20),
@date datetime
AS
DECLARE @smid int ;
declare @c1id int;
declare @c2id int;
declare @idcr int;
declare @mid int;
declare @tmp int;

select @c1id=ID
from Club
where name=@hcn;
select @idcr=ID_CR
from Club
where name=@hcn;

select @c2id=ID
From Club
where name=@ccn;

select @mid=m.ID
from Match m
where ID_C1=@c1id and ID_C2=@c2id and Start_time = @date;

select @smid=s.ID
from Stadium_Manager s
where s.username=@smn

select @tmp=s5.Capacity
from Stadium s5
where s5.ID_SM=@smid

Declare @stad_id int;
select @stad_id=ID
from Stadium
where ID_SM=@smid


Declare @i int ;
set @i = 1;

declare @the_condition_that_will_check varchar(20) ;
select @the_condition_that_will_check=Status
from Host_request
where Match_ID=@mid and ID_Club_representative = @idcr and ID_Stadium_Manager = @smid  ;

 update Match
 set ID_S = @stad_id
 where ID = @mid

 WHILE @i <= @tmp and @the_condition_that_will_check = 'unhandled' and @mid is not null
 BEGIN
  execute addTicket @hcn,@ccn,@date ;
   set @i = @i +1;
 END




update Host_request
set Status='accepted'
where Match_ID=@mid and ID_Club_representative = @idcr and ID_Stadium_Manager = @smid and Status = 'unhandled';
GO
create proc rejectRequest
@smn varchar(20),
@hcn varchar(20),
@ccn varchar(20),
@date datetime
AS
DECLARE @smid int ;
declare @c1id int;
declare @c2id int;
declare @idcr int;
declare @mid int;
declare @tmp int;

select @c1id=ID
from Club
where name=@hcn;
select @idcr=ID_CR
from Club
where name=@hcn;

select @c2id=ID
From Club
where name=@ccn;

select @mid=m.ID
from Match m
where ID_C1=@c1id and ID_C2=@c2id and Start_time = @date;

select @smid=s.ID
from Stadium_Manager s
where s.username=@smn

update Host_request
set Status='rejected'
where Match_ID=@mid and ID_Club_representative = @idcr and ID_Stadium_Manager = @smid and Status = 'unhandled';
GO
create proc addFan
@name varchar(20),
@username  varchar(20),
@pass  varchar(20),
@nid varchar(20),
@date datetime,
@add varchar(20),
@pn int
AS
Declare @check varchar(20);
select @check=Password
from SystemUser
where username=@username;
if(@check is null)
BEGIN

insert into SystemUser (username,Password) values (@username,@pass);
insert into Fan (Name,username,National_ID,birth_date,Address,Phone_Number) values (@name,@username,@nid,@date,@add,@pn);

END
else
BEGIN
print ('ERROR , This username already exists in the DataBase');
END
GO
create function upcomingMatchesOfClub
(@club_name varchar(20))
returns table
AS
return
select c1.name as 'Host Club Name',c2.name AS 'Competing Club Name',m.Start_time,s.Name as 'Stadium Name'
from Club c1 inner join Match m on (c1.ID=m.ID_C1)
inner join Club c2 on (c2.ID = m.ID_C2 )
inner join Stadium s on s.ID=m.ID_S
where ( (c1.name=@club_name  and   c2.name <> @club_name)  or  (c2.name=@club_name  and  c1.name <> @club_name ) ) and m.Start_time > CURRENT_TIMESTAMP
GO
create function availableMatchesToAttend
(@date datetime)
returns table
AS
return
select distinct c1.name AS host_club , c2.name AS guest_club , m.Start_time,s.Name as Stadium_Name
from Club c1 inner join Match m on c1.ID=m.ID_C1
inner join Club c2 on m.ID_C2=c2.ID
inner join Stadium s on s.ID=m.ID_S
inner join Ticket t on t.ID_M=m.ID
where m.Start_time >= @date and exists (
select t2.ID
from Ticket t2 inner join Match m2 on t2.ID_M=m2.ID and m2.ID=m.ID
where t2.Status = 1
)
GO
create proc purchaseTicket
@nid varchar(20),
@hcn varchar(20),
@ccn varchar(20),
@date datetime
AS
declare @mid int;
declare @c1id int;
declare @c2id int;
select @c1id =ID
from Club
where name=@hcn;
select @c2id=ID
from Club
where name=@ccn;
select @mid=ID
from Match
where ID_C1=@c1id and ID_C2=@c2id and Start_time=@date;
declare @tid int;
select @tid= ID
from Ticket
where ID_M=@mid and Status=1 and ID_F is null;
update Ticket
set Status=0 
where ID=@tid ;
update Ticket
set ID_F = @nid
where ID=@tid ;
GO
create proc updateMatchHost
@hcn varchar(20),
@ccn varchar(20),
@date datetime
AS

declare @mid int;
declare @c1id int;
declare @c2id int;
select @c1id =ID
from Club
where name=@hcn;
select @c2id=ID
from Club
where name=@ccn;
select @mid=ID
from Match
where ID_C1=@c1id and ID_C2=@c2id and Start_time=@date;

update Match
set ID_C1=@c2id , ID_C2=@c1id
where ID=@mid;
GO
create view matchesPerTeam
AS
select c.name , count(*) AS 'Number of Matches Played'
from Club c inner join Match m on (c.ID=m.ID_C1 or c.ID=m.ID_C2 )
where m.End_time < CURRENT_TIMESTAMP or m.End_time = CURRENT_TIMESTAMP
group by c.name
GO
create view clubsNeverMatched
AS
select c1.name as Club_one , c2.name as Club_two
from club c1 ,club c2
where not exists (
select m.ID_C1 , m.ID_C2  from Match m where m.ID_C1=c1.ID and m.ID_C2=c2.ID
)and not exists (
select m.ID_C1 , m.ID_C2  from Match m where m.ID_C2=c1.ID and m.ID_C1=c2.ID
)and  c1.name<>c2.name and c1.ID<c2.ID;
GO
Create function clubsNeverPlayed
(@clubname varchar(20))
returns table
as
return 
select C.name from club C where not exists(
select c2.name from club c1  
inner join match m on c1.ID = m.ID_C1 
inner join club c2  on c2.id = m.ID_C2 
where c1.name = @clubname 
and C.id = c2.id
and m.End_time <= CURRENT_TIMESTAMP
)
and not exists (
select c1.name from club c1 
inner join match m on c1.id = m.ID_C1 
inner join club c2 on m.ID_C2 = c2.id 
where c2.name = @clubname 
and C.id = c1.id
and m.End_time <= CURRENT_TIMESTAMP
)
and c.name<>@clubname;
GO
create function matchWithHighestAttendance
()
returns table
AS
return
select top 1 c1.name AS host_club , c2.name AS guest_club
from Club c1 inner join Match m on c1.ID=m.ID_C1
inner join Club c2 on c2.ID = m.ID_C2
inner join Ticket t on t.ID_M=m.ID
where t.Status=0
group by c1.name,c2.name
order by count(t.ID) desc
GO
create function matchesRankedByAttendance
()
returns table
AS
return
select TOP (100) PERCENT c1.name AS host_club , c2.name AS guest_club
from Club c1 inner join Match m on c1.ID=m.ID_C1
inner join Club c2 on c2.ID = m.ID_C2
inner join Ticket t on t.ID_M=m.ID
where t.Status=0
group by c1.name,c2.name
order by count(t.ID) desc
GO
create function requestsFromClub
(@stadname varchar(20),@clubname varchar(20))
returns  table
as
return
select c1.name as 'Host Club',c2.name as 'Guest Club'
from Stadium S inner join Match m on m.ID_S = S.ID
inner join Club c1 on m.ID_C1 = c1.ID 
inner join Club c2 on m.ID_C2 = c2.ID
inner join Host_request h on h.ID_Club_representative=c1.ID_CR
and h.Match_ID=m.ID
and h.ID_Stadium_Manager=s.ID_SM 
where s.name = @stadname and c1.name = @clubname
GO
create proc userLogin
@username varchar(20),
@password varchar(20),
@success int output,
@type int output ,
@user varchar(20) output
AS
if(@username='' or @password = '')
BEGIN
set @success=null;
END
IF EXISTS (SELECT * FROM SystemUser WHERE username = @username and Password = @password) 
BEGIN
   set @success=1;
   set @user = @username;
   IF EXISTS (SELECT * FROM System_Admin WHERE username = @username ) 
BEGIN
   set @type=1; 
END


IF EXISTS (SELECT * FROM Sports_Association_Manager WHERE username = @username ) 
BEGIN
  set @type=2;  
END


IF EXISTS (SELECT * FROM Club_representative WHERE username = @username ) 
BEGIN
  set @type=3; 
END


IF EXISTS (SELECT * FROM Stadium_Manager WHERE username = @username ) 
BEGIN
   set @type=4; 
END


IF EXISTS (SELECT * FROM Fan WHERE username = @username and Status=1 ) 
BEGIN
   set @type=5; 
END
IF EXISTS (SELECT * FROM Fan WHERE username = @username and Status=0 ) 
BEGIN
   set @type=6; 
END


END
ELSE
BEGIN
    set @success=null;
END
GO
create proc vClubAdd
@cn varchar (20),
@cl varchar(20),
@exists int output,
@empty int output
AS
set @exists = 0;
set @empty = 0;
if(@cn='' or @cl='')
BEGIN
set @empty =1;
END
if Exists (select c.ID from Club c where c.name = @cn and c.location = @cl )
BEGIN
set @exists = 1;
END
if(@exists=0 and @empty=0)
BEGIN
execute addClub @cn , @cl;
END
GO
create proc vClubDelete
@cn varchar (20),
@exists int output,
@empty int output
AS
set @exists = 0;
set @empty = 0;
if(@cn='' )
BEGIN
set @empty =1;
END
if Exists (select c.ID from Club c where c.name = @cn  )
BEGIN
set @exists = 1;
END
if(@exists=1 and @empty=0)
BEGIN
execute deleteClub @cn;
END
GO
create proc vAddStad
@cn varchar(20),
@cl varchar(20),
@cap int ,
@exists int output,
@empty int output
AS
set @exists = 0;
set @empty = 0;
if(@cn='' or @cl='' or @cap='')
BEGIN
set @empty =1;
END
if Exists (select s.ID from Stadium s where s.name = @cn and s.location = @cl and s.Capacity=@cap )
BEGIN
set @exists = 1;
END
if(@exists=0 and @empty=0)
BEGIN
insert into Stadium(Name,Location,Capacity)VAlues( @cn , @cl , @cap );
END
GO
create proc vDeleteStad
@cn varchar(20),
@exists int output,
@empty int output
AS
set @exists = 0;
set @empty = 0;
if(@cn='' )
BEGIN
set @empty =1;
END
if Exists (select s.ID from Stadium s where s.name = @cn  )
BEGIN
set @exists = 1;
END
if(@exists=1 and @empty=0)
BEGIN
execute deleteStadium @cn ;
END
GO
create proc vBlockFan
@cn int,
@exists int output,
@empty int output
AS
set @exists = 0;
set @empty = 0;
if(@cn='' )
BEGIN
set @empty =1;
END
if Exists (select s.Name from Fan s where s.National_ID = @cn  )
BEGIN
set @exists = 1;
END
if(@exists=1 and @empty=0)
BEGIN
if Exists (select s.Name from Fan s where s.National_ID = @cn and s.Status=0)
BEGIN
set @exists = 5;
END
ELSE
BEGIN
execute blockFan @cn ;
END
END
GO
create proc vAddSM
@name varchar(20),
@username varchar(20),
@pass varchar(20),
@stad_name varchar(20),
@error int output
AS
set @error=0;
if(@name='' or @username='' or @pass='' or @stad_name='')
BEGIN
set @error=1;
END
if not exists (select s.ID from Stadium s where s.Name=@stad_name)
BEGIN
set @error=1;
END
if exists (select s.username from SystemUser s where s.username=@username)
BEGIN
set @error=1;
END
if(@error=0)
BEGIN
execute addStadiumManager @name , @stad_name , @username , @pass
END
GO
create proc smC
@name varchar(20)
AS
select  s.*
from Stadium s inner join Stadium_Manager sm on s.ID_SM=sm.ID
where sm.username=@name
GO
create proc smR
@name varchar(20)
AS
select cr.Name AS 'Sending Club Representitive Name',c1.name AS 'Host Club Name',c2.name AS 'Guest Club Name',m.Start_time,m.End_time,h.Status,h.ID as 'Identifier'
from Stadium_Manager sm inner join Host_request h on sm.ID = h.ID_Stadium_Manager 
inner join Match m on m.ID=h.Match_ID
inner join Club_representative cr on h.ID_Club_representative=cr.ID
inner join Club c1 on m.ID_C1=c1.ID
inner join Club c2 on m.ID_C2=c2.ID 
where  sm.username=@name and c1.ID_CR=cr.ID
GO
create proc ar
@id int 
AS
DECLARE @smn varchar(20);
DECLARE @host varchar(20);
DECLARE @guest varchar(20);
Declare @date datetime;
select @smn=sm.username,@host=c1.name,@guest=c2.name,@date=m.Start_time
from Stadium_Manager sm inner join Host_request h on sm.ID = h.ID_Stadium_Manager 
inner join Match m on m.ID=h.Match_ID
inner join Club_representative cr on h.ID_Club_representative=cr.ID
inner join Club c1 on m.ID_C1=c1.ID
inner join Club c2 on m.ID_C2=c2.ID 
where h.Status = 'unhandled' and c1.ID_CR=cr.ID and h.ID=@id
execute acceptRequest @smn,@host,@guest,@date;
GO
create proc rr
@id int 
AS
DECLARE @smn varchar(20);
DECLARE @host varchar(20);
DECLARE @guest varchar(20);
Declare @date datetime;
select @smn=sm.username,@host=c1.name,@guest=c2.name,@date=m.Start_time
from Stadium_Manager sm inner join Host_request h on sm.ID = h.ID_Stadium_Manager 
inner join Match m on m.ID=h.Match_ID
inner join Club_representative cr on h.ID_Club_representative=cr.ID
inner join Club c1 on m.ID_C1=c1.ID
inner join Club c2 on m.ID_C2=c2.ID 
where h.Status = 'unhandled' and c1.ID_CR=cr.ID and h.ID=@id
execute rejectRequest @smn,@host,@guest,@date;
GO
create procedure doMExist
@Cname varchar(20),
@Date datetime ,
@Out int output
as
Declare @CID int;
Select @CID = ID from club where name = @Cname;

if exists (select * from Match where ID_C1 = @CID and Start_time = @Date and ID_S is null) begin
set @Out = 1;
end
else
set @Out = 0;
go
create procedure getCname
@User varchar(20),
@Cname varchar(20) output
as
Declare @ID int;
Select @ID = id from Club_representative where username = @User;
set @Cname = 'Not_Existing';
Select @Cname = name from club where ID_CR = @ID;
Go
create procedure viewAvailableStadiumsOnProc
@Date datetime
as
select * from stadium where ID not in(
select ID_S from match m where @Date  between m.Start_time and m.End_time
and ID_S is not null
)and  status = 1;
Go
create function upcomingMatchesOfClubWithStadium
(@club_name varchar(20))
returns table
AS
return
select c1.name as 'Host Club Name',c2.name AS 'Competing Club Name',m.Start_time,m.End_time,s.Name as 'Stadium Name'
from Club c1 inner join Match m on (c1.ID=m.ID_C1)
inner join Club c2 on (c2.ID = m.ID_C2 )
left outer join Stadium s on s.ID=m.ID_S
where ( (c1.name=@club_name  and   c2.name <> @club_name)  or  (c2.name=@club_name  and  c1.name <> @club_name ) ) and m.Start_time > CURRENT_TIMESTAMP
go
create proc ViewMatches
@User varchar(20),
@ExistR int output 
as
Declare @ID int;
Declare @ClubN varchar(20);
select @ID=  ID from Club_representative where username = @User;
if exists(select * from club where ID_CR = @ID) begin
set @ExistR =1;
select @ClubN = name from club where ID_CR = @ID;
Select * from upcomingMatchesOfClubWithStadium(@ClubN);
end
go
create proc vaddRepresentative
@name varchar(20),
@username varchar(20),
@password varchar(20),
@clubname varchar(20),
@Exists_User int output,
@Exists_Club int output,
@Already_Has_R int output
as
set @Exists_User = 0;
set @Exists_Club = 0;
set @Already_Has_R  = 0;
if exists(select * from SystemUser where username = @username)
begin
set @Exists_User = 1;
end

if exists(select * from club where name = @clubname)
begin
set @Exists_Club = 1;
end

if exists(select ID_CR from club where name = @clubname and ID_CR is not null)
begin
set @Already_Has_R  =1;
end 
if(@Exists_User = 0 and @Exists_Club = 1 and @Already_Has_R = 0)
begin
Exec addRepresentative @name ,@clubname,@username,@password
end
GO





create proc getClub
@User varchar(20),
@Exist int Output
as
set @Exist = 1;
Declare @Var int;
Select @Var = ID from Club_representative where username = @User;
if exists(select * from Club where ID_CR = @Var)
select * from Club where ID_CR = @Var
else
set @Exist = 0;
go
create proc addAssociationManager1 
@name varchar(20),
@username varchar(20),
@pass varchar(20),
@success bit output
AS
Declare @check varchar(20);
select @check=Password
from SystemUser
where username=@username;
if(@check is not null) or @username = '' or @pass = '' or @name = ''
set @success = 0
else
begin 
set @success = 1
exec addAssociationManager @name , @username , @pass
end

go

create proc addNewMatch1
@c1n varchar(20),
@c2n varchar(20),
@date datetime,
@enddate datetime,
@success bit output
AS
if (@c1n not in (select c.name from Club c)) or (@c2n not in (select c.name from Club c)) or @c1n = '' or @c2n = '' or @date = '' or @enddate = ''
set @success = 0
else 
begin 
set @success= 1
exec addNewMatch @c1n,@c2n,@date,@enddate
end

go

create proc deleteMatch1 
@c1n varchar(20),
@c2n varchar(20),
@startTime datetime,
@endTime datetime

AS

declare @c1id int
declare @c2id int
 select @c1id= c.ID
 from Club c
 where c.name = @c1n; --get the 1st club ID
 select @c2id= c.ID
 from Club c
 where c.name = @c2n  --get the 2nd club ID

 declare @mid int;
 select @mid=ID
 from Match
 where ID_C1=@c1id and ID_C2=@c2id and Start_time = @startTime and End_time= @endTime;
 delete from Ticket 
 where ID_M = @mid;
 delete from Host_request
 where Match_ID=@mid;
 delete from Match
 where ID = @mid;


go

create proc deleteMatch2
@c1n varchar(20),
@c2n varchar(20),
@date datetime,
@enddate datetime,
@success bit output
AS


if (@c1n not in (select c.name from Club c)) or (@c2n not in (select c.name from Club c)) or @c1n = '' or @c2n = '' or @date = '' or @enddate = '' 
set @success = 0
else
begin 
set @success= 1
DECLARE @mid int;
select @mid=m.ID 
from Match m inner join Club c1 on c1.ID=m.ID_C1 inner join Club c2 on c2.ID = m.ID_C2
where m.Start_time=@date and m.End_time=@enddate and c1.name=@c1n and c2.name=@c2n
if(@mid is null)
BEGIN
set @success = 0
END
ELSE
BEGIN
exec deleteMatch1 @c1n,@c2n,@date,@enddate
END
end

go

GO
create proc fanRegisteration
@username varchar(20),
@password varchar(20),
@name varchar(20),
@national_id_number varchar(20),
@phone_number int,
@birthdate date,
@address varchar(20),
@success int output

AS
if(@username='' or @password = '' or @name = '' or @national_id_number = '' or @phone_number = ''
or @birthdate = '' or @address = '')
BEGIN
set @success=null;
END
ELSE
BEGIN
    IF EXISTS (SELECT * FROM SystemUser WHERE username = @username)
    BEGIN
        set @success=null;
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT * FROM Fan WHERE National_ID = @national_id_number)
        BEGIN
            set @success=null;
        END
        ELSE
        BEGIN
            EXEC addFan @name, @username, @password, @national_id_number, @birthdate, @address, @phone_number;
            set @success = 1;
        END
    END
END
GO

GO
create proc availableMatchesDate
@matchdate datetime
AS
BEGIN
select * from dbo.availableMatchesToAttend(@matchdate)
END


GO
create proc buyTickFan
@uname varchar(25),
@mid varchar(25)
AS
declare @nid varchar(25)
declare @stime datetime
declare @c1id int
declare @c2id int
declare @c1name varchar(25)
declare @c2name varchar(25)
BEGIN
select @nid = f.National_ID
from Fan f
where f.username = @uname;

select @stime = m.Start_time
from match m
where m.ID = @mid;

select @c1id = m.ID_C1
from match m
where m.ID = @mid;

select @c2id = m.ID_C2
from match m
where m.ID = @mid;

select @c1name = c.name
from Club c
where c.ID = @c1id;

select @c2name = c.name
from Club c
where c.ID = @c2id;

EXEC purchaseTicket @nid, @c1name, @c2name, @stime

END
GO
create proc addHostRequestOmar
@club_name varchar(20),
@stad_name varchar(20),
@date datetime,
@Pend int output,
@SM int output
AS
set @SM = 1;
set @Pend = 1;
DECLARE @crid int;
DECLARE @smid int;
DECLARE @mid int;
select @crid=ID_CR
from Club
where name=@club_name;
select @smid=ID_SM
from Stadium
where Name=@stad_name;
Declare @idh int;
select @idh=ID
from Club
where name=@club_name;

select @mid=ID
from Match
where Start_time=@date and ID_C1=@idh ; --and ID_S=@smid
if ( not exists(select * from Host_request where Match_ID = @mid and ID_Club_representative = @Crid  and (status = 'accepted' or status = 'unhandled' )))
    Begin
	if(@smid is null)
	begin
	set @SM = 0;
	end
	else
	begin
	    insert into Host_request(Match_ID,ID_Club_representative,ID_Stadium_Manager) Values(@mid,@crid,@smid);
	    set @Pend = 0;

	end
	End


GO


insert into SystemUser values('admin','admin')
insert into System_Admin values('admin','admin')



