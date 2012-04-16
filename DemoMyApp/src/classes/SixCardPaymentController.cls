Public without sharing class SixCardPaymentController
{
    public string TxnID{get;set;}
    public string TxnType{get;set;}
    public string TxnState{get;set;}
    public string ActionCode{get;set;}
    public string ActionMsg{get;set;}
    public string AuthCode{get;set;}
    public string Error_Code{get;set;}
    public string Error_Text{get;set;}
    public string MerchantRef{get;set;}
    public string Card_Type{get;set;}
    public string Card_4Digit{get;set;}
    public String Card_Expiry{get;set;}
    public string financeID{get;set;}
    public string MerchantRef2{get;set;}
    string apid;
    public SixCardPaymentController(){
        if ((ApexPages.currentPage().getParameters().get('trx_merchant_reference') != null) && ApexPages.currentPage().getParameters().get('trx_merchant_reference').trim() != '' ){
                 apid = System.currentPagereference().getParameters().get('trx_merchant_reference');
        }
        else{
                apid =null;
        }
        if (ApexPages.currentPage().getParameters().get('TrxID') != null ){
                 TxnID = System.currentPagereference().getParameters().get('TrxID');
        }
        else{
                TxnID='Not Getting';
         }
         
         if (ApexPages.currentPage().getParameters().get('TrxState') != null ){
                 TxnState = ApexPages.currentPage().getParameters().get('TrxState');
          }
          else{
                TxnState = 'Not Getting';
         }
           
         if (ApexPages.currentPage().getParameters().get('AuthCode') != null ){
                 ActionCode = ApexPages.currentPage().getParameters().get('AuthCode');
            }
         else{
                ActionCode = 'Not Getting';
         }
            
         if (ApexPages.currentPage().getParameters().get('authorise_info_action_message') != null ){
                 ActionMsg = ApexPages.currentPage().getParameters().get('authorise_info_action_message');
          }
          else{
                ActionMsg = 'Not Getting';
          }
           
          if (ApexPages.currentPage().getParameters().get('authorise_info_authorise_code') != null ){
                 AuthCode = ApexPages.currentPage().getParameters().get('authorise_info_authorise_code');
          }
          else {
                AuthCode = 'Not Getting';
          }
            
          if (ApexPages.currentPage().getParameters().get('ErrorCode') != null ){
                 Error_Code = ApexPages.currentPage().getParameters().get('ErrorCode');
          }
          else{
                Error_Code = 'Not Getting';
          }
            
          if (ApexPages.currentPage().getParameters().get('ErrorText') != null ){
                 Error_Text = ApexPages.currentPage().getParameters().get('ErrorText');
          } 
          else{
                Error_Text = 'Not Getting';
          }
           
          if (ApexPages.currentPage().getParameters().get('trx_merchant_reference') != null ){
                 financeID  = ApexPages.currentPage().getParameters().get('trx_merchant_reference');
            }
          else{
                financeID = null;
          }
            
          if (ApexPages.currentPage().getParameters().get('trx_merchant_reference_2') != null ){
                 TxnType = ApexPages.currentPage().getParameters().get('trx_merchant_reference_2');
          }
          else{
                TxnType  = null;
          }
            
          if (ApexPages.currentPage().getParameters().get('CardType') != null ){
                 Card_Type = ApexPages.currentPage().getParameters().get('CardType');
           }
           else{
                Card_Type = 'Not Getting';
           }
            
           if (ApexPages.currentPage().getParameters().get('Card4Digits') != null ){
                 Card_4Digit = ApexPages.currentPage().getParameters().get('Card4Digits');
           }
           else{
                Card_4Digit = '';
           }
             
           if (ApexPages.currentPage().getParameters().get('CardExpiry') != null ){
                 Card_Expiry = ApexPages.currentPage().getParameters().get('CardExpiry');
            }
            else{
                Card_Expiry = null;
            }
    }
    
    public void  PaymentSuccess(){
        if(TxnType=='Application Fee'){
            ApplicationFeeSucess();
        }
        else if(TxnType=='Confirmation Deposit'){
            ConfirmationDepositSucess();        
        }
    }
    
    public void  PaymentFailure(){
          if(TxnType=='Application Fee'){
            ApplicationFeeFailure();
        }
        else if(TxnType=='Confirmation Deposit'){
            ConfirmationDepositFailure();        
        }  
        
    }
    
    public void ConfirmationDepositSucess(){
        try
        {
           // CC_Transaction_Results__c TrnResultSuccess = new CC_Transaction_Results__c();
            Finance_Transactions__c TrnResultSuccess = new Finance_Transactions__c();
            TrnResultSuccess =[select 
                                      Finance__r.Confirmation_Deposit_Paid__c
                                    , Finance__r.Opportunity__r.Paid_Application_Fee__c
                                    , Finance__r.Opportunity__r.Application_Fee_Complete__c  
                                    , Action_Code__c
                                    , Card_Type__c
                                    , Error_Code__c
                                    , Error_Text__c
                                    , Transaction_Method__c
                                    , Transaction_Status__c 
                                    , Expiry_Date__c
                                    , Transaction_ID__c
                                    , Transaction_State__c
                                    , Transaction_Type__c
                                    , Card_Last_4__c  
                                    , Finance__r.Opportunity__r.app_id__c
                                   
                             from Finance_Transactions__c where id=:financeID];              
            TrnResultSuccess.Action_Code__c = ActionCode ;
            TrnResultSuccess.Card_Type__c = Card_Type ;
            TrnResultSuccess.Error_Code__c= Error_Code ;
            TrnResultSuccess.Error_Text__c  = Error_Text ;
            TrnResultSuccess.Expiry_Date__c = Card_Expiry ;
            TrnResultSuccess.Transaction_ID__c = TxnID;
            TrnResultSuccess.Transaction_State__c = TxnState;                
            TrnResultSuccess.Transaction_Type__c = TxnType;            
            TrnResultSuccess.Card_Last_4__c = Card_4Digit;
            TrnResultSuccess.Transaction_Method__c = 'CC Charged Via Salesforce';
            TrnResultSuccess.Transaction_Status__c = 'Success';
            //TrnResultSuccess.App_ID__c = TrnResultSuccess.Finance__r.Opportunity__r.app_id__c;
            upsert TrnResultSuccess;
            // update Finance object flage
            TrnResultSuccess.Finance__r.Confirmation_Deposit_Paid__c = true;
            update TrnResultSuccess.Finance__r;
            
        }
        catch(Exception ex)
        {
            apexpages.addmessages(ex);
        }
    
    }
    
    public void ConfirmationDepositFailure(){
        try
        {
            Finance_Transactions__c TrnResultFailure = new Finance_Transactions__c();
            TrnResultFailure =[select 
                                     Action_Code__c
                                     , Card_Type__c
                                     , Error_Code__c
                                     , Error_Text__c
                                     , Transaction_Method__c
                                     , Transaction_Status__c 
                                     , Expiry_Date__c
                                     , Transaction_ID__c
                                     , Transaction_State__c
                                     , Transaction_Type__c
                                     , Card_Last_4__c  
                                     , Finance__r.Opportunity__r.app_id__c                                    
                                 from Finance_Transactions__c where id=:financeID];              
            TrnResultFailure.Action_Code__c = ActionCode ;
            TrnResultFailure.Card_Type__c = Card_Type ;
            TrnResultFailure.Error_Code__c= Error_Code ;
            TrnResultFailure.Error_Text__c  = Error_Text ;
            TrnResultFailure.Expiry_Date__c = Card_Expiry ;
            TrnResultFailure.Transaction_ID__c = TxnID;
            TrnResultFailure.Transaction_State__c = TxnState;                
            TrnResultFailure.Transaction_Type__c = TxnType;            
            TrnResultFailure.Card_Last_4__c = Card_4Digit;
            TrnResultFailure.Transaction_Method__c = 'CC Charged Via Salesforce';
            //TrnResultFailure.App_ID__c = TrnResultFailure.Finance__r.Opportunity__r.app_id__c;
                if(Error_Text.contains('DECLINE')){
                   TrnResultFailure.Transaction_Status__c = 'Decline';
                }
                else{
                   TrnResultFailure.Transaction_Status__c = 'Error';
                }
            update TrnResultFailure;
            
            
        }
        catch(Exception ex)
        {
            apexpages.addmessages(ex);
        }
    
    }
    
    public void ApplicationFeeSucess(){
        try
        {
           // CC_Transaction_Results__c TrnResultSuccess = new CC_Transaction_Results__c();
            Finance_Transactions__c TrnResultSuccess = new Finance_Transactions__c();
            TrnResultSuccess.Action_Code__c = ActionCode ;
            TrnResultSuccess.Finance__c = financeID ;
            TrnResultSuccess.Card_Type__c = Card_Type ;
            TrnResultSuccess.Error_Code__c= Error_Code ;
            TrnResultSuccess.Error_Text__c  = Error_Text ;
            TrnResultSuccess.Expiry_Date__c = Card_Expiry ;
            TrnResultSuccess.Transaction_ID__c = TxnID;
            TrnResultSuccess.Transaction_State__c = TxnState;                
            TrnResultSuccess.Transaction_Type__c = TxnType;            
            TrnResultSuccess.Card_Last_4__c = Card_4Digit;
            TrnResultSuccess.Transaction_Method__c = 'CC Charged Via Salesforce';
            TrnResultSuccess.Transaction_Status__c = 'Success';
            upsert TrnResultSuccess;            
            
            //Update Application flage
            Finance_Transactions__c TxnResult =[select 
                                      Finance__r.Confirmation_Deposit_Paid__c
                                    , Finance__r.Opportunity__r.Paid_Application_Fee__c
                                    , Finance__r.Opportunity__r.Application_Fee_Complete__c 
                                    , Finance__r.Opportunity__r.app_id__c             
                             from Finance_Transactions__c where id=:TrnResultSuccess.id];
            
            
            TxnResult.Finance__r.Opportunity__r.Paid_Application_Fee__c = true;
            TxnResult.Finance__r.Opportunity__r.Application_Fee_Complete__c = true;
            update TxnResult.Finance__r.Opportunity__r;
            
            /*TxnResult.App_ID__c = TxnResult.Finance__r.Opportunity__r.app_id__c;
            update TxnResult;*/
            
        }
        catch(Exception ex)
        {
            apexpages.addmessages(ex);
        }
    
    }
    
    public void ApplicationFeeFailure(){
        try{
            Finance_Transactions__c TrnResultFailure = new Finance_Transactions__c();
            TrnResultFailure.Action_Code__c = ActionCode ;
            TrnResultFailure.Finance__c = financeID ;
            TrnResultFailure.Card_Type__c = Card_Type ;
            TrnResultFailure.Error_Code__c= Error_Code ;
            TrnResultFailure.Error_Text__c  = Error_Text ;
            TrnResultFailure.Expiry_Date__c = Card_Expiry ;
            TrnResultFailure.Transaction_ID__c = TxnID;
            TrnResultFailure.Transaction_State__c = TxnState;                
            TrnResultFailure.Transaction_Type__c = TxnType;            
            TrnResultFailure.Card_Last_4__c = Card_4Digit;
            TrnResultFailure.Transaction_Method__c = 'CC Charged Via Salesforce';
                if(Error_Text.contains('DECLINE')){
                   TrnResultFailure.Transaction_Status__c = 'Decline';
                }
                else{
                   TrnResultFailure.Transaction_Status__c = 'Error';
                }
            insert TrnResultFailure;
            
          //Update Application flage
           /* Finance_Transactions__c TxnResult =[select Finance__r.Opportunity__r.app_id__c             
                             from Finance_Transactions__c where id=:TrnResultFailure.id];
                       
            TxnResult.App_ID__c = TxnResult.Finance__r.Opportunity__r.app_id__c;
            update TxnResult;*/
            
       }
       catch(Exception ex){
           apexpages.addmessages(ex);
       }
   }
}