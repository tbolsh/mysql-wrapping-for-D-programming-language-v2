import mysql;
import std.stdio;
import std.string;

//dmd -c mysql_test.d mysql.d
//gcc  mysql_test.o mysql.o  -o mysql_test -lphobos -lpthread -lm -lmysqlclient
//dmd mysql_test.d mysql.d -L/usr/lib/libmysqlclient.so 
//http://dev.mysql.com/doc/mysql/en/C.html
//http://dev.mysql.com/doc/mysql/de/C.html
// Tested with mysql-5.0.13
//dmd mysql_test.d mysql.d -L/home/hansen/mysql-5.0.13-rc/libmysql/.libs/libmysqlclient.so

//gdc -o  mysql_test mysql_test.d mysql.d -lmysqlclient  

int main() {
	MYSQL *mysql;
	MYSQL_RES *result;
	MYSQL_ROW row;
	ulong rows;
	
	mysql = mysql_init(null);		
	if (!mysql_real_connect(mysql,cast(char*)"localhost",cast(char*)"user",cast(char*)"pwd",cast(char*)"Video",0,null,0)) {
		writefln("verbindung fehlgeschlagen");
		return 0;
	}	 
	writefln("mysql: %s",mysql);

		
	mysql_query(mysql, cast(char*)"select * from filme ");

	//result = mysql_use_result(mysql);
	result = mysql_store_result(mysql);
	rows = mysql_num_rows(result);
	printf("rows = %d\n",rows);
	while ((row = mysql_fetch_row(result)) != null) {
		writef("%s ",toString(row[0]));
		writef("%s ",toString(row[1]));
		writefln("%s ",toString(row[2]));
	}	
	
	
	string play = mysql_escape("Long Play's");	
	writefln("play = %s",play);
	string query = std.string.format("insert into filme (name,genre,beginn,laenge,kassette,film,bem,freigabe) 
					  values 
					  ('Stirb langsam1','Hallo\n','00:00:00','120','1','1','%s', 'Nein')",play);
	mysql_query(mysql,cast(char*)query);
	//mysql_query(mysql, "insert into filme (name,genre,beginn,laenge,kassette,film,bem,freigabe) values ('Stirb langsam1','Actionfilm','00:00:00','120','1','1',play, 'Nein')");
	
	mysql_query(mysql, cast(char*)"delete from filme where nr = '2'");
	
	rows = mysql_affected_rows(mysql);
	writefln("rows = %d\n",rows);
	
	writefln("%s",toString(mysql_get_server_info(mysql)));
	mysql_close(mysql);	

	string escaped = mysql_escape("Hall'o");
	writefln(escaped);
	
	return 0;
}	




