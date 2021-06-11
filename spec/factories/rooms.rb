FactoryBot.define do
  factory :room,class: Room do
    name {"test_room"}
    admin_id{"1"}
    youtube_id{"youtube_id"}
    is_private{false}
  end
  
  factory :room_create,class: Room do
    name {|n|"room#{n}"}
    youtube_id{|n|"#{n}"}
    admin_id{|n|"#{n}"}
    is_private{false}
    start_time{Time.current}
  end
end