--
-- Copyright 2019 International Business Machines
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- The patent license granted to you in Section 3 of the License, as applied
-- to the "Work," hereby includes implementations of the Work in physical form.
--
-- Unless required by applicable law or agreed to in writing, the reference design
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-- The background Specification upon which this is based is managed by and available from
-- the OpenCAPI Consortium.  More information can be found at https://opencapi.org.
--


library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity axi_combiner is
  port (
    -- Processor Side
    s0_axi_aclk    : in  std_ulogic;
    s0_axi_aresetn : in  std_ulogic;
    s0_axi_awid    : in  std_ulogic_vector(6 downto 0);
    s0_axi_awaddr  : in  std_ulogic_vector(63 downto 0);
    s0_axi_awlen   : in  std_ulogic_vector(7 downto 0);
    s0_axi_awsize  : in  std_ulogic_vector(2 downto 0);
    s0_axi_awburst : in  std_ulogic_vector(1 downto 0);
    s0_axi_awlock  : in  std_ulogic_vector(1 downto 0);
    s0_axi_awcache : in  std_ulogic_vector(3 downto 0);
    s0_axi_awprot  : in  std_ulogic_vector(2 downto 0);
    s0_axi_awvalid : in  std_ulogic;
    s0_axi_awready : out std_ulogic;
    s0_axi_wid     : in  std_ulogic_vector(6 downto 0);
    s0_axi_wdata   : in  std_ulogic_vector(31 downto 0);
    s0_axi_wstrb   : in  std_ulogic_vector(3 downto 0);
    s0_axi_wlast   : in  std_ulogic;
    s0_axi_wvalid  : in  std_ulogic;
    s0_axi_wready  : out std_ulogic;
    s0_axi_bid     : out std_ulogic_vector(6 downto 0);
    s0_axi_bresp   : out std_ulogic_vector(1 downto 0);
    s0_axi_bvalid  : out std_ulogic;
    s0_axi_bready  : in  std_ulogic;
    s0_axi_arid    : in  std_ulogic_vector(6 downto 0);
    s0_axi_araddr  : in  std_ulogic_vector(63 downto 0);
    s0_axi_arlen   : in  std_ulogic_vector(7 downto 0);
    s0_axi_arsize  : in  std_ulogic_vector(2 downto 0);
    s0_axi_arburst : in  std_ulogic_vector(1 downto 0);
    s0_axi_arlock  : in  std_ulogic_vector(1 downto 0);
    s0_axi_arcache : in  std_ulogic_vector(3 downto 0);
    s0_axi_arprot  : in  std_ulogic_vector(2 downto 0);
    s0_axi_arvalid : in  std_ulogic;
    s0_axi_arready : out std_ulogic;
    s0_axi_rid     : out std_ulogic_vector(6 downto 0);
    s0_axi_rdata   : out std_ulogic_vector(31 downto 0);
    s0_axi_rresp   : out std_ulogic_vector(1 downto 0);
    s0_axi_rlast   : out std_ulogic;
    s0_axi_rvalid  : out std_ulogic;
    s0_axi_rready  : in  std_ulogic;

    -- Fire Side
    m0_axi_aclk    : out std_ulogic;
    m0_axi_aresetn : out std_ulogic;
    m0_axi_awid    : out std_ulogic_vector(6 downto 0);
    m0_axi_awaddr  : out std_ulogic_vector(63 downto 0);
    m0_axi_awlen   : out std_ulogic_vector(7 downto 0);
    m0_axi_awsize  : out std_ulogic_vector(2 downto 0);
    m0_axi_awburst : out std_ulogic_vector(1 downto 0);
    m0_axi_awlock  : out std_ulogic_vector(1 downto 0);
    m0_axi_awcache : out std_ulogic_vector(3 downto 0);
    m0_axi_awprot  : out std_ulogic_vector(2 downto 0);
    m0_axi_awvalid : out std_ulogic;
    m0_axi_awready : in  std_ulogic;
    m0_axi_wid     : out std_ulogic_vector(6 downto 0);
    m0_axi_wdata   : out std_ulogic_vector(31 downto 0);
    m0_axi_wstrb   : out std_ulogic_vector(3 downto 0);
    m0_axi_wlast   : out std_ulogic;
    m0_axi_wvalid  : out std_ulogic;
    m0_axi_wready  : in  std_ulogic;
    m0_axi_bid     : in  std_ulogic_vector(6 downto 0);
    m0_axi_bresp   : in  std_ulogic_vector(1 downto 0);
    m0_axi_bvalid  : in  std_ulogic;
    m0_axi_bready  : out std_ulogic;
    m0_axi_arid    : out std_ulogic_vector(6 downto 0);
    m0_axi_araddr  : out std_ulogic_vector(63 downto 0);
    m0_axi_arlen   : out std_ulogic_vector(7 downto 0);
    m0_axi_arsize  : out std_ulogic_vector(2 downto 0);
    m0_axi_arburst : out std_ulogic_vector(1 downto 0);
    m0_axi_arlock  : out std_ulogic_vector(1 downto 0);
    m0_axi_arcache : out std_ulogic_vector(3 downto 0);
    m0_axi_arprot  : out std_ulogic_vector(2 downto 0);
    m0_axi_arvalid : out std_ulogic;
    m0_axi_arready : in  std_ulogic;
    m0_axi_rid     : in  std_ulogic_vector(6 downto 0);
    m0_axi_rdata   : in  std_ulogic_vector(31 downto 0);
    m0_axi_rresp   : in  std_ulogic_vector(1 downto 0);
    m0_axi_rlast   : in  std_ulogic;
    m0_axi_rvalid  : in  std_ulogic;
    m0_axi_rready  : out std_ulogic
    );
end axi_combiner;

architecture axi_combiner of axi_combiner is

  signal awid_a_d    : std_ulogic_vector(6 downto 0);
  signal awaddr_a_d  : std_ulogic_vector(63 downto 0);
  signal awlen_a_d   : std_ulogic_vector(7 downto 0);
  signal awsize_a_d  : std_ulogic_vector(2 downto 0);
  signal awburst_a_d : std_ulogic_vector(1 downto 0);
  signal awlock_a_d  : std_ulogic_vector(1 downto 0);
  signal awcache_a_d : std_ulogic_vector(3 downto 0);
  signal awprot_a_d  : std_ulogic_vector(2 downto 0);
  signal awid_a_q    : std_ulogic_vector(6 downto 0);
  signal awaddr_a_q  : std_ulogic_vector(63 downto 0);
  signal awlen_a_q   : std_ulogic_vector(7 downto 0);
  signal awsize_a_q  : std_ulogic_vector(2 downto 0);
  signal awburst_a_q : std_ulogic_vector(1 downto 0);
  signal awlock_a_q  : std_ulogic_vector(1 downto 0);
  signal awcache_a_q : std_ulogic_vector(3 downto 0);
  signal awprot_a_q  : std_ulogic_vector(2 downto 0);
  signal awid_b_d    : std_ulogic_vector(6 downto 0);
  signal awaddr_b_d  : std_ulogic_vector(63 downto 0);
  signal awlen_b_d   : std_ulogic_vector(7 downto 0);
  signal awsize_b_d  : std_ulogic_vector(2 downto 0);
  signal awburst_b_d : std_ulogic_vector(1 downto 0);
  signal awlock_b_d  : std_ulogic_vector(1 downto 0);
  signal awcache_b_d : std_ulogic_vector(3 downto 0);
  signal awprot_b_d  : std_ulogic_vector(2 downto 0);
  signal awid_b_q    : std_ulogic_vector(6 downto 0);
  signal awaddr_b_q  : std_ulogic_vector(63 downto 0);
  signal awlen_b_q   : std_ulogic_vector(7 downto 0);
  signal awsize_b_q  : std_ulogic_vector(2 downto 0);
  signal awburst_b_q : std_ulogic_vector(1 downto 0);
  signal awlock_b_q  : std_ulogic_vector(1 downto 0);
  signal awcache_b_q : std_ulogic_vector(3 downto 0);
  signal awprot_b_q  : std_ulogic_vector(2 downto 0);

  signal wid_a_d   : std_ulogic_vector(6 downto 0);
  signal wdata_a_d : std_ulogic_vector(31 downto 0);
  signal wstrb_a_d : std_ulogic_vector(3 downto 0);
  signal wlast_a_d : std_ulogic;
  signal wid_a_q   : std_ulogic_vector(6 downto 0);
  signal wdata_a_q : std_ulogic_vector(31 downto 0);
  signal wstrb_a_q : std_ulogic_vector(3 downto 0);
  signal wlast_a_q : std_ulogic;
  signal wid_b_d   : std_ulogic_vector(6 downto 0);
  signal wdata_b_d : std_ulogic_vector(31 downto 0);
  signal wstrb_b_d : std_ulogic_vector(3 downto 0);
  signal wlast_b_d : std_ulogic;
  signal wid_b_q   : std_ulogic_vector(6 downto 0);
  signal wdata_b_q : std_ulogic_vector(31 downto 0);
  signal wstrb_b_q : std_ulogic_vector(3 downto 0);
  signal wlast_b_q : std_ulogic;

  signal write_state_0_d     : std_ulogic_vector(7 downto 0);
  signal write_state_0_q     : std_ulogic_vector(7 downto 0) := "00000001";
  signal write_state_0_last_q: std_ulogic_vector(7 downto 0) := "00000001";
  signal write_state_0_ns0_0 : std_ulogic;
  signal write_state_0_ns0_1 : std_ulogic;
  signal write_state_0_ns0_2 : std_ulogic;
  signal write_state_0_ns0_3 : std_ulogic;
  signal write_state_0_ns0_4 : std_ulogic;
  signal write_state_0_ns0_5 : std_ulogic;
  signal write_state_0_ns0_6 : std_ulogic;
  signal write_state_0_ns0_7 : std_ulogic;
  signal write_state_0_ns1_0 : std_ulogic;
  signal write_state_0_ns1_1 : std_ulogic;
  signal write_state_0_ns1_2 : std_ulogic;
  signal write_state_0_ns1_3 : std_ulogic;
  signal write_state_0_ns1_4 : std_ulogic;
  signal write_state_0_ns1_5 : std_ulogic;
  signal write_state_0_ns1_6 : std_ulogic;
  signal write_state_0_ns1_7 : std_ulogic;
  signal write_state_0_ns2_0 : std_ulogic;
  signal write_state_0_ns2_1 : std_ulogic;
  signal write_state_0_ns2_2 : std_ulogic;
  signal write_state_0_ns2_3 : std_ulogic;
  signal write_state_0_ns2_4 : std_ulogic;
  signal write_state_0_ns2_5 : std_ulogic;
  signal write_state_0_ns2_6 : std_ulogic;
  signal write_state_0_ns2_7 : std_ulogic;
  signal write_state_0_ns3_0 : std_ulogic;
  signal write_state_0_ns3_1 : std_ulogic;
  signal write_state_0_ns3_2 : std_ulogic;
  signal write_state_0_ns3_3 : std_ulogic;
  signal write_state_0_ns3_4 : std_ulogic;
  signal write_state_0_ns3_5 : std_ulogic;
  signal write_state_0_ns3_6 : std_ulogic;
  signal write_state_0_ns3_7 : std_ulogic;
  signal write_state_0_ns4_0 : std_ulogic;
  signal write_state_0_ns4_1 : std_ulogic;
  signal write_state_0_ns4_2 : std_ulogic;
  signal write_state_0_ns4_3 : std_ulogic;
  signal write_state_0_ns4_4 : std_ulogic;
  signal write_state_0_ns4_5 : std_ulogic;
  signal write_state_0_ns4_6 : std_ulogic;
  signal write_state_0_ns4_7 : std_ulogic;
  signal write_state_0_ns5_0 : std_ulogic;
  signal write_state_0_ns5_1 : std_ulogic;
  signal write_state_0_ns5_2 : std_ulogic;
  signal write_state_0_ns5_3 : std_ulogic;
  signal write_state_0_ns5_4 : std_ulogic;
  signal write_state_0_ns5_5 : std_ulogic;
  signal write_state_0_ns5_6 : std_ulogic;
  signal write_state_0_ns5_7 : std_ulogic;
  signal write_state_0_ns6_0 : std_ulogic;
  signal write_state_0_ns6_1 : std_ulogic;
  signal write_state_0_ns6_2 : std_ulogic;
  signal write_state_0_ns6_3 : std_ulogic;
  signal write_state_0_ns6_4 : std_ulogic;
  signal write_state_0_ns6_5 : std_ulogic;
  signal write_state_0_ns6_6 : std_ulogic;
  signal write_state_0_ns6_7 : std_ulogic;
  signal write_state_0_ns7_0 : std_ulogic;
  signal write_state_0_ns7_1 : std_ulogic;
  signal write_state_0_ns7_2 : std_ulogic;
  signal write_state_0_ns7_3 : std_ulogic;
  signal write_state_0_ns7_4 : std_ulogic;
  signal write_state_0_ns7_5 : std_ulogic;
  signal write_state_0_ns7_6 : std_ulogic;
  signal write_state_0_ns7_7 : std_ulogic;

  signal write_state_1_d     : std_ulogic_vector(4 downto 0);
  signal write_state_1_q     : std_ulogic_vector(4 downto 0) := "00001";
  signal write_state_1_ns0_0 : std_ulogic;
  signal write_state_1_ns0_1 : std_ulogic;
  signal write_state_1_ns0_2 : std_ulogic;
  signal write_state_1_ns0_3 : std_ulogic;
  signal write_state_1_ns0_4 : std_ulogic;
  signal write_state_1_ns1_0 : std_ulogic;
  signal write_state_1_ns1_1 : std_ulogic;
  signal write_state_1_ns1_2 : std_ulogic;
  signal write_state_1_ns1_3 : std_ulogic;
  signal write_state_1_ns1_4 : std_ulogic;
  signal write_state_1_ns2_0 : std_ulogic;
  signal write_state_1_ns2_1 : std_ulogic;
  signal write_state_1_ns2_2 : std_ulogic;
  signal write_state_1_ns2_3 : std_ulogic;
  signal write_state_1_ns2_4 : std_ulogic;
  signal write_state_1_ns3_0 : std_ulogic;
  signal write_state_1_ns3_1 : std_ulogic;
  signal write_state_1_ns3_2 : std_ulogic;
  signal write_state_1_ns3_3 : std_ulogic;
  signal write_state_1_ns3_4 : std_ulogic;
  signal write_state_1_ns4_0 : std_ulogic;
  signal write_state_1_ns4_1 : std_ulogic;
  signal write_state_1_ns4_2 : std_ulogic;
  signal write_state_1_ns4_3 : std_ulogic;
  signal write_state_1_ns4_4 : std_ulogic;

  signal bid_d : std_ulogic_vector(6 downto 0);
  signal bid_q : std_ulogic_vector(6 downto 0);
  signal bresp_d : std_ulogic_vector(1 downto 0);
  signal bresp_q : std_ulogic_vector(1 downto 0);

  signal write_response_state_d : std_ulogic_vector(3 downto 0);
  signal write_response_state_q : std_ulogic_vector(3 downto 0) := "0001";
  signal write_response_state_ns0_0 : std_ulogic;
  signal write_response_state_ns0_1 : std_ulogic;
  signal write_response_state_ns0_2 : std_ulogic;
  signal write_response_state_ns0_3 : std_ulogic;
  signal write_response_state_ns1_0 : std_ulogic;
  signal write_response_state_ns1_1 : std_ulogic;
  signal write_response_state_ns1_2 : std_ulogic;
  signal write_response_state_ns1_3 : std_ulogic;
  signal write_response_state_ns2_0 : std_ulogic;
  signal write_response_state_ns2_1 : std_ulogic;
  signal write_response_state_ns2_2 : std_ulogic;
  signal write_response_state_ns2_3 : std_ulogic;
  signal write_response_state_ns3_0 : std_ulogic;
  signal write_response_state_ns3_1 : std_ulogic;
  signal write_response_state_ns3_2 : std_ulogic;
  signal write_response_state_ns3_3 : std_ulogic;

  signal rid_a_d   : std_ulogic_vector(6 downto 0);
  signal rdata_a_d : std_ulogic_vector(31 downto 0);
  signal rresp_a_d : std_ulogic_vector(1 downto 0);
  signal rid_a_q   : std_ulogic_vector(6 downto 0);
  signal rdata_a_q : std_ulogic_vector(31 downto 0);
  signal rresp_a_q : std_ulogic_vector(1 downto 0);

  signal rid_b_d   : std_ulogic_vector(6 downto 0);
  signal rdata_b_d : std_ulogic_vector(31 downto 0);
  signal rresp_b_d : std_ulogic_vector(1 downto 0);
  signal rid_b_q   : std_ulogic_vector(6 downto 0);
  signal rdata_b_q : std_ulogic_vector(31 downto 0);
  signal rresp_b_q : std_ulogic_vector(1 downto 0);

  signal read_data_state_d : std_ulogic_vector(3 downto 0);
  signal read_data_state_q : std_ulogic_vector(3 downto 0) := "0001";
  signal read_data_state_ns0_0 : std_ulogic;
  signal read_data_state_ns0_1 : std_ulogic;
  signal read_data_state_ns0_2 : std_ulogic;
  signal read_data_state_ns0_3 : std_ulogic;
  signal read_data_state_ns1_0 : std_ulogic;
  signal read_data_state_ns1_1 : std_ulogic;
  signal read_data_state_ns1_2 : std_ulogic;
  signal read_data_state_ns1_3 : std_ulogic;
  signal read_data_state_ns2_0 : std_ulogic;
  signal read_data_state_ns2_1 : std_ulogic;
  signal read_data_state_ns2_2 : std_ulogic;
  signal read_data_state_ns2_3 : std_ulogic;
  signal read_data_state_ns3_0 : std_ulogic;
  signal read_data_state_ns3_1 : std_ulogic;
  signal read_data_state_ns3_2 : std_ulogic;
  signal read_data_state_ns3_3 : std_ulogic;

  -- If 0, return the first beat of 32 bits we get back from
  -- OpenCAPI. If 1, return the second beat.
  signal read_data_return_beat : std_ulogic_vector(127 downto 0) := (others => '0');

begin

  -- Global
  m0_axi_aclk <= s0_axi_aclk;
  m0_axi_aresetn <= s0_axi_aresetn;

  -----------------------------------------------------------------------------
  -- Write Address/Data State Machine
  -----------------------------------------------------------------------------

  -- State 0 - Idle - 0x01
  write_state_0_ns0_0 <= write_state_0_q(0) and not s0_axi_awvalid;
  write_state_0_ns0_1 <= write_state_0_q(0) and     s0_axi_awvalid;
  write_state_0_ns0_2 <= write_state_0_q(0) and '0';
  write_state_0_ns0_3 <= write_state_0_q(0) and '0';
  write_state_0_ns0_4 <= write_state_0_q(0) and '0';
  write_state_0_ns0_5 <= write_state_0_q(0) and '0';
  write_state_0_ns0_6 <= write_state_0_q(0) and '0';
  write_state_0_ns0_7 <= write_state_0_q(0) and '0';

  -- State 1 - Received AWValid 0 - 0x02
  write_state_0_ns1_0 <= write_state_0_q(1) and '0';
  write_state_0_ns1_1 <= write_state_0_q(1) and '0';
  write_state_0_ns1_2 <= write_state_0_q(1) and '1';
  write_state_0_ns1_3 <= write_state_0_q(1) and '0';
  write_state_0_ns1_4 <= write_state_0_q(1) and '0';
  write_state_0_ns1_5 <= write_state_0_q(1) and '0';
  write_state_0_ns1_6 <= write_state_0_q(1) and '0';
  write_state_0_ns1_7 <= write_state_0_q(1) and '0';

  -- State 2 - Wait for WValid 0 - 0x04
  write_state_0_ns2_0 <= write_state_0_q(2) and '0';
  write_state_0_ns2_1 <= write_state_0_q(2) and '0';
  write_state_0_ns2_2 <= write_state_0_q(2) and not s0_axi_wvalid;
  write_state_0_ns2_3 <= write_state_0_q(2) and     s0_axi_wvalid;
  write_state_0_ns2_4 <= write_state_0_q(2) and '0';
  write_state_0_ns2_5 <= write_state_0_q(2) and '0';
  write_state_0_ns2_6 <= write_state_0_q(2) and '0';
  write_state_0_ns2_7 <= write_state_0_q(2) and '0';

  -- State 3 - Received WValid 0 - 0x08
  write_state_0_ns3_0 <= write_state_0_q(3) and '0';
  write_state_0_ns3_1 <= write_state_0_q(3) and '0';
  write_state_0_ns3_2 <= write_state_0_q(3) and '0';
  write_state_0_ns3_3 <= write_state_0_q(3) and     awaddr_a_q(30) and not s0_axi_awvalid;
  write_state_0_ns3_4 <= write_state_0_q(3) and     awaddr_a_q(30) and     s0_axi_awvalid;
  write_state_0_ns3_5 <= write_state_0_q(3) and '0';
  write_state_0_ns3_6 <= write_state_0_q(3) and '0';
  write_state_0_ns3_7 <= write_state_0_q(3) and not awaddr_a_q(30);

  -- State 4 - Received AWValid 1 - 0x10
  write_state_0_ns4_0 <= write_state_0_q(4) and '0';
  write_state_0_ns4_1 <= write_state_0_q(4) and '0';
  write_state_0_ns4_2 <= write_state_0_q(4) and '0';
  write_state_0_ns4_3 <= write_state_0_q(4) and '0';
  write_state_0_ns4_4 <= write_state_0_q(4) and '0';
  write_state_0_ns4_5 <= write_state_0_q(4) and '1';
  write_state_0_ns4_6 <= write_state_0_q(4) and '0';
  write_state_0_ns4_7 <= write_state_0_q(4) and '0';

  -- State 5 - Wait for WValid 1 - 0x20
  write_state_0_ns5_0 <= write_state_0_q(5) and '0';
  write_state_0_ns5_1 <= write_state_0_q(5) and '0';
  write_state_0_ns5_2 <= write_state_0_q(5) and '0';
  write_state_0_ns5_3 <= write_state_0_q(5) and '0';
  write_state_0_ns5_4 <= write_state_0_q(5) and '0';
  write_state_0_ns5_5 <= write_state_0_q(5) and not s0_axi_wvalid;
  write_state_0_ns5_6 <= write_state_0_q(5) and     s0_axi_wvalid;
  write_state_0_ns5_7 <= write_state_0_q(5) and '0';

  -- State 6 - Received WValid 1 - 0x40
  write_state_0_ns6_0 <= write_state_0_q(6) and '0';
  write_state_0_ns6_1 <= write_state_0_q(6) and '0';
  write_state_0_ns6_2 <= write_state_0_q(6) and '0';
  write_state_0_ns6_3 <= write_state_0_q(6) and '0';
  write_state_0_ns6_4 <= write_state_0_q(6) and '0';
  write_state_0_ns6_5 <= write_state_0_q(6) and '0';
  write_state_0_ns6_6 <= write_state_0_q(6) and '0';
  write_state_0_ns6_7 <= write_state_0_q(6) and '1';

  -- State 7 - Wait for command to be sent - 0x80
  write_state_0_ns7_0 <= write_state_0_q(7) and     write_state_1_q(4);
  write_state_0_ns7_1 <= write_state_0_q(7) and '0';
  write_state_0_ns7_2 <= write_state_0_q(7) and '0';
  write_state_0_ns7_3 <= write_state_0_q(7) and '0';
  write_state_0_ns7_4 <= write_state_0_q(7) and '0';
  write_state_0_ns7_5 <= write_state_0_q(7) and '0';
  write_state_0_ns7_6 <= write_state_0_q(7) and '0';
  write_state_0_ns7_7 <= write_state_0_q(7) and not write_state_1_q(4);

  -- Control Outputs
  s0_axi_awready <= write_state_0_q(1) or write_state_0_q(4);
  s0_axi_wready  <= (write_state_0_q(3) and write_state_0_last_q(2)) or write_state_0_q(6); -- TODO remove last_q

  -- Next State
  write_state_0_d(0) <= write_state_0_ns0_0 or write_state_0_ns1_0 or write_state_0_ns2_0 or write_state_0_ns3_0 or write_state_0_ns4_0 or write_state_0_ns5_0 or write_state_0_ns6_0 or write_state_0_ns7_0;
  write_state_0_d(1) <= write_state_0_ns0_1 or write_state_0_ns1_1 or write_state_0_ns2_1 or write_state_0_ns3_1 or write_state_0_ns4_1 or write_state_0_ns5_1 or write_state_0_ns6_1 or write_state_0_ns7_1;
  write_state_0_d(2) <= write_state_0_ns0_2 or write_state_0_ns1_2 or write_state_0_ns2_2 or write_state_0_ns3_2 or write_state_0_ns4_2 or write_state_0_ns5_2 or write_state_0_ns6_2 or write_state_0_ns7_2;
  write_state_0_d(3) <= write_state_0_ns0_3 or write_state_0_ns1_3 or write_state_0_ns2_3 or write_state_0_ns3_3 or write_state_0_ns4_3 or write_state_0_ns5_3 or write_state_0_ns6_3 or write_state_0_ns7_3;
  write_state_0_d(4) <= write_state_0_ns0_4 or write_state_0_ns1_4 or write_state_0_ns2_4 or write_state_0_ns3_4 or write_state_0_ns4_4 or write_state_0_ns5_4 or write_state_0_ns6_4 or write_state_0_ns7_4;
  write_state_0_d(5) <= write_state_0_ns0_5 or write_state_0_ns1_5 or write_state_0_ns2_5 or write_state_0_ns3_5 or write_state_0_ns4_5 or write_state_0_ns5_5 or write_state_0_ns6_5 or write_state_0_ns7_5;
  write_state_0_d(6) <= write_state_0_ns0_6 or write_state_0_ns1_6 or write_state_0_ns2_6 or write_state_0_ns3_6 or write_state_0_ns4_6 or write_state_0_ns5_6 or write_state_0_ns6_6 or write_state_0_ns7_6;
  write_state_0_d(7) <= write_state_0_ns0_7 or write_state_0_ns1_7 or write_state_0_ns2_7 or write_state_0_ns3_7 or write_state_0_ns4_7 or write_state_0_ns5_7 or write_state_0_ns6_7 or write_state_0_ns7_7;

  -- State 0 - Idle - 0x01
  write_state_1_ns0_0 <= write_state_1_q(0) and not write_state_0_q(7);
  write_state_1_ns0_1 <= write_state_1_q(0) and     write_state_0_q(7);
  write_state_1_ns0_2 <= write_state_1_q(0) and '0';
  write_state_1_ns0_3 <= write_state_1_q(0) and '0';
  write_state_1_ns0_4 <= write_state_1_q(0) and '0';

  -- State 1 - Wait for AWReady - 0x02
  write_state_1_ns1_0 <= write_state_1_q(1) and '0';
  write_state_1_ns1_1 <= write_state_1_q(1) and not m0_axi_awready;
  write_state_1_ns1_2 <= write_state_1_q(1) and     m0_axi_awready;
  write_state_1_ns1_3 <= write_state_1_q(1) and '0';
  write_state_1_ns1_4 <= write_state_1_q(1) and '0';

  -- State 2 - Wait for WReady 0 - 0x04
  write_state_1_ns2_0 <= write_state_1_q(2) and '0';
  write_state_1_ns2_1 <= write_state_1_q(2) and '0';
  write_state_1_ns2_2 <= write_state_1_q(2) and not m0_axi_wready;
  write_state_1_ns2_3 <= write_state_1_q(2) and     m0_axi_wready and     awaddr_a_q(30);
  write_state_1_ns2_4 <= write_state_1_q(2) and     m0_axi_wready and not awaddr_a_q(30);

  -- State 3 - Wait for WReady 1 - 0x08
  write_state_1_ns3_0 <= write_state_1_q(3) and '0';
  write_state_1_ns3_1 <= write_state_1_q(3) and '0';
  write_state_1_ns3_2 <= write_state_1_q(3) and '0';
  write_state_1_ns3_3 <= write_state_1_q(3) and not m0_axi_wready;
  write_state_1_ns3_4 <= write_state_1_q(3) and     m0_axi_wready;

  -- State 4 - Done - 0x10
  write_state_1_ns4_0 <= write_state_1_q(4) and '1';
  write_state_1_ns4_1 <= write_state_1_q(4) and '0';
  write_state_1_ns4_2 <= write_state_1_q(4) and '0';
  write_state_1_ns4_3 <= write_state_1_q(4) and '0';
  write_state_1_ns4_4 <= write_state_1_q(4) and '0';

  -- Control Outputs
  m0_axi_awvalid <= write_state_1_q(1);
  m0_axi_wvalid  <= write_state_1_q(2) or write_state_1_q(3);

  -- Next State
  write_state_1_d(0) <= write_state_1_ns0_0 or write_state_1_ns1_0 or write_state_1_ns2_0 or write_state_1_ns3_0 or write_state_1_ns4_0;
  write_state_1_d(1) <= write_state_1_ns0_1 or write_state_1_ns1_1 or write_state_1_ns2_1 or write_state_1_ns3_1 or write_state_1_ns4_1;
  write_state_1_d(2) <= write_state_1_ns0_2 or write_state_1_ns1_2 or write_state_1_ns2_2 or write_state_1_ns3_2 or write_state_1_ns4_2;
  write_state_1_d(3) <= write_state_1_ns0_3 or write_state_1_ns1_3 or write_state_1_ns2_3 or write_state_1_ns3_3 or write_state_1_ns4_3;
  write_state_1_d(4) <= write_state_1_ns0_4 or write_state_1_ns1_4 or write_state_1_ns2_4 or write_state_1_ns3_4 or write_state_1_ns4_4;

  -- Write Address Channel
  awid_a_d(6 downto 0)    <= s0_axi_awid(6 downto 0)    when write_state_0_q(1) = '1' else awid_a_q(6 downto 0)   ;
  awaddr_a_d(63 downto 0) <= s0_axi_awaddr(63 downto 0) when write_state_0_q(1) = '1' else awaddr_a_q(63 downto 0);
  awlen_a_d(7 downto 0)   <= s0_axi_awlen(7 downto 0)   when write_state_0_q(1) = '1' else awlen_a_q(7 downto 0)  ;
  awsize_a_d(2 downto 0)  <= s0_axi_awsize(2 downto 0)  when write_state_0_q(1) = '1' else awsize_a_q(2 downto 0) ;
  awburst_a_d(1 downto 0) <= s0_axi_awburst(1 downto 0) when write_state_0_q(1) = '1' else awburst_a_q(1 downto 0);
  awlock_a_d(1 downto 0)  <= s0_axi_awlock(1 downto 0)  when write_state_0_q(1) = '1' else awlock_a_q(1 downto 0) ;
  awcache_a_d(3 downto 0) <= s0_axi_awcache(3 downto 0) when write_state_0_q(1) = '1' else awcache_a_q(3 downto 0);
  awprot_a_d(2 downto 0)  <= s0_axi_awprot(2 downto 0)  when write_state_0_q(1) = '1' else awprot_a_q(2 downto 0) ;

  awid_b_d(6 downto 0)    <= s0_axi_awid(6 downto 0)    when write_state_0_q(4) = '1' else awid_b_q(6 downto 0)   ;
  awaddr_b_d(63 downto 0) <= s0_axi_awaddr(63 downto 0) when write_state_0_q(4) = '1' else awaddr_b_q(63 downto 0);
  awlen_b_d(7 downto 0)   <= s0_axi_awlen(7 downto 0)   when write_state_0_q(4) = '1' else awlen_b_q(7 downto 0)  ;
  awsize_b_d(2 downto 0)  <= s0_axi_awsize(2 downto 0)  when write_state_0_q(4) = '1' else awsize_b_q(2 downto 0) ;
  awburst_b_d(1 downto 0) <= s0_axi_awburst(1 downto 0) when write_state_0_q(4) = '1' else awburst_b_q(1 downto 0);
  awlock_b_d(1 downto 0)  <= s0_axi_awlock(1 downto 0)  when write_state_0_q(4) = '1' else awlock_b_q(1 downto 0) ;
  awcache_b_d(3 downto 0) <= s0_axi_awcache(3 downto 0) when write_state_0_q(4) = '1' else awcache_b_q(3 downto 0);
  awprot_b_d(2 downto 0)  <= s0_axi_awprot(2 downto 0)  when write_state_0_q(4) = '1' else awprot_b_q(2 downto 0) ;

  m0_axi_awid    <= awid_b_q when awaddr_a_q(30) = '1' else
                    -- Use the ID from the second command for IBM
                    -- registers since we already responded to the
                    -- first command.
                    awid_a_q;
  m0_axi_awaddr  <= awaddr_a_q;
  m0_axi_awlen   <= x"01" when awaddr_a_q(30) = '1' else x"00";
  m0_axi_awsize  <= awsize_a_q;
  m0_axi_awburst <= awburst_a_q;
  m0_axi_awlock  <= awlock_a_q;
  m0_axi_awcache <= awcache_a_q;
  m0_axi_awprot  <= awprot_a_q;

  -- Write Data Channel
  wid_a_d(6 downto 0)    <= s0_axi_wid(6 downto 0)    when write_state_0_q(3) = '1' else wid_a_q(6 downto 0)   ;
  wdata_a_d(31 downto 0) <= s0_axi_wdata(31 downto 0) when write_state_0_q(3) = '1' else wdata_a_q(31 downto 0);
  wstrb_a_d(3 downto 0)  <= s0_axi_wstrb(3 downto 0)  when write_state_0_q(3) = '1' else wstrb_a_q(3 downto 0) ;
  wlast_a_d              <= s0_axi_wlast              when write_state_0_q(3) = '1' else wlast_a_q             ;

  wid_b_d(6 downto 0)    <= s0_axi_wid(6 downto 0)    when write_state_0_q(6) = '1' else wid_b_q(6 downto 0)   ;
  wdata_b_d(31 downto 0) <= s0_axi_wdata(31 downto 0) when write_state_0_q(6) = '1' else wdata_b_q(31 downto 0);
  wstrb_b_d(3 downto 0)  <= s0_axi_wstrb(3 downto 0)  when write_state_0_q(6) = '1' else wstrb_b_q(3 downto 0) ;
  wlast_b_d              <= s0_axi_wlast              when write_state_0_q(6) = '1' else wlast_b_q             ;

  m0_axi_wid     <= wid_a_q;
  m0_axi_wdata   <= wdata_a_q when write_state_1_q(2) = '1' else
                    wdata_b_q when write_state_1_q(3) = '1' else
                    (others => '0');
  m0_axi_wstrb   <= wstrb_a_q;
  m0_axi_wlast   <= (write_state_1_q(2) and not awaddr_a_q(30)) or
                    (write_state_1_q(3) and     awaddr_a_q(30));

  -----------------------------------------------------------------------------
  -- Write Response State Machine
  -----------------------------------------------------------------------------

  -- State 0 - Idle - 0x1
  write_response_state_ns0_0 <= write_response_state_q(0) and not m0_axi_bvalid and not (write_state_0_last_q(2) and write_state_0_q(3) and awaddr_a_q(30));
  write_response_state_ns0_1 <= write_response_state_q(0) and     m0_axi_bvalid and not (write_state_0_last_q(2) and write_state_0_q(3) and awaddr_a_q(30));
  write_response_state_ns0_2 <= write_response_state_q(0) and '0';
  write_response_state_ns0_3 <= write_response_state_q(0) and                           (write_state_0_last_q(2) and write_state_0_q(3) and awaddr_a_q(30));

  -- State 1 - Received BValid - 0x2
  write_response_state_ns1_0 <= write_response_state_q(1) and '0';
  write_response_state_ns1_1 <= write_response_state_q(1) and '0';
  write_response_state_ns1_2 <= write_response_state_q(1) and '1';
  write_response_state_ns1_3 <= write_response_state_q(1) and '0';

  -- State 2 - Wait for BReady 1 - 0x4
  write_response_state_ns2_0 <= write_response_state_q(2) and     s0_axi_bready;
  write_response_state_ns2_1 <= write_response_state_q(2) and '0';
  write_response_state_ns2_2 <= write_response_state_q(2) and not s0_axi_bready;
  write_response_state_ns2_3 <= write_response_state_q(2) and '0';

  -- State 3 - Wait for BReady 0 - 0x8
  -- This is sent on the first write of a pair before we even send the command
  write_response_state_ns3_0 <= write_response_state_q(3) and     s0_axi_bready;
  write_response_state_ns3_1 <= write_response_state_q(3) and '0';
  write_response_state_ns3_2 <= write_response_state_q(3) and '0';
  write_response_state_ns3_3 <= write_response_state_q(3) and not s0_axi_bready;

  -- Control Outputs
  m0_axi_bready <= write_response_state_q(1);
  s0_axi_bvalid <= write_response_state_q(2) or write_response_state_q(3);

  -- Next State
  write_response_state_d(0) <= write_response_state_ns0_0 or write_response_state_ns1_0 or write_response_state_ns2_0 or write_response_state_ns3_0;
  write_response_state_d(1) <= write_response_state_ns0_1 or write_response_state_ns1_1 or write_response_state_ns2_1 or write_response_state_ns3_1;
  write_response_state_d(2) <= write_response_state_ns0_2 or write_response_state_ns1_2 or write_response_state_ns2_2 or write_response_state_ns3_2;
  write_response_state_d(3) <= write_response_state_ns0_3 or write_response_state_ns1_3 or write_response_state_ns2_3 or write_response_state_ns3_3;

  -- Write Response Channel
  bid_d(6 downto 0)   <= m0_axi_bid(6 downto 0)   when write_response_state_q(1) = '1' else bid_q(6 downto 0);
  bresp_d(1 downto 0) <= m0_axi_bresp(1 downto 0) when write_response_state_q(1) = '1' else bresp_q(1 downto 0);

  s0_axi_bid   <= bid_q    when write_response_state_q(2) = '1' else
                  awid_a_q when write_response_state_q(3) = '1' else
                  -- We know this is still valid because MIPS waits
                  -- for a response before sending another command.
                  (others => '0');
  s0_axi_bresp <= bresp_q  when write_response_state_q(2) = '1' else
                  "00"     when write_response_state_q(3) = '1' else
                  "00";

  -----------------------------------------------------------------------------
  -- Read Address Channel
  -----------------------------------------------------------------------------
  -- We don't need to modify the sequence of read commands, just
  -- modify a few signals. We do the conversion for 64 to 32 bits on
  -- the response path. OpenCAPI returns all 64 bits, and we drop the
  -- 32 bits we don't care about. We do store the tag so we can figure
  -- out which one we're doing on the way back.
  m0_axi_arid    <= s0_axi_arid;
  m0_axi_araddr  <= s0_axi_araddr(63 downto 3) & "000" when s0_axi_araddr(30) = '1' else
                    s0_axi_araddr(63 downto 2) & "00";
                    -- For IBM registers, MIPS accesses registers with
                    -- offsets 0x...0, 4, 8, C, while OpenCAPI likes
                    -- 0x...0, 8. So we read the latter from OpenCAPI
                    -- and then select from the 2 halves (0 vs. 4 or 8
                    -- vs. C) when sending the response.
  m0_axi_arlen   <= x"01" when s0_axi_araddr(30) = '1' else x"00";
  m0_axi_arsize  <= s0_axi_arsize;
  m0_axi_arburst <= s0_axi_arburst;
  m0_axi_arlock  <= s0_axi_arlock;
  m0_axi_arcache <= s0_axi_arcache;
  m0_axi_arprot  <= s0_axi_arprot;
  m0_axi_arvalid <= s0_axi_arvalid;
  s0_axi_arready <= m0_axi_arready;

  process (s0_axi_aclk)
  begin
    if s0_axi_aclk'event and s0_axi_aclk = '1' then
      if s0_axi_aresetn = '0' then
        read_data_return_beat <= (others => '0');
      elsif s0_axi_arvalid = '1' and m0_axi_arready = '1' then
        -- Check for if it's an IBM register and it's a 0x4 or 0xC
        -- address, which MIPS generates but OpenCAPI doesn't see.
        read_data_return_beat(to_integer(unsigned(s0_axi_arid))) <= s0_axi_araddr(30) and s0_axi_araddr(2);
      end if;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- Read Data State Machine
  -----------------------------------------------------------------------------

  -- State 0 - Idle - 0x01
  read_data_state_ns0_0 <= read_data_state_q(0) and not m0_axi_rvalid;
  read_data_state_ns0_1 <= read_data_state_q(0) and     m0_axi_rvalid and not m0_axi_rlast;
  read_data_state_ns0_2 <= read_data_state_q(0) and     m0_axi_rvalid and     m0_axi_rlast;
  read_data_state_ns0_3 <= read_data_state_q(0) and '0';

  -- State 1 - Received RValid 0 - 0x02
  read_data_state_ns1_0 <= read_data_state_q(1) and '0';
  read_data_state_ns1_1 <= read_data_state_q(1) and not m0_axi_rvalid;
  read_data_state_ns1_2 <= read_data_state_q(1) and     m0_axi_rvalid;
  read_data_state_ns1_3 <= read_data_state_q(1) and '0';

  -- State 2 - Received RValid 1 - 0x04
  read_data_state_ns2_0 <= read_data_state_q(2) and '0';
  read_data_state_ns2_1 <= read_data_state_q(2) and '0';
  read_data_state_ns2_2 <= read_data_state_q(2) and '0';
  read_data_state_ns2_3 <= read_data_state_q(2) and '1';

  -- State 3 - Wait for RReady - 0x08
  read_data_state_ns3_0 <= read_data_state_q(3) and     s0_axi_rready;
  read_data_state_ns3_1 <= read_data_state_q(3) and '0';
  read_data_state_ns3_2 <= read_data_state_q(3) and '0';
  read_data_state_ns3_3 <= read_data_state_q(3) and not s0_axi_rready;

  -- Control Outputs
  s0_axi_rvalid <= read_data_state_q(3);
  m0_axi_rready <= read_data_state_q(0) or read_data_state_q(1);

  -- Next State
  read_data_state_d(0) <= read_data_state_ns0_0 or read_data_state_ns1_0 or read_data_state_ns2_0 or read_data_state_ns3_0;
  read_data_state_d(1) <= read_data_state_ns0_1 or read_data_state_ns1_1 or read_data_state_ns2_1 or read_data_state_ns3_1;
  read_data_state_d(2) <= read_data_state_ns0_2 or read_data_state_ns1_2 or read_data_state_ns2_2 or read_data_state_ns3_2;
  read_data_state_d(3) <= read_data_state_ns0_3 or read_data_state_ns1_3 or read_data_state_ns2_3 or read_data_state_ns3_3;

  -- Read Data Channel
  rid_a_d(6 downto 0)    <= m0_axi_rid(6 downto 0)    when read_data_state_q(0) = '1' else rid_a_q(6 downto 0)   ;
  rdata_a_d(31 downto 0) <= m0_axi_rdata(31 downto 0) when read_data_state_q(0) = '1' else rdata_a_q(31 downto 0);
  rresp_a_d(1 downto 0)  <= m0_axi_rresp(1 downto 0)  when read_data_state_q(0) = '1' else rresp_a_q(1 downto 0) ;

  rid_b_d(6 downto 0)    <= m0_axi_rid(6 downto 0)    when read_data_state_q(1) = '1' else rid_b_q(6 downto 0)   ;
  rdata_b_d(31 downto 0) <= m0_axi_rdata(31 downto 0) when read_data_state_q(1) = '1' else rdata_b_q(31 downto 0);
  rresp_b_d(1 downto 0)  <= m0_axi_rresp(1 downto 0)  when read_data_state_q(1) = '1' else rresp_b_q(1 downto 0) ;

  s0_axi_rid    <= rid_a_q;
  s0_axi_rdata  <= rdata_a_q when read_data_return_beat(to_integer(unsigned(rid_a_q))) = '0' else rdata_b_q ;
  s0_axi_rresp  <= rresp_a_q;
  s0_axi_rlast  <= '1';

  -----------------------------------------------------------------------------
  -- Latches
  -----------------------------------------------------------------------------
  process (s0_axi_aclk)
  begin
    if s0_axi_aclk'event and s0_axi_aclk = '1' then
      if s0_axi_aresetn = '0' then
        write_state_0_q         <= (0 => '1', others => '0');
        write_state_1_q         <= (0 => '1', others => '0');
        write_response_state_q  <= (0 => '1', others => '0');
        read_data_state_q       <= (0 => '1', others => '0');
      else
        write_state_0_q         <= write_state_0_d;
        write_state_1_q         <= write_state_1_d;
        write_state_0_last_q    <= write_state_0_q;
        awid_a_q(6 downto 0)    <= awid_a_d(6 downto 0);
        awaddr_a_q(63 downto 0) <= awaddr_a_d(63 downto 0);
        awlen_a_q(7 downto 0)   <= awlen_a_d(7 downto 0);
        awsize_a_q(2 downto 0)  <= awsize_a_d(2 downto 0);
        awburst_a_q(1 downto 0) <= awburst_a_d(1 downto 0);
        awlock_a_q(1 downto 0)  <= awlock_a_d(1 downto 0);
        awcache_a_q(3 downto 0) <= awcache_a_d(3 downto 0);
        awprot_a_q(2 downto 0)  <= awprot_a_d(2 downto 0);
        awid_b_q(6 downto 0)    <= awid_b_d(6 downto 0);
        awaddr_b_q(63 downto 0) <= awaddr_b_d(63 downto 0);
        awlen_b_q(7 downto 0)   <= awlen_b_d(7 downto 0);
        awsize_b_q(2 downto 0)  <= awsize_b_d(2 downto 0);
        awburst_b_q(1 downto 0) <= awburst_b_d(1 downto 0);
        awlock_b_q(1 downto 0)  <= awlock_b_d(1 downto 0);
        awcache_b_q(3 downto 0) <= awcache_b_d(3 downto 0);
        awprot_b_q(2 downto 0)  <= awprot_b_d(2 downto 0);
        wid_a_q(6 downto 0)     <= wid_a_d(6 downto 0);
        wdata_a_q(31 downto 0)  <= wdata_a_d(31 downto 0);
        wstrb_a_q(3 downto 0)   <= wstrb_a_d(3 downto 0);
        wlast_a_q               <= wlast_a_d;
        wid_b_q(6 downto 0)     <= wid_b_d(6 downto 0);
        wdata_b_q(31 downto 0)  <= wdata_b_d(31 downto 0);
        wstrb_b_q(3 downto 0)   <= wstrb_b_d(3 downto 0);
        wlast_b_q               <= wlast_b_d;
        write_response_state_q  <= write_response_state_d;
        bid_q(6 downto 0)       <= bid_d(6 downto 0);
        bresp_q(1 downto 0)     <= bresp_d(1 downto 0);
        read_data_state_q       <= read_data_state_d;
        rid_a_q(6 downto 0)     <= rid_a_d(6 downto 0);
        rdata_a_q(31 downto 0)  <= rdata_a_d(31 downto 0);
        rresp_a_q(1 downto 0)   <= rresp_a_d(1 downto 0);
        rid_b_q(6 downto 0)     <= rid_b_d(6 downto 0);
        rdata_b_q(31 downto 0)  <= rdata_b_d(31 downto 0);
        rresp_b_q(1 downto 0)   <= rresp_b_d(1 downto 0);
      end if;
    end if;
  end process;

end axi_combiner;
