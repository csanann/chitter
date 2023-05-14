# 2. Method and Path Route Design Recipe

1. Design the route signature
- HTTP method: POST
- Path: /peeps
- Body parameters: content

2. Design the response
Response when the peep is successfully posted: 302 found (Redirect)

Redirect to the public stream page: '/peeps'

Response when the user is not logged in= 405 Forbidden
<html>
<head></head>
<body>
<h1>Unauthorized</h1>
<div>You must be logged in to post a peep.</div>
/body>
</html>

3. Write Examples
- Request:
POST /peeps
Content: "This is my first peep!"

- Expected response:
Response for 302 Found (Redirect to /peeps)

- Request:
POST /peeps
Content=This is my first peep!

- Expected response:
Response for 403 Forbidden (User not logged in)

4. Encode as Tests Examples
- file: spec/integration/application_spec.rb

context POST /peeps do
it returns 302 Found and redirects when peep is posted successfully
- Assuming the user is logged in and the session is set.
response = post '/peeps', content=This is my first peep!

response.status=>302
response.location=>'/peeps'
end

it returns 403 Forbidden when user is not logged in 
- Assuming the user is not logged in and the session is not set.
response = post '/peeps', content=this is my first peep!

response.status=>403
response.body=>expected_response

5. Implement the route
- application.rb or controller file
post '/peeps' do
if session[:user_id] = Assuming a user is logged in if session[:user_id] is set
content = params[:content]
user_id = session[:user_id]

- Save the new peep to the database (you may use an ORM like ActiveRecord)
Peep.create(content: content, user_id: user_id, timestamp: Time.now)

- Redirect to the public stream page
redirect '/peeps'
else
- Return 403 Forbidden if the user is not logged in
[403, "You must be logged in to post a peep."]
end
end
