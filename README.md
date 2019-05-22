# Pi_Generation
A final project I made for my Matlab class

# piCalc.m
This program is a pi calculator which uses various formulas to
approximate pi.
This program will ask the user to select a mode.
iterations mode or digits mode.

# Iteration Mode
The program will ask for the number of iterations(i) and the amount of
precision wanted(n), and the series that are being used. It calculates 
approximations of pi for i iterations while giving n digits each time. 
It will write the digits into a text file named after the number of 
iterations and  plot the approximations over the iterations. 

# Digits Mode
The program will ask the user to enter the number of digits(n), an 
upperbound for the number of iterations(i), and the series that are 
being used. It generates n digits of pi using the selected formulas and
writes the digits into a text file named after the number of digits
calculated. The calculations are stopped if the amount of iterations 
exceed i.
It will also calculate the amount of precison gained and total precision
after each iteration. 
Finally, it will plot the approximations, precision gained, and total
precision over the number of iterations. Each statistic has its own graph. 

# The following formulas will be used in this program.
Gregory Series*,
Nilakantha series*,
Machin's Formula for pi,
Chudnovsky Series,
Newton's formula,
Ramanujan's Formula for pi,

**Series marked with * converge very slowly. So proceed with caution.**
