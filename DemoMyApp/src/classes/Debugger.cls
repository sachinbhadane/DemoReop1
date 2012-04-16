/*
 Class 		: Debugger
 Created BY : Niket Chandane 
*/
public with sharing class Debugger 
{
	 public class SVPException extends Exception
    {
    }
    
    public static testMethod void testErrorClass()
    {
        Debugger err = new Debugger();
        err.Success = false;
        
        Debugger eError = new Debugger();
        eError = Debugger.DebugLog('Data saved successfully');
        Debugger errMessage = Debugger.LogError('Error occured while Saving!!');
        Debugger errMessageFail = Debugger.LogSuccess('Data saved successfully');
        
        Contact contactNew = new Contact();
        contactNew.MailingState = 'CA';
        contactNew.MailingPostalCode = '94965';
        contactNew.LastName = 'test';
        
        Database.SaveResult saveResult = Database.insert(contactNew);
        
        try
        {
            Debugger.LogSaveResult(saveResult, '');
            throw new SVPException('test');
        }
        catch(Exception ex)
        {
            Debugger.LogException(ex);
        }
    }
    
    Public Debugger()
    {
      Success = true;
      ErrorMessage = new ApexPages.Message(ApexPages.Severity.Info ,'Success!');
    }
      
    public Boolean Success {get; set;}
    private ApexPages.Message ErrorMessage = new ApexPages.Message(ApexPages.Severity.Info ,'Success!');

    /* Returns: Error */
    /* Parameters: SaveResult, String */
    /* This method create object of Error class depending on the parameters passed to it and
       returns the same.*/
    public static Debugger LogSaveResult(Database.SaveResult saveResult, String strSuccessMessage)
    {
        Database.Error[] arrErrors = saveResult.getErrors();
        String strErrorMessage = '';
        for(Database.Error errCurrent : arrErrors)
        {
            strErrorMessage += errCurrent.getMessage() + '<br/>';
        }
        Debugger err = new Debugger();
        err.Success = saveResult.isSuccess();
        if(saveResult.isSuccess())
            err.ErrorMessage = new ApexPages.Message(ApexPages.Severity.Info ,strSuccessMessage);
        Else
            err.ErrorMessage = new ApexPages.Message(ApexPages.Severity.Error ,strErrorMessage);
        apexPages.addMessage(err.ErrorMessage);
        return err;
    }
    
    /* Returns: Error */
    /* Parameters: String */
    /* This method create object of Error class depending on the parameters passed to it and
       returns the same.*/
    public static Debugger DebugLog(String strMsg)
    {
        Debugger err = new Debugger();
        err.Success = true;
                    
        err.ErrorMessage = new ApexPages.Message(ApexPages.Severity.Info ,strMsg);
        apexPages.addMessage(err.ErrorMessage);
        
        return err;
    }
    
    /* Returns: Error */
    /* Parameters: Boolean, Exception */
    /* This method create object of Error class depending on the parameters passed to it and
       returns the same.*/
    public static Debugger LogException(Exception ex)
    {
        Debugger err = new Debugger();
        err.Success = false;
                    
        err.ErrorMessage = new ApexPages.Message(ApexPages.Severity.Error , ex.getMessage());
        apexPages.addMessage(err.ErrorMessage);
        return err;
    }
    
    /* Returns: Error */
    /* Parameters: Boolean, String */
    /* This method create object of Error class depending on the parameters passed to it and
       returns the same.*/
    public static Debugger LogError(String strMsg)
    {
        Debugger err = new Debugger();
        err.Success = false;
        
        err.ErrorMessage = new ApexPages.Message(ApexPages.Severity.Error ,strMsg);
        apexPages.addMessage(err.ErrorMessage);
        
        return err;
    }
    
    /* Returns: Error */
    /* Parameters: Boolean, String */
    /* This method create object of Error class depending on the parameters passed to it and
     returns the same.*/
    public static Debugger LogSuccess(String strMsg)
    {
        Debugger err = new Debugger();
        err.Success = true;
        
        err.ErrorMessage = new ApexPages.Message(ApexPages.Severity.Info ,strMsg);
        
        apexPages.addMessage(err.ErrorMessage);
        return err;
    }

}