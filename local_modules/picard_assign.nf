process PICARD_ASSIGN {
    tag "$sample"
    label 'process_low'

    conda "modules/picard.yml"

    publishDir "${params.outdir}/picard_assign", mode: 'copy'

    input:
    val sample
    path bam_R2_sorted_with_umis
    path outdir

    output:
    val sample, emit: sample
    path "${sample}_R2.star1.sortedByCoordinates.with_umis.bam" 
    path "${sample}_R2.star1.sortedByCoordinates.with_umis.with_RG.bam", emit: bam_R2_by_coord_umis_RG

    script:
    """
    picard FixMateInformation -I $bam_R2_sorted_with_umis -O ${sample}_R2.star1.sortedByCoordinates.with_umis.bam --IGNORE_MISSING_MATES false -SO coordinate
    
    picard AddOrReplaceReadGroups -I ${sample}_R2.star1.sortedByCoordinates.with_umis.bam -O ${sample}_R2.star1.sortedByCoordinates.with_umis.with_RG.bam -LB $sample -PL ILLUMINA -PU $sample -SM $sample
    """
}
