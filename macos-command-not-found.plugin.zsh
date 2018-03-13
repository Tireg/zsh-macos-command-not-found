# ------------------------------------------------------------------------------
#          FILE:  macos-command-not-found.plugin.zsh
#   DESCRIPTION:  MacOS plugin that emulates command-not-found like in Ubuntu,
#                 meaning it finds and prompts which package must be installed
#                 to get the currently not found command.
#        AUTHOR:  Tireg
#   INSPIRED BY:  https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/command-not-found
#       VERSION:  1.0.0
# ------------------------------------------------------------------------------

function command_not_found_handler() {
	local cmd="$1";
	typeset -gi _CMDNF_SKIP_BREW;

	# Initialize cache if not set
	if [ -z "${_CMDNF_SKIP_BREW}" ]; then
		# Do not run when inside Midnight Commander or within a Pipe,
		# except if on Travis-CI.
		# Then check for brew command-not-found tap
		if   test -z "${CONTINUOUS_INTEGRATION}" && \
		   ! test -n "${NC_SID}" -o ! -t 1 && \
		   (( ${+commands[brew]} ));
		then
			_CMDNF_SKIP_BREW="0";
		else
			_CMDNF_SKIP_BREW="1";
		fi
	fi

	# The code below is based off this Linux Journal article:
	#   http://www.linuxjournal.com/content/bash-command-not-found
	(( ${SKIP_BREW} )) && {
		# Zsh versions 5.3 and above don't print this for us.
		[[ "${ZSH_VERSION}" > "5.2" ]] \
			&& echo "zsh: command not found: ${cmd}";
	} || {
		# Brew command-not-found exists, so we can use it
		local txt="$(brew which-formula --explain "${cmd}" 2>/dev/null)";
		# If formula has been found, print instructions
		[ ! -z "${txt}" ] && echo "${txt}";
	}

	# Return command not found error code
	return 127;
}
