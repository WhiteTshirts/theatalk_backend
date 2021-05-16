#rikuiwasaki
FactoryBot.define do
  factory :room_create,class: Room do
    name {|n|"room#{n}"}
    youtube_id{|n|"#{n}"}
    admin_id{|n|"#{n}"}
    start_time{Time.current}
  end
  factory :room do
    name{"room"}
    youtube_id{"youtube_id"}
    admin_id{1}
    start_time{Time.current}
  end
end
#rikuiwasaki