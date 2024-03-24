# shellcheck shell=bash
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
