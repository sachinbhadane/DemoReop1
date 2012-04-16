trigger Email_Counters_Updater on xtma_Individual_Email_Result__c (before insert) {
 List<ID> LeadIds = New List<ID>();
    
    List<ID> CampaignIds = New List<ID>();
    
    List<Lead> leadsToUpdate = New List<Lead>();
    
    List<Campaign> CampaignToQuery = New List<Campaign>();
    
    for(xtma_Individual_Email_Result__c libro:Trigger.new){
        LeadIds.add(libro.Lead__c);
        CampaignIds.add(libro.Campaign__c);
        }
        
    leadsToUpdate = [select id, Number_Central_Emails__c, Number_Regional_Emails__c  from lead where id in :LeadIds];
    
    CampaignToQuery = [select id, Type from campaign where id in :CampaignIds];
    
    
    for (Lead l:leadsToUpdate){
        for (Campaign c: CampaignToQuery) {
            
            if (c.Type <> NULL) {
                if(l.Number_Central_Emails__c == NULL) {
                    l.Number_Central_Emails__c=1;
                    l.Central_Email_Sent_Date__c = System.Now();
                   }               
                else {
                    l.Number_Central_Emails__c++;
                    l.Central_Email_Sent_Date__c = System.Now();
                    }
                }    
               
            }
        }
    update leadsToUpdate;
}