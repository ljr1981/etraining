note
	description: "Test Client-Supplier"
	testing: "type/manual"
	EIS: "name=ECMA-367_8_7_clients_and_exports", "protocol=pdf", "type=file",
			"nameddest=8.7 Clients and Exports",
			"src=$GITHUB/etraining/ECMA-367.pdf"
	explanation: "[

		]"

class
	ET_807_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	client_supplier_tests
			-- Demonstrate Client-Supplier relationship
		note
			explanation: "[
				
				]"

		local
			l_client: ET_807_C
		do
			create l_client
			l_client.call_my_supplier (1_000)
			if attached {INTEGER} l_client.s.a as al_value then
				assert_integers_equal ("batting_a_thousand", 1_000, al_value)
			end
		end

end


