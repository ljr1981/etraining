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
				James Bond (007) had his now infamous Car that was also
				a Submarine. We want to "model" one of those with regard
				to what is driving the vehicle--the wheels or the props.
				
				To get there from here, we need a couple lines of "inheritance".
				First, we need two types of VEHICLE--CAR and SUBMARINE. Each
				one needs a motor and something which "drives" it (makes it
				move on land or in or under water).
				
				Once we have our CAR and SUBMARINE, we want to combine them
				into a CAR_SUB. Like the CAR and the SUB, our new thing will
				have both a motor, but it will now have two forms of "drive".
				
				We need to be able to switch between the wheels and the props
				depending on whether we are on land or on or under the water.
				]"
		local
			l_vehicle: ET_VEHICLE
			l_car: ET_CAR
			l_sub: ET_SUBMARINE
			l_james_bond_car: ET_CAR_SUB
		do
			create l_james_bond_car

				-- Our car is BOTH a car and a submarine, right?
			assert ("is_a_car", attached {ET_CAR} l_james_bond_car)
			assert ("but_also_a_sub", attached {ET_SUBMARINE} l_james_bond_car)

				-- When we first make a new Car, it's not driving at all.
			assert_void ("not_driving", l_james_bond_car.drive)

				-- Next, we engage as a car and expect our wheels are driving, yes?
				--	(and our props are not)
			l_james_bond_car.engage_as_car
			assert_attached ("driving_by_wheels", attached {ET_WHEEL} l_james_bond_car.drive)
			assert ("is_car", l_james_bond_car.is_operating_as_car)
			assert ("is_not_sub", not l_james_bond_car.is_operating_as_submarine)

				-- Next, we engage as a sub and expect our props are driving, yes?
				--	(and our wheels are not)
			l_james_bond_car.engage_as_submarine
			assert_attached ("driving_by_props", attached {ET_PROP} l_james_bond_car.drive)
			assert ("is_sub", l_james_bond_car.is_operating_as_submarine)
			assert ("is_not_car", not l_james_bond_car.is_operating_as_car)

				-- Make sure we can disengage the drive.
			l_james_bond_car.disengage_drive
			assert_void ("drive_disengaged", l_james_bond_car.drive)

		end

end


