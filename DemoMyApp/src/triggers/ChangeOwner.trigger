/* // Commented by Mahesh, below trigger is written in "Task_AssignOwner.cls"
    Created By Sekhar Swain, NetSutra
    Purpose: When a new task is created, AND if created by is s4s@hult.edu.fullqc AND who_id is an Applicant
    then set owner of the task to the Applicant's Owner 


trigger changeOwner on Task (before insert){
    List<Task> t = Trigger.new;
    String apiuserprofile = '00eU0000000HlxuIAC';
    id  Profile1= userinfo.getProfileId();

 // s4s ID is different on sandbox vs production, so use only one of the below lines.
 
//  Use the line below for Full QC Sandbox Server
    User user = [select id, ProfileId from user where username='s4s@hult.edu.fullqc' limit 1];    
    
 // Use the line below for Production Server
 // User user = [select id from user where username='s4s.apiuser@ef.com' limit 1];    // commnented by Mahesh G , 2/29, JIRA # 38   
      
        if(t[0].ownerId == user.profileId){
            List<Contact> con =[select id,ownerid from contact where id=:t[0].whoid];
            if( con.size()>0 ) t[0].ownerid = con[0].ownerid;        
        }   

}
*/
trigger ChangeOwner on Task (before insert) {
    new ChangeOwner(trigger.old, trigger.new).execute();
}