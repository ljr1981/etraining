note
	description: "Inheritance Tests"
	testing: "type/manual"

class
	ET_806_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	james_bond_test
			-- Test the {ET_CAR_SUB}
		local
			l_james_bond_car: ET_CAR_SUB
		do
			create l_james_bond_car
			l_james_bond_car.engage_as_car
			l_james_bond_car.engage_as_submarine
		end

end


