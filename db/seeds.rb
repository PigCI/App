# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Seeds::Install.new.save!

Seeds::User.new.save!

Seeds::GithubRepository.new.save!

Seeds::Project.new.save!

7.times do |day_offset|
  3.times do |hour_offset|
    created_at = Time.now - (7 - day_offset).days - (7 - hour_offset * 2.3).hours
    Seeds::ReportCollection.new(
      created_at: created_at
    ).save!
  end
end
