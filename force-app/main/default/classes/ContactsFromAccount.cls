public class ContactsFromAccount {
    //public static List<Contact> getContacts(String name){
    //    Account acct = [SELECT Id FROM Account WHERE Name = :name];
    //    List<Contact> contactsLst = [SELECT Name FROM Contact WHERE AccountId = :acct.id];
    //    return contactsLst;
    //} 
    
    public static List<Contact> getContacts(String accountName){
        return [SELECT Name FROM Contact WHERE Account.name = :accountName];
    } 
}