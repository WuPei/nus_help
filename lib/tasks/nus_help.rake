namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end


def make_users
  # commonly used global variables
  passwd  = "foobar"
  account = "STUB_ACCOUNT"

  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true,
                       gender: 1,
                       account: account + 0.to_s,
                       remember_token: (account + (0).to_s),
                       )
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 gender: 1,
                 password_confirmation: password,
                 account: account + (n + 1).to_s,
                 remember_token: (account + (n + 1).to_s)
                 )
  end
end 

def make_microposts
  users = User.all(limit: 6)
  50.times do
    users.each { |user|

      user.microposts.create!(content: Faker::Lorem.sentence(5),
                              title: Faker::Lorem.words,
                              gift: Faker::Lorem.words(2),
                              deadline: "03 May 12",
                              module_id: 1,
                             )
    }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

