note
	EIS: "name=OOSC2", "protocol=pdf", "type=file", "namedest=8.7 COMPOSITE OBJECTS AND EXPANDED TYPES",
			"src=$GITHUB/etraining/OOSC2.pdf"
	EIS: "name=ECMA-367_8.30_basic_data_types", "protocol=pdf", "type=file", "nameddest=8.30 Basic Types",
			"src=$GITHUB/etraining/ECMA-367.pdf"

	basic_data_types: "[
		The term “basic type” covers a number of expanded class types 
		describing elementary values: booleans, characters, integers, 
		reals, machine-level addresses. The corresponding classes — 
		BOOLEAN; CHARACTER, INTEGER, REAL and variants specifying explicit 
		sizes; POINTER —are part of ELKS, the Eiffel Library Kernel Standard.
		]"

class
	ET_NEXT_SIMPLE_CLASS

inherit
	ET_SIMPLEST_CLASS_EVER

feature -- Access (e.g. Basic Data Types as Attributes)

	example_boolean: BOOLEAN
			-- An attribute that holds a value of True or False.

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

;note
	glossary: "A glossary of interesting terms"

	expanded_type: "[
		Not a reference to an object, but the object itself. 
		Example: 100 vs ref to {INTEGER} having a value of 100
		See: reference_type or OOSC-2, 8.7 COMPOSITE OBJECTS AND EXPANDED TYPES
		]"

	reference_type: "[
		A name with a {POINTER} to an object, but not the object itself.
		Example: my_value: INTEGER is a reference to an object with a value.
		See: expanded_type
		]"

end
