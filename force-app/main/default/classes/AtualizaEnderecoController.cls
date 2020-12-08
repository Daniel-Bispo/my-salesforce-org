public class AtualizaEnderecoController {
    
    public Boolean fEdicao {get;set;}
    public Account fConta {get;set;}
    public Id fContaId {get;set;}
    
    // Não é possivel DML no construtor!!!
    public AtualizaEnderecoController(ApexPages.StandardController stdController) {
        fContaId = stdController.getRecord().id;
        fEdicao = false;
        carregaDados();
    }
    
    public void carregaDados() {
        List<Account> lContaLst = [SELECT Name, Phone, BillingStreet, BillingCity, 
                                   BillingState, BillingCountry, BillingPostalCode,
                                   BillingNeighborhood__c, BillingNumber__c
                                   FROM Account 
                                   WHERE id = :fContaId];
        if(lContaLst.size() > 0) {
            fConta = lContaLst[0];
        }
    }
    
    // Método utilizado para salvar um registro ao carregar a página ou 
    // redirecionar para outra página caso necessário
    public PageReference metodoAction() {
        
        return null;
    }
    
    public void save() {
        if(validaDados()) {
            update fConta;
        	fEdicao = false;
        }        
    }
    
    public void editar() { 
        fEdicao = true;
    }
    
    public void cancelar() {
        fEdicao = false;
        carregaDados();
    }
        
    public Boolean validaDados() {
        Boolean lSucesso = true;
        if(String.isBlank(fConta.BillingCity) ||
               String.isBlank(fConta.BillingState) ||
               String.isBlank(fConta.BillingStreet) || 
               String.isBlank(fConta.BillingCountry) ||
               String.isBlank(fConta.BillingPostalCode) ||
               String.isBlank(fConta.BillingNumber__c) ||
               String.isBlank(fConta.BillingNeighborhood__c) ) {
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Por favor preencha todos os campo!')); 
            lSucesso = false;
        }
        return lSucesso;
    }
    
    @AuraEnabled
    public static ViaCep getEndereco(String aCep){  
        return ViaCepCallout.consultaCep(aCep);
    }    
    
    @AuraEnabled
    public static String setEndereco(String aEndereco, Id aContaId){
        ViaCep lEndereco = (ViaCep) JSON.deserialize(aEndereco, ViaCep.class);
        Account lConta = new Account();
        lConta.id = aContaId;
        lConta.BillingStreet = lEndereco.logradouro;
        lConta.BillingNeighborhood__c = lEndereco.bairro;
        lConta.BillingCity = lEndereco.localidade;
        lConta.BillingState = lEndereco.uf;
        lConta.BillingPostalCode = lEndereco.cep;
        lConta.BillingCountry = 'Brasil';
        // Criar campo na conta para receber o numero e o bairro
        
        try{
            update lConta;
        }
        catch(DmlException e) {
            return e.getDmlMessage(0);
        }
        return 'Sucesso';
    }
    
    public void buscaEndereco() {          
        
        try {
            ViaCep lEndereco = getEndereco(fConta.BillingPostalCode);
            system.debug('###Endereco: ' + lEndereco);
            
            fConta.BillingStreet = lEndereco.logradouro;
        	fConta.BillingNeighborhood__c = lEndereco.bairro;
            fConta.BillingCity = lEndereco.localidade;
            fConta.BillingState = lEndereco.uf;
            fConta.BillingPostalCode = lEndereco.cep;
            fConta.BillingCountry = 'Brasil';
        }
        catch(Exception e) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Cep não localizado!'));
        }
        
    }
}