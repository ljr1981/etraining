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
			Result := attached {like wheels} drive
		end

	is_operating_as_submarine: BOOLEAN
			-- Is current a Submarine?
		do
			Result := attached {like props} drive
		end

feature -- Basic Operations

	engage_as_car
			-- Engage Current as a car driving by its `wheels'.
		do
			check has_wheels: attached {ET_DRIVE} wheels as al_mechanism then
				set_drive (al_mechanism)
			end
		end

	engage_as_submarine
			-- Engage Current as a car driving by its `props'.
		do
			check has_wheels: attached {ET_DRIVE} props as al_mechanism then
				set_drive (al_mechanism)
			end
		end

end
