note
	description: "Notion of `Class S' or Supplier."
	EIS: "name=ECMA-367_8_7_clients_and_exports", "protocol=pdf", "type=file",
			"nameddest=8.7 Clients and Exports",
			"src=$GITHUB/etraining/ECMA-367.pdf"
	explanation: "[

		]"

class
	ET_807_S

feature -- Access

	a: ANY
			-- Anything at all
		note
			see: "{ET_DOCS_ABOUT_ATTRIBUTES}.self_initializing_attributes"
		attribute
			create Result
		end

feature -- Settings

	set_a (a_thing: like a)
			-- Set `a' to `a_thing'.
		do
			a := a_thing
		end

end
