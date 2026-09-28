#  ClickUp Project & Task Management System

ClickUp is a task management web application. It allows users to create and manage projects, organize tasks, assign tasks to users, upload project files, and manage access based on user roles and task assignments.

The application also includes a **Free/Premium subscription system using Stripe**, authentication, authorization with Pundit, rate limiting with Rack Attack, and responsive UI using Bootstrap.

## Features

### Authentication

* User registration
* User login and logout
* Password hashing using has_secure_password
* Session-based authentication
* Current user/session management
* Automatic session expiration
* Login rate limiting using rack

### Project Model

* Create projects
* View projects
* Edit projects
* Delete projects
* Search projects by name
* Project visibility based on user permissions
* Free plan project limit
* Unlimited projects for Premium users

### Task Model

* Create tasks for the projects
* Edit the project tasks
* Delete the project tasks
* Assign tasks to users
* Set task priorities:
* Set task statuses:

### Authorization

 Implemented using **Pundit**.

Project owners have full control over their projects and tasks.

Assigned users can access projects where they have assigned tasks and can update the selected task fields.


### Stripe Integration

The application integrates Stripe for subscription management.

In this app user can create only 5 free projects on trial otherwise user will buy the subscription through the stripe

### File Uploads

Projects support file attachments using Active Storage.

In which user and admin both allow to upload the specific files for that project

### Security & Rate Limiting

Rack Attack is used to protect the login endpoint from excessive requests.

In which 4 login attempts give to user for the login with the correct credentials

### Dashboard

The dashboard provides project/task statistics such as:

* Total tasks
* Completed tasks
* Pending tasks
* In-progress tasks


# Webhooks

The application uses Stripe webhooks to receive events from Stripe.


Stripe sends an HTTP request to the Rails webhook endpoint.The application verifies the webhook and processes the event. Development webhook forwarding can be tested using Stripe CLI.


# Active Storage

Active Storage is used for project file uploads. Projects can have multiple files attached:
Files are uploaded through the project form.


# Project Search

The application supports searching projects by name.

The search is performed against the project name and can be used to quickly find projects.

The search functionality can be extended later to support:

* Task search
* User search
* Status filtering
* Priority filtering
* Multiple search conditions

# Testing

Testing can be implemented using the Rails testing ecosystem and tools such as:

* RSpec
* FactoryBot
* Faker



## Configure Environment Variables

Create a `.env` file for local development and save the sensitive data in it.

## 4. Configure PostgreSQL

Make sure PostgreSQL is installed and running.

Update the database configuration if necessary.

Then create and migrate the database:

## 5. Seed Database

Creating the temporary task projects and user by using the faker gem for the testing purpose.


# Security Considerations

The application follows several security practices:

* Passwords are hashed using BCrypt through `has_secure_password`
* Authentication is required for protected resources
* Pundit prevents unauthorized resource access
* Stripe secret keys are stored outside source code
* Stripe webhook signatures should be verified
* Rack Attack protects login against excessive requests
* Users should only access resources permitted by their policies
* Environment secrets should not be committed to Git

# Learning Objectives
It covers important Rails concepts including:

* MVC architecture
* Routing
* Controllers
* Models
* Active Record
* Database migrations
* Associations
* Validations
* ERB views
* Forms
* Authentication
* Authorization
* Pundit
* Active Storage
* Eager loading
* N+1 query prevention
* Rate limiting
* Stripe integration
* Webhooks
* Environment variables
* PostgreSQL
* Bootstrap
* RESTful routes