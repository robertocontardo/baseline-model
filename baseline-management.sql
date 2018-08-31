-- MySQL Script generated by MySQL Workbench
-- 08/30/18 06:12:11
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema baseline
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema baseline
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `baseline` DEFAULT CHARACTER SET utf8 ;
USE `baseline` ;

-- -----------------------------------------------------
-- Table `roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roles` ;

CREATE TABLE IF NOT EXISTS `roles` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `code` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_status` ;

CREATE TABLE IF NOT EXISTS `user_status` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `languages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `languages` ;

CREATE TABLE IF NOT EXISTS `languages` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `code` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `code_UNIQUE` ON `languages` (`code` ASC);


-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `users` ;

CREATE TABLE IF NOT EXISTS `users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `role_id` INT(11) NULL,
  `status_id` INT(11) NULL,
  `language_id` INT(11) NULL,
  `name` VARCHAR(100) NULL,
  `username` VARCHAR(50) NULL,
  `password` VARCHAR(50) NULL,
  `nidn` VARCHAR(150) NULL,
  `email` VARCHAR(150) NULL,
  `phone` VARCHAR(20) NULL,
  `mobile` VARCHAR(20) NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  `registered` TINYINT(1) NULL DEFAULT 0,
  `datetime_registered` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  `invalid` TINYINT(1) NULL DEFAULT 0,
  `datetime_invalid` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  `deleted` TINYINT(1) NULL DEFAULT 0,
  `datetime_deleted` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_users_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_user_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `user_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_languages1`
    FOREIGN KEY (`language_id`)
    REFERENCES `languages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_users_roles1_idx` ON `users` (`role_id` ASC);

CREATE INDEX `fk_users_user_status1_idx` ON `users` (`status_id` ASC);

CREATE INDEX `fk_users_languages1_idx` ON `users` (`language_id` ASC);

CREATE UNIQUE INDEX `nidn_UNIQUE` ON `users` (`nidn` ASC);

CREATE UNIQUE INDEX `username_UNIQUE` ON `users` (`username` ASC);


-- -----------------------------------------------------
-- Table `upload_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upload_status` ;

CREATE TABLE IF NOT EXISTS `upload_status` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uploads`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `uploads` ;

CREATE TABLE IF NOT EXISTS `uploads` (
  `id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `status_id` INT(11) NOT NULL,
  `location` TEXT NULL,
  `filename` VARCHAR(45) NULL,
  `extension` VARCHAR(45) NULL,
  `size` INT(11) NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  `deleted` TINYINT(1) NULL,
  `datetime_deleted` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_uploads_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_uploads_upload_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `upload_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_uploads_users1_idx` ON `uploads` (`user_id` ASC);

CREATE INDEX `fk_uploads_upload_status1_idx` ON `uploads` (`status_id` ASC);


-- -----------------------------------------------------
-- Table `threads`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `threads` ;

CREATE TABLE IF NOT EXISTS `threads` (
  `id` INT(11) NOT NULL,
  `title` VARCHAR(45) NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `message_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message_status` ;

CREATE TABLE IF NOT EXISTS `message_status` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `messages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `messages` ;

CREATE TABLE IF NOT EXISTS `messages` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `thread_id` INT(11) NOT NULL,
  `status_id` INT(11) NOT NULL,
  `upload_id` INT(11) NULL,
  `text` VARCHAR(150) NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_messages_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_threads1`
    FOREIGN KEY (`thread_id`)
    REFERENCES `threads` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_message_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `message_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_messages_users1_idx` ON `messages` (`user_id` ASC);

CREATE INDEX `fk_messages_threads1_idx` ON `messages` (`thread_id` ASC);

CREATE INDEX `fk_messages_message_status1_idx` ON `messages` (`status_id` ASC);


-- -----------------------------------------------------
-- Table `dispositives`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dispositives` ;

CREATE TABLE IF NOT EXISTS `dispositives` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `name` VARCHAR(50) NULL,
  `ip` VARCHAR(45) NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_dispositives_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_dispositives_users1_idx` ON `dispositives` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `sessions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sessions` ;

CREATE TABLE IF NOT EXISTS `sessions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `dispositive_id` INT(11) NOT NULL,
  `browser` TEXT NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_sessions_dispositives1`
    FOREIGN KEY (`dispositive_id`)
    REFERENCES `dispositives` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sessions_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_sessions_dispositives1_idx` ON `sessions` (`dispositive_id` ASC);

CREATE INDEX `fk_sessions_users1_idx` ON `sessions` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `modules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `modules` ;

CREATE TABLE IF NOT EXISTS `modules` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `code` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `code_UNIQUE` ON `modules` (`code` ASC);


-- -----------------------------------------------------
-- Table `options`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `options` ;

CREATE TABLE IF NOT EXISTS `options` (
  `id` INT(11) NOT NULL,
  `module_id` INT(11) NOT NULL,
  `type_id` INT(11) NULL,
  `name` VARCHAR(45) NULL,
  `code` VARCHAR(45) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_options_modules1`
    FOREIGN KEY (`module_id`)
    REFERENCES `modules` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_options_modules1_idx` ON `options` (`module_id` ASC);

CREATE UNIQUE INDEX `code_UNIQUE` ON `options` (`code` ASC);


-- -----------------------------------------------------
-- Table `views`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `views` ;

CREATE TABLE IF NOT EXISTS `views` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `module_id` INT(11) NOT NULL,
  `title` VARCHAR(45) NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_views_modules1`
    FOREIGN KEY (`module_id`)
    REFERENCES `modules` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_views_modules1_idx` ON `views` (`module_id` ASC);


-- -----------------------------------------------------
-- Table `mailings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mailings` ;

CREATE TABLE IF NOT EXISTS `mailings` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `html` TEXT NULL,
  `response` TEXT NULL,
  `datetime_created` DATETIME NULL,
  `datetime_send` DATETIME NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_mailings_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_mailings_users1_idx` ON `mailings` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `notifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `notifications` ;

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `target_id` INT(11) NOT NULL,
  `text` VARCHAR(100) NULL,
  `datetime_consumed` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  `consumed` TINYINT(1) NULL DEFAULT 0,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_notifications_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notifications_users2`
    FOREIGN KEY (`target_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_notifications_users1_idx` ON `notifications` (`user_id` ASC);

CREATE INDEX `fk_notifications_users2_idx` ON `notifications` (`target_id` ASC);


-- -----------------------------------------------------
-- Table `logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `logs` ;

CREATE TABLE IF NOT EXISTS `logs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `title` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_logs_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_logs_users1_idx` ON `logs` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `inbounds`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inbounds` ;

CREATE TABLE IF NOT EXISTS `inbounds` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `ip` VARCHAR(45) NULL,
  `port` VARCHAR(10) NULL,
  `method` VARCHAR(10) NULL,
  `url` TEXT NULL,
  `data` TEXT NULL,
  `response` TEXT NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  `process_id` VARCHAR(45) NULL,
  `datetime_process` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `process_id_UNIQUE` ON `inbounds` (`process_id` ASC);


-- -----------------------------------------------------
-- Table `outbounds`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `outbounds` ;

CREATE TABLE IF NOT EXISTS `outbounds` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `ip` VARCHAR(45) NULL,
  `port` VARCHAR(10) NULL,
  `method` VARCHAR(10) NULL,
  `url` TEXT NULL,
  `data` TEXT NULL,
  `response` TEXT NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  `process_id` VARCHAR(45) NULL,
  `datetime_process` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `process_id_UNIQUE` ON `outbounds` (`process_id` ASC);


-- -----------------------------------------------------
-- Table `tracks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tracks` ;

CREATE TABLE IF NOT EXISTS `tracks` (
  `id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NULL,
  `action` VARCHAR(45) NULL,
  `label` VARCHAR(45) NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tracks_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tracks_users1_idx` ON `tracks` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `value_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `value_types` ;

CREATE TABLE IF NOT EXISTS `value_types` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `settings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `settings` ;

CREATE TABLE IF NOT EXISTS `settings` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type_id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL,
  `code` VARCHAR(45) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_settings_value_types1`
    FOREIGN KEY (`type_id`)
    REFERENCES `value_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_settings_value_types1_idx` ON `settings` (`type_id` ASC);


-- -----------------------------------------------------
-- Table `token_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `token_types` ;

CREATE TABLE IF NOT EXISTS `token_types` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL,
  `code` VARCHAR(45) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `code_UNIQUE` ON `token_types` (`code` ASC);


-- -----------------------------------------------------
-- Table `roles_views`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roles_views` ;

CREATE TABLE IF NOT EXISTS `roles_views` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `view_id` INT(11) NOT NULL,
  `role_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_views_roles_views1`
    FOREIGN KEY (`view_id`)
    REFERENCES `views` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_views_roles_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_views_roles_views1_idx` ON `roles_views` (`view_id` ASC);

CREATE INDEX `fk_views_roles_roles1_idx` ON `roles_views` (`role_id` ASC);


-- -----------------------------------------------------
-- Table `modules_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `modules_users` ;

CREATE TABLE IF NOT EXISTS `modules_users` (
  `id` INT(11) NOT NULL,
  `module_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_modules_users_modules1`
    FOREIGN KEY (`module_id`)
    REFERENCES `modules` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_modules_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_modules_users_modules1_idx` ON `modules_users` (`module_id` ASC);

CREATE INDEX `fk_modules_users_users1_idx` ON `modules_users` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `tokens`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tokens` ;

CREATE TABLE IF NOT EXISTS `tokens` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `token` VARCHAR(255) NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tokens_token_types1`
    FOREIGN KEY (`type_id`)
    REFERENCES `token_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tokens_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tokens_token_types1_idx` ON `tokens` (`type_id` ASC);

CREATE INDEX `fk_tokens_users1_idx` ON `tokens` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `avatars`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `avatars` ;

CREATE TABLE IF NOT EXISTS `avatars` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `upload_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_avatars_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avatars_uploads1`
    FOREIGN KEY (`upload_id`)
    REFERENCES `uploads` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_avatars_users_idx` ON `avatars` (`user_id` ASC);

CREATE INDEX `fk_avatars_uploads1_idx` ON `avatars` (`upload_id` ASC);


-- -----------------------------------------------------
-- Table `groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `groups` ;

CREATE TABLE IF NOT EXISTS `groups` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `options_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `options_users` ;

CREATE TABLE IF NOT EXISTS `options_users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `option_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `type_id` INT(11) NOT NULL,
  `boolean_value` TINYINT(1) NOT NULL,
  `varchar_value` VARCHAR(255) NULL,
  `text_value` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_options_users_options1`
    FOREIGN KEY (`option_id`)
    REFERENCES `options` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_options_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_options_users_value_types1`
    FOREIGN KEY (`type_id`)
    REFERENCES `value_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_options_users_options1_idx` ON `options_users` (`option_id` ASC);

CREATE INDEX `fk_options_users_users1_idx` ON `options_users` (`user_id` ASC);

CREATE INDEX `fk_options_users_value_types1_idx` ON `options_users` (`type_id` ASC);


-- -----------------------------------------------------
-- Table `threads_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `threads_users` ;

CREATE TABLE IF NOT EXISTS `threads_users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `thread_id` INT(11) NULL,
  `user_id` INT(11) NULL,
  `datetime_created` DATETIME NULL DEFAULT 0000-00-00 00:00:00,
  `datetime_deleted` DATETIME NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_threads_users_threads1`
    FOREIGN KEY (`thread_id`)
    REFERENCES `threads` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_threads_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_threads_users_threads1_idx` ON `threads_users` (`thread_id` ASC);

CREATE INDEX `fk_threads_users_users1_idx` ON `threads_users` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `groups_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `groups_users` ;

CREATE TABLE IF NOT EXISTS `groups_users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `group_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_groups_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_groups_users_groups1`
    FOREIGN KEY (`group_id`)
    REFERENCES `groups` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_groups_users_users1_idx` ON `groups_users` (`user_id` ASC);

CREATE INDEX `fk_groups_users_groups1_idx` ON `groups_users` (`group_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
