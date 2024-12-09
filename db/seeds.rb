# frozen_string_literal: true

user = User.create!(
  name: "Admin User",
  email: "admin@bogomil.io",
  password: "sesam1234!",
  password_confirmation: "sesam1234!",
)
Current.user = user

current_date = Date.current
consumer_indicies_data = [
  [current_date.years_ago(2).year, (1..12)],
  [current_date.prev_year.year, (1..12)],
  [current_date.year, (1..current_date.month.to_i)],
].flat_map do |year, months|
  months.map do |month|
    number = (SecureRandom.random_number * (2.5 - 1.5) + 1.5).round(2)
    {
      year: year,
      month: month,
      index: 100 + number,
      previous_year: 100 + (number - 0.3),
      previous_month: number,
    }
  end
end
ConsumerIndex.create(consumer_indicies_data)

Collection.create!(collectable: RealEstate.new(
  name: "Muster Object",
  street: "Musterstraße 46",
  zip_code: "81667",
  city: "München",
  rooms: 3,
  size: 75,
))
