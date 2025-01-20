extends Node

var score: int = 0

var farm_creature_count = {
	# Common
	"Ant": 0,
	"Ladybug": 0,
	"Gnat": 0,
	"Moth": 0,
	"Grasshopper": 0,
	"Praying_mantis": 0,
	"Dandelion": 0,
	"Clover": 0,
	"Daisy": 0,
	"Wild_grass": 0,
	"Poppy": 0,
	"Calendula": 0,

	# Uncommon
	"Dragonfly": 0,
	"Wild_bee": 0,
	"Butterfly_caterpillar": 0,
	"Cricket": 0,
	"Tussock_moth": 0,
	"Chamomile": 0,
	"Lavender": 0,
	"Mint": 0,
	"Fern": 0,
	"Tomato": 0,

	# Rare
	"Monarch_butterfly": 0,
	"Rhinoceros_beetle": 0,
	"Blowfly": 0,
	"Jumping_spider": 0,
	"Giant_sunflower": 0,
	"Garden_cactus": 0,
	"Roses": 0,
	"Pumpkin": 0,

	# Epic
	"Atlas Moth": 0,
	"Imperial_dragonfly": 0,
	"Bengal_beetle": 0,
	"Carnivorous Plant": 0,
	"Giant_cactus": 0,
	"Water_lotus": 0,

	# Legendary
	"Titanus_giganteus": 0,
	"Blue_morpho_butterfly": 0,
	"Baobab": 0,
	"Olive_tree": 0,

	# Mythic
	"Titan_beetle": 0,
	"Ghost_orchid": 0
}
