note
	description: "Demonstration of {EV_CHECK_BUTTON}"
	testing: "type/manual"

class
	EV_CHECK_BUTTON_TEST_SET

inherit
	TEST_SET_SUPPORT_VISION2

feature -- Test routines

	ev_check_button_tests
			-- Demonstration of a basic EV_CHECK_BUTTON
		note
			testing:  "covers/{EV_CHECK_BUTTON}.make_with_text", "execution/isolated", "execution/serial"
			usage: "Set `show_me' to True, recompile, and run this test to interact with `l_item'."
		local
			l_item: EV_CHECK_BUTTON
		do
				-- Standard Creation
			create l_item.make_with_text ("Checkbox?")

				-- Setup and Demo
			show_me := False
			demonstrate_widget (l_item)
		end

end
