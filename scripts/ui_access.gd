extends Control

@onready var line_edit_user_name: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer3/LineEdit_UserName
@onready var line_edit_passphrase: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer4/LineEdit_Passphrase
@onready var ui_chat: Control = $"../UIChat"
@onready var ui_access: Control = $"."

func _ready() -> void:
	GameNetwork.login_succeeded.connect(_on_login_succeeded)
	pass
	
func _exit_tree() -> void:
	GameNetwork.login_succeeded.disconnect(_on_login_succeeded)
	pass
	
func _on_login_succeeded(peer_id: int, token: String):
	#print("PASS LOGIN...")
	ui_access.hide()
	ui_chat.show()
	pass

func _on_btn_login_pressed() -> void:
	GameNetwork.attempt_login(line_edit_user_name.text, line_edit_passphrase.text)

func _on_btn_register_pressed() -> void:
	GameNetwork.attempt_login(line_edit_user_name.text, line_edit_passphrase.text)
