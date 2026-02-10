	component waves is
		port (
			clk_clk         : in  std_logic := 'X'; -- clk
			reset_reset_n   : in  std_logic := 'X'; -- reset_n
			sdram_clock_clk : out std_logic         -- clk
		);
	end component waves;

	u0 : component waves
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --         clk.clk
			reset_reset_n   => CONNECTED_TO_reset_reset_n,   --       reset.reset_n
			sdram_clock_clk => CONNECTED_TO_sdram_clock_clk  -- sdram_clock.clk
		);

