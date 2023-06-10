create database Matches

Select * from SystemUser
Select * from SystemAdmin
Select * from SportsAssociationManager
Select * from ClubRepresentative
Select * from Club
Select * from StadiumManager
Select * from Stadium
Select * from Fan
Select * from Match

select * from clubsNeverMatched


delete from SystemUser where username = 'olayan'
insert into SystemUser values ('omar', 'adel')
insert into SystemAdmin values ('omarabuatala', 'omar');
insert into Club values ('Real Madrid', 'Spain')
insert into Stadium values ('Santiago Bernabeu', 'Madrid', 81044, 1)
insert into Stadium values ('Camp Nou', 'Madrid', 81044, 0)


go
create Procedure createAllTables
as
create table SystemUser
(
username varchar(20) primary key,
password varchar(20)
);

create table Fan
(
nationalID varchar(20) primary key,
name varchar(20),
birth_date date,
address varchar(20),
phone_no varchar(20),
status bit default 1,
username varchar(20),
constraint FKUsernameFan foreign key (username) references SystemUser on update cascade on delete cascade,
);

create table Stadium
(
id int primary key identity,
name varchar(20),
location varchar(20),
capacity int,
status bit default 1
);

create table StadiumManager
(
id int primary key identity,
name varchar(20),
stadium_ID int,
username varchar(20),
constraint FKStadiumIDStadiumManager foreign key (stadium_ID) references Stadium on update cascade on delete cascade,
constraint FKUsernameStadiumManager foreign key (username) references SystemUser on update cascade on delete cascade
);

create table Club
(
clubID int primary key identity,
name varchar(20),
location varchar(20)
);

create table ClubRepresentative
(
id int primary key identity,
name varchar(20),
club_ID int,
username varchar(20),
constraint FKClubIDClubRepresentative foreign key (club_ID) references Club on update cascade on delete cascade,
constraint FKUsernameClubRepresentative foreign key (username) references SystemUser on update cascade on delete cascade
);

create table SportsAssociationManager
(
id int primary key identity,
name varchar(20),
username varchar(20),
constraint FKUsernameSportsAssociationManager foreign key (username) references SystemUser on update cascade on delete cascade
);

create table SystemAdmin
(
id int primary key identity,
name varchar(20),
username varchar(20),
constraint FKUsernameSystemAdmin foreign key (username) references SystemUser on update cascade on delete cascade,
);

create table Match
(
matchID int primary key identity,
start_time datetime,
end_time datetime,
host_club_id int,
guest_club_id int,
stadium_id int,
constraint FKHostClubIDMatch foreign key (host_club_id) references Club on update cascade on delete cascade,
constraint FKGuestClubIDMatch foreign key (guest_club_id) references Club,
constraint FKStadiumIDMatch foreign key (stadium_id) references Stadium on update cascade on delete cascade
);

create table Ticket
(
id int primary key identity,
status bit default 1,
match_id int,
constraint FKMatchIDTicket foreign key (match_id) references Match on update cascade on delete cascade
);

create table TicketBuyingTransactions
(
fan_nationalID varchar(20) ,
ticket_ID int,
constraint FKFanNationalIDTicketBuyingTransactions foreign key (fan_nationalID) references Fan on update cascade on delete cascade,
constraint FKTicketIDTicketBuyingTransactions foreign key (ticket_ID) references Ticket on update cascade on delete cascade
);

create table HostRequest
(
id int primary key identity,
representativeID int,
managerID int,
matchID int,
status varchar(20) default 'unhandled' ,
constraint FKRepresentativeIDHostRequest foreign key (representativeID) references ClubRepresentative on update cascade on delete cascade,
constraint FKManagerIDHostRequest foreign key (managerID) references StadiumManager,
constraint FKMatchIDHostRequest foreign key (matchID) references Match,
);

go
create Procedure dropAllTables
as
drop table HostRequest, TicketBuyingTransactions, Ticket, Match, SystemAdmin, SportsAssociationManager, ClubRepresentative, Club, StadiumManager, Stadium, Fan, SystemUser

go
create Procedure dropAllProceduresFunctionsViews
as 
drop Procedure createAllTables, dropAllTables, clearAllTables, addAssociationManager, addNewMatch, deleteMatch, deleteMatchesOnStadium, addClub, addTicket, deleteClub, addStadium, deleteStadium, blockFan, unblockFan, addRepresentative, addHostRequest, addStadiumManager, acceptRequest, rejectRequest, addFan, purchaseTicket, updateMatchHost
drop view allAssocManagers, allClubRepresentatives, allStadiumManagers, allFans, allMatches, allTickets, allCLubs, allRequests, allStadiums, clubsWithNoMatches, matchesPerTeam, clubsNeverMatched
drop function viewAvailableStadiumsOn, allUnassignedMatches, allPendingRequests, upcomingMatchesOfClub, availableMatchesToAttend, clubsNeverPlayed, matchWithHighestAttendance, matchesRankedByAttendance, requestsFromClub

go
create Procedure clearAllTables
as
delete from HostRequest
delete from TicketBuyingTransactions
delete from Ticket
delete from Match
delete from SystemAdmin
delete from SportsAssociationManager
delete from ClubRepresentative
delete from Club
delete from StadiumManager
delete from Stadium
delete from Fan
delete from SystemUser

go
create view allAssocManagers
as
select sam.username, su.password, sam.name
from SportsAssociationManager sam inner join SystemUser su on (sam.username = su.username)

go
create view allClubRepresentatives
as
select cr.username, su.password, cr.name, c.name as ClubName
from ClubRepresentative cr inner join SystemUser su on (cr.username = su.username) inner join Club c on (cr.club_ID = c.clubID)

go
create view allStadiumManagers
as
select sm.username, su.password, sm.name,  s.name as StadiumName
from StadiumManager sm inner join SystemUser su on (sm.username = su.username) inner join Stadium s on (sm.stadium_ID = s.id) 

go
create view allFans
as
select f.username, su.password, f.name, f.nationalID, f.birth_date, f.status
from Fan f inner join SystemUser su on (f.username = su.username)

go
create view allMatches
as
select c1.name as HostClubName, c2.name as GuestClubName, m.start_time
from Match m inner join Club c1 on (m.host_club_id = c1.clubID) inner join Club c2 on (m.guest_club_id = c2.clubID)

go
create view allTickets
as
select c1.name as HostClubName, c2.name as GuestClubName, s.name as StadiumName, m.start_time
from Ticket t inner join Match m on (t.match_id = m.matchID) inner join Club c1 on (m.host_club_id = c1.clubID) 
	inner join Club c2 on (m.guest_club_id = c2.clubID) inner join Stadium s on (m.stadium_id = s.id)

go
create view allCLubs
as
select c.name, c.location
from Club c

go
create view allStadiums
as
Select s.name, s.location, s.capacity, s.status
from Stadium s

go
create view allRequests
as
select cr.username as ClubRepresentativeUsername, sm.username as StadiumManagerUsername, hr.status
from HostRequest hr inner join ClubRepresentative cr on (hr.representativeID = cr.id) inner join StadiumManager sm on (hr.managerID = sm.id)

go
create Procedure addAssociationManager
@name varchar(20),
@username varchar(20),
@password varchar(20),
@success bit output
as 
if(@username not in (select username from SystemUser))
begin
	set @success=1
	insert into SystemUser values (@username, @password);
	insert into SportsAssociationManager values (@name, @username);
end
else
begin 
set @success=0
end

go;
create Procedure addNewMatch
@hostClubName varchar(20),
@guestClubName varchar(20),
@start_time datetime,
@end_time datetime
as
declare @hostClubID int = 0;
select @hostClubID = c.clubID
from Club c
where c.name = @hostClubName

declare @guestClubID int = 0;
select @guestClubID = c.clubID
from Club c
where c.name = @guestClubName

insert into Match (start_time, end_time, host_club_id, guest_club_id) values (@start_time, @end_time, @hostClubID, @guestClubID);

go
create view clubsWithNoMatches
as 
select c.name
from Club c
where c.clubID NOT IN (select m.host_club_id
					  from Match m)
	 and c.clubID NOT IN (select m1.guest_club_id
			 from Match m1)

go

create Procedure deleteMatch
@hostClubName varchar(20),
@guestClubName varchar(20)
as
declare @hostClubID int = 0;
select @hostClubID = c.clubID
from Club c
where c.name = @hostClubName

declare @guestClubID int = 0;
select @guestClubID = c.clubID
from Club c
where c.name = @guestClubName

delete from Match where (host_club_id = @hostClubID AND guest_club_id = @guestClubID)

go
create Procedure deleteMatchesOnStadium
@stadiumName varchar(20)
as
declare @stadiumID int = 0;
select stadiumID = s.id
from Stadium s
where s.name = @stadiumName

delete from Match where stadium_id = @stadiumID AND match.start_time > CURRENT_TIMESTAMP

go
create Procedure addClub
@name varchar(20),
@location varchar(20)
as
insert into club  (name,location) values (@name,@location)
go
create Procedure addTicket
@hostClubName varchar(20),
@guestClubName varchar(20),
@startTime datetime
as
declare @matchID int = 0;
select @matchID = m.matchID
from Match m inner join Club c1 on (m.host_club_id = c1.clubID) inner join Club c2 on (m.guest_club_id = c2.clubID)
where m.start_time = @startTime

insert into Ticket (match_id) values (@matchID)

go
create Procedure deleteClub
@name varchar(20)
as
declare @temp int = 0;
select @temp = cr.id
from Club c inner join ClubRepresentative cr on (cr.club_ID = c.clubID)
where c.name = @name

declare @temp2 varchar(20);
select @temp2 = cr.username
from ClubRepresentative cr
where cr.id = @temp

delete from Match where guest_club_id = (select c.clubID from Club c where c.name = @name)
delete from Match where host_club_id = (select c.clubID from Club c where c.name = @name)
delete from Club where club.name = @name
delete from ClubRepresentative where ClubRepresentative.id = @temp
delete from SystemUser where username = @temp2;

go
create procedure addStadium
@name varchar(20),
@location varchar(20),
@capacity int 
as
insert into stadium (name,location,capacity)
values (@name,@location,@capacity)

go
create Procedure deleteStadium
@name varchar(20)
as
declare @temp int = 0;
select @temp = sm.id
from Stadium s inner join StadiumManager sm on (sm.stadium_ID = s.id)
where s.name = @name

declare @temp2 varchar(20);
select @temp2 = sm.username
from StadiumManager sm
where sm.id = @temp

delete from Ticket where match_id = (select m.matchID from Match m inner join Stadium S on (m.stadium_id = s.id) where s.name = @name)
delete from Stadium where stadium.name = @name
delete from HostRequest where managerID = @temp
delete from StadiumManager where StadiumManager.id = @temp
delete from SystemUser where username = @temp2

go
create procedure blockFan
@nationalID varchar(20)
as
Update Fan
Set status = 0
Where (Fan.nationalID = @nationalID);

go
create procedure unblockFan
@nationalID varchar(20)
as
Update Fan
Set status = 1
Where (Fan.nationalID = @nationalID);

go

create procedure addRepresentative
@name varchar(20),
@clubname varchar(20),
@username varchar(20),
@password varchar(20),
@success bit output
as
declare @clubID int = 0;
select @clubID = c.clubID
from Club c
where c.name = @clubname;

if(@username not in (select username from SystemUser))
begin
    set @success=1
	insert into SystemUser values(@username, @password);
	insert into ClubRepresentative values(@name, @clubID, @username);
end
else
begin 
set @success=0
end

go
create function viewAvailableStadiumsOn
(@date datetime)
returns table
as
return (select s.name,s.location,s.capacity 
from Stadium s 
where s.status = 1 and s.id not  in (select s1.id
								from Stadium s1 inner join Match m on (s1.id=m.stadium_id)
								where m.start_time=@date)
)

go

create procedure addHostRequest
@clubName varchar(20),
@stadiumName varchar(20),
@startingTime datetime
as
declare @c_id int = 0
select @c_id =  c.clubID
from Club c
where c.name = @clubName

declare @r_id int = 0
select @r_id= cr.id
from ClubRepresentative cr
where cr.club_ID = @c_id

declare @s_id  int = 0
select  @s_id = s.id
from Stadium s
where s.name = @stadiumName

declare @m_id int = 0
select @m_id= sm.id
from StadiumManager sm
where sm.stadium_ID = @s_id

declare @m1_id int = 0
select @m1_id = m1.matchID
from Match m1
where m1.host_club_id= @c_id and @startingTime = m1.start_time;

insert into HostRequest (representativeID,managerID,matchID) values (@r_id,@m_id,@m1_id);

go
create function allUnassignedMatches
(@club_name varchar(20))
returns table
as
return(select c1.name as GuestClubName ,m1.start_time 
from Match m1 inner join club c1 on (m1.guest_club_id =c1.clubID)
where m1.matchID = (select m.matchID
from match m
where m.stadium_id is null  and  m.host_club_id =(select c.clubID
from club c
where @club_name = c.name)))

go

create Procedure addStadiumManager
@name varchar(20),
@stadiumName varchar(20),
@username varchar(20),
@password varchar(20),
@success bit output 
as
declare @stadiumID int = 0;

select @stadiumID = s.id
from Stadium s
where s.name = @stadiumName

if(@username not in (select username from SystemUser))
begin
	set @success=1
	insert into SystemUser values (@username, @password);
	insert into StadiumManager values (@name, @stadiumID, @username);
end
else
begin 
set @success=0
end

go
create function allPendingRequests
(@username varchar(20))
returns table
AS
return ( select m.start_time,c.name as clubRepresentativename ,c1.name as guestclubname
from HostRequest h  inner join match m on (h.matchID=m.matchID) inner join ClubRepresentative c on (h.representativeID= c.id  ) inner join club c1 on (m.guest_club_id=c1.clubID) inner join StadiumManager sm ON (h.managerID=sm.id)
where h.status='UNHANDLED' and sm.username=@username
)

go
create procedure acceptRequest
@hosting_club_name varchar(20),
@competing_club_name varchar(20),
@stadium_manager_username varchar(20),
@starting_time datetime
as
declare @c_id1 int =0;
select @c_id1 = c.clubID
from Club c
where (c.name = @hosting_club_name);

declare @c_id2 int =0;
select @c_id2 = c.clubID
from Club c
where (c.name = @competing_club_name);

declare @match_id int =0;
select @match_id = m.matchID
from Match m
where (m.host_club_id = @c_id1 and m.guest_club_id = @c_id2 and m.start_time = @starting_time);

declare @man_id int =0;
select @man_id = man.id
from StadiumManager man
where man.username = @stadium_manager_username;

declare @r_id int = 0
select @r_id= r.id
from ClubRepresentative r
where r.club_ID = @c_id1;

declare @s_id int =0;
select @s_id = man.stadium_ID
from StadiumManager man
where man.username = @stadium_manager_username;

Update HostRequest
Set status = 'accepted'
Where (representativeID =  @r_id and managerid = @man_id and matchid =  @match_id );

update match
set stadium_id=@s_id
where matchID=@match_id

go
create procedure rejectRequest
@hosting_club_name varchar(20),
@competing_club_name varchar(20),
@stadium_manager_username varchar(20),
@starting_time datetime
as
declare @c_id1 int =0;
select @c_id1 = c.clubID
from Club c
where (c.name = @hosting_club_name);

declare @c_id2 int =0;
select @c_id2 = c.clubID
from Club c
where (c.name = @competing_club_name);

declare @match_id int =0;
select @match_id = m.matchID
from match m
where (m.host_club_id = @c_id1 and m.guest_club_id = @c_id2 and m.start_time = @starting_time);

declare @man_id int =0;
select @man_id = man.id
from StadiumManager man
where man.username = @stadium_manager_username;




declare @r_id int = 0
select @r_id= r.id
from ClubRepresentative r
where r.club_ID = @c_id1;

Update HostRequest
Set status = 'rejected'
Where (representativeID =  @r_id and managerid = @man_id and matchid =  @match_id );


go

create Procedure addFan
@name varchar(20),
@username varchar(20),
@password varchar(20),
@nationalIDNumber varchar(20),
@birthDate datetime,
@address varchar(20),
@phoneNumber int,
@success bit output
as
if(@username not in (select username from SystemUser))
begin
	set @success=1
	insert into SystemUser values (@username, @password);
	insert into Fan (nationalID, name, birth_date, address, phone_no, username) values (@nationalIDNumber, @name, @birthDate, @address, @phoneNumber, @username);
end
else
begin 
set @success=0
end
go

create function upcomingMatchesOfClub
(@club_name varchar(20))
returns table
as
return (select c.name as "Host Name", c2.name as "Guest Name", s.name as "Stadium Name", m.start_time as "Start Time"
from Club c inner join Match m on (c.clubID = m.host_club_id) inner join club c2 on (m.guest_club_id = c2.clubID) inner join Stadium s on (m.stadium_id = s.id) 
where (@club_name = c.name and m.start_time > CURRENT_TIMESTAMP) or (@club_name = c2.name and m.start_time > CURRENT_TIMESTAMP)
)

go
create function availableMatchesToAttend
(@start datetime)
returns table
as
return 
(
select  c1.name as HostClubName, c2.name as GuestClubName, m1.start_time, s.name
from Club c1 inner join Match m1 on (c1.clubID = m1.host_club_id) inner join Club c2 on (c2.clubID = m1.guest_club_id)
inner join Stadium s on (s.id = m1.stadium_id) inner join Ticket t on (t.match_id = m1.matchID)
where t.status = 1 and m1.start_time > @start
)

go
create Procedure purchaseTicket 
@fan_nationalid varchar(20),
@host_clubname varchar(20),
@guest_clubname varchar(20),
@starttime datetime
as
declare @host_clubid int =0;
select @host_clubid = clubID
from Club
where name=@host_clubname

declare @guest_clubid int =0;
select @guest_clubid = clubID
from Club
where name=@guest_clubname

declare @match_clubid int =0;
select @match_clubid = m.matchID
from Match m
where m.host_club_id=@host_clubid and m.guest_club_id=@guest_clubid and m.start_time=@starttime

declare @ticket_matchid int =0;
select @ticket_matchid = t.id
from Ticket t
where t.match_id=@match_clubid and t.status =1

update Ticket 
set status =0
where id=@ticket_matchid
insert into TicketBuyingTransactions values (@fan_nationalid,@ticket_matchid)


go
create procedure updateMatchHost
@host_club_name varchar(20),
@guest_club_name varchar(20),
@start_time datetime
as
declare @temp int = 0;

select @temp = m.matchID
from Match m inner join Club c1 on (m.host_club_id = c1.clubID) inner join Club c2 on (m.guest_club_id = c2.clubID)
where c1.name = @host_club_name AND c2.name = @guest_club_name AND m.start_time = @start_time

update Match 
set
host_club_id = guest_club_id,
guest_club_id = host_club_id,
stadium_id = null
where matchID = @temp

go
create view matchesPerTeam
as
select count(m.matchID) as matches, c.name
from club c ,match m
where (c.clubID = m.guest_club_id or c.clubID = m.host_club_id) and m.start_time<CURRENT_TIMESTAMP
group by c.name;

go
create view clubsNeverMatched
as
select distinct (c.name + '-'  + c1.name) as ClubsNeverMatched
from club c,club c1, match m
where c.clubID<c1.clubID and not exists(select (c2.name + '-' + c3.name) from club c2, club c3 , match m1
where (m1.guest_club_id=c2.clubID and m1.host_club_id=c3.clubID and c3.name=c1.name and c.name=c2.name) )

and not exists  (select (c2.name + '-' + c3.name) from club c2, club c3 , match m1
where (m1.guest_club_id=c3.clubID and m1.host_club_id=c2.clubID and c3.name=c1.name and c.name=c2.name)) and m.start_time < CURRENT_TIMESTAMP

go
create function clubsNeverPlayed (@clubName varchar(20))
returns table
as
return select c.name
from Club c 
where c.clubID not in (
select c3.clubID from Match m inner join club c1 on (m.host_club_id=c1.clubID)  inner join club c2 on (m.guest_club_id=c2.clubID) inner join Club c3 on (c3.clubID=c1.clubID or c3.clubID=c2.clubID)
where c1.name=@clubName or c2.name=@clubName 
)

go 
create function matchWithHighestAttendance ()
returns table
as
return select c.name as hostclubname,c2.name guestclubname,count (*) as numberofticketssold
from Club c inner join Match m on (c.clubID=m.host_club_id) inner join Ticket t on (m.matchID=t.match_id) inner join Club c2 on (m.guest_club_id=c2.clubID)
where  t.status=0
group by c.name,c2.name
having count(*)= (select max(x) from (select count(*) as x
from Match m inner join Ticket t on (m.matchID=t.match_id)
where t.status=0
group by m.matchID) as ff)

go
create function  matchesRankedByAttendance ()
returns table
as
return select c.name as hostclubname,c2.name as guestclubname,count (*) as pop
from Club c inner join Match m on (c.clubID=m.host_club_id) inner join Ticket t on (m.matchID=t.match_id) inner join Club c2 on (m.guest_club_id=c2.clubID)
where  t.status=0
group by c.name,c2.name



go
create function requestsFromClub (@stadium_name varchar(20),@club_name varchar(20))
returns table
as
return select c.name as hostclub ,c1.name as guestclub
from club c inner join match m on (c.clubID=m.host_club_id ) inner join club c1 on (m.guest_club_id=c1.clubID) inner join Stadium s on (m.stadium_id=s.id) inner join StadiumManager sm on (s.id=sm.stadium_ID) inner join ClubRepresentative cr on (c.clubID=cr.club_ID) inner join HostRequest hr on (hr.managerID=sm.id and hr.matchID=m.matchID and hr.representativeID=cr.id) 
where s.name=@stadium_name and c.name=@club_name

go
create function requestsFromClub4(@stadiumre_name varchar(20))
returns table
as
return select c.name as hostclub ,c1.name as guestclub,cr.name as crname,m.start_time,hr.status
from club c inner join match m on (c.clubID=m.host_club_id ) inner join club c1 on (m.guest_club_id=c1.clubID)  inner join ClubRepresentative cr on (c.clubID=cr.club_ID) inner join HostRequest hr on ( hr.matchID=m.matchID and hr.representativeID=cr.id) inner join StadiumManager sm on (sm.id=hr.managerID)
where sm.username=@stadiumre_name

go
create function alreadyPlayedMatches
(@club_name varchar(20))
returns table
as
return (select c.name as "Host Name", c2.name as "Guest Name", s.name as "Stadium Name", m.start_time as "Start Time"
from Club c inner join Match m on (c.clubID = m.host_club_id) inner join club c2 on (m.guest_club_id = c2.clubID) inner join Stadium s on (m.stadium_id = s.id) 
where (@club_name = c.name and m.start_time < CURRENT_TIMESTAMP) or (@club_name = c2.name and m.start_time < CURRENT_TIMESTAMP)
)

go

create procedure userlogin
@username varchar(20),
@password varchar(20),
@success bit output,
@type int output
as 
begin 

if exists (select username, password from SystemUser where username = @username and password = @password)
begin
	set @success = 1;
	if exists (select username from SystemAdmin where username = @username)
	begin
		set @type = 1
	end
	else if exists(select username from SportsAssociationManager where username = @username)
	begin
		set @type = 2
	end
	else if exists(select username from ClubRepresentative where username = @username)
	begin
		set @type = 3
	end
	else if exists(select username from StadiumManager where username = @username)
	begin
		set @type = 4
	end
	else if exists(select username from Fan where username = @username and status ='1')
	begin
		set @type = 5
	end
	else if exists(select username from Fan where username = @username and status ='0')
	begin
		set @type = 6
	end
	
end
else
begin
	set @success = 0;
end

end



insert into SystemUser values('adel','khashan')
insert into SystemUser values('mohab','olayan')
insert into SystemUser values('omar','adel')
insert into SystemUser values('lojain','lojain')
insert into SystemUser values('omarr','mohammed')
insert into SystemUser values('mostafa','adel')
insert into SystemUser values('moayad','olayan')

select *
from SystemUser

insert into Fan (nationalID,name,username)values ('1','adel','adel')
insert into Fan (nationalID,name,username)values ('2','mohab','mohab')
insert into Fan (nationalID,name,username)values ('3','omarr','omarr')
insert into Fan (nationalID,name,username)values ('4','omar','omar')
insert into Fan (nationalID,name,username)values ('5','lojain','lojain')
insert into Fan (nationalID,name,username)values ('6','mostafa','mostafa')
insert into Fan (nationalID,name,username)values ('7','moayad','moayad')

select *
from Fan


insert into SystemUser values('wessam','qutob')
insert into SystemUser values('layla','selim')
insert into SystemUser values('ana','dearmas')
insert into SystemUser values('sir','alex')
insert into SystemUser values('qtada','abo3ntr')

insert into Stadium (name,capacity) values ('sansiro',35)
insert into Stadium (name,capacity) values ('santaigo',105)
insert into Stadium (name,capacity) values ('campnou',25)
insert into Stadium (name,capacity) values ('anfield',15)
insert into Stadium (name,capacity) values ('oldtrafford',45)



 
 select *
from Stadium

insert into StadiumManager (name,stadium_ID,username)values ('wessam',1,'wessam')
insert into StadiumManager (name,stadium_ID,username)values ('layla',2,'layla')
insert into StadiumManager (name,stadium_ID,username)values ('ana',3,'ana')
insert into StadiumManager (name,stadium_ID,username)values ('qtada',4,'qtada')
insert into StadiumManager (name,stadium_ID,username)values ('sir',5,'sir')

 select *
from StadiumManager


insert into SystemUser values('perez','perez')
insert into SystemUser values('lionel','messi')
insert into SystemUser values('cr','7')
insert into SystemUser values('paolo','maldini')
insert into SystemUser values('mo','salah')
insert into SystemUser values('yasser','alqahtani')


insert into Club (name) values ('barca')
insert into Club (name) values ('real')
insert into Club (name) values ('acmilan')
insert into Club (name) values ('manutd')
insert into Club (name) values ('liverpool')
insert into Club (name) values ('hilal')


   select *
from Club

insert into ClubRepresentative  (name,club_id,username) values ('perez',2,'perez')
insert into ClubRepresentative  (name,club_id,username) values ('lionel',1,'lionel')
insert into ClubRepresentative  (name,club_id,username) values ('cr',4,'cr')
insert into ClubRepresentative  (name,club_id,username) values ('paolo',3,'paolo')
insert into ClubRepresentative  (name,club_id,username) values ('mo',5,'mo')
insert into ClubRepresentative  (name,club_id,username) values ('yasser',6,'yasser')


 select *
from ClubRepresentative



insert into SystemUser values('wiz','khalifa')
insert into SystemUser values('metro','boomin')




insert into SportsAssociationManager values ('wiz','wiz')
insert into SportsAssociationManager values ('metro','metro')

 select *
from SportsAssociationManager


insert into SystemUser values('slim','abdelnader')



insert into SystemAdmin values ('slim','slim')


 select *
from SystemAdmin


insert into Match (start_time,host_club_id,guest_club_id,stadium_id) values ('2022-01-01 12:12:12',2,1,2)
insert into Match (start_time,host_club_id,guest_club_id,stadium_id) values ('2022-02-01 12:12:12',2,4,2)
insert into Match (start_time,host_club_id,guest_club_id,stadium_id) values ('2022-03-01 12:12:12',4,5,5)
insert into Match (start_time,host_club_id,guest_club_id,stadium_id) values ('2022-04-01 12:12:12',5,3,4)
insert into Match (start_time,host_club_id,guest_club_id,stadium_id) values ('2022-05-01 12:12:12',3,6,1)
insert into Match (start_time,host_club_id,guest_club_id,stadium_id) values ('2022-06-01 12:12:12',1,5,3)
insert into Match (start_time,host_club_id,guest_club_id,stadium_id) values ('2022-07-01 12:12:12',5,4,4)
insert into Match (start_time,host_club_id,guest_club_id,stadium_id) values ('2022-08-01 12:12:12',1,2,3)
insert into Match (start_time,host_club_id,guest_club_id) values ('2022-09-01 12:12:12',1,2)
insert into Match (start_time,host_club_id,guest_club_id) values ('2023-09-01 12:12:12',2,6)
insert into Match (start_time,host_club_id,guest_club_id) values ('2023-10-01 12:12:12',4,6)

UPDATE match 
set start_time='2022-03-01 12:12:00'
where matchID=3

UPDATE match 
set start_time='2022-04-01 12:12:00'
where matchID=4
UPDATE match 
set start_time='2022-05-01 12:12:00'
where matchID=5

UPDATE match 
set start_time='2022-06-01 12:12:00'
where matchID=6
UPDATE match 
set start_time='2022-07-01 12:12:00'
where matchID=7
UPDATE match 
set start_time='2022-08-01 12:12:00'
where matchID=8
UPDATE match 
set start_time='2022-09-01 12:12:00'
where matchID=9

UPDATE match 
set start_time='2023-09-01 12:12:00'
where matchID=10
UPDATE match 
set start_time='2023-10-01 12:12:00'
where matchID=12

 
 select *
from Match


insert into Ticket  values(0,1)
insert into Ticket  values(0,1)
insert into Ticket  values(0,1)
insert into Ticket  values(0,1)
insert into Ticket  values(0,1)
insert into Ticket  values(0,1)
insert into Ticket  values(0,1)


insert into Ticket  values(0,3)
insert into Ticket  values(0,3)
insert into Ticket  values(0,3)
insert into Ticket  values(0,3)
insert into Ticket  values(0,3)
insert into Ticket  values(0,3)
insert into Ticket  values(1,3)

insert into Ticket  values(0,5)
insert into Ticket  values(0,5)
insert into Ticket  values(0,5)  
insert into Ticket  values(0,5)
insert into Ticket  values(1,5)
insert into Ticket  values(1,5)
insert into Ticket  values(1,5)




 select *
from Ticket


insert into TicketBuyingTransactions values ('1',1)
insert into TicketBuyingTransactions values ('1',2)
insert into TicketBuyingTransactions values ('1',3)
insert into TicketBuyingTransactions values ('1',4)
insert into TicketBuyingTransactions values ('1',5)
insert into TicketBuyingTransactions values ('1',6)
insert into TicketBuyingTransactions values ('1',7)

insert into TicketBuyingTransactions values ('2',8)
insert into TicketBuyingTransactions values ('2',9)
insert into TicketBuyingTransactions values ('2',10)
insert into TicketBuyingTransactions values ('2',11)
insert into TicketBuyingTransactions values ('2',12)
insert into TicketBuyingTransactions values ('2',13)

insert into TicketBuyingTransactions values ('3',15)
insert into TicketBuyingTransactions values ('4',16)
insert into TicketBuyingTransactions values ('5',17)
insert into TicketBuyingTransactions values ('7',18)

select * 
from match

exec addHostRequest 'manutd','oldtrafford','2023-10-01 12:12:12'

select * 
from HostRequest

insert into HostRequest VALUES(1,2,1,'ACCEPTED')
insert into HostRequest VALUES(2,3,9,'UNHANDLED')
insert into HostRequest VALUES(1,2,2,'ACCEPTED')
insert into HostRequest VALUES(1,2,10,'REJECTED')

