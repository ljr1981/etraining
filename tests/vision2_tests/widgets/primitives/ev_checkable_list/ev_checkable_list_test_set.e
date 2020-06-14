note
	description: "Demonstration of {EV_CHECKABLE_LIST}"
	testing: "type/manual"

class
	EV_CHECKABLE_LIST_TEST_SET

inherit
	TEST_SET_SUPPORT_VISION2

feature -- Test routines

	ev_checkable_list_tests
			-- Demonstration of a basic {EV_CHECKABLE_LIST}
		note
			testing:  "covers/{EV_BUTTON}.make_with_text", "execution/isolated", "execution/serial"
			usage: "Set `show_me' to True, recompile, and run this test to interact with `l_item'."
		local
			l_item: EV_CHECKABLE_LIST
			l_list_item: EV_LIST_ITEM
		do
				-- Standard Creation
			create l_item.make_with_strings (<<"Item 1", "Item 2", "Item 3", "Item 4">>)

				-- Needed Enhancements
			l_item.set_minimum_size (100, 100)

				-- Other Enhancements
			create l_list_item.make_with_text ("Item 5")
			add_item_clicked_me_dialog (l_list_item)
			l_item.extend (l_list_item)

				-- Setup and Demo
			show_me := False
			demonstrate_widget (l_item)
		end
		
end
