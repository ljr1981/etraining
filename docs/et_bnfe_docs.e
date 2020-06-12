note
	description: "Documenation about Backus-Naur Form (Ext)"
	EIS: "name=BNFE", "src=https://en.wikipedia.org/wiki/Backus%%E2%%80%%93Naur_form"

	explanation: "[
		We use BNFE to formally describe context-free grammars. Now, if
		you do not know what a "context-free grammar" is, then you will
		want to explore that, but here is a simpler way to think about BNF.
		
		BNF (or BNFE) simply describes how complex things break down into
		simpler things (or components). You can think of the notation as
		saying, "What does this thing consist of?"
		
		Car ::=
			Body
			Motor
			Wheels
			Doors
			
		Motor ::=
			Block
			Tranny
			Radiator (and so on)
			
		Wheels ::=
			Rim
			Tire
			Lug_nuts
			
		Perhaps you're getting the idea!?
		
		If you're still pining-away for knowing about
		context-free grammars, then see the next EIS link.
		You can also find a nice Eiffel-ish based description
		in the ECMA-367 standard PDF.
		]"

	EIS: "name=context_free_grammar", "src=https://en.wikipedia.org/wiki/Context-free_grammar"
	EIS: "name=BNFE", "protocol=pdf", "type=file", "nameddest=8.2.1 Definition: Syntax, BNF-E",
			"src=$GITHUB/etraining/ECMA-367.pdf"

class
	ET_BNFE_DOCS

end
