
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

entity top is
    port( 
		clk : in std_logic;
		input : in std_logic;
		rst, start_sig: in std_logic;

---------------------------------------  VGA CODE BELOW -------------------------------------------------------

		clk_e : in std_logic;
        clk_out : out std_logic;
        HSYNC, VSYNC : out std_logic;
        rgb : out unsigned (5 downto 0)
---------------------------------------  VGA CODE ABOVE -------------------------------------------------------

		);	
end top;

architecture synth of top is 

	component matrix_mult is
		port (  Clock : in std_logic; 
				A,B : in unsigned(71 downto 0);
				C : out unsigned(71 downto 0)
				);
	end component;

---------------------------------------  VGA CODE BELOW-------------------------------------------------------
	component mypll is
            port(
                  ref_clk_i : in std_logic;
                  rst_n_i : in std_logic;
                  outcore_o : out std_logic;
                  outglobal_o : out std_logic
            );
      end component;
      component vga is
            port(
                  g_clk : in std_logic;
                  valid, vga_HSYNC, vga_VSYNC : out std_logic;
                  ani_clk : out std_logic;
                  row, col : out unsigned(9 downto 0):= 10b"0"
            );
      end component;
      component pattern_gen is
            port(
                  p_valid : in std_logic;
                  ani_clk : in std_logic;
                  row_n, col_n : in unsigned(9 downto 0);
			   loadMatrix1, loadMatrix2, loadMatrix3 : in unsigned (71 downto 0);
                  p_rgb : out unsigned (5 downto 0)
            );
      end component;
      signal clk_int : std_logic;
      signal valid : std_logic;
      signal row, col : unsigned(9 downto 0);
      signal clk_ani : std_logic;
	 
---------------------------------------  VGA CODE ABOVE-------------------------------------------------------


		signal loadA, loadB, loadC, outC : unsigned(71 downto 0):= 72b"0";
		signal count : unsigned(9 downto 0);
		signal pause_sig : std_logic:= '0';

begin


	---------------------------------------  VGA CODE BELOW-------------------------------------------------------
	mypll0: mypll port map (
			ref_clk_i => clk_e,
			rst_n_i => '1',
			outcore_o => clk_out,
			outglobal_o => clk_int
		  );

	vga0: vga port map (
			g_clk => clk_int,
			valid => valid,
			vga_HSYNC => HSYNC,
			vga_VSYNC => VSYNC,
			row => row,
			col => col,
			ani_clk => clk_ani
	      );

	pattern_gen0: pattern_gen port map (
			p_valid => valid,
			row_n => row,
			col_n => col,
			loadMatrix1 => loadA,
			loadMatrix2 => loadB,
			loadMatrix3 => loadC,
			p_rgb => rgb,
			ani_clk => clk_ani
	      );
---------------------------------------  VGA CODE ABOVE-------------------------------------------------------


	matrix_mult0 : matrix_mult port map(
			Clock => clk, 
			A => loadA,
			B => loadB,
			C => loadC
		);
	process (clk) begin
		if rising_edge(clk) then
			if  start_sig = '1' then -- must be on to use
				if rst = '1' then -- synchronous reset
					count <= 10d"0";
					loadA <= 72d"0";
					loadB <= 72d"0";
					pause_sig <= '0';
				elsif pause_sig = '0' then -- 145-count counter to read in the two 3 x 3 (8 bit) matrices to memory and freeze the count
					count <= 10d"0" when count = 10d"144" else count + 10d"1";
					pause_sig <= '1' when count = 10d"144" else '0';
					if count < 72 then
						loadA <= loadA(70 downto 0) & input;				
					elsif count < 144 then
						loadB <= loadB(70 downto 0) & input;
					end if;
				end if;
			end if;
		end if;
	end process;
end synth;
