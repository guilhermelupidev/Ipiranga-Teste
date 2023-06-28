public with sharing class AccountTriggerHandler {

    public void onBeforeInsertUpdate(List<Account> accounts) {
        Pattern patternComHifen = Pattern.compile('^\\d{5}-\\d{3}$'); 
        Pattern patternSemHifen = Pattern.compile('^\\d{8}$'); 

        for(Account acc : accounts){ 

            String billingPostalCode = acc.BillingPostalCode; 

            if(billingPostalCode != null){   

                Matcher matcherComHifen = patternComHifen.matcher(billingPostalCode); 
                Matcher matcherSemHifen = patternSemHifen.matcher(billingPostalCode); 

                if(!matcherComHifen.matches() && !matcherSemHifen.matches()){  

                    acc.addError('Formato de CEP inválido! Insira um CEP válido no formato XXXXX-XXX ou XXXXXXXX.');

                } else if (matcherSemHifen.matches()) { 

                    acc.BillingPostalCode = billingPostalCode.substring(0, 5) + '-' + billingPostalCode.substring(5); 

                } 
            } 
        } 
    } 
} 
