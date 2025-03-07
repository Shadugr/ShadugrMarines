/datum/emote/living/carbon/human
	mob_type_allowed_typecache = list(/mob/living/carbon/human)
	keybind_category = CATEGORY_HUMAN_EMOTE

	/// Species that can use this emote.
	var/list/species_type_allowed_typecache = list(/datum/species/human, /datum/species/synthetic, /datum/species/yautja)
	/// Species that can't use this emote.
	var/list/species_type_blacklist_typecache = list(/datum/species/monkey)

/datum/emote/living/carbon/human/New()
	. = ..()

	species_type_allowed_typecache = typecacheof(species_type_allowed_typecache)
	species_type_blacklist_typecache = typecacheof(species_type_blacklist_typecache)

/datum/emote/living/carbon/human/can_run_emote(mob/living/carbon/human/user, status_check, intentional)
	. = ..()
	if(!.)
		return

	if(!is_type_in_typecache(user.species, species_type_allowed_typecache))
		. = FALSE
	if(is_type_in_typecache(user.species, species_type_blacklist_typecache))
		. = FALSE

/datum/emote/living/carbon/human/blink
	key = "blink"
	key_third_person = "blinks"
	message = "моргает."

/datum/emote/living/carbon/human/blink_rapid
	key = "rapidblink"
	message = "быстро моргает."

/datum/emote/living/carbon/human/bow
	key = "bow"
	key_third_person = "bows"
	message = "кланяется."
	message_param = "кланяется перед %t."

/datum/emote/living/carbon/human/chuckle
	key = "chuckle"
	key_third_person = "chuckles"
	message = "усмехается."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/clap
	key = "clap"
	key_third_person = "claps"
	message = "хлопает."
	hands_use_check = TRUE
	audio_cooldown = 5 SECONDS
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'sound/misc/clap.ogg'

/datum/emote/living/carbon/human/collapse
	key = "collapse"
	key_third_person = "collapses"
	message = "падает!"

/datum/emote/living/carbon/human/collapse/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	user.apply_effect(2, PARALYZE)

/datum/emote/living/carbon/human/cough
	key = "cough"
	key_third_person = "coughs"
	message = "кашляет!"

/datum/emote/living/carbon/human/cry
	key = "cry"
	key_third_person = "cries"
	message = "плачет."

/datum/emote/living/carbon/human/eyebrow
	key = "eyebrow"
	message = "поднимает бровь."

/datum/emote/living/carbon/human/facepalm
	key = "facepalm"
	key_third_person = "facepalms"
	message = "делает фейспалм."

/datum/emote/living/carbon/human/faint
	key = "faint"
	key_third_person = "faints"
	message = "теряет сознание!"

/datum/emote/living/carbon/human/faint/run_emote(mob/living/carbon/human/user, params, type_override, intentional)
	. = ..()
	user.sleeping += 10

/datum/emote/living/carbon/human/frown
	key = "frown"
	key_third_person = "frowns"
	message = "хмурится."

/datum/emote/living/carbon/human/gasp
	key = "gasp"
	key_third_person = "gasps"
	message = "задыхается!"

/datum/emote/living/carbon/human/giggle
	key = "giggle"
	key_third_person = "giggles"
	message = "хихикает."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/glare
	key = "glare"
	key_third_person = "glares"
	message = "сверлит взглядом."
	message_param = "сверлит взглядом %t."

/datum/emote/living/carbon/human/golfclap
	key = "golfclap"
	key_third_person = "golfclaps"
	message = "сдержанно хлопает."
	alt_message = "хлопает"
	sound = 'sound/misc/golfclap.ogg'
	cooldown = 5 SECONDS
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/grin
	key = "grin"
	key_third_person = "grins"
	message = "ухмыляется."

/datum/emote/living/carbon/human/grumble
	key = "grumble"
	key_third_person = "grumbles"
	message = "ворчит."

/datum/emote/living/carbon/human/handshake
	key = "handshake"
	message_param = "жмёт руку %t."

/datum/emote/living/carbon/human/laugh
	key = "laugh"
	key_third_person = "laughs"
	message = "смеётся!"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/look
	key = "look"
	key_third_person = "looks"
	message = "смотрит."
	message_param = "смотрит на %t."

/datum/emote/living/carbon/human/medic
	key = "medic"
	message = "зовёт медика!"
	alt_message = "shouts something"
	cooldown = 5 SECONDS
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/medic/get_sound(mob/living/user)
	if(user.gender == MALE)
		return pick('sound/voice/corpsman.ogg', 'sound/voice/corpsman_up.ogg', 'sound/voice/corpsman_over_here.ogg', 'sound/voice/i_need_a_corpsman_1.ogg', 'sound/voice/i_need_a_corpsman_2.ogg', 'sound/voice/im_hit_get_doc_up_here.ogg', 'sound/voice/get_doc_up_here_im_hit.ogg', 20;'sound/voice/i_cant_feel_my_legs_corpsman.ogg', 0.5;'sound/voice/human_male_medic_rare_1.ogg', 0.5;'sound/voice/human_male_medic.ogg', 1;'sound/voice/human_male_medic_rare_2.ogg')
	else
		return 'sound/voice/human_female_medic.ogg'

/datum/emote/living/carbon/human/medic/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

	user.show_speech_bubble("medic")

/datum/emote/living/carbon/human/medic/run_langchat(mob/user, group)
	if(!ishuman_strict(user))
		return

	var/medic_message = pick("Медик!", "Док!", "Помогите!")
	user.langchat_speech(medic_message, group, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_bolded"))

/datum/emote/living/carbon/human/moan
	key = "moan"
	key_third_person = "moans"
	message = "стонет."

/datum/emote/living/carbon/human/mumble
	key = "mumble"
	key_third_person = "mumbles"
	message = "бормочет."

/datum/emote/living/carbon/human/nod
	key = "nod"
	key_third_person = "nods"
	message = "кивает."

/datum/emote/living/carbon/human/pain
	key = "pain"
	message = "визжит от боли!"
	alt_message = "визжит"
	species_type_blacklist_typecache = list(/datum/species/synthetic)
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/pain/get_sound(mob/living/user)
	if(ishuman_strict(user))
		if(user.gender == MALE)
			return get_sfx("male_pain")
		else
			return get_sfx("female_pain")

	if(isyautja(user))
		return get_sfx("pred_pain")

/datum/emote/living/carbon/human/pain/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

	user.show_speech_bubble("pain")

/datum/emote/living/carbon/human/pain/run_langchat(mob/user, group)
	if(!ishuman_strict(user))
		return

	var/pain_message = pick("АЙ!!", "ААГХ!!", "АРГХ!!", "АУЧ!!", "ААА!!", "УФ!")
	user.langchat_speech(pain_message, group, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_yell"))
/datum/emote/living/carbon/human/salute
	key = "salute"
	key_third_person = "salutes"
	message = "салютует."
	message_param = "салютует %t."
	sound = 'sound/misc/salute.ogg'
	audio_cooldown = 5 SECONDS
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/scream
	key = "scream"
	key_third_person = "screams"
	message = "кричит!"
	audio_cooldown = 5 SECONDS
	species_type_blacklist_typecache = list(/datum/species/synthetic)
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/scream/get_sound(mob/living/user)
	if(ishuman_strict(user))
		if(user.gender == MALE)
			return get_sfx("male_scream")
		else
			return get_sfx("female_scream")
	if(isyautja(user))
		return get_sfx("pred_pain")

/datum/emote/living/carbon/human/scream/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

	user.show_speech_bubble("scream")

/datum/emote/living/carbon/human/scream/run_langchat(mob/user, group)
	if(!ishuman_strict(user))
		return

	var/scream_message = pick("БЛЯТЬ!!!", "АГГХ!!!", "АГХ!!!", "AAAA!!!", "ГГГХ!!!", "НГХХХ!!!", "СУКА!!!", "ДЕРЬМО!!!")
	user.langchat_speech(scream_message, group, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_PANIC_POP, additional_styles = list("langchat_yell"))

/datum/emote/living/carbon/human/shakehead
	key = "shakehead"
	message = "качает головой."

/datum/emote/living/carbon/human/shiver
	key = "shiver"
	key_third_person = "shivers"
	message = "дрожит."

/datum/emote/living/carbon/human/shrug
	key = "shrug"
	key_third_person = "shrugs"
	message = "пожимает плечами."

/datum/emote/living/carbon/human/sigh
	key = "sigh"
	key_third_person = "sighs"
	message = "вздыхает."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/smile
	key = "smile"
	key_third_person = "smiles"
	message = "улыбается."

/datum/emote/living/carbon/human/sneeze
	key = "sneeze"
	key_third_person = "sneezes"
	message = "чихает!"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/snore
	key = "snore"
	key_third_person = "snores"
	message = "храпит."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/stare
	key = "stare"
	key_third_person = "stares"
	message = "пялиться."
	message_param = "пялиться на %t."

/datum/emote/living/carbon/human/signal
	key = "signal"
	key_third_person = "signals"
	message_param = "raises %t fingers."
	hands_use_check = TRUE

/datum/emote/living/carbon/human/signal/run_emote(mob/user, params, type_override, intentional)
	params = text2num(params)
	if(params == 1 || !isnum(params))
		return "raises one finger."
	params = num2text(clamp(params, 2, 10))
	return ..()

/datum/emote/living/carbon/human/stop
	key = "stop"
	message = "протягивает открытую ладонь, жестом показывая, что нужно остановиться."
	hands_use_check = TRUE

/datum/emote/living/carbon/human/thumbsup
	key = "thumbsup"
	message = "показывает большой палец вверх."
	hands_use_check = TRUE

/datum/emote/living/carbon/human/thumbsdown
	key = "thumbsdown"
	message = "показывает большой палец вниз."
	hands_use_check = TRUE

/datum/emote/living/carbon/human/twitch
	key = "twitch"
	key_third_person = "twitches"
	message = "дёргается."

/datum/emote/living/carbon/human/wave
	key = "wave"
	key_third_person = "waves"
	message = "машет рукой."

/datum/emote/living/carbon/human/yawn
	key = "yawn"
	key_third_person = "yawns"
	message = "зевает."

/datum/emote/living/carbon/human/warcry
	key = "warcry"
	message = "выкрикивает вдохновляющий клич!"
	alt_message = "кричит что-то."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/warcry/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

	user.show_speech_bubble("warcry")

/datum/emote/living/carbon/human/warcry/get_sound(mob/living/user)
	if(ishumansynth_strict(user))
		if(user.gender == MALE)
			if(user.faction == FACTION_UPP)
				return get_sfx("male_upp_warcry")
			else
				return get_sfx("male_warcry")
		else
			if(user.faction == FACTION_UPP)
				return get_sfx("female_upp_warcry")
			else
				return get_sfx("female_warcry")

/datum/emote/living/carbon/human/whimper
	key = "whimper"
	key_third_person = "whimpers"
	message = "хнычет."

/datum/emote/living/carbon/human/whimper/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return

	user.show_speech_bubble("scream")

/datum/emote/living/carbon/human/enemynorth
	key = "enemynorth"
	key_third_person = "enemynorths"
	message = "кричит, что противник на севере!!!"
	alt_message = "кричит что-то."

/datum/emote/living/carbon/human/enemynorth/get_sound(mob/living/user)
	if(ishumansynth_strict(user))
		if(user.gender == MALE)
			if(user.faction == FACTION_UPP)
				return get_sfx("male_upp_warcry")
			else
				return get_sfx("male_warcry")
		else
			if(user.faction == FACTION_UPP)
				return get_sfx("female_upp_warcry")
			else
				return get_sfx("female_warcry")

/datum/emote/living/carbon/human/enemynorth/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

	user.show_speech_bubble("scream")

/datum/emote/living/carbon/human/enemysouth
	key = "enemysouth"
	key_third_person = "enemysouths"
	message = "кричит, что противник на юге!!!"
	alt_message = "кричит что-то."

/datum/emote/living/carbon/human/enemysouth/get_sound(mob/living/user)
	if(ishumansynth_strict(user))
		if(user.gender == MALE)
			if(user.faction == FACTION_UPP)
				return get_sfx("male_upp_warcry")
			else
				return get_sfx("male_warcry")
		else
			if(user.faction == FACTION_UPP)
				return get_sfx("female_upp_warcry")
			else
				return get_sfx("female_warcry")

/datum/emote/living/carbon/human/enemysouth/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

	user.show_speech_bubble("scream")

/datum/emote/living/carbon/human/enemywest
	key = "enemywest"
	key_third_person = "enemywests"
	message = "кричит, что противник на западе!!!"
	alt_message = "кричит что-то."

/datum/emote/living/carbon/human/enemywest/get_sound(mob/living/user)
	if(ishumansynth_strict(user))
		if(user.gender == MALE)
			if(user.faction == FACTION_UPP)
				return get_sfx("male_upp_warcry")
			else
				return get_sfx("male_warcry")
		else
			if(user.faction == FACTION_UPP)
				return get_sfx("female_upp_warcry")
			else
				return get_sfx("female_warcry")

/datum/emote/living/carbon/human/enemywest/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

	user.show_speech_bubble("scream")

/datum/emote/living/carbon/human/enemyeast
	key = "enemyeast"
	key_third_person = "enemyeast"
	message = "кричит, что противник на востоке!!!"
	alt_message = "кричит что-то."

/datum/emote/living/carbon/human/enemyeast/get_sound(mob/living/user)
	if(ishumansynth_strict(user))
		if(user.gender == MALE)
			if(user.faction == FACTION_UPP)
				return get_sfx("male_upp_warcry")
			else
				return get_sfx("male_warcry")
		else
			if(user.faction == FACTION_UPP)
				return get_sfx("female_upp_warcry")
			else
				return get_sfx("female_warcry")

/datum/emote/living/carbon/human/enemyeast/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

	user.show_speech_bubble("scream")
