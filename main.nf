#!/usr/bin/env nextflow

/*
========================================================================================
               3Seq : a Nextflow pipeline for 
========================================================================================
*/

nextflow.enable.dsl = 2


include { CUTADAPT } from './modules/cutadapt'


workflow {
    fa_ch = Channel.fromFilePairs("${params.input_dir}/*_{R1,R2}.fastq.gz")
    CUTADAPT(fa_ch)

}