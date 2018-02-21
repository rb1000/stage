import random

number = random.randint(1, 20)

number_of_guesses = 0

over=6

while number_of_guesses < 6:
    print('Gok een nummer tusssen 1 en 20: Je hebt nog ' + str(over) + ' pogingen over')
    guess = input()
    guess = int(guess)

    number_of_guesses = number_of_guesses + 1
    over = over - 1
    if guess < number:
        print('Je gok is te laag')
    
    if guess > number:
        print('Je gok is te hoog')
            
    if guess == number:
        break

if guess == number:
    number_of_guesses = str(number_of_guesses)
    print('Goed gedaan, je hebt mijn nummer in ' + number_of_guesses + ' pogingen geraden!')

if guess != number:
    number = str(number)
    print('Helaas het nummer waar ik aan dacht was ' + number)
