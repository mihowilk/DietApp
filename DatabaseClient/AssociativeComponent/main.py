import tkinter as tk
from Connector.Connector import Connector


class AddObj(tk.Frame):
    def __init__(self, parent, *args, **kwargs):
        self.name = kwargs["name"]
        self.table_name = kwargs["table_name"]
        del kwargs["name"]
        del kwargs["table_name"]

        tk.Frame.__init__(self, parent, *args, **kwargs)
        self.parent = parent
        self.parent.title("Dodaj " + self.name)
        self.connector = Connector.getInstance()
        self.column_names = self.connector.get_column_names(self.table_name)
        self.field_table = []

        self.counter = 0
        for value in self.column_names:
            field = tk.Entry(self.parent, width=30)
            field.grid(row=self.counter, column=1, padx=20)
            field_label = tk.Label(self.parent, text=value)
            field_label.grid(row=self.counter, column=0, padx=20)
            self.field_table.append(field)
            self.counter += 1

        self.submitButton = tk.Button(
            self.parent, text="Dodaj", command=self.submit)
        self.submitButton.grid(
            row=self.counter, column=0, pady=10, padx=10, ipadx=100)
        self.cancelButton = tk.Button(
            self.parent, text="Anuluj", command=self.close_windows)
        self.cancelButton.grid(
            row=self.counter, column=1, pady=10, padx=10, ipadx=100)

    def submit(self):
        data = []
        for field in self.field_table:
            if field.get() == "":
                data.append("null")
            else:
                data.append("'"+field.get()+"'")
        if(self.connector.execute_associative_insert(self.table_name, data)):
            self.parent.destroy()
        else:
            alert = tk.Label(self.parent, text="Niepoprawne dane")
            alert.grid(row=self.counter+1, column=0,
                       columnspan=2, padx=10, ipadx=100, pady=10)

    def close_windows(self):
        self.parent.destroy()


class DeleteObj(tk.Frame):
    def __init__(self, parent, *args, **kwargs):
        self.name = kwargs["name"]
        self.table_name = kwargs["table_name"]
        del kwargs["name"]
        del kwargs["table_name"]

        tk.Frame.__init__(self, parent, *args, **kwargs)
        self.parent = parent
        self.parent.title("Usuń " + self.name)
        self.connector = Connector.getInstance()
        self.column_names = self.connector.get_column_names(self.table_name)

        self.field = tk.Entry(self.parent, width=30)
        self.field.grid(row=0, column=1, padx=20)
        field_label = tk.Label(self.parent, text=self.column_names[0])
        field_label.grid(row=0, column=0, padx=20)

        self.submitButton = tk.Button(
            self.parent, text="Usuń", command=self.submit)
        self.submitButton.grid(
            row=1, column=0, pady=10, padx=10, ipadx=100)
        self.cancelButton = tk.Button(
            self.parent, text="Anuluj", command=self.close_windows)
        self.cancelButton.grid(
            row=1, column=1, pady=10, padx=10, ipadx=100)

    def submit(self):
        if(self.connector.execute_delete(self.table_name, self.column_names[0], self.field.get())):
            self.parent.destroy()
        else:
            alert = tk.Label(self.parent, text="Niepoprawne dane")
            alert.grid(row=2, column=0,
                       columnspan=2, padx=10, ipadx=100, pady=10)

    def close_windows(self):
        self.parent.destroy()


class UpdateObj(tk.Frame):
    def __init__(self, parent, *args, **kwargs):
        self.name = kwargs["name"]
        self.table_name = kwargs["table_name"]
        del kwargs["name"]
        del kwargs["table_name"]

        tk.Frame.__init__(self, parent, *args, **kwargs)
        self.parent = parent
        self.parent.title("Modyfikuj " + self.name)
        self.connector = Connector.getInstance()
        self.column_names = self.connector.get_column_names(self.table_name)

        self.fieldId = tk.Entry(self.parent, width=30)
        self.fieldId.grid(row=0, column=1, padx=20)
        field_label = tk.Label(self.parent, text=self.column_names[0])
        field_label.grid(row=0, column=0, padx=20)
        self.fieldField = tk.Entry(self.parent, width=30)
        self.fieldField.grid(row=1, column=1, padx=20)
        field_label = tk.Label(self.parent, text="kolumna")
        field_label.grid(row=1, column=0, padx=20)
        self.fieldVal = tk.Entry(self.parent, width=30)
        self.fieldVal.grid(row=2, column=1, padx=20)
        field_label = tk.Label(self.parent, text="nowa wartość")
        field_label.grid(row=2, column=0, padx=20)

        self.submitButton = tk.Button(
            self.parent, text="Modyfikuj", command=self.submit)
        self.submitButton.grid(
            row=3, column=0, pady=10, padx=10, ipadx=100)
        self.cancelButton = tk.Button(
            self.parent, text="Anuluj", command=self.close_windows)
        self.cancelButton.grid(
            row=3, column=1, pady=10, padx=10, ipadx=100)

    def submit(self):
        if(self.connector.execute_update(self.table_name, self.fieldField.get(), self.fieldVal.get(), self.column_names[0], self.fieldId.get())):
            self.parent.destroy()
        else:
            alert = tk.Label(self.parent, text="Niepoprawne dane")
            alert.grid(row=4, column=0,
                       columnspan=2, padx=10, ipadx=100, pady=10)

    def close_windows(self):
        self.parent.destroy()


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
        self.addButton = tk.Button(
            self.parent, text=f'Dodaj {self.name}', width=25, command=self.add_record)
        self.addButton.grid(row=1, column=0, padx=20)
        self.deleteButton = tk.Button(
            self.parent, text=f'Usuń {self.name}', width=25, command=self.delete_record)
        self.deleteButton.grid(row=2, column=0, padx=20)
        self.modifyButton = tk.Button(
            self.parent, text=f'Modyfikuj {self.name}', width=25, command=self.modify_record)
        self.modifyButton.grid(row=3, column=0, padx=20)
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

    def add_record(self):
        self.newWindow = tk.Toplevel(self.parent)
        self.app = AddObj(self.newWindow, name=self.name,
                          table_name=self.table_name)

    def delete_record(self):
        self.newWindow = tk.Toplevel(self.parent)
        self.app = DeleteObj(self.newWindow, name=self.name,
                             table_name=self.table_name)

    def modify_record(self):
        self.newWindow = tk.Toplevel(self.parent)
        self.app = UpdateObj(self.newWindow, name=self.name,
                             table_name=self.table_name)

    def close_windows(self):
        self.parent.parent.destroy()


class AssociativeComponent(tk.Frame):
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
