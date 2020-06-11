note
	description: "Tests of {ETRAINING}."
	testing: "type/manual"

class
	ETRAINING_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	et_tests
			-- Here are a couple of example tests.
			-- Hopefully, these are self-evident.
		do
			assert_strings_equal ("this_equals_itself", "this", "this")
			assert_strings_not_equal ("this_is_not_that", "this", "that")
		end

	et_simplest_class_ever_tests
			-- Testing of {ET_SIMPLEST_CLASS_EVER}.
		note
			thoughts: "[
				The class has no attributes or computing features, so there is
				really nothing to test except creating one.
				]"
		do
			assert_32 ("successful_creation", attached (create {ET_SIMPLEST_CLASS_EVER}))
		end

	et_next_simple_class_tests
			-- Testing of {ET_NEXT_SIMPLE_CLASS}.
		note
			tests_explained: "[
				Test#	Explanation
				------- --------------------------------------------------------------
				t1		Test that the default of `example_character' is Character 0 or '%U' (i.e. undefined or Null)
				t2		Test that a "detachable STRING" is in fact Null or Void as a reference (no object created)
				t3		Test that the default of `example_integer' is 0
				t4		Test that the default of `example_natural' is not {INTEGER} 0, but ...
				t5		Test that the default of `example_natural' is (in fact) 0 typed as {NATURAL_32}
				t6		Test that the default of `example_real' is not 0.0 (which could also be {DOUBLE} (i.e. {REAL_64}))
				t7		Test that the default of `example_real' is (in fact) 0.0 typed as {REAL_32}
				t8		Test that the default of `example_double' is 0.0 (does not need specific type definition)
				]"
		local
			l_object: ET_NEXT_SIMPLE_CLASS
		do
			create l_object

			assert_characters_equal ("t1_default_character", 		'%U', 			l_object.example_character)
			assert_equal 			("t2_void_target", 				Void, 			l_object.example_string)
			assert_integers_equal 	("t3_example_integer", 			0, 				l_object.example_integer)
			assert_not_equal 		("t4_example_natural", 			0, 				l_object.example_natural)
			assert_equal 			("t5_example_natural_typed", 	{NATURAL_32} 0, l_object.example_natural)
			assert_not_equal 		("t6_example_real", 			0.0, 			l_object.example_real)
			assert_equal 			("t7_example_real_typed", 		{REAL_32} 0.0, 	l_object.example_real)
			assert_equal			("t8_example_double",			0.0,			l_object.example_double)
		end

end
