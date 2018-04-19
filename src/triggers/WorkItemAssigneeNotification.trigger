trigger WorkItemAssigneeNotification on Work_Item__c (after insert) {
    Id templateId = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Assignee_Notification' LIMIT 1].Id;
    List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
    
    for(Work_Item__c wi: Trigger.new) {
        if(wi.Assignee__c != null && wi.Assignee__r.Email != null) {
        	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(wi.Assignee__c);
            mail.setTemplateId(templateId);    
            mail.setWhatId(wi.Id);
            emailList.add(mail);
        }
    }
    
    Messaging.sendEmail(emailList);
}