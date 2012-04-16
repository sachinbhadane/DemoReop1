// Trigger for update Currency of Finance Object when the campus changed.
trigger updateCurrency on Opportunity (after update) {
     integer i;
     List<Opportunity_Finance__c> oppFinNew = new List<Opportunity_Finance__c>();
     List<Opportunity> opp = Trigger.new;
     List<Opportunity> oppOld = Trigger.old;
     for(i=0;i<opp.size();i++){
         if(opp[i].Primary_Campus__c!=oppOld[i].Primary_Campus__c){
             List<Opportunity_Finance__c> oppFin = [select id,CurrencyIsoCode from Opportunity_Finance__c where Opportunity__c=:opp[i].id];
             for(Opportunity_Finance__c opf : oppFin){
                 opf.CurrencyIsoCode = opp[i].Program_Currency__c;
                 oppFinNew.add(opf); 
             }
             
             try{
                 update oppFinNew;             
             }
             catch(System.DmlException e){
                 Trigger.new[i].adderror(e.getDmlMessage(i));
             }
         }
     }
}