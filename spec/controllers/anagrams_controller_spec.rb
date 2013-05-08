require 'spec_helper'

describe AnagramsController do

  describe "POST #find_anagram" do
    before(:each) do
      @word_list = ["center", "centre", "new", "scream", "creams"]
      @hash = Anagram.create_anagram_hash(@word_list)
      @dictionary = Dictionary.create(:original => @word_list,
                                      :grouped => @hash,
                                      :time_taken => 2.33,
                                      :filename => "test.txt")     
    end

    after(:each) do
      @dictionary.destroy
    end

    it "can find an anagram with a word given and create a search log" do    
      session[:dictionary_id] = @dictionary.id
      post :find_anagram, :wanted_anagram => "center"

      @dictionary.previous_searches.first.wanted_anagram.should == "center"
      @dictionary.previous_searches.first.result.should_not be_empty
      @dictionary.previous_searches.first.result.should == ["center", "centre"]
    end

    it "will return empty list when no anagram found and will create a search log" do
      session[:dictionary_id] = @dictionary.id
      post :find_anagram, :wanted_anagram => "test"

      @dictionary.previous_searches.first.wanted_anagram.should == "test"
      @dictionary.previous_searches.first.result.should be_empty
    end

    it "won't break when passed no word" do
      session[:dictionary_id] = @dictionary.id
      post :find_anagram, :wanted_anagram => ""

      @dictionary.previous_searches.should be_empty
    end

    it "won't break when no dictionary set in session" do
      session[:dictionary_id] = nil
      lambda { post :find_anagram, :wanted_anagram => "test" }.should_not raise_error
    end

    it "won't break when submitting numbers" do
      session[:dictionary_id] = @dictionary.id
      post :find_anagram, :wanted_anagram => "test123"

      @dictionary.previous_searches.should be_empty
    end

  end

end
