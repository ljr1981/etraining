note
	description: "Abstract notion of a thing that DRIVEs a {ET_VEHICLE}"

deferred class
	ET_DRIVE

feature -- Access

	motor: detachable ET_MOTOR
			-- What motor drives?

feature -- Basic Operations

	engage (a_motor: attached like motor)
			-- `engage' using `a_motor'
		do
			motor := a_motor
		end

	disengage
			-- `disengage' `motor' as Void.
		local
			l_detached_motor: detachable ET_MOTOR
		do
			set_motor (l_detached_motor)
		end

feature -- Status Report

	is_engaged: BOOLEAN
			-- Is the `motor' engaged?
		do
			Result := attached motor
		end

feature -- Settings

	set_motor (a_motor: like motor)
			-- Set `motor' to `a_motor'
		do
			motor := a_motor
		end

end
