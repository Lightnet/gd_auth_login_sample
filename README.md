# dg_auth_login_sample

# License: MIT

# GodotEngine: 4.4.1

# Information:
  Sample build for auth for login and message test. This is just debug test and how it works.

  learning how rpc api mode for authority and any_peer works when using the function calls.

  By using the Notify Message to handle push events to know if the server or client are working correctly in sync.

# Features:
 - [x] Host
 - [x] Join
 - [x] Notify Message Simple
 - [x] Simple Connection Status for fail connection.
 - [x] Simple chat message send by using the Notify Message.

# multiplayer:
  When handle the login. They need to independent when login. Client need to request remote call to login as not to boardcast to clients but to server.

  Still need fitler out for which is server or client to handle login else you get some error saying you can't call self which is server and other errors.

  Well try to keep it very simple to filter out which is server or client when using the function. Since server can't call self in the rpc. But user normal call function.
```
# Client-side function to initiate login
func attempt_login(username: String, password: String):
	if not multiplayer.is_server():
		print("Sending login request for %s" % username)
		login_request.rpc_id(1, username, password)
	else:
		print("Server to login")
		login_request( username, password)
```
  When using the remote call login_request.rpc_id(1) 1 is server to make sure not clints. Since login checks.
  As for the server login. One reason is can be use to access player data to get and set data to hanle it. It depend on the setup.

```
@rpc("any_peer", "call_remote", "reliable")
func login_request(username: String, password: String):
	print("login_request is_server: ", multiplayer.is_server())
	if multiplayer.is_server():
		#do something if server for checking access login
		# ...
		# login_response.rpc_id(peer_id, result, token, reason)
		pass
```
  It will prcess the login test sample database. It would send back to client either pass or fail login.

```
var peer_id = multiplayer.get_remote_sender_id()
```
 Note that if server call the function return 0 since it not client remote id. If not the id must be great than 1. 1 is server by default.

```
login_response.rpc_id(peer_id, result, token, reason)
```
  So we need to call remote to client did the login request back to client.

```
login_response(result, token, reason)
```
  If server it would normal function call and not boardcast else it would close all login access when sync.

```
# Respond to client with login result
@rpc("authority", "call_local", "reliable")
func login_response(result: bool, token: String, reason: String):
	var peer_id = multiplayer.get_unique_id()
	if result:
		players[peer_id]["token"] = token
		emit_signal("login_succeeded", peer_id, token)
		print("Login succeeded for peer %d, token: %s" % [peer_id, token])
	else:
		emit_signal("login_failed", peer_id, reason)
		print("Login failed for peer %d: %s" % [peer_id, reason])
```
  There are signal to handle client event to push message and data.

# Notes:
- To learn how to use authority, any_peer, remote to make sure go to client to server when login test.
- Note that user and password is expose not use for production since not set up for encrytion. This just a sample.
- Note that compress file pack can be open. If there API keys that user should not access. Unless they public key for access pulbic lobby.
- This is just notes to refs.
