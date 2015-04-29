**** in sas basic information about dataset could be obtained by PROC CONTENTS
*** below pleas find example for sashel.cars dataset;


proc contents data=sashelp.cars;
run;

*** if you would like to assign information about eg. number of rows out should data _null_ and macro variables ;

data _NULL_;
	if 0 then set sashelp.cars nobs=n;
	call symputx('nrows',n);
	stop;
run;
%put nobs=&nrows;

*** for tabular reports first function could be proc freq;

proc freq data=sashelp.cars;
table origin /plots=freq;
run;

** if you would like to change results (eg. names displayed in table) you could use proc format;

proc format;
value $tab 'Asia'='A' 'Europe'='E' 'USA'='U';
run;

proc freq data=sashelp.cars;
table origin;
format origin $tab.;
run;

*** in sas you write functions which are called macros.
To declare macro first start with keyword %macro and end with %mend
Then you can declare variables.

Below you can find the same function as written in R;


%macro myFunction(ds=,x=,dn=);
proc freq data=&ds.;
table &x. /plots=freq;

%if (%length(&dn.)~=0) %then %do;
format &x. &dn.;
%end;

run;

%mend myFunction;

** execution of macro;
%myFunction(ds=sashelp.cars,x=origin,dn=$tab.);
