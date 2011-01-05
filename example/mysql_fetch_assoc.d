import std.stdio;
import mysql;
import mysql_wrapper;
// Example, how to compile
//dmd mysql_fetch_assoc.d mysql.d mysql_wrapper.d -L/usr/lib/libmysqlclient.so
//gdmd mysql_fetch_assoc.d mysql.d mysql_wrapper.d -L/usr/lib/libmysqlclient.so

int main() {
	MYSQL *mysql;
	MYSQL_RES *result;
	string[string] hash;
	
	mysql = mysql_init(null);		
	if (!mysql_connect_d(mysql,"localhost","user","pwd","Video",0,null,0)) {
		writefln("Verbindung fehlgeschlagen");
		return 0;
	}	 
		
	mysql_query_d(mysql, "select * from filme limit 2");

	result = mysql_use_result(mysql);
	while ((hash = mysql_fetch_assoc(result)) != null) {
		foreach ( string key; hash.keys.sort ) {
			writefln("%s = %s",key,hash[key]);
		}
	}	
	
	mysql_close(mysql);	
	return 0;
}	




