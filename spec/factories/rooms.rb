FactoryBot.define do
  factory :room,class: Room do
    name {"test_room"}
    admin_id{"1"}
    youtube_id{"youtube_id"}
    is_private{false}
  end
  
  factory :room_create, class: Room do
    sequence(:name) { |n| "room#{n}" }
    sequence(:youtube_id) { |n| "#{n}" }
    sequence(:admin_id) { |n| "#{n}" }
    is_private{false}
    start_time{Time.current}
  end
end