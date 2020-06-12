note
	testing: "type/manual"

class
	ET_CLASS_WITH_NOTES_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	notes_test
			-- Test creation
		do
			assert_attached ("creation", create {ET_CLASS_WITH_NOTES})
		end

end


