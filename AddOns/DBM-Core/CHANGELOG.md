# Deadly Boss Mods Core

## [1.13.70](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.70) (2021-03-23)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.69...1.13.70) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Classic/releases)

- Bump version  
- Fix any potential issues with nils in profiles. (Retail sync) (#706)  
- Forgot the self.Bars references  
- Retail sync. (DBT) (#705)  
- Broadcast pizza timer cancellations (Retail sync) (#704)  
- Missed some things  
- Actually port the special warning trivial downgrade feature to classic  
- Plug all classic dungeon levels into data table, this will improve auto logging to stop logging dungeons when out leveling them and also auto downgrade special warnings to less emphasized ones when >= 10 levels the dungeons max level range  
- Migrate over skinning API as a temporary solution till we merge DBT (#699)  
- Random sync from retail (To bump alpha, and update LibDurability) (#703)  
- Fix auto logging for naxx, since instance check was still in wrath instances. I left it in wrath instances but a copy of it also exists in classic instances now.  
    Also added every single classic dungeon, even trivial ones for now because I can't be bothered to figure out which ids are actually associated with the max level dungeons. This will of course make the auto logger literally log everything even deadmines, but before this alpha that's what it was doing anyways so it'll be fine.  
- Added more test bars buttons to GUI that don't require useres trying to find it in a different place.  
- Fix a regression where somehow istrivial lost it's mod protocotype version of check. Fixes #700  
- Small tweak  
- Die twitch, die. (#698)  
- Added moveme buttons to other timers option panels  
- Fix DBM-Classic blocking azeroth world bosses from loading  
- Update bug\_report.md  
    Remove twitch notice  
- Fix #695 (#696)  
    Define utility function BEFORE its called anywhere else.  
- Update luacheck  
- Start prepping classic DBM for migration to 9.x client.  
- Update ci.yml  
    Add WAGO API Token  
- Add Wago project ID  
- Also fixed a bug where AddMsg would fail to read chatframe setting when AddMsg is called by a mod and not core. Self would inherit the wrong parent  
- Improve nil check on DBM:AddMsg based on feedback  
- Prepare DBM-Classic for handling TBC instances and modern mods using modern IsTrivial checks like karazhan, so when they are ported over they just work.  
- Update localization.es.lua (#693)  
- Update localization.fr.lua (#692)  
- Revert upvalue, local cap  
- Fix unavailable icon (#691)  
- Message prefix typo from retail sync (#690)  
- Fixes to last to actually do what was intended  
- Allow CreatePizzaTimer object to be called with "whisper" arg by external modders using function to unicast timers. Also allows DBM to accept pizza timers sent this way via whisper sync handler.  
- Ensure Start and Stop timer actions reset paused status  
- Change antispam to 10  
- Ignore mark casts by spirits, only track main bosses Closes #689  
- Message prefix typo from retail sync (#688)  
- Sync this to classic too  
- Sync bar pausing to classic  
