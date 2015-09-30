#!/bin/sh
#Variables below correspond to blastn output headings
#Dependencies: csv_col_ave python script
#JP Tomkins July 14, 2015 - jtomkins@icr.org

#Check for input file args
if [ $# -lt 2 ] ; then
    echo 'Enter csv file and fasta query file as args 1&2!'
    exit 0
fi

#Function to count fasta seqs in query file
seqct () {
grep -c "^>.*" "${1}"
}

#Use csv_col_ave python program to get column aves - put in $data var
data=$(csv_col_ave $1)

#Extract column info into new vars from $data var - double check order of blastn output
perc_ident_bases=$(echo $data | cut -d' ' -f 1) #Ave Perc ID of the alignment
num_ident_bases=$(echo $data | cut -d' ' -f 2)  #Ave Number of identical bases
align_len=$(echo $data | cut -d' ' -f 3)        #Ave Length of alignments
query_seq_len=$(echo $data | cut -d' ' -f 4)    #Ave length of query seqs

#Number of total query seqs - use seqct func on query file
num_query_seq=$(seqct $2)

#Number of total query hits - use wc to count lines of *.csv
num_hits=$(wc -l $1 | awk '{print $1}')

#Get total chromosome length (total num chr bases)
total_chr_len=$(echo "$query_seq_len*$num_query_seq"|bc -l)

#Get total length of aligned bases (number of aligned bases)
total_aligned_len=$(echo "$num_ident_bases*$num_hits"|bc -l)

#Get more means
ave_hit_freq=$(echo "$num_hits/$num_query_seq*100"|bc -l)
ave_query_ident=$(echo "$num_ident_bases/$query_seq_len*100"|bc -l)
overall_dna_ident=$(echo "$total_aligned_len/$total_chr_len*100"|bc -l)

echo "Ave % identity align:" $(printf "%0.2f" $perc_ident_bases)
echo "Ave alignment length:" $(printf "%0.2f" $align_len)
echo "Ave query seq length:" $(printf "%0.2f" $query_seq_len)
echo "Number of query seqs:" $num_query_seq
echo "Number of query hits:" $num_hits
echo "Ave % hit frequency :" $(printf "%0.2f" $ave_hit_freq)
echo "Ave % query identity:" $(printf "%0.2f" $ave_query_ident)
echo "Overall DNA identity:" $(printf "%0.2f" $overall_dna_ident)
