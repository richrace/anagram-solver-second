require 'spec_helper'

describe Anagram do

  before(:all) do 
    @word_list = ["center", "centre", "test", "scream", "creams"]
    @grouped_hash = @word_list.group_by {|word| word.chars.sort}      
  end  

  describe "#find_anagram_with_dictionary" do
    before(:all) do
      @dictionary = Dictionary.create(:original => @word_list,
                                    :grouped => @grouped_hash,
                                    :time_taken => 2.33,
                                    :filename => "test.txt")
    end

    after(:all) do
      @dictionary.destroy
    end

    it "can find an anagram with dictionary and create Previous Search entry" do
      Anagram.find_anagram_with_dictionary("center", @dictionary)
      @dictionary.previous_searches.should have(1).items
      @dictionary.previous_searches.first.result.should have(2).items
      @dictionary.previous_searches.first.result.should match_array(["center", "centre"])
      prev_search_id = @dictionary.previous_searches.first.id
      PreviousSearch.find(prev_search_id).should_not be_nil
    end

    it "won't fail when send in nil Dictionary" do
      lambda { Anagram.find_anagram_with_dictionary("center", nil) }.should_not raise_error
    end

  end
  
  describe "#find_anagram" do

    it "will find an anagram" do
      result = Anagram.find_anagram("center", @grouped_hash)
      result.should have(2).items
      result.should match_array(["center", "centre"])
    end

    it "will not find an anagram" do
      result = Anagram.find_anagram("centers", @grouped_hash)
      result.should have(0).items
      result.should match_array([])
    end

  end

  describe "#create_anagram_hash" do

    it "will create a hash grouped by key" do
      hash = Anagram.create_anagram_hash(@word_list)
      hash.should have(3).items
      hash.values.should_not include(nil)
      hash.keys.should match_array(["center".chars.sort, "test".chars.sort, "scream".chars.sort])
    end

  end

end
