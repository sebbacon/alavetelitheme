# Add a callback - to be executed before each request in development,
# and at startup in production - to patch existing app classes.
# Doing so in init/environment.rb wouldn't work in development, since
# classes are reloaded, but initialization is not run each time.
# See http://stackoverflow.com/questions/7072758/plugin-not-reloading-in-development-mode
#
require 'dispatcher'
Dispatcher.to_prepare do
    # Example adding an instance variable to the frontpage controller
#    GeneralController.class_eval do
#        def mycontroller
#            @say_something = "Greetings friend"
#        end
#    end
#:set_view_paths
    ApplicationController.class_eval do
        alias_method :rescue_action_in_public_original, :rescue_action_in_public
        def rescue_action_in_public(exception)
          set_view_paths 
          rescue_action_in_public_original(exception)
        end
    end

end
