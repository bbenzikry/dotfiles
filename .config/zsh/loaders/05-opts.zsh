#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░

# ============================================================================
# Options
# ============================================================================

# Changing Directories
setopt AUTO_PUSHD                     # pushd instead of cd
setopt PUSHD_IGNORE_DUPS              # don't pushd twice
setopt PUSHD_SILENT                   # hide stack after cd
setopt PUSHD_TO_HOME                  # go home if no d specified
setopt AUTO_CD                        # auto cd 
setopt AUTO_PARAM_SLASH               # implicit "cd" if the command is a path


# Files
# setopt NOCLOBBER                   # Don’t overwrite existing files with '>' but uses '>!' instead
setopt RM_STAR_WAIT                  # Prompt for confirmation after 'rm *'-ish commands to avoid accidentally wiping out directories

# Completion
setopt AUTO_LIST                      # list completions
setopt AUTO_MENU                      # TABx2 to start a tab complete menu
setopt NO_COMPLETE_ALIASES            # no expand aliases before completion
setopt LIST_PACKED                    # variable column widths


# Expansion and Globbing
setopt EXTENDED_GLOB                  # like ** for recursive dirs
unsetopt CASE_GLOB                    # Remove case sensitivity from glob patterns
setopt GLOBDOTS                       # Glob dotfiles

# History
setopt APPEND_HISTORY                 # append instead of overwrite file
setopt EXTENDED_HISTORY               # extended timestamps
setopt HIST_IGNORE_DUPS               # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE              # omit from history if space prefixed
setopt HIST_REDUCE_BLANKS             # Remove superfluous blanks before recording entry.
setopt INC_APPEND_HISTORY             # Write to the history file immediately, not when the shell exits
# setopt HIST_VERIFY                  # verify when using history cmds/params -- disabled so we can !!
# unsetopt SHARE_HISTORY              # Disable sharing history between different zsh sessions
 
setopt ALIASES                        # autocomplete switches for aliases
# setopt COMPLETE_ALIASES
setopt AUTO_PARAM_SLASH               # append slash if autocompleting a dir
unsetopt CORRECT                     



# Job Control
setopt CHECK_JOBS                     # prompt before exiting shell with bg job
setopt LONGLISTJOBS                   # display PID when suspending bg as well
setopt NO_HUP                         # do not kill bg processes


# Prompting

setopt PROMPT_SUBST                   # allow variables in prompt

# Shell Emulation
setopt INTERACTIVECOMMENTS           # allow comments in shell

# Nuisances
setopt NO_BEEP                        # disable beeps 
setopt NONOMATCH 