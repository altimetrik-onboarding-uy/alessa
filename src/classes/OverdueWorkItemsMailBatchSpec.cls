@isTest
private class OverdueWorkItemsMailBatchSpec {

	@isTest
	static void testBatch() {
		OverdueWorkItemsTestFactory.generateTestData();

		Test.startTest();
		OverdueWorkItemsMailBatch batch = new OverdueWorkItemsMailBatch();
		DataBase.executeBatch(batch);
		Test.stopTest();

		System.assertEquals(200, OverdueWorkItemsMailBatch.testCount);
		System.assertEquals(1, OverdueWorkItemsMailBatch.emailLimits);
	}
}