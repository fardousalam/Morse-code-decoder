library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
ENTITY muxxx is 
      port (d0_i,d1_i,d2_i,d3_i,d4_i,d5_i,d6_i,d7_i,d8_i,d9_i,d10_i,d11_i: IN STD_LOGIC;
            a0_i,a1_i,a2_i,a3_i : IN STD_LOGIC;
            txd_o : OUT STD_LOGIC);
END muxxx;
ARCHITECTURE ar2_using_WITH_STATEMENT OF muxxx IS
SIGNAL seld_s: STD_LOGIC_VECTOR (3 DOWNTO 0);
BEGIN
seld_s<= a3_i&a2_i&a1_i&a0_i;
WITH seld_s SELECT
txd_o<= '1' WHEN "0000",
        '0' WHEN "0001",
        d0_i WHEN "0010",
        d1_i WHEN "0011",
        d2_i WHEN "0100",
        d3_i WHEN "0101",
        d4_i WHEN "0110",
        d5_i WHEN "0111",
        d6_i WHEN "1000",
        d7_i WHEN "1001",
        d8_i WHEN "1010",
        d9_i WHEN "1011",
       d10_i WHEN "1100",
       d11_i WHEN "1101",
         '1' WHEN OTHERS;
 END ar2_using_WITH_STATEMENT;
