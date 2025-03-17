#define CPL_VARIANT "Corporal"
#define SGT_VARIANT "Sergeant"

/datum/job/command/tank_crew
	title = JOB_TANK_CREW
	total_positions = 2
	spawn_positions = 2
	allow_additional = TRUE
	scaled = FALSE
	supervisors = "the acting commanding officer"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm/tank
	gear_preset_secondary = /datum/equipment_preset/uscm/tank/lesser_rank
	entry_message_body = "Your job is to operate and maintain the ship's armored vehicles. You are in charge of representing the armored presence amongst the marines during the operation, as well as maintaining and repairing your own vehicles."

	job_options = list(CPL_VARIANT = "Cpl", SGT_VARIANT = "Sgt")

/datum/job/command/tank_crew/set_spawn_positions(count)
	if (length(GLOB.clients) >= 200)
		spawn_positions = 2
	else
		spawn_positions = 0

/datum/job/command/tank_crew/handle_job_options(option)
	if(option != CPL_VARIANT)
		gear_preset = initial(gear_preset)
	else
		gear_preset = gear_preset_secondary

/datum/job/command/tank_crew/ai
	total_positions = 2
	spawn_positions = 2

/datum/job/command/tank_crew/ai/set_spawn_positions(count)
	return spawn_positions

/datum/job/command/tank_crew/ai/get_total_positions(latejoin = 0)
	return latejoin ? total_positions : spawn_positions

/datum/job/command/tank_crew/get_total_positions(latejoin = FALSE)
	if(SStechtree.trees[TREE_MARINE].get_node(/datum/tech/arc).unlocked)
		return 0
	if(length(GLOB.clients) >= 200 || total_positions_so_far > 0)
		return 2

	return 0

/obj/effect/landmark/start/tank_crew
	name = JOB_TANK_CREW
	job = /datum/job/command/tank_crew

#undef CPL_VARIANT
#undef SGT_VARIANT
