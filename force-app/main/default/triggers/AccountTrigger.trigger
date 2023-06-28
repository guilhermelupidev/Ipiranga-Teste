trigger AccountTrigger on Account (before insert, before update) {

    AccountTriggerHandler handler = new AccountTriggerHandler();
    
    if(Trigger.isBefore){         
        if(Trigger.isInsert || Trigger.isUpdate){
            handler.onBeforeInsertUpdate(Trigger.new);
        }
    }

}