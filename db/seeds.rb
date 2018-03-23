# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories = Category.create([{ 'name' => 'Giày thể thao nữ'},
                              {'name' => 'Giày cao nữ'},
                              {'name' => 'Giày bệt nữ'},
                              {'name' => 'Giày thể thao nam'},
                              {'name' => 'Giày da nam'},
                              {'name' => 'Giày thể thao trẻ em'}
                            ])

products = Product.create([
                            {'name' => 'Thể Thao Trắng Đen','description' => 'Có đủ size', 'category_id' => 1 ,'price' => 300000},
                            {'name' => 'Trắng Thêu Hoa','description' => 'Tùy chọn hình thêu', 'category_id' => 1 ,'price' => 450000},
                            {'name' => 'Slip on đinh da bóng','description' => 'Có 2 màu trắng, đen', 'category_id' => 1 ,'price' => 500000},
                            {'name' => 'Hở mũi quai đan','description' => 'Có 2 màu đen , nude', 'category_id' => 2 ,'price' => 1200000},
                            {'name' => 'Đen quai chéo','description' => 'Có 7 phân và 12 phân', 'category_id' => 2 ,'price' => 1000000},
                            {'name' => 'Búp bê có nơ','description' => 'có 2 màu hồng, đen', 'category_id' => 3 ,'price' => 350000},
                            {'name' => 'Búp bê mũi nhọn nơ chìm','description' => 'Có 2 màu hồng, trắng', 'category_id' => 3 ,'price' => 400000},
                            {'name' => 'Búp bê nơ ngang','description' => 'Có thể tháo nơ', 'category_id' => 3 ,'price' => 450000},
                            {'name' => 'Giày nike air','description' => 'Có đủ size nam, nữ', 'category_id' => 4 ,'price' => 800000},
                            {'name' => 'Giày adidas','description' => 'Có đủ size nam, nữ', 'category_id' => 4 ,'price' => 750000},
                            {'name' => 'Giày da buộc dây màu nâu','description' => 'Có 2 màu nâu, đen', 'category_id' => 5 ,'price' => 1500000},
                            {'name' => 'Giày da cao cổ','description' => 'Có đủ size', 'category_id' => 5 ,'price' => 1700000},
                            {'name' => 'Giày lười','description' => 'Có đủ size', 'category_id' => 5 ,'price' => 1200000},
                            {'name' => 'Giày thể thao hồng','description' => 'Có đủ size', 'category_id' => 6 ,'price' => 350000},
                            {'name' => 'Giày thể thao quai dán','description' => 'Có đủ size, có 2 màu trắng, đen', 'category_id' => 6 ,'price' => 480000}
                          ])

