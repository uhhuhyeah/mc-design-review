# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do
    title "MyString"
    user nil
    co_presenter_ids "MyText"
    date "2012-07-13"
    description "MyText"
    attend "MyText"
    prepare "MyText"
    expect "MyText"
    length 1
  end
end
