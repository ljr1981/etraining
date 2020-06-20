note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	LOGGING_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	logging_tests
			-- New test routine
		note
			testing:  "execution/isolated", "execution/serial"
		local
			l_log: LOG_LOGGING_FACILITY
			l_file: PLAIN_TEXT_FILE
			l_msg: STRING
			l_date: DATE
		do
				-- Delete old test result file
				-- to make way for new ...
			create l_file.make_with_name ("system.log")
			l_file.delete

				-- Create our logging object and enable it
			create l_log.make
			l_log.enable_default_file_log

				-- debug is the last level, which includes all others
				-- This must be done to get all logging levels to work!
			l_log.default_log_writer_file.enable_debug_log_level

				-- each level
			l_log.write_alert ("alert")
			l_log.write_critical ("critical")
			l_log.write_debug ("debug")
			l_log.write_emergency ("emergency")
			l_log.write_error ("error")
			l_log.write_information ("info")
			l_log.write_notice ("notice")
			l_log.write_warning ("warning")

				-- Check the file
			create l_file.make_open_read ("system.log")
			l_file.read_stream (l_file.count)
			l_file.close
			l_msg := l_file.last_string
			create l_date.make_now

				-- All these ought to be logged
			assert_booleans_equal ("has_date", True, l_msg.has_substring (l_date.out))
			assert_booleans_equal ("alert", True, l_msg.has_substring ("alert"))
			assert_booleans_equal ("critical", True, l_msg.has_substring ("critical"))
			assert_booleans_equal ("debug", True, l_msg.has_substring ("debug"))
			assert_booleans_equal ("emergency", True, l_msg.has_substring ("emergency"))
			assert_booleans_equal ("error", True, l_msg.has_substring ("error"))
			assert_booleans_equal ("info", True, l_msg.has_substring ("info"))
			assert_booleans_equal ("notice", True, l_msg.has_substring ("notice"))
			assert_booleans_equal ("warning", True, l_msg.has_substring ("warning"))
		end

end


