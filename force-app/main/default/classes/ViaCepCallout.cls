public class ViaCepCallout {    
    
    public static ViaCep consultaCep(String cep) {
        
		WebService__mdt lWebService = [SELECT Id, DeveloperName, Path__c, Timeout__c FROM WebService__mdt WHERE DeveloperName = 'ConsultaCEP'];
        
        List<Object> lParameters = new List<Object> {cep};        
        HttpRequest lRequest = new HttpRequest();
        lRequest.setEndpoint('callout:ViaCep' + String.format(lWebService.Path__c, lParameters));
        lRequest.setMethod( 'GET' );
        lRequest.setHeader('Content-Type','application/json');  
        lRequest.setTimeout(Integer.valueOf(lWebService.Timeout__c));
        Http http = new Http();    
        HttpResponse lResponse =  http.send( lRequest );
        if( lResponse.getStatusCode() == 200 ) {
            
            ViaCep endereco  = (ViaCep) System.JSON.deserialize(lResponse.getBody(), ViaCep.class);
            system.debug('Endereço: ' + JSON.serialize(endereco));
            return endereco;
        }
        return null;
    }
}