require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe 'GET #index' do


    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @topics with all topics ordered by title' do
      topic1 = Topic.create( name: 'Topic 1')
      topic2 = Topic.create( name: 'Topic 2')
      get :index
      expect(assigns(:topics)).to include(topic1, topic2)
    end


    it 'returns the status code 200' do
      get :index
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET #show' do
    let(:topic) { Topic.create(name:"my topic") }
    it 'renders the show template' do
      get :show, params: { id: topic.id }
      expect(response).to render_template(:show)
    end

    it "assigns @topic with topic" do
      get :show, params: { id: topic.id}
      expect(assigns(:topic)).to eq(topic)
    end

    it 'returns the status code 200' do
      get :show, params: {id: topic.id}
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new Topic instance to @topic' do
      get :new
      expect(assigns(:topic)).to be_a_new(Topic)
    end

    it 'returns the status code 200' do
      get :new
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET #edit' do
    let(:topic) { Topic.create(name: 'hunting')}

    it 'renders the edit template' do
      get :edit, params: { id: topic.id }
      expect(response).to render_template(:edit)
    end

    it 'returns the status code 200' do
      get :edit, params: { id: topic.id }
      expect(response).to have_http_status(200)
    end

  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Topic' do
        expect{post :create, params: { topic: { name: 'New Topic' } } }.to change(Topic, :count).by(1)
      end

      it 'redirects to the topics index' do
        post :create, params: { topic: { name: 'New Topic' } }
        expect(response).to redirect_to(topics_path)
      end

      it 'sets a flash notice' do
        post :create, params: { topic: { name: 'New Topic' } }
        expect(flash[:notice]).to eq('Topic was successfully created.')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Topic' do
        expect { post :create, params: { topic: { name: nil } } }.not_to change(Topic, :count)
      end

      it 'renders the new template again' do
        post :create, params: { topic: { name: '' } }
        expect(response).to render_template(:new)
      end

      it 'sets a flash alert' do
        post :create, params: { topic: { name: '' } }
        expect(flash[:alert]).to eq( nil )
      end
    end
  end

  describe 'PATCH #update' do
    let(:topic) { Topic.create(name: 'Old Name') }

    context 'with valid parameters' do
      it 'updates the requested topic' do
        patch :update, params: { id: topic.id, topic: { name: 'New Name' } }
        topic.reload
        expect(topic.name).to eq('New Name')
      end

      it 'redirects to the topic' do
        patch :update, params: { id: topic.id, topic: { name: 'New Name' } }
        expect(response).to redirect_to(topic_path(topic))
      end

      it 'sets a flash notice' do
        patch :update, params: { id: topic.id, topic: { name: 'New Name' } }
        expect(flash[:notice]).to eq('Topic was successfully updated.')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the topic' do
        patch :update, params: { id: topic.id, topic: { name: nil } }
        topic.reload
        expect(topic.name).to eq('Old Name')
      end

      it 'renders the edit template again' do
        patch :update, params: { id: topic.id, topic: { name: nil } }
        expect(response).to render_template(:edit)
      end

      it 'sets a flash alert' do
        patch :update, params: { id: topic.id, topic: { name: '' } }
        expect(flash[:alert]).to eq( nil )
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:topic) {Topic.create(name: 'Topic to be deleted')}
    it 'destroys the requested topic' do

      expect { delete :destroy, params: { id: topic.id } }.to change(Topic, :count).by(-1)
    end

    it 'redirects to the topics index' do

      delete :destroy, params: { id: topic.id }
      expect(response).to redirect_to(topics_path)
    end

    it 'sets a flash notice' do

      delete :destroy, params: { id: topic.id }
      expect(flash[:notice]).to eq('Topic was deleted successfully')
    end
  end
end
