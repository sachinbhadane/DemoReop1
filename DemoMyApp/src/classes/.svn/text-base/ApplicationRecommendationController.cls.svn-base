Public without sharing  Class ApplicationRecommendationController
{
public static Contact user{get;set;}
public Requirement__c req{get;set;}
public String firstname{get;set;}
public string lastname{get;set;}
public string contactid{get;set;}
public string email{get;set;}
public Boolean submitted{get;set;}
public Boolean invaliduser{get;set;}
public string Primary_Program_Choice_c{get;set;}
public ApplicationRecommendationController(){
if(contactid==null){
contactid=System.currentPagereference().getParameters().get('contactid');
}
        
if(system.currentPagereference().getParameters().get('c')!=null){
email = EncodingUtil.urlDecode(system.currentPagereference().getParameters().get('c'), 'UTF-8');
}




        
          try{
              String query ='select Supplied__c, Opportunity__r.Primary_Program_Choice__c, Opportunity__r.contact__r.lastname, Opportunity__r.contact__r.firstname, Id,Contact__c,Program__c,Recommendation_Background__c,Recommendation_SWOT__c,Recommendation_Level_Of_Planning__c, Recommendation_Stress_Management__c,Recommendation_Work_Experience__c,Recommendation_Personal_Motivation__c,Recommendation_Potential_For_Growth__c,Recommendation_Analytical_Ability__c,Recommendation_Comments__c, Recommendation_English_Ability__c from Requirement__c where id=:contactid';              
              if (email!=null){
                  query +=  ' and Recommendation_Contact__r.email=\''+email+'\'';              
              }
          
        /*req=[select Opportunity__r.Primary_Program_Choice__c, Opportunity__r.contact__r.lastname, Opportunity__r.contact__r.firstname, Id,Contact__c,Program__c,Recommendation_Background__c,
                             Recommendation_SWOT__c,Recommendation_Level_Of_Planning__c,
                             Recommendation_Stress_Management__c,Recommendation_Work_Experience__c,
                             Recommendation_Personal_Motivation__c,Recommendation_Potential_For_Growth__c,
                             Recommendation_Analytical_Ability__c,Recommendation_Comments__c,
                             Recommendation_English_Ability__c          
          
          from Requirement__c where id=:contactid and Recommendation_Contact__r.email=:email];*/
          req = database.query(query);
          firstname=req.Opportunity__r.contact__r.firstname;
          lastname=req.Opportunity__r.contact__r.lastname;
          Primary_Program_Choice_c=req.Opportunity__r.Primary_Program_Choice__c;         
          if(req.Recommendation_Background__c!=null)
          {submitted=true;} else {submitted=false;}
         invaliduser=false;
            } catch(exception e){
           // ApexPages.addMessages(e);
            invaliduser=true;
            req=new Requirement__c();}
           

}



public pagereference saveandcontinue()
{
if((req.Recommendation_Background__c==null) || (req.Recommendation_Background__c.trim()==''))
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter \'How long have you know the applicant and in what context?\''));
            }
if((req.Recommendation_SWOT__c==null) || (req.Recommendation_SWOT__c.trim()==''))
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter \'What do you consider the Applicant\'s strength and weaknesses?\''));
            }
if((req.Recommendation_Level_Of_Planning__c==null) || (req.Recommendation_Level_Of_Planning__c.trim()==''))
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter \'In your opinion, how well thought out are the applicant\'s plans for postgraduatre study?\''));
            }
if((req.Recommendation_Stress_Management__c==null) ||(req.Recommendation_Stress_Management__c.trim()==''))
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter \'This program is very intensive and students often feel highly proessured. Do you think the Applicant will be successful under these conditions?\''));
            }
if(req.Recommendation_Work_Experience__c==null)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter \'1. Work experience related to general management\''));
            }
if(req.Recommendation_Personal_Motivation__c==null)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter \'2. Personal Motivation\''));
            }
if(req.Recommendation_Potential_For_Growth__c==null)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter \'3. Potential for Growth\''));
            }
if(req.Recommendation_Analytical_Ability__c==null)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter \'4. Analytical Ability\''));
            }
if((req.Recommendation_Comments__c==null) || (req.Recommendation_Comments__c.trim()==''))
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter \'Please comment on the Applicant as to relevant intellectual and administrative competence, Ability to work with others, capacity in oral expression, imagination and probable creativity and other personal qualities that you believe would be helpful to the Admissions Committee in considering this individuals\'s application.\''));
            }  
if((req.Recommendation_English_Ability__c==null) || (req.Recommendation_English_Ability__c.trim()==''))
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter \'Please provide your appraisal of the Applicant\'s ability to read, write, understand, and speak English.\''));
            }                                                                                                                      
if(!apexpages.hasmessages()) 
            {

try{     
req.Supplied__c = true;                   
update req;
}
catch(dmlexception e){
 ApexPages.addMessages(e);
return null;
}

PageReference page = System.Page.ApplicationRecommendation;
Page.getParameters().put('contactid',System.currentPagereference().getParameters().get('contactid'));
Page.getParameters().put('c',System.currentPagereference().getParameters().get('c'));
page.setRedirect(true);
return page;
}
else
{
return null;
}
}
   
}