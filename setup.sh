#!/bin/bash

# Function to check if SDKPATH is valid
validate_sdkpath() {
    if [[ ! $TEST && ( ! -f "$SDKPATH/bin/pdc" || ! -d "$SDKPATH/bin/Playdate Simulator.app" ) ]]; then
        echo "Error: pdc executable or Playdate Simulator.app not found in $SDKPATH/bin/"
        return 1
    fi
    return 0
}

# Function to update the shell profile
update_shell_profile() {
    if [[ -f ~/.zshrc ]]; then
        SHELL_PROFILE=~/.zshrc
    elif [[ -f ~/.bashrc ]]; then
        SHELL_PROFILE=~/.bashrc
    elif [[ -f ~/.bash_profile ]]; then
        SHELL_PROFILE=~/.bash_profile
    fi

    if [[ $TEST || $MENU_CHOICE ]]; then
        echo -e "\033[1;33mDiff for $SHELL_PROFILE:\033[0m"
        diff --color=always $SHELL_PROFILE <(echo -e "$(cat $SHELL_PROFILE)\nexport PLAYDATE_SDK_PATH=$SDKPATH\nexport PATH=\$PATH:$SDKPATH/bin")
    fi

    if [[ ! $TEST ]]; then
        echo "export PLAYDATE_SDK_PATH=$SDKPATH" >> $SHELL_PROFILE
        echo "export PATH=\$PATH:$SDKPATH/bin" >> $SHELL_PROFILE
        if [[ "$SHELL" == "/bin/zsh" && "$SHELL_PROFILE" == "~/.zshrc" ]]; then
            source $SHELL_PROFILE
        elif [[ "$SHELL" == "/bin/bash" && "$SHELL_PROFILE" == "~/.bashrc" ]]; then
            source $SHELL_PROFILE
        fi

    fi
}

# Function to update ~/.Playdate/startup.sh
update_startup() {
    if [[ $TEST || $MENU_CHOICE ]]; then
        echo -e "\033[1;33mDiff for ~/.Playdate/startup.sh:\033[0m"
        diff --color=always ~/.Playdate/startup.sh <(sed "s|/usr/local/playdate/gcc-arm-none-eabi-9-2019-q4-major/bin:.*bin|/usr/local/playdate/gcc-arm-none-eabi-9-2019-q4-major/bin:$SDKPATH/bin|" ~/.Playdate/startup.sh)
    fi

    if [[ ! $TEST ]]; then
        sed -i '' "s|/usr/local/playdate/gcc-arm-none-eabi-9-2019-q4-major/bin:.*bin|/usr/local/playdate/gcc-arm-none-eabi-9-2019-q4-major/bin:$SDKPATH/bin|" ~/.Playdate/startup.sh
    fi
}

# Function to update ~/.Playdate/config
update_config() {
    if [[ $TEST || $MENU_CHOICE ]]; then
        echo -e "\033[1;33mDiff for ~/.Playdate/config:\033[0m"
        diff --color=always ~/.Playdate/config <(sed "s|SDKRoot.*|SDKRoot\t$SDKPATH|" ~/.Playdate/config)
    fi

    if [[ ! $TEST ]]; then
        sed -i '' "s|SDKRoot.*|SDKRoot\t$SDKPATH|" ~/.Playdate/config
    fi
}

# Manual argument parsing
while [[ $# -gt 0 ]]; do
    case "$1" in
        -a|--All)
            ALL=true
            SDKPATH="$2"
            shift 2
            ;;
        -t|--test)
            TEST=true
            SDKPATH="$2"
            shift 2
            ;;
        -*)
            # Iterate over each character in the flag (e.g., -cp will check 'c' and 'p')
            for (( i=1; i<${#1}; i++ )); do
                char="${1:$i:1}"
                case "$char" in
                    p)
                        PATH_UPDATE=true
                        ;;
                    c)
                        CONFIG_UPDATE=true
                        ;;
                    s)
                        STARTUP_UPDATE=true
                        ;;
                    *)
                        echo "Invalid option: -$char" >&2
                        exit 1
                        ;;
                esac
            done
            SDKPATH="$2"
            shift 2
            ;;
        *)
            echo "Invalid argument: $1" >&2
            exit 1
            ;;
    esac
done

# If no flags are provided, show the menu
if [[ -z $ALL && -z $PATH_UPDATE && -z $CONFIG_UPDATE && -z $STARTUP_UPDATE && -z $TEST ]]; then
    echo "1. Update \$PATH"
    echo "2. Update config + startup.sh"
    echo "3. Update All"
    echo "4. Test (Dry run)"
    read -p "Please select an option: " choice

    case $choice in
        1)
            read -p "Please enter the path to the SDK: " SDKPATH
            PATH_UPDATE=true
            MENU_CHOICE=true
            ;;
        2)
            read -p "Please enter the path to the SDK: " SDKPATH
            CONFIG_UPDATE=true
            STARTUP_UPDATE=true
            MENU_CHOICE=true
            ;;
        3)
            read -p "Please enter the path to the SDK: " SDKPATH
            ALL=true
            MENU_CHOICE=true
            ;;
        4)
            read -p "Please enter the path to the SDK: " SDKPATH
            TEST=true
            ;;
        *)
            echo "Invalid choice"
            exit 1
            ;;
    esac

    if [[ ! $TEST ]]; then
        read -p "Are you sure you want to update with the provided SDK path? [Y/n]: " confirm
        if [[ $confirm != "Y" && $confirm != "y" ]]; then
            echo "Update canceled."
            exit 0
        fi
        echo "Updating..."
    fi
fi

# Validate the SDK path
validate_sdkpath
if [ $? -ne 0 ]; then
    exit 1
fi

# Perform the updates based on the flags or menu choice
if [[ $ALL || $PATH_UPDATE || $TEST || $MENU_CHOICE ]]; then
    update_shell_profile
fi

if [[ $ALL || $CONFIG_UPDATE || $TEST || $MENU_CHOICE ]]; then
    update_config
fi

if [[ $ALL || $STARTUP_UPDATE || $TEST || $MENU_CHOICE ]]; then
    update_startup
fi

if [[ $TEST ]]; then
    echo "Done! Ran test successfully for path: $SDKPATH"
elif [[ $PATH_UPDATE ]]; then
    echo -e "Done! Updated \$PATH successfully for path: $SDKPATH.\nPATH is now $PATH"
elif [[ $CONFIG_UPDATE && $STARTUP_UPDATE ]]; then
    echo -e "Done! Updated config and startup successfully for path: $SDKPATH."
    echo -e "config:"
    cat ~/.Playdate/config
    echo -e "\nstartup.sh:"
    cat ~/.Playdate/startup.sh
elif [[ $CONFIG_UPDATE && $PATH_UPDATE ]]; then
    echo -e "Done! Updated config and startup successfully for path: $SDKPATH.\nPATH is now $PATH"
    echo -e "config:"
    cat ~/.Playdate/config
elif [[ $STARTUP_UPDATE && $PATH_UPDATE ]]; then
    echo -e "Done! Updated config and startup successfully for path: $SDKPATH.\nPATH is now $PATH"
    echo -e "startup.sh:"
    cat ~/.Playdate/startup.sh
elif [[ $STARTUP_UPDATE ]]; then
    echo -e "Done! Updated startup successfully for path: $SDKPATH."
    echo -e "\nstartup.sh:"
    cat ~/.Playdate/startup.sh
elif [[ $CONFIG_UPDATE ]]; then
    echo -e "Done! Updated config successfully for path: $SDKPATH."
    echo -e "config:"
    cat ~/.Playdate/config
elif [[ $ALL || ( $PATH_UPDATE && $CONFIG_UPDATE && $STARTUP_UPDATE ) ]]; then
    echo -e "Done! Updated \$PATH successfully for path: $SDKPATH.\nPATH is now $PATH"
    echo -e "config:"
    cat ~/.Playdate/config
    echo -e "\nstartup.sh:"
    cat ~/.Playdate/startup.sh
fi  
