# Orginele Woordenboek
usernames = {'Sammy': 'sammy-shark', 'Jamie': ' mantisshrimp54'}

# Het op zetten van de While loop
while True:

    #Het invoeren van een gebruikersnaam
    print('Voer een naam in:')

    # Toevoegen van variabel aan naam
    naam = input()

    # Kijken of de naam al in het woordenboek voorkomt en geeft de uitkomst terug
    if naam in usernames:
        print(usernames[naam] + ' Is de gebruikersnaam van ' + naam)

        # Als de naam niet voorkomt in het woordenboek
    else:

        #Feedback teruggeven
        print('Ik heb geen naam genaamd ' + naam + 'Wat is de juiste naam?')

        # Voeg een nieuwe naam toe voor de nieuwe gebruiker
        username = input()

        # Voeg username toe aan de naam key
        usernames[naam] = username

        # Voeg feedback toe om aan te geven dat de dat is aangepast
        print('Data is toegevoegd.')
