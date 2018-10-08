-------------------------------------------------------------------------------
--                               CritLine                               --
-------------------------------------------------------------------------------

NORMAL_HIT_TEXT = "Normal Hit"
NORMAL_TEXT = "Normal"
CRIT_TEXT = "Crit"

CRITLINE_OPTION_SPLASH_TEXT = "Display new high record splash screen"
CRITLINE_OPTION_SPLASHCRIT_TEXT = "Display critically splash screen"
CRITLINE_OPTION_PLAYSOUNDS_TEXT = "Play Sounds."
CRITLINE_OPTION_FILTER_ATTACKS_TEXT = "Do not count combatdamage."
CRITLINE_OPTION_SCREENCAP_TEXT = "Take screen capture on new records."
CRITLINE_OPTION_LVLADJ_TEXT = "Use Level Adjustment."
CRITLINE_OPTION_FILTER_HEALING_TEXT = "Do not count healing spells."
CRITLINE_OPTION_RESET_TEXTALL = "Reset All Characters."
CRITLINE_OPTION_RESET_TEXT = "Reset this Character."
CRITLINE_OPTION_TOOLTIP_TEXT = "Show ToolTipSummary"

CRITLINE_NEW_RECORD_MSG = "New %s Record!" --e.g. New Ambush Record!
CRITLINE_ALL_DATA_RESETTED = "All Data Resetted!"
CRITLINE_CHAR_DATA_RESETTED = "Character Data Resetted!"
CRITLINE_CRITICAL = "Critical!"
CRITLINE_OPTIONS = "Options"
CRITLINE_SHOW_SUMMARY = "Show Summary"
CRITLINE_HIDE_SUMMARY = "Hide Summary"
CRITLINE_BUTTON_POSITION = "Button Position"
CRITLINE_RECORDS = "CritLine Records"
CRITLINE_NORMAL = "Normal"
CRITLINE_CRIT = "Crit"
CRITLINE_HEAL = "Heal"
CRITLINE_CRITHEAL = "CritHeal"
CRITLINE_CHANCECRIT = "CritChance"

COMBAT_HIT = "You hit (.+) for (%d+)." --COMBATHITSELFOTHER
COMBAT_CRIT	= "You crit (.+) for (%d+)."

SPELL_HIT1 = "Your (.+) hits (.+) for (%d+)."
SPELL_HIT2 = "empty"
SPELL_HIT3 = "empty"
SPELL_CRIT1 = "Your (.+) crits (.+) for (%d+)."
SPELL_CRIT2 = "empty"
SPELL_CRIT3 = "empty"

SPELL_HIT_HEAL = "Your (.+) heals (.+) for (%d+)."
SPELL_CRIT_HEAL = "Your (.+) critically heals (.+) for (%d+)."

HEALINGPOTIONS = "Healing Potion"

if GetLocale() == "deDE" then
	NORMAL_HIT_TEXT = "Normaler Treffer"
	NORMAL_TEXT = "Normal"
	CRIT_TEXT = "Kritisch"
	
	CRITLINE_OPTION_SPLASH_TEXT = "Splash-Screen bei neuem rekord"
	CRITLINE_OPTION_SPLASHCRIT_TEXT = "Splash-Screen bei kritischen treffern"
	CRITLINE_OPTION_PLAYSOUNDS_TEXT = "Sounds bei neuem rekord"
	CRITLINE_OPTION_FILTER_ATTACKS_TEXT = "Kampfschaden nicht berьcksichtigen"
	CRITLINE_OPTION_SCREENCAP_TEXT = "Screenshot bei neuem rekord"
	CRITLINE_OPTION_LVLADJ_TEXT = "Benutze Level-Anpassung"
	CRITLINE_OPTION_FILTER_HEALING_TEXT = "Heilzauber nicht berьcksichtigen"
	CRITLINE_OPTION_RESET_TEXTALL = "Alle chars resetten"
	CRITLINE_OPTION_RESET_TEXT = "Char resetten"
	CRITLINE_OPTION_TOOLTIP_TEXT = "ToolTip-Zusammenfassung anzeigen"
	
	CRITLINE_NEW_RECORD_MSG = "Neuer %s Rekord!" --e.g. New Ambush Record!
	
	COMBAT_HIT = "Ihr trefft (.+). Schaden: (%d+)."
	COMBAT_CRIT = "Ihr trefft (.+) kritisch fГјr (%d+) Schaden."
	
	SPELL_HIT1 = "(.+) trifft (.+). Schaden: (%d+) (.+)."
	SPELL_HIT2 = "(.+) von Euch trifft (.+) fГјr (.+) Schaden."
	SPELL_HIT3 = "empty"
	SPELL_CRIT1 = "(.+) trifft (.+) kritisch: (%d+) (.+)schaden."
	SPELL_CRIT2 = "(.+) trifft (.+) kritisch: (%d+) Schaden."
	SPELL_CRIT3 = "empty"
	
	SPELL_HIT_HEAL ="(.+) heilt (.+) um (%d+) Punkte."
	SPELL_CRIT_HEAL = "Kritische Heilung: (.+) heilt (.+) um (%d+) Punkte."
	
	HEALINGPOTIONS = "Heiltrank"
end

if GetLocale() == "ruRU" then
	NORMAL_HIT_TEXT = "Обычное попадание"
	NORMAL_TEXT = "Нормальный"
	CRIT_TEXT = "Крит"
	
	CRITLINE_OPTION_SPLASH_TEXT = "Отображать новый высший рекорд, вспышкой."
	CRITLINE_OPTION_SPLASHCRIT_TEXT = "Отображать критический урон, вспышкой."
	CRITLINE_OPTION_PLAYSOUNDS_TEXT = "Проигрывать звук."
	CRITLINE_OPTION_FILTER_ATTACKS_TEXT = "Не учитывать урон."
	CRITLINE_OPTION_SCREENCAP_TEXT = "Сделать снимок с экрана при новом рекорде."
	CRITLINE_OPTION_LVLADJ_TEXT = "Использовать регулятор уровня."
	CRITLINE_OPTION_FILTER_HEALING_TEXT = "Не учитывать исцеляющие способности."
	CRITLINE_OPTION_RESET_TEXTALL = "Сбросить все"
	CRITLINE_OPTION_RESET_TEXT = "Сбросить персонажа"
	CRITLINE_OPTION_TOOLTIP_TEXT = "Показывать основную подсказку."
	
	CRITLINE_NEW_RECORD_MSG = "Новый рекорд - %s!" --e.g. New Ambush Record!
	CRITLINE_ALL_DATA_RESETTED = "Все данные сброшены!"
	CRITLINE_CHAR_DATA_RESETTED = "Данные персонажа сброшены!"
	CRITLINE_CRITICAL = "Критический!"
	CRITLINE_OPTIONS = "Настройки"
	CRITLINE_SHOW_SUMMARY = "Показать сводку"
	CRITLINE_HIDE_SUMMARY = "Скрыть сводку"
	CRITLINE_BUTTON_POSITION = "Позиция кнопки"
	CRITLINE_RECORDS = "Рекорды CritLine"
	CRITLINE_NORMAL = "Обычный удар"
	CRITLINE_CRIT = "Критический удар"
	CRITLINE_HEAL = "Исцеление"
	CRITLINE_CRITHEAL = "Критическое исцеление"
	CRITLINE_CHANCECRIT = "Шанс крит. удара"
	
	COMBAT_HIT = "Вы наносите (.+) (%d+) ед. урона." --COMBATHITSELFOTHER
	COMBAT_CRIT	= "Вы наносите (.+) (%d+) ед. урона: критический удар."
	
	SPELL_HIT1 = "Ваше заклинание \"(.+)\" наносит (.+) (%d+) ед. урона."
	SPELL_HIT2 = "empty"
	SPELL_HIT3 = "empty"
	SPELL_CRIT1 = "Ваше заклинание \"(.+)\" наносит (.+) (%d+) ед. урона: критический эффект."
	SPELL_CRIT2 = "empty"
	SPELL_CRIT3 = "empty"
	
	SPELL_HIT_HEAL = "Ваше заклинание \"(.+)\" исцеляет (.+) на (%d+) ед. здоровья."
	SPELL_CRIT_HEAL = "Ваше заклинание \"(.+)\" исцеляет (.+) на (%d+) ед. здоровья: критический эффект."
	
	HEALINGPOTIONS = "Лечебное зелье"
end

if GetLocale() == "frFR" then
	NORMAL_HIT_TEXT = "Coup Normal"
	NORMAL_TEXT = "Coup Normal"
	CRIT_TEXT = "Coup Critique"
	
	CRITLINE_OPTION_SPLASH_TEXT = "Afficher les Nouveaux Records \195\160 l\'\195\169cran"
	CRITLINE_OPTION_SPLASHCRIT_TEXT = "Afficher les critique \195\160 l\'\195\169cran"
	CRITLINE_OPTION_PLAYSOUNDS_TEXT = "Jouer un Son."
	CRITLINE_OPTION_FILTER_ATTACKS_TEXT = "Compter seulement les attaques JcJ."
	CRITLINE_OPTION_SCREENCAP_TEXT = "Faire un Screenshot pour un Nouveau record."
	CRITLINE_OPTION_LVLADJ_TEXT = "Utiliser l\'Ajustement de Niveau."
	CRITLINE_OPTION_FILTER_HEALING_TEXT = "Ne pas compter les Sorts de soin."
	CRITLINE_OPTION_RESET_TEXTALL = "R.\195\160.Z. de tous les records."
	CRITLINE_OPTION_RESET_TEXT = "R.\195\160.Z. des records."
	CRITLINE_OPTION_TOOLTIP_TEXT = "Show ToolTipSummary"
	
	CRITLINE_NEW_RECORD_MSG = "! Nouveau Record pour %s !"
	
	COMBAT_HIT = "Vous touchez (.+) et infligez (%d+) points"
	COMBAT_CRIT = "Vous infligez un coup critique \195\160 (.+) %((%d+) points"
	
	SPELL_HIT1 = "Votre (.+) touche (.+) et inflige (%d+) points"
	SPELL_HIT2 = "Votre (.+) touche (.+) et lui inflige (%d+) points"
	SPELL_HIT3 = "empty"
	SPELL_CRIT1 = "Votre (.+) inflige un coup critique \195\160 (.+) %((%d+) points"
	SPELL_CRIT2 = "empty"
	SPELL_CRIT3 = "empty"
	
	SPELL_HIT_HEAL = "Votre (.+) vous soigne pour (%d+) points de vie."
	SPELL_HIT_HEAL2 = "Votre (.+) soigne (.+) pour (%d+) points de vie."
	SPELL_CRIT_HEAL = "Votre (.+) soigne (.+) avec un effet critique et lui rend (%d+) points de vie."
	
	HEALINGPOTIONS = "Potion de soins"
end

if GetLocale() == "zhCN" then
	NORMAL_HIT_TEXT = "普通攻击"
	NORMAL_TEXT = "普通"
	CRIT_TEXT = "致命一击"
	
	CRITLINE_OPTION_SPLASH_TEXT = "显示产生新纪录的字样"
	CRITLINE_OPTION_SPLASHCRIT_TEXT = "显示重击特效"
	CRITLINE_OPTION_PLAYSOUNDS_TEXT = "播放声音."
	CRITLINE_OPTION_FILTER_ATTACKS_TEXT = "不统计战斗伤害."
	CRITLINE_OPTION_SCREENCAP_TEXT = "打破纪录时截图."
	CRITLINE_OPTION_LVLADJ_TEXT = "使用级别矫正."
	CRITLINE_OPTION_FILTER_HEALING_TEXT = "不计算治疗法术."
	CRITLINE_OPTION_RESET_TEXTALL = "重置所有角色纪录."
	CRITLINE_OPTION_RESET_TEXT = "重置这个角色的纪录."
	CRITLINE_OPTION_TOOLTIP_TEXT = "Show ToolTipSummary"
	
	CRITLINE_NEW_RECORD_MSG = "新的 %s 记录!" --e.g. New Ambush Record!
	
	COMBAT_HIT = "你击中(.+)造成(%d+)点伤害" --COMBATHITSELFOTHER
	COMBAT_CRIT	= "你对(.+)造成(%d+)的致命一击伤害"
	
	SPELL_HIT1 = "你的(.+)击中(.+)造成(%d+)点伤害"
	SPELL_HIT2 = "你的(.+)击中(.+)造成(%d+)点(.+)伤害"
	SPELL_HIT3 = "empty"
	SPELL_CRIT1 = "你的(.+)对(.+)造成(%d+)的致命一击伤害"
	SPELL_CRIT2 = "你的(.+)致命一击对(.+)造成(%d+)点(.+)伤害"
	SPELL_CRIT3 = "empty"
	
	SPELL_HIT_HEAL = "你的(.+)治疗了(.+)(%d+)点生命值."
	SPELL_CRIT_HEAL = "你的(.+)对(.+)产生极效治疗效果，恢复了(%d+)点生命值."
	
	HEALINGPOTIONS = "治疗药水"
end