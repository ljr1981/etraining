note
	description: "Demonstration of {EV_GRID}"
	testing: "type/manual"

class
	EV_GRID_TEST_SET

inherit
	TEST_SET_SUPPORT_VISION2

feature -- Test routines

	ev_grid_tests
			-- Demonstration of a basic EV_GRID
		note
			testing:  "covers/{EV_GRID}.make_with_text", "execution/isolated", "execution/serial"
			usage: "Set `show_me' to True, recompile, and run this test to interact with `l_item'."
			explanation: "[
				This is an empty grid with nothing in it.
				No columns. No rows. No cells (as a result).
				]"
		local
			l_item: EV_GRID
		do
				-- Standard Creation
			create l_item

				-- Setup and Demo
			show_me := False
			demonstrate_widget (l_item)
		end

end
