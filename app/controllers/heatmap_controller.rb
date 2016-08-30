# heatmap_controller.rb: -*- Ruby -*-  DESCRIPTIVE TEXT.
# 
#  Copyright (c) 2016 Brian J. Fox
#  Author: Brian J. Fox (bfox@opuslogica.com) Tue Aug 30 13:38:28 2016.
class HeatmapController < GenericApiRails::BaseController

  def heatmap
    @users = User.where.not(latitude: nil).where.not(longitude: nil)
    @users.select([:latitude, :longitude])each do |
    @heatmap = []
    @users
    render json: @answers
  end

  def answer_question_for
    if @question and @user
      @answer = @user.answers.where(survey_question_id: @question.id).first_or_create
      @answer.value = params[:value]
      @answer.save
    end

    render json: @answer
  end

  def survey_template
    template = SurveyGroup.all
    render json: SurveyGroup.all.order(position: :asc).as_json({deep: true})
  end
  
  def survey_submit
    if @user
      @user.answers.delete_all
      answers = params[:answers]
      answers.each do |answer|
        base = @user.answers.where(survey_question_id: answer[:survey_question_id])
        if answer[:value].blank?
          base.delete_all
        else
          a = base.first_or_create
          a.value = answer[:value]
          a.save
          @user.birthdate = a.value && @user.save if a.survey_question.tag == "birthdate"
          if survey_question.tag == "hometown"
            location = Geocode.search(a.value)
            @user.latitude = location[0].latitude rescue nil
            @user.longitude = location[0].longitude rescue nil
            @user.save
          end
        end
      end
    end

    render json: { saved: true, message: "saved" }
  end
  
  def setup
    @codename = params[:codename]
    @user = User.where(codename: @codename).first if @codename
    @question = SurveyQuestion.find(params[:question_id]) if params[:question_id]
    @answer = SurveyAnswer.find(params[:answer_id]) if params[:answer_id]
  end
    
end
