module mysql_wrapper;
import mysql;
import std.string;


MYSQL * mysql_connect_d(MYSQL *mysql, string host,string user, string passwd, string db, uint port, string unix_socket, uint clientflag) {
	return mysql_real_connect( mysql, cast(char*) host, cast(char*) user, cast(char*) passwd, cast(char*) db, port,
							   cast(char*) unix_socket, clientflag);
}	

int  mysql_query_d(MYSQL *mysql, string q) {
	return mysql_query(mysql, cast(char*) q);
}

string[] mysql_fetch_array(MYSQL_RES *result) {
    string[] werte;
    static MYSQL_ROW row;
    uint y,count;

    row = mysql_fetch_row(result);
    if (row != null) {
        count = mysql_num_fields(result);
        for ( y = 0; count > y; y++)  {
            werte ~= toString(row[y]);
        }
    } else {
        werte = null;
		mysql_free_result(result);
    }
    return werte;
}

string mysql_escape(string str) {
    string str_escape;
    foreach (char c; str) {
        if (c =='\'') {
            str_escape ~= "\\'";
        } else {
            if (c == '\\') {
                str_escape~= "\\\\";
            } else {
                str_escape ~= c;
            }
        }
    }
    return str_escape;
}

string[string] mysql_fetch_assoc(MYSQL_RES *result) {
    string[string] hash;
    static MYSQL_ROW row;
    uint y=0;
    MYSQL_FIELD *fields;
    //MYSQL_FIELD_OFFSET offset;

    row = mysql_fetch_row(result);
    if (row != null) {
        //offset = mysql_field_seek(result,0);
        mysql_field_seek(result,0);
        while ( (fields = mysql_fetch_field(result)) != null) {
            hash[toString(fields.name)] = cast(string) toString(row[y]);
            y++;
        }
    } else {
        hash = null;
		mysql_free_result(result);
    }
    return hash;
}

