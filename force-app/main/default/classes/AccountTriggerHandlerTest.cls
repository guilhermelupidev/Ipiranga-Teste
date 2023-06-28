@isTest
private class AccountTriggerHandlerTest {
    
    @isTest static void testeCepValidoComHifen() {
        Account acc = new Account(Name='Test Account', BillingPostalCode='12345-678');
        Test.startTest();
        insert acc;
        Test.stopTest();
        System.assertEquals('12345-678', [SELECT BillingPostalCode FROM Account WHERE Id=:acc.Id].BillingPostalCode);
    }
    
    @isTest static void testeCepValidoSemHifen() {
        Account acc = new Account(Name='Test Account 2', BillingPostalCode='12345678');
        Test.startTest();
        insert acc;
        Test.stopTest();
        System.assertEquals('12345-678', [SELECT BillingPostalCode FROM Account WHERE Id=:acc.Id].BillingPostalCode);
    }
    
    @isTest static void testeCepFormatoInvalido() {
        Account acc = new Account(Name='Test Account 3', BillingPostalCode='1234A-678');
        Test.startTest();
        try {
            insert acc;
        } catch(DMLException e) {
            System.assert(e.getMessage().contains('Formato de CEP inválido! Insira um CEP válido no formato XXXXX-XXX ou XXXXXXXX.'), 'Unexpected error message: ' + e.getMessage());
        }
        Test.stopTest();
    }
}
