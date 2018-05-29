ActiveRecord::Schema.define do
  create_table :houses, force: true do |t|
    t.string :name
    t.string :address
  end

  create_table :employees, force: true do |t|
    t.string :name
    t.references :house
  end

  create_table :shifts, force: true do |t|
    t.references :house
    t.references :employee
    t.datetime :starts_at
    t.datetime :ends_at
  end
end
