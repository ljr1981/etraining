note
	description: "Abstract notion of a VEHICLE"

deferred class
	ET_VEHICLE

feature -- Access

	motor: ET_MOTOR

	drive: detachable ET_DRIVE

feature -- Settings

	set_drive (a_drive: ET_DRIVE)
			--
		do
			drive := a_drive
			check attached drive as al_drive then al_drive.set_motor (motor) end
		end

end
