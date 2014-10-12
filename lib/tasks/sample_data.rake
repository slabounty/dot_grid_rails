namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    3.times do
      users.each { |user| user.documents.create!(
        name: Faker::Lorem.words(3).join(' '),
        file_name: "#{Faker::Lorem.word}.pdf",
        orientation: ["portrait", "landscape"][rand(2)],
        page_type: %w[planner checkerboard grid dot_grid horizontal_rule grid_plus_lines dot_dash][rand(7)],
        dot_weight: rand(0.5 .. 2.5).round(2),
        margin: rand(0.0 .. 1.0).round(2),
        page_size: %w[LETTER LEGAL A4 A5 B4 B5 3x5in][rand(7)],
        grid_color: "B3B3B3",
        spacing: rand(9)+1,
        planner_color_1: "CCCCCC",
        planner_color_2: "0099ff"
        ) }
    end
  end
end
