# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
user1 = User.create(name: "name1")
user2 = User.create(name: "name2")
user3 = User.create(name: "name3")
user4 = User.create(name: "name4")
user5 = User.create(name: "name5")
user6 = User.create(name: "name6")
user7 = User.create(name: "name7")
user8 = User.create(name: "name8")

Poll.destroy_all
poll1 = Poll.create(title: "title1", author_id: user1.id)
poll2 = Poll.create(title: "title2", author_id: user2.id)
poll3 = Poll.create(title: "title3", author_id: user3.id)
poll4 = Poll.create(title: "title4", author_id: user3.id)

Question.destroy_all
question1 = Question.create(text: "text1", poll_id: poll1.id)
question2 = Question.create(text: "text2", poll_id: poll2.id)
question3 = Question.create(text: "text3", poll_id: poll3.id)
question4 = Question.create(text: "text4", poll_id: poll4.id)
question5 = Question.create(text: "text5", poll_id: poll1.id)

AnswerChoice.destroy_all
answerchoice1 = AnswerChoice.create(question_id: question1.id, choice: "choice1")
answerchoice2 = AnswerChoice.create(question_id: question2.id, choice: "choice2")
answerchoice3 = AnswerChoice.create(question_id: question3.id, choice: "choice3")
answerchoice4 = AnswerChoice.create(question_id: question3.id, choice: "choice4")

response1 = Response.create(user_id: user1.id, choice_id: answerchoice1.id)
response2 = Response.create(user_id: user2.id, choice_id: answerchoice2.id)
response3 = Response.create(user_id: user3.id, choice_id: answerchoice3.id)
response4 = Response.create(user_id: user4.id, choice_id: answerchoice4.id)
