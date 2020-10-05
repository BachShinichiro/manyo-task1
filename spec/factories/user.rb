FactoryBot.define do
  factory :user do
    name { "Admin" }
    email { "admin@admin.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
  end
  factory :second_user, class: User do
    name { "picassopicasso" }
    email { "picasso@picasso.com" }
    password { "picassopicasso0123" }
    password_confirmation { "picassopicasso0123" }
    admin { false }
  end
end