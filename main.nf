#!/usr/bin/env nextflow

/*
========================================================================================
               3Seq : a Nextflow pipeline for 
========================================================================================
*/
nextflow.enable.dsl = 2

include { CUTADAPT } from './modules/cutadapt'
include { STAR_ALIGN } from './modules/star_align'

workflow {
    fa_ch = Channel.fromFilePairs("${params.input_dir}/*_{R1,R2}.chr21.paired.fastq.gz")
    // fa_ch.view()
    CUTADAPT(fa_ch)

    STAR_ALIGN(CUTADAPT.out.sample,
    CUTADAPT.out.trimmed_reads,
    params.genome_dir,
    params.outdir
    )

}