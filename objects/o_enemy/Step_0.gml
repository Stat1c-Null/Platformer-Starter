/// @description Insert description here
// You can write your code in this editor


//Kill enemy when colliding with them from the top
if(place_meeting(x,y-50,o_player)) {
	instance_destroy(self)	
}
