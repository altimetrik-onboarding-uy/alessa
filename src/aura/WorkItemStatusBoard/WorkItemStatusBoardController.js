({
	doInit: function(component, event, helper) {
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

		helper.updateList(component);
	},
	openModal: function(component, event) {
		component.set('v.editRecordId', event.getParam('recordId'));
		component.set('v.isEditMode', true);
	},
	closeModal: function(component) {
		component.set('v.isEditMode', false);
	},
	handleSaveSuccess: function(component, event, helper) {
		component.set('v.isEditMode', false);
		helper.updateList(component);
	}
})