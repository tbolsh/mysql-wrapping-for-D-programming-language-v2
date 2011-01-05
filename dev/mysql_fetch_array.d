import std.c.stdio;
import mysql;

int main() {
	MYSQL *mysql;
	MYSQL_RES *result;
	//char[][] values;
	ubyte[][] values;
	
	mysql = mysql_init(mysql);		
	if (!mysql_real_connect(mysql,"localhost","user","pwd","Video",0,null,0)) {;
		printf("verbindung fehlgeschlagen\n");
		return 0;
	}	 
		
	mysql_query(mysql, "select * from filme limit 2");

	result = mysql_use_result(mysql);
	//while ( (values = mysql_fetch_array(result)) != null) {
	while ( (values = db_fetch_array(result)) != null) {
		foreach (ubyte wert[]; values) {
		//foreach (char wert[]; values) {
			printf("wert = %.*s\n",wert);  // That works
			//writefln("wert = %s",wert);  // This not
		}
	}	
	
	mysql_close(mysql);	
	return 0;
}	




