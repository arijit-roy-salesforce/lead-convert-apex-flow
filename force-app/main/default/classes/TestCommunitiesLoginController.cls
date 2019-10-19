@isTest(seeAllData = false)
public with sharing class TestCommunitiesLoginController {


    public static Account createAccount() {
        Account account = new Account(Name = 'Veteran Affairs');
        insert account;
        return account;
    }

    public static Contact createContact(Account account) {
        Contact con = new Contact();
        con.FirstName = 'Arijit';
        con.LastName = 'Roy';
        con.Email = 'aroy@acumensolutions.com';
        con.AccountId = account.Id;
        insert con;
        return con;
    }

    static testMethod void testCasse1(){
        
        Test.startTest();
        
        Account acc = new Account();
        acc.Name ='mecrin';
        acc.sic = '12345';
        insert acc;
        
        CommunitiesLoginController  tp = new CommunitiesLoginController ();
        tp.username ='mecrin';
        tp.password  ='12345';
        
        tp.login();

        
        Test.stopTest();
        
    }
}
