component {

	private function getUser(id="0", emailId="") {

		userDetails = queryExecute("SELECT * FROM br_user WHERE id = :id OR email = :emailId", {id=id, emailId=emailId});
        
        return userDetails;
	}

    private function addUser(name, emailId="", password="", googleToken="", facebookToken="", loginType, role="2") {
		
        cfquery( name="addUser", result="addUserResult" ) { 

			writeOutput("insert into br_user (fullname, email, password, google_token, facebook_token, login_type, user_role, created_on)
            values
            (");
			cfqueryparam( cfsqltype="CF_SQL_NVARCHAR", value=name );

			writeOutput(",");
			cfqueryparam( cfsqltype="CF_SQL_NVARCHAR", value=emailId );

			writeOutput(",");
			cfqueryparam( cfsqltype="CF_SQL_NVARCHAR", value=hash(password) );

			writeOutput(",");
			cfqueryparam( cfsqltype="CF_SQL_NVARCHAR", value=googleToken );

			writeOutput(",");
			cfqueryparam( cfsqltype="CF_SQL_NVARCHAR", value=facebookToken );

			writeOutput(",");
			cfqueryparam( cfsqltype="CF_SQL_NVARCHAR", value=loginType );

			writeOutput(",");
			cfqueryparam( cfsqltype="CF_SQL_INTEGER", value=role );

			writeOutput(",");
			cfqueryparam( cfsqltype="CF_SQL_TIMESTAMP", value=now() );

			writeOutput(")");
		}
		
        return addUserResult.generatedkey;
	}

    private function loginCheck(required emailId) {
		
        cfquery( name="loginCheck", result="loginCheckResult" ) {

			writeOutput("SELECT * FROM br_user where email =");
			cfqueryparam( cfsqltype="CF_SQL_NVARCHAR", value=emailId );
		}
		
        return loginCheckResult.recordCount;
	}

    remote function login(required emailId, required password) {
		
        cfquery( name="login", result="loginResult" ) { 

			writeOutput("SELECT * FROM br_user WHERE email =");
			cfqueryparam( cfSqlType="CF_SQL_NVARCHAR", value=emailId );

			writeOutput("AND
            Password =");
			cfqueryparam( cfsqltype="CF_SQL_NVARCHAR", value=hash(password) );
		}

		recordCount = loginResult.recordCount;

		if ( recordCount == 0 ) {

			writeOutput("<script>
                alert('Invalid username or password');
                window.location.href='../pages/user/index.cfm';
            </script>");
		} else {
			session.id = login.id;
			session.name = login.fullName;
			location( "../pages/user/dashBoard.cfm", false );
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
			id = addUser(name = name, emailId = emailId, password = password, loginType = "web", role = role);
			session.name = name;
			session.id = id;
			location( "../pages/user/dashboard.cfm", false );
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
			id = addUser(name = googleLoginResult.other.given_name, emailId = googleLoginResult.other.email, googlToken = googleLoginResult.access_token , loginType = "google");
			session.name = "#googleLoginResult.other.given_name#";
			session.id = id;
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
		
        recordCount = loginCheck(emailId);
		
        if ( recordCount == 0 ) {
			id = addUser(name = FullName, emailId = emailId, facebookToken = token, loginType = "facebook");
			session.name = FullName;
			session.id = id;
		} else {
			getUser = getUser(emailId = emailId);
			session.name = getUser.FullName;
			session.id = getUser.id;
		}
	}
}