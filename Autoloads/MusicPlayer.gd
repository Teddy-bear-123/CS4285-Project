extends Node

var songs = []
var audio_player: AudioStreamPlayer

func _ready():
    # Create the audio player
    audio_player = AudioStreamPlayer.new()
    add_child(audio_player)
    audio_player.finished.connect(_on_song_finished)
    
    # Load all your music files
    songs = [
        preload("res://assets/music/At Doom's Gate.ogg"),
        preload("res://assets/music/Mick Gordon - 02. Rip & Tear.ogg"),
        preload("res://assets/music/Hellwalker.ogg"),
        preload("res://assets/music/Bfg Division.ogg"),
        preload("res://assets/music/Mick Gordon - 30. Mastermind.ogg"),
        preload("res://assets/music/Mick Gordon - 19. Cyberdemon.ogg"),
        preload("res://assets/music/Doom Eternal OST - The Only Thing They Fear Is You (Mick Gordon) [Doom Eternal Theme].ogg"),
        preload("res://assets/music/DOOM Eternal OST - meathook (Mick Gordon).ogg"),
        preload("res://assets/music/DOOM Eternal OST - Cultist Base.ogg"),
        preload("res://assets/music/Mick Gordon - The Super Gore Nest (DOOM Eternal - Gamerip) [REUPLOAD].ogg"),
        preload("res://assets/music/Mick Gordon - BFG 10K (DOOM Eternal - Gamerip) [REUPLOAD].ogg"),
        preload("res://assets/music/Mick Gordon - The DOOM Hunter (DOOM Eternal - Gamerip) [REUPLOAD].ogg"),
        preload("res://assets/music/DOOM Eternal Soundtrack： Urdak (Ambient).ogg"),
        preload("res://assets/music/The Icon of Sin.ogg"),
        preload("res://assets/music/Doom OST - E1M1 - At Doom's Gate.ogg"),
        preload("res://assets/music/Doom II OST - Map 09 - Into Sandy's City.ogg"),
        preload("res://assets/music/Doom II OST - Map 01,15 - Running from Evil.ogg"),
    ]
    
    # Shuffle and play
    songs.shuffle()
    play_next_song()

func play_next_song():
    if songs.is_empty():
        return
    
    audio_player.stream = songs[0]
    songs.push_back(songs.pop_front())  # Move played song to end
    audio_player.play()

func _on_song_finished():
    play_next_song()
