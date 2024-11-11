require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    before { create_list(:user, 3) }

    it 'returns a list of users' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    it 'returns a specific user' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(user.id)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { name: 'Sample Name', unit: 'sample unit', quantity: 10, price: 25.50, category_id: category.id } }
    let(:category) { create(:category) }

    context 'with valid attributes' do
      it 'create a new user' do
        expect { post :create, params: { user: valid_attributes } }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it "doesn't create a new user" do
        invalid_attributes = valid_attributes.merge(name: nil)
        post :create, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['name']).to include("can't be blank")
      end
    end
  end

  describe 'PUT #update' do
    let(:update_attributes) { { name: 'Updated Name', unit: 'Updated unit', quantity: 20, price: 15.50, category_id: category.id } }
    let(:user) { create(:user) }
    let(:category) { create(:category) }

    context 'with valid attributes' do
      it 'update an user' do
        puts user.inspect
        put :update, params: { id: user.id, user: update_attributes }
        user.reload
        expect(user.name).to eq('Updated Name')
        expect(user.unit).to eq('Updated unit')
        expect(user.quantity).to eq(20)
        expect(user.price).to eq(15.50)
        expect(user.category_id).to eq(category.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the user" do
        invalid_attributes = update_attributes.merge(quantity: -15)
        put :update, params: { id: user.id, user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['quantity']).to include("must be greater than or equal to 0")
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }   # user is saved before the test run (let!)

    it 'deletes a specific user' do
      expect { delete :destroy, params: { id: user.id } }.to change(User, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
