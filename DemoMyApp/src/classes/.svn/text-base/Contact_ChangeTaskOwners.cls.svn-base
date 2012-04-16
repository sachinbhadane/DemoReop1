public without sharing class Contact_ChangeTaskOwners extends ContactTrigger {
    public Contact_ChangeTaskOwners(Contact[] contactOldList, Contact[] contactNewList) {
        super(contactOldList, contactNewList);
    }
    
    public override void execute() {
        // What are the changed owners?
        Map<Id, Contact> contactOwnerChangedMap = new Map<Id, Contact> {};
        
        for(Contact contactNew : contactNewList) {
            Contact contactOld = contactOld(contactNew.Id);
            
            system.assert(null != contactOld);
            system.assert(null != contactNew);
            system.assert(null != contactNew.OwnerId);
            
            if (contactNew.OwnerId == contactOld.OwnerId)
                continue;
            contactOwnerChangedMap.put(contactNew.Id, contactNew);
        }
        
        system.debug('contactOwnerChangedMap.size() = ' + contactOwnerChangedMap.size());
        system.debug('contactOwnerChangedMap = ' + contactOwnerChangedMap);
        
        if (contactOwnerChangedMap.size() == 0)
            return; // nothing to do.
        
        Task[] taskUpdateList = new Task[] {};
        Task[] taskList = [
            select OwnerId
                 , WhoId
              from Task
             where WhoId in :contactOwnerChangedMap.keySet()
               and IsClosed = false
        ];
        
        system.debug('taskList.size() = ' + taskList.size());
        system.debug('taskList = ' + taskList);
        
        if (taskList.size() == 0)
            return;
        
        for(Task task : taskList) {
            Contact contact = contactOwnerChangedMap.get(task.WhoId);
            system.assert(null != contact);
            system.assert(null != contact.OwnerId);
            
            if (contact.OwnerId == task.OwnerId)
                continue;
            
            task.OwnerId = contact.OwnerId;
            taskUpdateList.add(task);
        }
        
        system.debug('taskUpdateList.size() = ' + taskUpdateList.size());
        system.debug('taskUpdateList = ' + taskUpdateList);
        
        if (taskUpdateList.size() == 0)
            return;
         update taskUpdateList;
    }
}