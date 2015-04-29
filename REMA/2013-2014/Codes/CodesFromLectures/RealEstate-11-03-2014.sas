*** assigning libary to given path
libname REMA3 'C:\Users\L419Kst\teacher\REMA';

*** declaration of dataset with sheet names;
data sheets;
input sheetname $;
cards;
Kody
DANE
Aglomer
Teren
;
run;

*** assigning value to macro variable path;
%let path=C:\Users\L419Kst\teacher\REMA;

*** declaration of macro for importing sheets from excel workbook;

%macro importdata(in,out);
%do i=1 %to 4;
data _null_;
set sheets(obs=&i);
call symputx('sheet',sheetname);
run;
proc import out=REMA3.&out.&sheet
datafile="&path.\&in..xls" dbms=excel replace; range="&sheet.$"; run; %end; %mend; %importdata(działki,dzialki); %importdata(domy,domy); 

*** macro usage;

%importdata(mieszkania,mieszkania);
%importdata(wynajem,wynajem);

