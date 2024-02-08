require 'rails_helper'

RSpec.describe "Tasks API", type: :request do
  let(:user) { create(:user) }
  
  
  before do
    post '/api/v1/sign_in', params: { email: user.email, password: user.password }
    @headers = { 'Authorization' => "Bearer #{user.authentication_token}" }
  end
  let(:project) { create(:project, user: user) }

  describe "GET /api/v1/projects/:project_id/tasks" do
    let!(:tasks) { create_list(:task, 5, project: project) }

    before do
      get "/api/v1/projects/#{project.id}/tasks", headers: @headers, as: :json
    end

    it "returns a successful response" do
      expect(response).to have_http_status(200)
    end

    it "returns all tasks associated with the project" do
      expect(json_response.size).to eq(5)
    end
  end

  describe "GET /api/v1/projects/:project_id/tasks/:id" do
    let(:task) { create(:task, project: project) }

    before do
      get "/api/v1/projects/#{project.id}/tasks/#{task.id}", headers: @headers, as: :json
    end

    it "returns a successful response" do
      expect(response).to have_http_status(200)
    end

    it "returns the requested task" do
      expect(json_response['id']).to eq(task.id)
    end
  end

  describe "POST /api/v1/projects/:project_id/tasks" do
    let(:valid_attributes) { { task: { name: 'New Task', description: 'Description', status: 'new' } } }

    context "with valid parameters" do
      before do
        post "/api/v1/projects/#{project.id}/tasks", params: valid_attributes, headers: @headers, as: :json
      end

      it "creates a new task" do
        expect(response).to have_http_status(201)
      end

      it "returns the newly created task" do
        expect(json_response['name']).to eq('New Task')
      end
    end

    context "with invalid parameters" do
      before do
        post "/api/v1/projects/#{project.id}/tasks", params: { task: { name: '' } }, headers: @headers, as: :json
      end

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation error message" do
        expect(json_response.values.flatten).to include("can't be blank")
      end
    end
  end

  describe "PUT /api/v1/projects/:project_id/tasks/:id" do
    let(:task) { create(:task, project: project) }
    let(:updated_attributes) { { task: { name: 'Updated Task' } } }

    before do
      put "/api/v1/projects/#{project.id}/tasks/#{task.id}", params: updated_attributes, headers: @headers, as: :json
    end

    it "returns a successful response" do
      expect(response).to have_http_status(200)
    end

    it "updates the task" do
      expect(task.reload.name).to eq('Updated Task')
    end
  end

  describe "DELETE /api/v1/projects/:project_id/tasks/:id" do
    let!(:task) { create(:task, project: project) }

    before do
      delete "/api/v1/projects/#{project.id}/tasks/#{task.id}", headers: @headers, as: :json
    end

    it "returns a successful response" do
      expect(response).to have_http_status(204)
    end

    it "deletes the task" do
      expect(Task.exists?(task.id)).to be_falsy
    end
  end
end
