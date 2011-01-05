import std.c.stdio;
import mysql;
import std.stdio;
import mysql_wrapper;

// gdc -c -fPIC -g  mysql_wrapper.d
// gdc -c -fPIC -g  mysql.d
// gdc -shared -o libmysql.so mysql_wrapper.o mysql.o
// gcc -shared -Wl,-soname,libmysql.so -o libmystuff.so.1 libmysql.o mysql_wrapper.o
// sudo cp libmysql.so /usr/local/lib
// sudo ln -s libmysql.so.1 libmysql.so
// sudo ln -s  libmysqlclient.so.15 libmysqlclient.so
// gdc -o mysql_shared mysql_shared.d -lmysqlclient -lmysql

int main() {
	MYSQL *mysql;
	MYSQL_RES *result;
	string[] values;
	
	mysql = mysql_init(mysql);		
	if (!mysql_real_connect(mysql,cast(char*)"localhost",cast(char*)"user",cast(char*)"pwd",cast(char*)"Video",0,null,0)) {;
		writefln("verbindung fehlgeschlagen\n");
		return 0;
	}	 
		
	//mysql_query(mysql, cast(char*)"select * from filme limit 2");
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




