public class ApplicantaccountDetails {
    public Opportunity opp;
    public datetime Application_Fee_Date_Time_c{get;set;}
    public date Confirmation_Deadline_c{get;set;}
    public User user{get;set;}
    public string msg{get;set;}
    public boolean isappFee{get;set;}
    public date CDeppaiddate{get;set;}
    public boolean cfee{get;set;}
    public string msgPhone{get;set;}
    public ApplicantaccountDetails()
    {
        user = [SELECT contact.firstname,contact.lastname, contact.Last_Log_In__c FROM User
        WHERE id = :UserInfo.getUserId()];
        msgPhone = '';
       
            try{
             opp=[select Program__r.name
                        , Start_Term__c 
                        ,  Confirmation_Deadline__c
                        , Owner.name
                        , Owner.email 
                        , owner.phone
                        , StageName
                        , Application_Substage__c
                        , Final_Submission_Tab_Complete__c
                        , Application_Fee_Date_Time__c 
                        , Primary_Campus__c
                   from Opportunity where contact__c=:user.contact.id limit 1];                   
                Application_Fee_Date_Time_c = opp.Application_Fee_Date_Time__c;
                Confirmation_Deadline_c = opp.Confirmation_Deadline__c;
                
                // method for get Confirmation deposit paid date
                ConfirmationDepositpaiddate();
                
                // Method for welcome messages
                welcomeMessage(opp.StageName, opp.Application_Substage__c);                
                
                if(Application_Fee_Date_Time_c!=null){
                    isappFee =true;
                }
                 
                
            } 
            catch (exception e){
                
            }     
       
        
    }
    
    public void ConfirmationDepositpaiddate(){
        try{            
            CDeppaiddate = [select Deposit_Date_Paid__c from Opportunity_Finance__c where Opportunity__c=:opp.id].Deposit_Date_Paid__c;            
            if(CDeppaiddate!=null)
            cfee = true;
        }
        catch(exception e){
        // Need to create Finance record
        //apexpages.addmessages(e);
        
            cfee = false;
            CDeppaiddate = null;
        }
       
    }
    
    public void welcomeMessage(String stage, String Substage){
        String cdate='';
        if (opp.Confirmation_Deadline__c!=null){
            cdate = opp.Confirmation_Deadline__c.day()+'-'+opp.Confirmation_Deadline__c.month()+'-'+opp.Confirmation_Deadline__c.year();
        }
        String msg1='';
        msg='';
        msg='Dear '+ user.contact.firstname +' '+ user.contact.lastname +',<br /><br />'; 
        if(stage=='Partial Application' && (Substage=='Completed Application' || Substage =='Working to Complete App' || Substage=='Pending Test(s)' || Substage=='Not Completing App' || Substage=='Not Set')){            
            msg += 'Congratulations on taking the first step towards becoming part of the world’s most international business school. Our Admissions support team will review your application and let you know if there is any additional information we require before submitting your application for review by our Admissions Committee.  <br /><br />Please feel free to contact me for further questions.'; 
            msg += '<br /><br />Best,';
        }
      
        else if(stage=='Accepted' && Substage=='Notified' && CDeppaiddate==null){            
            msg += 'Congratulations!  You’ve been accepted to become part of the world’s most international business school!';
            msg += '<br /><br />You will find a pdf version of your Acceptance letter in the Admissions tab at the top of this page. You will also receive Hult\'s official Acceptance Pack shortly, which contains useful information about your program, electives, campus city, and life at Hult.';
            msg += '<br /><br />Your seat for class beginning in '+opp.Primary_Campus__c+' will be reserved until no later than '+cdate+'.  Seats are filling up quickly, so to avoid disappointment you are advised to secure your place as soon as possible by paying your confirmation fee.';
            msg += '<br /><br />Please feel free to contact me for further questions.';
            msg += '<br /><br />Congratulations again!';
            
            /*if(opp.Program__r.name!='Bachelor of International Business Administration-UK-London'){
                msg1='Please be sure to upload your test confirmation booking (test date and location for GMAT/TOEFL, etc. tests, if you have not already done so already.<br /><br />'; 
            }*/
        }
        
        else if(stage=='Accepted' && Substage=='Notified' && CDeppaiddate!=null){            
            msg += 'Need Message<br />';
            msg += '<br /><br />Congratulations again!';            
         
        }
       
        else if(stage=='Admissions Endorsed' && Substage=='Notified'){
            msg += 'Congratulations!  Your candidacy to become part of the world’s most international business school can be advanced if you submit your missing documents on a timely basis.  These documents are listed on your Acceptance Letter.<br /><br />';
            msg += 'You will find a pdf version of your Acceptance letter in the Admissions tab at the top of this page.  You will also receive Hult’s official Acceptance Pack shortly, which contains useful information about your program, electives, campus city, and life at Hult.<br /><br />';
            msg += 'Please be sure to upload your test confirmation booking (test date and location) for your missing tests (ie.GMAT/TOEFL) if you have not done so already.  This can be done in the Exam tab, located at the top of the page.<br /><br />';
            msg += 'Your seat for class beginning in '+opp.Primary_Campus__c+' will be reserved until no later than '+cdate+'.  Seats are filling up quickly, so to avoid disappointment you are advised to secure your place as soon as possible by paying your confirmation fee.';
            msg += '<br /><br />Please feel free to contact me for further questions.';
            msg += '<br /><br />Congratulations again!';   
        }
        
        else if(stage=='Conditionally Accepted' && Substage=='Notified'){
            msg += 'Congratulations, you’ve been conditionally accepted to become part of the world’s most international business school!<br /><br />'; 
            msg += 'As a condition of your acceptance, you are required to submit on, or prior to, your arrival on campus, the missing original or notarized copies of the documents listed on your acceptance letter.<br /><br />';
            msg += 'You will find a pdf version of your Acceptance letter in the Admissions tab at the top of this page.  You will also receive Hult’s official Acceptance Pack shortly, which contains useful information about your program, electives, campus city, and life at Hult.<br /><br />';
            msg += 'Your seat for class beginning in '+opp.Primary_Campus__c+' will be reserved until no later than '+cdate+'.  Seats are filling up quickly, so to avoid disappointment you are advised to secure your place as soon as possible by paying your confirmation fee.';
            msg += '<br /><br />Please feel free to contact me for further questions.';
            msg += '<br /><br />Congratulations again!';        
        }
        
        else if((stage=='Conditionally Accepted' || stage=='Admissions Endorsed' || stage=='Accepted') && (Substage=='Pending Interview' || Substage=='Interviewed')){            
            msg += 'Congratulations on taking the first step towards becoming part of the world’s most international business school. Our Admissions support team will review your application and let you know if there is any additional information we require before submitting your application for review by our Admissions Committee.  <br /><br />Please feel free to contact me for further questions.';
            msg += '<br /><br />Best,';
        }
        
        else if(stage=='Enrolled'){
            msg += 'Congratulations on your enrolment to the world’s most international business school! I hope you enjoy your time at Hult.  <br /><br />Please feel free to contact me if you have any questions or need assistance.';
            msg += '<br /><br />Best,' ;
        }

        else if(stage=='Confirmed'){
            msg += 'Congratulations on your decision to become part of the world’s most international business school!  A place has now been reserved for you at Hult’s ';
            msg += opp.Primary_Campus__c + ' campus.';
            msg += '<br /><br />Our Student Services team and campus staff are looking forward to having you on board and will be contacting you shortly to ensure that your move to ' + opp.Primary_Campus__c + ' is a smooth and enjoyable experience. If you have any questions in the meantime, please feel free to contact me.';      
            msg += '<br /><br />Congratulations again!';        
        }

        else if(stage=='Conditionally Confirmed'){
            msg += 'Congratulations on your decision to become part of the world’s most international business school!  A place has now been reserved for you at Hult’s ';
            msg += opp.Primary_Campus__c + ' campus.';
            msg += '<br /><br />Our Student Services team and campus staff are looking forward to having you on board and will be contacting you shortly to ensure that your move to  '+opp.Primary_Campus__c+'  is a smooth and enjoyable experience. ';      
            msg += '<br /><br />If you haven’t already done so, please remember that, as a condition of your acceptance, you are required to submit on, or prior to, your arrival on campus, the missing original or notarized copies of the documents listed on your acceptance letter.';  
            msg += '<br /><br />If you have any questions in the meantime, please feel free to contact me.';        
            msg += '<br /><br />Congratulations again!';        
        }

        else if(stage=='Admissions Endorsed Confirmed'){
            msg += 'Congratulations on your decision to become part of the world’s most international business school!  A place has now been reserved for you at Hult’s ';
            msg += opp.Primary_Campus__c + ' campus.';
            msg += '<br /><br />Our Student Services team and campus staff are looking forward to having you on board and will be contacting you shortly to ensure that your move to '+opp.Primary_Campus__c+' is a smooth and enjoyable experience.';      
            msg += '<br /><br />If you haven’t already, please be sure to upload your test confirmation booking (test date and location) for your missing tests (ie.GMAT/TOEFL).  This can be done in the Exam Information tab, located at the top of the page.';        
            msg += '<br /><br />If you have any questions in the meantime, please feel free to contact me.';        
            msg += '<br /><br />Congratulations again!';        
        }
        else if(stage=='Waitlisted Confirmed'){            
            msg +='Congratulations on your decision to become part of the world’s most international business school!  We have now put you on the waitlist for a seat at Hult\'s '+opp.Primary_Campus__c+' campus.';
            msg +='<br /><br />I will be in touch with you as soon as a place becomes available in '+opp.Primary_Campus__c+'. Until then, if you’d like to confirm your seat for a different campus or have any further questions, please feel free to contact me.';
            msg += '<br /><br />Congratulations again!'; 
        }
        
        else if(stage=='Withdrawn'){            
            msg +='Your application for Hult International Business School '+opp.Start_Term__c+' intake for '+opp.Program__r.name+' has been withdrawn from our system.'; 
            msg +='<br />If you wish for your application to be re-considered for this year’s incoming class, please contact me as soon as possible.';            
            msg += '<br /><br />Best of luck in your future endeavors.'; 
            msg += '<br /><br />Sincerely,<br />';
            msgPhone = opp.Owner.phone+'<br />';
        }
        
        else {
                // Default Message
//            msg += 'Congratulations on your enrolment to the world’s most international business school! I hope you enjoy your time at Hult.  <br /><br />Please feel free to contact me if you have any questions or need assistance.';
              msg += 'Congratulations on taking the first step towards becoming part of the world’s most international business school. Our Admissions support team will review your application and let you know if there is any additional information we require before submitting your application for review by our Admissions Committee.  Please feel free to contact me for further questions.';

            msg += '<br /><br />Best,';
        }
        
        msg += '<br />';             
        /*if(msg1!=''){
            msg += msg1;
        }*/
        
        msg += opp.Owner.name+'<br />';
        msg += opp.Owner.email+'<br />';
        msg += msgPhone;
        msg +='<a target=\'blank\' href=\'http://www.hult.edu/en/Contact-Us/Admissions-Offices/\'>http://www.hult.edu/en/Contact-Us/Admissions-Offices/</a><br /><br />';
     
    }
    
    public boolean getisCDeadline(){
        if(Confirmation_Deadline_c!=null){
                if((opp.StageName=='Conditionally Accepted' || opp.StageName=='Admissions Endorsed' || opp.StageName=='Accepted') && (opp.Application_Substage__c=='Notified')){            
                    return true;
                }
                else{
                    return false;
                }
        }
        else{
            return false;
        }
    }

}