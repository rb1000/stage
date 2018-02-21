grade = 70

if grade >= 65:
    print("Passing grade of:")

# Als cijfer 65 is of hoger Print(bericht)
if grade >= 90:
    if grade > 96:
        print("A+")

    elif grade > 93 and grade <= 96:
        print("A")

    elif grade >= 90:
        print("A-")


elif grade >= 80:
    print("Je hebt een goed cijfer B")

elif grade >= 70:
    print("Je hebt eem mooi cijfer C")

elif grade >= 65:
    print("Je hebt een voldoende D")

# Als je cijfer onder de 65 is dan print(bericht)
else:
    print("Je cijfer is te laag zo ga je niet over")
