@isTest
public class verificaGarantiasTest {
    static testMethod void testVerificaGarantias() {
        List<Garantia__c> testRecords = new List<Garantia__c>();
        for(Integer i=0; i<10; i++) {
            Garantia__c g = new Garantia__c();
            g.Tempo_Garantia__c = 100; 
            testRecords.add(g);
        }
        insert testRecords;

        System.assertEquals(10, [SELECT COUNT() FROM Garantia__c]);

        Test.startTest();
        verificaGarantias batch = new verificaGarantias();
        ID batchID = Database.executeBatch(batch);
        Test.stopTest();

        List<Garantia__c> updatedRecords = [SELECT Status__c FROM Garantia__c];

        for(Garantia__c g : updatedRecords) {
            System.assertEquals('Não Assegurado', g.Status__c);
        }
    }
}
