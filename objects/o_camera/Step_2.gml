/// @description Camera Zoom and Follow the player
// Get current camera position
var camX = camera_get_view_x(camera)
var camY = camera_get_view_y(camera)
var camW = camera_get_view_width(camera)
var camH = camera_get_view_height(camera)
var zoom_in_w_max = 640
var zoom_in_h_max = 360
var zoom_out_w_max = 1920
var zoom_out_h_max = 1080

//Panning
if (mouse_check_button(mb_middle)) {
	var move_x = device_mouse_x_to_gui(0) - mouse_x_previous
	var move_y = device_mouse_y_to_gui(0) - mouse_y_previous
	
	camX -= move_x
	camY -= move_y
} else {
	//Follow the player 
	//Set the target camera position
	var targetX = o_player.x - camW/2 // + 17
	var targetY = o_player.y - camH/2
	
	//Clamp the target to room bounds
	targetX = clamp(targetX, 0, room_width - camW)
	targetY = clamp(targetY, 0, room_height - camH)
	
	//Smoothly move the camera to the target position
	camX = lerp(camX, targetX, CAM_SMOOTH)
	camY = lerp(camY, targetY, CAM_SMOOTH)
}

//Zooming
var wheel = mouse_wheel_down() - mouse_wheel_up()

if (wheel != 0){
	wheel *= zoom_speed
	
	// Add to size
	var addW = camW * wheel
	var addH = camH * wheel
	
	//Max Zoom Out
	if (camW <= zoom_out_w_max and camH <= zoom_out_h_max) {
		camW += addW
		camH += addH
	} else {
		camW = zoom_out_w_max
		camH = zoom_out_h_max
	}
	
	//Max Zoom In
	if (camW >= zoom_in_w_max and camH >= zoom_in_h_max) {
		camW += addW
		camH += addH
	} else {
		camW = zoom_in_w_max
		camH = zoom_in_h_max
	}
	
	// Position
	camX -= addW / 2
	camY -= addH / 2
}

//Apply camera position
camera_set_view_pos(camera, camX, camY)
camera_set_view_size(camera, camW, camH)
//Store previous position
mouse_x_previous = device_mouse_x_to_gui(0)
mouse_y_previous = device_mouse_y_to_gui(0)