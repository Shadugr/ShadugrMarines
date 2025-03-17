#define SECOND_LT_VARIANT "Second Lieutenant"
#define FIRST_LT_VARIANT "First Lieutenant"

/datum/job/command/pilot/cas_pilot
	title = JOB_CAS_PILOT
	total_positions = 1
	spawn_positions = 1
	allow_additional = TRUE
	scaled = FALSE
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/gp
	gear_preset_secondary = /datum/equipment_preset/uscm_ship/gp/lesser_rank
	entry_message_body = "<a href='"+WIKI_PLACEHOLDER+"'>Your job is to fly, protect, and maintain the ship's gunship.</a> While you are an officer, your authority is limited to the dropship, where you have authority over the enlisted personnel."

	job_options = list(SECOND_LT_VARIANT = "2ndLt", FIRST_LT_VARIANT = "1stLt")

/datum/job/command/pilot/cas_pilot/handle_job_options(option)
	if(option != SECOND_LT_VARIANT)
		gear_preset = initial(gear_preset)
	else
		gear_preset = gear_preset_secondary

/datum/job/command/pilot/cas_pilot/ai
	total_positions = 1
	spawn_positions = 1

/datum/job/command/pilot/cas_pilot/ai/set_spawn_positions(count)
	return spawn_positions

/datum/job/command/pilot/cas_pilot/ai/get_total_positions(latejoin = 0)
	return latejoin ? total_positions : spawn_positions

/datum/job/command/pilot/whiskey
	total_positions = 2
	spawn_positions = 2

// Dropship Roles is both DP, GP and DCC combined to not force people to backtrack
AddTimelock(/datum/job/command/pilot/cas_pilot, list(
	JOB_DROPSHIP_ROLES = 2 HOURS
))

/obj/effect/landmark/start/pilot/cas_pilot
	name = JOB_CAS_PILOT
	icon_state = "po_spawn"
	job = /datum/job/command/pilot/cas_pilot

#undef SECOND_LT_VARIANT
#undef FIRST_LT_VARIANT
