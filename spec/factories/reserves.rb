FactoryBot.define do
  factory :reserve do
    office { nil }
    client { nil }
    interview_begin_at { "2022-11-28 14:07:38" }
    interview_end_at { "2022-11-28 14:07:38" }
    user_name { "MyString" }
    user_age { 1 }
    contact_tel { "MyString" }
    note { "MyText" }
    is_contacted { false }
  end
end
