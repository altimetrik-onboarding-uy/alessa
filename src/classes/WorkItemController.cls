public with sharing class WorkItemController {
	@AuraEnabled
	public static List<Work_Item__c> getWorkItems(Id recordId) {
		List<Work_Item__c> workItems;

		if(recordId != null) {
			workItems = [SELECT Id, Title__c, Difficulty_Level__c, Type__c, Status__c FROM Work_Item__c WHERE Assignee__r.Id = :recordId];
		} else {
			workItems = [SELECT Id, Title__c, Difficulty_Level__c, Type__c, Status__c FROM Work_Item__c WHERE Start_Date__c = LAST_N_DAYS:30 OR Status__c = 'New'];
		}

		return workItems;
	}
}