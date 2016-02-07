% prgm_test.m
%
% N.B. Hawes
% 1/07/2016
%
% This m file tests the following classes: task, program, tree
clear all; close all; clc;
addpath('functions\');

% Make a program
prgm=program('myProgram','this is the first one');

% Make some tasks & subtasks
task1=task('Task1','');
task2=task('Task2','');
subtask1_1=task('SubTask1,1','');
subtask1_2=task('SubTask1,2','');
subtask1_3=task('SubTask1,3','');
subtask1_2_1=task('SubTask1,2,1','');
subtask1_2_2=task('SubTask1,2,2','');
subtask1_3_1=task('SubTask1,3,1','');
subtask3_1=task('SubTask3,1','');
% Attach tasks & subtasks
attachchild(task1,subtask1_1); % This attaches a subtask to task 1

attachchild(subtask1_2,subtask1_2_1);
attachchild(subtask1_2,subtask1_2_2);
attachchild(task1,subtask1_2);

attachchild(subtask1_3,subtask1_3_1);
attachchild(task1,subtask1_3);


attachchild(prgm,task1); % This attaches task 1 to the program
attachchild(prgm,task2); % This attaches task 2 to the program

task3=addchild(prgm,'Task3','',subtask3_1); % Add task3 directly to prgm and have subtask3_1 added under task3 

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

if all(ismember(leaves,[subtask3_1,subtask1_1,subtask1_2_1,subtask1_2_2,subtask1_3_1,task2]))
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

promote(subtask1_2_1)
move(subtask1_2,prgm)
update(prgm)
disp(prgm)

% Make sure subtask1_2_1 was promoted (and the it was removed from subtask1_2)
% Make sure subtask1_2 was moved under prgm (and that it was removed from task1
a(1)=ismember(subtask1_2_1,task1.children);
a(2)=~ismember(subtask1_2_1,subtask1_2.children);
a(3)=ismember(subtask1_2,prgm.children);
a(4)=~ismember(subtask1_2,task1.children);

disp(' ')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('% Checking disp, promote, and move functions')
if all(a)
    disp('% ...Passed')
else
    disp('% ...Failed')
end
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp(' ')