note
	description: "Demonstration of {EV_CHECKABLE_TREE}"
	testing: "type/manual"

class
	EV_CHECKABLE_TREE_TEST_SET

inherit
	TEST_SET_SUPPORT_VISION2

feature -- Test routines

	ev_checkable_list_tests
			-- Demonstration of a basic {EV_CHECKABLE_LIST}
		note
			testing:  "covers/{EV_BUTTON}.make_with_text", "execution/isolated", "execution/serial"
			usage: "Set `show_me' to True, recompile, and run this test to interact with `l_item'."
		local
			l_item: EV_CHECKABLE_TREE
			l_list_item: EV_TREE_ITEM
		do
				-- Standard Creation
			create l_item

				-- Needed Enhancements
			l_item.set_minimum_size (100, 100)

				-- Other Enhancements
			create l_list_item.make_with_text ("Top Node")
			l_list_item.extend (create {EV_TREE_ITEM}.make_with_text ("Child 1"))
			l_list_item.extend (create {EV_TREE_ITEM}.make_with_text ("Child 2"))
			add_item_clicked_me_dialog (l_list_item)
			l_item.extend (l_list_item)

			create l_list_item.make_with_text ("Next Node")
			l_list_item.extend (create {EV_TREE_ITEM}.make_with_text ("More 1"))
			l_list_item.extend (create {EV_TREE_ITEM}.make_with_text ("More 2"))
			l_item.extend (l_list_item)

				-- Setup and Demo
			show_me := False
			demonstrate_widget (l_item)
		end

end
