FactoryBot.define do
  factory :tag_create,class: Tag do
    name {|n| "tag#{n}"}
  end
  factory :tag do
    name{"tag"}
  end
end
