@isTest
private class OverdueWorkItemsMailBatchSpec {
	
	@testSetup
	static void setup() {
		List<Work_Item__c> workItems = new List<Work_Item__c>();
		Contact testContact = new Contact(FirstName='TestName1', LastName='TestLastName1');
		Date prevMonth = Date.today().addMonths(-1);
		Date nextMonth = Date.today().addMonths(1);

		insert testContact;

		for (Integer i = 0; i < 200; i++) {
			Work_Item__c overdueWorkItem = new Work_Item__c(Type__c='Idea', Title__c='Overdue' + i, Status__c='Ready', Assignee__c=testContact.Id, Estimated_End_Date__c=prevMonth);
			Work_Item__c workItem = new Work_Item__c(Type__c='Idea', Title__c='Not Overdue' + i, Status__c='Ready', Assignee__c=testContact.Id, Estimated_End_Date__c=nextMonth);
			workItems.add(overdueWorkItem);
			workItems.add(workItem);
		}

		insert workItems;
	}

	@isTest
	static void testBatch() {
		Test.startTest();
		OverdueWorkItemsMailBatch batch = new OverdueWorkItemsMailBatch();
		DataBase.executeBatch(batch);
		Test.stopTest();

		System.assertEquals(200, OverdueWorkItemsMailBatch.testCount);
		System.assertEquals(1, OverdueWorkItemsMailBatch.emailLimits);
	}
}