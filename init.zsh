######################################################################
#<
#
# Function: p6df::modules::heroku::deps()
#
#>
######################################################################
p6df::modules::heroku::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6df-js
    ohmyzsh/ohmyzsh:plugins/heroku
  )

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::heroku::vscodes()
#
#>
######################################################################
p6df::modules::heroku::vscodes() {

  code --install-extension ivangabriele.vscode-heroku
  code --install-extension JustBrenny.hero-heroku
  code --install-extension pkosta2005.heroku-command

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::heroku::external::yum()
#
#>
######################################################################
p6df::modules::heroku::external::yum() {

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::heroku::external::brew()
#
#>
######################################################################
p6df::modules::heroku::external::brew() {

  brew tap heroku/brew
  brew install heroku

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::heroku::langs()
#
#>
######################################################################
p6df::modules::heroku::langs() {

  heroku plugins:install heroku-accounts
  heroku plugins:install heroku-cli-deploy
  heroku plugins:install heroku-cli-diff
  heroku plugins:install heroku-connect-plugin
  heroku plugins:install heroku-dyno-types
  heroku plugins:install heroku-kafka
  heroku plugins:install heroku-pg-extras
  heroku plugins:install heroku-postgresql
  heroku plugins:install heroku-slugs

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::heroku::init()
#
#>
######################################################################
p6df::modules::heroku::init() {

  p6df::modules::heroku::completions::init
  p6df::modules::heroku::prompt::init 
}

######################################################################
#<
#
# Function: p6df::modules::heroku::prompt::init()
#
#>
######################################################################
p6df::modules::heroku::prompt::init() {

  p6df::core::prompt::line::add "p6df::modules::heroku::prompt::line"
}

######################################################################
#<
#
# Function: p6df::modules::heroku::completions::init()
#
#  Environment:	 HEROKU_AC_ZSH_SETUP_PATH
#>
######################################################################
p6df::modules::heroku::completions::init() {

  HEROKU_AC_ZSH_SETUP_PATH=$HOME/Library/Caches/heroku/autocomplete/zsh_setup 
  test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
}

######################################################################
#<
#
# Function: p6df::modules::heroku::prompt::line()
#
#  Depends:	 p6_string
#>
######################################################################
p6df::modules::heroku::prompt::line() {

  p6_heroku_prompt_info
}

######################################################################
#<
#
# Function: p6_heroku_prompt_info()
#
#  Depends:	 p6_string
#>
######################################################################
p6_heroku_prompt_info() {

  local str
  str=$(awk '/login/ { print $2 }' < ~/.netrc | tail -1)
  if ! p6_string_blank "$str"; then
    str="heroku:\t  $str"
  fi

  p6_return "$str"
}
