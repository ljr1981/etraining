note
	title: "A class with notes"
	bnfe: "[
			Class_declaration =Δ
				[Notes]
				Class_header
				[Formal_generics]
				[Obsolete]
				[Inheritance]
				[Creators]
				[Converters]
				[Features]
				[Invariant]
				[Notes]
				end
		]"
	explanation: "[
		Classes can have [Notes].
		
		In this class, the "title", "bnfe", and "explanation" are [Notes].
		
		Notes are here to both explain and reference (external or internal).
		You may have seen an external (EIS or Eiffel Information System) note
		already, but in case you have not, see the EIS-link below.
		]"
	EIS: "name=ECMA-367", "protocol=pdf", "type=file",
			"nameddest=8.4 Classes",
			"src=$GITHUB/etraining/ECMA-367.pdf"

class
	ET_CLASS_WITH_NOTES

inherit
	ET_BASE_CLASS

note
	what_is_BNFE: "[
		BNFE stands for Backus-Naur Form (Extended or Enhanced). It is a
		form of "notation" used to demonstrate how one things consists of
		other things. In the note at the top of this class, the BNFE is 
		telling us that Class (declaration) CONSISTS OF (i.e. =Δ) the 
		list of other things (below it). Items in [square_brackets] are
		"optional" (i.e. they are not required). Anything not in square
		brackets is required and must be there.
		
		Therefore, for a Class_declaration, we must have a Class_header
		and the "end" keyword. You can see this demonstrated in {ET_BASE_CLASS}
		]"

end
