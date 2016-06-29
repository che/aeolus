export AEOLUS_PCAP_PATH_FILE="/home/che/projects/dania/data/aeolus.20160623.pcap"
export AEOLUS_PCAP_KEYS="-e ip.proto -e eth.src -e ip.src -e udp.srcport -e eth.dst -e ip.dst -e udp.dstport -e frame.time_epoch -e data.len -e data.data"
export AEOLUS_PCAP_COMMAND="tshark -r ${AEOLUS_PCAP_PATH_FILE} -V -T fields ${AEOLUS_PCAP_KEYS}"
