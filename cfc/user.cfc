component {

	private function getUser(id="0", emailId="a@gmail.com", fbToken="1") {
		userDetails = queryExecute("SELECT * FROM br_user WHERE id = :id OR email = :emailId OR facebook_token = :fbToken",
		{id={cfsqltype:"cf_sql_integer", value:id}, emailId={cfsqltype:"cf_sql_nvarchar", value:emailId},
		fbToken={cfsqltype:"cf_sql_nvarchar", value:fbToken}});        
        return userDetails;
	}

    private function addUser(name, emailId, password="", googleToken="", fbToken="", loginType, role="2") {
		data = structNew();
		
		try{
			cfquery( name="addUser", result="addUserResult" ) {
				writeOutput("INSERT INTO br_user (fullname, email, password, google_token, facebook_token, login_type, user_role)
				VALUES (");
				cfqueryparam( cfsqltype="cf_sql_nvarchar", value=name );
				writeOutput(",");
				cfqueryparam( cfsqltype="cf_sql_nvarchar", value=emailId );
				writeOutput(",");
				cfqueryparam( cfsqltype="cf_sql_nvarchar", value=password );
				writeOutput(",");
				cfqueryparam( cfsqltype="cf_sql_nvarchar", value=googleToken );
				writeOutput(",");
				cfqueryparam( cfsqltype="cf_sql_nvarchar", value=fbToken );
				writeOutput(",");
				cfqueryparam( cfsqltype="cf_sql_nvarchar", value=loginType );
				writeOutput(",");
				cfqueryparam( cfsqltype="cf_sql_integer", value=role );
				writeOutput(")");
			}
			data.status = "success";
			data.text = addUserResult.generatedKey;
		}
		catch (any e){
			data.status = "error";
			data.text = e.message;
		}		
        return data;
	}

    private function loginCheck(emailId="", fbToken="1") {		
		loginCheck = queryExecute("SELECT * FROM br_user WHERE email = :emailId OR facebook_token = :fbToken", 
		{emailId={cfsqltype: "cf_sql_nvarchar", value:emailId}, fbToken={cfsqltype: "cf_sql_nvarchar", value:fbToken}});		
        return loginCheck.recordCount;
	}

    remote function login(required emailId, required password) {		
        cfquery( name="login", result="loginResult" ) { 
			writeOutput("SELECT * FROM br_user WHERE email =");
			cfqueryparam( cfSqlType="CF_SQL_NVARCHAR", value=emailId );
			writeOutput("AND Password =");
			cfqueryparam( cfsqltype="CF_SQL_NVARCHAR", value=hash(password) );
		}
		recordCount = loginResult.recordCount;
		if ( recordCount == 0 ) {
			writeOutput("<script>
                alert('Invalid username or password');
                window.location.href='../pages/user/index.cfm';
            </script>");
		} 
		else {
			session.id = login.id;
			session.name = login.fullName;
			if(login.user_role == 1){
				location( "../pages/admin", false );
			}
			else{
				location( "../pages/user/dashBoard.cfm", false );
			}
		}
	}

    remote function logout() {
		structDelete(session, "id");
		structDelete(session, "name");
		location( "../pages/user/index.cfm", false );
	}

    remote function register(required name, required emailId, required password, role) {
		
        recordCount = loginCheck(emailId);
		
        if ( recordCount == 0 ) {
			id = addUser(name = name, emailId = emailId, password = hash(password), loginType = "web", role = role);
			session.name = name;
			session.id = id.text;
			if(role == 1){
				location( "../pages/admin", false );
			}
			else{
				location( "../pages/user/dashBoard.cfm", false );
			}
		} else {
			writeOutput("<script>
                alert('User already exist please login');
                window.location.href='../pages/user/index.cfm';
            </script>");
		}
	}

    remote function googleLogin() {
		var loggedIn = false;

        cfoauth(
	        Type="Google",  
            clientid="856324982681-nd2gqlm9vqlildtenbahlbs7gpmr2i6i.apps.googleusercontent.com",  
            scope="https://www.googleapis.com/auth/userinfo.email+https://www.googleapis.com/auth/userinfo.profile",  
            secretkey="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",  
            result="googleLoginResult",  
            redirecturi="http://localhost:8500/bookbus/cfc/user.cfc?method=googleLogin");
            
		recordCount = loginCheck(googleLoginResult.other.email);

        if ( recordCount == 0 ) {
			id = addUser(name = googleLoginResult.other.given_name, emailId = googleLoginResult.other.email, googleToken = googleLoginResult.id , loginType = "google");
			session.name = "#googleLoginResult.other.given_name#";
			session.id = id.text;
			var loggedIn = true;
			location( "../pages/user/dashBoard.cfm", false );
		} else {
			getUser = getUser(emailId = googleLoginResult.other.email);
			session.name = getUser.FullName;
			session.id = getUser.id;
			var loggedIn = true;
			location( "../pages/user/dashboard.cfm", false );
		}
	}

    remote any function fbLogin(emailId, firstName, lastName, token) output=true returnFormat="plain" {
		
        FullName = "#firstName# #lastName#";
		
        recordCount = loginCheck(emailId, token);
		
        if ( recordCount == 0 ) {
			id = addUser(name = FullName, emailId = emailId, fbToken = token, loginType = "facebook");
			session.name = FullName;
			session.id = id.text;
		} else {
			getUser = getUser(emailId=emailId, fbToken=token);
			session.name = getUser.FullName;
			session.id = getUser.id;
		}
	}
}