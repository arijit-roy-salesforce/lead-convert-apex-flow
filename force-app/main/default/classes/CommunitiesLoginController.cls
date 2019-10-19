global with sharing class CommunitiesLoginController {

    global String username {get; set;}
    global String password {get; set;}
    public String orgId {get; set;}
    public String siteUrl {get; set;}
    public String startUrl {get; set;}


    global CommunitiesLoginController() {
        this.orgId = UserInfo.getOrganizationId();
        this.siteUrl = Site.getBaseUrl();
        this.startUrl = System.currentPageReference().getParameters().get('startUrl');
        if(startUrl == null) this.startUrl = '/';
    }

    global Pagereference login() {
        return Site.login(username, password, startUrl);
    }

    // Code we will invoke on page load.
    global PageReference forwardToAuthPage() {
      String startUrl = System.currentPageReference().getParameters().get('startURL');
      String displayType = System.currentPageReference().getParameters().get('display');
        return Network.forwardToAuthPage(startUrl, displayType);
    }
}
