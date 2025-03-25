#!/usr/bin/env nextflow

/*
========================================================================================
               3Seq : a Nextflow pipeline for 
========================================================================================
*/
nextflow.enable.dsl = 2

include { CUTADAPT } from './modules/cutadapt'
include { STAR_ALIGN } from './modules/star_align'
include { SAMBAMBA } from './modules/sambamba'
include { FGBIO } from './modules/fgbio'
include { PICARD_ASSIGN } from './modules/picard_assign'
include { PICARD_REMOVEDUP } from './modules/picard_removedup'
include { SAMTOOLS_EXTRACT } from './modules/samtools_extract'
include { STAR_COUNT } from './modules/star_count'

workflow {
    fa_ch = Channel.fromFilePairs("${params.input_dir}/*_{R1,R2}.chr21.paired.fastq.gz")
    // fa_ch.view()
    CUTADAPT(fa_ch)

    STAR_ALIGN(CUTADAPT.out.sample,
    CUTADAPT.out.trimmed_reads,
    params.genome_dir,
    params.outdir
    )

    SAMBAMBA(STAR_ALIGN.out.sample, 
    STAR_ALIGN.out.bam_R2,
    params.outdir)

    // SAMBAMBA.out.bam_R2_by_name.view()
    // SAMBAMBA.out.sample.view()


    FGBIO(SAMBAMBA.out.sample,
    SAMBAMBA.out.bam_R2_by_name,
    CUTADAPT.out.trimmed_reads,
    params.outdir)

    
    PICARD_ASSIGN(FGBIO.out.sample,
    FGBIO.out.bam_R2_by_name_with_umis,
    params.outdir)

    PICARD_REMOVEDUP(PICARD_ASSIGN.out.sample,
    PICARD_ASSIGN.out.bam_R2_by_coord_umis_RG,
    params.outdir)

    SAMTOOLS_EXTRACT(PICARD_REMOVEDUP.out.sample,
    PICARD_REMOVEDUP.out.bam_R2_by_coord_umis_RG_Rdup,
    params.outdir)

    STAR_COUNT(
        SAMTOOLS_EXTRACT.out.sample,
        SAMTOOLS_EXTRACT.out.fastq_extracted,
        params.genome_dir,
        params.outdir
    )

}