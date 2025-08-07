extends Control

@onready var line_edit_user_name: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer3/LineEdit_UserName
@onready var line_edit_passphrase: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer4/LineEdit_Passphrase

#func _ready() -> void:
	#pass

#func _process(delta: float) -> void:
	#pass

func _on_btn_login_pressed() -> void:
	#var username = "player1"
	#var password = "pass123"
	#GameNetwork.login_request.rpc_id(1, username, password)
	#login_request.rpc_id(1, username, password)
	#GameNetwork.attempt_login(username, password)
	GameNetwork.attempt_login(line_edit_user_name.text, line_edit_passphrase.text)
	#pass

func _on_btn_register_pressed() -> void:
	#var username = "player1"
	#var password = "pass123"
	#GameNetwork.login_request.rpc_id(1, username, password)
	#login_request.rpc_id(1, username, password)
	#GameNetwork.attempt_login(username, password)
	GameNetwork.attempt_login(line_edit_user_name.text, line_edit_passphrase.text)
	#pass
