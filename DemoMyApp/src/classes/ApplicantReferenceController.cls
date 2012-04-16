public without sharing  class ApplicantReferenceController {
public String forname1{get;set;}
public string surname1{get;set;}
public string comname1{get;set;}
public string position1{get;set;}
public string email1{get;set;}
public string oldemail1{get;set;}
public string cemail1{get;set;}
public String forname2{get;set;}
public string surname2{get;set;}
public string comname2{get;set;}
public string position2{get;set;}
public string email2{get;set;}
public string oldemail2{get;set;}
public string cemail2{get;set;}
public User user{get;set;}
public Opportunity opp{get;set;}
public contact con1{get;set;}
public contact con2{get;set;}
public Requirement__c req1{get;set;}
public Requirement__c req2{get;set;}
public boolean finalsubmit{get;set;}
public boolean tab2{get;set;}
public string proName{get;set;}
public String url=site.getCurrentSiteUrl();
List<string> pname;
public boolean Recom1{get;set;}
public boolean Recom2{get;set;}
public string refurl1{get;set;}
public string refurl2{get;set;}
public List<Requirement__c> recList{get;set;}
public static ID Referee_recordtype_id = [select Id from recordtype where Name = 'Referee' and sobjecttype='contact' limit 1].id;
String pat = '[a-zA-Z0-9\\.\\!\\#\\$\\%\\&\\*\\/\\=\\?\\^\\_\\+\\-\\`\\{\\|\\}\\~\'._%+-]+@[a-zA-Z0-9\\-.-]+\\.[a-zA-Z]+';

    public ApplicantReferenceController()
    {
        user = [SELECT contact.id,contact.firstname,contact.lastname,profile.name FROM User WHERE id = :UserInfo.getUserId()];
        // to lock visualforce page----
                 try{
                 ApplicantFinalController contrl= new ApplicantFinalController();
                 contrl.getopp();                 
                 finalsubmit=ApplicantFinalController.finalsubmit;}
                 catch(exception e){}
        getrefdata();
    }
    public Opportunity  opprec;
    public void getrefdata()
    {
            try{
             opprec=[select id,Program_and_Location_Tab_Complete__c from Opportunity where contact__c=:user.contact.id  limit 1];
              if(opprec.Program_and_Location_Tab_Complete__c==true)
                {tab2=true;}
                  
             } catch (exception e){//finalsubmit=true;
             }
            //where Opportunity__c=:opp and name='';
            try{
            recList=[select 
                          Recommendation_Background__c
                        , id
                        , Recommendation_Contact__r.id
                        , Recommendation_Contact__r.firstname
                        , Recommendation_Contact__r.lastname
                        , Recommendation_Contact__r.email
                        , Recommendation_Contact__r.Recommender_Company__c
                        , Recommendation_Contact__r.Title
                        , name 
                     from requirement__c
                     /*Changes by : Sachin Bhadane */
                     /*added an Extra condition in Where clause that is "isDeleted=false" */ 
                     where Opportunity__c=:opprec.id and recordtype.Name='Recommendation' and isDeleted=false order by name asc limit 2];
            
            if(recList.size()!=0)
            {
                if(recList.size()>0)
                {
                    Recom1=true;
                    forname1=recList[0].Recommendation_Contact__r.firstname;
                    surname1=recList[0].Recommendation_Contact__r.lastname;
                    comname1=recList[0].Recommendation_Contact__r.Recommender_Company__c;
                    position1=recList[0].Recommendation_Contact__r.title;
                    email1=recList[0].Recommendation_Contact__r.email;
                    oldemail1=recList[0].Recommendation_Contact__r.email;
                    cemail1=recList[0].Recommendation_Contact__r.email;
                    if(recList[0].Recommendation_Background__c!=null && recList[0].Recommendation_Contact__r.email!=null){
                    refurl1 = url+'ApplicationRecommendation?contactid='+recList[0].id+'&c='+EncodingUtil.urlEncode(email1, 'UTF-8');
                    }
                    if(forname1!=null)
                    {
                        //finalsubmit=true;
                    }
                }
                if(recList.size()>1)
                {
                    Recom2=true;
                    forname2=recList[1].Recommendation_Contact__r.firstname;
                    surname2=recList[1].Recommendation_Contact__r.lastname;
                    comname2=recList[1].Recommendation_Contact__r.Recommender_Company__c;
                    position2=recList[1].Recommendation_Contact__r.title;
                    email2=recList[1].Recommendation_Contact__r.email;
                    oldemail2=recList[1].Recommendation_Contact__r.email;
                    cemail2=recList[1].Recommendation_Contact__r.email;
                    if(recList[1].Recommendation_Background__c!=null && recList[1].Recommendation_Contact__r.email!=null){
                    refurl2 = url+'ApplicationRecommendation?contactid='+recList[1].id+'&c='+EncodingUtil.urlEncode(email2, 'UTF-8');
                    }
                    if(forname2!=null)
                    {
                       // finalsubmit=true;
                    }
                }
                    
            }
            else
            {
                Recom1=false;
                Recom2=false;  
            }
          }
          Catch(exception e){ApexPages.addMessages(e);} 
            
    }

       public pagereference saveandcontinue()
    {
    
            system.debug('recList==='+recList);
            system.debug('******'+recList.size());
            if(recList.size()>0)
            {
                if(forname1.trim()=='')
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter reference one First Name'));
                }           
                 
                if(surname1.trim()=='')
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter reference one Last Name'));          
                }
                           
                if(!Pattern.matches(pat, email1))
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter reference one valid email address'));            
                }
                
                if((cemail1.trim()=='') || (email1!=cemail1))
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Reference one email address and confirm email address did not match'));            
                }
            }
           
           if(forname2.trim()!='' || surname2.trim()!='' ||  cemail2.trim()!='' || email2.trim()!=''){
           
               if(recList.size()>1)
                {           
                   if(forname2.trim()=='')
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter reference two First Name'));
                    }
                   if(surname2.trim()=='')
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter reference two Last Name'));            
                    } 
                   if(!Pattern.matches(pat, email2))
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter reference two valid email address'));            
                    } 
                   if((cemail2.trim()=='') || (email2!=cemail2))
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Reference two email address and confirm email address did not match'));            
                    }
                }
            }
            
            if(!apexpages.hasmessages()) 
            {
                Opportunity  opprec=[select id from Opportunity where contact__c=:user.contact.id  limit 1];
                // Code for Create first reference contact---
                try{
                        req1=[select Supplied__c, id, Recommendation_Contact__c from requirement__c where id=:recList[0].id];
                        // Code for create contact--
                        try{
                            con1=[select recordtypeid, Do_Not_Route__c, id,firstname,lastname,email,Recommender_Company__c,title from contact where id=:req1.Recommendation_Contact__c];
                            con1.firstname=forname1;
                            con1.lastname=surname1;
                            con1.email=email1;
                            con1.Recommender_Company__c=comname1;
                            con1.title=position1;
                            con1.Do_Not_Route__c = true;
                            con1.recordtypeid = Referee_recordtype_id;
                            update con1;
                            // Method for Blank reference
                            if(email1!=oldemail1){
                                blankReference(req1.id);
                                SendEmailToRef(con1.firstname,con1.lastname,con1.email,user.contact.firstname,user.contact.lastname,req1.id);
                            }
                           } 
                        catch(exception e)
                        {
                            con1=new contact(
                            firstname=forname1,
                            lastname=surname1,
                            email=email1,
                            Recommender_Company__c=comname1,
                            title=position1,
                            Do_Not_Route__c = true,
                            recordtypeid = Referee_recordtype_id
                            );
                            insert con1;
                        SendEmailToRef(con1.firstname,con1.lastname,con1.email,user.contact.firstname,user.contact.lastname,req1.id);
                        }
                        req1.Recommendation_Contact__c=con1.id;
                        //req1.Supplied__c = true;
                        update req1;
                        opprec.Reference_Tab_Complete__c=true;
                        update opprec;
                        

                   } 
                catch(exception e)
                   { 
                       //ApexPages.addMessages(e);
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You must complete Program & Location tab before Reference Details tab'));
                       return null;
                   }
                
                // Code for Create Second reference contact---
              if(recList.size()>1)
               {
                    try{
                        req2=[select Supplied__c, id, Recommendation_Contact__c from requirement__c where id=:recList[1].id];
                        
                        // Code for create contact--
                        try{
                            con2=[select recordtypeid, Do_Not_Route__c, id,firstname,lastname,email,Recommender_Company__c,title from contact where id=:req2.Recommendation_Contact__c];
                            con2.firstname=forname2;
                            con2.lastname=surname2;
                            con2.email=email2;
                            con2.Recommender_Company__c=comname2;
                            con2.title=position2;
                            con2.Do_Not_Route__c = true;  
                            con2.recordtypeid = Referee_recordtype_id;                          
                            if(forname2.trim()!=''){
                                update con2;
                            if(email2!=oldemail2){
                                blankReference(req2.id);
                                SendEmailToRef(con2.firstname,con2.lastname,con2.email,user.contact.firstname,user.contact.lastname,req2.id);        
                                
                            }
                            }
                            else{
                                req2.Supplied__c = false;
                                update req2;
                                delete con2;                                
                            }
                            // Method for Blank reference
                            
                        } 
                        catch(exception e)
                        {
                            con2=new contact(
                            firstname=forname2,
                            lastname=surname2,
                            email=email2,
                            Recommender_Company__c=comname2,
                            title=position2,
                            Do_Not_Route__c = true,
                            recordtypeid = Referee_recordtype_id
                            );
                            if(forname2.trim()!=''){
                                insert con2;
                                req2.Recommendation_Contact__c=con2.id;
                               // req2.Supplied__c = true;
                                update req2;
                            SendEmailToRef(con2.firstname,con2.lastname,con2.email,user.contact.firstname,user.contact.lastname,req2.id);
                            }
                            
                        }
                    
                    opprec.Reference_Tab_Complete__c=true;
                    update opprec;
                        //SendEmailToRef(con2.firstname,con2.lastname,con2.email,user.contact.firstname,user.contact.lastname,req2.id);
                    } 
                    catch(exception e)
                    { 
                       ApexPages.addMessages(e);
                      // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You must complete Program & Location tab before Reference Details tab'));
                       return null;
                    }
               } 
            
            //return null;
            return page.ApplicantDocuments; 
            }
            return null;
    }

    public void SendEmailToRef(String rfistname,String rlastname,String remail,String firstname,String lastname,string reqid)
    {
       
        String encoded = EncodingUtil.urlEncode(remail, 'UTF-8'); 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSenderDisplayName('Hult Admissions');
        mail.setReplyTo('global.admissions@hult.edu');
        mail.setSubject('Reference for '+ firstname+' '+lastname);
        String msg='Dear '+rfistname+' '+rlastname+',<br/><br/>'; 
        

        msg += 'You have been nominated as a referee for the following application to Hult International Business School.</p>';
        msg += '<b>Applicant Name:</b> ' + firstname + ' ' + lastname +' </p>' ; 
        msg += 'The applicant has been advised that they should contact you directly to confirm this nomination. </p>Please click on the link below to go to the Online Referee Area and complete the form. </p>';
        msg += '<a href=\''+url+'ApplicationRecommendation?contactid='+reqid+'&c='+encoded+'\'>Click here to open the Reference Form</a><br /><br />'; 
        msg += 'Best wishes,<br />';
        msg += 'The Hult Admissions Team';
        String[] toAddresses = new String[] {remail};
        mail.setToAddresses(toAddresses);
        mail.setHtmlBody(msg);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
    }
  
  public PageReference emailSend(){
       //system.debug('Listsize********'+recList.size());
       if (saveandcontinue() == null){
           return null;
       }
       else 
       {
       List<requirement__c> recLists=[select id, Recommendation_Contact__r.id, Recommendation_Contact__r.firstname,Recommendation_Contact__r.lastname,Recommendation_Contact__r.email,Recommendation_Contact__r.Recommender_Company__c,Recommendation_Contact__r.Title, name from requirement__c where id=:System.currentPagereference().getParameters().get('mailrefID')];
       if(recLists.size()>0){
           SendEmailToRef(recLists[0].Recommendation_Contact__r.firstname,recLists[0].Recommendation_Contact__r.lastname,recLists[0].Recommendation_Contact__r.email,user.contact.firstname,user.contact.lastname,recLists[0].id);
       
       }
       /*if(recLists.size()>1 && recLists[1].contact__r.firstname!=null && recLists[1].contact__r.email!=null ){
           SendEmailToRef(recLists[1].contact__r.firstname,recLists[1].contact__r.lastname,recLists[1].contact__r.email,user.contact.firstname,user.contact.lastname,recLists[1].id);
       
       }*/
       getrefdata();
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.confirm,'Reference has been sent'));
       //return page.ApplicantReferenceDetail;
       return null;
       }
   
   }
   
   public void blankReference(String id){
       requirement__c blankReq=[select id
                                    , Recommendation_Background__c
                                    , Recommendation_SWOT__c
                                    , Recommendation_Level_Of_Planning__c
                                    , Recommendation_Stress_Management__c
                                    , Recommendation_Work_Experience__c
                                    , Recommendation_Personal_Motivation__c
                                    , Recommendation_Potential_For_Growth__c
                                    , Recommendation_Analytical_Ability__c
                                    , Recommendation_Comments__c
                                    , Recommendation_English_Ability__c   
                                 from requirement__c where id=:id limit 1];
                blankReq.Recommendation_Background__c = null;
                blankReq.Recommendation_SWOT__c = null;
                blankReq.Recommendation_Level_Of_Planning__c = null;
                blankReq.Recommendation_Stress_Management__c = null;
                blankReq.Recommendation_Work_Experience__c = null;
                blankReq.Recommendation_Personal_Motivation__c = null;
                blankReq.Recommendation_Potential_For_Growth__c = null;
                blankReq.Recommendation_Analytical_Ability__c = null;
                blankReq.Recommendation_Comments__c = null;
                blankReq.Recommendation_English_Ability__c  = null;  
                update blankReq;
   
   }
  
   public PageReference saveandcontinueandlogout() {
        if (saveandcontinue() == null)
            return null; // step3() returning null means there were errors, so drop back to the page.
        return new PageReference('/secur/logout.jsp');
    }
  public pagereference CheckReverencessaveandcontinue(){
      if(saveandcontinue() == null){
            return null;
      }
      else {      
      return page.AttachDocs;
      }
  
  }
 // Code for admin ----------- 
 public  pagereference sendemailfromAdmin(){
    if(!user.profile.name.contains('12.0 Hult Super User') && !user.profile.name.contains('3.0SU Hult Conversion Specialist') && !user.profile.name.contains('7.0SU Hult Product Manager') && !user.profile.name.contains('1.2SU Hult Recruiter')){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You are not authorized to resend the Recommendaton Email'));
        return null;    
    }
    
    try{
    string surl = ApexPages.currentPage().getHeaders().get('Host');
    if(surl.contains('cs9')){
        url ='http://hult-international-business-school.fullqc.cs9.force.com/portal/';
    }
    else{
        url='http://hult-international-business-school.force.com/portal/';
    }
    
    if(System.currentPagereference().getParameters().get('id')!=null){
         requirement__c re = [select id, Recommendation_Contact__r.firstname,Recommendation_Contact__r.lastname,Recommendation_Contact__r.email,Contact__r.firstname,Contact__r.lastname from requirement__c  where id=:System.currentPagereference().getParameters().get('id')];
             if(re.Recommendation_Contact__r.email!=null){
                 SendEmailToRef(re.Recommendation_Contact__r.firstname,re.Recommendation_Contact__r.lastname,re.Recommendation_Contact__r.email,re.Contact__r.firstname,re.Contact__r.lastname,re.id);
                 PageReference page = new PageReference('/' + re.id);     
                 page.setRedirect(true);
                 return page;
             }
             else{
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'No Recommendation has been given by applicant, So E-mail can not send.'));
                 return null;
             }
            
     }
     else{
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Invalid record'));
         return null;
     }
     }        
         
         catch(exception e){
             apexpages.addmessages(e);
             return null;
         }
 }
 
 public pagereference isBack(){
     PageReference page = new PageReference('/' + System.currentPagereference().getParameters().get('id'));     
     page.setRedirect(true);
     return page;
 }
 
 // end code fro admin------
}