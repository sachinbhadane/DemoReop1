trigger HelloWorldTrigger on Book__c (before insert) {

    List<ID> LeadIds = New List<ID>();
    
    List<ID> CampaignIds = New List<ID>();
    
    List<Lead> leadsToUpdate = New List<Lead>();
    
    List<Campaign> CampaignToQuery = New List<Campaign>();
    
    for(Book__c libro : Trigger.new){
        LeadIds.add(libro.Lead__c);
        CampaignIds.add(libro.Campaign__c);
        }
        
    leadsToUpdate = [select id, Number_Central_Emails__c from lead where id in :LeadIds];
    
    //CampaignToQuery = [select id, Type from campaign where id in :CampaignIds];
    
    //leadsToUpdate = [select x.id, x.Number_Central_Emails__c from lead x where x.id in :LeadIds];
    
    for (Lead l:leadsToUpdate){
        if(l.Number_Central_Emails__c == NULL) {
            l.Number_Central_Emails__c=1;
            l.Regional_Email_Sent_Date__c = System.Now();}
        else {
            l.Number_Central_Emails__c++;
            l.Regional_Email_Sent_Date__c = System.Now();
            }
    }
    update leadsToUpdate;
}