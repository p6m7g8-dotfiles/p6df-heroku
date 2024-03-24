# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::heroku::cmd(...)
#
#  Args:
#	... - 
#
#  Environment:	 P6_DFZ_HEROKU_APP
#>
######################################################################
p6df::modules::heroku::cmd() {
  shift 0

  heroku "$@" --app "$P6_DFZ_HEROKU_APP"
}
