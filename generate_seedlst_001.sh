#!/bin/bash
seeddir=/lustre/janus_scratch/yeti4009/ASN_OBS/SEED
#seeddir=/rc_scratch/life9360/BOSA_COR/SEED
#seeddir=/rc_scratch/life9360/COR_TA_TEST/SEED
#lstdir=/lustre/janus_scratch/life9360/COR_US_CONTINENT/working_${year}/seed.lst
#lstdir=/lustre/janus_scratch/life9360/COR_US_CONTINENT/working_${year}/seed_${m}.lst
#lstdir=/lustre/janus_scratch/life9360/COR_BOSA/seed.lst
lstdir=/lustre/janus_scratch/life9360/seed.lst
if [ -e seed.lst ]; then
        rm -f seed.lst
fi
cd $seeddir
ls OBS*seed >> ~/seed_fname.lst
awk 'BEGIN {FS="."} ; {print $2,$3}' ~/seed_fname.lst >~/monday.lst
awk 'BEGIN {FS="."} ; {print $1}' ~/seed_fname.lst  > ~/year.lst
awk 'BEGIN {FS="_"} ; {print $2}' ~/year.lst  > ~/year2.lst

cat ~/monday.lst |  sed s/'JAN'/'1'/ | sed s/'FEB'/'2'/ | sed s/'MAR'/'3'/ | sed s/'APR'/'4'/ | sed s/'MAY'/'5'/ | sed s/'JUN'/'6'/ | sed s/'JUL'/'7'/ | sed s/'AUG'/'8'/ | sed s/'SEP'/'9'/ | sed s/'OCT'/'10'/ | sed s/'NOV'/'11'/ | sed s/'DEC'/'12'/ > ~/monday2.lst
for fname in `cat ~/seed_fname.lst`
do
        echo "${seeddir}/${fname}" >> ~/seed_fname2.lst
done
paste ~/seed_fname2.lst ~/year2.lst ~/monday2.lst > ~/seed1.lst
awk '{print $1, $2, $3, $4 }' ~/seed1.lst > ~/seed.lst	
rm ~/year.lst ~/year2.lst ~/monday.lst ~/monday2.lst ~/seed_fname.lst ~/seed_fname2.lst ~/seed1.lst
mv ~/seed.lst $lstdir
