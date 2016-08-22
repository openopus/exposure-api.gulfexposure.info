class SurveyController < GenericApiRails::RestController
  before_action :setup
  
  def model
    @model ||= SurveyAnswer
  end

  def survey_answers_for
    @answers = []
    @answers = @user.answers if @user
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
  
  def setup
    @codename = params[:codename]
    @user = User.where(codename: @codename).first if @codename
    @question = SurveyQuestion.find(params[:question_id]) if params[:question_id]
    @answer = SurveyAnswer.find(params[:answer_id]) if params[:answer_id]
  end
    
end
