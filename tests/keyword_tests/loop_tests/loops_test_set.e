note
	description: "Tests related to the Loops (across and from)"
	testing: "type/manual"

class
	LOOPS_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- From Loops

	basic_from_loop_tests
			-- A `basic_from_loop'.
		note
			synopsis: "[
				Below is a loop that simply counts from 1 to 1,000
				]"
		local
			i: INTEGER
			l_names: ARRAYED_LIST [STRING]
			l_range: INTEGER_INTERVAL
		do
				-- First, simple from loop iterating over 1 .. 1_000
			from
				i := 1
			until
				i > 1_000
			loop
				print (i.out)
				i := i + 1
			end

				-- Next, make a list to iterate ...
			create l_names.make_from_array (<<"Fred", "Wilma", "Pebbles", "Barney", "Betty", "Bam-bam">>)
				-- The << .. >> is referred to as a "manifest array", which means
				-- the compiler sees the << as a signal telling it that an ARRAY is coming!
				-- The >> signals the end of the ARRAY. The ".." items in the list
				-- are a signal to the compiler that we have an ARRAY [STRING].
				-- An ARRAY [CHARACTER] is: <<'a', 'b', 'c'>>
				-- An ARRAY [INTEGER] is:	<<1, 2, 3, 4, 5>>
				-- An ARRAY [BOOLEAN] is: 	<<True, False, True, True>>
				-- An ARRAY [REAL] is: 		<<1.1, 2.7, 3.4, 5.1>>
				-- In all cases << signals ARRAY and the manifest type signals
				--	the [G] of ARRAY [G]

				-- Using a from-loop (like above) ...
			from
				l_names.start 	-- Puts the cursor index at the first item (if there is one)
			until
				l_names.off 	-- Iterate until the cursor index is after the last
								--	item (count + 1)
			loop
				print (l_names.item_for_iteration.out) -- The item we're on while iterating
				l_names.forth 	-- Move the cursor index to the next item in the list
								--	(or off, if we are at the end)
			end

				-- Next, a range might supply the upper and lower bounds
				--	(which is all we need)
			from
				l_range := 1 |..| 1_000
				i := l_range.lower
			until
				i > l_range.upper
			loop
				-- do some loop stuff ...
				i := i + 1
			end

			-- Yet ... the more interesting loops are the across variety of a loop!
			-- (NOTE: Eiffel really only has one loop structure, just variations)
		end

feature -- Across Loops

	iterate_over_an_arrayed_list_tests
			-- How to `iterate_over_an_arrayed_list'.
		note
			synpsis: "[
				An "across-loop" is something like a "for-each" in other languages.
				]"
		local
			l_names: ARRAYED_LIST [STRING]
			l_range: INTEGER_INTERVAL
		do
				-- First, make a list to iterate ...
			create l_names.make_from_array (<<"Fred", "Wilma", "Pebbles", "Barney", "Betty", "Bam-bam">>)
				-- The << .. >> is referred to as a "manifest array", which means
				-- the compiler sees the << as a signal telling it that an ARRAY is coming!
				-- The >> signals the end of the ARRAY. The ".." items in the list
				-- are a signal to the compiler that we have an ARRAY [STRING].
				-- An ARRAY [CHARACTER] is: <<'a', 'b', 'c'>>
				-- An ARRAY [INTEGER] is:	<<1, 2, 3, 4, 5>>
				-- An ARRAY [BOOLEAN] is: 	<<True, False, True, True>>
				-- An ARRAY [REAL] is: 		<<1.1, 2.7, 3.4, 5.1>>
				-- In all cases << signals ARRAY and the manifest type signals
				--	the [G] of ARRAY [G]

				-- Using a from-loop (like above) ...
			from
				l_names.start 	-- Puts the cursor index at the first item (if there is one)
			until
				l_names.off 	-- Iterate until the cursor index is after the last
								--	item (count + 1)
			loop
				print (l_names.item_for_iteration.out) -- The item we're on while iterating
				l_names.forth 	-- Move the cursor index to the next item in the list
								--	(or off if we are at the end)
			end

				-- Now lets go "across" the `l_names' list (i.e. iterate it) ...
			across
				l_names as ic_names
			loop
				print (ic_names.item)
			end

				-- We can go directly across manifest arrays too ...
			across
				<<"Fred", "Wilma", "Pebbles", "Barney", "Betty", "Bam-bam">> as ic
			loop
				print (ic.item + ",") -- Outputs each name in the list:
								-- "Fred,Wilma,Pebbles,Barney,Betty,Bam-bam"
			end

				-- or ...
			across
				<<0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100>> as ic
			loop
				print (ic.item.out + ",") -- Outputs: "0,10,20,30,40,50,60,70,80,90,100,"
			end

				-- We can also iterate over (i.e. "go across") integers as well ...
			across
				1 |..| 1_000 as ic
			loop
				print (ic.item.out + ",") -- Outputs: 1,2,3,4,5,6, .. 1000
			end

				-- We can do this with a class too ...
			l_range := 1 |..| 1_000			-- The "1 |..| 1_000" is a "Manifest {INTEGER_INTERVAL}"
			across l_range as ic loop 		-- Turns out, we can do this because {INTEGER_INTERVAL} inherits from {ITERABLE}
				print (ic.item.out + ",") 	-- Outputs: 1,2,3,4,5,6, .. 1000
			end
				-- NOTE: Why `ic'? What does that stand for?
				--			`ic' = {ITERATION_CURSOR}, which is what we get
				--				from something that is {ITERABLE}.
				--				`ic.item' is {ITERATION_CURSOR}.item --that is--the
				--				class has a feature called `item', which is what the
				--				"across loop" it iterating over and the `item' represents
				--				the item in the cursor where the cursor index
				--				is presently pointing.
		end

	bertrands_example_1_tests
		note
			EIS: "src=https://bertrandmeyer.com/2010/01/26/more-expressive-loops-for-eiffel/"
			synopsis: "[
				Dr. Bertrand Meyer provides a number of example uses of the across loop.
				The code (below) allows us to bring these examples in from the cold of
				just an internet page to something actually compiled and testable.
				]"
			warning: "[
				A number of coding conventions will NOT be held here (compare to {CODING_CONVENTIONS}).
				Why? The material presented (below) is taken from an academic setting. Many times,
				such examples are shortened for brevity so the point being taught is not lost in the
				details of best-practice conventions. Therefore, we see `s' as a STRING and `sum' as
				an INTEGER, but without the suggested `l_*' prefix. In short examples, this lack of
				convention will not be missed because the code is rather small and easily understood.
				
				Computes Σ i * s [i]
				]"
		do
			bertrand_example_prep_work

				-- Example 1
	        across
	        	s as c
	        from
	        	sum := 0
	        loop
	        	sum := sum + c.cursor_index * c.item.code
	        end -- NOTE: Slight changes from the article code
		end

	bertrand_example_2_tests
		note
			EIS: "src=https://bertrandmeyer.com/2010/01/26/more-expressive-loops-for-eiffel/"
			synopsis: "[
				Computes Σ a [i], for i ranging from m to n, for an array (or other structure) a.
				]"
		do
			bertrand_example_prep_work

				-- Example 2
			across
				m |..| n  as c
			from
				sum := 0
			loop
				sum := sum + a [c.item].code
			end -- NOTE: Slight changes from the article code
		end

	bertrand_example_3_tests
		note
			EIS: "src=https://bertrandmeyer.com/2010/01/26/more-expressive-loops-for-eiffel/"
			synopsis: "[
				Putting it in reverse
				
				to print elements in reverse order. (Using Eiffel’s operator
				mechanism, you may write – s.new_cursor, with a minus operator,
				as a synonym (alias) for new_cursor.reversed.) The `reversed' feature
				gives you a new cursor in reverse order, enabling you to iterate 
				backwards.
				]"
		do
			bertrand_example_prep_work

				-- Example 3
			across
				s.new_cursor.reversed as c
			loop
				print (c.item)
			end

				-- same as ...
			across
				- s.new_cursor as c  -- note the "-" before s.new_cursor
			loop
				print (c.item)
			end

				-- is this easier to read?
			across
				(- s.new_cursor) as c
			loop print (c.item)
			end
				-- minus sign replacement of `reversed' is
				-- 	possible due to: reversed alias "-": like Current
				--	in {INDEXABLE_ITERATION_CURSOR}
		end

	bertrand_example_4_tests
		note
			EIS: "src=https://bertrandmeyer.com/2010/01/26/more-expressive-loops-for-eiffel/"
			synopsis: "[
				Or you can use ... iterate over every n-th (e.g. third) item.

				(using s.new_cursor.incremented (3) rather than s.new_cursor + 3
				if you are not too keen on operator syntax) to iterate over every
				third item.

				NOTE: Sometimes, of course, you do want to change a structure while
				traversing it; for example you may want to add an element just to
				the right of the iteration position. If you know what you are doing
				that’s fine. (Let me correct this: if you know what you are doing,
				express it through precise contracts, and you’ll be fine.) But then
				you should not use the abstract forms of the loop, across…; you
				should control the iteration itself through the basic form
				from … until … with explicit cursor manipulation, protected by
				appropriate contracts.

				The two styles, by the way, are not distinct constructs. Eiffel
				has always had only one form of loop and this continues the case.
				The across forms are simply new possibilities added to the classical
				loop construct, with obvious constraints stating for example that
				you may not have both a some or all form and an explicit  loop body.
				In particular, an across loop can still have an invariant clause ,
				specifying the correctness properties of the loop, as in
				]"
		do
			bertrand_example_prep_work

				-- Example 4
			across
				s.new_cursor + 3 as c
			loop
				print (c.item)
			end

				-- Example 4b
			across
				- s.new_cursor + 3 as c		-- every 3rd item in reverse order.
			loop
				print (c.item)
			end

		end

feature {NONE} -- Bertrand Example Support

	bertrand_example_prep_work
			-- Do `bertrand_example_prep_work'.
		do
			s := "this is a string"; a := s
			m := 1; n := a.count
		end

	s, a: STRING
			-- Example strings `s' and `a' used in Bertrand Example Across-loop test features above.
		attribute
			create Result.make_empty
		end

	sum,m,n: INTEGER
			-- Example sum, lower, and upper bounds

feature -- Across-From Combined

	across_and_from_can_be_combined_tests
			-- Here is how `across_and_from_can_be_combined'!
		note
			synopsis: "[
				The "across" and "from" loops are not necessarily separate constructs.
				The "across" tells the compiler that we're iterating over something {ITERABLE}.
				The "from" tells the compiler that the code-block within it is prep-work
				for the loop at large. The until says, "We may not iterate over the entire
				{ITERABLE} thing." The "loop" part is still the loop part--that is--code
				that is executed for each item in the {ITERABLE} thing.
				
				NOTE: across and from loops can get even more expressive (see examples below).
				]"
		local
			i: INTEGER
		do
			across
				<<0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100>> as ic
			from
				i := 55
			until
				ic.item > i
			loop
				print (ic.item.out + ",") -- Outputs: "0,10,20,30,40,50,"
			end
		end

feature -- Loop Variant and Invariant

	prevent_endless_loops_tests
			-- How to `prevent_endless_loops'!
		note
			synopsis: "[
				From time to time, we write loops which never end. We call
				them "endless". An endless loop is a bug. All loops must end!
				The simplest way to prevent a loop from being endless is to
				provide a "variant", which is a sort of "count-down" value,
				starting at some high value and decreasing to zero. When the
				variant value goes negative, the compiler will stop the loop
				and declare an error.
				
				We do not have to be precise in knowing what is the max number
				of iterations our loop will make. We may or may not know the
				precise value. When we do not know the precise value, we can
				guess--that is okay! The point of the variant is to stop the
				loop from running endlessly.
				
				The variant helps to tell a reader of the code the intent of
				the designer of the code. It says, "Here--and no further!"
				Knowing the variant may also reveal something about the nature
				of the problem we are solving.
				
				Because of the way the "variant" works, it is a powerful
				bug preventing mechanism in our loops. PLEASE--use a loop
				variant as often as you can! It may not only reveal an
				endless loop, but a loop that one day may run longer than
				you originally thought--and YOU WANT to know that as well!
				]"
		local
			i,v: INTEGER
		do
			from
				i := 1
				v := 1_001
			until
				i > 1_000
			loop
				i := i + 1  -- What if I forget to increment my loop counter?
				--					If I do, my loop will never stop because 1 (i)
				--					will never increment and get larger than 1_000_000.
				v := v - 1
			variant
				v -- declares that `v' is not just some number. Once `v' is declared as
					-- the "variant", it is expected to decrement by at least 1 on each
					-- iteration. If it does not, this is also considered an error, and
					-- the program stops, thereby putting a failsafe on the nature of the
					-- operation of the variant value.
			end
		end

	the_loop_invariant_tests
			-- How to use `the_loop_invariant'.
		note
			synopsis: "[
				In the example loop below, we see two significant things:
				(1) We see that our "counter" `i' is both a counter and a loop variant
					(i.e. it is counting down to 0)
				(2) We see a new thing: "invariant" followed by a "tag" and a boolean expression.
				
				The intent of this loop is to count down from 1_000 to 0 by two's. The loop
				invariant states that before the loop starts that the value of `i' must be
				evenly divisable by 2. This same boolean assertion must hold True after
				each iteration of the loop. If it does not, then we're not counting down
				by two's--are we??? :-)
				
				NOTE: You can have as many invariants as you like! For example:
						we also want to express that we're actually counting
						down and NOT up!
						
				So--the tag `even' is a logical boolean assertion that `i' is even
				and the tag `down' is a logical boolean assertion that `j' is always
				greater than `i', which proves we're counting down and not up!
				]"
		local
			i,j: INTEGER
		do
			from
				i := 1_000
				j := i + 2 -- Sets `j' and satisfies the loop invariant the first time
			invariant
				even: (i \\ 2) = 0
				down: i < j
			until
				i = 0
			loop
				j := i	-- Captures the "old" value of `i' for the invariant "down".
				i := i - 2
			variant
				i
			end
				-- ... or ... you can just do it the Bertrand-way ...
				--	(see `bertrand_example_4' except do "by-2" instead of 3.)
			across
				(1 |..| 1_000).new_cursor.reversed + 2 as c
			loop
				print (c.item)
			end
		end

end
