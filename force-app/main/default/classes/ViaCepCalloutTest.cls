@isTest
public class ViaCepCalloutTest {
	@isTest static  void testGetCallout() {
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('ViaCepResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        ViaCep endereco = ViaCepCallout.consultaCep('19800000');        
        
        // Verify address  
        System.assertEquals(endereco.logradouro, 'Rua XI', 'Retorno dos dados da rua incorreto'); 
        System.assertEquals(endereco.bairro, 'Centro', 'Retorno dos dados do bairro incorreto'); 
        System.assertEquals(endereco.localidade, 'Assis', 'Retorno dos dados da localidade incorreto'); 
        System.assertEquals(endereco.uf, 'SP', 'Retorno dos dados do estado incorreto');          
    }  
}