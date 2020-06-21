note
	description: "Tests related to the Preferences Library"
	testing: "type/manual"

class
	PREFERENCES_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Testing

	preferences_tests
			-- Demonstration of how to get preferences setup
		note
			testing:  "execution/isolated", "execution/serial"
		local
				-- Factory Manager(s)
			l_factory: GRAPHICAL_PREFERENCE_FACTORY
			l_manager: PREFERENCE_MANAGER

				-- Preferences
			l_boolean_pref: BOOLEAN_PREFERENCE
			l_integer_pref: INTEGER_PREFERENCE
			l_array_pref: ARRAY_PREFERENCE
			l_string_pref: STRING_PREFERENCE
			l_string32_pref: STRING_32_PREFERENCE
			l_font_pref: FONT_PREFERENCE
			l_color_pref: COLOR_PREFERENCE
			l_path_pref: PATH_PREFERENCE
			l_string_list_pref: STRING_LIST_PREFERENCE
			l_path_list_pref: PATH_LIST_PREFERENCE
			l_string_choice_pref: STRING_CHOICE_PREFERENCE
			l_path_choice_pref: PATH_CHOICE_PREFERENCE

			l_standard_prefs: detachable PREFERENCES
			l_backup_storage: PREFERENCES_STORAGE_XML

			l_font: EV_FONT
		do
			create l_factory

			--| Use file default.conf to load default values
			create l_standard_prefs.make_with_defaults_and_storage (<<"default.conf">>, xml_pref_storage)

			--| preference under "display"
			l_manager := l_standard_prefs.new_manager ("display")
				l_boolean_pref := l_factory.new_boolean_preference_value (l_manager, "display.fullscreen_at_startup", Boolean_fallback_value)
				l_boolean_pref.set_description ("Ought the application be displayed at full-screen resolution upon application startup?")

				l_color_pref := l_factory.new_color_preference_value (l_manager, "display.background_color", create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
				l_color_pref.set_description ("Application window background color preference.")

			--| Path location preferences
			l_manager := l_standard_prefs.new_manager ("locations")
				if attached (create {DIRECTORY}.make ({EXECUTION_ENVIRONMENT}.Root_directory_name)) as al_install_directory then
					l_path_pref := l_factory.new_path_preference_value (l_manager, "locations.eiffel_studio", al_install_directory.path)
					l_path_pref.set_description ("Path to the latest installation of EiffelStudio.")
				end

			--| Blacklisted ECFs
			l_manager := l_standard_prefs.new_manager ("blacklist")
				l_string_list_pref := l_factory.new_string_list_preference_value (l_manager, "blacklist.blacklisted_ecfs", <<>>)
				l_string_list_pref.set_description ("A CSV list of ECF files from any location that you do not want processed by this Wizard or available to be used for any reason.%NEXAMPLE: this.ecf,that.ecf,my.ecf,your.ecf")

			--| User Defined ECF folders
			l_manager := l_standard_prefs.new_manager ("user_defined")
				l_path_list_pref := l_factory.new_path_list_preference_value (l_manager, "user_defined.list.paths", <<>>)
				l_path_list_pref.set_description ("A CSV list of paths to folders you want searched and available for ECF inclusion and selection.")

--			--| Basic preferences under "examples"
			l_manager := l_standard_prefs.new_manager ("examples")
				l_integer_pref := l_factory.new_integer_preference_value (l_manager, "examples.my_integer", 10)
				l_array_pref := l_factory.new_array_preference_value (l_manager, "examples.my_list", <<"1","2","3">>)
				l_array_pref := l_factory.new_array_preference_value (l_manager, "examples.my_list_as_choice", <<"1","2","3">>)
				l_array_pref.set_is_choice (True)
				if l_array_pref.selected_index = 0 then
					l_array_pref.set_selected_index (2)
				end

--				--| Graphical preferences under "examples"

				create l_font.make_with_values (1, 6, 10, 8)
				l_font.preferred_families.extend ("verdana")
				l_font.preferred_families.extend ("arial")
				l_font.preferred_families.extend ("helvetica")

				l_font_pref := l_factory.new_font_preference_value (l_manager, "examples.my_font_preference", l_font)
				l_font_pref.set_description ("Font preference description")

				l_string_pref := l_factory.new_string_preference_value (l_manager, "examples.my_string_preference", "a string")
				l_string_pref := l_factory.new_string_preference_value (l_manager, "examples.driver_location", (create {DIRECTORY_NAME}.make_from_string ("C:\My Directory Location")).string)


				--| List and Choice of strings preferences under "examples"
				l_string_list_pref := l_factory.new_string_list_preference_value (l_manager, "examples.list.strings", <<{STRING_32} "你", {STRING_32} "好", {STRING_32} "吗">>)
				l_string_list_pref.set_description ("String list preference")

				l_string_choice_pref := l_factory.new_string_choice_preference_value (l_manager, "examples.choice.strings", l_string_list_pref.value)
				l_string_choice_pref.set_description ("String choice preference")
				if l_string_choice_pref.selected_index = 0 then
					l_string_choice_pref.set_selected_index (2)
				end

				--| List and Choice of Paths preferences under "examples"
				l_path_list_pref := l_factory.new_path_list_preference_value (l_manager,
						"examples.list.paths",
						<<	create {PATH}.make_from_string ({STRING_32} "dir/你"), -- you
							create {PATH}.make_from_string ({STRING_32} "dir/好"), -- okay
							create {PATH}.make_from_string ({STRING_32} "dir/吗")  -- ?
						>>
					)
				l_path_choice_pref := l_factory.new_path_choice_preference_value (l_manager, "examples.choice.paths", l_path_list_pref.value)
				if l_path_choice_pref.selected_index = 0 then
					l_path_choice_pref.set_selected_index (2)
				end

				--| Unicode,Path, ... value preferences under "examples"
				l_string32_pref := l_factory.new_string_32_preference_value (l_manager, "examples.unicode.string_32", {STRING_32} "a unicode string 你好吗")
				l_path_pref := l_factory.new_path_preference_value (l_manager, "examples.my_path", create {PATH}.make_from_string ({STRING_32} "C:\unicode\folder\你好吗\here"))

				l_path_pref := l_factory.new_path_preference_value (l_manager, "examples.valid.existing_directory", (create {EXECUTION_ENVIRONMENT}).current_working_path)
				l_path_pref.require_existing_directory

			--| preference under "graphics"
			l_manager := l_standard_prefs.new_manager ("graphics")
				l_boolean_pref := l_factory.new_boolean_preference_value (l_manager, "graphics.use_maximum_resolution", True)

			create l_backup_storage.make_with_location ("backup.conf")
			l_standard_prefs.export_to_storage (l_backup_storage, Save_all_values)
		end

feature {NONE} -- Implementation

	xml_pref_storage: PREFERENCES_STORAGE_XML
			-- `xml_pref_storage' preferences in XML
		do
	 		create Result.make_with_location ("user.conf")
	 	end

	Save_modified_values_only: BOOLEAN = True
	Save_all_values: BOOLEAN = False

	Boolean_fallback_value: BOOLEAN = True

end
