import mysql;
import mysql_wrapper;
import std.stdio;
import std.c.process;

int main(char[][] args)
{
	MYSQL *mysql;
	MYSQL_RES *result;
	string[string] hash;
	string[] array;

	mysql = mysql_init(null);
	if (!mysql_connect_d(mysql,"localhost","user","pwd","Video",0,null,0)) {
		writefln("Verbindung fehlgeschlagen");
		return 0;
	}

	int i = 0;
	while(true) {
		mysql_query_d(mysql, "select * from filme where nr in (1,4)");
		result = mysql_use_result(mysql);
		//while (( array = mysql_fetch_array(result)) != null) {
		while (( hash = mysql_fetch_assoc(result)) != null) {
			foreach ( string key; hash.keys.sort ) {
				writefln("%s = %s",key,hash[key]);
			}
		}
		writeln();
	}

	mysql_close(mysql);
	return 0;
}
