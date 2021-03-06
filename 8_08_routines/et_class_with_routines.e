﻿note
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
	EIS: "name=8_8_routines", "protocol=pdf", "type=file", "nameddest=8.8 Routines",
			"src=$GITHUB/etraining/ECMA-367.pdf"

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

	whats_more: TUPLE
			-- What's more?
		note
			explanation: "[
				So—what's a {TUPLE} anyway?
				
				It's like you want a Date with Class, but all you get
				is a "cheap date" with a {TUPLE}! He doesn't do
				anything for you, but he does talk (provides data) a lot!
				
				TUPLES are a great way to gather data together without
				the need to compute anything (change the data).
				
				In the case below, we package up the values of `m', `o',
				`r', and `e' and put them in our Result {TUPLE}, which
				answers the question: `whats_more'?
				]"
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
