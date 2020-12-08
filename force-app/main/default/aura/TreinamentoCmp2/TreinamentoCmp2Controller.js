({
    doInit: function(component, event, helper) {
        var recordId = component.get('v.recordId');
        console.log('Valor de num: ', recordId);
        
        var action = component.get("c.getAccount");
        action.setParams({
            'id': recordId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.account", response.getReturnValue());
            } else {
                console.debug(response.error[0].message);
            }
        });
        $A.enqueueAction(action);
        console.log('Final handleGetRecord');
    },
    handleGetRecord  : function(component, event, helper) {
        
    },
})