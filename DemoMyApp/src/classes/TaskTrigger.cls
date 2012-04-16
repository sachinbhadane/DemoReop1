public virtual with sharing class TaskTrigger {
    protected final Map<Id, Task> taskOldMap = new Map<Id, Task>();
    protected final Task[] taskNewList = new Task[] {};
    protected final Task[] taskOldList = new Task[] {};
    private static Schema.DescribeSObjectResult describeResult;
    
    protected TaskTrigger(Task[] taskOldList, Task[] taskNewList) {
        this.taskNewList.addAll(taskNewList == null ? new Task[] {} : taskNewList);
        this.taskOldList.addAll(taskOldList == null ? new Task[] {} : taskOldList);
        this.taskOldMap.putAll(this.taskOldList);
    }
    
    protected Task taskOld(Id taskId) {
        Task task = taskOldMap.get(taskId);
        return task == null ? new Task() : task;
    }
    
    public virtual void execute() {}
}