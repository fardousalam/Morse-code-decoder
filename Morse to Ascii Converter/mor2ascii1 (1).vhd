-- MORSE TO ASCII CONVERTER

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


ENTITY MOR2ASCII IS PORT (m1_i,m2_i,cp_i,rb_i,dv_i,eot_i : IN STD_LOGIC; asc_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);sot_o : OUT STD_LOGIC);

END MOR2ASCII;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ARCHITECTURE ar1 of MOR2ASCII IS

CONSTANT sIDLE : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
CONSTANT sA : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01000001";
CONSTANT sB : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01000010";
CONSTANT sC : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01000011";
CONSTANT sD : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01000100";
CONSTANT sE : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01000101";
CONSTANT sF : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01000110";
CONSTANT sG : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01000111";
CONSTANT sH : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01001000";
CONSTANT sI : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01001001";
CONSTANT sJ : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01001010";
CONSTANT sK : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01001011";
CONSTANT sL : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01001100";
CONSTANT sM : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01001101";
CONSTANT sN : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01001110";
CONSTANT sO : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01001111";
CONSTANT sP : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01010000";
CONSTANT sQ : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01010001";
CONSTANT sR : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01010010";
CONSTANT sS : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01010011";
CONSTANT sT : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01010100";
CONSTANT sU : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01010101";
CONSTANT sV : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01010110";
CONSTANT sW : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01010111";
CONSTANT sX : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011000";
CONSTANT sY : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011001";
CONSTANT sZ : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011010";  
CONSTANT s1 : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";  
CONSTANT s2 : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";  
CONSTANT s3 : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";  
CONSTANT s4 : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";  
CONSTANT s5 : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";  
CONSTANT s6 : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";  
CONSTANT s7 : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";  
CONSTANT s8 : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";  
CONSTANT s9 : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";  
CONSTANT sDot : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";  
CONSTANT sDash : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";
CONSTANT sMinus : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";
CONSTANT sSpace : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011011";
CONSTANT sEOW : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01011101";  

              
SIGNAL morse : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL TiP : STD_LOGIC;

SIGNAL state_s : STD_LOGIC_VECTOR(7 DOWNTO 0) := sIDLE;
SIGNAL state_sf : STD_LOGIC_VECTOR(7 DOWNTO 0) := sIDLE;


	BEGIN 
	morse <= m1_i & m2_i;
	zahelon : PROCESS(rb_i,dv_i,cp_i)
	BEGIN
	IF (rb_i = '0') THEN state_s <= sIDLE;
	ELSIF (cp_i = '1' AND cp_i'EVENT AND dv_i = '1')
	THEN
		IF (eot_i = '1')
		THEN
		TiP <= '0';
		sot_o <= '0';
		END IF;
		IF (morse = "00")
		THEN 
		-- EOC <= '1';
		IF (state_s = sIDLE) THEN state_s <= sIDLE;
		ELSE
		IF (TiP = '0')
		THEN		
		asc_o <= state_s;
		state_s <= sIDLE;
		sot_o <= '1';
		TiP <= '1';
		END IF;
		END IF;
		END IF;
		IF (state_s = sIDLE) 
			THEN 
			IF(morse = "01") THEN state_s <= sT;
			ELSIF(morse = "10") THEN state_s <= sE;
			ELSIF(morse = "00") THEN state_s <= sIDLE;
			ELSIF(morse = "11") THEN state_s <= sSpace;
			
			END IF;
		ELSIF (state_s = sT)
			THEN 
			IF(morse = "01") THEN state_s <= sM;
			ELSIF(morse = "10") THEN state_s <= sN;
			--ELSE state_s <= sIDLE;
			END IF;		
		ELSIF (state_s = sE)
			THEN
			IF(morse = "01") THEN state_s <= sA;
			ELSIF(morse = "10") THEN state_s <= sI;
			--ELSE state_s <= sIDLE;
			END IF;		
		ELSIF (state_s = sM)
			THEN
			IF(morse = "01") THEN state_s <= sO;
			ELSIF(morse = "10") THEN state_s <= sG;
			--ELSE state_s <= sIDLE;
			END IF;		
		ELSIF (state_s = sN)
			THEN
			IF(morse = "01") THEN state_s <= sK;
			ELSIF(morse = "10") THEN state_s <= sD;
			--ELSE state_s <= sIDLE;
			END IF;		
		ELSIF (state_s = sA)
			THEN
			IF(morse = "01") THEN state_s <= sW;
			ELSIF(morse = "10") THEN state_s <= sR;
			--ELSE state_s <= sIDLE;
			END IF;		
		ELSIF (state_s = sI)
			THEN
			IF(morse = "01") THEN state_s <= sU;
			ELSIF(morse = "10") THEN state_s <= sS;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sO)
			THEN
			IF(morse = "01") THEN state_s <= sDash;
			ELSIF(morse = "10") THEN state_s <= sDot;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sG)
			THEN
			IF(morse = "01") THEN state_s <= sQ;
			ELSIF(morse = "10") THEN state_s <= sZ;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sK)
			THEN
			IF(morse = "01") THEN state_s <= sY;
			ELSIF(morse = "10") THEN state_s <= sC;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sD)
			THEN
			IF(morse = "01") THEN state_s <= sX;
			ELSIF(morse = "10") THEN state_s <= sB;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sW)
			THEN
			IF(morse = "01") THEN state_s <= sJ;
			ELSIF(morse = "10") THEN state_s <= sP;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sR)
			THEN
			IF(morse = "01") THEN state_s <= sL;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sU)
			THEN
			IF(morse = "01") THEN state_s <= sMinus;
			ELSIF(morse = "10") THEN state_s <= sF;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sS)
			THEN
			IF(morse = "01") THEN state_s <= sV;
			ELSIF(morse = "10") THEN state_s <= sH;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sDash)
			THEN
			IF(morse = "01") THEN state_s <= sO;
			ELSIF(morse = "10") THEN state_s <= s9;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sDot)
			THEN
			IF(morse = "01") THEN state_s <= sIDLE;
			ELSIF(morse = "10") THEN state_s <= s8;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sQ)
			THEN
			IF(morse = "01") THEN state_s <= sIDLE;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sZ)
			THEN
			IF(morse = "01") THEN state_s <= sIDLE;
			ELSIF(morse = "10") THEN state_s <= s7;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sY)
			THEN
			IF(morse = "01") THEN state_s <= sIDLE;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sC)
			THEN
			IF(morse = "01") THEN state_s <= sIDLE;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sX)
			THEN
			IF(morse = "01") THEN state_s <= sIDLE;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sB)
			THEN
			IF(morse = "01") THEN state_s <= sIDLE;
			ELSIF(morse = "10") THEN state_s <= s6;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sJ)
			THEN
			IF(morse = "01") THEN state_s <= s1;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sP)
			THEN
			IF(morse = "01") THEN state_s <= sIDLE;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sL)
			THEN
			IF(morse = "01") THEN state_s <= sIDLE;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sMINUS)
			THEN
			IF(morse = "01") THEN state_s <= s2;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sF)
			THEN
			IF(morse = "01") THEN state_s <= sIDLE;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			--ELSE state_s <= sIDLE;
			
			END IF;
		ELSIF (state_s = sV)
			THEN
			IF(morse = "01") THEN state_s <= s3;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sH)
			THEN
			IF(morse = "01") THEN state_s <= s4;
			ELSIF(morse = "10") THEN state_s <= s5;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sP)
			THEN
			IF(morse = "01") THEN state_s <= sIDLE;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			--ELSE state_s <= sIDLE;
			END IF;
		ELSIF (state_s = sSpace)
			THEN
			asc_o <= sSpace;
			IF(morse = "00") THEN state_s <= sIDLE;
			ELSIF(morse = "10") THEN state_s <= sIDLE;
			ELSIF(morse = "01") THEN state_s <= sIDLE;
			ELSIF(morse = "11") THEN state_s <= sSpace;
			END IF;
			--asc_o <= sSpace;
			--state_s <= sIDLE;
		ELSE 
		state_s <= sIDLE;
		END IF;
	END IF;
	END PROCESS zahelon;

	-- transl : PROCESS(EOC)
	-- BEGIN

	-- END PROCESS transl;

	--END;
END ar1;
