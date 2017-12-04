% Quyen Hua
% EE5673
% Module 7 MATLAB Assignment

function [ out ] = EE5673_M7( lambda1,lambda2, deltaT)
%EE5673_M7 
% Matlab function that returns the state transition matrix for the above 
% two-bus, three-processors system of slide 22 of module 7 notes
% given the bus failure rate (?1), processor failure rate (?2),
% and time interval (?t) as inputs. 


% Assign positions in the chain diagram as below,
% 32-->22-->12->
% |    |    |   \
% v    v    v   |
% 31-->21-->11-->F1
% \    |    /
%      v
%     F2

% with the following states:

% 1-->2-->3->
% |   |   |   \
% v   v   v   |
% 4-->5-->6-->7
% \    |    /
%      v
%      8

% therefore, our matrix will output transitions as follows:
% 1->1, 1->2, 1->3, ..., 1->8
% 2->1, 2->2, 2->3, ..., 2->8
% etc.

% this gives an 8x8 matrix 

% calculate the no transition values
oneone      =1-3*lambda1*deltaT-2*lambda2*deltaT;
twotwo      =1-2*lambda1*deltaT-2*lambda2*deltaT;
threethree  =1-1*lambda1*deltaT-2*lambda2*deltaT;
fourfour    =1-3*lambda1*deltaT-1*lambda2*deltaT;
fivefive    =1-2*lambda1*deltaT-1*lambda2*deltaT;
sixsix      =1-1*lambda1*deltaT-1*lambda2*deltaT;
sevenseven  =1;
eighteight  =1;

% the 9 possible transitions listed below:
onetwo      =3*lambda1*deltaT;
onefour     =2*lambda2*deltaT;
twothree    =2*lambda1*deltaT;
twofive     =2*lambda2*deltaT;
threesix    =2*lambda2*deltaT;
threeseven  =1*lambda1*deltaT;
fourfive    =3*lambda1*deltaT;
foureight   =1*lambda2*deltaT;
fivesix     =2*lambda1*deltaT;
fiveeight   =1*lambda2*deltaT;
sixseven    =1*lambda1*deltaT;
sixeight    =1*lambda2*deltaT;

% populate the matrix...
out = [oneone, onetwo, 0, onefour, 0, 0, 0, 0;...
        0, twotwo, twothree,0 ,twofive, 0, 0, 0;...
        0, 0, threethree, 0, 0, threesix, threeseven, 0;...
        0, 0, 0, fourfour, fourfive, 0, 0, foureight;...
        0, 0, 0, 0, fivefive, fivesix, 0, fiveeight;...
        0, 0, 0, 0, 0, sixsix, sixseven, sixeight;...
        0, 0, 0, 0, 0, 0, 1, 0; ...
        0, 0, 0, 0, 0, 0, 0, 1];
        
end

