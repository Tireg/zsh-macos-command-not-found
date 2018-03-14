# ------------------------------------------------------------------------------
#          FILE:  macos-command-not-found.plugin.zsh
#   DESCRIPTION:  MacOS plugin that emulates command-not-found like in Ubuntu,
#                 meaning it finds and prompts which package must be installed
#                 to get the currently not found command.
#        AUTHOR:  Tireg
#   INSPIRED BY:  https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/command-not-found
#       VERSION:  1.0.0
# ------------------------------------------------------------------------------

if [[ "$(uname -s)" = "Darwin" ]]; then
	# Only load when we're running on macOS
	zstyle -t ':tireg:module:command-not-found' skip-brew;
	_SKIP_BREW="$?"

	if [ "${_SKIP_BREW}" -eq 2 ]; then
		test -z "${CONTINUOUS_INTEGRATION}" \
			&& ! test -n "${NC_SID}" -o ! -t 1 \
			&& (( ${+commands[brew]} )) \
			&& brew command which-formula 2>/dev/null >/dev/null \
			&& zstyle ':tireg:module:command-not-found' skip-brew false \
			|| zstyle ':tireg:module:command-not-found' skip-brew true;

		zstyle -t ':tireg:module:command-not-found' skip-brew;
		_SKIP_BREW="$?";
	fi

	if [ "${_SKIP_BREW}" -eq 1 ]; then
		# Use brew
		function command_not_found_handler() {
			local cmd="$1";
			# Brew command-not-found exists, so we can use it
			local txt="$(brew which-formula --explain "${cmd}" 2>/dev/null)";
			# If formula has been found, print instructions
			[ ! -z "${txt}" ] && echo "${txt}" || {
				[[ "${ZSH_VERSION}" > "5.2" ]] \
					&& echo "zsh: command not found: ${cmd}";
			};
			return 127;
		}
	else
		# Skip brew
		function command_not_found_handler() {
			local cmd="$1";
			[[ "${ZSH_VERSION}" > "5.2" ]] \
				&& echo "zsh: command not found: ${cmd}";
			return 127;
		}
	fi
fi
