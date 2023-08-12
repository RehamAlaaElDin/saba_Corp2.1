<?xml version="1.0" encoding="UTF-8"?><DeploymentDescriptor AllowDataSets="N" Connect="version 6.1.1__1" Name="Kobil-WS" ProjectFileName="Kobil-WS.ifp" eid="51236B7705FDAA9264621">
  <WebServices Name="Web Services Root" eid="51236B7705FDAA9267837"/>
  <Portlets Name="Portlets Root" eid="51236B7705FDAA9267840"/>
  <Parameters Name="Variables Root" eid="51236B7705FDAA9267839">
    <RunTimeParameters Name="Runtime Variables" eid="51236B7705FDAA9267853">
      <RunTimeParameter Mode="Live" Name="Mode" eid="51236B7705FDAA9267854"/>
      <RunTimeParameter Name="Session Timeout" eid="51236B7705FDAA9267855"/>
      <RunTimeParameter Name="Debug Level" eid="51236B7705FDAA9267856"/>
      <RunTimeParameter Name="Cryptokey File" eid="51236B7705FDAA9267857"/>
      <RunTimeParameter Name="Security" Security="Y" eid="51236B7705FDAA9267858"/>
      <RunTimeParameter Name="SubSession" SubSession="N" eid="51236B7705FDAA9267859"/>
      <RunTimeParameter Name="Compress HTML Responses" eid="51236B7705FDAA9267860"/>
    </RunTimeParameters>
    <GlobalParameters Name="Global Variables" eid="51236B7705FDAA9267861">
      <GlobalParameter GlobalParameterValue="https://master.dev2-api-multi.aws.kobil.com:8446" Name="KOBIL_MIDDLEWARE_URL" eid="51236B7705FDAA9276231"/>
      <GlobalParameter GlobalParameterValue="true" Name="LOGIN_WITH_PAM_PASSWORD" eid="51236B7705FDAA929957"/>
      <GlobalParameter GlobalParameterValue="CLOUD" Name="MAJOR" eid="5123B7705FDAA93645"/>
      <GlobalParameter GlobalParameterValue="safbdjjdxxx" Name="TENANT_ID" eid="51236B7705FDAA92857"/>
      <GlobalParameter GlobalParameterValue="Y2xvdWRjb25uZWN0b3I6Y2xvdWRjb25uZWN0b3I=" Name="MGMT_AUTHORIZATION" eid="51236B7705FDAA9276456"/>
      <GlobalParameter GlobalParameterValue="Y2xvdWRjb25uZWN0b3I6Y2xvdWRjb25uZWN0b3I=" Name="POR_AUTHORIZATION" eid="51236B7705FDAA9276457"/>
      <GlobalParameter GlobalParameterValue="Mgmt_Authorization" Name="MGMT_AUTHORIZATION_NAME" eid="51236B7705FDAA9276456"/>
      <GlobalParameter GlobalParameterValue="Por_Authorization" Name="POR_AUTHORIZATION_NAME" eid="51236B7705FDAA9276457"/>
       <GlobalParameter GlobalParameterValue="TEMPLATE" Name="TRANSACTION_TEMPLATE_FORMAT" eid="5123B7705FDAA93645"/>
      <GlobalParameter GlobalParameterValue="Saba_Kobil" Name="APP_NAME_TO_TRIGGER_2FA" eid="5123B7705FDAA93695"/>
      <GlobalParameter GlobalParameterValue="IS_TEMP_USER" Name="USER_PROPERTY_KEY" eid="51236B7705FDAA9236457"/>
      <GlobalParameter GlobalParameterValue="dHJ1ZQ==" Name="TEMP_PASSWORD" eid="5123B7705FDAA93645"/>
      <GlobalParameter GlobalParameterValue="ZmFsc2U=" Name="PERMANENT_PASSWORD" eid="5123B7705FDA9236457"/>
      <GlobalParameter GlobalParameterValue="1234567890" Name="BANK_HELPDESK_NO" eid="51236B7705FDAA929976457"/>
      <GlobalParameter GlobalParameterValue="https://callback.free.beeceptor.com/my/api/path1" Name="SEND_OTP_CALLBACK_URL" eid="51236B7705FDAA9236488557"/>
      <GlobalParameter GlobalParameterValue="https://callback.free.beeceptor.com/my/api/path1" Name="ACTIVATION_CODE_CALLBACK_URL" eid="51236B7705FDAA9236488557"/>
      <GlobalParameter GlobalParameterValue="https://temenostesting.free.beeceptor.com/my/api/path?key=" Name="TRANSACTION_CALLBACK_URL" eid="51236B7705FDAA92857"/>
      <GlobalParameter GlobalParameterValue="5" Name="CALLBACK_SLEEP_TIME" eid="51236B7705FDAA92857"/>
      <GlobalParameter GlobalParameterValue="15" Name="CALLBACK_RETRY_COUNT" eid="51236B7705FDAA92857"/>
    </GlobalParameters>
  </Parameters>
  <DirectoryStructure Name="Directory Structure Root" eid="51236B7705FDAA9267836">
    <Directory DefaultDir="Y" Directory="./templates" Name="Templates dir" eid="51236B7705FDAA9267845"/>
    <Directory DefaultDir="Y" Directory="./html" Name="HTML dir" eid="51236B7705FDAA9267846"/>
    <Directory DefaultDir="Y" Directory="./html/js" Name="JavaScript dir" eid="51236B7705FDAA9267847"/>
    <Directory DefaultDir="Y" Directory="./html/css" Name="Stylesheet dir" eid="51236B7705FDAA9267848"/>
    <Directory DefaultDir="Y" Directory="./html/templates" Name="HTML Templates dir" eid="51236B7705FDAA9267849"/>
    <Directory DefaultDir="Y" Directory="./images" Name="Images dir" eid="51236B7705FDAA9267850"/>
    <Directory DefaultDir="Y" Directory="./dictionary" Name="Dictionary dir" eid="51236B7705FDAA9267851"/>
    <Directory DefaultDir="Y" Directory="./DataSets" Name="Data Sets dir" eid="51236B7705FDAA9267852"/>
  </DirectoryStructure>
  <ComponentRoot Name="ComponentRoot" eid="51236B7705FDAA9267841"/>
  <Profiles Name="Profiles Root" eid="51236B7705FDAA9267842">
    <IOSProfiles Name="iOS Profiles" eid="51236B7705FDAA9267862"/>
    <AndroidProfiles Name="Android Profiles" eid="51236B7705FDAA9267863"/>
    <WindowsUniversalProfiles Name="Windows Profiles" eid="51236B7705FDAA9267865"/>
  </Profiles>
  <Messages Name="Messages Root" eid="51236B7705FDAA9267843">
    <Message MESSAGE_NAME="ok" Name="ok" VALUE="OK" eid="51236B7705FDAA9267866"/>
    <Message MESSAGE_NAME="not_now" Name="not_now" VALUE="Not Now" eid="51236B7705FDAA9267867"/>
    <Message MESSAGE_NAME="user_settings" Name="user_settings" VALUE="Settings" eid="51236B7705FDAA9267868"/>
    <Message MESSAGE_NAME="check_updates" Name="check_updates" VALUE="Check for updates" eid="51236B7705FDAA9267869"/>
    <Message MESSAGE_NAME="developer_settings" Name="developer_settings" VALUE="Developer settings" eid="51236B7705FDAA9267870"/>
    <Message MESSAGE_NAME="title_activity_app_pereferences" Name="title_activity_app_pereferences" VALUE="Settings" eid="51236B7705FDAA9267871"/>
    <Message MESSAGE_NAME="internet_connection_needed_title" Name="internet_connection_needed_title" VALUE="No Connectivity" eid="51236B7705FDAA9267872"/>
    <Message MESSAGE_NAME="internet_connection_needed" Name="internet_connection_needed" VALUE="Please verify you have cellular network or WiFi connection" eid="51236B7705FDAA9267873"/>
    <Message MESSAGE_NAME="error_accessing_server_title" Name="error_accessing_server_title" VALUE="Error communicating with the server" eid="51236B7705FDAA9267874"/>
    <Message MESSAGE_NAME="error_accessing_server_description" Name="error_accessing_server_description" VALUE="The server cannot be reached" eid="51236B7705FDAA9267875"/>
    <Message MESSAGE_NAME="invalid_ssl_cert" Name="invalid_ssl_cert" VALUE="The SSL certificate is invalid. The server cannot be trusted." eid="51236B7705FDAA9267876"/>
    <Message MESSAGE_NAME="invalid_ssl_cert_development" Name="invalid_ssl_cert_development" VALUE="The SSL certificate is invalid. This is allowed only in development mode." eid="51236B7705FDAA9267877"/>
    <Message MESSAGE_NAME="lang_preference_dialog_title" Name="lang_preference_dialog_title" VALUE="Preferred language" eid="51236B7705FDAA9267878"/>
    <Message MESSAGE_NAME="lang_preference_title" Name="lang_preference_title" VALUE="Language settings" eid="51236B7705FDAA9267879"/>
    <Message MESSAGE_NAME="lang_preference_summary" Name="lang_preference_summary" VALUE="Select your preferred language" eid="51236B7705FDAA9267880"/>
    <Message MESSAGE_NAME="change_confirm_reload" Name="change_confirm_reload" VALUE="For applying your settings, the application has to be reloaded. Reload the application now?" eid="51236B7705FDAA9267881"/>
    <Message MESSAGE_NAME="settings_update_title" Name="settings_update_title" VALUE="Settings update" eid="51236B7705FDAA9267882"/>
    <Message MESSAGE_NAME="update_download_updates_now" Name="update_download_updates_now" VALUE="Updates are available. Download updates now?" eid="51236B7705FDAA9267883"/>
    <Message MESSAGE_NAME="update_result_uptodate" Name="update_result_uptodate" VALUE="The application is uptodate." eid="51236B7705FDAA9267884"/>
    <Message MESSAGE_NAME="update_result_error" Name="update_result_error" VALUE="The update site rejected the query." eid="51236B7705FDAA9267885"/>
    <Message MESSAGE_NAME="update_result_processing_error" Name="update_result_processing_error" VALUE="Error encountered during update." eid="51236B7705FDAA9267886"/>
    <Message MESSAGE_NAME="update_result_unknown_error" Name="update_result_unknown_error" VALUE="Error reading the update status from the update site." eid="51236B7705FDAA9267887"/>
    <Message MESSAGE_NAME="downloading_file_title" Name="downloading_file_title" VALUE="Downloading updates..." eid="51236B7705FDAA9267888"/>
    <Message MESSAGE_NAME="downloading_file_starting" Name="downloading_file_starting" VALUE="Starting..." eid="51236B7705FDAA9267889"/>
    <Message MESSAGE_NAME="downloading_file_progress" Name="downloading_file_progress" VALUE="Downloading file  %1$d of %2$d." eid="51236B7705FDAA9267890"/>
    <Message MESSAGE_NAME="downloading_updates_error" Name="downloading_updates_error" VALUE="Failed to download the updates." eid="51236B7705FDAA9267891"/>
    <Message MESSAGE_NAME="downloading_updates_success" Name="downloading_updates_success" VALUE="The updates were downloaded successfully." eid="51236B7705FDAA9267892"/>
    <Message MESSAGE_NAME="update_through_googleplay_confirmation" Name="update_through_googleplay_confirmation" VALUE="You need to update the application through google play. Download the updated application now?" eid="51236B7705FDAA9267893"/>
    <Message MESSAGE_NAME="update_through_windows_store_confirmation" Name="update_through_windows_store_confirmation" VALUE="You need to update the application through Windows Phone Store. Download the updated application now?" eid="51236B7705FDAA9267894"/>
    <Message MESSAGE_NAME="store_updatetitle" Name="store_updatetitle" VALUE="AppStore update" eid="51236B7705FDAA9267895"/>
    <Message MESSAGE_NAME="update_result_major_update" Name="update_result_major_update" VALUE="Updates are available for this application. Connect to iTunes now?" eid="51236B7705FDAA9267896"/>
    <Message MESSAGE_NAME="alert_title" Name="alert_title" VALUE="Alert" eid="51236B7705FDAA9267897"/>
    <Message MESSAGE_NAME="loading_wait" Name="loading_wait" VALUE="Loading, please wait..." eid="51236B7705FDAA9267898"/>
    <Message MESSAGE_NAME="save" Name="save" VALUE="Save" eid="51236B7705FDAA9267899"/>
    <Message MESSAGE_NAME="use_device_language" Name="use_device_language" VALUE="Use device language" eid="51236B7705FDAA9267900"/>
    <Message MESSAGE_NAME="all_pages" Name="all_pages" VALUE="All pages" eid="51236B7705FDAA9267901"/>
    <Message MESSAGE_NAME="filesave_success" Name="filesave_success" VALUE="File saved successfully" eid="51236B7705FDAA9267902"/>
    <Message MESSAGE_NAME="one_page" Name="one_page" VALUE="One page" eid="51236B7705FDAA9267903"/>
    <Message MESSAGE_NAME="pdf_documents" Name="pdf_documents" VALUE="PDF Documents" eid="51236B7705FDAA9267904"/>
    <Message MESSAGE_NAME="print" Name="print" VALUE="Print" eid="51236B7705FDAA9267905"/>
    <Message MESSAGE_NAME="reports" Name="reports" VALUE="Reports" eid="51236B7705FDAA9267906"/>
    <Message MESSAGE_NAME="app_name" Name="app_name" VALUE="App name - not used required by Cordova" eid="51236B7705FDAA9267907"/>
  </Messages>
  <HybridLanguages Name="HybridLanguages Root" eid="51236B7705FDAA9267844"/>
  <DataMapping/>
</DeploymentDescriptor>
