@IsTest
private class Contact_RouteByRecruitingTest 
{
	static testmethod void AnalysContact_RouteByRecrutingTest()
	{
		test.startTest();
		
		ID ProfileID = [ Select id from Profile][0].id;
		
		 User objUser = new User( email='test-user@fakeemail.com', profileid = profileid, 
                			UserName='test-user@fakeemail.com', alias='tuser1', CommunityNickName='tuser1', 
        					TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1', 
        					LanguageLocaleKey='en_US', FirstName = 'Test', LastName = 'User' );
        insert objUser;
		
		// Create Country 
		Country__c objCountry = new Country__c( Name = 'DemoCountry',Calling_Code__c = 00,Country_Code__c  = 'pp',Region__c = 'MEA11');
        insert objCountry;
		
		//Create Department Data
        Department__c objDept = new Department__c(Name = 'TestMBA');
        insert objDept;
		
		// Created Country Requirement 
		Requirement__c objReqCountry = new Requirement__c(Name = 'CR',Country__c = objCountry.Id);
        insert objReqCountry;
		
		// Created Program
		Program__c objProgram = new Program__c(Name = 'TestProgram',Country__c= objCountry.Id,Department__c = objDept.Id);
        insert objProgram;
		
		
		test.stopTest();
	}
}