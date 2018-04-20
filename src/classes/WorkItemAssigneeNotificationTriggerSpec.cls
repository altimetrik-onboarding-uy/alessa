@isTest
private class WorkItemAssigneeNotificationTriggerSpec {
	
	@isTest
	static void testSingleInsert() {
		Contact testContact = new Contact(FirstName='Test1', LastName='Test1', Email='test@test.com');
		insert testContact;
		Work_Item__c testWorkItem = new Work_Item__c(Type__c='Idea', Title__c='TestItem10', Status__c='New', Assignee__c=testContact.Id);
		
		Test.startTest();
		insert testWorkItem;
		System.assertEquals(1, Limits.getEmailInvocations());
		Test.stopTest();
	}

	@isTest
	static void testBulkInsert() {
		Contact testContact = new Contact(FirstName='Test1', LastName='Test1', Email='test@test.com');
		insert testContact;
		List<Work_Item__c> testWorkItems = new List<Work_Item__c>();

		for(Integer i = 0; i < 10; i++) {
			Work_Item__c wi = new Work_Item__c(Type__c='Idea', Title__c='TestItem' + i, Status__c='New', Assignee__c=testContact.Id);
			testWorkItems.add(wi);
		}

		Test.startTest();
		insert testWorkItems;
		System.assertEquals(1, Limits.getEmailInvocations());
		Test.stopTest();
	}
	
}