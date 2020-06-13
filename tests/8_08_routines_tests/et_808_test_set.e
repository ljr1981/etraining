note
	testing: "type/manual"

class
	ET_808_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	more_tests
			-- Let's test {ET_CLASS_WITH_ROUTINES}
		note
			explanation: "[
				Our goal here is to see that Commands compute
				changes to data, whereas Queries change nothing
				and only answer questions about the "state"
				(i.e. values of our data) of our object.
				]"
		local
			l_item: ET_CLASS_WITH_ROUTINES
		do
			create l_item													-- Creation: 	Everything = 0
			assert_integers_equal ("more_default_v1", 0, l_item.more)		-- Query: 		Yes? Right!
			l_item.set_em_up_joe											-- Command:		Sets values a,b,c
			assert_integers_equal ("more_default_v2", 0, l_item.more)		-- Query: 		But "more" was not affected.
			l_item.more_stuff (0)											-- Command: 	Using a,b,c lets change m,o,r,e
			assert_integers_equal ("more_0", 17, l_item.more)				-- Query: 		What's `more' now?
			l_item.set_em_up_joe											-- Command: 	Reset a,b,c but not m,o,r,e
			assert_integers_equal ("more_default_v3", 17, l_item.more)		-- Query: 		Did `more' change? No? Right!
			l_item.more_stuff (1)											-- Command: 	Let's do `more' ...
			assert_integers_equal ("more_1", 24, l_item.more)				-- Query: 		What's `more' now?
			l_item.set_em_up_joe											-- Command: 	You are getting that this does nothing `more', right?
			assert_integers_equal ("more_default_v4", 24, l_item.more)		-- Query: 		What's `more' now? Still the same!

				-- Finally, let's ask: ...
			assert_equal ("whats_more", [3, 4, 10, 7], l_item.whats_more)
		end

end


