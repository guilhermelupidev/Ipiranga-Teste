global class verificaGarantias implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, TempoGarantia__c, CreatedDate FROM Garantia__c';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Garantia__c> records) {
        List<Garantia__c> recordsToUpdate = new List<Garantia__c>();

        for(Garantia__c g : records) {
            Integer daysBetween = g.CreatedDate.date().daysBetween(Date.today());
            if(daysBetween >= g.Tempo_Garantia__c) {

                g.Status__c = 'Não Assegurado';
                recordsToUpdate.add(g);
            }
        }

        if(!recordsToUpdate.isEmpty()) {
            update recordsToUpdate;
        }
    }

    global void finish(Database.BatchableContext BC) {
    }
}
