/// @description 
hsp = 0
vsp = 0
grv = 0.2
walk_speed = 7
jump_power = -9
jump_max = 2
jump_current = jump_max

// Dash variables
dash_speed = 15;
dash_duration = 12;        // frames the dash lasts
dash_cooldown = 30;        // frames before you can dash again
dash_timer = 0;
dash_cooldown_timer = 0;
is_dashing = false;
can_dash = true;           // resets when grounded (optional)
dash_direction = 1;        // 1 = right, -1 = left