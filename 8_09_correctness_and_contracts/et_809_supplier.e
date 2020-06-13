note
	description: "Notion of a Supplier Class."
	EIS: "name=ECMA-367_8_9_Contracts", "protocol=pdf", "type=file",
			"nameddest=8.9 Contacts",
			"src=$GITHUB/etraining/ECMA-367.pdf"

class
	ET_809_SUPPLIER

feature -- Access

	balance: NATURAL
			-- Balance of an account.

	overdraft_balance: NATURAL
			-- Balance of an Overdraft account.

	overdraft_limit: NATURAL
			-- Credit limit to `overdraft_balance'.

feature -- Settings

	set_overdraft_limit (a_limit: NATURAL)
			-- Set the `overdraft_limit' to `a_limit' amount.
		require
			limited_limit: a_limit >= overdraft_balance
		do
			overdraft_limit := a_limit
		ensure
			set: overdraft_limit = a_limit
		end

feature -- Operations

	deposit (a_amount: NATURAL)
			-- Deposit positive non-zero `a_amount' into `balance'.
		require
			positive_amount: a_amount > 0
		local
			l_amount: like balance
		do
			l_amount := a_amount
			if is_overdrafted and then (l_amount > overdraft_balance) then
				l_amount := l_amount - overdraft_balance
				overdraft_balance := 0
				balance := balance + l_amount
				l_amount := 0
			elseif is_overdrafted and then (l_amount <= overdraft_balance) then
				overdraft_balance := overdraft_balance - l_amount
				l_amount := 0
			else
				balance := balance + l_amount
			end
		ensure
			deposit_made: not old is_overdrafted implies balance = (old balance + a_amount)
			overdraft_handled: old is_overdrafted implies
							( (overdraft_balance = 0 xor
								old overdraft_balance = overdraft_balance - a_amount)
							and then
							  (balance = old balance xor
							  	balance = (old balance + (a_amount - old overdraft_balance)) ) )
		end

	withdraw (a_amount: like balance)
			-- Withdraw `a_amount' from `a_balance'.
		require
			enough_overdraft: amount_within_remaining_overdraft (a_amount)
		local
			l_amount: like balance
		do
			if a_amount <= balance then
				balance := balance - a_amount
			elseif a_amount > balance then
				l_amount := a_amount - balance
				balance := 0
				overdraft_balance := overdraft_balance + l_amount
			end
		ensure
			enough_balance: (old balance >= a_amount) implies (balance = (old balance - a_amount))
			overdrafted: (old balance <= a_amount) implies
							( old balance = a_amount xor
								old overdraft_balance = (overdraft_balance - (a_amount - old balance)) )
		end

feature -- Status Report

	is_overdrafted: BOOLEAN
			-- Current is overdrafted?
		do
			Result := overdraft_balance > 0
		end

	amount_within_remaining_overdraft (a_amount: like balance): BOOLEAN
			-- Is `a_amount' within the `remaining_overdraft_amount' plus `balance'?
		do
			if a_amount <= balance then
				Result := True
			else
				Result := (a_amount - balance) < remaining_overdraft_amount
			end
		ensure
			within_balance: (a_amount <= balance) implies Result
			within_overdraft: (Result and (a_amount > balance)) implies
						a_amount <= (remaining_overdraft_amount + balance)
		end

	remaining_overdraft_amount: NATURAL
			-- What is the remaining overdraft balance?
		do
			Result := overdraft_limit - overdraft_balance
		end

invariant
	within_limits: overdraft_balance <= overdraft_limit

end
