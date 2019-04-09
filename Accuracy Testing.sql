
/*sum on source table*/
select column_name
,sum(Amount_Column) as Amount_Column
into Table_Name_accuracy_Src
from Table_Name_Src
group by column_name
------------------------
/*sum on target table*/
select column_name
,sum(Amount_Column) as Amount_Column
into Table_Name_accuracy_Trg
from Table_Name_trg
group by column_name
---------------------------------
/*inner join of both the tables*/
select a.column_name,
abs(a.Amount_Column- b.Amount_Column) as dif_Amount_Column
into eydb.dbo.FP3_FIX_TD_AUDIT_TRAIL_TEMP_Accuracy
from Table_Name_accuracy_Src a
inner join Table_Name_accuracy_Trg b
on a.column_name=b.column_name