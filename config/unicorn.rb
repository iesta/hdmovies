worker_processes 2

working_directory "/home/jm/hdmovies/"

preload_app true

timeout 30

# This is where we specify the socket.
# # We will point the upstream Nginx module to this socket later on
listen "/home/jm/hdmovies/tmp/sockets/unicorn.sock", :backlog => 64
#
# # Set the path of the log files inside the log folder of the app
# stderr_path "/home/rails/akalettr/log/unicorn.stderr.log"
# stdout_path "/home/rails/akalettr/log/unicorn.stdout.log"
#
# before_fork do |server, worker|
#   defined?(ActiveRecord::Base) and
#       ActiveRecord::Base.connection.disconnect!
#       end
#
#       after_fork do |server, worker|
#         child_pid = server.config[:pid].sub('.pid', ".#{worker.nr}.pid")
#           system("echo #{Process.pid} > #{child_pid}")
#
#             defined?(ActiveRecord::Base) and
#                 ActiveRecord::Base.establish_connection
#                 end
