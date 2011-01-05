import mysql;
import std.stdio;

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
	char* host = cast(char*)"localhost", user=cast(char*)"user",password=cast(char*)"pwd",database=cast(char*)"Video";
	
	if (!mysql_real_connect(mysql,host,user,password,database,0,null,0)) {;
		printf("verbindung fehlgeschlagen\n");
		printf("Leider nicht geklappt\n");
		return 0;
	}	 

		
	mysql_query(mysql, cast(char*)"select * from filme ");

	//result = mysql_use_result(mysql);
	result = mysql_store_result(mysql);
	rows = mysql_num_rows(result);
	printf("rows = %d\n",rows);
	while ((row = mysql_fetch_row(result)) != null) {
		printf("%s ",row[0]);
		printf("%s ",row[1]);
		printf("%s\n",row[2]);
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
	printf("rows = %d\n",rows);
	
	printf("%s\n",mysql_get_server_info(mysql));
	mysql_close(mysql);	

	string escaped = mysql_escape("Hall'o");
	writefln(escaped);
	return 0;
}	




