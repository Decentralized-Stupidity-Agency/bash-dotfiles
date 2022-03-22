#!/bin/bash
set -e

#!/bin/bash
set -e

###
# CONFIG
#
FILES_SYNCH=(
	'.bash_aliases'
	'.bashrc'
	'.gitconfig'
	'.profile'
	);

DIRS_SYNCH=(
	'.ssh'
	);

DIRS_SYNCH_CLOBBER=(
	'crontab'
	);
#
# CONFIG EOF
###

for FILE_SYNCH in "${FILES_SYNCH[@]}"; do
	if [ -f "${HOME}/${FILE_SYNCH}" ]; then
		cp "${HOME}/${FILE_SYNCH}" ./ && \
			echo "+++ file ${FILE_SYNCH}"
	else
		echo >&2 "--- missing file ${FILE_SYNCH}"
	fi
done

for DIR_SYNCH in "${DIRS_SYNCH[@]}"; do
	DIR_SYNCH="${HOME}/${DIR_SYNCH}"
	if [ -d "${DIR_SYNCH}" ]; then
		cp -r --no-clobber "${DIR_SYNCH}" ./ && \
			echo "+++ dir (no-clobber) ${DIR_SYNCH}"
	else
		echo >&2 "--- missing dir $DIR_SYNCH"
	fi
done

for DIR_CLOBBER in "${DIRS_CLOBBER[@]}"; do
	#
	# extended path for clobbering
	if [ -d "${HOME}/${DIR_CLOBBER}" ]; then
		rm -rf "./${DIR_CLOBBER}"
	fi
	DIR_CLOBBER="${HOME}/${DIR_CLOBBER}"
	cp -r "${DIR_CLOBBER}" ./ && \
		echo "+++ dir ${DIR_CLOBBER}"
done

echo '*** done'
exit 0
