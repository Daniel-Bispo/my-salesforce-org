trigger accountTestTrggr on Account (after insert, after update) {
    asyncApex.processAccount(Trigger.newMap.keySet());   
}