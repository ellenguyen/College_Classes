/* Final Project: Hypothesis Testing
   Hypothesis: Average body temperature is 98.6 degrees Fahrenheit. */

/* Elle */
/* Import the dataset */
PROC IMPORT DATAFILE = "/home/u63749642/Final_Project/Project_Dataset.csv"
			OUT = temp_project
			DBMS = CSV
	REPLACE;
	DELIMITER = ',';
	GETNAMES = YES;
	GUESSINGROWS = MAX;
RUN;

/* Get file info */
PROC CONTENTS DATA = temp_project;
RUN;

/* Confidence Interval of the Mean - default is 95% confidence interval */
TITLE 'Analysis of Body Temperature';
ODS SELECT BasicIntervals;
PROC UNIVARIATE DATA = temp_project CIBASIC;
   VAR body_temp;
RUN;

/* Conclusion: 
- The 95% confidence interval is 98.12 to 98.38 degrees Fahrenheit.
- We are 95% confident that the true mean body temperature for the population is between 98.12 and 98.38 degrees. */

/* One-Sample t-Test */
ODS GRAPHICS ON;
PROC TTEST H0 = 98.6 PLOTS(SHOWH0);
	VAR body_temp;
RUN;
ODS GRAPHICS OFF;

/* Conclusion:
- The t statistic is -5.45 and the corresponding p-value is < .0001
- Hence, we reject the null hypothesis since the p-value is less than the default alpha level of .05.

/* Conduct another One-Sample t-Test at a different H0 */
ODS GRAPHICS ON;
PROC TTEST H0 = 98.2 PLOTS(SHOWH0) ALPHA = 0.1;
	VAR body_temp;
RUN;
ODS GRAPHICS OFF;

/* Produce more distributions and descriptive statistics */
PROC UNIVARIATE DATA = temp_project NORMAL MU0 = 98.6;
	VAR body_temp;
	HISTOGRAM;
	PROBPLOT;
RUN;


/* Andy - summarize statistics */
/* Mean, Standard Deviation, Min/Max, Lower/Upper Quartile, Median, Interquartile range */
PROC MEANS DATA = temp_project MEAN MEDIAN STD MIN MAX Q1 Q3 QRANGE MAXDEC = 3;
	CLASS gender;
	VAR body_temp heart_rate;
	TITLE "Simple Descriptive Stats for TempData";
RUN;

/* Calculates simple descriptive statistics for categorical data */
PROC FREQ DATA = temp_project;
	TABLES gender body_temp heart_rate;
RUN;

/* Plot BodyTemp against HeartRate */
/* Scatter plot */
symbol1 v=circle color=red;
symbol2 v=triangle color=black;
PROC GPLOT DATA = temp_project;
	TITLE "Scatter Plot of BodyTemp by HeartRate";
	PLOT body_temp*heart_rate=gender; *Plot statement represents the variable before asterisk on the y-axis;
RUN;

/* Generate barchart */
PROC GCHART DATA = temp_project;
	TITLE "Bar Chart for BodyTemp";
	VBAR body_temp;
RUN;

PROC GCHART DATA = temp_project;
	TITLE "Bar Chart for HeartRate";
	VBAR heart_rate;
RUN;

/* Box-and-whisker plot -> no outliers */
PROC BOXPLOT DATA = temp_project;
	TITLE "Distribution of Body Temperature by Gender";
	PLOT body_temp*gender;	
RUN;

/* Correlation function */
PROC CORR DATA = temp_project;
	VAR body_temp heart_rate;
RUN;

/* Simple Linear Regression to find normality */
PROC REG DATA = temp_project;;
	MODEL body_temp = heart_rate;
	TITLE "Example of SLR using Proc REG";
RUN;

symbol V=star I=RL;
PROC GPLOT DATA = temp_project;
	PLOT body_temp*heart_rate;
RUN;