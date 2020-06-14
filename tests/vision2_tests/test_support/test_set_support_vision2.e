note
	description: "A Test Support for Vision2 Demonstrations"

class
	TEST_SET_SUPPORT_VISION2

inherit
	TEST_SET_SUPPORT

feature -- Basic Operations

	demonstrate_widget (a_widget: EV_PRIMITIVE)
			-- Demonstration of `a_widget' in a window.
		local
			l_app: EV_APPLICATION
			l_window: ET_TS_WINDOW
		do
			if show_me then
				l_window := demo_window (a_widget)

				application.post_launch_actions.extend (agent l_window.show)
				l_window.close_request_actions.extend (agent l_window.destroy_and_exit_if_last)
				l_window.close_request_actions.extend (agent application.destroy)
				l_window.show -- Added this "show" call, otherwise window does not show.

				application.launch
			end
		end

feature -- Status Report

	show_me: BOOLEAN
			-- Change me to True to see widget demo!
			-- Determines if `demonstrate_widget'
			--	shows `demo_window' in `application'.

feature -- Access

	demo_window (a_primitive: EV_PRIMITIVE): ET_TS_WINDOW
			-- A window for demonstration of widgets.
		local
			l_box: EV_VERTICAL_BOX
		do
			create Result.make_with_title ("Demonstration: " + a_primitive.generating_type)
			create l_box
			l_box.extend (a_primitive)
			l_box.disable_item_expand (a_primitive)
			l_box.set_border_width (3)
			l_box.set_padding (3)
			Result.extend (l_box)
			Result.set_size (400, 400)
		end

	application: EV_APPLICATION
		once ("OBJECT")
			create Result
		end

feature -- GUI Components

	add_clicked_me_dialog (a_primitive: EV_PRIMITIVE)
			-- What to show when a widget is clicked.
		do
			a_primitive.pointer_button_press_actions.extend (agent on_click)
		end

	on_click (i1, i2, i3: INTEGER_32; r1, r2, r3: REAL_64; i4, i5: INTEGER_32)
			-- What happens `on_click' (e.g. pointer_button_press_actions)?
		local
			l_dialog: EV_INFORMATION_DIALOG
		do
			create l_dialog.make_with_text ("Clicked!")
			l_dialog.show
		end

end
