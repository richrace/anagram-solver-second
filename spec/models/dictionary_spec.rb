require 'spec_helper'

describe Dictionary do
  
  before(:all) do
    @word_list = ["center", "centre", "test", "scream", "creams"]
    @hash = Anagram.create_anagram_hash(@word_list)
  end

  describe "#make_anagram_list" do

    it "can set and access grouped hash and original array" do
      dictionary = Dictionary.new(:grouped => @hash, :original => @word_list)
      dictionary.original.should match_array(@word_list)
      dictionary.grouped.should == @hash
    end
  
  end

  describe "#save" do

    it "can not save an invalid Dictionary" do
      dictionary = Dictionary.new
      dictionary.grouped.should be_nil
      dictionary.should_not be_valid
      dictionary.stub(:save).and_return(false) 
    end

    it "can save a valid Dictionary" do
      dictionary = Dictionary.new(:original => @word_list,
                                  :grouped => @hash,
                                  :time_taken => 2.33,
                                  :filename => "test.txt")    
      dictionary.should be_valid
      dictionary.stub(:save).and_return(true) 
    end

  end

  describe "#delete" do

    it "will delete all previous searches and dictionary is removed" do
      dictionary = Dictionary.create(:original => @word_list,
                                     :grouped => @hash,
                                     :time_taken => 2.33,
                                     :filename => "test.txt") 

      result = Anagram.find_anagram("center", dictionary.grouped)

      prev_search = PreviousSearch.create(:dictionary_id => dictionary.id, 
                                          :result => result, 
                                          :wanted_anagram => "center", 
                                          :time_taken => Time.now)

      dictionary.previous_searches.length.should == 1
      prev_search_id = dictionary.previous_searches.first.id
      PreviousSearch.find(prev_search_id).should == prev_search

      dictionary.destroy
      Dictionary.find(:all).should be_empty
      PreviousSearch.find(:all).should be_empty
    end

  end

end
