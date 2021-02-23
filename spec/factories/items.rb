# spec/factories/items.rb
FactoryBot.define do
  factory :item do
    name { Faker::Movies::StarWars.character }
    done { Faker::Boolean.boolean(true_ratio: 0.2) }
    todo_id nil
  end
end
