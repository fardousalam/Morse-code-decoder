library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
ENTITY baud IS
 port (rb_i,cp_i: IN STD_LOGIC;
       co_o: OUT STD_LOGIC);

END baud;
ARCHITECTURE baud_gen OF baud IS
COMPONENT comp1 PORT (q2_o, co_o:OUT STD_LOGIC; rb_i,cp_i: IN STD_LOGIC); END COMPONENT;
COMPONENT comp2 PORT (q3_o, co_o:OUT STD_LOGIC; rb_i,cp_i,ena_i: IN STD_LOGIC); END COMPONENT;
COMPONENT comp3 PORT (q3_o, co_o:OUT STD_LOGIC; rb_i,cp_i,ena_i: IN STD_LOGIC); END COMPONENT;

FOR ALL: comp1 USE ENTITY WORK.c5xc (ar1);
FOR ALL: comp2 USE ENTITY WORK.c13ec (ar1);
FOR ALL: comp3 USE ENTITY WORK.c16ec (ar1);

SIGNAL ng5c_s,ng5q_s, ng13c_s, ng13q_s, ng16q_s, ng16c_s: STD_LOGIC;

BEGIN
 g1a :comp1 PORT MAP (ng5q_s, ng5c_s,rb_i,cp_i);
 g2b: comp2 PORT MAP ( ng13c_s, ng13q_s, rb_i,cp_i,ng5c_s);
 g3c : comp3 PORT MAP (ng16q_s, ng16c_s,rb_i,cp_i,ng13c_s);

co_o<= ng16c_s;
END baud_gen;
