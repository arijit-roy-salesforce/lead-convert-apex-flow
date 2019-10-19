global class LeadConvertController {
    
    @InvocableMethod(label='Lead Convert')
    global static void convertLead(List<ConvertLeadActionRequest> ActionRequests) {
        
        for(ConvertLeadActionRequest lca : ActionRequests) {
            convertLead(lca);
        }
    }

    public static ConvertLeadActionResult convertLead(ConvertLeadActionRequest request) {
    Database.LeadConvert lc = new Database.LeadConvert();
    lc.setLeadId(request.leadId);
    lc.setConvertedStatus(request.convertedStatus);

    if (request.accountId != null) {
        lc.setAccountId(request.accountId);
    }

    if (request.contactId != null) {
      lc.setContactId(request.contactId);
    }

    // if (request.overWriteLeadSource != null && request.overWriteLeadSource) {
    //   lc.setOverwriteLeadSource(request.overWriteLeadSource);
    // }

    // if (request.createOpportunity != null && !request.createOpportunity) {
    //   lc.setDoNotCreateOpportunity(!request.createOpportunity);
    // }

    // if (request.opportunityName != null) {
    //   lc.setOpportunityName(request.opportunityName);
    // }

    // if (request.ownerId != null) {
    //   lc.setOwnerId(request.ownerId);
    // }

    // if (request.sendEmailToOwner != null && request.sendEmailToOwner) {
    //   lc.setSendNotificationEmail(request.sendEmailToOwner);
    // }

    Database.LeadConvertResult lcr = Database.convertLead(lc, true);
    if (lcr.isSuccess()) {
      ConvertLeadActionResult result = new ConvertLeadActionResult();
      result.accountId = lcr.getAccountId();
      result.contactId = lcr.getContactId();
      result.opportunityId = lcr.getOpportunityId();
      return result;
    } else {
      throw new ConvertLeadActionException(lcr.getErrors()[0].getMessage());
    }
  }


    private static LeadStatus getConvertStatus() {
        return [Select Id, MasterLabel From LeadStatus Where IsConverted = true Limit 1];
    }

    global Class ConvertLeadActionRequest {

        @InvocableVariable(required = true)
        global ID leadId;

        @InvocableVariable
        global Id  contactId;

        @InvocableVariable(required = true)
        global Id accountId;

        @InvocableVariable( required = true)
        global String convertedStatus;
    }

    global class ConvertLeadActionResult {
        @InvocableVariable
        global ID accountId;

        @InvocableVariable
        global ID contactId;

        @InvocableVariable
        global ID opportunityId;
    }

    global class ConvertLeadActionException extends Exception{}

}
