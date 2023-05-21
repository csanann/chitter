## Chitter Project: from user stories to Routes planning

#### User Stories:

User registration: As a user, So that I can use Chitter, I want to be able to sign up for an account.
User login: As a user, So that I can access my Chitter account, I want to be able to log in.
Posting peeps: As a user, So that I can share my thoughts with others, I want to be able to post peeps.
Viewing public stream: As a user, So that I can see what others are posting, I want to be able to view the public stream of peeps in reverse chronological order.

#### Planning pages:

Registration page: User can sign up for an account
Login page: User can log in to their account
Peep posting page: User can post peeps
Public steam page: User can view all peeps in reverse chronological order

#### Planning routes Page:

- Page: Registration
Request: GET /signup
Response (200 OK): HTML view with registration form (to POST /signup)

- Page: User Registered
Request: POST /signup With parameters: username="user" email="user@email.com" password="password"
Response (Redirect): Redirect to the login page with flash confirmation message

- Page: Login
Request: GET /login
Response (200 OK): HTML view with login form (to POST /login)

- Page: User Logged In
Request: POST /login With parameters: email="user@email.com" password="password"
Response (Redirect): Redirect to the peep posting page with flash confirmation message

- Page: Peep Posting
Request: GET /peeps/new
Response (200 OK): HTML view with form to submit a new peep (to POST /peeps)

- Page: Peep Posted
Request: POST /peeps With parameters: content="My first peep!"
Response (Redirect): Redirect to the public stream page with flash confirmation message

- Page: Public Stream
Request: GET /peeps
Response (200 OK): HTML view with a list of all peeps in reverse chronological order

#### Test-Drive and Implement
We will test-drive and implement each route using the RSpec testing framework. As our application interacts with a database, we will have to test-drive and implement other layers of the program i.e., models and controllers.
