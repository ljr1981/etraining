note
	description: "Notion of a Client Class"
	EIS: "name=ECMA-367_8_9_Contracts", "protocol=pdf", "type=file",
			"nameddest=8.9 Contacts",
			"src=$GITHUB/etraining/ECMA-367.pdf"

class
	ET_809_CLIENT

feature -- Operations

	make_deposit (a_amount: INTEGER)
			-- Make a Deposit in the amount of `a_amount'.
		require
			positive_non_zero: a_amount > 0
			reset: is_advice_reset
		do
			account.deposit (a_amount.as_natural_32)
		end

	make_withdrawal (a_amount: INTEGER)
			-- Make a withdrawal in the amount of `a_amount'.
		require
			positive_non_zero: a_amount > 0
			reset: is_advice_reset
		do
			if account.amount_within_remaining_overdraft (a_amount.as_natural_32) then
				account.withdraw (a_amount.as_natural_32)
			else
				create transaction_advice.make_from_string (Insufficient_overdraft_advice)
			end
		end

	reset_advices
			-- Reset deposit and withdrawal advice messages.
		do
			transaction_advice := Void
		end

feature -- Constants

	Insufficient_overdraft_advice: STRING = "Insufficient overdraft balance."
			-- Insufficient overdraft advice message.

feature -- Status Report

	is_advice_reset: BOOLEAN
			-- Have the advices been reset?
		do
			Result := not attached transaction_advice
		end

feature -- Access

	transaction_advice: detachable STRING
			-- Optional "advice" for a deposit or withdrawal transaction.

	account: ET_809_SUPPLIER
			-- An `account' to play with.
		attribute
			create Result
		end

end
