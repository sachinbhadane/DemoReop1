//test method TestForApplicantMypageController
public class registrationLastloginController {
PageReference newPage;
User user;
public pagereference lastlogin()
{
user = [SELECT contact.Last_Log_In__c FROM User
WHERE id = :UserInfo.getUserId()];
user.contact.Last_Log_In__c=datetime.now();
update user.contact;
newPage = Page.registration2;
return newPage.setRedirect(true);
}

}