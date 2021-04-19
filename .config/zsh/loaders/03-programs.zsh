#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░

#█▓▒░ Executables directly downloaded via zinit


# We source lib/asdf instead of asdf directly to prevent shim addition to path. 
# shims are added via .envrc / direnv individually using the ``use asdf`` call ( see: https://github.com/asdf-community/asdf-direnv)
# or directly to the path during profile initialization ( see asdf.zsh in profile/paths )
if command -v asdf >/dev/null 2>&1; 
then 
. $ASDF_DIR/lib/asdf.sh
# Note: back to sourcing ASDF directly for now. 
# . "$ASDF_DIR/asdf.sh"
fi

## Items from GH release
# Notes: 
#   1) that programs are loaded after other plugins(0c)
#   2) tealdeer *is* downloaded as binary from brew. We don't want to compile it on new setups and currently there's no gh release for macos
#   3) lbin'!' means symlink instead of hard link ( which currently uses -P )
#   4) completions starting with _ are automatically inferred, those that don't need are directly mv'ed or downloaded
#   5) Items that are not based or a release or have a common ice pick structure are seperated to their own area ( on the same level - 0c)
zt 0c light-mode binary from'gh-r' lman lbin'!' for \
    atpull'%atclone' atclone'mv completions.zsh _exa' dl'https://raw.githubusercontent.com/ogham/exa/master/completions/completions.zsh' mv"exa* -> exa"   ogham/exa \
    atclone'mv -f **/*.zsh _bat' atpull'%atclone' mv"bat* -> bat"               @sharkdp/bat \
    mv"ripgrep* -> rg"                                                    BurntSushi/ripgrep \
    mv"delta* -> delta" dl'https://raw.githubusercontent.com/dandavison/delta/master/etc/completion/completion.zsh' atclone'mv completion.zsh _delta' atpull'%atclone'  dandavison/delta \
    mv"dust* -> dust"                                           bootandy/dust \
    mv"fd* -> fd"                                                    @sharkdp/fd \
    mv"mmv* -> mmv"                                                itchyny/mmv \
    bpick"*darwin*"                                                             ClementTsang/bottom \
                                                                                jesseduffield/lazydocker \
    dl'https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1'    junegunn/fzf \
    trigger-load'!navi' atclone'./**/navi repo add denisidoro/cheats 1>/dev/null'  bpick'*osx*'  atload'!source <(navi widget zsh)' has'fzf' \
                                                                                denisidoro/navi \
    lbin'!**/gh' atclone'./**/gh completion --shell zsh > _gh' atpull'%atclone'  cli/cli \
    lbin'!antidot* -> antidot' atclone'./**/antidot* update 1>/dev/null' atpull'%atclone' \
        doron-cohen/antidot \
        atclone'./just --completions zsh > _just' atpull'%atclone' \
        casey/just \
        bpick'*Darwin*' orf/gping \
        bpick'*darwin*' x-motemen/ghq \
        bpick'*darwin*' mv'*gst*->gst' uetchy/gst

# This assumes all relevant libraries are already there. 
zt 0c light-mode null from"gh-r" for \
    has'bat'  pick'src/*'  eth-p/bat-extras \
    lman lbin"!**/nvim" bpick'*macos*' neovim/neovim \
    lman mv"rust-analyzer-mac->rust-analyzer" lbin"!rust-analyzer" bpick'rust-analyzer-mac' rust-analyzer/rust-analyzer


# Consider this for libvterm image use - doesn't seem to work at the moment.
# zt 0c light-mode null for \
#     ver"master" atclone"make DEPS_CMAKE_FLAGS='-DUSE_BUNDLED_LIBVTERM=OFF' && make install"

# tmux source build
# note that we don't use the make'' flag due to extract'' not working well for some reason with nested folders
zt 0c light-mode null lman from'gh-r' for \
    bpick'*.tar.gz*' atclone'cd ./tmux* && LDFLAGS="-L/usr/local/lib" CPPFLAGS="-I/usr/local/include" LIBS="-lresolv" ./configure --prefix=$ZPFX && PREFIX=$ZPFX make install' atpull'%atclone' \
        tmux/tmux

# viu source build ( required for images to work properly outside of iterm )
# Should be loaded before prompt for neofetch use
zinit light-mode null lman for \
    has"cargo" lbin'!target/release/viu' atclone"cargo install --path ." atpull'%atclone' atanunq/viu


# more shell executables
zt 0c light-mode null nocompile lbin'!' for \
    ver'master' laggardkernel/git-ignore \
    nateshmbhat/rm-trash \
    has'jq' from'gitlab' \
    aaronNG/reddio \
    has'gpg' \
    dylanaraps/pash \
    paulirish/git-open


# Note: we're compiling nnn with nerd font support for macos. requires O_PCRE=1. plugins are downloaded atclone.
zt 0c light-mode binary for \
    lbin'!' reset \
        kazhala/dotbare \
    ver'master' make'!PREFIX=$ZPFX O_PCRE=1 O_NERD=1' atclone"curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh" atpull'%atclone' \
    jarun/nnn


zt 0c light-mode null for \
    lbin'!'    davidosomething/git-my \
    from'gh-r' lbin"!diff-so-fancy" \
        so-fancy/diff-so-fancy \
    molovo/revolver \
    lbin'!' atclone'./build.zsh' atpull'%atclone' \
        zunit-zsh/zunit \
    atclone'mkdir -p $HOME/.config/tmux/plugins/tpm; ln -sf $PWD/tmux-plugins---tpm $HOME/.config/tmux/plugins/tpm' atpull'%atclone' \
        tmux-plugins/tpm
    # installing via brew for now, readline is symlinked to /opt
    # atclone'autoreconf --install && ./configure --prefix=$ZPFX' make'PREFIX=$ZPFX' lbin'rlwrap' hanslub42/rlwrap



## Release based language servers and other language / reversing related tooling
### Omnisharp for C# / VB.NET
### netcoredbg for open source debugging ( note sbin is used so we load from actual netcoredbg folder including relevant dylibs)
### vsdbg for closed source debugging ;]
### abs-lang for fun
### dex2jar and cfr decompiler for android and java reversing
zt 0c light-mode ver'latest' null nocompile for \
from'gh-r' id-as"omnisharp" bpick'omnisharp-osx.tar.gz' sbin'run -> omnisharp' atpull"%atclone" OmniSharp/omnisharp-roslyn \
id-as"netcoredbg" atpull'%atclone' atclone'build-netcoredbg' sbin'bin/netcoredbg' Samsung/netcoredbg \
id-as"vsdbg" lbin'!vsdbg' lbin'!vsdbg-ui' atclone'download-vsdbg $(pwd)' zdharma/null \
id-as'abs-lang' from'gh-r' lbin'!abs-lang' bpick'*darwin*' mv'abs* -> abs-lang' abs-lang/abs \
id-as'dex-tools' from'gh-r' pxb1988/dex2jar \
id-as'cfr-decompiler' from'gh-r' leibnitz27/cfr

## Mac Debugging helpers
zt 0c light-mode null nocompile for \
id-as"bitcode-retriever" lbin'!build/bitcode_retriever' make AlexDenisov/bitcode_retriever \
id-as"segment_dumper" lbin'!build/segment_dumper' make AlexDenisov/segment_dumper

ztnodepth 0c light-mode null nocompile for \
id-as"libebc" has"llvm-dis" has"cmake" atclone'build-libebc' lbin'!build/tool/ebcutil' atpull'%atclone' ver'llvm-11' bbenzikry/LibEBC

# TODO: spack
# zinit ice wait lucid as'program' pick'bin/spack' \
#   atclone'./bin/spack bootstrap; \
#           ./bin/spack install lmod coreutils automake autoconf openssl \
#           libyaml readline libxslt libtool unixodbc unzip curl libevent jq \
#           tig mosh axel; \
#          ' \
#   atpull'%atclone' \
#   atload'. $PWD/share/spack/setup-env.sh'
# zinit light spack/spack


# TODO: Download alfred workflow for navi
#Example: https://github.com/denisidoro/navi/releases/download/v2.14.0/navi-v2.14.0.alfredworkflow
# ~/Library/Application\ Support/Alfred/Alfred.alfredpreferences/workflows/
# wget http://path/to/workflow.alfredworkflow
# unzip workflow.alfredworkflow
# mv workflow ~/path/to/installed/workflows/
