//import std.c.stdio;
import std.stdio;
import std.string;
import mysql;


int main() {
	MYSQL *mysql;
	MYSQL_RES *result;
	ubyte[][char[]] hash;
	//char[][char[]] hash;
	
	mysql = mysql_init(null);		
	if (!mysql_real_connect(mysql,"localhost","user","pwd","Video",0,null,0)) {;
		printf("verbindung fehlgeschlagen\n");
		return 0;
	}	 
		
	mysql_query(mysql, "select * from filme limit 2");

	result = mysql_use_result(mysql);
	//while ((hash = mysql_fetch_assoc(result)) != null) {
	while ((hash = db_fetch_assoc(result)) != null) {
		foreach ( char [] key; hash.keys.sort ){
			//printf("hash[key] = %.*s\n",hash[key]);	
			writefln("%s = %s",key,hash[key]);
		}
	}	
	
	mysql_close(mysql);	
	return 0;
}	




