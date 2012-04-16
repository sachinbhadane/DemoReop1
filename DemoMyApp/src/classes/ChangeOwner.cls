/* Purpose: When a new task is created, AND if created by is s4s@hult.edu.fullqc AND who_id is an Applicant
    then set owner of the task to the Applicant's Owner 
*/
 public without sharing class ChangeOwner extends TaskTrigger {
    public ChangeOwner(Task[] taskOldList, Task[] taskNewList) {
        super(taskOldList, taskNewList);
    }
    
    public override void execute() {
    	return;
    	/*
        //User user = [select id from user where username='s4s@hult.edu.fullqc' limit 1]; 
        System.debug(' ::Task_AssignOwner:: step 1'); // Added by mahesh G, 2/29, JIRA #38
        String apiuserprofile = '00eU0000000HlxuIAC';
        id  Profile1= userinfo.getProfileId();
        Map<Id, Id> recordOwnerIds = new Map<Id, Id> {};
        
        for(Task taskNew : taskNewList) {
            Task taskOld = taskOld(taskNew.Id);
            
            if (Profile1 == apiuserprofile)
                recordOwnerIds.put(taskNew.WhoId, null);
                System.debug(' :::ChangeOwner trigger ::: step 1::');
           }
        
        // Nothing to match?
        if (recordOwnerIds.size() == 0){
            System.debug(' :::ChangeOwner trigger ::: step 2::');
            return;
        }
           
        
        // Contacts
        for(Contact record : [
            select OwnerId
              from Contact
             where Id in :recordOwnerIds.keySet()
        ]) recordOwnerIds.put(record.Id, record.OwnerId);
        
        // Reassign
        for(Task taskNew : taskNewList) {
            System.debug(' :::ChangeOwner trigger ::: step 3::');
            Task taskOld = taskOld(taskNew.Id);
            if (recordOwnerIds.containsKey(taskNew.WhoId) == true)
            {   
                System.debug(' :::ChangeOwner trigger ::: step 4::');
                taskNew.OwnerId = recordOwnerIds.get(taskNew.WhoId);
            } 
        }
       */ 
    }
    
}