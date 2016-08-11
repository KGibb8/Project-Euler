
class FileReader
  def mount_text_art(filename)
    open filename do |file|
      while line = file.gets
        puts line
      end
    end
  end
end
