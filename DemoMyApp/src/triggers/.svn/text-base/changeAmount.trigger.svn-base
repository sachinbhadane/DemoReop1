trigger changeAmount on Finance_Transactions__c (before insert, before update ) {
    double cValue;
    //Map<id,Finance_Transactions__c> ft = new Map<id,Finance_Transactions__c>(trigger.oldMap);

    set<id> finaceID = new set<id>();
    for(Finance_Transactions__c ftt : trigger.new){
        finaceID.add(ftt.finance__c);
    }   
    
    
    DateTime crateddate;
    
    List<DatedConversionRate> ExchRateCache = [SELECT ISOCode, ConversionRate, StartDate, NextStartDate 
                    FROM DatedConversionRate];
                    system.debug('ExchRateCache'+ExchRateCache.size());
                    
    for(Finance_Transactions__c fttn : trigger.new){      
        Opportunity_Finance__c oppMap = [select id, Opportunity__r.program__r.CurrencyIsoCode  from Opportunity_Finance__c where id =:fttn.Finance__c];        
          crateddate = fttn.createddate;
          if(crateddate==null){
              crateddate = date.today();
          } 
               
           currencyConvert(double.valueof(fttn.Amount_Received__c),string.valueof(fttn.CurrencyIsoCode),string.valueof(oppMap.Opportunity__r.program__r.CurrencyIsoCode), date.valueof(crateddate));
           fttn.Amount_Received_New__c = cvalue;                 
    }
    
  
  

    public double nRate(String cCode, date dDateFieldValue){
               double nRate = -1;
                    for (DatedConversionRate exchRate : ExchRateCache) {
                        // Looping through the cached DatedConversionRate object
                        if (exchRate.ISOCode == cCode 
                        && exchRate.StartDate <= dDateFieldValue 
                        && exchRate.NextStartDate > dDateFieldValue) {
                            // Look for a match for CURRENCYCODE and within the Date Ranges
                            nRate = exchRate.ConversionRate;
                            break;
                        }
                    }
                    return nRate;
           }              
          
           public void currencyConvert(double amount,string cCode,string newCode, Date dDateFieldValue){
           cValue=0;
           
              
               try{                   
                   cValue = ((nRate(newCode,dDateFieldValue))/nRate(cCode ,dDateFieldValue))*amount;
               } 
               Catch(exception  e){
                   //apexpages.addmessages(e);                   
                   cvalue=amount;
               }
               //return cValue;
           } 
}