require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should be successful with all fields completed' do
      @category = Category.create name: 'Tester'
      @product = Product.new(name: 'Test Product', description: 'Test Description', image: 'myimg/img.jpg', price_cents: 100, quantity: 1)
      @product.category_id = @category.id
      @product.save!
      expect(@product).to be_valid
    end
    it 'should be invalid without a name' do
      @category = Category.create name: 'Tester'
      @product = Product.create(description: 'Test Description', image: 'img/myimg.jpg', price_cents: 100, quantity: 1)
      @product.category_id = @category.id
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include('Name can\'t be blank')
    end
    it 'should be invalid without a price' do
      @category = Category.create name: 'Tester'
      @product = Product.create(name: 'Test Product', description: 'Test Description', image: 'img/myimg.jpg', quantity: 1)
      @product.category_id = @category.id
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include('Price can\'t be blank')
    end
    it 'should be invalid without a quantity' do
      @category = Category.create name: 'Tester'
      @product = Product.create(name: 'Test Product', description: 'Test Description', image: 'img/myimg.jpg', price_cents: 100)
      @product.category_id = @category.id
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include('Quantity can\'t be blank')
    end
    it 'should be invalid without a category' do
      @product = Product.create(name: 'Test Product', description: 'Test Description', image: 'img/myimg.jpg', price_cents: 100, quantity: 1)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include('Category can\'t be blank')
    end
  end
end
