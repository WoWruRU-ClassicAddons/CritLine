-------------------------------------------------------------------------------
--                               CritLine                        	     --
--                  	  Version : Russian ( by Maus )                  --
-------------------------------------------------------------------------------




function CritLine_LocalizeRU()
	
	NORMAL_HIT_TEXT = "Обычное попадание";
	NORMAL_TEXT = "Нормальный";
	CRIT_TEXT = "Крит";

	CRITLINE_OPTION_SPLASH_TEXT = "Отображать новый высший рекорд, вспышкой.";
	CRITLINE_OPTION_SPLASHCRIT_TEXT = "Отображать критический урон, вспышкой.";
	CRITLINE_OPTION_PLAYSOUNDS_TEXT = "Проигрывать звук.";
	CRITLINE_OPTION_FILTER_ATTACKS_TEXT = "Не учитывать урон.";
	CRITLINE_OPTION_SCREENCAP_TEXT = "Сделать снимок с экрана при новом рекорде.";
	CRITLINE_OPTION_LVLADJ_TEXT = "Использовать регулятор уровня.";
	CRITLINE_OPTION_FILTER_HEALING_TEXT = "Не учитывать исцеляющие способности.";
	CRITLINE_OPTION_RESET_TEXTALL = "Сброcить всех";
	CRITLINE_OPTION_RESET_TEXT = "Сброcить персонажа";
	CRITLINE_OPTION_TOOLTIP_TEXT = "Показывать основную подсказку.";
		
	CRITLINE_NEW_RECORD_MSG = "Новый рекорд - %s!"; --e.g. New Ambush Record!

	COMBAT_HIT = "Вы наносите (.+) (%d+) ед. урона."; --COMBATHITSELFOTHER
	COMBAT_CRIT	= "Вы наносите (.+) (%d+) ед. урона: критический удар.";
			
	SPELL_HIT = "Ваше заклинание (.+) наносит (.+) (%d+) ед. урона.";
	SPELL_HIT2 = "empty";
	SPELL_HIT3 = "empty";
	SPELL_CRIT = "Ваше заклинание (.+) наносит (.+) (%d+) ед. урона: критический эффект.";
	SPELL_CRIT2 = "empty";
	SPELL_CRIT3 = "empty";

	SPELL_HIT_HEAL = "Ваше заклинание (.+) исцеляет (.+) на (%d+) ед. здоровья.";
	SPELL_CRIT_HEAL = "Ваше заклинание (.+) исцеляет (.+) на (%d+) ед. здоровья: критический эффект.";
	
	HEALINGPOTIONS = "Лечебное зелье";
end