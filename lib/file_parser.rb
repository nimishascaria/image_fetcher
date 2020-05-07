require 'uri'

#to parse the plain text file
class FileParser
  def self.run(file)
    raise 'File not found' unless File.exists?(file)

    urls = []
    File.open(file, 'r').each { |line| urls << line.strip.slice(URI.regexp) }
    urls.compact
  end
end
