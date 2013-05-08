class DictionariesController < ApplicationController

  def upload
    start_time = Time.now
    file_content = ParseAnagrams.parse_file(params[:file])
    if file_content
      @dictionary = Dictionary.new(file_content)
      end_time = Time.now
      @dictionary.time_taken = ((end_time - start_time) * 1000).to_f
      @dictionary.save!
      session[:dictionary_id] = @dictionary.id
    end
    redirect_to root_path
  end

end
