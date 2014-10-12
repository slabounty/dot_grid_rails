FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :document do
    name "My Cool Document"
    file_name "dotgrid.pdf"
    orientation "portrait"
    page_type "planner"
    dot_weight 1.5
    margin 0.0
    page_size "LETTER"
    grid_color "B3B3B3"
    spacing 5
    planner_color_1 "CCCCCC"
    planner_color_2 "0099ff"
    user
  end
end
