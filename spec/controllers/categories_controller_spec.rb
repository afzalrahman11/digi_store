require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET /index' do
    before { create_list(:category, 3) }

    it 'returns a list of categories' do
      get '/categories'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /show' do
    let(:category) { create(:category) }

    it 'returns a specific category' do
      get "/categories/#{category.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(category.id)
    end

    it 'returns a 404 if a category is not found' do
      get '/categories/10101'     # assuming 10101 ID doesn't exists
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /create' do
    let(:valid_attributes) { { name: 'Sample Name', unit: 'sample unit' } }
    let(:category) { create(:category) }

    context 'with valid attributes' do
      it 'create a new category' do
        expect { post '/categories', params: { category: valid_attributes } }.to change(Category, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it "doesn't create a new category" do
        invalid_attributes = valid_attributes.merge(name: nil)
        post '/categories', params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['name']).to include("can't be blank")
      end
    end
  end

  describe 'PUT /update' do
    let(:update_attributes) { { name: 'Updated Name', unit: 'Updated unit' } }
    let(:category) { create(:category) }

    context 'with valid attributes' do
      it 'update a category' do
        puts category.inspect
        put "/categories/#{category.id}", params: { category: update_attributes }
        category.reload
        expect(category.name).to eq('Updated Name')
        expect(category.unit).to eq('Updated unit')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the category" do
        invalid_attributes = update_attributes.merge(unit: nil)
        put "/categories/#{category.id}", params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['unit']).to include("can't be blank")
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:category) { create(:category) }   # category is saved before the test run (let!)

    it 'deletes a specific category' do
      expect { delete "/categories/#{category.id}" }.to change(Category, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
