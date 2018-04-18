({
	doInit : function(component, event, helper) {
		var item = component.get('v.workItem');
		var iconName = '';
		
		switch(item.Type__c) {
			case 'Idea':
				iconName = 'standard:solution';
				break;
			case 'Action':
				iconName = 'standard:connected_apps';
				break;
			case 'Fix':
				iconName = 'standard:maintenance_plan';
				break;
		}

		component.set('v.iconName', iconName);
	},
	openEdit: function(component, event, helper) {
		var event = $A.get('e.force:editRecord');
		event.setParams({
			'recordId': component.get('v.workItem.Id')
		});
		event.fire();
	},
	handleSave: function(component, event, helper) {
		console.log('dalebooo1');
	}
})