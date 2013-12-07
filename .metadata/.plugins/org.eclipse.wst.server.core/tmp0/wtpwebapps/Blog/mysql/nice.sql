/*index is created automaticly for primary key and foreign key*/
drop database if exists weibo;
create database weibo;
use weibo;

drop table if exists user;
create table user(
    user_name   varchar(20) not null, /*unique*/
    user_pwd    varchar(32) not null,
    user_email  varchar(50) not null,
    user_tel    varchar(15),
    user_age    smallint default 20,
    primary key (user_name))
    ENGINE = InnoDB DEFAULT CHARSET=utf8;

drop trigger if exists user_before_insert;
delimiter |
create trigger user_before_insert 
before insert on user for each row
begin
    if new.user_age>150 or new.user_age<5 then /*not so important*/
        set new.user_age=20;
    end if;
end;
| delimiter ;

drop table if exists admin;
create table admin(
    adm_name   varchar(20) not null, /*unique*/
    adm_pwd    varchar(32) not null,
    adm_auth   smallint not null default -1,/*can do nothing*/
    adm_email  varchar(50) not null,
    adm_tel    varchar(15),
    adm_age    smallint default 20,
    primary key (adm_name))
    ENGINE = InnoDB DEFAULT CHARSET=utf8;

drop trigger if exists admin_before_insert;
delimiter |
create trigger admin_before_insert 
before insert on admin for each row
begin
    if new.adm_age>150 or new.adm_age<5 then /*not so important*/
        set new.adm_age=20;
    end if;
    if new.adm_auth>10 or new.adm_auth<0 then/*we have 10 authority levels (important)*/ 
        set new.adm_auth=-1;
    end if;
end;
| delimiter ;
    
drop table if exists diary;
create table diary(
    diary_id          bigint not null,/*auto create, maybe (user_name + time)*/
    user_name         varchar(20) not null,
    diary_title       varchar(50) not null,
    diary_text        longtext not null,
    diary_date        varchar(20) not null,
    diary_repost      smallint not null,
    diary_visual      smallint default 1,
    primary key (diary_id),
    foreign key (user_name) references user(user_name)
    on delete cascade on update cascade)
    ENGINE = InnoDB DEFAULT CHARSET=utf8;

drop trigger if exists diary_after_delete;
delimiter |
create trigger diary_after_delete 
after delete on diary for each row
begin
    delete from weibo.comm where weibo_id=old.diary_id;
end;
| delimiter ;

drop table if exists weibo;
create table weibo(
    weibo_id         bigint not null,
    user_name        varchar(20) not null,
    weibo_text       varchar(200) not null,
    weibo_date       varchar(20) not null,
    weibo_repost     smallint not null,
    weibo_visual     smallint default 1,
    primary key (weibo_id),
    foreign key (user_name) references user(user_name)    
    on delete cascade on update cascade)
    ENGINE = InnoDB DEFAULT CHARSET=utf8;

drop trigger if exists weibo_after_delete;
delimiter |
create trigger weibo_after_delete 
after delete on weibo for each row
begin
    delete from weibo.comm where weibo_id=old.weibo_id;
end;
| delimiter ;

drop table if exists comm;
create table comm(
    comm_id     bigint not null,
    user_name   varchar(20) not null,
    weibo_id    varchar(45) not null,
    comm_text   varchar(200) not null,
    comm_date   varchar(20) not null,
    primary key(comm_id),
    foreign key (user_name) references user(user_name)    
    on delete cascade on update cascade)
    ENGINE = InnoDB DEFAULT CHARSET=utf8;

drop table if exists friend;
create table friend(
    f1_name      varchar(20) not null,
    f2_name      varchar(20) not null,
    friend_type  varchar(10) not null,
    primary key (f1_name, f2_name),
    foreign key (f1_name) references user(user_name)    
    on delete cascade on update cascade,
    foreign key (f2_name) references user(user_name)    
    on delete cascade on update cascade)
    ENGINE = InnoDB DEFAULT CHARSET=utf8;

drop table if exists timeline;
create table timeline(
    tline_id       bigint not null AUTO_INCREMENT,
    user_name      varchar(20) not null,
    tline_time     varchar(20) not null,
    tline_action   varchar(100) not null,
    primary key (tline_id),
    foreign key (user_name) references user(user_name)    
    on delete cascade on update cascade)
    ENGINE = InnoDB DEFAULT CHARSET=utf8;

drop trigger if exists friend_after_insert;
delimiter |
create trigger friend_after_insert 
after insert on friend for each row
begin
    insert into timeline(user_name, tline_time, tline_action)
           values(new.f1_name,concat(curdate(),' ',curtime()),concat('您添加好友',new.f2_name));
end;
| delimiter ;
/*
drop trigger if exists friend_after_delete;
delimiter |
create trigger friend_after_delete 
after delete on friend for each row
begin
    insert into timeline(user_name, tline_time, tline_action)
           values(old.f1_name,concat(curdate(),' ',curtime()),concat('您删除好友：',new.f2_name,'!'));
end;
| delimiter ;
*/

drop trigger if exists user_after_insert;
delimiter |
create trigger user_after_insert 
after insert on user for each row
begin
    insert into timeline(user_name, tline_time, tline_action)
           values(new.user_name,concat(curdate(),' ',curtime()),'您加入了微博大家庭！');  
end;
| delimiter ;

/*for test*/
insert into user(user_name,user_pwd,user_email,user_tel,user_age)
    values('cyj','cyj2012','2257772562@qq.com','18001366305',200);

insert into user(user_name,user_pwd,user_email,user_tel,user_age)
    values('nice','1','haha@qq.com','18001366305',12);

/*for test*/
insert into admin(adm_name,adm_pwd,adm_auth,adm_email,adm_tel,adm_age)
    values('cyj','cyj2012',11,'2257772562@qq.com','18001366305',151);

/*for test*/
INSERT INTO `weibo`.`diary` (`diary_id`, `user_name`, `diary_title`, `diary_text`, `diary_date`, `diary_repost`, `diary_visual`)
    VALUES (10, 'cyj', 'test', 'test', '2013/11/30 21:50:30', 0, 1);
UPDATE `weibo`.`user` SET `user_name`='yjc' WHERE `user_name`='cyj';
DELETE FROM `weibo`.`user` WHERE `user_name`='yjc';

/*for test*/
insert into user(user_name,user_pwd,user_email,user_tel,user_age)
    values('cyj','cyj2012','2257772562@qq.com','18001366305',200);
INSERT INTO `weibo`.`weibo` (`weibo_id`, `user_name`, `weibo_text`, `weibo_date`, `weibo_repost`, `weibo_visual`) 
    VALUES (10, 'cyj', 'test', '2013/11/30 22:07:40', 0, 1);
UPDATE `weibo`.`user` SET `user_name`='yjc' WHERE `user_name`='cyj';
DELETE FROM `weibo`.`user` WHERE `user_name`='yjc';