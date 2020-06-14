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
			l_checkable: EV_GRID_CHECKABLE_LABEL_ITEM
			l_choice: EV_GRID_CHOICE_ITEM
			l_combo: EV_GRID_COMBO_ITEM
			l_drawable: EV_GRID_DRAWABLE_ITEM
			l_editable: EV_GRID_EDITABLE_ITEM
			l_label: EV_GRID_LABEL_ITEM
			l_pix_right: EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM
		do
				-- Standard Creation
			create l_item

				-- Enhancements
			l_item.set_minimum_size (300, 400) -- Let's see it ...

				-- Adding "cells" as {EV_GRID_LABEL_ITEM}s
			l_item.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("c1,r1"))
			l_item.set_item (1, 2, create {EV_GRID_LABEL_ITEM}.make_with_text ("c1,r2"))
			l_item.set_item (2, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("c2,r1"))
			l_item.set_item (2, 2, create {EV_GRID_LABEL_ITEM}.make_with_text ("c2,r2"))
			l_item.column (1).set_width (150)

				-- More specialized items
			create l_checkable.make_with_text ("I am checkable?")
			l_item.set_item (1, 3, l_checkable)

			create l_choice.make_with_text ("I have a choice!")
			l_choice.set_item_strings (<<"Choice 1", "Choice 2", "Choice 3">>)
			l_item.set_item (1, 4, l_choice)
			l_choice.enable_full_select -- `l_choice' need a "parent" before this
			l_choice.select_actions.force (agent l_choice.activate) -- We are responsible for `activate'

			create l_combo.make_with_text ("combo?")
			l_item.set_item (1, 5, l_combo)
			l_combo.set_item_strings (<<"Item 1", "Item 2", "Item 3", "Item 4">>) -- set items
			l_combo.select_actions.extend (agent l_combo.activate) -- handle activation

			create l_combo.make_with_text ("Non-editable combo")
			l_item.set_item (1, 6, l_combo)
			l_combo.disable_select
			l_combo.set_item_strings (<<"Item 1", "Item 2", "Item 3", "Item 4">>) -- set items
			l_combo.select_actions.extend (agent l_combo.activate) -- handle activation

			create l_drawable
			l_item.set_item (1, 7, l_drawable)

			create l_editable.make_with_text ("You can edit me")
			l_item.set_item (1, 8, l_editable)
			l_editable.activate_actions.extend (agent on_editable_select (?, l_editable.text_field))
			l_editable.select_actions.extend (agent l_editable.activate) -- handle activation

			create l_pix_right.make_with_text ("Pix right")
			l_item.set_item (1, 9, l_pix_right)
			l_pix_right.set_pixmap ((create {EV_STOCK_PIXMAPS_IMP}).information_pixmap)

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
			show_me := False
			demonstrate_widget (l_item)
		end

	on_editable_select (a_popup: EV_POPUP_WINDOW; a_field: detachable EV_TEXT_FIELD)
			-- One way to support {EV_GRID_EDITABLE_ITEM} activation
			--	for doing a "select_all" on the resulting text field.
		do
			if attached a_field as al_field then
				al_field.select_all
			end
		end

end
