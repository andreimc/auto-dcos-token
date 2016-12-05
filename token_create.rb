#!/usr/bin/env ruby

require 'optparse'
require_relative 'token_generator'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ha-create.rb [options]"

  opts.on("-uURL", "--url=URL", "Rnacher temp url: eg https://dcos.auth0.com/login?ajs_anonymous_id=%227d6466ab-2b40-4bc5-80b6-b4cf662fce26%22&client=3yF5TOSzdlI45Q1xspxzeoGBe9fNxm9m&cluster_id=78fe376f-3d38-4308-8232-9434501d5b1d&redirect_uri=urn:ietf:wg:oauth:2.0:oob") do |url|
    options[:url] = url
  end

  opts.on("-uUSER", "--user=USER", "Username for google") do |user|
    options[:user] = user
  end

  opts.on("-pPASS", "--pass=PASS", "Password for google") do |pass|
    options[:pass] = pass
  end
end.parse!

TokenGenerator.new(options).configure_ha

