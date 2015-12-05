% tasklinetest.m
%
% N.B. Hawes
% 12/05/2015
%
% This m file tests the following classes: task, program
clear all; close all; clc;
addpath('functions\');

prgm=program('myProgram','this is the first one');

task1=task('firstTask','');
task2=task('secondTask','');
subtask1_1=task('firstSubTask','');

attachobject(task1,subtask1_1); % This attaches a subtask to task 1
attachobject(prgm,task1); % This attaches task 1 to the program
attachobject(prgm,task2); % This attaches task 2 to the program

disp(prgm,'name')

