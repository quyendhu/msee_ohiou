% Quyen Hua
% EE5713
% M8 - MATLAB

% The provided matlab function idealized_binary_signaling.m simulates the 
% transmission of a polar NRZ signal with one sample per symbol, over an 
% additive Gaussian noise channel. The sample plot in figure 1 shows the 
% data signal (blue stem plot) and the noisy received signal+noise
% (red stem plot). The receiver only gets to observe the signal+noise,
% and makes bit decisions by deciding data=1 if the received signal is
% >0 and data =0 if the received signal is <0.
% Study the code, run to produce plots of figures 1 and 2, 
% and answer the following questions.
% 
%    1 In the figure 1 plot, identify which bits are decided in error by the receiver.
%     You can do this by simply looking at the plot.
%     
%   2  Figure 2 presents the probability of bit error vs. Eb/N0 in dB 
%     (we will study this in more detail in module 12.) 
%     What built in matlab function is used to calculate the theoretical bit error curve?
%    
%   3 What is the approximate bit error rate at Eb/No = 7 dB.
%     
%   4  Where do the simulated curve and the theoretical curve deviate most from each other? Why?
% 
% Turn in the two plots and the answers to the questions. 

clear all;
close all;

idealized_binary_signaling;