note
	description: "Notion of `Class C' or Client."
	EIS: "name=ECMA-367_8_7_clients_and_exports", "protocol=pdf", "type=file",
			"nameddest=8.7 Clients and Exports",
			"src=$GITHUB/etraining/ECMA-367.pdf"

	explanation: "[
		Along with inheritance, the client relation is one of 
		the basic mechanisms for structuring software.

		In broad terms, a class C is a client of a type S — which 
		is then a supplier of C — when it can manipulate objects 
		of type S and apply S’s features to them.

		The simplest and most common way is for C to contain
		the declaration of an entity of type S, which is precisely
		what this class has (see `s' below)
		]"

class
	ET_807_C

feature -- Supplier

	call_my_supplier (a_thing: ANY)
			--
		do
			s.set_a (a_thing)
		end

feature -- Supplier

	s: ET_807_S
			-- A supplier `s' making C a "simple client".
		note
			see: "{ET_DOCS_ABOUT_ATTRIBUTES}.self_initializing_attributes"
		attribute
			create Result
		end

end
