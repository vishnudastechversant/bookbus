component displayname="buses"{

	remote function addbus()
		{

			if((not isdefined("form.csrfToken")) OR (not CSRFVerifyToken(form.csrfToken)))
				{
					writeOutput('Invalid Request');
					exit;
				}

			form_values		=  structNew();
			
			if(structKeyExists(form, 'bus_name') AND structKeyExists(form, 'bus_type')  AND structKeyExists(form, 'layout_type') AND structKeyExists(form, 'available_today') AND structKeyExists(form, 'seat_count') AND structKeyExists(form, 'route_from') AND structKeyExists(form, 'route_to') AND structKeyExists(form, 'main_route') AND structKeyExists(form, 'daily_bus') AND structKeyExists(form, 'bus_days') AND structKeyExists(form, 'route_available') AND structKeyExists(form, 'departure_time') AND structKeyExists(form, 'arrival_time') )
				{
					form_values["bus_name"]            =   form.bus_name;
					form_values["bus_type"]            =   form.bus_type;
					form_values["layout_type"]         =   form.layout_type;
					form_values["available_today"]     =   form.available_today;
					form_values["seat_count"]          =   form.seat_count;
					form_values["route_from"]          =   form.route_from;
					form_values["route_to"]            =   form.route_to;
					form_values["main_route"]          =   form.main_route;
					form_values["daily_bus"]           =   form.daily_bus;
					form_values["bus_days"]            =   form.bus_days;
					form_values["route_available"]     =   form.route_available;
					form_values["departure_time"]      =   form.departure_time;
					form_values["arrival_time"]        =   form.arrival_time;

					Session.admin_status  =  'success';
					Session.admin_message =  'Your bus has been added succesfully!';
					Session.admin_form 	  =  form_values;
					location('../../pages/admin/addnewbus.cfm');
				}
			else 
				{
					Session.admin_status  =  'error';
					Session.admin_message =  'This is a error';
					Session.admin_form 	  =  form;
					location('../../pages/admin/addnewbus.cfm');
				}
		}


}