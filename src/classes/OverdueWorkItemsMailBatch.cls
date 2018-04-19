global class OverdueWorkItemsMailBatch implements Database.Batchable<sObject>, Database.Stateful {
	
	global Integer overdueCount = 0;
	
	global Iterable<sObject> start(Database.BatchableContext bc) {
		Date today = Date.today();

		return [SELECT Id FROM Work_Item__c WHERE Status__c <> 'Done' AND Estimated_End_Date__c < :today];
	}

   	global void execute(Database.BatchableContext bc, List<Work_Item__c> scope) {
		overdueCount += scope.size();
	}
	
	global void finish(Database.BatchableContext bc) {
		List<String> addresses = new List<String>();
		List<User> admins = [SELECT Email FROM User WHERE Profile.Name = 'System Administrator'];
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		String mailBody = overdueCount == 0 ? 'There are no overdue items' : (overdueCount == 1 ? 'There is 1 overdue item' : 'There are ' + overdueCount + 'overdue items');

		mail.setSubject('Overdue items daily notification');
		mail.setPlainTextBody(mailBody);

		for(User u: admins) {
			addresses.add(u.Email);
		}

		mail.setToAddresses(addresses);
		Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
	}
	
}