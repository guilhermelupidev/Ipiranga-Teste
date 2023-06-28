/*
Public static void BloqueiaIntegracao(List<Opportunity> Opp){ 

    0##### PODERIA SER DECLARADO DENTRO DO FOR

    List<OpportunityContactRole> Oppcontacts = New List<OpportunityContactRole>(); 

    /0#####

    for(Opportunity OppA : Opp){

        1###### QUERY DENTRO DO FOR, NÃO RESPEITANDO OS LIMITES E AS BOAS PRATICAS PASSADAS PELA SALESFORCE. ERRO NO API NAME DO Contact.FirstName E FORA DE FORMATAÇAO

        Oppcontacts = [SELECT id,contact.email,contact.fistname,contact.lastname from OpportunityContactRole where Opportunityid =: OppA.id AND Role =: 'Responsável Financeiro'];

        /1######
        if(Oppcontacts.size()=0){
            oppA.addError( 'É necessario ter o papel financeiro alinhado na oportunidade.'); 
        }
        
    } 
    
}
*/

public with sharing class BloqueiaIntegracao {

    public static void BloqueiaIntegracao(List<Opportunity> opps){

        Map<Id, List<OpportunityContactRole>> oppContactRoleMap = new Map<Id, List<OpportunityContactRole>>();
    
        List<OpportunityContactRole> oppContactRoles = [SELECT Id, Contact.Email, Contact.FirstName, Contact.LastName,OpportunityId FROM OpportunityContactRole WHERE OpportunityId IN: opps AND Role =: 'Responsável Financeiro'];
    
        for (OpportunityContactRole opportunityContactRoleVar : oppContactRoles) {
    
            if (!oppContactRoleMap.containsKey(opportunityContactRoleVar.OpportunityId)) {
                oppContactRoleMap.put(opportunityContactRoleVar.OpportunityId, new List<OpportunityContactRole>());
            }
            oppContactRoleMap.get(opportunityContactRoleVar.OpportunityId).add(opportunityContactRoleVar);
        }
    
        for (Opportunity oppA : opps) {
    
            List<OpportunityContactRole> oppContacts = oppContactRoleMap.get(oppA.Id);
    
            if (oppContacts == null || oppContacts.size() == 0) {
                oppA.addError('É necessario ter o papel financeiro alinhado na oportunidade.');
            }
        }
    }
    
}

