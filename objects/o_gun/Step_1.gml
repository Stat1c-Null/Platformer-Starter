//Move gun to player position
x = o_player.x
y = o_player.y-2
//Gun follow the mouse
image_angle = point_direction(x,y,mouse_x, mouse_y)

firingdelay -= 1
recoil = max(0, recoil - 1)//Make sure recoil doesnt go below 0`
if(mouse_check_button(mb_left)) and (firingdelay < 0) {
	firingdelay = delay_value
	recoil = recoil_value
	with(instance_create_layer(x,y,"Bullets", o_bullet))
	{
		speed = 25
		//Make bullet move at same direction as gun
		direction = other.image_angle + random_range(-other.gunSpread, other.gunSpread)
		image_angle = direction
	}
}

//Recoil
x = x - lengthdir_x(recoil, image_angle)
y = y - lengthdir_y(recoil, image_angle)

//Flip gun
if(image_angle > 90) and (image_angle < 270) {
	image_yscale = -1
} else {
	image_yscale = 1	
}



