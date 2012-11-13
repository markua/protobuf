##
## Evented Mode
##
#
# Require this file if you wish to run your server and/or client RPC
# with the evented handlers via EventMachine.
#
# To run with rpc_server specify the switch `evented`:
#
#   rpc_server --evented myapp.rb
#
# To run for client-side only override the require in your Gemfile:
#
#   gem 'protobuf', :require => 'protobuf/evented'
#
require 'protobuf'
Protobuf.connector_type = :evented

begin
  require 'eventmachine'
  require 'protobuf/ext/eventmachine'
  require 'protobuf/rpc/servers/evented/server'
  require 'protobuf/rpc/connectors/eventmachine'
rescue LoadError => e
  if e.message =~ /Fiber/
    $stdout.puts '[WARNING] Your platform does not support Fiber usage. Falling back to default of Socket client/server implementation.'
    load 'protobuf/socket'
  else
    raise
  end
end
