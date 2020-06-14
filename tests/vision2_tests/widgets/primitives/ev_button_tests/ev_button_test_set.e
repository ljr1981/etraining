note
	description: "Demonstration of EV_BUTTON"
	testing: "type/manual"

class
	EV_BUTTON_TEST_SET

inherit
	TEST_SET_SUPPORT_VISION2

feature -- Test routines

	ev_button_tests
			-- Demonstration of a basic EV_BUTTON
		note
			testing:  "covers/{EV_BUTTON}.make_with_text", "execution/isolated", "execution/serial"
			usage: "Set `show_me' to True, recompile, and run this test to interact with `l_item'."
		local
			l_item: EV_BUTTON
		do
			create l_item.make_with_text ("OK")
			add_clicked_me_dialog (l_item)
			show_me := False
			demonstrate_widget (l_item)
		end

	ev_button_enhanced_demonstration
			-- An enhanced demo of EV_BUTTON
		note
			testing:  "covers/{EV_BUTTON}.make_with_text", "execution/isolated", "execution/serial"
			usage: "Set `show_me' to True, recompile, and run this test to interact with `l_item'."
		local
			l_item: EV_BUTTON
		do
			create l_item.make_with_text ("OK")
				-- Enhancements
			l_item.set_tooltip ("What you get when you hover.")
			l_item.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (128, 128, 128))
			l_item.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 0, 0))
			l_item.set_minimum_size (100, 50)
			add_clicked_me_dialog (l_item)
			show_me := False
			demonstrate_widget (l_item)
		end

end


