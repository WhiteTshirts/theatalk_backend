FactoryBot.define do
  factory :user_create,class: User do
    name {|n|"hoge#{n}"}
    password {|n|"fuga#{n}"}
  end
  factory :user,class: User do
    name {"test_user"}
    password {"hoge"}
  end
  
end