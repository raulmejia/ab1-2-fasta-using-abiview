# sudo apt-get install emboss

abiview -graph png 48_Dr.Kain-as_F12.ab1 -outseq 48_Dr.Kain-as_F12.fasta

ls * | parallel -j+2 --eta abiview 


mkdir -p $logs_path/HaplotypleCaller/
mkdir -p $results_path/HaplotypeCaller/

for sample in $CHSKHV_bams_path/*.bam;do
    name=${sample%.bam}
    $invokegatk HaplotypeCaller\
    -R $myrefgenome\
    -I $sample\
    --emit-ref-confidence GVCF\
    -O $results_path/HaplotypeCaller/$(basename $name).erc-GVCF.vcf\
    --dbsnp $myknownsites\
    2> $logs_path/HaplotypleCaller/$(basename $name).HaplotypeCaller.ERC-GVCF.sterror
done
