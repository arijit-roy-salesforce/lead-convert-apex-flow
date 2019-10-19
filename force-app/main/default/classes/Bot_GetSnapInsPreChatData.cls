public without sharing class Bot_GetSnapInsPreChatData {
    public class PrechatOutput{
        @InvocableVariable
        public String sFirstName;
        @InvocableVariable
        public String sLastName;
        @InvocableVariable
        public String sEmail;
        @InvocableVariable
        public String sContactID;
        @InvocableVariable
        public String sLoggedUser;
    }
    public class PrechatInput{
        @InvocableVariable
        public String sChatKey;
    }
    @InvocableMethod(label='Get SnapIns Prechat Data')
    public static List<PrechatOutput> getSnapInsPrechatData(List<PrechatInput> inputParameters)
    {
        System.debug('######## Input Parameters: '+inputParameters);
          
        String sChatKey = inputParameters[0].sChatKey;
        String sContactId = null;
        List<prechatoutput> outputParameters = new List<prechatoutput>();
        PrechatOutput outputParameter = new PrechatOutput();
        if (sChatKey != null && sChatKey != '')
        {
            List<LiveChatTranscript> transcripts = [SELECT Id, CaseId,
                                                    ContactId, Username__c
                                                    FROM LiveChatTranscript WHERE ChatKey = :sChatKey];
            if (transcripts.size()>0)
            {
                sContactId = transcripts[0].ContactId;
                outputParameter.sLoggedUser = transcripts[0].Username__c;
            }
        }
          
        if (sContactId != null && sContactId != '')
        {
            List<Contact> contacts = [SELECT Id, FirstName, LastName, Email, Username__c
                                      FROM Contact WHERE Id = :sContactId];
            if (contacts.size()>0)
            {
                outputParameter.sFirstName = contacts[0].FirstName;
                outputParameter.sLastName = contacts[0].LastName;
                outputParameter.sEmail = contacts[0].Email;
                outputParameter.sContactId = contacts[0].Id;
            }
        }
        outputParameters.add(outputParameter);
        return outputParameters;
    }
}