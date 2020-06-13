note
	description: "Notion of an Applied (Effected) Anchor"
	explanation: "[
		In the ancestor of this class, both `a' and `b' are anchored
		as a attached {STRING}. Because this is true, we must initialize
		these two features. One we will make_empty and the other we
		will provide a string "NOT EMPTY".
		
		In the case of our `c' {INTEGER} attribute, we allow it to
		be its expanded type default of zero (0).
		
		A later test {ET_811_TEST_SET} will show the outcome of the
		`make' (creation procedure) below.
		]"

class
	ET_APPLIED_ANCHOR

inherit
	ET_TYPES_ANCHOR [INTEGER]

create
	make

feature {NONE} -- Intialization

	make
			-- Initialize Current.
		do
			create a.make_empty
			create b.make_from_string ("NOT EMPTY")
		end

end
