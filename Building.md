# Dependencies

The darkGlass library depends on many other dark libraries:

  (This list may be incomplete as development progresses, but will be periodically updated.)

  * darkDynlib       https://github.com/chapmanworld/darkDynlib
  * darkCollections  https://github.com/chapmanworld/darkCollections
  * darkUnicode      https://github.com/chapmanworld/darkUnicode
  * darkIO           https://github.com/chapmanworld/darkIO
  * darkLog          https://github.com/chapmanworld/darkLog
  * darkThreading    https://github.com/chapmanworld/darkThreading
  * darkPlatform     https://github.com/chapmanworld/darkPlatform
  
Due to limitations in nested submodule support within git, these dependencies have not been added to the project, and must therefore be cloned separately.
Each project has paths configured with the assumption that all dark libraries are cloned into the same parent directory, as follows...

\darkLibs\darkDynlib
\darkLibs\darkCollections
\darkLibs\darkIO
\darkLibs\darkLog
\darkLibs\darkThreading
\darkLibs\darkPlatform
\darkLibs\darkGlass

You may rename the 'darkLibs' directory as you wish, so long as each of the sub-directories remain under the same parent directory.
Once you have cloned each of the projects, open the grpDarkGlassDependencies.groupproj file within the RAD Studio IDE and build all projects.

# Using darkGlass

There are two ways to use the darkGlass project. You can bind to the project dynamically or statically (mobile platforms must be static).
In the case of dynamic binding, add the following path to your project...

......\darkGlass\out\$(Platform)\$(Config)

(where ..... is the directory in which you cloned the dark library projects).
Then simply uses the two files...

  uses
    darkglass,
    darkglass.dynamic;
    

In order to use the darkGlass engine statically, the path to the output directory for each of the dependencies must be included in your project options...

  * .....\darkDynlib\out\$(Platform)\$(Config)
  * .....\darkCollections\out\$(Platform)\$(Config)
  * .....\darkIO\out\$(Platform)\$(Config)
  * .....\darkLog\out\$(Platform)\$(Config)
  * .....\darkThreading\out\$(Platform)\$(Config)
  * .....\darkPlatform\out\$(Platform)\$(Config)
  * .....\darkGlass\out\$(Platform)\$(Config)
  
The uses list should use the static library...

uses
  darkglass,
  darkglass.static;
  
  
  

