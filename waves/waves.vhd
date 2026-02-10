library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity waves is
	port (
		adc_sclk        : out   std_logic;      
		adc_cs_n        : out   std_logic; 
		adc_dout        : in    std_logic;  
		adc_din         : out   std_logic;
		clk        		 : in    std_logic;    
		dac		       : out   std_logic_vector(15 downto 0);                   
		leds     		 : out   std_logic_vector(7 downto 0);                 
		reset   			 : in    std_logic;        
		sdram_addr      : out   std_logic_vector(11 downto 0);                
		sdram_ba        : out   std_logic_vector(1 downto 0);                    
		sdram_cas_n     : out   std_logic;                                        
		sdram_cke       : out   std_logic;                                       
		sdram_cs_n      : out   std_logic;                                        
		sdram_dq        : inout std_logic_vector(31 downto 0); 
		sdram_dqm       : out   std_logic_vector(3 downto 0);                     
		sdram_ras_n     : out   std_logic;                                        
		sdram_we_n      : out   std_logic;                                        
		sdram_clk 		 : out   std_logic;                                        
		switches 		 : in    std_logic_vector(7 downto 0) 
	);
end waves;

architecture rtl of waves is

component waves_nios is
	port (
		adc_sclk        : out   std_logic;                                        --         adc.sclk
		adc_cs_n        : out   std_logic;                                        --            .cs_n
		adc_dout        : in    std_logic                     := '0';             --            .dout
		adc_din         : out   std_logic;                                        --            .din
		clk_clk         : in    std_logic                     := '0';             --         clk.clk
		dac_export      : out   std_logic_vector(15 downto 0);                     --         dac.export
		leds_export     : out   std_logic_vector(7 downto 0);                     --        leds.export
		reset_reset_n   : in    std_logic                     := '0';             --       reset.reset_n
		sdram_addr      : out   std_logic_vector(11 downto 0);                    --       sdram.addr
		sdram_ba        : out   std_logic_vector(1 downto 0);                     --            .ba
		sdram_cas_n     : out   std_logic;                                        --            .cas_n
		sdram_cke       : out   std_logic;                                        --            .cke
		sdram_cs_n      : out   std_logic;                                        --            .cs_n
		sdram_dq        : inout std_logic_vector(31 downto 0) := (others => '0'); --            .dq
		sdram_dqm       : out   std_logic_vector(3 downto 0);                     --            .dqm
		sdram_ras_n     : out   std_logic;                                        --            .ras_n
		sdram_we_n      : out   std_logic;                                        --            .we_n
		sdram_clock_clk : out   std_logic;                                        -- sdram_clock.clk
		switches_export : in    std_logic_vector(7 downto 0)  := (others => '0')  --    switches.export
	);
end component;

begin

NIOS:waves_nios
port map(adc_sclk,adc_cs_n,adc_dout,adc_din,clk,dac,leds,reset,sdram_addr,sdram_ba,sdram_cas_n,sdram_cke,sdram_cs_n,sdram_dq,sdram_dqm,sdram_ras_n,sdram_we_n,sdram_clk,switches);

end architecture rtl;