public class Treinamento {
  
	@future
    public static void teste() {
        system.debug('getQueries ' + Limits.getQueries());
        system.debug('getLimitQueries ' + Limits.getLimitQueries());
        
        List<City__c> cidLst = [SELECT Id, Name FROM City__c limit 1];
        
        system.debug('getQueries ' + Limits.getQueries());
        system.debug('getLimitQueries ' + Limits.getLimitQueries());    
    }
}