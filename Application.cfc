component{

  this.name = "cftasklist";
  this.applicationTimeout = createTimeSpan( 30, 0, 0, 0 ); //30 days
  this.setClientCookies = true;
  this.sessionStorage = true;
  this.sessionTimeout = createTimeSpan( 0, 0, 60, 0 ); // 1 hour 
  this.datasource = "cftasklistdb";
  this.restEnable="true";
  this.restSettings.restPath="cftasklist/api";
  this.restSettings.mapping="cftasklist/api/","";
  this.mappings["/tests"] = expandPath("/tests");
  this.ormEnabled = true;

  // Get environment variables
  env = getEnvironment();
  // Set credentials
  ormSettings = { username = env["CF_DB_USER"], password = env["CF_DB_PASS"]};


  // move to a more secure location
  this.ormSettings = { dialect = "MySQL", dbCreate = "update", logSQL = true, dbFactory = "MySQL5", username = "root", password = "", saveMapping = true};
  public void function onApplicationStart() { dbCreate();}

  // Application root
  this.rootPath = expandPath( "/cftasklist" );

  function onApplicationStart(){}
  function onApplicationEnd( struct applicationScope ) {}

  function onSessionStart() {}
  function onSessionEnd( struct sessionScope, struct applicationScope ) {}

  function onRequestStart( string targetPage ) {
    if(ListFindNoCase(cgi.script_name, "/tests/") > 0){ application.testMode = true;}    
    if(application.testMode){ this.enableCache = false;}    
  }
  function onRequest( string targetPage ) {
    include arguments.targetPage;
  }
  function onRequestEnd() {}
  function onCFCRequest( cfcname, method, struct args) { 
        return;
  } 

  function onError( any Exception, string EventName ) {}
  function onAbort( required string targetPage ) {} 
  function onMissingTemplate( required string targetPage ) {}

}

