import random
import string


def get_random_password(length: int = 20):
    # Generate a list of random characters
    characters = [random.choice(string.ascii_letters + string.digits + string.punctuation) for _ in range(length)]
    # Shuffle the list of characters
    random.shuffle(characters)
    # Return the shuffled list of characters as a string
    return ''.join(characters).replace('\'', '')


def random_string(length: int = 20):
    result_str = ''.join(random.choice(string.ascii_letters) for _ in range(length))
    return result_str
