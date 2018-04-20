@isTest
private class WorkItemAssigneeNotificationTriggerSpec {
	
	@isTest
	static void testTrigger() {
		Contact testContact = new Contact(FirstName='Test1', LastName='Test1', Email='test@test.com');
		insert testContact;
		Work_Item__c testWorkItem = new Work_Item__c(Type__c='Idea', Title__c='TestItem10', Status__c='New', Assignee__c=testContact.Id);
		
		Test.startTest();
		insert testWorkItem;
		System.assertEquals(1, Limits.getEmailInvocations());
		Test.stopTest();

	}
	
}