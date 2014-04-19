# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.35-0+wheezy1)
# Database: devm
# Generation Time: 2014-04-19 11:53:11 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table _360
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_360`;

CREATE TABLE `_360` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;



# Dump of table _devm
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_devm`;

CREATE TABLE `_devm` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;



# Dump of table counter
# ------------------------------------------------------------

DROP TABLE IF EXISTS `counter`;

CREATE TABLE `counter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `estonian_label` varchar(200) COLLATE utf8_estonian_ci DEFAULT NULL,
  `english_label` varchar(200) COLLATE utf8_estonian_ci DEFAULT NULL,
  `value` int(11) DEFAULT '1',
  `increment` int(11) NOT NULL DEFAULT '1',
  `type` enum('childcount','increment') COLLATE utf8_estonian_ci NOT NULL DEFAULT 'increment',
  `created` datetime DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `changed` datetime DEFAULT NULL,
  `changed_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deleted_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `old_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `old_id` (`old_id`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;



# Dump of table dag_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dag_entity`;

CREATE TABLE `dag_entity` (
  `entity_id` int(11) unsigned NOT NULL DEFAULT '0',
  `related_entity_id` int(11) unsigned NOT NULL DEFAULT '0',
  `distance` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`entity_id`,`related_entity_id`),
  KEY `de_fk_re` (`related_entity_id`),
  CONSTRAINT `de_fk_e` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `de_fk_re` FOREIGN KEY (`related_entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

LOCK TABLES `dag_entity` WRITE;
/*!40000 ALTER TABLE `dag_entity` DISABLE KEYS */;

INSERT INTO `dag_entity` (`entity_id`, `related_entity_id`, `distance`)
VALUES
	(5,46374,1),
	(5,46375,1),
	(5,46376,2),
	(46375,46376,1);

/*!40000 ALTER TABLE `dag_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entity`;

CREATE TABLE `entity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `definition_id` int(11) unsigned DEFAULT NULL,
  `entity_definition_keyname` varchar(25) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `public` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sharing` enum('public','link','domain','private') COLLATE utf8_estonian_ci NOT NULL DEFAULT 'private',
  `sort` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `changed` datetime DEFAULT NULL,
  `changed_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `deleted_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `old_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `public` (`public`),
  KEY `entity_definition_keyname` (`entity_definition_keyname`),
  KEY `sort` (`sort`),
  KEY `deleted` (`deleted`),
  KEY `sharing` (`sharing`),
  CONSTRAINT `e_fk_ed` FOREIGN KEY (`entity_definition_keyname`) REFERENCES `entity_definition` (`keyname`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

LOCK TABLES `entity` WRITE;
/*!40000 ALTER TABLE `entity` DISABLE KEYS */;

INSERT INTO `entity` (`id`, `definition_id`, `entity_definition_keyname`, `public`, `sharing`, `sort`, `created`, `created_by`, `changed`, `changed_by`, `deleted`, `is_deleted`, `deleted_by`, `old_id`)
VALUES
	(5,NULL,'person',0,'public','Mihkel Putrinš',NULL,NULL,'2014-04-14 08:46:50','5',NULL,0,NULL,'mihkel'),
	(6,NULL,'person',0,'public','Argo Roots',NULL,NULL,'2014-01-10 09:22:22','5',NULL,0,NULL,'argo'),
	(46374,NULL,'questionary',0,'domain','Äripäev 360','2014-04-19 10:21:15','5','2014-04-19 10:31:51','5',NULL,0,NULL,NULL),
	(46375,NULL,'customer',0,'domain','Äripäev','2014-04-19 10:27:47','5','2014-04-19 10:32:36','5',NULL,0,NULL,NULL),
	(46376,NULL,'person',0,'public','Mare Pork','2014-04-19 10:29:00','5','2014-04-19 10:30:30','5',NULL,0,NULL,NULL);

/*!40000 ALTER TABLE `entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entity_definition
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entity_definition`;

CREATE TABLE `entity_definition` (
  `keyname` varchar(25) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  `ordinal` int(11) DEFAULT NULL,
  `open_after_add` tinyint(1) NOT NULL DEFAULT '0',
  `public_path` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `estonian_public` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `english_public` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `actions_add` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `changed` datetime DEFAULT NULL,
  `changed_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `old_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`keyname`),
  UNIQUE KEY `old_id` (`old_id`),
  KEY `public_path` (`public_path`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

LOCK TABLES `entity_definition` WRITE;
/*!40000 ALTER TABLE `entity_definition` DISABLE KEYS */;

INSERT INTO `entity_definition` (`keyname`, `ordinal`, `open_after_add`, `public_path`, `estonian_public`, `english_public`, `actions_add`, `created`, `created_by`, `changed`, `changed_by`, `deleted`, `is_deleted`, `deleted_by`, `old_id`)
VALUES
	('answer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('person',NULL,0,NULL,NULL,NULL,'default,csv',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('question',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('questionary',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('test',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('test-direction',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL);

/*!40000 ALTER TABLE `entity_definition` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entity_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entity_info`;

CREATE TABLE `entity_info` (
  `entity_id` int(11) unsigned NOT NULL,
  `language` varchar(100) CHARACTER SET utf8 COLLATE utf8_estonian_ci NOT NULL DEFAULT '',
  `search_it` varchar(2000) CHARACTER SET utf8 COLLATE utf8_estonian_ci DEFAULT NULL,
  `sort_it` varchar(2000) CHARACTER SET utf8 COLLATE utf8_estonian_ci DEFAULT NULL,
  `displayname` text CHARACTER SET utf8 COLLATE utf8_estonian_ci,
  `displayinfo` text CHARACTER SET utf8 COLLATE utf8_estonian_ci,
  `displayproperties` mediumtext CHARACTER SET utf8 COLLATE utf8_estonian_ci,
  PRIMARY KEY (`entity_id`,`language`),
  KEY `language` (`language`,`search_it`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table file
# ------------------------------------------------------------

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(500) COLLATE utf8_estonian_ci DEFAULT NULL,
  `filesize` int(13) unsigned DEFAULT NULL,
  `file` longblob,
  `is_link` tinyint(1) DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `changed` datetime DEFAULT NULL,
  `changed_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deleted_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `old_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `old_id` (`old_id`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;

INSERT INTO `file` (`id`, `filename`, `filesize`, `file`, `is_link`, `created`, `created_by`, `changed`, `changed_by`, `deleted`, `deleted_by`, `old_id`)
VALUES
	(2566,'file64206105_be2c139b.jpg',140536,'ÿØÿà JFIF  H H  ÿÛ C !"$"$ÿÛ CÿÀ I" ÿÄ             	ÿÄ P  !1"A2QaBq#3R$br¡±Á%4Cst¢²³567SuÂÑðcá&ÒñÿÄ             ÿÄ 4    !1A"Q2aq¡#BÁ3±ÑðRáñ$bÿÚ   ? û+F Ñ£F4hÖ=ô
-­~¶ÔãI«ßÎªÎ­2äSRÄ¿}p?Y×I,ñÖ¥ì#CçFçF¡"á£F°u4ëYÑ¥Ñ£F 4£F h#F«¿ÁëcõgZ:;´âEázáÝþõ¸ï§¡·ÿ ;)Eÿ «éàó¯)þ*nMMðâÒÍÖà9_«·Üqÿ kn¡º+.x5þ
º](©ôDm$ôjY^0^IÂ.}KÁb~à}'*
	ãü¿}xð¥AYüé(ëeJj(ÿ ¦@;Kéò
9<ó¯[»VËAg¨©FÚ |`c,YAÚ9ã:¶%íLñ¿_þAz»Ãm¦v,UR!Çì?m$©¦ç_I|F¢­
ÕcÕ"ÎáÉÃly$d(ÁÔ,òCG²ß>Úå;R¦t2, ¸¢gß'É÷:E<ôõ¦N¶I;Ó´³T¿©W #¼wHBFãéõmQ©oäÏ/¯IÓ­Îå%¢Û*¥Tí$Ó2ØnêãÆá·y:´Ø¨)éi#(ÜÚò´îåsÎªvú¸):³ÚªªÊËß¹ÏP+z£ß¸àïd98úµ}p{xT1N­òW>Oé]NÒXáw]È$ç##8Ö©ZYLÍøé®àÂñûjÇ1 sù×¥Ð($6OãEkJHªäÛ¾ÚÑ¤aLZ8òqéBñì^UÚ~xß\«d1@'b§*\)#íÏ\ïT0@§Ó¸÷:ó®¥»[ë!Ü®kDó£J½ì×õ·¹ÖR;ðiýNF·:Ôù:ªå£dfùm¾R*3±ÙT ÏÜãÆº%Lô69ú(­1Íöù#ËË6H' Üqy­WVõUÖm¾ªÙj¬CEûÔÁX/ÛÛqà1uW¦!¹WSÖu-<uuJÍMSu|Ù()µ Âñd¶±õtÏcy\p^íWÓqVVÕÿ ¶4ÕTñÕ|¼ª+ïfÇBä~>çPú[¨ºZÇM;\nÖÉîÏEKU4e¥wAÈw<ûãUwDô]7ÊÉM,aÐ¥
Èë°6âîÕíÇN(:*XiëiéM²×O±É4Ëä"H0%þ¬¶2	öãT½¾©aÝ9WD+Yô¥¦ãJM¨¦¨Ò#ÉØL.	8É'ØjÃÔUOQlQÛêZw¡*BÈbw)gÆNí¸ûgMbéhà¶Fðß*å©Ú'BV-ÎX°RYG÷?}OêÝ±mËIKP÷)»J#2HìÃk6 h¸ìneÅCy6ç®cVhÈXéëepøOL`úlj?MÔ\(«®Ñ[ìuRÒB5,ÊT,qã mË1ãÒý?[b¾Y5Tí-GknJ³m$íÂ®|¯Rèº¶éEDôÐ­ÃÖj"r¢IÏ¨¹IÚ£'ãIm?$cyrî(³Øã¯j9 L'd#ÈoÀ À#vó´ääì4ÏBehZÃYSVEu3(c¸®=ýGï©=#Ô5ÑSÏJRU¼{7'!Ô³2úÁõ  ±®öÌ°ÚîiQLbævI!·§,T?ÁÀ\ê#WOH¹ZD»ÓÑüÍ4Ô¶»L"	y
DH88õíáGÓªu¥*kÅú²ÍQQ"Í$ôÚ)	*B²ðÃiÓ$êÕGwjJé) éÙª$ZU¦(uO¥· åqï´ý¸Øïõ0ô}-¢kÊwõj.ÁàmEãçsgÆ¬ÖîYÜ°Â£xDxlsÏ\ª««é»À{q1r·@ÉöÎs¥ýAn¾Mkhîw²¢7dI
'a³!¹
?ígÛM^áÔ·;dtöÊjXÌ±9v&YIÚxÆs|jURõÉBn5ö¤FxiÄ$,H_ïl0O5VéCvô¦Ñ¥³ !Rj¯36YéK´G"êp­.5ÚñgéÊWI[SFóÔToð¥Fì±úäë½æßÖqªQÇQn§§fMÕ@Ûc!H+q»Øäý:@Öhi+ªê¯½L´ýó+îÈÙØ¬ÌÄ·##È};§sª'c9îÿ DXó]K%mP3ö0©¿ ª7ñç'L«ºÇTög¶Tùhb¬!@ß+V3Æ©ÝAh©$rñNóSV%©Â Éf$89ü7è+]©­ÕÒ	)©f;I*Í|ÇVtS>inKÁË¨h¡ºSËY]YHÿ 1$JÝ½äìc¸´díÝÕôéÖ¥j©-ôAÊjÂ9AÀNÖÆwägê'IRnÚíM=MH¸ÕZS4p#;(^@¨m#o1ôê¹vù{|6{]êé^xêªp¢%/Pér3å¼êÓ«4ÓåÚ£Ã
5¼üÂéG»c4Å0ÙÇÔ@bA>ØÔ.þF¶ÈjE,QÓÊc~ôf&rwêòþ¶<b5kêÕ°Òº=EtÑ´ÍÞVEÃ Hq=ýb¢.«·QÑ½uµ¥2"­&B	Ã©Ú2Àc qÈçR®]G2Pú_,­UÃa¼VVÓÐYìU¨b¯ÓLÅX£
Ä6íäÐGØëJ¹ºª¶ñe ¡¦H¤Xk§-°ÆÈ À]§rî;}8öÕ£¥eéættµ¶V8IyGóäzÈÖ:ÛÍh
tÐR¬L}&ü2£Ù98ÜÕøÕ¸äÎj2TÒ_"µ¶µ%5edWÚACE£Ge=¤¶í¡Ôú²?¤®7V:¶å[v¦":k:H*`4Îª¦5|nUÎì6OÔ¼5dèîºKÔ&j ±#Ç:«+eFk6g#<q¤Óµ47gîN)ª7úboL~³´s6Iük)ÊMZòviñbSqr¶º,6ÛoSGf¦¦Å-lsJÛZÙS¶a	82,lTç.âyÎ[ú×Sg¬ ²µdqUR"[;	`H¼g9\êÿ v¢/J-oqc*¨BÈ@ãöÕÃ6Ê©Yc(OJb¼nØ»¶ù ýôIàrÈ¥-Ã¤£¥éê³VUÂ.2Á<´ÈÖõ6°ÜG\ïÑÝlVwK«'Ê$H²HPn;{@ÁW8
NÞ}'Zß3WNË­¾wTP¬à"·Æ;B±EÔtÕUUÖ^ã´Ýä¸­sßc;í@ÊH ds­;#ÞÛd
ùÍ%L¦¦ÛCQOUP*N )ÈlÜï<mÁ'KééhiI¬£¹¥<ôç(Òùg¸BbBp§Î¸Î¬
EOÕMAn*Ñvûq¨mÅvNIo©³5U½Yï455HÐÃTcnÚHÎY6ùK&³ãÚMW¹tL\¥-¹;aÔW«R©¦ÂÊ:òi'ìä äç]oªkET53WÌ)iÚS<AÀiJ)Ì¯#ãS-ÆX{°ÏCÔÒ"Ô°în>Ãì5ÎßS°¬@é`BÂôùÃ¤¨õyûë[¶vF
1ÛÒt¤Òu
Ûæ®TÈiçyMF%*çãvÂ@üë[[ëì¶è«éÖZA+dâDÇlA÷Ú
	 ãfªxi¾RÑoñ*IÞ{» çÎNrÖ&µV-åj¢gËÄµ;VQK'` axñ¨8ÄÈ¹è¦X¯ÕVJÒ:«eLÇÞarA*9+ ÃmIçWK§CG]f·u?EÝ¦ºÒÒÝÇ«p3cÇ·t®ÍA%=â±Û¶
ª9#²WpQ#p ·
ÛFG$èî©®øswª±î5_#,ÑÊ¥HÈñD g$Ï:¦:Kë=Kj>?róð*í5-Þ®Ç~±D¨Õ²8gl?òcû}<ëÛ­SÔSÞv½#Ô§+06~[Ç±×ÞlöÎ«²GÔý4ùq ¶¬g(oHÚsÁÆ=õ}é~³±õ'DÉv­b¥nÍ\6Àå¹ñçýF5èaáSèù¯Äâ²¿R¾ûàíÕµ%.ªÛòJ£´.qÎO9öÒ/VÚ{¤)bÑ>a&ÚÐ1p7#Nþ5ÚÁTÙ«*i§¬XÙèeçä«.~£rGjeª*Øç¢«)r'#h!¸ ã<Ãÿ [ðÕT°Ïrí·È(nì¥Étíòé*Ù¹XÊc ¤ç>¡í¨õvÚKoY<²Ò­=mÅþV*ÒÃµ8DÌ[ã^>)Ü<åqà®uµ¹*«è+®¢CQQò[ ¦l÷:ý,Á:Öt°ÁÒö[¥µ$%U"ì¨FPÊ¤2>Ö?|ï¬âùkàôe¹)§õwù:ËdKvçSO²Ø&BjÇ þ¦9Ïãmxÿ Än
y«¸Zë£kTÊ®jzpÍM2:²HÁÉÀ©+ÙëÒ~"ÖÃIÑõ7Ù©EdÌ²
!`³H3Á¶-çÕ S^jï]33CîytUíW[Ë«¬q¶EUíç98.©ÈTg¡¢÷'ú·r·ËÓqUTS-_ËL±@Ê%;[¼ CéO¥¶ê\
U(*õOsþd+dktîÌ^`ä®÷ÉSõ Aò5é3U\z~j«,3µ©ÚY¡fÝÛ}ÐK`)ÊoÏ
¾I×üB·Oh¡,ÐHôõAfU7¤©÷aÇ¥@õú°7Ú05Ã8»GÔé²îRR^á¬ÓÜ:PMÕV±RÍ#SÝé3w)]È·%	~éõ¸Y~#ÔY#³ZúÆ¨·UKóÑX¦DA;('Ô *À©:p¾Õ]®jsGu¢*7@<f÷r¹,ÜíÀãW/SÐõ'F\,}ALÑÔ[Y#hs±eî'Üy_±Æ´ÆÛÓWÆ:]2zê-;SD.ôõÑµIQ(³àNCxÔ~ ·%WCÁ\Élg
¡¸°`8)·~Ãï¤°EÑwIg§¼ÖùÍ?y&fºBHfU
}í«±%«¡¼ô¬7k5ß2ªÉ¸lÞVÊôÖ;mÓ=ÛqîæLè+kuWÃz«jä¯Fj¤ß02v>p¥p g;±Æ5æ¶êÙl]C$+<±íHj)æl2FNJ37ÛÒ89«gÂ·ÖÑµ´Ýå~ìlºÝKxÈàýõ¯ÄZJ¾°©Þ¯3/Ë*ÜÊáz[¹x?VÑàKkb®ÊaÞ²Ê/é|¢¹ÖwZWÆë¸*ªjmóÔF**1$®G
ÁH÷ }OËKÆTpF¶¾Jøu¿§`­)#¨Ic%ÕÕ Þ3ÈÜ¬v}[i¨*À>ý4rlw(8Ø
uâ|6§§¢^5¡hÑ£BCXÎ°5(täëó­Æ«V3£lÎ¬L
ã:¬Ó0Óë{dm]V®7ÈÏí hügV<º
4hHhÑ£@4hÐ4£F kVàkmjþ4Z {éÉÀÎ4æ¯Oí¤ÄFªÏCH¹ JrF°N478Öÿ f{^kYÑ©@4kúÎ¡Ñ£F 5 4hÑ 
4hZ±Æ¶×7äè
ÈÎ°|ë` ñ­Omxñ3_¿:>Ù2*Oõ8 }^ú~|ÙñqÅ÷ãõt4ÕÔDâJK¿ñT|®©ûKc¯Q&};ð¢ÕQkøom£áIäWd¢ý³í«>ÒÓÆ$ñýIH÷û±Ô^·-»§((#GµL¨I9d%Fìsß]jÊRÓÇCæ9q.7Ç,Ç>äg¾5ÑI7[óI¯,¬õýìEISm§IÚ8Ð	Ävf9Ä*ÞW#êÒ8®5Ï¥i`éÞ¥¦ã²¨ÄïÜ,JïèÈE'|ç-ç:ÇNtý\U5×N¢­¦útÂöÕAË0ä<nÉó­úbòÞ¸¸Ã¦nÅ¼.k Ä)1LvNæ¤àúA
ÕF¨6Î©m6®¼¿¿Áj±[c·Ñ1;jdRIy	É$HÏ>báß¾²8~ÚÏ¶´<é;vqòaÉÉÏç]7!gÃEHdhÐ¹Ü@Î?}lÄäñ¡;P2Æ7|{(Î¡Í4ÔÑ4¸¡²öÆÊ¸Ý!ô/ÎM E£z&	ØR>Wý|RM£§×ÁQø¡-Â¢*:
a¥LØ©Ú7>Ì@QËx pGQì9üÃ¨*j®Pì®¦£0îlX²  êàò´V_ÚW¹]!Ùr¼VÊz®c#i)rÌI#5º ¬¶W3SÁ=i`ì$1¼12R°Ø§j³Äã>úç9Z>Þ,[¢=MêÕÓp-²"5MTpMºpPýmªF9;²p4¾*úYnñÁ¾juÄµ<k+n­»cI»¨ÏÓÎÜê_GVUtª_*¯pªÔÒå©©uªä²Ùµí<àps&Zº(-ºJ«³´ÀÖÔ©X`dLrËê-p¹Ösr³·Â¡j_s¸õ'RVRÅ
©¡£@²¼µ©¹Î@
Ê§zçËmÆ?Í¥Qÿ :«0ÓÕÞª'v5u¤¥
Ñò},]ÀÎ~ÃM.]3o¡µ/ÎÝ*]b<øMÅ	þ¬%\`
JKKEJôvË¬uÓHË%DñpÄ©<F1·Õç:5#8O
´q ij+m¶QS\ê&«¨ª©C¾2ûUØ'h!ÁûA´Av¦´If¶[)ÍyµIoê-4lJ-ï!àò}$:e=*tä1ÍWÕR½ÚeÊÂÒ	U\ëûþß}'§¯®·-ÂáXéX@B«+Êá}DnU ùÀ¯Ó¨µÛ4Å	Ê/g?[ORÝlv:[<xnW©5«spìYT¨ÂHõrÒh¨í6Ô5·¢öÞ÷r) §¦PÒ¹Ýµi$)Ãx sçKìýQGj¶£ç®5wi©GÇë;¶®òsÛ 	$çHîSR]äëqZúÚ¦Ú­gT3æFÂ;¸ñ¤²n_|IG$®Ò~|²ÉÓ½>uRDÔÔÝ¨Ý"ÉeGpbÌAÎ=¼÷ÔËL\å²:á¢Uï´¯·¸Þ¤ãÛ8ûûjaÍQw;UÊ¦_éN@cdl:?>1´¾s<µIY?ÌÙ­kAO!g$E×ô;a¾ë»ö:¤'Í³}N)ÅÉEÿ ~G¨Õ=HÔ_ÍãªíÓÇeÙ,]î éú½'QÒJÂÍ
ÊÑuX­¥¡à1å¦
çÔpWoÕM¹^ªb+5%®Tfä`¤ TaGÓùÕýU\*ÜKDÈd2j8ÉeÎ{` YÈã'6×°¦^­xþãºN¤~JxÙÚ¼Ë¤Ú®.ÐÙ,Aö9'8Î¸u/Äjjû%Vê:ÊÇgw2SÑ(P½Ì>æÂTñLéNü·:»rÐÑCL^F¨þ¬£ ÇyÖÕU)MKT°´%v¡§;Jï8Ù«²3¤yc%eËÂå­º|D4sÔµR·pÈÑÑcãHõlùmRÚáÖ	j/w.J§*§kzH!|¶ÐåJå³»z?ó;òºZë=ÎX1,qîÂ¤»L³%ÀIÁÆºaê*©K[Þ è­H	úCyÒÀnÜ§Ï¤}^{Zåã±.#L¢T«¶ËMlºY)©¢~]¥ <`ãÿ 1è¾¢ø·¿µ¸èÎêsÊ®ÖeôG>ûqZ:¯«>~¢iÖ"nÚNÜÁAAêbF mÀÚßa¨PÝf«½³R ¢JyI+"²°%'Ô`ãj©Á>	QÏÞ=oÄñt4´½9AMPÎ2´õf}ÙcÍµW$Éài'UWõ]CKGk ¨{y6©ZÉ$F Ü­¸úeÆHe,xÆ5o£°ÑQMKAéñ2Ìò´¥#æ§ÉþÞ@ûiÝ×¦íÂª©Rr¥ã­U1¸neP\çç 5z´eº8æ®_ÙOx}+ÿ 6·#Í&v¨§x2mJn%çÈÒëÿ ­R¾^[àjaQé,Å²I;ù_õZj+æÚ²bÈZ*h@2ÎÌ-´ÎrØ­ËR()®¯ØFÌ°Ç8HÖT%dnâ)n
NÜc¬ë9ªvvÆ{ Ô§T-°õEªJ*©é¢FpI$r<C
LgmTtÕOTÕ$ÝGp¥u	ýtÀ"Ú6er­ª¾¯jWQ[î5E
M%d
Z°Ê±¢²%wÜ8bAUXÒ¶x¢Ü÷olçhLÇ#¶©»ÅcÄ§îøû,·Ë¤¯Ü¶u#,qöÕÁVI8
V2NqáÈ ûéä??ZF.£çÄ"mRÙ ,NOO8úª=5Ó=9ýjê[¬Ð]Æö¤Ø¨¹ÈP<á±ãïï©ôt=wS]HÕ²V|ÌkÅTj`ÆïxÁäì
yËxÒ)pg7r¥Ñs¾u-¾àÑ%%EÉÝBIÎ6©Æ7c9ôþWí5ßÌ©)éovö]Ò8!ÌËÛ;OVÌªz|(''\i:¯©!£Zî¶^))ähÖ{TíK"ïbD¶,¹+ùq¥uýIÒ÷
¢*ãoïÉKWIÛhÂP¥KaÕ8Ö²\ÙÉ§Qq§ÀÉ*ÚÎµtýå*¯·C¨JÀg¸¯Âä«ì¹ËgVzkÿ QÙbªú~¡WmD
YÝÇ­È`Ï¼cßUËUÏ¥¤ýÉ£¼¼£Qµìc}¸Þ1íd{è·¤¨êyKL±!¡ÕV& ±Ü{	 eu]Ít^X£-ÉZ_¹Æ5°]íZ^§º[ªRi'iaí JpN=[ó¤Ýk¥Ú8®÷ZùèêËGÅVÈä[Ò2¸Á2Äùi÷Uÿ <©K}ªª"DÒS/Â¨à@ÜÜºôê]kÅKSOEVPËÛiéf £mß#10 qùÁÈÕejV ªù¿î¿"ÃÕ=ã©ît<ÈoA!w¨giÔÿ QÜä0õdm`F5¦ª&êjíÕKU1C:© !ÆÚlpAaûkº²Ë=²jqXÆY¡§|$´RbÃ!²1ã]ª¬WKñÖÒÔÉ-Îo©i2¤uú·äg${[¸ÙrS¿À³OahªÖ¦¦8áR« H¥P·¤©Ëó<fìµ]JUh:¤ä½GmÉq·±!+Áyqêäq¨6®¦ª©ZêÒÄÛDP¹	è_9_'ø×N¡¡k}<fè¢(Y7Ûv
Ø÷Ã´«c9Q8'úûä[o¸KQ=º
fÛØnÔÅÔàíàòàãäj=eQ¹V5Ád9fîJr\¬£**z©
ªùç×£ôkPåîßTÑEPOÎÒ>;°$I1 äex9Üj³ÕôÒ=Ú¦c½,è1$§,Wßný%Ø¬8àëyïá­m@ÆKUÝ+<ýêjx´ÿ FÀA
ã¸×©WÒÑÃs5
cQÓÝI	5%â
HÜ 2§úóÝF½4RÖÀ³Z+ñú¸?Û3 ,U°ÙÆ½«mô}#[ag¤ªÆ)Ó?û§8Üñä¶uÕ^Ë<MV6µ5Tß_ÿ kÁg±B"²S[V*ZÛwrKtSÎ¹*psä«l>ÜcRZnvZu«i'HÃÇOéÈÜNàwdT%¾5Ô­QQ¾¶­34 q¨fXÊQÈ<®­ù]E<uT5Ò!µ©¡àKSµ²F@ãÛ[Â[åçÅ²|ù*ÿ nTâÕ~´WK=¶ª©\¤fIÇn9³à4s<KóÆ¬ýÖÛ½¶íÓ/ïPôÓH
`Ê!xü{'ßK:¦ÙW~kßI\(
Ê0<`5?p
¹RqýLàçö>5ZèëÍÂµ¢õW3SÊÓ;LÈwWDÝª .C¡Ç«>}õi;-k&=jÑèñËE-íhîmG?ÏÃ%¶±#GØí´îûäãÛ¯ë»}Û§WÅÔ¬^ÇVÖøg$AJ¬/áVTgL+.q¯XëÍöÿ CN¸	,¬Xï·þ`\nàjµñ¾ëz¦1RQ×ôåÎ%(»¢årX¸ß àr:ewCCùÐÿ úáºµ¤¤¾SÜ"¨ªé}]53+BÊÒÆî\<óÁw`jrµÍ[eZ^Ä0Æ#ÇIe@îdmØÚ0Ï¸m:¢ioÿ ï°[h«iØå¤w¦Hüîß¸)LûÛHîÝSGe®¥HLrXnÔSÔJ ´¢í&G#/Û@ý<ã\ùTwFårÅÑDé*É¬÷ém"ÕtêÒQ*°AµÐgX8Ï[º.ó[nêz{fO¸SºénPmÞÌQGI-ÕNçDo=EÝTôí]}¨ÝTçoµ-O©ÒLÚZ£Ç=$ª¬Î]¿­K&sÀ}ÒFIËdg:çM§hî{eÆK²éñÉõ=Âê±|Ïõ?Å ±FXù^Y2OêÂãßJlÈ ¹YªDsÂ²¤}´2æAÆ~ Àµ·y×f»ÇÕM
EÁ~eèIeªv
¼GëmõêrWûq¨x'¥¶Ã.áÞ0ÈíLXåID_PáÇ?:¼¾»/¥cå¤(êúD£¯åO0ie©ÔÇIÎý¬¿îó«]ÐÝíö+Ò¡Ù(©âÑÂÍnvÐÏ®ÞU%¹S:ã¦~k§ÕmôÔ²V%3ûe&ZfYTe°[y$Çuýq­¢,Tf&òû++)ÕéF@ÈHÜxãTkkoäÏÕß·oêRz¾³!OÏSÂjv aÊ¾à89÷?}5ðÎïûáõëg£@T~OCýÝxRt$öû%]L]AUÞÌDÌëÜBï#YAaÆXÓ«ð¥x¿áå]¡v«Z+Ú-Ù\ÿ âÿ ]u`µÃ<Ít÷8ÈõïmgXöÖuÑGhÑ£@ÀÖu©@¶_Ôë?ßF	P7¨iå½³éF[Û]v©pÇ®·×8~ë¦¬xô4hÐÑ£F4hÑ 
4hF Ö¯ôm­_é:}aÀ'UêÓ4þàH
ãUê£9ÆªÏWH¤ãCk«ûèo:ÌõCFF£F1ï¬èÑ 0u4@Ç¾³£F>ÿ ¶¹N5±8Ö«ß@eük]lþ5®Ç§o¥FO8àdëç4.°ø³x½ÔQÔ,+×r²Uvíl´¡îWÜëÜ~#\ÞÉðÿ ¨o	þ%¶yS÷ØBÿ ÔªðThS¦)^JháU5d½Á,¤8S¹ÏÀÛîuD3,¹vFMxGÓAI÷ó÷Ô	)!/W.]¶<~ø?m0<úiMêª8ÑZHd@Î±7ÈÀp <yÿ ÃîuÒþOr|yõ=_zh3Õî´±Óû#r73"ý1üÏ>éÛM
Õ¾²]½Ý±åäÉÒ5·é¯2ÛÅ4È+wsI´´íS8çiÕ¹9ýõ»5É*K9=Jî1DÈ§?Ëûë§­NW×È«
`-:ëÛÙfcøÎ¤ÀÌIéÁ9?}k.Usí:è (ÂøÖ¥H p23í¡1|*j'+.châQõõÎ¼óTÖ(¦Bë´ °5Æp«äFAãL/2Ô·f%q<ñÎ1ãÆ]ìÕuvá§ªù
FtêçÑ´ä9-È8N²³ÐÂ¢ªÅðÒÛ.UÕ³µAIãÔ#F¢øxÒëÃÔÇr8ÐWVÂÙaDÈÌAf`ØÇ'S]i)ã©¬@ÿ #Q4¿ú(GáxÎA<5\ê^´[7OÉW	¦é]ku
*v|UÙÌ¡	e cÛÎ²v¸=,qwið@¸Q^¯µÕòTE=¦<RÊ[·¸a¿O¾´¸ôÿ Qôå9é ´ÛUiÿ ©ÚBÆrLüÀdò~¦% Üÿ úM»ÐÅòH ¦-$,Òhò0Qõ6CúÈð0 õs©6ßÝGx¢e½ß­«O<ìÕQÚäSU¸m!¥ ®0BîR<ë-­ðv·ÝÅ/±7§«ítu-Ys¾ÇW7ø¡`<ØÎç8:v¼tíD¢º+å¶8ª*#oIP]¹Î<ÃMføoÓEXÆ°ÔÕni*bÇ* @¬qc9Ï¾«7½#Pj®u6;lñ¼TüÓ@7ºw:»ý½YÎï
¶´Xä£FKQ³ßtÈö*Nª¦®»¯(V®¡µGÑ¥]pFÞãÇ)¢½ü6Dw¬ë{É;Ã°\@úWsª/«çV¬ÖÞéÚÁ+ÅÒôr
Ìu2TAÞi@1¤E²02Àÿ Üéåu¾ºzZ+-¼TDÁ§k|D.p"	ÞÙ,} cTÛå#__.÷ì A|è
Û¥MÒ»©(%¡¤ÅKd &0
ã ó¦ýsÖý-s¦·ôÕ£¾ÖNÂÆ¢	lòyPãÅMº·k±Ú**"yR*¥k¬A¿§+6õ><x¯'Jô}SÔj{lUAdjXÌ/	AÚØ$rÁO«$WtRtu(NyäC--ÅM=â Ë¹v,¢H@Ã9P§ zÇmt¸Zãù*ûî Ú^0fA"Â{]ÃrÛcìt~°Z-îõ·ËÎHeméæ«N0ÜÇÓùÒ+E«¥d£aéÇºUE(5SÏL­)õeÈ¶äF ÅÒ;Þ9æ÷'ÑoªëKm]Ê®lá:tZµwï]²JÚI$Ó'N/T­zéô¹ÉmãR´æ!R­Ao6â Û>ú¨Ûii¬sTW7N¼¶ìîGPÑ¾q÷ +´òqK®oÖ«Â_«m2P©SQôÍÈ6*Ür@#<òuw4Ó1PkÓJÒùý¬7ëqIs·¼½¹¦b<áßaG¸RÇ§·{EÒ½ëª¦¤jii¡xÎÕë°Â@£>ÜÞ8Õg®zn²¹­R[ª-¤«´;ÙmR b¸Úy:´Ãx­¬´bðnéûp<î3¹ð¾Ê¸Û§$5D¢û/fQãû+ý%\.ß-gåP)DÓÎøÚäû}Ï\zO§ù©*kt
RÔ7m²q¸ 2<j¡KGW[
\rÔ¬ôÕ°XØ1/¬íb Ù0ÈÆNçLnp5Òª²ègºy§Þ°Ó;*&Ñev çHöÕã]Î·dNøü¼ï÷jhãlTÔ6B²5ÎÁw8ÞÙr>ìuúâ
(
=ÍN*gT%¾2rN>(Ë6u^ µZ#®h¦ËLXéX¶«pª	lê<gQ®vî¦¡×
CÕ	"¨zdjgFÏöÜFãÈûa¹ß´ë,uµ¦Ç54Ôf©åoÅ8#/¼aÁ ÈØlþüéºø²ÖIS__p«ùJbÔó(âe °FÑ°Ú®
»Õm%m5+qCKE3ï!Uq"àÓÏ:|KE¢²µ²³RJ²E>X)!³ê$ßn4÷¥v6aúTküh®$èªÿ þeOMò26þÑVe`T~Çn5^©¯6#)¬©xÄfnP«}@õçï­æµGIu¦¡¬éi¦ZB%ÄWÕ-½ Ï[Üj=EGM½âX²$§UW®¸ÌrÁY/êóÿ ãJ¨JX!º¹&_®ÖÉ,Ükm²ÅLj
)Hç$'.rpÃìÎRËÓUô	:ÐöX«Ë`L î(*ÙÜp<®tÑ¨¬uKÒËYp¥¶oYb«¯BùÙ9í·LdWæÉOG;Ò¤É'Ôågå0'ãZýÜ¡%È®5¾ßN¥©8á1FÅRHÀõz¤¶î=µ>É=ÂÍdµ±ÎÑ!UÄo±· FvîÀÿ ½©6úd5TÁ©Ñ\FkLQ?tÆøîÅ¹¹Ü­êeË³±§7«m%%,}ÊS!0JAtP¤zÐX¸ÀãR¸VUzvíî5+YØz®¢d÷ÓÁSTåçÜÿ }.¬¨þgÒlºÄ³3únÉÆIÀ_m-é;]m$ÏB¦u¥)MD¦EQìáã4º¾´Awª«FÛ*æ¸  #÷?¶NuË\CO·Ê%õ/Nt¾æ`¼XÅ"ËòêQé»nC6ÜIÎ5ÆÅSy¶ÜöØ®tÔ$±ás(Ús[' r1«E´MKf¨íW°ôÔjÚ­:Êð1åv
ç:¨ÓÝ#	nv¡¬®:è¨¦9ÀÇÕ8Ü}+àk[N¨â4¯Ì°]z¶Z9­«C9îHZ8é£Ï;IÏ¬¶x,õäUÔ]4ì¦¶*¢
ù÷Î@ÝG'ÆÞ®+
«¹y·ÓÔ²SÕÒ/êA$r{g'#n8ú¼Uì];m4öÚãRêEN'Ü­Â20%I`x%|êüYW;ÆÚÖVÿ ËGviDò¼dÅRÑ'%#ÁÇ·«V
z_´ÁWKÜÞb2CT$£0@®¡Ë{  Ëgp#Ôê
=ÆDµ*®)$»©~\ì'úPj
Â*ªRÔÍ%"=$4Bvª É#ïÈ>¢ø¢ÐnøìSPÔG"©®jé\«,£mY°Hrp	û4Ê­-¶
MtÒ½Eµ$ÄãsS	 ?NÂ[õ};úß§í1¨ìÈÅIM¯,Ý¶ä;/ ØÜ~<3¸[a6Ê
Ù£ZU@óRA)ETOmGë³Ãlq¨I%îe3^åµrUz~ä¶{Ýºjt¨ÝH~Z¸»/¤#é# «l ûë=g]eÛÅ§×WOPõ­LäîzVBHí,Ü;G°×j{)Þ\®íOSn.øZñ±8,ý$g j¹l¬»Å²håc¥sÄ}8MÙÝ±K`ãQ/k¤k
q¿(aÓT©PÁAQG-E%_nJ-ûfcjùÎ\ ×Ò=-2|ôåÐ,Ô3#-¾W 4ÿ ¯Ê	°×ÉvJÖµ¾h²1*Ò¢z{
¼c;vqÀðáÈ×Ðß	ºî¦'Q
¯)¡¸¿©*[!O¨ò$J¶~þÃS¥u*~NoÆqdËdï%óaºtõºfº¶u ©IÚÚâOèÈC+G Ào
êÚC1 «ïÃ[Ì^¤î´ÑG¶%¦¤ÚÌ¨ÏÚbôûHÚ½YËHç¶|^éuêÎ0^º\ È¹ÀçÆ|=úðÈª.¼ÔS­L7`*J¡£I,é¸< 8úFîu´¥;]iæ¿Óm_îzMRAQiùk-ÓÛe:ÉLp'h«îZNÙãhn	×½÷5TT{]ëlµI
òõÑ R}¹ÀCÆåBt¯©kk®_Éz£³'¦Jµ E*É2£Ç*àUÀaWåué¶mYðæ¨|òÒ&5ÚË8[ðCãw°ÖJWÎÌ¥PÍðé»5Ãá­zÜè«éùÖ¬nC$B0YÔ"fl
Û?â´ôltÝGÑÉ§a-U¢ Ò³Ì1²«y"XØÉÞA÷Õ;¢kæ²utOpjZ:Z»C%M*È^#4-ëÊQI³yS©ÿ .Ût§â©iå ¬zHÖA¹ä£!^Ü1¹L01#qä
Jj©L$¦Üxþ¤S­éGÒ}s_n¯$WXÚfXä(Õ:#`lUu 06ï¤#v3|¤¥I6DËX²9ÀH%P> ªË­w¾F®ÅEµ¢é¹.Ul6Ô¥D¶*É+ôý<àsç^Yñ·¬ÒP\ßù9qËÈi¼#d9 ûë,v§·£È³¸æ]Õ~¥6¤Ïe©UÞ	ÖTd Re¹#þ_Î®ij¹ÑQÝiê¶ÓÃRE	2gq' ]@öT¶lÑ'yÝex9íª²QÈb¬Ç'ÜkL]*zfíSBDmO\ÑTBgb!Ð3bs·ì¤sÉûë¯£,vºàqWMqéÎ«¶VÊ¡j«Òx)Cáí:¸Ëmý.4åhi^ÁB^:Ùe£ÅO½iÚ@;$ `¸eWüÀê×.¬»ÕuP*Í(¯hÌ»áZ6$r=öS»K®W)¯}>E4¨ÆÍSÉ6óñ¹Àr<0x²1à©rº£iÂR¿Ìô+wS¤ý7tã¨ÔÑÄRQæa¼ÈñäoÝÂå¼þ«v²MDÕqTEWZfÚ¬LÃÓ¼e°°|®ìàiÕÂëv²_m°IKMriE,ÐG$ÛV@$¦àýÀãHd¥«§4¦xbf¦62³.ÖxEoIÚrqéÒmôÎ­6Ú´»-·«tMÎ**¹èê¢g	äl
¸69÷ükð±T×¢4Òï¹c¨e
Â2çþyÒ;ÜÂ>+)T¢·OJ;`vcÈ!«/ )#\·¬®ÐÉ8@-ïÞJºíÿ ¿Z`m¾O7ñB
ÉôÖ5Ö04hÑ©¬
gFYÑ£FÁÚ#¦¶öQÈçi@HaÎ¬ÎLñà±SF5ÛQéNSR5uÑàËê
4jH
4hF Ñ£F4hÑ 
jÿ IÖÚÕþ B»á«µ?[jÁsàWª]µVzú3ÉÖ=ñ­ûkSõk3Ó3£F hÑ£K£F@
4j@hÑ£@4kÆÃk]dþ5`èÐ|h
gÆêzªÏýGGK4Ôd2§ÔÇéþMüÚjhhî
QQ$ÝZxa_+¶é
¯°É`ÄPÏØc^{À±Ü´ÑÏ»?nÛjü
Õþ×Ò*´uc`>\Iõ7>GßñªÅ\ÑÉªÜ2H÷êá#Ó°A<îû/¿÷ÇÎ¼Öùv¦ê)(ªeâTÜ£²|ÕÉäs¾3«ÏRM!ì[bPµÄÓ'/?aª6ëzWõ%RILÆOæUDI"FôÁ»<`«·ÛZÏ³G²	Ê]ÛEÑÐÃN0{k~ìy'ýI×zDïñø<ÛZË+ ³
r&#RTK2±#ÕÁÄùvÎ°¼¬#_³yÆ»*äë <ëaàêJ³I21·å,BXÊ6ì7§èNïýt®ùY$H ¾óÉÚ<j¢Ðlãtª¤ öå`îàþãíª}_WUVI==ÏUtù·
²1'P$8Õ{dsÇ<õm&$Mp=ùô6æ´AÔîÅÔá²¥³98'5Lô±zqM5l§ÐÙú«h$7{µ
\°ºö¤)èM¥±»YíË¶å¸Ó*­ìc°ÑP
Xþ_çfgVtà}Dor6sÎum¢0Ç[h¤7¥B¨\m?oN§"Ä?©$¤Æ¡Aõ\Ep%¦æªÇv½UÔ±9íÓþPyb?$ëöZ*
ªgË	^#EB ýçxn4ÈHÇç]¢Et§b1¨xþÚù2õrräÄUsA¶GuÕo)À	#¹_ò`ñùÔM×ªr)wí?~ õ¸.ÖÏßq«\õÑ¦ØÒªúélµ79sy:¹bÔD°9
$cÏ0Êþ
%ÂÙzéÞõE/RS¬Yj BÆI`Aþàx9Æ5]²ôZêê®Oóµ3e.Á°6æüùÿ ¿^§Ô­®Öv)\¶)ã1 T$chÂý9ÆG3höI};Yª`h÷@¸H§Óé#>#ó¬^4ß'§_8A5Û<ÖÉlÝrª®ÕF)dTù:`ØhçÙ¹Svà¿H,XíäWP*çJéjÎÅ7CEGpHØ7.wgvAãÓg0Ö×Záp¢QRQj)mèª=ªNOêbÙÎÕU(à¡©«Äµ5RÇ
¼YÆÒj 7`¤y:çÕÑíá¥-òóý÷x §¬xT´Q,Ýî:ÆÎãà£,¸ æ*R­Tf¦Ûu«©¨}ÕDK ª²;yø 9×zZ¾£­J»¿[Zè«é¦ÄpK_Âìe1Ç>±äûê·eëî±O$}ëuTí(Q43,`s1Q(´õ`qªl¾Íã«N1|¡Õ_Ë(â§ºY£®gÌËgn=³§u]J+à°·\cªR#eúÁÝE?myïÿ H6ª+«ÔYäºJ¢GÑ$oØÉÈs&åÁ#5¬Wî§êJ¨ú¤ís´;ÚzbC;Ä»Wv$#Q´ãs5XÁ§HfÉI9sä³µÎÿ òðQRÐKNªWLª°v¾àòo:g]W%7ÃÃMöàÔÂ$´;v3.1ùÕ
ÝÓ}yv<ûuÚ%AO·))YålÕ¿rÆpG5¸ô×V=5Ú)¨újáØ5Rz©.Ò#V*rvùn<l±µÃèåÉ¨YWµsv6·[®W Ñk»ÚâzêNàY*51VÚT&c é^}?,½Ü.ôJö¸ÐRÃs%À¼*.v¶ÞT¾ó·Ï«UKõ« ùK²Xë£
Ç$$. ;±î4æ§¾&Ößb§yM}Ñ5E<wEdE)¹Y¸LzOÒXN£jkÄ²Ê.çtK°PUUWHÔP²
@$N	EñÉ9öÕ[Ý*l°Yª¥­#fÙc²rç.ì
ÚO¤êrâJ{é±­2Ö¨Vy¥e\¸µ[Õ÷'ï©=0ß¨ê**-¨¼SÄg&3¸$ð¹ÔF4é"g©µÅ^¹ÒGÑ#ÕvI«ÖiQè¤{rí
cnãr@L¶«6»]¼«[àC©cGXæ!ÙÃÆÂñ|{iµ¾oÉj[A´X4;!ñ£gÂ®FGØxÎA?Y\"¡zËt3ÂCº*¥Wãj	À6Þ òÙöÒQmp[£ní|.QÚª¦Ó
4Õ
ÜzdXÁ´1;ßªW¿çL:j¦ÕQk_ºÒÅ@®^}Ø-íÁ\ûmfãÆ±IÔq¥z°éº(Ö	bvKey`(Èë&ÒrGÔãSÖõòÉ:ÖZÄÍèùÊÊgé yã-òfàâÍÖhI+¢m*ÒKgJx¦JËT­P08=²*  s§²ql¨*¤Ãó.^hKd ê®O#c¾I+ãKé+,ñCÓ}cAFi·ò 7&Cà¶rÀmp®ªÝ,´÷;Z*uGFîÁ0ppãwßÜcÆ¢JUÑ´9µMhî÷¡_EQ]n¶	*PÓy¨(ÎÖçþQ'Oh/4·)á·NóÐrê>éÉ#píÉ|gçÛIãêkedýú¹j®]±BR aÀ,	ö$¨ÎÜg#OîÓY®-b[^·±Þ®E|;mÇÑ8xä"S*¥ôêëUeõ5Î¢u­>c
¬¡Ë¶A#Ü¨¥¤ªi©«E
Ìùà° Çñ¯M»Rôè ¦z¨*_åÃF'fGc¸Á ò>þúÖ}·ùÓÛå«c©ÚfÛÝÀöúcç\ZØ¨®?R©Þ1Ø«º·ÖB©5?wd6»c§!Oämték-tÐ¬óPNÊµ
"SàðP7þ4Úh¬òPËC[kù©Î×Q)Órb>	ÀóÎ£½ÝkµÚîÎ\,=4!/´·Õ¸s©ÛÖÒ²ËI©.ÿ páO]CG]o¨ùK²8M¨pÃjHßú=ÇßH
ø×:íWÑòòÓkéx¶b%ßàÊ3ãH¨!ª«®¬Ô**Xö©Áí+ÉUpÄÇ:`níréJ:èº~à£åÜ¼Ã{P¹BçÑx'¼g>XG£:_~­¹ÃT©ÒIãÿ wEô,y*Êù<*´³{F¬OAQzËÛË$±Ò!JynÑq¸««*U~ßs¥]3rHÍÜG*êU¥YÔ3ÑÙÅ8Ü?ìém©d³ÝYUe¬
¤R»0Ñü3 qä1<d.O(¬¿»g
~èíÓÎïn­és¶*Ö¡bxb§njµw6Ï·ÏÅu-e)¬¸Ûî7ÐEÜD&Ü	S¼0õ:£6NA*¿«]áéÓSE5M5<+ÈDh_iÜ"%·ùUaNvç\-³Ûâ¬¡»Sò¬(»uj¬©S±7zciÓ´®Þg¤«"2PMIòsèëîº²
AQX^UÜÈ¡
²ôäeÈ;ýôºöÖ©*êµ*£B®Õô³)+È	µ¤'± î×jQ¶¦ßÑÃUSZå©éä *«9#dpF¹Ög¤§¶Ú¡bcDKÜe;\ÈÆ0wg%ÓU³©<p{£Óì¦\¥äª}æ¢biO\´lp}.U¶8Î5|øiy¥§¨þYÔ**-l±NÒW¤FÑ0 mÎ
«cêÇ9ÕfÅBýAMUfHiÑgUd£rl` H8]Ò~È*¶³ÓMYÏåë±èír2 ²CÆ@ãW:®çh<P6ø±ôÓ]f³VSC5Wr*T`Ò0-z9	bfÓIpxAñW¢èéj
Ö
8%¤¬Ì5KäC²¹Á¤Àúv®ªÇN\­>ÜíÚk<LpÓ2ðUCµFàÙñkÖz>¹º¥ÞðN@Èx?Ó"7ìq9]êk,i+ôTãÕÓûýÏéëÿ ÉÝZ¢©ÔÃ$8
a»Q¼IãnÕÛàeÖÅv­èjØÏ#×Û6ñ´mõoH
ë÷Ëê·Yb¨éºª-5ZÉ)"*²Å33ãAõ¡[ ªç']jZ*î·uu½
ó§åIS6àÔÛmP=m£ÆÑÆ«íi>ÎýVÝF'ñ/÷ñÿ ²××vz[]óù¤"Nñ©¥~Ë6ÃÙJ¼úyRü)Õ0ÖGy¼FdqMEÜ%Î­_r)K©
Nc>Ú·õRÐuE¦¨iã©¥ê#©.6©p¡?Jç¸Üç xa¯
µºPß©jCüÑ¥F¯,_óy÷mg#ø'A¦õp7µÑï×m½mðþ¾ÛPgiJI¡íäg £qFo1rxã^__KUm­é·¢Q:ÉÛJv$I V%×ÓHÜ6zOPõ?KQCÔÖä­Õ¬b¤Ó°$ «Êìe
êËÄxQ¯=õË©Ë%YëywF2V;·nõó·Ë~F#Q9/§ðÌê^ßòyõ"SQU$<ÈÕ
¹ä12Ë!]çÆðX`øÚ5ªmóÉn`²"¥+n¸¿©wþ-ÉÏÓo:Þ÷*¯[­,=
\²UÑÌçcÈ[kÂØúp/ c oÔõÔÓª!¸ÌEêî1V?P*î*È|çXS,írßExÑ]¢¨U,´ïIåÕe#oõ{g^Wd ¢¡«¾Qâ¶áÖ«$ ªR[¨qBñã^a 
¹`ùU¨§2É¨É½AAos¯^£Z«·ÁZi$z³]mZ	â>ØVÀ#¦5VÄ  ý8Òîº9qåºõ?#$ü,³ß-¬¨hª¢÷ãÁ]s¤´vµøvËº]ëéþn9©
VB$d zv=#N~Ê·¾»ôëÈÊzx)iÄÃdÈ=;×ÛéÎ¹õ©ª¥cZ´ÔË,39BÃ´fgjþoWØjd\Å§·ã¯ìo[k¶ÿ ±ÒP0K_ALð­Dë2³	¤Láã¸Ïç:¦YÆ{3BÌ²GQÎy*PÉû¼jÉ{¸ÇÂe=l	V`£ùzÙcwË1ìõ6
Q÷ÇÁÖ?Å_PõmÐÃ¼3&Ùÿ â.ùQûù'WÆ½Üº¾a.íDèÑ£]'hÑ£RF Ö'YÑ© o+¦4°çK£ãO $6¤æÏÑc¡>jPÔJ¤jXÕ×G?¨Î5%CFü}Á@|èÐhÑ£@4hÐ¹Ëã]5¤ûhJÜÈÛªôßâ§3Ç"äö:£v{Z5Q9§ þFµØ}:Ôjy4hF Ñ£F÷ÖthÐ4¬Î´,rt:=õó ùÐÐ|hÐtÞ©ÛþË^{ÛSo©þÃ´ÜëÎ¿øc^¼´l75\A×B$û@cðuèÝTªÝ+y}ÝS»ÿ ú©pF¿V`àÊõÒUð0ïÔGêGµ¥£ØîµQQTWTº¬H¦F%°6 ÝÞÙüéWÃX\Ú¾y'zú©vaÕp6!ýûk¿ZlÒ5YÂ8Ñx*¹ÿ 1Âä6éÊ9(­GQ!yÌG%Ï,ÔjÕÈóeKæu¹¥8ª~PõNÜõûøÔjiÒ´öø$õI¸m'h#'ÜóÎ5­ZUVÔNdw£¤Ð»°¶ysÿ 1Î»[
4BH¨)X¨+ºR¸£õøÕ(©~ljD vGï©ÀÑÎÝjÌßC>Ù²¡`°VfÇÆ­TpÓÚÌS8sÈð\+)è)jÉÕ'©îST9¤½1Ã®G#Ò<äð¤ðuFwiq<2ÃßJYÏ§ûýµ©ñSqÚiJ$O*¹(I!}È$þu:z×PQîiuUS Ìò£îGÛÀ÷ÕÓkßü}Dao¶¶¹1ß$zU·SØ£ì´ç!Üçó©Ð5DELÒ@¾@àÿ ®ºËWe	ûãQãR~¦9ãöûê×}nðE§í[¥/s·3TìvgÇ:[]°ÕHlý0lÅci%Æy Î¬¸V~1²3¬OSTñNiÐøÝ!È?îÑÑ*SíòU.7bZëvZxaý0b[
±þ§þÏ×Ì&¥íZ«?¯´É0PÛÔ»ìÚHåF<àtèÅYYphg¬3ö£VivÆ$ÿ éEu7SÍx0QÜ íÅÅ9Ç§ØãY¾øÜ¤´¼/GQÔ3M
ÁmqwEGí¢±à*s´cÆ5ÒN¬zY'¹õþd :zÇzÉW ðHþÚcShºÁqa$Ô©URV%HÎæC½÷F=?WçÆ³yi+Òõ²÷Ðúj 
¿~quIs´ßÝ7¥ûÃÊkmÖ×_%»ÐH\Tw-RHÌÊÙR·¤ZW4ÛÓ)!k=P&ª$¹_Æî;wr¤T¯¤¹÷ÕËªé«¬öÞ~§zX4ÌWs`Ì7³ý#J)lÓµ-MþiaHðrFAÀÈÏé'Xd_J=</IZÜ:S¤ÐCn´P5.CÉ
AÂ<Ëð2s¸:°ÙR:A+Ûì6Ù6õgÁF3»ý8÷Ô¾´ÑÙYjX2F%Ó`gÃÁÎTûq®ôp3]dháTóÏ%I&)ÕÀ	»õeK¡ñªÁK¶[&\kØ¯C*ªÊwªºF&C0dXÂ¢ª1$m÷'?c¨·:í7êK½ÉwUÉU4âTJs(ÌNHÚ«ûêÏlY.UÝê"¨Ñ%Å
ºcp~¼+=M¥×*[U?Í{Ô²ôÐ-)qQ°	8^}9÷Ö®¶G+]¯¢5öÐµ¨®úú¡%®)%¨/4nî{`ôe¶¹VÇ'IìÕ¨¢¿½R±@R9ûøQm(ÅnÃ´S8e¶$¶z¸x¶²)óÛØá0@<xÓ b¬éÿ ®üTÝ¶nMìryÆìcþºÅ·5fö±û{ûù+µ=7Kxhà§4¤í$B§¶N89'9×²éEm©¢â°Ui2Ù'iõ7çÛQd¶\mUµµ/Ý[z­;]÷ a½YN=Jà6ìó«[^û¯^ëûñA Ft^A1õã$¶N1¨ÚäùTÎæÛ%qÑôÅuÔ-Tef"A¢ìdãÞG?s®§³tÕTÛý.W± ÎHbUHð28ó®¿#AQ#Olù¬2d­ÜZelíTÜNæÁ_Iã>ú_Ò×{
[á©J¦,ì&LãVÜÇã|ve,ñqÈê/ôd{Ä}5üÎ
IYà¤$
P$ÚáÐ+Jì Æî_>u­gQÒÑÅ¥$©¥efÜÄúF¾Ã ãÆõ
áÓ×
{;üÌæ(w7Hô3``x>ÃVë5}¥ÿ 3Gó±²´j¡c ôçRäö²'qÆIî¿¹;¦îÔ'±-ÖÏ]Æ Ëõi8åkþ Ôê¬eÛm·%U.Ê'¨¥4`)Ý¼¿Ò7xÛù×Î¹FdSD]_s¤ª²ãnO-éú¼ñùÒ;¢_,7s%¾¾¢GÒI¥Úw²à
ý¸Ö¡Äº0Ç¤Ç99cúqÚºn
JÚyúÓ-P`Ë%E"	p	ã;¼©l`z´¾Ùk,µ5æ$Yx§¤
DlWaÀ<¯#ÂøÓÎ§hä ´ß­©$sÆ
Ì²HK©*	Æá8óÎ¢[írM=
Dw¡5j%,pT2@ó¬ÜåuàÚ á¿¦ûì¬VôWKÜí«KjéxáîÌeù'yB U<lç;O§Qm]Ó1Ø¥{¥Ã¾§°¦± rù$í*F0[Õ^¾]º~è-äº·(
zIôòØ\}µ3æºY«(ÖAÝI¼Jí0Ws)^@ýtõDÍ*[zýJOt¯N×Ú ÿ x¦X²¦ÊfT`ÕO3ïÎÑô7QÇ7zÍ{UÊ¨2wzÎÕ\6H9³Ú éjK%ôÓ¡¹ÊåóHËHQç%­#ùñ<ì"±,Ò³)÷óìu{IrRVÞÔÚE1ä¼[îrÖ]nPÜ©ë#BÔ-Ñûa.£/¨çËasäé­êçFn0|Ý>xAV¨eVPçåO9R<1¾5òÛ<k\+uK"Æå»Mãi)ÉöÒ¦´ÐÏQÊhÚÝR¥>X°F
°`|çÆU¶í¬¤¯³£q§º×ÑMhcª«¾ÐC,òÂU)§~ÞàdçÙþàsùÒÛÂ>¶¤µ»5*½1¦hvw1
w²°\êÎt¨º®áót°Ö<Â8û"MîvI¹NåÚ0ëÁFÉ×JI#¡Ìn¤ :ð,ÀaÆx§± ¶ufÒN¬3·O´2énKKÿ 4¶§û?pPÁ2á-¸{(SÓ:w±RÛ«'ÐÕU¢)Dì¢-Ú6rp8\gow ¼:÷èê«.sø!²®ÁüVÏJä¸#'ÒNºÿ 2¶ÑÚ%kK,îÏÛ¡§N$VL(+ÁwqÆí»²u*QjãÕhÓRöØmu5SÛØDô¥ØÞNîå[§§¸ñ¦:~¬Ì(¡¨ã(jZzAóÂû¤uåHÛ³:G¡Î³Û#£ ¸gl¯+¸mMÊ|y;xÓ+¥Þ¾J8þrß#²±ÔÜ¦Y$V$ÈSêòÙçP²qTjô²XµÁ]èV¬ëÆ
u¥y©>Ìåw;Õÿ *øËs­î	~»Ü+mt4°ÒÒÈ²w©ÖRØÜ9- ²J m1Ï¾¤ÖGw²	!Ì.ûâðr¬H_<D¨ùÞ¼ÿ !¶9(éÄ).Ì¾ÿ lç8g:Oé8Þ4 µ\ë¦Ýp[5¸íÃ#
ùhR	ôç+|s­ë*¨§¨¹AÛ£ªxé.Q<xUQê¸q·zu©JZ8ÄÊdxiê¥¨_÷xöïÜFÐ<98Ûã!ruÛt¢¹Ú¦µ×(µbIV8÷ <¤ÿ ~5´Î¨IJäön4°GU~¶ÄWrµÊKÈ½ÎXÆÀB¶ïÎ4öÆÏESE]*qü¶i@ÆR¦]KnÎvøò{%}ÒßQy%cQ¤1ÎDÔ@¬ o%2Oq0ÅdÛjå]o¤ÜÖéÞZZø	 ¶ÈwÄc æ6\ -ç¸Iª<]FäÝÉføO]5y®¶$épÀì (xÓ¼¿Å ©
;qªÇCÑü­e5ÎJIá¦¨©xê(æÈ`FyÀG%¹` 5k½]îÍ¢ïué·yh«
SÔ84¥· !¹ÔºçÉòît££c=/ÖU#VÒÒ\çq\bE~ñRPp9¯¶rX}µ¬¡ïR8ðætîÁT±%m¿¥×§$&jî¿Â XcGsM1!@\16¶«×úft4£½uÞÑÄ
JI+,"pÀ'èô¦:~²ÝÚ¦Ý)èãO	2ÎÊÙ*%IvßQÏèÒÊËÜ¾±,Fk4ð´rSÎîT}¨1Áw7c÷ÖJé®"RO¿òXz2¢á[Qü8êH+ç£­ià,D°L@ÈQî q¯=¼E
¨lxªÞ¥ÒÞ=vçb¬$yÝ1¯Eê:5/Å¯¬&¢¸Ñ
J.PT¬,ØeÝµÏÙöÕk®­b£¤í5nµÑÔ¤W©.æÿ ë;;¹ÀAyÔeI¤ÆRÜáÿ lE×ÝTÉÛ«§G$¦róLD?2°LÀÚàxÊíñªÎ¾¥ë©¡Zç©hò"nß+ìÃòo±×§tÊáQw¶ERkinÊ«Erð´@	\*ê¯í
þ`9×^"®¿[ >åD=ª^Ñî&6¦P¨²ï2xÔ4äng&lÑ,kT"<¡Ãfõ)ÆX~W>úöþ¼ÐÐV\¤3üêÜ#ÔmI«Sº0Ns>ñëÌzV¦¦O¹ÒÛÛ¹]O¤ÿ ÔØM(ø>8ÕÚåKM-ÆÑLU±Ó¨æAVZfWpÊÒ/¥ÏNÑÎ©N)pÂuOÈ³á}ýå¡H¤ù§xêÈ*ÛÝV~Db<qìéÎtâô,;K6õª¦í«mfÀô1bAó¸ûy©*ú²UFÎÕÉE:4|±Täð}YsäëÐ:*}¯¤©&¨5­zD«¼¥`±1Qµ ùñ¢î)Æ54H½SS×|,¸E$ÑASU
EM]ÕÒíRåÞ7#37dçZÿ ¢¡­½G1­;r­ÕýL)ê¤«¢m÷.ÜZcW§0RHûRË>c9Ï8·ÿ tÉ@]êêk¼d £?íoó¿WÛ´kÚÎºN0Ñ£F4@5¬ëV@è¼L¤9qBEõig6~%¼¨þS¾Úº<,¿Q4jLÃF5 Ñ£F4hÑ 
i'­õ¤IÐî§ÒNHräiåÔúHÒ7s¬ÏsIÄM kÄF³ªÁ£F(cßYÐ4£F°tthÖ :Ôù:ØëSäèXÑ£@4hÐáSU¡!Û(RXmÿ õµYþ*|:¹ÐÚ¬5b^>£½~¢>ØP3ç êÓñ:ÍWÔzËA«¢tòã?ê1¯6þî¿#EYaÔÒÕT83Ì£··;ËXuTýèãÕAÎ
AÔªÕ\ö¤Ý×V%B·ô×d7V¤y#í§1ÑFçt¯©Èó.µSG/PVU	$sÔLÈÅ§)àsÏúkUòÐüçþ5ÐxójÒ!IEX]cUFßdúG¿#Á9Ôª*«ØC¬²_ò?çK³Hgª] d"y¿ÓL  ãBk£p=:ã2¯¨ÙÎºK"Æ¹?|
`0$÷ÐªD[)R©;{gÛJÞÔ©PÀwºI,\á¹ÿ ùéÜòâyB3ã}r<ÓðvuäÚe4£)¢í¨\Xàó¥¥jOò6êFyæFáTÿ û5Úª­Âb;¬¬%²'Üþ<éuJ¸YZYY0B»@îÛí÷ýZtm<îf±Ò¥<5Î¼n«`N üþ>þú5Åâ[eywnUÏ¿ãJkÂ÷hÁùxæõl÷Aú|±çZU^¡¶ÅTÔ÷jë4qY¨ í_}¹3ë;Hèô¥7fªé5Ä%MULç*ÂßçsàKãL&f¡¨¢>ö7¶è÷ì s¹§Ü4áÕQELÖë24Õq®$za!·Tóð	M_vº´UËYOe Ý¾yâõur\mSá|ûgVYìè&DR,×[í=½c¶Øáj©³Òä 9Ü|é}úßb¶¨é¾zäùV¥Bän<W$p=Dûj®dJjzy$'dóìÇÇ?¾Hß?Û,4KJ%dtÎÖuÿ pXô:ÅäV¼zL]>kþòb;ÅÚåtãY%,¡q¶en}LËA í¸ýõØ.wÛÄõäw£¶JðBzÒ<cßÎ±Qe¸U9¢µ­Aí<"]v/®RHøãê×
+L°QÐ\«nAÚã}À`ê¡HnOÓÎ²n~OQz1Oeu_¡2X ½×OCòrÕ-3.Ä*Bd*;s®ÔT4ÓÂôµeb°$ÛîÜ0søÒ«õ=¾ÃSvZzÇP­8çT6¨ýCò?:Kp­©éËqºïr¸yã¤O
ÁNSÚ8å9ãTMaÔ§Ãð\©k¨à¨X­ö×5vz^5þ£¨pgo'$s­©kot¶O÷JdÛ¨9ÛÆÏ$û%¶ÚlâÞS\êª+å*½ÞUSceÊ
ØÛÉõÇ\£ºÑZ®sÏdH)$U2>åFpÛC¯¹-Ù:nòSøx6ö¦ÚùVWÒ¥CS\ÓÜea	M¤aÎçÀÆ ÓÈøêt¿1³í²Y[fÑdäña®Bk.[haVTC%\£µ´ðv#ç)öÏØk§T­¦íÑK
ÊßýiÙæeÉ;2d0'qà}´vù²ði5Ûó­¢õÙ»°î]È% +_M-Ñ½Ø-m|üÒFª63SwsöÇ
äu¥WYc¦(DDhØäF úsÿ MJj8è«êë?  gUPápÛsêñàg:Õ]ñÑÏ9în-«_ûQJÊoÈO(¨iÃ}^=Ç>réËýmd¥ñÎ¼² ØÈúAò}<q)ÒðUÿ 4K°M¸È@Î  1ìÓã:+î5BåöÚ*EhÎ±¥>ÎÞ9ûgVm·vs8ÜZj×Ëàã_l¥àë=ÒÖ¢Pú[zªsêlAûk­%]%-`íy¬ß2íVìÊUÜ>n ùãHz¾ãJ°¡¨£BÊdZÚ
àÛà_~<k79®íÒ¬²H»Ë4#FùÈÁäùµ^¿&ø«½OCg6z×ºÝä¯w3¬õ`w
ª
Tçf Çû¹Ôgêè®ÌíiH(9ÇuÛÄ®ÈÆBÏ¯u^éd¶AS1¸ßjçaE2½6PËOùq¢®f¼ÔÜáx+Wà#h*8Ú¡\!¾ÃY¼êòÏK¨Kå1ð­ÛK5<T¶ê½ÊGâ2¯pN]£©KOl
 ¢1(1²K0Y½;xÞ®æÐM}é;}ÂáG!¡¥=\IQÁ:Viï5)%ï ÚOpGJàÃ7{7¶¡¹.;²¸qÂRR¦»Ü­þóYKX}0¼÷` 'ÑËÇ7xÕzän¦®8ÙèéghFÅË7 åw?Æ¶¨ÎaI#æLY
6çiõ~öÑÞyH	4ÔÛ%í¼ìÆ>ùO'ßY¹5.Ù8ß)óûî´Õõ»EzÉSQ	Cº(ÝA,ç#vWÁ\ZL×%ªßZ°<r%TR°u!CËÊG·¸ÇW/5ÌÔö6f]¨GSJ°  xðIük­ÈÔÙiè`¢®M;,FTÜÅÃ6Aðy<úZ©»ºäÂx=L[nßüt
Vk¨¨¥98mòvö¸]ÌØÊ÷9|`ªý4:+³IDtKO+Âó'À2AÇ¿q©ôuw:º-vòßºXá=¬v
¸çÀ?0®²WG,±],ÊHNðMç®ãî ·Ð6êdºìÆ/dåÇÁ%Þj2Þi5Ï;r¨bB©ÎÑãÎqÿ ¡ÖôÛQ\)ëh*þ^º5Ú]åXåú['öÎ1­hèëå=¡®µ	B:àø}8óÎtÒ:óQWmdH«oR§#Õ·0yÔ6ÚJJ;%xÝ}¾ÅB¾!T)S@îK«ÆYIb¡Üªr}'!q;¤²­×-E¾
[¡*%VïÂ òaBðx9ó¢ªÛOOUm¦IÔ5]1*ôôQv¶10ãVuË©êï6(ZÍ|ÔTðÉÞJ£H,
²*T¶Éårå[>wm¼k¦S&I9-¯½_÷DKT­n§ÌÜÞF9ææäcn
ê çÀÔÛ=æÛS¢,W(QPqPÐã$ÈÖ	¬¬¶Æ.L°|­C$TÑÔ#cw²ÜÉb161¥6Df®ÅÞ6Ér*Û²g*Ç>°GÒ sª6âèìPHî$Û*¡É(*èh­/ ´jª²q¼»Øatúç{¹TÈÕ1UÑ)eiÌ°Ì+È_VpÅ×aß#ÆN«ÖJUïGÏGO!häT«*1?O>s©×þ_oJO/Qr2ÔÇ9îÄc~@HÈ-o+çU\hd(äHéÍº¶ãÃSÙT¨Æ$+§(J1RO$÷ÒgÛh¸Ô=D?®3_<
Ì20s«NXiëÿ Áv«XP»ITTªÉSÆ #ÉãJ ´Ù¤¢ºÓÁQËáY­Wy#ú§h^T«c¢MÄädâ¼îªÕPÝ¿
³vHÒÇêÆàÉSÁ\:ªu#SÞ)nf7º¯iö¢¹½àíûgVøf½7]FóÌDÛ@¿t¯q0m<ùÏfÕÊTùE¯¡	UU$B¤9Cíýß$Ê+$7G²óðåK#ÖÙï0E$ugÝ,FÒêOÜ~à/ØjË×vÊÞ£¦ ¶µZ¡}+Ó*<£eeÚJú[X7CØ×ôt6[®yjk©RM¼a$ô'z=¼~ÆuôMÖ'\ô"(CWÜHwE*¶PÎ Èüt`è¸³Æ×ÁàÔ/¥º&Y.vÎ¯é))^¢ºc'T_Õ· ò8óðFFªw;5$ín¶ÕÎÔõ4U?.ËTº=¹'B}ñr¹hnÒÝh)ovÖsU=ÔFR8Ü P! 7* öÕ·Ct¤§ê[s-ÊÝT\©ÊN$*ÎP7«Û	ý$ýõÒÛKò<ÇfOå¾ì(ø±ÓSÛº6JÙk(eS¶zÍ c  i=[¸Álø$ëÁ¨fÓO{³=Ý$Ji<Èxýtþ ªÛqçë\kèÞ¸Å«ª:rDp­*×Û·`´QTþÎvTÇ(ºðÞ ïr³ß#So©ÙG½&«E=¹ÚDrH»í.sayG¡øtå,nî,¶|CµÍÕ}!Æ7EÚE3Ê<·)Feÿ ýõB²ÝE¨b³WºÓ	âGzqÜ(tr7nR?ªO0;õè}!t¶Í,SÊÐnZTgb¸ÌglÈçÑïÜkÊ¾+RKoºP)j*aQ®ôO¸å]­	ó¸ãÊKäô¡ldãÚ]«êzGªæ¼S¥BFµrK:öG<n"¼6áº'faõ
Zºÿ 9¾Á+É
%l+S>0õ
þî º¸`	ÎÑU~§X®ëtôµ^Z(6¢*ÙP®2Û·î>çLºbàk*mñÒA<Uô)¦¥FpJb3{OÇTRµùb}gñ%g]Nô±E<MQ
UÜç{,ùpÊÿ æãwØjÓJË%å)'{»Ñ³¼Aª"®ØÝË úÜ}Rªez[øº
i;ôµ®s+âsã>úõ©nZ»ÄtuOVµkv·(tQâåcü®ÑgÒÃÕ"ûçH%8Û-oU+Ë(©nÌ*i^ZpQ
¤xp±øIÏ*G$ëÐë-é
-+_s©ig«JÊARBÄªRÃá:§SÀ)jjZsGCTðÜ©`h6¬Mµ&ðÊÃ'Ò3´'-têf©¯¥¦UÉ%u]ô¢V~äÄV6*=+ºFÈBzµªKu3¿áø~DKq¢ºt5}+é¤­#tbF|Æ²ÙÂ»sàjÓüVé~§ |ç»O¶øñÿ êkÅ«fª´Ey£§XéêÌhwªînÜ»ÓÀ$q¯aþhê¡«*iZÿ ¶ÿ àÚ¾5É¢o&Ù>Ï }µ5º2
4hÀhÑ£@ÁÖtjÈ
L£ 8ÔMJ¥úÆ#2à±ÛÈÀÓ
-·{i®àå^àÑ£F¤Ì4hÑ 
4hF Ñ£F5¤¿IÖúÒ_¤è7op4O:yuà¤²b{_¤äÞNÉÑ¡Ü4hÔ 4hÔÑ£F5¬èÑ Ö³£SØ0u©òu¾´>N ÐthÐ®ìëcãFEfQ¾õ8dÏØx7ðtñuGQÜd%£Y$^ò3$ÌWß!ãð3í¯tªa,òÜÙN¼Oø5¦JOågZYZTGÚÙó¹³r«çÕWFYW¶_õ)#¡ç9ÉwÉÉÉÔ"Ì)wÎFO[ËØÀ'\ÝÙf9òGuÒ|çõÔ`Ç$øÖN£S$# OÒ3ïùÔvþOý4#ÉvTS»oö:î /¤
B[Çb$*;noû´/fQ´ÈÑ¯¿AÂ©l nBøÆ¥TÖEK1àît¶ïq8û"'©¶à¾{idÛå¶ñÀó-Q¬÷éä9kYDáW`2¥¾üóïªì­¯PäÒS»ébýr ~¢Ð¹Èç\ºç2ÍFjr<& úKf5Æ7ù yInéÙjÿ qXì½¢cùE©ïTäîaXäàuÍ9¶é¾O«ÊêúG}¤ìñÛÕæH±Ó®äÁ>ø£ÁöÔm«uº*D§¬³4ò8OsãhãÎ[dùB)ãíÓÑ{M°aTo,ïÇ gÚ×¨º²
¨Íb¥C2ìòKÏ!O¨ãÎ ãQüÏ;`IêÏörÝA%_vevfïI)ELéä(öQãHb :©:xbWR«)eS=*IÎH>}ËcµõP¦¥a¶ÃJÇ%KlF=g>9 rí*Z«5?ûx¸²î×K)ÓØã6ê­îw#|2Ø«û*e©¸@b¢ «ØHÝTìUªP¨*QB³*Hbvqº½þÏM¶ÙOl£¦s¼X©WiG'r®OÛ]²¹»õ0ôñE'õRt­@dgã0öÎv¶F«}Es¥mÖë4TâU|Lòc]X
ÆÌ69Îuj©Årrå#5ÓS×3kè©»²È´
ÁsÞ
»q'*Ðs­V¶,±QÓÜ1ÞYª-ìNoñ¤ÖËEe];
º)Üyn»Õ#3fàµpÌ{éJÛîow¸µí ´S1~äÇº71aÝ%ÀÃ1
Àn _¾±Ù/,ô%á!Ö[l3IUIPîIÔÇ8irÅ8^qªçNÐËS'óº¦·G9j_Qú·í,ØàGIi©XÜ®ñxøã&bABªFIÉÇéÈÎ®­Ûwª:Éclt±eYX¿Ôl¨-8ð§Æ¢PòZ9£ÛßÉºÛt£ùXZºC>ð±K#ÀEÛ´$ú½EÛò1WÁwº: xh×Ôû°q¸ù¹U3§%Gtik®40BÒ³.æø$ zõe½ äcUK×J^¤Ô-|ðC#,l^&d ¸R2» ¹Ù»>­YãmZD,õ'ÃYÚÅiÍ^ÑwaFÀ¡yKÄå[o¤y é\%¥5){¢yc}ûdOVC	]ªÑáÔ >ù:ç$L(íTR$ª:iLs(áÔíl2>ß§Vj¸^ì1ÅGMI=*±6Í l+Æ= 9ÖqVÒ7Y#Ûæÿ B%×[¡545)(ºO¶ÛÎF?oQ×[¬w÷ÛmtÓDAZW\ãò¾qï®½9-l}Ê+¬Kòíó
¬Oòàe¿oÎ·õGW ¦¬<ª²	O c×ä¡ûz­WÁyóáü:BÄ*ms%MêXé2È°´¡FU¸ò3ç<ê5Î>¡±O-ÐÑi¢XRN¥Øñêd~QÇ#¦TÑ³C=ºI÷I7õA7d§$ñøÖõ]màÆ©Ù©mªP9úP[ßiIDçõg<®ùO´*½_èº¾Ç,q§§1Jõ	æ6]»¯Õä`-CÅr©¢­Zk­òî®í­ýY g;yÖÝ9COKp¯ªOËómîdÏòò5	)®öY½ÉF±-<û
"Þ£húv¾Tyûë;ouÆ
oâ¬Mx®£¼Ö´7x¡¦a	Y°àe0}KÎ>çï«Ò µ,îéS5¼,±/ôðà20Rq±ýZ__%Mi¼:ÓEj1éÿ L Î06ùÉ¾\(Þ;ÍÃÝ£¨Ñ\o[Êû°ñªÅvtÍµ±õÁÙh¢5F©7nõ!Î{Oï¸÷ÈÔkkÑ¼G
ulG¢!vÒx_¤1È$gRº¢¶Ý|µ[55vèÐÉ4Iyûc§p¿Þ)®ß¡1ÎÊ²<¥c]G±#Àý'Æ®ÿ ØäÄç4_SìÓ¿1f¾J¥Nä4«µ»@¸ÀMÞG'¤Ûú¦[vÛ	sÊú½GúkJÊÕM4j«¥D1¢,F}@úÕéýYë.Ü)fZaý9^MÏ	 n@Y|°Çfß'D`ýÍ?Î× ¥¸WnC,maÞ0¹@Ï<äÏk¥T5T5oªI·KNÓ WPúCàÇ¿§X¬*.)Xô¶êv¨§+`­Y³B(ò77ö#ßH»ÒÇUPVÞ*FGÞ©HÑ\=ÇR<x,HÇ¶­¶JF^¬RYºrY#éÊ»KÝ^5Ìb"ñÅéQûvÃÕ01©×sQÓSQ:WVìÉ;É"#®Õô+Æçôùàs¯9·õÒi'àÆÎ&¦&ð2íµ@`@ÉhÀÆ­Öîº´ÕÁ-e}3Te¼»^¥;PA<É÷:ÓÕåPË»çõ-·
AKU[Ó×M]Ò¬$¦
ª%QUÎíØäuÖÝ-¤Ã4wJ± vãË< ¸õH;u]¦»A4¦ïnw6µ0Ì¢9DoH÷V<gZõ­;ñq]¥Ç%'«NcË·¨O§ {j\éðc2òæëïäôÕ6%¦»5teII²<ý
P° ¸Ëg#Æªõ4p×#jç¨îM%DG¿þãw .@Ø÷[ú~ãf¼SÓ4ñGON£úÔÑÃàð[rµFrt£¨(mÔ=B*h²ue0
Û Ð3j¦·#§M6²lççìU.mY5òëUQÊ¸ÌaÎãÁb8UV-éÚÀyP>nÎ¦Ö±ÈE2|¹sµ@õ0'8QÁátÉ,³ÄÓÖúÒZYªbY'ÈQ·
6ùàýôéhV§¸[»ÔÆ¶Jæ¦;ª?hØ6 líãË9öÕ{ìÑÉBUÃ"ÏU[sª{H!©Ucv¶T¾Ç«N¾$PÇ-ÆJ
$²RÒTÇL2	¡ÙúømÜz}8÷Õ~¶;u
<¿"#XgHêöf!¥3õ®ã'ÉÔ¬«¡6Ët±µM4ÏêcÖ±ÈÙ
­TÌ3ìÀeq¨Æøh¾¢ýHMt4y#¢®ZÉº§ædjSÔÓ2vÈ
I>~ù'SeÇmµ]éá·^¡X£4måv±PmårIÈ9öÒ
T7*Ú*¸,XUádX7nÜ§ÒÎqã>ÇÓ§wiï­x¸I[2ÎQ-%<	24ý´¬	¹pv°8>5xÔUÊ¥9-¾Jôø+¢KqYÒ"cÏqgÜ§°0H\}J¹-8µ\jZ§ÃÇ,{QTäýxÀÀ÷ÀÔúÂªÒ÷£3[$Q<ªÁJÉµçi	&°Ómo¼P×ÒÖC#I*ÒQÚôðÉÆúë)Ës:£ìímôðÿ VtÄéY0ßBùb#eÏ ûz§Â:ÏºÇ[g©zËMÁÚ0p1ã%dÎvãT3ÒÓÝë©#'ËU#ÊNá÷?NáÈó«§NA=îjéä«§¹QTCrj
 ÌnØ¿@r6Y°\±Õôò¶Äa¶¥ÄK¢úþZ@~}#K*`?V
qã }AêUUû
â´ô.
Úvç¾¬NFáå9]Ù p1­>'S¯òÊ;!]&'¥fÚ­ AãXúj®§éx¿Ó¯y£1ÔBO©Où¸ñ~ãí¯A7Ñò¶áå_Káÿ ÉçG¬­w)æ2Ûª&ùIgH159?ä5
þ3gêÕô4ßíLÔRG/Ìm§
WC"+ùhÛÊüó÷Õ«,âÝÒ²ôµÕÍMºEÆnôl{FÂ3à±'ÉÆ£õ$Éfµ½îya«µ×ÇG[<j3*Ê¦8*Õ$3$YaFY ãYeSGcÈ¤Ý©pWºz¢;}þ£¥jj!«Þ­) À£$IõoQ' xí¾íW>4Y¡J£îÅød£wõ
ÛTdý¾¬ø]4(ï1÷7¹PÍ5<² ÀAÄ` 7á³m}oKßÂ6»¥JM|±Õ»±T+W"«Xx@äkf¨ô¶¬7v¥Ùæ}DÔväZve¤¸Lïn"©L­Ñäý¤Vàÿ ku4)//ÄBÔF#dl îÚyõ>Ãçt«J®¤­$¥)Wcº@íÛÊ¼Y60ËÄé°z+¯Ã5x1:¾éá>
¾ð
Êÿ ÿ ýõÏ·¹\ö|t'Þ¬lñTTMQn©iê Q%Ú¥0øö8ûjÿ m¡¢PYn±UÇò_5EV%.Ñ´aê>ù?¤kÉjea)FRV
Ä	[röò¸ÕÊª*åµSS*åyçYR¢¦£¼¡mîgÀ<>âå@µÔàÔ³6ØÆªÕ è}L4ÉÔOv9(çXâñðØ¹ÜNN4â:êw²Üjdy%§$ÊòÇµHFV?«Ðy×k»Ô§Âq_OB©îmnU] x x\>¡ª¥Úy?ú6ºy%Ü xÞ$íJìÌWÇô7kXO.Êaá²·×C_P¢6)»&PB<ñ´kÝ¿Êi× n9P$uÕÄÆ¾Á·?·?ô×õ½Ýî}Tm´¥&ù*XA/ PÅ@_ÕÇúëê¯Öy,_¬öé¡heTwto#s1Çàã×.Î<õºã£Fnd4hÐ4¬gFêU/Ö5Ré\jç>WÁ`·xcöÒëo2ÔÇ£ÁÌýÁ£FXÌ4hÑ 
4hF Ñ£F5Î_ ë¦´é:
ÛÉÒIIÝ§Qäé$¿V±=Í/Òr>NÉÑ¡Ü4kDÇ¾³ 
ühÆuñ 1£F°tthÖ§ Z'[ëCäê1¬;*!wdEPK30
 ÷$øÖuäÄÝÞ¹:~ÉÑÖÉL5]QqZ2èüw +ã,èã÷:$éY°øýÑöyä¤´¬·£b,d¬9fÇ:iðÇãLõ¥ò|Ém¼6LTÓp"2|ö>uê]!ðÃ£z_¦hlJ¨¨×j¨Ifsõ;zÉóã¶¼ø¡øQJAGñ#¡hâ¤Ó*½m,
ÙL6VpKg
},=ñãVpâÎkã'G¶TCóTòÒôMí¹qÿ ¼;øM¢ªî]<!1Cræpÿ Oi$A÷t³ø×´ôµÖõÓ}¡eTÆËàn
HÇ±VÈÇã^Aü(D_>$ÖÒ4ñWc
É§ã8EÕvòódÛ÷GÔUSü¼h{o),©µ>çÿ ã®4Qm$Ë;IaÏßR$txàO¶
æªªÞË+ÄJK9Ï²ó¸×EUÃ"á± ÖÚåMf5Vv@9vúë§¶ ©«78Ç÷ÔzÂÌQ.Àù×iJäÁOß:Yvæè;hÅc*?¹ãPÝB*ù^îðÒÄÓÁù»A£FÊ©É8õqã8ûÎFó÷Aª¨hªe;4²°ùóGýFÛìtÑGµ~a(v¨ü`íÇÀ¤ueÆ×YY¸Õ"<kªb!eg'zÆÒ¦¦ÁvS
g'G£)½ì]wÙu-ÛõÑî0"ÆàðfùNqÀ-y*nU]R@Ì Þ;F[%W>=LKgÙt¢²¾ef´/Ê³öÒIä=¡^ÖpÛ»j'^y|½^o¶¢eR¤¨gzjEPK´í>%åÉQê×6LÞKÛ\Wÿ ±eêÎ½·[-öÅ5U2ü½-C«K'êyüª¹$)?B«ÆÙ.U°ìÅDÓO$§æke¤iÖÂÉ!lBý
< uÖ¯¤í3V\më5ÊéQ­¢X£Ú7¥ò±¡P ØOuYê¬»2ÓÍQh±ïíIQK ,TêÁÏ¶<c)Q¹/îZj:íIpJ©­óÕ<p>üFBàb­W>t¾÷ñÿ Q@°Cw¤t!ÉP»IFgBÙlçÆÐç^f¿1p»K%M\ó¬¨c@É¹ÿ ÊHÁ^H ÆÁSKÕÞÍo·¬ÑÉ+d*1îHÁ 7jÑ¶¹9çµPÖ¯ªïS,QSQT,fV2TîYLW8ÉPßëE¯©Þ¢áWYG+ª4¦&C¨ðCmbí¤µÏQS+ÏÓ¶g[¤ÑÉ½ÖD?ª-ÎÊJ³ñ1Ë(ñ\íSÖÑÈxêè'j·µ$
²ÚÌª¤ãs98Ô5Ê&,¸[ªÂD®¸Ý+$GØÎ@1Ê¯Ò8R2 gÉÖ·º»u?OÍ°QÑ=^ù¥Õ¦¨²ä£nõ¸É?NF<kt2ÖAY]GÙ¯¦¨IÒº wCÜ2gäÙÇéÒ;}¾ÑÇ|¨¸=Y¨gíy!ÀbX®ìÆHÆì´¥GK---¦ºívh&T	'¨YN6¼}Mí¦K[YëMÓ3(y«ät+Í·qú88ãõp4.ð]%
	"¥(P`*ÝÜþ¦=àÿ ÃùÓñæ;dokòÒ3iÁïàÊ%F6ãßñªÉòk1\>oäsm¸]ÓÍ#´Ã=E¾T¼áÃiÏ
ägDî°O94¹SÍ =i&å±ÀäøÜÜyÒËms^e;Í}-¶Ð8CµÉÎràp}>¡Ç>4ÒkU4)¨¨êÖv©¤
263gÜNn9|é¹¾å8ä÷E[$Ø%®[°£M¨>©§À	 ±sÏØöÒÔ·û}D«ÐÕÊí	C,|¦áì®GgP¬Vfªéú{}Dðne¨Ü2åÒäàå$®	?2Û+ëâÿ f.=\Qìj1·ÈR» 7"îò8?mK¯q<V÷«Ck8¼^hDý·a1î'o%?¤!R9óL¤ ¯¥êª1R'V¡rD#ôlÿ m)´Ö½KT|LSÀ%Dn0eA>ÜéäÏ%±¦®þgFFîÊã-&8ç?è4þæYã8¶Òá:s5:L©Þ=©)'bv°ä G«p ÏJ:®ßÔ]¹#d%Úqë±Ü?,HrG:[T0ÛkiVJÎéwF=jF3ë^x>x<iuÞº­:Í,Të	IôKFF@ñöÕäÕâM~¥hë%¡¢)º[~Ð3çÁ5©M·¤î7ªí²TñÌ0IåqíÆýuXêî®+ÌðM-7v¦VSñ¤  ñþò.©ê	MTI,µÕÒìÒJÌ¡aÎóã<sªË#ýKbÓ©Ie¸ðz;Ø¥µÓÁ:ÅQVÕ+8IR«´°%¸Éç\n}[ÓtU5®:eXäZiÒBøld¨ Á>y×Üª.WºäÔK4èÊ:7Üñ6îÁ$2À¨Ô-U´hÕÛgÒ>ïb7ÊpîÅy9ÁÊóÆ±÷.÷9{ºäõ{·ÅJÛÅÞ£µ
YeiâRà`È8VÉaO¶q¥fÅLYux£ù©5®v}äÝ¶LÚ¹ñí¯7¤ºS´ÄÒÑTÝzg%¤díõGÎçÎO;¸#OZ¾¤MO¹¢yrÅþp¬íÈqÉmàí©é{¦cÇìÆW;Ub*Zev]ÌÜy*Nv{k{}ª®IohÃ¶ýã9z½(qÆªðÜ¤f©Tli%OêÞãÓÆ§¯UHË3¤pÅ!2	ÚyÃ l}#vqçU¶Ùµ([o²ùUm²ÑÙ"K­C$NZ"°Y}#Ô
dsîF¥Ùkªk «S\Y'"J¡Q?Ì~GñRmÕÄóÑR¨+Úbr®êBªxÙ?¦¸ÛhúZjèn5®ýåa;­#d"¹Üv&Aã5ÑÛ³X ¢íöv­»ÕHdªai«Áh¥'8ðN2=ò<ëw§µÞíõ¶»ÇF¼GbPBöÕÏ¨°ÉÏÁC[£¼¼uÇQF)§
	ç8#|<ýõ.ÛÓõ"±çvµ@ÇdeuU` ¢|êØ¯¶rê=hº~égr½1_qÛ2ÓËV?Þqà*ÈÌ¥WÒp66ÜéÌ=oU-·ùWRtÚDòÿ A¥¤ 2
¯q,vÎ}ôº®ÙÓR[ßVôýlU²#ªìí÷3wmÛáUqj4ÔDgZÂÁI*±ä >æiPP3Ún´Q^NIIÉï®u¿,®[eæLWIeXÒ¡c*ÜvÈ=$m99`3vé«­ºªÛr §¢FïÉ3¨ö ©ÇÔÃÜ`
Wèº¦t6kµ3Ð^áeX4+©YY¬Òp	ÃjÉ%²Ût´Ou¢!*±p
BªÍÁÈxÆ5GÄ¸:c8OO¯à5¦(Öãlµ\»3®x¬FF+µFFâ¾Ã4É7+$i0Ñ=ø,ÙÀdãn×Z»¼Ê§¯KÓ`­4¨Â\DàúK~|i«Io·ôÅ
U¾i*.-[IÚHP=ðNí£¯í£JL¹bKÿ ¬óâW	6ôº´@!=X>ðþ5Îí[O-Ê¶³¹gq¼öÎUà}8VÛ¼­pÝmÕHÕfNÙª4tÅX«Éõ#íªõó!h«Y#¸µcÓÊ
H!
±Ë&÷å}JÙT*02¹YÆ<»:òäöÇÝ/[Ó³Ý))+tbµbôÄ6©Ýé÷Ü»§ÉáCãñK­¦ïWQk©e§53tËl¬»O§`çÉK¾|[êçziÚY+UdRÎÑ£\}Y$1 
tùe¹´RvÃÏN¡6¤hØ!å;ÝHptim#~­:.º<+pvVc¶2J.Ëì5²jëG<±´pÌ»VC[ Î¤ßÇD¥ÒTQ®ØA%3Q ÿ `?×xè[|õåäHêXÏSÆL9XäÉåKú¹úuÎ¹G«Æêay}Ë=RÓ$uÀD¢áØ!ô¨Ï´dþxÕã§n4¾¼UÔHéIdbIU
Á(ØcÏ¶Gy½Îª¦Ë}0]Á0S:§í«7h®Àã ÿ Fq«×LY¨ÑégGf¡©`JcÎñ$ \KíRs¸êØ½²0×%(Úñg«ôµAºôìÝ/x|Ïõ)]'iwY=lì2ú»Õ:ÇUYÐ½h·
©V\Ò;Ó2 SmP£r)AÜÎ
Ï«7Xd¶uµ¶¬ÃO\ÿ 9éÜ0¸ei?©}À û
Në
(nöØo©D°ÏÃ"]Ï mÎãêò0>ÚôÝ·ÁòXyRúekòd¿6¸ÑÉ]OS?lKòïd1ã¹pÙÁ×>J>¨é6°<­³0;âtb»7gÒè|AèÛÝÂ«¦¬íV&H¢§X¤
Á%r20@8÷:×¡.t4Ýpö8ç¦5ÑÔÔÉÄ!k(÷YU¹6hÝÈçgþÁåKcÛs¡x¤ù"£BÃØc2#pç
¾A,à6NÌ*ZÉ_%E%ZDôäÊÅHYYSv70 <=^¬e×®|f¢×ÔÐÛûjº¥M_`ìa+G#}Ewù ëÊú[w^Y*~dBò»ÓNË'srNìÇÃ
Ý¹`öã¸éûOkK­zJ×'^i$±^¯v)ó,´RÉM¼Hv íêAã÷Ö,ªÐUµ\{sN"&$ÙµÝabH`JíÇÕzÆ8c¶õ×KÞ:&j§z¹3
¥i
»´j¢8Î?QrA£[èh¢áoQUàMÀD$bCÃ&3E?ë¬2Çofò½ír¨â«c	ezxsQõ8úKñ·þºÍ¯Ó[éæjzkb¢&($ì»pÊØý@<{÷Ó«4ìá«H¾j9ÚF;~]SDF2[q[Ü
!½Ö4utùU@
X|YyÇ/þO:¤_L«ÓoþÙtæÙUozGT­êÈH·<9ý±þA»8×=Ï¢®4"®yßH²÷;a÷Ô
Øx]*|ð~çQìuµ47	å²H¥§gÖ. Ì³!'/2ûþt¶
Ù×RÑ:SÅ%Lìñ÷7¤g
Xq v|
Y*§ì¡çÀjXn¿,õÓZ­cÅÓo<¹ó¯­ò×_ ÿ -me¨xÔãÀ)ÀÏ°××Ãöÿ ®»1ªGÛlÎ5rCF Ñ£F5õcÛYÑ 6ý¹ÔÚ1Ó©ÔÞ1«ÙºÛþ©ÿ mB S´jv­ÂËõ5&a£X]Øõ}ZÎ4hÑ 
4hF Ö¯ôm­_ÆIviÒs»V;ªåíªìÇ¬åÙìèÝÄâ|ÀÖuSÑ
`k:5(÷Öu}gPÁÖHÎ°ºÆÁ °u`è`k:ÀÔ°jÄçXÖÌ3¬{êyW÷î?Å¿Ãkd©ºJ¡\	Xìc]zþ¼«¬k"´ÿ _
.¾Èæ¤¨¤% .]G?»õÐÃRÿ Ï¥ ÷ñ¨7ë]îÉ]f¯BÔôòSLªpYJc­:õoéÛmòí3CAEMQ Rv"ùl?ÛR-µ´×+häÓÔ 7Sï­¸èùÚkÜ¿.°¢º·áWUT54öêÙM$8YNçFà»Ôxõï«ð }¬ïÛB|íí§Mã??ýúgüGü	ªë^¦¤ê-Îp°\#ï¬9Ú§·PXðJUäà#>«ðg è¾t%'MÒ<sI4µªï9?Wö }5D©¹u;ñ}ËuLBThý@©çû®tÔPÓRGIJ©Q®ÕXÐQöÛR7 ¹'Ç¶¡GR'wxKLúmÈóêðNxÖq[\x%*(w¹
ç-¬Èâ$ÜNÃþP|ó­j=¯P"¹"È:©±Ëd8È}iwªùz3HZb*þuÞ
±Bð¸ç÷ÔZ§ÜÃ#¼àúÕeÑ¼¿ÈDno<µ6zaùT/W1l$lFà	üùÈçùÕïp¡·W_n<Jm©lªGn ¼}\nçNÝâ¡¤¦iÖª¡ä0Ä¾¹HÚ ùÁ n<zçPÛª­Ð/ËÛ£¤¦ÒÂr*2ªnhP9K}¹Ûð{08=ÉpQzÆ²åp ¶¸GcÐÔoîRR±±\0·Sèºjé}½=²ù^ÙíQ»N®ÊìùD$úPàã¿VN¯}]ÔU5ôÂªXÚ#+b¦m ¸ßéÚäåsä>t¶?ÍÒÐURb*iD½èc1²1Võ(!õ \ømsÊ{Xó8AGÈújÎé&â\+ëeUiû±F}jp6ú¦}õMê©¹Ô^¢§Xj£`¨ÕELSs¿Ö*Ê
`×¢­êFºÏIEXETû!eï¸í\bÁ@Ú£Ç¾¦ß¥húÈE"E%]JÌÔç+ jq¿k¦ç|xbS,|i8FZJQ©t ¬¾Ý/TÒËW¤YYB-=râ8À ²Æ \Gã#êÔßP®¥&R¢+¹Üòrr3ç#:kq§j«i)!¹Wi±¨X;eP®£»yË.}üq¥=kKi²PÕTSÝo	TGj¤u&¢_IÃ. õ:Û9Þ8âM¢D×þ¨Ô]íMFcí¤]Ë)WFv©Æî·:´Ø¨*+©çª¶UÅ]s»òÐÂÃclRÜªGÇ¢Efê¾¦KuT"¦"Î)G,ådme9@$¨-u{GPPªihRV5H.QÃUv.U+3N¥¦ú/P Ókûu½|¿7q­¨¶ÉâãMb\ñ½¶R¬wÏvHî*êjg¯e`jkî9xgÆÝÛ=´½®_©¥EÄ6ÐÒÊ²J»ÔXòñíÀ`}D0Ú³|9h
¡kjb55¨å¢¨HÎá¸áX} Ï¨¬`ë³ºQY´é@~¤yÞé=¢ÙII¹£¥18HSvsË`
_(ï¶ëObkºqÕä}Ë¦5ÎHH':ªPTôí
4BJ(®²,.¬°ñEêS9`¬ÏÃnßùÓ*HÅ}Ê×k¥ÑSKeU!	^\ûçí©ÜÙ+erá|½ÆûZÕOSMf0E(Z]äxl)xò¾úUt6Éç¡£ÛÕÂeW
G'n@o'S®÷lT.Ë¢Å*D*ÉÅp)K PÑRIOCYWt¸H`q,4Êy°®CçÇ'ªtéN;oö9TßåCGk4rÛ¨¨Â³5c`F	ásìqÞùöÓ[4«Ö­ç»¬ Ì>^4i[o¨¡ÃgaWMt_Ì	ÖøÌpAUöÌ Ë0HÁÕ²Ïo®£SMB°å©bD È±mÈÉÝ8>úµ6ì«Ú£Á6y¬--L5rHU½1%e,9ÿ ,A>}õ-éáµüE4âfEÏ³v2.G<àò=ÉÓ[=kQFi*©©¥¨*T'È9¸Î¸]W¦¾jJªH¨á\9§Uüas8÷:¾Õ[¼Û¥)<mz.W+pºVÀÖø)".¾¼îËáÓtx!pAj¥[|[eEM&¦¢ÙÊ±4VF_ Äí#ê
í©W¾å¦:ëºF§©*¹*Æâ¤Á¸ÝãJ+ª«hj:k{Ô¤S÷f{eí:ÁlSäjÉ_e`ö:bN¢«®Iï7V¶#*¦DÞeÁeQ2¶~ÙÔ±méúK/Æ¢áÌø2Ô<9aã#UûV¬¥­¡¤[á¹æ+:ÔªvXêuv6}W¥ÕBâë%SÜ$7í,¬YX`FC0R~çßHÂÑ®Lë¤mâÏÓéKA²Áo»üº·76UI °ÉbHÉ:U~îÌVúI)kCè8R¬Y½D1ÛçïïªÝÖák£³l«³Ò%îÆl»`§gÂ£7«é<s¨Q×ÒÛá¬ÿ ú2¢ê©ÏSPÉðÆW8'9ÛçWKyÛ7J]_çf¸Å_Ö÷y$¬d1`CÃ/§ÁûêÅOÒ-S$KUYW­mZ Û&]ø''` Têi%é$«¾KLY%ËâI`±HóÎº|ÕÉ jªz Mê¼$(ÊªãvpAðtiüyépË/GROGòÔ4µ5qJ¦jÊóþ Äª+÷:æ)i¶HÑÇ7	èö$IS6Âp§ÎÖ@É8ÀUÕS£nÒ]nWhXÏ+A[X'+;Ýªp[úGjÜ{êÅfê:váQgiiª*Ó²ôðÐMÛU£ò##îÎ«(Ó4¦.68¡¯z¨ID³Ô:íy#TaWk)´¡}!rÄù:[t¸õ´&ÛY=hª¥XéfUWp,Üó6ãQº¨ú¥â/C5,÷U¨Ð'ÚsUâ8>¶¡ü/¹U^êeªó<T08V¼É±²î	À8ôí¯ÎªvD<÷UõU,RUtýæXiÒÙ~^D7eNöõ¶>ËÈçÏ§V*¤	inVk}#ÔËª$_2¤g
-+îì5"¶Ë]dVY*T5-¤fç{¸°Ô8"±[­ª>Ã%Àì1´ª#¡# üuk®Ù'ºÎ·?JVÓÕIz¶A$@ªÎ[bÂá@@2QÁ>I£Ýé-ÑÔÊÖC4ÔT±0+,ªgu,1¿®ÓéÃg^)©ºVk\Ët»¦?m)« @0X¡;HÀÎâ3ªÕç¤Zº:Û}¶XéßWÆSã!Ý7ag<$s©NMß«í»$SÝ)CÅf¿HQ¼Aéd¨¤*)v¡í³H¾`)Ç÷Õ£¦¡sÒõÆ6©fR¹$dú+émÎ3¯?Ûu·ÑÓEBÉ:È&Hã,Ub19ËzmÀRFÜãV.¹,ñ-UÇ
VÔ)Äògp8V ð#<çpÕ¤Â2¦×kÀöín¤¦e6C"®.;28,¡²ÙcÏ>FQÒ¥QÃj¦5æa3DOjM¸wWÇ9Vä}5Æ<0Ínía,6¿ay<ê;C%ÎïR±zr±ÄÌÛ¿§µC OêãðWãPòS×DÓûþåbíE$âp)éR²IaCá@ËÆ]HmägrAÎ¢Ð[
=éQ;³ÇJ,³(¢ë´ØÁb@÷ÝÎ3§WëïW¦¡è©ßt¥h(à¸.­õ©Î.Ür}|RíUUÕGn¢æ6d3áL²gÊ.ÕÈ$ðuF©93·IMÇÑíp»WÝîg»Igx10ÞÊò'jàóÆ±k¶Ò_d¡!Q!egp¬ÍË!ñêÆv< uµÆ®²Ûg6Ûx9*ãIä«¶Yy
Cye
Ã>ã 'N«ª ¢´#·G#ÐUq;"=ÎÁ§s *9àc)\x=aÛ'/"6·+i.Ôey'hÀ'sn+§U°\¨)m]òÃ((K#;¶pJ9>N¡ÒOOl·SÈüìªc¦Á»9ÆIÉ<êgEÖÀ·êiûU²Ý rÉ´¨'-Äj¹$g#WlÓ.FbÞ´ã~¨ª«ÃNîñJØçÁüá²SR,UiÓ·9úzãTÓÒKrPUïÆÌà}@)FHûë¥Úát¡¤¢JQQ4»c'ÕÉåHÀÎ|ûmÒêÃR³ÖP\É,j×1)Ú$I·ôáÀ$HÚ~ú¯õZcB)ôÏèõ¬òX*ëÓW$ß")RÜ¹Æ2¹óºôeÆºVáK3DÆÞÓÇ$TrII PþõºXYºw©gZzEÚiHy³íÛî:ô~¢³ÐÊêÔÂ"¹)wns#\î$þuêáSGÆëpKw	®´Êõ¯ý¹ÎªVh$. 
Ðyô±9ú²sé}ú°PõOM] íÉÙ»:È÷£zwÃ1õ¶ÿ âÆGY¾
TGUÐtÔ5%xZIÂÄ#âÄêÀp+ÈÁÕ!ùÖ·K\rm¥¸ÇW¹¶XUFTÆI=¸ð>¬¨lã7IQXÇÔHËÁèÝyQ2t-P1QP!jOÕýU±Ç'ûëÎº×aê	 ´½;SÇ_÷)ßþ\höãrË¾tÛâ5RÖ|7¸T%ù`ålú7M¼«ó}P:*õo®ë§¨«y*.¿3	S1f¥
Ùw9üãU½ÔÍô8<.K¯þúÊéðú1p²­õF	@@tÈHRpWi?ÃîuæÝEL´ÿ ï0C$TU,³ÅvË¨RyÜ§'!Wó¯W»A[U|¤§7ho5ÓALÃdrUÂDòúIÈØÜ¼êÔRÛ¤¯jÐÅ*RÆcYeL¿ôÞ)}(ùI3yñ®L±m£ÞÑå¬r®ÓWÙm4]7z¼õÝÚhiÖwb
ËòùÖÊáK¬nðKYOH¡%V+³qcçôm{UÚ®8ä¹ª-5SÅTÆÄÕÄjTX²»[8×ÁH(ïqÕÁ!1ÒÓK°oÉ{î¡FV5Z¾Wµí~Göµ/ÒPE!Yá©JHvåbÂÇÎâÃÏØþ5ÂñokmtáMTu4îedÁP|
Ïãó®ÿ Z£¹¦2=wÌ$®Ó]ùÏÓÊºäû6¹tå7ó«e¾ÐDëXÐ°Y}¦QÀü`ScVÏpþúM,ÝKr®·ÇÊ¦¢Iá	V
göÿ }z¾£Û(©í¶êku"%5ÎxQ·RuèGxá£FX4£F°4HÑçÛX:Ù|hÐ6LãLhjc#L¨Tn¹ÇÒQ Æ¤q¥A®ú²èðçõ5%CF Ñ£F4hÑ 
4hZ­µ \*söÕj aj×qMÈß¶ªÕ 	[VG­¢d_}gX÷Öué±@Õ!ï¬èÑªÉme¼kS­Æ×X:ËyÖÖ³¬
Kþ5e½µ® ¼'ø«G¤¹ôeØ
hIÊ6ålýúÓ^í¯þ-ÃûVbG^"(Xãkdß#ý5
ÑI¤àÏ úºß'Qt-Î×
BC%ÊÝ$+2FF÷µã_Á÷UO7LËÒW,¤Ô/þï»;½'kÇä©_c¯v¶){-"2xÁR8ú×Ë×?öøªDCGS<wjS&]&maà7gí«dmTäh¡»±?<þ§ÔRÖF#7<®}Î¤³*¬sÉ gT
¨µ¿XÍ@#Î³ÓÓV:äGäBñÆ½Qw1ÇçÎ´º9²á*Ü²SÉRÈóÊèwã8
öÜð×xV×d*(ÀçÎV:UVÇO%
Îd2R£l@¾HãMàR>s©3kÎÜj
a;Éoðä{Æ¥Ø$iue$D Ãam:Y	DbçÃ¯uF¿õ,õeMÓBÍ]HFA¡ÿ rqÛ:¸Þ¨êëíÏ$é¹áð~ú£_,¢¥5Fû¥ª¯½Fâ;rÿ á|$=çÈÛ|c«å+cÐU+ª!óRWIûs?ðÏ°ÕtßYRÑÑB$JE} ÜÐÜ# ìí 3õzvËã#V[ZCm­»ZîmOÒ»Å)Ãå;6sÈÁbîÜuAø§3Ü.ÿ :x%¥Vjx 72wVAê;F	8çÁdO{Òä:à_r©írÜí¢ZYcÃÝ~ãÂË(l ¿úR~ØqäjÖ×sU%4íOÞ­u)*KÖ Êwøî`qãÒßT>õ­%ðö°Y¤µ}Í²¼yPÇ·P
ßõz§øÔô×ÔQÓ²Ý)e)êZ1UJ£ûn#¶íÉÔG·ß¹uøÿ qê_¸þõÖTW¡¿Û©ÌÜ)FØ\ÆÚ
äd{gK¾9u,UW«mU
Ö¥V¤Í:ÑÓöcIg	îWn0vä:ó:éªb¥TU¾HéÆ"
ÙuÎi)§ûMüìsá¦îJóÀ=Ç:éYãdüJy1ìòz-ï¨ºeºÆU	îéà?âÖ±!Äàð¸W¾©zîiíôtÿ Õji¸|Ç$9ûûj½¡þkmï¢È­ßýM¸<ûê5¾Z8j®Sºr!õ`îÏ¤è £ÉYj§¥'ÅÙìn¢¸×Ýd²WUÉY*jæTÀ*Äqåsr©¿ÐISN$Vi¸ôî¥ç?«ªóyé$Ji©®`ÄëQLXp·È'ïãM~vùÚÊàïv©RíQ1ô$dÍ%³Ç0Þ8ÕvQÒµO/ò×ÐTÕõ¦¦¡9xÎÄb(_¤(F!|ä`sÕ«¤Ì±A
-MÆIR>×õxÎò0O«5ç6óY½·l¼å¥Æ]N$b£Êç;H$yÓ¾¹å
ª5¦Y$;LBBUÑ¶³~ 6Ýÿ ü:äÍº=ßÃ3F>Ù±ðî)ª/6ûÜtUÔ°L^8hÕYr 'òçí«íÆ[¥EÒ8hmÔr[ß´ÓÅXr#ç }õæ_èã¯SC3¼mØ¤Zv(}-»$nûkÛo]EWÒVSÑIaiFR4,W'>ç'8ÔâèøOO4yïäòÚö»Ûå¸GK¦¶JzuzÕj
¬o~ <àgÒ¸Ý­ª(î×
;´òu-
=:|Üì°¿mSËHÁ	Ü¥B9ÿ MX'ºÒÜb§Âÿ ÍfGÍ(EH$VbrÙ÷?Qo³Í:ÓK55Â)ÑOwå#d$Ë*ºçüEËOoÎ¥WÀ¾Ïäam¸ßì5µVÑ
Í¦ª g(IÞÁØîÊà+8æ:CóõíN­#µ$*³>rUØgp`[¼x×+WXítkBýª#WYèNøÙYÀ!æ$ñonþ×:©W³"ÜÃTê@åÈhÓÐFIos´p5ê-*J¬ì·Úi+éoTMO)Ü¨§t97ðÈ8ÈWé9 J ³AÕo[w£©XU"Ñ	b¸$`g<gÆh`»¾Ú+"·¾LlÔÁ£TO«}#r®qêÉ'Dëo§?)Ó53BÓ¶SÔKÛ+ Vf'#*GÜ8ÇBNìÑ¥¸Ç|ø U×-'OwÒ&ænTï:vÜdFéHN9$g9ãPíQÔ5*ØÞ8r*fVÆÕcµA^3`7{©2SÛ§u7*ØoÀF×ÕU)'¤yeçi-àéLU°ZSNñTw"­ÊD»åð+zX·@ó­6·Ã9÷%ôo·)ÛUòÐÔ°ADBç([{ÆXÄgÓÆàAª*¨%u°SÞcYäfîÃêÚqä.}õ­Ú®¿«¯[[(ìUG¨£jlè>ÚÓöï©«£§E¶\Ì Ü¹sÍô¨öÆ=ôn+Ns¹KU¢:hfémQ©$&2àF¸ÉVøÆ<j=ê;Áp£»^ÒF)ÑB6Q°¬ú²·,HóªÅ+--®ínOü?ûÃ,ËÛghLñxÛªMÓ¨£Z«,ödÿ ©T¦õ¶í ùO?¶§%ÙMnªot-ò­4vêôÚ³N*##1ä
¡¶$®3:²ÒÞ)íw¢¢½Ép·=R«24c`ãÔ2¾­÷ñëÒOI_x¦¨¤£­&XÃn$ÔÃ gûc]¦¹Ü¨ª +RE0
Y ¯:éØ³ÆªQ=áTÞ):ç©;METÁdäÅJ`N àc;±©~¥5÷{5ºÇó×wjÞVTãqÂáR33¯*¡ºW[ïõvSºUa»vysÏï¦6Î¡Zn«¶xÙD4¯
äí%H-ù''?|é,vì¶Xá¯Éï_º²¤$f¢¼ÕMKòà+#%#ÚuðÂÌ¶[\¶ASIU19fïÆd,KU<¸}C$g:ùî²õ-çª­ôÂ¶/·îjep³¶Ô'»xÓ;}Ã¨o×jÊ;
Y§¢Jøèb±®ä~HÇ±Ç$q¬U#®Å3ùø>®¢ãyb¨êk!Ö*÷T#Q´6FûãK-ÒëÔsÙí0Zëf¶§¸\-ÕE£Þ¾ÎÕf¡sÉ:ñ~ªødÿ c(º;¤íÔÀS	ES(o ð«zÃ>¸tJ'éþ¢«r­WR²4qÉ3 Ìä«nÖ nûnÉÖrJÙÛ:1´ì³47Ûe{M%ÀÑÑºmæL|ïã#ÛVÝ®5GQÔqÝHu¥¢D¢4súvªícÎ9 ç\mÖKEm4-s²Òä»¼ .á¹1>àÿ fÕVªÕGEzÏc«fW®¨VÝ*yä?
ú@%¹T÷EqÑèJxg%:û­qAjj:«-S[ªåªÛMrEV=GxPIõ4â×t©é¦¾©ë¥&9b*Cc¸¤ò<pF«4øC=%
UU
'~Xlg`9ÉêÍj­ác6Ä)éÈ.
Á·6S%½_Jÿ mB_.(¯~>ËWÃvXÝPóÃ
¡È<ãì¤ñýÉ×)èhiªÀÑG+Éòò±3É¨}+6ÿ 8'Uëåù)$k?VIÇSur}ANÞ7û
<»ÒÝI¦®!+Õ´M³²TáLgpf, }®vyùpJ{þ¢U¾;$,r6Hï!T/éHÈÏÁ2ÂçT§ç¦)LÆíTÒï1>¦?b76	ô¶½ûót¶ñQIDµ7»E'¡NNõ
õ}ÉÏ>5_²RPtË=Æî*+*ª!u~Ø(Z3IÎ¾§*ÝUÑ}U
Ó/Â+ÝKo¶T×½=¹´vG<"±vd
ÛH
Ëc j­yË§Ù/ó7B«)AUº@ÇèË·©4Ä]j.êÚÈËCd@=+$¤úÀ\6È÷sO«ñ­hèf+u¶#D¥I¹sP¹ý^Þs8îèõ!''ÉÂýBâ¡¡qQýh¡¨75Pv#FAÚàÍÇ>Ú¶ôÝ%%®Ï-Ö®ñ[©£¦ænÙ ¶Ð70éÛõdú«Ög¹ÄßÊ,õ4ôÕÊÑ,27­àmmÄzàêÄ ·ÔKEa¤«ù¤¤?;qíZ q<ã3ÚÛt\Ò·ÙJÉ*êêîcå°@@ðÙ àyñ©×½ò×m¡(ï6µÄ/!³áU×*]6nCÿ 2#L¬ôt
oZéãY#5Ó$@2¯r0²c!} iwPK®¢¦£Y£®ÕT§Õú¹\ñN0r5JÏI¸M¨¿Þ¤±u§HKeåFIèg0óS2`îô¹
qõ
<øqz¼ZºNê
y$&@Ý¼<é²¶×VÃ7lñÄ 1ªÇJÔM=-}²X@Zx$WbXUØ|ÀÀÕ¯­ít>¢·´T1Qùv¬P¸t]£m÷bÀí×V>WäxºÜ_ÍxçÔ¿iÑôpÛ*nÔK>"ZÑ@»8ò	\«y#T{}%5³â¨®q$Õ;¡cNÖô*ÀãQSÞÚºÉ¶n©-
KQÝKÜTr0	ÉÇåüêY[=}ÜMà©d-£/é?¹q.ïHÇtNIUNùTÇÐÒtíÂùrÕC"lAy® ä­´ápOö×ÛÕ)ìÕß&'ûB( w*MR¤¤þ!í¶WvæÆ½3«/÷[âÝm÷9)©ÕíÊñxU >qsÏ'þ]xM¤ÍÕ65TºÎdáöÆò¨äUy]ræsàöôzg
#×'´Àµu²å]&Zº§deæ¢+°I]ËÀÈójúºø	5¹ ôfAÇ0Øq7úP«Éä`êLÝSm§K½c,©÷E÷fjÒ1ny°>°Õ.Ym|>»Å#Ã
zO4xmÌõ9áÈÜA#9^³DÚ:#1¶ÎßÌ©jºÛ=ZÔÏÍ$U T7l´h®NWwgãIo¤ÞnHÓÆÄÄPÀ3w2@8#;NáÏ¶Jëp@^¢¤"D(!±Á$?:[ª?ÍªÝi¤ædùX¦ÒäqÀ]gÊ|?rÜþFzªD	iâá°ªTº·$!ÛR:"¦[WSPÊ~­Þ1¸3giöýµ\ºö>z¾U¸U4Sé(ñ8ç^³ü?tÚÝ:ßçEBD-a]Z@P¥X´î<®9Ö©\éJoÓcéfÎI¹<¶³¬{çßÎ»O05Ö4'
øÎ{èÖ[Î±©¬
gF¬0u²øÖ5ç í ÉMíÊw4¦ÃO­Ê8Èÿ MY:©RD0£[ax]m«%ò4hÐ4£F hÑ£@4hÐ4z¥3ùªÜ°:¶Î3Õ^îTöÕYèhd÷P¬ðugäöPhÑ£PHhÑ£R l5ñýõps ó£A9:4£XÉÐ4`Ã{k]lÞÚ×@ñïâ®ÝÒ£VßU <áGÿ ­¯a×üXÜþ+|,²«àµáêG©±³ûzOújTe6}*B P ãíÆ¼3ø¶ÔExéëå,+#U%mb§Js2n>å^7#s¯tãÎ<ëÌ¿Jºz¥ç4x"yX¶@²|þ}kèg ¿â"×ÉæßÃ°»ßúîZ©&z{Z	ëLØ&J§@ÕHVn7`q¯¤d(cß!
9×=9%áÔw:ÊQO[}Ü¥xGæ%G:õ\Ä0cçñªaÈ~#¨yõ
ø9÷djÜ¹ÁÇíç]ÑX»r>ÃÉuEËyûc\ÞBÒÉì2Nµ8NUÕ2íOQ*da¹ÉóãöÖ,Ôü£bLzIã5î×ªÉS±ÎvÇ±Ëñç3­"ê;ÜéQÛÂJý·ÿ ôX §gßzîK]X®¢²ae¥MÑÔ 
`­Ã/¿8ãßMëz¾ÇUo£©£½ÒÌÕY
L0p	Ï}JøÑÝyÓk¾átri.0í	Ï¨7nðF|kå¾¥ ê®¢¦¨ª£²]IÔÇ%¼RH+¶¤± áÉuÏªîég¤Ë·wµ¡/Äud{u`RE)§î/ÓÑvxüêhê;=--m£ªék`»E?~¾	'aØ<a¹Ö÷Õß'%¾t(ÝÜ°xUàRNA yàûjÔZÕK¸¦©0FÍÚYÜ3D§pG¾²Ã§i{üCìëÖw¹ïñÉ:S
aØXvÇFõÇ$
ëÜ~¥ðO±ýõ*Çww(éÜwäXW$cyÇíä×_s?z6ÓÑþ³ª²IUÔRM&Ê«8zsí&(ÎB`©!ßù5Ù¤¨ð2dy&äûgÈÝÖÖëOóØ®;ÿ v¦©!j;@q3Ãõ*¬Àg
WÞþ/·ûWó8¨ç¨¡xßdòHaVaÈ` 1	,}ýµbøßÕÇ©~6]êR{tÿ #eYÖD¹gLQÿ ¦½«¥>6ü&øqÑ¶{U]l4ô²AD¤22gãÖì¤ã÷QÕ²Ä§.YòE_BtäÙ-wøMBMÛE/t8Ç-PÜÇMÔý%¶ª1VÏ2Ë¼DzÛö$Ilé_ÄkÍ'QõÅîýo£Z:Zúégc£9*?ÓÕÇ käºô=e¶¶¾±¿´kKKêÇ+Ë8 öÇ×øÕ'h¶%Q-{)!q´ÿ .½ÖPI%ò²+ly#oRJ#ßMn]yOç4j9¦rW>­¥À8$ãí_z&ßCQQÔÝ7\Ó-$îhÍ*a ñ_uÎ2uO¢¡¯è«J
à²ÑË#êROèÌìÁà¥[9Á_p5~1=a«y)ÃO,-O2ÑÉP<¿-»ØgÜml}:ioª¶¸Bj£wAM¹Dr»¯ÒÜ¿Û>ÚyqéG¸Zà¨¶©EÝ4rC
¦\L§ ¹+ã:«½¶óhëYèÕÌK1PK2­·80qûëÓG§4±Ín=ûà¿~ºkY£;Æ¿·PN]Ãnvº¶Gäs¯§ê©;A§TVÚQzß<kãG
²ñ%4r¬TÑÔ¬¨ÒI½Ärmyb=XF|kíÕ¨·§;ÀÜ²©eÇ¿|{xÕt±¤Ó5üc+±HòË´OGyõµT	ØNèÓªn* äÏ¶,s¤ý_q£.uX³+&),C%ÚÞ'®u4x9ÔFa¥2 £õ
Ä 9Õ[¨åù Ôöî¦JÄVßSQ{f~rSð~úÎN¯iß¦ÍÌ[U%]UuoÓ 4KSLðî
 ;2Ã;± ó®uVw¤®c%áé©éâï4
T»x 	6úAw`¥Éó«]
Âf¶]¨$§o1ÉBò;s±}mBºÐÜIz«®jÇá%¦ÜT-'=Yã#Y'âANÚÚG»ÖÝíôðÓSÊQ´k%væ$øÿ 6Õû8Ò+ÅU¦íBªcñDwÔ$ªÉQP¦¥ÿ 8ä{.ÑÂcÓÓ÷~NF<¥ãb0NÒ¹(àÆªôËO=ÒèU¸¬árªÖ$8
¼7Õ.ïó©m¨ÅßL~Rm³Ïw£¢åÜ°"|(8àcÆxLù×õWR%RÔ+:ËÒó¡·Ùq°g gÎ5wën®¨Ì×)ébJªZáE
"?@Æ2ì,7$v¯ ¹M)»î" ºÉ#*}ÇmN®ãGLµÂ;ÒÍ4UÌéòÛ×µbi^XÁ<'ßR¦ºÉ*5¾¡)i¬¸LÊ2ã$2ä2qéãHi$¹Ûh"¨DK%3KÚLÌÈeR	sVFÎKõÂEÜÆf=ÊàFÓpØ8ý¿:ÕElõ\.Î÷ÛÌ÷QM

)e¡<Õ2¶73>	ÀAÀòIO7LÜéî4k¼4ÉbÆîÐco°ÏÓ
Ê+\RTYÏy+AÚgÂÇ0î þ8Æ|ëò²ãfJk}áhîÔêDÎ¡$«o¨ÁÁ<`}µ´x<ìÉ¶÷
æ¨§æhå¨cA(-M5A.èTd9ÛP(©®
)"·ÑÉ,TÌiBçfNOçÇã^éü;|§ë[=ÏªåRv;ém¦c0ýéíD`26ÇßÁ×¥ÁÑ=Òl44QTÔ½]L4´¸d<mar\RÙÉÉ:Ö©YÊ¤æÒ>>©¡ºË'ÎNîò8Ý¼É¹¿é¢;U|µ00«©Ï¨ø}ð³á$}ev¡²]£¸Úáik)ê©KDR7zyíß¸{~uøÇøpè
Û}ÂçÖ¹hiíÜÀþ ÎH'èTl×>b?çýÁQÖ$°#öyaê:Î¥§+ë#©¯
µ	\r~y[Øªhn5+àwX-if>çÛ÷:}¶Æ²·ÂÈìí¹Q²¼ ûx÷Ô7Í2±¢·Åô4éúÞ¶PTÕ\Ê~¡C°£ Ï8'O9×­ü?ë^µ³Î÷õéè)eSnùd`©.¶_?RÕÇF{»gZäp}ØÛlq÷Õë¢,ÓuµÉ*zõ!¶ÓÔs3Fd çÎ¢Q¾Íôù¾ÉíPüJ¿uõÁ-=ôÕ¨·êØû³ªåAì ¸pÛ'Û»tÕ¢ÓÐEOÜEÑ¢g®®>jWfÞ¼cÙ÷v0lÕ½43þÊtò@®!ÈÖòL	**ZSÇq¼`z±í¦T	Ó¶ÎkæêhéÙ¤J$ákb@SF¹ò]í]A§ÇW,¹5¸¨¬®WÔ¤¥Û´0L#E)Â¿`Jþ¾Û­ÐAjZù#©E§uNé|n0N §Ò[U»'TQ^o¿E[i#0­TÊ!*là¾yÉÀÕÞjKÅÂUsªê$
<ÐÓ Ãt>=ð gYmmòvOT¦ª<"U·§z_¢éRûWJó]e'³Jõ*0
«È>¢yó®Wªd®»OÞa;ý;
´H#þX6±5ÒÓ`­æiä½ÝYsNõNÓuý+¶N@PIä«ÁÔksêI~z¤¡t%Øy2>ãÈàþ>Ú<Ò]Áos-õ÷_oÑèSkµ]jª$.Z8Ôí/ì¤ûùÉàñR> _+fK=-;E±$ß<«ÿ  û¸o°Ñg¿ÌÖ:æ3Åô¢B¥Xíð6óëÎº[-Ô6û]m}Ü³WTJÈYãÏø@£$sõ'ßRÞä3ÇaÕüì±ÕXúA
íÅu¼@bÍ¶XdR2N5\ºMGr-ÔözªFbðìõ¨â]î}aF06ã:²uÀ¨êÂU¢éaB©)R³9!FeàÛFùMm¢¶ÃRgézq}¥ê¢LT2J«IU%×''êÏ§V¥à²×2íû}uá§³ÒÞ¶Ú¬ÔòIÛ§p¡b8?K9ÉmÄîðs.¸ô¬t×X(Ú¨xÊvzUnàý¹ó«=òãk§¶Ån¸ESg§5ESO&Q$0ÜW!Ðx<¨Ç:IOAQU^)"yw®d(Á0Ê3dp
Ü·¨o ¡¹¿ôº·¥«*bZÚÛ²Ó	S¸GHUB2 Êä°'õx'T[E7óh&·CY
]9îPÔ¹9iã'µ"¡Ýî ãÒwxäjßtm=#Ã-L7©JÖe§\(yä]²îØ¤m8SRâ¦:Úx,½¸+§Sí¾E-úñÃqÃ3ÈÖ94­$^Ly&ü¾ÃËÅ¹SRÎAGRÎ­«¥¬; ¬6©¹pFï«[µÒÝa¥b-BË1xÈBáH ¹`£{kÍnrWÚZSDhf3
{ì,}dL¡gyPÇj·°Èorué3VtP:¸Ú5E`ýðÜÛõÁÀ5¬
Yæ·C/Çòvé»Ã×Ù)b(c¤*ôj¹ý¶_ÒÁvx%¿]ÐñÅ/^^hf*¡Wt%UyO¯vIúGr0|Àûj¥ÓÕöþµ´REÂ	¥QÚ1úÝýµQ»0¾ÞFº½ÁúKâå$±P´´uw(à`ò(Ú©°»0
e[Øó©NÒl£Ý0ê¬ÕÒ­/Äse¨/PÏW$E3°hÖA!#ÉGàr3¯=¿S-¼+3,aØ.Ü®¯öà{s¯Dø÷!·|P·O_/QQt±rYM9]ãmúG¸:ó©"TÐS¦jY
2Èâ=]2wíRÙûcßYd^êG£¦Î¹|!dôïdêxÑµ5²¤¸ôà <)cøG+§ËB*Ì¦ykL²1m¡ò>ý°qçS>qki¢¡~^¦®Mì@`B1Ý|êV¹C,`W(»BÁ½·omg¨Ï,«;K2Ò5¾)ce"öm î$ï4®ëVµ"ß#3ITïtÇf9óãq¯(+vrýÈO­+?âõ%nA`då GÈÕF³zÑÚ"&¶u(g^ë(à·:÷á\)î·ijco®¡FÎp68Èÿ ®¼&ÙPQOßJõ"Bç?¾¾Ùømf¦³ôu²:xâs ö¡9 ëljÝNi}ÆG÷ÖWè£$cûèu·ZûçSEXÐNtj¬ëYÕ=õ´V°¾uÒ5;¼
2M 9VzpÑ'¨yÕpº²<½VN	ZÎ±æ4£F hÑ£@4hÐ4£F«ò~5]½Çê'V6ñ¤×¸ý'¬º:´²Û2¶ã<mk®­é}f{Ë£4hÐ°hÑ£@Ç¶ÉÖ·R0u¬·`èëYÖ¬ÁöÖºÙ½µ®ª1×Ç ¹ÿ ]9ÈJÚ,ST"ê>áÏã5èÈ×Ù§ñ¡eØsÙãöu³
Gúrü¢0G¶¾kø÷Q/QuÅ³  J²·«¤4Ó²>F6I1*<Þ9?§:ú*ãY
Ur¬0Æ2îÜ >úùëáµuñAvê	¬V~v3îUd Nã _'-#ÌÑ?N3Éö>§EN@¨ªBµ@ð1öhR#ÏiØ9çDûDQI'êükH°¶B Iêr}hq}ÎÔÐö¢Ù¼Í¸óíÎºòOls­SríùåSo¤¨LOK û2ähUdY1éb¤s3¤u56yTÔ³ÒäÏÛ Æ»´DÁ©m´ªàä'!ûÎ	üéP¤jBí\UWB<óùôõË6®êi-³L;ô¿ Â"à²®yeyÕ+ãÅnÝµqVK:É
7È<Í;õ QéÊYX:÷jji"`2é?¿ã^OsêÊÉº­­=Ó¶ªùLaÅÍâÁoñfT9äi&äèÓFrè>úðuÚûO*|:«¦­¼U,4hô}2 ÜnÛùÕÉÓÝð¢äß~Zû×UtF*+M½~umò0d;ÀÂ,¾1f$÷}G×wæ¹_.×^·<`N)å¦ ã$!eÄqçÎsÇ¾¼¿âEÐÐÞáèßý?R·K<sI¿ÂZW:Ù5%²eÀ?ÓQBuD©ptgHÜ¬ð;í<*;oÜ©Do,2BP£ø(P¨F×¶ÿ ¿?ØKÏûÕâhíWÔÅY#e©&Âf<ààûxß\tå®¢*;MWRÝzuñ«@TÉÂ%ÏÕªõ²¾2Û«"fßÆæÝÝýO"S?º^åLõOöÄ§øÕUtò6égz½ôã1Éª2È¸lll¿©s§Tþ¤§ªº~djÛM*Ã½ÿ ô±nb#\¦ìÙÃ§:Í=EÚ*D­! MYaM¥£XÏ$»°0@ÞÃÜëê¸ÄRVRÔAQ,]ÃêWÚ<8ÛÙ÷ÖrµÊ5Æ£5¶E*>½½[Òµ¶h¦SGBcÎ½'¤­´ö;$+Yßej¨äª±SÂVR· sàmWv·ÆycºÔI(MDÑÃµ\mCéÆp9#}E¹^mpNß-Suyãh¥	SF¾T!`O(¸c´ç'ÊNsG¡4©¸;lø?n§¿¨/×à¤UÇN&5Â²3ô©8Ç 3ª÷Ä»­÷¨ä§Z×)­íHfM¬³ÈqØ§+XÀq¬\¥­¬³x©il¶dª3¤½FæÎìc
¾{ietü.`´ï¨ÃÜ¡bÆÃÂ |êÒ.Ö%.ùÚØMl¯ßOYo«TQ°8R¯­sê!õ çÕ¾çKÕ*NxÚèj ¦©µÕ#sí-4OÌjA
¿Óã¨éu²ÈôµW[4.ì":ÓJÀ1
ÛI9'ñ¯gè¿Hôýdøà·Ûà§¡zºÚjD}âdb";	Y#PAõg ãUìézUÚgt¥-æÝ×öÔÛSFÑ)6òT
ëû.à~Þ¬n×ÝõÂ£mõ¼o¤++ Ü ú¾^èXß¯~5E5®F²Ò	åÈÀ«´Íô·¨Ho>m}MÔT´BÕSQ4±@£j¬Â%LË5´&qê§²=òÊmªÌ/iUqzu`ÞÁQÐ¡Ô8^[Û*·I!JihUR³!¤.WÛiçõxÔË¥$=B#¨¢¸RÇq%$üÃq\}½´¶çÓUÔÓ­(¸¬«"Ì³ÉRG(Pya|{kWÏ[¥I9*k-4uR¨zi8ªa,7±#ü¼0@ÄÎ·ª¥%-Òå?õ¤hÑ\ÙLË¼-lé¯TÚû=
Éòõ±&Øu±
NG¸À¥PV=MGòÚæjRð?Ë©Þ­Ïá(X0G:ÊQQ|$§
ÑðHêi¨©
E;BéPUêÀí«1\®pÊmbvÕJ¶ÞnÖÙ.´tq­¾ZHé*(å=°²©!\c!689ÎÞ)ëf¶×ÕPVÐ8R<¡ÆW$ã' ¯¬ù!½:Dn5ÒLòÇ¤%û¦v(¨cÇôãE\¨ÃXàp5ª><mßÑVøªôrE;eÊ'pÁ"ï@=;ÚJí°eÝC³ÒAGÒ5UZg§ÿ úiÌ`Ìx#³éáU¼cVÎ»9*UmäËó4ÑÆîæR@¾rsÃgÉÔ{jTËÓ¶	¨å
újib/<=è'ÜÍ¹Af+ )$~Ò3©r£Ow+º+p ®Z)Ukà¶µÍ¬.Z<òJ{)Û'9:U´7?ÊR[íTsF"þ`àFTL-8ÜÓ0x8ÈÆG]ECO9å(±ÑÀõÅ£UÆ@Ø½LX@ôzî»é[­eòií÷å÷L½FÍ¡òg\stû_G8ä¾=[v¡®¢4ôRÜÕA1ÕÕ·i£"$oH ä)ài§FtªÁSyùQµC,kSV¦EJêyÁÆ÷ÆW·êÔêz[rRWZï
xÑê)àù¥e
I3q»r<¹s4tßUY¬òÏ=Ççr4TVG,.åFÙ±¢Ûäé±TLÛiÿ 7ëÁf·Ñ4VúzU¬µSÌïMgïÇ¸½Ït7%8÷×ÔKyþ':zÙZíÒRSDÀ>àé½ÎWÇ¾|.ëûm¾Eu¨«QBÝÙB	J¢;	õsêüYôë²üIé·ù¬~ªÈéÉßòåT!X:àà|q­iÊ'%ÇcÊj> ^¾ôõ²ëÒ±OOv§-eEÅLíUàD£\?}y'Æ/]YñNñOqêy¡=ôÔ¨R¹É`	''ÀÕñ)¨¡¥79
\G¬0\v'VÉnÝÁçUªz"Y½º°Ìçnè;ÚÄdCé9¿g	(®MõY©cEg§£ynvÒV$öÁ$p~Ú¿ÖMCHô³ÕÆe+5<4±··¨`r¥¸lFqIèÎÙ$ÓµL¨Å%1É
lÜÎ}ê-ê
?:é2ÐÖuû:\ÒªÑ@Læ¢¢^ÉWêL½«ûê[¥k£hàz|Ôí>(Yk¨ouÅ£¿;	©¯û»>ì&$ dsªºÜL¤µST)ÿ 6à89ç^£t»^þ"Üd¶ÐÃQt©ûÕ'j¸T³;*c·qãzÎõÃëMÚí®«OöáWRTm%dÎ@ÆÆó5«gÃ;rÇÐÊÁë~¥JJ+aÛjíJ©ãX)é¯Êª>ßVç^Ðß¬4·ÊoÝadêZÑû¼nõ8/ì3á{g^IÔÝ9Ö
µSVÍc¢­`!rHÀ upÀ¡^Aß^:Oª~.[héd^¨¹RÍÍñÆ¢QnAäqÆ«(ºá83(Ê¦Ï§«h¡I©d"pCBI88Õ7«îÔjje¶²Y¢ùy*VFyWb¿ôÀý¸xmUçüBÏÕt­£DòÕÅ± V;c¿¸ÈçÈÒ®½Ü©`j þ]!>bi(9ªà³/-rdMp}xÜÜ[¯·9wPÕÛêf(*V8jª$d+ÉPì
¯Ô}¸öÔ¹-QUAß¹-Æ®J°ÄÊ°
p=w°'@É÷Ö)º®Ã5äT5®àT#$þ¤¼öeÆxÇtíúã£ª-ÔuÖ<+P²I,îöÎO ¹<èõ¤¨õg­yx&»TOEIxºCN´ó+QÑàË&p¸ÆN8 ãD¸ÝZër²{-Ñ§£· PI#sÒåÛå°3L[Ã:k@¡¹[iu%a~ìÀ)fH¶QprIqêEÂÛÜm6ªa$'m¥jgkØ¸Ç«ó­}=³WiWÁ1oØ,âáu¶ÂÝÅJqê` .õ%±!p1Vj/5Õ7Ã~åWl«rÂaÄAvÚ=ä(>wx9ñ§QÐÝë«é!®ËQ<s;F*ªWj J/N6Î¥¿M_)ÒÝÞÝ\¨<ÉÇìqí¨[»Hü<mM«)W[u¾jI)²ã3.Ù*gYôöÓÒGmgÔûó·KêZÎ«j+4µf6©ccÂ!ç-Êí A:²=*×Þ»ÁÝ{2}8(xÞG«NUÝªéâÅjJx*!QÀÛbwÚÛòYÛiÃÇ·ÛFøä¼1¬±®ÕE\¹ØÈ DÈA·,ÝÃ9UÉ'ï¥=Æ«©háãJh³ò]£
r\©qÉØÛWn¨îGCunìæeÓ+¦00dÇ~? i,3üªÔÉÌU@hY[~¤gÎO`ÊÙÝ,¸´øÔWÌêîÝ-Õsj)ç·WN±VDÓ) 6Ø²Kd2°;I÷=¦­Ôöi¨ª`ßKP`p¯ w× 6}9íºá½Ê<tuBë_MÂxç8²UT¬ò¿POä®uV³÷ï½'YAVÕsVÛ&QO+ÊsÙeR©&GJ |g:²mÉG¾©¯´GK,qì»JúâbÊòÈÎsqúN©]9roÌ/5&EêÒe*Uv¡|p9ÔµÍâéÕ8åîÛk©§¦\Ì±Iðç':¥Û®ïEq¡ª¸I4Æ°ÎòwÃ±!Æ<#÷³±Çpüñú±üBÜ©®}s`È¯$u2ê*9BªÉVßÈÆw¶¼®¸I<JXgWåt¨éñ°Ùs¸ð}8?ë«gÄºÈVyµÊIó*²3][-ê÷©_.4ÑÉJcXPGÝ-æWf%KÇsa¹ÇãîuVí¶#8 Á¬TÐ\>Ýí Fîì3|{ê¿-Ìµ¼ÌÛÎj# dsöãR«R¶­Å;Iý@üÃg Àö×
cT[ê(~^Wf=©¹N=s«Á$qg§íBº{ÒIµ¸X þNF»[jd¤­j§W¨®0|©^ààó¦ÆÁzkbÜe´V¤§ª²ì¾rÀú°@À¼Çðò)**«
pT\.À|CÉÖ­«äâmÚ<þ®
<ìÌÓ@èðÆWöö×¯]¾&uõê«[¨béøÕ§¦¤´íì8U<~O:ånøIEl [µ]ñ¦%bíÓ²3@ÀÜsçã:´Xêib7+m=¾;Õ(·jAà¼¾¬¶$}CWz¤vàÑÏ"Ý>¤úâ´ý_U3¹d+F^psâÕ§¤¾/_¨ïqÑõzÑÏA+vûñGÛxû0öÁÈ9ûi»tüKo¹ÓãHáE®!wDÝ=<Ì-ôåK±¼
R~!RÐÝd¨v·QÁTÁjÚXÀ2;4{zIH[$n<j=I@Ùi1M5ÒlrFAã)èºæ¹tm½øi­ñ;{íÇþMõØ¥hóS
4j	05`k:»èu"<ç¶¹`gÆ¥S®Xhæèc@ éí:á[ãñ¦è0 jérxz[6Ñ£F¤å
4hF Ñ£F4hÑ 
4hFÆ]r6D­\Æs§ø]M:#ìuÁ¼j]râb=µ¼cXÑôX£Pr5a|k:4·×[Ð·Î kYÑ£­í­u³{k] kÅzÂ½,ÅgH\åùºX `¿¨3´~O×µkÃÿ [íÓ¾±·îù«MHR1ÄnÀ©ñÿ â ¹ÿ mG<âÑôg_L©azSPæ¥ÄO!¸1¹Ûnrp ÿ }P¿ó!|ëzLru%âzÔôà4 ìüªçû øµ×ërþiúÊW\í Ân)$ÄG(_q·'Õù_¹×°t]+/FÙlÊph(!©cQß#Î´Jåg/åáQ~YÜKß UÄågÈJfLGÄ{~4Ú(¹ÿ WÛØj=-=-Xgl³y-© ÈFY»cýs«¦tãì5êqx£Bï">úÓÜå©8¨ãM %óç<có¡­çå'j**Y+ëÂZhØ.äng<*äÏ9O7T\£V:"à%ùÉ[ñÀTQùËi=¢(å.óNw1Á`;b<ð ñ1©³hI¹ÀXãÝýÛ÷Ð]«¾ëÑ_ªéL¢_ 	X³v8Òªþ£è®¦§©.zù(4tì1
=\ûmÎN	#]ë®w~¦®ª¶QÐ_-T1JÝÑÂ¦OQ$gqeÀUÈ÷|ûj¶Ò´5ér²Ìjä·Æç~R§E
3·ÔgvuÙÕëþW+Í}Ã¥¦ºWõ/NYê Üqs*FN\¬ç~ÌÁ2¾¦<®Ý_i®³ÿ %øu¶jX] ¹ªïËîg`yiK9'TN³ê¹-·
k´¸_#OP5JÒ¡BöÉôÎ[}+¶õT_%7J9)-{ãDA&öÛÈÑ¥?W¤Übó$êÈþ$ßkãKô÷HYi¬]
l~¬¼ÖInQ2÷&¹JËºzý@ÆJ-ïÆ<ËâBYzW¦-AMj¼Þ¯µù,C=4!$gIAôvW>x×¶oVªWf¦²T¥Z{fõiÎ»å¼¸8`}ôÚëÔÖûZõ7XÖSSÔÞe§9$Göª¨ÆIS#IÛê'í£Ë6ZûåkÇØù§§ëá¿]-+}y-VøUg¬¯l`«ê+ç-¡ªå²Ë4p|$^C"@ZByÂ9÷^óÔ?GÒ¿®Ô¿Ê(jïè°Ô×K4¬'z» Pp¹Ø çNª}OÒ6j>é¾ ¨'¸º%e`»µÁE'ir>û1ïªoãïA.âÚâÿ àókïTKiYú6cqËBå	u-À«gyïYÕUMmÉGC,(LÐµ:< Øý°:·õÝ?UZjíÔÔPÐÓ ËòéP¼pq¥½?k­«ø§,Ó1ùëpcÇAÆ"ã )ôÆ¦23É¦ÏJ
öè©³ýG|éIú¦[zQPÀ[dø/¶­ý	Ð6Íã
]WQí¡¥Lñ8ÆÖrÅQ·þS¼`çVé]èÔ,.Õ	RQÓ¶7úÁõm_HåIÁ:¹ÔU¬ÓÒYl4IVdR­n4Ng¾*¥Ï$³®[Ü(oøF«Bíseféðö^I f4ghäY¤§rc
¤ùaÏ
öÞñGlRÑh¥®«¨b©<Ôí/ci[)¸*nÆâÞÊuè1ÍIÔqÑÔ´×áÛ¶'­LQá¸ ±lî
qàkÓ¾|4ÒR²òâº·æ¨Èñ)äí]¤`cÇ¶äìÇÒ|
èXz>Ï,]YåS 8Üà{jËÕ§¿,pSLq:ËM,.p6§9:wHÑ cgÜ¹ÒÎ£jÎì1Fô8d,ÈÀ Æ·¯iäú¦kgõ=mAWn£¡i6Âä ªÆÛó7#K«)M©àºRÏY5d~©6Ycÿ 9 ®ßpã>ú~§â·}Êx#¨0ÂáY×úàNyó®Ý3Ó%lôÖnT5Q"y·³1'`|qF¸r|SFÕ¾Êà­u·«¨îpÖÖZHU(ÊÈ¯ÀÜ¡þçq¦eëq·U«ÕÚ58*PErá²xÏ5.®­ôÔÒ=Ts¥\j½Ì£H@V8*	 g?ÊVÓÝ ½W\¤¶?F;¿eÏn^ÚGÉÃ9Q¤
ÌÄc8ÂÛë¹(×_cZ
1KüÂ%ÝTf

¨ ÆÈx,9#8#,3ãK©å­§¤ª ¨yB­;.Ä*èV°¾¾®©¤­ééb¼6´qEô\´fòqÎ£Ù¾eÙMSOPW·<d³Èw(#v7êÈÎ[]Ú<vüÕD¥¦¨#ºwÂ{nå~¹öã'vF1®+tüdÆÐÔºüÔT­9,I!eúq><jËÔ
	®I¶)L´Ó¥K$¦qµB`ÿ ýªo
?PPÔÂ\:Ô6'¨ÒÀÛñäÿ Ë«Zòa·$bÚì°U$RÒCMÝF¦O·»"FCVGß3¨KTÚø,QW¼S¤ÿ 'P²îêÒàqÚ¡}8áºÝ::¤ôWÐÝl×
yBµTÆ¥²Êð7dU°5.ÁCÔÉ]EEµ¢
²XWÞ>âX>Ãã,3äêogÑÔB*wYïÕÔôÕ5Æ6-¢Xá¨íS¨ÈÌìw=(Ø8Æ¦tÍþ×|ªK§¥+3¼²-]½bìÆ£t»n	*J+1ÎWÐS_,@)é/u3»AM[vÅ
H§2È¶d»RU¾¥è~¥§ømÑ%Mõ÷ÉÁïL¸S!>Îæ6§#k	¬Yäê´³ÂÛ¾W>èÚ¨­µ7Y h§ë¡°íz@VÉ%pT£¶¬Vª?=%`éÚûXÓw
ÖºBÛ·Dwb[ÕàëÊþ"ô¤´ÝkhøSÑW¥ª(J«Ô:wK.ýÒ6p¸P0¾A8ÕV¦ýÕ4½R¶[e]|¿%#@Ë5@óÈç*ÞØ_rÜë}ÒG±ãu¹Uü/}Õµò=/Ã®²´Fîd§ZÍ\I¸å£W@+àã#í¥²XzâË%,ýÕpC6¹´ÈªÍåss¸~ÇVÆN½¤¨»GM=eDjÀÈ®Åc 3¹?>øê{M|ûSÕM5PDº±´cU
ÜÁÎÜÃjÀ|j-K´f¢ñ¦ã6Ví]3ñ¬}¿¦îæÅ{ªÓCñ¸1Ueü6ï}^ºkà
ÒõKñ#®é²$«ÉjRRvÖv<º0
 3äé^üzø§]Óë®¶K5~¦9!id¹  2 Û¸Á>5Qø§GÔ³%\ÝnõW(NÉd¬©Y_·¿ÓöÀËO6i-±-6Y½Ò¶£Éfë>¾¡¦ZÝðÌlT0µ1*ïldº?Ôîo¬±<
¸Õ¦h¬[ºªõM%s»¼µ»Ï/Má`¹ß{é¦ßÖ×+-2uÖ´;b2Ý<ãÎtû¦:×gø®Ô·#-EZ$¸/ËÄT'ü!ïwç×3·Ï'¯+ÍÊãÕxüÉ3ÒWJ© ¢¾J·+RÇ$T-·/.@Ô¬¬Tàú@×³|<éî¶IAjêK¨ºí¦F5´p®\n$íÏ-Ò4ÆÓIhÙQ­()Ð#¹í«0!WÔ[>ÿ 'êLYì]ã¥¾ÔÐºHêhª#!Ì²«paôI|ê4ø!qã÷½WN!Y¨duU+BÓQÂÑ ðÇÉàýQÓõåu
*WA¥ÈÜ©]¶·|yúuÞºûd¼G]QEo¬·oôÊë°wr1¶Qê¯s¦==oö_jåÎá)î4×9'L#àÉÁ1¨ÚÛä×\~ô¼-UÔ@ÓÞzz®I"s
SEQ	ÉN]s¹¸5g¶u]íB(mßÊ(«$þ¤pÉl@9*«1VÎG¥G©°8Ô¥©¯SÔ=U=-]§U­ºj¶qfu_é¸àmÆÑÒX+m±Ó]úl´ÿ Ò×RÔ'ogs;(.Ãä~úÚù³{ ïì]¨¾J¾Ü&®i 2¤p) 1ÕN
áx'þON5ùÐK_-l6ûdunð«TË08
w6=^Ê ~xñªE®ùh£ïY¯ß7C"0ù6gïª"¡@áãOÀ tò×vGV):R¢£A¹»0Íãµ6ÉØçS¹>oAÆN}"»wéª»Lÿ .(ãmÈì'¤§Ý»9VÚê>²ßß]kéêVyÞ¸lCQ9­¼äHô±$$ çÆ®×³D-·¯åu¢1)ª©BNÆÖkÞ|zµT×¶Ôu¶Ùwô¤Â8NpG Äx÷ÖßwãP­;h[l¸Ú)	GDÌ2»IdL°hl®Üu&N¯ê;
ÁÅÞºD¹$)	PrÇòàdjíÓVÛ%2J×bEþõeÂÎy$À|¸Ån4÷KZ[h£¹3
xR-BÑ¹ý<8Ç+çZ¦«$?Pµÿ ~T]aæç|¶Ö4QeØá7yåfÚbAõr ÓÉ¨¤´SÙÝ¤X+6e[rÎðääqíW©©íÕU5õïOQ,ncx© VEÚõyÀ_^qÃ
M¤¸\-ôTw8á¯µÊ¯,U=Éá¦9bÊØÈ7IÕ)7í57SIzº:{?MÍBèñ%=x§ÔTáÖÎ>¢1ã¯4±_^²^Ó=M#é¹CÛfçüçÝuíöÊêÊc«Y@­£REQð#l-lg¹}Zñ/Tüò«å+$:³sP'Áa<i%ÅçÈªººUZ*z¹¡ØX,êX¶X¦õp¦¹-*hVrìr1vÈöÈló]¢HÑÆ¡ÃË(Q¿?ë£ª`ªñUS
JJÒR6ölD¸QãØûê¢rÍÍ'÷Ý+ÅÊWÈ«OÞôñÎ~N~ØãHo1O[]AA,q¤q°(7 «êÎ8+ÎÕÂªÈµÒÍo²ÐÔOQÙH2;{Æ?×Î¬t¢Ù4ÒÖü·~MÆ&fYÂx7¤_VF1¢îdèû:jÞnË=}3IT"ùxÀQ)T<7'É ý#«Rc¦®­ ²Ò
y`vE<gyòÕqÐ<j\k$-t{)ûèÕbUÀÝÀ0TÃÛþÐÓN®®®RµRVn:Â<1»rHÇêÎ-r_ÂåRg²RU¹Ý	bÛýZ#|À]Ä³>øû
KZ8¦ÛQ5D1Ã,ðBþÎï«øÓÊ¦ÏUw©h¿«´«¤¾¡Ç§Øù:|½ü?´»ËQS
Fé#@a¨Qú7º`n%s¸#UÅ´­&röòfÏÒw*©ÆwùváýÄdìÁ#r4û¤ïvÞ´×Ôu£ªCÜ«Ä±´Mµ¶daÆÝÙÎ¼¨þ5Ü'¥¦¶Zì6Ø;DQIé°ÈxÕvëÓÝmÕ0=ê³WM0´¾#<´Öá±ÙÃ¨ÕË45ØÓ¯þ,TT¬î-F±­9©XáBÝ±°Rí Ê8*ºCðþûqJô©¢¢`i"NY(ô¤Iãî~ú§K¤4gÁb2ãpÎ½á
Ýú¦ÅhØÏóµÑÏP|ì>OöÀÇúkI%tyxsÍÉI³ìn¢þ[Óv»~0i¨âÆ@OýIÓw1`1éðGa£FJ£F³'O`Ê}´Æ9P¢OÓzùÐåÔNÒ<.q©Ãk:í]vÐð¦íÑ£FF Ñ£F4hÑ 
4hF Ñ£F5­s×s­&§¶ÅÔW¹¨V<i[ùÓ»²&
ÜfÏ Ó;®ÎTé
4h k`01­u°Ð·`ë-çX::ÀÖu©`Ã{k]lÞÚÓ¨ºM×V¸/}´Î¹Z«tè03JùFûk1 U¾ô·÷ãQà½§Ê?«¤½üén«#Üê¨i©Ê
ÌIä qùÈûkî:ª;¼{ÿ ¯ûõð¿À:y^ôÝº«Øëib>â ÿ Ôñ¯¸Ö  6|1©Å{y<}zø¥ðnõ	INÓNÅQ¶¢:Ë24×9»0ç Ø>äêl² *GÜçÆï¨4ÑÚq6äÏq×*0NBìu±ÄM§.ü"Äç-È°öÔíRXýù<ùÖØÀQüN£×ÂÕ1ö\)ArpJý´385dµFH¨  ¦¡ÆcÒ×ý¸Ôz;|µ9eª1*fbÜñ±0?å>:hvÄ¨06¨ >ß¶¸G£÷_sHIËóôÐ~ðT^	¤IEgE`OnYÈ*v´\àù4¦ºãf¤¯4UÚcS¢©1	&ª(HÄTà Á÷ÔûÕæáRëÊ(iÐ£ÀÇWV,OpxÛª_RÐ
9±ê)ëk­4©E ³úðX¸5çG~L¦ýÒ£[­þ×kIæ©¥ª©º×
qç¶¡w(;ssªm|;¨¬];;Â³¬ª¡Ïø@î^é¿S/o°Õ¾ÑOLÓT
§Ö×:,­®UW`úQ@ÏçI®W#*ÕËR]¥T*ýXÆ0HÉãÎ¹rMÝ£ÝÒãdÕº+ë%Öªô¾®$4õPVIq#·´p?¯'ÇUÔõzT;Vw¬I
K¬u1©tî³ç+¿¬ ãWzëz)h¢48ª¤Y q,ØÝ¹G#êànÒÿ mÑréèhL±sijPzw·ÃÏÒCj¶tOr[TLón£¨¹Û)ÖíOg¨iQ%,¯±cn;âàgÆÆßVÞ.·K½mhYÓÂñP³<îV8ÜnWÈÁ ï¯RzE
]H³_ªlo*(	V:ªhI#r8#ð>¬·Æ¨N¥ê/SÚÒùùa3Óïr=)"Ñ"°o¤9·öÕ)å»ªBÅ-êZµª®*¦§H2TfBTà»`eÃeGÒ·¹Ù*ª®4ôð\Ö¶¸ÑÔC(m´ìJb¡O>
äéÖÅ%TU¹ª¦ßº7¤WSsÖ'§x$¡ý ´ýõØ®vú;Yèb¨fZõ§}3ìcÏÃ|ê"ÕÒ+
­ÓL(-êJ¯æ*ô5´Î	V WRºC¸©$¦IúÀÀyÓ±ß©ælô¬Õ²F!X ^¹÷8ÜH£D,¬äÄ1²º¶twÂkÒßvêëqÇVJºy"ÍAB]¸CêoX#$6êýwê-4«=ëq¬1Ø%Ypº7¸ãhoï­d©\/S|¶ãýX¿¥-0Ø®ST\%¡¬»VHÂ&cLj(öCHÜ¿ü:¼ÐÍ-DP­*êaN3j¯ÓÖjxn±¬²K OÇË|_¨aQìA\ 3«Bßg6¥c¨rJ·Ä±D±[<ó¤ÝS
Jýé¯lº@Ð«±*F6þÇ÷Î±Ó¹]¦f9¡Hñ?&XRøÚq®uk¢ª{T&cÚÉ(Ä`çÒX~®u¤®Çft¥ÁåTw°ÖU¼Íp¨h%GîÆ±É*»0ÓSèb@?mfÉf©½Vÿ >£
Ù%YÝ^ÚÛ²N=°~úGpµôå=âéEy­ µ¤ÆÉ-<LæIS;²/ài-ü{¹Ç#NÒÔ5=!'Êï· 7 7<Î¹ï(úh¬iñ'oíhu¬»ÚïsKq»D8Wp¡w.NWhãý5N¨.VêKou©½ÌFpd¥ +¸Ü[¿P>Ú,Ï]N=÷LÐ( IòÄò$àcIÚ<Îìê£{Zj·´Ô´µÁ9äWyÎÓØ}õIpÚ;ô«vE~gLÜa·»ÍScQ49r-³OÝùÆÙÄþ¥4¿:©R÷ ëýr@Ü¤ùcÆ\ë`{u{\<Ï4«¹Õ +&í¹ÊàÇ9²Hõ=KYmu4Ð±ÜîÞH%FF@Úà `óªEY|É$ßÏcÎ°°¬Ìµvç§«©;wEFD^TzÎ,Ãsø×õNUÎÒ\(ªè&©E;¦vA%~¥-ì[8¬=Kó´²ÐËM.Á]ÁÇÝYn#q«
mÝmë@¦ë]Nì(MÄó¥q8­jgí91©iâ²7hó>²ÑÙzÅ¢¼ÚÑáC1ft:¤\;Äs°«gp
Ïnú´ÿ ¨ímp¾=]U|­K)f1W'ôwmÀÚÛr~éµUéONØùÂÒ§0#Ëß8PÇJqäò1ZºQS«°Mg¾Òwäqã!\`¾ÖåpÞàhÛ®Q¦uÅÚèï÷­ÐNIÖ¡Ä_Ã¼+ÈÞÅ}$ÂçE¢¢Ñk§ºGu¶CN¯ ­JöªR,¨AÂ.àÇo-'W®¢¢HmóÊ:vW¼¢5¡É_Q9ØgêúWTÿ ]-l¹Íü¨MªæZØ@0ÆX	FÒÌ6YxaÉçHÃFYs9ÉÁ.|_Ý;tã××+0ª©dè ©#-*áÕÈfX ¸'ØîÔ¿]Qd¹Ü:º¾Á«yÄ½cÞôûç¿Æ®ÖµºÄÕ´* ICQJû%Å+·r»T®sªõ]ßs¢¶ÝhìKQâ
ê>Z*ÉX1íÊÄâ)=GhúN9Û­Värÿ bÜß+ð'¡úo©¾Ý'ºÕÆ·K­UgË	&P1UcÆ@Fáí®uz~EK[ëå¥A\R(¢y6GÏ¬6B"Ä,>úõ>¡êÞé+'KÍÐ4]C®ÔdfpA`­áÔ9'pÉ'\ÅöÓE
#ÿ ±w* -ª*E9K³É,Ìp»x ýõvéßXãéìu_¹æ:J³«?§5IÍSA-0î4½ì«4çÏm×¤twCCzø[5©Rz{¦ùj©	òÐàmSÆbb7r>t¯á}íÓKg¶õ5Ö=]EZÐM#
@UFI!7e¶xÓ«µMú«ù¥¥UÌÇÅÃMã*jàóuI}\aibQuBKí½h·¯Ëµ-:C4²dÄÙ;½À;Fß'YëÚZºY"ó=HLîTcÁ`7(-¤ãÒ¢áZôýGÕ)é8ûÈï
@]ùÌ ¸Èp9Î[z_áýZË-¶¿¨ë'Dm¯OnéxmÇ
wa¨.ÍgÆ*1éèîu7ù&¯Z*Xès%*×Ô3¤ ,p8À#äkIºÒJÛÀI,K0¥q,&Áâ,Xîv,0Ãi8b¹Î5~ê³Uv{¹ÒCN¥ciTDjK
)õ'ÓN6ó&z*M¬¢i!*v=,£Ü´hã³¢ÑgWuUãmJ~¤éÉ(¢Ü¬18ÜwÎ0Ìïo¶¢t½kkÕWôÝÂ«¦¨ûn¦øb Çî×³t­/Mr*UÒUa÷c)Äñþ¸Õ[¨úf¦*é¯6txí¬]Ôí|«8_ñ9¸ã[%|d³F9=¶¾â(î4¶ç$V¢xö¤ÒCÞ¥i7¯þ;=à¤ïLz´ÆýÓ-Õ0¥÷§în¼99 L°1
xx3³pÜCàäçv­´Àd»TÇ	ª¶UÓ´uÐ»3öAã¢R°ÎHã©yÓÉª÷m¾£Jã¼I©Cî	!¤ÈÚÍúüg)8ðwC
ÍRÜÓð×ù$Zú½â¼
âÙPÒO
 x#Øñ;+°p{e¼ôuêZyî5ÔóOM%-pF¸f°,ØÏ¤{îÓN ¾¼¶[­vû52Þ¢eh."C`Ì¬9'ÙÆ´gh¢¢ó«¨á$YÕ;/åD±²ø"0ÏÄg:ÂJ/£ÐÓåÉMf_©2³¥.¯J.i]=t5,k6=H@Ü¡gõgÙÆôõ¢%¶HÔp
SLù¨÷ 
ëAàí* [lÝU6ç§ùå=ê'
cá}$þ ¬6HÞ ó:QK$(¦WUQ0hÉu§#ÔU¸#ìÙò4Üû/9nðü1m/RÓ,qÄ!§¢¹"ý1\Á%¨ ¸ýñ¦=v¸Sµâª²	Ë
«êdf\  ;@ãhú¸9ZôÜ{T3U:´ÅÈrwÏ,Þ®r4¢¢©ºféóÝªi2Q
@$.ÇÒÃ8Nvtº§'ÊùòY­k%îøéÕ
UÞ¼	,R9ªí
vî,rÇÎ1«¿OÕÒÐZVÚîµK-InÂCì* O ~vê·¾õE|fß1LtÇiA<©$oPNNà=´ÒÔZcV8ÂVJ*«nVÁÝµ² -é<j"öù)C$We£Ò\Mj¨ÌÑL±?J|çÇß^Ö\nÉk*à¦YÅÚª	¢·«ròÆ=ù¾iQEGXe*¹£BPRNóì_øÀ'Î¼Ún¬ÿ lÿ ÓJzºïT\ò÷8 9'W9´ïëî®·NÖè%ªÃSòD$eXÇ¥HU øç:²ß,SÐéÐè0	Pª0JíËHçÚºõGÃ±Cq¹À/o²IàQÉ Hbs°FFé¯UÞ,1QÝÉ-c¦)«	"pkÎíÀ ç:¥+£­J1êà¥Ýs_P÷*²¹j)Û·V*¢2¬p±êöÃ ¤¤UuÐJê.
Y4ó³Tyh]»|9ó¦7N¦¬n¢¦½%¨¯yMSW Sçê#ö8÷ÓJ­³½ME
I D.¡;YÉÉ
 Oç^¹¶soõ=¥)a ¹_~Q4.	HYV"±fsçQWã^Áð«¦-æ©qQ|¢¬{ù²Û°çÜ
¤éÇDÐ×X©«ä§XU¦i%e?O¤är|ûëÓ,4õ}>ëwS¨Ð$Õu2ÂÄrÀ±Ü®Ûq¢m¿±mÓâwõ>?Ç§©éþ[$.÷¹FW ?m	`<²á||ëçµ]«*b2ÔµMDÝÙÝÜTg~ ãó«×Åµ_Ä/ýGJi"Û²zVH
7-lFtï£ºa©¯¥Yjê£î¥rÒ{fQÂ¾OþQî1¦õ|82jesà>Yëzr¼Ó¥%5B·Ë$À%×;+àc¬1Î¬}[z¹Vôù­¸L2Ë¦(cp¤ùÁå0È'ÎEb¬¢;tko@3ôà!Çÿ ¥¤=wR[(ã¨N¨{J^7@,
ä@÷×-¹;>8pÂÏ
X%®©S<«úÊ7cÛ¯£?,uwßUµ7nb-¶ü}>?ªGöÚ2=ó¯
µÙ.7{ÄvºSVÜk"6@;Ýß_otwNÐôKPtíª*(4¸ÁSËÈælþÃ^5»ÜÏP~·¶±£Fµ,4hÔ§À
f/:Àó®.[Æ¡Ý"M2;  -£äptö<(ÖyZ¼Ðau¶°<k:±å4£F hÑ£@4hÐ4£F hÑ£@`ë=:ÛX>4D·HÎLó«EÁ='UÊµÄë6{)ðD>tk-Ã<k¡è5$²§'ÆÆÎ°u`è`k:ÀÔ°aõF1¬¿k¨¡I4Î­­MücVÚÑKRÓ×W]þµ9¿r]F¾¸´©=K>ó+dñö?ýþÚùcáL/ñ³ÔqHÁÉ®<°l«ØýõõUÊé@½ÃãÕÃy÷Î­¯ýfs##Q))cß¾¥+CøNãQ)¢j©T °@¡°¸ûãß÷ó¦[.çÁÇ¾´9¥ðÎ4´å.ÆGûÀýµ´òv×qÎ}÷Ö´õ?ª4nß´mo>G#ï¡^Ù Ê Sêûj=KË,mÚmù`9þÇÆº$nä´ä
%¸LñTÉD¨Í·xXÕå²yÉÿ §¶¨Ù¶8îtL¯®l¯4h©ÄrÜþuåýGÕ2ÓÔWA
dµO·1CN6Î  7¯Æ0NHägCëþª©¨©j9íÐ¿Êná;Ã¨î;®vÆäÞÚ¯Û)æ¸ÜiÚ­éæ¬ ´¿áo+
Á³Ç ðºåË''Hú-bü/7ä®ñVVRÅRÊCGÝîÉ2vmÚw*ú©ÈkIzã;^¯F;xÚÒSÒA¶(çe8BøfFÍà¾Að@Ô¸)­6ÊºÛÓ¼u÷).ORéÅ
¸Hx|cÂgq<³cSª%§¤¶¶ª
Z§"R¡²
*	Nö]§FÒ[1ªÊ)iÊm:èý%MG"Cd¯µYT«ÌI2H.õa5öóo¼t\JÒx&vã
ý\5ÂHªksÈ³¶Úv4²¢!_h,©Üq´óm41^ê©+(k£¥Us0cÜÛÁHò¯û¨\peÈäÈïà®]=ÄémÆp3
VeYÁ1Ê
åÂëL/
Zºb:z.Ýé<d§gWu8\Ær ¦ÔhäFd*8ä1FB$ ¿êÆ1ß÷ÔºN¢²¤NòÜhäH³P»»«N8;¾®OTy²0Ë'íF_ -m_NóLrÈè±«ïË<aI ©êËCIk´Ñ±·ÄòLçsÊÛ¸ÉÃ<<xÕ:ïÔSVÒVÕZ¯4ð*Tw^Þw ¨çß?WãI§zë©m®ÕCÐÔ«ÈñG´bHIÃlnÿ üÇRO,±Ë8¯R|ª½¬TQ[1fEÄÁL[úä £ï»ñ©V
ÿ zôÞ?¡²ÔB¢©÷î#8ãí¯)êe$ÒÓÕ5,ó(1I,ÒI#JUp¬H2=88oÎ¯ÿ  9%µÖSBµKoÍQ²'ÈmÈ9$i{çÓúztüv§IzpÃ++ì¼çiçøkÌæ¼_Ò¶õ_K½c§e¦4ò!î)|fö$s{ëÒm5?1Hiê[´«$Ç;_$8 ç÷Ò~­:UÝË ¨nÙ"dæB ÆáÛ¶ÿ bu¤ÕÓG¤Ê±¹BKOFÐ´}]qº¦ÊHIcµäxõpu×âÂßR«5<u}ÛWpzxò}ñí§=2Î¶XªÊàÅ£Ç¹ÇT´¹Q½<ðÑÒE-eCìeKra±ÆH·¶´m(Q+Ï©¶º<Æ²¦5¸I5eú9æÙNõÂ­o±÷&}g(Pdù?mL¼+Ó[cêûå	`¦µVzu+Cpª}%<xÂóçJá£¢ëQWp¦ºü©)¿ ã"U °]Æ*wûçZVÝìu;uCD²´PÅ(Øv²¤,Í1z¿ãëÉô©9I_G8Lôöé(Ñ)¤¥h)ii%Þòb5!ßÇbð~Çï¨êY(l·Âß"Ê×åêIùb±µabYBHÞ¶¶«rSµ+ÑO,L&6jqH03T`zÍøÖ*¨ê+zxæ¹
ZHVXûþ®æîv¹ã¬F5Lë§Ê,k`¾a%5ËÞ!¸BFßÓn<û>Úß§­t4íQ
ÕQ	PÆ³mPêà#Î×T`pÕN
õ¢¹TEQTîLÊ±I*7mÀþ T>s8'È§}-s¨«ª¬kx ²*Î¯¸Òä1ò¬O·e¹¦Ýµç³½P¶ÅtCHèbTíWÜªNYxc¸evã5¿G<·gµÙ$ßÚ÷
´Sº
±66îáÀ`?¶ÇDóYéh`bJ^G\<»þVw¶¹Y¬½`f§¢djÉi rOk{2à°ÉÃxõiÔ­deQKÓj¿»TÁm?Í<+ÆBÈ{gð$ôãvVE_µU©A1¢©Ã°!Ø¿8Îp­²WOç\çï=D<¿54w#
à²©þ®UpAQn5lzU¨ÕÂZRH®H\g û¶õIët÷.O"qpiÃà¯õ¦ç_±ÑKO=M;¡¢,FÅpYJ1^9Ç:¯ÒW_ ¯¡³ÜnÍSÏ(4óÑ)·.ýØ1äªìÁÎurë$=KoTIÊaã%½-»>ß|ûiUm»¨.=[VÅlTVH<r<î®0gTxwØ5g8fpRK'R®ósMdíÝ§Y¢* Éå}9Ï#rå²<j%·§®VÙ
*E$iK\Ë:¢ÄqòKn G¤ó¯p¤äªê&µõPUTa#yà§D9©Û¶LïCéaÁÝó¨7·t÷V[®{]H¢@èdaÆÖ`Í s÷Ój^M¡©ÞÔ¹k²ÓuôÖÈ¨²^,Ìä)jC¦òDQ¸_ó:¹=ïç©Z«ý»´°ÇºsM,2Arù<Á
¦½UÒÕ·xéÌw#NÞOJtycêQÆH##RºO¥zv)mÓBµ¦øä¨RÛdý2.ïHaãSµôß>\ÐqRJÚ)´Ö
î¦JZº§qa,1Ï.AbØ1c,29ó­ÏÃjjY[CO2Ñ¸%ªçäDJâp»0£ ¾®ôSBËÂ®íËo&>ù*qljgYÕÍe§¶ÆâÄfªíraêb8 yjRIG#YRK²µd°Zë¡ÕÇLç»pÿ D 9_l	qÎ5¶ÍSKn¨§´u´44uè½ù
ä±'ÖY|m}:ikR_¥¹ÐÃPi§L¬A ®ÑµsµO àóÁç]ì÷;?ÌÖZê$§ùJ¶xw¬s¡ãÒ
öÖpÈ3ãvÕz6kE¡æV^Uª &ð6ra³ ÀÒÚËÜ}êZîMiMÔi
>ÆVÚg´CÎÿ Æ®ÒDlwJÚkºjU+8 ¨W*ÀdûçUd¾Üºr¹¨®¤¬¥DCò&ðäS0û³ä`iÓ¤mö6ùB÷[['þUn³\ec3îSµöØxcî6ø:¹C_]S¶Ä «íÖOBÇ-ì6àa¾ÃUjû«©Ö«æL±T ªoKÀÄÈ<¶q©t}>ÖWéc#LfJXY¤¡·ù±iÒåýw)ªm6JË}B§MJ±Ë%8O£}ë`}øc9u©z6­*ëªË:!ËÚRÿ Ôe`ØAÆÕ;H5²QZëo)Km¹»[®TV§ä²¬µØî÷w@HÛå}8ÜuX¨£Q-+Å<4ÕRA2F)¶6PÒÃ$~}CTÝ]Á9âÔý¬¥^iäéksPÕ
q\Fã%BðÊ­þ ãotæíKUn[Ú<ìÓ¡ÔÔº>-ª^yÈàcJÐÁUg¬³åÝÙZ9@ö\®ÁÇ:Mk§¢5ò ß'Rà ¨XÏow¨mt\ðFãÊñrÕ?¹ìÓNãÑé×e¹ÕW×tà%xà0Æ`dxÎu÷A¤êkzAy
EWXÎå=°Í¸`[h$Õ:ÿ l±Ô=ÃùeKSéª©$Ø	]à®[iÀSÆJû§WÊºÒÔU4)=Óbh6G¼DAc´.y;pÇ, áµ¢HÁaøNÚ"ÐÝo=u-Þ_¥¢%q»ü­§qúµ>Iº))+ªé«^hEC»_¥þp0\,ÝOyz¹gHf§­]j*ºîó´}J2r«f§ªª«*+ºRfÛ¦w¿2°;NO, Î¯jKàæÍ·ÜF7d¬Y¥¡¥«ªª¶Ó«üÅB%¹ÊIÆ°ÀzpwcXm´öúwY%jÚh	q7geÌcB0_v9<ó­-ýCY
	I¢ M9¥Ñ,QÁz°åq¥öªJ­Æ×XèbvT¨Q#(QµÞpxãú«~9&òStü3¥Z<4É$ðaí2f<r=8ÿ ®õ"Ô=,i·¹*3d«cß$óöÔXã k<t;
(BÈGpÃÉÇí®P¿Ìæ¥ zr¤c{D¤Ò=ñÇÜêÞu-²ÜPî/e¯»Ýc¸Ó"Gl¥@ÈÌAebAð#U[´×®v£GFA¶ 6>´ÞFq"z@n=D8Õ¨¡«·Ý*&«¨·BóÔ¸ùL©ÄgGç,yãRëªMÞt±ÜÃ²C:÷6£9ä®G
P8ä®gýG\nX*ªÕòëÓïùõd(±ªð79U>@å;¾ÃMì??UB¶
=Â²nâ'e¢u
P*Y6ù+¸òsªÝºí¢½I©/~3K6å
sXû`z¥-#ê8+­·h£^¢'bd¦_#Ã¨<{häú'1Æ;¼xt5®ã5ºëDðÉQÆÔàeb»q¥
Fï;Æ¼×ãWYÃNéÓ<ûÄ<Û£Uoù@Á@<QöÖ¿:öªÕ,wZ¨èêà2"d©¸r6¬¼@Ò|ó¯èêûWQu|_Ïk©hH[æjem«K*ì,©%÷q~u¬-Ã?6HË-d|¿òÁl6ët454óBg?3¸á»ÎÕmÇôÇî}®ý
Ó;Õ]'dËÉTú°Ê£HG6é¯½VÑQ\Ö H!aÏÄ©ý¾Æ	9°ÔRPPÌñt½¦r©mMUTòµ+ÿ ¡Ï¬ ç b±ß'­-BV8ª>=3f+ «
UISS½ÄR¡V(Cpxåp3Ç¸Ç¾|J@!YVd7÷ÌG´«ï`YBíÚ@ÛãV:z¶´ÿ 8®¿ÇÃ3\Fª3²þyÁ÷Ò^°és'F\+Å+é"§yÏûÇmjå1çÒÀ`ùõYBãÁ¯S¹3ÃzaO]5PË=WûI®íje>þOÕþ£_g»fGã'_tÕ|Rèè¡EË\Äqò?uõû6[:êÃôN¥%Ñ4kB Ftk#é8É¾¥R¦N£ $ntÎ>¬YR'QÅi´+¨t¨@çS×éÕÑáê%lØk:4jLF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4h¨xÕráõ­3®=ôå¨U£»G:t"n5Ìk¬ùë©#ÚA£FA`Ñ£F5¬ëDëÛYÖ¥Vúµe¼ë4kÆ Éá_	!íJ®KC\Éé#!?ï:ú~öÌÒE£b²»gîF>þ<kækqïã¦Hm¬¡Ä¡ùéÈ$þ2ªsç:újç¶Jët
92÷<rTßê@þú¾7Áâjã·)"Eó]»W<Gxî5Ñ&QçêúGù¸ÔK«³ÆáËuâR¬9M¹9÷Ï¶¢Z¨«§KÉTH4TÉ)
mÇ«Çßí­hæ¥ÛÈê¨YÏ  ýõ	ÒHÌÞÇÁ>ãQE=m]Ásùê®´å°«ûs¨Ï-º)( @-àxçïçUm"aÉ{{'VÕzG¨)$¡G+Ëû~úóî­¼AIHÑ×b*§¦U@-JøÃsË~_v?e:³Ý®1Æ{ØRÁT!=É6îSÿ (çïÆ¼¬
WQ^­ôôÍ/ÎÔU»Åªò±I\ûì+éCÆ0NIÖY'ÊLõ4X;é	«okÇPRKÒÛªÔü©öO!vSÉPW!x rHÔ×»U*ÏO]ò±Ô xAOÀ»)Ç×µ[ °Ç©8:SGAm¾¢ÞõtõT´à$ÕÆÇÕfr=B-ÌÄàà Ç:~¤¤{åÂ¶­î_IÍUq1Æ8<ð7s·¿«\S<E§VÔr.	R,W²S,G*MÛAÄw	çùÈ<9Ó¾é¤«ª­»Î#rß5=)Ù¹gãçmR:g¦ª«¢~·êxèíÌd¤îÖà1,#¶*WéÎHn7i·©º¾i(Ñ(Ú*ê£Þ±¦w
Þ1yÆ«\ÈéËÖ¸á¤NºPÎzÅÕ3GFí$VøaÄ°9Úê ÆXðr¬Ð4ö5}Mêz3UXdù¥`m¡@óÇÀûê·zzOO´v[SAê^ª¢Ô.¸ØIÚ»½?D¥¹%T6ëeº¢ªu«2¼CÎì¹ºi}*G'Z¼héÚRä¸Y.TSCjt(;rWÌ Á
ÙýøÒ ©¾»$u¹(¥ØÍ"¤[Þ|1ãçßÆ¢Ák»ÒÁ{2¸T:Ââ%b®FÆÁ` È%¾ÃS)Eî¢Dº;¥dS¥E@pQ#pß~F1¬uÑ³Å~äG/x·S­*AÜV¿e](ß&ÝªÌÎ÷ükWS-4³HµÏ;Â$bÅ>C If,ÌßJqÁ:ª_¬AUÔ	KS<UûÞY§SS0vb¨S¶ì8>Z¥­î­iNúðÑ;±.ñFw«6àcí«=ÔF75jÈpÄµSÛftjÚÑ:ÊÀÉr¥v¾ ÓºÉ"_®³-Y£ÌÊ©Q$ d)Ü\©V1¥3ÇCk6k²¦§ÀìF%ÁTòÏßNz	¨ïWkes
h+RY÷
T¶ìí¥F×PõsF.Ú²ÚØ§¿û.+<ÒÕK$ê°ÊlCÊðÃ`Ä5:à¦çYj¦¦TF¢&x¡í÷U§£ ­°þ¬ñ¥ÿ 5IÖûMÐÇ/© Ëo>À+gìO¹X©(â¤JÈiÙ`8ü~|k»i+«ÙnK2¬íÉG*>:Á÷È×õWËTÉIjI¥B$¼`m\©;·§$í é¥÷âuõÓÐÑ<bÀêYÆåÏã¯9¹½¹ïõu·ª*f¤ùXr§ 4m
ú³ãË6hË³ðÝLO|ÈÕÍÕíE'P\tnãÄ\ÍÈÉByÿ (÷Ô4ôé\Ð¸Ö8·¤%yc(UTûÀr}ÛÛ¨n×SÅ[Ak·`¥ýÏdúC3¹Ï¾õ
aäUYê«d}²/n0
H<O:åÚÏ¡EóÁÚ{{ÿ ³ôu1GuªWuTq³(ÄzO±}õ+«â ­1IC~¥Ìë"aª6úG¶vàdÙÄ/LôÍMMÞCß:n%gFßÝs52²(ä¸VàDJgÖ½!ÀÏÈäz:mQÚ±e²Ü)"hØÁ"XS
Þ1Çv«¸Ó~¥¸M4ö(-ÑÕI"ÏÈ°ÉÄ ÜøÔo©¶Þª/Tlô²G2INñ9¸»Å»içÇ#M/rtÁ©[­4×Æ:¹è÷ °Ü}%µWQ¤sÖè%Ã,U-¡í¦)äXädì§Ø§(HQ98ÛùÔm%ÐNö3ÉQòÝÍ©+:ed8R1ÁP<g^yjë554±ÕTMY
4Ò=:NÈ8ÆÒÀ}Y$jÛl¹EO
<T°CRËRÂZ!ùt,xÊ©%/¤s«E§.z1ËPØÏùå¾N0SGVn0*4NÒÅ)í;XdîemÃØkÖUQR¯PDñI%ddÄBn.;TzWÂIÆw}\£JN¥¬®¬¬RL³Ê{£ü¬P/¼nUTÉ9:­R5u¾õQj¹,&%Æå
a·r¸ÙHúAÁÆXêeÂàÃNÿ ûùæ}ª+zb¢´¢¨öá¶ÜAãìtÂÐfà-Öè`&%¤2>àHÊàrpÕbº;zêÒ²TîßKOì>få9l }É5£*ã´üõ*L)îqìTv·2å±õ`³ÆxÀ>çE:Lé£çsþGýoüú¢zÔ`jvQMòJw¨UÚÅ¿,xûgS:~çWUqxn!*j4YGÔÑ·ÓÊ±Î[§½Õ1¨¹5(I×r$=²°åe½Ï¶xÔêê¸j¨ÅÊ¢'Ph§>7 p9ó}õ)§r³Æ^;QÞ£¹ÓÌôÕ0»Ã.3»*>ê¶VÝ&·^f©ÚfHÈ#ÈÚÄJçp8'Qmõ/;Üç§ÀXfFI\RpsÀ]¸öüêM-®V=Æ9åþÿ Õxå6ýX$þ#Æ¥OwecÛ¾õ]ÉØÊeh*@#q8÷Ëå:Õ"ã}³ÓÓÖSÄ3'ôãÞtÙÃ~v·8:]ÖÖI2ÈcH¤fyäe%2í#¿æ;±·çM.Õôõ7ê5å16;*È!y'Ç§Üq¨NüµRú^²8Þ£0KOÛaW<àøÇ8@©¹=¿¨~Hw:²å]ÜøÆTîüLéÛ4÷WQP ·ÒÍ&ÖyC+°2	#q­ÕUu·F¸ÉfXÊ__<û1¬éÑÒòCsÝð4ê­³WÓ×Ò§®ÙlBÑ³:Ç¨zêS1¤Gu4}BÏSQe}²©ÊÅXÙ¯¥±äò=<éI{¼ÝÛj²
Yd¢-².wO m<å«ttôÝA-BµuEÆeÃHîiæGbí³g¸;FF2¸ãÎ´<£0QIÝ.Qßª$¬nTöøFUÌ]Õ¥.² rcöÖje´ÿ .ºRVÜj-RÒöâù{ÇúnØ÷ <q¨URÏ_%E4ÔeRê#2¼ªÁ}Do#slñªöº©®t»â:T-±¼Ã%2pÊ,Wj§ÛI6iéÅÅú©.VËPY«#Hèåe.mJý#;¼çÔë½}ºóx§¯¤hãêDC&=Ué|y÷V
3iQn°\î+==+Go.Ü2å¶ãºÑý
.¸ÃB!J¿¶$ë$
¢1¿ÌIô\jªt»,ð'.¸gk
Â­t´UL.`¼µ4Ò¹Dª;Ô´¹w	ÁÜp|ûp»Ú¤jh¢Z¯÷ØF7	Æ±}¥zz[yAé¦$)v7yÊ©' àFµj÷¢¹RÓÎ´&ãN³:JGm*8SÆ
 ÈÝÆ²wr6M¾É®°Ìu°Rìª«º&gÈVEà}>ù(ç3µÒ\!§v$a^ìÁS¿,ÃÔNxÇãH«îu0]~YÝ©«mGSd_ ëêë=¾º¢Ã"Oy©cu¨TrÌì0ü¶2¥±ãûkX.99²;É'ºÏUEMQVf¨2àVt!Þ¦É 4²þÔÉx6Ú¤¢¬§e,Ñ(3RzCÛ÷ÛùlÒÊ.´âibþ¤súH#9aÃdîÆ25ºSÑU¹ÅoEvzÂE'«8ÊãíÏ5ÁÐã.dÆô}?Úå¨¶U-,É	È<lÑ+áH8nBþçÆ»t}ª¢õ_,TRÍ¾gj×EC"Î7C~}½ó¨´¼\)¨-iMV)õÄJCeÚ2Gî1çYéú¦"Çn¤»¯ÍRÝÒ¤o§VmQÆÔâ¿Ìîéº	 §ÞTC!UiÜ¸ ~¢§ïï®
2QÓÓÔRöÅY%¬hðêK*í'ÇéüjRKQns$ýÆÄU¨b9üqùÖïöNéP'2TG%|®áHçªw vúG¨ûêbæc8%¼Úû
Ó¥ëÞ¢bjjfî±dAF#éáC õ`ªKB±ÛQ*­õRK<«2:m@6ùÜpvçhm£cÔrÞ(^¦Ù4ÖËfT°:+²#&$ p|s©'It½Å]Y-\;¥<qùÉÚ§'>øÕw9ªÇ:ð$¤ª¯jSÙiÍtA)êT«³)F'h'#:²^®×jékêikUÅ)é{wn=;~u;¦¬5+ORug|­RÇ4[pÐ 
#${èø§KWHQXíêÔµ2ÒâJÌ.dBÃ%C$óvdDa¹Û+,ËV3åÎ©¸7PÝZxa%9xøAb|rIç>uºÏ<õð²G Ê*T,Ed2HeÎ~ßmp©µÜlµ¢Í{´VA,KÛ¦V¢Êá°K½xàNF1¦=(;.#£"*÷S.ÌH9 ý¼{u5¶5àù¬rõrïeû ¤½Þ![dnãtq(ÂR¹lmaÈÇzcu²G,¿ÊhÂSfßTùDþÞÜåF¯5·¼õñÅu­«0¦=ç»r¸üX©ù§¥/cI#G±B ²Oï®IÍÝ#êtÐBÑe²W¹S»½²£°*à(f<9p:³õE®¥:ùOòî­nïKÝÌý{Ng:ÏMüÒÙaWµ%2ÊÑÇÓcªdÇïÁ·Qþ0½=5[#C--Q
°Jv	Æàyvux§f:«&E¯'| ¡áñr¦D*(bcÇ!¶g÷àëêP01¯þ(Þ¢åÔ·×ÁHÌt@Àqû¯×\EVIna£FX¨c:ØxX_¾²¹,xÔÑ]Çx8£4¾I <¤CÆ¬;S2U:zxÔãZF\c]5sÉ¶4hÐÑ£F4hÑ 
4hF Ñ£F4hÑ 
4hX:Î®9:Yq i§ßQkrC5Á-²*hC5¾ÚipãK%>úÎG¿[®5Á£F kYÖÖ³£RÁ«{k]lÞÚ×PX:Î°|m@<EóßÆ¥JBÊ*i(""Å{®ÆJîH!ÿ úú(¯T ÙÁ)npHôñ(lþq¯ÆÊ/ãÚó90Üi3/¨hÉÁÿ 0,ýuõ ni)Yãk¥ïH"<LÊÑÅûî:ÄÕ]ù÷Ä üàqï®1º×8J­J·øÔ§
«Ü9ûxÖGG!h²/?IN¨·ª(®WqGP¥ÔÈ%-ÜØ)ÎI?:µÏ[%26¯<þÿ õÒ	¨©b²±¡
Ê¦%rØ$1{çÂ~ãÓÒ'Ä]iÔ1ÐØ¤©Å7w1PÅ´¬xCbßbÀÛ^;j7%²Ý:^¬ÑÑ¤ï¹þ£Êþ¥`ÐFÖR1s¯Kø³M²Ë,1v)Ñl	éÇ¤.8×]hàk-¢×0()byb§asª¦\î,íÝûÆ¹²vì÷ôxÓ`¼öXºUã¨¶VPÑUì(W­,@
õ>tºÛg¤¯¿ÔÑ)â£¤:©ê¥ûwíõ[è^sDª@Ö+ÇòÅ³+=<SVRØ<cTù¿áÒ¿3nèzô¨¡«¨b¹t³É±
 ÜÇ1xÀ>ÚÆ=rzYqµ7éotÕýLo¿ù]2gµIG¤¥ÆY×$¥
(úB@ä©ÇG--²ÕYIInuÌòÏ·fUl{Øò5ù]5ÒÁ%¯U34q$eUK  XÁÛÇ¯À :SH%£¸«IRóUµXQ,dHC1õJTTsäêmµÑñF
¶Ë%æª²ôUòõð8"cAËnÿ ¡ò:PPÛcÛòÛ¶a-$l¤¸  ã:«teÖí=í¨æ¥yiD©÷ÁßQ;¶°<ú³í©7þ¬¾çu¡¸PR%\S$5Ôð·j"ÇoqTRyPõgÛUi[''/jÄÒQDj/U÷JúÜ8vÈpFO>ùqu*;eê¶.¬¦KDr_'è$±ÚrËm(¹£ÜÍ´|åtâOP$ßBífF
Ä>F4ê¥5Ö»të¬=ô!dã`
·' Xàê6Gêf.Hûb©jd¢¸ÕÖtiá¦EÔÔ¹íÆ3½ÆÝØUÚ@Æ|©7)n¬µµdT¥ee,¹#KÃcQ 	_
	dRCí`Îþu¡AÂ 'Øj"u$öª
dª©qO
\²L$úäÇ+\} ð}ñ©R¤ì«Â·$?­î¶þ\î³5Væ0   Ñ$ó¸·¶4ßøx¼[ªÕZç
jx 7dÆàìÇ!åÛgÎ<¯:Îñ]{ê2K ª©T¢i64äðHÛÙ<kï.é«oBôe'NÛf0Ëú§©ÿ ¶Ðk£,ñüJÿ û¬vú(ëa¤(tÝW>	öÉÉþÚWñéH²ÃLb¡~£«pÀË(ö#îu`»ÔAg±ÉUHe½FOëÂ.W¾Q5dÍÓ'Ê,w82úÔÞK±ÜrÍER<íê&òË¤H¹ÒÚ¡E-µHæÝÝË+*HÆâ<~tªm0VP{\I²jáB ²åHÃaÔz@ÇoQI]
Úib9#ã¿y_-î ¸P >ÙÔÈîTÓO|ÑDÁ,J³mÊÉëTøGÒcßsdh*$Zv£7'1IveXä.B?ßLÅ]mº¡*¥Ý X1~ ¡
Ä/¤}dz¹{j®ö)»uVºzv;æj$zØÊ¹¥°IÛa«M]®æki%g~Ù1,l»#Ò}²9í¬å&Øåp×;TUÔ6(n4ØZyIÞ0!~¥ç®TÖOM5=-5+ÖÒïSi]îFFNqéí«E<R¸îÜ"EÄ«Iöì,8ÿ sÇ*Z¥xj¤
Êûe3 íª.Ö#fgqåq¸ëX¶Ì2-­¤r¾TÇd£S5fê§7¤«& +ìôH§&@p¾üÇH¥¸­S²Ð'q¨^DÜ\d¸$`7x:íÖ5RR91Lß5òóES$XîÁ]¸8Ï¡IÜ05ÞÉA5îépì(ÜL«"·¢FÃØzrÆ9'VmØrËÉDêêh"÷ªVEu3ÂêT Ä®p5?£:¾Øièâ8«ÓTS÷
 B92ÀÀÇ«ð²Eª?ê «©S´Ó1\+DUAN1Ç¾¼ë­:fº´Æj#«©¨FmÑ»Þ5/¼?Ñ`àjI®
]ß«	¡»%5MÆKD§%@wì¨Éf`­é£-3
*ªz¾ª¦¥aaæ"²0`¬_ (Ú*[8\¯
 êjøh©ëkf£CÈp\ÇmÎr0ÁGîðut£ºT<PUCÔS¥+#R¦8áW|;
*¡HÀõc>:-	c+ª.Ýcr¡·ØãHåÍ$DS#&ÞxQõ{äê©)hj¦:z¸#);`«Íê<pç>G|ë=ÊË^ÕkWVÔsÅÆdy[õ(&>GÜùÆ¢ÞlïSsôò½lqH£ç ,¾¬ÀÀ¼¬²EÞã·céK\ªÝL4Q»D´üÎ2»~0N¶X(R+pJxwRMÜ«{hò ®JãpG«ï»:.IAoéºe
T¨Ve,eD²	Ë.@|Äý'ÆTõ-m=-Ô³4QE[E¸,8 ±ÉãØ
CUÑh¹eÔªM}ï§n2ÒZRË!§iéÔHpq´1>ç?o"¦¢¶UQÚ¥*êÜRÂ¨U'9u<.>ØÇ¬£Ûä¤§`'©BöcÛÞ|àzÛ x^?Vu"åAª¶JºÃ´7,É!ÝG'òc>¢£Á:´e"²ÃûSÿ èË¦.uñ5#zjØ#Ìý	5!äc;Îtòæ´=Tntvï&á©`Ñ÷ ä¡²ÃÒxãUûýîÛi£²Úéá«7HëUH~
r}%·7>à{+¯¼U1ê+*¦¦NÆéa20U'
ñ)a»Æìjý*96<·Â$µþÀ-#t§ëb+uþ
ÄQp	QéQ9Óµ¬µÒ®9iJx©Á¬rªçÝH
r1ùÒ[¦Ù%®	böoê¢V%@S´¿#\é:nÁ¦ãqG	ìãñò¿~AãThÔÜ×?qÍ«©kmöÊJz©éØO:!LÒ¿'9##ÀÔ:þ¡¡Ù]LT¨SAWj!ÔUK by\y×¤¸41*Ç_Oý&eC"¬¨Dõ<"çÎHàmÒòØúæ**èâç
1ûaÛr¡Aã¶|wdñ©WTFZSrù5ýe¯´GÆi® FµU5\AØÅün@÷ó¤7ZÈj­µ´éUPZU3ÿ E	.³d0ld(P225ÿ po¶ú¸"Þõû¸mÎógt@¶Ü1ÆU@à§?e¥H	 ZÚ8*©T²íA¹ÑACÛl.X.O:S»"9!$àûBsNÐRSÇW¢«5ÌÒìH$¬wG·:jHj,¶ëucH°L°VË¤y÷ÏÖBØüêm¾:Uçd%6ù#HãÄ dO§Ç¾}µÊS%¡$ª1O\©)rc¤	î§Rê£'#ãUrðl ÚuÐÖj+,ñZ'ªiU%Tt'Ô=yÉ¼)Ç>ú×¨î¦ûb¶ÔRÓJµð¢Ç;JÄeCá¶°`1Ú1çKìÔõ5wÊºz§Xª'å~ 2Ã" 1Éã0·X)g¦qA%M¾YdZNWqxÔFãdÉB|ÿ â.ê-õòDÍ²#Ûd1n+À q«óY¾­5÷§* ^£¡E©aËopÍ'$óruNµY**¨i(äs*¢£3¥ÈWwýdûiÿ D-¦nVë\)K¸HãW	ÈG<dÇñãR¤Õ&exg{%­®ïD0Ì]À+øíßP©æ·SÝdªFàªWeT2	G9Ïq 8øãÏ:´W---¶²<=dõ*KmBÑwI,¸àÉúy9 Õ~ºåMUeE14ÔÅD®¬¦Xl¬G$í×ã'ênÎÍJÓ'ÐU\!­©6øîÒÍr*wfB¤ìçAÏ¤áöÔþÛoçwªi")<S«n-Ë<}ÉÏØð8Öùo4õ¥ÍUÉ
	;226Óús´gn3Îìie®= ¬VU=Fp7)-ÀTç>}íK%=É§Árèú¹.ëLðÓG)©¢Êâ&6ÜsÇ8bwgÑb¢jËÅÎõHrT°\HØÜÄ/møÏxÒÎx­vºSËÍr%h6¦Bþ@UÂ ~®3¦Uûd6¸)yãYUj¤ERÇnã>$þ5¤zM³&²ÉAvSú¦ãH×§¥û0Ï%-IÅ8<OÖøV|daó¦5Kf±ßÞÔñÔ5ÆcH£íyF+¸ñÎªrSMQ=ttèÕT43<Tù çÇ¸!ýôÚ{Ãçiª*;RÄ*án9
\~9Î¡JÙ¶\	ãQ¾¿VM5íñÁ=J1©Ø=­ÞÉýoUÿ ´}ü:¾VLõÂFD*ä£Ò7InIç¥ß3Y,3êóPÀ°;dL`´d7%vúAþþu;§!´ÔMcüÌR½RÆñl!j1XË ä/s,IÛÂþu1w2'8ð×gÿ Bt¥é»mdËrÈñU;X¨ýÀl}À×ÑÇ4{©énÊmÄ6O·ê>3§ôâ2çp¸üMìËS$ßË#c8æÜwsúæÀükÍ'eïwåØZtsHW* m$sÇÙÉ;('''Ùv·ÖZ¥©¤¦@h <}Î>=?[:N²H¦¦¬¶¥DÇpÈ*gÜ¥0Ø$O8Õ§*Äp¯f¢FÙ ¦®A÷ã9Ï8×¦Ù,¢µ)'íu¥¨<QSÆÂXÔá[8Ú¿«8$ò}¹ägO'$¾Qé»SÇKtj°°Çd0;±uÜpÜç^ñæ¡íô»ÕUÍZnÏ "çFóûzßNTÓ[w#Ú¦¦ÝQB¸9Ï× <)¹ÈÁç_9|q¨¬¾&Ed¡S¨mtåpTÆþ~äÿ ¦¯Ú«1gIÕQîÃ½ôÿ Â[<r®*««ê29ÌOú(ë¯BÖÓCGTtË¶
xÖì¨6¯ýk}vô¨óãÊ
58:Æ}±­ã>5¨ó©4ÑåöÕÑGC
À:¥L
A£é+«#ÆÔNÙ×F°5Xä
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4h\g]ÊuÛZ¿¨kS¦"¸Åç$Nã«5rd¤«ªÑìi2ñD}gA:ãÎ¨z Ñ£F°u`è4jÀÕ½µ®·#?j|TÐ|hÐt|uìçÇ>ë7`ËSK$Íÿ «Ç Ïåg_[Î®ð0À-ô°ä }ÿ Ó_2¶in?¡»Ó¶Ù­[ðy¹iÈû¯xøKrþoð·¥®F^ëTZi>[¶|ä~ãVìñ¿I1ò§n8àGÂKI:WO-]J´¥>Q3µ?üF8ÃÇÕÇí©;QJïº\ 	È\}¾Ú*EI_·ãWãÉÅ»BÅµÒ­Tõq¨ïÈ /îª0ÛÆÔíiR?¥sçÿ 8¡½FîxãóùÒ»ÔiOl­ gw1 qÀÕ'×^<ÝLóÎ»­+x®¢P%¤í,a¾¬ð0â x×A`¸_.>ÏÊ¬O £d£k²2nËzNÆçüÜxÕËâe:ßºm´oØ&Zd¸Uür8F uDÑÛ!¥J+%,¢Q82K;Ã
Î|ËqdO}FÛWb¼TÝ%G
ª6®yLªÐ1HP`÷¬Ù(nW[4²-zÒA¤O)¼î*ÿ æØHåqÉÕ¦õB-´iÓ´Ç²ªuÞs%¹°3ä¬yÎË$â+¬ªÑÐÂ²Ô*peßÕ¼>í®¤ÄúAÎ3Æ³LìÕ$OpÓæz*V¨44Óg4Òzn6©#$í\
:¶Ö@*¸(mðOYT8 $2yÊ¶9íöGvU¯éé
Ùé)-¯F°Éó
ÒU ÎN?Ê'ë)cáo¦¬sUAN¥åÌ"â3Î7d{}ó_uôcqmóòOéÊ­7zÚ´ÄKC1pPÛã>ÎOØj5¦s_}ª©ªzÈczB°:2¸_X~âÒ9ã8Ús4¶åsÞjn4ÔéOS´söÅ[
ÞåG <¯q½×3Ë§¨ vìVASr ±áàIµu
-ðh²¥û^«¢ëzìOGOP&ÿ |Hã>uÊÛWCmºÖ=*ê!Å$UÞGlçÃ«)>sçÆ©[®Uvºeªvvnq±27Õ¸6dòO:éjhíôÝ×Y
M9QNµ1rAØHcõ¤¢6qL¤åáî55ÕVó,7Ê¡¨ÂÕ1¹ 2+`?¶â¸ÀUûÕbÅ`©¾]§
%NÏ()#1Ô[hôN×\©&¯ì®w§¦óeP² fÙ7¬á¼î:òþ½©j\=Úªï¼¥4
bP0õçò51rIú\¡R,? jwÅmÊª8ãëÖcÜ­"0ÅØf#òÜy:ûsáÓ\jíuÔTÝº¹Úp7*@#ÇcÆ¼ËørøLÝùEjæ,öä° Ê ;ÜäÓz æ¥c1HñËr<ûw¥Í5*PÛÛ~O7øYGR´ÓUÓ¯n£pÁøET
mÜîÛcN¼Î¢àQ þo_SoVjJX Æ6G'À¶÷ÕÏ­:nï?V×ßm÷dzuRO0ÈsÁOr<z²8ãT:¥§¨¶Ýnm±pd¼&BT¢w Vàg\óW#ÜÑ¸Ãv;ù"ÞÒ!%% 1ÒªËýDÜò²»cü¤9ã\ìÖº:»åUå_4pF»,wLR11ÿ Q	$¶ì»9ÈÔ¥mÚ¯¨í[Op¢§¥f§¥d¹Z ¦ñþlrÞ¦ÀÓ}î¦Ç^ÐTZR/´Òlf	#2©Vqµ@Q¿V>uU¨Ýêe+,ÑKÒ½¦
6¢A¶´j­ý1ô<gß[u«zºÙ$¢@`BÄPo;nò	>3¡**ëMÚùDÉEJ%ed¶¨ d¸?})¼^åiémöÕ¦§ã1ÀYÿ ·ïÛo¾²ÚäuâË®ÿ bEQ«¨ùhhþJy÷¡(É»¸,q£<ò56ÿ üÎ?©­è§sØþ««¬ÓÁ^U½ góTÅÍ!¨»C7%b#ì¾äR¿YPO#\~3®µ+Éà²¦yA ìS»iÜÿ MÈúx>9·	Ñ§#s\UVÅ5®W¤¨5u,°S/«n3± ýG8Æ¥ô_òêhh8g©ÜÂæ#ý@À!Û÷Æï!éë%ÊkØ¡¦â!Ý$,H©ß<þ¯Hã5tê+¥·ÚãYk6)êncaÜqç$Æs´q¨É?-¹9*,ýCV)#T¬H® ³gÒÿ ðcÏ:ó.½«7¢®(©´l X°çlÁûãWÊxMcÔÃOTÓ¬qG2
Å¥Ü Ùà1ÃÁQúÚÍ_
4
PÒB_ÔQAßÏ ÷mdÛO§5±§à¤XiíCu³ÉO<Û«©dÜª{aÈG.d9<yãQz~ºªÕz-njJ:Ê¨ÑÍ+;9k)F®Ø%@ ûiÃÉéÍ×ÔA	ùB[låÙNÉ9_Zu-"ÍWYOm$´ÔÕÊøÄ*ÀúàÁÀ]ÝÅÎÀûël}vliÇqdµÞ®}/CP&õ\°ÄõÏÛÅ@01lÏ ©Px»EÖÀfVÔ¦¨ß8 »áôç>G»|kËìÈ`E¨¦?ªä8Ú«}DG·±ÎáìOZ²Ç%²Ì·)ë_äà)6ÍvÀÞp>Ã·$ñVLêÁRRê¸Ý`UWº=,kè\öçU´Ñô2³)R 0,uÏ¦¬7*Æóø6d$ÏËb¤6>Äs¨²-eÀ
öû þ¡÷$gEÝr¹Îí­ú8ów¥¹Üª¨?ÚKE%ê Y;ä »I©`XmÇÔpt=ë§È¿0\íH"UòñNôP§ui¤®áMSSs2A#t1)º¸	·H=²3¤rUSOÓÊµvþÁiI5i	2¶®<gÔ¾¯°Ç¶´£ÏKò^+'ô²9wN×1±\©%á!p|êµÉÅÙ`ZØªUc¦¥aM+¡¤O¯rúÇ°_°ÒÔúXªkQLåC(P°#j¦ \gÏ5ÖÝSÕÒR¥Ï&iC©C  ë\*ø$ñ¦õe×å®éLòñÊæ¹CCg`(#ÝWîu=(%í}î[æ©ìtìMEFËØF.ßmÈÌÌ¥²¼ÏC3Ö-u4ÓÍIOV8i§ú6ÎÒÄeH aXxÎ^«oµVÚ($*<Ô±	ÝÔé®áIÇ!rrß.¯¯¤àºk
>çFmÑ¨ÉÆÓ>*¾u\Ó78ÆÎÊÅæ;¶óUS»öWmèÒº @Ûá@G«Ï7{%æáIK~¼NR
(»L¢Må!,6Ûêc¼ÙÝß+ªªºp`¹Ûmì)çìÉo#m¥%öd 'Mìó´ô·Tà¡~fjuPd=ËïåÛ+éÆÍ³¥%ÿ %~YR;òÍM7e£I:HÁàãs«úz¸,JÕî»G±v ¤g1«g#Ò@ðO&¾Ø$§ê'¨§£¤¯¤ïv¥f3bgPÜ	^IM¨é
Æ¿I$)P¤;ãWUr?¨H2àcñ«I§Tg·)Zçä¯Éõ75Û°YI 
f	É	<`x îlð8Õ«¦èîqÏAWDòÔEUD_¶BIWÉL*Wm! æopSòµjI°«&æh<W9Óú*þJ«]ÂJY·ÄÑ±
QNÈªä¤w¶yÉÏßI.	v+­¯ju4}ºXáX§¡sSaý@dL}Dø#ØjûAÑ|9º	)jè!Ü²Ü¿¡¿Vrüg:£ÁTkiÚ²ª~Ýo¥:V@7ù`pm<«½GmxlôqUG´ë+É4¿QPnôÙ#8üjåFRö³êmÕTwzê;âUùI},ò}õÂÉWb
RÒ[+fHw£@S+¼6âK"w¤÷×ZZÈ©ìÖÚiª
Ztq=TJàW=Æ«}·¯çP+ê)aªá`|íéûI
¹§hòÁKÇ>ÅO
RÙ¬d¶»%ÔCpù5¥¢ÛJÊûvË] ;<}×Î.©5ÒD¸$©"HLc¸8FÁ^r»rO³ê#P¬÷jùjélß-4ÑLäWÈÞ»ää
ÅGVÊþ¤½Û¾}@Í7lwUpÍÁlTþQ5*5dÊJ	ZErµM[,l$*L­lÅ°ÀX}ñ¨ÔÍòÂ97Ë3Ã"m=Ã8ÝTHØÏmÔMi¬Xhb¥©0aJIVB¬Å°@e#Óìk[M¶8é)#¬ïIQVUé={oÃÙÁ_ôÖ{iÃ$Ü=èË=
GYqzgVÕËûpÛU>·§;E<µ\Ë»P·oà<}ÇÜêù%$ö^¬Q¤lEy¤a×¶>¡´)<ùãTúd"¥¥f¥J°pØS*È'«dU=.G<²¡³RV] ¶,îÙ¦8ÄxWÚA9ÇÛû
Z­ÑUYêM°Ó%uDP¬4qL
ûÑçUÞ¹­Ë]
4F¦ALÄí*Ñb§w;zsýôæÚï[,´*ç/E,(D±Q|ú¶ãp#È\~­Z
èÃ:Èå+èØÑÍuêË©j(*éR8ÁB×8£<ÄrH<*¦
WÕöÁk¢åÝÞË(Á7î(s\d{MoUÓÝEï«tw¦AZ©f`T®ð£'Ô`x-×ãÉ©fµôÕª« ñTæ!ÌwÂíS¾£êóÆµXÑÁ-laqí¾üj¯ýa¸Ã!÷Vø¬X `<c'øüiIG¥­°eYG÷ @ ùúx$¬et	@iicZ¹%b®ÎôáùÚ"»÷(ÞÚ©Rõ ÔUÀk`r0[+ÉçHÍ9peM*}±FQÊµËuÁ¡´´!¥F=É¸1I3´ý8Æ'^¹òsÖS-{VU5#D$»h¨(À>®@lï¯(´ÓÓLÊ·jÂÒ£Ø®ë!l
¬}#j«Éç8×£ô¥®ëQÕT5,Ë:Ï(íÇ!»®s7Ö-É®ÇÉ'¿Ü-vÚ¦gZÌD1ÎÖÚH~ÃÒüãN|ëÏ>S¥ïãÒ3T-²9+0ãyÃ ~Ü¾?}zoÆ«Õk©¶ÓÃÔMH;²;n	¬¶«úÙÂIáPdyÕsø5³³©êChè cú°{ÛØk¯TYâëu+J*ô)ÏÛFÖqÆ·f~u°Ö Æ²9ñ«$VFñ®NPEÎ¢SFYÑÃ·Æ¢t´ ñ©£\`\kªgc­R¶m£F
4£F hÑ£@4hÐ4£F hÑ£@4hÐ4¬k:4J¤Î×Ä9!GújÁ(ãJë#óª³¯O*erUÃ5«r8ÔªÎIÔRp5=¼r´k£Yó¬hhÁÖthX3£#F ëSäë}h|4h½Ugÿ Ó7;âºáÈ8Ãè?ÙÕSø'ê)n*zf©*ºv¶JPêX?X¦¯Àr	ØëÆº	 è?âêçmd4ô=YGó**4ÇÔr<yY>ãóªÝIZÈo>¬Ò)àóéf¼ùßÅñ¶ÐÇ.ê«è-Ï>ÃöÎºÜbQNÒ)fV85Æº1=Ú6wÌ*ó`)ÚÇnÌÿ O#ö:ÜñcÃ6¨
øo¾ßÈÉ"4l.B=ÃvÜú±ûqûéÊ+2Ê 
¡÷Ué~^ãrcQ¶VPÃo¥pN?aªËÁ×)NÙD·Ò=GR"ÖGKUÙ#
¸Ïà6òNª¿#¨§·TOBZÝ^#b>U^AÏ»¸Õç¤§¦ÕiºT#ÿ ¹Ô</$ÁÞÜ08ËF1ãHî°<Ý5_JÑ	°ÉK9¿¦åXç(¥Iã®j[y=øek-?ÐÏuºG´ÒÌÒ
ø5D¢¶Xÿ Ã=ÛMÕWjHZj+l.Y²È@wsÚ¯Ô»²yÎ52ºv³3;Â«$4M!Bë*©rcò ¢ÇvN¡Cs§¤þv¢j½ }!FÜÊØÜoH;rvfàTw$D^ën¸££C_H¢³ÀÛe%2nð;-çqûë¾¡fke5$3¬ë
QU;£s6X
«w®ÕõMµn)lÜÖÈ]£v÷ÒÍåH#Áñ§Öõ¦§©©¹Våá©@²´4ë6àÊ66Å,r2Ë[>Ú«KÁ\y7R~{4¤¤¨ªJÈ©îK5D²1yÏ¾eçêÆv3ýÔÎ¨£ê	>R­RæuIj.ì¬£²0ÀeJpó¤õÔÔ4ðAq®6©A<u AÓ¹ò§9<ä(ÛuÚjÊª9*ÜÁßô³@½ÈsîtoD'Ë_öó:Ü+n4èàS58íQ#Mì,> lqç×^£¶­"Mo¢ßM	1wê§?:%BIRQ=y]Ç8Éñ®
eºAÞ½ÞÞÐJa°&t`§ny'$ø8Ôw¡"G¤­8òªËË#ÅóàîòùÊ
UÙ¢JN«q¤oY,Õµõc¥p
C÷NÓV<[^gÔöÙ«,pC<.CÅ³%È ?¾½rÝh¿«Ú+MAMòÓw| ÆI¡Á!Ç>\êUË§#N¨¦'gÙbW^ËÊ»²2§Øp\5TågD´ø³ÆP=«ú+ßOÀm5fÜm¨jÒòÂ©#Ä
³8ÀpËõgrcß_ÒuOÄîêî´7Ûí
Ê:5=ÙÒb§¸­pF½J»¨:w»ÓµÏSUÓt2î(a.Hçic#Vº
Î§kÊ:ÊiL¨Õ2e = í8ÎA'*s­£©ry9Y`£t×¶üø£Ó,HÐÓÛú¢õ4G£8gª"Aôù)¾ Ú«éº®Hj¤E¡%=,P´ª
úWÆL¸×ÉµqÝþuÅ³©zvfadÎ¤«ãl±1Haù:ûÔYþ't£ª:}^Xã¨1(/ã-ÉVÆº¸´y=M&w||MH)îÑ¥5²â÷H¥7n¥]ô"8
´óWvëÎ{¥Üê®Á`Dc,1KDÛ}AÌ8P¸+´Õt]l¾Ge5B¶¤.[2wõ)
Wi*G:M{³ÖOE¢ËPóD £êIÛÁÀRËëä0'Ô| ké>OfX­ZðD~KÛ¥º&ÙÅ\´H$îFLkÿ ¤)¹}Ju&ÑjÓÿ ¸Y¢ßÞQOÊÈîc.w;±8  aµLWIbn·*jéOOØcÎ^'r3mÄ 0C7<ÒÞ±ë_AXbYÞ[ErßöåÞ\bYN=*árãõHãURWE£¶÷ÉÐ:ôõ¢+ÇZÜOË³Ë «©rp0cR÷ÄiyWéþ&ü7¬é(nPb®G1Ë3¬3úv+«ô®ÜV>N¼FûIÕ]mq7ËåcHEfÂªð¯Ð¹8 cuXêºYª6TÒI$Ý1ûÏãVXâÕ6rËñF&§{õð·=Öd¥jªñ,,bFä	Ç§:ïgI*Un´õõu\ÓBI§Orp
98>uÐµW-©^²[$¼+Ç#	(¤ç Ï dæ3é 3¯¡¬3[çuZV/Ë)I±ÁãnßOÓÎïã\Ùq¼nîhu°ÖÁÉbíðþÛ{µAíÛ©Õ§]e'Ü¿¿§óª'Å:úø_x«JõÒ­]µ?¬à»àú§#Vyn-=5æ&¶ìT2T×ô(#Á<ïïª?ÆêÈ>²+È©iJ]¶e>IÎÏq¢Ñ9ã:åä¯tÍLqGGl¨
ÝÑîä,Ëêà¶ÛD=e5Áv¹e14Óvâ#$0l Àa8ÇØÙ:fößèº(éJÔ\+¹²L!_¨öÖ+h`±W
ª¨Þ>í}{LÎål³å¼lÓÏ:+´=ãñØÇ,3].t·±A$r¼2¸A)ÃÈõ~ÙÇêÀÆ³h½ÔÛ-ñÂ K!Q¸¦Ö~ÚÊ}cxüOÛ[NõW
:«sS%¢¢¡HÐ«NHPå²ÙE+àÌNrW:G
MÂ¨µM¶h);j¢Ý±Y±!Ç* äÉÏChÎXÝðZly®Q\:Q4sÉVÓzb¬A\8¹qäSöÖ:MÙ`®izHØçEg*å;v
Wf¦+d1:Ï-4ó÷©æ6²*±J@âNUp§Û?a®ï¦%ÆªÚèÌR%»ì¥Ã3;¾ûGÛRíû÷¡ÿ ÂÇi¸ÒÔO}M<}¥M*FÑÆÑ¾æ8cí%ÏÒÔ57¨(æ¯´ÓÊ)iÖ^Ð¤Pñ3a³%¸ôTûüõ©®;´]¶Ha@;»å\ñûjE]lUUU6Z¨U%#fÀ9?¦°8Ñ¹>Q´v$­ö1®­¸ÑÒ1êZ#Á@`â=®y2U²s®vßz²5m};Ä;¤!Ê¹Cåsp<îQÕm ªg¯R«<K@äGU>=É÷®_­Zn?Ìè¶;pµÆàÅv¸ gvìø:FL´RI¾	µwvIéíö:ÉáUIé#©$Ë.ÃÁ\±À
w jTmoíÒM_Q!aìÎÊK·«$¶[18ÉÆ¤ôý×Ak¸Ü+QÌJâI¼ÛXð=CqËsÀÒÛâ×$7©ì±'I# ÒlÇ*ÍîÀ\y:/wf3j.â-­j´ê(k c0
C,L¸/aFÃÀû4·¬ß/%<ß)MO;lcPÒJØúU]IÜØÎWüÇJî¸¹UPÏKHÉ4ÕhápT*íñð¤¶}Ï`¥+@¯ÊÀºa"¬jK¨
]¹Ýì~ÞF«'î4Åî¶t4TEnÌv±<¢Eîè§¿§Ã9ämWW5QÐµ\5PGÏü8$ñö	Ü@'\/\Og±*ê))foÀÃq>Äã@Ç$®»­bÝíÖª³#OOózEÕ½@Ú­mW9Î4iòW4øJ=«:qîu5WH-Ï<ÕTq2)«A*¦	}û½ÙUK<.µÕLl3[ë-ß=óDùT&#vò9ãLe¢XzN¹,sFÒÆ!3ºbÙÂF¨}ÌW9ÆïÆõrÉ6ô ß5a§Eáð1#?Ò2£çkäëIÉÒ2:{WlKÔ6¦j
¨¦ÄÊîNAAbìáXm
2pNÒ@\éuÚ®®¶Å]w¹2Rº»D H§
2ËÎ?
ö´XãÖUÝo2*Z-2IyüÎ«×*ë¤Q¥2ÓxÌ(bÊ(XÎÖ\mUÊõçêrN1XçHeCR* +s§¨aLÓÃÅYªecµBÈÈíçÇÏOÏ[ÓÕU³S¬°Fôe^HÀ.Û1çÈ$ðO#¾¢MYoåGK[ÖÆîªÛ}NEr¬
¬Øð>úÍ^H©*÷ö÷ GLÀ!¾JÏäèwG--ÊÞÖón«Úc<³E#¸F?ÓdÀÃ67gÊ2çÆ¦u%D²bÍJUb¬-¾~Þü¨`Kó»$¶¢ô²é-¦¦o·Í*D,eÜÒ!mmÄ7)
 :±^-¶úzºYm$¢9*çh àqVÜÀäí^9Õç2HÇ#L]tÄM'b¡¤@P¢]ãØý 2 ?W¿ùu-}CQÕU]ÒiÂ¨ÔaX) ¯ßPlÏ	ªn¸ëh*' (âQÙô=óÎuÖ;ý;:Ûà¦·ÐSHÛÄm²<>åòN³ºãÉ¤J­?&ñ×EOzd©k
²H î|# yqBëÊAÓÍ½{g2Æ§lñ#ü1Æï¨éGOÏKm·êÌóÖFã+4±Â§*2]½Ï<øÒ~ ¨©¹÷hé*${Kn¦Þ­&ÿ (ÙÉaHÿ >Ú«	G*Ú>¶vêà¦¥R\îJ°Ò2Çéä§ün|¯C·Ú¨¥§fÝh	zZ~ÙE]øç@ÿ A;¶1ª/OµÔ=êx;ò@í<{}TòU(sC aí¥ïÒtïÃ zTå)ö!Q*¢î
Är¼zº0ôq~%{x|#Æ>9õ¥__õÄÓ0·A.â«éTÈàqQö ãÎ§tÏN|­TÖÓ¯fCÚJ4ÌPG¤Ý´øqª¿Ãë,jå.ôTñ'õå#ÈÎ[p_<kÓ.2^»·y¤jÅ	H¦ ãj.N=òp} ú°<dês=ª?Ã0©KÔ®ÿ ØIv¾KIcçt¥»lÏÜe!Tprm ·H¶¢ëPÉtÔ¸EG*¹,BÆ¡A)Ø¾[Á:¼Zi ¯u¶Ûhg¢%Gîd8?H½(Àê\sçGÈRÁUOT¬dP¤³ç%>¬ó¸ú³í¬\â£Ú#õ<­I<;(?4´éÈá0ôÇ¹³ß^]p=	d©ßIß¨^Ï·´Ã Ï*Ä»¼ãöÕrk­GÛá¨Ø'© ü õL¼´ÎW%#'#õãVªÞ¤¹çQ]·öÝ1$ñö¢HHÚ¢<\³
Þ£Æ­JÌuSk~%K­nõrÅ]qÕÝ*ê¶CemûÒ§Ø`_T|(é8ú' ¨,A@¨Pg¬lçtÏßéÛ^9ð¥«ú×ýµ¯§uµYAn
ó/ÓÇ
Äû{}ÌN~úìÅ,ð¦Ô²6º1£F²¾u­rAló®±G­S©p&u&gHCÒ¦1¨q`¦®=µ4y9òÙÕ²5±ÄÃF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 5WsOÔy×¡|n_­L)ÀÒÆ_¸ÓÊô<iDèCyé¬Ú=½<íÇï¬kcçZTë
`ë:4$ÆgF¬Zäë}`ê(hÐ5	`ëÆ?ZI­}3ñÙ+zråöQæ`F ?íkÙô®ú~>©èËÇNÈ5ô­><Æý 5YLôE|½?IT'I2]8 çÇÇL>Òw¯h
» O9ÿ ¦¼KøE¿5ÏáR[k§«íuml©VÓh×)~W'Ý½¾³cGµÔí
`ûkX;\\{rPShÓFF<sÎ¸UÓ÷eÜ	ãÛ#@ ¥Höí! Ûûk1sg?]òEíçBz	¦ß
XÂH61Éüþy}Þ¶gêkñ ®Ló¦âKzÔ+`w={/Q[ÕuPGÅP¯¨ªOGØö#TU¶5d&YjþvHÄ°cd¥AÂ ÈKyg<ëIß'Ðé2ã7vÙæß%ßéïCR¸\V%ðO$1<<kÖnåUîhÅTË·çv#ú®?Hpnxçn5?©!¸ÑÇOr$\SÇ1H2eîR1½[¶¤ÏPkknu-Ö±c§ib í5*fÝe
°,Jç¬·T©¢Æ²G|E]MO?WÒ|ËÔVÜ»ª´ÎÉJ\nTÃ­6:j´OElá@'§f¯äÂ§*©2ÿ 6°9##ÕÞ[õU1Zæiëk,jiâvðÂ@¡H `ûãIêéìÉk§§­yçe+QEª¥{{äÞ¦çtlxT×<ÚÖ¬y%¤¨J*°ÒÆµ3ÓÌÊ«.æ9är¹}õ6ã³M4÷*Ún© ÄÐ2¶0Jví?uçQÖzê¤Äl0È°1Dc·­"µöäd6<ë{MÂõ-Ú¿ç¬Rú¸fªÑ¼3µÆí©`ÝÊ°ÔG®JNqî=¢ÍC=%D3S-%e$²<	ÈË5AT#ÔøÀ%QíéÏ¾^.UÍUþåMN#:Ykc­îI°U(à² ªst¶ÛqºÛWT°QF±ÉòIÚ0<L-¸o_ÔA9r6J«e\ëMªh¤§/RÑO9}<.}L¨7däöòº«6Å6×¿ÉòMEü£¾SüIËÈ	ÊF¥aß¹¿¦¸ò£VÉ¿ö¡/%%
,1È#PcË»À~Gu­ª¨¡Zèn¢ ÁòÑÓÌOn`	%Qõ^O«di¿G½²ÝHh!%Ô3ÄÍLëq±ÿ ¦³eQò0½ôµõhx4²3¸úm¿úÎÞ¢¹ò£8Áð5J¸|.¤[Ý3E^OèÁ_,¤0
ÊÏ«êÝàjënª­º¥á¡£·8a,ê!_ÕÚ zÕ;<:oYIÖ7¸%DôtÒ¬DRs,¿ðÊ:ÑE4ÙÁëdÅ=·Áâ7~¥¨³SPOMe%^
	ÜP@H
wð¡ ï$gÓ_úÒùð+©nZvN¢éi*ÏJéä9V#\9ô·¾:õ£¸tÝmeE(pñ&Ød"´¡È#ÒA]ÛÉm*¸ôMÿ \k¬lc¥©Q'ÉÏ9¬ ìpÙÀU8SÈãÏ¥HÛU©û×?òz¥¦®ÁÖg«z6÷Â	UH1¦uÆ2§ÈÊ·ÛU[·I](íO5%Y¬¤g¥iZ©ËDP
Ã ,sç^?_ð²å`å®ç[k¯µ11º¨³!]Çê]Å.·éåÎ#µuU5;0\c1Õ'>hÇ«8àlûëW]4yðÑgÃRÜ¿ÁmµôüPÒAüå¨¸JÕ4õ%Æ qÂg8
!¼ô_KV_.}W_LîV¨4ÓÖ>úT cÒ<8Ç°8Sãn§]¾>[«©
-_OÖÙ¿ª%YU½ ¤`(] îÛÆA*uç×+ÇYÞe¯CUMFHaÊL¢5ÜÛC0ÛaTÈÕ$vvã©Ç­ºÖ+-ÕBª+}2òM ÁúFô¶õ?Î\àé"UGeid§ìÇ9bG¹ÉçWÞ°Aq¾ÓÚîä°I
<sÛ×
ê`X7,2Ã<Àu[j·ÑÁs´Þ;ªðEö«o´§\ãlOÅnìõÆ½6¹ø<J¯ ,²WTTCk¯¥Fº°;Xä0ääzÇü?_¬´UËêbkh.Ì!âE
¤+Á^yÓû¤Þúv­¨U)ãZfi~  eb§ÁÇÒ?J@ÕvïÐrÖÔPÉ^UQ*F±Hé²6 åO'B\}MÒoM{MÕõ¾)ûTTs_kã&aÚ
Úîn8cáã
¾®uÂÙE%îî÷~©¨.Kdv^ÚÅ3bBý'?r|¶¬ô½9Ó)ÐZç	IKKF­09YF`
¼yÑ
5JÔS^ZEªªi6í&ÇÕIÇUº|ÇÍ¹ä7ºNhzcOFFÑ´QAµóÐ9Ü)'ß?¾£Ëhz¢­ÈóBÝ¨aUUW¸¿ªø$}D.}µa¶ÒÓ-4ðWÀ¨ÕÕTXÆ;FyÏ¤í>}õÓ¤VÝª¥§Hcí	]§Xóõ{}µzçoÁY©¶ú¨äÒRvÃT½QÜOqýxÉá¾ÚIr·[¥VÛd¨à¦
,îæE*ÌWèË1;HÇÜ)ÏzöÕÛq<Ää &\)VPqôN8úC$I5cÇÉÖú£eÞ#t
ãöõg¶5
´©Æ±Í'e#©;Gf*¬jÉ¡0+ÜJw$]§êý* o1¨-rÕÝ­%T
´E#,p
ÿ AUÚYA,H-Èñ«Ý-j©Mfõq'`bRÀØ?J·9o¨À¯Þ¨*iêéªã¤Óï=Â Y$î ±8ã?f#õ
LdüfÂ·×ÁªF·+½CÚ»_'Lí$S+v³%\çó©×I»³Cs©·4*¥ µTaaÞ m±ã\ºzI¢¤­tõÔµ4»)Á]¨C¹;à¹G MêKµ¾hXWT¬1SíÌ´ì¹PªfÁ'àÔ¶×+²#â·y#
¯¦qhzékçrÄ%50ebpT`y<¶[ÇICOQC²	MdO#MR«o"*¥±9OH çí«]KS[-ÒIMZ)Þ¾7VUUe'eÆKgÆ¡KzìÃ)jHê&4¬ 2ÈQØîÈ}[ÈS8æ'UN»5ÉSå]®õUÉW!ÄMªÉGãÛRß~q¨ýC!¥ZKA·SÂOqäF*q"îf\àýµÖ[½¾±r0ÉÝO¡läî÷Æ¡ÆµØ¡¢×3FTÊ6Æ+3}M ÊùÔÅ¯$åT¶§º ¶­D
R(0.ìÃ©²[#iôã1ê;e;oµW\bW¢§IåmÛá	µÐ¡FXÃ÷ÔÛ­õîtõ§E Ä«¤f0 2zF1¸ð<c!éúòõW+ýÇæ%)Þ
1ó$E-Jî.å'brßGË³|Þ|§ÊQGµ>k{UU@$á3¼'°ú²Oê,WÁÖ¶
Z9ªÞÙ¬¬!!¦1!bÊXïõãààqW`¸WVY×¥h)ÐÒÈÊgJÉ0P¥÷°ý<IÀ8Õ¿¤nt¯gv® {´ðÄW´ÀA|s¤WdZqjçc©:}íðÅA\ôU+O¾Lf1é åF(ÆrNéJa«÷q§v¶Hglìjì,sÐ 9Ï¾«×«¿u5Å)Òäy¦©Rî¨Yö ¬{kê¿a¨ýmÏ%Ö»KS¬Q8ä0Ë	á}XÆ¬åTH©Î6ÿ RUmÎ®¢×cl[Ã ÆîÙ,XpÈsäq­,15ª«åªÄÒÃ1±QÜc$o!¸ÆÆÎÓ|êÑEk¥^©¦¥4R,`ÉgiãÏ {ûê¹o µ¹#åä°É*íCÛ&4Qà°Qû±ÈÕ)E}ÎÑÞ
vMmC-\ÑLüÍ¾p0eÜ=9ã#ßëkièÒ­avÛ¹&vì¬1¥6ä1ºR÷d¥­g04f`cJ2¸d
[9/9_lyÓêK}Ò²¾Ôj$m=P§O îu±Ï²ú
9<ãH«2Ë%¹¥Ò$XXÐÕÍb½V»U2£Ä$`BãÎ\ñãNÞh.q-ªé"P¤×,áBïÁÎ5Ë­m4¿8²ÐIÜ³d
¨<d.7Arp[8}d²Ç|*TÐÕB çlÃ,pØ|~u-ËäAKu
ÌZ¤¥*bJ¢$RÁdmÃp¡F<ÀÚtüWIèª*LdFí1z>àä¯° cX² ©¼MYI2ÕÝ&,ÑËPÄ¤?QR8$  _kUp¦£>Uj#¹¾îä3(.Jõ6pÕeÏ¹Â;[BªÈªÑÙ*+(	Rzc} ¨}M·nu";(n¢½²4QU£,(	â6%SÒ}(N}ãX«8m4¤JµaBÒº		üËµ·gpáxÕ¦ÙCy«mõrÅRÔðG<Òa\öîËsöãoºªIdÊÓR¾3Eu%UÉ^WªIMVàøy*\µP/qSº.êË/HÝ.&HæJú<ãX¾C¤gðun¨?ô}UÚa¶0I¶Æïèô¨;qóy7Lí[ËÇ2¦dXl# ¤þ5¬¦à1Æ³ÊqLgÐÒÙEm-ßO)MQP»-!,£FXmà`{jÇEÔ6ô®jz)e®¨@~bl i	<¶}#ì]¬uéQETRÖÄJf2ª_êLãÈ<ñã[ÿ 6µRT»Ýh~a$LÔ«!$§§ÆsãñªÊWõ3«(Å5ûDsÝeµØîw	R³hõ´Y÷®|ägÆ05çÓõ½Ù*{fq£Ü«ìAï«Ää¼ÔÓÓ!¤½$ÏpÃ</qýÿ . ×¡|+¤éë7LÓ^+hÖjV1¼³Óù ´&<ð¬ î§òsjç}
þìóNèëåÖHïMq .ÕfècòNÒ0Ò§-ÀÆ·¹¥WZõ-ÃWSóadòióíµGÔtç®ºÒåg·£UuEÖC54qëR> }r¶ð<kÖþ|= zm¾súýAqU{A9e0OùTòO¹ç[Båg«Ë²>;ò[ºZÇné °ZÑ-Ïõ1ÎYÛþ&>¬{xÓ`ócYq®ÕÁÁÒ óí­ÔxãZtN}¤³táBX`i$c5Â<tÚ!v|	±áF¦¨ôr@5ßW<»a£F
4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@ÒA8ÖúÁñ \1]Ty%«Nua© QW¨ÏKM1D ãZï2È\µõ1ÊÑ¦
çFªh4hÑ ÖgF¬9÷Ù<hoüt'Tè`ðq¬ãV©åøyüI^`VÝÕï¦x¶22ÙIÛ ÿ ké©Qj`ä0¤r=Ç¾¾Sþ0©'¤¶ô·VÑgµÖÎ=½.?oAÜëê^ºS_,TWz"
=l	4yöÁÿ »SóG¯Ý²AKPéTÈ@Ü#Æ¥ÍÀÜ>¬ñÎõ,íM@µÌrÓÈ$UG
\gI'ÁÈÏß2m³Òî¡ÐF=µ©Àù¦B®:¨L±åÚ'Ã¢ÿ ÔkÅ¾%ÔUQL´7ct¾9!o©$Á67}½;VÇIP»^¨ú0¿«9þÃ:óÏ7G]i¯ »ª2Q×vEbQ±»Ï$s¬2«èôÿ 
e[<ßvêÂH#GE#¿x4ÝÜïWô¨R}9ÛÎ¢­¢ªzÈé¨e:ö¨÷TWåpÃÙ°pÀ8$êåð**,µè©Zû}OËÈcFULD0áÎÐï$ùÓNµéº3%Ee<wY%h¶øe*1ú¹ô×?§ýK³Þ«ÇÒ++­EêáÓ}>wéáq4ò3@« r¬ãÇ5ªú>Í"k%º¶¢	¥ IB úÑ[Ö2Ð¶xÎ[:¼|$	èë¯]Ñn3ïÈÀ±EúK}y.ßö±íª×Çzª9+"ùí¥È¦nËm5¤wý[³àì ùÔíJÎU¨Èó¸/VÚ¢ª*zKÃ¥<ALTáåX P¥¶®v²@b#'52ºãÔ¦ªãC$àÍ ëä`yê%Ê®¾áüÂªµéâIL2KÀÜ0ÒbpØ%AQ'Qn"Ïbªá<¶êS;Á ¢EeF_Y£1 rª¾æÓ[WÜ@ÒTÏ-55[UÕ¬¡c£Jb] OI$îlÎ®_¨^¶zJ£UÓE#­>_&¢EBªÀîõ*zòO¤äêc¢¨f%SGn§,ÓLùbýkÏ¥®NðH÷N¤µÁÓ°Ö¥;ÅCÓËq *Ñø°<¦Ôäucþ^7'ÙZº_k(º¥,ãU=lu UÍ$IÌkÜ«È¾OÛX»Û®«UED¹5uÌÏ%7dD¹Uúô¸?lñ«/Nµ$õæä`v¨Íka[CPvîùQÎ®öÕ1]dxÑãT¤¥T+á<ñì?|ê;dÏ^ðU/ýYz¬®±í¶ÚêÈd­¨{#ägf$oø ¦Ö«ìÌõ´pÅ©F.T DbPmÞ !x*~úmt«!p¹4wF%Æ^G.vãÁeõ)àÕO¢1ÞEM*K5d±¶)êmSsûöÎ5WpoØ¤¹CÉ®50SÁo¸Ë%òÊä+&Wyb2 9ÚIó¨µ;]·mÖÕòðK4aªt	zKa¸Ï¤ûé¡§¬ºz©ÙuºÈ¸íÖÒn7_>Àç:ÖñÓ¢©c¬¬éª8¢JõuÊP6dRxãÈö#:ÑBTèãõaîB*¾¯è¤E4ÔõfE	vvØ)BåØÉJ gÛTû¤¶ªk=Ñl³|¤51£¼óÓcP2Q9½'!Fâ3«RõwM]éåT³âRC-Êã%XnxÛ¶rÌÅW
0:©MrÓÅb´SË?t¤«IJ`¤ãÖ»6%³ÁöÆ«'&ÑÛ§T7r´VéXä¯©¡¤£ôéÚFdÚ múÃ íÎì¸Cf::È#"12H7pËòq¸.75Ù,PÔÔÝï2JÏBªS4¸awìEõ¹<r3q34G¯~Z:zjJE`nÛãeÜÄûë'g^(+±à:úzx¨b«Z3ºa°"A·s²áHôòLj)!:j¾Â°6ùª¥FÉPn(¸Æ 8Âßryà´ÓÔ%L
Î´ÌèóË¸ÈÓö*>¬òqãR¥¼CþÊ1ÀjéäõJÊÄ0aßZ×lâ§½mùYn´ÑPÖQPÒÖOYÚV^0«d·è qÎïÆ´ê©§¦·Â$¦¥ïÊe#¤VæûuüéÇM×ÛVÎÒ¥4CÂ© V1´¨ý_* ¸ÁW[Hû7`vÑN8ðNáÆO¶³vÑ¼?ÔrÛÑ§èDÒËzLÒDc"UU!JàúOçSvÑ|¢µMÙ§2ç*3Ê¨>UñÆ¶PÕlfª9VO[PÌPí$!QÉV$ø, ñ¨5OQs¬ZTÙOQOô 07`g>9Ú¸'ßD©r]ÊS']îÕÔ´ûBPÎíè©<ávó®%MÂª9hTÏ³çµVP= û³¶n®ÎÔ
1,#d]¢Î
©9nÎÛ]íB;eê8éÜÔ¤PjÊd®U<Ëc:AS+qe±Û"ÛnÕ5típ¢¨¯æ¥Ì©ÝUÚÔò¸ÇÎqÏGê8é.²F´q53¬=ê¸¥Ué@Ãþl`5Ð÷èMÍ^Y* :Dét2;>ÛX>ÚÔui7QRSTA5#É2oÃny7<ç { ~ÃUæ¬umT[£ºI-]Y)¡2,ÙPQ¯Ô|´ 	ÎIÁãR&-mX`îÈGrj¥ÞÒÇ9ñ¥½ù«,ò:C3H{íÚR/·Ýgky'M¬U\ÃGPO	R³«ÈÙ$äSé?q«Æï*O-åe¹ÔCGYQ¬,b©TeÂt@rw+ W>¦8­IBdêSÛ©t(ÕZ¡-,Ê$(qÇß;uë7U7TPÏ>õ¥«12Yós¦8Fþe»#TÈhßw§ï4ùfÚ'sÞËÃßê<êõ|ù2Ã'Ä%à¯ßª®óßic,F
sLÇú ¬>É¶?W:Úçc¯¼IOv©§!+UâÜ¸
ÄÎåçS¸Lª¯£¡·®]F«e=D)ô3c;ØqµcÎuÆ½ëì
©/UH;­L¬eX3ÛX6®O§ñªvé£­Ëln/ê+ot¼ðT1»Q¤mê]È%T±T\ yäêzÝ(íÔ_5ò´n­[4'ôÇ¨p	ÆÑËò¢mÂ¡cy¢Ùb§6O>4ö¦¢ã
Ø!ZÑÄuP´ÉoXp¡UIôäFNÞ4RB1qIùb	^¾êUkj#§ØÁ&ÊEU
Ì,AC´äúgÔ1½u²ÉN!¥®¦y?ªÂ~\!J à®a8Élé÷QGu÷5DÔI-ràGDÑµ1>¯R«t²ª¡&«y'¢c\0íõqäpÛSkÁºlåm¦¬±×I=UUÀL®Õô ääsçS^ãEÖU»[ÎÔ÷m9AÊr0Û¹öQ¥´Õ·[}=D5uah#vÖepaÆüËiÅÝÎÌ´µttTòiÊXF¹RÉÇÅ½ xuV|MW´GeÝG*G'ÎÕ@9g1fÁlp UÇ?æÏZ/ûÖUÉØyjí¡lvçÖ7Â s¦=Â'±ØìÕõICÿ P¢¸$ºÎ{yÃøÃ`gU^¯´VtÌ¶j¹Ð+\¥PÀy±R¸cÎAÔSäÍÎ0>?É
º®®ëP´¨Õ©)L]FC±Ëôâ=ÀíÃ`ãÛW?§å%#¦¨Ødì1
Ìwx!K<i]*ºÚtÔtTèî{q @;x]Í¹÷ük­Ú¾KP²Ûé»QP(=évÉºN@ +=ýõ&tØ¦î°\n±Ú-´ÈZJäfu`{mÈ' áNìi­´Câe47\­¦et²LòØ úà3ï¬PPiÖòÒÑÆM$MN¬¯4U õ7}^xÒ:øèêÙêêâhç­«HáurÎÈ²FD`ù?JN3u¤8óBIR}öY§»¨i÷÷0´äHÕÎ1¾¥Z­ÕÏo*'XéPg*\G ÀÚN>®AÇ° 	ëÔóUVTYìT´TS¡î=?x,Ï³,a³NWj.Ws%5M)Oôÿ .»bìÿ ^YAÆK1inÀØ1©WlK,£#ØEÊÁx§"©F|åyN$Bqeår Ü:6KU¶Ù$ï(V§rÙ$&ÞTçAç¥pPS\k©êÄiQ[;vB;Jª¯<~8×8ït7=BÕÓKUrÑÔÆA!øu
 .}%ÀÚÉ®zàêÉ&±§ÊURV[Ì+[RZ¥ªGf2ÙÆIíGúàxÃìu~¢y-Æy~r¦v©VbíHÿ §?æÜA d`éF¨ö6®ºÖE%uJ×ÜêåiäÒ<¦| 8Õ¾çxJ»]U¹È"A¸;nÜ(íÎ8%pO$êÑ¤¸1É¾U©EëºôÛO4"5&e¿©Dõÿ 2³¹~|JlPêÓPTOj#^Bp?©x>ÙÔ¾¥£¦«øöÉR©m« ,ä8$àmHé»u4Ö-
McÝ£©NäTçÑAb|Ã¶©)&íàT¬(©c£¶Ï+\îpÓÔ4¢%¦4o"@O u>N*5³ÕË])ÕÌôê@lÃÜ¡#êI"U$ÆSÉDõÂÇ)Ù#8Wo¤Ãáxó¥ém£¨VX­ÕPM3´³O$m*îôÇ±F3ÇþïçYî¤u(î£PÚç]MS%W¢¤83òTù?¾´ø|¯°Z)®H	-ºúAHÿ Ä9$ãÉ;|jÉIþËtý%Mþól.Y·¹ª8Ôú¤bNAú|gÆ¼öÕlºüoøþÿ 'ËÙèÛ¹\ tT°V"8ÞBí$y;Û[aÅ¹YæëõÞÂÍü3ô]Múá'ÄÎ¨NñîâÓ¦ºzZ`£À
Âÿ ÅÈ×Ñ-Ïs¤¦¦£¤11'ÑFFºm:ô£HðR¾_lÀÎ¶Öu°ÔÙ,Ùu"	ÇÒ(?¾QÃêjN|¹D(GÛM ®tÑ Æ¦*Î¬âælØxÖthÔ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4
xWVO¶°'KêPdê¶ÓÕ&Æ¡0Áñ¦µJ2F5`uSÙÃ.¸ÏëöÖíçX##¥Vk£F1£BCFÐ5oüu®N¶oüu® 9ÎgXÐ_âÈ·ïÊ}¥²,Pò?Ð¦Â?Q%ÓáM%¹åÍ]­4èË´xq÷SÇäcVy©£­§eV¦'Ã8Çï¯þnß!ñ7ªz.©Z6$Ênþ¤lÈëùàîÏßVêG®
XÝOÝ)é®TUî¨Ï£Aüût³áÅ-«¦ã ¤¨EÜö~| 8Õêá
¥¿mW®òÖPÞ»ÑJ"IBªnPVfÝìXgÛÝ;Gv£n¡¡Z'U£`	)
X`l©?ë­'ÿ nJ¢Q¸#2ìrHñ;¨1TPsÀ;#éýþúGdâëuª*|Ñ!Ã4T9$ùð£mcÈÿ ±çýCê«mb:EK:l®ggà àùÛ õc9]ï?Õ§L+24ëÇoÉ:CñvÍnÓ¤FimE¯,¤ÊéÃd5h·æºÉo!.È×;±é÷>úÊ1©4zsÈ(Mþ¦§éÿ 4²VÎÑSÒÐæ©s¨,ÌAçÝùÏï¯n¿Î/üÊ3\æj(Ä¤
z2¥ÑLdî]Àqõx:ö/â&¦¶§*R¢"
I$lÅäPÑ¶ÑÂ¶ÐÜ5CëZzë-0Zi¨$eA-#"ä¨$ï# °\çÇ+Wµ£·@úí!Åû¨jß{Em·<p*2º¼£ê¿¦Héàs¯Sè¿Ö´xë.4±D¥âXå¼aÆ=ÎÖ9Úx:«ô=¨¢Xn4
`HåoÈ.~üc3¯Fµ^î°UQJiÅþñ2ã ýD .¬¯g«èÚ¾¡ÌÖ{Åºz§Y)\UHðY»[?æU;ÐNïFXl?!ACp¦y%âyej|v§mÄ*Y'ñH^¤«§{õ5oò¨dÖÃvªVhøeHSãíÓÞ
ûY¨¢TT@»$ àeqÎO9?æ:Ò¢åÁÃ>XâJ~íjZÝ© ªnE-·ôñúxðxäêrvd§·½KA¹X>£Ær04Ò¢ÕS²D¬FÜ¤q4©$¥®¸Ü% 9¤Ø+3á<)ÉÎµªèóoR<³m
kÑ¯¶¬Þr\gÁ~ÄqªeÙCrª§¥n÷õàXÝ l{ª±È,O°ÕÚû­ÊÖªD}µ=Õ;²X¨#Ü~=Ze jK5Ý+] ¥vLeÎU¸Úr8®ÍÎÎµ©X`ã'ð)èãY4æ÷Y_)]¡sêBà¹,àýÆ­´QõÔ³VÓESQ:fH·ì~"
 ç	#Uº«÷MÛnõ1Ô_¢Í<jb~âàPN¶¥]º÷¦çGìÏrFçÈ°ÂH1`=Ês«¬j'£P²dá¾¦é+­ ¼VÇ+æ¨í\åÑOl\n>®IÎ¡tNÜáeE~ãÃ2Ç/9u!¹òGöÓû]Úýz
¬*jÕê'G<[,ìÛ$'é@9ä¶¤Yï´r×ÌôPÌf
ßTªÄ#Q1¸lLä«a®}R=¼zÌÞ*àÿ 6Ñ,LíUPí`ÛA(Ø_8úÜê[QÞ®GUDÔÃä6JKG*· ] nàçZ«c·Ó^)Ì¿/+EÚV©|>æÃcÒ1>øçI#êeºùP÷*ÓÕOÛh!xÂFT¶K`ãj7fÿ ÅÜ8^%ÿ §Òl´L!éBÅ1=YÜqîqþu_ê6-KÓôÐIN¯54êdØNÑPÁG<à¨MñW¦¨¥ªµ>ßTTKîpà`¨ÎÈýZ_pøÐµÐÏl>[19&ôóÎÒprm_#R94²Ë~õçü
i&«ÃN¶qO²µ¡ÔxBÃ úãw1ÇÕ°þÅÀ
#ÝB¶G>wiLuGIÞ$¨»Ún6Êè§"#ûç'ßãñ¨µ5K°MkKY§SÝB]YCGyÇ¶÷Ô(Åp]ê%OýHYé(©©åâÕU¸¥3Ï
)Ø2Ü°ý <ãL)©)"¸Ò4´ã»<$º¢eþ`¤dþó®Ô4Âã²ÔBÔðÉ)1õ3òÃÓj+Ä^4¾çA}æuZÊÙi`C?£póÁá¹>xñªÉx6RS÷'ÀÊñ¦¯¹OKA42ÅKÎÊ°Õøg'î¨Øï®¶kR¼òÞ.²$a(Ûµ^rvÕ|Æ¶¥ßa¨§¶É<p¼F²E ÛB¶ÈÊFw}Ög¬¶O4tq¼óÕc~Ö¹#3çWÙAáp51I>L·RÙ¯<5½ÚÒPÎ rxÀ#pÝqÏ¿¹Ôz«ÖÖ×ËS!¦!$ª'zúnÆp¸s:ÛòÛP³ÔG.c  ±-øsÇøÝ®·ûDÍe­¹ÝUÌK­äÄ6áTVpuÉ¼uJ3áÿ ÉYèk¥,qÚê»ÈÏ,yeó´!«'pôë5U´4õw
	c±qlC,P©£ÈÈ ¨û*²ÑTÜk¾¢dUîÃ{E:PyR¸8ÓÕåû)+Vg)óJFPH9Ë2ÃóÎ©ÎßÈîÄ²òþ£ôSGb§¸ÓTR ¨h@
ÀnÇ§ÎÒÃ7RÑÖÛ^êâP@HÄr<6H9ÇDmRÉó-[G
z¸H1ÈÏ?ÙÁà4Òµä´UüÏtPÉNî©P$ lx³Jpyçñ¦7fÔûö¿"v´J¹+WJa5HHêcUí®ßK#v2[A­ÒÚ¯=:Z[-DÏb0 åw
`ÇTr°6ã;N½"Í]I³W¶É]&ã2ºÍ<	|àã¼6TnN½²*¿ç)rI¡CËÁÕX¦ìäFÛA
ô5¢~ÓnåK²¹ljX%©Y)¶¯úX)¤>¶'²x0q©öÚúe®U
Ù»ûéäYËc.Fààãr>ÚI5ªzfJ¹âIVH½*çÓÈ9ö$msÉãL4fÕTEO ¤
6dÎ
#ÆU÷öÎ[ÖN*]xm9qCºÈ©ë ¶2UA§¨i"M¬B¾ÁUGï%©å
gy(Å"áU1ºK+O÷<jm"[Z%«ÀD2µAVw`B)b¤z¸ ý:ïqD¡£Níu<À((UYÔ9Rld\kÉ³u¢ç],rTÅI7Åq3.}.ÈØÚÒýÆ½uß,ôsné¦YÆ©åX1]¹À<øsWíiÙ·E%DôòÉ<áQeFØ©é9E?¯hçwmµðÅK=¢Ù;\HeôFÍ Ò¹ÆáöÖ·J9Gu>¾Ç!u×f¬Ëx·jª%Äl.µ¹Èó°þsÞ¾ï5Ú):­RhÂ:/y[³úyúTÇÒ=|êUEZ¢²CM±=BÁ2	/;v ÚT®F='n<kr¨kªQÃIt±±
Ò)pH+Êr@fûÆ¯¯	cóði=UtôkMn¬§ /Q)P p21Ã ïuZ´BÍI$ó£»õÐÃaxßçÎHûa§£ÿ gãÙ5kÆâTå#~¬ä(ÙÏ:eªµ¿OÔÔÜks Ù,[2Ûå>Ì6A}CÌ05^Me]kJ«2|Ì&ê!ù{},ÎÆr®H*¾Iûäc³cµÉu±w-4R<Jg8ð"FàûõJ5'£k/WõEö¾²áGÔRÓÃ}sí=Ðû@mj Çë[%ß¨íÝ9p³ÐÛöK$ëQq¨PÊù£b[

6ùãZZ8ò'6ö¤$¾U]nªÕÅÍü·b>á+M³t¤Ü¨ú@+ÉÎ­®£zE5©¬Þ´´³üØK¶RqéÊ©úRpÚw±\iD7icZKK*Feõ¨Î1À;³ùÔÛ8ê(k£¸Ó­H@rÛÚv&@<1ÁçûêýØ·_%§.h¿¥c®@
ÃnÎ¹ÆA>NFªAp¡¨ê*-Öøÿ ¤Ò4)*zÙd`Ìò.Ürgo'ÓùÕ´½Þ©YçæhÌ¥dGG±ðÙ9\6>íÔXªú~ÛO(©¶È÷*x¤1ìÜ#iX6_yô*¨ÆÄ®Õ q¬ûöoÆ¥ê¤ÛbÞZ*ºyzº¯}
ªZ)@»!Ê¢2
Wqðå>N
«­@`IT$23GÏ±þ9û
W¨Ú¶ï%V\åF±G @1íÜUWÝØ$±ñÓõ_S½§é(híu!î°5CÉM?m¡~ØÂµÉe\î D»ø/1{2ÿ a_IMM÷¨ëî4ñE:¼ªfç|Ç
Æ0ãtÒjmX-5qU¬ç$·i±m¡¶ÈùËgÍ5ºåóµ1mÀ§vç
ù
¸ç'ràñùÓX­+²ëm¨÷{ÂHÞ0ð0|äyùÕ$Ó:1¥ß;t½CAGªt2;¢g|äðAàÉËÀa®wÊ+$/-ú¿	M3G,7¯©@ÜO	øÒ®øq:©ªßTÇ´Z¨¥Nrs¯8éû/U|cêSl¶¹Ú©¼Ó:2çqðÎG {ûê!ÊTsj5Þ_þ_xÏR|\ë4²tüDC bev&
[Éb	$±ÉÆ5õÃþµtWLAa´+v¢;æ¸zJú¤aìO<
c¡úNÉÑ]=§©{4èAVæIä>]ÏÇØ{ióuèÂ*
à¹K$·K°$çY<5@Öw¶®*z#]" ó¡>ÚO'WFygµ©#$øÓz8 ë?q¦®ñ¥N£-ðoíè<hÖus4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hj<é©:ÒOLIV¥ó§ÿ ÓNjÓÏYPûêzX'À±Ôgë_}H ¸7£=;4omc[ëCäë3pÖ3¬ëÁÿ ÇZëfçÆ±ï¨4hÑ© 	:ùåôñGW ºÍ¹2B$Qñõ?°ûëèmxwñkG%/LuÅ0ÃÚ«\y`Y]}¹^5Yd¦§âé§!¬I$©ð||~ãY¼Ò­dYWxÎÖ?¤ãÎ¢tÕÉn6*
Ú"g¨§bÊr}ÿ ýÿ ñÓ§áHÖë£çÝã^èê×« *Ú:¸¿¥:@}/ÆàHýÆ¸ïùN«lÆÍ
`Uî¥{ª  ãØÀõcÛ5Æ"}uP®;ê¥Ð! ïýYÇHÓN¤¢Q=LGl°H1å¶®èÎrHçqD]£I¤¥kÈâ\*ÖÚÉ½!OêoÃO±]ÃùÓN·-¶ÍGAþ(UG¾ßûëN´ óÒu´»H2B%Dw¯÷Ê:ÓlÒÙ©\ÈeS²Jy2)>üçD½Åß¥_rñ_{WÙiÖR­\²IVF,}nó¾º¡kÞ©ê¡ªR`T¤Wh#f\ÜSéÈb<ó{?WÛ)«ieªÔTA&Ö@ªÌÀ:ò:éêÒ8íó\Öy{2z6pÜòN	¢Gsj>®OsðÜ(ñ½¶²> ¸EÉ½-LuQÊiYÜmr«}Áó|j×Ôõ_9wV¦²æ¡$@I
aÕ¸`}À#v¤uM%5»qh¨©{
ê9/ÐÝÇÿ N<jyk¥¶¶@ó=Â*x 4È°É?K@	àë+Tz°ÉyoäµüEëÈ,Q¦ÛM%Ò­VG¥7sF@ÂîÈÉkÍiÿ ¾¤¥lvºKte·?mXsË#ã#~úôÚ»Ø¨í1Õ^)ZVI)+ã$Q;(Üj»{ÅpA;yÆüTþìÓÙd¾YkmñÈ Y^IV
±mcÃgÈSÎ·Æ¢¢yZØNmzn£ðÏCèïUÔq^®2Ù«úrx­ÞÒÉG0s%M+)ÈWF1çnHÉ×ª­gLÝ)b¹G{´MA-?n¥¢7I#`AlðAÉ¹×æÒÅtéù¤H	h%EfÜô¸d{çý5:Ëzi#XËÚ-;"ì sN2=³àò9Õ÷Ú¸g¥RÛ>ö?S|WènêåªçOt¹T¦ØTÆb=¹{¹ ì zsyÿ Äòõ#ÔÁò´qQSÔÛÁ*7».wí;9kÎèé­ò%-L1q fª¦¦´¯*»òåõÀÀÔ{EºZËÅM<pB¢8ÙJ«»ÇAÁÃY<Ï¥Ñé­*|Èy»Ç]nÛ`4RE/z¢ª°°ù7nEfR6HUÚ@Û»q×>¬
é`¹×ÔµmóO2:,¯¨.yÚNG'T¦¬aZ*âùY'QPè±¨$sèäñÓøÓ:fÚkSÍK<¨¥*w¡PÈÂEeÎX#(Ïßfç#|XáNÑ*¥ªå=R+;Dñ?ex.©É 8>A-÷×¢|6»®4Õ×wg-BÐm¥hVI \AöÎ	+é'U ¡­2HÍ)ÀPFB1cÊþSöÏ{v´E3
«D^µÖTÌSÇ0gQ'¾Uäûj±´uOKãÜ5ø§ñbøôËKc³Íi¶y#ª¡;U(7.Ð­dìÈb$Ç¶¼Æëv½õÖ
&¯ylCCJºhFòÛ2<îÍr¹wçd}Ò¡ù®æá9É¸ç#Ü®ch1Úé®T1Q
3ÓÓG+«mcr»pÈð	S&äÎd£H¦ÖTL(V©Ü¨úôsÁãñ­VÎ;/Ó°FÀ@Èäp<i­Ùª?§ÆlÆ"¥\±Ç?QQ¸¨ãïmp`ò)±,IÄLY»náWvHçê³9ä¯"ÏmâH©#î«a\.ísG È4æÁÖIlÕÚ¯h'ÜpZ©Ù·µ²?×JÖ)åYêIâ&F,Ä	Âùn~Ä}wtVCÃ| UÙBÚX9'î¹?§b³5jù=Ïñ©"¶X¯ãF­SJä6S©Ëd`zDüUè¹c¢°Û*i£e9éH2emÄ/¥p<ëæ§zHXÜH_ÀÙgb|ÿ òÐbnÅJÕNíà8ÚÃnpWP±¤Í'¨Ùt}]|¿V×ÊåÂ¤4±Ç ymÆ#é+î38°ÂëAWÔ4ºÏ1îö²v*(Ý·ãÎOß_+ôYuLÜIµT¼ñl
Ôµ1U úÝÆ½~2^+;ÐÅE
8VÐxÕÔ3q\ã# qªíÖµqqPð{%OTÅCW-"LkëÊãT
ó3(l»Àq¥}EÔûÄ´tÖúxÜþ	%Ý´$øû'Uë.¨£¨äA2ÈÒD)
 w7`ùäsüëikêh/Ñ,dH J F]Hôwr?¾²àïÃ
;{
yeþÑm¨¢¡¡¡îSM#©2"ms Ús··9?J©ù¶JEìÀ7+´,¤À\f0¾YQÇ<x×[ºªáÑÔ¤öú¨iª	$´dã$c9<s«w{õm5ª²äeÓd¶¸/µÉÆ8ðÚ½ª¦c5)ÊÓOþø$]èI¶%þHÞ¬ÕÔ:E¸Gº&$° ©Á  ò1­«~bçÓÔÝ1<Õ¶Ö¶¢¤º®áÜ,C(9ò0»GM5E Ui¢v4Ï
H äú`­ÿ »5
íüÈ#ÒÉWÃM2ÈÇh\Îvó'FÒº4ä¤ßO­%tÙ«`¤¦ÿ p¨­·»2naô®eZ6ñnãNopÃx³OrYd¸BáäàU`¦0 X_#ßHî/Lµ=G
[.ª¢ªµåhË!¯ç$z~ûÎuk1
x®uiµ®er±óX÷£8ÙÛØb¨ñðÊæÃE´Ê²EK
ÔRÈÁ37¨~Ü8ú:«OnAG5u,H°)El} @<î>ú³Q|¸¤§¤YÑäíºï@ÌêpA
àã+}@êKSÛÒª¢tñR®õö3)'il)ÎÖÛÉó¬~ù(mÝ>N4·[­4µ7'·¬´Éo. ¤\"¨çÒ08?m"[MÕn¦ÎC?-'Ë\/ ¨lnä/îNu¬Z½Æjè*éèãáKF±¶»'Â}Üé·RÕl[©>fNå9CÝPäï	×-ô·Ù8Î4qàçã*§Kàe£«75SÁslX¤BÌ L¹ ÓüôëõNõFeYZ8À2-´e'¹ÈçEp¶Yíp=
]UELYjÌ[È8@CçU¹@)¤§HVJ¦Áy'*è¥äqõ1MÀ}XmÄh­ðÊ{c¹*,ÛëëÚ£¶í-)Ç-FàÌ¿¦@2Élîà0 
Ú)¢L-%+¬õÃýOkÄD»X6TÉPHÏ}F3U¤0Ww+VJ¤fIO²(NðÜãÇÆãÂy×

¨z~¢Ýa­¤«Qîªí+2¤Í!ÞüF =¾£v+1S¸^Fö¹­ÖÙ%¨åÖ®3YF>ÙE`9'z¹ÚØb«Õu÷9ihc©Z:r+Æ»"  W
çnO5c¨´v-´whéá#¤æ(Ì}ÙdÔªÊ3êqJ\ÑTDk(ïLJ¾Ñ1S£HØ§ªÑú}ó£4é_e®Í} ¥¶[h7´³ ví¶Å$r
øÃyçTº.¤xªÍPÔhLR"æà3°dö9;ÇßN#¡¹´´ÿ 7JÎ^¤°~NAg|Áý\ùÔþ»\(­TÉUB#4å6ðU¦Ää* 9ÎxÕ­¤È(ãÚWº?N¥·I`0Äd©pîriNÐÂçÁÖª ¹Ás#
ÔÔÉ÷ê1°+íoKª`;½µûVEi"EP³J.-9Ùº¨¨>¯l©P6§°ÕXªÇMJ-5PEü²F«xJ³JYYæ;½ y>}µ·;N6íª+åxj+&iÞ14QPÑ.ØÎJ[-á½[|
q¬[955¾º8
ÄKTÄFânâ­¸±+³Á<é-Þ:jù\$Äk4Y¥	Ï§1Æ>[¨*­T3Ð<¬«4ì^MÄ`!P=²1ã\í×'¤¡-ª$_­SJÕ¢Fª ¤;@vTöR~?:ðoÝFÝEÕòÔ@Â(doé&ò6Æ±mPØæ#^­×÷,¶5<Ô÷
¸J²¯ý>Óçú@1ê àkÃ#-Yw²XÃFÒ¸þúÓMÛ<ßÅóº8vYlúÒ©ê®JáÈih*À}Óz®º¥¦owQ´Hr|7° ¹ñ¯Fþ:rKÝUÞhÄA£ @Bp|9Î¾iÔzlñ®¯F/ÌlëÇË%ð«ú²
®·ªÉlN~R©ÿ ÃÂÉ×Ò=)ÓÖ~±Ac°ÐÇEE ZFÿ 3Ô'M4kTáÛnÛ³':4hI` ï­Ö ÀÖè¤êR(ävrFQAÆq¨ÔýÆQÂ Õ¨óuk­<X5)p=´"àc:ÛWG'¹Î4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4¬1¬èÐêW+¥I§R®FÕEÏãUgNÓÌ¤xéûùÓ)|ê£}C=\S"¹*xÖÏ¾¶ OýúÔPûj¬é1£YomcP\Æµ>u°ÑöÔ´
4h5 5IøïbN¡ø?Ôt=½òÅMópä4Gp?3Æ®ÚÏn:^c{maÿ yÐ¬º<ïøp¿Kvøcj¹3+TZÅ4ÍóOáåT)ðW#{üG¹ $ç#9úùø9©Ý[ÖÝ_"¤êÒÐBÌ3ÛÁ¿Ñ?ß_HÑ«SFbV1ª¬ÃÏçVÂí6¶GB^¦ ®ù¾çõdDXÐ`ÙôþpOújÁ*ï¥  ÅÃûéOU%DD)ÉþòÂ [Üà}8¦9éÒhÇ¡ÐÏ¶µèæ´}7U5EHÌu13Á*í8§ÈÝÉ ûiÓDQÜ®6ØqMnTWL,Lù,}×Ãþl{k¬GIÔ¿0)8ÁeSyÁÇ>puÈã¤ê
Jåêâù9ÙÝý¾±û°ÕRä>Õ%AUyuþ8)+û¶ëÂ¢IidL¬¼®¯L0Æy\ú¿mWúmÏ\ÒWCJ,ª?#þº¤ã¹òvè³<RãÉäUo¯Ã55·ùurE5C#ëo;È(ùú¨×UF¯Óð¼¦¢	c¨îÆÃ`Þ	 ÿ kÓï-Stù·V­²ñUF^ ¬Gobä?¤0'Ò}#®/MÏYs¯¨xåp(QÀ13Üå*}Jq¿Û\[>¸Ý>Ä½9[KF·Ø®²×ÅÆ(êV9cevCyÜ0[aVl^8×¤Ïa³|ý%e},WG¼2efqÛ»ÈÆª}<÷
kÂªÔTEBrP ùq$[;aÇøx%G«;mz=¸Í;}ÚeR²¸oG_#çþ´RkS'Óâÿ Éó¯Å«MT·IìF©ÿ §O-XzúVFýD`ò?ò*^~¥®¨bX$¤tFHÙ?¦ì}}*Q¿|ëîk=£¨z+ånônc<M-dÃúR(I$Û@+¯ê^~êH+¤JÔmÜªz*b7*®;=EØ±Ûêäç©}7q+	Ã[
¹
yøkñ[¤Í"ÔtôÕ0ÏÌAWFÂQ³ ÜÆå#'#ãÕ6Û|ÅX+òP'¨îÜ*H Ã#ëï7ëå½#
úÃ5ËÇ;`Q\¨ßêb8y#ÜqÆÝ9§ntÓTÜR)ä9qÍÀpñÎe¶ûägZÿ -T|Kséttýi,WNÌ)(IQ³sGLvîòÇ>w0ü5­e7^$_Ì#éÈ`ÒN±Hñ¸m£;²Bç ð}Î¾ç½|?éÊªh©è¬:(cL¤ÁXÔ0PÀ_ø:íñ&Ýeµt½ÏEGIWV-#nÁúc-"¡ã@A+ç
1ãW8¢«$¤Ôw;gÂ´2õÚÑTMIa¯hâí³ËO1ú=D¸`='»RüD¾QRÜ`»ÚTU©¥.Ä»X}ñï¯£zGáÜ]?ðò[Äwjú{]ùX3Æ[iÛ;AÉ,>ÚÐÝ[Vg¦¾h^²e©£I$ÛF\ícËéàó®w¶ú=x`É±ÍeëåVës-%<R÷'rÉ$2íÄÙ À¸©Ç
x¾»MÕÏ+4ô5a²¤m¨ÁRpA#úýðªÒ>jçzh.u{<{^fBë`à¨9¶Rü.z]'hà$cP7°w1`9áÙÕ[ûÇµÎ_Øùn¥ÔRÖ¬Wôm¼¨P 0VVËì4º[­ÒijzK¾æfn÷ÀÀçûëéÃ¥zújú54µkÙØaô*çsdçú³¦ÔýôhñÃl¦«xÈÌ¨ ¯£Ô=$ð~ÃEGÁ¢ü9Ïùjº8Õ	9Ø²Ä)\?¿÷uþasRÛ¶EbgPÀ$rsîÇþ¼x×¾\zZ²jh C
C«µD*Á£p¬ãé$çÀ9ÎO:¯½®£¨s,F
5uI0JÃÖ|(ÚÕmUg¾ÑwøD±ºS<}o*ªÐÏÞçÖ² Û{mO¦¨¢jÌDfB[¼'Vàã*U}#z-öÉd¤½|¥ÓG,ÌÌJàþ x'ÛIcè+UÂZÆéZx{26áä`êÞ¬[ª0>5wert¼¹Ý»×oÀûóööÖLÍ1 ãÉ,`çÆ@ò¿ß[?KÇKDÕÂ±nWÃã9ûët}EÆa=mCJÌ QbsíÇN¦£}8æ|(/U½µQcºÔ:#7°Áe-ß?}.¸uuÊã3¥½OÍLîÍ*Æ«#ÆâXrÇÉÕ²Ýð¥)¶Ëv72ä¨RH8÷ý¡×¦t×@ZhàH-Ô¦½ÑJ¬¨­{ðX©}ßSêc\ù5ÇøN³%nö£Âúb>£±õÎASHÕ-æ©8FBÀÀðF@äýµîÔ×¶£¡iw=¡¦vÛÉU½ã<nÁòÇtÎèÂ²ÙOM_CA·²­C/$8#2HûjµSj¶S[i.½º6Þ^i"öÓ¸unâvÃ
¥Ô7§Ãíª9¬l447Í¢÷ÐõL.MÏõLú²ª+7F»²ÀnðGZUcÓ[Ot¬55ÀÎ!	+Êá[Ç$=µçÖ{}eK¬kW
JÒÎð°2â^Òà»:¹Ñ÷¯IM@E2îê'|D&ÆUT¦rF1cIÝÑR|wàÝkXJu¥£*"X$Øe8»*v	Ùé#W6¹ÅlZYÚ
qt24ò1Ë#¿ÕaÁüëLôïk¨nôµq:*ÄgQ½Y2¤ªàxÊ«O¾áôãY¸ÐÂ:iâ¹96±ï$°èÎzs©QpÊ.MHu¯¦¨¦âAJñJéÝ
 RÁñ|sùÔ^¥ZêMÿ 8~V ¤e	` rÅòp['ï©V3ó6õ+@"i%À°WðxçÆF«ÕýÓldu%¢YäÒ6Xp } ¨
ô·øãXòKiß¶yéc®MÈÒ:ÁÎÅaÀÉ\uÒºk-7Ì
^ò+M+H°Éç©ÆµºS\/SWOi·×S[iÊ=D}À m BNA$~}ñq+õUÆ¥ja|
$íxC¸,yÚHÚÇ¶Ûå³dÛÄcÉ¥2ÌÔß"F¥ùMÀ`øàO¾Û+()¬U«UITÆTe+Ùrs¸ûg
s´yÆ¥Z®VË+ÒUENkæYÙéðPcü4À  à-?9{­iÑ^")e rÇÕä	ý;s¨§Á´Ô§íÑtõÎÿ EÜat£"9[j",\6/ÉËc;yl¬·Z#¥¢Y$î×BáRT7Q+ä¯Üë[÷:^²5*UÄ³¹	§kmeþ24
k}3ÔÁCT÷An¸±b2É02	À±Î1­.þkkáÕOPÝ(k" É©ÄtÐÔb.ÿ qÎÿ »ý@Â»-µÔÛç ¯WYTE;ÓÂFFÿ Ô»â»¼ç[XïóQÜ`§ºl;{1c öÙrq¸)\¹ÝKæÜ§®£jp)ã§¤(ô®@Ï-´$þ:«î|Alâ¸$ÕÓP]oï&j8ûÚIBÆáCçvÝÜü>ÚÒ¾ÕU÷æ7ÉIf¡UËK2Ò«ý,
6ó¨6»Â¦íMwI¨ÛaHÚ,úËNõTrqçmÕ
yH.ù I)éÑ%-èRÌànÁÚ<ùöÕ§lÆRÝqèalz¤¢ªa¥3JE:»Õr¦4,9>´ûîõiuÎûSÓôP%E`¤Ùåá SlÛúØ8 ãÛIí4ëWó+©ÛNÝ0µëÎF
ÛÈ ¨\ÎºÇMq»ÔZgþ^Lä¾òAÊ³qú²yó¦æÉP¨lÖzkÝâÞIBöãË!ç ãß[îÝAfýÙá·P$ÒWdQÈPÍÀ>úÏ@[¾FÙ5*jj$}ÅËÎ1e@üóãUo7NÓÐTï®pþ«0 üy:¤¸FÎn2ü&ëûM]LÀ»ÍSZwsO¶}:{géqKÜ* F 4ñK"IÞ2_ïxû
 °<7êÛCÊwD`£H¢YÙ3O
}sAðîÃI9jhÌ4ÕT1ÒÖÒ# ày<ë«:àO.ì®lðû¤­3Fò[­H¤Áç  µç>ÚAM4têVcXÑ~ÀxÔt._.ÃF©­ `s ~4 ÊÇRéã-
s¦C»ÁÓz
q²93äÚw¡ 4ÊÚ5­<`.»ÈÁãí«#ÆËs6Ñ£F¬d4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@au¡7­\d M¦$©ÉÒùÓãNê£ ,¨MQ,|óqomK1ùÔy  q¨hô¡#Ldyñ­u·¶µ>Nªka£XÇçYÔ·Á'1£Y mcPB­ÀÑ¬hEYáÔ¿G«#ÇÜI+'jÉ%=÷ÆAÇÜc_PR<¢u´MçYÍÀóçÆ¾aþ,­T½9ñØ­óv*ÄBHRÁãÈûngÇ¾¾é¥-þÅm¼ÒN­
d	U)ÈeuÎ?¶qû©ÇÇ®NÎG+AB*U7do'þoÌU5&<?§<mè?×ZÖEóTSS²z :YET)MV6aà?nkKääÛº<nÄ%E$¦P%)N$Ü§|yÿ .¢ßà©ËPî¢¥TI?©YYê£Sî@3!f=D¯?ÛúF{£ªwûý¿}¢aG^óÕÒGQ² ·ù#ø äÛK®:¢wZW"ªØÍàgî0xüêeªG[YN ÙÐ+ qëñ¸û©ò²;C2 
üÿ Oí©íi;®6¯[üSÆimJÛe.$Wa÷}<ì9:Í]±)"Iþ=;6ø·±wv_qñÎC%AÀãNúÏC´w¢@aeEÛÀ'ðÕ^,ÑM-BÎÕß,åÚwVX Ê\ª¦?}r?j=üRSäè¯Ú­¯Äh§C
-ºJ¸Ùºîq÷'ÜuéÝ<µÖîÝYV@UÊÙ#èúþ5ã]A	µ\ÒäÊõ7©³(
ÚRÎ@ð$21ÁòcÆ½[á=cÌÕÓ²Ë¶FXÎÐyÈüù>ù ccâTOâRÀòJ*
zØ¢Xé	Èp¨,pxú¶ßIz¦joTKo¦¥ìb)ÈìWãnpÁ#[k©iªaùyÑJ°ÆÜy úôÖÕ±BBaE!Ä¾¬m'ûó®Ïyã{>sýiºÕM ¢X.[ÄôÕD5Ò&Òæ\( ´ç>AÒê®¼¤»Dö¸Cæ1î&T+¶£zÐ2N0uôRô}²÷Cp§îËK5de¢,@0 lªÈ§ÀdýõæýMðû¨-Ò´öþÍÚÜ´Ù0ÎîL¤
Â,á²7°ãvsËµG³¦üJOz7©ët¥²g²%iYÑÒ¨mÀ ©$ÁÏã³¨_×²< J:\æhkÔÂ¦WÁ}ñù×]ª¡¬¥¢(ÒÈ^IÖ<ÆS ·(y*SÛÈñ¥¶ÛE]Þ Ú Ôå©þn=Ñ2#·ôóÀûëK"á,ZiIM#Ôj~ ÚiiÖµ_P²b¢9
4Aº,j06äùP}ÀÔÛ·Vô|©e ¯·[Ê*TEb¬¤@äì#^7%uâÝoÕÒ4pÉ)¢¨S¼±Ën_\d«6í °#'ÒµUE®pôÔ<ÈóÈSË¬#W%T\}8wãT÷¯ÈèþSæ=ÙïýEñ£ê-ó%Ó©¢¸SÉPVÇví¿pçõzöÔN¦øÓÌìÕu0mQèr¡v·©K#rÁ ÈðÌ1OÚíÁOòhTbÌØòàòT·ÈBjYg£¬",XÁ sú²SfQÃ>O]ëÿ kv¨ªk%tTÓ %z·
¤nÜÅbA¹ÂòÍ¨ýYÖOMMKQh£§·ÍU3#²ï&Yö¶ÆÝÇ¾¼ò::íU1
J8mÓ2àÁÀüëµ[Ã{éxZº¦¸°ÔÑ'ô£!ß'fK
ãäR[héÇ¥õÐÿ ª/wËwTT$µ
¦£Q½	rîUSFvx8Ï¾«Ò­UÇ¨æÒcSg><¤ðkÏÔºëu¢Î)(»kÁfþªd9 }hq·Õ0±OLýOj©¥¶¬²S+¬ïÙÆÐX®N2rÞ?tù7nS7Z¨nT2KOUSZRÔIòÅce
s{aÝ_ÈÚt²­Ú:©¨ÂH¼TÌUwFþx'Ð8õsui³Óu'PRMZjqLZT¥r±Ûb¸ÞüNæI:¶Û>X¢kõFÄ£rVãÀªI#÷÷Ô¤RMET»(vê±¸5T´­GJBªÀý;yäIcÉÕç§­v~»,â)ZIjNã4¨øhÙ ¬ôøÕ®ÿ AØ©©Z7¤Ì±ÁTò¬9óçÚ©õØKó	MXZyU( åx<Ç«ñ¨É(Ç¢øpK,ýÊWc!«©A
¶·æ4Ü6Çc'ï©ôHhi¥¦Y£"=;H7àÂñ>àëB?û9WKSJÈP¨mñ;söû0ãòuç%H±[ª[0Æ«~c;¹$¿«nìgX)5g«I¥µ©æª¸Q4é!)Z¢à)±¯7;½½óªÅþ¬2ÂigvVGe

{7N?L*è­õÖð´Sîd ãv FTe#+£®W	¦hmä{ûO"­µWnð}8ÈÁl«Áº£Q{kÁÓ§ª*¬GUEQm¦¥¢,#ÚNJçÕµ&N9#p5~¶W½åjRJzü¬ÒL0£ ó< àªðsçUy£µÜUôõU=Ê·Y_pvnû§Ws¨}=4¬w¾mÑ,ÃÃH»Æ>úÝGxyýKmÎ
âÙ1¤f¢u©û±ªùÚyCøÉÇF§4Ð××¬B*ZÀÓÈÝÍ¬$Ïh21Tù«-âëm«¥×ØzÙªêH<*Ô"(U_au''UÈìÆáWô×y*.ªB«&Äí'l`~ÙÖÒê?©9O]4õ©VïoHiÞY£Ä£¸gðQ=d1äçP.-óWZ£îi"!Þ5E\»g|Üþú´ß£¦Ñ[{Ôm^ÄìéI}ÙÎÓ'¸þ4¬YêÅÎg§±<,[!b± Ê¸¯8Ï÷Ör.üsÝrðiÓ=;¶Z³]W ¢t=0ª-ê ª¤6?WÇ-[Z*®T·(êeH¢s%ªº¦Ü W<Î<ë^¡¦­jÙ&zÉ)è±Ýµ±^À#Ô<ùÚ	ó¤·¦¦åS)Døth¢§HÖ6ÜK U'{*äù'Óêª&;¡-Íöq ji'­f1;óaZS©

89Áûj{GÞ óA,»!îà+0Fb¦B	P1q®PRÇòY_a;«?¨#=¶ÜWr¸9ÆãÈôé×h*íP<óÉ,0:*¤'{w$~«ÆÃnÇ¶£§H×-9vW®KèÒÜa®t¥ÄPÊ lqôÇÇÓÉÁó»SzZ;e4RÅ[Ih±*nHã,X1wn 9ÈP§,Ø Ô*'­cÌôÝ¶Y1,HööìÏ'ñÀûk½'ÌUNE¾§h{e¥]Ý¿#z ^\ç<pvãVs÷-;kÁ ¶5åTN¢Dd¯Ò¸P>ãûÚyo¾T[ÄUpÓ5Ãýß´3Äã>véU5E54ÇÎOrUý8ÙÆy
yäê\5ÛÕ$®zã,$IpQwúçÈÆß>4òjçÆÄbØluÕj¨«iÌ¤²£Y\vÛfÜäíô¡RÇI¢¸»TCI{3+´³nYqÇão°ÔRUÀÖwêâ£§R#NùUÈ<±?åãÆ7tºÌ-S5Æz¹^£4ïéEÛË7'ÓÆÐ<ê{àÆ=Ã9ï¶ºÔ¦Z²jªR¦:.ã2¤úG$°ûiåMd=¶2\Å%@¨mà0ûgw4¶ÇOG[oä´	IÀñHí´ 
ïPO$àÛ·Û°[ç
i¤hæH®Uó=6YqST¾|Tàb5/ÚÝ'Mª®]b¯[Í~c¥	þNæÁô«Xãü¿xTEUt¸StÕ¹Ü®UB!
ÜÀlûrHÇêé×=ërM=ÆVxiYåhÊá¶à9$ãÆ¶¯Ã7CTw*>'ßi~^[öìÔÔð¯sñÀýÉÕðãsi¾_ÄòG
Ùî'á?Ã$²VÏMX`P×+)	Ë2/¤~¡ï{@äãÀ:×j-µw{ruºk²**ÌãÎ°
ç@#}´úÚ%ça#ÔÚ(7cÓ«#³ÚH¡w§4ñÆ¹RE´5=VHñ³ä¶l Y5Xå®CF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£FQ¡2<imL\øÓ}B¨L}CGF)Ð¡p|i|àäý´â¥$@©N3ª¦Ù
ÈÎ¶eóÆ¹äçÕäí]Ñ¬·þ:Æ_ÆµÖÏãZèFd`tSÖ?Vt]ß¦d;VåJÐ£`²y¹û8Sþº¤ÿ [5ÇáÍgH×:ÇuéjÃNîùÆÑÉÚýÄÏ·ôÜ<ÿ ¦¼ª'ÿ èø·õÜe§z¼@«¸FosÇ,Å¾çHºg·èÚ>´Â\ì}µY«iº²J
JWS¬Ô¸ú×÷ þÇV
F#a´m; àxñï¤=a¨¥ïn²ÓQÝ	¸{²#*[ÏãZ´y{§ä±ÓsPr§ÇÛH¯54¸/´äÉ'csÏä~5ÔÔ0Z*-¡hÀáväe¶N>øÔû´©ü½¦ØeM¹ Oà~|ê$CÙ#z
²Óï)q¬1ê\ç?ÜóoWM9Y	CcÛeXãS%ÂVÉOoW÷ÿ ¦¬ÑÉ*Ëqï©âäÉÚ)=Ko´VÜèëmY
Évú[Á?Oxlðuïn?0·H+".bÛNQ¥
ð|:¸WÓÉ$M
$MÇ¤¾@f¤D££úpý°¼ë'uaÍI4y?UrQz;ËUQI+¢Êì«"SFÄ[nrØlûêóð}f7Gù!þ\Â­½ÂÄ}bÃðÀ{imÊáuê¦¯y¤KDÌ¹66Ë#©esÁ«Eª-¾i ºI*Úm
7p¸ûôüê°¹3¯>mØ_ÜwXäÏM±K¡9ÜcS_þRW¦Aê0çîqÿ Mt­)æ¦Þ	Ì±gíy?úë ñ¥×±[ ÛKL£{~£÷Ô´>ÎáÄqÿ ïkPÛSrO¾¹¥@jE!BÀ~=ôN«<·¨>Ó\:6¢ëp§KDð
ÆÒ{¬b,$Ã.8ÈÎ8×ÏÑ=G%[+¥öÄ±ÝBÕç¹3¸ £úË,ÌÑÒ|ÂPH¢oºDWllåG!Ï§Ç°Ô[e¾Z«B©ÙÏÌBÄ°
¤ð§ )>ú¦D¤zLïiô|ué¿v}u¹%¦(Fú¸¤).ÀçàãÜiDöµ&X¤·VTCXBâÛ äåHÎÕÆ1kìXàéÙ*ãjúi5,ñ^B¤ñºO?WéÏ¾¼ã¨ºÌ÷¡þYX°Ä°ÅZZ2IÉYáA
 c$ø×;G¯Ëô£ç)º¬bõ6kÃ$LÔE;´ ä2¶/Ãþ¿{É¡¥°ÕÑVmÀB\H-´}C¬ð1ã^Ýyêãi¾T^mÔUªâ£wXÞIÛS¹ÛÓJÎÍÖÕ]aõÀï§«b/µñ¾Caÿ Ujdº<Xü&øQòM<ÿ Ý¨Õ*_p'+·ÈRI<4æáXÐÃVEÔTvëha=LPÔ:£ÒN¬ãQÇ'Vª^§­®¡ºÕÃ=DQÍ4$m!öÈªÀÜû×m%Yjï6ªÞ ºÕÔeéêK©VYBU;|á¸Õm'lÚ8r*i{gø_nãP²_®Y¶¼qÅO²i7#:öÄ ÊG'Ç²UtÙF·I[XêÂ9ê·<î£ d K2=8Î¸ÖÜ"ÖzW ¢SER#[k2²¨+	\g<kiïuw¸g4ªªÙTK)ÎÀdO ¶Ûäk;»;¢¥½Sà±¶n «´ÑEÎÛ ¡í²<.
®ÑÂKÞHäòuQ½×IzºÊÿ «Â¶c`'¶{
0G9×:ëìÎµKM]Y²D=éàlÜNöÒ¾õSåé©á#õîËIôoÜçñ¬¾G^c
ªØeib â5s#T*ðK/}bµuZ¹"æzÎÆI_ÁÈ÷ÎÜãå'¬"§XCË)jOÏ=·N©èzg¹IIHz&Àx%Èñ¸¯ö#ÎN²Øw©ÚhÕnP=²[aijªvoÖà
 ýÇ°ÎK<ÓU¼õ2Jâ±^ÐÀãò9'ût£5 ¼éK£ÛR°$bnª+¥]VÅ%DÄ±Vßµ[
U Ï±+«(>¼TNíÛj©©¨mÝKSÛ +ÄïU!°Î§Ù!qøJêÞº¤±Þ ¥Ðð½ì	;Ðå³cîuÝÞëéá©£¦À&TÚ¢CúY!rUIòØmÔý7oY)â¡Ikbz%|Ä²"¬ÃaPxò7~5¤RòrgË/é#Ùî×Û¢¶jÉQ"QÒM­{XÎ8.»v@8}kª¬µü¥\®ì2´ÊÀ8f>nI§ìFNÜêUîãa¥ée©e¹½3ÖÌ0±.õØ$'íÃ`py×Ýéív,U6QwaÔË¹þv	ý\«ÉTËnIWÍkc¸|%Ål¸T³ËØI7îhhànBÓyàéý¨^iª*MD5qÉWiQYo*$  .W
7cÍöÑØ·Ühc2ÇG)tYÑJE	ÆC! ÿ ïï®ûbûO5]Pw¥¦ù8%¨w#»²«>qÁÑJ4¬¾L2{N¶;m-ÊïRWÔP	F ­·;ºÀíUÆN]ñÊSME+Ö6]³êÜ¼*NãøS_S%=EDVÞîÈÑý¹i>dÆßÜ F³´tw ëq1mÌ«"£6H'ÈäRso¡	ËzävóWMo¨Hâî;JëDeÆgq,9
ãuU»Ý(®}Tö»M,ÄK1I]@ ©eÆrÕxñ¦÷ÓS=Òª©¨§¨Xdf¨U§$ a^y<mþúïh[b®«Ö3Ó;ÇMàGÂìßéô7>6ãUÿ QÓ5|.ÌÓ[èÞÇß¨ùzhá§xiâ*UÈf;7ýEs´[Ú@à
Våz¥¨« ã=cjã½çVr_#Ô ÆtÐU	bY$3ÇQ! ÂÃýáýA[qò8ò5¦k]*JF{p<gïï¨´ ãqÒ²ÁFbjùîñÁx/¸g$K2ó÷ÁÇ¾ÐÜ¥7jËUIhéáª²S¾IbÜC*äoäxÕ¦¾£åRßÏ$éÕHExCãÃc¨6´Å5aSBbI,h>røÏ'þ#ÁÖ©ÛoÁ¦á{Uâ®êj©$-Ãº> 7aN~ø×{Å|PµeHzHiÊ¥:Db^èË4ìç<
¼yÖõ·$»Þ*f¡ §¥ZÚ5KDêKpÃ9Êç>?ÍmI*VRR8jE@féÉçßö³"	Ë¸É+9Ý<µ58 
Ï!ç3ÂóûéMEE<SW\¦ÅfÀÿ :Âà6Ü¶I]ÇßXê-ºz&¸

4²Ï[iGp)~NKòUG¾	8ÀÓ©[<*K=BÔtõ ã¹¹ë×7aÉÇ Üj½rDîR¢5¦¾áDËOG)DESÿ 9Î,}DsÖaCl´APÿ ;$ØÀ]î@UUÈ>Ä¸ÒÕmðÉKOPÏ=c+³¢ls]µ#Ûmäûÿ Åª½ºÝwø£ÕôÖ;E¾
:8
dbðÓÆ¹1óÆNÿ ÔXs©^FêsGO}¾Ã~¨ø¿ÖñAÒG¸:Öºî1Â ã?*»òruõTÒ+b4E$#Fp ÀSÒVwKôÝOÚb)GJ )<_doÉÀÆ|ix×¡¨Gj>ynË7'fÏ÷Öê05¨ÎF·Ô
ÎþÓ@cÁ×HÔ¬ù×zxÎ@Æ¬¥GJh¶ÑSáC ¦ôëÇ#VG©ÍÉ¼q×]`k:±ç>XhÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4¹Êë¬ \
j£<iuL~iôñðt²ª>uJ;ðLG*àã\va¼êuL|CàhÏR2³Vÿ ÇXÖW'Î°|øÖfèÕük]nyÖ§Î¤Ñ£FØêñ£S®º
ºÌ±£V¨ïÑ³(öýï«xÖÃ8Ð«ªeøOëÇ¹ô;tPÔ®ý;oë>J~e³î»gþÏß^³TÈµTAPv#ÀdÈ î¬×ñ¯þ!OWðÃã%]ÁF{ìVS sìßIÇëé;²Þít×{YCàËñðOÛ?L|3ÈÕiÖ)n]1M*ÕPÕ%©bp0É0ÆÒß+ýÁöÕÜ¡òÓYO9õ×9èÌ´rû	Á>vê2E²l*ªÊo_¾u§F3©«]&¢X$âL«d°
È÷Ö-hÑ?£h0ª¾à~u3.òwvìÉøûê=C¤æV'í³¨¶äþ¾ÉMÖ¹Kv<sìþúªõ!a-=ºJÀ;Îâ@ücß÷Õî¦C½ÜåÓi#>qí­¥\¢ÄJã|~ØÑ«COM+=lÔ¶4´t± Û=Åa»Ö¾ä	ÕÁ®ª¤÷1I\øñã\o6£,2SNê¨Iáÿ ßí­ªZKuÉ+ÔÃ)H¦9É,33øÕ£¢sK¢Á*B±áWPoÑ©¤2·seÂÆNIð<ir?¶³UÉ ~qÆ´ñgtÈôò©cGeVe8>Hÿ \í®FÅp :F±S¥T*¨rüÀÿ ã®Îd3àþ¶ýWbÌ®«êf^ÚÂÃcÎîçÛ'Hº_åTqU½UtQni¨¢©ëpÁcÞþ9Õii$$íM´ÁrTÿ ~¢KHÌh¡HjgeSê$Ásç'ÛÛPÕ£\rI­ÇCÔ3U\Ëq¢¬¥ªUmu
Ä:/;
éa39Ò¢ê}M]¢È¶úåY*f¸*$3GË»
êç :¡N<ëÐ/=MbUÑÅL³IÛ©ªªPHGbNB`°UÌF¼#®¶Õt4Êkiö.õu	¸a_O-ôù×·G}&ssz.¬¬£Bõ(éR0ò0#º@¤åNå<ò3©3o6jIàjØUêÖJ#(UYpqÜ*}¹ÎÔ½+Zb¦µ¥A:ªa¬!ÛBîØùÕvÛWý?-,1[%lu*dpDq¿éäãs¬·#½EãR^Kuª÷c¶Ï#ÒC5|%ÚcURÑ>©*¢¶|zîu÷ÔQÔ[åêôTPÉQK<ÊfFÇíRÌxÈçÆª·	*Þ¦gDhhûqJï$*¨d`w`ÞTgWRkî0ÖWÓÆ Ú4ï2	Ü²ö8.3úwj{+ùäþÕ"Úá·ÂZU¤FHF±#ív=-änçõk"jóJôLðÌÔï:ªMÜ FÍqçéÇ¹Æ<s£-@w¢T7²î )å!	Ï¹ñ©	I$
!ÔvvÎ"Ol£§8`88ó¬i/'L'/¦¨Yi"¾¡ª¼<­NDªC  6úG¨à#N,ÒSÓJËV#s´HÁ»¹)¤HÃqÆ£QÚ#XËÆ¢ý¼^p®Ç9,pÜ`Å
<ôU&*V¦U[ôO¤>Ö9'Üj·Tû&\©êè«~Zà¢#<ÛYÓÉ¸ûÇ,<Æ¹[åÛR[$³.ÓºÉÎÖÇîF@ç]«n-¾*iÓËLûö¼{²`Ç2sÈÇR £­NÏm ªíî%T>=$g%X 3ýõ8é*f[í¦JúKLµ²Ñh¢®ùlÇ,cê_Äð·sö)þvÝª)Xû[pA¹ÇØãw1ï®\)è­­E=3Zs,,¹Îõ ¢àò¤·Ö)ûÔñ£ÿ 2)Ô»IÉà(û­76¸9.Z³·JTÚêj0Dæ8ç+»rÆãÛEMáûÜFz ¦
²ÌP¨Q¤ï$i]úI)i*þ^JjhW!Ã?¡Jà.;¼sãWn£{÷L­RSP[)Ãwª$1×T¹ØK(Ã16àó«/s0Èåh[déÎåÜ)Ú[uEä¦¬u71"7Ç<®9ýEã_IG]p»ÓVÉ<eaEªJ´"NäUÃ"6NvêUÒªÝoÑh¶=½R5]¶$(þ·ÂÄ¾Ëé/ï¨
w7	»I54FJPâHÚV]Ì»A,à( q´ãRï)»|Yt²_ éèo¶zØê'gY$$9
@Û³Ô@B~°Ê¤
iMAc¤®ººXêS:HÆÊ»LmÊäãl®ã÷ÕRºKÍD1Ô×¤pZ(]i¤Q8 lóøãV:~×lÿ "K
ü@óß2ÛÈË6x,|¸O:IH¶ØAÛnÙ¦¾éSM÷êÖ¤GEUª)vßsÇéó®5Óö¦)
Øµ b¡	#iß ðUNp2	 éÅ×©(V§ùM1¨©4&`Û*ôDÇ_¤þ<çUyëì_Ì½¨$(M=5&Ã*± nÝèÛF1ªI|âË$Ò²=gNÛíB	¦X$TTÃ9,«³¼\¬x\qçU¨.	Qw¶5¥£g,[²¬ùà26Å8ÉÓj:8g¥îÔ$ª;d©S¶D½I¿vbïW*iÙK%34ÀåW
êCÔAÉÇá´UË±IÍ¯'9ai§©¸ÑI
E3ÕÈc¸Kð@çóK~útÚT];S¢ìí£ªäöÃ)+¼äp¤u
°QÇAo¥¨@aWéà®O¥r8' y_?w¦åCjk-bPÔD³îþ¸ef)ëö;p7¬ï}Í·¨
-¦4[^|¤ ãb W
µTº}GE¶Ù:À#©o£9j%¦EDIdbrÈÄxvyéWGM$j%¨bÉØ½gx$sïnc«¤©Yb§ÒhÖ8ÚyØz£ª8w«óï­äàËß.Äéq¥à@ô´T±¼µ2H!ViXeW
§'`ÈÏ§'Îµè«k[E0^ËI«cL²Wo#ê\ù8Ê©ÔE¢ß_Þ«¸Fô1P²"Tdlò3ì¿c©½wKOoªÅo¨J¦YmªqmÁ9-äãEîä¬å(5"ÑQC
EónäNï*¤Hª}3þ!àíó·:is¯¶Ûá4QG4	ÈÙOv©ñ¸»ç\dåyåG¹×úeªÍEEêÄF#RûÛ'qfÛÉPTð88Õ"¥/ýSÔQôí¦Z»µSmiráiWqÊøÀ\'ØcVJSöø#.XéRÉ?«àÚßIÔ]qÔt¿OJ*ªª±óUg":hp¤þI#¾±øyÑv^éØì¶¨¾UÕº%LË·ÙG²øð§ mºh[¨Ùj+åëëGßì¾á¶­Ù:îÏäÉ<ùæÃwü:>­ s­V 5ßR{ë äãXÇí­£\Yn'÷ÓHI#q¥8Óº( #R
FZGJXð£hãZ Âë¦®yæ4hÐ¨hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4¬gFÒAÔ
¤ÛLH×	ãÈÕY|ri*£Æt¶U øÓê¨óéeL\j_ìhÖò.<k'<Tî³Æµ#]:Õ¼êôhÎ< ÖAÆ±£@!øÒ=iÒVã±f¡ð¤K~Üò5æÃ?]Vtÿ W×|1êâªGæ#pe9![ìÃ£ì>ç^Þ	ÏyÇé×4PÞ¬®):®Ü¿î©Ùó p!vì­úOGßÉX©EÆG¾SVÐM+çUm¬¤Aó¬\`3,AISÜ\Nìpã_>|øÉ_x¢ÿ dú§	ÔTÔõrWÇÆõPÕ¶ù?b5ïÐQÕi½6·1Æç>ÿ ~8ÇÎ´6	á¾¶ºµW èÇ,§÷÷Öó0§páOmÝ·Ûÿ û¨QG[O!H£ª$ýPzN>ä}J¦©¦«Y)ä¥ttÆøåÿ Üus9Rvo¤ï÷Óf_ÑÜS¾}µ?#ß¿ßJâ¥¥¡ G,'ÛãóÎ»Á2)ÜÉí|ñ¶%ÏF÷^ïÈÊÐFòÊªJ*8B[í¸ð§òu[¯;ÇNÖBÖG"DÊwÆãS8BîçÜjØ}kÃ}õ^êäÁÆB°:«DâÉ·[K-ò2ì/±Øà{kÆUÕÝU£_L øÚ}õ&ÒzTtÊ såxÿ ¼j¸©¥&EíöwqäýùÕ¼QæVÎJi§§	M0§
ä#v0|cí¨tu[fª(0¼2ðQ²Dóï©bHé)îÿ ],¤ªT©{}VØÞz;Q pêÙ÷ÝÅ©ë<Ô4ï,G;b	Ü\m-ëaÀñßL©'hðÉDs_÷IØ|Í=]?õ!j2²SÊT 2¾T 6A×4 ,Uô²Eò_ã#j¹á¸ÿ ¯ãTm<{j¡Ya7ÔÑMº#ÜH 3gÇqÏÛx×u¢¦õ%B½ª+EJÈ2óUV¤dÉrY2¤
Ü1ý@kÓnSËüÁ¢6§4äò2¾1fæ µPÔUM8Wh¥TÆÜã¿j$zLÓÉJ=³æ^µé®õÎ6#ELiNÌC±Ò7ß íÀVÇ¾u_ÓTÔÓ½E:ZU ©¯pÆ$$Éç?N5ô,Ý5k¼ºßißE½cI¢õ³ ¾¢Jgwqàjz±Ó_#×J¢C,3=ÁË´[$7îà23ÇqO&Ï¦Ç«gMr»<êÇhh­U·Z2\¼ñ$¦ÝµlCÉp9?ñ®vó®7ÙÈ¢¶©ZÜÃAMn]Ð+HY²L{}° ç<ê[U®éo!éêÁç%WÐeÊ Ï5ÒßS%:Æ(i`3.]Þ±ÁKÝà{oÎ²sÛÙÕè<ÚQºz×Þ­cUóµXUô»qî'k!ü9ô:o@YjYmÏ­
2 *©MÇÎB¢Èp§ þ5q»SÛæ²¤0wâefMË	cdà·¨`öÔZ4¢0íÓORýð¯$Ó£i ¹]ÀnÔ9ÆèÞg©yÛªä¦¬§¨{U4ªJ4Rè»ðÙ÷Éã$:D¶Å-Î©Ö¶Zj5Â6Ù.Hnìóútªço¹ÉuïÔ$»RA&ÄÇ¤ #ü§é×Fªy­õKÆRniÑBÚ9Ïé àíçÎÈÈæn«ç+g:ã)üâØ;XH*¢¦)¨&F4ÌØ¥`6I=ÈÜ0<0;#R)"5µÂïOAKeÖi`fTÛêdU;>ÖêçS>vXj'À°¡UX¦N²)£ç!±VQ*IÊºÙU
m%e!%Á"EôÌ¸Lñ´±+äé=¾e¸ÉO];@e*æÐÊREÁíû	à}µÞhÅUÚ*u\+FÊÒTE¸&Fráÿ ß§3Ð¥
RÕ\^VÒUdú26ÊIÎtVº/(Æm7ÙÂjêêvÌ¯OOäðdC$PHÉÛÿ î5"ÓS$óÉÓß/0É½¢(ãap0cú²§#8Á×:Ê»hymÔÕ5Ú%§Qç\ç* ñÛÃcüØ×K%E¾áÓu4T·y)ÿ ¯ ©" ·Ð2y.<
ÙöÕc+deiq#Æ¦ÿ Ò$5YN%©XW	89
®?W>5úë[RöÛ4tµ¬"ÞH)U³ÈåÏäð1®öëS[l§3Q--4«Ã19r
àî]þ8ÖJ¯æÔë5y¦HÕ³­+n*ÁØ³Äî¶à ÕÚâÑí6Mº[émÕpµcU-lðxhYBÅ/§é¨ãÇ¶¥Ó\©*mÐ>æíz¦p;[À;Ky¨OW"èæúgÂÀ
ÊÃ,>F5Î¾ç¤«H!ù£e2îh	8b¡Wp?r<ê-®lRW.ÑiêK¥jZ(-4ó«[¨>^A)Êó'$ÆOãP
ÙvíÑ«ÔT2÷H ãrÂ¯@ñ<ie²²ÖµñµH$@0ÞVPáOqãVûÏPÚ­zkU® XTÖ=S]Hl¤jëÃåÜþÚ¬ejÙgª0»8õQµ¤0JDäA*'|}yÏÚ­ÐÃEGU9¸ÈÎÄÂ¢6y$¿Wwìq«T})Yz:jHòi[Â§àg9Õr®KMMÈËiL6ôÈrÎÁN<ã?VoNTã¶'(­ÒÕ\#Jjæ>Öùpøô³r1öÚ:ÚF¹Æ6WÖµt®R(iøul|å¶nÚybA:iC`hà ¨¦­zóìÁQÏ« Ç5ß<0ßÅdÅf©{	&ÝWh sÀðyüê\¹¯2EOÎOt¦HæhIö	°²AÑúvê®ÒIBÚæËÈmZCÊzc@ÜxÝ¦Ô5PÝâ2RhR,ç>¢É£Æá¸ý'8Îÿ 3Ðöêi~Ð÷;³wp8ôêïÜpT ­êà$ª¨YVÊÒÕß';N3¸ä®IkÙUlÒÕ4òni'dlªåÉÿ /:ç5@IîPÓ­<Ð¼`æ^Üq$gïÀÝ³êÖ×øË­%¯x0¢8ãúÀ8÷ý´\Ôi,pÁä~
î×»ÿ R¥®Þ¦¢éQ"B
(V( B *Y¹ç$m}?ð?áÔ_l_+¿óùÁÈE"%>áO$ûU¿ï_ì­¾¨¿Ãÿ êµ=; EmÈÏÿ ÅaÎ}öH<czá±;rÍ')r²=õ®
Æ³¬Î=õ1¬äkuQÈ]Þ5"2XkHwq¦4ù`HÕËtP`®DQ®tñRut.G&ÚÎÑ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£FÁÖg[hÐy UGN4ª¦.4öuÈÒú¨ÿ «G^!2§Qðs¦UQ5Ue<jëá£:Ôÿ [=ò5«xÛíª´t·k­ÆµÔ Ñ£F4Áã4h%øïðº«¨ç¬z<:²
Ñ(¸"m9ÿ ÒÊ~¡yÆüøÂboåWèjZ¶ iÞÉ¢*}@<¶OÒpFÞ<ëÚ°9àùÿ »^uñwá5¯A¹ÀÉiê8××ªq/¶Ù±ËÌ9ÕeåvRTã¶JÑí9ÔVëý°VY;ùe
Ùh#ØþÜêT&ã$4Ð¬k¾c÷óø×Ç½#×]wð©ß×Tõº­t¥¥`1$}ap1ËgÎ¾è~»ª¨éê)zÜ*$S$´ñÆ%HÁ ¼ÇØ«C-ñ#ÌÍ¡.X¹è¨ok¦9QÎ£Í²eTTÊÛJV®¬ÕËOÖÜEAe9÷.xn=^ÛLéR¹UX½T³îN¶NÎ¨Ú­'ÂóÛ*?ë®Ð¼aXäçÔsº¬Õ+øQûë²öÆpTüçB²ÊÇv9Æ~úÍJ« pÑqí­iÅJM Ð¦=µÖD íÈÆt!¾Hb7@Üàþ:®RVISs¦¬1ìRíO4gÿ ÄB
Ï¶	#í5e¸ÌÜ¹L²¿¸çJ«âZîFr»Õòj²:ð´Èr#1µÁ
Fôuus½Aãg©×ÛÔ Öm]º[e àÄK4k°úAÿ |úõñsù
zµ*ôÔë´`)oQî¹_ßwãK¯ÕrE7SÃÜ;cKKÚÛ¡rã úqÖ§ïª9WFðéù$Ø.Q5Ú+¥#UMAP´êº¾èöî«äúë²@:Y;ÒÚ"S0æo§y'x°q¬µ=\$»`¸Ä°×pÃr î<ý³¨×ç©µNð«M¦QÅý$p9eÆ3Ô&oEË${ÒYºìöË}À,¶ùµ¨lÆHÃ }×õ%âåYOmºÚRÓTÁÔ©áN@ý³¦÷¨¤µuAºÁ**³»Q²G®GÛôùó¥u×{eum=Æ'¸T@§duÜd>ì3£pÏöÆ¸²dröI£Ó,4ÓµÙË«.ÝGhY¢¬ù¹ãî"Þ#½AÆïÉÆ«vJ®£«/KoY7U>¥y'-@?×Jº¢I)®Fª¦Þ"sN²öÐ4q´KsçÛLPÜÿ Ãq ¡ùª÷0Yä
ãvò~¡ìu¢äí71jïó:Ý*.¦8.¯IV<ÀÍ3mV#+°ÝÆ8Ô{%]U$S¼FgÂÇÊTl7üWå
sçPmÖÊÃÛ»ÖÍ
Jñ=Ô-òr àÿ ®Üï°SPRµ<©ävMòqCe;½«d=UJ´WeÎå¢¸Yiéã"`vú2yl~<~t\¤¢Xd«ï1IÝIT¯m°m¼æWÜ!Tª%r¡É3tû7~JË¸Xû*¶°Uc8ðF2ÞuÎ×oþoAWÕ$ºBTI#¶QJ¦7êÜÇí­!Á}ÓI/_Í
º®¢Ð8xÒ¬L@ 79È#rÎÃEYëª&ÃMF©Û:êí\·v¾äéEÿ ÓµRÉWq¨Ý;±c9 ·+éä<q¦Û|wNêC,;#VTt&hÏ-àðF7jÛbÎuIWÏK}ðÛ)û&¡íd2(Ã4 à8ú´âY($°SÓ+"Ïó±XBåFç
 rTQÿ SÜïik©1­9§M¡¥{o
	1b6ý9#>ú4p¼©-ZÆ¦!#Fwà¤xãägñª·]âmYa¦ßnTgKp¢îSv*}L[·êSéÛvsé%Ì¼öØêä°ã¦ZD¯$eNWbs´ùÀÉ$¨éÅETu°@2 ª¡fÎ¡êcôå
VÕ\`Ç:cv¯©¬§o§¿ÌR&6*ú³áN Xø#UÚ«o{áÑ^§¤²5¯¹`¦¹GvûóÇRNð@-\`(ÚqëÝ©u×9"ºÝ@¡³U'u¦`J cñ´¾=>tSÜnöîí$R5<I8i©X8Áo±9=9Î¥Zúz;Ôw©Ö¦9»MQ@9o,¥6ï
öÛöc¤S¡.ÿ ÉÍIGx²	":Fª/JLªUèÀç¸ôÛý ¼ÑWôøªj¸¦it'Õ·#{çöüé5Á¢v¨©µÖ·Ëvaä$¹ÎFåÂúr3Î¤Ùêd£<°$ëYlS¹T|yÑº5#N7ÀÎ Õi-JðO! y@$c#wÒ{/# ÓÑ*{Ålõ­"3¶P,x%ÄùoôÝ®¦Ã5=«hªæ4Q#*CÞÀ¶Häøàj®ÏK$ÑÁOU$çtons?Ì>ÚËkgSZü.uF;¼)-~gw# 2ïaÀöÚ8ÜÞ52Û%=ed¤&³2KÜV-µ0H#vrs¨¨
¥á
ÇO*¶Úf=É%MÛ8åÃPUOß\ê;ÕT1Pª÷¤V+ vDW ÜÜùñ«¸ZF.æÔz'ÔÅÚ%²éD xaPqôå@@Ì¾ TVTÚ-¿#q¥|Ë3ÎïiÊÿ }GöMoCoºVÂ¶úËhòÊ@6`ñ«~¥ã%,|çJéØÉKUv¿Yp
ª±Û»l¸`èá]úÍ:"ÓI4²ÿ /®ß
=3:¡²  ¶ÒÉ>¯vãÛNz>2µwJ~áÜÕª|`68Ôr9Ï5Õ*©©írÓHÍ=VÐêH*Wiå¾ QÆ«=]z× ¨¼'È Ü¤-ó«/RRo&Fgâ/Sí£è H`Xû0¢±8½3H@NÑîFkü6t$MÔu¥Î1n¡u%;r­'ébOÕ¶¼¾ZÞ¡ç¯xÒveU8y<$Jyü/>uögÀÞ¦¾Ø¨jrµSCóòxy}@sÈÂë®¬QçÉáju2Ï«1cÉÖ4h×Ak8Îç[¢@³ëüëe÷ÔÐ25Ò4ç}h2}µ2"N¬g*;ÒAñ§T°£Qè #g
m²<}F[èÝ<km`xÖu'hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4dj-DyãRõ¤+¡dÚUGxÒÊjÁUAÒª¸ñª
k)Î¥J>5ÄyÐô£6Î[Nµa×]hàcw:¡¡ÏFgAÐ#lFG¡Ñ ðNïËmêß%¶ïo¦¸QÊGr
¤ßÎ¼#¬þß:Zµ¯*fxÀÌ¶ÙeÔ$ºò|}>æ×Ðz=Á÷5IEK²µNÑã
?§9Ö´ÒÒUBR¥§;ñH¾ÔúÛs¶ÜmböoñÍB±87çã3¯8øð÷¤:ê/ÖÁó¡qÂ»5QÛýcþkÈ¤è?n_Í,	×t<SZÚr»Ðp|Èüh ¯³.9^×ûXRÖGUQÚ¢¢i VÄ»P²ËÛÎ§5E4rvScK6'$~N¼£®¹TgRPÖôõr®Ù{Øp|Æ?orx+zû]ìSÙãª2´5<#SÃÞîq»o 8üëHä<ÜyÂ\¡×ó
E²ÓF³Å»,	}kq¬H(ZYBVobÄÿ ~£ÒÌU¢Úbâ,îÀFW
¥|3þÔÍó4oN®²Iõ,kîAÈç÷Z&34åLéI\*"zQ,mSLêµ	í´OìGQè»´vÞÓ7qrà+újÑÅO=YNÛÔQáädÜÇ`¾ï"#£3]O±ïö¯ænáµñÐâ4
:UF¬À¾ÉnWß÷Æ¹ISV×j»}=?yæ§Yå'<~£¹qã}ôã¬ii®jã}ýp«´ÑÙë+`Ý%E%½7¤úqûÿ Me*ÝHíÅO
euïµÎõEI4ÔÐÆûdÁPwm¤càüiGu»PW*Ô7¼\\U-+Î%¹äcJúÚûÓ©#U©f:ÿ Oåe`?Èço¤ä·ÜR):­â²\­78å§ªT<!äLúõ«Éã?æÖÉv{ôÑÔaâ4Ð§¬j.ÝAMp¨yÙ©!nÒÏé*ÛÓÇÔÀãt­e
KWºUÒñ% vízAÀô{4Ù'¯N¦5Zx{²QÆÖ<+(óÇW>N£õ%Lí=-®8+dOiRT\
K7,sÂºc:å»³Ó½5µ/kÍÊº¢¦³d×JîS)IÐ;O·*AÔÊÙ'jjU©xi¤7²î2${N÷`IÏF ÎºõÊ¦ñ[='MÌ,ïEÝª$þÈç îÝ¨àº­EA$s3­26Ø¤Õ*¾WºúHárs»$~u¦ÔEµl±@.5v+â®jTO¨©É&FÂ7*cn»ßP/TÈ¬êf·ÒHVÛgbã
î>9
÷ÊçMé#FXêèííÆ&v5hpÝíÅI#]¯¨"Ù¯Ì×È§ºW´É`*RAÏÞÚ´nJ«#+ò-³Diºj)V®3+;Â\9;½_~5åNwIåpw¥¤GÌ
ñ,#w§wn9^F}þúi®Û§¦µV­Xc"{¤k­ÀAôñÎ·¥¤ªªjê_úÛäíÅ¤#p|uJéW\ì´Ú3d5°ÍÓªU(Feä¢¶
§ ð1Æ¥Úc¼=EE@ AºU£J¾ìF¥½:åF¦+DÉT¦FOIn
1î¼ç\¶Ùv³XVh¦	W¶7m8È$}@=Ö[ìèX#!{Õ1Kv)(H±xð·«ÿ wSk~N·äæhaIyi8ÊB 	ý$'|éETÔõéQAl¬dá£Ë*2Ã±Æ¤VÝo:7·¤pM:ÄÝ´VíÆ¸ å±Á`l	>N¨·{/v»EWoJU*×a3ví
ê¥äøÏ¤6O¤cY§¢¶==¾jXè0ybXÀIÃÝ»IÊ¶×Oß\7LñOÌÈQrÑ	1BÀ/ Il:eKWYGT*å¸%4ÞQ²5bª }Y6xã>kv.k4$­6!ßù~î {éôS)5T2¯¨)j[ÙÈÏßhÁþÄê,ýC=\TÂ¾9é²ä»äþ¡ä³uóMDµÓZ¨ºÛV),ë»WhPÎ©¹rÀ óÜüjÑ·Ê3riO±6ËmcM=l	F@ÅRTI'$gäýXcEÕq§§YªÞ8E¸"ÌCíÂ©Á; >@ÉÒé)mÕ
tJÕGReQÊª"
6í#kr1É
Ç¶º,;®é%OÌ¢6ög$27é¶à¹ó§Ù,9.	÷k)o(£·Û«ÊÎ¢F ¬ÍÇ<mñÁÒêÚz(Ò7¯§§åÍD©
°)9 òä}µÚéêïSP½®)h pDYb»I Õ'ÇjkßJ­24í9&ya`ç ¿ý$Æ|7¿ìI¸VÒÔ\élë$&ØîÐñ@  ¨á2A %r|êE%}î¢;U:C<q!1¬awHsÌðHñ®pW
S$õSÆ´)2ÙwGú{xwÀÒXn¼
k¨¹ÓÓÄdWFci9
Iãîu	´èºQ]£ÃÒS[ë%ï\)§FÏl9ÄÉ>¬ccJ¨©6ºJ)£O\6mÑ9ap=À!@<tkÒOòëP²Ý(ãßÜ>¯YûcmJª½QÚªëé>rY@ia¥£GõÁ#,| 8ÿ 6u2´KÔS_)­(ó¤P0uj-þ7ÔcoÐr|û°¨ÖHnÚ÷nÊaieg\ö¾§lzË
r2Öõ5Ô³ÎéÈTìÑ °£ûjéCQm°-D­44é±;{ÜssåI?qôãiÖØ¾çñ3¹ñmÓ6Zn¦øÓÝmDµPÈU¡½D>Ê\ûàaï}+nçÃí¯þz6{ç[ÖÄ
]Ê­éi&öÈ²ëÝÏucUO=ËtÜF4hÑ­	6m¬
dûêz <nük ë¤i©\:AG5¡pu8ÀÓº8p£Mf£+\io¶¤ÕF5¾®yr{hÑ£BF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
cYÖå,y.ª6öÔjÁöÔ5f¸çB	ãÇ@9÷Óº¨¹ñ¥õàê´z¸²p/9_:ÆF5Ò@wsãZ7C;bìæÀxÖ¸×FúÑÆª\Àó¬î×FÉ#ÿ -cF hÑ¬}@1¡}'+ÁühÑ©°èÎêø{}Gc¤¯l`LWlËíÃ¯¨ÿ ®¼Ú·à9µÈúæñÓò¡ÊA4$°d ãðCkÚ1 ùÔ4¿#Â'ê¿_$ÝSh=Ijê­ ¤@£põ¨VrÀr«oö?úg¯èÖ»½45É=½ã1Î¤®xÝõäÊû§
JTHÁ#í¯(øðZÑy¬þ}ÒìPÆÍ ttò1ó¼l'üËÆ«M>|¸csßÉìtT¸u¯ÀÜ×	ôòOHÿ ÝÓ©D=ó1,Wn8\ýþüy×Íö?kðú÷J|a¥¨ÒFRõEy¶ý;Çé,Têuìî  ºôMÏ¡nõËOÛ1ÉTûâ©<Äg«ú°ÉIDïñI>V+3«iÕxØþr6ø ·Æ¹Xª^HjkÞ:XäÁÑw²áÆìk½µèëúb¢
gãs0IÉs	bY£ð©ÈãK°S3ÓÍDñCQ,
Q¸àùóÇÍ«¹_ìyû¾éWC½­´ÎöÌ`ÄÐ`¸Àö8oop>Ú¬^©iÞçYr. ¾X×±q7 ØÝÀ×³4+UQ(¥Dû#fB`:ôäãö×]¬Õ6ÚùTRS®å}ÄØ¹¼²áÀð3®<°iñÑõTf½Ü?r³
º¶¦ÏS	µ$U*
Kl¨.aX¶
çó¨¦¥èi©a¡[¾a(ì¬0ßÔ¥hòqûi=]MrÙ#¨WÌ±ÎrJÊSçãûçÛQlô¼sTZÙÑÊºBvÀwx|ÌªªðiÊÝ)®5©mUÄÓÃZVI%uHãö´áFåÉä$I¥bõu/ÙWMàÂØz]XfG9ÏßSi©RTCKYÅQ$zÏy3´®2Aóí«I:~¬µJeiQñ0m¹3©eà@À9Ö«³u*£¿C¼RUÐÚ.¦-D²XçA¶HÎâs)<~tºÄvVÊ)ËÔÂ®(Ë3YÜ(Lm* ¦Õ¶éiê)¥1-]-4¶8ß7m$ã8'o÷×^¶I_Ãn·odyexÕXàmcÈAî­×G$.sI-â{%Y¶Fâ¼ÑJã(ËObÞnç'GÍ]¤©5Ó±ÁÇÈ¤g<­ÊçËq¬ÓÕ^¦Jg+JíHaÄ¿ÒIq,r?ìñûëJÚºØ" ¦­Ká"¦q, *ú$GP=L7xÀÎ²ÜÒèï6¾É[}e%¢²µ$cXèàÎÈVÈ [}^ÚGMv)+PÍM%<ÄÒÌåj{'*vå#q| ~úaORUM
:×WÓ8RÃ#¿l+mÚÙpxÀÀÆâ<xÒÎãÔT¯nZâZQ·Àãs£æãU|¾
7RJO£´T«;C,¤zP_îBã<0µ\¡¼\à¡zz8°Y7ñ*¿#Á<xÒõ¾yatzª8=À{qyÊMõU ó5ÚöÔuEáE*#F"ë¾eÊáX'©@ Bs·u+f»|D²íªÏ@)Új#byªU9î¡ÔxÉÀóçU¸jkê¦¢ù%|»²'§Hç%cnA
£>Ù×!Q-zS­[$TòNcxdmë+KH±®ÝÀB¿ã[Ø©c 1Ö
ºii1Ë,ÅH nN?á?}YU&c¶jÚ|d§·\Ì[+ ­T
á'aj.÷±ÆpÞ¸Ñv¥£º¢{¥M¹ch¤c4´õ:ä'kzOéuã®hê¦G«
R#¢Ès_¬öàe:s½[êSü«@V%
FnO$±À'Ë`ãQ|â+ÝØÞ¦i§oyÑjipIä('j1Äc}Îµ²×MCm²í4³<b5ìÀyA÷MÁê¹u½V×HëQ?ÉHpJ¡"\màñ>úu5wIª«-u3Ã%8YÌu>@p$û¹Á?bp<j)²ËÅFC«Þ5Z3@Õ5Cv ôR ¦ÆfÉp>¬©$ó¥3Ýî·«ó9×æHS²+Æ RÀôãËy×=p§¥ñRXäÔ,eÕb§ü@0tÊJÈ¥enÊSÆÐ¬&ndaPî÷F0£Æ­ÑXnÈëÁy«¤è"'¿¼#w'fÉ.GÜ	ÈÓXç·ÓJÕFßM[q
TÔÎCÓÓÆr©Ìù'åÐé<9ÂP*³Ô+SÎª	K1\m^GÛJEÞ\uR>%¦QCðN%ËÈ<óãT§f×Íï·*{EªZw¢VG#çlf'+¸)_9Ï
<jS=ß­k£¨¸	(±2r¦¼p~¯OçQª]ú¸ÕK§¤ 4Té!;ÈônOî?OWK5<ÔÔÙx!JrY0ê#ä6|dã'iÎ5tö.;9nZÜ."¿r5}Ü³	³9´Ôà0h²b zä²ê¹U×B(iÃÊ6,íÎ3ûõ}Í®µÑZèí'«¸IÁs¸p9ñÎ¤tm¢+Ä~éïÇ-bv8Ï5®5Ê8µ³I8ãé^ü2±¯Mü:°YpièÐÉìL71?ÝújÄ5
ÔåWÒ3çÆ»(ð©ó¬¯uó­´H¸}lºÀó­ÔjRTsøÔºxòA\!BØmCÈàjN=FJDªpÆÄ (×!Úº5¢<l³rfthÑ¡hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£X$Î³ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hZH¹N·Ö4B©ÉÆÔGä§³&áãKê!ãÏý5VuaÉB)ãÁç:ããMª#Ë`étêA#U=lSGF¹ù<ë£yÆµ<j­QÒsÑ¬Æu
4hY':Æ hÑ£@ddè95³r4Ç·Æ²x:Æ~³Zoöm»u5ÆlïtÜ ûî­ÿ ç^Ôº¿áÍÂ^ªøGt©Áim²ªÉ2ä(<LûÚú+X^5
&QÁ3Â>|t¦ªªX§¥§¶×¢z«MWô d@Kveo¥²HX$ã^në9ºJ+Cu°ÓI&ucíõÃnóm)ø£ð¥úÿ uTÈö«ÎÐ¢áJ ´a*xqùó¯¿Y~&|-íÅ!êNÝ ­=9ûÚ^#ÿ ºÆqå¼Mÿ 1ñOy¢ºÖTÞ,gæ4rÝO¹ÉÁä{ =¡^/vªd±J ¤]4Õ*1>àyËcp¼¦z£§:ÊJ
¸­7qÙè+§UZïVwÇ!à6H;OØ}µz±Hëó4öúÊÉdR²4ÑFXvæaÞdÉÊëQëãXZSèCÔÔés¶G5tj]X¨TeFIçv2¹óÏuVIé/t·[3TÎ Jª·Àlc jÃx{UÈÖjºÉ)²ªÍNÑ!Ú®c'kgßØi|w#+|ÃBbdíï/*79!%Pv®|1çY/j;ç³"µÀ¾{e¾&`à3E*(pUB@;}[ðF}Hu3½U°Ç,#¿S2#1À@Ã#ljU5Lt4õ´uitdh:Îx ãøÿ ²>ÚG2[½o¸(¨ªMëHò:Hw¶íõpp1<êÍÑÏ²1ãÈâáM=oyJ:Ý©#@ù=,	wÏpoçQi+à 4E%ÄJ³¸¿*r«H>Õþ5¥DôKmUKua0Ó8w`£¸[20v¡V\ç²Â«DwÃ¼ 7/ÙlçJhË/+a{2$uBIå2vhÐ9!`Þ=µ*å:SÉPñÕVR[æ#¼ì±È$ .Ý¥wÎ|S'¼ÝuH¢zjxª2Ý¨P«´ø,ßPûé¬¹ozZëmfhjdÁVBa±@ãoçF¥Ò"9ñµî;Öu%}5$/zÑ0;(*ZVu+%9r þ®8×
E«ª¶ÀòWó2)U%e*ìØlÞ#%uÂlÑ[V¾ãx¢¬*z)µ!$Þl ¶wsBª¢ãê7\@"]í#}N<¡
H>tÛ(²¾¤&9¶LÕ5õt6ºñtU)i%.¡WÈdm¹'%s·<ë^ºQÑ=¾Ô¼·Jð0u>>WôäÎ¹Û®
¢8}¬H9Æçv# ãÛéÀ'Î¡ÝEe<Ã%\÷i#ùX I1%±»88ÔJÙÑlÊ**¥{²-&ÙU9ErKD°pûu'«¥(
®·shÍ<r±Þü6G©xÁgA÷Ô
[¤oLJDxä©\1À¸ö ¹qÎÐ@àém
¢ºjÁQO"L°*ª÷±ÀGíäúíª¤KÉ>R$ÐÉRj©L­b`Yâbªx3µ-Ækyðç\XPÍSóÔTÒ[³ }ûX3Ùú|g<ó÷:GFñ<ô¢Ydp0X"ö'8;²¿P$cu½
ZAnZJY.(+"	Y Ì7R2Â2¡[ÒêÇ¶ «ÄóÓ=Âx) ìéQ`r9$¶<{jkÓRÚ¬³,w'¹,f6ÖfSÇÓêò¾E_'·ÇM%Å¥dhÑ)ü'Ü9p£Ïí¤PT,F²·¾ÆÛb@KÙÜxÀ$¸Ï8ÑYVåöL·A
U.(í%S¼ÕHÀöqF0ªÛÉôûjeu}%LÅ÷&çSÜ]ËÎÐ9÷]¼óÎ]¯µ­L©{ÉPÈ
¡ª%o¡pIÇ÷Ò;]%mÍfÈc (P¤±lù ¼ñ«R«(ó4öÀ±IÔUô6n/ÛÙv{*Ar$VD.¾~>çïªÕ
¥¥nõÎFSé1B·õHÐ¿«MZhR¢EG¨?§26ÒCFâÇ8Ó=Òö¤ºU2Ë4 V,Â8ÓÌ`_SduKq\MåÖ5ék%SËYut8Q;ÂSÐ6îØ¥	ûê³ÕÅ-BÄ±âË·pÃiòA 7ÜL½WSQØ@TS×ÊÝÙQ¦F*H »>pIEÁeú]Ó+%ÉnÑ»|<K´2Iqï¨IöÎ¬²Øý,}ºS¦å¦¥.±#WL=DÁ÷
DA|l9çïÆÿ Báñö
PRI(ÎÓ°ûrÇý5Êås«ù9^ßª¨Ç¹½X·ÖBBnÕ»øM¥ù®¶êë¿¤,Q,(¹ÎÍîNýêÄ÷IN²c}ÞN±­Îu2<ë¤å6ÀÖthÆun O¶º¢äûµªóï©Tñå³«d(á'yI@3¨tgM¡Q·©£ÇÔe³ ñ¬ëYÕ Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4há4z­Yr4a6¢¢Vq¥u1Xæ?}+«Î©G¡(Ó
®L0ÚSß"ú´=\r´r<k­õ3ãT55Ñ¬¬hF Ñ£F5¶áûk]-ÉÖ4hÐ4¬¬ªT´0Ç}Ük4¾|ðy_ÄÝ	ÕZ:wéûsÞ¢QÙs÷xOÝvx÷Pü2øÉÑ´ãùd­ÔÈ¸_s1Eãÿ DßÔ_é'Æ¾µöÇ÷ÖA#N|çQIöUEÅÜ]
MNVæ1ÚôÕTì
¨# á¶ôn¸S º$Ñ¼hØíÓ#Vò»YT8àåµõ÷QX,]I¨,ÔE;(ü67ìuæKü:|?¹3Mjë`ûÓÏÞgÏ¦\ýTÙ^}Bþ£Â[¯í±T"R3(±-26A#÷u¥?\õwÆMÍK`úÝ<dëÐî¿þ ôÅº®ºÇÔÖ;å<QÊ]²²)ö½s|ê³ÓÝwÕ5Ê³WðÂÅÔÔI<Â$¥W> J®sÆÝeéÑ»ÏP÷L®EþÔÞ×Tõ]ãb;µ5&ÂB fÈ û}ôï¦:¯¨ëâuÚJ¾¡;ì'µvª%dûa¦4:BÌ´/KT#®¾
»%'<ãqÎ¡Oñ#£k«~v»§{ÒbBýê§H¦Ó´+õàñîºö"0NNLÞ«áñ³BtêzZJU¨:kN%ôóBXï»1\¥bÓÓt½ë»J¼;¨ÚTç#b:£<Øl{ê4÷;{Óvl=Iq@²¡%`IÆÅÊ1·ZÐÍW1Üáu"]á¥y
G¤d 2O$ênOà´1+^ç÷,50tÊà¼!GH)ÀÚª2NOÓÁôis\¡µFÔ°Ñ5LË($´äËW  ý±ùÒê#ü²I6\³6SnBÊÁrNAÊ	ûë¥E²Rï©m´ª°H&mù9eÜÞÜäñUE¾Í?uÄRüòÔ¨ÞU	VECà{3/Ï8ÓZ&¦©D¯¢q,vÍË¨9rw/¤`ãóªý,ºD×AÀ$M¬ÇÛ`ý> çï¨×£¦C&CXg9+äç°Õ}9x-\ÔË¯ZUTÖ°¿>XéÉt*Ø_J(ÀÁÀÇÀ4°WüÜ|õ5$E}f!'n@Öúä`í ¤Tv¹H³RÐÔTÔn;&x]Ø\mDRI'ÀO¾¼5à1«U'õ)Qß³$0É<·«8±üL2?±&  ³RDØÝgJwêë&îHÊw±Åôr9å¿:_%ÌÖ×DòÌc6Ú^L¶èòFÑ»¸ÝÇãL©(¬4íõ[#AßÏ+´êu¾Ã=ecÛ¨í0Ë¶è}Äî+¸!;IÈ%O#¯³s;¤bifN)¥âi7âhS¡%7gi#jûd¢UÛ*.ênÜrÌI±+s¸cÔØ#-ã9¸ÍH*áº¶3)×)!f
É&26±Ë}×çPï·*é®1ÇCOJV(ûxx|<sê @8#uL×}ø²5ÆÛl xSp0Ái L±ásÆï9çÆ´zKõTS<km¡b@BÊec0T6òO:f\V°*¹( Ê°Î Ï>ãßLcßO-VÚxë$}¦(EB1·w¾9Ç¶¡´¸.±Ê\Õ/²ÙmtpÓµByÈ$ËQ7Ë)o;;|gkp®ç'¨iÀHéÌbrF %}Kî  åñÎ·_sÔÕU¬TiO¾H¢V.ÄíÆFvíÙ>5
Ùî¾Z§å©.Ê6ÕÊwdÈX±DÏjoK"(ýLãkçîQÝç§Í,ÑÛ¡BHmÄXïåGàj|ÒGD³ÑK
ò²»ò<ÂùÔØñò"¢háßI R3Ü;X-äÀ}øÒ+Ô¢èâhç©1Y2±²J#3ÆLd/àê[.¸zç·äðzR6Ú§
+ÛdHúYÝ´y
¯ÁÍª'Çqøsÿ ¨²f£¸8¤âY¼ì5Â¤Ïßó¯@þOOõ\)!ct  z$¿¶ºð>O'\©Åû¬§`s­ëÊgY_Æ·çJ!ºFÑ.tÎÄj%<y ãNíñG:²G§*DÚHÂÀÔ½h5¾®xÒ°Ñ£F4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ¸ÈÆ¡TDñ©úç9Ñ¨¯ÔÁÏ,¨x:²ÔDNNÕÆFp5J=L|
ck\H¨øÁ:=;0|k]n|kgÆ«EÍth÷Ñ 
4hF Ñ£F4hÑ 
ÈÖv®m´ëSÆ4{çßFÎª©¥hÞ2¤kçáz²¢Í×QÓ3´ñUONÔùBBq'È<¶?lëéä{kç/PÔ|=þ",uF^¼<¬«î ):¶ô þKV\2~(·õ £®éGWm­(éRXVQ!0rO9É_f]Uú× ,ë$5Up5¼e¨o4q´6W2·¯wHô·{Ä^ÕSuE$0OÛßQMé"rrßñÞ ç}Vº9®6:ºÂdª¶I+GYGPìë«Vò=L§pÞ8:Â'_'£µu(óùüü)uÇCÜºbí-±el%QN%ÿ Ø7.A'ñ¤±AM%fÆexË³F²ßRnç¶y×Ô}gÒôHõgk6¦®÷,ApÄú°%¿AÕf_ÝqL×õSÁnVC;£,.x î'sóôøàzue>i£6sßV
j*H*ãáLÕYa©IJ}|¯¾?×húz¶Ç_Wk¯z)lf¦p§<~uè÷?Ö¢Yþ*XnP©ÙÕfSU$g$àqÆ©rË_a¯ß¨òÍ0YAáã8Î@RãêëkéSÃÝH éYLÒÅ¶ÀIw$^ìpØúßSmÖIù©3oñöÅ½qµx>IÏçÛáKy³%;5OFÄ×UÃÅ+\.Û+î4{w09S¼yçtjë£/=Þ
*t,ÐÅêæ'PL³HÇÔ[!sÁá+áD%
CE²á}©ic
)¢§*$råT ®<»ÈÎ£ÉÓõ¿ÎV*u@£kÒÂã+'d² êÉñ­é¦~§ìiÙ¡¢¨U<iTllmôá|
<§®êk¼í
Ëb¢ãlmå½yçêÝùu¤gn,rjâÔ¶úüÎ=ÒA#©¤°VáFýÐÞ?P×[¿R[á¶¥
$p«<ld÷»ÉúWÉÉ;I>u¶Õn3Üj+ªr¦å<7©ÎÖÁN|ä}uÙÕÜ®üÀ!¢¢ÆÄ%ÈÎÝ¼NÜ.<¬ëÉÐòlö£gôÄÐAAvá-2olmÛÈàðFW>üjSËµ,lèÒ¿mÊO%OùIþpH\g])Ã54sC[#ÔIQ®Ñí·<dÿ ¨Ô*æI)R!p¡$ WÚCçÏ ßYÊ)8òJë}LT'y¥i
ì¦¦/#Îí¸
WÔØ>¯Æ§½ubK$ÒÛ¤µÄ¬·4éÂ¨^Ì`;ÏãY¦ª×Ó2`s¢(Åît¬ çYG[Û&»]émðÅ7z¥8PCa·`ÙöÔ(¥É¤²Êév7ÄðI=º:*tJÓS£:«oõúÄo¥AÉÞ3ãXéªuYª#¡´ÓD{¯*4$Bÿ r}µÖÍ{n¼e¢ÙúdÄQª¯ôâRG­ÆI$ßIºÝ³PÒR½= 6Ä£mYd]ÛNUCaê<JUÉIýÁ=:ms&D»OORjêï"HY#íD¦X£v£@WÑ"óê>O>uR¶ÔÕt²W@²CXU¥Øò ÂnAäªªHÆHÎÞöQÀìô#wjD`ÍàNqã<þ~uÎí:º½-*ä»:O Ý»ÔNOu{Q1É¿3¿¾¦¬¸%P¢¤Aµ¤Zõd ùAøÇkü)Þÿ |Vêá"º£ãVÝýX2ýÊGiAr<S*.Ê¦rÊd\/¸óãT{õewOõÂÞ(eùj¸çZäø'ÆH÷É¾	T¹9X£?ï ¬ëåþ"z®Õ4í­;¦Cÿ ÒSö&P|`ÿ øûaOç_Ct?XôçZÛ
Ã§.iV«þ4$lÿ g?>5Ü¤3ÔEy<®±ðFµPIñï÷ÔW-ãW\)pM£pNÒGÔt^24Ú1Æ¥&¦vèßF±ÉA£F
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
4hF Ñ£F4hÑ 
jÃ:ÛFá2qÆÔÁtÛ\'@G®9´ÊÕT$¥ò ßV*ªp}´® ¤àPö4ÙmO¾~uÖ2uS°Ôù<kßjF5Ñ£F5¶=õ®¶SÆ4çë×M`4Èë­³ 2ãBè:*29Î´®Ê}#:ç0ÉÎÓF :¤|rèïößáµÂÛOµÒ|Ý½±È9 #pÈãß»liÜr¡¢%ÑçÂÄqÖQÑìEyµÀaÆâ$§w±¹xÎl­±õ]ejÍYMSI%2F[®<îbø:ñV;·Ã¿T_:E
2OR­;)ÄI1>¤p?Ds|ý½ö¢íhë.´uÍäe*Þ¡mà²7°!k`s¨|ÇÑÇ^F¥Ô¿ÜS-BØÄ6áG)gcÈG «!*8'ÓyÝm?I4RÜ:hÛåHÍîH¡²¹ðlnnT¯«õF.rWQG--lg^×kdtyÇ Äÿ <g\:²ìï5=KÂw
ôÕÙ
´ïPÛYI÷ÖåQééêM³É«ï[@PÒ%Â¸©¦Ý´Tc·ÎpÜyÔ»GYü?¯¥ùÓ{¤ßµeFacC;G8ð|iWÚo´oVÔOArTImãqTS
þ¯r3·Hê­³üòÉ%5ÅaVgW;rK²1 å\ùÏ:ç©cëÖN:»ýD-ÓÝ,C}&(Bz±à¶Ð0g¥²SÛÕÄöúÔª¦Á©TÏ6[
 mUb*@\ä¦ÒZzª¾ª+%TTÔîJxI`qÉÿ « àr4»¤+ãÕ°´PB¯1>áa¸¨Ëé1|ëE)?¨á5 ·Ï
ªÿ ÈQ4û»µdàúWÿ ×LiEÊ¾¦*u5:«¨#µf`©îHK6ì$m&JjJ;|PTÔ¸EY;¿7)î
kðPAûÆ=ï¨Mª8)*¢(ËÑSÀh×a£/ãQ8·Ò#E|)ìhUàcÔË·~bª±;q@<<j}
%8ãKP¾Ââ
rÙ9£ÁoOý3ôëµnE¨»ÜgE ò'~¡Èç8ä}µõu¦µP5u³æwB­IQpXÕJà0ÃãÜç[àéõqÅZDêê¿æKOQ¶É*dSÁI§ÀLÀçSsºÒ[Ý|Ì.2Ò²;`úÉlc\°>¬(Ö·J©¡£pÔâR1Hñ¡÷0l!lð¤\©­æ¸ÇKMRT«S·Ë¡
ðê
c í]ÇvrJñ£vKÉ,Êà¸ù"%ºqI:ùlu ñ+íÊ³tåp¾Nu2®áEUu¦äID¡ £·Àg-ÛF3´ÎÖf ÆÝH  ¸\!Z*®ÄB$fWÑõ+Q'éÏ<ñã[Üc°Z(æ¬jÓQBy*1`Ê[hPÀ½õXóßD¥(ÇÙç¶Æ4tÕµ]ªëÁE=ÕF¥^8pÚ#/ýg#*H\Xi5EuoRÝ
]¶Jk`u7ë\zÃÙ±fú@ k¥=ãªkh$©FH+E5/mfÛÉ
FaKooFZî´Ð«ÇC@ùi"X&zX1_@#8åoÔx$ HÔÉ¨ò8±Ë$ªOdÑRÐEGÓX¡g Y§,\ûeôãÒ;ô-Í V8»<A76X 'Çý<éÖZh\9hÁ7w6C¸Ã7ÛC}'¹Þ%kl×dæ&j
Jð2yã\êÜC3<[QÂQR\b$±JX£ñµcÆÇãËb }ª?)ª«+L|ío8ûûôþª¥!8©g¦r®®Ø,	)yô£4¢¶'4Í¿¼À¯sÐ7`ý<g##ßÑ}VpæK&,èÛñ£í5r(Ô¨ïcÿ µ»Ï÷Óz*;¿OÝb¾tí\Öª7Fcô£}är='5_¯´¬°%\N¥$216à<{ãöÕáYÛì/ä}soKÏLÖ]ÿ 8¢aÀ&{¡àë¦-IðÏWhðºk³Ý>ü|¶ÞdÅÖÈ{¾DiXÚzùÏøn~çÓ¯ iràçcö:øóâ§Â:»=¶+Õ$¿Ìl2
ô÷Ta¹W»àöç:°ü øã7IOOÑß%Ú²êÙoéY	óØûk¢wR858ä£¾£ìÂó©ZI=<ôñÍO4sE"GÃ+©ý@#ó©](ðe+&thÑ¡£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@Ãë:4IâÎtª²Æ0Î¢UÃ¸j´o&ÖTê"Ãr1Î¸7Nkéÿ S2á±£V{x2)#µ9ó­½õæ§ ñ¬ks­HÀÒ1£ßF²<è©'Î°ç[ëËyÖ9ük:ÆÙu¶µ_}m 
Çî5åF³¬M mØ`ùÐOWôýUôÅÃ§.£A_G¹¸ØäMÇØÁÿ ]xïð]u­´õRü9½&ê)@'Ê =JU¿;uîÇûç9ã_;uÓ¯Aÿ ö¤¦^Å%Ù£aúeþÄ}ìÜê¯Ï¨Çº-#è>¢²¬VS&þÚ8ÙD'êQÿ  Æ5Q¹ÙîÄl·^û5Hæh¬=¦HÛ°ÆW8Îuë]Oª-ÒÓñ¾ÀX 2p=üx×ßiémÝSÀ!¤¯§ï¡#Ë2ÁÎp=ê¹aðFU+H£KAÔÝõ¶Ü+éjéæÂÈ·1SÂÜú2Ç§ñªZtWÙe+LóÙå
JzèJIø
|û5ì]SÓVñ@e)LqNÍê NÝçê_Ï·¾uKºQ%2½WIÞí5òTF±z¹JÈ72î
ÈÊ	#ôãY%·¤fó¤ñºãUSPÏ|iêë."éRdFùOn1öó®4Â¢¦]¦î²LõRF,d¨ô®c\<£5n¸UôÄ±ÃtéiòQ×º8vã#êÙï¤·é 6èº¨ Ê¼2Á^1¹QÈç9Õ]x:yn¤kC?NÑK,pØå¦ Y¤.'ôb2Ü a¹Ýëé¦2CméÈ-12±g.ÓNÄ(ËcÇßQà¡Z¢¥¸$«3ñÜ$í*</;yó©OQVÔSÝ®·JØaQÓÐmHÛÀ`ò²ú·{k/y¦ÜI|deQ1DÝ'¨wäÃgª§¿s%5À³D+[\r³O$&F©`Aò±'Ò2xÆ¡Qå<4³Â­#
âU@ØÂþ2=ýµ!ê,öW-t%ÙÁ¾v¦>à_*6 i9*­äj~^îõ6Éy«@îûþX(Ù£p
éGÓu*z«5º(]û·¿~ (úÛéRrtÞ®Wº<XhV§`+6à#$ò1îªp|çO,]?f¤íßú±êdÉqO<äeüs0vùÛ¤¯Ë5Ç(É)ZÒ-ÂýK-ÂIEIFe¨¨ÕUQã cÎ=_òë
Km¥mÔÔ+5D¹F¨IÈX¡ò0`øäíãÓúë­êÿ ¶9)¨ (ãBAc¸r£õGíM¯ ·Ûl[+kÕÑB6PCl bd©õâ§´.F1W¿¤Ñbá<²$BÇdýF¼NK½Â­IÛ%vv|ïbp=ñ%ª¸ÔYºv¦ÝPÿ 1WDc¯Ìi¼úUÉÈÎ}GvO¾¤½uÂ©#ÎñÕ^ç¡/XáÞ¸.>ÌxUý+É[SMb¢ÛÚD«{OSÙ$Kÿ I,ÎGöÎ¨åfëSkÁÛUIEMò®dGvÒ3¹ÁÂãî<êc»Bnu±o¥HË¤JÅzy
x9ÀÏã]êi¬±Ü§¸¸Ô2SâíBJÈK¥ R?ÍyÎ£\énP@¦Y+ÈbR¡VP¥UsÉ+¸eu06³äo=Î²)êá*h£¦ÊödONÁÁãuÎ«7.Ê õ)rÓÉ?p8Ö×X6ÈÔ´OMP²ÉIËå²Þ8ãïíF
OKº(&5
ÈD «¬ücò <êçë*¢	êä®¦SIYI¶)þçq*HuSê*h&1N&ñ³+7pN?>þq§Ô²²[%bûÊ*oÆHÎìxûgJ/,TôêÎ¦wÝy_°þÙÔÂ4ø1ÕÊ/³î?á¦lôÕDcÛ&ÿ R7VlÏxñð^ynÖ¨n$EbÆä'ÃxÎ¾ø]hþIðç§­e½5ºq¸1@Xdóç:WIOUCUK\d|=õêJ
Hù->¶X2·Ú}¯áÿ ú£á-D4uf{çFNËþêí¨ÁýPçéÿ ÕIöÆ¾×é.¦²õ]ûÓ×kíóýÆs<«!¸<ëç¿ªíÔõä·¬%6JsÓR<Êú³5ãÔÝUðÒïQ|èé¤4{³qµOþ	Ã`.ÓêÜ ~¡÷Ö+#ÆêGv£CSWMýÐ0uy×Áý=ñ2Ìg äî°÷Ëd®óþ!Æ½t¦G$âéÑ£F4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£FkGPA×Mj|/«rçGYñ«,ßáé-ÖuYnèFêßX×IµÏYù=»
`ë:RàgßXu·¾µu Û:ÕgZûhFeÖOauñ 0§ñ¬ßX]@kú´hýZ4ÀkÎ²5ç@`ñ¯þ2)d¦µôÇS@Ò$ÔuíqÐqÝCÝ½ðëÇþå$ÿ ó8?ùrj²3ÈéBË,Í6ö&¦Wunw ?þÝy÷ZÔKENT$Q4ÔU¯L¬Ç"(\ÒGñ±°Så#Wzþ¦±ìcÿ ª7ZæWßÚþe6¯'Áæèÿ Ô'õXZbá¾Zªl¬s¨Ê3RHÎ<àïëÉúúßÑ=Êê+u©;Èv'Ó·òuìý­ÿ Ô·ÿ %uóMïÿ «)?õ±òÎ¹²»>ðÌ1n6«îiYi¸Ã íß¨ª©ESÉ"àà0þ#:wW8¤²EífJsÙîlQ	ßJ­ý¾ù}7ÿ *=Hèñ®_úÖÿ »\r]Æ<PÔ·+]|Ñ¾Hâeâ9*×¼a«q~NÆÞ~ë­M-6z¤YÚ>öWÂmbp?Oþm5«úþÖîMJè¿þÑSÿ íÿ Àuem<0i#­¾óq¤sKo¨¥¦#ÔGOÛY»µ@'>y:Otí(
*{µÊyÌ+Ä%#1
$;z[
TõÕîéÿ Ùjoý@ÿ áMg¢¿ókGíÿ 4j¦Ê(Çg(§Ü(ïbÿ 7f¡G"6,$ e³­¸Î1bËoÜÒª1yY¬7ÞAìIÏßL:Óÿ ·ÿ ë¦ÿ å
N¢ÿ 
óÿ «ÿ Y^æo+µÀ®áz§¶É5%¹ HåØÌ%Ý¿êQì3çÙ°Ç$ 4ªãó¯:%SB.RBKnÄJÙ*Xþ¢FHÇq®æ_ýE'ÿ <j]ÿ ¼cÿ ¶Çÿ êéUÑ»úS"_ÖkF%ùëæ(êf¬\ö 8mU>0¾ CsãUúþqª$j;)Üìêür[bíßÎºõOÿ ^×í¯ÿ v¹t·ÿ \Mÿ åµüshÂË<tbº¤3E®ì¾Ò¤sÀ>Ùó¬¸ê¥U¤]³¶(BàÊì oÞy#[>}µß¨ÿ úÆ»ÿ cÿ Ú7ÿ Stÿ üçþèµ¤:8òÉ¦ÐÎßMm¤£õ±½Iiqö*¯¸nõ1þNhd2D±ª9:öþ5µÛügÿ ßÿ »]-'ÿ Û"ÿ àÔBz¸»4ËL¤[¿¤ÅpC¯¤>sýµ3áWM·]üp±ôüÉ(ÄÂz¿Qâ ]¹3´/ý¡®µ_ýaSÿ µVÿ Þu|þÿ ûã¾ù¿üø5¶\7ñY8`t}¤¡Iàcdt{ÿ ml|ëÑGÇÑÉY
· ùß^!ñÃà÷óïQô¢º©2ÏHWwÌÿ ÂáI#Áàûã^áî5ÎOüÛþÊê%S:4º¬y©Aö~|UÛï4IÏ¥Íeª(J/fQAù,>¤úàÇJ»AÓ½DjêÊ|Ç,/m*
ñÃ%=½µæ_ÄOÿ oWÿ jÿ MxÕßÿ ¾Îÿ ÖPÿ ñraöx=ïÄt¸ó`Z¦ÏÑà$ëmpëoß]õÚ|Ãì4hÑ¡!£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@4hÐ4£F hÑ£@ÿÙ',0,'2014-04-19 10:30:30','5',NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table property
# ------------------------------------------------------------

DROP TABLE IF EXISTS `property`;

CREATE TABLE `property` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `definition_id` int(11) unsigned DEFAULT NULL,
  `property_definition_keyname` varchar(50) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `entity_id` int(11) unsigned NOT NULL,
  `ordinal` int(11) DEFAULT NULL,
  `language` varchar(10) COLLATE utf8_estonian_ci DEFAULT NULL,
  `value_display` varchar(500) COLLATE utf8_estonian_ci DEFAULT NULL,
  `value_formula` varchar(500) COLLATE utf8_estonian_ci DEFAULT NULL,
  `value_string` varchar(500) COLLATE utf8_estonian_ci DEFAULT NULL,
  `value_text` text COLLATE utf8_estonian_ci,
  `value_integer` int(11) DEFAULT NULL,
  `value_decimal` decimal(15,4) DEFAULT NULL,
  `value_boolean` tinyint(1) unsigned DEFAULT NULL,
  `value_datetime` datetime DEFAULT NULL,
  `value_entity` int(11) unsigned DEFAULT NULL,
  `value_reference` int(11) unsigned DEFAULT NULL,
  `value_file` int(11) unsigned DEFAULT NULL,
  `value_counter` int(11) unsigned DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `changed` datetime DEFAULT NULL,
  `changed_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `deleted_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `property_definition_keyname` (`property_definition_keyname`),
  KEY `entity_id` (`entity_id`),
  KEY `ordinal` (`ordinal`),
  KEY `language` (`language`),
  KEY `value_string` (`value_string`(255)),
  KEY `value_file` (`value_file`),
  KEY `value_reference` (`value_reference`),
  KEY `value_counter` (`value_counter`),
  KEY `value_entity` (`value_entity`),
  KEY `deleted` (`deleted`),
  KEY `created` (`created`),
  KEY `changed` (`changed`),
  KEY `value_display` (`value_display`(255)),
  CONSTRAINT `p_fk_e` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `p_fk_pd` FOREIGN KEY (`property_definition_keyname`) REFERENCES `property_definition` (`keyname`) ON UPDATE CASCADE,
  CONSTRAINT `p_fk_v_counter` FOREIGN KEY (`value_counter`) REFERENCES `counter` (`id`),
  CONSTRAINT `p_fk_v_file` FOREIGN KEY (`value_file`) REFERENCES `file` (`id`),
  CONSTRAINT `p_fk_v_reference` FOREIGN KEY (`value_reference`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

LOCK TABLES `property` WRITE;
/*!40000 ALTER TABLE `property` DISABLE KEYS */;

INSERT INTO `property` (`id`, `definition_id`, `property_definition_keyname`, `entity_id`, `ordinal`, `language`, `value_display`, `value_formula`, `value_string`, `value_text`, `value_integer`, `value_decimal`, `value_boolean`, `value_datetime`, `value_entity`, `value_reference`, `value_file`, `value_counter`, `created`, `created_by`, `changed`, `changed_by`, `deleted`, `is_deleted`, `deleted_by`)
VALUES
	(8,NULL,'person-user',5,NULL,NULL,'mihkel@entu.ee',NULL,'mihkel@entu.ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1001-01-01 00:00:56',NULL,NULL,NULL,NULL,0,NULL),
	(9,NULL,'person-forename',5,NULL,NULL,'Mihkel',NULL,'Mihkel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1001-01-01 00:00:11',NULL,NULL,NULL,NULL,0,NULL),
	(10,NULL,'person-surname',5,NULL,NULL,'Putrinš',NULL,'Putrinš',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1001-01-01 00:01:27',NULL,NULL,NULL,NULL,0,NULL),
	(11,NULL,'person-user',6,NULL,NULL,'argoroots@gmail.com',NULL,'argoroots@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1001-01-01 00:01:40',NULL,NULL,NULL,NULL,0,NULL),
	(12,NULL,'person-forename',6,NULL,NULL,'Argo',NULL,'Argo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1001-01-01 00:00:40',NULL,NULL,NULL,NULL,0,NULL),
	(13,NULL,'person-surname',6,NULL,NULL,'Roots',NULL,'Roots',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1001-01-01 00:01:36',NULL,NULL,NULL,NULL,0,NULL),
	(83178,NULL,'person-user',5,NULL,NULL,'mihkel.putrinsh@gmail.com',NULL,'mihkel.putrinsh@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1001-01-01 00:01:00',NULL,NULL,NULL,NULL,0,NULL),
	(83749,NULL,'person-user',6,NULL,NULL,'mart@tftak.eu',NULL,'mart@tftak.eu',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2013-02-25 07:31:10','9',NULL,NULL,'2013-02-25 07:32:48',1,'9'),
	(128833,NULL,'person-entu-api-key',5,NULL,NULL,'your0key0for0communicating0with0entu0api',NULL,'your0key0for0communicating0with0entu0api',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-04-14 08:46:50','5',NULL,NULL,NULL,0,NULL),
	(129677,NULL,'questionary-name',46374,NULL,NULL,'Äripäev 360',NULL,'Äripäev 360',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-04-19 10:21:15','5',NULL,NULL,NULL,0,NULL),
	(129678,NULL,'questionary-start',46374,NULL,NULL,'2014-05-03 00:00',NULL,NULL,NULL,NULL,NULL,NULL,'2014-05-03 00:00:00',NULL,NULL,NULL,NULL,'2014-04-19 10:21:32','5',NULL,NULL,NULL,0,NULL),
	(129679,NULL,'questionary-stop',46374,NULL,NULL,'2014-06-02 00:00',NULL,NULL,NULL,NULL,NULL,NULL,'2014-06-02 00:00:00',NULL,NULL,NULL,NULL,'2014-04-19 10:21:35','5',NULL,NULL,NULL,0,NULL),
	(129680,NULL,'questionary-techsupport',46374,NULL,NULL,'Mihkel Putrinš',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,NULL,NULL,'2014-04-19 10:21:39','5',NULL,NULL,NULL,0,NULL),
	(129681,NULL,'customer-name',46375,NULL,NULL,'Äripäev',NULL,'Äripäev',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-04-19 10:27:47','5',NULL,NULL,NULL,0,NULL),
	(129682,NULL,'person-forename',46376,NULL,NULL,'Mare',NULL,'Mare',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-04-19 10:29:00','5',NULL,NULL,NULL,0,NULL),
	(129683,NULL,'person-surname',46376,NULL,NULL,'Pork',NULL,'Pork',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-04-19 10:29:02','5',NULL,NULL,NULL,0,NULL),
	(129684,NULL,'person-email',46376,NULL,NULL,'mare@joa.ee',NULL,'mare@joa.ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-04-19 10:29:09','5',NULL,NULL,NULL,0,NULL),
	(129685,NULL,'person-phone',46376,NULL,NULL,'5011438',NULL,'5011438',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-04-19 10:29:36','5',NULL,NULL,NULL,0,NULL),
	(129686,NULL,'person-photo',46376,NULL,NULL,'file64206105_be2c139b.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2566,NULL,'2014-04-19 10:30:30','5',NULL,NULL,NULL,0,NULL),
	(129687,NULL,'questionary-organizer',46374,NULL,NULL,'Mare Pork',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,46376,NULL,NULL,'2014-04-19 10:30:50','5',NULL,NULL,NULL,0,NULL),
	(129688,NULL,'person-user',46376,NULL,NULL,'mare@joa.ee',NULL,'mare@joa.ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-04-19 10:29:09','5',NULL,NULL,NULL,0,NULL);

/*!40000 ALTER TABLE `property` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table property_definition
# ------------------------------------------------------------

DROP TABLE IF EXISTS `property_definition`;

CREATE TABLE `property_definition` (
  `keyname` varchar(50) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  `entity_definition_keyname` varchar(25) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `dataproperty` varchar(24) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `datatype` enum('boolean','counter','counter-value','decimal','date','datetime','file','integer','reference','string','text','secret') COLLATE utf8_estonian_ci NOT NULL DEFAULT 'string',
  `defaultvalue` varchar(500) COLLATE utf8_estonian_ci DEFAULT NULL,
  `formula` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `executable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `visible` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `ordinal` int(11) DEFAULT NULL,
  `multilingual` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `multiplicity` int(11) unsigned DEFAULT NULL,
  `readonly` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `createonly` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `public` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `mandatory` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `propagates` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `autocomplete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `classifying_entity_definition_keyname` varchar(25) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `changed` datetime DEFAULT NULL,
  `changed_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `old_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`keyname`),
  UNIQUE KEY `old_id` (`old_id`),
  KEY `ordinal` (`ordinal`),
  KEY `dataproperty` (`dataproperty`),
  KEY `entity_definition_keyname` (`entity_definition_keyname`),
  KEY `classifying_entity_definition_keyname` (`classifying_entity_definition_keyname`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `pd_fk_ced` FOREIGN KEY (`classifying_entity_definition_keyname`) REFERENCES `entity_definition` (`keyname`) ON UPDATE CASCADE,
  CONSTRAINT `pd_fk_ed` FOREIGN KEY (`entity_definition_keyname`) REFERENCES `entity_definition` (`keyname`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

LOCK TABLES `property_definition` WRITE;
/*!40000 ALTER TABLE `property_definition` DISABLE KEYS */;

INSERT INTO `property_definition` (`keyname`, `entity_definition_keyname`, `dataproperty`, `datatype`, `defaultvalue`, `formula`, `executable`, `visible`, `ordinal`, `multilingual`, `multiplicity`, `readonly`, `createonly`, `public`, `mandatory`, `search`, `propagates`, `autocomplete`, `classifying_entity_definition_keyname`, `created`, `created_by`, `changed`, `changed_by`, `deleted`, `is_deleted`, `deleted_by`, `old_id`)
VALUES
	('answer-question','answer','question','string',NULL,0,0,1,10,0,1,0,0,0,1,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('answer-rating','answer','rating','integer',NULL,0,0,1,20,0,1,0,0,0,0,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('answer-text','answer','text','text',NULL,0,0,1,30,0,1,0,0,0,0,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('customer-contact','customer','contact','reference',NULL,0,0,1,20,0,NULL,0,0,0,1,1,0,0,'person',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('customer-name','customer','name','string',NULL,0,0,1,10,0,1,0,0,0,1,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('person-email','person','email','string',NULL,0,0,1,40,0,NULL,0,0,0,0,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('person-entu-api-key','person','entu-api-key','string',NULL,0,0,0,1000,0,NULL,1,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('person-forename','person','forename','string',NULL,0,0,1,10,0,1,0,0,0,0,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('person-phone','person','phone','string',NULL,0,0,1,50,0,NULL,0,0,0,0,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('person-photo','person','photo','file',NULL,0,0,1,30,0,1,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('person-surname','person','surname','string',NULL,0,0,1,20,0,1,0,0,0,0,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('person-user','person','user','string',NULL,0,0,0,1000,0,NULL,1,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('question-continuous','question','continuous','boolean',NULL,0,0,1,30,0,1,0,0,0,1,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('question-ordinal','question','ordinal','integer',NULL,0,0,1,20,0,1,0,0,0,1,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('question-text','question','text','boolean',NULL,0,0,1,40,0,1,0,0,0,1,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('question-title','question','title','string',NULL,0,0,1,10,0,1,0,0,0,1,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('questionary-name','questionary','name','string',NULL,0,0,1,10,0,1,0,0,0,1,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('questionary-organizer','questionary','organizer','reference',NULL,0,0,1,20,0,NULL,0,0,0,1,1,0,0,'person',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('questionary-photo','questionary','photo','file',NULL,0,0,1,40,0,1,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('questionary-start','questionary','start','datetime',NULL,0,0,1,50,0,1,0,0,0,1,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('questionary-stop','questionary','stop','datetime',NULL,0,0,1,60,0,1,0,0,0,1,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('questionary-techsupport','questionary','techsupport','reference',NULL,0,0,1,30,0,NULL,0,0,0,1,1,0,0,'person',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('test-assessee','test','assessee','reference',NULL,0,0,1,40,0,1,0,0,0,1,1,0,0,'person',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('test-assessor','test','assessor','reference',NULL,0,0,1,30,0,1,0,0,0,1,1,0,0,'person',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('test-direction','test','direction','reference',NULL,0,0,1,20,0,1,0,0,0,1,1,0,0,'test-direction',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('test-direction-label','test-direction','label','string',NULL,0,0,1,10,0,1,0,0,1,1,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	('test-questionary','test','questionary','reference',NULL,0,0,1,10,0,1,0,0,0,1,1,0,0,'questionary',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL);

/*!40000 ALTER TABLE `property_definition` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table relationship
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relationship`;

CREATE TABLE `relationship` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `relationship_definition_keyname` varchar(25) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  `property_definition_keyname` varchar(50) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `related_property_definition_keyname` varchar(50) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `entity_definition_keyname` varchar(25) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `related_entity_definition_keyname` varchar(25) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `entity_id` int(11) unsigned DEFAULT NULL,
  `related_entity_id` int(11) unsigned DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `changed` datetime DEFAULT NULL,
  `changed_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `deleted_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `old_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `old_id` (`old_id`),
  KEY `entity_id` (`entity_id`,`related_entity_id`),
  KEY `related_entity_id` (`related_entity_id`),
  KEY `relationship_definition_keyname` (`relationship_definition_keyname`),
  KEY `property_definition_keyname` (`property_definition_keyname`),
  KEY `related_property_definition_keyname` (`related_property_definition_keyname`),
  KEY `entity_definition_keyname` (`entity_definition_keyname`),
  KEY `related_entity_definition_keyname` (`related_entity_definition_keyname`),
  CONSTRAINT `r_fk_e` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `r_fk_ed` FOREIGN KEY (`entity_definition_keyname`) REFERENCES `entity_definition` (`keyname`) ON UPDATE CASCADE,
  CONSTRAINT `r_fk_pd` FOREIGN KEY (`property_definition_keyname`) REFERENCES `property_definition` (`keyname`) ON UPDATE CASCADE,
  CONSTRAINT `r_fk_rd` FOREIGN KEY (`relationship_definition_keyname`) REFERENCES `relationship_definition` (`keyname`) ON UPDATE CASCADE,
  CONSTRAINT `r_fk_re` FOREIGN KEY (`related_entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `r_fk_red` FOREIGN KEY (`related_entity_definition_keyname`) REFERENCES `entity_definition` (`keyname`) ON UPDATE CASCADE,
  CONSTRAINT `r_fk_rpd` FOREIGN KEY (`related_property_definition_keyname`) REFERENCES `property_definition` (`keyname`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

LOCK TABLES `relationship` WRITE;
/*!40000 ALTER TABLE `relationship` DISABLE KEYS */;

INSERT INTO `relationship` (`id`, `relationship_definition_keyname`, `property_definition_keyname`, `related_property_definition_keyname`, `entity_definition_keyname`, `related_entity_definition_keyname`, `entity_id`, `related_entity_id`, `created`, `created_by`, `changed`, `changed_by`, `deleted`, `is_deleted`, `deleted_by`, `old_id`)
VALUES
	(1,'owner',NULL,NULL,NULL,NULL,5,5,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	(2,'owner',NULL,NULL,NULL,NULL,6,5,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	(4,'owner',NULL,NULL,NULL,NULL,5,6,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	(5,'owner',NULL,NULL,NULL,NULL,6,6,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	(7,'allowed-child',NULL,NULL,'person','customer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	(13,'child',NULL,NULL,NULL,NULL,5,46374,'2014-04-19 10:21:15','5',NULL,NULL,'2014-04-19 10:28:29',1,'5',NULL),
	(14,'owner',NULL,NULL,NULL,NULL,46374,5,'2014-04-19 10:21:15','5',NULL,NULL,'2014-04-19 10:21:15',1,'5',NULL),
	(15,'owner',NULL,NULL,NULL,NULL,46374,6,'2014-04-19 10:21:15','5',NULL,NULL,NULL,0,NULL,NULL),
	(17,'owner',NULL,NULL,NULL,NULL,46374,5,'2014-04-19 10:21:15','5',NULL,NULL,NULL,0,NULL,NULL),
	(18,'allowed-child',NULL,NULL,'customer','questionary',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	(19,'allowed-child',NULL,NULL,'customer','person',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	(20,'allowed-child',NULL,NULL,'questionary','question',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	(21,'allowed-child',NULL,NULL,'questionary','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	(22,'allowed-child',NULL,NULL,'questionary','answer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),
	(23,'child',NULL,NULL,NULL,NULL,5,46375,'2014-04-19 10:27:47','5',NULL,NULL,NULL,0,NULL,NULL),
	(24,'owner',NULL,NULL,NULL,NULL,46375,5,'2014-04-19 10:27:47','5',NULL,NULL,'2014-04-19 10:27:47',1,'5',NULL),
	(25,'owner',NULL,NULL,NULL,NULL,46375,6,'2014-04-19 10:27:47','5',NULL,NULL,NULL,0,NULL,NULL),
	(27,'owner',NULL,NULL,NULL,NULL,46375,5,'2014-04-19 10:27:47','5',NULL,NULL,NULL,0,NULL,NULL),
	(28,'child',NULL,NULL,NULL,NULL,46375,46374,'2014-04-19 10:28:26','5',NULL,NULL,NULL,0,NULL,NULL),
	(29,'child',NULL,NULL,NULL,NULL,46375,46376,'2014-04-19 10:29:00','5',NULL,NULL,'2014-04-19 10:31:04',1,'5',NULL),
	(30,'owner',NULL,NULL,NULL,NULL,46376,5,'2014-04-19 10:29:00','5',NULL,NULL,'2014-04-19 10:29:00',1,'5',NULL),
	(31,'owner',NULL,NULL,NULL,NULL,46376,6,'2014-04-19 10:29:00','5',NULL,NULL,NULL,0,NULL,NULL),
	(33,'owner',NULL,NULL,NULL,NULL,46376,5,'2014-04-19 10:29:00','5',NULL,NULL,NULL,0,NULL,NULL),
	(34,'viewer',NULL,NULL,NULL,NULL,46374,46376,'2014-04-19 10:31:48','5',NULL,NULL,'2014-04-19 10:32:02',1,'5',NULL),
	(35,'expander',NULL,NULL,NULL,NULL,46374,46376,'2014-04-19 10:32:02','5',NULL,NULL,'2014-04-19 10:33:08',1,'5',NULL),
	(36,'viewer',NULL,NULL,NULL,NULL,46375,46376,'2014-04-19 10:32:35','5',NULL,NULL,'2014-04-19 10:32:39',1,'5',NULL),
	(37,'expander',NULL,NULL,NULL,NULL,46375,46376,'2014-04-19 10:32:39','5',NULL,NULL,'2014-04-19 10:33:01',1,'5',NULL),
	(38,'editor',NULL,NULL,NULL,NULL,46375,46376,'2014-04-19 10:33:01','5',NULL,NULL,NULL,0,NULL,NULL),
	(39,'editor',NULL,NULL,NULL,NULL,46374,46376,'2014-04-19 10:33:08','5',NULL,NULL,NULL,0,NULL,NULL),
	(40,'viewer',NULL,NULL,NULL,NULL,46376,46376,'2014-04-19 10:45:47','5',NULL,NULL,'2014-04-19 10:45:50',1,'5',NULL),
	(41,'expander',NULL,NULL,NULL,NULL,46376,46376,'2014-04-19 10:45:50','5',NULL,NULL,NULL,0,NULL,NULL);

/*!40000 ALTER TABLE `relationship` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table relationship_definition
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relationship_definition`;

CREATE TABLE `relationship_definition` (
  `keyname` varchar(25) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  `created` datetime DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `changed` datetime DEFAULT NULL,
  `changed_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  PRIMARY KEY (`keyname`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

LOCK TABLES `relationship_definition` WRITE;
/*!40000 ALTER TABLE `relationship_definition` DISABLE KEYS */;

INSERT INTO `relationship_definition` (`keyname`, `created`, `created_by`, `changed`, `changed_by`, `deleted`, `is_deleted`, `deleted_by`)
VALUES
	('allowed-child',NULL,NULL,NULL,NULL,NULL,0,NULL),
	('child',NULL,NULL,NULL,NULL,NULL,0,NULL),
	('default-parent',NULL,NULL,NULL,NULL,NULL,0,NULL),
	('editor',NULL,NULL,NULL,NULL,NULL,0,NULL),
	('expander',NULL,NULL,NULL,NULL,NULL,0,NULL),
	('optional-parent',NULL,NULL,NULL,NULL,NULL,0,NULL),
	('owner',NULL,NULL,NULL,NULL,NULL,0,NULL),
	('propagated-property',NULL,NULL,NULL,NULL,NULL,0,NULL),
	('target-property',NULL,NULL,NULL,NULL,NULL,0,NULL),
	('viewer',NULL,NULL,NULL,NULL,NULL,0,NULL);

/*!40000 ALTER TABLE `relationship_definition` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table requestlog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `requestlog`;

CREATE TABLE `requestlog` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `port` int(65) DEFAULT NULL,
  `status` int(3) DEFAULT NULL,
  `method` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(1000) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `arguments` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `time` double(11,4) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `browser` varchar(2000) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;



# Dump of table searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `searchindex`;

CREATE TABLE `searchindex` (
  `entity_id` int(11) unsigned NOT NULL,
  `language` varchar(10) CHARACTER SET utf8 COLLATE utf8_estonian_ci NOT NULL DEFAULT '',
  `val` varchar(2000) CHARACTER SET utf8 COLLATE utf8_estonian_ci DEFAULT NULL,
  `sort` varchar(2000) CHARACTER SET utf8 COLLATE utf8_estonian_ci DEFAULT NULL,
  PRIMARY KEY (`entity_id`,`language`),
  KEY `entity_id` (`entity_id`),
  KEY `language` (`language`),
  KEY `val` (`val`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tmp_file
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tmp_file`;

CREATE TABLE `tmp_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(500) COLLATE utf8_estonian_ci DEFAULT NULL,
  `filesize` int(13) unsigned DEFAULT NULL,
  `file` longblob,
  `created` datetime DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;



# Dump of table translation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `translation`;

CREATE TABLE `translation` (
  `entity_definition_keyname` varchar(25) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `property_definition_keyname` varchar(50) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `relationship_definition_keyname` varchar(25) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `field` enum('','description','displayinfo','displayname','displaytable','displaytableheader','label','label_plural','label_pural','menu','public','sort') CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  `language` enum('estonian','english') CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `value` varchar(300) CHARACTER SET utf8 COLLATE utf8_estonian_ci DEFAULT NULL,
  KEY `language` (`language`),
  KEY `entity_definition_keyname` (`entity_definition_keyname`),
  KEY `property_definition_keyname` (`property_definition_keyname`),
  KEY `relationship_definition_keyname` (`relationship_definition_keyname`),
  CONSTRAINT `translation_ibfk_1` FOREIGN KEY (`entity_definition_keyname`) REFERENCES `entity_definition` (`keyname`) ON UPDATE CASCADE,
  CONSTRAINT `translation_ibfk_2` FOREIGN KEY (`property_definition_keyname`) REFERENCES `property_definition` (`keyname`) ON UPDATE CASCADE,
  CONSTRAINT `translation_ibfk_3` FOREIGN KEY (`relationship_definition_keyname`) REFERENCES `relationship_definition` (`keyname`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `translation` WRITE;
/*!40000 ALTER TABLE `translation` DISABLE KEYS */;

INSERT INTO `translation` (`entity_definition_keyname`, `property_definition_keyname`, `relationship_definition_keyname`, `field`, `language`, `value`)
VALUES
	('person',NULL,NULL,'label','estonian','Persoon'),
	('person',NULL,NULL,'label','english','Person'),
	('person',NULL,NULL,'label_plural','estonian','Persoonid'),
	('person',NULL,NULL,'label_plural','english','Persons'),
	('person',NULL,NULL,'menu',NULL,'Setup'),
	('person',NULL,NULL,'displayname',NULL,'@forename@ @surname@'),
	('person',NULL,NULL,'displayinfo',NULL,'@user@'),
	('person',NULL,NULL,'displaytable',NULL,'@forename@ @surname@|@email@|@phone@|@birthdate@|@user@'),
	('person',NULL,NULL,'sort',NULL,'@forename@ @surname@'),
	(NULL,'person-email',NULL,'label','estonian','Email'),
	(NULL,'person-forename',NULL,'label','estonian','Eesnimi'),
	(NULL,'person-surname',NULL,'label','estonian','Perenimi'),
	(NULL,'person-user',NULL,'label','estonian','Kasutaja'),
	(NULL,'person-email',NULL,'label','english','Email'),
	(NULL,'person-forename',NULL,'label','english','Forename'),
	(NULL,'person-surname',NULL,'label','english','Surname'),
	(NULL,'person-user',NULL,'label','english','User'),
	(NULL,'person-email',NULL,'label_plural','estonian','Emailid'),
	(NULL,'person-forename',NULL,'label_plural','estonian','Eesnimed'),
	(NULL,'person-surname',NULL,'label_plural','estonian','Perenimed'),
	(NULL,'person-user',NULL,'label_plural','estonian','Kasutajad'),
	(NULL,'person-email',NULL,'label_plural','english','Emails'),
	(NULL,'person-forename',NULL,'label_plural','english','Forenames'),
	(NULL,'person-surname',NULL,'label_plural','english','Surnames'),
	(NULL,'person-user',NULL,'label_plural','english','Users'),
	(NULL,NULL,'allowed-child','label','estonian','Lubatud alam'),
	(NULL,NULL,'child','label','estonian','Alam'),
	(NULL,NULL,'default-parent','label','estonian','Vaikevanem'),
	(NULL,NULL,'editor','label','estonian','Muutja'),
	(NULL,NULL,'expander','label','estonian','Laiendaja'),
	(NULL,NULL,'owner','label','estonian','Omanik'),
	(NULL,NULL,'propagated-property','label','estonian','Propageeruv väli'),
	(NULL,NULL,'target-property','label','estonian','Sihtväli'),
	(NULL,NULL,'viewer','label','estonian','Vaataja'),
	(NULL,NULL,'allowed-child','label','english','Allowed child'),
	(NULL,NULL,'child','label','english','Child'),
	(NULL,NULL,'default-parent','label','english','Default Parent'),
	(NULL,NULL,'editor','label','english','Editor'),
	(NULL,NULL,'expander','label','english','Expander'),
	(NULL,NULL,'owner','label','english','Owner'),
	(NULL,NULL,'propagated-property','label','english','Propagated property'),
	(NULL,NULL,'target-property','label','english','Targeted property'),
	(NULL,NULL,'viewer','label','english','Viewer'),
	(NULL,NULL,'allowed-child','label_plural','estonian','Lubatud alamad'),
	(NULL,NULL,'child','label_plural','estonian','Alamad'),
	(NULL,NULL,'default-parent','label_plural','estonian','Vaikevanemad'),
	(NULL,NULL,'editor','label_plural','estonian','Muutjad'),
	(NULL,NULL,'expander','label_plural','estonian','Laiendajad'),
	(NULL,NULL,'owner','label_plural','estonian','Omanikud'),
	(NULL,NULL,'propagated-property','label_plural','estonian','Propageeruvad väljad'),
	(NULL,NULL,'target-property','label_plural','estonian','Sihtväljad'),
	(NULL,NULL,'viewer','label_plural','estonian','Vaatajad'),
	(NULL,NULL,'allowed-child','label_plural','english','Allowed childs'),
	(NULL,NULL,'child','label_plural','english','Childs'),
	(NULL,NULL,'default-parent','label_plural','english','Default Parents'),
	(NULL,NULL,'editor','label_plural','english','Editors'),
	(NULL,NULL,'expander','label_plural','english','Expanders'),
	(NULL,NULL,'owner','label_plural','english','Owners'),
	(NULL,NULL,'propagated-property','label_plural','english','Propagated properties'),
	(NULL,NULL,'target-property','label_plural','english','Targeted properties'),
	(NULL,NULL,'viewer','label_plural','english','Viewers'),
	('person',NULL,NULL,'displaytableheader',NULL,'Name|Email|Phone|Birth Date|User'),
	(NULL,'person-entu-api-key',NULL,'label',NULL,'Key'),
	(NULL,'person-entu-api-key',NULL,'label_plural',NULL,'Key'),
	(NULL,'person-photo',NULL,'label_plural','english','Photos'),
	(NULL,'person-photo',NULL,'label_plural','estonian','Fotod'),
	(NULL,'person-photo',NULL,'label','estonian','Foto'),
	(NULL,'person-photo',NULL,'label','english','Photo'),
	(NULL,'person-phone',NULL,'label_plural','estonian','Telefonid'),
	(NULL,'person-phone',NULL,'label_plural','english','Phones'),
	(NULL,'person-phone',NULL,'label','english','Phone'),
	(NULL,'person-phone',NULL,'label','estonian','Telefon'),
	('customer',NULL,NULL,'label','estonian','Klient'),
	('customer',NULL,NULL,'label','english','Customer'),
	('customer',NULL,NULL,'label_plural','estonian','Kliendid'),
	('customer',NULL,NULL,'label_plural','english','Customers'),
	(NULL,'customer-name',NULL,'label','estonian','Nimi'),
	(NULL,'customer-name',NULL,'label_plural','estonian','Nimed'),
	(NULL,'customer-contact',NULL,'label','estonian','Kontakt'),
	(NULL,'customer-contact',NULL,'label_plural','estonian','Kontaktid'),
	('questionary',NULL,NULL,'label','english','Questionary'),
	('questionary',NULL,NULL,'label_plural','english','Questionaries'),
	('question',NULL,NULL,'menu',NULL,'Setup'),
	('customer',NULL,NULL,'menu',NULL,'Setup'),
	(NULL,'customer-contact',NULL,'label','english','Contact'),
	(NULL,'customer-contact',NULL,'label_plural','english','Contacts'),
	(NULL,'customer-name',NULL,'label','english','Name'),
	(NULL,'customer-name',NULL,'label_plural','english','Names'),
	(NULL,'questionary-name',NULL,'label_plural','estonian','Nimed'),
	(NULL,'questionary-photo',NULL,'label_plural','estonian','Logod'),
	(NULL,'questionary-organizer',NULL,'label_plural','estonian','Korraldajad'),
	(NULL,'questionary-techsupport',NULL,'label_plural','estonian','Tehniline tugi'),
	(NULL,'question-title',NULL,'label_plural','estonian','Küsimused'),
	(NULL,'question-ordinal',NULL,'label_plural','estonian','Järjenumbrid'),
	(NULL,'question-continuous',NULL,'label_plural','estonian','Pidevskaala?'),
	(NULL,'question-text',NULL,'label_plural','estonian','Tekstivastused?'),
	(NULL,'test-questionary',NULL,'label_plural','estonian','Küsitlused'),
	(NULL,'test-direction',NULL,'label_plural','estonian','Suunad'),
	(NULL,'test-assessor',NULL,'label_plural','estonian','Hindajad'),
	(NULL,'test-assessee',NULL,'label_plural','estonian','Hinnatavad'),
	(NULL,'answer-question',NULL,'label_plural','estonian','Küsimused'),
	(NULL,'answer-rating',NULL,'label_plural','estonian','Hinnangud'),
	(NULL,'answer-text',NULL,'label_plural','estonian','Tekstivastused'),
	(NULL,'questionary-name',NULL,'label','english','Name'),
	(NULL,'questionary-photo',NULL,'label','english','Logo'),
	(NULL,'questionary-organizer',NULL,'label','english','Organizer'),
	(NULL,'questionary-techsupport',NULL,'label','english','Tech Support'),
	(NULL,'question-title',NULL,'label','english','Question'),
	(NULL,'question-ordinal',NULL,'label','english','Ordinal'),
	(NULL,'question-continuous',NULL,'label','english','Continuous Scale?'),
	(NULL,'question-text',NULL,'label','english','Text Answer?'),
	(NULL,'test-questionary',NULL,'label','estonian','Küsitlus'),
	(NULL,'test-direction',NULL,'label','english','Direction'),
	(NULL,'test-assessor',NULL,'label','english','Assessor'),
	(NULL,'test-assessee',NULL,'label','english','Assessee'),
	(NULL,'answer-question',NULL,'label','english','Question'),
	(NULL,'answer-rating',NULL,'label','english','Rating'),
	(NULL,'answer-text',NULL,'label','english','Answer'),
	(NULL,'questionary-name',NULL,'label','estonian','Nimi'),
	(NULL,'questionary-photo',NULL,'label','estonian','Logo'),
	(NULL,'questionary-organizer',NULL,'label','estonian','Korraldaja'),
	(NULL,'questionary-techsupport',NULL,'label','estonian','Tehniline tugi'),
	(NULL,'question-title',NULL,'label','estonian','Küsimus'),
	(NULL,'question-ordinal',NULL,'label','estonian','Järjenumber'),
	(NULL,'question-continuous',NULL,'label','estonian','Pidevskaala?'),
	(NULL,'question-text',NULL,'label','estonian','Tekstivastus?'),
	(NULL,'test-questionary',NULL,'label','estonian','Küsitlus'),
	(NULL,'test-direction',NULL,'label','estonian','Suund'),
	(NULL,'test-assessor',NULL,'label','estonian','Hindaja'),
	(NULL,'test-assessee',NULL,'label','estonian','Hinnatav'),
	(NULL,'answer-question',NULL,'label','estonian','Küsimus'),
	(NULL,'answer-rating',NULL,'label','estonian','Hinnang'),
	(NULL,'answer-text',NULL,'label','estonian','Tekstivastus'),
	(NULL,'questionary-name',NULL,'label_plural','english','Names'),
	(NULL,'questionary-photo',NULL,'label_plural','english','Logo'),
	(NULL,'questionary-organizer',NULL,'label_plural','english','Organizers'),
	(NULL,'questionary-techsupport',NULL,'label_plural','english','Tech Support'),
	(NULL,'question-title',NULL,'label_plural','english','Questions'),
	(NULL,'question-ordinal',NULL,'label_plural','english','Ordinals'),
	(NULL,'question-continuous',NULL,'label_plural','english','Continuous Scale?'),
	(NULL,'question-text',NULL,'label_plural','english','Text Answer?'),
	(NULL,'test-questionary',NULL,'label','english','Questionary'),
	(NULL,'test-questionary',NULL,'label_plural','english','Questionaries'),
	(NULL,'test-direction-label',NULL,'label','estonian','Suund'),
	(NULL,'test-direction-label',NULL,'label_plural','estonian','Suunad'),
	(NULL,'test-direction-label',NULL,'label_plural','english','Directions'),
	(NULL,'test-direction-label',NULL,'label','english','Direction'),
	(NULL,'test-direction',NULL,'label_plural','english','Directions'),
	(NULL,'test-assessor',NULL,'label_plural','english','Assessors'),
	(NULL,'test-assessee',NULL,'label_plural','english','Assessees'),
	(NULL,'answer-question',NULL,'label_plural','english','Questions'),
	(NULL,'answer-rating',NULL,'label_plural','english','Ratings'),
	(NULL,'answer-text',NULL,'label_plural','english','Answers'),
	('answer',NULL,NULL,'menu',NULL,'Setup'),
	('test',NULL,NULL,'menu',NULL,'Setup'),
	('test-direction',NULL,NULL,'menu',NULL,'Setup'),
	('questionary',NULL,NULL,'menu',NULL,'Setup'),
	('answer',NULL,NULL,'label','estonian','Vastus'),
	('answer',NULL,NULL,'label_plural','estonian','Vastused'),
	('answer',NULL,NULL,'label','english','Answer'),
	('answer',NULL,NULL,'label_plural','english','Answers'),
	('answer',NULL,NULL,'sort',NULL,'@question@'),
	('answer',NULL,NULL,'displayname',NULL,'@question@'),
	('answer',NULL,NULL,'displayinfo',NULL,'@rating@ @text@'),
	('answer',NULL,NULL,'displaytable',NULL,'@question@|@rating@|@text@'),
	('answer',NULL,NULL,'displaytableheader','estonian','Küsimus|Hinnang|Vastus'),
	('answer',NULL,NULL,'displaytableheader','english','Question|Rating|Answer'),
	('customer',NULL,NULL,'sort',NULL,'@name@'),
	('customer',NULL,NULL,'displayname',NULL,'@name@'),
	('customer',NULL,NULL,'displayinfo',NULL,'@contact@'),
	('question',NULL,NULL,'label','english','Question'),
	('question',NULL,NULL,'label_plural','english','Questions'),
	('question',NULL,NULL,'label_plural','estonian','Küsimused'),
	('question',NULL,NULL,'label','estonian','Küsimus'),
	('question',NULL,NULL,'sort',NULL,'@ordinal@'),
	('question',NULL,NULL,'displayname',NULL,'@ordinal@. @title@'),
	('question',NULL,NULL,'displaytable',NULL,'@ordinal@ @title@|@continuous@|@text@'),
	('question',NULL,NULL,'displaytableheader','estonian','Küsimus|Pidevskaala?|Tekstivastus?'),
	('question',NULL,NULL,'displaytableheader','english','Question|Continuous?|Text?'),
	('questionary',NULL,NULL,'label','estonian','Küsitlus'),
	('questionary',NULL,NULL,'label_plural','estonian','Küsitlused'),
	('questionary',NULL,NULL,'sort',NULL,'@name@'),
	('questionary',NULL,NULL,'displayname',NULL,'@name@'),
	('questionary',NULL,NULL,'displayinfo',NULL,'@start@-@stop@'),
	('questionary',NULL,NULL,'displaytable',NULL,'@name@|@start@-@stop@'),
	('questionary',NULL,NULL,'displaytableheader','estonian','Nimi|Kestus'),
	('questionary',NULL,NULL,'displaytableheader','english','Name|Duration'),
	('test',NULL,NULL,'label','estonian','Ankeet'),
	('test',NULL,NULL,'label_plural','estonian','Ankeedid'),
	('test',NULL,NULL,'label_plural','english','Tests'),
	('test',NULL,NULL,'label','english','Test'),
	('test',NULL,NULL,'displayname',NULL,'@questionary@: @assessor@'),
	('test',NULL,NULL,'displayinfo',NULL,'@direction@: @assessee@'),
	('test',NULL,NULL,'displaytable',NULL,'@questionary@|@assessor@|@direction@|@assessee@'),
	('test',NULL,NULL,'displaytableheader','estonian','Küsitlus|Hindaja|Suund|Hinnatav'),
	('test',NULL,NULL,'displaytableheader','english','Questionary|Assessor|Direction|Assessee'),
	('test-direction',NULL,NULL,'label','estonian','Suund'),
	('test-direction',NULL,NULL,'label_plural','estonian','Suunad'),
	('test-direction',NULL,NULL,'label_plural','english','Directions'),
	('test-direction',NULL,NULL,'label','english','Direction'),
	(NULL,'questionary-start',NULL,'label','english','Start'),
	(NULL,'questionary-start',NULL,'label_plural','english','Start'),
	(NULL,'questionary-start',NULL,'label_plural','estonian','Start'),
	(NULL,'questionary-start',NULL,'label','estonian','Start'),
	(NULL,'questionary-stop',NULL,'label','estonian','Stop'),
	(NULL,'questionary-stop',NULL,'label_plural','estonian','Stop'),
	(NULL,'questionary-stop',NULL,'label_plural','english','Stop'),
	(NULL,'questionary-stop',NULL,'label','english','Stop');

/*!40000 ALTER TABLE `translation` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `provider` varchar(20) COLLATE utf8_estonian_ci DEFAULT NULL,
  `provider_id` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `picture` varchar(1000) COLLATE utf8_estonian_ci DEFAULT NULL,
  `language` varchar(10) COLLATE utf8_estonian_ci DEFAULT NULL,
  `hide_menu` tinyint(1) NOT NULL DEFAULT '0',
  `session_key` varchar(64) COLLATE utf8_estonian_ci DEFAULT NULL,
  `user_key` varchar(32) COLLATE utf8_estonian_ci DEFAULT NULL,
  `access_token` varchar(1000) COLLATE utf8_estonian_ci DEFAULT NULL,
  `redirect_url` varchar(1000) COLLATE utf8_estonian_ci DEFAULT NULL,
  `redirect_key` varchar(64) COLLATE utf8_estonian_ci DEFAULT NULL,
  `login_count` int(11) NOT NULL DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `changed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `provider` (`provider`,`provider_id`),
  KEY `session_key` (`session_key`),
  KEY `user_key` (`user_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `provider`, `provider_id`, `name`, `email`, `picture`, `language`, `hide_menu`, `session_key`, `user_key`, `access_token`, `redirect_url`, `redirect_key`, `login_count`, `created`, `changed`)
VALUES
	(1,'google','103228544448049423783','Mihkel Putrinš','mihkel.putrinsh@gmail.com','https://lh6.googleusercontent.com/-QkLzfgk85RU/AAAAAAAAAAI/AAAAAAAAENg/EwwpUOI7wNw/photo.jpg','estonian',0,'psYqoN38atYnjAFUmifA5IzNtXTsDLYc17c1610d5194cdb010b77681540c4bdd','0d9823baab723d3008b573e06db9915a','ya29.1.AADtN_WCA-4ow27fM8RE1S32448U4p0LMMZ6P3HB5sW3eq_rr7ghR1Ktcl6QzdHlyyFiwpms',NULL,NULL,0,'2014-04-19 10:16:51',NULL);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
