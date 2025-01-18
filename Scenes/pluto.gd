extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	# Add gravity from Area2D
	# This is cool, but probably too complex for my current plan
	#velocity += get_gravity() * delta
	
	var center = Vector2(0,0);
	
	var distToCenter = global_position - center
	
	velocity = distToCenter.orthogonal().limit_length(SPEED);
	
	#TODO move position in/out and increase/decrease speed
	#TODO if speed lower than a certain amount start falling back in towards the center?
		#could also make this proportional, so lets say the closer you are to the sun the faster you need to go to prevent falling in. 

	move_and_slide()
