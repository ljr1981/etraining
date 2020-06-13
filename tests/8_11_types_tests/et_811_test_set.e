note
	description: "Types Tests"
	testing: "type/manual"

class
	ET_811_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	type_anchoring_tests
			-- Type anchoring tests
		local
			l_item: ET_APPLIED_ANCHOR
		do
			create l_item.make
			assert_strings_equal ("empty", "", l_item.a)
			assert_strings_equal ("not_empty", "NOT EMPTY", l_item.b)
			assert_integers_equal ("zero", 0, l_item.c)
		end

end


