require 'spec_helper'

describe PreviousSearch do
  
  before(:all) do
    word_list = ["center", "centre", "test", "scream", "creams"]
    grouped_hash = Anagram.create_anagram_hash(word_list)
    @dictionary = Dictionary.create(:original => word_list,
                                    :grouped => grouped_hash,
                                    :time_taken => 2.33,
                                    :filename => "test.txt")
  end

  after(:all) do
    @dictionary.destroy
  end
  
  describe "#save" do
    it "can not save an invalid Previous Search" do
      previous = PreviousSearch.new(:dictionary_id => @dictionary.id)
      previous.should_not be_valid
      previous.stub(:save).and_return(false)
    end

    it "can save a valid Previous Search" do
      previous = PreviousSearch.new(
        :dictionary_id => @dictionary.id, 
        :result => ["center", "centre"], 
        :wanted_anagram => "center", 
        :time_taken => Time.now
      )
      previous.should be_valid
      previous.stub(:save).and_return(true)
    end

    it "can save a Previous Search and Dictionary can find it" do
      previous = PreviousSearch.new(
        :dictionary_id => @dictionary.id, 
        :result => ["center", "centre"], 
        :wanted_anagram => "center", 
        :time_taken => Time.now
      )
      previous.should be_valid
      previous.save!

      previous.dictionary.should == @dictionary
    end
  end

end
