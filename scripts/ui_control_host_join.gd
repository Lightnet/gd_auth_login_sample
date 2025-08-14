extends Control

@onready var ui_multiplayer: Control = $"."
@onready var ui_access: Control = $"../UIAccess"
@onready var line_edit_address: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineEdit_Address
@onready var line_edit_port: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineEdit_Port
@onready var label_network_type: Label = $"../UIDebug/VBoxContainer/HBoxContainer/Label_NetworkType"
@onready var client_counts: Label = $"../UIDebug/VBoxContainer/HBoxContainer2/ClientCounts"

func _ready() -> void:
	GameNetwork.player_failed_connected.connect(_on_failed_connected)
	GameNetwork.player_connected.connect(_on_player_connect)
	GameNetwork.player_disconnected.connect(_on_player_disconnect)
	ui_multiplayer.show()
	ui_access.hide()
	#pass

func _exit_tree() -> void:
	GameNetwork.player_failed_connected.disconnect(_on_failed_connected)
	GameNetwork.player_connected.disconnect(_on_player_connect)
	
	GameNetwork.player_disconnected.disconnect(_on_player_disconnect)
	
	#player_disconnected

func _on_failed_connected()->void:
	ui_multiplayer.show()
	ui_access.hide()
	#pass
func _on_player_connect(peer_id: int, player_info: Dictionary):
	client_counts.text = str(len(multiplayer.get_peers()))
	pass
func _on_player_disconnect(peer_id: int):
	client_counts.text = str(len(multiplayer.get_peers()))
	pass

func _on_btn_host_pressed() -> void:
	label_network_type.text = "SERVER"
	GameNetwork.start_server(line_edit_port.text.to_int())
	ui_multiplayer.hide()
	ui_access.show()
	#pass
	
func _on_btn_join_pressed() -> void:
	label_network_type.text = "CLIENT"
	GameNetwork.join_server(line_edit_address.text,line_edit_port.text.to_int())
	Global.show_connection_status()
	ui_multiplayer.hide()
	ui_access.show()
	#pass
	
