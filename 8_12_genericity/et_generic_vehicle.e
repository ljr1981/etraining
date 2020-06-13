note
	description: "Abstract notion of a Generically Specified VEHICLE."

deferred class
	ET_GENERIC_VEHICLE [D -> ET_DRIVE]

feature -- Access

	motor: ET_MOTOR
			-- Motor of Current.

	drive: detachable D
			-- Drive of Current.

feature -- Settings

	set_drive (a_drive: D)
			--
		do
			drive := a_drive
			check attached drive as al_drive then al_drive.set_motor (motor) end
		end

end
