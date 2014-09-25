@isTest
public with sharing class UTIL_Typeahead_TEST {

    private static testMethod void testQuery() {
    	UTIL_CustomSettingsFacade.getContactsSettingsForTests(
            new npe01__Contacts_and_Orgs_Settings__c (npe01__Account_Processor__c = CAO_Constants.HH_ACCOUNT_PROCESSOR));
    
        UTIL_CustomSettingsFacade.getHouseholdsSettingsForTests(
            new npo02__Households_Settings__c (npo02__Household_Rules__c = HH_Households.ALL_PROCESSOR));
  
	    list<Account> aa = new list<Account>{
	      new Account(Name='Test Account'),
	      new Account(Name='Another Account', BillingCity='Test City'),
	      new Account(Name='Third Account')
	    };
	    insert aa;
	    
	      // crazy, but you have to fake this
	      list<Id> fixedSearchResults= new list<Id>{aa[0].id, aa[1].id};
	      Test.setFixedSearchResults(fixedSearchResults);
	
	    Test.startTest();
	    list<sObject> accts = UTIL_Typeahead.searchRecords( 'test', 'Account', null, null, null, null, null );
	    Test.stopTest();
	
	    system.assertEquals(2, accts.size());
	    system.assertEquals('Another Account', accts[0].get('Name'));
	    system.assertEquals('Test Account', accts[1].get('Name'));
    }
}