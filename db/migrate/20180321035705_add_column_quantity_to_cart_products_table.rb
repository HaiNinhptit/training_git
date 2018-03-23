class AddColumnQuantityToCartProductsTable < ActiveRecord::Migration[5.1]
  def change
    add_column :cart_products, :quantity, :integer, default: 1
  end
end
