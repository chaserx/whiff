#!/usr/bin/env ruby
require 'digest/md5'
require 'open3'
require 'fileutils'

# from: http://3till7.net/2014/01/24/vcr-for-shell-scripts/index.html

command = ARGV.join(' ')
program = File.basename(ARGV.shift)
# Compute a hash of the command being run, including its arguments:
hash = Digest::MD5.hexdigest(program + ARGV.join(' '))
test_data_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))
fixtures = File.join(test_data_dir, program, hash)
stdout_path = File.join(fixtures, 'stdout')
stderr_path = File.join(fixtures, 'stderr')
exit_code_path = File.join(fixtures, 'exit_code')

# If we can't find a directory for this particular command, we need to
# record new cassettes.
unless Dir.exists?(fixtures)
  FileUtils.mkdir_p fixtures
  stdin, stdout, stderr, wait_thr = Open3.popen3(command)
  stdin.close # Assume no further input necessary for the command
  output = stdout.read
  error = stderr.read
  exit_code = wait_thr.value.exitstatus
  # Write cassettes:
  File.open(stdout_path, 'w') {|file| file.puts output }
  File.open(stderr_path, 'w') {|file| file.puts error }
  File.open(exit_code_path, 'w') {|file| file.puts exit_code }
end

# This script responds just as the actual program did, writing the same
# data to stdout and stderr, exiting with the same exit code.
$stdout.print File.read(stdout_path)
$stderr.print File.read(stderr_path)
exit File.read(exit_code_path).to_i
