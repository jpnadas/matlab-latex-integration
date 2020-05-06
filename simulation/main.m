% This is a simple simulation to show how to integrate Matlab with LaTeX using matlab2tikz
% The simulation generates and plots two sine waves, configures the figure and exports it 
% to TikZ using matlab2tikz. It also exports the parameters into a LaTeX table, so they
% are correctly presented on the paper.

% clear the environmet
clearvars
close all
clc

% building the time axis
max_time = 0.1; % Simulation duration, in seconds.

sampling_frequency = 4.4e4; % Hz
t = 0:1/sampling_frequency:max_time; % time axis

% sine wave parameters
A1 = 2; % Amplitude in Volts
A2 = 1.5; % Amplitude in Volts
f1 = 60; % Frequency in Hz
f2 = 80; % Frequency in Hz
theta1 = 0; % initial phase in radians
theta2 = pi/2; % initial phase in radians

% plotting
LW = 2; % line width

figure % defines a new figure

% plots both sines
plot(t*1e3, ...
     A1 * sin(2*pi*t*f1 + theta1),...
     '--',...
     'linewidth', LW,...
     'DisplayName',['$f$ = ' num2str(f1) ' Hz'])

hold all % hold, such that both are displayed on the same figure

plot(t*1e3, ...
     A2 * sin(2*pi*t*f2 + theta2),...
     'linewidth', LW,...
     'DisplayName',['$f$ = ' num2str(f2) ' Hz'])

% defines properties of the figure
grid on
x = xlabel('Time (ms)')
x.Interpreter = 'latex'
y = ylabel('Value $V(t$) (V)')
y.Interpreter = 'latex'
l = legend('-DynamicLegend')
l.Interpreter = 'latex'

% Export to TikZ to use in the paper
matlab2tikz('../paper/figures/sine_waves.tex')

% Export the simulation parameters to a LaTeX table.
% This uses a cusom class TableRow, provided in this repository.
% This class uses the threeparttable LaTeX package, to provide 
% the possibility of adding notes to rows. It also uses booktabs
% to have a nicer looking table. Make sure that those packages are
% included in your paper code. The class is not very well documented,
% but the general idea is to use it in the following way:
%
% TableRow('Description text', value, 'unit', 'variable name', 'reference', ...additional parameters)
% 
% If no additional parameters are passed, the other positional arguemnts
% that preced it may be ommited. Otherwise, send an empty string.

tableRows(1) = TableRow('Simulation Time', max_time*1e3,'ms','t');
tableRows(end+1) = TableRow('Sampling Frequency', sampling_frequency,'Hz','f_\text{s}','Roy2002');
tableRows(end+1) = TableRow('Amplitude Sine 1', A1,'V','A_1');
tableRows(end+1) = TableRow('Amplitude Sine 2', A2,'V','A_2');
tableRows(end+1) = TableRow('Frequency Sine 1', f1,'Hz','f_1');
tableRows(end+1) = TableRow('Frequency Sine 2', f2,'Hz','f_2');
tableRows(end+1) = TableRow('Initial Phase Sine 1', theta1,'radians','\theta_{0,1}');
% Note that for the next line, we want to set the precision. In order
% to do that, we must give a reference for the parameter (because of 
% the argument positioning). Since we don't have a reference for this 
% parameter, we give it a blank string.
tableRows(end+1) = TableRow('Initial Phase Sine 2', theta2,'radians','\theta_{0,2}', '', 'precision', 3);
printTable(tableRows,'../paper/tables/params', 'tb:params')
