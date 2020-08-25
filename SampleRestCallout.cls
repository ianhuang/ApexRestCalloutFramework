public with sharing class SampleRestCallout extends RestCalloutBase {
    
    public class SampleRestCalloutRequest {
        public String customerNumber;
        //public String other properties;
    }
    
    public SampleRestCallout(String customerId) {
        super('POST', 'alteration/coupon/access');
        this.request.setHeader('CustomerId', customerId);
    }

    public RestCalloutEntity.RestCalloutResponse send(SampleRestCalloutRequest sampleRequest) {
        //System.debug(System.JSON.serialize(sampleRequest));

        RestCalloutEntity.RestCalloutResponse sampleResponse = new RestCalloutEntity.RestCalloutResponse();
        String body = JSON.serialize(sampleRequest);
        response = super.send(body);
        if(response.getStatusCode()==200) {
            String responseBody = response.getBody();
            sampleResponse = (RestCalloutEntity.RestCalloutResponse)JSON.deserialize(responseBody, RestCalloutEntity.RestCalloutResponse.Class);
        }
       
        return sampleResponse;
    }

}