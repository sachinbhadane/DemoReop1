/***************************************************************************************
Class Name      : Task_AssignOwner
Author          : Mahesh Gaddam
Created Date    : March 15, 2012
Usage           : This class is for Task_AssignOwner trigger.                
                : This trigger updates Owner on new Tasks to the owner of the contact if the 
                  task is created by s4s.apiuser@ef.com.fullqc.     
Revision History: 
****************************************************************************************/
public without sharing class Task_AssignOwner extends TaskTrigger {
    public Task_AssignOwner(Task[] taskOldList, Task[] taskNewList) {
        super(taskOldList, taskNewList);
    }
    
    public override void execute() {
    	User[] user = [select id, profileID from user where username='s4s.apiuser@ef.com.fullqc' limit 1]; 
    	
    	if(user.size() == 0)
    	 return;
    	
    	System.debug(' ::Task_AssignOwner:: step 1'); 
    	id  Profile1= userinfo.getProfileId();
        Map<Id, Id> recordOwnerIds = new Map<Id, Id> {};
               
        for(Task taskNew : taskNewList) {
            Task taskOld = taskOld(taskNew.Id);
            System.debug(' ::Task_AssignOwner:: step 2::');
            
            if (taskNew.WhoId == null)
           	    continue;
            
            if (userinfo.getProfileId()!= user[0].ProfileId)
                continue;
            
	        if (String.valueOf(user[0].profileId).equals(Profile1)&& String.valueOf(taskNew.WhoId).startsWith('003'))   
                recordOwnerIds.put(taskNew.WhoId, null);
          }
        
        // Nothing to match?
        if (recordOwnerIds.size() == 0){
        	System.debug(' ::Task_AssignOwner:: step 3:: recordOwnerIds.size' );
        	return;
        }
            
        // Contacts for recordOwnerIds
        for(Contact record : [
            select OwnerId
              from Contact
             where Id in :recordOwnerIds.keySet()
        ]) recordOwnerIds.put(record.Id, record.OwnerId);
        
        // Reassign
        for(Task taskNew : taskNewList) { 
        	Task taskOld = taskOld(taskNew.Id);
            System.debug(' ::Task_AssignOwner:: step 4::' );
            if (taskNew.WhoId == null)
                continue;
            if (recordOwnerIds.containsKey(taskNew.WhoId) == false)
                continue;
            taskNew.OwnerId = recordOwnerIds.get(taskNew.WhoId);
            System.debug(' ::Task_AssignOwner:: step 5:' );
             
        }
    }
}