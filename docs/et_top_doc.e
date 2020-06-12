note
	title: "Start of Self-documenting Documentation"
	description: "The code that documents its own documentation!"

class
	ET_TOP_DOC

feature

	begin_at_the_beginning: ET_BASE_CLASS
		note
			what_is_this: "[
				This is an example of the simplest class possible.
				
				It is empty except for the "class" keyword, class name, and "end" keyword.
				
				It has no data attributes.
				
				It has not computing features.
				
				What makes a class interesting is when we start adding features: Data or Computations.
				]"
		attribute
			create Result
		end

end
