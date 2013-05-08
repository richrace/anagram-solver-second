class ParseAnagrams

  def self.parse_file(file)
    incorrect = false
    file_content = File.open(file.tempfile.path, "r") { |file_obj| file_obj.readlines }
    file_content.each do | file_line |         
      if file_line.split(' ').length > 1
        incorrect = true
        break
      end
      file_line.downcase!
      file_line.chomp!
    end

    return {:filename => file.original_filename, :original => file_content, :grouped => Anagram.create_anagram_hash(file_content)} unless incorrect

  end

end