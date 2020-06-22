note
	description: "Tests related to the Masking Library"
	testing: "type/manual"

class
	MASKING_TEST_SET

inherit
	TEST_SET_SUPPORT_VISION2

feature -- Testing

	masking_tests
			-- Demonstration of how to get preferences setup
		note
			testing:  "execution/isolated", "execution/serial"
			EIS: "src=$GITHUB\etraining\tests\masking_tests\screen_shot.PNG"
		local
			l_box: EV_VERTICAL_BOX

				-- data-type specific fields
			l_masked_date: MASKED_DATE_TIME_FIELD
			l_masked_integer: MASKED_INTEGER_FIELD
			l_masked_decimal: MASKED_DECIMAL_FIELD
			l_masked_money: MASKED_CURRENCY_FIELD
			l_masked_percent: MASKED_PERCENT_FIELD

				-- variations on MASKED_STRING_FIELD
			l_masked_ssan: MASKED_STRING_FIELD
			l_masked_digits_only_with_spaces: MASKED_STRING_FIELD
			l_masked_digits_only: MASKED_STRING_FIELD
			l_masked_alpha_only: MASKED_STRING_FIELD
			l_masked_upper_alpha_only: MASKED_STRING_FIELD
			l_masked_letters_and_digits_only: MASKED_STRING_FIELD
			l_masked_forced_upper_alpha_only: MASKED_STRING_FIELD
			l_masked_forced_lower_alpha_only: MASKED_STRING_FIELD
		do
			create l_box

				-- Standard Creation

				-- Data field
			create l_masked_date.make_with_caption ("Date: ", create {DATE_TIME}.make_now)
			l_box.extend (l_masked_date.box)

				-- Integer field
			create l_masked_integer.make_with_caption ("Some integer: ", 365)
			l_box.extend (l_masked_integer.box)

				-- Decimal field
			create l_masked_decimal.make_with_caption_and_precision ("Some decimal: ", create {DECIMAL}.make_from_string ("3.14"), 2, 8)
			l_box.extend (l_masked_decimal.box)

				-- Money or currency field
			create l_masked_money.make_with_caption_and_precision ("Some money: ", create {DECIMAL}.make_from_string ("19.99"), 2, 13)
			l_box.extend (l_masked_money.box)

				-- Percent field
			create l_masked_percent.make_with_caption_and_precision ("Some percent: ", create {DECIMAL}.make_from_string ("99.999"), 3, 6)
			l_box.extend (l_masked_percent.box)

				-- SSAN field
			create l_masked_ssan.make_with_caption_and_pattern ("Some SSAN: ", "999-99-9999", "")
			l_box.extend (l_masked_ssan.box)

				-- digits_only_with_spaces
			create l_masked_digits_only_with_spaces.make_with_caption_and_repeating_pattern ("Digits only with spaces: ", '#', "only THE digits and spaces will appear 0123456789")
			l_box.extend (l_masked_digits_only_with_spaces.box)

				-- digits only
			create l_masked_digits_only.make_with_caption_and_repeating_pattern ("Digits only: ", '9', "111 ONLY the digits 0123456789 will appear! 777 All else is converted to zero 999")
			l_box.extend (l_masked_digits_only.box)

				-- alpha only
			create l_masked_alpha_only.make_with_caption_and_repeating_pattern ("Alpha only (others converted to spaces): ", 'A', "alpha only and UPPER TOO but not 0123456789")
			l_box.extend (l_masked_alpha_only.box)

				-- upper alpha only
			create l_masked_upper_alpha_only.make_with_caption_and_repeating_pattern ("Upper Alpha only: ", 'K', "upper alpha only but 0123456789 are digits and have no upper version")
			l_box.extend (l_masked_upper_alpha_only.box)

				-- letters and digits only
			create l_masked_letters_and_digits_only.make_with_caption_and_repeating_pattern ("Letters and digits only: ", 'N', "letters and digits only but not !@#$%%^&*() as they are converted to spaces in the GUI")
			l_box.extend (l_masked_letters_and_digits_only.box)

				-- forced upper alpha only
				-- Notice how this gets forced to UPPER case on the text field in the GUI.
			create l_masked_forced_upper_alpha_only.make_with_caption_and_repeating_pattern ("Forced upper Alpha only: ", 'U', "forced upper alpha only")
			l_box.extend (l_masked_forced_upper_alpha_only.box)

				-- forced lower alpha only
				-- Notice how this gets forced to lower case on the text field in the GUI.
			create l_masked_forced_lower_alpha_only.make_with_caption_and_repeating_pattern ("Forced lower Alpha only: ", 'W', "FORCED LOWER ALPHA ONLY")
			l_box.extend (l_masked_forced_lower_alpha_only.box)

				-- Setup and Demo
			show_me := False
			demonstrate_widget (l_box)
		end

end
