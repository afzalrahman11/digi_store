require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe 'GET #index' do
    before { create_list(:item, 3) }

    it 'returns a list of items' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET #show' do
    let(:item) { create(:item) }

    it 'returns a specific item' do
      get :show, params: { id: item.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(item.id)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { name: 'Sample Name', unit: 'sample unit', quantity: 10, price: 25.50, category_id: category.id } }
    let(:category) { create(:category) }

    context 'with valid attributes' do
      it 'create a new item' do
        expect { post :create, params: { item: valid_attributes } }.to change(Item, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it "doesn't create a new item" do
        invalid_attributes = valid_attributes.merge(name: nil)
        post :create, params: { item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['name']).to include("can't be blank")
      end
    end
  end

  describe 'PUT #update' do
    let(:update_attributes) { { name: 'Updated Name', unit: 'Updated unit', quantity: 20, price: 15.50, category_id: category.id } }
    let(:item) { create(:item) }
    let(:category) { create(:category) }

    context 'with valid attributes' do
      it 'update an item' do
        puts item.inspect
        put :update, params: { id: item.id, item: update_attributes }
        item.reload
        expect(item.name).to eq('Updated Name')
        expect(item.unit).to eq('Updated unit')
        expect(item.quantity).to eq(20)
        expect(item.price).to eq(15.50)
        expect(item.category_id).to eq(category.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the item" do
        invalid_attributes = update_attributes.merge(quantity: -15)
        put :update, params: { id: item.id, item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['quantity']).to include("must be greater than or equal to 0")
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:item) { create(:item) }   # item is saved before the test run (let!)

    it 'deletes a specific item' do
      expect { delete :destroy, params: { id: item.id } }.to change(Item, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
