clc; clear; close all;

xs = linspace(-10,10,21);
ys = [];
for i = 1:length(xs)
    ys(i) = mfis(xs(i));
end

figure;
plot(xs,ys,xs,xs.^2)
xlabel('Input variable "x"')
ylabel('Ouput variable "y"')
%y = mfis(0)
%----------------------------------------------------------------------------
%                   STAGE ONE: DEFINE FUZZY SETS
%-----------------------------------------------------------------------------------  
 function [y]=mfis(x)
 
 % Defining five Membership functions, NB, NS, Z, PS, PB
 
 NB = lshlder(x,-10,-5,-10);
 NS = triangle(x,-5,0,-10);
 Z  = triangle(x,0,5,-5);
 PS = triangle(x,5,10,0);
 PB = rshlder(x,10,10,5);
 
 % Defining the Three Membership functions, N, S, V
 
 N_l=0;
 N_c=0;
 N_r=25;
 %
 S_l=0;
 S_c=25;
 S_r=100;
%
 V_l=25;
 V_c=100;
 V_r=100;

 %----------------------------------------------------------------------------
 %     STAGE TWO: RULE BASE AND INFERENCE USING SCALED OUTPUT APPROACH
 %----------------------------------------------------------------------------
 % Rule 1 
 % IF x = Z THEN y = N
   Mu_N = Z;

 % Rule 2
 % IF x = NS or PS THEN y = S
   Mu_S = max(NS, PS);
 
  % Rule 3
  % IF x = NB or PB THEN y = V
   Mu_V = max(NB, PB);
   
  % Inference using Scaled Output Approach
  
  % In the Product implication method, the fuzzy logic inference system scales the output 
  % membership functions at the value of the corresponding rule weights.
  
  % We find the Areas of each output membership function separately
  
     A_N = 0.5*Mu_N*(N_r-N_l);

     A_S = 0.5*Mu_S*(S_r-S_l);

     A_V = 0.5*Mu_V*(V_r-V_l);
     
   % Note that in this example the Output Membership Functions do not intersect 

   % The Union of the Output membership functions fired is simply the sum of the areas
   
     Union_Areas=A_N+A_S+A_V;
%----------------------------------------------------------------------------
%    STAGE THREE: DEFUZZIFICATION 
%----------------------------------------------------------------------------
% We use center of Area Approach which is popular and simple to realize

  y=(A_N*N_c+A_S*S_c+A_V*V_c)/Union_Areas; 

end
%
%*****************************************************************************
%                               END OF PROGRAM
%*****************************************************************************