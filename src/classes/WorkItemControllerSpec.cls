@isTest
private class WorkItemControllerSpec {

	@testSetup
	static void setup() {
		List<Contact> testContacts = new List<Contact>();
		List<Work_Item__c> testWorkItems = new List<Work_Item__c>();
		Date inRange = Date.today();
		Date outOfRange = Date.today().addDays(-31);


		testContacts.add(new Contact(FirstName='TestName1', LastName='TestLastName1', Email='test@test.com'));
		testContacts.add(new Contact(FirstName='TestName2', LastName='TestLastName2', Email='test@test.com'));

		insert testContacts;

		for(Integer i = 0; i < 50; i++) {
			Work_Item__c newIdeaOut = new Work_Item__c(Type__c='Idea', Title__c='TestIdea' + i, Assignee__c=testContacts[0].Id, Start_Date__c=outOfRange, Status__c='Ready');
			Work_Item__c newAction = new Work_Item__c(Type__c='Action', Title__c='TestAction' + i, Assignee__c=testContacts[0].Id, Start_Date__c=inRange, Status__c='Ready');
			Work_Item__c newIdea = new Work_Item__c(Type__c='Idea', Title__c='TestIdea' + 50 + i, Assignee__c=testContacts[1].Id, Start_Date__c=inRange, Status__c='Ready');
			Work_Item__c newActionOut = new Work_Item__c(Type__c='Action', Title__c='TestAction' + 50 + i, Assignee__c=testContacts[1].Id, Start_Date__c=outOfRange, Status__c='Ready');

			testWorkItems.add(newIdea);
			testWorkItems.add(newAction);
			testWorkItems.add(newIdeaOut);
			testWorkItems.add(newActionOut);
		}

		insert testWorkItems;

	}
	
	@isTest
	static void testGetWorkItemsWithRecordId() {
		Id recordId = [SELECT Id FROM Contact WHERE FirstName = 'TestName1' AND LastName = 'TestLastName1'].Id;
		List<Work_Item__c> response = WorkItemController.getWorkItems(recordId);

		System.assertEquals(50, response.size());

	}
	
	@isTest
	static void testGetWorkItemsWithoutRecordId() {
		List<Work_Item__c> response = WorkItemController.getWorkItems(null);

		System.assertEquals(100, response.size());
	}
	
}