Feature: Sample API Test

  Scenario: Get user details
    Given url 'https://reqres.in/api/users/2'
    When method GET
    Then status 200
    And match response.data.id == 2
    And match response.data.email == '#string'
    And match response.data.first_name == '#present'

  Scenario: Create a new user
    Given url 'https://reqres.in/api/users'
    And request { "name": "morpheus", "job": "leader" }
    When method POST
    Then status 201
    And match response.name == 'morpheus'
    And match response.job == 'leader'

  Scenario: Update user details
    Given url 'https://reqres.in/api/users/2'
    And request { "name": "morpheus", "job": "zion resident" }
    When method PUT
    Then status 200
    And match response.name == 'morpheus'
    And match response.job == 'zion resident'

  Scenario: Delete a user
    Given url 'https://reqres.in/api/users/2'
    When method DELETE
    Then status 204

  Scenario: List all users
    Given url 'https://reqres.in/api/users?page=2'
    When method GET
    Then status 200
    And match response.page == 2
    And match response.data[*].id == '#number'
    And match response.data[*].email == '#string'
    And match response.data[*].first_name == '#present'

  Scenario: Register a user
    Given url 'https://reqres.in/api/register'
    And request { "email": "eve.holt@reqres.in", "password": "pistol" }
    When method POST
    Then status 200
    And match response.id == '#number'
    And match response.token == '#string'

  Scenario: Get user details with invalid ID
    Given url 'https://reqres.in/api/users/9999'
    When method GET
    Then status 404

  Scenario: Create a new user with missing fields
    Given url 'https://reqres.in/api/users'
    And request { "name": "morpheus" }
    When method POST
    Then status 400

  Scenario: Update user details with invalid data
    Given url 'https://reqres.in/api/users/2'
    And request { "name": 123, "job": true }
    When method PUT
    Then status 400

  Scenario: Delete a non-existent user
    Given url 'https://reqres.in/api/users/9999'
    When method DELETE
    Then status 404

  Scenario: Register a user with missing password
    Given url 'https://reqres.in/api/register'
    And request { "email": "eve.holt@reqres.in" }
    When method POST
    Then status 400

  Scenario: List users with invalid page number
    Given url 'https://reqres.in/api/users?page=9999'
    When method GET
    Then status 200
    And match response.data == []

  Scenario: Access protected resource without authentication
    Given url 'https://reqres.in/api/protected'
    When method GET
    Then status 401

  Scenario: Rate limiting test
    Given url 'https://reqres.in/api/users'
    When method GET
    Then status 429