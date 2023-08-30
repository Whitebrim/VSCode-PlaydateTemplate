<img src="https://media.giphy.com/media/QhNgpDotBASjWj7asJ/giphy.gif" width="800" height="480" />

# Installation:

1. **Make** the `BuildAndRun.sh` script executable if it isn't already:  
    ```bash
    chmod +x BuildAndRun.sh
    ```

2. If you've installed the Playdate SDK to the default path (Documents folder), then just **run** `setup.sh` to add environment variables:  
    * PLAYDATE_SDK_PATH to Playdate SDK
    * Adds Playdate SDK's bin folder to PATH (if it is not already added) to create `pdc` shortcut  

    **!!!** If you've changed the default path, edit the appropriate section in `setup.sh` to set your custom SDK path, then run it.  
    ```bash
    SDKPATH="/path/to/your/custom/sdk"
    ```

    This should be done only once. You need to restart VSCode after this.

3. Open the template folder with VSCode, **install the recommended extensions** (a popup will show in the lower right corner): `Lua`, `Lua Plus`. Then restart VSCode.

4. If you want to change the "build and run" key (default is Ctrl+Shift+B):  
    * **Cmd + K, Cmd + S**  
    * Change the keybind for `Tasks: Run Build Task` (You can change it to another key, for example, **F5**).

5. You can find your `main.lua` file inside the `source` folder. Press your "Run Build Task" button, and you should see the "Template" text in the Playdate simulator.

6. Feel free to delete `dvd.lua` and all DVD-related lines from `main.lua` (marked `-- DEMOO`).

7. ## ⚠️ Don't forget to change your unique project info in `source/pdxinfo`: "bundleID", "name", "author", "description". Read more about pdxinfo [here](https://sdk.play.date/Inside%20Playdate.html#pdxinfo).  
    It's critical to change your game bundleID, so there will be no collisions with other games, installed via sideload.