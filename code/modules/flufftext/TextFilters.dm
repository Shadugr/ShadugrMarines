//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/proc/Intoxicated(phrase)
	phrase = html_decode(phrase)
	var/leng=length(phrase)
	var/counter=length(phrase)
	var/newphrase=""
	var/newletter=""
	while(counter>=1)
		newletter=copytext_char(phrase,(leng-counter)+1,(leng-counter)+2)
		if(rand(1,3)==3)
			if(lowertext(newletter)=="o") newletter="u"
			if(lowertext(newletter)=="s") newletter="ch"
			if(lowertext(newletter)=="a") newletter="ah"
			if(lowertext(newletter)=="c") newletter="k"
		switch(rand(1,7))
			if(1,3,5) newletter="[lowertext(newletter)]"
			if(2,4,6) newletter="[uppertext(newletter)]"
			if(7) newletter+="'"
			//if(9,10) newletter="<b>[newletter]</b>"
			//if(11,12) newletter="<big>[newletter]</big>"
			//if(13) newletter="<small>[newletter]</small>"
		newphrase+="[newletter]";counter-=1
	return newphrase

/proc/NewStutter(phrase,stunned)
	phrase = html_decode(phrase)

	var/list/split_phrase = splittext(phrase," ") //Split it up into words.

	var/list/unstuttered_words = split_phrase.Copy()
	var/i = rand(1,3)
	if(stunned) i = length(split_phrase)
	for(,i > 0,i--) //Pick a few words to stutter on.

		if (!length(unstuttered_words))
			break
		var/word = pick(unstuttered_words)
		unstuttered_words -= word //Remove from unstuttered words so we don't stutter it again.
		var/index = split_phrase.Find(word) //Find the word in the split phrase so we can replace it.

		//Search for dipthongs (two letters that make one sound.)
		var/first_sound = copytext(word,1,3)
		var/first_letter = copytext(word,1,2)
		if(lowertext(first_sound) in list("ch","th","sh"))
			first_letter = first_sound

		//Repeat the first letter to create a stutter.
		var/rnum = rand(1,3)
		switch(rnum)
			if(1)
				word = "[first_letter]-[word]"
			if(2)
				word = "[first_letter]-[first_letter]-[word]"
			if(3)
				word = "[first_letter]-[word]"

		split_phrase[index] = word

	return strip_html(jointext(split_phrase," "))

/proc/DazedText(phrase)
	phrase = html_decode(phrase)
	var/result = ""
	var/i = rand(5,10)
	if(length(phrase)<2)
		for(,i > 0,i--)
			result += pick("E","A","O","U")
			if(i > 1)
				result += "-"
		return result
	var/firstletter = copytext(phrase,1,2)
	var/secondletter = copytext(phrase,2,3)
	result = firstletter
	for(,i > 0,i--)
		result += "-"+secondletter
	return result

/proc/Stagger(mob/M,d) //Technically not a filter, but it relates to drunkenness.
	step(M, pick(d,turn(d,90),turn(d,-90)))

/proc/Ellipsis(original_msg, chance = 50)
	if(chance <= 0) return "..."
	if(chance >= 100) return original_msg

	var/list/words = splittext(original_msg," ")
	var/list/new_words = list()

	var/new_msg = ""

	for(var/w in words)
		if(prob(chance))
			new_words += "..."
		else
			new_words += w

	new_msg = jointext(new_words," ")

	return new_msg
