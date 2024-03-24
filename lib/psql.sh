# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::heroku::psql()
#
#>
######################################################################
p6df::modules::heroku::psql() {

  p6df::modules::heroku::cmd psql

  p6_return_void
}
