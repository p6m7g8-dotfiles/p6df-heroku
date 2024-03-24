# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::heroku::rails::console()
#
#>
######################################################################
p6df::modules::heroku::rails::console() {

  p6df::modules::heroku::cmd run rails console

  p6_return_void
}
