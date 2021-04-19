#rikuiwasaki
FactoryBot.define do
  factory :user_create,class: User do
    name {|n|"hoge#{n}"}
    password {|n|"fuga#{n}"}
  end
  factory :user do
    name{"hoge"}
    password{"hoge"}
  end
end
#rikuiwasaki