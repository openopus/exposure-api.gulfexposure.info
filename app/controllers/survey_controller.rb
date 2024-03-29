class SurveyController < GenericApiRails::RestController
  before_action :setup
  
  def model
    @model ||= SurveyAnswer
  end

  def survey_remove
    result = true
    @user.destroy if @user
    render json: result
  end
  def survey_answers_for
    @answers = []
    @answers = @user.answers.order(survey_question_id: :asc) if @user
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
          @user.birthdate = a.value if a.survey_question.tag == "birthdate"
          if a.survey_question.tag == "current-age"
            @user.birthdate = DateTime.now - (2.years + 6.months) if a.value.starts_with?("0 - 5")
            @user.birthdate = DateTime.now - (8.years + 6.months) if a.value.starts_with?("6 - 10")
            @user.birthdate = DateTime.now - (13.years + 6.months) if a.value.starts_with?("11 - 17")
            @user.birthdate = DateTime.now - (21.years + 6.months) if a.value.starts_with?("18 - 25")
            @user.birthdate = DateTime.now - (30.years + 6.months) if a.value.starts_with?("26 - 35")
            @user.birthdate = DateTime.now - (40.years + 6.months) if a.value.starts_with?("36 - 45")
            @user.birthdate = DateTime.now - (50.years + 6.months) if a.value.starts_with?("46 - 55")
            @user.birthdate = DateTime.now - (60.years + 6.months) if a.value.starts_with?("56 - 65")
            @user.birthdate = DateTime.now - (70.years + 6.months) if a.value.starts_with?("66 - 75")
            @user.birthdate = DateTime.now - (82.years + 0.months) if a.value.starts_with?("76 - 99")
          end
          if a.survey_question.tag == "hometown"
            location = Geocoder.search(a.value)
            @user.latitude = location[0].latitude rescue nil
            @user.longitude = location[0].longitude rescue nil
          end
        end
      end
      @user.save
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
