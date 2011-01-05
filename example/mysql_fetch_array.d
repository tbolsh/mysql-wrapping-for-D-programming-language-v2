import std.c.stdio;
import std.stdio;
import mysql;
import mysql_wrapper;

// dmd mysql_fetch_array.d mysql.d mysql_wrapper.d -L/usr/lib/libmysqlclient.so
int main() {
	MYSQL *mysql;
	MYSQL_RES *result;
	string[] values;
	
	mysql = mysql_init(mysql);		
	if (!mysql_connect_d(mysql,"localhost","user","pwd","Video",0,null,0)) {;
		writefln("verbindung fehlgeschlagen");
		return 0;
	}	 
		
	mysql_query_d(mysql, "select * from filme limit 2");

	result = mysql_use_result(mysql);
	
	while ( (values = mysql_fetch_array(result)) != null) {
		foreach (string wert; values) {
			writefln("wert = %s",wert);
		}
	
	}	
	
	
	mysql_close(mysql);	
	return 0;
}	




