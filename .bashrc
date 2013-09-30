bash_prompt_command() {
	# How many characters of the $PWD should be kept
	local pwdmaxlen=25
	# Indicate that there has been dir truncation
	local trunc_symbol=".."
	local dir=${PWD##*/}
	pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
	NEW_PWD=${PWD/$HOME/\~}
	local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
	if [ ${pwdoffset} -gt "0" ]
		then
		NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
		NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
	fi

	# Setup variable for current git branch, if available
	if ! git rev-parse --git-dir > /dev/null 2>&1; then
		GIT_CURRENT_BRANCH=""
		GIT_CURRENT_BRANCH_STATE_COLOR=""
	else
		if ! git diff --quiet 2>/dev/null >&2; then
			GIT_CURRENT_BRANCH_STATE_COLOR='\[\033[0;31m\]' #git dirty HEAD 
		else
			if ! git diff --cached --quiet 2>/dev/null >&2; then
				GIT_CURRENT_BRANCH_STATE_COLOR='\[\033[0;33m\]' #git dirty index
			else
				GIT_CURRENT_BRANCH_STATE_COLOR='\[\033[0;32m\]' #git clean branch
			fi
		fi
		GIT_CURRENT_BRANCH=" [$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')]"
	fi
	bash_prompt # call again this function to update PS1 to use corresponding GIT_CURRENT_BRANCH_STATE_COLOR
}

bash_prompt() {
	local NONE='\[\033[0m\]'    # unsets color to term's fg color

# NB: Unused Colors disabled

        # regular colors
	local R='\[\033[0;31m\]'    # red
	local B='\[\033[0;34m\]'    # blue
															    
	local UC=$C                 # user's color
        [ $UID -eq "0" ] && UC=$R   # root's color
	
	PS1="${NONE}[\t${NONE}] ${NONE}[${B}\${NEW_PWD}${NONE}]${G}${GIT_CURRENT_BRANCH_STATE_COLOR}\${GIT_CURRENT_BRANCH}${NONE}\\$ ${NONE}"
	SUDO_PS1="${NONE}[\t${NONE}] ${NONE}[${R}\u${R}@${R}\h ${B}\${NEW_PWD}${NONE}]${G}\${GIT_CURRENT_BRANCH}${NONE}\\$ ${NONE}"
}
	
PROMPT_COMMAND=bash_prompt_command 
bash_prompt

# Make bash check its window size after a process completes
shopt -s checkwinsize
