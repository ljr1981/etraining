note
	description: "[
		Tests related to {ET_CLASS}
	]"
	testing: "type/manual"

class
	ET_BASE_CLASS_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	simple_class_test
			-- Testing of {ET_CLASS}.
		note
			thoughts: "[
				The class has no attributes or computing features, so there is
				really nothing to test except creating one.
				]"
		do
			assert_attached ("successful_create", create {ET_CLASS})
		end

end


