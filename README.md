
# This project is an API for managing projects and tasks.

## Table of Contents

- [Features](#features)
- [Technologies](#technologies)
- [Installation](#installation)
- [API Endpoints](#api-endpoints)
- [Testing](#testing)

## Features

- User authentication (sign up, sign in, sign out)
- CRUD operations for projects
- CRUD operations for tasks associated with projects
- Filtering tasks by status

## Technologies

- Ruby 3.2.3
- Ruby on Rails 7.1.3
- PostgreSQL 1.1
- RSpec 6.1.0
- Swagger for API documentation
- Devise

## Installation

1. Clone the repository:

   `git clone https://github.com/DadaLV/projects_app.git`

2. Install:

   `bundle install`
   `rails db:create`
   `rails db:migrate`

3. (Optional) Seed the database with sample data:

   `rails db:seed`

4. Start the Rails server:

   `rails server`

5. Access the API endpoints with Swagger documentation 

   `http://localhost:3000/api-docs/index.html`

or using a tool like Postman or curl.

## API Endpoints

The API provides the following endpoints:

* Sign up: POST /api/v1/sign_up
* Sign in: POST /api/v1/sign_in
* Sign out: DELETE /api/v1/sign_out
* Retrieve all projects: GET /api/v1/projects
* Create a new project: POST /api/v1/projects
* Retrieve a project by ID: GET /api/v1/projects/:id
* Update a project by ID: PUT /api/v1/projects/:id
* Delete a project by ID: DELETE /api/v1/projects/:id
* Retrieve all tasks associated with a project: GET /api/v1/projects/:project_id/tasks
* Create a new task associated with a project: POST /api/v1/projects/:project_id/tasks
* Retrieve a task by ID associated with a project: GET /api/v1/projects/:project_id/tasks/:id
* Update a task by ID associated with a project: PUT /api/v1/projects/:project_id/tasks/:id
* Delete a task by ID associated with a project: DELETE /api/v1/projects/:project_id/tasks/:id

For more detailed information, refer to the Swagger documentation provided in the project.

## Testing

Run the RSpec tests:

  `rspec`
