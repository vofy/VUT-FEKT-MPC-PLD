-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
-- Date        : Thu Apr 23 10:02:31 2026
-- Host        : PC-SC660-21 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/243511/Projects/VUT-FEKT-MPC-PLD/LC10/SOURCES/IP/microblaze_mcs_riscv_0/microblaze_mcs_riscv_0_stub.vhdl
-- Design      : microblaze_mcs_riscv_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity microblaze_mcs_riscv_0 is
  Port ( 
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    UART_rxd : in STD_LOGIC;
    UART_txd : out STD_LOGIC;
    GPIO1_tri_i : in STD_LOGIC_VECTOR ( 7 downto 0 );
    GPIO1_tri_o : out STD_LOGIC_VECTOR ( 7 downto 0 );
    GPIO2_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of microblaze_mcs_riscv_0 : entity is "microblaze_mcs_riscv_0,bd_04f4_0,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of microblaze_mcs_riscv_0 : entity is "microblaze_mcs_riscv_0,bd_04f4_0,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=microblaze_mcs_riscv,x_ipVersion=1.0,x_ipCoreRevision=5,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,JTAG_CHAIN=2,MICROBLAZE_INSTANCE=microblaze_0,AVOID_PRIMITIVES=0,PATH=mcs_0,FREQ=50,OPTIMIZATION=0,DEBUG_ENABLED=2,USE_BSCAN=0,BSCANID=0,TRACE=0,ECC=0,MEMSIZE=65536,MEMTYPE=0,USE_IO_BUS=0,USE_UART_RX=1,USE_UART_TX=1,UART_BAUDRATE=115200,UART_PROG_BAUDRATE=0,UART_DATA_BITS=8,UART_USE_PARITY=0,UART_ODD_PARITY=0,UART_RX_INTERRUPT=0,UART_TX_INTERRUPT=0,UART_ERROR_INTERRUPT=0,USE_FIT1=0,FIT1_No_CLOCKS=6216,FIT1_INTERRUPT=0,USE_FIT2=0,FIT2_No_CLOCKS=6216,FIT2_INTERRUPT=0,USE_FIT3=0,FIT3_No_CLOCKS=6216,FIT3_INTERRUPT=0,USE_FIT4=0,FIT4_No_CLOCKS=6216,FIT4_INTERRUPT=0,USE_PIT1=0,PIT1_SIZE=32,PIT1_READABLE=1,PIT1_PRESCALER=0,PIT1_INTERRUPT=0,USE_PIT2=0,PIT2_SIZE=32,PIT2_READABLE=1,PIT2_PRESCALER=0,PIT2_INTERRUPT=0,USE_PIT3=0,PIT3_SIZE=32,PIT3_READABLE=1,PIT3_PRESCALER=0,PIT3_INTERRUPT=0,USE_PIT4=0,PIT4_SIZE=32,PIT4_READABLE=1,PIT4_PRESCALER=0,PIT4_INTERRUPT=0,USE_GPO1=1,GPO1_SIZE=8,GPO1_INIT=0x00000000,USE_GPO2=1,GPO2_SIZE=16,GPO2_INIT=0x00000000,USE_GPO3=0,GPO3_SIZE=32,GPO3_INIT=0x00000000,USE_GPO4=0,GPO4_SIZE=32,GPO4_INIT=0x00000000,USE_GPI1=1,GPI1_SIZE=8,GPI1_INTERRUPT=0,USE_GPI2=0,GPI2_SIZE=32,GPI2_INTERRUPT=0,USE_GPI3=0,GPI3_SIZE=32,GPI3_INTERRUPT=0,USE_GPI4=0,GPI4_SIZE=32,GPI4_INTERRUPT=0,INTC_USE_EXT_INTR=0,INTC_INTR_SIZE=1,INTC_LEVEL_EDGE=0x0000,INTC_POSITIVE=0xFFFF,INTC_ASYNC_INTR=0xFFFF,INTC_NUM_SYNC_FF=2,Component_Name=microblaze_mcs_riscv_0,USE_BOARD_FLOW=false,CLK_BOARD_INTERFACE=Custom,RESET_BOARD_INTERFACE=Custom,GPIO1_BOARD_INTERFACE=Custom,GPIO2_BOARD_INTERFACE=Custom,GPIO3_BOARD_INTERFACE=Custom,GPIO4_BOARD_INTERFACE=Custom,UART_BOARD_INTERFACE=Custom}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of microblaze_mcs_riscv_0 : entity is "yes";
end microblaze_mcs_riscv_0;

architecture stub of microblaze_mcs_riscv_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "Clk,Reset,UART_rxd,UART_txd,GPIO1_tri_i[7:0],GPIO1_tri_o[7:0],GPIO2_tri_o[15:0]";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of Clk : signal is "xilinx.com:signal:clock:1.0 CLK.Clk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of Clk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of Clk : signal is "XIL_INTERFACENAME CLK.Clk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_04f4_0_Clk, INSERT_VIP 0, ASSOCIATED_ASYNC_RESET Reset, BOARD.ASSOCIATED_PARAM CLK_BOARD_INTERFACE";
  attribute X_INTERFACE_INFO of Reset : signal is "xilinx.com:signal:reset:1.0 RST.Reset RST";
  attribute X_INTERFACE_MODE of Reset : signal is "slave";
  attribute X_INTERFACE_PARAMETER of Reset : signal is "XIL_INTERFACENAME RST.Reset, POLARITY ACTIVE_HIGH, INSERT_VIP 0, BOARD.ASSOCIATED_PARAM RESET_BOARD_INTERFACE";
  attribute X_INTERFACE_INFO of UART_rxd : signal is "xilinx.com:interface:uart:1.0 UART RxD";
  attribute X_INTERFACE_MODE of UART_rxd : signal is "master";
  attribute X_INTERFACE_PARAMETER of UART_rxd : signal is "XIL_INTERFACENAME UART, BOARD.ASSOCIATED_PARAM UART_BOARD_INTERFACE";
  attribute X_INTERFACE_INFO of UART_txd : signal is "xilinx.com:interface:uart:1.0 UART TxD";
  attribute X_INTERFACE_INFO of GPIO1_tri_i : signal is "xilinx.com:interface:gpio:1.0 GPIO1 TRI_I";
  attribute X_INTERFACE_MODE of GPIO1_tri_i : signal is "master";
  attribute X_INTERFACE_PARAMETER of GPIO1_tri_i : signal is "XIL_INTERFACENAME GPIO1, C_USE_GPO1 1, C_GPO1_SIZE 8, C_GPO1_INIT 0x00000000, C_USE_GPI1 1, C_GPI1_SIZE 8, C_GPI1_INTERRUPT 0, BOARD.ASSOCIATED_PARAM GPIO1_BOARD_INTERFACE";
  attribute X_INTERFACE_INFO of GPIO1_tri_o : signal is "xilinx.com:interface:gpio:1.0 GPIO1 TRI_O";
  attribute X_INTERFACE_INFO of GPIO2_tri_o : signal is "xilinx.com:interface:gpio:1.0 GPIO2 TRI_O";
  attribute X_INTERFACE_MODE of GPIO2_tri_o : signal is "master";
  attribute X_INTERFACE_PARAMETER of GPIO2_tri_o : signal is "XIL_INTERFACENAME GPIO2, C_USE_GPO2 1, C_GPO2_SIZE 16, C_GPO2_INIT 0x00000000, C_USE_GPI2 0, C_GPI2_SIZE 32, C_GPI2_INTERRUPT 0, BOARD.ASSOCIATED_PARAM GPIO2_BOARD_INTERFACE";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "bd_04f4_0,Vivado 2025.2";
begin
end;
