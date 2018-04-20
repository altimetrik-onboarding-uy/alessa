trigger WorkItemAssigneeNotification on Work_Item__c (after insert) {
    Id templateId = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Assignee_Notification' LIMIT 1].Id;
    List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
    List<Id> assigneeIds = new List<Id>();

    for(Work_Item__c wi: Trigger.new) {
        assigneeIds.add(wi.Assignee__c);
    }

    Map<Id, Contact> assigneeMap = new Map<Id, Contact>([SELECT Email FROM Contact WHERE Id IN :assigneeIds]);
    
    for(Work_Item__c wi: Trigger.new) {
        Contact assignee = assigneeMap.get(wi.Assignee__c);

        if(assignee != null && assignee.Email != null) {
        	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(wi.Assignee__c);
            mail.setTemplateId(templateId);    
            mail.setWhatId(wi.Id);
            emailList.add(mail);
        }
    }
    
    Messaging.sendEmail(emailList);
}