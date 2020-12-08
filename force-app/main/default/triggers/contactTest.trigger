trigger contactTest on Contact (before insert, before update) {
    
    Set<Id> accountIds = new Set<Id>();
    for(Contact ct: Trigger.new)
        accountIds.add(ct.AccountId);
    
    //Do SOQL Query    
    Map<Id, Account> accounts = new Map<Id, Account>(
        [select id, name, billingState from Account where id in :accountIds]);
    
    for(Contact ct: Trigger.new){
        if(accounts.get(ct.AccountId).BillingState=='CA'){
            System.debug('found a contact related to an account in california...');
            ct.email = 'test_email@testing.com';
            //Apply more logic here....
        }
    }        
}