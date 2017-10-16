FactoryGirl.define do
  factory :item do
    content { Faker::StarWars.character }
    done false
    todo_id nil
  end
end
