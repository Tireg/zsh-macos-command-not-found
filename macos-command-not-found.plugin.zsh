# ------------------------------------------------------------------------------
#          FILE:  macos-command-not-found.plugin.zsh
#   DESCRIPTION:  MacOS plugin that emulates command-not-found like in Ubuntu,
#                 meaning it finds and prompts which package must be installed
#                 to get the currently not found command.
#        AUTHOR:  Tireg
#   INSPIRED BY:  https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/command-not-found
#       VERSION:  1.0.0
# ------------------------------------------------------------------------------

function cmdnf_classic_handler() {
	local cmd="${1}";

	[[ "${ZSH_VERSION}" > "5.2" ]] && echo "zsh: command not found: ${cmd}";
}

function cmdnf_brew_handler() {
	local cmd="${1}";

	# Use brew which-formula
	local txt
	if ! txt="$(brew which-formula --explain "${cmd}" 2>/dev/null)"; then
		# brew command-not-found is not installed
		cmdnf_classic_handler;
	fi

	#
	[ ! -z "${txt}" ] && echo "${txt}" || cmdnf_classic_handler "${cmd}";
}

# Check if brew should be used
test -z "${CONTINUOUS_INTEGRATION}" \
	&& ! test -n "${NC_SID}" -o ! -t 1 \
	&& (( ${+commands[brew]} )) \
	&& {
		# Use brew handler if brew is installed
		function command_not_found_handler() {
			cmdnf_brew_handler "${@}";
		}
	} \
	|| {
		# Use classic handler
		function command_not_found_handler() {
			cmdnf_classic_handler "${@}";
		}
	}
