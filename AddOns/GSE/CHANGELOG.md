# GSE2: Gnome Sequencer Enhanced

## [2.6.16](https://github.com/TimothyLuke/GnomeSequencer-Enhanced/tree/2.6.16) (2020-10-19)
[Full Changelog](https://github.com/TimothyLuke/GnomeSequencer-Enhanced/compare/2.6.15...2.6.16) [Previous Releases](https://github.com/TimothyLuke/GnomeSequencer-Enhanced/releases)

- #720 Limit Macro names to 28 Characters in length  
- #724 #669 show '$$' prefix in editor  
- #724 #669 Prefixing a spell line with '$$' will force GSE to use the specific version of a spell.  eg'/cast Crusade' will return '/cast Avenging wrath' NORMALLY HOWEVER '$$/cast Crusade' will return '/cast Crusade'.  This will work for Shadow Priests where they need to cast Void Bolt specifically in certain circumstances.  
- #724 add back in Azerite Essences  
- #724 replace the Statics.BaseSpellTable with FindBaseSpellByID.  Still need to manually override Azerite Essences and may need to do the same for Covenant abilities.  
