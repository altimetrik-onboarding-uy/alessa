trigger UpdateWorkItemDate on Work_Item__c (before update) {
    for(Work_Item__c wi: Trigger.new) {
        Work_Item__c wiOld = Trigger.oldMap.get(wi.Id);
        Boolean isNewToReady = wiOld.Status__c.equals('New') && wi.Status__c.equals('Ready');
        Boolean isSetToDone = !wiOld.Status__c.equals('Done') && wi.Status__c.equals('Done');
        
        if(isNewToReady) {
            wi.Start_Date__c = Date.today();
        } else if(isSetToDone) {
            wi.End_Date__c = Date.today();
        }
    }
}