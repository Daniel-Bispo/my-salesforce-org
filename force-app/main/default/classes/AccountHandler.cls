public class AccountHandler {
    
    public static void updateContactsDescription(Map<Id,Account> accountNewMap){
        
        system.assert(trigger.isExecuting, 'Este código deve ser executado no contexto de trigger!' );
        
        //This queries all Contacts related to the incoming Account records in a single SOQL query.
        //This is also an example of how to use child relationships in SOQL
        List<Account> accountsWithContacts = [select id, name, (select id, salutation, description,
        firstname, lastname, email from Contacts)
        from Account where Id IN :accountNewMap.keySet()];

        List<Contact> contactsToUpdate = new List<Contact>{};
        // For loop to iterate through all the queried Account records
        for(Account a: accountsWithContacts){
            // Use the child relationships dot syntax to access the related Contacts
            for(Contact c: a.Contacts){
                System.debug('Contact Id[' + c.Id + '], FirstName[' + c.firstname + '], LastName[' + c.lastname +']');
                c.Description=c.salutation + ' ' + c.firstName + ' ' + c.lastname;
                contactsToUpdate.add(c);
            } 
        }

        //Now outside the FOR Loop, perform a single Update DML statement.
        update contactsToUpdate;
    }
}