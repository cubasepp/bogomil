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

real_estate = RealEstate.create!(
  name: "Muster Object",
  street: "Musterstraße 46",
  zip_code: "81667",
  city: "München",
  units: 3,
  space: 300,
  built_at: "01/1978",
  renovated_at: "10/2024",
  energy_certificate: true,
  heating_type: "heat_pump_air",
  heating_designation: "xxx",
  heating_manufacturer: "Stiebel Eltron",
  heating_installed_at: "03/2024",
  solar_plant_present: true,
  solar_plant_manufacturer: "solis",
  solar_plant_designation: "XXXX",
  solar_plant_capacity: "12.8",
  solar_plant_battery_capacity: "15",
  solar_plant_installed_at: "03/2024",
  membership: Membership.new(user:),
)
3.times do |i|
  LivingUnit.create!(
    name: "Wohneinheit #{i}",
    description: Faker::Lorem.sentence,
    real_estate: real_estate,
    # rents: [
    #   Rent.new(
    #     cold_rent: 1000,
    #     heating_costs: 250,
    #     incidental_costs: 100,
    #     rent_type: "normal",
    #     valid_from: Time.zone.now,
    #   ),
    # ],
  )
end
