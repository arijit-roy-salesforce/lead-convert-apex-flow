@isTest(seeAllData = true)
public with sharing class TestBot_PreChatCmpCtrl {
    static testMethod void testCase1() {
        Account ac = new Account(name ='Acumen Solutions Test') ;
        insert ac; 
       
        Contact con = new Contact(LastName ='Bethanbu',AccountId = ac.Id, FirstName = 'Franc', Email='franc@acumensolutions.demo');
        insert con;  

        Profile p = [Select Id From Profile where Name = 'Customer Community Plus User'];
                  
        User user = new User(alias = 'test123', email='aroy@acumensolutions.demo',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p.Id, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
       
        insert user;
        System.runAs(user) {
            Bot_PreChatCmpCnt.getCurrentUser();
        }
        
    }
}
