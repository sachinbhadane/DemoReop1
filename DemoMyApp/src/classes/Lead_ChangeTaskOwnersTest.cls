@IsTest
private class Lead_ChangeTaskOwnersTest {
    public static User[] userList = [
        select Id 
          from User 
         where IsActive = true
           and Id != :UserInfo.getUserId()
           and ProfileId = :UserInfo.getProfileId()
         limit 3
    ];
    
    @IsTest
    public static void test() {
        Country__c country = [select Id from Country__c limit 1];
        Program__c program = [select Id from Program__c limit 1];
        
        Lead lead = new Lead();
        lead.FirstName = 'FirstName';
        lead.LastName = 'LastName';
        lead.Company = 'Company';
        lead.LeadSource = 'Undecided';
        lead.Email = 'cccded1d8f725170a1aad6a8147af7a8@example.com';
        lead.Applicant_Email__c = 'cccded1d8f725170a1aad6a8147af7a8@example.com'; // Added by Mahesh G, 3/12
        lead.Do_Not_Route__c = true;
        lead.Program_Primary__c = program.Id;
        lead.Country_of_Residence__c = country.Id;
        insert lead;
        
        Task[] taskList = new Task[] {
            new Task(WhoId = lead.Id, OwnerId = UserInfo.getUserId()),
            new Task(WhoId = lead.Id, OwnerId = UserInfo.getUserId()),
            new Task(WhoId = lead.Id, OwnerId = UserInfo.getUserId())
        };
        
        insert taskList;
        
        for(Task task : [
            select OwnerId
              from Task
             where Id in :taskList
        ]) system.assertEquals(UserInfo.getUserId(), task.OwnerId);
        
        system.assert(UserInfo.getUserId() != userList[0].Id);
        system.assertEquals(UserInfo.getUserId(), [
            select OwnerId
              from Lead
             where Id = :lead.Id
        ].OwnerId);
        
        system.debug('*** lead update: START');
        lead.OwnerId = userList[0].Id;
        update lead;
        system.debug('*** lead update: END');
        
        system.assertEquals(userList[0].Id, [
            select OwnerId
              from Lead
             where Id = :lead.Id
        ].OwnerId);
        
        for(Task task : [
            select OwnerId
              from Task
             where Id in :taskList
        ]) system.assertEquals(userList[0].Id, task.OwnerId);
    }
}