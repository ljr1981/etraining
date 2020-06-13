note
	description: "809 Tests"
	testing: "type/manual"

class
	ET_809_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	correctness_and_contracts_tests
			-- Demonstration of correctness and contracts
		note
			explanation: "[
				External tests here in AutoTest do not have to repeat tests
				handled by internal Contracts. Therefore, the goal is to have
				as much internal contract assertions, which translates into
				less external testing required.
				
				Stated another way—our testing here becomes all about the API
				and not about the internal operations under the hood of the
				API and code.
				
				Moreover—contract failures ought never be about the failing
				of the outside world. For example: If you ask the ARM to
				withdraw more money than your balance + overdraft protection,
				doing so ought not crash the ATM machine! The ATM ought to
				simply report its rejection of your request.
				
				In like fashion, the code below should not crash with an
				internal contract failure when asked to withdraw more money
				than what is available. It should merely report this fact,
				which thing it does in the form of "transaction advice".
				]"
		local
			l_item: ET_809_CLIENT
		do
			create l_item
			l_item.account.set_overdraft_limit (500)
			l_item.make_deposit (1_000)
			assert_equal ("1_000", 1_000, l_item.account.balance.as_integer_32)
			l_item.make_withdrawal (500)
			l_item.make_withdrawal (550) -- Overdrafts by $50
			assert_equal ("zero_balance", {NATURAL} 0, l_item.account.balance)
			assert_equal ("50_overdraft", {NATURAL} 50, l_item.account.overdraft_balance)
			l_item.make_withdrawal (1_000) -- Fails because only $450 in overdraft remains.
			check attached l_item.transaction_advice as al_advice then
				assert_strings_equal ("Insufficient_overdraft_advice", l_item.Insufficient_overdraft_advice, al_advice)
			end
			l_item.reset_advices
			l_item.make_deposit (2_000) -- pays the $50 overdraft, leaving $1,950
			assert_equal ("new_balance", {NATURAL} 1950, l_item.account.balance)
			assert_equal ("full_overdraft", {NATURAL} 0, l_item.account.overdraft_balance)
		end

end


