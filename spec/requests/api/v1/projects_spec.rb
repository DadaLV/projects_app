require 'rails_helper'

RSpec.describe "Projects API", type: :request do
  let(:user) { create(:user) }

  before do
    post '/api/v1/sign_in', params: { email: user.email, password: user.password }
    @headers = { 'Authorization' => "Bearer #{user.authentication_token}" }
  end

  describe "GET /api/v1/projects" do
    let!(:projects) { create_list(:project, 5, user: user) }

    before do
      get '/api/v1/projects', headers: @headers, as: :json
    end

    it "returns a successful response" do
      expect(response).to have_http_status(200)
    end

    it "returns all projects" do
      expect(json_response.size).to eq(5)
    end
  end

  describe "GET /api/v1/projects/:id" do
    let(:project) { create(:project, user: user) }

    before do
      get "/api/v1/projects/#{project.id}", headers: @headers, as: :json
    end

    it "returns a successful response" do
      expect(response).to have_http_status(200)
    end

    it "returns the requested project" do
      expect(json_response['id']).to eq(project.id)
    end
  end

  describe "POST /api/v1/projects" do
    let(:valid_attributes) { { project: { name: 'New Project', description: 'Description', user_id: user.id } } }

    context "with valid parameters" do
      before do
        post '/api/v1/projects', params: valid_attributes, headers: @headers, as: :json
      end

      it "creates a new project" do
        expect(response).to have_http_status(201)
      end

      it "returns the newly created project" do
        expect(json_response['name']).to eq('New Project')
      end
    end

    context "with invalid parameters" do
      before do
        post '/api/v1/projects', params: { project: { name: '', description: '', user_id: user.id } }, headers: @headers, as: :json
      end
    
      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    
      it "returns a validation error message" do
        expect(json_response.values.flatten).to include("can't be blank")
      end
    end
  end

  describe "PUT /api/v1/projects/:id" do
    let(:project) { create(:project, user: user) }
    let(:updated_attributes) { { project: { name: 'Updated Project' } } }

    before do
      put "/api/v1/projects/#{project.id}", params: updated_attributes, headers: @headers, as: :json
    end

    it "returns a successful response" do
      expect(response).to have_http_status(200)
    end

    it "updates the project" do
      expect(project.reload.name).to eq('Updated Project')
    end
  end

  describe "DELETE /api/v1/projects/:id" do
    let!(:project) { create(:project, user: user) }

    before do
      delete "/api/v1/projects/#{project.id}", headers: @headers, as: :json
    end

    it "returns a successful response" do
      expect(response).to have_http_status(204)
    end

    it "deletes the project" do
      expect(Project.exists?(project.id)).to be_falsy
    end
  end
end
