library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pattern_gen is
  port(
        p_valid : in std_logic;
        ani_clk : in std_logic;
	   loadMatrix1, loadMatrix2, loadMatrix3: in unsigned (71 downto 0);
	   
        row_n, col_n : in unsigned(9 downto 0);
        p_rgb : out unsigned (5 downto 0)
  );
end pattern_gen;

architecture synth of pattern_gen is
signal num :unsigned(9 downto 0);
signal m_rgb, pattern : unsigned (7 downto 0);
signal h_shift, v_shift : unsigned(9 downto 0);
signal h_inc : std_logic;
signal v_inc : std_logic;
begin
      process (ani_clk) begin
            if rising_edge(ani_clk) then
               if h_shift = 10d"191" then
                        h_inc <= '0';
                  elsif h_shift = 10d"0" then
                        h_inc <= '1';
                  end if;
                  if v_shift = 10d"419" then
                        v_inc <= '0';
                  elsif v_shift = 10d"0" then
                        v_inc <= '1';
                  end if;
                  h_shift <= h_shift + '1' when h_inc = '1' else h_shift - '1';
                  v_shift <= v_shift + '1' when v_inc = '1' else v_shift - '1';
            end if;
      end process;
num <= ( (row_n + col_n + v_shift + h_shift) xor (row_n + v_shift) xor (col_n + h_shift)) mod 13;
pattern <= "11111111" when num = 0 else "00100000";
m_rgb <= pattern when (col_n < 10d"241" or col_n > 399 or row_n > 477 or row_n = 0) else
		 loadMatrix1(71 downto 64) when (col_n > 10d"240" and col_n < 10d"294" and row_n > 10d"0" and row_n < 10d"54") else
		 loadMatrix1(63 downto 56) when (col_n > 10d"293" and col_n < 10d"347" and row_n > 10d"0" and row_n < 10d"54") else
		 loadMatrix1(55 downto 48) when (col_n > 10d"346" and col_n < 10d"400" and row_n > 10d"0" and row_n < 10d"54") else
		 
		 loadMatrix1(47 downto 40) when (col_n > 10d"240" and col_n < 10d"294" and row_n > 10d"53" and row_n < 10d"107") else
		 loadMatrix1(39 downto 32) when (col_n > 10d"293" and col_n < 10d"347" and row_n > 10d"53" and row_n < 10d"107") else
		 loadMatrix1(31 downto 24) when (col_n > 10d"346" and col_n < 10d"400" and row_n > 10d"53" and row_n < 10d"107") else
		 
		 loadMatrix1(23 downto 16) when (col_n > 10d"240" and col_n < 10d"294" and row_n > 10d"106" and row_n < 10d"160") else
		 loadMatrix1(15 downto 8) when (col_n > 10d"293" and col_n < 10d"347" and row_n > 10d"106" and row_n < 10d"160") else
		 loadMatrix1(7 downto 0) when (col_n > 10d"346" and col_n < 10d"400" and row_n > 10d"106" and row_n < 10d"160") else
		 
		 
		 loadMatrix2(71 downto 64) when (col_n > 10d"240" and col_n < 10d"294" and row_n > 10d"159" and row_n < 10d"213") else
		 loadMatrix2(63 downto 56) when (col_n > 10d"293" and col_n < 10d"347" and row_n > 10d"159" and row_n < 10d"213") else
		 loadMatrix2(55 downto 48) when (col_n > 10d"346" and col_n < 10d"400" and row_n > 10d"159" and row_n < 10d"213") else
		 
		 loadMatrix2(47 downto 40) when (col_n > 10d"240" and col_n < 10d"294" and row_n > 10d"212" and row_n < 10d"266") else
		 loadMatrix2(39 downto 32) when (col_n > 10d"293" and col_n < 10d"347" and row_n > 10d"212" and row_n < 10d"266") else
		 loadMatrix2(31 downto 24) when (col_n > 10d"346" and col_n < 10d"400" and row_n > 10d"212" and row_n < 10d"266") else
		 
		 loadMatrix2(23 downto 16) when (col_n > 10d"240" and col_n < 10d"294" and row_n > 10d"265" and row_n < 10d"319") else
		 loadMatrix2(15 downto 8) when (col_n > 10d"293" and col_n < 10d"347" and row_n > 10d"265" and row_n < 10d"319") else
		 loadMatrix2(7 downto 0) when (col_n > 10d"346" and col_n < 10d"400" and row_n > 10d"265" and row_n < 10d"319") else



		 loadMatrix3(71 downto 64) when (col_n > 10d"240" and col_n < 10d"294" and row_n > 10d"318" and row_n < 10d"372") else
		 loadMatrix3(63 downto 56) when (col_n > 10d"293" and col_n < 10d"347" and row_n > 10d"318" and row_n < 10d"372") else
		 loadMatrix3(55 downto 48) when (col_n > 10d"346" and col_n < 10d"400" and row_n > 10d"318" and row_n < 10d"372") else
		 
		 loadMatrix3(47 downto 40) when (col_n > 10d"240" and col_n < 10d"294" and row_n > 10d"371" and row_n < 10d"425") else
		 loadMatrix3(39 downto 32) when (col_n > 10d"293" and col_n < 10d"347" and row_n > 10d"371" and row_n < 10d"425") else
		 loadMatrix3(31 downto 24) when (col_n > 10d"346" and col_n < 10d"400" and row_n > 10d"371" and row_n < 10d"425") else
		 
		 loadMatrix3(23 downto 16) when (col_n > 10d"240" and col_n < 10d"294" and row_n > 10d"424" and row_n < 10d"478") else
		 loadMatrix3(15 downto 8) when (col_n > 10d"293" and col_n < 10d"347" and row_n > 10d"424" and row_n < 10d"478") else
		 loadMatrix3(7 downto 0) when (col_n > 10d"346" and col_n < 10d"400" and row_n > 10d"424" and row_n < 10d"478");

p_rgb <= "000000" when p_valid = '0' else resize(m_rgb, 6);
--p_rgb <= "111111" when p_valid = '0' else "111111" when num = '0' else "000001";
end;