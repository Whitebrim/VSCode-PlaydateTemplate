<img src="https://media.giphy.com/media/QhNgpDotBASjWj7asJ/giphy.gif" width="800" height="480" />

# Installation (Windows):  
0. **Unlock** `Build and Run (Simulator).ps1` file if it's locked: open properties and click unlock in the bottom of the window.
0. If you've installed Playdate SDK to the default path (Documents folder) then just **run** `ADD_ENV_VARIABLE.cmd` to add env variables:  
    * PLAYDATE_SDK_PATH to Playdate SDK
    * Adds Playdate SDK's bin folder to PATH (if it is not already added) to create `pdc` shortcut  

    **!!!** If you've changed default path - edit 6th line in `ADD_ENV_VARIABLE.cmd`, then run it.  
    `set SDKPATH="YOUR CUSTOM SDK PATH HERE"`
    
    This should be done only once, you need to restart VSCode after this.  
0. ~~Edit your `Code.exe` execatable (VSCode) to run with **admin rights** by default. You can find this file if you input this path to your explorer: `%appdata%\..\Local\Programs\Microsoft VS Code`~~  
    Open Windows PowerShell and change execution policy to RemoteSigned, so you can run closeSim.ps1 without admin rights:  
    Enter `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` into PowerShell then hit `Y`.
0. Open template folder with VSCode, **install recomended extensions** (popup will show in the lower right corner): `Lua`, `Lua Plus`. Then restart VSCode.  
0. If you want to change "build and run" key (default is Ctrl+Shift+B):  
    * **Ctrl + K, Ctrl + S**  
    * Change keybind for `Tasks: Run Build Task` (I've changed to **F5**)  
0. Your can find your `main.lua` file inside `Source` folder. Press your "Run Build Task" button, you should see "Template" text in playdate simulator.
0. Feel free to delete `dvd.lua` and all dvd-related lines from `main.lua` (marked `-- DEMO`)

## ⚠️ Don't forget to change your unique project info in `Source/pdxinfo`: "bundleID", "name", "author", "description". Read more about pdxinfo [here](https://sdk.play.date/Inside%20Playdate.html#pdxinfo). It's critical to change your game bundleID, so there will be no collisions with other games, installed via sideload.
  
# Installation (Linux):
0. If it's not already executable, navigate to this directory and make `build_and_run.sh` executable by running the following command:
    ```
    chmod +x build_and_run.sh
    ```
0. Add `PLAYDATE_SDK_PATH` to your `.bashrc`/`.zshrc` or equivalent, and source it; check it with: `env | grep -i playdate`
0. Launch/relaunch VSCode - if prompted to install extensions, click Yes.
0. If desired, change the default key sequence for Build/Run as described in the Windows instructions above

## ⚠️ Don't forget to change your unique project info in `Source/pdxinfo`: "bundleID", "name", "author", "description". Read more about pdxinfo [here](https://sdk.play.date/Inside%20Playdate.html#pdxinfo). It's critical to change your game bundleID, so there will be no collisions with other games, installed via sideload.

# Installation (Mac):
https://github.com/cadin/playdate-vscode-template
