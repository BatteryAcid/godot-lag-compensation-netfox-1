## Godot + SteamMultiplayerPeer GDExtension Version (for P2P Multiplayer)

This version uses the SteamMultiplayerPeer GDExtension to enable use of the High Level Networking APIs (like Spawner, Synchronizer, RPCs) for a P2P multiplayer game over Steam networks.

> Tutorial: https://youtu.be/xugYYCz0VHU


Extension/Addon SteamMultiplayerPeer:  
- https://github.com/expressobits/steam-multiplayer-peer


Source Demo:  
- https://github.com/expressobits/steam-multiplayer-peer/tree/demo


This extension is built on the SteamNetworkingSockets APIs which is Steam’s lower level socket:
- https://partner.steamgames.com/doc/api/ISteamNetworkingSockets

The pre-compiled custom Godot build uses SteamNetworkingMessages:
- https://partner.steamgames.com/doc/api/ISteamNetworkingMessages


k_EResultLimitExceeded issue:
- https://github.com/expressobits/steam-multiplayer-peer/issues/15


Opening the pre-compiled build then installing the Extension issue:
- https://godotsteam.com/tutorials/common_issues/#using-the-module-and-plug-in


MacOS issues:
- https://github.com/expressobits/steam-multiplayer-peer/issues/9


---

# Basic Multiplayer Version

This is a fork of Brackeys first Godot project with an added basic multiplayer implementation. 

Uses MultiplayerSynchronizer, MultiplayerSpawner, and RPCs to sync player position, animation, and the moving platform in the game.

- See tutorial: https://youtu.be/V4a_J38XdHk


# First game in Godot
Project files for our video on making your first game in Godot.

Check out the videos on the [Brackeys YouTube Channel](http://youtube.com/brackeys).

Everything is free to use, also commercially (public domain).
