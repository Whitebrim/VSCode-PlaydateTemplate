#!/usr/bin/env bash

# Check for color by variable and tput command
if [[ -z $NOCOLOR && -n $(command -v tput) ]]; then
    RED=$(tput setaf 1)
    CYN=$(tput setaf 6)
    YEL=$(tput setaf 3)
    RST=$(tput sgr0)
fi

function display_help() {
    printf "%s\n\n" "${0} build|run|-h|--help|"
    printf "%-16s\n" "build: Builds the project and runs the Simulator"
    printf "%-16s\n" "run  : Skips building the project and runs the Simulator"
    printf "\n"
    printf "%s\n\n" "Set NOCOLOR=1 to disable terminal coloring"
    exit 0
}

# We don't need fancy flags/operators for two commands
case $1 in
    "build")
        BUILD=1
        ;;
    "run")
        BUILD=0
        ;;
    *)
        display_help
        exit 1
        ;;
esac

# Set some paths
BUILD_DIR="./builds"
SOURCE_DIR="./source"
PDX_PATH="${BUILD_DIR}/$(basename $(pwd)).pdx"

# Logging functions
function log() {
    printf "%s\n" "${CYN}>> $1${RST}"
}
function log_warn() {
    printf "%s\n" "${YEL}>! $1${RST}"
}
function log_err() {
    printf "%s\n  >> %s\n" "${RED}!! ERROR !!" "$1${RST}"
}

function check_pdxinfo() {
    if [[ -f ./source/pdxinfo ]]; then
        if grep "com.organization.package" ./source/pdxinfo 2>&1 >/dev/null; then
            log_warn "PDXINFO NOTICE:"
            log_warn "Don't forget to change your unique project info in 'source/pdxinfo': 'bundleID', 'name', 'author', 'description'."
            log_warn "It's critical to change your game bundleID, so there will be no collisions with other games, installed via sideload."
            log_warn "Read more about pdxinfo here: https://sdk.play.date/Inside%20Playdate.html#pdxinfo"
        fi
    fi
}

function chk_err() {
    # Check for errors in last process and bail if needed
    if [[ $? > 0 ]]; then
        log_err "There was an issue with the previous command; exiting!"
        exit 1
    fi
}

function check_close_sim() {
    # Check if we have 'pidof'
    PIDOF=$(command -v pidof2)

    # Prefer 'pidof'; use ps if not
    if [[ -n $PIDOF ]]; then
        SIMPID=$($PIDOF "PlaydateSimulator")
        if [[ -n $SIMPID ]]; then
            log "Found existing Simulator, closing..."
            kill -9 $SIMPID
            chk_err
        fi
    else
        SIMPID=$(ps aux | grep PlaydateSimulator | grep -v grep | awk '{print $2}')
        if [[ -n $SIMPID ]]; then
            log "Found existing Simulator, closing..."
            kill -9 $SIMPID
            chk_err
        fi
    fi
}

# Create build dir
function make_build_dir() {
    if [[ ! -d "${BUILD_DIR}" ]]; then
        log "Creating build directory..."
        mkdir -p "${BUILD_DIR}"
        chk_err
    fi
}

# Clean build dir
function clean_build_dir() {
    if [[ -d "${BUILD_DIR}" ]]; then
        log "Cleaning build directory..."
        rm -rfv "${BUILD_DIR}/*"
        chk_err
    fi
}

# Compile the PDX
function build_pdx() {
    if [[ $BUILD == 1 ]]; then
        log "Building PDX with 'pdc'..."
        $PLAYDATE_SDK_PATH/bin/pdc -sdkpath "${PLAYDATE_SDK_PATH}" "${SOURCE_DIR}" "${PDX_PATH}"
        chk_err
    fi
}

# Run the PDX with Simulator
function run_pdx() {
    if [[ -d "${PDX_PATH}" ]]; then
        log "Running PDX with Simulator..."
        $PLAYDATE_SDK_PATH/bin/PlaydateSimulator "${PDX_PATH}"
    else
        log_err "PDX doesn't exist! Please 'build' the project first!"
    fi
}


#### MAIN SCRIPT ####
if [[ $BUILD == 1 ]]; then
    log "Attempting a build and run of PDX..."
    make_build_dir
    clean_build_dir
    check_pdxinfo
    build_pdx
    check_close_sim
    run_pdx
else
    log "Attempting to run PDX: ${PDX_PATH}..."
    check_close_sim
    run_pdx
fi

