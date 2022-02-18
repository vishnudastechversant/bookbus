component displayname="buses"{

	remote function addbus()
		{
			form_values		=  structNew();
			
			if((not isdefined("form.csrfToken")) OR (not CSRFVerifyToken(form.csrfToken)))
				{
					Session.admin_status  =  'error';
					Session.admin_message =  'Invalid request';
					Session.admin_form 	  =  form_values;
					location('../../pages/admin/addnewbus.cfm');
				}

			
			if(structKeyExists(form, 'bus_name') AND structKeyExists(form, 'bus_type')  AND structKeyExists(form, 'layout_type') AND structKeyExists(form, 'available_today') AND structKeyExists(form, 'seat_count') AND structKeyExists(form, 'route_from') AND structKeyExists(form, 'route_to') AND structKeyExists(form, 'main_route') AND structKeyExists(form, 'daily_bus') AND structKeyExists(form, 'bus_days') AND structKeyExists(form, 'route_available') AND structKeyExists(form, 'departure_time') AND structKeyExists(form, 'arrival_time') AND structKeyExists(form, 'bus_price') )
				{
					bus_name            =   form.bus_name;
					bus_type            =   form.bus_type;
					layout_type         =   form.layout_type;
					available_today     =   form.available_today;
					seat_count          =   form.seat_count;
					route_from          =   form.route_from;
					route_to            =   form.route_to;
					main_route          =   form.main_route;
					daily_bus           =   form.daily_bus;
					bus_days            =   form.bus_days;
					route_available     =   form.route_available;
					departure_time      =   form.departure_time;
					arrival_time        =   form.arrival_time;
					bus_price           =   form.bus_price;

					created_by			=	1;
					insert_bus 			=	addToBus(bus_name, bus_type, layout_type, available_today, seat_count, created_by);
					
					if(insert_bus != 'error')
						{
							bus_id 		=	insert_bus;
							add_route	=	addRoute(bus_id,bus_price,bus_days,route_from,route_to,departure_time,arrival_time,available_today,daily_bus);
							if(add_route != 'error')
								{
									Session.admin_status  =  'success';
									Session.admin_message =  'Your bus has been added succesfully!';
									Session.admin_form 	  =  form_values;
									location('../../pages/admin/listbus.cfm');
								}
							else 
								{
									Session.admin_status  =  'success';
									Session.admin_message =  'Your bus has been added. Adding route failed. Please add in edit section!';
									Session.admin_form 	  =  form_values;
									location('../../pages/admin/listbus.cfm');
								}
						}
					else 
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

							Session.admin_status  =  'error';
							Session.admin_message =  'Error. Something went wrong!';
							Session.admin_form 	  =  form_values;
							location('../../pages/admin/addnewbus.cfm');
						}					
				}
			else 
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

					Session.admin_status  =  'error';
					Session.admin_message =  'Please enter all mandatory fields';
					Session.admin_form 	  =  form_values;
					location('../../pages/admin/addnewbus.cfm');
				}
		}

	private function addToBus(bus_name, bus_type, layout_type, available_today, seat_count, created_by)
		{
			try
				{
					result = queryExecute("INSERT INTO br_buses (
														bus_name, 
														bus_type, 
														layout_type, 
														available_today, 
														no_of_seats, 
														created_by
													) 
											VALUES 
												(	
													:bus_name,
													:bus_type,
													:layout_type,
													:available_today,
													:seat_count,
													:created_by
												)",
												{
								                    bus_name: { cfsqltype: "cf_sql_varchar", value: bus_name },
								                    bus_type: { cfsqltype: "cf_sql_varchar", value: bus_type },
								                    layout_type: { cfsqltype: "cf_sql_integer", value: layout_type },
								                    available_today: { cfsqltype: "cf_sql_integer", value: available_today },
								                    seat_count: { cfsqltype: "cf_sql_integer", value: seat_count },
								                    created_by: { cfsqltype: "cf_sql_integer", value: created_by }
								                }, 
												{ result="resultset" });
					return	resultset.generatedKey;
				}
			catch(Exception e)
				{
					return 'error';
				}
		}

	private function addRoute(bus_id,bus_price,bus_days,route_from,route_to,departure_time,arrival_time,available_today,daily_bus)
		{
			try
			{
				result = queryExecute("INSERT INTO br_bus_routes (
											bus_id,
											price,
											bus_days,
											route_from,
											route_to,
											departure_time,
											arrival_time,
											available_today,
											daily_bus
										)
										VALUES (
											:bus_id,
											:bus_price,
											:bus_days,
											:route_from,
											:route_to,
											:departure_time,
											:arrival_time,
											:available_today,
											:daily_bus
											)",
										{
											bus_id: { cfsqltype: "cf_sql_integer", value: bus_id },
						                    bus_price: { cfsqltype: "cf_sql_integer", value: bus_price },
						                    bus_days: { cfsqltype: "cf_sql_varchar", value: bus_days },
						                    route_from: { cfsqltype: "cf_sql_integer", value: route_from },
						                    route_to: { cfsqltype: "cf_sql_integer", value: route_to },
						                    departure_time: { cfsqltype: "cf_sql_time", value: departure_time },
						                    arrival_time: { cfsqltype: "cf_sql_time", value: arrival_time },
						                    available_today: { cfsqltype: "cf_sql_integer", value: available_today },
						                    daily_bus: { cfsqltype: "cf_sql_integer", value: daily_bus }
										},
										{result = "resultset"});
				return	resultset.generatedKey;
			}
			catch(Exception e)
			{
				return 'error';
			}
		}

	public function getCity()
		{
			try 
			{
				result = queryExecute("SELECT * FROM br_city");
				return result;	
			}
			catch(Exception e) 
			{
				return 'error';
			}
		}

	public function getBuses(userid)
		{
			try
			{
				result = queryExecute("SELECT bus.bus_name AS bus_name, 
										   bus.bus_type AS bus_type, 
									       bus.layout_type AS layout_type, 
									       IF(bus.available_today = 1, 'Yes', 'No') AS available_today, 
									       bus.no_of_seats AS no_of_seats, 
									       bus.created_by AS created_by,
									       route.price AS price,
									       route.bus_days AS bus_days,
									       (SELECT city FROM br_city WHERE route.route_from = id  ) AS route_from,
									       (SELECT city FROM br_city WHERE route.route_to = id  ) AS route_to,
									       route.departure_time AS departure_time,
									       route.arrival_time AS arrival_time,
									       IF(route.available_today = 1, 'Yes', 'No' ) AS route_available_today,
									       IF(route.daily_bus = 1, 'Yes', 'No' ) AS daily_bus
									FROM 
									       br_buses AS bus
									LEFT JOIN 
									       br_bus_routes AS route
									ON 
									       bus.id = route.bus_id	    
									WHERE 
									       bus.created_by = :userid
       									",
       									{userid: { cfsqltype: "cf_sql_integer", value: userid }});
				return result;
			}
			catch(Exception e)
			{
				return 'error';
			}
		}
}