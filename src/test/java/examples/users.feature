Feature: Sample API Test

  Scenario: Get user details
    Given url 'https://reqres.in/api/users/2'
    When method GET
    Then status 200
    And match response.data.id == 2
    And match response.data.email == '#string'
    And match response.data.first_name == '#present'