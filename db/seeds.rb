require 'faker'

p 'destroying existing records'

Review.destroy_all
Restaurant.destroy_all

p 'seeding...'

10.times do
    resto = Restaurant.create!(
        name: Faker::Restaurant.name,
        address: Faker::Address.full_address,
        phone_number: Faker::PhoneNumber.cell_phone,
        category: ["chinese", "italian", "japanese", "french", "belgian"].sample
    )
    rand(1..5).times do
        Review.create!(
            content: Faker::Restaurant.review,
            rating: rand(1..5),
            restaurant: resto
        )
    end
end

p 'completed'