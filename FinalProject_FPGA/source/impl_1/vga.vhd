library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga is
  port(
        g_clk : in std_logic;
        valid, vga_HSYNC, vga_VSYNC : out std_logic;
        ani_clk : out std_logic;
        row, col : out unsigned(9 downto 0):= 10b"0"
        
  );
end vga;


architecture synth of vga is
      signal h_valid : std_logic;
      signal v_valid : std_logic;
      begin
      process (g_clk) begin
            if rising_edge(g_clk) then

                  col <= 10d"0" when (col = 10d"799") else col + '1';         

                  row <= 10d"0" when (row = 10d"524" and col = 10d"799") else row + '1' when (col = 10d"799");
                  
                  ani_clk <= '1' when (row = 10d"524" and col = 10d"799") else '0';
            end if;
      end process;
      vga_HSYNC <= '0' when (col >= 10d"656" and col < 10d"752") else
                        '1';
      h_valid <= '1' when (col >= 10d"0" and col < 10d"640") else
                        '0';
      vga_VSYNC <= '0' when (row >= 10d"490" and row < 10d"492") else
                        '1';
      v_valid <= '1' when (row >= 10d"0" and row < 10d"480") else
                        '0';
      
      
      valid <= v_valid and h_valid;
      end;