require 'spec_helper'

describe HomeController do

  describe "GET '#index'" do

    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "renders :index view" do
      get :index
      response.should render_template "index"
    end

    it "won't get a dictionary if ID not set in session" do
      get :index
      assigns(:dictionary).should be_nil
    end

    it "won't break if session has dictionary ID that isn't in the database" do
      session[:dictionary_id] = 1000;
      lambda { Dictionary.find(session[:dictionary_id]) }.should raise_error

      lambda { get :index }.should_not raise_error
      assigns(:dictionary).should be_nil
    end

    it "will set dictionary if exists in session" do
      @word_list = ["center", "centre", "test", "scream", "creams"]
      @grouped_hash = @word_list.group_by {|word| word.chars.sort}
      dictionary = Dictionary.create(:original => @word_list,
                                  :grouped => @grouped_hash,
                                  :time_taken => 2.33,
                                  :filename => "test.txt")

      session[:dictionary_id] = dictionary.id

      get :index
      assigns(:dictionary).should_not be_nil
      assigns(:dictionary).should == dictionary
    end  

  end

end
