component { 
    remote function addState(string state_name) {
        if(structKeyExists(arguments, 'state_name')){
            result = queryExecute("INSERT INTO br_state( state ) VALUES( :state)",{state :{cfsqltype: "cf_sql_varchar", value: "#arguments.state_name#"}},{});
            Session.admin_status  =  'success';
            Session.admin_message =  'succesfully Added!';
            location('../../pages/admin/state.cfm');
        }
        else
        {
            Session.admin_status  =  'error';
            Session.admin_message =  'An error occured';
            Session.admin_form 	  =  form;
            location('../../pages/admin/state.cfm');
        }	
    }

    remote function getState(){
       allState = queryExecute("SELECT * FROM br_state", {});
       return allState;
    }

    remote function deleteState(id){
        if(structKeyExists(arguments, 'id')){
            queryExecute("DELETE FROM  br_state WHERE id = #id#", {});
            Session.admin_status  =  'success';
            Session.admin_message =  'succesfully Deleted!';
            location('../../pages/admin/state.cfm');
        }
        else
        {
            Session.admin_status  =  'error';
            Session.admin_message =  'This is a error';
            location('../../pages/admin/state.cfm');
        }
    }

    function selectSingleState(){
        return queryExecute("SELECT * FROM br_state WHERE id = #id#", {});   
    }

    remote function updateState(state_name,state_id){
        if(structKeyExists(arguments, 'state_id')){
            queryExecute("UPDATE br_state SET state = :state WHERE id = :state_id",{
                                                state_id: { cfsqltype: "cf_sql_integer", value: state_id },
											    state: { cfsqltype: "cf_sql_varchar", value: state_name}},{});
            Session.admin_status  =  'success';
            Session.admin_message =  'succesfully Updated!';
            location('../../pages/admin/state.cfm');
        }else{
            Session.admin_status  =  'error';
            Session.admin_message =  'Try after some time';
            location('../../pages/admin/state.cfm');
        }
    }
}