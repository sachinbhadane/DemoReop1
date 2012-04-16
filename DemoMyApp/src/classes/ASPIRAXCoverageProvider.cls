@isTest private class ASPIRAXCoverageProvider{
private static testmethod void testGetters()
{
ASPIRAX.AspiraController controller = new ASPIRAX.AspiraController();
System.assert(controller.availableObjects.size() > 1, 'AvailableObjects list must contain more than one entry!');
System.assertEquals(1, controller.availableLookups.size(), 'availableLookups list must contain only one entry!');
System.assertEquals(1, controller.availableDispatchers.size(), 'availableDispatchers list must contain only one entry!');
System.debug('Is this a FREE EDITION: ' + (controller.isFreeEdition ? 'true' : 'false'));
System.debug('Is limit reached: ' + (controller.isLimitReached ? 'true' : 'false'));
controller.listener = 'User';
controller.lookupType = 'Incoming';
System.assert(controller.availableLookups.size() > 1, 'availableLookups list must contain more than one entry!');
controller.lookupField = controller.availableLookups.get(1).getValue();
System.assert(controller.lookupField != null && controller.lookupField != '', 'lookupField must not be empty!');
System.assert(!controller.availableDispatchers.isEmpty(), 'availableDispatchers list must contain more than one entry!');
controller.listener = controller.availableObjects.get(1).getValue();
controller.lookupType = 'Outgoing';
System.assert(controller.availableLookups.size() > 1, 'availableLookups list must contain more than one entry!');
controller.lookupField = controller.availableLookups.get(1).getValue();
System.assert(controller.lookupField != null && controller.lookupField != '', 'lookupField must not be empty!');
System.assert(!controller.availableDispatchers.isEmpty(), 'availableDispatchers list must contain more than one entry!');
}
private static testmethod void testAddRelationMethod()
{
System.debug('Creating new controller...');
ASPIRAX.AspiraController controller = new ASPIRAX.AspiraController();
controller.enterpriseURL = 'https://na7-api.salesforce.com/services/Soap/s/16.0';
controller.listener = 'User';
controller.lookupType = 'Outgoing';
controller.lookupField = 'ContactId';
controller.dispatcher = 'Contact';
controller.triggerName = 'Trigger' + String.valueOf(System.now().getTime());
System.debug('Adding a new relation...');
System.assertEquals(null, controller.addRelation(), 'addRelation method was supposed to return NULL!');
}
private static testmethod void testDeleteRelationMethod()
{
System.debug('Cleaning up relations...');
delete [select Id from ASPIRAX__Relation__c];
System.debug('Inserting a stub relation...');
insert buildRelation();
System.debug('Creating new controller...');
ASPIRAX.AspiraController controller = new ASPIRAX.AspiraController();
System.assertEquals(1, controller.getRelations().size(), 'There must be one relation!');
controller.relationToDelete = controller.getRelations().get(0).Id;
System.assertEquals(null, controller.deleteRelation(), 'deleteRelation method was supposed to return NULL!');
controller.invalidateData();
System.assertEquals(0, controller.getRelations().size(), 'Thre must be no relations!');
}
private static testmethod void testRerenderMethod()
{
System.debug('Creating new controller...');
ASPIRAX.AspiraController controller = new ASPIRAX.AspiraController();
System.assertEquals(null, controller.rerender(), 'rerender method was supposed to return NULL!');
}
private static testmethod void testAnyOfTriggersExistsMethod()
{
System.debug('Creating new controller...');
ASPIRAX.AspiraController controller = new ASPIRAX.AspiraController();
ASPIRAX__Relation__c relation = buildRelation();
relation.ASPIRAX__Trigger_Name__c = 'Relation';
System.assertEquals(true, controller.anyOfTriggersExists(new List<ASPIRAX__Relation__c>{relation}), 'anyOfTriggersExists method was supposed to find Relation trigger!');
}
private static ASPIRAX__Relation__c buildRelation()
{
return new ASPIRAX__Relation__c(
ASPIRAX__Listener__c = 'Account__c',
ASPIRAX__Lookup_Type__c = 'Outgoing',
ASPIRAX__Lookup_Field__c = 'LastModifiedBy',
ASPIRAX__Dispatcher__c = 'User',
ASPIRAX__Trigger_Name__c = 'Test' + String.valueOf(System.now().getTime()));
}
private static testmethod void testParseResponse()
{
String response = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="http://soap.sforce.com/2006/08/apex" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><compileAndTestResponse><result><classes><bodyCrc>2147483647</bodyCrc><column>-1</column><id>01p20000000TQZ2AAO</id><line>-1</line><name>SFDEVDeleteMePleaseTest</name><success>true</success></classes>'
+ '<runTestsResult>'
+ '<dmlInfo><column>3</column><line>22</line><numExecutions>1</numExecutions><time>0.0</time></dmlInfo>'
+ '</runTestsResult>'
+ '<problem xsi:nil="true"/>'
+ '<success>true</success><triggers><bodyCrc>2114550382</bodyCrc><column>-1</column><id>01q20000000TONtAAO</id><line>-1</line><name>DeleteMePlease</name><problem xsi:nil="true"/><success>true</success></triggers></result></compileAndTestResponse></soapenv:Body></soapenv:Envelope>';
ASPIRAX.AspiraController controller = new ASPIRAX.AspiraController();
controller.parseResponse(response, new List<ASPIRAX__Relation__c>{buildRelation()});
}
private static testmethod void testSortOptionsByLabel()
{
List<SelectOption> options = new List<SelectOption>{
new SelectOption('2', '2'),
new SelectOption('3', '1'),
new SelectOption('B', 'B'),
new SelectOption('C', 'A')
};
options = ASPIRAX.Utils.sortOptionsByLabel(options);
System.assertEquals(options.get(0).getLabel(), '1', 'Unable to sort options properly!');
System.assertEquals(options.get(2).getLabel(), 'A', 'Unable to sort options properly!');
}
private static testmethod void testListValuesFromField()
{
List<Account> accounts = new List<Account>{
new Account(Name = 'A'),
new Account(Name = 'B'),
new Account(Name = 'C')
};
System.assertEquals(new List<Object>{'A','B','C'}, ASPIRAX.Utils.listValuesFromField(accounts, 'Name'), 'Unable to list values from field!');
}
private static testmethod void testFetchApiPrefix()
{
String url = 'https://sfdev.na6.visual.force.com/services/Soap/c/16.0/00DA0000000HPHJ';
System.assertEquals('na6', ASPIRAX.Utils.fetchApiPrefix(url), 'Prefix mismatch!');
}
private testmethod static void testCriterion()
{
System.assertEquals(ASPIRAX.SOQL.eq('A', 'B').toSOQL(), 'A=\'B\'', 'Wrong ASPIRAX.SOQL generated!');
System.assertEquals(ASPIRAX.SOQL.ne('A', 'B').toSOQL(), 'A!=\'B\'', 'Wrong ASPIRAX.SOQL generated!');
System.assertEquals(ASPIRAX.SOQL.lt('A', 'B').toSOQL(), 'A<\'B\'', 'Wrong ASPIRAX.SOQL generated!');
System.assertEquals(ASPIRAX.SOQL.le('A', 'B').toSOQL(), 'A<=\'B\'', 'Wrong ASPIRAX.SOQL generated!');
System.assertEquals(ASPIRAX.SOQL.gt('A', 'B').toSOQL(), 'A>\'B\'', 'Wrong ASPIRAX.SOQL generated!');
System.assertEquals(ASPIRAX.SOQL.ge('A', 'B').toSOQL(), 'A>=\'B\'', 'Wrong ASPIRAX.SOQL generated!');
System.assertEquals(ASPIRAX.SOQL.match('A', 'B').toSOQL(), 'A LIKE \'B\'', 'Wrong ASPIRAX.SOQL generated!');
System.assertEquals(ASPIRAX.SOQL.oneOf('A', new List<Object>{'B'}).toSOQL(), 'A IN (\'B\')', 'Wrong ASPIRAX.SOQL generated!');
System.assertEquals(ASPIRAX.SOQL.noneOf('A', new List<Object>{'B'}).toSOQL(), 'A NOT IN (\'B\')', 'Wrong ASPIRAX.SOQL generated!');
System.assertEquals(ASPIRAX.SOQL.oneOf('A', new List<Id>{UserInfo.getUserId()}).toSOQL(), 'A IN (\'' + UserInfo.getUserId() + '\')', 'Wrong ASPIRAX.SOQL generated!');
System.assertEquals(ASPIRAX.SOQL.noneOf('A', new List<Id>{UserInfo.getUserId()}).toSOQL(), 'A NOT IN (\'' + UserInfo.getUserId() + '\')', 'Wrong ASPIRAX.SOQL generated!');
}
private testmethod static void testEscapeMethod()
{
System.assertEquals('NULL', ASPIRAX.SOQL.escape((Integer)null), 'Error when escaping a null!');
System.assertEquals('\'test\'', ASPIRAX.SOQL.escape('test'), 'Error when escaping a string!');
System.assertEquals('1024', ASPIRAX.SOQL.escape(1024), 'Error when escaping an integer!');
System.assertEquals('1024.4201', ASPIRAX.SOQL.escape(1024.4201), 'Error when escaping an double!');
System.assertEquals('TRUE', ASPIRAX.SOQL.escape(true), 'Error when escaping a boolean!');
System.assertEquals('FALSE', ASPIRAX.SOQL.escape(false), 'Error when escaping a boolean!');
System.assert(ASPIRAX.SOQL.escape(System.now()).length() > 0, 'Error when escaping a datetime!');
System.assert(ASPIRAX.SOQL.escape(System.today()).length() > 0, 'Error when escaping a datetime!');
System.assertEquals('NULL', ASPIRAX.SOQL.escape(new ASPIRAX.SOQL.Query()), 'Unknown objects suppose to escape to NULL');
System.assertEquals('=', ASPIRAX.SOQL.escape(ASPIRAX.SOQL.Operator.EQUAL), 'Unable to escape ASPIRAX.SOQL.Operator!');
System.assertEquals('!=', ASPIRAX.SOQL.escape(ASPIRAX.SOQL.Operator.NOT_EQUAL), 'Unable to escape ASPIRAX.SOQL.Operator!');
System.assertEquals('<', ASPIRAX.SOQL.escape(ASPIRAX.SOQL.Operator.LESS_THAN), 'Unable to escape ASPIRAX.SOQL.Operator!');
System.assertEquals('>', ASPIRAX.SOQL.escape(ASPIRAX.SOQL.Operator.GREATER_THAN), 'Unable to escape ASPIRAX.SOQL.Operator!');
System.assertEquals('<=', ASPIRAX.SOQL.escape(ASPIRAX.SOQL.Operator.LESS_OR_EQUAL), 'Unable to escape ASPIRAX.SOQL.Operator!');
System.assertEquals('>=', ASPIRAX.SOQL.escape(ASPIRAX.SOQL.Operator.GREATER_OR_EQUAL), 'Unable to escape ASPIRAX.SOQL.Operator!');
System.assertEquals(' IN ', ASPIRAX.SOQL.escape(ASPIRAX.SOQL.Operator.ONE_OF), 'Unable to escape ASPIRAX.SOQL.Operator!');
System.assertEquals(' NOT IN ', ASPIRAX.SOQL.escape(ASPIRAX.SOQL.Operator.NONE_OF), 'Unable to escape ASPIRAX.SOQL.Operator!');
System.assertEquals(' LIKE ', ASPIRAX.SOQL.escape(ASPIRAX.SOQL.Operator.LIKE_PATTERN), 'Unable to escape ASPIRAX.SOQL.Operator!');
System.assertEquals(' AND ', ASPIRAX.SOQL.escape(ASPIRAX.SOQL.Operator.LOGICAL_AND), 'Unable to escape ASPIRAX.SOQL.Operator!');
System.assertEquals(' OR ', ASPIRAX.SOQL.escape(ASPIRAX.SOQL.Operator.LOGICAL_OR), 'Unable to escape ASPIRAX.SOQL.Operator!');
}
private testmethod static void testQuery()
{
ASPIRAX.SOQL.Query query = new ASPIRAX.SOQL.Query();
query.use('User')
.include('Id')
.include(new List<String>{'Name', 'Id'})
.include('*')
.exclude('*')
.exclude('Name, Id')
.exclude(new List<String>{'Name', 'Id'})
.all()
.nolimit()
.orderASC(new List<String>{'Name'})
.orderDESC(new List<String>{'Name'})
.noorder()
.include('Name, Id')
.meet(ASPIRAX.SOQL.eq('Id', UserInfo.getUserId()))
.within(1)
.orderASC('Name')
.orderDESC('CreatedDate')
.joins(new ASPIRAX.SOQL.Query().use('DelegatedUsers'))
.lock()
.nolock();
List<User> users = Database.query(query.toSOQL());
System.assert(users.size() == 1, 'Query supposed to return a current user!');
}
}