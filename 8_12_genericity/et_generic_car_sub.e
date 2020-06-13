note
	description: "Notion of a Combined Car-Sub"

class
	ET_GENERIC_CAR_SUB

inherit
	ET_COMBO_VEHICLE [ET_GENERIC_CAR, ET_GENERIC_SUB]
		rename
			drive1 as wheels,
			drive2 as props,
			engage_as_v1 as engage_as_car,
			engage_as_v2 as engage_as_sub,
			is_operating_as_v1 as is_operating_as_car,
			is_operating_as_v2 as is_operating_as_sub
		end

feature {NONE} -- Initialization

	create_drives
			--<Precursor>
		do
			create wheels
			create props
		end

end
