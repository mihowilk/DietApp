import psycopg2
from .config import config

# ssh -L 5432:pascal.fis.agh.edu.pl:5432 8cwierz@pascal.fis.agh.edu.pl


class Connector:
    __instance = None

    @staticmethod
    def getInstance():
        """ Static access method. """
        if Connector.__instance == None:
            Connector()
        return Connector.__instance

    def __init__(self):
        self.conn = None
        self.cur = None
        """ Virtually private constructor. """
        if Connector.__instance != None:
            raise Exception("This class is a singleton!")
        else:
            Connector.__instance = self

    def connect(self):
        try:
            # read connection parameters
            params = config()

            # connect to the PostgreSQL server
            print('Connecting to the PostgreSQL database...')
            self.conn = psycopg2.connect(**params)

            # create a cursor
            self.cur = self.conn.cursor()

            # execute a statement
            print('PostgreSQL database version:')
            self.cur.execute('SELECT version()')

            # display the PostgreSQL database server version
            db_version = self.cur.fetchone()
            print(db_version)

        except (Exception, psycopg2.DatabaseError) as error:
            print(error)

    def disconnect(self):
        self.cur.close()
        self.conn.close()
        print('Database connection closed.')

    def get_column_names(self, table_name):
        self.cur.execute(f"Select * FROM fit_planner.{table_name} LIMIT 0")
        return [desc[0] for desc in self.cur.description]

    def execute_insert(self, table_name, column_names):  # takes multiple arguments
        # Where column names is a tuple or list of all the column headings you want in your query.
        columns = ', '.join(column_names)
        print(column_names)
        query = """ INSERT INTO fit_planner.%s VALUES(default, %s); """ % (
            table_name, columns)
        if column_names == []:
            query = """ INSERT INTO fit_planner.%s VALUES(default); """ % (
                table_name)
        print(query)
        try:
            self.cur.execute(query)
            self.conn.commit()
            return True
        except:
            self.cur.execute("ROLLBACK")
            self.conn.commit()
            return False

    # takes multiple arguments
    def execute_associative_insert(self, table_name, column_names):
        # Where column names is a tuple or list of all the column headings you want in your query.
        columns = ', '.join(column_names)
        query = """ INSERT INTO fit_planner.%s VALUES(%s); """ % (
            table_name, columns)
        print(query)
        try:
            self.cur.execute(query)
            self.conn.commit()
            return True
        except Exception as e:
            print(e)
            self.cur.execute("ROLLBACK")
            self.conn.commit()
            return False

    def execute_select(self, table_name):
        query = """ SELECT * FROM fit_planner.%s; """ % (
            table_name)
        self.cur.execute(query)
        print(query)
        return self.cur.fetchall()

    def execute_delete(self, table_name, id_name, id_val):
        query = """ DELETE FROM fit_planner.%s WHERE %s = %s; """ % (
            table_name, id_name, id_val)
        print(query)
        try:
            self.cur.execute(query)
            self.conn.commit()
            return True
        except Exception as e:
            print(e)
            self.cur.execute("ROLLBACK")
            self.conn.commit()
            return False

    def execute_update(self, table_name, field_name, field_val, id_name, id_val):
        query = """ UPDATE fit_planner.%s SET %s = '%s' WHERE %s = %s; """ % (
            table_name, field_name, field_val, id_name, id_val)
        print(query)
        try:
            self.cur.execute(query)
            self.conn.commit()
            return True
        except Exception as e:
            print(e)
            self.cur.execute("ROLLBACK")
            self.conn.commit()
            return False


def main():
    connector = Connector()
    connector.connect()
    connector.disconnect()


if __name__ == "__main__":
    main()
