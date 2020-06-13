note
	description: "Notion of a Combined VEHICLE"

deferred class
	ET_COMBO_VEHICLE [VA -> ET_GENERIC_VEHICLE [ET_DRIVE], VB -> ET_GENERIC_VEHICLE [ET_DRIVE]]

inherit
	ET_GENERIC_VEHICLE [ET_DRIVE]
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			--<Precursor>
		do
			Precursor
			create_drives
		end

	create_drives
			-- Create `drive1' and `drive2'
		deferred
		ensure
			set: attached drive1 and attached drive2
		end

feature -- Access

	drive1: like {VA}.drive

	drive2: like {VB}.drive

feature -- Status Report

	is_operating_as_v1: BOOLEAN
			-- Is current a {VA}?
		do
			Result := attached {like drive1} drive as al_drive and then al_drive.is_engaged
		end

	is_operating_as_v2: BOOLEAN
			-- Is current a {VB}?
		do
			Result := attached {like drive2} drive as al_drive and then al_drive.is_engaged
		end

feature -- Basic Operations

	disengage_drive
			-- Disengage the `motor' from the `drive'
		do
			drive := Void
		ensure
			not is_operating_as_v1 and not is_operating_as_v2
		end

	engage_as_v1
			-- Engage Current as a v1 driving by its `drive1'.
		do
			check has_d1: attached drive1 as al_mechanism then
				set_drive (al_mechanism)
				al_mechanism.engage (motor)
			end
		ensure
			is_operating_as_v1 and not is_operating_as_v2
		end

	engage_as_v2
			-- Engage Current as a v2 driving by its `drive2'.
		do
			check has_d2: attached drive2 as al_mechanism then
				set_drive (al_mechanism)
				al_mechanism.engage (motor)
			end
		ensure
			is_operating_as_v2 and not is_operating_as_v1
		end

invariant
	v1: is_operating_as_v1 implies not is_operating_as_v2
	v2: is_operating_as_v2 implies not is_operating_as_v1
	engaged: (is_operating_as_v1 xor is_operating_as_v2) implies
				attached drive as al_drive and then al_drive.is_engaged
	not_engaged: not (is_operating_as_v1 xor is_operating_as_v2) implies
				not attached drive

end
