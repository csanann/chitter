# Modelling and Planning web application for Chitter Project

0. User stories or specification
User registration:
As a user,
So that I can use Chitter,
I want to be able to sign up for an account.

User login:
As a user,
So that I can access my Chitter account,
I want to be able to log in.

Posting peeps:
As a user,
So that I can share my thoughts with others,
I want to be able to post peeps.

Viewing public stream:
As a user,
So that I can see what others are posting,
I want to be able to view the public stream of peeps in reverse chronological order.

1. Planning pages and a small diagram

Registration page: User can sign up for an account
Login page: User can log in to their account
Peep posting page: User can post peeps
Public steam page: User can view all peeps in reverse chronological order

--a sequence diagram
: one to many relationships: a user can have many peeps, a peep belongs to only one user
User -> Chitter: Register
User -> Chitter: Login
User -> Chitter: Post Peep
Chitter -> User: Display Peep
User -> Chitter: View Public Stream
Chitter -> User: Display All Peeps

2. Planning routes
Page: Registration

-Request:
GET /register

Response (200 OK):
HTML view with registration form (to POST /register)

Page: User Registered

-Request:
POST /register
With parameters:
  username="user"
  email="user@email.com"
  password="password"

-Response (200 OK or Redirect):
HTML view with confirmation message or redirect to the login page

Page: Login

-Request:
GET /login

-Response (200 OK):
HTML view with login form (to POST /login)

Page: User Logged In

-Request:
POST /login
With parameters:
  email="user@email.com"
  password="password"

-Response (200 OK or Redirect):
HTML view with confirmation message or redirect to the peep posting page

Page: Peep Posting

-Request:
GET /peeps/new

-Response (200 OK):
HTML view with form to submit a new peep (to POST /peeps)

Page: Peep Posted

-Request:
POST /peeps
With parameters:
  content="My first peep!"

-Response (200 OK or Redirect):
HTML view with confirmation message or redirect to the public stream page

Page: Public Stream

-Request:
GET /peeps

-Response (200 OK):
HTML view with a list of all peeps in reverse chronological order

3.Test-drive and implement
we will test-drive and implement each route using a test RSpec framework. As our application interacts with a database, we will have to test-drive and implement other layers of the program ie., models and controllers.
