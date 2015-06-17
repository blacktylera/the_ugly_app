Fabricator(:user) do
  name   { Faker::Name.name }
  email  { Faker::Internet.email }
  password              "Tubthumping1"
  password_confirmation "Tubthumping1"
end