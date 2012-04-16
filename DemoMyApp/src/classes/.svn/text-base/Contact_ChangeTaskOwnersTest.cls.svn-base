@IsTest
private class Contact_ChangeTaskOwnersTest {
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
        Contact contact = new Contact();
        contact.FirstName = 'FirstName';
        contact.LastName = 'LastName';
        contact.Email = 'email@sample.com';
        contact.Do_Not_Route__c = true;
        insert contact;
        
        Task[] taskList = new Task[] {
            new Task(WhoId = contact.Id, OwnerId = UserInfo.getUserId()),
            new Task(WhoId = contact.Id, OwnerId = UserInfo.getUserId()),
            new Task(WhoId = contact.Id, OwnerId = UserInfo.getUserId())
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
              from Contact
             where Id = :contact.Id
        ].OwnerId);
        
        system.debug('*** contact update: START');
        contact.OwnerId = userList[0].Id;
        update contact;
        system.debug('*** contact update: END');
        
        system.assertEquals(userList[0].Id, [
            select OwnerId
              from Contact
             where Id = :contact.Id
        ].OwnerId);
        
        for(Task task : [
            select OwnerId
              from Task
             where Id in :taskList
        ]) system.assertEquals(userList[0].Id, task.OwnerId);
    }
}