# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.where(email: 'bfox@opuslogica.com').first_or_create(password: 'idtmp2tv', password_confirmation: 'idtmp2tv')

survey_groups = [
  { name: "Health Baseline",
    questions: [
      { name: "Codename", data_type: "String", selection_type: "Fixed", instructions: "Your codename is chosen for you!" },
      { name: "Birthdate", data_type: "Date", selection_type: "Date", instructions: "Your date of birth helps us to understand your problems better" },
      { name: "Gender at Birth", data_type: "String", selection_type: "Pick One", options: ["Male", "Female", "Other"], instructions: "This is unrelated to your current gender" }
    ]},
  { name: "Illness & Symptoms",
    questions: [
      { name: "I have been diagnosed with cancer", data_type: "String", selection_type: "Pick Many With Other",
        options: [
          "Angiosarcoma",
          "Chondrosarcoma",
          "Ewing's Sarcoma",
          "Fibrosarcoma",
          "Gastrintestinal Stromal Tumor",
          "Leiomyosarcoma",
          "Liposarcoma",
          "Malignant Peripheral Nerve Sheath Tumor",
          "Osteosarcoma",
          "Rhabdomyosarcoma",
          "Synovial Sarcoma"
        ],
        instructions: "Select all that apply" },

      { name: "I have the following symptoms", data_type: "String", selection_type: "Pick Many With Other",
        options: [
          "Skin Irritations/Rashes/Lesions",
          "Eye Irritation/Vision Issues",
          "Upper Respiratory Issues (nose, sinus, throat)",
          "Lower Respiratory Issues (difficulty breathing)",
          "Kidney/Liver/Pancreas Issues",
          "Neurological issues",
          "Psychological Issues/Depression",
          "Gastrointestinal issues / nausea",
          "Cardiovascular issues",
          "Headaches / dizziness",
          "Genealogical issues",
          "Fatigue",
          "Muscular / skeletal issues",
          "Balding / hair loss" ],
        instructions: "Select all that apply, including pre-existing conditions" },
    ]},
  
  { name: "Locations & Roles",
    questions: [
      { name: "My role(s) during the spill", data_type: "String", selection_type: "Pick Many With Other",
        options: [
          "Community member",
          "Cleanup worker",
          "BP employee",
          "Volunteer",
          "Government employee",
          "Contractor",
          "Fisherman",
          "Boat captain / crew" ],
        instructions: "Select all that apply" },
      { name: "Location where you were exposed", data_type: "String", selection_type: "Location", instructions: "Enter zip code, address, or other location information" },
      { name: "Location where you live now", data_type: "String", selection_type: "Location", instructions: "Enter zip code, address, or other location information" }
    ]}
];

survey_groups.each_with_index do |group, gi|
  group[:position] = gi + 1
  ar_group = SurveyGroup.where(name: group[:name]).first_or_create
  ar_group.update_attributes(instructions: group[:instructions], position: group[:position])
  ar_group.save
  group[:questions].each_with_index do |question, qi|
    question[:position] = qi + 1
    ar_question = SurveyQuestion.where(name: question[:name]).first_or_create
    ar_question.update_attributes(survey_group: ar_group, instructions: question[:instructions], data_type: question[:data_type],
                                  selection_type: question[:selection_type], position: question[:position])
    ar_question.save
    if question[:options]
      question[:options].each_with_index do |opttext, oi|
        option = { name: opttext, position: oi + 1 }
        ar_option = QuestionOption.where(name: option[:name]).first_or_create
        ar_option.update_attributes(survey_question: ar_question, name: option[:name], position: option[:position])
        ar_option.save
      end
    end
  end
end


