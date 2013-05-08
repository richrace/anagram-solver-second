require 'spec_helper'

describe DictionariesController do

  describe "POST #upload" do

    before(:all) do
      @single_word = File.new(Rails.root + "#{Rails.root}/spec/assets/test_dic.txt")  
      @uploaded_single_word = ActionDispatch::Http::UploadedFile.new(:tempfile => @single_word, :filename => File.basename(@single_word)) 

      @multi_word = File.new(Rails.root + "#{Rails.root}/spec/assets/multi_word.txt")  
      @uploaded_multi_word = ActionDispatch::Http::UploadedFile.new(:tempfile => @multi_word, :filename => File.basename(@multi_word)) 
    end

    it "can upload a correct format file" do
      post :upload, :file => @uploaded_single_word

      response.should redirect_to root_url
      assigns(:dictionary).should_not be_nil
      assigns(:dictionary).grouped.should_not be_nil
    end

    it "can upload a file and not break when it's wrong format" do
      post :upload, :file => @uploaded_multi_word

      response.should redirect_to root_url
      assigns(:dictionary).should be_nil
    end

    it "will add the dictionary to the database if everything is ok" do
      post :upload, :file => @uploaded_single_word

      response.should redirect_to root_url
      assigns(:dictionary).should_not be_nil

      Dictionary.find(assigns(:dictionary).id).should_not be_nil
    end

  end

end
