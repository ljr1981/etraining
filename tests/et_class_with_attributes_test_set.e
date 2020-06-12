note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	testing: "type/manual"

class
	ET_CLASS_WITH_ATTRIBUTES_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	basic_types_test
			-- Testing of {ET_CLASS_WITH_ATTRIBUTES}.
		note
			tests_explained: "[
				Test#	Explanation
				------- --------------------------------------------------------------
				t0		Test that the default of `example_boolean' is False
				t1		Test that the default of `example_character' is Character 0 or '%U' (i.e. undefined or Null)
				t2		Test that a "detachable STRING" is in fact Null or Void as a reference (no object created)
				t3		Test that the default of `example_integer' is 0
				t4		Test that the default of `example_natural' is not {INTEGER} 0, but ...
				t5		Test that the default of `example_natural' is (in fact) 0 typed as {NATURAL_32}
				t6		Test that the default of `example_real' is not 0.0 (which could also be {DOUBLE} (i.e. {REAL_64}))
				t7		Test that the default of `example_real' is (in fact) 0.0 typed as {REAL_32}
				t8		Test that the default of `example_double' is 0.0 (does not need specific type definition)
				]"
			EIS: "name=ECMA-367_8.30_basic_data_types", "protocol=pdf", "type=file",
					"nameddest=8.32.23 Special characters and their codes",
					"src=$GITHUB/etraining/ECMA-367.pdf"
		local
			l_object: ET_CLASS_WITH_ATTRIBUTES
		do
			create l_object

			assert_booleans_equal	("t0_default_boolean",			False,			l_object.example_boolean)
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


