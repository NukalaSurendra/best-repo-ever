public with sharing class AccountBusinessObjectsUserContr{
    public boolean businessObjectsUserFlag{get;set;}
    public boolean alertFlag{get;set;}  
    public string CDSStrategicAccountControllerAlert{get;set;}

    public AccountBusinessObjectsUserContr(ApexPages.StandardController controller) {
        
        //User user = [SELECT FederationIdentifier,ProfileId,accountId,Business_Objects_User__c FROM User u WHERE u.username = :userinfo.getuserName() LIMIT 1];
        //Profile profile=[SELECT p.Name, p.Id FROM Profile p WHERE p.id = :user.ProfileId LIMIT 1];
        
        User user = [SELECT FederationIdentifier, Profile.Name, Business_Objects_User__c FROM User WHERE Id = :userinfo.getUserId() LIMIT 1];
        
        businessObjectsUserFlag = user.Business_Objects_User__c;
        
        if(user.FederationIdentifier == null) {
            businessObjectsUserFlag = false;
        }
        
        String profileString = System.Label.CDS_Strategic_Account_Field_Allowed_Profiles;
        List<String> allowdProfiles = profileString.split(';',0);
        
        //Account currentAccount = [SELECT CDS_Strategic_Account__c FROM Account WHERE Id = : controller.getId() LIMIT 1];  
        Account currentAccount = (Account)controller.getRecord();

        for(String profileName:allowdProfiles){
            if(currentAccount.CDS_Strategic_Account__c != null && profileName == user.profile.Name) {               
                CDSStrategicAccountControllerAlert =  currentAccount.CDS_Strategic_Account__c;
                alertFlag = true;
            }
        }
    }
}