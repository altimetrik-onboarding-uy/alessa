({
	getTypeIcon : function(component, event, helper) {
		var workItem = component.get('v.workItem');
		console.log(workItem.Title__c);
		console.log(workItem.Type__c);
		console.log(workItem.Difficulty_Level__c);
		return 'action:check';
	}
})