extends CenterContainer

class_name SettingsMenu

signal closing

func Load():
	visible = true
	for child in $VBoxContainer/TabContainer.get_children():
		if (is_instance_of(child, SettingsTab)):
			child.Load()

func _on_apply_button_pressed():
	for child in $VBoxContainer/TabContainer.get_children():
		if (is_instance_of(child, SettingsTab)):
			child.Save()

func _on_back_button_pressed():
	visible = false
	closing.emit()
