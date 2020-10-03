
------------------------------------------------------------------------------------------------------------
------------------------Filename: uartcontrolfsm_tb.vhd - 12x1 uartcontrolfsm Test Bench-------------------------------------
------------------------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
 
 
ENTITY uartcontrolfsm_tb IS
END uartcontrolfsm_tb;
 
ARCHITECTURE behavior OF uartcontrolfsm_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
   COMPONENT uartcontrolfsm PORT (
						 rb_i, 
						 cp_i, 
						 dv_i, 
						 co_i: IN STD_LOGIC; 
						 dv_o:OUT STD_LOGIC);
   END COMPONENT;
	
    FOR ALL : uartcontrolfsm USE ENTITY WORK.fsm_uart_control (a1);	

   --Inputs
   SIGNAL rb_i : STD_LOGIC := '0';
   SIGNAL cp_i  : STD_LOGIC := '0';
   SIGNAL dv_i  : STD_LOGIC := '0';
   SIGNAL co_i  : STD_LOGIC := '0';
  
 	--Outputs
   SIGNAL dv_o : STD_LOGIC := '0';
   
     -- Setting period of clock
 
   CONSTANT period : TIME := 20 ns;
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: uartcontrolfsm PORT MAP (
						  rb_i => rb_i,
						  cp_i => cp_i,
						  dv_i => dv_i,
						  co_i => co_i,
						  dv_o => dv_o
						 );

 -- Clock PROCESS definitions
   clock_PROCESS :PROCESS
   BEGIN
		cp_i <=  '0';
		WAIT FOR period/2;
		cp_i <=  '1';
		WAIT FOR period/2;
   END PROCESS;						 
		
		  -- Stimulus PROCESS
   stim_proc: PROCESS
   BEGIN
      
     -- hold reset state for 20 ns.
		rb_i <= '0';
		WAIT FOR 20 ns;	
			rb_i <= '1';
		
		--test for Uart FSM
--------------------------------------------------------------------------
		
		dv_i <= '1'; WAIT FOR 20 ms;
		--data valid from morse binary tree is high enable "dv_o" => start mod12 counter
		--which inturns starts uart transmission

	    co_i <= '1'; WAIT FOR 104*12 us;
		--carry out from morse mod12 counter is high which means transmission 
		--of a single ASCII character is done and now "dv_o" can be reset 

	    dv_i <= '0'; WAIT FOR 10 ms;
		--data valid becomes zero which means fsm can finally go to initial state 
		
     END PROCESS;

END behavior;			
			

