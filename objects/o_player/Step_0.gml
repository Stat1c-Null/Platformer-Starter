//Get Player Input
key_dash = keyboard_check_pressed(vk_shift);
key_left = keyboard_check(ord("A"))
key_right = keyboard_check(ord("D"))
key_jump = keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("W"))

//Calculate movement
var move = key_right - key_left
hsp = move * walk_speed

//Gravity
vsp = vsp + grv

//Jump
if(place_meeting(x, y+1, o_wall)) and (key_jump) and jump_current > 0
{
	vsp = jump_power
	jump_current -= 1
} else {//DOUBLE JUMPS
	// In air
	if(key_jump) and jump_current > 0 {
		vsp = jump_power
		jump_current -= 1
	}
}


// --- Trigger dash ---
if (key_dash && !is_dashing && dash_cooldown_timer <= 0 && can_dash) {
    is_dashing = true;
    dash_timer = dash_duration;
    dash_cooldown_timer = dash_cooldown;
    can_dash = false;
    
    // Use facing direction, or input direction if pressed
    if (keyboard_check(key_right))      dash_direction = 1;
    else if (keyboard_check(key_left))  dash_direction = -1;
    else                                dash_direction = image_xscale; // facing dir
}

// --- Handle active dash ---
if (is_dashing) {
    hsp = dash_speed * dash_direction;
    vsp = 0;              // freeze vertical movement (Celeste-style)
    dash_timer--;
    
    if (dash_timer <= 0) {
        is_dashing = false;
        hsp = dash_speed * dash_direction * 0.5; // soften exit so you don't stop dead
    }
}

// --- Cooldown tick ---
if (dash_cooldown_timer > 0) dash_cooldown_timer--;

// --- Refresh dash on ground (optional, Celeste-style single air dash) ---
if (place_meeting(x, y + 1, o_wall)) {
    can_dash = true;
}


//Horizontal collision
if(place_meeting(x+hsp, y, o_wall)){
	//Check if collision ended
	while(not place_meeting(x+sign(hsp), y, o_wall)){
		x = x + sign(hsp)	
	}
	hsp = 0	
}

x = x + hsp

//Vertical collision
if(place_meeting(x, y+vsp, o_wall)){
	//Check if collision ended
	while(not place_meeting(x, y+sign(vsp), o_wall)){
		y = y + sign(vsp)	
	}
	vsp = 0	
	jump_current = jump_max
}


y = y + vsp

//Animation
if(not place_meeting(x, y+1, o_wall))
{
	//In the Air
	sprite_index = s_jump
	image_speed = 0
	if (sign(vsp) > 0) image_index = 1; else image_index = 0;
} else {
	image_speed = 1
	if(hsp == 0)
	{
		sprite_index = s_dudeidle
	} else {
		sprite_index = s_run	
	}
}

//Flip player sprite
if(hsp != 0) image_xscale = sign(hsp)

//Restart the game if player is falling out of the level
if(y - 1000 > room_height) {
	game_restart()
}




