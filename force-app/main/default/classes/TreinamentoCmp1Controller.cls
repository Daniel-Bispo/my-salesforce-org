public with sharing class TreinamentoCmp1Controller {
    @AuraEnabled
    public static Account getAccount(String id){
        return [SELECT Name, CNPJ__c     FROM Account WHERE id = :id];
    }
}