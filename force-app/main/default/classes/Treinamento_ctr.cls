public class Treinamento_ctr {    
    public Account fAccount {get;set;}      
    public String fMsgError {get;set;}   
    public Boolean fEditMode {get;set;}    
        
    public String fAccName {get;set;} 
    public String fAccPhone {get;set;} 
    
    public String fCep {get;set;} 
    
    public Treinamento_ctr(ApexPages.StandardController stdController) {
        fAccount = [SELECT name, phone FROM Account WHERE id = :((Account)stdController.getRecord()).id];
        fMsgError = null;
        fEditMode = false;
        loadData();
    }
    
    private void loadData() {
        fAccName = fAccount.name;        
        fAccPhone = fAccount.phone;
    }
    
    public void customEdit() {
        fEditMode = true;
    }
    
    public void customCancel() {
        fEditMode = false;
        loadData();
    }
    
    public void customSave() {
        fMsgError = null;
        
        if(!validateFields()) return;
        
        fAccount.name = fAccName;        
        fAccount.phone = fAccPhone;
        
        try {
            update fAccount;
            fEditMode = false;
        }
        catch(DMLException ex) {
            fMsgError = ex.getDmlMessage(0);
        }         
    }
    
    public Boolean validateFields() {
        
        if(String.isBlank(fAccName)) {
            fMsgError = 'Por favor preencher o campo Nome';
            return false;
        }
        
        if(String.isBlank(fAccPhone)) {
            fMsgError = 'Por favor preencher o campo Telefone';
            return false;
        }
        
        return true;
    }
    
    public void consultaCep() {

        HttpRequest lRequest = new HttpRequest();
        lRequest.setEndpoint( 'https://viacep.com.br/ws/'+ fCep.replace('-','') +'/json/'  );
        lRequest.setMethod( 'GET' );
        lRequest.setHeader('Content-Type','application/json');  
        lRequest.setTimeout(20000);
        Http http = new Http();    
        HttpResponse lResponse =  http.send( lRequest );
        if( lResponse.getStatusCode() == 200 ) {
            
            ViaCepWrapper lEndereco  = (ViaCepWrapper) System.JSON.deserialize(lResponse.getBody(), ViaCepWrapper.class);
    
            if(lEndereco != null) {
                //fEndereco = lEndereco.logradouro;
                //fCidade = lEndereco.localidade;
                //fEstado = lEndereco.uf;
                //fBairro = lEndereco.bairro;
                //fCep = lEndereco.cep;
            }
        }
    }

    public class ViaCepWrapper {
    
        public String cep;
        public String logradouro;
        public String complemento;
        public String bairro;
        public String localidade;
        public String uf;
        public String unidade;
        public String ibge;
        public String gia;
    }
}