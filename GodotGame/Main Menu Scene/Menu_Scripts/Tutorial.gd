extends Control

@onready var dialogue_box = $Dialogue/DialogueBox
@onready var dialogue_idx = 0 #For printing out the dialogue sound

var text = load("res://Dialogues/CharacterList.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue_box.variables["Player"] = GameData.username
	if (not dialogue_box.running):
		if GameData.username == "":
			dialogue_box.start()
		else:
			dialogue_box.start_id = "Tutorial2"
			dialogue_box.start()




#var testDic = {"Talia": 2}
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	SoundControl.is_playing_theme("main")
	pass


#TODO: Testing. Function not called
func dialogue_effect(text):
	var regex = RegEx.new()
	regex.compile("\\[.*?\\]")
	var text_without_tags = regex.sub(text, "", true)
	print(text_without_tags.length())
	for i in range(0, text_without_tags.length()):
		SoundControl.is_playing_sound("dialogue")




func _on_dialogue_box_dialogue_signal(value):
	
	#TODO: More values will be added based on dialogue direction
	if (value == "EnterName"):
		dialogue_box.stop()
		get_tree().change_scene_to_file("res://Main Menu Scene/EnterName.tscn")
	
	elif (value == "ShowControls"):
		$Controls.visible = true
		
	elif (value == "DialogueControl"):
		$NPCexample.visible = true
		
	elif (value == "Done"):
		GameData.visitTutorial = true
		
		TextTransition.set_to_chained_timed(
			[
				"You then enter the village, excited for the opportunity to make profit."
			],
			"res://World Scene/World.tscn",
			3,
			""
		)
		SceneTransition.change_scene("res://Globals/text_transition.tscn")
	else:
		$Controls.visible = false
		$NPCexample.visible = false
	pass # Replace with function body.

func _on_dialogue_box_dialogue_proceeded(node_type):
	#print($Dialogue/DialogueBox.speaker.text," addf")
	SoundControl.is_playing_sound("button")
	if $Dialogue/DialogueBox.speaker.text != "":
		var idx = Utils.char_dict[str($Dialogue/DialogueBox.speaker.text)]
		$CharacterIMG.texture = Utils.character_list.characters[idx].image
