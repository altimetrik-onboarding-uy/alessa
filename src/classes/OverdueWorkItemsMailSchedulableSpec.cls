@isTest
private class OverdueWorkItemsMailSchedulableSpec {
	
	@isTest
	static void testSchedule() {
		OverdueWorkItemsTestFactory.generateTestData();

		System.assertEquals(0, [SELECT COUNT() FROM CronTrigger]);

		Test.startTest();
		System.schedule('testSchedule', '0 0 0 15 3 ? 2022', new OverdueWorkItemsMailSchedulable());
		Test.stopTest();

		System.assertEquals(1, [SELECT COUNT() FROM CronTrigger]);
	}
}