trigger changeApplicationOwner on Contact (after update) {
    /**
     * Commented out by Ian Zepp, replace by the Contact_UpdateOpportunities trigger+class
     *
     
   User user;   
   List<Contact> ncon=trigger.new;
   List<Contact> ocon=trigger.old; 
   if(ncon[0].ownerid!=ocon[0].ownerid)
   {
       try
       {
           user=[select id from user where (profile.Name='1.0 Hult Recruiters' or profile.Name='5.0 Hult Management' or profile.Name='12.0 Hult Super User' or profile.Name='7.0 Hult Product Manager') and  id = :ncon[0].ownerid limit 1]; 
           Opportunity oppList = [select Id, Contact__c, OwnerId from Opportunity where Contact__c=:ncon[0].id limit 1];         
           oppList.OwnerId = user.id;       
           update oppList;
        
       }
      catch(exception e){}
   }     
   
   */
}