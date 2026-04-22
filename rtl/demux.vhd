library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity demux is
    generic(
        N: integer:= 4
    );
    port (
        SEL: in unsigned(N-1 downto 0);
        RESET: in std_logic;
        DEMUX_OUT: out std_logic_vector(2**N-1 downto 0)
    );
end entity demux;

architecture rtl of demux is
    signal counter: unsigned(N-1 downto 0):= to_unsigned(0,N);
    signal demux_signal: unsigned(2**N -1 downto 0);
begin
    loop_proc: process (SEL) is
    begin
        if RESET= '0' then
            for i in 0 to 2**N-1 loop
                if counter= SEL then
                    exit;
                else
                    counter<= counter + to_unsigned(1,N);
                    demux_signal<= shift_left(demux_signal,1);
                end if;
            end loop; 
        else
            demux_signal<= to_unsigned(1, 2**N);            
        end if;
    end process;
    DEMUX_OUT<= std_logic_vector(demux_signal);
    
end architecture rtl;