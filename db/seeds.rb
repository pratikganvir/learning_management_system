# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Admin.create(
    first_name: 'Super', last_name: 'Admin', admin_type: 'super_admin',
    login_attributes: {email: 'super_admin@testlms.com', password: 'test123', password_confirmation: 'test123'}
)

Admin.create(
    first_name: 'School', last_name: 'Admin', admin_type: 'school_admin',
    login_attributes: {email: 'school_admin@testlms.com', password: 'test123', password_confirmation: 'test123'}
)
