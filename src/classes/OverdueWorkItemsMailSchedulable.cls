global class OverdueWorkItemsMailSchedulable implements Schedulable {
	global void execute(SchedulableContext sc) {
		OverdueWorkItemsMailBatch b = new OverdueWorkItemsMailBatch();
		database.executebatch(b);
	}
}