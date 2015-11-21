% rdbtest.m
%
% N.B. Hawes
% 11/20/2015
%
% This m file tests the following classes: resource, resource_db, and
% obj_db

clear all; close all; clc;

% make a few resources
r1=resource('Di',5170,'lp');

r2=resource('Tomas',5130,'lp');

r3=resource('Kum-Kang',5170,'sp');

% make a resource database
rdb=resource_db('First RDB','Not sure what this field is for',[r1,r2,r3]);

% make a resource and attach to the database
r4=resource('Dave',5170,'sp');

attachobject(rdb,r4);

% add a few resources directly to the database
addobject(rdb,'Joey',9999,'sp');
addobject(rdb,'Nate',5170,'lp');

% query the rdb for all LPs in 5170
[flag,queryresults1]=query_db(rdb,@(x,y)(strcmp(x,'lp')&&(y==5170)),{'band','lab'});

