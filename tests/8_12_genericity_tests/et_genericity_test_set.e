note
	description: "Test of Genericity"
	testing: "type/manual"

class
	ET_GENERICITY_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	genericity_test
			-- New test routine
		local
			l_item: ET_GENERIC_CAR_SUB
		do
			create l_item
--			l_item.engage_as_car
--			l_item.disengage_drive
--			l_item.engage_as_sub
--			l_item.disengage_drive
		end

end


