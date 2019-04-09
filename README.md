Software used for testing:
1.	SQL Server management Studio (SSMS)
2.	Sybase central
3.	Microsoft visual studio 2010
4.	Oracle SQL
Steps for Data Migration testing:
1.	Create 2 databases in SSMS: Target and source
2.	Import the tables from the target system (Oracle) into the SQL target database, using import export wizard.
3.	Copy the source text files from the source system into a specific folder on the server.
4.	In the data type file that was given by the bank, certain changes are to be made as the SQL SMS doesn’t support a few datatypes. The following datatypes need to be changed in the Source section: 
Number- Numeric
Varchar2- Varchar
Timestamp(6)- Datetime
5.	Use the ‘Datatype and Update’ file to prepare TblCrt table on SSMS, which consists of the datatypes of all the tables in the required format. This TblCrt table should be stored in target database (target database specifically because the codes were written accordingly).
 
6.	Create the result table. (Query is there in the ‘Row Count Check’ file.)
7.	Run the code for ‘Check Row Count’, ‘Copy and Check’ and ‘Create Table’ procedures.
8.	For completeness testing, use the ‘Row Count Check’ file. The results will be stored in result table.
9.	For data type and data length check, use the ‘Data Type & Length’ file.
10.	For Null check, first create the null check procedure using ‘Null Function’ file and then just run the statement which is mentioned at the end of the query in the ‘Null Function’ file.
11.	For accuracy check, first create the Accuracy check procedure using ‘Accuracy_1_Procedure (to find unique keys)’ file. Then use ‘Accuracy Testing’ file for the queries to be used to test the accuracy.


