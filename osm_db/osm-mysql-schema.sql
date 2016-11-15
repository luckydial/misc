-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.77


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema osm
--

CREATE DATABASE IF NOT EXISTS osm
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;
USE osm;

SET foreign_key_checks = 0;
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
--
-- Definition of table `osm`.`acls`
--

DROP TABLE IF EXISTS `osm`.`acls`;
CREATE TABLE  `osm`.`acls` (
  `id` int(11) NOT NULL auto_increment,
  `address` int(10) unsigned NOT NULL,
  `netmask` int(10) unsigned NOT NULL,
  `k` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `v` text default NULL,
  PRIMARY KEY  (`id`),
  KEY `acls_k_idx` (`k`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`acls`
--

/*!40000 ALTER TABLE `acls` DISABLE KEYS */;
LOCK TABLES `acls` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `acls` ENABLE KEYS */;


--
-- Definition of table `osm`.`changeset_tags`
--

DROP TABLE IF EXISTS `osm`.`changeset_tags`;
CREATE TABLE  `osm`.`changeset_tags` (
  `changeset_id` bigint(64) NOT NULL,
  `k` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL default '',
  `v` text NOT NULL default '',
  KEY `changeset_tags_id_idx` (`changeset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`changeset_tags`
--

/*!40000 ALTER TABLE `changeset_tags` DISABLE KEYS */;
LOCK TABLES `changeset_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `changeset_tags` ENABLE KEYS */;


--
-- Definition of table `osm`.`changesets`
--

DROP TABLE IF EXISTS `osm`.`changesets`;
CREATE TABLE  `osm`.`changesets` (
  `id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `min_lat` int(11) default NULL,
  `max_lat` int(11) default NULL,
  `min_lon` int(11) default NULL,
  `max_lon` int(11) default NULL,
  `closed_at` datetime NOT NULL,
  `num_changes` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`changesets`
--

/*!40000 ALTER TABLE `changesets` DISABLE KEYS */;
LOCK TABLES `changesets` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `changesets` ENABLE KEYS */;


--
-- Definition of table `osm`.`current_node_tags`
--

DROP TABLE IF EXISTS `osm`.`current_node_tags`;
CREATE TABLE  `osm`.`current_node_tags` (
  `node_id` bigint(64) NOT NULL,
  `k` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL default '',
  `v` text NOT NULL default '',
  PRIMARY KEY  (`node_id`,`k`),
  CONSTRAINT `current_node_tags_ibfk_1` FOREIGN KEY (`node_id`) REFERENCES `current_nodes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`current_node_tags`
--

/*!40000 ALTER TABLE `current_node_tags` DISABLE KEYS */;
LOCK TABLES `current_node_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_node_tags` ENABLE KEYS */;


--
-- Definition of table `osm`.`current_nodes`
--

DROP TABLE IF EXISTS `osm`.`current_nodes`;
CREATE TABLE  `osm`.`current_nodes` (
  `id` bigint(64) NOT NULL auto_increment,
  `latitude` int(11) NOT NULL,
  `longitude` int(11) NOT NULL,
  `changeset_id` bigint(20) NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `timestamp` datetime NOT NULL,
  `tile` int(10) unsigned default NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `current_nodes_timestamp_idx` (`timestamp`),
  KEY `current_nodes_tile_idx` (`tile`),
  KEY `changeset_id` (`changeset_id`),
  CONSTRAINT `current_nodes_ibfk_1` FOREIGN KEY (`changeset_id`) REFERENCES `changesets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`current_nodes`
--

/*!40000 ALTER TABLE `current_nodes` DISABLE KEYS */;
LOCK TABLES `current_nodes` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_nodes` ENABLE KEYS */;


--
-- Definition of table `osm`.`current_relation_members`
--

DROP TABLE IF EXISTS `osm`.`current_relation_members`;
CREATE TABLE  `osm`.`current_relation_members` (
  `relation_id` bigint(64) NOT NULL,
  `member_type` enum('Node','Way','Relation') NOT NULL default 'Node',
  `member_id` bigint(11) NOT NULL,
  `member_role` varchar(191) NOT NULL default '',
  `sequence_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`relation_id`,`member_type`,`member_id`,`member_role`,`sequence_id`),
  KEY `current_relation_members_member_idx` (`member_type`,`member_id`),
  CONSTRAINT `current_relation_members_ibfk_1` FOREIGN KEY (`relation_id`) REFERENCES `current_relations` (`relation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`current_relation_members`
--

/*!40000 ALTER TABLE `current_relation_members` DISABLE KEYS */;
LOCK TABLES `current_relation_members` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_relation_members` ENABLE KEYS */;


--
-- Definition of table `osm`.`current_relation_tags`
--

DROP TABLE IF EXISTS `osm`.`current_relation_tags`;
CREATE TABLE  `osm`.`current_relation_tags` (
  `id` bigint(64) NOT NULL,
  `k` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL default '',
  `v` text NOT NULL default '',
  PRIMARY KEY  (`id`,`k`),
  CONSTRAINT `current_relation_tags_ibfk_1` FOREIGN KEY (`id`) REFERENCES `current_relations` (`relation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`current_relation_tags`
--

/*!40000 ALTER TABLE `current_relation_tags` DISABLE KEYS */;
LOCK TABLES `current_relation_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_relation_tags` ENABLE KEYS */;


--
-- Definition of table `osm`.`current_relations`
--

DROP TABLE IF EXISTS `osm`.`current_relations`;
CREATE TABLE  `osm`.`current_relations` (
  `relation_id` bigint(64) NOT NULL auto_increment,
  `changeset_id` bigint(20) NOT NULL,
  `timestamp` datetime NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY  (`relation_id`),
  KEY `current_relations_timestamp_idx` (`timestamp`),
  KEY `changeset_id` (`changeset_id`),
  CONSTRAINT `current_relations_ibfk_1` FOREIGN KEY (`changeset_id`) REFERENCES `changesets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`current_relations`
--

/*!40000 ALTER TABLE `current_relations` DISABLE KEYS */;
LOCK TABLES `current_relations` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_relations` ENABLE KEYS */;


--
-- Definition of table `osm`.`current_way_nodes`
--

DROP TABLE IF EXISTS `osm`.`current_way_nodes`;
CREATE TABLE  `osm`.`current_way_nodes` (
  `id` bigint(64) NOT NULL,
  `node_id` bigint(64) NOT NULL,
  `sequence_id` bigint(11) NOT NULL,
  PRIMARY KEY  (`id`,`sequence_id`),
  KEY `current_way_nodes_node_idx` (`node_id`),
  CONSTRAINT `current_way_nodes_ibfk_2` FOREIGN KEY (`node_id`) REFERENCES `current_nodes` (`id`),
  CONSTRAINT `current_way_nodes_ibfk_1` FOREIGN KEY (`id`) REFERENCES `current_ways` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`current_way_nodes`
--

/*!40000 ALTER TABLE `current_way_nodes` DISABLE KEYS */;
LOCK TABLES `current_way_nodes` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_way_nodes` ENABLE KEYS */;


--
-- Definition of table `osm`.`current_way_tags`
--

DROP TABLE IF EXISTS `osm`.`current_way_tags`;
CREATE TABLE  `osm`.`current_way_tags` (
  `way_id` bigint(64) NOT NULL,
  `k` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL default '',
  `v` text NOT NULL default '',
  PRIMARY KEY  (`way_id`,`k`),
  CONSTRAINT `current_way_tags_ibfk_1` FOREIGN KEY (`way_id`) REFERENCES `current_ways` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`current_way_tags`
--

/*!40000 ALTER TABLE `current_way_tags` DISABLE KEYS */;
LOCK TABLES `current_way_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_way_tags` ENABLE KEYS */;


--
-- Definition of table `osm`.`current_ways`
--

DROP TABLE IF EXISTS `osm`.`current_ways`;
CREATE TABLE  `osm`.`current_ways` (
  `id` bigint(64) NOT NULL auto_increment,
  `changeset_id` bigint(20) NOT NULL,
  `timestamp` datetime NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `current_ways_timestamp_idx` (`timestamp`),
  KEY `changeset_id` (`changeset_id`),
  CONSTRAINT `current_ways_ibfk_1` FOREIGN KEY (`changeset_id`) REFERENCES `changesets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`current_ways`
--

/*!40000 ALTER TABLE `current_ways` DISABLE KEYS */;
LOCK TABLES `current_ways` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_ways` ENABLE KEYS */;


--
-- Definition of table `osm`.`diary_comments`
--

DROP TABLE IF EXISTS `osm`.`diary_comments`;
CREATE TABLE  `osm`.`diary_comments` (
  `id` bigint(20) NOT NULL auto_increment,
  `diary_entry_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `body` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `diary_comments_entry_id_idx` (`diary_entry_id`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`diary_comments`
--

/*!40000 ALTER TABLE `diary_comments` DISABLE KEYS */;
LOCK TABLES `diary_comments` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `diary_comments` ENABLE KEYS */;


--
-- Definition of table `osm`.`diary_entries`
--

DROP TABLE IF EXISTS `osm`.`diary_entries`;
CREATE TABLE  `osm`.`diary_entries` (
  `id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL,
  `title` varchar(191) NOT NULL,
  `body` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `latitude` double default NULL,
  `longitude` double default NULL,
  `language` varchar(3) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`diary_entries`
--

/*!40000 ALTER TABLE `diary_entries` DISABLE KEYS */;
LOCK TABLES `diary_entries` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `diary_entries` ENABLE KEYS */;


--
-- Definition of table `osm`.`friends`
--

DROP TABLE IF EXISTS `osm`.`friends`;
CREATE TABLE  `osm`.`friends` (
  `id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL,
  `friend_user_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id_idx` (`friend_user_id`),
  KEY `friends_user_id_idx` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`friends`
--

/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
LOCK TABLES `friends` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;


--
-- Definition of table `osm`.`gps_points`
--

DROP TABLE IF EXISTS `osm`.`gps_points`;
CREATE TABLE  `osm`.`gps_points` (
  `altitude` float default NULL,
  `trackid` int(11) NOT NULL,
  `latitude` int(11) NOT NULL,
  `longitude` int(11) NOT NULL,
  `gpx_id` bigint(64) NOT NULL,
  `timestamp` datetime default NULL,
  `tile` int(10) unsigned default NULL,
  KEY `points_gpxid_idx` (`gpx_id`),
  KEY `points_tile_idx` (`tile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`gps_points`
--

/*!40000 ALTER TABLE `gps_points` DISABLE KEYS */;
LOCK TABLES `gps_points` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `gps_points` ENABLE KEYS */;


--
-- Definition of table `osm`.`gpx_file_tags`
--

DROP TABLE IF EXISTS `osm`.`gpx_file_tags`;
CREATE TABLE  `osm`.`gpx_file_tags` (
  `gpx_id` bigint(64) NOT NULL default '0',
  `tag` varchar(191) NOT NULL,
  `id` bigint(20) NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  KEY `gpx_file_tags_gpxid_idx` (`gpx_id`),
  KEY `gpx_file_tags_tag_idx` (`tag`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`gpx_file_tags`
--

/*!40000 ALTER TABLE `gpx_file_tags` DISABLE KEYS */;
LOCK TABLES `gpx_file_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `gpx_file_tags` ENABLE KEYS */;


--
-- Definition of table `osm`.`gpx_files`
--

DROP TABLE IF EXISTS `osm`.`gpx_files`;
CREATE TABLE  `osm`.`gpx_files` (
  `id` bigint(64) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL,
  `visible` tinyint(1) NOT NULL default '1',
  `name` varchar(191) NOT NULL default '',
  `size` bigint(20) default NULL,
  `latitude` double default NULL,
  `longitude` double default NULL,
  `timestamp` datetime NOT NULL,
  `public` tinyint(1) NOT NULL default '1',
  `description` varchar(191) NOT NULL default '',
  `inserted` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `gpx_files_timestamp_idx` (`timestamp`),
  KEY `gpx_files_visible_public_idx` (`visible`,`public`),
  KEY `gpx_files_user_id_idx` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`gpx_files`
--

/*!40000 ALTER TABLE `gpx_files` DISABLE KEYS */;
LOCK TABLES `gpx_files` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `gpx_files` ENABLE KEYS */;


--
-- Definition of table `osm`.`messages`
--

DROP TABLE IF EXISTS `osm`.`messages`;
CREATE TABLE  `osm`.`messages` (
  `id` bigint(20) NOT NULL auto_increment,
  `from_user_id` bigint(20) NOT NULL,
  `title` varchar(191) NOT NULL,
  `body` text NOT NULL,
  `sent_on` datetime NOT NULL,
  `message_read` tinyint(1) NOT NULL default '0',
  `to_user_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `messages_to_user_id_idx` (`to_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`messages`
--

/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
LOCK TABLES `messages` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;


--
-- Definition of table `osm`.`node_tags`
--

DROP TABLE IF EXISTS `osm`.`node_tags`;
CREATE TABLE  `osm`.`node_tags` (
  `node_id` bigint(64) NOT NULL,
  `version` bigint(20) NOT NULL,
  `k` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL default '',
  `v` text NOT NULL default '',
  PRIMARY KEY  (`node_id`,`version`,`k`),
  CONSTRAINT `node_tags_ibfk_1` FOREIGN KEY (`node_id`, `version`) REFERENCES `nodes` (`node_id`, `version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`node_tags`
--

/*!40000 ALTER TABLE `node_tags` DISABLE KEYS */;
LOCK TABLES `node_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `node_tags` ENABLE KEYS */;


--
-- Definition of table `osm`.`nodes`
--

DROP TABLE IF EXISTS `osm`.`nodes`;
CREATE TABLE  `osm`.`nodes` (
  `node_id` bigint(64) NOT NULL,
  `latitude` int(11) NOT NULL,
  `longitude` int(11) NOT NULL,
  `changeset_id` bigint(20) NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `timestamp` datetime NOT NULL,
  `tile` int(10) unsigned default NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY  (`node_id`,`version`),
  KEY `nodes_timestamp_idx` (`timestamp`),
  KEY `nodes_tile_idx` (`tile`),
  KEY `changeset_id` (`changeset_id`),
  CONSTRAINT `nodes_ibfk_1` FOREIGN KEY (`changeset_id`) REFERENCES `changesets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`nodes`
--

/*!40000 ALTER TABLE `nodes` DISABLE KEYS */;
LOCK TABLES `nodes` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `nodes` ENABLE KEYS */;


--
-- Definition of table `osm`.`relation_members`
--

DROP TABLE IF EXISTS `osm`.`relation_members`;
CREATE TABLE  `osm`.`relation_members` (
  `relation_id` bigint(64) NOT NULL default '0',
  `member_type` enum('Node','Way','Relation') NOT NULL default 'Node',
  `member_id` bigint(11) NOT NULL,
  `member_role` varchar(191) NOT NULL default '',
  `version` bigint(20) NOT NULL default '0',
  `sequence_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`relation_id`,`version`,`member_type`,`member_id`,`member_role`,`sequence_id`),
  KEY `relation_members_member_idx` (`member_type`,`member_id`),
  CONSTRAINT `relation_members_ibfk_1` FOREIGN KEY (`relation_id`, `version`) REFERENCES `relations` (`relation_id`, `version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`relation_members`
--

/*!40000 ALTER TABLE `relation_members` DISABLE KEYS */;
LOCK TABLES `relation_members` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `relation_members` ENABLE KEYS */;


--
-- Definition of table `osm`.`relation_tags`
--

DROP TABLE IF EXISTS `osm`.`relation_tags`;
CREATE TABLE  `osm`.`relation_tags` (
  `relation_id` bigint(64) NOT NULL default '0',
  `k` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL default '',
  `v` text NOT NULL default '',
  `version` bigint(20) NOT NULL,
  PRIMARY KEY  (`relation_id`,`version`,`k`),
  CONSTRAINT `relation_tags_ibfk_1` FOREIGN KEY (`relation_id`, `version`) REFERENCES `relations` (`relation_id`, `version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`relation_tags`
--

/*!40000 ALTER TABLE `relation_tags` DISABLE KEYS */;
LOCK TABLES `relation_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `relation_tags` ENABLE KEYS */;


--
-- Definition of table `osm`.`relations`
--

DROP TABLE IF EXISTS `osm`.`relations`;
CREATE TABLE  `osm`.`relations` (
  `relation_id` bigint(64) NOT NULL default '0',
  `changeset_id` bigint(20) NOT NULL,
  `timestamp` datetime NOT NULL,
  `version` bigint(20) NOT NULL,
  `visible` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`relation_id`,`version`),
  KEY `relations_timestamp_idx` (`timestamp`),
  KEY `changeset_id` (`changeset_id`),
  CONSTRAINT `relations_ibfk_1` FOREIGN KEY (`changeset_id`) REFERENCES `changesets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`relations`
--

/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
LOCK TABLES `relations` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;


--
-- Definition of table `osm`.`schema_migrations`
--

DROP TABLE IF EXISTS `osm`.`schema_migrations`;
CREATE TABLE  `osm`.`schema_migrations` (
  `version` varchar(191) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`schema_migrations`
--

/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
LOCK TABLES `schema_migrations` WRITE;
INSERT INTO `osm`.`schema_migrations` VALUES  ('1'),
 ('10'),
 ('11'),
 ('12'),
 ('13'),
 ('14'),
 ('15'),
 ('16'),
 ('17'),
 ('18'),
 ('19'),
 ('2'),
 ('20'),
 ('21'),
 ('22'),
 ('23'),
 ('24'),
 ('25'),
 ('3'),
 ('4'),
 ('5'),
 ('6'),
 ('7'),
 ('8'),
 ('9');
UNLOCK TABLES;
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;


--
-- Definition of table `osm`.`sessions`
--

DROP TABLE IF EXISTS `osm`.`sessions`;
CREATE TABLE  `osm`.`sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(191) default NULL,
  `data` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sessions_session_id_idx` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`sessions`
--

/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
LOCK TABLES `sessions` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;


--
-- Definition of table `osm`.`user_preferences`
--

DROP TABLE IF EXISTS `osm`.`user_preferences`;
CREATE TABLE  `osm`.`user_preferences` (
  `user_id` bigint(20) NOT NULL,
  `k` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `v` text NOT NULL,
  PRIMARY KEY  (`user_id`,`k`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`user_preferences`
--

/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
LOCK TABLES `user_preferences` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;


--
-- Definition of table `osm`.`user_tokens`
--

DROP TABLE IF EXISTS `osm`.`user_tokens`;
CREATE TABLE  `osm`.`user_tokens` (
  `id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL,
  `token` varchar(191) NOT NULL,
  `expiry` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_tokens_token_idx` (`token`),
  KEY `user_tokens_user_id_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`user_tokens`
--

/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
LOCK TABLES `user_tokens` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `user_tokens` ENABLE KEYS */;


--
-- Definition of table `osm`.`users`
--

DROP TABLE IF EXISTS `osm`.`users`;
CREATE TABLE  `osm`.`users` (
  `email` varchar(191) NOT NULL,
  `id` bigint(20) NOT NULL auto_increment,
  `active` int(11) NOT NULL default '0',
  `pass_crypt` varchar(191) NOT NULL,
  `creation_time` datetime NOT NULL,
  `display_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL default '',
  `data_public` tinyint(1) NOT NULL default '0',
  `description` text NOT NULL,
  `home_lat` double default NULL,
  `home_lon` double default NULL,
  `home_zoom` smallint(6) default '3',
  `nearby` int(11) default '50',
  `pass_salt` varchar(191) default NULL,
  `image` text,
  `administrator` tinyint(1) NOT NULL default '0',
  `email_valid` tinyint(1) NOT NULL default '0',
  `new_email` varchar(191) default NULL,
  `visible` tinyint(1) NOT NULL default '1',
  `creation_ip` varchar(191) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `users_email_idx` (`email`),
  UNIQUE KEY `users_display_name_idx` (`display_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
LOCK TABLES `users` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `osm`.`way_nodes`
--

DROP TABLE IF EXISTS `osm`.`way_nodes`;
CREATE TABLE  `osm`.`way_nodes` (
  `way_id` bigint(64) NOT NULL,
  `node_id` bigint(64) NOT NULL,
  `version` bigint(20) NOT NULL,
  `sequence_id` bigint(11) NOT NULL,
  PRIMARY KEY  (`way_id`,`version`,`sequence_id`),
  KEY `way_nodes_node_idx` (`node_id`),
  CONSTRAINT `way_nodes_ibfk_1` FOREIGN KEY (`way_id`, `version`) REFERENCES `ways` (`way_id`, `version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`way_nodes`
--

/*!40000 ALTER TABLE `way_nodes` DISABLE KEYS */;
LOCK TABLES `way_nodes` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `way_nodes` ENABLE KEYS */;


--
-- Definition of table `osm`.`way_tags`
--

DROP TABLE IF EXISTS `osm`.`way_tags`;
CREATE TABLE  `osm`.`way_tags` (
  `way_id` bigint(64) NOT NULL default '0',
  `k` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `v` text NOT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY  (`way_id`,`version`,`k`),
  CONSTRAINT `way_tags_ibfk_1` FOREIGN KEY (`way_id`, `version`) REFERENCES `ways` (`way_id`, `version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`way_tags`
--

/*!40000 ALTER TABLE `way_tags` DISABLE KEYS */;
LOCK TABLES `way_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `way_tags` ENABLE KEYS */;


--
-- Definition of table `osm`.`ways`
--

DROP TABLE IF EXISTS `osm`.`ways`;
CREATE TABLE  `osm`.`ways` (
  `way_id` bigint(64) NOT NULL default '0',
  `changeset_id` bigint(20) NOT NULL,
  `timestamp` datetime NOT NULL,
  `version` bigint(20) NOT NULL,
  `visible` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`way_id`,`version`),
  KEY `ways_timestamp_idx` (`timestamp`),
  KEY `changeset_id` (`changeset_id`),
  CONSTRAINT `ways_ibfk_1` FOREIGN KEY (`changeset_id`) REFERENCES `changesets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `osm`.`ways`
--

/*!40000 ALTER TABLE `ways` DISABLE KEYS */;
LOCK TABLES `ways` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `ways` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

SET foreign_key_checks = 1;