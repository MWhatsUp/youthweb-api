Feature: Interact with a post
    In order to request a post or his relationships
    As a user

Background:
    Given an user named "Alice"
    And "Alice" owns a post with id "d5a5a2c3-041b-4985-907c-74a2131efc98"
    And an user named "Bob"
    And "Bob" owns a post with id "f5a5a2c3-041b-4985-907c-74a2131efc98"
    And the post can be viewed by "authors"

Scenario: Alice requests her own post
    Given I am authorized as Alice
    When I request "GET /posts/d5a5a2c3-041b-4985-907c-74a2131efc98"
    Then I get a "200" response
    And the correct headers are set
    And the "included" property exists
    And the "included" property is an array
    And the "data" property exists
    And the "data" property is an object
    And scope into the "data" property
    And the response contains at least 5 items
    And the "type" property exists
    And the "type" property is a string equalling "posts"
    And the "id" property exists
    And the "id" property is a string
    And the "links" property exists
    And the "attributes" property exists
    And scope into the "data.attributes" property
    And the response contains at least 10 items
    And the properties exist:
        """
        title
        content
        content_html
        view_allowed_for
        comments_allowed
        comments_count
        reactions_given
        reactions_count
        created_at
        updated_at
        """
    And the "title" property is a string
    And the "content" property is a string
    And the "reactions_given" property is an array
    And the "reactions_count" property is an object
    And scope into the "data.links" property
    And the response contains 1 items
    And the properties exist:
        """
        self
        """
    And scope into the "data.relationships" property
    And the response contains at least 3 items
    And the properties exist:
        """
        author
        comments
        parent
        """

Scenario: Requesting a post without permission
    Given I am authorized as Alice
    When I request "GET /posts/f5a5a2c3-041b-4985-907c-74a2131efc98"
    Then I get a "403" response
    And the correct headers are set
    And the "errors" property exists
    And the "errors" property is an array
    And scope into the first "errors" property
    And the "status" property exists
    And the "status" property is a string equalling "403"
    And the "title" property exists
    And the "title" property is a string equalling "Forbidden"

Scenario: Requesting a not existing post
    Given I am authorized as Alice
    When I request "GET /posts/45a5a2c3-041b-4985-907c-74a2131efc98"
    Then I get a "404" response
    And the correct headers are set
    And the "errors" property exists
    And the "errors" property is an array
    And scope into the first "errors" property
    And the "status" property exists
    And the "status" property is a string equalling "404"
    And the "title" property exists
    And the "title" property is a string equalling "Resource not found"

Scenario: Requesting the author of a post
    Given I am authorized as Alice
    When I request "GET /posts/d5a5a2c3-041b-4985-907c-74a2131efc98/author"
    Then I get a "200" response
    And the correct headers are set
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
    Given I am authorized as Alice
    When I request "GET /posts/d5a5a2c3-041b-4985-907c-74a2131efc98/relationships/author"
    Then I get a "200" response
    And the correct headers are set
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
    Given I am authorized as Alice
    When I request "GET /posts/d5a5a2c3-041b-4985-907c-74a2131efc98/parent"
    Then I get a "200" response
    And the correct headers are set
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
    Given I am authorized as Alice
    When I request "GET /posts/d5a5a2c3-041b-4985-907c-74a2131efc98/relationships/parent"
    Then I get a "200" response
    And the correct headers are set
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
    Given I am authorized as Alice
    When I request "GET /posts/f5a5a2c3-041b-4985-907c-74a2131efc98"
    Then I get a "403" response
    And the correct headers are set
    And the "errors" property exists
    And the "errors" property is an array
    And scope into the first "errors" property
    And the "status" property exists
    And the "status" property is a string equalling "403"
    And the "title" property exists
    And the "title" property is a string equalling "Forbidden"

Scenario: Requesting a not existing post
    Given I am authorized as Alice
    When I request "GET /posts/45a5a2c3-041b-4985-907c-74a2131efc98"
    Then I get a "404" response
    And the correct headers are set
    And the "errors" property exists
    And the "errors" property is an array
    And scope into the first "errors" property
    And the "status" property exists
    And the "status" property is a string equalling "404"
    And the "title" property exists
    And the "title" property is a string equalling "Resource not found"

Scenario: Create a post on an not existing user
    Given I am authorized as Alice
    And I have the payload
        """
        {"data":{"type":"posts","attributes":{"title":"The post title","content":"Lorem ipsum dolor sit amet, sed libris elaboraret eu.","view_allowed_for":"users","comments_allowed":true}}}
        """
    When I request "POST /users/987654/posts"
    Then I get a "404" response
    And the correct headers are set
    And the "errors" property exists
    And the "errors" property is an array
    And scope into the first "errors" property
    And the "status" property exists
    And the "status" property is a string equalling "404"
    And the "title" property exists
    And the "title" property is a string equalling "Resource not found"

Scenario: Create a post without permission
    Given I am authorized as Alice
    And I have the payload
        """
        {"data":{"type":"posts","attributes":{"title":"The post title","content":"Lorem ipsum dolor sit amet, sed libris elaboraret eu.","view_allowed_for":"users","comments_allowed":true}}}
        """
    When I request "POST /users/487654/posts"
    Then I get a "403" response
    And the correct headers are set
    And the "errors" property exists
    And the "errors" property is an array
    And scope into the first "errors" property
    And the "status" property exists
    And the "status" property is a string equalling "403"
    And the "title" property exists
    And the "title" property is a string equalling "Forbidden"

Scenario: Create a post with empty content
    Given I am authorized as Alice
    And I have the payload
        """
        {"data":{"type":"posts","attributes":{"title":"The post title","content":"","view_allowed_for":"users","comments_allowed":true}}}
        """
    When I request "POST /users/287654/posts"
    Then I get a "400" response
    And the correct headers are set
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
    Given I am authorized as Alice
    And I have the payload
        """
        {"data":{"type":"posts","attributes":{"title":"The post title","view_allowed_for":"users","comments_allowed":true}}}
        """
    When I request "POST /users/287654/posts"
    Then I get a "400" response
    And the correct headers are set
    And the "errors" property exists
    And the "errors" property is an array
    And scope into the first "errors" property
    And the "status" property exists
    And the "status" property is a string equalling "422"
    And the "title" property exists
    And the "title" property is a string equalling "Unprocessable Entity"
    And the "detail" property exists
    And the "detail" property is a string equalling "The field `attributes.content` must be set."

Scenario: Sending a request with invalid JSON API
    Given I am authorized as Alice
    And I have the payload
        """
        {"data":{"type":"posts","attributes":{"content":"Lorem ipsum dolor sit amet, sed libris elaboraret eu."}},"errors":[{"detail":"The members data and errors MUST NOT coexist in the same document."}]}
        """
    When I request "POST /users/287655/posts"
    Then I get a "400" response
    And the correct headers are set
    And the "errors" property exists
    And the "errors" property is an array
    And scope into the first "errors" property
    And the "status" property exists
    And the "status" property is a string equalling "400"
    And the "title" property exists
    And the "title" property is a string equalling "Bad Request"
    And the "detail" property exists
    And the "detail" property is a string equalling "Your request format must be valid JSON API. The properties `data` and `errors` MUST NOT coexist in Document."
