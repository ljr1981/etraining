note
	description: "A class with routines"
	explanation: "[
		A routine is a feature of a class that has code to
		perform some computation or calculation.
		
		There are two basic types of routine:
		
		Command
		Query
		
		Commands operate on attributes (data) to make changes.
		This is where computation mainly happens.
		
		Queries (on the other hand) answer questions about the
		data, but they make NO CHANGES to it!
		
		Ensuring that only commands change data and queries change
		nothing, but answer questions about data is called: 
		"Command-Query Separation" (CQS for short).
		
		See the notes at the bottom of the class for more.
		]"

class
	ET_CLASS_WITH_ROUTINES

feature -- Routines: Commands

	set_em_up_joe
			-- Set our "Access" attributes to a starting point.
		do
			a := 1
			b := 2
			c := 3
		end

	more_stuff (a_new_stuff: INTEGER)
			-- Do "stuff" (computations) on `m', `o', `r', and `e'
		do
			m := a * b + a_new_stuff
			o := a + b + a_new_stuff
			r := m * c + a_new_stuff
			e := a + b + c + a_new_stuff
		end

feature -- Routines: Queries

	more: INTEGER
			-- What is `more'?
		do
			Result := m + o + r + e
		end

	still_more: TUPLE
			-- What are the `more' values?
		do
			Result := [m, o, r, e]
		end

feature -- Routines: Predicates

feature -- Access

	a: INTEGER
			-- A value to access.

	b: INTEGER
			-- A value to access.

	c: INTEGER
			-- A value to access.

	h,j,k: INTEGER
			-- We can also write it this way.

	m,
	o,
	r,
	e: INTEGER
			-- Or even this way.

;note
	further_study: "[
		You can see this breakdown of routines into commands and queries
		in the ELKS base library. Examine class {ROUTINE} and see that
		it descends into FUNCTION (query) and PROCEDURE (command).
		Further note that FUNCTION descends into PREDICATE, which is
		a special BOOLEAN-query--that is--its only answer is True or False
		(yes or no).
		]"

end
