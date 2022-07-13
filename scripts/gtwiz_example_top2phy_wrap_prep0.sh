#!/bin/bash
sed -e 's/gtwizard_ultrascale_0_example_wrapper/DLx_phy_example_wrapper/' \
-e 's/mgtrefclk0_x0y6/mgtrefclk0_x0y0/g' \
-e 's/mgtrefclk0_x0y7/mgtrefclk0_x0y1/g' \
-e 's/MGTREFCLK0_X0Y6/MGTREFCLK0_X0Y0/g' \
-e 's/MGTREFCLK0_X0Y7/MGTREFCLK0_X0Y1/g' \
-e 's/gtwizard_ultrascale_0/DLx_phy/g' \
-e 's/gtwizard_ultrascale_0/DLx_phy/g' \
-e '/bit_synchronizer_link_down_latched_reset_inst/,+4 s/^/\/\//' \
-e '/reset_synchronizer_prbs_match_all_inst/,+4 s/^/\/\//' \
-e '/example_stimulus_64b66b example_stimulus_inst/,+7 s/^/\/\//' \
-e '/example_checking_64b66b example_checking_inst/,+8 s/^/\/\//' \
-e '/bit_synchronizer_vio_gtpowergood_/,+4 s/^/\/\//' \
-e '/phy_vio_0/,+20 s/^/\/\//' \
-e '/in_system_ibert_0/,+64 s/^/\/\//' \
-e "/bit_synchronizer_vio_gtwiz_buffbypass_tx_error_0_inst/{N;N;N;N; a \ \n\
  \/\/ Synchronize gtwiz_buffbypass_rx_error into the free-running clock domain for VIO usage\n\
  wire [0:0] gtwiz_buffbypass_rx_error_vio_sync;\n\
\n\
\n\
  DLx_phy_example_bit_synchronizer bit_synchronizer_vio_gtwiz_buffbypass_rx_error_0_inst (\n\
   \.clk_in (hb_gtwiz_reset_clk_freerun_buf_int),\n\
    \/\/ \.i_in   (gtwiz_buffbypass_rx_error_int[0]),\n\
   \.i_in   (1'b0),\n\
   \.o_out  (gtwiz_buffbypass_rx_error_vio_sync[0])\n\
  );\n
} " ./gtwizard_ultrascale_0_example_top.v  > dlx_phy_wrap.v
