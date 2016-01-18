% prgm_test.m
%
% N.B. Hawes
% 1/07/2015
%
% This m file tests the following classes: task, program, tree
clear all; close all; clc;
addpath('functions\');

% Make a program
prgm=program('myProgram','this is the first one');

% Make some tasks & subtasks
task1=task('firstTask','');
task2=task('secondTask','');
subtask1_1=task('firstSubTask','');
subtask1_2=task('secondSubTask','');
subtask1_3=task('thirdSubTask','');
subtask1_2_1=task('firstSubSubTask','');
subtask1_2_2=task('secondSubSubTask','');
subtask1_3_1=task('thirdSubSubTask','');
subtask3_1=task('fourthSubTask','');
% Attach tasks & subtasks
attachchild(task1,subtask1_1); % This attaches a subtask to task 1

attachchild(subtask1_2,subtask1_2_1);
attachchild(subtask1_2,subtask1_2_2);
attachchild(task1,subtask1_2);

attachchild(subtask1_3,subtask1_3_1);
attachchild(task1,subtask1_3);

task3=addchild(prgm,'thirdTask','',subtask3_1); % Add task3 directly to prgm and have subtask3_1 added under task3 

attachchild(prgm,task1); % This attaches task 1 to the program
attachchild(prgm,task2); % This attaches task 2 to the program

% Make a 2nd program and try to attach it to prgm, this should fail
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('% Checking double attachment')
prgm2=program('myProgram2','this is the second one');
good=0;
try
   attachchild(prgm,prgm2)
catch err
   good=strcmp(err.message,'Cannot attach a program object to anything');
end

if good
    disp('% ...Passed')
else
    disp('% ...Failed')
end
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp(' ')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('% Checking leaf find')

% Find the leaf tasks
leaves=findleaves(prgm);

if all(leaves==[subtask3_1,subtask1_1,subtask1_2_1,subtask1_2_2,subtask1_3_1,task2])
    disp('% ...Passed')
else
    disp('% ...Failed')
end
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp(' ')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('% Checking update function')
% Check if the update function works properly by adding cost & time to the
% leaf tasks and then running update on prgm

rand1=20*rand(length(leaves),1);
rand2=40*rand(length(leaves),1);

for i=1:length(leaves)
    leaves(i).cost=rand1(i);
    leaves(i).time=rand2(i);
end
    
update(prgm);

chk=[prgm.cost,prgm.time];

if chk(1)==sum(rand1)&&chk(2)==sum(rand2)
    disp('%...Passed')
else
    disp('...Failed')
end
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp(' ')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('% Checking disp, promote, and move functions')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

% Display the tree
disp(prgm)
promote(subtask1_2_1)
move(subtask1_2,prgm)
disp(prgm)