% rdbtest.m
%
% N.B. Hawes
% 11/21/2015
%
% This m file makes a bunch of resources, a resource_db, and saves as a
% .mat file.

clear all; close all; clc;
addpath('functions\');

ver='0,1';

% Make resource database
rdb=resource_db('GRC List','v0.1: first try');

% Make resources

% 5170
addobject(rdb,'Kevin',5170,'t');
addobject(rdb,'Nate',5170,'lp');
addobject(rdb,'Di',5170,'lp');
addobject(rdb,'Patel',5170,'lp');
addobject(rdb,'Kum Kang',5170,'sp');
addobject(rdb,'Dave',5170,'sp');

% 9999
addobject(rdb,'Joey',9999,'sp');
addobject(rdb,'Andy',9999,'lp');

% 3333
addobject(rdb,'Jeremy',3333,'sp');

% 5130
addobject(rdb,'Tomas',5130,'lp');
addobject(rdb,'Bill',5130,'t');

% 8888
addobject(rdb,'SoftwareLP',8888,'lp');

% Save the mat file
save(['resources' ver '.mat'],'rdb');