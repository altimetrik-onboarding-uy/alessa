({
	setStatusLists : function(component, itemList) {
		var newList = [];
		var readyList = [];
		var inProgressList = [];
		var doneList = [];

		itemList.forEach(function(item) {
			switch(item.Status__c) {
				case 'New':
					newList.push(item);
					break;
				case 'Ready':
					readyList.push(item);
					break;
				case 'In Progress':
					inProgressList.push(item);
					break;
				case 'Done':
					doneList.push(item);
					break;
			}
		});

		component.set('v.newList', newList);
		component.set('v.readyList', readyList);
		component.set('v.inProgressList', inProgressList);
		component.set('v.doneList', doneList);
	},
	updateList: function(component) {
		var action = component.get('c.getWorkItems');
		
		action.setCallback(this, function(response) {
			var state = response.getState();
			if(state === 'SUCCESS') {
				this.setStatusLists(component, response.getReturnValue());
			} else {
				console.log('Failed with state: ' + state);
			}
		});

		$A.enqueueAction(action);
	}
})