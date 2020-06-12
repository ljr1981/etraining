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
			-- How to use the `assert_arrays_reference_equal' test.
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

	test_assert_attached
			-- How to use the `assert_attached' test.
			-- Check that `object` is attached.
		note
			explanation: "[
				Attachment is how we describe a Reference having an "attached" (assigned)
				Pointer to an actual Object in memory.
				
				A "detached" Reference (or assignment) is:
				
				Reference --> Void ...
				
				An "attached" Reference (or assignment) is:
				
				Reference --> Pointer --> Object
				
				Where "Reference" is a key:value pair, where we know the "key" (reference name)
					and "value" is the "Pointer", which points to an Object in the memory of
					our system.
					
				Note then that a "detachable" Reference (e.g. like `l_object_reference' below)
					is one that can be either attached or detached and is detached by default.
					Declaring the reference as "detachable" means that Eiffel creates the Reference
					but does not expect an Object or a Pointer to it.
				]"
		local
			l_object_reference: detachable STRING
		do
				-- At this point, `l_object_reference' is a reference that is "not attached"
				-- That is--it does not have a pointer to an actual object in memory.
				-- We prove this with a simple test.
			assert ("not_attached", not attached l_object_reference)
				-- Now, we attach it (provide it an object and "assign" the reference to it).
			l_object_reference := "any_string_at_all"
			assert_attached ("assert_attached", l_object_reference)
		end

	test_assert_booleans_equal_or_not
			-- How to use a `assert_booleans_equal' test.
		note
			explanation: "[
				Not only will we see how to test {BOOLEAN} expanded types,
				but also reference types. We will also see how to test
				negation (not equal) as well.
				
				Your biggest take-away here is seeing how reference types
				and expanded types play together nicely, but YOU need to
				keep in your head that an expanded type is the thing itself
				(e.g. True or False - binary/int 1 or 0), while a reference
				has a pointer to the thing itself. The comparisons (tests)
				are ultimately reaching for the "thing itself" (expanded object)
				to base the test on.
				
				UNLESS you are wanting to test the references--that is--you
				want to see if two references point to the same thing.
				(look back up to the array reference test)
				]"
		local
			l_true,
			l_false,
			l_expected,
			l_actual: BOOLEAN
		do
			l_true := True -- We MUST do this because expanded type BOOLEAN defaults to False
			-- Thus, we do not need to assign (attach the reference) `l_false' to False.
			l_expected := l_true
			l_actual := True
			assert_booleans_equal ("assert_booleans_equal", l_expected, l_actual)
			assert_booleans_equal ("two_expandeds_are_equal", True, True)
			assert_booleans_equal ("the_same_is_true_here", False, False)
			assert_booleans_not_equal ("even_here", False, True)
			assert_booleans_equal ("compare_ref_to_expanded", l_true, True)
			assert_booleans_not_equal ("works_other_way_as_well", False, l_true)
		end

end
