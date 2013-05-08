class AnagramsController < ApplicationController

  def find_anagram
    if !params[:wanted_anagram].blank? && !(params[:wanted_anagram] =~ /\d/) && session[:dictionary_id]
      @dictionary = Dictionary.find(session[:dictionary_id])
      if @dictionary
        Anagram.find_anagram_with_dictionary(params[:wanted_anagram], @dictionary)
      end
    end
    redirect_to root_path
  end

end
