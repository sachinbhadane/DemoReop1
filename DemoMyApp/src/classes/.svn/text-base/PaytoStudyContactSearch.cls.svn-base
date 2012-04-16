public class PaytoStudyContactSearch {
    public string name{get;set;}
    public string id{get;set;}
    public list<contact> contactList{get;set;}
    public list<contact> contactListnew{get;set;}
    public String query1{get;set;}
    public string query2;
    public List<Requirement__c> req;
    public set<id> conId = new set<id>();
    public map<id, attachment> attMap ;
    
    public PaytoStudyContactSearch(){
    }
    
    
    public void contactSearch(){
    
        if(name.trim()=='' && id.trim()==''){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter either Name or Student ID'));
             return;
        }
        query2 ='select firstname,lastname, id ,Student_ID__c,Web_Campaign_Source__c from contact where id!=\'\'' ;
        query1 ='';
        list<string> cc;        
        
        if(name!=null && name.trim()!=''){
        cc= name.split(' ');
        for(string c: cc){
            if(query1!=''){
                query1 +=' or firstname like \'%'+c+'%\' or lastname like \'%'+ c+'%\'';    
            }
            else{
                query1 +=' firstname like \'%'+c+'%\' or lastname like \'%'+ c+'%\'';    
            }
            
        }
       
        query1 =' and ('+ query1+')'; 
        }
        if(id!=null && id.trim()!=''){
        query1 +=' and Student_ID__c like \'%'+ id +'%\'';
        }
        if(name.trim()!='' || id.trim()!=''){
            try{
            contactList = database.query(query2 + query1 + ' limit 250' );
                for(contact cn : contactList){
                    conid.add(cn.id);
                }
            }
            catch(exception e){
                apexpages.addmessages(e);
            }
        }
     // get documents
     set<id> pID = new set<id>();
     attMap = new map<id, attachment>();
     map<id, Requirement__c> reqMap = new map<id, Requirement__c>();
     req= [select name, Opportunity__r.Contact__c, id from Requirement__c where Opportunity__r.Contact__c in :conId and name='Scan of current passport'];
     
     for(Requirement__c r : req){
         
         pID.add(r.id);
         reqMap.put(r.id,r);
     } 
     
     List<attachment> att =[select parentid, id from attachment where parentid in : pID];
     for(attachment a : att){
         attMap.put(reqMap.get(a.parentid).Opportunity__r.Contact__c,a) ;
     }
     
     // add contact to list
     contactListnew = new List<contact>(); 
       for(contact cnn : contactList){
           
           if(attMap.keyset().contains(cnn.id)){         
               cnn.Web_Campaign_Source__c = string.valueof(attMap.get(cnn.id).id);           
           }
           else{
               cnn.Web_Campaign_Source__c = '';           
           }
           contactListnew.add(cnn);
           
       }
        
    }
}