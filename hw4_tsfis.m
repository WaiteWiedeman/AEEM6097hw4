%************************************************************************
% Prepared by Prof. Kelly Cohen for Soft Computing Based AI Class
%        University of Cincinnati, July 16 2020
%************************************************************************
clc; clear; close all;

x1 = -10:0.1:10;
y=x1.^2;
% Where y is the function we wish to approximate using fuzzy logic
figure(1)
plot(x1,y)
xlabel('Input variable "x"')
ylabel('Ouput variable "y"')

% Defining the 7 Triangle shaped membership functions for the input variable
% Using Kelly Cohen's ToolBox's triangle command

for N=1:length(x1)
    x=x1(N);
    NB(N) = lshlder(x,-10,-7.5,-10);
    NS(N) = triangle(x,-7.5,-5,-10);
    NM(N) = triangle(x,-5,-2.5,-7.5);
    NZ(N) = triangle(x,-2.5,0,-5);
    PZ(N) = triangle(x,2.5,5,0);
    PM(N) = triangle(x,5,7.5,2.5);
    PS(N) = triangle(x,7.5,10,5);
    PB(N) = rshlder(x,10,10,7.5);
end

% Plotting the Inout variable Membership functions
figure(2)
plot(x1,NB,x1,NS,x1,NM,x1,NZ,x1,PZ,x1,PM,x1,PS,x1,PB) %x1,Z,
xlabel('Input variable "x"')
legend('NB','NS','NM','NZ','PZ','PM','PS','PB');

%*************************************************************************
% Calculate the Fuzzy function Apprioximatin using Takagi-Sugeno Approach
%*************************************************************************

for N=1:length(x1)
    x=x1(N);

% % Calculate the Membership Function of each of the 5 Rules
Mu_R1=PZ(N); Mu_R2=PM(N); Mu_R3=PS(N); Mu_R4=PB(N);
Mu_R5=NZ(N); Mu_R6=NM(N); Mu_R7=NS(N); Mu_R8=NB(N);

% Using Supervised learning (Linear Curve Fit) to Calculate the formula for
% each Rule based on Takagi-Sugeno Fuzzy System Architecture
f1=0.5*x; f2=4*x; 
f3=6*x; f4 = 10*x;
f5=-0.5*x; f6=-4*x;
f7=-6*x; f8=-10*x;

% Defuzzification Calculation using Takagi-Sugeno (T-S) approach (Page 88 of John
% H. Lilly book "Fuzzy Control and Identification", Wiley, 2010)

Defuzz_Output=(f1*Mu_R1+f2*Mu_R2+f3*Mu_R3+f4*Mu_R4+f5*Mu_R5+f6*Mu_R6+f7*Mu_R7+f8*Mu_R8)...
    /(Mu_R1+Mu_R2+Mu_R3+Mu_R4+Mu_R5+Mu_R6+Mu_R7+Mu_R8);

DF(N)=Defuzz_Output;
end
% Comparing the T-S Fuzzy Approximator with the Original Function
figure(3)
plot(x1,DF,x1,y)
xlabel('Input variable "x"')
ylabel('Ouput variable')