/*------------------------------------------------------------  
Author:        Ian Huang
Company:       Salesforce.com
Description:   An abstract base class for rest callouts
Test Class:    TBC
History        <Changed By>         <Date>      <Change Descirption>
------------------------------------------------------------*/
public inherited sharing abstract class RestCalloutBase {

    public final Integer HTTP_REQUEST_TIME_OUT = 120000;
    
    protected HttpRequest request;
    protected HttpResponse response;
    
    private String path;

    public RestCalloutBase(String httpMethod, String path) {
        this.path = path;
        request  = new HttpRequest();

        request.setMethod(httpMethod);
        //TODO: update named credential 
        request.setEndpoint('callout:REST_API_Endpoint/' + this.path);
        request.setTimeout(HTTP_REQUEST_TIME_OUT);
        //set common header values
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('DateTime', System.now().format('yyyy-MM-dd'));
    }

    public virtual HttpResponse send(String requestBody) {
        if(requestBody==null) return null;
        
        Datetime sendingOn = Datetime.now();

        try {    
            if(String.isNotEmpty(requestBody)) {
                request.setBody(requestBody);   
            }

            if (!Test.isRunningTest()) {
                long startTime = DateTime.now().getTime();
                response = new http().send(request);
            
                //ApplicationLogHelper.debugLog(request.toString());
                //ApplicationLogHelper.debugLog(response.toString());
                //ApplicationLogHelper.debugLog(response.getBody());

                long endTime = DateTime.now().getTime();
                /*ApplicationLogHelper.logCallout('Class',
                                                'RestCalloutBase', 'send', '', '', 
                                                'callout:HKT_Ruby_API/' + this.path,
                                                'StatusCode: ' + response.getStatusCode(),
                                                request.getBody(),
                                                response.getBody(), 
                                                endTime - startTime); */
            }
        } catch(Exception ex) {
            ApplicationLogHelper.logException('Class', 'RestCalloutBase', 'send', ex);
        }
        return response;
    }
	
}
