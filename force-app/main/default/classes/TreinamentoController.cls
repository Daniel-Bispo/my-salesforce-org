public with sharing class TreinamentoController {

    public List<Account> accountLst{get;set;}
    public String searchAccountName{get;set;}

    public TreinamentoController() {
       this.accountLst = [SELECT Id, Name, ShippingAddress, BillingAddress, CNPJ__c FROM Account];
        
    }

    public void search(){
        String searchText = '%' + searchAccountName + '%';
        this.accountLst = [SELECT Id, Name, ShippingAddress, BillingAddress, CNPJ__c FROM Account WHERE Name LIKE :searchText];
    }
}