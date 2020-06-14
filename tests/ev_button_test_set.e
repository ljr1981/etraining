note
	description: "Demonstration of EV_BUTTON"
	testing: "type/manual"

class
	EV_BUTTON_TEST_SET

inherit
	TEST_SET_SUPPORT_VISION2

feature -- Test routines

	ev_button_tests
			-- New test routine
		note
			testing:  "covers/{EV_BUTTON}.make_with_text", "execution/isolated", "execution/serial"
		local
			l_item: EV_BUTTON
		do
			create l_item.make_with_text ("OK")
			add_clicked_me_dialog (l_item)
			show_me := False
			demonstrate_widget (l_item)
		end

end


