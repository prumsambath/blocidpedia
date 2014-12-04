require 'rails_helper'

RSpec.describe WikisController, :type => :controller do
  shared_examples 'public access to wikis' do
    describe 'GET #index' do
      it 'populates only public wikis' do
        public_wiki = create(:wiki)
        private_wiki = create(:private_wiki)
        get :index
        expect(assigns(:wikis)).to match_array([public_wiki])
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template(:index)
      end 
    end
  end

  shared_examples 'full access to wikis' do
    describe 'Get #new' do
      it 'assigns a new wiki to @wiki' do
        get :new
        expect(assigns(:wiki)).to be_a_new(Wiki)
      end

      it 'renders the :new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested wiki to @wiki' do
        get :edit, id: wiki
        expect(assigns(:wiki)).to eq(wiki)
      end

      it 'renders the :edit template' do
        get :edit, id: wiki
        expect(response).to render_template(:edit)
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves the new wiki in the database' do
          expect {
            post :create, wiki: attributes_for(:wiki)
          }.to change(Wiki, :count).by(1)
        end

        it 'redirects to wikis#index' do
          post :create, wiki: attributes_for(:wiki)
          expect(response).to redirect_to(wikis_path)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new wiki in the database' do
          expect {
            post :create, wiki: attributes_for(:invalid_wiki)
          }.to_not change(Wiki, :count)
        end

        it 're-renders the :new template' do
          post :create, wiki: attributes_for(:invalid_wiki)
          expect(response).to render_template(:new)
        end 
      end
    end

    describe 'PATCH #update' do
      before :each do
        @wiki = create(:wiki, 
          title: 'A sample wiki title',
          body: 'A sampple wiki body',
          user: user
        )
      end

      context 'with valid attributes' do
        it 'locates the requested wiki' do
          patch :update, id: @wiki, wiki: attributes_for(:wiki)
          expect(assigns(:wiki)).to eq(@wiki)
        end

        it "changes @wiki's attributes" do
          patch :update, id: @wiki, wiki: attributes_for(:wiki,
            title: 'New title that will be changed.',
            body: 'New body that will also be changed.')
          @wiki.reload
          expect(@wiki.title).to eq('New title that will be changed.')
          expect(@wiki.body).to eq('New body that will also be changed.')
        end

        it 'redirects to wikis#index' do
          patch :update, id: @wiki, wiki: attributes_for(:wiki)
          expect(response).to redirect_to(wikis_path)
        end
      end

      context 'with invalid attributes' do
        it "does not change the wiki's attributes" do
          patch :update, id: @wiki, wiki: attributes_for(:wiki,
            title: 'New title of the updated wiki',
            body: nil)
          @wiki.reload
          expect(@wiki.title).to_not eq('New title of the updated wiki')
          expect(@wiki.body).to eq('A sampple wiki body')
        end

        it 're-renders the edit template' do
          patch :update, id: @wiki, wiki: attributes_for(:invalid_wiki)
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes the wiki' do
        wiki.user # used to initialize wiki variable
        expect {
          delete :destroy, id: wiki
        }.to change(Wiki, :count).by(-1)
      end

      it 'redirects to wikis#path' do
        delete :destroy, id: wiki
        expect(response).to redirect_to(wikis_path)
      end
    end
  end

  describe 'user access to wikis' do
    let(:user) { create(:user) }
    let(:wiki) { create(:wiki, user: user)}

    before :each do
      sign_in user
    end

    it_behaves_like 'public access to wikis'
    it_behaves_like 'full access to wikis'
  end

  describe 'guest access to wikis' do
    let(:wiki) { create(:wiki) }

    it_behaves_like 'public access to wikis'

    describe 'POST #create' do
      it 'requires login' do
        post :create, id: wiki, wiki: attributes_for(:wiki)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: wiki
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
