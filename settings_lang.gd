extends OptionButton


var langs = []
#var langnames = ["Беларуская", "中文", "English", "Русский", "Español", "Suomi", "Bielaruskaja lacinka", "Polski", "🦲 (emoji)", "Latviešu", "Russkiǐ"]
#var langtooltips = [
	#"",
	#"",
	#"",
	#"",
	#"",
	#"",
	#"",
	#"",
	#"",
	#"",
	#"Одно из главных нововеденний ZR 2.0 это ЛОКАЛИЗАЦИЯ! Вы можете сражаться с зомби без языкового барьера! УРА! (LR)",
#]

func _ready() -> void:
	langs.clear()
	for lang in TranslationServer.get_loaded_locales():
		var translation = load("res://Translation/translations.%s.translation" % lang)
		langs.append({
			"name": translation.get_message("$$$langname"),
			"desc": translation.get_message("$$$hovertext"),
			"procent": translation.get_message("$$$procent"),
			"lang": lang
		})
		
	print(langs)
	for lang in langs.size():
		print(lang)
		add_item(langs[lang]["name"], -1)
		set_item_tooltip(lang, langs[lang]["desc"])
	
	selected = TranslationServer.get_loaded_locales().find(TranslationServer.get_locale(), 0)
	
func _on_item_selected(index: int) -> void:
	TranslationServer.set_locale(langs[index]["lang"])
	
	print(langs[index]["lang"])
