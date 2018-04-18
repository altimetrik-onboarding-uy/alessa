({
	doInit: function(component, event, helper) {
		var action = component.get('c.getWorkItems');
		var listsMeta = {
			new: {
				text: 'New',
				icon: 'action:add_relationship'
			},
			ready: {
				text: 'Ready',
				icon: 'action:new_task'
			},
			inProgress: {
				text: 'In Progress',
				icon: 'action:fallback'
			},
			done: {
				text: 'Done',
				icon: 'action:approval'
			}
		}

		component.set('v.listsMeta', listsMeta);

		action.setCallback(this, function(response) {
			var state = response.getState();
			if(state === 'SUCCESS') {
				helper.setStatusLists(component, response.getReturnValue());
			} else {
				console.log('Failed with state: ' + state);
			}
		});

		$A.enqueueAction(action);
	},
	openEdit: function(component, event, helper) {
		console.log('ISEDITMODE', component.get('v.isEditMode'));
		component.set('v.editRecordId', event.getParam('recordId'));
		component.set('v.isEditMode', true);
	}
})