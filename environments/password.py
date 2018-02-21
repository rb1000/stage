# Nieuwe variabel aanmaken | leeg zodat we deze kunnen gebruiken als gebruiker input
password = ''

while password != 'password':
    print("Wat is het wachtwoord?")
    password = input()

    print(" Ja, het wachtwoord is: " + password + ". Je mag verder.")

