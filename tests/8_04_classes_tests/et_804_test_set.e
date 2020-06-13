note
	description: "[
		Tests related to {ET_CLASS}
	]"
	testing: "type/manual"

class
	ET_804_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test Class

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

feature -- Test Notes

	notes_test
			-- Test creation
		do
			assert_attached ("creation", create {ET_CLASS_WITH_NOTES})
		end

end


