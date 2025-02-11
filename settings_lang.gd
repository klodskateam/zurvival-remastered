extends OptionButton


var langs
const langnames = ["Беларуская", "中文", "English", "Русский", "Español", "Suomi", "Bielaruskaja lacinka"]
const langtooltips = [
	"Адно з галоўных новаўвядзенняў ZR 2.0 гэта ЛАКАЛІЗАЦЫЯ! Вы можаце змагацца з зомбі без моўнага бар'ера! УРА!",
	"ZR 2.0 的主要新功能之一是本地化！您可以在没有语言障碍的情况下与僵尸战斗！耶",
	"One of the main new features of ZR 2.0 is LOCALIZATION! You can fight zombies without a language barrier! YAY!",
	"Одно из главных нововеденний ZR 2.0 это ЛОКАЛИЗАЦИЯ! Вы можете сражатся с зомби без языкового барьера! УРА!",
	"Una de las principales novedades de ZR 2.0 es ¡La LOCALIZACIÓN! ¡Podrás luchar contra zombis sin la barrera del idioma! ¡YAY!",
	"Yksi ZR 2.0:n tärkeimmistä innovaatioista on LOKALISAATIO! Voit taistella zombeja vastaan ​​ilman kielimuuria! HURRAA!",
	"Adno z haloŭnych novaŭviadzieńniaŭ ZR 2.0 heta LAKALIZACYJa! Vy možacie zmahacca z zombi biez moŭnaha barjera! URA!"
]

func _ready() -> void:

	
	langs = TranslationServer.get_loaded_locales()
	print(langs)
	for n in langs.size():
		print(n)
		add_item(langnames[n], -1)
		var sus = n + 1
		set_item_tooltip(n, langtooltips[n])
		
	
func _on_item_selected(index: int) -> void:
	TranslationServer.set_locale(langs[index])
	
	print(langs[index])
