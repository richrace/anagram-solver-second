require 'spec_helper'

describe ParseAnagrams do

  describe "#parse_file" do

    before(:all) do
      @single_word = File.new(Rails.root + "#{Rails.root}/spec/assets/test_dic.txt")  
      @uploaded_single_word = ActionDispatch::Http::UploadedFile.new(:tempfile => @single_word, :filename => File.basename(@single_word)) 

      @multi_word = File.new(Rails.root + "#{Rails.root}/spec/assets/multi_word.txt")  
      @uploaded_multi_word = ActionDispatch::Http::UploadedFile.new(:tempfile => @multi_word, :filename => File.basename(@multi_word)) 
    end

    it "can be given a file and parse contents" do
      result = ParseAnagrams.parse_file(@uploaded_single_word)
      result.should have_key(:original)
      result[:original].should include("center")
    end

    it "can be given a file and parse contents and group words into hash" do
      result = ParseAnagrams.parse_file(@uploaded_single_word)
      result.should have_key(:grouped)
      result[:grouped].should include("center".chars.sort)
    end

    it "won't fail when given incorrect format of file" do
      result = ParseAnagrams.parse_file(@uploaded_multi_word)
      result.should be_nil
    end

  end

end