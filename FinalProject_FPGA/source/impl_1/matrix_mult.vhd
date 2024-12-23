library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

entity matrix_mult is
    port (  Clock: in std_logic; 
            A,B : in unsigned(71 downto 0);
            C : out unsigned(71 downto 0)
            );
end entity;

architecture synth of matrix_mult is
begin 
			C(71 downto 64) <= resize(((A(71 downto 64) * B(71 downto 64)) + (A(63 downto 56) * B(47 downto 40)) + (A(55 downto 48) * B(23 downto 16))),8);
			C(63 downto 56) <= resize((((A(71 downto 64) * B(63 downto 56)) + (A(63 downto 56) * B(39 downto 32))) + (A(55 downto 48) * B(15 downto 8))),8);
			C(55 downto 48) <= resize((((A(71 downto 64) * B(55 downto 48)) + (A(63 downto 56) * B(31 downto 24))) + (A(55 downto 48) * B(7 downto 0))),8);			 

			C(47 downto 40) <= resize((((A(47 downto 40) * B(71 downto 64)) + (A(39 downto 32) * B(47 downto 40))) + (A(31 downto 24) * B(23 downto 16))),8);
			C(39 downto 32) <= resize((((A(47 downto 40) * B(63 downto 56)) + (A(39 downto 32) * B(39 downto 32))) + (A(31 downto 24) * B(15 downto 8))),8);
			C(31 downto 24) <= resize((((A(47 downto 40) * B(55 downto 48)) + (A(39 downto 32) * B(31 downto 24))) + (A(31 downto 24) * B(7 downto 0))),8);

			C(23 downto 16) <= resize((((A(23 downto 16) * B(71 downto 64)) + (A(15 downto 8) * B(47 downto 40))) + (A(7 downto 0) * B(23 downto 16))),8);
			C(15 downto 8) <= resize((((A(23 downto 16) * B(63 downto 56)) + (A(15 downto 8) * B(39 downto 32))) + (A(31 downto 0) * B(15 downto 8))),8);
			C(7 downto 0) <= resize((((A(23 downto 16) * B(55 downto 48)) + (A(15 downto 8) * B(31 downto 24))) + (A(31 downto 0) * B(7 downto 0))),8);
end architecture;