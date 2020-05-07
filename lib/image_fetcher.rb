class ImageFetcher
  include Celluloid

  def initialize(destination_dir)
    @destination_dir = destination_dir
  end

  def fetch!(url)
    return unless url

    puts "Fetching url #{url}"
    open(url) do |stream|
      File.open(destination_path(url), 'wb') { |file| file.write(stream.read) }
    end
  rescue OpenURI::HTTPError => e
    puts "HTTP Error! #{e.message}"
  rescue => e
    puts "Error! #{e.message}"
  else
    puts "Succesfully fetched #{url}"
  end

  private

  def destination_path(url)
    file_name = File.basename(url).split('.')
    "#{@destination_dir}/#{file_name.first}_#{DateTime.now.strftime("%Q")}.#{file_name.last}"
  end
end
