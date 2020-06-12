note
	description: "Feature Categories"
	EIS: "name=8_5_3_Feature_categories_overview", "protocol=pdf", "type=file",
			"nameddest=8.5.3 Feature categories: overview",
			"src=$GITHUB/etraining/ECMA-367.pdf"

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

feature -- Routines: Procedures

	procedure_routine
			-- A routine that is a procedure (Command)
		do
			v := 10
		end

feature -- Routines: Functions

	funtion_routine: INTEGER
			-- A routine that computes an answer to a question.
		do
			Result := v * c
		end

end
