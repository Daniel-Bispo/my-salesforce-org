global with sharing class MySOAPWebService {
    webservice static Account getRecord(String id) {
        return [SELECT Id, Name FROM Account WHERE Id = :id];
    }
}