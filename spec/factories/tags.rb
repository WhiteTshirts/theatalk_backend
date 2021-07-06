FactoryBot.define do
  factory :tag_create, class: Tag do
    sequence(:name) { |n| "tag#{n+1}" }
  end

  factory :tag do
    name{"tag"}
  end
end
