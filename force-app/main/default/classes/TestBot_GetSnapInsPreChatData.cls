@isTest(seeAllData = true)
public with sharing class TestBot_GetSnapInsPreChatData {
    
    static testMethod void TestBot_GetSnapInsPreChatData() {

        Account ac = new Account(name ='Acumen Solutions2') ;
        insert ac; 
       
        Contact con = new Contact(LastName ='Bethany',AccountId = ac.Id, FirstName = 'Arijit', Email='aroy@2acumensolutions.demo');
        insert con;  

        Profile p = [Select Id From Profile where Name = 'Customer Community Plus User'];
                  
        User user = new User(alias = 'test123', email='aroy@acumensolutions.demo',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p.Id, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
       
        insert user;

        System.runAs(user) {
            LiveChatVisitor visitor = new LiveChatVisitor();
            insert visitor;

            LiveChatTranscript chatTranscript = new LiveChatTranscript();
            chatTranscript.ContactId = con.Id;
            chatTranscript.ChatKey = '2263397381';
            chatTranscript.Username__c = user.Id;
            chatTranscript.LiveChatVisitorId = visitor.Id;
            insert chatTranscript;

            Bot_GetSnapInsPreChatData botcontroller = new Bot_GetSnapInsPreChatData();
            Bot_GetSnapInsPreChatData.PrechatInput prechat = new Bot_GetSnapInsPreChatData.PrechatInput();
            prechat.sChatKey = '2263397381';

            Bot_GetSnapInsPreChatData.getSnapInsPrechatData(new List<Bot_GetSnapInsPreChatData.PrechatInput> {prechat});
        }

        
    }
}
