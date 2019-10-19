@isTest(seeAllData = true)
public class TestBotKnowledgeSearch {
    
    static testMethod void testCase1() {
        List<KnowledgeArticleVersion> articles = [Select Id, Title, UrlName from KnowledgeArticleVersion];
        BotKnowledgeSearch.summarizeArticleForBot(articles[0].UrlName, articles[0]);
        System.debug('#### Knowledge articles '+articles);
        List<BotKnowledgeSearch.FAQSearchOutput> searchResults = new List<BotKnowledgeSearch.FAQSearchOutput>();
        BotKnowledgeSearch.FAQSearchInput searchInput = new BotKnowledgeSearch.FAQSearchInput();
        searchInput.sKeyword = 'Career';
        searchResults = BotKnowledgeSearch.searchFAQ(new List<BotKnowledgeSearch.FAQSearchInput>{searchInput});
    }
}
