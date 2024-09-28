/* Step 1: Assign a libref */
libname grp6 '/home/u60908848/stats project 2024';

/* Step 2: Print the dataset */
proc print data=grp6.group_6_train;
run;

proc means data=grp6.group_6_train;
run;


DATA grp6.group_6_train;
SET LIBRARY.group_1_train
(RENAME=
  (_1=Student_Age
_2 = Sex
_3 = Grad_High_School_Type
_4 = Scholarship_Type
_5 = Additional_Mark
_6 = Artistic_Sports_Activity
_7 = Partner
_8 = Salary
_9 = Transportation
_10 = Accommodation
_11 = Mother_Edu
_12 = Father_Edu
_13 = No_Siblings
_14 = Parental_Stat
_15 = Mothers_Occu
_16 = Fathers_Occu
_17 = Weekly_Stu_Hour
_18 = Read_Freq_Non_Scien
_19 = Read_Freq_Scien
_20 = Seminar_Attend
_21 = Impact_Proj_Stud_Succ
_22 = Attendance
_23 = Prep_Mid_Term_Exam_1
_24 = Prep_Mid_Term_Exam_2
_25 = Taking_Notes_Class
_26 = Listening_Class
_27 = Discussions
_28 = Flip_Class
_29 = Cumal_GPA_Last_Sem
_30 = Expected_GPA_Grad));
DROP _dataobs_;
RUN;

/*This allows one to print the new dataset that we have created from the previous piece of code that was used by the set statement*/
ODS HTML;
PROC PRINT DATA grp6.group_6_train;
RUN;
ODS HTML CLOSE;

/* Step 1: Check normality for Attendance */
proc univariate data=grp6.group_6_train normal;
   var Attendance;
   histogram Attendance / normal;
   probplot Attendance / normal(mu=est sigma=est);
   inset mean std skewness kurtosis / position=ne;
run;

proc univariate data=grp6.group_6_train normal;
   var Expected_GPA_Grad;
   histogram Expected_GPA_Grad / normal;
   probplot Expected_GPA_Grad / normal(mu=est sigma=est);
   inset mean std skewness kurtosis / position=ne;
run;

/* Scatter plot for Attendance vs Expected_GPA_Grad */
proc sgplot data=grp6.group_6_train;
   scatter x=Attendance y=Expected_GPA_Grad / markerattrs=(symbol=circlefilled);
   xaxis label="Attendance";
   yaxis label="Expected GPA at Graduation";
run;

proc sgplot data=grp6.group_6_train;
   vbox Attendance / category=Sex;
   xaxis label="Sex";
   yaxis label="Attendance";
run;

proc sgplot data=grp6.group_6_train;
   vbox Expected_GPA_Grad / category=Sex;
   xaxis label="Sex";
   yaxis label="Expected GPA at Graduation";
run;


proc freq data=grp6.group_6_train;
   tables Expected_GPA_Grad / nocum;
run;

proc freq data=grp6.group_6_train;
   tables Attendance * Expected_GPA_Grad / chisq;
run;


ods graphics on;
proc sgplot data=grp6.group_6_train;
   scatter x=Attendance y=Expected_GPA_Grad / markerattrs=(symbol=circlefilled);
   xaxis label="Attendance";
   yaxis label="Expected GPA at Graduation";
run;







