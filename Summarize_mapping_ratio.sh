# This is a bash script to summarize RNA-seq mapping ratio step by step

#!/bin/bash

PATH0=/Share/home/wangsiqi/projects/01.HCC_biomarker/01.exRNA-seq/01.LuLab_HCC_exRNA

for i in `cat ./file_name`
do

        cat $PATH0/01.Pre_cutadapt/${i}/${i}.cutAdapt.log | grep 'Total reads processed' | awk 'BEGIN{FS=OFS=":"}{print $2}' | sed 's/^    [ \t]*//g' | sed 's/,//g' >>01.Raw_reads;


        cat $PATH0/01.Pre_cutadapt/${i}/${i}.cutAdapt.log | grep 'Reads that were too short' | awk 'BEGIN{FS=OFS=":"}{print $2}' | sed 's/^    [ \t]*//g' | sed 's/,//g' | sed 's/ //g' >>02.reads_shorte
r_than_36nt;

        cat $PATH0/01.Pre_cutadapt/${i}/${i}.cutAdapt.log | grep 'Reads written' | awk 'BEGIN{FS=OFS=":"}{print $2}' | sed 's/^    [ \t]*//g' | sed 's/,//g' | sed 's/ //g' >>03.Clean_reads;

        wc -l $PATH0/02.hsa_rRNA_bowtie2/${i}/${i}.no_rRNA.fq |awk 'reads=(($1/4)){printf("%d\n",reads)}' >>05.Kept_reads;


        tail -6 $PATH0/log/${i}.bowtie2_remove_rRNA.pbs.err | grep 'exactly' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/04.rRNA_reads_1;
        tail -6 $PATH0/log/${i}.bowtie2_remove_rRNA.pbs.err | grep '>1' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/04.rRNA_reads_n;
        paste -d "\t" ./tmp/04.rRNA_reads_1 ./tmp/04.rRNA_reads_n | awk 'total=(($1+$2)){print total}' >./tmp/04.rRNA_reads;
        paste ./tmp/04.rRNA_reads ./03.Clean_reads | awk 'ratio=(($1/$2*100)){printf("%.2f\n",ratio)}' | sed 's/$/%/g' | paste -d "\t" ./tmp/04.rRNA_reads - >04.rRNA;


        tail -6 $PATH0/log/${i}.bowtie2_mapping_hg38.pbs.err | grep 'exactly' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/06.hg38_reads_1;
        tail -6 $PATH0/log/${i}.bowtie2_mapping_hg38.pbs.err | grep '>1' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/06.hg38_reads_n;
        paste -d "\t" ./tmp/06.hg38_reads_1 ./tmp/06.hg38_reads_n | awk 'total=(($1+$2)){print total}' >./tmp/06.hg38_reads;
        paste ./tmp/06.hg38_reads ./05.Kept_reads | awk 'ratio=(($1/$2*100)){printf("%.2f\n",ratio)}' | sed 's/$/%/g' | paste -d "\t" ./tmp/06.hg38_reads - >06.hg38;


        tail -6 $PATH0/log/${i}.bowtie2_mapping_miRNA.pbs.err | grep 'exactly' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/11.miRNA_reads_1;
        tail -6 $PATH0/log/${i}.bowtie2_mapping_miRNA.pbs.err | grep '>1' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/11.miRNA_reads_n;
        paste -d "\t" ./tmp/11.miRNA_reads_1 ./tmp/11.miRNA_reads_n | awk 'total=(($1+$2)){print total}' >./tmp/11.miRNA_reads;
        paste ./tmp/11.miRNA_reads ./05.Kept_reads | awk 'ratio=(($1/$2*100)){printf("%.2f\n",ratio)}' | sed 's/$/%/g' | paste -d "\t" ./tmp/11.miRNA_reads - >11.miRNA;


        tail -6 $PATH0/log/${i}.bowtie2_mapping_piRNA.pbs.err | grep 'exactly' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/12.piRNA_reads_1;
        tail -6 $PATH0/log/${i}.bowtie2_mapping_piRNA.pbs.err | grep '>1' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/12.piRNA_reads_n;
        paste -d "\t" ./tmp/12.piRNA_reads_1 ./tmp/12.piRNA_reads_n | awk 'total=(($1+$2)){print total}' >./tmp/12.piRNA_reads;
        paste ./tmp/12.piRNA_reads ./05.Kept_reads | awk 'ratio=(($1/$2*100)){printf("%.2f\n",ratio)}' | sed 's/$/%/g' | paste -d "\t" ./tmp/12.piRNA_reads - >12.piRNA;


        tail -6 $PATH0/log/${i}.bowtie2_mapping_Y_RNA.pbs.err | grep 'exactly' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/13.Y_RNA_reads_1;
        tail -6 $PATH0/log/${i}.bowtie2_mapping_Y_RNA.pbs.err | grep '>1' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/13.Y_RNA_reads_n;
        paste -d "\t" ./tmp/13.Y_RNA_reads_1 ./tmp/13.Y_RNA_reads_n | awk 'total=(($1+$2)){print total}' >./tmp/13.Y_RNA_reads;
        paste ./tmp/13.Y_RNA_reads ./05.Kept_reads | awk 'ratio=(($1/$2*100)){printf("%.2f\n",ratio)}' | sed 's/$/%/g' | paste -d "\t" ./tmp/13.Y_RNA_reads - >13.Y_RNA;


        tail -6 $PATH0/log/${i}.bowtie2_mapping_snRNA.pbs.err | grep 'exactly' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/14.snRNA_reads_1;
        tail -6 $PATH0/log/${i}.bowtie2_mapping_snRNA.pbs.err | grep '>1' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/14.snRNA_reads_n;
        paste -d "\t" ./tmp/14.snRNA_reads_1 ./tmp/14.snRNA_reads_n | awk 'total=(($1+$2)){print total}' >./tmp/14.snRNA_reads;
        paste ./tmp/14.snRNA_reads ./05.Kept_reads | awk 'ratio=(($1/$2*100)){printf("%.2f\n",ratio)}' | sed 's/$/%/g' | paste -d "\t" ./tmp/14.snRNA_reads - >14.snRNA;


        tail -6 $PATH0/log/${i}.bowtie2_mapping_srpRNA.pbs.err | grep 'exactly' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/15.srpRNA_reads_1;
        tail -6 $PATH0/log/${i}.bowtie2_mapping_srpRNA.pbs.err | grep '>1' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/15.srpRNA_reads_n;
        paste -d "\t" ./tmp/15.srpRNA_reads_1 ./tmp/15.srpRNA_reads_n | awk 'total=(($1+$2)){print total}' >./tmp/15.srpRNA_reads;
        paste ./tmp/15.srpRNA_reads ./05.Kept_reads | awk 'ratio=(($1/$2*100)){printf("%.2f\n",ratio)}' | sed 's/$/%/g' | paste -d "\t" ./tmp/15.srpRNA_reads - >15.srpRNA;


        tail -6 $PATH0/log/${i}.bowtie2_mapping_tRNA.pbs.err | grep 'exactly' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/16.tRNA_reads_1;
        tail -6 $PATH0/log/${i}.bowtie2_mapping_tRNA.pbs.err | grep '>1' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/16.tRNA_reads_n;
        paste -d "\t" ./tmp/16.tRNA_reads_1 ./tmp/16.tRNA_reads_n | awk 'total=(($1+$2)){print total}' >./tmp/16.tRNA_reads;
        paste ./tmp/16.tRNA_reads ./05.Kept_reads | awk 'ratio=(($1/$2*100)){printf("%.2f\n",ratio)}' | sed 's/$/%/g' | paste -d "\t" ./tmp/16.tRNA_reads - >16.tRNA;


        tail -6 $PATH0/log/${i}.bowtie2_mapping_other_lncRNA.pbs.err | grep 'exactly' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/17.other_lncRNA_reads_1;
        tail -6 $PATH0/log/${i}.bowtie2_mapping_other_lncRNA.pbs.err | grep '>1' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/17.other_lncRNA_reads_n;
        paste -d "\t" ./tmp/17.other_lncRNA_reads_1 ./tmp/17.other_lncRNA_reads_n | awk 'total=(($1+$2)){print total}' >./tmp/17.other_lncRNA_reads;
        paste ./tmp/17.other_lncRNA_reads ./05.Kept_reads | awk 'ratio=(($1/$2*100)){printf("%.2f\n",ratio)}' | sed 's/$/%/g' | paste -d "\t" ./tmp/17.other_lncRNA_reads - >17.other_lncRNA;


        tail -6 $PATH0/log/${i}.bowtie2_mapping_mRNA.pbs.err | grep 'exactly' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/18.mRNA_reads_1;
        tail -6 $PATH0/log/${i}.bowtie2_mapping_mRNA.pbs.err | grep '>1' | head -1 | awk 'BEGIN{FS=OFS=" "}{print $1}' >>./tmp/18.mRNA_reads_n;
        paste -d "\t" ./tmp/18.mRNA_reads_1 ./tmp/18.mRNA_reads_n | awk 'total=(($1+$2)){print total}' >./tmp/18.mRNA_reads;
        paste ./tmp/18.mRNA_reads ./05.Kept_reads | awk 'ratio=(($1/$2*100)){printf("%.2f\n",ratio)}' | sed 's/$/%/g' | paste -d "\t" ./tmp/18.mRNA_reads - >18.mRNA;


paste -d "\t" ./file_name 01.Raw_reads 03.Clean_reads 04.rRNA 05.Kept_reads 06.hg38 11.miRNA 12.piRNA 13.Y_RNA 14.snRNA 15.srpRNA 16.tRNA 17.other_lncRNA 18.mRNA | cat data_summary.header - >00.data_summary
done
