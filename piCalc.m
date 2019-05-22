%%
% Isaac Chi 
% Monterey Peninsula College
% ENGR 17
% Connett
% Final Project
% Due Date: May 21, 2018
%%
% PROBLEM
% This program is a pi calculator which ises various formulas to
% approximate pi.
% This program will ask the user to select a mode.
% iterations mode or digits mode.
% Iteration Mode
% ---------------
% The program will ask for the number of iterations()i and the amount of
% precision wanted(n), and the series that are being used. It calculates 
% approximations of pi for i iterations while giving n digits each time. 
% It will write the digits into a text file named after the number of 
% iterations and  plot the approximations over the iterations. 

% Digits Mode
% ---------------
% The program will ask the user to enter the number of digits(n), an 
% upperbound for the number of iterations(i), and the series that are 
% being used. It generates n digits of pi using the selected formulas and
% writes the digits into a text file named after the number of digits
% calculated. The calculations are stopped if the amount of iterations 
% exceed i.
% It will also calculate the amount of precison gained and total precision
% after each iteration. 
% Finally, it will plot the approximations, precision gained, and total
% precision over the number of iterations. Each statistic has its own graph. 

% The following formulas will be used in this program.
% Gregory Series*
% Nilakantha series*
% Machin's Formula for pi
% Chudnovsky Series
% Newton's formula
% Ramanujan's Formula for pi
% **Series marked with * converge very slowly. So proceed with caution.**
%%
% INPUT
% mode: a scalar determining the mode
% n: a scalar(the number of digits)
% select: an array of booleans corresponding to the formulas used
% iter: a scalar(the iteration number)

%%
% OUTPUT
% precPerIter: a cell array of vectors of scalars
% (the precision gained after each iteration)

% totalPrecPerIter: a cell array of vectors of scalars
% (the total precision after each iteration)

% piVal: a cell array of vectors of syms(the approximated values of pi)

%%
% Get the mode the user wants
mode = 2;
while mode > 1 || mode < 0
    mode = input('Enter 0 for iteration mode, 1 for digits mode. ');
end
switch mode
    case 0 % Iteration Mode
    % Get number of iterations and wanted precision
    i = input('How many iterations would you like? ');
    n = input('How accurate do you want the approximations to be? ');
    
    case 1 % Digits Mode
    % Get the number of digits the user wants and iteration bound
    n = input('How many digits of pi would you like to generate? ');
    i = input('What is the maximum amount of iterations for each formula? ');
end

% Get the formulas to be used.
% Selection vector
select = false(1,6);
% Display strings
dispSelect = repmat(["Off"], 1, 7);
display = ["Gregory-Leibniz Series"
           "Nilakantha Series"
           "Machin's Formula for pi"
           "Newton's Formula for pi"
           "Ramanujan's Formula for pi"
           "Chudnovsky Algorithm"
           "Exit"];
% Exit boolean
exit = false;
while ~exit
    disp('Select the formula(s) you would like to use.');
    disp('To select multiple formulas, put brackets around your numbers');
    for k = 1:7
        fprintf("%d: %s: %s\n", k, display(k), dispSelect(k));
    end
    changes = input('Enter num(s) to continue : ');
    if changes < 7
        select(changes) = ~select(changes);
        dispSelect(select == true) = "On";
        dispSelect(select == false) = "Off";
        
    elseif changes == 7
        exit = true;
    end
end

% Get the indices of the selected formulas
selections = find(select == true);
% Create an array of function handles
piFunc = {};

for currS = 1:numel(selections)
    s = selections(currS);
    switch s
        case 1
            piFunc{1,currS} = @gregorySum;
            piFunc{2,currS} = @gregory;
        case 2
            piFunc{1,currS} = @nilakanthaSum;
            piFunc{2,currS} = @nilakantha;
        case 3
            piFunc{1,currS} = @machinSum;
            piFunc{2,currS} = @machin;
        case 4
            piFunc{1,currS} = @newtonSum;
            piFunc{2,currS} = @newton;
        case 5
            piFunc{1,currS} = @ramanujanSum;
            piFunc{2,currS} = @ramanujan;
        case 6
            piFunc{1,currS} = @chudnovskySum;
            piFunc{2,currS} = @chudnovsky;
    end       
end

% Set precision to n+4 to guard from rounding error
digits(n+4)

% If digits mode is on
if mode
    % Generate a char vector of the value of pi with the set precision
    piTemplate = char(vpa(pi));
    piTemplate = piTemplate(1:n+2);

    % Create cell arrays for precisions
    precPerIter = {};
    totalPrecPerIter = {};
else % If iteration mode is on
    % Create a cell array of the generated pi digits
    genPi = {};
end
% Create a cell array for the approximations of pi.
piVal = {};

% loop through the selections array
for currS = 1:numel(selections)
    % Helper variables for calculations
    iter = 0;
    nth_par = 0;
    currVal = 0;
    
    % if digits mode is on
    if mode
        % Define helper variables for digits mode
        prevPrec = 0;
        totalPrec = 0;
        genPi = ''; % genPi is a reference
        % while the precision has not been met
        while  ~isempty(prevPrec) && prevPrec < n && iter < i
            % Calculate pi
            nth_par = vpa(nth_par + piFunc{1, currS}(sym(iter)));
            currVal = vpa(piFunc{2, currS}(nth_par));
            genPi = char(currVal);

            % Compare the genPi and piTemplate char vectors
            % Make the lengths of the piTemplate and genPi equal to each other
            % first, then compare.
            if numel(genPi) < numel(piTemplate)
                piCompare = [genPi zeros(1, numel(piTemplate)-numel(genPi))*32]...
                            == piTemplate(1:end);
            else
                piCompare = [piTemplate zeros(1, numel(genPi)-numel(piTemplate))]...
                            == genPi(1:end);
            end
            % Find the first 0 in the logical array
            % If there is none, the pi has been calculated
            totalPrec = find(piCompare == 0, 1)-2; 
            % Increment iter
            iter = iter + 1;

            % Precision gained is the new precision - old precision
            if isempty(totalPrec)
                precPerIter{currS}(iter) = n - prevPrec;
            else
                precPerIter{currS}(iter) = totalPrec - prevPrec;
            end
            prevPrec = totalPrec;
            
            % add precision to total precision 
            totalPrecPerIter{currS}(iter) = totalPrec;
            
            % store the approximation
            piVal{currS}(iter) = currVal;
            
        end 
    else
        while iter < i
            % Calculate pi
            nth_par = vpa(nth_par + piFunc{1, currS}(sym(iter)));
            currVal = vpa(piFunc{2, currS}(nth_par));
            % Increment iter
            iter = iter+1;
            % store the approximation
            piVal{currS}(iter) = currVal;
        end
        genPi{currS} = char(currVal);% GenPi is a cell array of char arrays 
    end
end

% get the labels for the legend
names = display(selections);

if mode
% Plot and text for digits mode
    %Plotting Total Precision over Iterations
    figure(1)
    axis([0, i, 0, inf])
    hold on
    for currS = 1:numel(selections)
        plot(1:numel(totalPrecPerIter{currS}), ... 
                        totalPrecPerIter{currS}, '.-')
    end
    title('Total Precision per Iteration')
    xlabel('Iteration')
    ylabel('Precision')
    legend(names)

    %Plotting Precision over Iterations
    figure(2)
    axis([0, i, -inf, inf])
    hold on
    for currS = 1:numel(selections)
        plot(1:numel(precPerIter{currS}), precPerIter{currS}, '.-')
    end
    title('Precision Gained/Lost per Iteration')
    xlabel('Iteration')
    ylabel('Precision')
    legend(names)
end

%Plotting Approximation
figure(3)
axis([0, i, 2, 5])
hold on
for currS = 1:numel(selections)
    plot(1:numel(piVal{currS}), piVal{currS}, '.-')
end
title('\pi Approximations using Various Formulas')
xlabel('Iteration')
ylabel('Approximations')
legend(names)

% Text file modification
if mode
    fileID = fopen(num2str(n)+ "digitsOfPi.txt", 'w');
    text = piTemplate;
    while numel(text) >= 70
        fprintf(fileID, '%s\n', text(1:70));
        text = text(71:end);
    end
    fprintf(fileID, '%s\n', text);
    fclose(fileID);
else
    fileID = fopen(num2str(i)+ "iterToPi.txt", 'w');
    for currS = 1:length(selections)
        k = selections(currS);
        fprintf(fileID, display(k)+"\n--------------------------------\n");
        if numel(genPi{currS}) < n
            text = genPi{currS};
        else
            text = genPi{currS}(1:n);
        end
        while numel(text) >= 70
            fprintf(fileID, '%s\n', text(1:70));
            text = text(71:end);
        end
        fprintf(fileID, '%s\n', text);
    end
    fclose(fileID);
end