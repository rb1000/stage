# Maak een veriabel genaamd = Balance
balance = -10

# Als Balance onder is Print(bericht)
if balance < 0:
    print("Je balans is: " + str(balance) + " Zorg ervoor dat je geld toevoegd of je moet een boete betalen.")

# Als Balance gelijk is aan 0 (bericht)
elif balance == 0:
    print("Je balans is: " + str(balance) + " Euro")


# Als Balance boven 0 print(bericht)
else:
    print("Je balans is: " + str(balance) + "")

