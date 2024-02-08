class_name Golden_Juuso extends Food


func _on_body_entered(body):
	if body is PapaT:
		body.golden_juusos += 1
		die()
