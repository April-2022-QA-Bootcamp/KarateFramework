Feature: goRest Post User API validation

  Background: 
    * url baseUrl = 'https://jsonplaceholder.typicode.com'
    * path getUsersPath = '/posts'
    * def payload = read('classpath:user.json')
		# And header Authorization = 'Bearer xxx'
		
	@postUser	
  Scenario: Post a user
    Given header Accept = 'application/json'
    When request {"title": "foo","body": "bar","userId": 1}
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
    # Response body validation
    Then match response.userId == 1
    And match response.body contains 'b'
    
  @jsonFile
  Scenario: Post a user with json
    Given header Accept = 'application/json'
    When request payload
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
    # Response body validation
    Then match response.userId == payload.userId
    And match response.body contains payload.body.charAt(0)
    
  @setJsonRequest
  Scenario: Post a user with json
    Given header Accept = 'application/json'
    * set payload.userId = 15
    When request payload
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
    # Response body validation
    Then match response.userId == payload.userId
    And match response.body contains payload.body.charAt(0)
