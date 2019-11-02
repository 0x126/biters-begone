# Biters Begone!

Pretty simple mod. It does two things, and does those things well:

- It prevents anything that belongs to the enemy force (biters, biter bases and worms in vanilla) from spawning on map chunk generation, by removing `autoplace`'s peaks from their prototypes.
- When first loading a save, **either new or existing**, it erases all enemy forces already in the map.

Basically, all biters go *kapoot* and no new ones will ever spawn while this mod is active. And because the map settings are left alone, disabling or removing "Biters Begone!" will restore biter spawning without any future side-effects. Neat!

Hope you like it [KoS](https://www.youtube.com/channel/UCTIV3KbAvaGEyNjoMoNaGtQ)!

## Changelog
> **2.0.0**
> - added RSO compatibility (requires user input for now, ty Zangiry!)
> - mod now nils autoplace peaks, not autoplace outright (less conflicts with other mods)
> **1.1.0**
> - `rechart()` the map on biter spring cleaning to clear all that nasty red stuff
> - added a "few" more flavour messages (ty Lupus!)