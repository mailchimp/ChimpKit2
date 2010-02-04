require "rubygems"
require "sinatra"
require "ruby-growl"
require "json"

get "/" do
  g = Growl.new "localhost", "ruby-growl",
                ["ruby-growl Notification"]
  g.notify "ruby-growl Notification", "", params.inspect
  params.to_json
end

put "/" do
  g = Growl.new "localhost", "ruby-growl",
                ["ruby-growl Notification"]
  g.notify "ruby-growl Notification", "", params.inspect
  params.to_json
end