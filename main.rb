require 'open3'
require 'fileutils'

def env_has_key(key)
	return (ENV[key] == nil || ENV[key] == "") ? nil : ENV[key]
end

def runCommand(command)
    puts "@@[command] #{command}"
    status = nil
    stdout_str = nil
    stderr_str = nil
    Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
      stdout.each_line do |line|
        puts line
      end
      stdout_str = stdout.read
      stderr_str = stderr.read
      status = wait_thr.value
    end
  
    unless status.success?
      raise stderr_str
    end
end

options = ""
tuist_path = env_has_key("AC_TUIST_PATH")
tuist_commands = env_has_key("AC_TUIST_COMMANDS") || abort("Missing AC_TUIST_COMMANDS")

if tuist_path
    options += "#{tuist_path}"
end

runCommand("#{tuist_commands} #{options}")