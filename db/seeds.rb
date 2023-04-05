require "csv"

CSV.foreach('db/brands.csv', headers: true) do |row|
  begin
    Brand.create!(id: row[0], name: row[1])
  rescue ActiveRecord::RecordNotUnique => e
    # idが重複する場合はスキップする
  end
end

CSV.foreach('db/shapes.csv', headers: true) do |row|
  Shape.create!(:id => row[0], :name => row[1])
end

CSV.foreach('db/colors.csv', headers: true) do |row|
  Color.create!(:id => row[0], :name => row[1], :code => row[2])
end
