/datum/species/proc/get_valid_shapeshifter_forms(var/mob/living/carbon/human/H)
	return list()

/datum/species/proc/get_additional_examine_text(var/mob/living/carbon/human/H)
	return

/datum/species/proc/get_tail(var/mob/living/carbon/human/H)
	return tail

/datum/species/proc/get_tail_animation(var/mob/living/carbon/human/H)
	return tail_animation

/datum/species/proc/get_tail_hair(var/mob/living/carbon/human/H)
	return tail_hair

/datum/species/proc/get_blood_mask(var/mob/living/carbon/human/H)
	return blood_mask

/datum/species/proc/get_damage_overlays(var/mob/living/carbon/human/H)
	return damage_overlays

/datum/species/proc/get_damage_mask(var/mob/living/carbon/human/H)
	return damage_mask

/datum/species/proc/get_examine_name(var/mob/living/carbon/human/H)
	return name

/datum/species/proc/get_icobase(var/mob/living/carbon/human/H, var/get_deform)
	return (get_deform ? deform : icobase)


/datum/species/proc/get_station_variant()
	return name

/datum/species/proc/get_race_key(var/mob/living/carbon/human/H)
	return race_key

/datum/species/proc/get_bodytype(var/mob/living/carbon/human/H)
	if (bodytype)	
		return bodytype
	return name

/datum/species/proc/get_knockout_message(var/mob/living/carbon/human/H)
	return ((H && H.isSynthetic()) ? "encounters a hardware fault and suddenly reboots!" : knockout_message)

/datum/species/proc/get_death_message(var/mob/living/carbon/human/H)
	return ((H && H.isSynthetic()) ? "gives one shrill beep before falling lifeless." : death_message)

/datum/species/proc/get_ssd(var/mob/living/carbon/human/H)
	return ((H && H.isSynthetic()) ? "flashing a 'system offline' glyph on their monitor" : show_ssd)

/datum/species/proc/get_blood_colour(var/mob/living/carbon/human/H)
	return ((H && H.isSynthetic()) ? SYNTH_BLOOD_COLOUR : blood_color)

/datum/species/proc/get_virus_immune(var/mob/living/carbon/human/H)
	return ((H && H.isSynthetic()) ? 1 : virus_immune)

/datum/species/proc/get_flesh_colour(var/mob/living/carbon/human/H)
	return ((H && H.isSynthetic()) ? SYNTH_FLESH_COLOUR : flesh_color)

/datum/species/proc/get_environment_discomfort(var/mob/living/carbon/human/H, var/msg_type)

	if(!prob(5))
		return

	var/covered = 0 // Basic coverage can help.
	for(var/obj/item/clothing/clothes in H)
		if(H.l_hand == clothes || H.r_hand == clothes)
			continue
		if((clothes.body_parts_covered & UPPER_TORSO) && (clothes.body_parts_covered & LOWER_TORSO))
			covered = 1
			break

	switch(msg_type)
		if("cold")
			if(!covered)
				to_chat(H, "<span class='danger'>[pick(cold_discomfort_strings)]</span>")
		if("heat")
			if(covered)
				to_chat(H, "<span class='danger'>[pick(heat_discomfort_strings)]</span>")

/datum/species/proc/get_random_name(var/gender)
	if(!name_language)
		if(gender == FEMALE)
			return capitalize(pick(GLOB.first_names_female)) + " " + capitalize(pick(GLOB.last_names))
		else
			return capitalize(pick(GLOB.first_names_male)) + " " + capitalize(pick(GLOB.last_names))

	var/datum/language/species_language = all_languages[name_language]
	if(!species_language)
		species_language = all_languages[default_language]
	if(!species_language)
		return "unknown"
	return species_language.get_random_name(gender)

/datum/species/proc/get_vision_flags(var/mob/living/carbon/human/H)
	return vision_flags

/datum/species/proc/get_husk_icon(var/mob/living/carbon/human/H)
	return husk_icon


/mob/proc/get_species()
	return ""

/mob/proc/get_species_datum()
	return null


/mob/living/carbon/human/get_species()
	if(!species)
		set_species()
	return species.name

/mob/living/carbon/human/get_species_datum()
	if(!species)
		set_species()
	return species


//returns the species of this mob's brain
//In 99.999% of cases this is the same as the body. but in the case of a divider puppet it can be different
/mob/proc/get_mental_species()
	return get_species()

/mob/living/carbon/human/get_mental_species()
	var/obj/item/organ/internal/brain/B = internal_organs_by_name[BP_BRAIN]
	if (B && B.species)
		return B.species.name
	return get_species()


/mob/proc/get_mental_species_datum()
	return get_species_datum()


/mob/living/carbon/human/get_mental_species_datum()
	var/obj/item/organ/internal/brain/B = internal_organs_by_name[BP_BRAIN]

	if (B && B.species)
		return B.species

	.=..()