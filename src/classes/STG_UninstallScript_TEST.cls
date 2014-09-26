@isTest
public with sharing class STG_UninstallScript_TEST {

    public testmethod static void rununinstall() {
    	UTIL_CustomSettingsFacade.getContactsSettingsForTests(
		    new npe01__Contacts_and_Orgs_Settings__c (npe01__Account_Processor__c = CAO_Constants.HH_ACCOUNT_PROCESSOR));
		    
		UTIL_CustomSettingsFacade.getHouseholdsSettingsForTests(
		    new npo02__Households_Settings__c (npo02__Household_Rules__c = HH_Households.ALL_PROCESSOR));
  
    	//The scheduled jobs are being set when the settings page loads
    	STG_SettingsManager_CTRL ctrl = new STG_SettingsManager_CTRL(); 
    	ctrl.setTriggerSchedConfig();
    	
    	//Check jobs were scheduled
    	List<CronTrigger> scheduledJobs = [select Id, CronJobDetail.Id from CronTrigger 
           where CronJobDetail.Name IN :UTIL_MasterSchedulableHelper.scheduledJobs and CronJobDetail.JobType = '7'];
    	System.assertEquals(3, scheduledJobs.size());
    	
    	//Run uninstall script
    	Test.testUninstall(new STG_UninstallScript());
    	
    	//Confirm scheduled job was deleted
    	scheduledJobs = [select Id, CronJobDetail.Id from CronTrigger 
           where CronJobDetail.Name IN :UTIL_MasterSchedulableHelper.scheduledJobs  and CronJobDetail.JobType = '7'];
        System.assertEquals(0, scheduledJobs.size());
    }
}