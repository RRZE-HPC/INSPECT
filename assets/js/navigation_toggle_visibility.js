function toggle_visibility(option) {
	var name = "";
	if (String(option).startsWith("dim")) {
		name = "dim"
	} else if (String(option).startsWith("rad")) {
		name = "rad"
	} else if (String(option).startsWith("weight")) {
		name = "weight"
	} else if (String(option).startsWith("kind")) {
		name = "kind"
	} else if (String(option).startsWith("coeff")) {
		name = "coeff"
	} else if (String(option).startsWith("dt")) {
		name = "dt"
	} else if (String(option).startsWith("machine")) {
		name = "machine"
	}

	if (String(option).endsWith("all")) {
		$("[class^="+name+"]").css("display","block");
	} else {
		$("[class^="+name+"]").css("display","none");
		$("."+String(option)).css("display","block");
	}
}
