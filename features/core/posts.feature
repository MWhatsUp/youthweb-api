Feature: Interact with a post
	In order to request a post or his relationships
	As a user

Scenario: Requesting a post
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	When I request "GET /posts/d5a5a2c3-041b-4985-907c-74a2131efc98"
	Then I get a "200" response
	And the "included" property exists
	And the "included" property is an array
	And the "data" property exists
	And the "data" property is an object
	And scope into the "data" property
	And the response contains 5 items
	And the "type" property exists
	And the "type" property is a string equalling "posts"
	And the "id" property exists
	And the "links" property exists
	And the "attributes" property exists
	And scope into the "data.attributes" property
	And the response contains 7 items
	And the properties exist:
		"""
		title
		content
		view_allowed_for
		comments_allowed
		comments_count
		created_at
		updated_at
		"""
	And scope into the "data.links" property
	And the response contains 1 items
	And the properties exist:
		"""
		self
		"""
	And scope into the "data.relationships" property
	And the response contains 3 items
	And the properties exist:
		"""
		author
		comments
		parent
		"""

Scenario: Requesting a post without permission
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	When I request "GET /posts/f5a5a2c3-041b-4985-907c-74a2131efc98"
	Then I get a "403" response
	And the Content-Type Header "application/vnd.api+json" exists
	And the Accept Header "application/vnd.api+json; net.youthweb.api.version=0.13" exists
	And the "errors" property exists
	And the "errors" property is an array
	And scope into the first "errors" property
	And the "status" property exists
	And the "status" property is a string equalling "403"
	And the "title" property exists
	And the "title" property is a string equalling "Forbidden"

Scenario: Requesting a not existing post
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	When I request "GET /posts/45a5a2c3-041b-4985-907c-74a2131efc98"
	Then I get a "404" response
	And the Content-Type Header "application/vnd.api+json" exists
	And the Accept Header "application/vnd.api+json; net.youthweb.api.version=0.13" exists
	And the "errors" property exists
	And the "errors" property is an array
	And scope into the first "errors" property
	And the "status" property exists
	And the "status" property is a string equalling "404"
	And the "title" property exists
	And the "title" property is a string equalling "Resource not found"

Scenario: Requesting the author of a post
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	When I request "GET /posts/d5a5a2c3-041b-4985-907c-74a2131efc98/author"
	Then I get a "200" response
	And the "data" property exists
	And the "data" property is an object
	And scope into the "data" property
	And the response contains 5 items
	And the "type" property exists
	And the "type" property is a string equalling "users"
	And the "id" property exists
	And the "id" property is a string
	And the "attributes" property exists
	And the "attributes" property is an object
	And the "links" property exists
	And the "links" property is an object
	And the "relationships" property exists
	And the "relationships" property is an object
	And scope into the "data.links" property
	And the response contains 1 items
	And the properties exist:
		"""
		self
		"""
	And scope into the "data.relationships" property
	And the response contains 1 items
	And the properties exist:
		"""
		posts
		"""

Scenario: Requesting the author relationship of a post
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	When I request "GET /posts/d5a5a2c3-041b-4985-907c-74a2131efc98/relationships/author"
	Then I get a "200" response
	And the "data" property exists
	And the "data" property is an object
	And the "links" property exists
	And the "links" property is an object
	And scope into the "data" property
	And the response contains 2 items
	And the "type" property exists
	And the "type" property is a string equalling "users"
	And the "id" property exists
	And the "id" property is a string
	And scope into the "links" property
	And the response contains 2 items
	And the properties exist:
		"""
		self
		related
		"""

Scenario: Requesting the parent of a post
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	When I request "GET /posts/d5a5a2c3-041b-4985-907c-74a2131efc98/parent"
	Then I get a "200" response
	And the "data" property exists
	And the "data" property is an object
	And scope into the "data" property
	And the response contains 5 items
	And the "type" property exists
	And the "type" property is a string equalling "users"
	And the "id" property exists
	And the "id" property is a string
	And the "attributes" property exists
	And the "attributes" property is an object
	And the "links" property exists
	And the "links" property is an object
	And the "relationships" property exists
	And the "relationships" property is an object
	And scope into the "data.links" property
	And the response contains 1 items
	And the properties exist:
		"""
		self
		"""
	And scope into the "data.relationships" property
	And the response contains 1 items
	And the properties exist:
		"""
		posts
		"""

Scenario: Requesting the parent relationship of a post
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	When I request "GET /posts/d5a5a2c3-041b-4985-907c-74a2131efc98/relationships/parent"
	Then I get a "200" response
	And the "data" property exists
	And the "data" property is an object
	And scope into the "data" property
	And the response contains 2 items
	And the "type" property exists
	And the "type" property is a string equalling "users"
	And the "id" property exists
	And the "id" property is a string
	And scope into the "links" property
	And the response contains 2 items
	And the properties exist:
		"""
		self
		related
		"""

Scenario: Requesting a post without permission
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	When I request "GET /posts/f5a5a2c3-041b-4985-907c-74a2131efc98"
	Then I get a "403" response
	And the Content-Type Header "application/vnd.api+json" exists
	And the Accept Header "application/vnd.api+json; net.youthweb.api.version=0.13" exists
	And the "errors" property exists
	And the "errors" property is an array
	And scope into the first "errors" property
	And the "status" property exists
	And the "status" property is a string equalling "403"
	And the "title" property exists
	And the "title" property is a string equalling "Forbidden"

Scenario: Requesting a not existing post
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	When I request "GET /posts/45a5a2c3-041b-4985-907c-74a2131efc98"
	Then I get a "404" response
	And the Content-Type Header "application/vnd.api+json" exists
	And the Accept Header "application/vnd.api+json; net.youthweb.api.version=0.13" exists
	And the "errors" property exists
	And the "errors" property is an array
	And scope into the first "errors" property
	And the "status" property exists
	And the "status" property is a string equalling "404"
	And the "title" property exists
	And the "title" property is a string equalling "Resource not found"

Scenario: Create a post on an not existing user
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	And I have the payload
		"""
		{"data":{"type":"posts","attributes":{"title":"The post title","content":"Lorem ipsum dolor sit amet, sed libris elaboraret eu.","view_allowed_for":"users","comments_allowed":true}}}
		"""
	When I request "POST /users/987654/posts"
	Then I get a "404" response
	And the Content-Type Header "application/vnd.api+json" exists
	And the Accept Header "application/vnd.api+json; net.youthweb.api.version=0.13" exists
	And the "errors" property exists
	And the "errors" property is an array
	And scope into the first "errors" property
	And the "status" property exists
	And the "status" property is a string equalling "404"
	And the "title" property exists
	And the "title" property is a string equalling "Resource not found"

Scenario: Create a post without permission
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	And I have the payload
		"""
		{"data":{"type":"posts","attributes":{"title":"The post title","content":"Lorem ipsum dolor sit amet, sed libris elaboraret eu.","view_allowed_for":"users","comments_allowed":true}}}
		"""
	When I request "POST /users/487654/posts"
	Then I get a "403" response
	And the Content-Type Header "application/vnd.api+json" exists
	And the Accept Header "application/vnd.api+json; net.youthweb.api.version=0.13" exists
	And the "errors" property exists
	And the "errors" property is an array
	And scope into the first "errors" property
	And the "status" property exists
	And the "status" property is a string equalling "403"
	And the "title" property exists
	And the "title" property is a string equalling "Forbidden"

Scenario: Create a post with empty content
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	And I have the payload
		"""
		{"data":{"type":"posts","attributes":{"title":"The post title","content":"","view_allowed_for":"users","comments_allowed":true}}}
		"""
	When I request "POST /users/287654/posts"
	Then I get a "400" response
	And the Content-Type Header "application/vnd.api+json" exists
	And the Accept Header "application/vnd.api+json; net.youthweb.api.version=0.13" exists
	And the "errors" property exists
	And the "errors" property is an array
	And scope into the first "errors" property
	And the "status" property exists
	And the "status" property is a string equalling "422"
	And the "title" property exists
	And the "title" property is a string equalling "Unprocessable Entity"
	And the "detail" property exists
	And the "detail" property is a string equalling "The field `attributes.content` can't be empty."

Scenario: Create a post with missing content
	Given I have set the "Content-Type" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json"
	And I have set the "Accept" header with "application/vnd.api+json; net.youthweb.api.version=0.13"
	And I have set the "Authorization" header with "Bearer valid_JWT"
	And I have the payload
		"""
		{"data":{"type":"posts","attributes":{"title":"The post title","view_allowed_for":"users","comments_allowed":true}}}
		"""
	When I request "POST /users/287654/posts"
	Then I get a "400" response
	And the Content-Type Header "application/vnd.api+json" exists
	And the Accept Header "application/vnd.api+json; net.youthweb.api.version=0.13" exists
	And the "errors" property exists
	And the "errors" property is an array
	And scope into the first "errors" property
	And the "status" property exists
	And the "status" property is a string equalling "422"
	And the "title" property exists
	And the "title" property is a string equalling "Unprocessable Entity"
	And the "detail" property exists
	And the "detail" property is a string equalling "The field `attributes.content` must be set."
