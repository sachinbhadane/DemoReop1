@isTest 
private class Contact_UpdateOpportunitiesTest
{
	  
	   static testmethod void test()
         {
           User[] newUser = [
            select Id, Name
              from User
              where Id != :UserInfo.getUserId()
              and IsActive = true
               and ContactId = null // no portal users
             limit 3
                             ];
        System.debug(':::::: Contact_UpdateOpportunitiesTest::newUser 1::===>' +newUser[0].Name);
        System.debug(':::::: Contact_UpdateOpportunitiesTest::newUser 2::===>' +newUser[1].Name);
        
        Country__c[] country = [
          Select Id 
          FROM Country__c
          WHERE Name = 'United States'
          limit 1
          ];
        
        if (newUser.size() == 0 || country.size() == 0)
          return; 
       
        Account account = new Account();
        account.Name = 'Account';
        insert account;
        System.debug(':::::: Contact_UpdateOpportunitiesTest::Account::===>' +Account.Name);
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'FirstName1';
        contact1.LastName = 'LastName1';
        contact1.OwnerId = newUser[0].Id;
        contact1.Country_Of_Residence__c = country[0].Id;
        contact1.MailingCity = 'Holmdel';
        insert contact1;
        System.debug(':::::: Contact_UpdateOpportunitiesTest::contact1::===>' +contact1.FirstName);
        
        Contact contact = new Contact();
        contact.FirstName = 'FirstName';
        contact.LastName = 'LastName';
        contact.AccountId = account.Id;
        contact.OwnerId = newUser[2].Id;
        contact.Country_Of_Residence__c = country[0].Id;
        contact.MailingCity = 'Holmdel';
        insert contact;
        System.debug(':::::: Contact_UpdateOpportunitiesTest::contact::===>' +contact.FirstName);
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Opportunity';
        opportunity.StageName = 'StageName';
        opportunity.AccountId = account.Id;
        opportunity.Contact__c = contact.Id;
        opportunity.CloseDate = Date.today();
        opportunity.OwnerId = newUser[2].Id;
       // opportunity.CurrencyIsoCode = 'USD-U.S.Dollar';
       // opportunity.ForecastCategory = 'Hot';
        insert opportunity;
        System.debug(':::::: Contact_UpdateOpportunitiesTest::opportunity::===>' +opportunity.Name);
       	contact1.OwnerId = newUser[1].Id;
		update contact1;
       	
       	contact.OwnerId= newUser[1].Id;
		update contact; 
		
			
		    Opportunity[] message = [SELECT OwnerId FROM Opportunity WHERE ID = :opportunity.Id]; 
		    
		    System.debug(':::::: Contact_UpdateOpportunitiesTest::cont::OwnerID of Opportuntiy ===>' +message[0].OwnerID); 
				if(message.size() > 0)
					{
					System.assert(message[0].OwnerId == newUser[1].Id);	
					System.debug(':::::: Contact_UpdateOpportunitiesTest::asertedvalue::===>' +message[0].OwnerID);
			     	System.debug(':::::: Contact_UpdateOpportunitiesTest::cont::ID should be same as above ===>' +newUser[1].ID);
					}
								
   		}
}