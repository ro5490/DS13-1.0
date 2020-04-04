/*
	Player datums are created and stored on a one-per-ckey basis. They persist for the entire session, across any number of reconnects and mobs.
	Use them to store data which needs to persist in such a manner.
*/
/datum/player
	var/key
	var/client
	var/mob

/datum/player/New(var/newkey)
	src.key = newkey
	.=..()

/datum/player/proc/Login()
	GLOB.logged_in_event.raise_event(src)
	return

/datum/player/proc/get_mob()
	return locate(mob)

/datum/player/get_client()
	return locate(client)



/mob/proc/register_client_and_player()
	if (!client || !ckey)
		return

	var/datum/player/me = get_or_create_player(ckey)
	me.client = "\ref[src.client]"
	me.mob = "\ref[src]"

	world << "Client and mob registered: 	[me.client]	[me.mob]|[me.get_mob()]"

	//Existing stuff i might replace
	GLOB.player_list |= src
	GLOB.key_to_mob[key] = src



/mob/proc/player_login()
	register_client_and_player()

	var/datum/player/me = get_or_create_player(key)
	me.Login()



/*
	Getter procs
*/
/proc/get_or_create_player(var/key)
	key = ckey(key)
	if (!GLOB.players[key])
		GLOB.players[key] = new /datum/player(key)
	return GLOB.players[key]


/mob/proc/get_player()
	if (!client)	//TODO: Figure out how to make this work for disconnected players in future. I know the key field is not nulled
		return null

	return get_or_create_player(client.ckey)