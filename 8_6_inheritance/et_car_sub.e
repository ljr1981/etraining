note
	description: "Notion of a CAR that is also a SUBMARINE"

class
	ET_CAR_SUB

inherit
	ET_CAR

	ET_SUBMARINE

feature -- Access

	wheels: ET_WHEEL

	props: ET_PROP

feature -- Status Report

	is_operating_as_car: BOOLEAN
			-- Is current a Car?
		do
			Result := attached {like wheels} drive as al_drive and then al_drive.is_engaged
		end

	is_operating_as_submarine: BOOLEAN
			-- Is current a Submarine?
		do
			Result := attached {like props} drive as al_drive and then al_drive.is_engaged
		end

feature -- Basic Operations

	disengage_drive
			-- Disengage the `motor' from the `drive'
		do
			drive := Void
		ensure
			not is_operating_as_car and not is_operating_as_submarine
		end

	engage_as_car
			-- Engage Current as a car driving by its `wheels'.
		do
			check has_wheels: attached {ET_DRIVE} wheels as al_mechanism then
				set_drive (al_mechanism)
				al_mechanism.engage (motor)
			end
		ensure
			is_operating_as_car and not is_operating_as_submarine
		end

	engage_as_submarine
			-- Engage Current as a car driving by its `props'.
		do
			check has_wheels: attached {ET_DRIVE} props as al_mechanism then
				set_drive (al_mechanism)
				al_mechanism.engage (motor)
			end
		ensure
			is_operating_as_submarine and not is_operating_as_car
		end

invariant
	car: is_operating_as_car implies not is_operating_as_submarine
	sub: is_operating_as_submarine implies not is_operating_as_car
	engaged: (is_operating_as_car xor is_operating_as_submarine) implies
				attached drive as al_drive and then al_drive.is_engaged
	not_engaged: not (is_operating_as_car xor is_operating_as_submarine) implies
				not attached drive

end
