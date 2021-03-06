Feature: Interact with the comments of an object
    In order to request the comments of an object
    As a user

Scenario: Requesting the posts from a users pinnwall
    Given I am authorized as Alice
    When I request "GET /users/123456/posts"
    Then I get a "200" response
    And the correct headers are set
    And the "included" property exists
    And the "included" property is an array
    And the "data" property exists
    And the "data" property is an array
    And scope into the first "data" property
    And the response contains 5 items
    And the "type" property exists
    And the "type" property is a string equalling "posts"
    And the "id" property exists
    And the "attributes" property exists
    And the "attributes" property is an object
    And the "relationships" property exists
    And the "relationships" property is an object
    And the "links" property exists
    And the "links" property is an object

Scenario: Requesting the posts relationships from a users pinnwall
    Given I am authorized as Alice
    When I request "GET /users/123456/relationships/posts"
    Then I get a "200" response
    And the correct headers are set
    And the "data" property exists
    And the "data" property is an array
    And the "links" property exists
    And the "links" property is an object
    And scope into the first "data" property
    And the response contains 2 items
    And the "type" property exists
    And the "type" property is a string equalling "posts"
    And the "id" property exists

Scenario: Requesting the posts from a users pinnwall without posts
    Given I am authorized as Alice
    When I request "GET /users/123450/posts"
    Then I get a "200" response
    And the correct headers are set
    And the "data" property exists
    And the "data" property is an empty array

Scenario: Creating a post on an users pinnwall
    Given I am authorized as Alice
    And I have the payload
        """
        {"data":{"type":"posts","attributes":{"title":"The post title","content":"Lorem ipsum dolor sit amet, sed libris elaboraret eu.","view_allowed_for":"users","comments_allowed":true}}}
        """
    When I request "POST /users/123456/posts"
    Then I get a "201" response
    And the correct headers are set
    And the Location Header exists
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
    And scope into the "data.links" property
    And the response contains 1 items
    And the properties exist:
        """
        self
        """

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
