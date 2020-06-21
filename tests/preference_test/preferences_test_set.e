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
			explanation: "[
				HOW TO (and WHY)
				================
				Preferences follow a basic pattern. The first step in
				that pattern is to understand how with this Preferences
				Library, you build up Preferences using a Preference
				Factory and a Domain Manager. The steps are basically:
				
				1. Determine how to store your prefs (XML, Registry)
				2. Create your Preferences list with 
					2a) Defaults (e.g. hard coded/specified in XML file)
					2b) Storage (e.g. where to put changes that the user makes)
						* e.g. you won't see this "user.conf" file until the user changes something.
				3. Create a Factory
				4. For each Preference Domain, create a Manager
					4b. Create the new Manager from the Preferences
					4c. For each Preference item, create it from a Factory + Manager
						(i.e. l_my_bool_pref := l_factory.new_boolean_preference_value (l_manager, "domain.pref_name", [True/False]))
				5. Rinse-and-Repeat 4 to 4C for each Domain + Preference item
					you want in your Preferences set (list)
					
				STORAGE NOTES
				=============
				There are at least N places where a set of Preferences are stored:
				
				1. Memory - Your code will want to call a routine that sets up
					preferences (like the example code below) as the program is
					starting and before the preference values are needed. Be sure
					to have sufficient access program-wide. Perhaps a once'd reference.
				2. Default - The XML example below uses a "default.conf" XML file
					as a disk-based resource for loading your preferences instead of
					building them up in code. This means there are two ways of 
					setting up your default preferences. Note that user pref changes
					will overwrite these if they exist.
				3. User - When the user makes changes to the preferences, they are
					stored into a repository (e.g. XML file or Registry entries).
					As long as the user makes no changes, the repo (e.g. file) will
					not be created. If the user resets all their changes back to
					the default (see above), the repo is deleted (XML file removed
					or Registry entries removed).
				4. Backup - This is NOT required or even needed. The example below
					creates a "backup.conf" XML file, which is really just a glorified
					"default.conf" XML file. It is here as a way to provde you with
					an example XML file to understand how preferences look in a
					unicode XML file and its structure.
				]"
			BNFE: "[
				Preferences ::=
					{Domain}*
					
				Domain :=
					{Preference}*
				]"
			glossary: "[
				Preference set: A list of Domains, each with a set of Preference items.
				
				Preference item: A single preference (e.g. boolean checkbox or font preference)
				
				Domain: A subset of Preference item(s) in the Preference set, denoted by
						a dot-call-delineated list (i.e. dot-separated-text-values).
						(e.g. display.input_screens.font can implies a preference for
						 a particular font for input-screens in the domain of things
						 displayed)
				]"
		local
				-- Preferences & Storage
			l_standard_prefs: detachable PREFERENCES	-- List of Preferences (w/domains & mgrs)
			l_backup_storage,							-- An XML file to store default prefs
			l_main_storage: PREFERENCES_STORAGE_XML		-- An XML file to store user changes to prefs

				-- Factory Manager(s)
			l_factory: GRAPHICAL_PREFERENCE_FACTORY		-- Factory to create Prefs for Mgrs
			l_manager: PREFERENCE_MANAGER				-- A Manager responsible for each pref domain

				-- Preference items
			l_boolean_pref: BOOLEAN_PREFERENCE				-- A BOOLEAN pref (checkbox)
			l_integer_pref: INTEGER_PREFERENCE				-- An INTEGER pref (numeric spinner)
			l_array_pref: ARRAY_PREFERENCE					-- An ARRAY [ANY] pref (list)
			l_string_pref: STRING_PREFERENCE				-- A STRING pref (text field)
			l_string32_pref: STRING_32_PREFERENCE			-- A STRING_32 pref (unicode text field)
			l_font_pref: FONT_PREFERENCE					-- An EV_FONT pref (font picker)
			l_color_pref: COLOR_PREFERENCE					-- An EV_COLOR pref (color picker)
			l_path_pref: PATH_PREFERENCE					-- A PATH pref (dir/file picker)
			l_string_list_pref: STRING_LIST_PREFERENCE		-- A list of STRINGs (CSV list)
			l_path_list_pref: PATH_LIST_PREFERENCE			-- A list of PATHs (CSV list)
			l_string_choice_pref: STRING_CHOICE_PREFERENCE	-- A list of STRINGs as Choices (combobox)
			l_path_choice_pref: PATH_CHOICE_PREFERENCE		-- A list of PATHs as Choices (combobox)

			l_font: EV_FONT
		do
			--| Use file default.conf to load default values
			create l_main_storage.make_with_location ("user.conf")
			create l_standard_prefs.make_with_defaults_and_storage (<<"default.conf">>, l_main_storage)

			create l_factory

			--| preference under "display"
			l_manager := l_standard_prefs.new_manager ("display")
				l_boolean_pref := l_factory.new_boolean_preference_value (l_manager, "display.fullscreen_at_startup", Boolean_fallback_value)
				l_boolean_pref.set_description ("Ought the application be displayed at full-screen resolution upon application startup?")

				l_color_pref := l_factory.new_color_preference_value (l_manager, "display.background_color", create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
				l_color_pref.set_description ("Application window background color preference.")

			--| Path location preferences
			l_manager := l_standard_prefs.new_manager ("locations")
				if attached (create {DIRECTORY}.make ({EXECUTION_ENVIRONMENT}.Root_directory_name)) as al_install_directory then
					l_path_pref := l_factory.new_path_preference_value (l_manager, "locations.root", al_install_directory.path)
					l_path_pref.set_description ("Path to the root directory.")
				end

			--| Blacklisted Files
			l_manager := l_standard_prefs.new_manager ("blacklist")
				l_string_list_pref := l_factory.new_string_list_preference_value (l_manager, "blacklist.blacklisted_files", <<>>)
				l_string_list_pref.set_description ("A CSV list of files from any location that you do not want processed or available to be used for any reason.%NEXAMPLE: this.file,that.file,my.file,your.your")

			--| User Defined folders
			l_manager := l_standard_prefs.new_manager ("user_defined")
				l_path_list_pref := l_factory.new_path_list_preference_value (l_manager, "user_defined.list.paths", <<>>)
				l_path_list_pref.set_description ("A CSV list of paths to folders you want searched and available for inclusion and selection.")

			--| Basic preferences under "examples"
			l_manager := l_standard_prefs.new_manager ("examples")
				l_integer_pref := l_factory.new_integer_preference_value (l_manager, "examples.my_integer", 10)
				l_array_pref := l_factory.new_array_preference_value (l_manager, "examples.my_list", <<"1","2","3">>)
				l_array_pref := l_factory.new_array_preference_value (l_manager, "examples.my_list_as_choice", <<"1","2","3">>)
				l_array_pref.set_is_choice (True)
				if l_array_pref.selected_index = 0 then
					l_array_pref.set_selected_index (2)
				end

				--| Graphical preferences under "examples"
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

	Save_modified_values_only: BOOLEAN = True
	Save_all_values: BOOLEAN = False

	Boolean_fallback_value: BOOLEAN = True

end
