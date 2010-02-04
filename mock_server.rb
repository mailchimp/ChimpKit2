require "rubygems"
require "sinatra"
require "ruby-growl"

post "/" do
  g = Growl.new "localhost", "ruby-growl",
                ["ruby-growl Notification"]
  g.notify "ruby-growl Notification", "", params.inspect
end