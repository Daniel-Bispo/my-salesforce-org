@isTest
public class SampleTestMethodCls {
	   static testMethod void testAccountTrigger(){
        
        //First, prepare 200 contacts for the test data
        Account acct = new Account(name='test account');
        insert acct;
        
        Contact[] contactsToCreate = new Contact[]{};
        for(Integer x=0; x<200;x++){
             Contact ct = new Contact(AccountId=acct.Id,lastname='test');
             contactsToCreate.add(ct);
        }
        
        //Now insert data causing an contact trigger to fire.
        Test.startTest();
        	insert contactsToCreate;
        Test.stopTest(); 
    }
}