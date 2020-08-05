require 'faker'

p 'seeding...'

10.times do
    resto = Restaurant.create!(
        name: Faker::Restaurant.name,
        address: Faker::Address.full_address,
        phone: Faker::PhoneNumber.cell_phone,
        # category: ['Chinese', 'Italian', 'Mexican'].sample
        category: Faker::Restaurant.type
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