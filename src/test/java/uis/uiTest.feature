Feature: Validating UI using Karate

  Background: 
    * def uiUrl = uiUrl
    * def locators = read("classpath:locators.json")

  @chrome
  Scenario: Google Chrome
    Given driver uiUrl
    And driver.maximize()
    And input(locators.searchInput,'iphone 14 pro max')
    When click(locators.searchButton)
    * def out = text(locators.itemCount)
    Then print out

  @firefox
  Scenario: Firefox
    * configure driver = { type: 'geckodriver', executable:"#('C:/Users/mdnas/eclipse-workspace/karate.april.2022/drivers/geckodriver.exe')"}
    Given driver 'https://www.amazon.com/'

  @edge
  Scenario: EDGE
    * configure driver = {type:'msedge'}
    Given driver 'https://www.amazon.com/'

  @anotherFeature
  Scenario: call another feature with tag
    Then call read('classpath:uis/helper.feature')

  @scenarioWithTag
  Scenario: call another feature with tag
    Then call read('classpath:uis/helper.feature@tagged')

  @dynamicFeature
  Scenario: call another feature with tag and dynamic input
    Then call read('classpath:uis/helper.feature@dynamic'){input:"#('This is a dynamic input with tag scenario')"}
