#!/usr/bin/env zsh
# Note: this is relevant only for the main / system python installation. 
python3 -m ensurepip
python3 -m pip install -U --user pip
python3 -m pip install -U --user pynvim pipx

# TODO: install meson

pipx_pypy() {
	# Check if we're using pypy
	if [ "$(pypy3 --version | sed 1q | awk '{print $2}' | cut -d'.' -f2)" -ge 6 ]; then
		pipx install --python pypy3 "$@"
	else
		pipx install "$@"
	fi
}

parallel pipx_pypy ::: \
	git+https://github.com/asciinema/asciinema.git \
	# Hacker news terminal
	git+https://github.com/donnemartin/haxor-news.git \
	# Google from terminal
	git+https://github.com/jarun/googler.git \
	# Duck duck go terminal
	git+https://github.com/jarun/ddgr.git \
	# Speed test CLI
	git+https://github.com/sivel/speedtest-cli.git \
	# Reddit terminal
	git+https://gitlab.com/ajak/tuir.git

# The most important part here is ptpython
parallel pipx install --system-site-packages ::: \
	mypy pylint pytest pytype pyre-check \
	'git+https://github.com/prompt-toolkit/ptpython.git#egg=ptpython[ptipython]' \

# Include apps adds the items to path directly.
pipx inject --include-apps ptpython konch

parallel pipx install ::: \
	flake8 black isort pre-commit proselint pydiatra pydocstyle pygments \
	requires.io restructuredtext-lint safety \
	tox vim-vint virtualenv xenon yamllint \
	git+https://github.com/aboul3la/Sublist3r.git \
	git+https://github.com/noahp/emoji-fzf.git \
	git+https://github.com/ngynLk/ImageColorizer