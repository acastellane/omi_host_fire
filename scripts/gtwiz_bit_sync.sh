#!/bin/bash
sed -e 's/gtwizard_ultrascale_0/DLx_phy/g' \
    ./gtwizard_ultrascale_0_example_bit_sync.v  > DLx_phy_example_bit_sync.v