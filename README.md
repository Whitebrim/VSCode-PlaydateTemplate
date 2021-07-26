<img src="https://media.giphy.com/media/QhNgpDotBASjWj7asJ/giphy.gif" width="800" height="480" />

# Installation:
1) **Unlock** `closeSim.ps1` file if it's locked: open properties and click unlock in the bottom of the window.
2) If you've installed Playdate SDK to the default path (C:\Program Files (x86)\Playdate) then **run** `PLAYDATE_SDK.cmd` to add env variable to Playdate SDK. This should be done only once. If you've changed path - edit `PLAYDATE_SDK.cmd`, change path to yours, then run it.
3) If you have installed SDK ver `1.1.0`/`1.2.0`/`1.2.1` you should apply workaround from [here](https://devforum.play.date/t/simulator-doesnt-open-build-launched-via-command-line-1-1/1667):
* Rename `YOUR_SDK_PATH_HERE\Disk\System\Launcher.pdx` folder to something else, for example `Launcher2.pdx`
4) Only if you've changed installation path change it in `.vscode/settings.json` too:
```
"Lua.workspace.library": {
  "YOUR_PATH_HERE\\CoreLibs": true
}
```
5) Edit your `Code.exe` execatable to run with **admin rights** by default. You can find this file if you input this path to your explorer: `%appdata%\..\Local\Programs\Microsoft VS Code`
6) Open template folder with VSCode, **install recomended extensions** (popup will show in the lower right corner): `Lua`, `Lua Plus`, `Playdate`. Then restart VSCode.
7) If you want to change "build and run" key:
* **Ctrl + K, Ctrl + S**
* Change keybind for `Tasks: Run Build Task` (I've changed to **F5**)
8) Your can find your `main.lua` file inside `source` folder. Press your "Run Build Task" button, you should see "Template" text in playdate simulator.
9) Feel free to delete `dvd.lua` and all dvd-related lines from `main.lua`
