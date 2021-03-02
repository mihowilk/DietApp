import tkinter as tk
from MainComponent.main import MainComponent
from AssociativeComponent.main import AssociativeComponent
from RaportComponent.main import RaportComponent
from Connector.Connector import Connector


class Navbar(tk.Frame):
    def __init__(self, parent, *args, **kwargs):
        tk.Frame.__init__(self, parent, *args, **kwargs)
        self.parent = parent

        self.button = tk.Button(
            self, text='Użytkownik', width=25, command=lambda: self.show_component("uzytkownika", "uzytkownik", "uzytkownik_stat"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Dieta', width=25, command=lambda: self.show_component("diete", "dieta", "dieta"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Przepis', width=25, command=lambda: self.show_component("przepis", "przepis", "przepis_stat"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Ocena', width=25, command=lambda: self.show_component("ocene", "ocena", "ocena"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Skladnik', width=25, command=lambda: self.show_component("skladnik", "skladnik", "skladnik"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Dostawca', width=25, command=lambda: self.show_component("dostawce", "dostawca", "dostawca"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Dzienny plan', width=25, command=lambda: self.show_component("dzienny plan", "dziennyplan", "dziennyplan_stat"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Krok przepisu', width=25, command=lambda: self.show_component("krok przepisu", "przepiskrok", "przepiskrok"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Kategoria przepisu', width=25, command=lambda: self.show_component("kategorie przepisu", "kategoriaprzepisu", "kategoriaprzepisu"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Kategoria skladniku', width=25, command=lambda: self.show_component("kategorie skladniku", "skladnikkategoria", "skladnikkategoria"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Przepis - kategoria', width=25, command=lambda: self.show_associative_component("przepis - kategoria", "przepis_has_kategoriaprzepisu", "przepis_has_kategoriaprzepisu"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Skladnik - kategoria', width=25, command=lambda: self.show_associative_component("skladnik - kategoria", "skladnik_has_skladnikkategoria", "skladnik_has_skladnikkategoria"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Skladnik - dostawca', width=25, command=lambda: self.show_associative_component("skladnik - dostawca", "skladnik_has_dostawca", "skladnik_has_dostawca"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Przepis - skladnik', width=25, command=lambda: self.show_associative_component("przepis - skladnik", "przepis_has_skladnik", "przepis_has_skladnik"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Dieta - dzienny plan', width=25, command=lambda: self.show_associative_component("dieta - dzienny plan", "dieta_has_dziennyplan", "dieta_has_dziennyplan"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Dzieny plan - przepis', width=25, command=lambda: self.show_associative_component("dzieny plan - przepis", "dziennyplan_has_przepis", "dziennyplan_has_przepis"))
        self.button.pack()

        self.button = tk.Button(
            self, text='Lista zakupow', width=25, command=lambda: self.show_raport_component("lista zakupow", "lista_zakupow", "lista_zakupow"))
        self.button.pack()

        self.quitButton = tk.Button(
            self, text='Zamknij okno', width=25, command=self.close_windows)
        self.quitButton.pack()

        self.pack()

    def show_component(self, name, table_name, view_table_name):
        self.newWindow = tk.Toplevel(self.parent)
        self.app = MainComponent(self.newWindow, name=name,
                                 table_name=table_name, view_table_name=view_table_name)

    def show_associative_component(self, name, table_name, view_table_name):
        self.newWindow = tk.Toplevel(self.parent)
        self.app = AssociativeComponent(self.newWindow, name=name,
                                        table_name=table_name, view_table_name=view_table_name)

    def show_raport_component(self, name, table_name, view_table_name):
        self.newWindow = tk.Toplevel(self.parent)
        self.app = RaportComponent(self.newWindow, name=name,
                                   table_name=table_name, view_table_name=view_table_name)

    def close_windows(self):
        self.parent.parent.destroy()


class Main(tk.Frame):
    def __init__(self, parent, *args, **kwargs):
        tk.Frame.__init__(self, parent, *args, **kwargs)
        self.parent = parent
        self.text1 = tk.Text(self, width=30)
        self.text1.pack()
        self.text1.insert(
            tk.END, "UI napisane w Python\nPrzy użyciu biblioteki tkinter\nJednostki miary:\nwaga[kg]\nwzrost[cm]\nczas[s]\nporcja[g]")
        self.pack()


class MainApplication(tk.Frame):
    def __init__(self, parent, *args, **kwargs):
        tk.Frame.__init__(self, parent, *args, **kwargs)
        self.parent = parent

        # self.statusbar = Statusbar(self, ...)
        # self.toolbar = Toolbar(self, ...)
        self.navbar = Navbar(self)
        self.main = Main(self)

        # self.statusbar.pack(side="bottom", fill="x")
        # self.toolbar.pack(side="top", fill="x")
        self.navbar.pack(side="left", fill="y")
        self.main.pack(side="right", fill="both", expand=True)


def main():
    print("Ja łaczyłem się za pomocą: ssh -L 5432:pascal.fis.agh.edu.pl:5432 8cwierz@pascal.fis.agh.edu.pl")
    root = tk.Tk()
    root.title("FIT PLANNER")
    connector = Connector()
    connector.connect()
    MainApplication(root).pack(side="top", fill="both", expand=True)
    root.mainloop()
    connector.disconnect()


if __name__ == "__main__":
    main()
