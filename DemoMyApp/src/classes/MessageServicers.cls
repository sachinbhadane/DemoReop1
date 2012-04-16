public without sharing class MessageServicers {
    public static void scheduleAll() {
        rC_Core.MessageServicerSchedulable.schedule(new rC_Core.MessageServicer.Servicer[] {
            new Lead_ConvertApplicantServicer(),
            new Lead_RouteByRecruitingServicer(),
            new Contact_RouteByRecruitingServicer()
        });
    }
}