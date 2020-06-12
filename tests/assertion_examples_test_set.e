note
	description: "[
		Demonstration of AutoTest Assertions using {TEST_SET_SUPPORT}
	]"
	testing: "type/manual"

	ca_ignore_what_is_that_about: "[
		The `ca_ignore' note clauses (below) are here to prevent the
		Eiffel Code Analyzer from complaining about various things.
		]"

		-- that is ... stop complaining about ...
	ca_ignore: "CA093" -- Manifest array type differs from target array type.
	ca_ignore: "CA085" -- Unneeded helper variable

class
	ASSERTION_EXAMPLES_TEST_SET

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
		note
			analysis_warning: "[
				In this routine, the Code Analyzer will give us the following warning:
				
				CA093	Manifest array type differs from target array type.
				
						Manifest array of type ARRAY [NONE] is used in a reattachment 
							with target type ARRAY [detachable ANY]:
							
				What it really means is: We created a couple of empty "manifest arrays"
					(i.e. "<<>>") and the Eiffel Compiler cannot figure them out fully.
					It knows they are a manifest array because of the "<<>>", but an
					array of what? It has no clue, unless we provide one.
					
				The analyzer gives us three potential options for dealing with the matter:
							
					Option #1 - add an explicit manifest array type;
					Option #2 - change target type to make sure the types are the same;
					Option #3 - disable the rule "Manifest array type mismatch" in the code 
						analizer preferences or add the rule CA093 to the list of 
						ignored rules of the class.
						
				In our code (below), we have used option #2 on the second assertion call.
					In this case, instead of saying just "<<>>", we've provided an explicit
					type in the form of "{ARRAY [INTEGER]} <<>>". Now, the Eiffel Compiler
					no longer has to partially know, because we explicity tell it that
					our manifest array is an {ARRAY [INTEGER]} (array of integers).
					
				Providing the explicit type declaration on the manifest array satisfies the
				Code Analyzer. In this case, we want you to see the problem, so we've told
				the analyzer to ignore the error (e.g. "ca_ignore" note) and left the code
				to facilitate this explanation.

				]"
		local
			l_expected,
			l_actual: ARRAY [INTEGER]
		do
			assert_arrays_equal ("assert_arrays_equal_v1", <<>>, <<>>) -- See `analysis_warning' note (above)
			assert_arrays_equal ("assert_arrays_equal_v2", {ARRAY [INTEGER]} <<>>, {ARRAY [INTEGER]} <<>>)
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
			-- Or `assert_booleans_not_equal' (the notted version)
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

	test_assert_characters_equal_or_not
			-- How to use a `assert_characters_equal' test.
			-- or `assert_characters_not_equal' (the notted version)
		note
			explanation: "[
				When we say {CHARACTER}, we must be aware of what "set" we are
				referring to--there are many. Mostly, we are going to care about
				ASC-II (see EIS link below). This consists of a "set" of 256 Latin
				characters originally defined in 1967 as the American Standard Code 
				for Information Interchange (ASCII).
				
				The Eiffel compiler is coded to understand certain "escaped-characters"
				as being equal to various ASCII characters. For example the %U points
				to the 0-th character (NULL). Likewise, %N = Newline, %T = TAB and so on.
				
				See the EIS link below of the ECMA list of Special character and their codes.
				]"
			EIS: "name=ASCII", "src=https://en.wikipedia.org/wiki/ASCII"
			EIS: "name=ECMA-367_8.30_basic_data_types", "protocol=pdf", "type=file",
					"nameddest=8.32.23 Special characters and their codes",
					"src=$GITHUB/etraining/ECMA-367.pdf"
		do
			assert_characters_equal ("assert_characters_equal", '%U', '%U')
			assert_characters_not_equal ("assert_characters_not_equal", '%U', '%N')
		end

	test_assert_equal_or_not
			-- How to use a `assert_equal' test.
			-- Or `assert_not_equal' (the notted version)
		do
			assert_equal ("assert_equal", True, True)
			assert_not_equal ("assert_not_equal", True, False)
		end

	test_assert_equal_message_or_not
			-- How to use a `assert_equal_message' test.
			-- Or the `assert_not_equal_message' (the notted version)
		note
			use_case: "[
				We have a failing test and we want to grab its message and
				use it somehow. To do this, we use the `assert_equal_message'.
				It turns out that this is really just a call to `assert_equal'
				and then grabbing the message of it when it fails, and returning
				whatever the message is that would normally appear in the 
				AutoTest results output pane (below in the EiffelStudio IDE 
				"AutoTest Results tab").
				]"
		local
			l_message: STRING_32
		do
			l_message := assert_equal_message ("assert_equal_message", Void, Void)
			assert_strings_equal ("what_is_the_message", void_message, l_message)

			l_message := assert_equal_message ("more_words_please", "BLAH", "BLAH2")
			assert_strings_equal ("more_words_are", more_words_message, l_message)

			l_message := assert_not_equal_message ("notted_version", void_message, more_words_message)
			assert_strings_equal ("void_not_blah", void_not_blah, l_message)
		end

	test_assert_integers_equal_or_not
			-- How to use a `assert_integers_equal' test.
			-- Or `assert_integers_not_equal' (the notted version).
		note
			explanation: "[
				This is also another great place to see the difference
				between reference and expanded types.
				]"
			FYI: "Did you know you can create your own expanded type classes?"
			EIS: "name=underused_expanded_types",
					"src=https://www.eiffel.org/node/391"
		local
			l_value: INTEGER
		do
			assert_integers_equal ("assert_integers_equal", 0, 0)
			assert_integers_equal ("ref_vs_expanded", 0, l_value) -- We can do this because `l_value' is expanded and defaulted to 0.
			l_value := 1
			assert_integers_not_equal ("and_not_equal_now", 0, l_value) -- Line above made them not-equal.
		end

	test_assert_old
			-- Apparently, you're not supposed to use this, but
			-- I don't get why. How is it old? What does "old"
			-- mean in this context? This is all very confusing! :-)
		do
			assert_old ("assert_old", True)
		end

	test_assert_predicate
			-- How to use a `assert_predicate' test.
			-- Check that `pred` evaluates to True.
		note
			prerequisite: "[
				You must have a basic understanding of agents
					before this will fully make sense to you!
				]"
			explanation: "[
				The {PREDICATE} class descends from {FUNCTION} from {ROUTINE}.
				A predicate is just a function that returns a {BOOLEAN} result.
				The predicate might take arguments, but in the example (below)
				we have no arguments. We simply use a {BOOLEAN} constant as
				our predicate.
				
				Once we have a {BOOLEAN} returning function, we can then create
				an "agent" out of it (ex: "l_pred := agent my_predicate"). With
				that, we can then call the `assert_predicate' routine, which
				expects a call on `l_pred' (e.g. l_pred.call) to evaluate to True.
				If so, then the test passes. If not, it fails.
				]"
			warning: "There is no `notted' version of this. Result must always be True."
		local
			l_pred: PREDICATE
		do
			l_pred := agent my_true_predicate
			assert_predicate ("assert_predicate", l_pred)
		end

	test_strings_and_things
			-- Various forms of {STRING} testing assertions!
		note
			explanation_for_diffs: "[
				Be aware that the `assert_strings_equal_diff' is coming from {TEST_SET_SUPPORT},
				which is NOT an Eiffel Software core testing class. It is one especially created
				by me for a purpose. The purpose was (and is) to not only see that strings are
				not equal, but WHERE they differentiate from each other! This is especially helpful
				in very long and complex strings.
				
				The call to `assert_strings_equal_diff' is used twice (below). In the second
				instance you will see how it helps if you change one of the "x" values in `l_message'.
				]"
		local
			l_message: STRING
		do
				-- If we are really just that insensitive, then "blah" and "BLAH" are the same!
			assert_strings_case_insensitive_equal ("case_insensitive", "blah", "BLAH")
				-- Otherwise, we care (STRING-SJW's UNITE!)
			assert_strings_equal ("we_now_care", "blah", "blah") -- using "BLAH" will FAIL! (let the protests begin!)

			assert_strings_equal_diff ("show_me_the_diffs", "blah", "blah") -- See "explanation_for_diffs" note (above)

			l_message := assert_strings_equal_message ("the_message", "x", "x")
			assert_strings_equal_diff ("strings_equal_message", strings_equal_message, l_message)

			assert_strings_not_equal ("notted_version", "blah", "BLAH") -- now we care, but in the notted version.
			l_message := assert_strings_not_equal_message ("notted_message", "", "")
				-- perhaps you get the idea already ...
			l_message.do_nothing 	-- Satisfies Code Analyzer warning:
									-- CA020 Local l_message is not read after assignment.

		end

	test_assert_void
			-- How to use a `assert_void' test.
		note
			explanation: "[
				Our final tour-de-force of assertion tests turns back to the notion
				of attachment and detachment in terms of references to objects.
				
				In this case, we want to test whether a reference is attached or not.
				There are several ways to to this (see below)
				
				A couple of alternatives are demonstrated as well. The second alternative
				is really convoluted (i.e. it does not "read well" at all)!
				]"
		local
			l_void_ref: detachable STRING
		do
			assert_void ("assert_void", Void)
			assert_void ("detached_reference", l_void_ref) -- the `l_void_ref' {STRING} will not be "attached" by default.

				-- We could also accomplish such a thing this way ...
			assert ("another_way", not attached l_void_ref) -- it's a little more verbose, but the idea is still clear.
				-- Yet another way (more convoluted) ...
			assert_equal ("detached", False, attached l_void_ref)

		end

feature {NONE} -- Test Support

	my_true_predicate: BOOLEAN = True
			-- The basis feature for creating an "agent" to
			-- give to a {PREDICATE} reference.

	void_message: STRING = "[
assert_equal_message
   expected: Void
   but  got: Void
]"

	more_words_message: STRING = "[
more_words_please
   expected: BLAH
   but  got: BLAH2
]"

	void_not_blah: STRING = "[
notted_version
   got actual value: more_words_please
   expected: BLAH
   but  got: BLAH2
   should not match: assert_equal_message
   expected: Void
   but  got: Void
]"

	strings_equal_message: STRING = "[
the_message
   expected: x
   but  got: x
]"

end
