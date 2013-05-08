class Anagram

  def self.find_anagram_with_dictionary(wanted, dictionary) 
    if dictionary
      start_time = Time.now
      anagram_output = find_anagram(wanted, dictionary.grouped)
      end_time = Time.now
      PreviousSearch.create(:dictionary_id => dictionary.id, 
                            :result => anagram_output, 
                            :wanted_anagram => wanted, 
                            :time_taken => ((end_time - start_time) * 1000).to_f)
    end
  end

  def self.find_anagram(wanted, grouped_hash) 
    if grouped_hash
      grouped_hash[wanted.downcase.chars.sort] || []
    else 
      []
    end
  end

  def self.create_anagram_hash(word_list)
    word_list.group_by {|word| word.chars.sort}
  end

end
