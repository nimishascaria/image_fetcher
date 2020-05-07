require 'open-uri'
require 'fileutils'
require 'celluloid/current'
require_relative 'lib/image_fetcher'
require_relative 'lib/file_parser'

input_file = ARGV.first
destination_dir = File.dirname(__FILE__) + '/dest'
FileUtils.mkdir_p destination_dir

begin
  urls = FileParser.run(input_file)
  # Making a pool of size 5
  thread_pool = ImageFetcher.pool(size: 5, args: [destination_dir])
  urls.each { |url| thread_pool.fetch!(url) }
rescue => e
  puts "Error! #{e.message}"
  exit(1)
end
