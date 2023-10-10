*** Settings ***

#Documentation on what these test cases are about
#Libraries to import. eg selenium library
Library  SeleniumLibrary
Variables  ../../Secrets/config.yaml

*** Variables ***


*** Test Cases ***

Liberty Flow
    [documentation]  Download files from Liberty and put into Google Drive
    [tags]   Liberty Automation

    Launch Browser

    Login To Liberty

    Navigate Liberty To Renewals


*** Keywords ***

Launch Browser
    Open Browser  ${liberty-url}  ${liberty-preferred-browser}


Login To Liberty
    Input Text  //*[@id="j_username"]  ${liberty_username}  True
    Input Password  //*[@id="j_password"]  ${liberty_password}  True

    Click Button  //*[@id="j_login"]

    Verify Single Session


Verify Single Session
    ${accept_button_check} =  Run Keyword And Return Status  Page Should Contain Element  //*[@id="j_id97:j_id99"]
    ${error_message_check} =  Run Keyword And Return Status  Page Should Contain Element  //*[@id="forceLogoutLink"]

#    Log to console  YYYYY1 Verify Single Session ${accept_button_check}
#    Log to console  YYYYY2 Verify Single Session ${error_message_check}

    ${accept_button_exists} =  Evaluate  ${accept_button_check} == True
    ${error_message_exists} =  Evaluate  ${error_message_check} == True

#    Log to console  XXXXX1 Verify Single Session ${accept_button_exists}
#    Log to console  XXXXX2 Verify Single Session ${error_message_exists}

    Run Keyword If  ${accept_button_exists}  Accept Terms and Conditions
    Run Keyword If  ${error_message_exists}  Handle Simultaneous Login Error


Accept Terms and Conditions
#    Log to console  XXXXX1 Accept Terms and Conditions
    Click Element  //*[@id="j_id97:j_id99"]


Handle Simultaneous Login Error
#    Log to console  XXXXX1 Handle Simultaneous Login Error
    Click Element  //*[@id="forceLogoutLink"]

    Click Element  //*[@id="logoutOkButton"]

    Login To Liberty

Navigate Liberty To Renewals
#    Sleep  5s

    Click Element  //*[@id="j_id5:RENEWAL_DOWNLOAD"]

    Click Element  //*[@id="j_id5:MY_RENEWAL_NOTICE"]

#    Sleep  10s


