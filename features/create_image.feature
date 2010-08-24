Feature: Designer creates a new image

  As a talented designer
  I want to create a new image
  So that I can draw pretty pictures
  
  Scenario: creates a image
    Given I am not already drawing a great picture
    When I start a new session
    And I submit the command "I56"
    Then a new image should be created
    
