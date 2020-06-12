note
	description: "Testing Inheritance"
	testing: "type/manual"

class
	ET_INHERITANCE_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	inheritance_test
			-- New test routine
		note
			explanation: "[

				]"
		local
			l_vehicle: ET_VEHICLE
			l_car: ET_CAR
			l_boat: ET_BOAT
			l_sub: ET_SUBMARINE
			l_plane: ET_AIRPLANE
			l_james_bond_car: ET_CAR_SUB
		do
			create l_james_bond_car
			assert_void ("not_driving", l_james_bond_car.drive)

			l_james_bond_car.engage_as_car
			assert_attached ("driving_by_wheels", attached {ET_WHEEL} l_james_bond_car.drive)
			assert ("is_car", l_james_bond_car.is_operating_as_car)
			assert ("is_not_sub", not l_james_bond_car.is_operating_as_submarine)

			l_james_bond_car.engage_as_submarine
			assert_attached ("driving_by_props", attached {ET_PROP} l_james_bond_car.drive)
			assert ("is_sub", l_james_bond_car.is_operating_as_submarine)
			assert ("is_not_car", not l_james_bond_car.is_operating_as_car)
		end

end


