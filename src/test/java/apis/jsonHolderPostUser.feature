Feature: goRest Post User API validation

  Background: 
    * url baseUrl = jsonHolderBaseUri
    * path getUsersPath = getUsersPathJsonHolder
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

  @dataDriven @smoke @regression
  Scenario Outline: Test for - <title>
    Given header Accept = 'application/json'
    * set payload.title = <title>
    * set payload.body = <body>
    * set payload.userId = <userId>
    When request payload
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
    # Response body validation
    Then match response.userId == payload.userId
    And match response.body contains payload.body.charAt(0)

    Examples: 
      | title                 | body                     | userId |
      | 'Lord Of the Rings-1' | 'Fellowship of the Ring' |    101 |
      | 'Lord Of the Rings-2' | 'Two Towers'             |    202 |
      | 'Lord Of the Rings-3' | 'Returns of the King'    |    303 |
