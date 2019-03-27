RSpec.describe UsersController, type: :controller do

  let!(:user) { create(:user) }

  describe 'GET users#index' do
    it 'assigns @users' do
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET users#show' do
    it 'assigns @user' do
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the show template' do
      get :show, id: user.id
      expect(response).to render_template('show')
    end
  end

  describe 'GET users#edit' do
    it 'assigns @user' do
      get :edit, id: user.id
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the edit template' do
      get :edit, id: user.id
      expect(response).to render_template('edit')
    end
  end

  describe 'POST users#create' do
    let(:subject) do
      post :create, user: { first_name: 'Andy', last_name: 'Wang', age: 20, gender: 'male', address: { country: 'CN', address_1: 'SZ city', address_2: 'GZ city' } }
    end

    it 'should create a new user successfully' do
      expect do
        subject
      end.to change(User, :count).by(1)
    end

    it 'renders the show template' do
      subject
      expect(response).to redirect_to("/users/#{assigns(:user).id}")
    end
  end

  describe 'PUT users#update' do
    let(:subject) do
      put :update, id: user.id, user: { first_name: 'Jason', last_name: 'Wu', age: 20, gender: 'male', address: { country: 'CN', address_1: 'SZ city', address_2: 'GZ city' } }
    end

    it 'should update the user successfully' do
      subject
      expect(user.reload.first_name).to eq('Jason')
    end

    it 'renders the show template' do
      subject
      expect(response).to redirect_to("/users/#{assigns(:user).id}")
    end
  end


  describe 'DELETE users#destroy' do
    it 'should destroy the user successfully' do
      expect do
        delete :destroy, id: user.id
      end.to change(User, :count).from(1).to(0)
    end

    it 'renders the index template after destroy the user' do
      delete :destroy, id: user.id
      expect(response).to redirect_to('/users')
    end
  end
end
