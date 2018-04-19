@isTest
private class UpdateWorkItemDateTriggerSpec {
	
	@testSetup
	static void setup() {
		Contact testContact = new Contact(FirstName='TestName1', LastName='TestLastName1');
		insert testContact;
		Work_Item__c testWorkItem = new Work_Item__c(Type__c='Idea', Title__c='TestItem10', Status__c='New', Assignee__c=testContact.Id);
		insert testWorkItem;
	}

	@isTest 
	static void testNewToReady() {
		Work_Item__c testContact = [SELECT Status__c, Start_Date__c FROM Work_Item__c WHERE Title__c = 'TestItem10' LIMIT 1];
		Date testDate = Date.today();

		testContact.Status__c = 'Ready';
		
		Test.startTest();
		update testContact;
		Test.stopTest();

		testContact = [SELECT Start_Date__c FROM Work_Item__c WHERE Id = :testContact.Id];

		System.assertEquals(testDate, testContact.Start_Date__c);
	}
	
	@isTest
	static void testToDone() {
		Work_Item__c testContact = [SELECT Status__c, End_Date__c FROM Work_Item__c WHERE Title__c = 'TestItem10' LIMIT 1];
		Date testDate = Date.today();

		testContact.Status__c = 'Done';
		
		Test.startTest();
		update testContact;
		Test.stopTest();

		testContact = [SELECT End_Date__c FROM Work_Item__c WHERE Id = :testContact.Id];

		System.assertEquals(testDate, testContact.End_Date__c);
	}
	
}