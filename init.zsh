# shellcheck shell=bash
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
# Function: p6df::modules::heroku::aliases::init()
#
#>
######################################################################
p6df::modules::heroku::aliases::init() {

  alias heroku="p6_heroku_cmd"

  p6_return_void
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
  p6_file_load "$HEROKU_AC_ZSH_SETUP_PATH"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::heroku::prompt::line()
#
#  Environment:	 APP P6_DFZ_HEROKU_APP
#>
######################################################################
p6df::modules::heroku::prompt::line() {

  local str
  str=$(awk '/login/ { print $2 }' <~/.netrc | tail -1)
  if ! p6_string_blank "$str"; then
    str="heroku:\t\t  $str"
  fi

  if ! p6_string_blank "$P6_DFZ_HEROKU_APP"; then
    str="$str APP=$P6_DFZ_HEROKU_APP"
  fi

  p6_return "$str"
}

######################################################################
#<
#
# Function: p6df::modules::heroku::app::set(app)
#
#  Args:
#	app -
#
#  Environment:	 P6_DFZ_HEROKU_APP
#>
######################################################################
p6df::modules::heroku::app::set() {
  local app="$1"

  p6_env_export "P6_DFZ_HEROKU_APP" "$app"

  p6_return_void
}

######################################################################
#<
#
# Function: p6_heroku_cmd(...)
#
#  Args:
#	... - 
#
#  Environment:	 P6_DFZ_HEROKU_APP
#>
######################################################################
p6_heroku_cmd() {
  shift 0

  heroku "$@" --app "$P6_DFZ_HEROKU_APP"
}

######################################################################
#<
#
# Function: p6df::modules::heroku::rails::console()
#
#>
######################################################################
p6df::modules::heroku::rails::console() {

  p6_heroku_cmd run rails console

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::heroku::psql()
#
#>
######################################################################
p6df::modules::heroku::psql() {

  p6_heroku_cmd psql

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::heroku::config::envs()
#
#  Environment:	 BEGIN
#>
######################################################################
p6df::modules::heroku::config::envs() {

  p6_heroku_cmd config -s |grep -v BEGIN

  p6_return_void
}
