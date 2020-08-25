//
public inherited sharing class RestCalloutEntity {
    
    
    public virtual class RestCalloutResponse {
        public Integer StatusCode;
        public String Status;
        public String Message = '';
        public Boolean isSuccess;

        public virtual void updateStatus(HTTPResponse response) {
            this.StatusCode = response.getStatusCode();
            this.Status     = response.getStatus();
            this.Message    = '';
            this.isSuccess  = this.StatusCode==200 ? true : false;
            //TODO parse response message
        }
    }
    
    

}