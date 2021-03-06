FactoryBot.define do
  factory :dm_message do
    user_id { 1 }
    dm_id { 1 }
    message { "MyString" }
  end
end
