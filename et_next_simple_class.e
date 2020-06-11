class
	ET_NEXT_SIMPLE_CLASS

inherit
	ET_SIMPLEST_CLASS_EVER

feature -- Access (e.g. Data or Attributes)

	example_character: CHARACTER
			-- An attribute that holds 1 {CHARACTER} of data.
			-- Example: 'A' or 'B' are examples of single {CHARACTER}.

	example_string: detachable STRING
			-- An attribute that holds zero, one, or more {CHARACTER}s.
			-- The `detachable' keyword means this attribute may not
			-- reference an actual "Object" of type {STRING} when this
			-- class is created (we call this a Void target or Null-reference).

	example_integer: INTEGER
			-- An attribute defaulting to 0, but capable of being set to
			-- numbers between 	Min_value: INTEGER_32 = -2147483648 and
			-- a Max_value: INTEGER_32 = 2147483647

	example_natural: NATURAL
			-- An attribute defaulting to 0, but capable of being set to
			-- numbers between Min_value: NATURAL_32 = 0 and
			-- a Max_value: NATURAL_32 = 4294967295

	example_real: REAL
			-- An attribute defaulting to 0, but capable of being set to
			-- numbers between 	Min_value: REAL_32 = -3.4028234663852885981170e+038 and
			-- a Max_value: REAL_32 = 3.4028234663852885981170e+038

	example_double: DOUBLE
			-- An attribute defaulting to 0.0, but capable of being set to
			-- numbers between Min_value: REAL_64 = -1.7976931348623157081452e+308 and
			-- a Max_value: REAL_64 = 1.7976931348623157081452e+308

end
