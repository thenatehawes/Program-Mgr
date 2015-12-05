% tasklinetest.m
%
% N.B. Hawes
% 12/05/2015
%
% This m file tests the following classes: taskline

clear all; close all; clc;
addpath('functions\');
load('resources0,1.mat');

tl1=taskline(rdb.list(5),5);
tl2=taskline(rdb.list(3),82,'hr');

[c,t]=tl1+tl2; % note that matlab doesn't like it, but it works since I overrode plus
disp(['Taskline Plus; Time (Wks): ' num2str(t) ', Cost: ' num2str(c)]);

tl3=taskline(rdb.list(8),9);
tl4=taskline(rdb.list(7),1);

tls=[tl1,tl2,tl3,tl4];
[c2,t2]=sum(tls);

disp(['Taskline Sum; Time (Wks): ' num2str(t2) ', Cost: ' num2str(c2)]);

