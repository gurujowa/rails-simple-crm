worker_processes 2

stderr_path File.expand_path('/var/log/unicorn/stderr.log', __FILE__)
stdout_path File.expand_path('/var/log/unicorn/stdout.log', __FILE__)

pid File.expand_path('/var/log/unicorn/unicorn.pid', __FILE__)

preload_app false
