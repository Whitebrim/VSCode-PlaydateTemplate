<img src="https://media.giphy.com/media/QhNgpDotBASjWj7asJ/giphy.gif" width="800" height="480" />

# Installation:
0) **Unlock** `closeSim.ps1` file if it's locked: open properties and click unlock in the bottom of the window.
1) If you've installed Playdate SDK to the default path (%userprofile%\Documents\PlaydateSDK\bin) then just **run** `ADD_ENV_VARIABLE.cmd` to add env variable to Playdate SDK. This should be done only once. If you've changed path - edit `ADD_ENV_VARIABLE.cmd`, change path to yours, then run it.
2) Edit your `Code.exe` execatable to run with **admin rights** by default. You can find this file if you input this path to your explorer: `%appdata%\..\Local\Programs\Microsoft VS Code`
3) Open template folder with VSCode, **install recomended extensions** (popup will show in the lower right corner): `Lua`, `Lua Plus`, `Playdate`. Then restart VSCode.
4) If you want to change "build and run" key:
* **Ctrl + K, Ctrl + S**
* Change keybind for `Tasks: Run Build Task` (I've changed to **F5**)
5) Your can find your `main.lua` file inside `source` folder. Press your "Run Build Task" button, you should see "Template" text in playdate simulator.
6) Feel free to delete `dvd.lua` and all dvd-related lines from `main.lua` (marked `-- DEMOO`)
