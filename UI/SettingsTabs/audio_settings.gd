extends SettingsTab

var _masterVolume
var _musicVolume
var _sfxVolume

func _ready():
	_get_audio_settings()
	Load()

func Load():
	$VBoxContainer/MasterSlider.value = _masterVolume
	$VBoxContainer/MusicSlider.value = _musicVolume
	$VBoxContainer/SFXSlider.value = _sfxVolume

func Save():
	_get_audio_settings()

func Back():
	_reload_audio_settings()

func _reload_audio_settings():
	_update_bus(0, _masterVolume)
	_update_bus(1, _musicVolume)
	_update_bus(2, _sfxVolume)

func _get_audio_settings():
	_masterVolume = db_to_linear(AudioServer.get_bus_volume_db(0))
	_musicVolume = db_to_linear(AudioServer.get_bus_volume_db(1))
	_sfxVolume = db_to_linear(AudioServer.get_bus_volume_db(2))

func _update_bus(idx, value):
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))

func _on_master_slider_drag_ended(value_changed):
	if (value_changed):
		_update_bus(0, $VBoxContainer/MasterSlider.value)

func _on_music_slider_drag_ended(value_changed):
	if (value_changed):
		_update_bus(1, $VBoxContainer/MusicSlider.value)

func _on_sfx_slider_drag_ended(value_changed):
	if (value_changed):
		_update_bus(2, $VBoxContainer/SFXSlider.value)
