note
	description: "Demonstration of {EV_GRID}"
	testing: "type/manual"

class
	EV_GRID_TEST_SET

inherit
	TEST_SET_SUPPORT_VISION2

feature -- Test routines

	ev_grid_demo
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

	ev_grid_populated_demo
			-- Demonstration of a basic EV_GRID with rows and columns.
		note
			testing:  "covers/{EV_GRID}.make_with_text", "execution/isolated", "execution/serial"
			usage: "Set `show_me' to True, recompile, and run this test to interact with `l_item'."
			explanation: "[
				This grid adds a couple columns and rows.
				]"
		local
			l_item: EV_GRID
		do
				-- Standard Creation
			create l_item

				-- Enhancements
			l_item.set_minimum_size (200, 200) -- Let's see it ...

				-- Adding "cells" as {EV_GRID_LABEL_ITEM}s
			l_item.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("c1,r1"))
			l_item.set_item (1, 2, create {EV_GRID_LABEL_ITEM}.make_with_text ("c1,r2"))
			l_item.set_item (2, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("c2,r1"))
			l_item.set_item (2, 2, create {EV_GRID_LABEL_ITEM}.make_with_text ("c2,r2"))

				-- Once we have columns, we can populate the {EV_GRID_HEADER_ITEM} over each.
				-- Note that as each column is created, it automatically gets
				--	an empty header item. We then get to enhance it however we want.
				--	In this case, we are adding header text.
			l_item.column (1).header_item.set_text ("Col 1")
			l_item.column (2).header_item.set_text ("Col 2")
				-- An alternative way ...
			l_item.header [1].set_text ("Alt Col 1")
			l_item.header [2].set_text ("Alt Col 2")

				-- Setup and Demo
			show_me := True
			demonstrate_widget (l_item)
		end

end
