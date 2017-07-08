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
      { name: "Codename", tag: "codename", data_type: "String", selection_type: "Fixed", instructions: "Your codename is chosen for you!" },

#       { name: "Birthdate", tag: "birthdate", data_type: "Date", selection_type: "Date", instructions: "Your date of birth helps us to understand your problems better" },

      { name: "Birthdate", tag: "birthdate", data_type: "String", selection_type: "Pick One", options: ["0 - 5 years", "6 - 10 years", "11 - 17 years", "18 - 25 years", "26 - 35 years", "36 - 45 years", "46 - 55 years" "56 - 65 years", "66 - 75 years", "76 - 99 years"], instructions: "Your age helps us to understand your problems better" },


      { name: "Gender at Birth", tag: "gender", data_type: "String", selection_type: "Pick One", options: ["Male", "Female"], instructions: "This is unrelated to your current gender" },
      { name: "Life Status", tag: "life-status", data_type: "String", selection_type: "Pick One", options: ["Alive", "Bedridden", "Deceased"], instructions: "How well is the patient doing overall?" },
      { name: "Date Passed", tag: "passdate", data_type: "Date", selection_type: "Date", instructions: "The date of birth that this individual passed.", dependent_on: "life-status", dependent_value: "Deceased" }
    ]},
  { name: "Illness & Symptoms",
    questions: [
      { name: "I have a cancer diagnosis...", tag: "has_cancer", data_type: "String", selection_type: "Boolean" },
      { name: "Check all that apply", tag: "cancers", data_type: "String", selection_type: "Pick Many With Other", dependent_on: "has_cancer", dependent_value: "Yes",
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

      { name: "I have the following symptoms", tag: "symptoms", data_type: "String", selection_type: "Pick Many With Other",
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
      { name: "My role(s) during the spill", tag: "role", data_type: "String", selection_type: "Pick Many With Other",
        options: [
          "Community member",
          "Cleanup worker",
          "BP employee",
          "Volunteer",
          "Government employee",
          "Contractor",
          "Fisherman",
          "Boat captain / crew",
          "Just went to the beach" ],
        instructions: "Select all that apply" },
      { name: "Location where you were exposed", tag: "exposed-at", data_type: "String", selection_type: "Location", instructions: "Enter zip code, address, or other location information" },
      { name: "Location where you live now", tag: "hometown", data_type: "String", selection_type: "Location", instructions: "Enter zip code, address, or other location information" }
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
                                  selection_type: question[:selection_type], tag: question[:tag], dependent_on: question[:dependent_on],
                                  dependent_value: question[:dependent_value], position: question[:position])
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


