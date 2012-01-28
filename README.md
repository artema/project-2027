# Licensing

Licensed under the GNU Lesser GPL.

The following files are not a part of 2027 and/or are not released under the LGPL:

 * Any files under the /2027/Music directory.
 * Any files under the /2027/Textures directory.
 * Any files under the /2027/Sounds directory.
 * /2027/System/GameMedia.u
 * /2027/System/DeusEx.u
 * /2027/System/DeusExUI.u
 * /2027/System/MP5S.u
 * /2027/System/otpUIfix.u
 * /2027/System/VSDDX.u
 * Any files under the /System directory, except for the files with a rus or eng extension.
 * Any files from the DeusEx package, except for the files that were not released by Ion Storm with Deus Ex 1.1112fm. 

This repository contains only core game code and all game texts. You can easily modify other game files using the Deus Ex SDK.

WARNING: You won't be able to play original Deus Ex after installing this package, so use a separate copy of the game.

# How to setup this package:

 * Install the Deus Ex 1.112fm (it will be your %DeusEx% directory).
 * Install the Deus Ex SDK.
 * Install the latest version of 2027.
 * Change the WORK_PATH constant in %REPOSITORY%/build.properties file (just one it with the Notepad) to point to your Deus Ex folder and SOURCE_PATH path to your %REPOSITORY% folder (the same folder this file is located in).
 * Delete %DeusEx%/System/DeusEx.u and %DeusEx%/System/DeusExUI.u
 * Copy %REPOSITORY%/DeusEx.ini to your %DeusEx%/System folder (overwrite the existing file). 

# How to modify and compile game texts:

 * Modify texts from %REPOSITORY%/src or %REPOSITORY%/locale folders.
 * Use Apache Ant to run build.xml and launch the "UpdateTexts" task.
 * The compiler might show some errors, but it's OK.
 * Your compiled files will be placed into %DeusEx%/2027/System folder. Please note that all locale files will be placed to the %DeusEx%/System folder (you can find them by .eng and .rus extensions). 

WARNING: All files from the %REPOSITORY%/locale folder must be in UTF-8 encoding. All files from the GameTextsEng and GameTextsRus packages must be in Windows-1251 encoding. Editing these files from the Google code web interface will convert them to UTF-8 automatically.

# How to modify and compile game scripts:

 * Modify scripts from %REPOSITORY%/src folder.
 * Use Apache Ant to run build.xml and launch the "UpdatePackage" task.
 * Select a package to compile.
 * The compiler might show some errors, but it's OK.
 * Your compiled files will be placed into %DeusEx%/2027/System folder. 

# How to get and to use the Apache Ant:

 * Install JDK.
 * Install Apache Ant.
 * Open the command-line pompt (press Win+R and type cmd).
 * Type ant -buildfile D:\2027SourceDirectory\build.xml UpdateTexts (where D:\2027SourceDirectory is your 2027' sources directory and UpdateTexts or UpdatePackage is a name of the task you want to execute). 

# How to modify and compile game launcher:

 * Modify Visual Studio project from %REPOSITORY%/launcher folder.
 * In project options set your %DeusEx% folder as an output directory.
 * Use Resources.ru-RU.resx to build a Russian version of the launcher. 