require 'open3'
require 'fileutils'

def env_has_key(key)
  !ENV[key].nil? && ENV[key] != '' ? ENV[key] : abort("Missing #{key}.")
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

tuist_path = env_has_key("AC_TUIST_PATH")
tuist_commands = env_has_key("AC_TUIST_COMMANDS")


runCommand("#{tuist_commands} -p #{tuist_path}")