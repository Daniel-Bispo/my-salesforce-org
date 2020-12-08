public class AsyncApex {
    
    @future
    public static void processAccount(Set<Id> accountId) {
        List<Contact> contacts = [select id, salutation, firstname, lastname, email
                                  from Contact where accountId = :accountId];
        
        for(Contact c: contacts){
            System.debug('Contact Id[' + c.Id + '], FirstName[' + c.firstname + '], LastName[' + c.lastname +']');
            c.Description=c.salutation + ' ' + c.firstName + ' ' + c.lastname;
        }
        update contacts;       
    }  
}