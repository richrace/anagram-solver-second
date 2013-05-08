class HomeController < ApplicationController
  def index
    begin
      @dictionary = Dictionary.find(session[:dictionary_id]) if session[:dictionary_id]
    rescue ActiveRecord::RecordNotFound
      @dictionary = nil
      session[:dictionary_id] = nil
    end
  end
end
