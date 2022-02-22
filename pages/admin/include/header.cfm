<!DOCTYPE html>
<html lang="en">
   <head>
      <title>Admin | Bus Booking</title>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta name="description" content="Portal - Bootstrap 5 Admin Dashboard Template For Developers">
      <meta name="author" content="Xiaoying Riley at 3rd Wave Media">
      <link rel="shortcut icon" href="favicon.ico">
      <script defer src="../../assets/admin/plugins/fontawesome/js/all.min.js"></script>
      <link id="theme-style" rel="stylesheet" href="../../assets/admin/css/portal.css">
   </head>
   <body class="app">
      <header class="app-header fixed-top">
         <div class="app-header-inner">
            <div class="container-fluid py-2">
               <div class="app-header-content">
                  <div class="row justify-content-between align-items-center">
                     <div class="col-auto">
                        <a id="sidepanel-toggler" class="sidepanel-toggler d-inline-block d-xl-none" href="#">
                           <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 30 30" role="img">
                              <title>Menu</title>
                              <path stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="2" d="M4 7h22M4 15h22M4 23h22"></path>
                           </svg>
                        </a>
                     </div>
                     <div class="search-mobile-trigger d-sm-none col">
                        <i class="search-mobile-trigger-icon fas fa-search"></i>
                     </div>
                     <div class="app-search-box col">
                        <form class="app-search-form">   
                           <input type="text" placeholder="Search..." name="search" class="form-control search-input">
                           <button type="submit" class="btn search-btn btn-primary" value="Search"><i class="fas fa-search"></i></button> 
                        </form>
                     </div>
                     <div class="app-utilities col-auto">
                        <div class="app-utility-item app-user-dropdown dropdown">
                           <a class="dropdown-toggle" id="user-dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false"><img src="../../assets/admin/images/user.png" alt="user profile"></a>
                           <ul class="dropdown-menu" aria-labelledby="user-dropdown-toggle">
                              <li><a class="dropdown-item" href="#">Account</a></li>
                              <li><a class="dropdown-item" href="#">Settings</a></li>
                              <li>
                                 <hr class="dropdown-divider">
                              </li>
                              <li><a class="dropdown-item" href="#">Log Out</a></li>
                           </ul>
                        </div> 
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <div id="app-sidepanel" class="app-sidepanel">
            <div id="sidepanel-drop" class="sidepanel-drop"></div>
            <div class="sidepanel-inner d-flex flex-column">
               <a href="#" id="sidepanel-close" class="sidepanel-close d-xl-none">&times;</a>
               <div class="app-branding">
                  <a class="app-logo" href="index.html"><img class="logo-icon me-2" src="../../assets/admin/images/app-logo.svg" alt="logo"><span class="logo-text">Ticket+</span></a>
               </div>
               <nav id="app-nav-main" class="app-nav app-nav-main flex-grow-1">
                  <ul class="app-menu list-unstyled accordion" id="menu-accordion">
                     <li class="nav-item">
                        <a class="nav-link" href="index.cfm">
                           <span class="nav-icon">
                              <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-house-door" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                 <path fill-rule="evenodd" d="M7.646 1.146a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 .146.354v7a.5.5 0 0 1-.5.5H9.5a.5.5 0 0 1-.5-.5v-4H7v4a.5.5 0 0 1-.5.5H2a.5.5 0 0 1-.5-.5v-7a.5.5 0 0 1 .146-.354l6-6zM2.5 7.707V14H6v-4a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5v4h3.5V7.707L8 2.207l-5.5 5.5z"/>
                                 <path fill-rule="evenodd" d="M13 2.5V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"/>
                              </svg>
                           </span>
                           <span class="nav-link-text">Dashboard</span>
                        </a>
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="sample_form.cfm">
                           <span class="nav-icon">
                              <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-folder" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                 <path d="M9.828 4a3 3 0 0 1-2.12-.879l-.83-.828A1 1 0 0 0 6.173 2H2.5a1 1 0 0 0-1 .981L1.546 4h-1L.5 3a2 2 0 0 1 2-2h3.672a2 2 0 0 1 1.414.586l.828.828A2 2 0 0 0 9.828 3v1z"/>
                                 <path fill-rule="evenodd" d="M13.81 4H2.19a1 1 0 0 0-.996 1.09l.637 7a1 1 0 0 0 .995.91h10.348a1 1 0 0 0 .995-.91l.637-7A1 1 0 0 0 13.81 4zM2.19 3A2 2 0 0 0 .198 5.181l.637 7A2 2 0 0 0 2.826 14h10.348a2 2 0 0 0 1.991-1.819l.637-7A2 2 0 0 0 13.81 3H2.19z"/>
                              </svg>
                           </span>
                           <span class="nav-link-text">Sample Form</span>
                        </a>
                     </li>

                     <!--Bus section menus-->

                     <cfif FindNoCase('addnewbus.cfm', cgi.script_name)>
                           <cfset parentbusexpanded   = 'true'   />
                           <cfset parentbusshow       = 'show'   />
                           <cfset parentbusactive     = 'active' />
                           <cfset newbusactive        = 'active' />
                        <cfelse>
                           <cfset parentbusexpanded   = 'false' />
                           <cfset parentbusshow       = '' />
                           <cfset parentbusactive     = '' />
                           <cfset newbusactive        = '' />
                     </cfif>
                     <cfif FindNoCase('listbus.cfm', cgi.script_name)>
                           <cfset parentbusexpanded   = 'true'   />
                           <cfset parentbusshow       = 'show'   />
                           <cfset parentbusactive     = 'active' />
                           <cfset listbusactive        = 'active' />
                        <cfelse>
                           <cfset parentbusexpanded   = 'false' />
                           <cfset parentbusshow       = '' />
                           <cfset parentbusactive     = '' />
                           <cfset listbusactive       = '' />
                     </cfif>
                     <li class="nav-item has-submenu">
                        <a class="nav-link submenu-toggle <cfoutput>#parentbusactive#</cfoutput>" href="#" data-bs-toggle="collapse" data-bs-target="#submenu-1" aria-expanded="<cfoutput>#parentbusexpanded#</cfoutput>" aria-controls="submenu-1">
                           <span class="nav-icon">
                              <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-files" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                              <path fill-rule="evenodd" d="M4 2h7a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2zm0 1a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h7a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1H4z"/>
                              <path d="M6 0h7a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2v-1a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H6a1 1 0 0 0-1 1H4a2 2 0 0 1 2-2z"/>
                              </svg>
                           </span>
                           <span class="nav-link-text">Buses</span>
                           <span class="submenu-arrow">
                              <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-down" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                              <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
                              </svg>
                           </span>
                        </a>
                        <div id="submenu-1" class="collapse submenu submenu-1 <cfoutput>#parentbusshow#</cfoutput>" data-bs-parent="#menu-accordion">
                           <ul class="submenu-list list-unstyled">
                              <li class="submenu-item">
                                 <a class="submenu-link <cfoutput>#listbusactive#</cfoutput>" href="listbus.cfm">List All Bus</a>
                              </li>
                              <li class="submenu-item">
                                 <a class="submenu-link  <cfoutput>#newbusactive#</cfoutput>" href="addnewbus.cfm">
                                    Add New Bus
                                 </a>
                              </li>
                           </ul>
                        </div>
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="state.cfm">
                           <span class="nav-icon">
                                 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right-square-fill" viewBox="0 0 16 16">
                                    <path d="M0 14a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v12zm4.5-6.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5a.5.5 0 0 1 0-1z"/>
                                 </svg>
                           </span>
                           <span class="nav-link-text">State</span>
                        </a>
                     </li>

                     <li class="nav-item">
                        <a class="nav-link" href="city.cfm">
                           <span class="nav-icon">
                                 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-list-nested" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M4.5 11.5A.5.5 0 0 1 5 11h10a.5.5 0 0 1 0 1H5a.5.5 0 0 1-.5-.5zm-2-4A.5.5 0 0 1 3 7h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm-2-4A.5.5 0 0 1 1 3h10a.5.5 0 0 1 0 1H1a.5.5 0 0 1-.5-.5z"/>
                                 </svg>
                           </span>
                           <span class="nav-link-text">City</span>
                        </a>
                     </li>

                     <li class="nav-item">
                        <a class="nav-link" href="bus_booking_view.cfm">
                           <span class="nav-icon">
                                 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bricks" viewBox="0 0 16 16">
                                    <path d="M0 .5A.5.5 0 0 1 .5 0h15a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-.5.5H14v2h1.5a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-.5.5H14v2h1.5a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-.5.5H.5a.5.5 0 0 1-.5-.5v-3a.5.5 0 0 1 .5-.5H2v-2H.5a.5.5 0 0 1-.5-.5v-3A.5.5 0 0 1 .5 6H2V4H.5a.5.5 0 0 1-.5-.5v-3zM3 4v2h4.5V4H3zm5.5 0v2H13V4H8.5zM3 10v2h4.5v-2H3zm5.5 0v2H13v-2H8.5zM1 1v2h3.5V1H1zm4.5 0v2h5V1h-5zm6 0v2H15V1h-3.5zM1 7v2h3.5V7H1zm4.5 0v2h5V7h-5zm6 0v2H15V7h-3.5zM1 13v2h3.5v-2H1zm4.5 0v2h5v-2h-5zm6 0v2H15v-2h-3.5z"/>
                                 </svg>
                           </span>
                           <span class="nav-link-text">Booking list</span>
                        </a>
                     </li>


                    <!---------------- ADD MENU END HERE ------------------------>
                  </ul>
               </nav>
               <div class="app-sidepanel-footer">
                  <nav class="app-nav app-nav-footer">
                     <ul class="app-menu footer-menu list-unstyled">
                     </ul>
                  </nav>
               </div>
            </div>
         </div>
      </header>
      <div class="app-wrapper">
      <div class="app-content pt-3 p-md-3 p-lg-4">
      <div class="container-xl">
