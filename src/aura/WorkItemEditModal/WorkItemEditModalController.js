({
	close: function(component) {
		component.getEvent('closeWorkItemEdit').fire();
	},
	save: function(component) {
		component.find('edit').get('e.recordSave').fire();
	}
})