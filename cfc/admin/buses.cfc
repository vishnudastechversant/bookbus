component displayname="buses"{

	remote function addbus(
							required string bus_name,
							required string bus_type,
							required numeric layout_type,
							required numeric available_today,
							required numeric seat_count,
							required numeric route_from,
							required numeric route_to,
							required string main_route,
							required string daily_bus,
							required string bus_days,
							required string route_available,
							required string departure_time,
							required string arrival_time,
							required numeric bus_price)
		{
			variables.form_values		=  structNew();
			
			if((not isdefined("form.csrfToken")) OR (not CSRFVerifyToken(form.csrfToken)))
				{
					Session.admin_status  =  'error';
					Session.admin_message =  'Invalid request';
					Session.admin_form 	  =  variables.form_values;
					location('../../pages/admin/addnewbus.cfm');
				}

			
			variables.created_by			=	session.id;
			variables.insert_bus 			=	addToBus(bus_name, bus_type, layout_type, available_today, seat_count, variables.created_by);
			
			if(variables.insert_bus != 'error')
				{
					variables.bus_id 		=	variables.insert_bus;
					variables.add_route		=	addRoute(variables.bus_id,bus_price,bus_days,route_from,route_to,departure_time,arrival_time,available_today,daily_bus);
					if(variables.add_route != 'error')
						{
							Session.admin_status  =  'success';
							Session.admin_message =  'Your bus has been added succesfully!';
							Session.admin_form 	  =  variables.form_values;
							location('../../pages/admin/listbus.cfm');
						}
					else 
						{
							Session.admin_status  =  'success';
							Session.admin_message =  'Your bus has been added. Adding route failed. Please add in edit section!';
							Session.admin_form 	  =  variables.form_values;
							location('../../pages/admin/listbus.cfm');
						}
				}
			else 
				{
					form_values["bus_name"]            =   bus_name;
					form_values["bus_type"]            =   bus_type;
					form_values["layout_type"]         =   layout_type;
					form_values["available_today"]     =   available_today;
					form_values["seat_count"]          =   seat_count;
					form_values["route_from"]          =   route_from;
					form_values["route_to"]            =   route_to;
					form_values["main_route"]          =   main_route;
					form_values["daily_bus"]           =   daily_bus;
					form_values["bus_days"]            =   bus_days;
					form_values["route_available"]     =   route_available;
					form_values["departure_time"]      =   departure_time;
					form_values["arrival_time"]        =   arrival_time;

					Session.admin_status  =  'error';
					Session.admin_message =  'Error. Something went wrong!';
					Session.admin_form 	  =   variables.form_values;
					location('../../pages/admin/addnewbus.cfm');
				}
		}

	remote function editbus(required numeric busid,
							required string bus_name,
							required string bus_type,
							required numeric layout_type,
							required numeric available_today,
							required numeric seat_count,
							required numeric route_from,
							required numeric route_to,
							required string main_route,
							required string daily_bus,
							required string bus_days,
							required string route_available,
							required string departure_time,
							required string arrival_time,
							required numeric bus_price)
		{
			variables.form_values 	=  structNew();

			//writeDump(form);
			
			if((not isdefined("form.csrfToken")) OR (not CSRFVerifyToken(form.csrfToken)))
				{
					Session.admin_status  =  'error';
					Session.admin_message =  'Invalid request';
					Session.admin_form 	  =  form_values;
					location('../../pages/admin/listbus.cfm');
				}

			if(!isNumeric(busid) || busid < 1 )
				{
					Session.admin_status  =  'error';
					Session.admin_message =  'Not a valid request';
					Session.admin_form 	  =  form_values;
					location('../../pages/admin/listbus.cfm');
				}	
				
					variables.created_by			=	session.id;
					variables.update_bus 			=	editToBus(busid, bus_name, bus_type, layout_type, available_today, seat_count, variables.created_by);
					
					if(variables.update_bus != 'error')
						{
							variables.update_route	=	editRoute(busid,bus_price,bus_days,route_from,route_to,departure_time,arrival_time,available_today,daily_bus);
							if(variables.update_route != 'error')
								{
									Session.admin_status  =  'success';
									Session.admin_message =  'Your bus has been updated succesfully!';
									Session.admin_form 	  =  form_values;
									location('../../pages/admin/listbus.cfm');
								}
							else 
								{
									Session.admin_status  =  'success';
									Session.admin_message =  'Your bus has been update. Updating route failed. Please continue edit in edit section!';
									Session.admin_form 	  =  form_values;
									location('../../pages/admin/listbus.cfm');
								}
						}
					else 
						{
							form_values["bus_name"]            =   bus_name;
							form_values["bus_type"]            =   bus_type;
							form_values["layout_type"]         =   layout_type;
							form_values["available_today"]     =   available_today;
							form_values["seat_count"]          =   seat_count;
							form_values["route_from"]          =   route_from;
							form_values["route_to"]            =   route_to;
							form_values["main_route"]          =   main_route;
							form_values["daily_bus"]           =   daily_bus;
							form_values["bus_days"]            =   bus_days;
							form_values["route_available"]     =   route_available;
							form_values["departure_time"]      =   departure_time;
							form_values["arrival_time"]        =   arrival_time;

							Session.admin_status  =  'error';
							Session.admin_message =  'Error. Something went wrong!';
							Session.admin_form 	  =  form_values;
							location('../../pages/admin/editbus.cfm?busid=#bus_id#');
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

	private function editToBus(bus_id, bus_name, bus_type, layout_type, available_today, seat_count, created_by)
		{
			try
				{
					result = queryExecute("UPDATE br_buses SET 
														bus_name = :bus_name, 
														bus_type = :bus_type, 
														layout_type = :layout_type, 
														available_today = :available_today, 
														no_of_seats = :seat_count
												WHERE  
														created_by = :created_by
												AND 
														id = :bus_id",
												{
								                    bus_name: { cfsqltype: "cf_sql_varchar", value: bus_name },
								                    bus_type: { cfsqltype: "cf_sql_varchar", value: bus_type },
								                    layout_type: { cfsqltype: "cf_sql_integer", value: layout_type },
								                    available_today: { cfsqltype: "cf_sql_integer", value: available_today },
								                    seat_count: { cfsqltype: "cf_sql_integer", value: seat_count },
								                    created_by: { cfsqltype: "cf_sql_integer", value: created_by },
								                    bus_id: { cfsqltype: "cf_sql_integer", value: bus_id }
								                }, 
												{ result="resultset" });
					return	'success';
				}
			catch(Exception e)
				{
					return 'error';
				}
		}

	private function editRoute(bus_id,bus_price,bus_days,route_from,route_to,departure_time,arrival_time,available_today,daily_bus)
		{
			try
			{
				result = queryExecute("UPDATE br_bus_routes SET
											price           = :bus_price,
											bus_days        = :bus_days,
											route_from      = :route_from,
											route_to        = :route_to,
											departure_time  = :departure_time,
											arrival_time    = :arrival_time,
											available_today = :available_today,
											daily_bus       = :daily_bus
										WHERE 
											bus_id          = :bus_id
											",
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
				return	'success';
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
				result = queryExecute("SELECT 
										   bus.id AS bus_id, 
										   bus.bus_name AS bus_name, 
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
									GROUP BY 
										   bus.id
       									",
       									{userid: { cfsqltype: "cf_sql_integer", value: userid }});
				return result;
			}
			catch(Exception e)
			{
				return 'error';
			}
		}

	public function getBusesById(busid, userid)
		{
			try
			{
				result = queryExecute("SELECT 
										   bus.id AS bus_id, 
										   bus.bus_name AS bus_name, 
										   bus.bus_type AS bus_type, 
									       bus.layout_type AS layout_type, 
									       bus.available_today AS available_today, 
									       bus.no_of_seats AS no_of_seats, 
									       bus.created_by AS created_by,
									       route.price AS price,
									       route.bus_days AS bus_days,
									       route.route_from AS route_from,
									       route.route_to AS route_to,
									       route.departure_time AS departure_time,
									       route.arrival_time AS arrival_time,
									       route.available_today AS route_available_today,
									       route.daily_bus AS daily_bus
									FROM 
									       br_buses AS bus
									LEFT JOIN 
									       br_bus_routes AS route
									ON 
									       bus.id = route.bus_id	    
									WHERE 
									       bus.created_by = :userid AND bus.id = :busid
       									",
       									{
       										userid: { cfsqltype: "cf_sql_integer", value: userid },
       										busid: { cfsqltype: "cf_sql_integer", value: busid }
       									},{returntype="array"});
				return result;
			}
			catch(Exception e)
			{
				return 'error';
			}
		}	
}