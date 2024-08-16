-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 16 août 2024 à 16:23
-- Version du serveur : 8.0.27
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `donvital`
--

-- --------------------------------------------------------

--
-- Structure de la table `annonces`
--

DROP TABLE IF EXISTS `annonces`;
CREATE TABLE IF NOT EXISTS `annonces` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `raison` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TypeSang` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CentreSante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `annonces_user_id_foreign` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `annonces`
--

INSERT INTO `annonces` (`id`, `titre`, `description`, `raison`, `TypeSang`, `CentreSante`, `created_at`, `updated_at`, `user_id`) VALUES
(1, 'Recherche de sang 0+', 'besoin de sang o+ urgemment à la clinique saint jean', 'Chirurgie', 'O+', 'Clinique Saint Jean', '2024-08-07 15:03:17', '2024-08-07 15:03:17', 12),
(2, 'Sang AB—', 'besoin de sang AB- urgent', 'Accident', 'AB-', 'hôpital yalgado ouedraogo', '2024-08-07 15:13:10', '2024-08-07 15:13:10', 12),
(3, 'sang 0-', 'besoin urgemment de sang à yalgado', 'Grossesse', 'O-', 'Yalgado', '2024-08-07 17:11:23', '2024-08-07 17:11:23', 12),
(4, 'besoin de sang', 'sang o-', 'Je préfère ne pas le dire', 'O-', 'Chu Angre', '2024-08-08 17:37:28', '2024-08-08 17:37:28', 26),
(5, 'besoin de sang', 'sang o-', 'Accident', 'O-', 'Chu Angre', '2024-08-08 17:38:02', '2024-08-08 17:38:02', 26),
(6, 'besoin de sang', 'sang o-', 'Accident', 'O-', 'Chu Angre', '2024-08-08 17:38:22', '2024-08-08 17:38:22', 26),
(7, 'besoin de sang', 'sang A+ urgemment a bogodogo', 'Accident', 'A+', 'CHU Bogodogo', '2024-08-09 16:06:08', '2024-08-09 16:06:08', 12),
(8, 'besoin de sang', 'sang A+ urgemment a bogodogo', 'Accident', 'A+', 'CHU Bogodogo', '2024-08-09 16:06:38', '2024-08-09 16:06:38', 12),
(9, 'A+', 'sang A+', 'Accident', 'A+', 'bogodogo', '2024-08-09 16:22:10', '2024-08-09 16:22:10', 10),
(10, 'besoin', 'sang A+', 'Chirurgie', 'A+', 'bogodogo', '2024-08-12 11:41:01', '2024-08-12 11:41:01', 10),
(11, 'Besoin de sang B-', 'urgemment besoin de sang B-', 'Grossesse', 'B-', 'yalgado', '2024-08-13 10:14:28', '2024-08-13 10:14:28', 12),
(12, 'sang', 'aaaaaaa', 'Accident', 'A+', 'bbvv', '2024-08-13 10:28:18', '2024-08-13 10:28:18', 12),
(13, 'besoin de sang', 'dgjjj', 'Chirurgie', 'A+', 'yalgado', '2024-08-13 10:57:42', '2024-08-13 10:57:42', 12),
(14, 'Traore', 'Laouratou', 'Autre', 'AB+', 'saint viateur', '2024-08-13 17:27:01', '2024-08-13 17:27:01', 12),
(15, 'besoin de sang', 'je veux du sang pour ma fille', 'Je préfère ne pas le dire', 'O-', 'siloyé', '2024-08-14 10:24:31', '2024-08-14 10:24:31', 29),
(16, 'Sang B+', 'besoin de sang urgemment B+', 'Grossesse', 'B+', '1', '2024-08-16 16:19:50', '2024-08-16 16:19:50', 12);

-- --------------------------------------------------------

--
-- Structure de la table `centres_sante`
--

DROP TABLE IF EXISTS `centres_sante`;
CREATE TABLE IF NOT EXISTS `centres_sante` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Localisation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `centre_santes`
--

DROP TABLE IF EXISTS `centre_santes`;
CREATE TABLE IF NOT EXISTS `centre_santes` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Localisation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `centre_santes`
--

INSERT INTO `centre_santes` (`id`, `nom`, `Localisation`, `image`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Centre Hospitalier Universitaire Yalgado Ouédraogo', 'Ouagadougou', 'images/cBX98RZJKYB2uMSX0oaTYg0lZWMG3jjmdygmQatv.png', 'premier hopital', '2024-08-15 02:00:16', '2024-08-15 02:00:16');

-- --------------------------------------------------------

--
-- Structure de la table `dons`
--

DROP TABLE IF EXISTS `dons`;
CREATE TABLE IF NOT EXISTS `dons` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_08_01_161327_create_permission_tables', 1),
(6, '2024_08_02_095929_add_blood_group_to_users_table', 2),
(7, '2024_08_02_154010_create_annonces_table', 3),
(8, '2024_08_02_154024_create_dons_table', 3),
(9, '2024_08_07_105330_add_user_id_foreign_key_to_annonces_table', 3),
(10, '2024_08_11_211858_add_fcm_token_to_users_table', 4),
(11, '2024_08_13_090450_create_notifications_table', 5),
(12, '2024_08_15_011556_create_centres_sante_table', 6),
(13, '2024_08_15_015848_create_centre_santes_table', 7);

-- --------------------------------------------------------

--
-- Structure de la table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 3),
(2, 'App\\Models\\User', 4),
(2, 'App\\Models\\User', 5),
(2, 'App\\Models\\User', 6),
(2, 'App\\Models\\User', 7),
(2, 'App\\Models\\User', 8),
(2, 'App\\Models\\User', 9),
(2, 'App\\Models\\User', 10),
(2, 'App\\Models\\User', 11),
(2, 'App\\Models\\User', 12),
(2, 'App\\Models\\User', 13),
(2, 'App\\Models\\User', 14),
(2, 'App\\Models\\User', 15),
(2, 'App\\Models\\User', 16),
(2, 'App\\Models\\User', 17),
(2, 'App\\Models\\User', 18),
(2, 'App\\Models\\User', 19),
(2, 'App\\Models\\User', 20),
(2, 'App\\Models\\User', 21),
(2, 'App\\Models\\User', 22),
(2, 'App\\Models\\User', 23),
(2, 'App\\Models\\User', 24),
(2, 'App\\Models\\User', 25),
(2, 'App\\Models\\User', 26),
(2, 'App\\Models\\User', 27),
(2, 'App\\Models\\User', 28),
(2, 'App\\Models\\User', 29),
(2, 'App\\Models\\User', 30);

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `annonce_id` bigint UNSIGNED NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_foreign` (`user_id`),
  KEY `notifications_annonce_id_foreign` (`annonce_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `titre`, `message`, `annonce_id`, `read`, `created_at`, `updated_at`) VALUES
(1, 12, 'Annonce de demande de sang', 'Une nouvelle annonce de demande de sang correspond à votre groupe sanguin!', 11, 0, '2024-08-13 10:14:28', '2024-08-13 10:14:28'),
(2, 2, 'Annonce de demande de sang', 'Une nouvelle annonce de demande de sang correspond à votre groupe sanguin!', 12, 0, '2024-08-13 10:28:18', '2024-08-13 10:28:18'),
(3, 10, 'Annonce de demande de sang', 'Une nouvelle annonce de demande de sang correspond à votre groupe sanguin!', 12, 0, '2024-08-13 10:28:18', '2024-08-13 10:28:18'),
(4, 28, 'Annonce de demande de sang', 'Une nouvelle annonce de demande de sang correspond à votre groupe sanguin!', 12, 0, '2024-08-13 10:28:18', '2024-08-13 10:28:18'),
(5, 2, 'Annonce de demande de sang', 'Une nouvelle annonce de demande de sang correspond à votre groupe sanguin!', 13, 0, '2024-08-13 10:57:42', '2024-08-13 10:57:42'),
(6, 10, 'Annonce de demande de sang', 'Une nouvelle annonce de demande de sang correspond à votre groupe sanguin!', 13, 0, '2024-08-13 10:57:42', '2024-08-13 10:57:42'),
(7, 28, 'Annonce de demande de sang', 'Une nouvelle annonce de demande de sang correspond à votre groupe sanguin!', 13, 0, '2024-08-13 10:57:42', '2024-08-13 10:57:42'),
(8, 29, 'Annonce de demande de sang', 'Une nouvelle annonce de demande de sang correspond à votre groupe sanguin!', 13, 0, '2024-08-13 10:57:42', '2024-08-13 10:57:42'),
(9, 3, 'Annonce de demande de sang', 'Une nouvelle annonce de demande de sang correspond à votre groupe sanguin!', 15, 0, '2024-08-14 10:24:31', '2024-08-14 10:24:31'),
(10, 26, 'Annonce de demande de sang', 'Une nouvelle annonce de demande de sang correspond à votre groupe sanguin!', 15, 0, '2024-08-14 10:24:31', '2024-08-14 10:24:31'),
(11, 25, 'Annonce de demande de sang', 'Une nouvelle annonce de demande de sang correspond à votre groupe sanguin!', 16, 0, '2024-08-16 16:19:50', '2024-08-16 16:19:50'),
(12, 30, 'Annonce de demande de sang', 'Une nouvelle annonce de demande de sang correspond à votre groupe sanguin!', 16, 0, '2024-08-16 16:19:50', '2024-08-16 16:19:50');

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('cheich.yalaweogo61@gmail.com', '$2y$12$BJN7EYqZtE03VChvKISJM.WFhfr1kkvivob05JvkmOzsT5yl08CKC', '2024-08-02 15:16:05');

-- --------------------------------------------------------

--
-- Structure de la table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 4, 'auth_token', 'c3164c23d6ed3e0eee5dc1d769f08bd7c52fffe82168a42943951dc225b31858', '[\"*\"]', NULL, NULL, '2024-08-02 17:25:49', '2024-08-02 17:25:49'),
(2, 'App\\Models\\User', 4, 'auth_token', '9d82205e41e50e8a9361e416b0f5ce411fc9988152f4c90444d93694656d3011', '[\"*\"]', NULL, NULL, '2024-08-02 17:27:03', '2024-08-02 17:27:03'),
(3, 'App\\Models\\User', 4, 'auth_token', '8d694726901e921ebebd1cabab81a61c4c55f379c7cce714e4db36e1a375b2e3', '[\"*\"]', NULL, NULL, '2024-08-04 00:08:00', '2024-08-04 00:08:00'),
(4, 'App\\Models\\User', 4, 'auth_token', '56cee9a199923db8a0add3dc65bf1055db0966679a85cc913280c727421d81de', '[\"*\"]', NULL, NULL, '2024-08-04 00:08:05', '2024-08-04 00:08:05'),
(5, 'App\\Models\\User', 4, 'auth_token', 'd2947e5c1db237a8f02c998f7102ff48ab2c5a91cb292b783857b61d72e2e941', '[\"*\"]', NULL, NULL, '2024-08-04 00:11:19', '2024-08-04 00:11:19'),
(6, 'App\\Models\\User', 4, 'auth_token', '5ba453e0698385b15af58708da9485c0ed666270751d4342dd13a91bae2fe264', '[\"*\"]', NULL, NULL, '2024-08-04 00:16:48', '2024-08-04 00:16:48'),
(7, 'App\\Models\\User', 4, 'auth_token', 'de596adf2e15cd9113351e326e476f727452d05641e75c4617309d0d3ffe5919', '[\"*\"]', NULL, NULL, '2024-08-04 00:21:20', '2024-08-04 00:21:20'),
(8, 'App\\Models\\User', 4, 'auth_token', '18888c931c497c623c4cca3a525317f0325d0ce3126b34de489aadb79aa89400', '[\"*\"]', NULL, NULL, '2024-08-04 00:28:53', '2024-08-04 00:28:53'),
(9, 'App\\Models\\User', 4, 'auth_token', 'cd7df8418a29cd34bd6c4f361c3728623f9394b701c38194b25cc533eb9822a0', '[\"*\"]', NULL, NULL, '2024-08-04 00:30:21', '2024-08-04 00:30:21'),
(10, 'App\\Models\\User', 4, 'auth_token', '801417d8d3c2e7e801e1a82f17bfe33c8a421d0c939add969ba851f3a05f3146', '[\"*\"]', NULL, NULL, '2024-08-04 00:30:33', '2024-08-04 00:30:33'),
(11, 'App\\Models\\User', 4, 'auth_token', 'e1b39304622a6a7feb4732a3e40fe916959b1e86e05eca2cebed779be5db594c', '[\"*\"]', NULL, NULL, '2024-08-04 00:31:05', '2024-08-04 00:31:05'),
(12, 'App\\Models\\User', 4, 'auth_token', 'dba07645c4160dd4c06b7d5ee895850c7af50f834dc4b1a7fb817cb17280c473', '[\"*\"]', NULL, NULL, '2024-08-04 00:32:58', '2024-08-04 00:32:58'),
(13, 'App\\Models\\User', 4, 'auth_token', '6134997024cceb21dbec55cbe98154aa751b509ac4237ca902fd97c4571faea5', '[\"*\"]', NULL, NULL, '2024-08-04 00:51:15', '2024-08-04 00:51:15'),
(14, 'App\\Models\\User', 4, 'auth_token', '8e5b433da075eed922bcfcfb3486b4385e17ea5e943b87821136a62b2467d379', '[\"*\"]', NULL, NULL, '2024-08-04 00:51:50', '2024-08-04 00:51:50'),
(15, 'App\\Models\\User', 4, 'auth_token', 'f9990ffc0ffe13dbf994f095155c47bfcd3a18823693f94f3491ff022adf54c9', '[\"*\"]', NULL, NULL, '2024-08-05 21:51:40', '2024-08-05 21:51:40'),
(16, 'App\\Models\\User', 4, 'auth_token', '17dc2e99c5b0aa41ce3b068bc9ca6f3e97f43a5a52ce04a9287784cc6e568285', '[\"*\"]', NULL, NULL, '2024-08-05 21:57:48', '2024-08-05 21:57:48'),
(17, 'App\\Models\\User', 5, 'auth_token', '353c13673a8cce5240112ce41f2ea83518f7cf3b02c2572ab1d07ead8df55da5', '[\"*\"]', NULL, NULL, '2024-08-05 22:01:28', '2024-08-05 22:01:28'),
(18, 'App\\Models\\User', 6, 'auth_token', '234e48f901aab45c512f2f3e15096ecfc120770316fee97f1e6df63d5b7cea60', '[\"*\"]', NULL, NULL, '2024-08-05 22:12:13', '2024-08-05 22:12:13'),
(19, 'App\\Models\\User', 7, 'auth_token', '4eca7f2abce3ced505bcd0f692d44556f4d3959e117e7536429088bdb1e496fc', '[\"*\"]', NULL, NULL, '2024-08-05 22:24:13', '2024-08-05 22:24:13'),
(20, 'App\\Models\\User', 8, 'auth_token', '4d455ca1ce29337ddaa48b438cf09ddb2f32b39bd95fcc5294554521df42ae6c', '[\"*\"]', NULL, NULL, '2024-08-05 22:25:11', '2024-08-05 22:25:11'),
(21, 'App\\Models\\User', 9, 'auth_token', 'b4a0ce0332ceaa0e8af5b9778a13633fc9469a3d7483b64cbff06538bb778a54', '[\"*\"]', NULL, NULL, '2024-08-05 22:34:54', '2024-08-05 22:34:54'),
(22, 'App\\Models\\User', 10, 'auth_token', 'eae3529ad6a451ad409f0ffc40e4b5ef128a7d9854a4e9d499003f1b271a9ce3', '[\"*\"]', NULL, NULL, '2024-08-05 22:45:33', '2024-08-05 22:45:33'),
(23, 'App\\Models\\User', 11, 'auth_token', 'b46f8bb1c056887ec403dd99ca2bd87ba8a4eda6ba2744f184d6ba8b69ab766d', '[\"*\"]', NULL, NULL, '2024-08-05 23:16:36', '2024-08-05 23:16:36'),
(24, 'App\\Models\\User', 4, 'auth_token', 'd4dee19fced0c9c40da2f6e444460849f9ecc3976aff60bb5c7737202f163718', '[\"*\"]', NULL, NULL, '2024-08-05 23:57:38', '2024-08-05 23:57:38'),
(25, 'App\\Models\\User', 4, 'auth_token', '34ed82ef571e9293b3f26ba187a8330f7a51d9208d517ec75b9fe2a5cd093dd6', '[\"*\"]', NULL, NULL, '2024-08-05 23:58:39', '2024-08-05 23:58:39'),
(26, 'App\\Models\\User', 4, 'auth_token', 'b25cfc8a88a793617a6a38c526e7e3c0e6cb558c800171dfcc9cf50358f85f90', '[\"*\"]', NULL, NULL, '2024-08-06 00:16:28', '2024-08-06 00:16:28'),
(27, 'App\\Models\\User', 4, 'auth_token', 'c94412922959d7b0c818c0bb5c79753f781b207eb27f1392f9b13e701a797458', '[\"*\"]', '2024-08-06 00:29:23', NULL, '2024-08-06 00:28:15', '2024-08-06 00:29:23'),
(28, 'App\\Models\\User', 10, 'auth_token', '8f9fbac67f75d6c939830234494b365249d89d8767cc91b7a9a32a93bbc32632', '[\"*\"]', '2024-08-06 00:42:27', NULL, '2024-08-06 00:30:48', '2024-08-06 00:42:27'),
(29, 'App\\Models\\User', 10, 'auth_token', 'cdca7d84e6aba6554ee5f41d23746da4eb9f394b1d134eb676d7027c7890f993', '[\"*\"]', '2024-08-06 00:43:08', NULL, '2024-08-06 00:43:03', '2024-08-06 00:43:08'),
(30, 'App\\Models\\User', 10, 'auth_token', 'e3820091d5a2d5d8a248cf83f6bf1a2d36d1ee837d86a9527812747c341ad921', '[\"*\"]', '2024-08-06 00:46:36', NULL, '2024-08-06 00:46:30', '2024-08-06 00:46:36'),
(31, 'App\\Models\\User', 10, 'auth_token', '294e12ce21bc19bf488fcd0957f6821bc40d3fac2e23b27a2ef7d7d1b55c32a7', '[\"*\"]', '2024-08-06 01:19:47', NULL, '2024-08-06 00:48:06', '2024-08-06 01:19:47'),
(32, 'App\\Models\\User', 10, 'auth_token', 'b33e83d8e1f485e645500899d049f6bfd840a8145933e74fc3c2095edd56a624', '[\"*\"]', '2024-08-06 01:22:56', NULL, '2024-08-06 01:20:51', '2024-08-06 01:22:56'),
(33, 'App\\Models\\User', 10, 'auth_token', 'b9750d5cc2e8d4e0068a65df31314ea56aa4e36b66f3684dca9c2868e7cef40f', '[\"*\"]', '2024-08-06 01:28:32', NULL, '2024-08-06 01:25:49', '2024-08-06 01:28:32'),
(34, 'App\\Models\\User', 12, 'auth_token', '1e638c0d74d2aeffcca67b0c7f0a976654127170a03ef06a800b7743088ef296', '[\"*\"]', '2024-08-06 01:32:09', NULL, '2024-08-06 01:31:25', '2024-08-06 01:32:09'),
(35, 'App\\Models\\User', 10, 'auth_token', 'd27dc962c5a51c0613a2bdddc5db5f8f98533155ddb0d5e5844daea965a1df81', '[\"*\"]', '2024-08-06 09:23:01', NULL, '2024-08-06 09:22:53', '2024-08-06 09:23:01'),
(36, 'App\\Models\\User', 10, 'auth_token', '593a3bbd1d6e554f840cf943bb06495cb6ce89322033a26b27683c97ea506981', '[\"*\"]', '2024-08-06 09:25:40', NULL, '2024-08-06 09:25:32', '2024-08-06 09:25:40'),
(37, 'App\\Models\\User', 12, 'auth_token', 'e6c1c3ea5e741f96d2c9de8e7d53967a70a679e01e9ede78ce912bbabf91b32b', '[\"*\"]', '2024-08-06 09:28:08', NULL, '2024-08-06 09:28:02', '2024-08-06 09:28:08'),
(38, 'App\\Models\\User', 12, 'auth_token', '6db5a6d23d309521c8fbbe4bbda91ac591cc520ccafbe37e6d74a84e5521af7b', '[\"*\"]', '2024-08-06 09:28:54', NULL, '2024-08-06 09:28:49', '2024-08-06 09:28:54'),
(39, 'App\\Models\\User', 12, 'auth_token', '54313be0a0e6b330c7300162849c75089ff5993db44e8e0c3ac0c5f0d301e0a6', '[\"*\"]', '2024-08-06 09:35:05', NULL, '2024-08-06 09:30:20', '2024-08-06 09:35:05'),
(40, 'App\\Models\\User', 13, 'auth_token', '6bececbcddedfc4f6984dad1b57b2d19e5f5b603c1de7cc0ee946f0cb6f3cdaf', '[\"*\"]', NULL, NULL, '2024-08-06 09:34:36', '2024-08-06 09:34:36'),
(41, 'App\\Models\\User', 13, 'auth_token', '9cd95b6fb82dd12f092d32e1df069f0c2be28c607874fcec5060803407e54571', '[\"*\"]', '2024-08-06 10:02:47', NULL, '2024-08-06 09:35:57', '2024-08-06 10:02:47'),
(42, 'App\\Models\\User', 14, 'auth_token', 'eb768a68a7e4652717e0d980e7d1e7c0ff27551ce02b91c3c9bfe1b724cadf85', '[\"*\"]', NULL, NULL, '2024-08-06 09:41:07', '2024-08-06 09:41:07'),
(43, 'App\\Models\\User', 14, 'auth_token', '1153c7a88a09415a4019992b3e8a20dc12e4b0f86f06c262cd6acbaf7a683d83', '[\"*\"]', '2024-08-06 09:42:03', NULL, '2024-08-06 09:42:00', '2024-08-06 09:42:03'),
(44, 'App\\Models\\User', 15, 'auth_token', '39fc23dc7dd46c93f91057d7fb82be599ec760dfbaf2080b020bcf304fec1656', '[\"*\"]', NULL, NULL, '2024-08-06 09:44:27', '2024-08-06 09:44:27'),
(45, 'App\\Models\\User', 15, 'auth_token', '02c81f446ceeff0c4a5fad301d3a18c4699bc78b70a42e33cc604ae5d08d55b9', '[\"*\"]', '2024-08-06 09:45:54', NULL, '2024-08-06 09:45:52', '2024-08-06 09:45:54'),
(46, 'App\\Models\\User', 16, 'auth_token', 'f15ba6f9a872e729a902235eba52477ee37b73703fa1fd54e155d570ab291b92', '[\"*\"]', NULL, NULL, '2024-08-06 09:46:33', '2024-08-06 09:46:33'),
(47, 'App\\Models\\User', 17, 'auth_token', 'cf16dc65e3643576255f1f1f7a89c4acf6e9655ba161826f1c3fd0c7367b01cf', '[\"*\"]', NULL, NULL, '2024-08-06 09:52:04', '2024-08-06 09:52:04'),
(48, 'App\\Models\\User', 18, 'auth_token', '4a552bbca2c3b8012b18d1bc01dde85c8315c9ac8ca12d6a89d3815469a776ae', '[\"*\"]', NULL, NULL, '2024-08-06 09:55:05', '2024-08-06 09:55:05'),
(49, 'App\\Models\\User', 19, 'auth_token', '85173dfc622d7df78050b4dc1489d1d892579d77a27bd40f6dc1d09e6037f793', '[\"*\"]', NULL, NULL, '2024-08-06 10:02:37', '2024-08-06 10:02:37'),
(50, 'App\\Models\\User', 20, 'auth_token', '1a071c8da33ab25f4ea2876d803d76f8001c3d7e88abb1b1963eba421191133b', '[\"*\"]', '2024-08-06 10:13:07', NULL, '2024-08-06 10:12:49', '2024-08-06 10:13:07'),
(51, 'App\\Models\\User', 21, 'auth_token', 'a5503e7fc243274dbf1b643a2d31793e0cf584ea399653cb2b8f95b6e7559bac', '[\"*\"]', NULL, NULL, '2024-08-06 10:15:12', '2024-08-06 10:15:12'),
(52, 'App\\Models\\User', 22, 'auth_token', '4724ec487a689034b078b760a84dcfc0dd9374f79a0d3a9d70a6acc57819b0c1', '[\"*\"]', '2024-08-06 10:27:47', NULL, '2024-08-06 10:27:15', '2024-08-06 10:27:47'),
(53, 'App\\Models\\User', 10, 'auth_token', 'e820cdd1dd6e11ad1a21923038dd4d3fafaf8e6c8b82c57bca153d613a322fba', '[\"*\"]', '2024-08-06 10:56:27', NULL, '2024-08-06 10:56:22', '2024-08-06 10:56:27'),
(54, 'App\\Models\\User', 23, 'auth_token', '159ce4832f9ff67ed09ab6a8e694a4e7dc9ca34ad451e384f797afbcaff9c4ac', '[\"*\"]', '2024-08-06 10:59:41', NULL, '2024-08-06 10:59:35', '2024-08-06 10:59:41'),
(55, 'App\\Models\\User', 10, 'auth_token', '8d1240edc15bdf502d5dd6dad952289e5fa267198532582f0c2ecd3e9310dab9', '[\"*\"]', '2024-08-06 11:17:10', NULL, '2024-08-06 11:16:04', '2024-08-06 11:17:10'),
(56, 'App\\Models\\User', 24, 'auth_token', '50d6361d690c662616f22e007c7a72bb3c725d3369e46eaac05d7ce5cc26259d', '[\"*\"]', NULL, NULL, '2024-08-06 11:22:09', '2024-08-06 11:22:09'),
(57, 'App\\Models\\User', 14, 'auth_token', 'fd293ded78410a1ca1b6f804b866c14e9dec68ad876bf4ef1753b3a1e1328b43', '[\"*\"]', '2024-08-06 11:30:05', NULL, '2024-08-06 11:29:52', '2024-08-06 11:30:05'),
(58, 'App\\Models\\User', 14, 'auth_token', 'ca69caa2a973828d36de4731063b13d5e438f74cd1f02a6240dee37ad67facbf', '[\"*\"]', '2024-08-06 11:47:40', NULL, '2024-08-06 11:47:35', '2024-08-06 11:47:40'),
(59, 'App\\Models\\User', 14, 'auth_token', '89c6a59becb4f424f2039310a0757aac538cd2672291ec0bbce98e33dc522664', '[\"*\"]', '2024-08-06 11:48:59', NULL, '2024-08-06 11:48:55', '2024-08-06 11:48:59'),
(60, 'App\\Models\\User', 25, 'auth_token', 'ef616cc2ee988d812998fc90ef172bb93e182afd2e48fc26c2dd96e44bd3706f', '[\"*\"]', '2024-08-06 12:05:24', NULL, '2024-08-06 11:52:53', '2024-08-06 12:05:24'),
(61, 'App\\Models\\User', 14, 'auth_token', 'b67ed73eda4cfe55f6bf510bc681c32e824e39afee492d6db34ce8f68631fccc', '[\"*\"]', '2024-08-06 11:54:05', NULL, '2024-08-06 11:54:02', '2024-08-06 11:54:05'),
(62, 'App\\Models\\User', 10, 'auth_token', 'b2bded098aa4f02a49cc8e442bf378b4414381854fc4b8eb8de051b6e10f93b7', '[\"*\"]', '2024-08-06 12:12:06', NULL, '2024-08-06 12:12:01', '2024-08-06 12:12:06'),
(63, 'App\\Models\\User', 10, 'auth_token', '8a2810e5c12821d0ff73fdfba22761ce2758f65f6b78750fdbbb234e12874637', '[\"*\"]', '2024-08-06 12:43:52', NULL, '2024-08-06 12:35:42', '2024-08-06 12:43:52'),
(64, 'App\\Models\\User', 10, 'auth_token', '0350f423a7bef1aadcda4e6fcc580e8a7958857b9b4033cce87bb560def5fdba', '[\"*\"]', '2024-08-06 14:00:08', NULL, '2024-08-06 13:59:14', '2024-08-06 14:00:08'),
(65, 'App\\Models\\User', 10, 'auth_token', '75d74818ec02486d780a1eb098231e622255d8208fc0bf446d0bd8557ef3897d', '[\"*\"]', NULL, NULL, '2024-08-06 14:15:21', '2024-08-06 14:15:21'),
(66, 'App\\Models\\User', 10, 'auth_token', 'eed1c540009f0af08459cddf309d442a1f754156af087346628f6676246a7a86', '[\"*\"]', NULL, NULL, '2024-08-06 14:16:48', '2024-08-06 14:16:48'),
(67, 'App\\Models\\User', 12, 'auth_token', '42c4c2dd74a12f8bc29c53de8258cc2299a6ca0172df6d1c67052f5d47eb1f5a', '[\"*\"]', NULL, NULL, '2024-08-06 14:22:00', '2024-08-06 14:22:00'),
(68, 'App\\Models\\User', 12, 'auth_token', 'c56076a3e0814db6f1fc8e9dfee40c9e80a50b4b078daefff216e2ad93775c1b', '[\"*\"]', '2024-08-06 14:52:21', NULL, '2024-08-06 14:46:06', '2024-08-06 14:52:21'),
(69, 'App\\Models\\User', 14, 'auth_token', 'c6e5c0eb82f0baa66c36ede17eaa794365562ca9c03a3dd8be00356dc0fa5f1b', '[\"*\"]', '2024-08-06 14:54:16', NULL, '2024-08-06 14:54:02', '2024-08-06 14:54:16'),
(70, 'App\\Models\\User', 10, 'auth_token', 'cece6ff3478483c16e2613598285d57a8d59aa9b74ca64402b4f8b59752d056c', '[\"*\"]', '2024-08-06 15:06:32', NULL, '2024-08-06 15:00:24', '2024-08-06 15:06:32'),
(71, 'App\\Models\\User', 10, 'auth_token', 'c88816e09251a850d18953c004abccfd3fbb5002cd241d7ecfd019075f3bfe6c', '[\"*\"]', '2024-08-06 15:10:53', NULL, '2024-08-06 15:10:44', '2024-08-06 15:10:53'),
(72, 'App\\Models\\User', 12, 'auth_token', 'ec427315b28d207fa0d031158b41dc929ddc480b14e8176d728a319c72deddfe', '[\"*\"]', '2024-08-06 15:14:52', NULL, '2024-08-06 15:14:45', '2024-08-06 15:14:52'),
(73, 'App\\Models\\User', 12, 'auth_token', 'bf03af53ec2f0079b066b932b2a8a972742d78f4ef46db2c0f2e3d86ee773c4d', '[\"*\"]', '2024-08-06 15:18:41', NULL, '2024-08-06 15:18:32', '2024-08-06 15:18:41'),
(74, 'App\\Models\\User', 12, 'auth_token', '2cc762602b3b8de801369b667797a7ca5c43a5a14b3917750eb23b83eda4ec4c', '[\"*\"]', NULL, NULL, '2024-08-06 15:32:20', '2024-08-06 15:32:20'),
(75, 'App\\Models\\User', 12, 'auth_token', '57898954de73bd9c75e2f3d8a70e0690575fb72fde81386fe82c0a27e85965c7', '[\"*\"]', '2024-08-06 16:30:30', NULL, '2024-08-06 16:30:15', '2024-08-06 16:30:30'),
(76, 'App\\Models\\User', 12, 'auth_token', '9f0a2ca3a17b13c1fd437f2a2b6153bfb73222a99def7c79c224fae62401b537', '[\"*\"]', '2024-08-06 16:54:35', NULL, '2024-08-06 16:50:11', '2024-08-06 16:54:35'),
(77, 'App\\Models\\User', 10, 'auth_token', 'dcd355fdddde1b0055f5151972ae31feef07bff03cd5bebb0886becd410b11e6', '[\"*\"]', '2024-08-07 00:09:06', NULL, '2024-08-07 00:08:57', '2024-08-07 00:09:06'),
(78, 'App\\Models\\User', 10, 'auth_token', 'c5d39d3fe71cbd316bedb4281bdeb62514e73cf78ffbbdb9958f4644b7a34ed2', '[\"*\"]', '2024-08-07 00:19:12', NULL, '2024-08-07 00:17:49', '2024-08-07 00:19:12'),
(79, 'App\\Models\\User', 10, 'auth_token', '6d4813f78a75c4de301f323af9ea8f5489067377b6f8b7978b06afae461c4f1c', '[\"*\"]', '2024-08-07 00:22:44', NULL, '2024-08-07 00:21:58', '2024-08-07 00:22:44'),
(80, 'App\\Models\\User', 10, 'auth_token', '1a2214a3dcf5bb27b33d1e7cd5cbca2215b933a0de42a8047ab74d702ce75d40', '[\"*\"]', '2024-08-07 00:27:31', NULL, '2024-08-07 00:27:24', '2024-08-07 00:27:31'),
(81, 'App\\Models\\User', 10, 'auth_token', '4000da542cdbdd41e2ef5098e96907e1470e4ef96ebe55b6639eb50e78e27914', '[\"*\"]', '2024-08-07 00:34:43', NULL, '2024-08-07 00:34:35', '2024-08-07 00:34:43'),
(82, 'App\\Models\\User', 10, 'auth_token', '896fafd632a10e288a54c920e990b58face299f7fdf249122011944c499a9479', '[\"*\"]', '2024-08-07 00:58:17', NULL, '2024-08-07 00:54:59', '2024-08-07 00:58:17'),
(83, 'App\\Models\\User', 10, 'auth_token', '475a91e0ca49f9b383035871378f3bbfce5c7fb3b450b498555135789c21d1d7', '[\"*\"]', '2024-08-07 01:20:12', NULL, '2024-08-07 01:19:39', '2024-08-07 01:20:12'),
(84, 'App\\Models\\User', 10, 'auth_token', 'b7b7950a18577819c61a509b16da0d831a18aa07e4985de05c2763f759230dd8', '[\"*\"]', '2024-08-07 01:28:58', NULL, '2024-08-07 01:28:31', '2024-08-07 01:28:58'),
(85, 'App\\Models\\User', 10, 'auth_token', '191b688f43c7f29b219c71e42acc7da7804e0c3293cab19e3d150e0aac879fd9', '[\"*\"]', '2024-08-07 01:39:25', NULL, '2024-08-07 01:38:58', '2024-08-07 01:39:25'),
(86, 'App\\Models\\User', 10, 'auth_token', 'aed01717ee3f318357ca7b51cb3ddb37826c1fdbd9c5ff87f764220716f6cfed', '[\"*\"]', '2024-08-07 01:47:59', NULL, '2024-08-07 01:46:05', '2024-08-07 01:47:59'),
(87, 'App\\Models\\User', 26, 'auth_token', 'b4c5f997d7b5d8054c981d3b786a930a016a8758a3d8e82e7b5d44662102f8dc', '[\"*\"]', '2024-08-07 01:51:22', NULL, '2024-08-07 01:49:57', '2024-08-07 01:51:22'),
(88, 'App\\Models\\User', 10, 'auth_token', 'bee010f1e92008fdfa8980b900d67f2c8d6a139125d086386aa2fcd6b8dd8da2', '[\"*\"]', '2024-08-07 08:59:57', NULL, '2024-08-07 08:59:32', '2024-08-07 08:59:57'),
(89, 'App\\Models\\User', 10, 'auth_token', '8fec2fa2793c4b11ebcad0c23bf9a12d8542850fc3132077e5530470c32b920d', '[\"*\"]', '2024-08-07 09:02:39', NULL, '2024-08-07 09:00:36', '2024-08-07 09:02:39'),
(90, 'App\\Models\\User', 10, 'auth_token', '3900e3d73c51b095eebf7f59accd4557a4f601437179cbcb0ee8434fd16c5a1d', '[\"*\"]', '2024-08-07 10:15:51', NULL, '2024-08-07 10:15:43', '2024-08-07 10:15:51'),
(91, 'App\\Models\\User', 14, 'auth_token', '5a123b7500a85009904ce39d19427e3394d842803c6218b53e559a8a5dba4baa', '[\"*\"]', '2024-08-07 10:22:29', NULL, '2024-08-07 10:22:19', '2024-08-07 10:22:29'),
(92, 'App\\Models\\User', 14, 'auth_token', 'ebc0fca7f473a8c3c6435add8511bef24c80a2a880d0e5ccfb7c66f9a769c706', '[\"*\"]', '2024-08-07 10:34:38', NULL, '2024-08-07 10:32:02', '2024-08-07 10:34:38'),
(93, 'App\\Models\\User', 14, 'auth_token', 'f3a77543139aa89ead47e8c68cebfe605d6c824b6a66730610be42c2b5dcdc86', '[\"*\"]', '2024-08-07 10:49:04', NULL, '2024-08-07 10:49:01', '2024-08-07 10:49:04'),
(94, 'App\\Models\\User', 10, 'auth_token', '8a6c615e9d0d3531f324d23ee61b52e62b9b4d71588745ba0b5555af4fc54758', '[\"*\"]', '2024-08-07 11:26:19', NULL, '2024-08-07 11:24:06', '2024-08-07 11:26:19'),
(95, 'App\\Models\\User', 14, 'auth_token', '2c57ab34d2339fd2b97bd403035c9dcb289817239bb2b81f7f6ff46d94d2edc2', '[\"*\"]', NULL, NULL, '2024-08-07 11:33:56', '2024-08-07 11:33:56'),
(96, 'App\\Models\\User', 14, 'auth_token', '174f00e63581a350402691ba99aa0acd4eec6461dcc742c0c7c028fdc5a10b23', '[\"*\"]', NULL, NULL, '2024-08-07 11:41:49', '2024-08-07 11:41:49'),
(97, 'App\\Models\\User', 14, 'auth_token', '02104a7a6435dd4837ca58b3c259b760b9d0636d03f5c47268d1f6baf4752565', '[\"*\"]', NULL, NULL, '2024-08-07 11:46:33', '2024-08-07 11:46:33'),
(98, 'App\\Models\\User', 12, 'auth_token', '3c610622bcbde686ee08dfe199a6fab03eff68c17859b7be127edee0db54b84a', '[\"*\"]', '2024-08-07 11:49:05', NULL, '2024-08-07 11:48:31', '2024-08-07 11:49:05'),
(99, 'App\\Models\\User', 12, 'auth_token', 'b4205b01d9cb77d1b14221f682a712f4b2d055543ee73a2ec49de00ac5510905', '[\"*\"]', NULL, NULL, '2024-08-07 12:03:16', '2024-08-07 12:03:16'),
(100, 'App\\Models\\User', 12, 'auth_token', '41c326d6d90e64f1941a96deef56043f9f9dddcd3f13abd5101d196ea87ea15a', '[\"*\"]', '2024-08-07 12:28:28', NULL, '2024-08-07 12:27:48', '2024-08-07 12:28:28'),
(101, 'App\\Models\\User', 12, 'auth_token', 'aba28cdb9fbce7c5a729fa1b16ea8346f8a4e5107e48a6d5ffde872b40de8144', '[\"*\"]', '2024-08-07 14:29:11', NULL, '2024-08-07 14:29:09', '2024-08-07 14:29:11'),
(102, 'App\\Models\\User', 12, 'auth_token', 'b5e14c4e55d705bfb67654024e7ec275a5a5c1811bedf98b75f914c3fb67ce1b', '[\"*\"]', '2024-08-07 14:34:16', NULL, '2024-08-07 14:30:40', '2024-08-07 14:34:16'),
(103, 'App\\Models\\User', 12, 'auth_token', '7f1f08ee4222978855b8dfb914e60507a6687d03a613879f310fb914091d5091', '[\"*\"]', '2024-08-07 14:37:18', NULL, '2024-08-07 14:37:09', '2024-08-07 14:37:18'),
(104, 'App\\Models\\User', 12, 'auth_token', '72491e2c1ea7b2c415475fca56771fbdd833c66dd2aeba083ce29fe1b1638a84', '[\"*\"]', '2024-08-07 14:40:18', NULL, '2024-08-07 14:40:12', '2024-08-07 14:40:18'),
(105, 'App\\Models\\User', 12, 'auth_token', '8c76f120ce2d800dec456482bab40e54a15bd1fb02a5b16e99d0f3e01b63a2f7', '[\"*\"]', '2024-08-07 14:50:20', NULL, '2024-08-07 14:46:44', '2024-08-07 14:50:20'),
(106, 'App\\Models\\User', 12, 'auth_token', '64bc6e83e064404262995342817e9a57e1f2f24770b94703867533d84c3cc90a', '[\"*\"]', '2024-08-07 15:03:17', NULL, '2024-08-07 15:01:31', '2024-08-07 15:03:17'),
(107, 'App\\Models\\User', 12, 'auth_token', 'fd0bb030e016f9b46c74d5d57665ad47f14f5ccc83ffbcd1ffeb4f50128e18e3', '[\"*\"]', '2024-08-07 15:13:10', NULL, '2024-08-07 15:11:48', '2024-08-07 15:13:10'),
(108, 'App\\Models\\User', 10, 'auth_token', '9556a8de9e77a6a830c348a43e014b0d89c9e6b619ccb76ab823cdc9ff462548', '[\"*\"]', NULL, NULL, '2024-08-07 15:56:49', '2024-08-07 15:56:49'),
(109, 'App\\Models\\User', 10, 'auth_token', '52e7f4bb392c742460255c233242e3b41af41afb9dc825cbf437ce12bb84f25b', '[\"*\"]', NULL, NULL, '2024-08-07 16:01:56', '2024-08-07 16:01:56'),
(110, 'App\\Models\\User', 10, 'auth_token', 'f6dcb5824db243e2a930c05db351c670acc5db4cfe612f94fee29e2ac773ee2a', '[\"*\"]', '2024-08-07 16:09:54', NULL, '2024-08-07 16:07:41', '2024-08-07 16:09:54'),
(111, 'App\\Models\\User', 10, 'auth_token', 'b645fd772b51c146b70330d24b0b350ee4b96bee34128af131146e1292bc8b5d', '[\"*\"]', NULL, NULL, '2024-08-07 17:04:03', '2024-08-07 17:04:03'),
(112, 'App\\Models\\User', 10, 'auth_token', 'f1e2f9ca9a7563b665daeaeab39635c4dd449b029528b837fb3494b7738e01ab', '[\"*\"]', NULL, NULL, '2024-08-07 17:06:01', '2024-08-07 17:06:01'),
(113, 'App\\Models\\User', 12, 'auth_token', '1d0e60e5d4f2a7a940512de67197377541d854f0817cb3455dfc0f0072fbd6bf', '[\"*\"]', '2024-08-07 17:11:22', NULL, '2024-08-07 17:09:06', '2024-08-07 17:11:22'),
(114, 'App\\Models\\User', 26, 'auth_token', 'bb225919ddca10976b5dd7366b8de5a4c20c82b99f218b196733dd3218998ee2', '[\"*\"]', '2024-08-08 17:38:54', NULL, '2024-08-08 17:35:55', '2024-08-08 17:38:54'),
(115, 'App\\Models\\User', 12, 'auth_token', 'b42a2b6264601e127e37a1a8090c7192f2c2be49ed80268d6c568552d10fed79', '[\"*\"]', '2024-08-08 17:59:00', NULL, '2024-08-08 17:58:41', '2024-08-08 17:59:00'),
(116, 'App\\Models\\User', 12, 'auth_token', 'e440a33d92448eafa218bbb454ddd1cd0181e577786d29569182093c5a465482', '[\"*\"]', '2024-08-09 16:07:17', NULL, '2024-08-09 16:05:04', '2024-08-09 16:07:17'),
(117, 'App\\Models\\User', 10, 'auth_token', 'fe0719a98ba40f5e1948f68fe66c2fa432063267a774baf7edc4d8ae0b9293f5', '[\"*\"]', '2024-08-09 16:22:10', NULL, '2024-08-09 16:09:03', '2024-08-09 16:22:10'),
(118, 'App\\Models\\User', 12, 'auth_token', 'f79e15623f83edd8bb292058af4f6f8f99306cbe369ea0ea3a899d01713c82f0', '[\"*\"]', NULL, NULL, '2024-08-11 22:23:39', '2024-08-11 22:23:39'),
(119, 'App\\Models\\User', 12, 'auth_token', '1b90e7bbd6552181fbb3c7b4f1ed719d590666bac3e409d988bfd0ad2fe3a5c5', '[\"*\"]', NULL, NULL, '2024-08-11 22:26:20', '2024-08-11 22:26:20'),
(120, 'App\\Models\\User', 12, 'auth_token', 'fae57fec0674b1f043d49af5e642e5a3d6f389573db188fcd89557363be946d7', '[\"*\"]', '2024-08-11 22:38:25', NULL, '2024-08-11 22:38:17', '2024-08-11 22:38:25'),
(121, 'App\\Models\\User', 12, 'auth_token', 'e6a18c3538b46cbd1d02ebf821decee3692f560730579f7657b6b5dc0091395e', '[\"*\"]', NULL, NULL, '2024-08-11 22:42:41', '2024-08-11 22:42:41'),
(122, 'App\\Models\\User', 12, 'auth_token', '44f4eba7d0051442a1c50d43a4714ed4bf1f47f40ba21aa1c4da4466ed4d1d17', '[\"*\"]', '2024-08-11 22:50:35', NULL, '2024-08-11 22:44:56', '2024-08-11 22:50:35'),
(123, 'App\\Models\\User', 12, 'auth_token', '90b21e0612aaaf99d8a3ad224868063444bd9d64728fd0c73ddc9e5f47b8f7ce', '[\"*\"]', NULL, NULL, '2024-08-11 23:01:50', '2024-08-11 23:01:50'),
(124, 'App\\Models\\User', 12, 'auth_token', 'b48e7248da27790e40313baf65747a3c2345f8a697c7b2c6b65f80a1f9e3269f', '[\"*\"]', '2024-08-11 23:47:47', NULL, '2024-08-11 23:47:11', '2024-08-11 23:47:47'),
(125, 'App\\Models\\User', 12, 'auth_token', 'b28fa25d7980038c75f5ea3285fcd145fb29a5733873cc36360e14b141408d51', '[\"*\"]', '2024-08-12 01:10:41', NULL, '2024-08-12 01:10:24', '2024-08-12 01:10:41'),
(126, 'App\\Models\\User', 12, 'auth_token', '61396700abb00b64ff6dcb08689b97215746db6e15981c95f289a31745bed47d', '[\"*\"]', '2024-08-12 01:15:08', NULL, '2024-08-12 01:15:02', '2024-08-12 01:15:08'),
(127, 'App\\Models\\User', 12, 'auth_token', '29e6fca1dcb9c9282d94b2e32294ab56d964189ebcc90c3893d9ab4c389f92f6', '[\"*\"]', '2024-08-12 01:16:58', NULL, '2024-08-12 01:16:32', '2024-08-12 01:16:58'),
(128, 'App\\Models\\User', 12, 'auth_token', 'd6701cc577046c18fa3db0e2f4837536bfafb67264882fd16d10b405300a4cdb', '[\"*\"]', NULL, NULL, '2024-08-12 01:34:22', '2024-08-12 01:34:22'),
(129, 'App\\Models\\User', 12, 'auth_token', 'dfecfd11ad0a4660eeacfa3d961b10ade5d8137f0526cb54b7eed2343704958f', '[\"*\"]', NULL, NULL, '2024-08-12 01:37:59', '2024-08-12 01:37:59'),
(130, 'App\\Models\\User', 10, 'auth_token', '263f3915510119418d2fd2672ca0aaf2d137a9ea08bc283a06afc8c31c0d2f41', '[\"*\"]', '2024-08-12 11:41:01', NULL, '2024-08-12 11:40:18', '2024-08-12 11:41:01'),
(131, 'App\\Models\\User', 10, 'auth_token', '2ce997eba2f137e4052aac008a06ae64bb7aeb6a2ce95907922f4431fcfd84a4', '[\"*\"]', '2024-08-12 11:53:44', NULL, '2024-08-12 11:53:25', '2024-08-12 11:53:44'),
(132, 'App\\Models\\User', 27, 'auth_token', '1898aa967abdb838fc60a3e14beaafc689807dee77e1ca61c0b72f8a1837a231', '[\"*\"]', '2024-08-12 11:58:02', NULL, '2024-08-12 11:57:58', '2024-08-12 11:58:02'),
(133, 'App\\Models\\User', 27, 'auth_token', '1e4ce935044dd574692b23c78fa04632972d8eed3a8ba09fc09b5ae8e42886ea', '[\"*\"]', '2024-08-12 12:05:55', NULL, '2024-08-12 12:04:43', '2024-08-12 12:05:55'),
(134, 'App\\Models\\User', 28, 'auth_token', '021c78bdbfc0b08c545cd6f7e40339314c83cda36508fc9defa473f46df4c52e', '[\"*\"]', '2024-08-12 12:07:04', NULL, '2024-08-12 12:06:40', '2024-08-12 12:07:04'),
(135, 'App\\Models\\User', 12, 'auth_token', 'b0a611b346f1e26fb0b8a15107d1425bb5d12d4e0894d991db26fc750d47d430', '[\"*\"]', '2024-08-13 10:14:28', NULL, '2024-08-13 10:10:50', '2024-08-13 10:14:28'),
(136, 'App\\Models\\User', 12, 'auth_token', '99031fbb06809183b9a04f34238764eb5e4c414c24ab5e9a7dff157ddf4b7d76', '[\"*\"]', NULL, NULL, '2024-08-13 10:15:16', '2024-08-13 10:15:16'),
(137, 'App\\Models\\User', 12, 'auth_token', '8997676d082e2127bf59d96db6acc7ada0611cb7ee153097be6b5140bec5132b', '[\"*\"]', '2024-08-13 10:17:22', NULL, '2024-08-13 10:17:18', '2024-08-13 10:17:22'),
(138, 'App\\Models\\User', 12, 'auth_token', '93d39225e7eb08bab62813caf1b3837a8825cdbea8b80a57e3614d16bed12ab4', '[\"*\"]', '2024-08-13 10:57:42', NULL, '2024-08-13 10:23:53', '2024-08-13 10:57:42'),
(139, 'App\\Models\\User', 14, 'auth_token', 'e1fa50b432d916d6cfeea7f6fb360e31ad1a4317abe229f96ed98a0023ff78e6', '[\"*\"]', NULL, NULL, '2024-08-13 10:52:48', '2024-08-13 10:52:48'),
(140, 'App\\Models\\User', 29, 'auth_token', '9abc3440bdc0165fc5460eb32682339ebeaad8a887861470c5bef1c87b58fd26', '[\"*\"]', '2024-08-13 10:55:01', NULL, '2024-08-13 10:54:56', '2024-08-13 10:55:01'),
(141, 'App\\Models\\User', 29, 'auth_token', 'fbf3ee6fc788eef0914c72c81c408705bb34792e09cbb131b1f32c0445adc1ac', '[\"*\"]', '2024-08-13 10:58:30', NULL, '2024-08-13 10:56:28', '2024-08-13 10:58:30'),
(142, 'App\\Models\\User', 29, 'auth_token', '836b5de2140fe02d926b6af9c0632930b2e326dbd4a0b9d6b269f580b3936d8e', '[\"*\"]', '2024-08-13 11:07:44', NULL, '2024-08-13 11:03:33', '2024-08-13 11:07:44'),
(143, 'App\\Models\\User', 10, 'auth_token', '6dae269542fdd30bdfb032cba8cfffd6b2c3a5bd3c9570bf4a07531d08333c5b', '[\"*\"]', '2024-08-13 11:25:39', NULL, '2024-08-13 11:22:52', '2024-08-13 11:25:39'),
(144, 'App\\Models\\User', 12, 'auth_token', 'dfb41bc327cfa03f94b8b3f90773906a090bec377c88bf00090ada68a4b22d35', '[\"*\"]', '2024-08-13 11:27:40', NULL, '2024-08-13 11:27:16', '2024-08-13 11:27:40'),
(145, 'App\\Models\\User', 12, 'auth_token', '7ec499d19e29ee9c5d6534ffc9e7518cbad634051605a28dda7f0f2017b7a69c', '[\"*\"]', '2024-08-13 13:34:18', NULL, '2024-08-13 13:26:49', '2024-08-13 13:34:18'),
(146, 'App\\Models\\User', 12, 'auth_token', '7326a7329de8d3598c6c302c4cbfe6f5e82f074b4d81533a2fe5c43da0b968e0', '[\"*\"]', NULL, NULL, '2024-08-13 13:36:04', '2024-08-13 13:36:04'),
(147, 'App\\Models\\User', 12, 'auth_token', '47d7245a6f469e70382aaddae3865ce5568b0baaee50812ee8399a6f765b65f4', '[\"*\"]', '2024-08-13 13:40:25', NULL, '2024-08-13 13:40:15', '2024-08-13 13:40:25'),
(148, 'App\\Models\\User', 12, 'auth_token', 'e5cd4f8794d92a5281d7546175317aa8100340e4b3385395090ba9552f4c2499', '[\"*\"]', '2024-08-13 14:08:58', NULL, '2024-08-13 13:41:02', '2024-08-13 14:08:58'),
(149, 'App\\Models\\User', 29, 'auth_token', '2b2c2302573b383fb7150ad2da605f18084105c19bfcdcad49e7959e61dac4a7', '[\"*\"]', '2024-08-13 14:07:23', NULL, '2024-08-13 14:07:18', '2024-08-13 14:07:23'),
(150, 'App\\Models\\User', 29, 'auth_token', '4f0c65bc142f0d5e49b7c852abfb3eb2b22fcce032cff2ec320146599a1912ac', '[\"*\"]', '2024-08-13 15:37:26', NULL, '2024-08-13 14:09:38', '2024-08-13 15:37:26'),
(151, 'App\\Models\\User', 10, 'auth_token', '3d4c2d4d1588b24fad5a36eea8f0380bb5c34d987c5ebb73f2836e7a594cd4b4', '[\"*\"]', '2024-08-13 15:34:39', NULL, '2024-08-13 15:17:03', '2024-08-13 15:34:39'),
(152, 'App\\Models\\User', 12, 'auth_token', '5e1d307c0df1934e34dc6b286d4cfdb8ec89eed6ae3f2e16cddc8a2dce00b2e6', '[\"*\"]', '2024-08-13 15:36:45', NULL, '2024-08-13 15:36:33', '2024-08-13 15:36:45'),
(153, 'App\\Models\\User', 29, 'auth_token', '561f10b537aedc7f1d809c9fdf6d91a384a543102651f2f93b3429462e17f86b', '[\"*\"]', '2024-08-13 15:43:29', NULL, '2024-08-13 15:43:12', '2024-08-13 15:43:29'),
(154, 'App\\Models\\User', 29, 'auth_token', '1ec7b71835b1813ac43bec8898197d10f61a979227748661287158b52e13f5a0', '[\"*\"]', '2024-08-13 15:48:39', NULL, '2024-08-13 15:48:02', '2024-08-13 15:48:39'),
(155, 'App\\Models\\User', 10, 'auth_token', 'c0fc776e1f67295c431e93988d6c874c0b8c19d252e8d2ef8bebeca9567fabd2', '[\"*\"]', NULL, NULL, '2024-08-13 15:52:24', '2024-08-13 15:52:24'),
(156, 'App\\Models\\User', 12, 'auth_token', '7c4336f3ba518385226e35dbacee15e9374578996735c37bf185da5cf059361e', '[\"*\"]', '2024-08-13 15:55:46', NULL, '2024-08-13 15:54:27', '2024-08-13 15:55:46'),
(157, 'App\\Models\\User', 29, 'auth_token', '2850a828ac76f4f5a05a5cc777c8dfa3729b9347c1c49637943266a3795d6656', '[\"*\"]', '2024-08-13 16:15:07', NULL, '2024-08-13 16:01:27', '2024-08-13 16:15:07'),
(158, 'App\\Models\\User', 12, 'auth_token', 'd83d14afedb64968b477f1b330610ecf9a57244c82a8917652ced71d528848be', '[\"*\"]', '2024-08-13 16:16:04', NULL, '2024-08-13 16:07:29', '2024-08-13 16:16:04'),
(159, 'App\\Models\\User', 29, 'auth_token', '2897de2597cadd0ce8699de9e6258de9d6eff4cc38f469c331ea58310ae781fe', '[\"*\"]', '2024-08-13 16:17:23', NULL, '2024-08-13 16:16:33', '2024-08-13 16:17:23'),
(160, 'App\\Models\\User', 12, 'auth_token', '33380cc3a36a5a870471f84d55f8afd90dd628a19a1d5c88eee76935fabed380', '[\"*\"]', '2024-08-13 16:41:27', NULL, '2024-08-13 16:41:20', '2024-08-13 16:41:27'),
(161, 'App\\Models\\User', 12, 'auth_token', '8fa4ce6842d06fd8fbf5a1924911099fdce9098f4d6d8f386cc98ed2f6489e9e', '[\"*\"]', '2024-08-13 16:43:07', NULL, '2024-08-13 16:43:01', '2024-08-13 16:43:07'),
(162, 'App\\Models\\User', 12, 'auth_token', 'b3ffd2ed18efdb1011a79cc83142d1aa4da9376bc395c47eda079e1fc526da55', '[\"*\"]', '2024-08-13 16:57:22', NULL, '2024-08-13 16:44:33', '2024-08-13 16:57:22'),
(163, 'App\\Models\\User', 10, 'auth_token', '104bf938d3b63b6a02943d3a0def639a3faae8fba543025c082b4ca1ef8c8ae6', '[\"*\"]', '2024-08-13 17:12:41', NULL, '2024-08-13 17:09:31', '2024-08-13 17:12:41'),
(164, 'App\\Models\\User', 28, 'auth_token', '741ff3d01f2b7e558dd7254dc27deecf7b53679e5a29a6d2f17d7f8de1ee2a43', '[\"*\"]', '2024-08-13 17:21:17', NULL, '2024-08-13 17:19:17', '2024-08-13 17:21:17'),
(165, 'App\\Models\\User', 12, 'auth_token', 'b011ed2e940f6b20378281e4f35c9023323d71618df19cdf3ea69688482163c3', '[\"*\"]', '2024-08-13 17:32:57', NULL, '2024-08-13 17:22:30', '2024-08-13 17:32:57'),
(166, 'App\\Models\\User', 28, 'auth_token', '8242fa7dfb334670e8092d4a3fe2abd53d50a64e17d75bc9c59ffcc06598db45', '[\"*\"]', '2024-08-13 17:36:30', NULL, '2024-08-13 17:33:19', '2024-08-13 17:36:30'),
(167, 'App\\Models\\User', 12, 'auth_token', 'f3399d0d0dd5ebaaee2d6128acb1d5ccfa535b493abb6d3ff6aeb395a18a0255', '[\"*\"]', '2024-08-13 23:41:59', NULL, '2024-08-13 23:41:43', '2024-08-13 23:41:59'),
(168, 'App\\Models\\User', 12, 'auth_token', 'fb14e16894239e414078ae0bb98f9b6b554a900c678604eb3092a3c4f4c8dd5e', '[\"*\"]', '2024-08-13 23:47:29', NULL, '2024-08-13 23:47:23', '2024-08-13 23:47:29'),
(169, 'App\\Models\\User', 12, 'auth_token', 'd7814adc8f9a545399e0fed9d85a6040ada11a934bb8b94f975505ee5c99ac64', '[\"*\"]', '2024-08-13 23:59:45', NULL, '2024-08-13 23:59:39', '2024-08-13 23:59:45'),
(170, 'App\\Models\\User', 12, 'auth_token', '605980f120c617142e53ff2d9356f42ff31542f4010c121c2587b32544da8cfd', '[\"*\"]', '2024-08-14 00:02:03', NULL, '2024-08-14 00:01:57', '2024-08-14 00:02:03'),
(171, 'App\\Models\\User', 12, 'auth_token', 'f424cabd3a332bc00e62f043a47f272868fab54bdd3a0012b90915cd9dca063d', '[\"*\"]', '2024-08-14 00:23:34', NULL, '2024-08-14 00:22:15', '2024-08-14 00:23:34'),
(172, 'App\\Models\\User', 12, 'auth_token', '18acde320d6fa0f0d929a044a293f35e35580d7f5fcc61abdd106598c620cfae', '[\"*\"]', '2024-08-14 01:15:59', NULL, '2024-08-14 01:15:51', '2024-08-14 01:15:59'),
(173, 'App\\Models\\User', 12, 'auth_token', 'cb7106e573997b731005282909c17164df7c3460e1bf7aadde67dc7d17ba6ff0', '[\"*\"]', '2024-08-14 01:19:05', NULL, '2024-08-14 01:18:59', '2024-08-14 01:19:05'),
(174, 'App\\Models\\User', 12, 'auth_token', '2894269b54365e97f8204c6937aafd562fc319c94c92ef748cb45e7910d0a96b', '[\"*\"]', '2024-08-14 01:21:19', NULL, '2024-08-14 01:21:13', '2024-08-14 01:21:19'),
(175, 'App\\Models\\User', 10, 'auth_token', '20198536cc316b8cbe5e42bb75adad1492fc89a63daa3bd9bb62f3fb05d88bd2', '[\"*\"]', '2024-08-14 01:36:42', NULL, '2024-08-14 01:28:04', '2024-08-14 01:36:42'),
(176, 'App\\Models\\User', 12, 'auth_token', '753f1c221defa1b46bb36d829510594d04e133ae5322a7f8a66c86340058e5a4', '[\"*\"]', '2024-08-14 09:18:20', NULL, '2024-08-14 09:17:45', '2024-08-14 09:18:20'),
(177, 'App\\Models\\User', 12, 'auth_token', '344ab3dba5f9105ffbe565ceb537294f33a2255bb83426f523a763f521bb739c', '[\"*\"]', '2024-08-14 10:17:14', NULL, '2024-08-14 09:29:28', '2024-08-14 10:17:14'),
(178, 'App\\Models\\User', 29, 'auth_token', 'dfa4493f1074b69c9202df465fb0aaa6c572b5fa380f0c1b449499cfb9cd1b17', '[\"*\"]', '2024-08-14 09:44:52', NULL, '2024-08-14 09:44:40', '2024-08-14 09:44:52'),
(179, 'App\\Models\\User', 29, 'auth_token', 'f49f4f2c59997a570730a674155ce97df36012686b8b5f86bc16948d5ae979eb', '[\"*\"]', '2024-08-14 09:55:01', NULL, '2024-08-14 09:54:58', '2024-08-14 09:55:01'),
(180, 'App\\Models\\User', 29, 'auth_token', '85ed09024a0e9d2107c9b54a540d1a2848d3fba394014c4a0473b61e5944bcfa', '[\"*\"]', '2024-08-14 10:00:12', NULL, '2024-08-14 10:00:07', '2024-08-14 10:00:12'),
(181, 'App\\Models\\User', 29, 'auth_token', '2fbc2d88196013ced6ddeefd98c86695074d65d8ddbcd6c1a7fdd24355352e9d', '[\"*\"]', '2024-08-14 10:05:17', NULL, '2024-08-14 10:05:11', '2024-08-14 10:05:17'),
(182, 'App\\Models\\User', 29, 'auth_token', 'f24cf04e980f5a933232cc08a9df647382b755c60290de96754390f58d27d676', '[\"*\"]', '2024-08-14 10:24:47', NULL, '2024-08-14 10:09:39', '2024-08-14 10:24:47'),
(183, 'App\\Models\\User', 12, 'auth_token', '341a3cd4e4d0deea8d4074e043891a78eecac5411a2720d7299aac5bd2de1ef0', '[\"*\"]', '2024-08-14 10:20:25', NULL, '2024-08-14 10:20:17', '2024-08-14 10:20:25'),
(184, 'App\\Models\\User', 12, 'auth_token', '50fda432ff354c73cab688494c288826b8712a44e769c77780f6fca1c0682853', '[\"*\"]', '2024-08-14 10:46:37', NULL, '2024-08-14 10:46:28', '2024-08-14 10:46:37'),
(185, 'App\\Models\\User', 12, 'auth_token', 'f73a9833bff7bc9631455e52ec9d3c7654d0ef10096fdb329bcb2ad03933a8c2', '[\"*\"]', '2024-08-14 11:02:14', NULL, '2024-08-14 11:02:09', '2024-08-14 11:02:14'),
(186, 'App\\Models\\User', 12, 'auth_token', '2500eec459dc8cae46229a55e9c02d5559b3c79a2aee5defa6995dbd3a3c3d73', '[\"*\"]', '2024-08-14 11:08:56', NULL, '2024-08-14 11:08:52', '2024-08-14 11:08:56'),
(187, 'App\\Models\\User', 12, 'auth_token', 'a5866e69f2262b5645960214e7c4f2c479af76d1afe78ff2e486bd3dfe2a7b43', '[\"*\"]', '2024-08-14 11:12:43', NULL, '2024-08-14 11:12:36', '2024-08-14 11:12:43'),
(188, 'App\\Models\\User', 12, 'auth_token', '42a3bb544691ecbc722b6241300e7da2b490bd42309282a4e64d2fec65d1fea7', '[\"*\"]', '2024-08-14 11:20:47', NULL, '2024-08-14 11:15:44', '2024-08-14 11:20:47'),
(189, 'App\\Models\\User', 12, 'auth_token', 'f306a62bdef505768e043f18bbe252d636ea51b5cfffec52ceea58d0ee3a53b8', '[\"*\"]', '2024-08-14 11:30:29', NULL, '2024-08-14 11:30:25', '2024-08-14 11:30:29'),
(190, 'App\\Models\\User', 12, 'auth_token', 'e123cec5e5db6bbeeb67df99fb8e8bbfd4c0f9d31c8b316a4490db052b6b96c6', '[\"*\"]', '2024-08-14 11:36:04', NULL, '2024-08-14 11:35:54', '2024-08-14 11:36:04'),
(191, 'App\\Models\\User', 12, 'auth_token', '3fd6deb5c94dea314674a8836f382c24f5b6b58eded059d02ed588dcbc81c6d0', '[\"*\"]', '2024-08-14 11:37:30', NULL, '2024-08-14 11:37:04', '2024-08-14 11:37:30'),
(192, 'App\\Models\\User', 12, 'auth_token', '0eb2ae5c4c230754d872adf3fd664bed7799aa9fcb8e06657fec2b246755e448', '[\"*\"]', '2024-08-14 11:38:40', NULL, '2024-08-14 11:38:35', '2024-08-14 11:38:40'),
(193, 'App\\Models\\User', 10, 'auth_token', 'fbc1d0c1b7f0845df68d5d737478d378a155eeb47b5bb211aaa843628c2a18de', '[\"*\"]', '2024-08-14 11:39:21', NULL, '2024-08-14 11:39:17', '2024-08-14 11:39:21'),
(194, 'App\\Models\\User', 29, 'auth_token', '1a66c4b459159f675bca2d555e868f0553bea1a59948f59fcccc88ae724fdafc', '[\"*\"]', '2024-08-14 11:44:00', NULL, '2024-08-14 11:43:57', '2024-08-14 11:44:00'),
(195, 'App\\Models\\User', 12, 'auth_token', '95c2f76080a5c5414729d05fa49f345e95f14894aed9aeedaf905659e442ae29', '[\"*\"]', '2024-08-14 11:44:20', NULL, '2024-08-14 11:44:16', '2024-08-14 11:44:20'),
(196, 'App\\Models\\User', 12, 'auth_token', '2a9561d460a072bb0e3ff958c2ebd1217096967b2baae423d44989a94c91f334', '[\"*\"]', '2024-08-14 12:01:40', NULL, '2024-08-14 11:44:58', '2024-08-14 12:01:40'),
(197, 'App\\Models\\User', 12, 'auth_token', '2f071610862bd7ed8d4c0534ed84b39a8971f46e36852c47bb841568802a8ea4', '[\"*\"]', '2024-08-14 12:09:30', NULL, '2024-08-14 12:09:26', '2024-08-14 12:09:30'),
(198, 'App\\Models\\User', 12, 'auth_token', '691ca82952014a4b2a2aa91309b18296a193a17bb43edebc0c7353ee6dd12f06', '[\"*\"]', '2024-08-14 12:12:06', NULL, '2024-08-14 12:11:45', '2024-08-14 12:12:06'),
(199, 'App\\Models\\User', 12, 'auth_token', '4a978213a14bdc1b4c35c44933dace22d866f8b780f279773981648966b6165d', '[\"*\"]', '2024-08-14 12:14:43', NULL, '2024-08-14 12:14:36', '2024-08-14 12:14:43'),
(200, 'App\\Models\\User', 29, 'auth_token', '84020f16a40004928c7bcfbfc88a5a315a8387e7089d12c31415c1fd8fbb8570', '[\"*\"]', '2024-08-14 16:56:24', NULL, '2024-08-14 16:53:52', '2024-08-14 16:56:24'),
(201, 'App\\Models\\User', 12, 'auth_token', 'ad36a70b45943c6db439363a82c6cf1679f4fffd68c8ddfccd4d256b44de8b6d', '[\"*\"]', '2024-08-14 17:56:44', NULL, '2024-08-14 17:52:43', '2024-08-14 17:56:44'),
(202, 'App\\Models\\User', 10, 'auth_token', 'afe456e971d8b067c7d00c54bbed2cbcd6e20d3e2f72ca24ec2f9396002e620d', '[\"*\"]', '2024-08-15 00:54:16', NULL, '2024-08-15 00:42:55', '2024-08-15 00:54:16'),
(203, 'App\\Models\\User', 12, 'auth_token', '4c5ed66714bb0ede08a65ab3fb011011fab98b504b9ff7bf6a6521fdf15effae', '[\"*\"]', '2024-08-15 02:01:51', NULL, '2024-08-15 00:59:28', '2024-08-15 02:01:51'),
(204, 'App\\Models\\User', 12, 'auth_token', '00223c34f97b7fe3a196e5be55d67170a005581a3b61b26bf8d96e1e9924639c', '[\"*\"]', '2024-08-16 09:14:25', NULL, '2024-08-16 09:08:56', '2024-08-16 09:14:25'),
(205, 'App\\Models\\User', 29, 'auth_token', '4f463f7da9e8dad35df268a21b5a3a9461dc4db6db3a8d441aef08b877dd33ec', '[\"*\"]', '2024-08-16 09:15:25', NULL, '2024-08-16 09:15:16', '2024-08-16 09:15:25'),
(206, 'App\\Models\\User', 29, 'auth_token', '8167b9f521a85f848490e8c4bd7c4b743fcff78940acb67ea84f39ea1e52c242', '[\"*\"]', '2024-08-16 09:20:05', NULL, '2024-08-16 09:18:49', '2024-08-16 09:20:05'),
(207, 'App\\Models\\User', 14, 'auth_token', 'baabff85023752b2ed7c90993b4f30ee644c366c93ffef233764893f41ef4702', '[\"*\"]', '2024-08-16 09:30:56', NULL, '2024-08-16 09:20:22', '2024-08-16 09:30:56'),
(208, 'App\\Models\\User', 29, 'auth_token', '658bcde4207dd82c5bb4963ec1cf6421b63a6728325295662e1ea375740fb68b', '[\"*\"]', '2024-08-16 09:48:12', NULL, '2024-08-16 09:48:09', '2024-08-16 09:48:12'),
(209, 'App\\Models\\User', 29, 'auth_token', 'f1e36c6a894987ee4939038fe51a81542ff6fbb019de23a0b44be989dea347f2', '[\"*\"]', '2024-08-16 10:43:42', NULL, '2024-08-16 09:51:10', '2024-08-16 10:43:42'),
(210, 'App\\Models\\User', 12, 'auth_token', 'd4ca40437e6cacf4cb93fb3d45e9e6dc005de4195de2baa2c5cc3aeee1654922', '[\"*\"]', '2024-08-16 10:15:35', NULL, '2024-08-16 10:14:50', '2024-08-16 10:15:35'),
(211, 'App\\Models\\User', 12, 'auth_token', '6b53c7008b615221827bdcd42cc8215b6010f1a6abdb634ca0ce507f19629e27', '[\"*\"]', '2024-08-16 10:40:46', NULL, '2024-08-16 10:37:50', '2024-08-16 10:40:46'),
(212, 'App\\Models\\User', 12, 'auth_token', 'af171e4cb3108b2bb018e819f227f09a230d17b5dc1af34b9df54446df95dc27', '[\"*\"]', '2024-08-16 11:03:37', NULL, '2024-08-16 11:03:32', '2024-08-16 11:03:37'),
(213, 'App\\Models\\User', 12, 'auth_token', '174b894d9f21f87f37c4297431e37dd71a5ce1659f1083bf795f6a351eb57761', '[\"*\"]', '2024-08-16 11:06:38', NULL, '2024-08-16 11:06:34', '2024-08-16 11:06:38'),
(214, 'App\\Models\\User', 12, 'auth_token', '0e7a09fdbf99a9c1a967f36916d06e8d8574b3bffc14ab9ce0ccc57a9b6cd0c8', '[\"*\"]', '2024-08-16 11:09:54', NULL, '2024-08-16 11:09:50', '2024-08-16 11:09:54'),
(215, 'App\\Models\\User', 12, 'auth_token', 'b2baa377c41dc86ccec037d235e2782d9667ad534aed8b6e8ec7b7853fae7af9', '[\"*\"]', '2024-08-16 11:14:25', NULL, '2024-08-16 11:14:21', '2024-08-16 11:14:25'),
(216, 'App\\Models\\User', 12, 'auth_token', 'bd7defe38c2f9e50d1c7ced1974d9467bde8611ce61f003de8f00164e66cf568', '[\"*\"]', '2024-08-16 11:17:56', NULL, '2024-08-16 11:17:53', '2024-08-16 11:17:56'),
(217, 'App\\Models\\User', 12, 'auth_token', '012a3f1d2cf083cbea768f1b21f8c96253b0fc307ee144bcb11c691706d3f6fb', '[\"*\"]', '2024-08-16 11:22:04', NULL, '2024-08-16 11:21:22', '2024-08-16 11:22:04'),
(218, 'App\\Models\\User', 12, 'auth_token', 'db0ef1da8bc23c44e23cc978801660dce35444a4e8524294a2e7b23d3f9fa2b6', '[\"*\"]', NULL, NULL, '2024-08-16 11:23:24', '2024-08-16 11:23:24'),
(219, 'App\\Models\\User', 12, 'auth_token', 'd3205856a90f0849f198d20d7e8d71b47836ed2047e91b01e4f00f3caea91003', '[\"*\"]', '2024-08-16 11:26:15', NULL, '2024-08-16 11:24:25', '2024-08-16 11:26:15'),
(220, 'App\\Models\\User', 12, 'auth_token', '38c39c78fb42590bccc21fddfa896c44762624af81dbe7df01fd81f664badcb0', '[\"*\"]', '2024-08-16 11:38:11', NULL, '2024-08-16 11:32:28', '2024-08-16 11:38:11'),
(221, 'App\\Models\\User', 12, 'auth_token', '8f2abe3d4a000ce763c6e826f03931c4eb0ba16b21a29786af509698c70d01e2', '[\"*\"]', '2024-08-16 16:19:50', NULL, '2024-08-16 15:10:03', '2024-08-16 16:19:50'),
(222, 'App\\Models\\User', 30, 'auth_token', 'd60152c680f2f11761a42a582250fd4988e9ea93327630e345425644c3e6fa96', '[\"*\"]', '2024-08-16 16:14:41', NULL, '2024-08-16 16:12:02', '2024-08-16 16:14:41'),
(223, 'App\\Models\\User', 30, 'auth_token', 'b22729a02b10ae0dca1a84a21d26258ba345ae40d510f9be4af6947b71de96ed', '[\"*\"]', '2024-08-16 16:15:48', NULL, '2024-08-16 16:15:01', '2024-08-16 16:15:48'),
(224, 'App\\Models\\User', 30, 'auth_token', '93f016a63bdf763becc8378fac5be735757c174fd3d7ca2ac6371ba0c42ec0d9', '[\"*\"]', '2024-08-16 16:20:11', NULL, '2024-08-16 16:17:02', '2024-08-16 16:20:11');

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2024-08-02 11:16:46', '2024-08-02 11:16:46'),
(2, 'utilisateur_normal', 'web', '2024-08-02 11:16:46', '2024-08-02 11:16:46');

-- --------------------------------------------------------

--
-- Structure de la table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int DEFAULT NULL,
  `sexe` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pays` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ville` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fcm_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `age`, `sexe`, `pays`, `ville`, `telephone`, `image`, `blood_group`, `remember_token`, `fcm_token`, `created_at`, `updated_at`) VALUES
(2, 'Yalaweogo Wendyam Eric Cheich Omar', 'cheich.yalaweogo61@gmail.com', NULL, '$2y$12$6yP1CzWVWT.EAClGvToqx.yCo7bLCyZeC77ulsEB.oow1Sx68whUe', 26, 'Homme', 'Burkina', 'Ouagadougou', '0022666054115', 'images/JZBpzakDj7DR3YgClloXHTGQLdKSMV5VqOeOfJFh.png', 'A+', NULL, NULL, '2024-08-02 11:33:04', '2024-08-02 11:33:04'),
(3, 'omar', 'cheich.yalaweogo@gmail.com', NULL, '$2y$12$ROCxKLntaJKVRr9AXd.FIeBBY5uXcAZuiPEJ9N66/61C0YLL0QFR.', 27, 'Femme', 'Cote-dIvoire', 'Abidjan', '0022507848695', NULL, 'O-', NULL, NULL, '2024-08-02 15:20:18', '2024-08-02 15:20:18'),
(4, 'rach', 'rach@gmail.com', NULL, '$2y$12$/05OEUzS4aLzY.COX9.xyu3yDgKF1Knqk3Jg4t5JAKBr6Nylg2MUy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-08-02 17:25:48', '2024-08-02 17:25:48'),
(6, 'Yalaweogo Eric', 'eric@gmail.com', NULL, '$2y$12$6V0jYoPX7io/h06frvUCZOt7GITM.AQyvB.J.p03svOnvTTl6Dhty', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-08-05 22:12:13', '2024-08-05 22:12:13'),
(7, 'rachid', 'rachido@gmail.com', NULL, '$2y$12$mxA9zjz6tz.JdMOXDHbMGeQvxjfcvduwvawxw4z07IngeMro9aGu.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-08-05 22:24:13', '2024-08-05 22:24:13'),
(8, 'rachida', 'rachid@gmail.com', NULL, '$2y$12$5oIbNsTPhu3XXseudjr8ge5rQx6iX2H1MP.tKMLP/5aks0riNVo4K', NULL, NULL, NULL, NULL, '66054115', NULL, NULL, NULL, NULL, '2024-08-05 22:25:11', '2024-08-05 22:25:11'),
(10, 'Rodrigue Bonkoungou', 'vincent@gmail.com', NULL, '$2y$12$hsFYu3y2bF57VlY0qao6u.uvNH79CbDIfk6rbTdT1J.RBEJLPvCBi', 28, 'Homme', 'Burkina Faso', 'Ouagadougou', '64925038', 'images/ZLX1zneceqKPEtBsCW7l6AYp7Ae1IslyMaepBLdJ.jpg', 'A+', NULL, NULL, '2024-08-05 22:45:33', '2024-08-13 17:12:08'),
(11, 'ben', 'ben@gmail.com', NULL, '$2y$12$qcOfqXymv4bef3Raa9YKSeidFt7/q6Vq1hFFszB.3oDrkysE4KTYW', NULL, NULL, NULL, NULL, '56789090', NULL, NULL, NULL, NULL, '2024-08-05 23:16:36', '2024-08-05 23:16:36'),
(12, 'TRAORE Laouratou', 'fanta@gmail.com', NULL, '$2y$12$OGFiXuDlowjT./fvi5Epyect1CRnzW/CrnrB9mNz4bUeSWCDLIt3O', 36, 'Femme', 'Burkina', 'Ouagadougou', '65879825', 'images/JTSwQy9utpI1jwmE1nuLi9cGu9pU2Miyk3rkjpzZ.jpg', 'B-', NULL, NULL, '2024-08-06 01:30:23', '2024-08-13 17:28:48'),
(13, 'Traore Laouratou', 'laou@gmail.com', NULL, '$2y$12$EBiJ.mOFlAH0nTxUv0eV.O3C7HdRX9s8Qgx6wSu/2wkEFYi45JE1e', NULL, NULL, NULL, NULL, '54345678', NULL, NULL, NULL, NULL, '2024-08-06 09:34:35', '2024-08-06 09:34:35'),
(14, 'Koloma', 'fadel@gmail.com', NULL, '$2y$12$bDrFWtxnYsAtQnrXb28mS.p2N.wEWnNnQpFnHHzLXZQR2iK.JBsfC', 20, 'Homme', 'Côte d\'Ivoire', 'bassam', '0173586441', 'images/kQIfhBnJu895uLO2owWMf0RHny7xQ2chOuNsw8bA.jpg', NULL, NULL, NULL, '2024-08-06 09:41:07', '2024-08-07 10:34:32'),
(15, 'fadel', 'fadel1@gmail.com', NULL, '$2y$12$SIgVnOF8FTlra6XqoNKY/OPMaLuwI2HRwAVoCykWzcX6DDAIR3aYK', NULL, NULL, NULL, NULL, '0710238502', NULL, NULL, NULL, NULL, '2024-08-06 09:44:27', '2024-08-06 09:44:27'),
(18, 'Hamado', 'ham@gmail.com', NULL, '$2y$12$ApEebYGTwQrD60K57wsy0uhEMps7FGE4UGXjSvWrwcyvelU2JdiHy', NULL, NULL, NULL, NULL, '54678909', NULL, NULL, NULL, NULL, '2024-08-06 09:55:05', '2024-08-06 09:55:05'),
(19, 'fadel', 'fat@gmail.com', NULL, '$2y$12$PLv44DLYwSyKEBcUwekNw.uz7Vd93Tevra7nKWdx7GHGaW55HqkeG', NULL, NULL, NULL, NULL, '56765456', NULL, NULL, NULL, NULL, '2024-08-06 10:02:37', '2024-08-06 10:02:37'),
(20, 'bonjour', 'bon@gmail.com', NULL, '$2y$12$kJ41FFYIxSAgNqjaOA9DNOUbp.GLBPMHrYs74RMHbU38j8YHfQzxu', NULL, NULL, NULL, NULL, '54678909', NULL, NULL, NULL, NULL, '2024-08-06 10:12:48', '2024-08-06 10:12:48'),
(21, 'Omar', 'baro@gmail.com', NULL, '$2y$12$O./SbymgtMraADQKh1jSr.nNkL1p3fhZWcGbncxYyr5em3eqaTLZ2', NULL, NULL, NULL, NULL, '66543454', NULL, NULL, NULL, NULL, '2024-08-06 10:15:12', '2024-08-06 10:15:12'),
(22, 'oumar', 'oumar@gmail.com', NULL, '$2y$12$HqrcwFaSqxK29AcaJ2w3Ke32Dbue4GmNJt2lr3m64goIhfFRMx7UK', NULL, NULL, NULL, NULL, '0156524656', NULL, NULL, NULL, NULL, '2024-08-06 10:27:15', '2024-08-06 10:27:15'),
(23, 'bintou diaby', 'bintou@gmail.com', NULL, '$2y$12$iIzfc12bqD/t8gyBRZV2puMkgkI.rHuS/czzNAaRq746V3sBVNfqC', NULL, NULL, NULL, NULL, '0173586666', NULL, NULL, NULL, NULL, '2024-08-06 10:59:35', '2024-08-06 10:59:35'),
(24, 'beni', 'beni@gmail.com', NULL, '$2y$12$FC1hVxv0oJTTbf0ZiClg9uegjtSi8k3VfTcSzhoqrPnfhFmDX4YeW', NULL, NULL, NULL, NULL, '1469953246', NULL, NULL, NULL, NULL, '2024-08-06 11:22:08', '2024-08-06 11:22:08'),
(25, 'Adelt', 'ade@gmail.com', NULL, '$2y$12$4lzZpaPAih6Z2utoJscriuy6XTt2vLY/qCBU0ffvT3dDLDaE1Zp3i', NULL, NULL, NULL, NULL, '35795432', NULL, 'B+', NULL, NULL, '2024-08-06 11:52:53', '2024-08-06 11:52:58'),
(26, 'Sawadogo Mariam', 'mariam@gmail.com', NULL, '$2y$12$IuclkL.ufWrZ72pNojrTDe10LduDt1uL33gXrEE33lxGzIohXVhKy', 32, 'Femme', 'Côte d\'Ivoire', 'Abidjan', '0022507654321', 'images/YdYhNmhn69AiY6AdrcL1WeqPZU7ss8v8lNvANHCi.png', 'O-', NULL, NULL, '2024-08-07 01:49:57', '2024-08-07 01:51:09'),
(27, 'Mamadou', 'ma@gmail.com', NULL, '$2y$12$lf7wNESGhmhpQhCpyuqxle4TExL8Qxe4/QNwWQEnB6ONKY7DHtOY6', NULL, NULL, NULL, NULL, '67564532', NULL, 'A-', NULL, NULL, '2024-08-12 11:57:57', '2024-08-12 11:58:02'),
(28, 'Binta', 'Binta@gmail.com', NULL, '$2y$12$yhtTszHDg2R./3YG1df8h.DZ5Np.0xBucLiW/pT8et4djTitaxFaa', NULL, NULL, NULL, NULL, '56789087', NULL, 'A+', NULL, NULL, '2024-08-12 12:06:40', '2024-08-12 12:06:48'),
(29, 'fadel', 'Batman@gmail.com', NULL, '$2y$12$9uF2k/DmmgXXg5rn1kYTuO7NPIGCpgXW8CKLNFe5mvk4qwYzEI4vm', NULL, NULL, NULL, NULL, '12345678', NULL, 'A+', NULL, NULL, '2024-08-13 10:54:56', '2024-08-13 10:55:01'),
(30, 'Bonkoungou Latifa Ashley', 'bonkoungouashley8@gmail.com', NULL, '$2y$12$Efr9bPaQgV644yMXPomB..c3hVS8NFhP13Ftcv9u1IbdBYG2P93zy', 22, 'Femme', 'Burkina Faso', 'Ouagadougou', '60519565', 'images/Im9ds8iuUeJcQbdyTyndTPXO6eUFX7CgxV6Tdjyr.jpg', 'B+', NULL, NULL, '2024-08-16 16:12:02', '2024-08-16 16:18:05');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `annonces`
--
ALTER TABLE `annonces`
  ADD CONSTRAINT `annonces_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_annonce_id_foreign` FOREIGN KEY (`annonce_id`) REFERENCES `annonces` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
