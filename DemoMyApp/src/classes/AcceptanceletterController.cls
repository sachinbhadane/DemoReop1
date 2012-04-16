public class AcceptanceletterController{
    public Opportunity opp;
    public User user{get;set;}
    public string msg{get;set;}
    public string letterName{get;set;}
    public string attId{get;set;} 
    public List<Acceptance_Letter__c> letter{get;set;}
    public List<Acceptance_Letter__c> newLetter{get;set;}
    public List<AcceptanceletterController.WrapObj> wrapList{get;set;}
    public AcceptanceletterController(){
              user = [SELECT 
                    contact.firstname
                    , contact.lastname
                    , contact.Last_Log_In__c 
                FROM User WHERE id = :UserInfo.getUserId()];
                
            try{
             opp=[select id from Opportunity where contact__c=:user.contact.id limit 1];                   
             letter = [select name,Letter_Title__c, (select id,name from attachments) from Acceptance_Letter__c where application__c=:opp.id];
            
             wrapList = new List<AcceptanceletterController.WrapObj>();
                 for(Acceptance_Letter__c al : letter){
                     if(al.attachments.size()>0){
                         wrapList.add(new AcceptanceletterController.WrapObj(al.attachments[0].name,al.attachments[0].id));
                     }
                 }
            
            }
            catch (exception e){
                apexpages.addmessages(e);
                
            }     
        
            
    }
    
    // inner class
    public class WrapObj {
          public String Letter_Title_c{get;set;}
          public string attID{get;set;}              
          
          public WrapObj(string Letter_Title_c, String attID){                  
              this.Letter_Title_c = Letter_Title_c;
              this.attID = attID;
          }
    }





}                                                                      