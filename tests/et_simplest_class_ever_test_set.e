note
	description: "[
		Tests related to {ET_SIMPLEST_CLASS_EVER}
	]"
	testing: "type/manual"

class
	ET_SIMPLEST_CLASS_EVER_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	simple_class_test
			-- Testing of {ET_SIMPLEST_CLASS_EVER}.
		note
			thoughts: "[
				The class has no attributes or computing features, so there is
				really nothing to test except creating one.
				]"
		do
			assert_32 ("successful_creation", attached (create {ET_SIMPLEST_CLASS_EVER}))
		end

end


