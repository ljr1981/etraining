note
	description: "Feature Categories"
	EIS: "name=8_5_3_Feature_categories_overview", "protocol=pdf", "type=file",
			"nameddest=8.5.3 Feature categories: overview",
			"src=$GITHUB/etraining/ECMA-367.pdf"

	explanation: "[
		Features like `v', `c', `s', `procedure_routine', and `function_routine'
		are "grouped" together using the "feature" keyword. In the ECMA 8.5.2
		we find a specification for Feature_clause, which is a grouping of
		features.
		
		As you are looking at this class, take time to examine the Features tab
		(to the right) and notice how each instance of the "feature" keyword
		is represented as a Node in the "Features tree" on the tab. Moreover,
		notice how the "Header_comment" (the comment just to the right of the
		"feature" keyword) is used in the "Feature tree" as the "Node text" for
		each "Feature node".
		
		Also note the icon or symbol used for each node in the tree. It corresponds
		to the "export status" (e.g. ECMA 8.5.2) [Clients]. For example, in the
		case of "Routines: Procedures" and "Routines: Functions", the contained
		features in those groups (i.e. clauses) are visible/accessible (exported)
		to {NONE} (i.e. no other class can see them from the outside).
		
		In this example class, the Feature Groups (Clauses) have been written to
		denote each of the "Feature categories" per ECMA 8.5.3.
		]"

class
	ET_FEATURE_CATEGORIES

feature -- Variable Attributes

	v: INTEGER
			-- An attribute that can vary.

feature -- Constants Attributes

	c: INTEGER = 99
			-- An attribute that is a constant (unchanging reference)

	s: STRING = "some string of characters"
			-- An attribute that is a constant string (unchanging reference, but changable contents)
			-- That is, the object reference will not change, but the contents of the string can.

feature {NONE} -- Routines: Procedures

	procedure_routine
			-- A routine that is a procedure (Command)
		do
			v := 10
		end

feature {NONE} -- Routines: Functions

	funtion_routine: INTEGER
			-- A routine that computes an answer to a question.
		do
			Result := v * c
		end

end
