<cfcomponent>
    <cffunction  name="getUser" access="private">
        <cfargument  name="userId" default="0">
        <cfargument  name="emailId" default="">

        <cfquery datasource="busbooking" name="userDetails" result="userDetails">
            SELECT * FROM users Where 
            userId = <cfqueryparam value="#arguments.userId#" cfSqlType="CF_SQL_INTEGER">
            OR
            emailId = <cfqueryparam value="#arguments.emailId#" cfSqlType="CF_SQL_NVARCHAR">
        </cfquery>

        <cfreturn userDetails>
    </cffunction>

    <cffunction  name="addUser" access="private">
        <cfargument  name="name">
        <cfargument  name="userName">
        <cfargument  name="emailId">
        <cfargument  name="phoneNumber">
        <cfargument  name="role">
        <cfargument  name="password">

        <cfquery datasource="busbooking" name="addUser" result="addUserResult">
            INSERT INTO users (fullName, userName, password, emailId, phoneNumber, RoleId)
            Values
            (<cfqueryparam value="#arguments.name#" cfSqlType="CF_SQL_NVARCHAR">,
            <cfqueryparam value="#arguments.userName#" cfSqlType="CF_SQL_NVARCHAR">,
            <cfqueryparam value="#hash(arguments.password)#" cfSqlType="CF_SQL_NVARCHAR">,
            <cfqueryparam value="#arguments.emailId#" cfSqlType="CF_SQL_NVARCHAR">,
            <cfqueryparam value="#arguments.phoneNumber#" cfSqlType="CF_SQL_NVARCHAR">,
            <cfqueryparam value="#arguments.role#" cfSqlType="CF_SQL_INTEGER">)
        </cfquery>

        <cfreturn addUserResult.generatedkey>
    </cffunction>

    <cffunction  name="loginCheck" access="private">
        <cfargument  name="emailId" required="true">

        <cfquery datasource="busbooking" name="loginCheck" result="loginCheckResult">
            SELECT * FROM users where emailId = <cfqueryparam value="#arguments.emailId#" cfSqlType="CF_SQL_NVARCHAR">
        </cfquery>

        <cfreturn loginCheckResult.recordCount>
    </cffunction>

    <cffunction  name="login" access="remote">
        <cfargument  name="userName" required="true">
        <cfargument  name="password" required="true">
        
        <cfquery datasource="busbooking" name="login" result="loginResult">
            SELECT * FROM users WHERE UserName = <cfqueryparam value="#arguments.userName#" cfSqlType="CF_SQL_NVARCHAR">
            AND
            Password = <cfqueryparam value="#hash(arguments.password)#">
        </cfquery>
        <cfset recordCount = loginResult.recordCount>
        
        <cfif recordCount eq 0>
            <script>
                alert('Invalid username or password');
                window.location.href='../login.cfm';
            </script>
        <cfelse>
            <cfset session.userId = login.userId>
            <cfset session.name = login.fullName>
            <cflocation  url="../dashBoard.cfm" addToken="false">
        </cfif>
    </cffunction>

    <cffunction  name="logout" access="remote">
        <cfset structDelete(session, "userId")>
        <cfset structDelete(session, "name")>    

        <cflocation  url="../index.cfm" addtoken="no">
    </cffunction>

    <cffunction  name="register" access="remote">
        <cfargument  name="name" required="true">
        <cfargument  name="userName" required="true">
        <cfargument  name="emailId" required="true">
        <cfargument  name="phoneNumber" required="true">
        <cfargument  name="role">
        <cfargument  name="password" required="true">

        <cfset recordCount = loginCheck(arguments.emailId)>
        <cfif recordCount eq 0>
            <cfset userId = addUser(arguments.name, arguments.userName, arguments.emailId, arguments.phoneNumber, arguments.role, arguments.password)>
            <cfset session.name = arguments.name>
            <cfset session.userId = userId> 
            <cflocation  url="../dashboard.cfm" addToken="false">
        <cfelse>
            <script>
                alert('User already exist please login');
                window.location.href='../login.cfm';
            </script>  
        </cfif>
    </cffunction>

    <cffunction name="googleLogin" access="remote">
        <cfset var loggedIn = false>
        <cfoauth
            Type="Google"
            clientid="856324982681-nd2gqlm9vqlildtenbahlbs7gpmr2i6i.apps.googleusercontent.com" 
            scope="https://www.googleapis.com/auth/userinfo.email+https://www.googleapis.com/auth/userinfo.profile"
            secretkey="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" 
            result="googleLoginResult"  
            redirecturi="http://127.0.0.1:8500/BusTicketReservation/components/user.cfc?method=googleLogin">
            
            <cfset recordCount = loginCheck(googleLoginResult.other.email)>
            
            <cfif recordCount eq 0>
                <cfset userId = addUser(googleLoginResult.other.given_name, googleLoginResult.other.given_name, googleLoginResult.other.email)>
                
                <cfset session.name = "#googleLoginResult.other.given_name#">
                <cfset session.userId = "#userId#"> 
                <cfset var loggedIn = true>
                <cflocation  url="../userDetails.cfm" addToken="no">
            <cfelse>
                <cfset getUser = getUser(emailId = googleLoginResult.other.email)>

                <cfset session.name = getUser.FullName>
                <cfset session.userId = getUser.UserId>
                <cfset var loggedIn = true>
                <cflocation  url="../dashboard.cfm" addToken="no">
            </cfif>            
    </cffunction>

    <cffunction name="fbLogin" access="remote" returnformat='plain' returntype='any' output='true'>
        <cfargument name="emailId">
		<cfargument name="firstName">
		<cfargument name="lastName">

        <cfset FullName = "#firstName# #lastName#">

        <cfset recordCount = loginCheck(arguments.emailId)>

        <cfif recordCount eq 0>
            <cfset userId = addUser(FullName, arguments.firstName, arguments.emailId)>
            <cfset session.name = FullName>
            <cfset session.userId = userId> 
        <cfelse>
            <cfset getUser = getUser(emailId = arguments.emailId)>
            <cfset session.name = getUser.FullName>
            <cfset session.userId = getUser.UserId>
        </cfif>
    </cffunction>
</cfcomponent>