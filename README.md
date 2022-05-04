<img src="https://media.giphy.com/media/QhNgpDotBASjWj7asJ/giphy.gif" width="800" height="480" />

# Installation:  
0. **Unlock** `closeSim.ps1` file if it's locked: open properties and click unlock in the bottom of the window.  
0. If you've installed Playdate SDK to the default path (C:\user\%Username%\Documents\PlaydateSDK) then just **run** `ADD_ENV_VARIABLE.cmd` to add env variables:  
    * PLAYDATE_SDK_PATH to Playdate SDK
    * Adds Playdate SDK's bin folder to PATH (if it is not already added) to create `pdc` shortcut  

    If you've changed default path - edit 3rd line in `ADD_ENV_VARIABLE.cmd`, then run it.  
    This should be done only once, you need to restart VSCode after this.  
0. Edit your `Code.exe` execatable (VSCode) to run with **admin rights** by default. You can find this file if you input this path to your explorer: `%appdata%\..\Local\Programs\Microsoft VS Code`  
0. Open template folder with VSCode, **install recomended extensions** (popup will show in the lower right corner): `Lua`, `Lua Plus`, `Playdate`. Then restart VSCode.  
0. If you want to change "build and run" key:  
    * **Ctrl + K, Ctrl + S**  
    * Change keybind for `Tasks: Run Build Task` (I've changed to **F5**)  
0. Your can find your `main.lua` file inside `source` folder. Press your "Run Build Task" button, you should see "Template" text in playdate simulator.  
0. Feel free to delete `dvd.lua` and all dvd-related lines from `main.lua` (marked `-- DEMOO`)
