./run fire synthesize.tcl; ./run fire implement.tcl 8; ./run fire gen_bitstream.tcl 8; grep -A2 -m1 WNS fire/impl_8/post_route_timing_summary.rpt; pwd
