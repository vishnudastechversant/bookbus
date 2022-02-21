component { 
    remote function addCity(state_id,city) { 
        if(structKeyExists(arguments, 'city')){
            queryExecute("INSERT INTO br_city ( city, state_id) VALUES  (	:city,:state_id )", { city: { cfsqltype: "cf_sql_varchar", value: city }, state_id: { cfsqltype: "cf_sql_varchar", value: state_id }}, { result="resultset" });
            Session.admin_status  =  'success';
            Session.admin_message =  'succesfully Added!';
            location('../../pages/admin/city.cfm');
        }
        else
        {
            Session.admin_status  =  'error';
            Session.admin_message =  'This is a error';
            Session.admin_form 	  =  form;
            location('../../pages/admin/city.cfm');
        }	
    }

    remote function getcity(){
       allState = queryExecute("SELECT * FROM br_city INNER JOIN br_state ON br_city.state_id=br_state.id", {});
       return allState;
    }

    remote function deletCity(id){
        if(structKeyExists(arguments, 'id')){
            queryExecute("DELETE FROM  br_city WHERE id = #id#", {});
            Session.admin_status  =  'success';
            Session.admin_message =  'succesfully Deleted!';
            location('../../pages/admin/city.cfm');
        }
        else
        {
            Session.admin_status  =  'error';
            Session.admin_message =  'This is a error';
            location('../../pages/admin/city.cfm');
        }
    }

    function selectSingleCity(userId){
        return queryExecute("SELECT * FROM br_city WHERE id = #id#", {});   
    }

    remote function updateCity(state_id,city,city_id){
        if(structKeyExists(arguments, 'city_id')){
            queryExecute("UPDATE br_city SET city = :city, state_id = :state_id WHERE id = :city_id",{
                                                city_id: { cfsqltype: "cf_sql_integer", value: city_id },
											    city: { cfsqltype: "cf_sql_varchar", value: city },
						                        state_id: { cfsqltype: "cf_sql_integer", value: state_id }},{});
            Session.admin_status  =  'success';
            Session.admin_message =  'succesfully Updated!';
            location('../../pages/admin/city.cfm');
        }else{
            Session.admin_status  =  'error';
            Session.admin_message =  'Try after some time';
            location('../../pages/admin/city.cfm');
        }
    }
}

