require 'bundler'
require 'rest-client'
require 'json'
require 'faker'
# require 'colorized_string'
# require 'colorize'
require 'io/console'
require 'tty-cursor'
require 'tty-screen'
require 'tty-font'
require 'pastel'

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil

require_all 'lib/modules'
require_all 'lib/combat'
require_all 'lib/models'
require_all 'lib'

MY_ANIMAL_FAKER = ["alligator", "crocodile", "alpaca", "ant", "antelope", "ape", "armadillo", "donkey", "baboon", "badger", "bat", "bear", "beaver", "bee", "beetle", "buffalo", "butterfly", "camel", "water buffalo", "caribou", "cat", "cattle", "cheetah", "chimpanzee", "chinchilla", "cicada", "clam", "cockroach", "cod", "coyote", "crab", "cricket", "crow",  "raven", "deer", "dinosaur", "dog", "dolphin", "porpoise", "duck", "eagle", "eel", "elephant", "elk", "ferret", "fish", "fly", "fox", "frog", "toad", "gerbil", "giraffe", "gnat", "gnu ", "wildebeest", "goat", "goldfish", "goose", "gorilla", "grasshopper", "guinea pig", "hamster", "hare", "hedgehog", "herring", "hippopotamus", "hornet", "horse", "hound", "hyena", "impala", "jackal", "jellyfish", "kangaroo ", "wallaby", "koala", "leopard", "lion", "lizard", "llama", "locust", "louse", "macaw", "mallard", "mammoth", "manatee", "marten", "mink", "minnow", "mole", "monkey", "moose", "mosquito", "mouse", "rat", "mule", "muskrat", "otter", "ox", "oyster", "panda", "pig", "platypus", "porcupine", "prairie dog", "pug", "rabbit", "raccoon", "reindeer", "rhinoceros", "salmon", "sardine", "scorpion", "seal ", "sea lion", "serval", "shark", "sheep", "skunk", "snail", "snake", "spider", "squirrel", "swan", "termite", "tiger", "trout", "turtle ", "tortoise", "walrus", "wasp", "weasel", "whale", "wolf", "wombat", "woodchuck", "worm", "yak", "yellowjacket", "zebra"]

SCREEN_SIZE = TTY::Screen.size
CURSOR = TTY::Cursor
PASTEL = Pastel.new

SLEEP_TIME = 2
