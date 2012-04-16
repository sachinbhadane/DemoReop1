public class headerController{
    public string App_ID_c{get;set;}
    public headerController(){
        try{
        User  user = [SELECT contactid FROM User WHERE id = :UserInfo.getUserId()];        
        Opportunity opp=[select App_ID__c, id from Opportunity where contact__c=:user.contactid limit 1];     
        App_ID_c = opp.App_ID__c;        
        } catch(exception e){
        }
    }
    static testMethod void headerID(){
        headerController hc = new headerController();    
    }    
}