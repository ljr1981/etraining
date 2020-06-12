note
	description: "[
		Demonstration of AutoTest Assertions using {TEST_SET_SUPPORT}
	]"
	testing: "type/manual"

class
	ETRAINING_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	assertion_examples
			-- Here are a few example tests.
			-- Hopefully, these are self-evident.
		local
			l_what_was_expected,
			l_what_was_actually_produced: STRING
		do
			assert_strings_equal ("this_equals_itself", "this", "this")
			assert_strings_not_equal ("this_is_not_that", "this", "that")

			l_what_was_expected := "BLAH"
			l_what_was_actually_produced := "BLAH2"
			assert_strings_not_equal ("blah_not_blah2", l_what_was_expected, l_what_was_actually_produced)
		end

	test_assert
			-- How to use the `assert' test.
		do
			assert ("assert", True)
		end

	test_assert_32
			-- How to use the `assert_32' test.
			-- NOTE: I do not understand how this differs from `assert'.
		do
			assert_32 ("assert_32", True)
		end

	test_assert_arrays_equal
			-- How to use the `assert_arrays_equal' test.
			-- Check that `expected` and `actual` have the same items
			-- in the same order (use equal for item comparison).
		local
			l_expected,
			l_actual: ARRAY [INTEGER]
		do
			assert_arrays_equal ("assert_arrays_equal", <<>>, <<>>)
			l_expected := <<1, 2, 3>>
			l_actual := <<1, 2, 3>>
			assert_arrays_equal ("assert_arrays_equal_2", l_expected, l_actual)
		end

	test_assert_arrays_reference_equal
			-- how to use the `assert_arrays_reference_equal' test.
			-- Check that `expected` and `actual` have the same items
			-- in the same order (use '=' for item comparison).
		local
			l_expected,
			l_actual: ARRAY [INTEGER]
		do
			l_expected := <<1, 2, 3>>
			l_actual := l_expected
			assert_arrays_reference_equal ("assert_arrays_reference_equal", l_expected, l_actual)
			assert ("this_is_the_same_as", l_expected = l_actual) -- because they both point to (reference) the same Object.
		end

end
