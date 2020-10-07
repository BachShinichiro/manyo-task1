FactoryBot.define do
  factory :label do
    name { "ラベル1" }
  end
  factory :label2 , class: Label do
    name { "ラベル2" }
  end
end
