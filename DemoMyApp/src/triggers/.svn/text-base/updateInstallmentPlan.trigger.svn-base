// Trigger to update Installment Plan on Finance Object when the program is changed.
trigger updateInstallmentPlan on Opportunity (after update) {
     integer i;
     List<Opportunity_Finance__c> oppFinNew = new List<Opportunity_Finance__c>();
     List<Opportunity> opp = Trigger.new;
     List<Opportunity> oppOld = Trigger.old;
     for(i=0;i<opp.size();i++){
         if(opp[i].Program__c !=oppOld[i].Program__c ){
             List<Opportunity_Finance__c> oppFin = [select id,Installment_Plan__c, 
             Housing_Accommodation__c, CurrencyIsoCode from Opportunity_Finance__c where Opportunity__c=:opp[i].id];
             for(Opportunity_Finance__c opf : oppFin){
             
                 if (opp[i].Program_Parsed__c != 'EMBA') {
                     opf.Installment_Plan__c = 'No Installment Plan';
                     opf.Housing_Accommodation__c= '';
                     //opf.Rebooking_Guarantee__c= FALSE;
                     opf.Payment_Amount_3rd__c= NULL;
                     opf.Payment_Due_Date_3rd__c= NULL;
                     opf.Payment_Amount_4th__c= NULL;
                     opf.Payment_Due_Date_4th__c= NULL;
                     opf.Payment_Amount_5th__c= NULL;
                     opf.Payment_Due_Date_5th__c= NULL;
                     opf.Payment_Amount_6th__c= NULL;
                     opf.Payment_Due_Date_6th__c= NULL;
                     opf.Payment_Amount_7th__c= NULL;
                     opf.Payment_Due_Date_7th__c= NULL;
                     opf.Payment_Amount_8th__c= NULL;
                     opf.Payment_Due_Date_8th__c= NULL;
                     opf.CurrencyIsoCode = opp[i].Program_Currency__c;}
                 else {
                     opf.Installment_Plan__c = 'No FlexiPlan';
                     opf.Housing_Accommodation__c= '';
                     //opf.Rebooking_Guarantee__c= FALSE;
                     opf.Payment_Amount_5th__c= NULL;
                     opf.Payment_Due_Date_5th__c= NULL;
                     opf.Payment_Amount_6th__c= NULL;
                     opf.Payment_Due_Date_6th__c= NULL;
                     opf.Payment_Amount_7th__c= NULL;
                     opf.Payment_Due_Date_7th__c= NULL;
                     opf.Payment_Amount_8th__c= NULL;
                     opf.Payment_Due_Date_8th__c= NULL;
                     opf.CurrencyIsoCode = opp[i].Program_Currency__c;}
                 
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