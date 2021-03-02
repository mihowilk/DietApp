import tkinter as tk
from Connector.Connector import Connector


class Navbar(tk.Frame):
    def __init__(self, parent, *args, **kwargs):
        self.name = kwargs["name"]
        self.table_name = kwargs["table_name"]
        self.view_table_name = kwargs["view_table_name"]
        del kwargs["name"]
        del kwargs["table_name"]
        del kwargs["view_table_name"]
        tk.Frame.__init__(self, parent, *args, **kwargs)
        self.connector = Connector.getInstance()
        self.parent = parent
        self.show_buttons()

    def show_buttons(self):
        self.showButton = tk.Button(
            self.parent, text=f'Pokaż/Odśwież tabele {self.name}', width=25, command=self.show_record)
        self.showButton.grid(row=0, column=0, padx=20)
        self.quitButton = tk.Button(
            self.parent, text='Zamknij okno', width=25, command=self.close_windows)
        self.quitButton.grid(row=4, column=0, padx=20)

    def show_record(self):
        data_table = self.connector.execute_select(self.view_table_name)
        column_names = self.connector.get_column_names(
            self.view_table_name)
        for idx, column in enumerate(column_names):
            record = tk.Label(self.parent, text=column)
            record.grid(row=0, column=idx+1, padx=20)
        for idx, rows in enumerate(data_table):
            for jdx, data in enumerate(rows):
                record = tk.Label(self.parent, text=data)
                record.grid(row=idx+1, column=jdx+1, padx=20)

    def close_windows(self):
        self.parent.parent.destroy()


class RaportComponent(tk.Frame):
    def __init__(self, parent, *args, **kwargs):
        self.name = kwargs["name"]
        self.table_name = kwargs["table_name"]
        self.view_table_name = kwargs["view_table_name"]
        del kwargs["name"]
        del kwargs["table_name"]
        del kwargs["view_table_name"]

        tk.Frame.__init__(self, parent, *args, **kwargs)
        self.parent = parent
        self.parent.title("Tabela " + self.table_name)

        self.navbar = Navbar(
            self, name=self.name, table_name=self.table_name, view_table_name=self.view_table_name)

        self.pack()
