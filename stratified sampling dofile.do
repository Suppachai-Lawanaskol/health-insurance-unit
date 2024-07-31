***********OPD*****************
use ipd_opd_stratified sampling.dta,clear
destring hn,replace
**stratified sampling the auditation process**
gen diag_group=substr(pdx,1,1)
gen d_diag_group_number=substr(pdx,2,2) if diag_group=="D"
destring d_diag_group_number,replace
count if diag_group=="A" | diag_group=="B" 
drop if diag_group==""
drop if status=="ipd"
**There are missing in the principle diagnosis, 414 charts, IPD=2, OPD=412**
**Start sampling**
set seed 1234
sample 4 if diag_group=="A" | diag_group=="B" ,count 
sample 2 if d_diag_group_number>=50 & d_diag_group_number!=.,count 
sample 2 if diag_group=="E",count 
sample 2 if diag_group=="I",count 
sample 2 if diag_group=="J",count 
sample 2 if diag_group=="K",count 
sample 4 if diag_group=="M",count 
sample 4 if diag_group=="O",count 
sample 4 if diag_group=="R",count 
sample 4 if diag_group=="S",count 
sample 10 if diag_group=="Z",count 
sample 10 if !(diag_group=="A" | diag_group=="B") & !(d_diag_group_number>=50 & d_diag_group_number!=.) & diag_group!="E" & diag_group!="I" & diag_group!="J" & diag_group!="K" & diag_group!="M" & diag_group!="O" & diag_group!="R" & diag_group!="S" & diag_group!="Z",count
tab diag_group
sort diag_group pdx
list date vn hn pdx status diag_group,sep(10)
***********IPD*****************
use ipd_opd_stratified sampling.dta,clear
destring hn,replace
**stratified sampling the auditation process**
gen diag_group=substr(pdx,1,1)
gen o_diag_group_number=substr(pdx,2,2) if diag_group=="O"
gen z_diag_group_number=substr(pdx,2,2) if diag_group=="Z"
**Exclude**
destring o_diag_group_number,replace
destring z_diag_group_number,replace
drop if o_diag_group_number==80
drop if z_diag_group_number==38

count if diag_group=="A" | diag_group=="B" 
drop if diag_group==""
drop if status=="opd"
**There are missing in the principle diagnosis, 414 charts, IPD=2, OPD=412**
**Start sampling**
set seed 1234
sample 4 if diag_group=="A" | diag_group=="B" ,count 
sample 4 if diag_group=="C",count
sample 4 if diag_group=="I",count 
sample 4 if diag_group=="J",count 
sample 4 if diag_group=="K",count
sample 2 if diag_group=="M",count 
sample 2 if diag_group=="N",count 
sample 4 if diag_group=="O",count
sample 4 if diag_group=="P",count
sample 4 if diag_group=="S",count
sample 4 if !(diag_group=="A" | diag_group=="B") & diag_group!="C" & diag_group!="I" & diag_group!="J" & diag_group!="K" & diag_group!="M" & diag_group!="N" & diag_group!="O" & diag_group!="P"  & diag_group!="S",count
tab diag_group
sort diag_group pdx
format %10.0f vn
list date vn hn pdx status diag_group,sep(10)


