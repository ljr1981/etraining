note
	description: "Documentation about Attributes."
	EIS: "name=ECMA-367_8_18_attributes", "protocol=pdf", "type=file",
			"nameddest=8.18 Attributes",
			"src=$GITHUB/etraining/ECMA-367.pdf"

class
	ET_DOCS_ABOUT_ATTRIBUTES

feature -- Docs

	self_initializing_attributes
		note
			example: "{ET_807_C}.s as Client and {ET_807_S} as Supplier"
			explanation: "[
				By using the "attribute" keyword here, we make this
				a `self-initializing attribute'--that is--we do not
				need to explicitly create `s' (this feature) in a
				creation procedure for the Class. Thus, if `s' is
				accessed for any reason before it is explicity
				created, the code (below) will handle the one-time
				creation of `s' just before the access is allowed.
				]"
			lazy_creation: "[
				One can think of this as a "lazy-creation" or
				"postponed-creation-until-needed". It has a number
				of advantages, but also disadvantages as well.
				]"
			advantages: "[
				The chief advantage is not requiring an explicit
				creation procedure for the Class. 
				]"
			disadvantages: "[
				A disadvantage might be that the lazy-creation 
				(below) does not meet the needs of the accessing Client. 
				Consider, there might be several creation procedures for `s'.
				Does the accessing Client of `s' care how `s' is created?
				]"
		do do_nothing end

end
