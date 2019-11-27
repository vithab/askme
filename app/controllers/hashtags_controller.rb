class HashtagsController < ApplicationController
  before_action :set_hashtag, only: [:show]

  # GET /hashtags/1
  def show
    @questions = @hashtag.questions
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hashtag
      @hashtag = Hashtag.find(params[:id])
    end
end
