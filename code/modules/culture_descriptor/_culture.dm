/decl/cultural_info
	var/name
	var/desc_type
	var/description
	var/economic_power = 1
	var/language
	var/name_language
	var/default_language
	var/list/additional_langs
	var/list/secondary_langs
	var/category
	var/subversive_potential = 0
	var/hidden
	var/hidden_from_codex
	var/list/qualifications

/decl/cultural_info/New()

	if(!default_language)
		default_language = language

	if(!name_language && default_language)
		name_language = default_language

	// Remove any overlap for the sake of presentation.
	if(LAZYLEN(additional_langs))
		additional_langs -= language
		additional_langs -= name_language
		additional_langs -= default_language
		UNSETEMPTY(additional_langs)

	if(LAZYLEN(secondary_langs))
		secondary_langs -= language
		secondary_langs -= name_language
		secondary_langs -= default_language
		if(LAZYLEN(additional_langs))
			secondary_langs -= additional_langs
		UNSETEMPTY(secondary_langs)

	..()

/decl/cultural_info/proc/get_random_name(var/gender)
	var/decl/language/_language
	if(name_language)
		_language = decls_repository.get_decl(name_language)
	else if(default_language)
		_language = decls_repository.get_decl(default_language)
	else if(language)
		_language = decls_repository.get_decl(language)
	if(_language)
		return _language.get_random_name(gender)
	return capitalize(pick(gender==FEMALE ? GLOB.first_names_female : GLOB.first_names_male)) + " " + capitalize(pick(GLOB.last_names))

/decl/cultural_info/proc/sanitize_name(var/new_name)
	return sanitizeName(new_name)

#define COLLAPSED_CULTURE_BLURB_LEN 48
/decl/cultural_info/proc/get_description(var/header, var/append, var/verbose = TRUE)
	var/list/dat = list()
	dat += "<table padding='8px'><tr>"
	dat += "<td width='260px'>"
	dat += "[header ? header : "<b>[desc_type]:</b>[name]"]<br>"
	if(verbose)
		dat += "<small>"
		dat += "[jointext(get_text_details(), "<br>")]"
		dat += "</small>"
	dat += "</td><td width>"
	if(verbose || length(get_text_body()) <= COLLAPSED_CULTURE_BLURB_LEN)
		dat += "[get_text_body()]"
	else
		dat += "[copytext(get_text_body(), 1, COLLAPSED_CULTURE_BLURB_LEN)] \[...\]"
	dat += "</td>"
	if(append)
		dat += "<td width = '100px'>[append]</td>"
	dat += "</tr></table><hr>"
	return jointext(dat, null)
#undef COLLAPSED_CULTURE_BLURB_LEN

/decl/cultural_info/proc/get_text_body()
	return description

/decl/cultural_info/proc/get_text_details()
	. = list()
	var/list/spoken_langs = get_spoken_languages()
	if(LAZYLEN(spoken_langs))
		var/list/spoken_lang_names = list()
		for(var/thing in spoken_langs)
			var/decl/language/lang = decls_repository.get_decl(thing)
			spoken_lang_names |= lang.name
		. += "<b>Language(s):</b> [english_list(spoken_lang_names)]."
	if(LAZYLEN(secondary_langs))
		var/list/secondary_lang_names = list()
		for(var/thing in secondary_langs)
			var/decl/language/lang = decls_repository.get_decl(thing)
			secondary_lang_names |= lang.name
		. += "<b>Optional language(s):</b> [english_list(secondary_lang_names)]."
	if(!isnull(economic_power))
		. += "<b>Economic power:</b> [round(100 * economic_power)]%"

/decl/cultural_info/proc/get_spoken_languages()
	. = list()
	if(language)                  . |= language
	if(default_language)          . |= default_language
	if(LAZYLEN(additional_langs)) . |= additional_langs

/decl/cultural_info/proc/get_formal_name_suffix()
	return

/decl/cultural_info/proc/get_formal_name_prefix()
	return

/decl/cultural_info/proc/get_qualifications()
	return qualifications

/decl/cultural_info/proc/get_possible_personal_goals(var/department_refs)
	return
