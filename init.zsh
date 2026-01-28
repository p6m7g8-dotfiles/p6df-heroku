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

  p6df::modules::vscode::extension::install ivangabriele.vscode-heroku
  p6df::modules::vscode::extension::install JustBrenny.hero-heroku
  p6df::modules::vscode::extension::install pkosta2005.heroku-command

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
  p6df::core::homebrew::cli::brew::install heroku

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
# Function: p6df::modules::heroku::init(_module, dir)
#
#  Args:
#	_module -
#	dir -
#
#>
######################################################################
p6df::modules::heroku::init() {
  local _module="$1"
  local dir="$2"

  p6_bootstrap "$dir"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::heroku::aliases::init(_module, dir)
#
#  Args:
#	_module -
#	dir -
#
#>
######################################################################
p6df::modules::heroku::aliases::init() {
  local _module="$1"
  local dir="$2"

  p6_alias "heroku" "p6df::modules::heroku::cmd"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::heroku::completions::init()
#
#  Environment:	 HEROKU_AC_ZSH_SETUP_PATH HOME
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
# Function: p6df::modules::heroku::prompt::mod()
#
#  Environment:	 HOME P6_DFZ_HEROKU_APP
#>
######################################################################
p6df::modules::heroku::prompt::mod() {

  local str
  if p6_file_exists "$HOME/.netrc"; then
    str=$(p6_file_display "$HOME/.netrc" | p6_filter_row_select "login" | p6_filter_column_pluck 2 | p6_filter_row_last 1)
    if p6_string_blank_NOT "$str"; then
      str="heroku:\t\t  $str"
      if p6_string_blank_NOT "$P6_DFZ_HEROKU_APP"; then
        str="$str APP=$P6_DFZ_HEROKU_APP"
      fi
    fi
  fi

  p6_return "$str"
}
