# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::heroku::config::envs()
#
#  Environment:	 BEGIN
#>
######################################################################
p6df::modules::heroku::config::envs() {

  p6df::modules::heroku::cmd config -s |grep -v BEGIN

  p6_return_void
}
