note
	description: "Notion of Anchored Types"
	explanation: "[
		In the code below, both `a' and `b' are "type anchored"
		to `my_string_anchor'.
		
		The `my_string_anchor' feature is detachable because we
		have no intention of actually having an object there
		and using it. The feature is only here to serve as an
		anchor. That does not mean that anchors are always 
		"for-reference-only". There are plenty of times that
		we anchor to useful features as well.
		
		Q: Why use anchors at all?
		
		A: Because they allow us to change the type of
			many features by changing the type of just
			the anchor feature. We might change our
			anchor through inheritance or Genericity.
			
		The `c' feature is anchored to `generic_anchor',
		which then varies depending on the G -> ANY. So,
		it could be ANYthing at all in descendant classes.
		]"
	EIS: "name=8_11_types", "protocol=pdf", "type=file", "nameddest=8.11 Types",
			"src=$GITHUB/etraining/ECMA-367.pdf"

deferred class
	ET_TYPES_ANCHOR [G -> ANY]

feature -- Access

	a: attached like my_string_anchor
			-- Example of type anchored attribute.

	b: attached like my_string_anchor
			-- Another example.

	c: attached like generic_anchor
			-- A generic anchor.

feature {NONE} -- Implementation: Anchors

	my_string_anchor: detachable STRING
			-- A type anchor.

	generic_anchor: detachable G
			-- A type anchors based on a Generic Parameter.

end
