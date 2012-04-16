public without sharing class Lead_ChangeTaskOwners extends LeadTrigger {
    public Lead_ChangeTaskOwners(Lead[] leadOldList, Lead[] leadNewList) {
        super(leadOldList, leadNewList);
    }
    
    public override void execute() {
        // What are the changed owners?
        Map<Id, Lead> leadOwnerChangedMap = new Map<Id, Lead> {};
        
        for(Lead leadNew : leadNewList) {
            Lead leadOld = leadOld(leadNew.Id);
            
            system.assert(null != leadOld);
            system.assert(null != leadNew);
            system.assert(null != leadNew.OwnerId);
            
            if (leadNew.OwnerId == leadOld.OwnerId)
                continue;
            leadOwnerChangedMap.put(leadNew.Id, leadNew);
        }
        
        system.debug('leadOwnerChangedMap.size() = ' + leadOwnerChangedMap.size());
        system.debug('leadOwnerChangedMap = ' + leadOwnerChangedMap);
        
        if (leadOwnerChangedMap.size() == 0)
            return; // nothing to do.
        
        Task[] taskUpdateList = new Task[] {};
        Task[] taskList = [
            select OwnerId
                 , WhoId
              from Task
             where WhoId in :leadOwnerChangedMap.keySet()
               and IsClosed = false
        ];
        
        system.debug('taskList.size() = ' + taskList.size());
        system.debug('taskList = ' + taskList);
        
        if (taskList.size() == 0)
            return;
        
        for(Task task : taskList) {
            Lead lead = leadOwnerChangedMap.get(task.WhoId);
            system.assert(null != lead);
            system.assert(null != lead.OwnerId);
            
            if (lead.OwnerId == task.OwnerId)
                continue;
            
            task.OwnerId = lead.OwnerId;
            taskUpdateList.add(task);
        }
        
        system.debug('taskUpdateList.size() = ' + taskUpdateList.size());
        system.debug('taskUpdateList = ' + taskUpdateList);
        
        if (taskUpdateList.size() == 0)
            return;
         update taskUpdateList;
    }
}