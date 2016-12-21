#!/usr/bin/env ruby

require 'optparse'
require_relative 'users_generator'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: user_create.rb [options]"

  opts.on("-uURL", "--url=URL", "DCOS url: eg https://dcos.example.com") do |url|
    options[:url] = url
  end

  opts.on("-uUSER", "--user=USER", "Username for google") do |user|
    options[:user] = user
  end

  opts.on("-pPASS", "--pass=PASS", "Password for google") do |pass|
    options[:pass] = pass
  end

  opts.on("-aACCOUNTS", "--accounts=ACCOUNTS", "Space delimited accounts") do |file|
    options[:accounts] = file
  end

  opts.on("-dDEBUG", "--debug=DEBUG", "Debug true false") do |debug|
    options[:debug] = debug
  end
end.parse!

ug = UsersGenerator.new(options)

if (options[:accounts])
  ug.create_users
else
  ug.get_token
end

