# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::heroku::config::envs()
#
#>
######################################################################
p6df::modules::heroku::config::envs() {

  p6df::modules::heroku::cmd config -s | p6_filter_row_exclude BEGIN

  p6_return_void
}
