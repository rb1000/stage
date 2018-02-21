# Het defineren van een functie
def world():
    print("Hello, World!")

# Roep een fucntie op in de module zelf
world()

# Defineer een variabel
shark = "Sammy"

# Defineer een class
class Octopus:
    def __init__(self, name, color):
        self.color = color
        self.name = name

    def tell_me_about_the_octopus(self):
        print("Deze octopus is: " + self.color + ".")
        print(self.name + " Is de naam van de octopus.")
