--
-- PostgreSQL database dump
--

\restrict aeH5dchGIjHkv40c5MsQkzd5GBWFWEd8eE63eC1nFCCkTzYMfrPvJfeViqRPJdz

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	cab8578e-2881-4c5f-a8a8-8f5dc99c3f1b	{"action":"user_confirmation_requested","actor_id":"a49228be-1c36-4f0f-b60e-e699614e2f50","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-05 18:47:14.549323+00	
00000000-0000-0000-0000-000000000000	5f22dc22-9d23-4814-8851-ab41b7891b0c	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"a49228be-1c36-4f0f-b60e-e699614e2f50","user_phone":""}}	2025-08-05 18:47:52.644531+00	
00000000-0000-0000-0000-000000000000	1c6e6306-a3fc-4870-bf89-6dfb5cbc310a	{"action":"user_confirmation_requested","actor_id":"ed4dc101-13b2-4986-aaeb-63127202fdb6","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-05 18:48:00.397165+00	
00000000-0000-0000-0000-000000000000	e51713e4-d52b-4b50-a6a6-726d8dbf9cfa	{"action":"user_signedup","actor_id":"ed4dc101-13b2-4986-aaeb-63127202fdb6","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-05 18:49:00.688298+00	
00000000-0000-0000-0000-000000000000	2df9e8b1-01ee-4500-b7d8-6c0954e079ea	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"ed4dc101-13b2-4986-aaeb-63127202fdb6","user_phone":""}}	2025-08-05 18:57:08.070926+00	
00000000-0000-0000-0000-000000000000	da0f308c-bc68-4f2b-9012-10db8f56ee7f	{"action":"user_confirmation_requested","actor_id":"4388d56a-775c-4bb3-9dac-4e52358add52","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-05 18:57:19.230456+00	
00000000-0000-0000-0000-000000000000	912cb68f-a168-4510-a705-a34e36867288	{"action":"user_confirmation_requested","actor_id":"4388d56a-775c-4bb3-9dac-4e52358add52","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-05 18:58:45.173708+00	
00000000-0000-0000-0000-000000000000	274b0b09-f30a-4298-98ed-b83b283c92c7	{"action":"user_confirmation_requested","actor_id":"1848b7ef-5590-4da9-9be3-6c7ebb7e0c94","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-05 18:59:00.161047+00	
00000000-0000-0000-0000-000000000000	4e17aa32-3b16-4712-ace1-ce123476a6bd	{"action":"user_signedup","actor_id":"1848b7ef-5590-4da9-9be3-6c7ebb7e0c94","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-05 18:59:27.055941+00	
00000000-0000-0000-0000-000000000000	210e3a31-6a93-4548-97f3-77fa1fead54a	{"action":"logout","actor_id":"1848b7ef-5590-4da9-9be3-6c7ebb7e0c94","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"account"}	2025-08-05 18:59:46.236913+00	
00000000-0000-0000-0000-000000000000	6d314386-a08c-48ad-9f85-5ad1d6cbdaae	{"action":"login","actor_id":"1848b7ef-5590-4da9-9be3-6c7ebb7e0c94","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-05 18:59:55.665206+00	
00000000-0000-0000-0000-000000000000	7a67f31c-3590-433c-ac87-521cb51b43ca	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"4388d56a-775c-4bb3-9dac-4e52358add52","user_phone":""}}	2025-08-05 19:00:36.517306+00	
00000000-0000-0000-0000-000000000000	9248b4a3-d837-47d7-a143-440bd0a8d3f4	{"action":"logout","actor_id":"1848b7ef-5590-4da9-9be3-6c7ebb7e0c94","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"account"}	2025-08-05 19:00:42.888277+00	
00000000-0000-0000-0000-000000000000	81c764aa-d7d2-4963-86be-1c773c83f68d	{"action":"user_confirmation_requested","actor_id":"28ba1a27-795f-40fa-bea5-1576b0b68392","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-05 19:00:51.822443+00	
00000000-0000-0000-0000-000000000000	44d8a27c-d67b-4c52-bd09-3c8d0cdad4d3	{"action":"user_signedup","actor_id":"28ba1a27-795f-40fa-bea5-1576b0b68392","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-05 19:01:11.011295+00	
00000000-0000-0000-0000-000000000000	b5fc1bcf-17d2-4664-a47c-2251d18d0596	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justin.mcintyre@wwt.com","user_id":"1848b7ef-5590-4da9-9be3-6c7ebb7e0c94","user_phone":""}}	2025-08-05 19:08:05.358768+00	
00000000-0000-0000-0000-000000000000	73560653-ef83-44e8-a77f-3db2517a434e	{"action":"logout","actor_id":"28ba1a27-795f-40fa-bea5-1576b0b68392","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-05 19:08:09.464231+00	
00000000-0000-0000-0000-000000000000	206f1320-85d1-4896-922b-39f17024aa1a	{"action":"user_repeated_signup","actor_id":"28ba1a27-795f-40fa-bea5-1576b0b68392","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-05 19:08:17.175896+00	
00000000-0000-0000-0000-000000000000	80830190-912c-4974-b209-39423314cd6f	{"action":"user_repeated_signup","actor_id":"28ba1a27-795f-40fa-bea5-1576b0b68392","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-05 19:08:39.451484+00	
00000000-0000-0000-0000-000000000000	1c07965c-9d3a-4997-94f9-d3dc3d66cd3a	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"28ba1a27-795f-40fa-bea5-1576b0b68392","user_phone":""}}	2025-08-05 19:09:10.378249+00	
00000000-0000-0000-0000-000000000000	1398707c-0096-4a1c-8e00-1b3e652050df	{"action":"user_confirmation_requested","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-05 19:11:58.299985+00	
00000000-0000-0000-0000-000000000000	f16b8b6d-8f80-4117-9dff-5c7c9348b91c	{"action":"user_signedup","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-05 19:12:49.345281+00	
00000000-0000-0000-0000-000000000000	32a505b2-1ff1-40ba-8582-dcc3b825211f	{"action":"logout","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-05 19:13:06.084243+00	
00000000-0000-0000-0000-000000000000	0019220a-3ceb-4983-bcd5-63d731119359	{"action":"login","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-05 19:13:16.887887+00	
00000000-0000-0000-0000-000000000000	f68a78e4-fada-4e47-8cfb-78c4fe1f95ef	{"action":"user_recovery_requested","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-05 19:13:52.149271+00	
00000000-0000-0000-0000-000000000000	60c34626-c2ee-45e7-8547-8ecbf1af277b	{"action":"login","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-05 19:14:04.03487+00	
00000000-0000-0000-0000-000000000000	3a11b37b-3705-499e-a659-91d9942de91d	{"action":"user_recovery_requested","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-05 19:19:34.741044+00	
00000000-0000-0000-0000-000000000000	4778c41d-9ed8-40ec-9d11-7d0a4f2d11b4	{"action":"login","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-05 19:19:51.025733+00	
00000000-0000-0000-0000-000000000000	fc94f939-0b47-433a-86cc-54d4d64dac97	{"action":"user_recovery_requested","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-05 19:24:27.456167+00	
00000000-0000-0000-0000-000000000000	66818f13-b895-49d9-a75f-944ac1407ef0	{"action":"login","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-05 19:24:42.289009+00	
00000000-0000-0000-0000-000000000000	c69fcf61-c27b-449b-8cc1-7f40a7178c01	{"action":"user_recovery_requested","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-05 19:31:19.058196+00	
00000000-0000-0000-0000-000000000000	8bd64709-1c7d-4321-84a7-27ae6a89be6c	{"action":"login","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-05 19:31:32.064634+00	
00000000-0000-0000-0000-000000000000	61af285e-8107-4b96-ad25-de43605df268	{"action":"user_recovery_requested","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-05 19:33:42.259007+00	
00000000-0000-0000-0000-000000000000	d9d298a6-c924-428f-b3d7-94ea45c8f3ba	{"action":"login","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 11:46:43.619483+00	
00000000-0000-0000-0000-000000000000	ab00c155-f957-403c-9d3c-a4f385564b2c	{"action":"token_refreshed","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-06 13:24:26.554035+00	
00000000-0000-0000-0000-000000000000	14d84852-2906-4526-bc60-f439230fb419	{"action":"token_revoked","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-06 13:24:26.577665+00	
00000000-0000-0000-0000-000000000000	f9769bcd-9ad0-41d0-8217-15401dda1e83	{"action":"logout","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 13:24:29.200966+00	
00000000-0000-0000-0000-000000000000	a1b8cfe3-3de5-4755-aacf-0a93c1db2406	{"action":"login","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-06 13:33:53.675092+00	
00000000-0000-0000-0000-000000000000	28982ef3-3e63-4783-a6fd-09eaadae2784	{"action":"logout","actor_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 13:34:03.137775+00	
00000000-0000-0000-0000-000000000000	9da5a064-f22d-4174-828f-687824629172	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"64ae8bfd-ecd1-46ca-a18f-84352e54b121","user_phone":""}}	2025-08-06 13:34:22.468692+00	
00000000-0000-0000-0000-000000000000	e323895e-e7c0-44c2-9928-f30bb0b8e6c4	{"action":"user_confirmation_requested","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 13:35:02.931576+00	
00000000-0000-0000-0000-000000000000	2989ed0e-f642-4977-8bda-eba351deda56	{"action":"user_signedup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-06 13:35:20.16337+00	
00000000-0000-0000-0000-000000000000	94bef1fd-0942-43b8-9279-9636853dee4c	{"action":"logout","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 13:47:02.879558+00	
00000000-0000-0000-0000-000000000000	d6d219fd-4e70-4478-a272-a599ec74b784	{"action":"user_recovery_requested","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 13:47:23.282225+00	
00000000-0000-0000-0000-000000000000	6a0b84d4-962a-44e4-937e-7638a8f92938	{"action":"login","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 13:47:36.619963+00	
00000000-0000-0000-0000-000000000000	86425536-3a79-43d5-89ac-e24ffe3bedb3	{"action":"user_updated_password","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 13:47:53.36236+00	
00000000-0000-0000-0000-000000000000	f4abaf5b-e96f-4fd2-98df-6c180bfa0f73	{"action":"user_modified","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 13:47:53.362985+00	
00000000-0000-0000-0000-000000000000	ad0c7cfa-2d08-4933-b15a-3eed5d4fecc0	{"action":"logout","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 13:47:58.546106+00	
00000000-0000-0000-0000-000000000000	2dada574-b5b2-405b-9007-ddd2a0c84d96	{"action":"login","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-06 13:48:07.643999+00	
00000000-0000-0000-0000-000000000000	3f47faf4-d72e-41fd-9ad0-40aa3fee762f	{"action":"user_recovery_requested","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 13:49:02.239636+00	
00000000-0000-0000-0000-000000000000	7dbd1002-ef07-4b87-a60c-b3a6c4c25089	{"action":"login","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 13:49:12.031957+00	
00000000-0000-0000-0000-000000000000	d038eda5-d3ec-4f25-86fc-9f07a94cafb7	{"action":"user_recovery_requested","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 13:50:46.128753+00	
00000000-0000-0000-0000-000000000000	0d8f37d7-12ad-4f2f-9119-7ca6de13a512	{"action":"login","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 13:50:54.082266+00	
00000000-0000-0000-0000-000000000000	c77e8d8c-e90d-4bef-ab9a-f7c1ae36d2e8	{"action":"user_recovery_requested","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 13:57:01.430991+00	
00000000-0000-0000-0000-000000000000	0620194b-0619-44c8-968e-b9661bad6dda	{"action":"login","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 13:57:10.606778+00	
00000000-0000-0000-0000-000000000000	9f0efbdd-8a07-4b6d-9fdd-4990e4aa9079	{"action":"user_recovery_requested","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 14:09:55.3828+00	
00000000-0000-0000-0000-000000000000	2d539c4e-ac40-48f7-ae71-1cdc6a7e42cd	{"action":"login","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 14:12:02.790308+00	
00000000-0000-0000-0000-000000000000	8d5373ff-0766-41ff-a238-3468344cda20	{"action":"user_updated_password","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 14:12:11.807854+00	
00000000-0000-0000-0000-000000000000	16f059b5-1d5e-41bd-af16-9f5278198e0a	{"action":"user_modified","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 14:12:11.808585+00	
00000000-0000-0000-0000-000000000000	c9f414c7-bebb-4ffe-9b5d-22ec6311428b	{"action":"logout","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 14:15:08.055077+00	
00000000-0000-0000-0000-000000000000	397ce792-77f2-474b-a9a2-037d20413018	{"action":"user_recovery_requested","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 14:15:14.590576+00	
00000000-0000-0000-0000-000000000000	488d22e7-c497-4446-bf3f-ec6e66080a84	{"action":"login","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 14:15:24.064608+00	
00000000-0000-0000-0000-000000000000	c55f8521-d13f-4b26-8087-8b96d17f686c	{"action":"user_recovery_requested","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 14:16:26.879427+00	
00000000-0000-0000-0000-000000000000	51103966-3185-444d-b239-9f77957eee9e	{"action":"login","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 14:16:35.217285+00	
00000000-0000-0000-0000-000000000000	457e4b1e-42f3-4d21-a5b7-354f57f0654f	{"action":"user_updated_password","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 14:16:55.744923+00	
00000000-0000-0000-0000-000000000000	86cc1d8e-2603-4272-933e-fed334ab6c30	{"action":"user_modified","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 14:16:55.745592+00	
00000000-0000-0000-0000-000000000000	153988d1-e0a1-4c75-9a96-d2765a9ade84	{"action":"logout","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 14:17:01.213488+00	
00000000-0000-0000-0000-000000000000	3e2cce5d-e716-4f6e-8a69-0d79695c2234	{"action":"user_repeated_signup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 14:17:13.286713+00	
00000000-0000-0000-0000-000000000000	580e2aa7-b734-4259-bc5c-6c84fe9525c7	{"action":"user_repeated_signup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 14:21:36.711397+00	
00000000-0000-0000-0000-000000000000	101574d3-8b86-4c37-bebb-200a96e46e34	{"action":"user_repeated_signup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 14:31:55.952599+00	
00000000-0000-0000-0000-000000000000	28f25e2d-49ee-4329-9473-d33ab44dbcc9	{"action":"user_repeated_signup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 14:33:26.870227+00	
00000000-0000-0000-0000-000000000000	df826703-a6ab-4b99-a633-a75ab43822fc	{"action":"user_repeated_signup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 14:33:37.196138+00	
00000000-0000-0000-0000-000000000000	e959af3a-92cd-46e9-b873-4a8054f00bb2	{"action":"user_repeated_signup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 14:34:06.443609+00	
00000000-0000-0000-0000-000000000000	349e1d86-e254-4678-9093-f4a95684957b	{"action":"user_repeated_signup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 15:02:24.088504+00	
00000000-0000-0000-0000-000000000000	f030eb8e-a920-497b-969d-c3cbda4f1033	{"action":"user_repeated_signup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 15:03:49.304898+00	
00000000-0000-0000-0000-000000000000	76bdbd16-505a-45a8-8d7c-2e10f90e6749	{"action":"user_repeated_signup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 15:04:22.883233+00	
00000000-0000-0000-0000-000000000000	cfa7eee4-ee05-4b41-acbc-2ca0fc743a20	{"action":"user_repeated_signup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 15:16:50.294123+00	
00000000-0000-0000-0000-000000000000	afa00f49-96d5-47a9-b41d-ccc15701f57d	{"action":"user_confirmation_requested","actor_id":"5177ff82-a9d6-4212-a064-90860c0817e7","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 15:17:07.912493+00	
00000000-0000-0000-0000-000000000000	92fa1b9c-e398-4c9b-8b55-41157613f800	{"action":"user_signedup","actor_id":"5177ff82-a9d6-4212-a064-90860c0817e7","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-06 15:17:59.547801+00	
00000000-0000-0000-0000-000000000000	289890ee-b55d-4407-b4a5-c7f3cfe4a4a7	{"action":"login","actor_id":"5177ff82-a9d6-4212-a064-90860c0817e7","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-06 15:23:27.765962+00	
00000000-0000-0000-0000-000000000000	30581e8a-9074-43f8-b776-98ab049596d8	{"action":"logout","actor_id":"5177ff82-a9d6-4212-a064-90860c0817e7","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 15:23:34.012402+00	
00000000-0000-0000-0000-000000000000	28a22cef-41cc-4518-9cf1-b2c628eafbe1	{"action":"login","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-06 15:26:22.607366+00	
00000000-0000-0000-0000-000000000000	9974cc16-dfef-4b86-b37c-173ac3d2f490	{"action":"logout","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 15:26:31.04367+00	
00000000-0000-0000-0000-000000000000	762cf23c-0422-4b6b-9393-5005006c38ac	{"action":"user_repeated_signup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 15:26:52.179992+00	
00000000-0000-0000-0000-000000000000	d47a005a-f4f1-4680-b133-970b7ae580d1	{"action":"user_repeated_signup","actor_id":"84d2f96b-aff1-496e-848b-0115747757ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 15:32:10.647919+00	
00000000-0000-0000-0000-000000000000	0fbe4a60-4cbe-4ebe-815d-9658ec8414cd	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"84d2f96b-aff1-496e-848b-0115747757ce","user_phone":""}}	2025-08-06 15:33:06.693831+00	
00000000-0000-0000-0000-000000000000	2830d844-eb0c-48ce-93a1-26ae8de65eaf	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justin.mcintyre@wwt.com","user_id":"5177ff82-a9d6-4212-a064-90860c0817e7","user_phone":""}}	2025-08-06 15:33:06.731042+00	
00000000-0000-0000-0000-000000000000	7fd0c68c-3be5-40b4-b6e0-4c4cfd154d17	{"action":"user_confirmation_requested","actor_id":"6d82ac9e-60f6-4d89-bd16-a0f8537168d6","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 15:33:18.344945+00	
00000000-0000-0000-0000-000000000000	94578c85-9daf-4e55-a674-50de4ba3fde1	{"action":"user_signedup","actor_id":"6d82ac9e-60f6-4d89-bd16-a0f8537168d6","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-06 15:33:35.08653+00	
00000000-0000-0000-0000-000000000000	ebdee51d-567a-46d6-8f8a-adaf27d81336	{"action":"logout","actor_id":"6d82ac9e-60f6-4d89-bd16-a0f8537168d6","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 15:33:42.540813+00	
00000000-0000-0000-0000-000000000000	eea7c12f-ab62-418c-a3ab-3b0885f88326	{"action":"user_repeated_signup","actor_id":"6d82ac9e-60f6-4d89-bd16-a0f8537168d6","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 15:36:42.768781+00	
00000000-0000-0000-0000-000000000000	2d6186a0-a727-4166-8c6e-d53f80e81e84	{"action":"user_repeated_signup","actor_id":"6d82ac9e-60f6-4d89-bd16-a0f8537168d6","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 15:39:58.240264+00	
00000000-0000-0000-0000-000000000000	9d0c65a4-58e4-40b2-8d6f-14c303c72a8c	{"action":"login","actor_id":"6d82ac9e-60f6-4d89-bd16-a0f8537168d6","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-06 15:40:05.340847+00	
00000000-0000-0000-0000-000000000000	f9f08a78-549e-4717-a90f-b8976cb543b1	{"action":"logout","actor_id":"6d82ac9e-60f6-4d89-bd16-a0f8537168d6","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 15:40:11.386954+00	
00000000-0000-0000-0000-000000000000	59318b9b-d8a7-474a-93f0-fc3c1745e5c9	{"action":"login","actor_id":"6d82ac9e-60f6-4d89-bd16-a0f8537168d6","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-06 16:19:38.347249+00	
00000000-0000-0000-0000-000000000000	d074ded3-1f22-4956-bfc1-b8316a2ada61	{"action":"logout","actor_id":"6d82ac9e-60f6-4d89-bd16-a0f8537168d6","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 16:19:51.826408+00	
00000000-0000-0000-0000-000000000000	39cd7fce-dd90-4e1f-868d-e3843f882a26	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"6d82ac9e-60f6-4d89-bd16-a0f8537168d6","user_phone":""}}	2025-08-06 16:23:19.244474+00	
00000000-0000-0000-0000-000000000000	5371b399-86a6-44bc-aff2-ba48e510d25a	{"action":"user_confirmation_requested","actor_id":"1f01e513-ffd3-4cf7-8d6b-6c318fb8cb69","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 16:24:13.600151+00	
00000000-0000-0000-0000-000000000000	9fd6eb84-d777-4940-8431-d430400af4a4	{"action":"user_signedup","actor_id":"1f01e513-ffd3-4cf7-8d6b-6c318fb8cb69","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-06 16:24:34.869524+00	
00000000-0000-0000-0000-000000000000	a45447f4-4892-4c68-98a8-0a1dcea7ff58	{"action":"user_confirmation_requested","actor_id":"ca44a568-6efd-4d9f-a685-b293c9294f80","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 16:25:08.548519+00	
00000000-0000-0000-0000-000000000000	9d986a8d-3adb-4eb6-bdde-36710f303ea8	{"action":"user_signedup","actor_id":"ca44a568-6efd-4d9f-a685-b293c9294f80","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-06 16:26:19.400091+00	
00000000-0000-0000-0000-000000000000	bb235cd1-795d-4b50-88a3-ddbcb4ad97a2	{"action":"logout","actor_id":"1f01e513-ffd3-4cf7-8d6b-6c318fb8cb69","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 16:26:28.30213+00	
00000000-0000-0000-0000-000000000000	42aa20f6-c3c7-4f17-9c43-139a3bc6ce6d	{"action":"user_recovery_requested","actor_id":"1f01e513-ffd3-4cf7-8d6b-6c318fb8cb69","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 16:26:40.569902+00	
00000000-0000-0000-0000-000000000000	acf391fb-5bb2-4e59-9375-c8c67fef685a	{"action":"login","actor_id":"1f01e513-ffd3-4cf7-8d6b-6c318fb8cb69","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 16:26:54.962568+00	
00000000-0000-0000-0000-000000000000	ec320c91-2dd3-4737-b598-dc3f466799e2	{"action":"user_updated_password","actor_id":"1f01e513-ffd3-4cf7-8d6b-6c318fb8cb69","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 16:27:28.505249+00	
00000000-0000-0000-0000-000000000000	cfbf00a5-9399-4c1c-b1c6-cc62c5b30740	{"action":"user_modified","actor_id":"1f01e513-ffd3-4cf7-8d6b-6c318fb8cb69","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 16:27:28.508152+00	
00000000-0000-0000-0000-000000000000	2fd631a1-92fb-45fa-9f5a-1d9608067dee	{"action":"login","actor_id":"ca44a568-6efd-4d9f-a685-b293c9294f80","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-06 16:30:18.698009+00	
00000000-0000-0000-0000-000000000000	d26376fa-d884-4d0a-9d95-9683c252fe0c	{"action":"logout","actor_id":"ca44a568-6efd-4d9f-a685-b293c9294f80","actor_username":"justin.mcintyre@wwt.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 16:30:31.441499+00	
00000000-0000-0000-0000-000000000000	cdd2fe22-7a45-40d8-9a45-076bbdaf41e3	{"action":"logout","actor_id":"1f01e513-ffd3-4cf7-8d6b-6c318fb8cb69","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 16:30:38.22958+00	
00000000-0000-0000-0000-000000000000	e53f175b-0a71-4cf7-9943-57da06e87df6	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justin.mcintyre@wwt.com","user_id":"ca44a568-6efd-4d9f-a685-b293c9294f80","user_phone":""}}	2025-08-06 16:30:43.279402+00	
00000000-0000-0000-0000-000000000000	6eac582c-2cd6-4dc5-8d42-07322226f0e4	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"1f01e513-ffd3-4cf7-8d6b-6c318fb8cb69","user_phone":""}}	2025-08-06 16:30:43.309065+00	
00000000-0000-0000-0000-000000000000	ffe059d3-86ed-4489-bf9b-693751bd1bea	{"action":"user_confirmation_requested","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 16:35:07.665854+00	
00000000-0000-0000-0000-000000000000	b153f7ca-7374-4c61-ab04-5fb9659b37b0	{"action":"user_signedup","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-06 16:35:18.715607+00	
00000000-0000-0000-0000-000000000000	29fa6740-2987-4acf-8b65-642dc685c76a	{"action":"logout","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 16:35:25.829385+00	
00000000-0000-0000-0000-000000000000	dd10c358-64f4-4c93-be9c-2e230f0eba34	{"action":"user_recovery_requested","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 16:35:29.377471+00	
00000000-0000-0000-0000-000000000000	508c3b6a-034a-4b3a-9740-b72fc08fa600	{"action":"login","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 16:35:36.421669+00	
00000000-0000-0000-0000-000000000000	d4727b97-64dd-48e8-85e9-459906bf9e99	{"action":"user_updated_password","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 16:35:47.469659+00	
00000000-0000-0000-0000-000000000000	f2c60eb3-fd70-4faa-841a-313e979da58d	{"action":"user_modified","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 16:35:47.470345+00	
00000000-0000-0000-0000-000000000000	d251cb47-5011-4474-ad3f-0a235e6a27ee	{"action":"logout","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 16:37:24.326226+00	
00000000-0000-0000-0000-000000000000	c3ad71cc-03cc-4044-887b-38eec235fdcc	{"action":"login","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-06 16:38:52.706379+00	
00000000-0000-0000-0000-000000000000	53afc0d9-6765-4bb7-95db-b0d4e3a50bfe	{"action":"logout","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 16:39:06.053771+00	
00000000-0000-0000-0000-000000000000	e9183f29-95bb-47c8-bb25-24de1b7147cf	{"action":"user_recovery_requested","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 16:39:22.087247+00	
00000000-0000-0000-0000-000000000000	edf0cbe8-2e20-42d0-ae66-cbd98fe74767	{"action":"login","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 16:39:35.721828+00	
00000000-0000-0000-0000-000000000000	7bfcc5b8-c69b-46f5-a91a-dcc67ddc8783	{"action":"user_updated_password","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 16:40:02.729963+00	
00000000-0000-0000-0000-000000000000	5a51df37-2f0f-4f62-9ff6-6142c7cd8f2b	{"action":"user_modified","actor_id":"b3458fba-c14e-41c9-83d4-da7af119a223","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 16:40:02.730635+00	
00000000-0000-0000-0000-000000000000	f0790888-0a15-406f-b6ae-136f4a929bac	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"b3458fba-c14e-41c9-83d4-da7af119a223","user_phone":""}}	2025-08-06 21:36:03.730875+00	
00000000-0000-0000-0000-000000000000	6c7a7048-f0f3-4f59-82e2-2e081783e5a9	{"action":"user_confirmation_requested","actor_id":"ff44bb45-90e0-480d-a492-b84400be95bb","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 21:36:29.813322+00	
00000000-0000-0000-0000-000000000000	72a1c6b2-4c5e-434d-b376-f3000331d832	{"action":"user_signedup","actor_id":"ff44bb45-90e0-480d-a492-b84400be95bb","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-06 21:36:45.778022+00	
00000000-0000-0000-0000-000000000000	0574f5bf-766e-409e-962e-98f8ce1b52cd	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"ff44bb45-90e0-480d-a492-b84400be95bb","user_phone":""}}	2025-08-06 21:39:06.041843+00	
00000000-0000-0000-0000-000000000000	9f0ff3bd-0c18-447d-9cae-9003f19e32b6	{"action":"user_confirmation_requested","actor_id":"f40c4c1c-e031-468e-978b-47231a93497b","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 21:39:28.485633+00	
00000000-0000-0000-0000-000000000000	f7d52d44-7f3f-4c36-8fd2-844d68a8a199	{"action":"user_signedup","actor_id":"f40c4c1c-e031-468e-978b-47231a93497b","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-06 21:39:35.342938+00	
00000000-0000-0000-0000-000000000000	67be9bdd-133c-4017-8e2e-9525e932d3c4	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"f40c4c1c-e031-468e-978b-47231a93497b","user_phone":""}}	2025-08-06 21:48:03.838222+00	
00000000-0000-0000-0000-000000000000	9269e630-0394-4f4a-a9c5-86cff7c9f8a0	{"action":"user_confirmation_requested","actor_id":"1b5bafc8-f8d8-48fc-a096-92ecf67051c0","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 21:50:59.82431+00	
00000000-0000-0000-0000-000000000000	e08f4d86-1b60-443e-ac5e-e73673d6a60c	{"action":"user_signedup","actor_id":"1b5bafc8-f8d8-48fc-a096-92ecf67051c0","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-06 21:51:13.729259+00	
00000000-0000-0000-0000-000000000000	ca660b69-3ba9-49ab-8e1e-6b1e029b2fb0	{"action":"logout","actor_id":"1b5bafc8-f8d8-48fc-a096-92ecf67051c0","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 21:51:50.67483+00	
00000000-0000-0000-0000-000000000000	2d95cb45-f02e-4030-a694-8caed7d7aa4c	{"action":"user_repeated_signup","actor_id":"1b5bafc8-f8d8-48fc-a096-92ecf67051c0","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 21:52:00.857804+00	
00000000-0000-0000-0000-000000000000	c890ceef-1ebb-4519-8281-ba1be0e6ef54	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"1b5bafc8-f8d8-48fc-a096-92ecf67051c0","user_phone":""}}	2025-08-06 22:11:57.288231+00	
00000000-0000-0000-0000-000000000000	e5cac34a-5fab-48e9-b9e6-93380472aa78	{"action":"user_confirmation_requested","actor_id":"eb9e204e-1861-41c5-84c2-3663ad6a32ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 22:13:04.114944+00	
00000000-0000-0000-0000-000000000000	5be2b5b1-58be-4606-b884-133c40849b3b	{"action":"user_signedup","actor_id":"eb9e204e-1861-41c5-84c2-3663ad6a32ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-06 22:13:16.621205+00	
00000000-0000-0000-0000-000000000000	48f75799-8a85-4a0c-96a2-336ab6f66aa5	{"action":"logout","actor_id":"eb9e204e-1861-41c5-84c2-3663ad6a32ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 22:13:24.652702+00	
00000000-0000-0000-0000-000000000000	44d91571-c256-469c-89f1-70ea5f6ff1ef	{"action":"user_repeated_signup","actor_id":"eb9e204e-1861-41c5-84c2-3663ad6a32ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 22:13:36.523525+00	
00000000-0000-0000-0000-000000000000	7b0972a4-6d54-4002-8a17-4a37e403408a	{"action":"login","actor_id":"eb9e204e-1861-41c5-84c2-3663ad6a32ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-06 22:23:08.235327+00	
00000000-0000-0000-0000-000000000000	716a4338-1d16-4cdb-9c92-eb9cc3168b0b	{"action":"logout","actor_id":"eb9e204e-1861-41c5-84c2-3663ad6a32ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 22:23:09.546251+00	
00000000-0000-0000-0000-000000000000	d30a7c5f-4458-4cdb-a613-bd312e5ee700	{"action":"user_repeated_signup","actor_id":"eb9e204e-1861-41c5-84c2-3663ad6a32ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 22:23:18.314388+00	
00000000-0000-0000-0000-000000000000	c852d368-f079-49ab-896d-df47c4c94de3	{"action":"login","actor_id":"eb9e204e-1861-41c5-84c2-3663ad6a32ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-06 22:23:27.021628+00	
00000000-0000-0000-0000-000000000000	636f161d-1858-4d61-8a2e-b2c4659ef2fa	{"action":"logout","actor_id":"eb9e204e-1861-41c5-84c2-3663ad6a32ce","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 22:23:31.578608+00	
00000000-0000-0000-0000-000000000000	0c1182e5-9350-4c67-bf6a-7a5aafede0a9	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"eb9e204e-1861-41c5-84c2-3663ad6a32ce","user_phone":""}}	2025-08-06 22:24:03.89025+00	
00000000-0000-0000-0000-000000000000	bea42b59-447b-4dba-92aa-4a683ba6a373	{"action":"user_confirmation_requested","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 22:24:17.727995+00	
00000000-0000-0000-0000-000000000000	097ce38b-7b62-4736-9dcb-96ba3af27952	{"action":"user_signedup","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-06 22:28:34.125115+00	
00000000-0000-0000-0000-000000000000	331de42d-bac5-4c83-87a8-c19548a10c87	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 22:35:19.442627+00	
00000000-0000-0000-0000-000000000000	50425cf5-b1ee-4713-b387-e9aecbdc2cc6	{"action":"user_repeated_signup","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-06 22:35:42.247438+00	
00000000-0000-0000-0000-000000000000	9ba9bf04-6975-40c3-b1c9-78142994e29f	{"action":"user_recovery_requested","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-06 22:35:49.925489+00	
00000000-0000-0000-0000-000000000000	74678de9-2333-454b-9196-8f402959f66c	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 22:35:57.039121+00	
00000000-0000-0000-0000-000000000000	d29dd26c-3900-4c28-aa21-c0391d007008	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-06 22:36:10.548923+00	
00000000-0000-0000-0000-000000000000	eb919ccb-a487-4d1e-a043-9f868b579ac5	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-06 22:37:00.920088+00	
00000000-0000-0000-0000-000000000000	5b3405ae-c04b-4cd9-b7f0-9dc85cc227db	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-06 22:37:07.140599+00	
00000000-0000-0000-0000-000000000000	38facba4-f4db-4fce-9346-98bdd23275b3	{"action":"token_refreshed","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-07 13:55:06.872628+00	
00000000-0000-0000-0000-000000000000	413b9cbb-b602-436f-9abd-cb42bcba725d	{"action":"token_revoked","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-07 13:55:06.886216+00	
00000000-0000-0000-0000-000000000000	5482997f-5498-47c3-9488-90365ff0131f	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-07 13:55:13.576297+00	
00000000-0000-0000-0000-000000000000	1e80b975-8b0c-4dca-bdf3-e4ade6e86eed	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-07 13:55:18.904072+00	
00000000-0000-0000-0000-000000000000	a4fccf9a-08d2-4048-b1ff-4d6cbf6e8e28	{"action":"token_refreshed","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-07 16:02:15.731016+00	
00000000-0000-0000-0000-000000000000	c4e5e6f2-0703-46d1-b9da-1f333f9949ec	{"action":"token_revoked","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-07 16:02:15.745753+00	
00000000-0000-0000-0000-000000000000	274421ae-eab8-49fb-9629-7bb63cf81a71	{"action":"token_refreshed","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-07 17:17:13.975772+00	
00000000-0000-0000-0000-000000000000	9bf80b83-d6f4-4fd6-a1ed-9ee808def289	{"action":"token_revoked","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-07 17:17:14.000222+00	
00000000-0000-0000-0000-000000000000	8ef609b2-d0fd-48c3-82dc-8507c1a201fa	{"action":"token_refreshed","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-07 19:32:38.946698+00	
00000000-0000-0000-0000-000000000000	1caabe3b-7e16-4890-9251-0ba86a9056eb	{"action":"token_revoked","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-07 19:32:38.963402+00	
00000000-0000-0000-0000-000000000000	d53d14a4-0f76-4a0b-afda-209420c9e73c	{"action":"token_refreshed","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-08 12:28:11.70589+00	
00000000-0000-0000-0000-000000000000	f1e15380-3679-4255-ad80-a0b80b9cc2df	{"action":"token_revoked","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-08 12:28:11.734128+00	
00000000-0000-0000-0000-000000000000	079755e9-0192-4bbb-b4e5-7a848d12c9b3	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-08 18:19:39.606155+00	
00000000-0000-0000-0000-000000000000	25b4d425-3525-47a3-843d-65f09ed7f61b	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-08 18:22:50.582406+00	
00000000-0000-0000-0000-000000000000	58457026-5516-4bf5-a09a-b7a32781c348	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-08 18:23:27.211117+00	
00000000-0000-0000-0000-000000000000	54737936-de28-4d1b-9e10-11329ee4d446	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-08 18:23:56.261339+00	
00000000-0000-0000-0000-000000000000	552e8a6c-29c6-4ed1-9f87-9d05b5e91117	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-08 18:25:19.956974+00	
00000000-0000-0000-0000-000000000000	9c6f53d0-3a7b-4660-9065-9b6e1649801d	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-08 18:25:26.873378+00	
00000000-0000-0000-0000-000000000000	3e40dc10-89f0-477c-bf19-8724ca0d5850	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-08 18:28:38.107179+00	
00000000-0000-0000-0000-000000000000	bd751b0b-2e13-4f7d-a54e-b0b59c3445cb	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-08 18:28:46.023874+00	
00000000-0000-0000-0000-000000000000	bba3421d-9f61-49b2-a838-c46e0276711d	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-08 18:31:32.66246+00	
00000000-0000-0000-0000-000000000000	402291cf-1f28-4f57-9828-60b0767255de	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-08 18:33:42.936138+00	
00000000-0000-0000-0000-000000000000	97c20857-10a2-4a18-b296-f80b1b647993	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-08 18:34:19.426201+00	
00000000-0000-0000-0000-000000000000	9211e3da-0aed-4d1f-a86d-4237cba120ca	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-08 18:35:59.987679+00	
00000000-0000-0000-0000-000000000000	0a6fe5d9-4901-459d-a52f-4162ab424229	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-08 18:39:50.280848+00	
00000000-0000-0000-0000-000000000000	45fb02d5-b761-4db9-8f4c-b13a0f54213b	{"action":"token_refreshed","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-08 19:56:23.059142+00	
00000000-0000-0000-0000-000000000000	46d5fb1b-2620-4242-8d9e-ecddc79ca3a6	{"action":"token_revoked","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-08 19:56:23.084293+00	
00000000-0000-0000-0000-000000000000	9f2b6e38-1627-4fa3-ad49-8a78dd14708c	{"action":"token_refreshed","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-08 19:56:32.925965+00	
00000000-0000-0000-0000-000000000000	0eecea07-02d5-4ac6-9f39-b1fd0200687c	{"action":"token_revoked","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-08 19:56:32.928061+00	
00000000-0000-0000-0000-000000000000	112143bd-5496-4121-9477-b0f4d297beea	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-09 00:34:54.191065+00	
00000000-0000-0000-0000-000000000000	6a545406-1e3f-4030-b8de-71950d5eb97b	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-09 00:35:35.604438+00	
00000000-0000-0000-0000-000000000000	47704c0e-fda0-4a85-bd68-dc9eb05b8a67	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-09 00:36:16.89407+00	
00000000-0000-0000-0000-000000000000	32e30431-0462-4800-a3ae-b512a575a738	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-09 00:36:29.868951+00	
00000000-0000-0000-0000-000000000000	e20783f5-ff52-4830-8e22-789e847acea7	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-09 01:30:33.150683+00	
00000000-0000-0000-0000-000000000000	cc1f0e39-6ec8-4df6-bd3e-e88d57000213	{"action":"user_repeated_signup","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-09 11:56:34.710755+00	
00000000-0000-0000-0000-000000000000	aac0c46f-73de-4e21-bda9-842abd9c8199	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-09 11:56:41.320649+00	
00000000-0000-0000-0000-000000000000	0378abc0-5a13-4d9b-9fd0-3f4b5b8979b8	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-09 11:56:50.938827+00	
00000000-0000-0000-0000-000000000000	4eada6ae-eab6-4039-bdc1-ecc50f07f01d	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-09 11:57:50.258393+00	
00000000-0000-0000-0000-000000000000	b8b0bdf5-703a-46e5-b06d-f468e997c39a	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-09 11:57:55.139938+00	
00000000-0000-0000-0000-000000000000	c91b5df5-7141-40c2-92c8-c24e92d61c25	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-10 12:08:34.601959+00	
00000000-0000-0000-0000-000000000000	68d10f37-d3be-4911-8a61-a2478edb3024	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-10 12:14:20.307077+00	
00000000-0000-0000-0000-000000000000	f6cc930c-a3f5-423a-abd3-a8be7b6c25e4	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-10 12:15:11.84331+00	
00000000-0000-0000-0000-000000000000	d692e8d1-a7a0-43cb-af37-ce3bed4d98d0	{"action":"user_signedup","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-08-10 12:15:20.0307+00	
00000000-0000-0000-0000-000000000000	4b0f9b56-6474-4725-a2ea-cda7ed417087	{"action":"logout","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-10 12:15:45.388695+00	
00000000-0000-0000-0000-000000000000	f35a1667-2af1-4aa3-8f31-c215c5330f67	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-10 12:15:57.858114+00	
00000000-0000-0000-0000-000000000000	20a49131-8bc2-448a-8136-ec618ac8ea44	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-10 12:16:02.890986+00	
00000000-0000-0000-0000-000000000000	a07aa6b7-4bb9-4707-a3ac-74521140da37	{"action":"user_repeated_signup","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-10 12:16:38.223052+00	
00000000-0000-0000-0000-000000000000	0a6b44aa-f297-48b6-8475-dcfef8967a8a	{"action":"login","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-10 12:17:00.535965+00	
00000000-0000-0000-0000-000000000000	66631d1b-8877-4a69-b1fb-01155ec7851c	{"action":"logout","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-10 12:18:37.090608+00	
00000000-0000-0000-0000-000000000000	78514aff-f4db-4069-8fa8-fc427bf87fe4	{"action":"user_recovery_requested","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-10 12:21:47.176009+00	
00000000-0000-0000-0000-000000000000	f207e840-c642-438d-9c04-8dc8b876ee23	{"action":"login","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-10 12:22:01.479353+00	
00000000-0000-0000-0000-000000000000	4816b7ed-83c6-4f87-a3e6-1cb2b20d3ba5	{"action":"user_recovery_requested","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-10 12:23:09.994594+00	
00000000-0000-0000-0000-000000000000	ed10c685-0089-478f-9d30-5fa5116aacb9	{"action":"login","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-10 12:23:26.16466+00	
00000000-0000-0000-0000-000000000000	e20a4434-48f0-4ec9-9dc4-269063170956	{"action":"user_updated_password","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-10 12:23:34.449778+00	
00000000-0000-0000-0000-000000000000	83b5f2cb-1950-4ff0-8457-d6479fc5f6f7	{"action":"user_modified","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-10 12:23:34.450488+00	
00000000-0000-0000-0000-000000000000	3d87c798-73bc-4c3a-83f1-e855ba483c22	{"action":"logout","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-10 12:23:59.137174+00	
00000000-0000-0000-0000-000000000000	043c3aad-b0ef-46ed-b6a2-1d5147a0e5fd	{"action":"login","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-10 12:24:08.287011+00	
00000000-0000-0000-0000-000000000000	6b38e483-246c-46ee-9535-46dc7943d3ea	{"action":"user_recovery_requested","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-10 12:24:30.970128+00	
00000000-0000-0000-0000-000000000000	924c60dd-610a-4795-be6f-4fe908fe2c4b	{"action":"login","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-10 12:28:43.029323+00	
00000000-0000-0000-0000-000000000000	25df6b16-cede-4b3c-a1a4-4e05cab4224c	{"action":"logout","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-10 12:28:50.467796+00	
00000000-0000-0000-0000-000000000000	159d6252-4922-4bcc-95bc-7f8e086ffeea	{"action":"user_recovery_requested","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-11 11:15:51.96264+00	
00000000-0000-0000-0000-000000000000	3d3ac1db-6c1e-4ec5-9284-89825beb640b	{"action":"user_recovery_requested","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-11 11:22:40.024388+00	
00000000-0000-0000-0000-000000000000	22f00ebb-beee-4f01-aaa2-611b03fd1c7e	{"action":"user_recovery_requested","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-08-11 11:38:46.590574+00	
00000000-0000-0000-0000-000000000000	2f0fb899-7ec6-419e-9cd2-29c3897a0d5c	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-11 11:43:20.406601+00	
00000000-0000-0000-0000-000000000000	489e5c87-d591-4b38-bb6d-92339213f3de	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-11 12:20:14.898499+00	
00000000-0000-0000-0000-000000000000	5724c6f2-a4b6-4f66-94b5-e4a373272957	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-11 12:33:14.131145+00	
00000000-0000-0000-0000-000000000000	badb9e99-1b38-4796-be94-54fe87ef7bf4	{"action":"login","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-11 12:33:21.439169+00	
00000000-0000-0000-0000-000000000000	3b632dfb-ae89-4ce8-94a9-742ddee36268	{"action":"logout","actor_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-11 12:33:26.719597+00	
00000000-0000-0000-0000-000000000000	f4bc5776-3002-4a14-af91-92c139682640	{"action":"login","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-11 12:33:33.060662+00	
00000000-0000-0000-0000-000000000000	77e0b3fe-d11d-429e-9887-43538a1e3cf3	{"action":"logout","actor_id":"68b77d70-383d-449b-894c-be2bd91d64c5","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-11 12:33:39.975639+00	
00000000-0000-0000-0000-000000000000	c0e84107-0542-4806-904c-e577db354c8f	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"50fd2651-dfbc-4e6d-b0e3-8b6b4c893c57","user_phone":""}}	2025-08-11 13:13:58.093226+00	
00000000-0000-0000-0000-000000000000	e0c4e0eb-72d7-44b9-b64e-9903df97a2fa	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"roamingbearhoneyco@gmail.com","user_id":"68b77d70-383d-449b-894c-be2bd91d64c5","user_phone":""}}	2025-08-11 13:13:58.11292+00	
00000000-0000-0000-0000-000000000000	1e123158-3712-44ea-a036-0f1b2c18bd7a	{"action":"user_confirmation_requested","actor_id":"c7f1505e-c323-4496-911a-9534620dc33a","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-11 13:54:31.363953+00	
00000000-0000-0000-0000-000000000000	690d889b-1c26-47a1-9587-9775ce77376a	{"action":"user_signedup","actor_id":"c7f1505e-c323-4496-911a-9534620dc33a","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-11 13:55:09.005781+00	
00000000-0000-0000-0000-000000000000	21472972-2dde-4d45-8375-8851f2613069	{"action":"logout","actor_id":"c7f1505e-c323-4496-911a-9534620dc33a","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-11 13:56:38.789226+00	
00000000-0000-0000-0000-000000000000	5485549f-a58f-49b4-81f3-f89ad8ca651c	{"action":"login","actor_id":"c7f1505e-c323-4496-911a-9534620dc33a","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-11 13:56:48.633195+00	
00000000-0000-0000-0000-000000000000	8d75d8ee-2991-43fe-853f-07920b75f118	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"c7f1505e-c323-4496-911a-9534620dc33a","user_phone":""}}	2025-08-11 13:59:12.045783+00	
00000000-0000-0000-0000-000000000000	172ac9ae-1c54-41b0-8615-b3ea48654c44	{"action":"user_confirmation_requested","actor_id":"61a114f0-5100-419e-8ad6-54080dcc6630","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-11 14:00:16.037004+00	
00000000-0000-0000-0000-000000000000	00f1f6ad-118e-4566-b582-c00897e885c8	{"action":"user_signedup","actor_id":"61a114f0-5100-419e-8ad6-54080dcc6630","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-11 14:00:40.624135+00	
00000000-0000-0000-0000-000000000000	d9d229e3-fd8f-4b4b-9ab4-fba99c10025a	{"action":"logout","actor_id":"61a114f0-5100-419e-8ad6-54080dcc6630","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-11 14:01:56.377224+00	
00000000-0000-0000-0000-000000000000	cf86518f-d2f7-434a-b5a5-bda54c004122	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"61a114f0-5100-419e-8ad6-54080dcc6630","user_phone":""}}	2025-08-11 14:02:11.1101+00	
00000000-0000-0000-0000-000000000000	d839c5a2-507e-429f-8990-68e2d402cb9d	{"action":"user_confirmation_requested","actor_id":"5cedff21-8f88-4e63-bf47-72c34fa7857b","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-11 14:03:57.051597+00	
00000000-0000-0000-0000-000000000000	6df99040-613a-4a38-afba-972911d46e9c	{"action":"user_signedup","actor_id":"5cedff21-8f88-4e63-bf47-72c34fa7857b","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-11 14:04:22.681452+00	
00000000-0000-0000-0000-000000000000	94800f32-b68c-49a6-9417-3cf06234224d	{"action":"logout","actor_id":"5cedff21-8f88-4e63-bf47-72c34fa7857b","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-11 14:04:47.111602+00	
00000000-0000-0000-0000-000000000000	78dabb07-de28-4e9f-8a74-6dd52834bfef	{"action":"user_signedup","actor_id":"2ae7cd55-7374-472f-941c-eff8f1cbac15","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-08-11 14:05:00.888985+00	
00000000-0000-0000-0000-000000000000	794a3d95-8b46-43e4-8e5d-b9b6d696837e	{"action":"login","actor_id":"2ae7cd55-7374-472f-941c-eff8f1cbac15","actor_name":"Justin","actor_username":"roamingbearhoneyco@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-11 14:05:11.667545+00	
00000000-0000-0000-0000-000000000000	60236dc0-1984-4280-9b85-457a4c043fe9	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"5cedff21-8f88-4e63-bf47-72c34fa7857b","user_phone":""}}	2025-08-11 14:06:26.516085+00	
00000000-0000-0000-0000-000000000000	68e48bb7-4ad5-4744-b663-3ed5c8b58add	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"roamingbearhoneyco@gmail.com","user_id":"2ae7cd55-7374-472f-941c-eff8f1cbac15","user_phone":""}}	2025-08-11 14:06:26.549506+00	
00000000-0000-0000-0000-000000000000	ab1ee6e2-9b1a-45c4-986c-cafb42473d29	{"action":"user_signedup","actor_id":"56a65ce8-2c00-4f9b-ac0d-dc079a7f38ff","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-08-11 17:13:09.874292+00	
00000000-0000-0000-0000-000000000000	a7cd99df-1225-4a40-b79d-84c2e9feb9b6	{"action":"logout","actor_id":"56a65ce8-2c00-4f9b-ac0d-dc079a7f38ff","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-11 17:32:22.811382+00	
00000000-0000-0000-0000-000000000000	5ab2b46b-bb6e-4bad-9fed-de70430d94d4	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"56a65ce8-2c00-4f9b-ac0d-dc079a7f38ff","user_phone":""}}	2025-08-11 20:09:11.936489+00	
00000000-0000-0000-0000-000000000000	2622fdfa-c649-459d-89bc-8de772e3ba43	{"action":"user_confirmation_requested","actor_id":"73b38887-62c5-4c30-b66c-aa154c378766","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-11 21:43:03.069595+00	
00000000-0000-0000-0000-000000000000	5c550a42-7dff-4a4a-9958-965a069301ea	{"action":"user_signedup","actor_id":"73b38887-62c5-4c30-b66c-aa154c378766","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-11 21:43:13.680527+00	
00000000-0000-0000-0000-000000000000	65b12e6f-7fea-48c0-8725-20801440cd48	{"action":"logout","actor_id":"73b38887-62c5-4c30-b66c-aa154c378766","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-11 21:43:48.171638+00	
00000000-0000-0000-0000-000000000000	66c805fd-e9d3-455d-9e01-3749ffe97868	{"action":"login","actor_id":"73b38887-62c5-4c30-b66c-aa154c378766","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-11 21:43:55.886579+00	
00000000-0000-0000-0000-000000000000	7db67676-5c97-4925-96d3-bd4c93076599	{"action":"logout","actor_id":"73b38887-62c5-4c30-b66c-aa154c378766","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-11 22:01:20.381907+00	
00000000-0000-0000-0000-000000000000	75670774-cbac-43f6-a512-9cca83e2d1ea	{"action":"login","actor_id":"73b38887-62c5-4c30-b66c-aa154c378766","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-11 22:02:53.298683+00	
00000000-0000-0000-0000-000000000000	07b08036-6d0d-4a6f-ac2d-43bceb3d42c9	{"action":"logout","actor_id":"73b38887-62c5-4c30-b66c-aa154c378766","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-11 22:04:06.835406+00	
00000000-0000-0000-0000-000000000000	f3619a1b-689c-4297-9a02-e0d804ff8146	{"action":"user_signedup","actor_id":"3a14f027-09d8-4cf5-a383-18075d4d1b89","actor_name":"Sommer McIntyre","actor_username":"sommermac1@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-08-11 23:10:22.867495+00	
00000000-0000-0000-0000-000000000000	777d1bd7-e664-4b77-b6af-6b4f68cbc283	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"sommermac1@gmail.com","user_id":"3a14f027-09d8-4cf5-a383-18075d4d1b89","user_phone":""}}	2025-08-12 11:35:28.202466+00	
00000000-0000-0000-0000-000000000000	fa380318-f966-45b8-8117-3d90db57dd46	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"justinmcintyre3@gmail.com","user_id":"73b38887-62c5-4c30-b66c-aa154c378766","user_phone":""}}	2025-08-12 11:35:28.200744+00	
00000000-0000-0000-0000-000000000000	4bd59602-3060-4a5d-b843-36d9f91b4da0	{"action":"user_confirmation_requested","actor_id":"adaeb04f-180c-4e3f-88e5-bdb886899158","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-12 12:59:28.561709+00	
00000000-0000-0000-0000-000000000000	2e1955eb-7afd-41e4-8926-86ad7fb1be8a	{"action":"user_signedup","actor_id":"adaeb04f-180c-4e3f-88e5-bdb886899158","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-12 12:59:45.217952+00	
00000000-0000-0000-0000-000000000000	8a9587db-7eaa-40de-a986-81c4e1d68e64	{"action":"logout","actor_id":"adaeb04f-180c-4e3f-88e5-bdb886899158","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-12 13:00:21.370943+00	
00000000-0000-0000-0000-000000000000	f08e0d69-68e9-499a-a5fc-2528b19f723a	{"action":"login","actor_id":"adaeb04f-180c-4e3f-88e5-bdb886899158","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-12 13:00:36.12535+00	
00000000-0000-0000-0000-000000000000	1054facf-4649-4121-a404-b4bdabc2f13e	{"action":"login","actor_id":"adaeb04f-180c-4e3f-88e5-bdb886899158","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-12 13:02:57.857978+00	
00000000-0000-0000-0000-000000000000	2b1ab5aa-9cb7-42d2-93da-97ef725ebbad	{"action":"login","actor_id":"adaeb04f-180c-4e3f-88e5-bdb886899158","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-12 13:03:25.867055+00	
00000000-0000-0000-0000-000000000000	cc0b65fa-7deb-4a2e-ae4d-8942d6c8d69a	{"action":"logout","actor_id":"adaeb04f-180c-4e3f-88e5-bdb886899158","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-12 13:22:01.826937+00	
00000000-0000-0000-0000-000000000000	574f2562-8709-444a-acce-75aadf74713e	{"action":"login","actor_id":"adaeb04f-180c-4e3f-88e5-bdb886899158","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-08-12 13:22:11.016021+00	
00000000-0000-0000-0000-000000000000	abf51759-d211-4a92-a98b-ec272b4fc680	{"action":"logout","actor_id":"adaeb04f-180c-4e3f-88e5-bdb886899158","actor_name":"justin mcintyre","actor_username":"justinmcintyre3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-12 14:03:08.680476+00	
00000000-0000-0000-0000-000000000000	8db53423-7ba5-4cc1-89f6-493e16fd65a5	{"action":"user_confirmation_requested","actor_id":"320eb545-a079-43cb-ba2a-656229326de2","actor_username":"sommermac1@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-12 17:46:04.208203+00	
00000000-0000-0000-0000-000000000000	1e207b1f-a1d9-44c5-a49a-cc8270fe2983	{"action":"user_signedup","actor_id":"320eb545-a079-43cb-ba2a-656229326de2","actor_username":"sommermac1@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-12 17:46:28.135279+00	
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
1cdd9385-ceaf-4d98-8f86-f7509e365bf1	\N	\N	\N	\N	google			2026-02-25 11:47:11.830006+00	2026-02-25 11:47:11.830006+00	oauth	\N	\N	http://localhost:4321/portal	\N	\N	f
967d672f-2171-4456-9d39-0bce02b339c8	\N	\N	\N	\N	google			2026-02-25 14:01:04.265492+00	2026-02-25 14:01:04.265492+00	oauth	\N	\N	http://localhost:4321/portal	\N	\N	f
77c84f4c-3e71-4212-b2b5-251789c146ec	\N	\N	\N	\N	google			2026-02-07 00:02:30.561239+00	2026-02-07 00:02:30.561239+00	oauth	\N	\N	https://testsite.roamingbearhoneyco.com/portal	\N	\N	f
5f9ad94d-299c-4af4-8af9-67e22bd79c7d	\N	\N	\N	\N	google			2026-02-07 18:58:32.965786+00	2026-02-07 18:58:32.965786+00	oauth	\N	\N	http://localhost:4321/portal	\N	\N	f
b8754aba-93a9-48b8-bfc5-b2754c4bc590	\N	\N	\N	\N	google			2026-02-09 22:25:27.878529+00	2026-02-09 22:25:27.878529+00	oauth	\N	\N	https://testsite.roamingbearhoneyco.com/portal	\N	\N	f
18421768-23d7-471b-888a-d20e7e5187a4	\N	\N	\N	\N	google			2026-02-16 14:03:56.01366+00	2026-02-16 14:03:56.01366+00	oauth	\N	\N	https://testsite.roamingbearhoneyco.com/portal	\N	\N	f
c30ca428-6d61-41dc-840f-3c04dab6766d	\N	\N	\N	\N	google			2026-02-16 14:17:42.87053+00	2026-02-16 14:17:42.87053+00	oauth	\N	\N	https://testsite.roamingbearhoneyco.com/portal	\N	\N	f
4938ef30-ef59-407b-bc93-8a0eee35571b	\N	\N	\N	\N	google			2026-02-16 14:20:21.989448+00	2026-02-16 14:20:21.989448+00	oauth	\N	\N	https://testsite.roamingbearhoneyco.com/portal	\N	\N	f
8fd3479f-6562-4762-9b46-31717536e592	\N	\N	\N	\N	google			2026-02-16 15:26:50.582926+00	2026-02-16 15:26:50.582926+00	oauth	\N	\N	http://localhost:4321/portal	\N	\N	f
71fcb9c5-0536-4e26-8d95-2124a1da0668	\N	\N	\N	\N	google			2026-02-16 15:29:04.071268+00	2026-02-16 15:29:04.071268+00	oauth	\N	\N	http://localhost:4321/portal	\N	\N	f
942aa789-0bd9-49e2-838e-dc557746c1ab	\N	\N	\N	\N	google			2026-02-16 15:30:57.902208+00	2026-02-16 15:30:57.902208+00	oauth	\N	\N	http://localhost:4321/portal	\N	\N	f
5da259ef-d1db-4f6e-9507-a3407f94598a	\N	\N	\N	\N	google			2026-02-16 16:25:41.397747+00	2026-02-16 16:25:41.397747+00	oauth	\N	\N	https://testsite.roamingbearhoneyco.com/portal	\N	\N	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	b1e57433-e952-4f52-9fec-0f5cb8a6d7c1	authenticated	authenticated	bricewhitley@gmail.com	$2a$10$3owHZngfhTcBsP.dFzLLfucpZHTyVDyzA7uBhn8oZGodQfcAKynJi	2026-02-10 01:37:24.256882+00	\N		2026-02-10 01:36:20.940805+00		\N			\N	2026-02-10 01:37:24.265985+00	{"provider": "email", "providers": ["email"]}	{"sub": "b1e57433-e952-4f52-9fec-0f5cb8a6d7c1", "email": "bricewhitley@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-10 01:36:19.834105+00	2026-02-15 00:42:45.009755+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	90b30f7b-08b8-4e7b-990e-44389c4049b2	authenticated	authenticated	justinmcintyre3@gmail.com	\N	2026-02-16 19:01:51.247911+00	\N		\N		\N			\N	2026-02-25 14:27:42.879122+00	{"provider": "google", "providers": ["google"]}	{"iss": "https://accounts.google.com", "sub": "102089393456770420162", "name": "justin mcintyre", "email": "justinmcintyre3@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocJ-EKoz21cuFrMrhnIP6tvuYPlrJMrmR_oeeFrZykrJWs9XLA=s96-c", "full_name": "justin mcintyre", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocJ-EKoz21cuFrMrhnIP6tvuYPlrJMrmR_oeeFrZykrJWs9XLA=s96-c", "provider_id": "102089393456770420162", "email_verified": true, "phone_verified": false}	\N	2026-02-16 19:01:50.295136+00	2026-02-25 15:46:12.058607+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e9745b7b-8e14-4c45-b678-56d6ca26f567	authenticated	authenticated	stefanross@gvtc.com	$2a$10$9NkBsrN.fHkhOKwxvRdiTub4DUapryngHaDfl9/DPQm7kRTOeL.kG	2026-02-16 17:54:20.174576+00	\N		2026-02-16 17:53:14.246831+00		\N			\N	2026-02-16 17:54:20.184255+00	{"provider": "email", "providers": ["email"]}	{"sub": "e9745b7b-8e14-4c45-b678-56d6ca26f567", "email": "stefanross@gvtc.com", "email_verified": true, "phone_verified": false}	\N	2026-02-16 17:53:13.09224+00	2026-02-16 17:54:20.217624+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
102089393456770420162	90b30f7b-08b8-4e7b-990e-44389c4049b2	{"iss": "https://accounts.google.com", "sub": "102089393456770420162", "name": "justin mcintyre", "email": "justinmcintyre3@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocJ-EKoz21cuFrMrhnIP6tvuYPlrJMrmR_oeeFrZykrJWs9XLA=s96-c", "full_name": "justin mcintyre", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocJ-EKoz21cuFrMrhnIP6tvuYPlrJMrmR_oeeFrZykrJWs9XLA=s96-c", "provider_id": "102089393456770420162", "email_verified": true, "phone_verified": false}	google	2026-02-16 19:01:51.236272+00	2026-02-16 19:01:51.236348+00	2026-02-25 14:27:42.873356+00	acafcc19-b221-45d9-95b7-012434b047fb
b1e57433-e952-4f52-9fec-0f5cb8a6d7c1	b1e57433-e952-4f52-9fec-0f5cb8a6d7c1	{"sub": "b1e57433-e952-4f52-9fec-0f5cb8a6d7c1", "email": "bricewhitley@gmail.com", "email_verified": true, "phone_verified": false}	email	2026-02-10 01:36:20.917979+00	2026-02-10 01:36:20.918033+00	2026-02-10 01:36:20.918033+00	54566b46-8615-4943-ab08-99482f4762cd
e9745b7b-8e14-4c45-b678-56d6ca26f567	e9745b7b-8e14-4c45-b678-56d6ca26f567	{"sub": "e9745b7b-8e14-4c45-b678-56d6ca26f567", "email": "stefanross@gvtc.com", "email_verified": true, "phone_verified": false}	email	2026-02-16 17:53:14.23034+00	2026-02-16 17:53:14.230398+00	2026-02-16 17:53:14.230398+00	f5bd2427-f81e-42d0-ae55-fa71b5d1c5ad
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
08310d10-7081-483c-be29-56632baf041c	90b30f7b-08b8-4e7b-990e-44389c4049b2	2026-02-25 12:44:56.317509+00	2026-02-25 14:02:32.312458+00	\N	aal1	\N	2026-02-25 14:02:32.31235	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	130.45.156.4	\N	\N	\N	\N	\N
c5ea310b-3ced-47c9-b9cf-16527c61660b	b1e57433-e952-4f52-9fec-0f5cb8a6d7c1	2026-02-10 01:37:24.266676+00	2026-02-15 00:42:45.030008+00	\N	aal1	\N	2026-02-15 00:42:45.029266	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Mobile/15E148 Safari/604.1	23.120.165.116	\N	\N	\N	\N	\N
008dd664-14ee-4135-92fd-eeffb4047a13	e9745b7b-8e14-4c45-b678-56d6ca26f567	2026-02-16 17:54:20.184381+00	2026-02-16 17:54:20.184381+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	96.8.185.223	\N	\N	\N	\N	\N
16fa1016-7013-4d2c-be24-57553d3467b6	90b30f7b-08b8-4e7b-990e-44389c4049b2	2026-02-25 14:02:49.363749+00	2026-02-25 14:02:49.363749+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.109.5 Chrome/142.0.7444.265 Electron/39.3.0 Safari/537.36	130.45.156.4	\N	\N	\N	\N	\N
ba461657-3caf-4ccd-a8e7-f6cb7a52561e	90b30f7b-08b8-4e7b-990e-44389c4049b2	2026-02-25 14:27:42.881984+00	2026-02-25 15:46:12.073325+00	\N	aal1	\N	2026-02-25 15:46:12.073132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	130.45.156.4	\N	\N	\N	\N	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
c5ea310b-3ced-47c9-b9cf-16527c61660b	2026-02-10 01:37:24.313073+00	2026-02-10 01:37:24.313073+00	otp	9714ef52-af41-4fc6-af96-3072e2986c62
008dd664-14ee-4135-92fd-eeffb4047a13	2026-02-16 17:54:20.220721+00	2026-02-16 17:54:20.220721+00	otp	f98a2161-8744-48fc-b2d7-25a6470948c4
08310d10-7081-483c-be29-56632baf041c	2026-02-25 12:44:56.338822+00	2026-02-25 12:44:56.338822+00	oauth	54bc8395-1712-413b-a239-9b2a3beb0b0f
16fa1016-7013-4d2c-be24-57553d3467b6	2026-02-25 14:02:49.371204+00	2026-02-25 14:02:49.371204+00	oauth	2c1e2093-4f74-4488-b58e-b077d350ca29
ba461657-3caf-4ccd-a8e7-f6cb7a52561e	2026-02-25 14:27:42.924671+00	2026-02-25 14:27:42.924671+00	oauth	7416375e-9cc6-435b-8d89-63d0e7041695
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	191	nldtqlksavpn	90b30f7b-08b8-4e7b-990e-44389c4049b2	t	2026-02-25 12:44:56.329849+00	2026-02-25 14:02:32.263808+00	\N	08310d10-7081-483c-be29-56632baf041c
00000000-0000-0000-0000-000000000000	192	bvr3m6fynljy	90b30f7b-08b8-4e7b-990e-44389c4049b2	f	2026-02-25 14:02:32.291918+00	2026-02-25 14:02:32.291918+00	nldtqlksavpn	08310d10-7081-483c-be29-56632baf041c
00000000-0000-0000-0000-000000000000	193	vv354hxdzdn6	90b30f7b-08b8-4e7b-990e-44389c4049b2	f	2026-02-25 14:02:49.368346+00	2026-02-25 14:02:49.368346+00	\N	16fa1016-7013-4d2c-be24-57553d3467b6
00000000-0000-0000-0000-000000000000	194	3uvbeyfbewph	90b30f7b-08b8-4e7b-990e-44389c4049b2	t	2026-02-25 14:27:42.899462+00	2026-02-25 15:46:12.008853+00	\N	ba461657-3caf-4ccd-a8e7-f6cb7a52561e
00000000-0000-0000-0000-000000000000	195	fwq2adkzvmgc	90b30f7b-08b8-4e7b-990e-44389c4049b2	f	2026-02-25 15:46:12.037175+00	2026-02-25 15:46:12.037175+00	3uvbeyfbewph	ba461657-3caf-4ccd-a8e7-f6cb7a52561e
00000000-0000-0000-0000-000000000000	163	jdqviur5ta4z	b1e57433-e952-4f52-9fec-0f5cb8a6d7c1	t	2026-02-10 01:37:24.28959+00	2026-02-10 04:02:35.403962+00	\N	c5ea310b-3ced-47c9-b9cf-16527c61660b
00000000-0000-0000-0000-000000000000	164	5i72zwvzfk2p	b1e57433-e952-4f52-9fec-0f5cb8a6d7c1	t	2026-02-10 04:02:35.433917+00	2026-02-15 00:42:44.947876+00	jdqviur5ta4z	c5ea310b-3ced-47c9-b9cf-16527c61660b
00000000-0000-0000-0000-000000000000	167	azuohl6xplmr	b1e57433-e952-4f52-9fec-0f5cb8a6d7c1	f	2026-02-15 00:42:44.983093+00	2026-02-15 00:42:44.983093+00	5i72zwvzfk2p	c5ea310b-3ced-47c9-b9cf-16527c61660b
00000000-0000-0000-0000-000000000000	186	6r6tftvbhx4z	e9745b7b-8e14-4c45-b678-56d6ca26f567	f	2026-02-16 17:54:20.199852+00	2026-02-16 17:54:20.199852+00	\N	008dd664-14ee-4135-92fd-eeffb4047a13
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: rbhc-table-profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."rbhc-table-profiles" (user_id, created_at, email, brevo_contact_id, subscribed, last_synced, first_name, id, merch_preferences) FROM stdin;
e9745b7b-8e14-4c45-b678-56d6ca26f567	2026-02-16 17:53:13.089978	stefanross@gvtc.com	53	t	2026-02-16 17:53:13.089978+00	Stefan	43	{}
90b30f7b-08b8-4e7b-990e-44389c4049b2	2026-02-16 19:01:50.288414	justinmcintyre3@gmail.com	54	t	2026-02-16 19:01:50.288414+00	Justin	45	{Stickers,Hoodies,T-Shirts,Hats}
b1e57433-e952-4f52-9fec-0f5cb8a6d7c1	2026-02-10 01:36:19.832444	bricewhitley@gmail.com	52	t	2026-02-10 01:36:19.832444+00	Friend	40	{}
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, status, tracking_number, created_at, shipped_at, delivered_at, updated_at, profile_id) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, type, description, price, dropship_sku, dropship_supplier, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, quantity, price_paid, created_at) FROM stdin;
\.


--
-- Data for Name: subscription_tiers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_tiers (id, name, display_name, description, price_monthly, price_6month, price_yearly, benefits, created_at, updated_at) FROM stdin;
1	free	Free	Access to content and community	0	0	0	{"merchandise": [], "discount_percent": 0, "honey_jars_per_year": 0}	2026-02-07 20:41:16.82886+00	2026-02-07 20:41:16.82886+00
2	level-1	Level 1: Friend of the Bear	1 jar of honey per year + merch	1299	7794	12990	{"merchandise": ["shirt", "hat"], "discount_percent": 0, "honey_jars_per_year": 1}	2026-02-07 20:41:16.82886+00	2026-02-07 20:41:16.82886+00
3	level-2	Level 2: Honey Keeper	1 jar + shirt/hat + 5% discount	1799	10794	17990	{"merchandise": ["shirt", "hat"], "discount_percent": 5, "honey_jars_per_year": 1}	2026-02-07 20:41:16.82886+00	2026-02-07 20:41:16.82886+00
4	level-3	Level 3: Bear Guardian	2 jars per year (spring/fall) + merch + 10% discount	2499	14994	24990	{"merchandise": ["shirt", "hat", "other"], "discount_percent": 10, "honey_jars_per_year": 2}	2026-02-07 20:41:16.82886+00	2026-02-07 20:41:16.82886+00
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscriptions (id, tier_id, stripe_customer_id, stripe_subscription_id, billing_cycle, status, next_renewal_date, created_at, updated_at, profile_id) FROM stdin;
16	1	\N	\N	1	active	\N	2026-02-10 01:36:19.832444+00	2026-02-10 01:36:19.832444+00	40
17	1	\N	\N	1	active	\N	2026-02-16 17:53:13.089978+00	2026-02-16 17:53:13.089978+00	43
18	1	\N	\N	1	active	\N	2026-02-16 19:01:50.288414+00	2026-02-16 19:01:50.288414+00	45
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-02-04 20:04:54
20211116045059	2026-02-04 20:04:54
20211116050929	2026-02-04 20:04:54
20211116051442	2026-02-04 20:04:54
20211116212300	2026-02-04 20:04:54
20211116213355	2026-02-04 20:04:54
20211116213934	2026-02-04 20:04:54
20211116214523	2026-02-04 20:04:54
20211122062447	2026-02-04 20:04:54
20211124070109	2026-02-04 20:04:54
20211202204204	2026-02-04 20:04:54
20211202204605	2026-02-04 20:04:54
20211210212804	2026-02-04 20:04:54
20211228014915	2026-02-04 20:04:54
20220107221237	2026-02-04 20:04:54
20220228202821	2026-02-04 20:04:54
20220312004840	2026-02-04 20:04:54
20220603231003	2026-02-04 20:04:54
20220603232444	2026-02-04 20:04:54
20220615214548	2026-02-04 20:04:55
20220712093339	2026-02-04 20:04:55
20220908172859	2026-02-04 20:04:55
20220916233421	2026-02-04 20:04:55
20230119133233	2026-02-04 20:04:55
20230128025114	2026-02-04 20:04:55
20230128025212	2026-02-04 20:04:55
20230227211149	2026-02-04 20:04:55
20230228184745	2026-02-04 20:04:55
20230308225145	2026-02-04 20:04:55
20230328144023	2026-02-04 20:04:55
20231018144023	2026-02-04 20:04:55
20231204144023	2026-02-04 20:04:55
20231204144024	2026-02-04 20:04:55
20231204144025	2026-02-04 20:04:55
20240108234812	2026-02-04 20:04:55
20240109165339	2026-02-04 20:04:55
20240227174441	2026-02-04 20:04:55
20240311171622	2026-02-04 20:04:55
20240321100241	2026-02-04 20:04:55
20240401105812	2026-02-04 20:04:55
20240418121054	2026-02-04 20:04:55
20240523004032	2026-02-04 20:04:55
20240618124746	2026-02-04 20:04:55
20240801235015	2026-02-04 20:04:55
20240805133720	2026-02-04 20:04:55
20240827160934	2026-02-04 20:04:55
20240919163303	2026-02-04 20:04:55
20240919163305	2026-02-04 20:04:55
20241019105805	2026-02-04 20:04:55
20241030150047	2026-02-04 20:04:55
20241108114728	2026-02-04 20:04:55
20241121104152	2026-02-04 20:04:55
20241130184212	2026-02-04 20:04:55
20241220035512	2026-02-04 20:04:55
20241220123912	2026-02-04 20:04:55
20241224161212	2026-02-04 20:04:55
20250107150512	2026-02-04 20:04:55
20250110162412	2026-02-04 20:04:55
20250123174212	2026-02-04 20:04:55
20250128220012	2026-02-04 20:04:55
20250506224012	2026-02-04 20:04:55
20250523164012	2026-02-04 20:04:55
20250714121412	2026-02-04 20:04:55
20250905041441	2026-02-04 20:04:55
20251103001201	2026-02-04 20:04:55
20251120212548	2026-02-04 20:04:56
20251120215549	2026-02-04 20:04:56
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-02-04 16:38:01.610549
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-02-04 16:38:01.625747
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-02-04 16:38:01.650243
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-02-04 16:38:01.660282
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-02-04 16:38:01.664348
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-02-04 16:38:01.686433
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-02-04 16:38:01.718393
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-02-04 16:38:01.78396
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-02-04 16:38:01.788872
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-02-04 16:38:01.793297
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-02-04 16:38:01.797893
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-02-04 16:38:01.81475
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-02-04 16:38:01.818931
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-02-04 16:38:01.82349
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-02-04 16:38:01.827386
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-02-04 16:38:01.837624
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-02-04 16:38:01.841649
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-02-04 16:38:01.846641
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-02-04 16:38:01.858394
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-02-04 16:38:01.868359
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-02-04 16:38:01.872694
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-02-04 16:38:01.876621
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-02-04 16:38:02.054163
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-02-04 16:38:02.091273
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-02-04 16:38:02.096109
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-02-04 16:38:02.105607
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-02-04 16:38:02.110145
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-02-04 16:38:02.128523
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-02-04 16:38:01.629812
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-02-04 16:38:01.669346
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-02-04 16:38:01.723886
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-02-04 16:38:01.759023
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-02-04 16:38:01.881614
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-02-04 16:38:01.89789
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-02-04 16:38:01.907951
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-02-04 16:38:01.912074
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-02-04 16:38:01.915769
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-02-04 16:38:02.025379
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-02-04 16:38:02.030971
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-02-04 16:38:02.036428
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-02-04 16:38:02.037826
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-02-04 16:38:02.043527
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-02-04 16:38:02.047796
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-02-04 16:38:02.058535
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-02-04 16:38:02.066009
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-02-04 16:38:02.07055
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-02-04 16:38:02.077532
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-02-04 16:38:02.082034
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-02-04 16:38:02.087235
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-02-04 16:38:02.113945
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-02-05 19:05:12.704227
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-02-05 19:05:12.791907
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-02-05 19:05:12.793554
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-02-05 19:05:12.943647
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-02-05 19:05:12.946752
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-02-05 19:05:12.948427
56	fix-optimized-search-function	cb58526ebc23048049fd5bf2fd148d18b04a2073	2026-02-06 13:24:30.7569
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name) FROM stdin;
20250809013601	{"create or replace function public.handle_new_user()\nreturns trigger as $$\nbegin\n  insert into public.\\"rbhc-table-profiles\\" (user_id, subscription_tier, created_at)\n  values (new.id, 'free', now());\n  return new;\nend;\n$$ language plpgsql security definer","create trigger on_auth_user_created\nafter insert on auth.users\nfor each row execute procedure public.handle_new_user()"}	create_user_profile_trigger
20250809120918	{"create or replace function public.handle_new_user()\nreturns TRIGGER as $$\nbegin\n  insert into public.\\"rbhc-table-profiles\\" (user_id, subscription_tier, created_at)\n  values (new.id, 'free', now());\n  return new;\nend;\n$$ language plpgsql security definer SET search_path = 'public, auth'","drop TRIGGER if exists on_auth_user_created on auth.users","create TRIGGER on_auth_user_created\nafter insert on auth.users\nfor each row execute procedure public.handle_new_user()"}	add_search_path_to_handle_new_user
20250811130958	{"-- Migration: Adjust rbhc-table-profiles for email subscriptions and new PK\n\nDO $$\nDECLARE\n  pk_name text;\nBEGIN\n  -- Find existing primary key constraint name\n  SELECT constraint_name INTO pk_name\n  FROM information_schema.table_constraints\n  WHERE table_schema = 'public'\n    AND table_name = 'rbhc-table-profiles'\n    AND constraint_type = 'PRIMARY KEY';\n\n  -- Drop the existing PK constraint if it exists\n  IF pk_name IS NOT NULL THEN\n    EXECUTE format('ALTER TABLE public.\\"rbhc-table-profiles\\" DROP CONSTRAINT %I', pk_name);\n  END IF;\nEND;\n$$","-- Add new id column if it doesn't exist\nALTER TABLE public.\\"rbhc-table-profiles\\"\nADD COLUMN IF NOT EXISTS id bigserial","-- Set the new id column as primary key\nALTER TABLE public.\\"rbhc-table-profiles\\"\nADD PRIMARY KEY (id)","-- Make user_id nullable if currently NOT NULL\nALTER TABLE public.\\"rbhc-table-profiles\\"\nALTER COLUMN user_id DROP NOT NULL","-- Add email column if it doesn't exist\nALTER TABLE public.\\"rbhc-table-profiles\\"\nADD COLUMN IF NOT EXISTS email text","-- Create unique index on email to avoid duplicates\nCREATE UNIQUE INDEX IF NOT EXISTS idx_profiles_email ON public.\\"rbhc-table-profiles\\" (email)"}	adjust_profiles_table_to_include_email
20250811133506	{"-- Migration: Adjust rbhc-table-profiles for email subscriptions and new PK\n\nDO $$\nDECLARE\n  pk_name text;\nBEGIN\n  -- Find existing primary key constraint name\n  SELECT constraint_name INTO pk_name\n  FROM information_schema.table_constraints\n  WHERE table_schema = 'public'\n    AND table_name = 'rbhc-table-profiles'\n    AND constraint_type = 'PRIMARY KEY';\n\n  -- Drop the existing PK constraint if it exists\n  IF pk_name IS NOT NULL THEN\n    EXECUTE format('ALTER TABLE public.\\"rbhc-table-profiles\\" DROP CONSTRAINT %I', pk_name);\n  END IF;\nEND;\n$$","-- Add new id column if it doesn't exist\nALTER TABLE public.\\"rbhc-table-profiles\\"\nADD COLUMN IF NOT EXISTS id bigserial","-- Set the new id column as primary key\nALTER TABLE public.\\"rbhc-table-profiles\\"\nADD PRIMARY KEY (id)","-- Make user_id nullable if currently NOT NULL\nALTER TABLE public.\\"rbhc-table-profiles\\"\nALTER COLUMN user_id DROP NOT NULL","-- Add email column if it doesn't exist\nALTER TABLE public.\\"rbhc-table-profiles\\"\nADD COLUMN IF NOT EXISTS email text","-- Create unique index on email to avoid duplicates\nCREATE UNIQUE INDEX IF NOT EXISTS idx_profiles_email ON public.\\"rbhc-table-profiles\\" (email)","-- 20250811190000_update_handle_new_user_function.sql\n\ncreate or replace function public.handle_new_user()\nreturns trigger as $$\nbegin\n  insert into public.\\"rbhc-table-profiles\\" (user_id, subscription_tier, created_at, email)\n  values (new.id, 'free', now(), new.email)\n  on conflict (email) do update\n  set user_id = excluded.user_id\n  where public.\\"rbhc-table-profiles\\".user_id is null;\n\n  return new;\nend;\n$$ language plpgsql security definer SET search_path = 'public, auth'","drop trigger if exists on_auth_user_created on auth.users","create trigger on_auth_user_created\nafter insert on auth.users\nfor each row execute procedure public.handle_new_user()"}	adjust_trigger_to_add_email_to_nulled_user
20250811155001	{"alter table public.\\"rbhc-table-profiles\\"\r\nadd column brevo_contact_id varchar null"}	add_brevo_contact_id_column
20250811165622	{"alter table public.\\"rbhc-table-profiles\\"\r\nadd column subscribed BOOLEAN DEFAULT true"}	add_contact_subscription_status
20250811170512	{"alter table public.\\"rbhc-table-profiles\\"\r\nadd column last_synced TIMESTAMP WITH TIME ZONE"}	add_synced_at_column
20250811171044	{"ALTER TABLE public.\\"rbhc-table-profiles\\" REPLICA IDENTITY FULL"}	add_replica_realtime_to_table
20250811172358	{"-- Enable HTTP extension (needed for http_post)\r\ncreate extension if not exists http","-- Create a trigger function that calls the Edge Function\r\ncreate or replace function public.call_brevo_sync()\r\nreturns trigger\r\nlanguage plpgsql\r\nas $$\r\ndeclare\r\n  response text;\r\nbegin\r\n  -- Send HTTP POST to Edge Function\r\n  select content::text into response\r\n  from http_post(\r\n    'https://dohcquvoxlpqcsdkywbd.functions.supabase.co/sync-brevo-contact',\r\n    json_build_object(\r\n      'email', new.email,\r\n      'tier', new.subscription_tier\r\n    )::text,\r\n    'application/json',\r\n    json_build_object(\r\n      'Authorization', 'Bearer ' || current_setting('app.settings.service_role_key', true)\r\n    )::text\r\n  );\r\n\r\n  -- Optional: log the response for debugging\r\n  raise notice 'Brevo sync response: %', response;\r\n\r\n  return new;\r\nend;\r\n$$","-- Drop trigger if it exists (for re-deploy safety)\r\ndrop trigger if exists on_profile_insert on public.\\"rbhc-table-profiles\\"","-- Create the trigger\r\ncreate trigger on_profile_insert\r\nafter insert on public.\\"rbhc-table-profiles\\"\r\nfor each row execute function public.call_brevo_sync()"}	enable_realtime_db_listener_function_caller
20250812113006	{"alter table public.\\"rbhc-table-profiles\\"\r\nadd column first_name varchar(50)"}	add_first_name_column
20250812121500	{"-- Update Edge Function trigger payload to include first_name\r\ncreate or replace function public.call_brevo_sync()\r\nreturns trigger\r\nlanguage plpgsql\r\nas $$\r\ndeclare\r\n  response text;\r\nbegin\r\n  select content::text into response\r\n  from http_post(\r\n    'https://dohcquvoxlpqcsdkywbd.functions.supabase.co/sync-brevo-contact',\r\n    json_build_object(\r\n      'email', new.email,\r\n      'tier', new.subscription_tier,\r\n      'first_name', new.first_name\r\n    )::text,\r\n    'application/json',\r\n    json_build_object(\r\n      'Authorization', 'Bearer ' || current_setting('app.settings.service_role_key', true)\r\n    )::text\r\n  );\r\n\r\n  return new;\r\nend;\r\n$$"}	update_brevo_sync_include_first_name
20250812124756	{"-- Replace the existing function to add search_path and first_name support\r\nCREATE OR REPLACE FUNCTION public.call_brevo_sync()\r\nRETURNS trigger\r\nLANGUAGE plpgsql\r\nSECURITY DEFINER\r\nSET search_path = public\r\nAS $$\r\nDECLARE\r\n  res http_response;\r\n  response_json jsonb;\r\n  brevo_id text;\r\nBEGIN\r\n  res := http_post(\r\n    'https://dohcquvoxlpqcsdkywbd.functions.supabase.co/sync-brevo-contact',\r\n    json_build_object(\r\n      'email', NEW.email,\r\n      'tier', NEW.subscription_tier,\r\n      'first_name', NEW.first_name\r\n    )::text,\r\n    'application/json'\r\n  );\r\n\r\n  response_json := res.content::jsonb;\r\n\r\n  brevo_id := response_json->>'brevo_contact_id';\r\n\r\n  IF brevo_id IS NOT NULL THEN\r\n    UPDATE public.\\"rbhc-table-profiles\\"\r\n    SET brevo_contact_id = brevo_id,\r\n        last_synced = NOW()\r\n    WHERE id = NEW.id;\r\n  END IF;\r\n\r\n  RETURN NEW;\r\nEND;\r\n$$"}	_update_call_brevo_sync_set_search_path
20250812125257	{"-- Create the extensions schema if it doesn't exist\r\nCREATE SCHEMA IF NOT EXISTS extensions","-- Drop the http extension if it exists in public\r\nDROP EXTENSION IF EXISTS http","-- Recreate the http extension in the extensions schema\r\nCREATE EXTENSION IF NOT EXISTS http SCHEMA extensions"}	move_http_post_to_extensions_scheme_from_public
20250812125432	{"CREATE OR REPLACE FUNCTION public.call_brevo_sync()\r\nRETURNS trigger AS\r\n$$\r\nDECLARE\r\n  res extensions.http_response;\r\n  response_json jsonb;\r\n  brevo_id text;\r\nBEGIN\r\n  -- Make sure to qualify http_post with extensions schema\r\n  res := extensions.http_post(\r\n    'https://dohcquvoxlpqcsdkywbd.functions.supabase.co/sync-brevo-contact',\r\n    json_build_object(\r\n      'email', NEW.email,\r\n      'tier', NEW.subscription_tier,\r\n      'first_name', NEW.first_name\r\n    )::text,\r\n    'application/json'\r\n  );\r\n\r\n  response_json := res.content::jsonb;\r\n\r\n  brevo_id := response_json->>'brevo_contact_id';\r\n\r\n  IF brevo_id IS NOT NULL THEN\r\n    UPDATE public.\\"rbhc-table-profiles\\"\r\n    SET brevo_contact_id = brevo_id,\r\n        last_synced = NOW()\r\n    WHERE id = NEW.id;\r\n  END IF;\r\n\r\n  RETURN NEW;\r\nEND;\r\n$$ LANGUAGE plpgsql SECURITY DEFINER\r\n  SET search_path = public, extensions"}	_update_call_brevo_sync_http_post_from_extensions_shcema
20260206002252	{"-- 1. Ensure the vault extension is active\r\nCREATE EXTENSION IF NOT EXISTS \\"supabase_vault\\" WITH SCHEMA \\"vault\\"","-- 2. Add your secret to the vault\r\n-- Note: Locally, you might use a dummy value, then update it in production\r\nSELECT vault.create_secret(\r\n  'PLACEHOLDER_DO_NOT_COMMIT_REAL_KEY', \r\n  'service_role_key', \r\n  'Internal key for triggering Edge Functions'\r\n)"}	setup_vault_secrets
20260207203938	{"-- Migration: Create subscription system tables\r\n-- Date: 2025-02-07\r\n-- Purpose: Single source of truth for all user tiers (free, level-1, level-2, level-3)\r\n--          with Stripe integration and flexible billing cycles\r\n\r\n-- ============================================================================\r\n-- TABLE: subscription_tiers\r\n-- Purpose: Define tier details (benefits, names, prices)\r\n-- ============================================================================\r\nCREATE TABLE public.subscription_tiers (\r\n  id BIGSERIAL PRIMARY KEY,\r\n  name VARCHAR(50) NOT NULL UNIQUE, -- 'free', 'level-1', 'level-2', 'level-3'\r\n  display_name VARCHAR(100) NOT NULL, -- 'Free', 'Level 1: Friend of the Bear', etc.\r\n  description TEXT,\r\n  \r\n  -- Pricing per billing cycle (in cents, e.g., 900 = $9.00)\r\n  price_monthly INT NOT NULL DEFAULT 0, -- $0 for free, actual price for paid tiers\r\n  price_6month INT NOT NULL DEFAULT 0,\r\n  price_yearly INT NOT NULL DEFAULT 0,\r\n  \r\n  -- Benefits (stored as JSON for flexibility)\r\n  benefits JSONB DEFAULT '{}', -- e.g., {\\"honey_jars_per_year\\": 1, \\"discount_percent\\": 5}\r\n  \r\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\r\n  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\r\n)","-- Pre-populate tiers\r\nINSERT INTO public.subscription_tiers \r\n  (name, display_name, description, price_monthly, price_6month, price_yearly, benefits)\r\nVALUES\r\n  ('free', 'Free', 'Access to content and community', 0, 0, 0, '{\\"honey_jars_per_year\\": 0, \\"discount_percent\\": 0, \\"merchandise\\": []}'),\r\n  ('level-1', 'Level 1: Friend of the Bear', '1 jar of honey per year + merch', 1299, 7794, 12990, '{\\"honey_jars_per_year\\": 1, \\"discount_percent\\": 0, \\"merchandise\\": [\\"shirt\\", \\"hat\\"]}'),\r\n  ('level-2', 'Level 2: Honey Keeper', '1 jar + shirt/hat + 5% discount', 1799, 10794, 17990, '{\\"honey_jars_per_year\\": 1, \\"discount_percent\\": 5, \\"merchandise\\": [\\"shirt\\", \\"hat\\"]}'),\r\n  ('level-3', 'Level 3: Bear Guardian', '2 jars per year (spring/fall) + merch + 10% discount', 2499, 14994, 24990, '{\\"honey_jars_per_year\\": 2, \\"discount_percent\\": 10, \\"merchandise\\": [\\"shirt\\", \\"hat\\", \\"other\\"]}')","-- Index for lookups\r\nCREATE INDEX idx_subscription_tiers_name ON public.subscription_tiers(name)","-- ============================================================================\r\n-- TABLE: subscriptions\r\n-- Purpose: Track each user's subscription (single source of truth for tier)\r\n-- ============================================================================\r\nCREATE TABLE public.subscriptions (\r\n  id BIGSERIAL PRIMARY KEY,\r\n  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,\r\n  \r\n  -- Tier reference\r\n  tier_id BIGINT NOT NULL REFERENCES public.subscription_tiers(id),\r\n  \r\n  -- Stripe integration\r\n  stripe_customer_id VARCHAR(255), -- null until first payment\r\n  stripe_subscription_id VARCHAR(255), -- null until Stripe subscription created\r\n  \r\n  -- Billing cycle in months\r\n  billing_cycle INT NOT NULL DEFAULT 1, -- 1, 6, or 12\r\n  \r\n  -- Subscription status\r\n  status VARCHAR(50) NOT NULL DEFAULT 'active', -- active, paused, canceled\r\n  \r\n  -- Renewal tracking\r\n  next_renewal_date TIMESTAMP WITH TIME ZONE,\r\n  \r\n  -- Timestamps\r\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\r\n  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\r\n)","-- Indexes for common queries\r\nCREATE INDEX idx_subscriptions_user_id ON public.subscriptions(user_id)","CREATE INDEX idx_subscriptions_tier_id ON public.subscriptions(tier_id)","CREATE INDEX idx_subscriptions_stripe_customer_id ON public.subscriptions(stripe_customer_id)","CREATE INDEX idx_subscriptions_stripe_subscription_id ON public.subscriptions(stripe_subscription_id)","CREATE INDEX idx_subscriptions_status ON public.subscriptions(status)","CREATE INDEX idx_subscriptions_next_renewal_date ON public.subscriptions(next_renewal_date)","-- ============================================================================\r\n-- TABLE: orders\r\n-- Purpose: Track physical honey shipments and merchandise orders\r\n-- ============================================================================\r\nCREATE TABLE public.orders (\r\n  id BIGSERIAL PRIMARY KEY,\r\n  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,\r\n  \r\n  -- Order status\r\n  status VARCHAR(50) NOT NULL DEFAULT 'pending', -- pending, shipped, delivered, canceled\r\n  \r\n  -- Tracking\r\n  tracking_number VARCHAR(255),\r\n  \r\n  -- Timestamps\r\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\r\n  shipped_at TIMESTAMP WITH TIME ZONE,\r\n  delivered_at TIMESTAMP WITH TIME ZONE,\r\n  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\r\n)","CREATE INDEX idx_orders_user_id ON public.orders(user_id)","CREATE INDEX idx_orders_status ON public.orders(status)","CREATE INDEX idx_orders_created_at ON public.orders(created_at)","-- ============================================================================\r\n-- TABLE: products\r\n-- Purpose: Honey jars, shirts, hats, merch items\r\n-- ============================================================================\r\nCREATE TABLE public.products (\r\n  id BIGSERIAL PRIMARY KEY,\r\n  name VARCHAR(255) NOT NULL,\r\n  type VARCHAR(50) NOT NULL, -- 'honey', 'shirt', 'hat', 'merch'\r\n  description TEXT,\r\n  price INT NOT NULL, -- in cents\r\n  \r\n  -- Dropship info (optional)\r\n  dropship_sku VARCHAR(255),\r\n  dropship_supplier VARCHAR(255),\r\n  \r\n  -- Availability\r\n  is_active BOOLEAN DEFAULT TRUE,\r\n  \r\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\r\n  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\r\n)","CREATE INDEX idx_products_type ON public.products(type)","CREATE INDEX idx_products_is_active ON public.products(is_active)","-- ============================================================================\r\n-- TABLE: order_items\r\n-- Purpose: Line items in each order\r\n-- ============================================================================\r\nCREATE TABLE public.order_items (\r\n  id BIGSERIAL PRIMARY KEY,\r\n  order_id BIGINT NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE,\r\n  product_id BIGINT NOT NULL REFERENCES public.products(id),\r\n  \r\n  quantity INT NOT NULL DEFAULT 1,\r\n  price_paid INT NOT NULL, -- in cents, for historical record\r\n  \r\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\r\n)","CREATE INDEX idx_order_items_order_id ON public.order_items(order_id)","CREATE INDEX idx_order_items_product_id ON public.order_items(product_id)","-- ============================================================================\r\n-- RLS POLICIES - Enable Row Level Security\r\n-- ============================================================================\r\n\r\n-- Enable RLS on all new tables\r\nALTER TABLE public.subscriptions ENABLE ROW LEVEL SECURITY","ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY","ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY","-- Subscriptions: authenticated users can only see their own\r\nCREATE POLICY \\"Users can view their own subscription\\"\r\n  ON public.subscriptions\r\n  FOR SELECT\r\n  USING (auth.uid() = user_id)","CREATE POLICY \\"Users can update their own subscription\\"\r\n  ON public.subscriptions\r\n  FOR UPDATE\r\n  USING (auth.uid() = user_id)","-- Orders: authenticated users can only see their own\r\nCREATE POLICY \\"Users can view their own orders\\"\r\n  ON public.orders\r\n  FOR SELECT\r\n  USING (auth.uid() = user_id)","-- Order items: authenticated users can only see items in their orders\r\nCREATE POLICY \\"Users can view order items for their orders\\"\r\n  ON public.order_items\r\n  FOR SELECT\r\n  USING (order_id IN (SELECT id FROM public.orders WHERE user_id = auth.uid()))","-- Subscription tiers and products are public read-only\r\nALTER TABLE public.subscription_tiers ENABLE ROW LEVEL SECURITY","ALTER TABLE public.products ENABLE ROW LEVEL SECURITY","CREATE POLICY \\"Everyone can view subscription tiers\\"\r\n  ON public.subscription_tiers\r\n  FOR SELECT\r\n  USING (true)","CREATE POLICY \\"Everyone can view products\\"\r\n  ON public.products\r\n  FOR SELECT\r\n  USING (is_active = true)","-- ============================================================================\r\n-- FUNCTION: Auto-create subscription for new users\r\n-- ============================================================================\r\n-- When a new profile is created, auto-create a 'free' subscription\r\nCREATE OR REPLACE FUNCTION public.create_subscription_for_new_user()\r\nRETURNS trigger\r\nLANGUAGE plpgsql\r\nSECURITY DEFINER\r\nSET search_path = public\r\nAS $$\r\nDECLARE\r\n  free_tier_id BIGINT;\r\nBEGIN\r\n  -- Get the 'free' tier ID\r\n  SELECT id INTO free_tier_id FROM public.subscription_tiers WHERE name = 'free' LIMIT 1;\r\n  \r\n  IF free_tier_id IS NULL THEN\r\n    RAISE LOG 'Free tier not found in subscription_tiers table';\r\n    RETURN NEW;\r\n  END IF;\r\n  \r\n  -- Create subscription for this user only if they don't already have one\r\n  INSERT INTO public.subscriptions (user_id, tier_id, billing_cycle, status)\r\n  VALUES (NEW.user_id, free_tier_id, 1, 'active')\r\n  ON CONFLICT (user_id) DO NOTHING;\r\n  \r\n  RETURN NEW;\r\nEND;\r\n$$","-- Trigger: When profile is created (and user_id is not null), create free subscription\r\nCREATE TRIGGER on_profile_insert_create_subscription\r\n  AFTER INSERT ON public.\\"rbhc-table-profiles\\"\r\n  FOR EACH ROW\r\n  WHEN (NEW.user_id IS NOT NULL)\r\n  EXECUTE FUNCTION public.create_subscription_for_new_user()","-- ============================================================================\r\n-- ROLLBACK INSTRUCTIONS\r\n-- ============================================================================\r\n--\r\n-- To rollback this migration, run:\r\n--\r\n-- DROP TRIGGER IF EXISTS on_profile_insert_create_subscription ON public.\\"rbhc-table-profiles\\";\r\n-- DROP FUNCTION IF EXISTS public.create_subscription_for_new_user();\r\n-- DROP TABLE IF EXISTS public.order_items CASCADE;\r\n-- DROP TABLE IF EXISTS public.orders CASCADE;\r\n-- DROP TABLE IF EXISTS public.products CASCADE;\r\n-- DROP TABLE IF EXISTS public.subscriptions CASCADE;\r\n-- DROP TABLE IF EXISTS public.subscription_tiers CASCADE;\r\n--"}	create_subscription_system
20260207204800	{"-- Migration: Update handle_new_user function to remove subscription_tier\r\n-- Date: 2025-02-07\r\n-- Purpose: Remove subscription_tier setting from handle_new_user since subscriptions\r\n--          are now managed in the subscriptions table with auto-creation via trigger\r\n\r\nCREATE OR REPLACE FUNCTION public.handle_new_user()\r\nRETURNS trigger\r\nLANGUAGE plpgsql\r\nSECURITY DEFINER\r\nSET search_path = public\r\nAS $$\r\nBEGIN\r\n  INSERT INTO public.\\"rbhc-table-profiles\\" (user_id, created_at, email)\r\n  VALUES (new.id, now(), new.email)\r\n  ON CONFLICT (email) DO UPDATE\r\n  SET \r\n    user_id = excluded.user_id\r\n  WHERE public.\\"rbhc-table-profiles\\".user_id IS NULL;\r\n\r\n  RETURN new;\r\nEND;\r\n$$","-- ============================================================================\r\n-- ROLLBACK INSTRUCTIONS\r\n-- ============================================================================\r\n--\r\n-- To rollback this migration, restore the previous function version:\r\n--\r\n-- CREATE OR REPLACE FUNCTION public.handle_new_user()\r\n-- RETURNS trigger\r\n-- LANGUAGE plpgsql\r\n-- SECURITY DEFINER\r\n-- SET search_path = public\r\n-- AS $$\r\n-- BEGIN\r\n--   insert into public.\\"rbhc-table-profiles\\" (user_id, subscription_tier, created_at, email)\r\n--   values (new.id, 'conditional', now(), new.email)\r\n--   on conflict (email) do update\r\n--   set \r\n--     user_id = excluded.user_id,\r\n--     subscription_tier = excluded.subscription_tier\r\n--   where public.\\"rbhc-table-profiles\\".user_id is null;\r\n--\r\n--   return new;\r\n-- end;\r\n-- $$;"}	update_handle_new_user_function
20260207204900	{"-- Migration: Remove subscription_tier column from rbhc-table-profiles\r\n-- Date: 2025-02-07\r\n-- Purpose: subscription_tier is now managed in subscriptions table, not denormalized in profiles\r\n\r\nALTER TABLE public.\\"rbhc-table-profiles\\"\r\nDROP COLUMN IF EXISTS subscription_tier","-- ============================================================================\r\n-- ROLLBACK INSTRUCTIONS\r\n-- ============================================================================\r\n--\r\n-- To rollback this migration:\r\n--\r\n-- ALTER TABLE public.\\"rbhc-table-profiles\\"\r\n-- ADD COLUMN subscription_tier VARCHAR(50) DEFAULT 'free';"}	remove_subscription_tier_from_profiles
20260207205000	{"-- Migration: Update handle_new_user to UPSERT by email\r\n-- Date: 2025-02-07\r\n-- Purpose: When auth user signs up, check if email already exists in profiles (from onboard).\r\n--          If yes, UPDATE the user_id. If no, INSERT new profile.\r\n--          This allows seamless migration from email-only leads to authenticated users.\r\n\r\nCREATE OR REPLACE FUNCTION public.handle_new_user()\r\nRETURNS trigger\r\nLANGUAGE plpgsql\r\nSECURITY DEFINER\r\nSET search_path = public\r\nAS $$\r\nBEGIN\r\n  INSERT INTO public.\\"rbhc-table-profiles\\" (user_id, created_at, email)\r\n  VALUES (new.id, now(), new.email)\r\n  ON CONFLICT (email) DO UPDATE\r\n  SET \r\n    user_id = excluded.user_id,\r\n    created_at = COALESCE(public.\\"rbhc-table-profiles\\".created_at, excluded.created_at)\r\n  WHERE public.\\"rbhc-table-profiles\\".user_id IS NULL;\r\n\r\n  RETURN new;\r\nEND;\r\n$$","-- ============================================================================\r\n-- ROLLBACK INSTRUCTIONS\r\n-- ============================================================================\r\n--\r\n-- To rollback this migration:\r\n--\r\n-- CREATE OR REPLACE FUNCTION public.handle_new_user()\r\n-- RETURNS trigger\r\n-- LANGUAGE plpgsql\r\n-- SECURITY DEFINER\r\n-- SET search_path = public\r\n-- AS $$\r\n-- BEGIN\r\n--   INSERT INTO public.\\"rbhc-table-profiles\\" (user_id, created_at, email)\r\n--   VALUES (new.id, now(), new.email)\r\n--   ON CONFLICT (email) DO UPDATE\r\n--   SET \r\n--     user_id = excluded.user_id\r\n--   WHERE public.\\"rbhc-table-profiles\\".user_id IS NULL;\r\n--\r\n--   RETURN new;\r\n-- END;\r\n-- $$;"}	update_handle_new_user_upsert
20260207205100	{"-- Migration: Create trigger for email-only leads (onboard) to auto-create FREE subscriptions\r\n-- Date: 2025-02-07\r\n-- Purpose: When a profile is inserted with NULL user_id (from onboard), auto-create a FREE subscription.\r\n--          When profile is later UPDATEd with a real user_id (from auth signup), subscription already exists.\r\n\r\nCREATE OR REPLACE FUNCTION public.create_subscription_for_email_lead()\r\nRETURNS trigger\r\nLANGUAGE plpgsql\r\nSECURITY DEFINER\r\nSET search_path = public\r\nAS $$\r\nDECLARE\r\n  free_tier_id BIGINT;\r\nBEGIN\r\n  -- Get the 'free' tier ID\r\n  SELECT id INTO free_tier_id FROM public.subscription_tiers WHERE name = 'free' LIMIT 1;\r\n  \r\n  IF free_tier_id IS NULL THEN\r\n    RAISE LOG 'Free tier not found in subscription_tiers table';\r\n    RETURN NEW;\r\n  END IF;\r\n  \r\n  -- Create subscription for email-only leads (user_id is NOT NULL but came from onboard)\r\n  -- This happens for both:\r\n  -- 1. New email-only leads (INSERT with user_id from onboard UUID)\r\n  -- 2. Existing leads getting authenticated (UPDATE with user_id from auth)\r\n  INSERT INTO public.subscriptions (user_id, tier_id, billing_cycle, status)\r\n  VALUES (NEW.user_id, free_tier_id, 1, 'active')\r\n  ON CONFLICT (user_id) DO NOTHING;\r\n  \r\n  RETURN NEW;\r\nEND;\r\n$$","-- Drop old trigger if it exists\r\nDROP TRIGGER IF EXISTS on_profile_insert_create_subscription ON public.\\"rbhc-table-profiles\\"","-- Create new trigger for both INSERT and UPDATE\r\nCREATE TRIGGER on_profile_create_or_update_subscription\r\n  AFTER INSERT OR UPDATE ON public.\\"rbhc-table-profiles\\"\r\n  FOR EACH ROW\r\n  WHEN (NEW.user_id IS NOT NULL)\r\n  EXECUTE FUNCTION public.create_subscription_for_email_lead()","-- ============================================================================\r\n-- ROLLBACK INSTRUCTIONS\r\n-- ============================================================================\r\n--\r\n-- To rollback this migration:\r\n--\r\n-- DROP TRIGGER IF EXISTS on_profile_create_or_update_subscription ON public.\\"rbhc-table-profiles\\";\r\n-- DROP FUNCTION IF EXISTS public.create_subscription_for_email_lead();\r\n--\r\n-- CREATE TRIGGER on_profile_insert_create_subscription\r\n--   AFTER INSERT ON public.\\"rbhc-table-profiles\\"\r\n--   FOR EACH ROW\r\n--   WHEN (NEW.user_id IS NOT NULL)\r\n--   EXECUTE FUNCTION public.create_subscription_for_new_user();"}	create_trigger_email_lead_subscription
20260208124933	{"-- 1. START TRANSACTION\r\nBEGIN","-- 2. UNLOCK TABLES (Drop Foreign Keys and Policies first)\r\n-- We do this first so Postgres allows us to drop/modify columns later\r\nALTER TABLE public.subscriptions DROP CONSTRAINT IF EXISTS subscriptions_user_id_fkey","ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS orders_user_id_fkey","DROP POLICY IF EXISTS \\"Users can view their own subscription\\" ON public.subscriptions","DROP POLICY IF EXISTS \\"Users can update their own subscription\\" ON public.subscriptions","DROP POLICY IF EXISTS \\"Users can view their own orders\\" ON public.orders","DROP POLICY IF EXISTS \\"Users can view order items for their orders\\" ON public.order_items","-- 3. REFACTOR THE PROFILES TABLE\r\n-- Drop and recreate ID as BigInt Identity\r\nALTER TABLE public.\\"rbhc-table-profiles\\" DROP COLUMN IF EXISTS id","ALTER TABLE public.\\"rbhc-table-profiles\\" ADD COLUMN id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY","-- Fix user_id to be the optional Auth UUID link\r\nALTER TABLE public.\\"rbhc-table-profiles\\" ALTER COLUMN user_id DROP NOT NULL","ALTER TABLE public.\\"rbhc-table-profiles\\" ALTER COLUMN user_id DROP DEFAULT","-- 4. UPDATE CHILD TABLES (Subscriptions & Orders)\r\n-- Now that policies are gone, we can safely drop these columns\r\nALTER TABLE public.subscriptions DROP COLUMN IF EXISTS user_id","ALTER TABLE public.subscriptions DROP COLUMN IF EXISTS profile_id","-- Safety check\r\nALTER TABLE public.subscriptions ADD COLUMN profile_id BIGINT","ALTER TABLE public.orders DROP COLUMN IF EXISTS user_id","ALTER TABLE public.orders DROP COLUMN IF EXISTS profile_id","-- Safety check\r\nALTER TABLE public.orders ADD COLUMN profile_id BIGINT","-- 5. RE-ESTABLISH INTEGRITY & SECURITY\r\n\r\n-- A) Add Foreign Keys\r\nALTER TABLE public.subscriptions \r\n  ADD CONSTRAINT subscriptions_profile_id_fkey \r\n  FOREIGN KEY (profile_id) REFERENCES public.\\"rbhc-table-profiles\\"(id) ON DELETE CASCADE","ALTER TABLE public.orders \r\n  ADD CONSTRAINT orders_profile_id_fkey \r\n  FOREIGN KEY (profile_id) REFERENCES public.\\"rbhc-table-profiles\\"(id) ON DELETE CASCADE","-- B) Re-create Policies (Using the profile_id -> user_id hop)\r\nCREATE POLICY \\"Users can view their own subscription\\" ON public.subscriptions\r\n  FOR SELECT USING (\r\n    profile_id IN (SELECT id FROM public.\\"rbhc-table-profiles\\" WHERE user_id = auth.uid())\r\n  )","CREATE POLICY \\"Users can view their own orders\\" ON public.orders\r\n  FOR SELECT USING (\r\n    profile_id IN (SELECT id FROM public.\\"rbhc-table-profiles\\" WHERE user_id = auth.uid())\r\n  )","CREATE POLICY \\"Users can view order items for their orders\\" ON public.order_items\r\n  FOR SELECT USING (\r\n    order_id IN (\r\n      SELECT id FROM public.orders \r\n      WHERE profile_id IN (SELECT id FROM public.\\"rbhc-table-profiles\\" WHERE user_id = auth.uid())\r\n    )\r\n  )","-- 6. UPDATE TRIGGER FUNCTIONS\r\n\r\n-- Trigger for Auth -> Profiles (Linker)\r\nCREATE OR REPLACE FUNCTION public.handle_new_user() RETURNS trigger\r\n    LANGUAGE plpgsql SECURITY DEFINER AS $$\r\nBEGIN\r\n  INSERT INTO public.\\"rbhc-table-profiles\\" (user_id, email)\r\n  VALUES (new.id, new.email)\r\n  ON CONFLICT (email) DO UPDATE\r\n  SET user_id = excluded.user_id\r\n  WHERE public.\\"rbhc-table-profiles\\".user_id IS NULL;\r\n  RETURN new;\r\nEND;\r\n$$","-- Trigger for Profiles -> Subscriptions (Auto-onboard)\r\nCREATE OR REPLACE FUNCTION public.create_subscription_for_new_profile() RETURNS trigger\r\n    LANGUAGE plpgsql SECURITY DEFINER AS $$\r\nDECLARE\r\n  free_tier_id BIGINT;\r\nBEGIN\r\n  SELECT id INTO free_tier_id FROM public.subscription_tiers WHERE LOWER(name) = 'free' LIMIT 1;\r\n  \r\n  INSERT INTO public.subscriptions (profile_id, tier_id, billing_cycle, status)\r\n  VALUES (NEW.id, free_tier_id, 1, 'active');\r\n  \r\n  RETURN NEW;\r\nEND;\r\n$$","-- Final Trigger Attachments\r\nDROP TRIGGER IF EXISTS on_profile_created_assign_sub ON public.\\"rbhc-table-profiles\\"","CREATE TRIGGER on_profile_created_assign_sub\r\n  AFTER INSERT ON public.\\"rbhc-table-profiles\\"\r\n  FOR EACH ROW EXECUTE FUNCTION public.create_subscription_for_new_profile()",COMMIT}	decouple_auth_and_profile
20260208134004	{BEGIN,"-- 1. REFINED PROFILE INSERT TRIGGER (Handling Duplicates)\r\n-- This logic ensures that if an email exists, we don't overwrite it if they are already an Auth user.\r\nCREATE OR REPLACE FUNCTION public.handle_profile_insert_logic() \r\nRETURNS TRIGGER AS $$\r\nBEGIN\r\n  -- If the email exists and already has a user_id, it means they are a registered Auth user.\r\n  -- We prevent the frontend from overwriting this record.\r\n  IF EXISTS (\r\n    SELECT 1 FROM public.\\"rbhc-table-profiles\\" \r\n    WHERE email = NEW.email AND user_id IS NOT NULL\r\n  ) THEN\r\n    RAISE EXCEPTION 'ALREADY_REGISTERED';\r\n  END IF;\r\n\r\n  RETURN NEW;\r\nEND;\r\n$$ LANGUAGE plpgsql","DROP TRIGGER IF EXISTS on_profile_insert_gatekeeper ON public.\\"rbhc-table-profiles\\"","CREATE TRIGGER on_profile_insert_gatekeeper\r\n  BEFORE INSERT ON public.\\"rbhc-table-profiles\\"\r\n  FOR EACH ROW EXECUTE FUNCTION public.handle_profile_insert_logic()","-- 2. BREVO SYNC TRIGGER (The Webhook Payload)\r\n-- This function gathers the Name, Email, and Tier from the related tables\r\nCREATE OR REPLACE FUNCTION public.get_brevo_payload() \r\nRETURNS TRIGGER AS $$\r\nDECLARE\r\n  payload JSONB;\r\nBEGIN\r\n  SELECT jsonb_build_object(\r\n    'email', p.email,\r\n    'first_name', p.first_name,\r\n    'tier', st.name,\r\n    'profile_id', p.id\r\n  ) INTO payload\r\n  FROM public.\\"rbhc-table-profiles\\" p\r\n  JOIN public.subscription_tiers st ON st.id = NEW.tier_id\r\n  WHERE p.id = NEW.profile_id;\r\n\r\n  -- Trigger the Edge Function via Supabase Webhook (configured in Dashboard)\r\n  -- Or manually using net.http_post if you have the extension enabled\r\n  RETURN NEW;\r\nEND;\r\n$$ LANGUAGE plpgsql","DROP TRIGGER IF EXISTS on_subscription_created_sync_brevo ON public.subscriptions","CREATE TRIGGER on_subscription_created_sync_brevo\r\n  AFTER INSERT OR UPDATE OF tier_id ON public.subscriptions\r\n  FOR EACH ROW EXECUTE FUNCTION public.get_brevo_payload()",COMMIT}	sync_logic_update
20260208135411	{"-- Update the sync function to fetch the Tier Name properly\r\nCREATE OR REPLACE FUNCTION public.sync_subscription_to_brevo() \r\nRETURNS trigger \r\nLANGUAGE plpgsql SECURITY DEFINER\r\nSET search_path TO 'public', 'extensions'\r\nAS $$\r\nDECLARE\r\n  res extensions.http_response;\r\n  response_json jsonb;\r\n  v_brevo_id text;\r\n  v_payload JSONB;\r\n  v_service_key TEXT;\r\nBEGIN\r\n  -- 1. Gather rich data (Email, Name, Tier Name)\r\n  SELECT jsonb_build_object(\r\n    'email', p.email,\r\n    'first_name', COALESCE(p.first_name, 'Friend'),\r\n    'tier', st.name\r\n  ) INTO v_payload\r\n  FROM public.\\"rbhc-table-profiles\\" p\r\n  JOIN public.subscription_tiers st ON st.id = NEW.tier_id\r\n  WHERE p.id = NEW.profile_id;\r\n\r\n  -- 2. Get service key from vault\r\n  SELECT decrypted_secret INTO v_service_key \r\n  FROM vault.decrypted_secrets \r\n  WHERE name = 'service_role_key';\r\n\r\n  -- 3. Call the Edge Function\r\n  res := extensions.http_post(\r\n    'https://your-project.supabase.co/functions/v1/sync-brevo',\r\n    v_payload::text,\r\n    'application/json',\r\n    ARRAY[extensions.http_header('Authorization', 'Bearer ' || v_service_key)]\r\n  );\r\n\r\n  -- 4. Parse response: only update if we got a NEW ID (Status 201)\r\n  IF res.status = 201 THEN\r\n    response_json := res.content::jsonb;\r\n    v_brevo_id := response_json->>'brevo_contact_id';\r\n\r\n    UPDATE public.\\"rbhc-table-profiles\\"\r\n    SET brevo_id = v_brevo_id,\r\n        last_synced = NOW()\r\n    WHERE id = NEW.profile_id;\r\n  END IF;\r\n\r\n  RETURN NEW;\r\nEND;\r\n$$","-- Apply trigger to subscriptions table\r\nDROP TRIGGER IF EXISTS on_subscription_created_sync ON public.subscriptions","CREATE TRIGGER on_subscription_created_sync\r\n  AFTER INSERT ON public.subscriptions\r\n  FOR EACH ROW EXECUTE FUNCTION public.sync_subscription_to_brevo()"}	update_triggers_use_subscriptions
20260208135907	{BEGIN,"-- 1. THE GATEKEEPER (For the Frontend Modal)\r\nCREATE OR REPLACE FUNCTION public.handle_profile_insert_gatekeeper() \r\nRETURNS TRIGGER AS $$\r\nBEGIN\r\n  -- If email exists and is already linked to an Auth User, block the insert\r\n  IF EXISTS (\r\n    SELECT 1 FROM public.\\"rbhc-table-profiles\\" \r\n    WHERE email = NEW.email AND user_id IS NOT NULL\r\n  ) THEN\r\n    RAISE EXCEPTION 'ALREADY_REGISTERED';\r\n  END IF;\r\n  RETURN NEW;\r\nEND;\r\n$$ LANGUAGE plpgsql","DROP TRIGGER IF EXISTS on_profile_insert_gatekeeper ON public.\\"rbhc-table-profiles\\"","CREATE TRIGGER on_profile_insert_gatekeeper\r\n  BEFORE INSERT ON public.\\"rbhc-table-profiles\\"\r\n  FOR EACH ROW EXECUTE FUNCTION public.handle_profile_insert_gatekeeper()","-- 2. THE BREVO SYNCER (Refactored to your exact logic)\r\nCREATE OR REPLACE FUNCTION public.sync_subscription_to_brevo() \r\nRETURNS trigger \r\nLANGUAGE plpgsql SECURITY DEFINER\r\nSET search_path TO 'public', 'extensions'\r\nAS $$\r\nDECLARE\r\n  res extensions.http_response;\r\n  response_json jsonb;\r\n  brevo_id text;\r\n  v_service_key TEXT;\r\n  v_email TEXT;\r\n  v_first_name TEXT;\r\n  v_tier_name TEXT;\r\nBEGIN\r\n  -- We need to fetch the Profile details because they aren't in the NEW subscription record\r\n  SELECT email, first_name INTO v_email, v_first_name\r\n  FROM public.\\"rbhc-table-profiles\\"\r\n  WHERE id = NEW.profile_id;\r\n\r\n  SELECT name INTO v_tier_name\r\n  FROM public.subscription_tiers\r\n  WHERE id = NEW.tier_id;\r\n\r\n  -- 1. Vault Secret Check (Your original logic)\r\n  SELECT decrypted_secret INTO v_service_key \r\n  FROM vault.decrypted_secrets \r\n  WHERE name = 'service_role_key';\r\n\r\n  IF v_service_key IS NULL THEN\r\n    RAISE LOG 'Vault secret service_role_key not found!';\r\n    RETURN NEW;\r\n  END IF;\r\n\r\n  -- 2. Call Edge Function (Your original syntax)\r\n  res := extensions.http(\r\n    (\r\n      'POST', \r\n      'https://roqwrtsmcisdxhgthpem.supabase.co/functions/v1/sync-brevo',\r\n      ARRAY[\r\n        extensions.http_header('Authorization', 'Bearer ' || v_service_key),\r\n        extensions.http_header('Content-Type', 'application/json')\r\n      ],\r\n      'application/json',\r\n      json_build_object(\r\n        'email', v_email,\r\n        'tier', COALESCE(v_tier_name, 'OOPS'),\r\n        'first_name', COALESCE(v_first_name, 'Friend')\r\n      )::text\r\n    )::extensions.http_request\r\n  );\r\n\r\n  -- 3. Parse and Update (Only if ID is returned, prevents loops)\r\n  response_json := res.content::jsonb;\r\n  brevo_id := response_json->>'brevo_contact_id';\r\n\r\n  IF brevo_id IS NOT NULL THEN\r\n    UPDATE public.\\"rbhc-table-profiles\\"\r\n    SET brevo_id = brevo_id, -- Matches your schema's column name\r\n        last_synced = NOW()\r\n    WHERE id = NEW.profile_id;\r\n  END IF;\r\n\r\n  RETURN NEW;\r\nEND;\r\n$$","-- 3. RE-ATTACH TRIGGER\r\nDROP TRIGGER IF EXISTS on_subscription_created_sync ON public.subscriptions","CREATE TRIGGER on_subscription_created_sync\r\n  AFTER INSERT OR UPDATE OF tier_id ON public.subscriptions\r\n  FOR EACH ROW EXECUTE FUNCTION public.sync_subscription_to_brevo()",COMMIT}	fix_dbfunction_use_subscriptions
20260208140428	{BEGIN,"-- 1. DROP ALL TRIGGERS ON ALL TABLES\r\n-- This unlocks the functions so they can be deleted.\r\n\r\n-- From Profiles Table\r\nDROP TRIGGER IF EXISTS on_profile_upsert ON public.\\"rbhc-table-profiles\\"","DROP TRIGGER IF EXISTS trigger_brevo_sync ON public.\\"rbhc-table-profiles\\"","DROP TRIGGER IF EXISTS on_profile_update_sync ON public.\\"rbhc-table-profiles\\"","DROP TRIGGER IF EXISTS on_lead_created_create_subscription ON public.\\"rbhc-table-profiles\\"","DROP TRIGGER IF EXISTS on_profile_create_or_update_subscription ON public.\\"rbhc-table-profiles\\"","DROP TRIGGER IF EXISTS on_profile_insert_gatekeeper ON public.\\"rbhc-table-profiles\\"","DROP TRIGGER IF EXISTS on_profile_created_assign_sub ON public.\\"rbhc-table-profiles\\"","-- From Subscriptions Table\r\nDROP TRIGGER IF EXISTS on_subscription_created_sync_brevo ON public.subscriptions","DROP TRIGGER IF EXISTS on_subscription_created_sync ON public.subscriptions","-- From Auth Users Table\r\nDROP TRIGGER IF EXISTS on_auth_user_created ON auth.users","-- 2. DROP THE STALE FUNCTIONS\r\n-- Now that the links are cut, these will delete cleanly.\r\n\r\nDROP FUNCTION IF EXISTS public.call_brevo_sync()","DROP FUNCTION IF EXISTS public.get_brevo_payload()","DROP FUNCTION IF EXISTS public.create_subscription_for_email_lead()","DROP FUNCTION IF EXISTS public.create_subscription_for_new_user()","DROP FUNCTION IF EXISTS public.handle_profile_insert_logic()","-- 3. RE-ESTABLISH ONLY THE CURRENT LOGIC\r\n-- This puts back the triggers required for your Modal and your Sync.\r\n\r\n-- A) Trigger for assigning Free Subscription when a profile is created\r\nCREATE TRIGGER on_profile_created_assign_sub\r\n  AFTER INSERT ON public.\\"rbhc-table-profiles\\"\r\n  FOR EACH ROW EXECUTE FUNCTION public.create_subscription_for_new_profile()","-- B) Trigger for blocking Modal from overwriting Auth users\r\nCREATE TRIGGER on_profile_insert_gatekeeper\r\n  BEFORE INSERT ON public.\\"rbhc-table-profiles\\"\r\n  FOR EACH ROW EXECUTE FUNCTION public.handle_profile_insert_gatekeeper()","-- C) Trigger for syncing to Brevo when the subscription is created\r\nCREATE TRIGGER on_subscription_created_sync\r\n  AFTER INSERT OR UPDATE OF tier_id ON public.subscriptions\r\n  FOR EACH ROW EXECUTE FUNCTION public.sync_subscription_to_brevo()",COMMIT}	remove_old_triggers_functions
20260208141306	{BEGIN,"CREATE OR REPLACE FUNCTION public.sync_subscription_to_brevo() \r\nRETURNS trigger \r\nLANGUAGE plpgsql SECURITY DEFINER\r\nSET search_path TO 'public', 'extensions'\r\nAS $$\r\nDECLARE\r\n  res extensions.http_response;\r\n  response_json jsonb;\r\n  brevo_id text;\r\n  v_service_key TEXT;\r\n  v_email TEXT;\r\n  v_first_name TEXT;\r\n  v_tier_name TEXT;\r\nBEGIN\r\n  -- 1. Gather Profile and Tier details\r\n  SELECT email, first_name INTO v_email, v_first_name\r\n  FROM public.\\"rbhc-table-profiles\\"\r\n  WHERE id = NEW.profile_id;\r\n\r\n  SELECT name INTO v_tier_name\r\n  FROM public.subscription_tiers\r\n  WHERE id = NEW.tier_id;\r\n\r\n  -- 2. Vault Secret Check\r\n  SELECT decrypted_secret INTO v_service_key \r\n  FROM vault.decrypted_secrets \r\n  WHERE name = 'service_role_key';\r\n\r\n  IF v_service_key IS NULL THEN\r\n    RAISE LOG 'Vault secret service_role_key not found!';\r\n    RETURN NEW;\r\n  END IF;\r\n\r\n  -- 3. Call Edge Function (Updated Path to sync-brevo-contact)\r\n  res := extensions.http(\r\n    (\r\n      'POST', \r\n      'https://roqwrtsmcisdxhgthpem.supabase.co/functions/v1/sync-brevo-contact',\r\n      ARRAY[\r\n        extensions.http_header('Authorization', 'Bearer ' || v_service_key),\r\n        extensions.http_header('Content-Type', 'application/json')\r\n      ],\r\n      'application/json',\r\n      json_build_object(\r\n        'email', v_email,\r\n        'tier', COALESCE(v_tier_name, 'Free'),\r\n        'first_name', COALESCE(v_first_name, 'Friend')\r\n      )::text\r\n    )::extensions.http_request\r\n  );\r\n\r\n  -- 4. Parse response\r\n  -- Note: We only update if we get a brevo_contact_id back (Status 201)\r\n  IF res.status = 201 THEN\r\n    response_json := res.content::jsonb;\r\n    brevo_id := response_json->>'brevo_contact_id';\r\n\r\n    IF brevo_id IS NOT NULL THEN\r\n      UPDATE public.\\"rbhc-table-profiles\\"\r\n      SET brevo_id = brevo_id,\r\n          last_synced = NOW()\r\n      WHERE id = NEW.profile_id;\r\n    END IF;\r\n  END IF;\r\n\r\n  RETURN NEW;\r\nEND;\r\n$$",COMMIT}	sync_subscription_to_brevo
20260208142201	{BEGIN,"-- We update the function to map the Brevo ID to the correct column: brevo_contact_id\r\nCREATE OR REPLACE FUNCTION public.sync_subscription_to_brevo() \r\nRETURNS trigger \r\nLANGUAGE plpgsql SECURITY DEFINER\r\nSET search_path TO 'public', 'extensions'\r\nAS $$\r\nDECLARE\r\n  res extensions.http_response;\r\n  response_json jsonb;\r\n  v_brevo_id text;\r\n  v_service_key TEXT;\r\n  v_email TEXT;\r\n  v_first_name TEXT;\r\n  v_tier_name TEXT;\r\nBEGIN\r\n  -- 1. Gather Profile and Tier details\r\n  SELECT email, first_name INTO v_email, v_first_name\r\n  FROM public.\\"rbhc-table-profiles\\"\r\n  WHERE id = NEW.profile_id;\r\n\r\n  SELECT name INTO v_tier_name\r\n  FROM public.subscription_tiers\r\n  WHERE id = NEW.tier_id;\r\n\r\n  -- 2. Vault Secret Check\r\n  SELECT decrypted_secret INTO v_service_key \r\n  FROM vault.decrypted_secrets \r\n  WHERE name = 'service_role_key';\r\n\r\n  IF v_service_key IS NULL THEN\r\n    RAISE LOG 'Vault secret service_role_key not found!';\r\n    RETURN NEW;\r\n  END IF;\r\n\r\n  -- 3. Call Edge Function (Ensuring correct URL)\r\n  res := extensions.http(\r\n    (\r\n      'POST', \r\n      'https://roqwrtsmcisdxhgthpem.supabase.co/functions/v1/sync-brevo-contact',\r\n      ARRAY[\r\n        extensions.http_header('Authorization', 'Bearer ' || v_service_key),\r\n        extensions.http_header('Content-Type', 'application/json')\r\n      ],\r\n      'application/json',\r\n      json_build_object(\r\n        'email', v_email,\r\n        'tier', COALESCE(v_tier_name, 'Free'),\r\n        'first_name', COALESCE(v_first_name, 'Friend')\r\n      )::text\r\n    )::extensions.http_request\r\n  );\r\n\r\n  -- 4. Parse response and update the CORRECT column\r\n  -- Only update on 201 (New Contact Created)\r\n  IF res.status = 201 THEN\r\n    response_json := res.content::jsonb;\r\n    v_brevo_id := response_json->>'brevo_contact_id';\r\n\r\n    IF v_brevo_id IS NOT NULL THEN\r\n      UPDATE public.\\"rbhc-table-profiles\\"\r\n      SET brevo_contact_id = v_brevo_id,  -- Correct column name\r\n          last_synced = NOW()\r\n      WHERE id = NEW.profile_id;\r\n    END IF;\r\n  END IF;\r\n\r\n  RETURN NEW;\r\nEND;\r\n$$",COMMIT}	sync_subscription_to_brevo2
20260208201908	{BEGIN,"-- 1. Update the function to handle both \\"Linking\\" and \\"Creating\\"\r\nCREATE OR REPLACE FUNCTION public.handle_new_user()\r\nRETURNS trigger\r\nLANGUAGE plpgsql\r\nSECURITY DEFINER \r\nSET search_path = public\r\nAS $$\r\nBEGIN\r\n  -- SCENARIO 1: The user already exists in profiles (from the email modal)\r\n  -- We just update their record with the new Auth UUID.\r\n  IF EXISTS (SELECT 1 FROM public.\\"rbhc-table-profiles\\" WHERE email = NEW.email) THEN\r\n    UPDATE public.\\"rbhc-table-profiles\\"\r\n    SET \r\n      user_id = NEW.id,\r\n      -- If they didn't have a name yet, take it from auth metadata if available\r\n      first_name = COALESCE(first_name, NEW.raw_user_meta_data->>'first_name')\r\n    WHERE email = NEW.email;\r\n    \r\n  -- SCENARIO 2: Brand new user (Direct Signup)\r\n  -- We create a fresh profile row for them.\r\n  ELSE\r\n    INSERT INTO public.\\"rbhc-table-profiles\\" (user_id, email, first_name)\r\n    VALUES (\r\n      NEW.id,\r\n      NEW.email,\r\n      NEW.raw_user_meta_data->>'first_name'\r\n    );\r\n  END IF;\r\n\r\n  RETURN NEW;\r\nEND;\r\n$$","-- 2. Re-attach the trigger to the Auth table\r\nDROP TRIGGER IF EXISTS on_auth_user_created ON auth.users","CREATE TRIGGER on_auth_user_created\r\n  AFTER INSERT ON auth.users\r\n  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user()",COMMIT}	fixup_modal_vs_direct_signup
20260208202157	{BEGIN,"-- 1. Drop the old trigger so we can remove the old function name\r\nDROP TRIGGER IF EXISTS on_auth_user_created ON auth.users","-- 2. Drop the old function name\r\nDROP FUNCTION IF EXISTS public.handle_new_user()","-- 3. Create the function with the new name: handle_new_auth_user\r\nCREATE OR REPLACE FUNCTION public.handle_new_auth_user()\r\nRETURNS trigger\r\nLANGUAGE plpgsql\r\nSECURITY DEFINER \r\nSET search_path = public\r\nAS $$\r\nBEGIN\r\n  -- Check if a profile with this email already exists (Lead-to-Customer flow)\r\n  IF EXISTS (SELECT 1 FROM public.\\"rbhc-table-profiles\\" WHERE email = NEW.email) THEN\r\n    UPDATE public.\\"rbhc-table-profiles\\"\r\n    SET \r\n      user_id = NEW.id,\r\n      -- Fill in name from metadata if it was missing in the lead row\r\n      first_name = COALESCE(first_name, NEW.raw_user_meta_data->>'first_name')\r\n    WHERE email = NEW.email;\r\n    \r\n  -- Create new profile if they didn't exist (Direct Signup flow)\r\n  ELSE\r\n    INSERT INTO public.\\"rbhc-table-profiles\\" (user_id, email, first_name)\r\n    VALUES (\r\n      NEW.id,\r\n      NEW.email,\r\n      NEW.raw_user_meta_data->>'first_name'\r\n    );\r\n  END IF;\r\n\r\n  RETURN NEW;\r\nEND;\r\n$$","-- 4. Re-attach the trigger using the NEW function name\r\nCREATE TRIGGER on_auth_user_created\r\n  AFTER INSERT ON auth.users\r\n  FOR EACH ROW EXECUTE FUNCTION public.handle_new_auth_user()",COMMIT}	rename_function_for_authusercreated
20260208221520	{"-- 1. THE FUNCTION (Lives in 'public' to interact with your profiles)\r\nCREATE OR REPLACE FUNCTION public.handle_new_auth_user()\r\nRETURNS TRIGGER AS $$\r\nBEGIN\r\n  IF EXISTS (SELECT 1 FROM public.\\"rbhc-table-profiles\\" WHERE email = NEW.email) THEN\r\n    UPDATE public.\\"rbhc-table-profiles\\"\r\n    SET \r\n      user_id = NEW.id,\r\n      first_name = COALESCE(\r\n        first_name, \r\n        NEW.raw_user_meta_data->>'given_name',\r\n        NEW.raw_user_meta_data->>'first_name',\r\n        'Friend'\r\n      )\r\n    WHERE email = NEW.email;\r\n  ELSE\r\n    INSERT INTO public.\\"rbhc-table-profiles\\" (user_id, email, first_name)\r\n    VALUES (\r\n      NEW.id,\r\n      NEW.email,\r\n      COALESCE(\r\n        NEW.raw_user_meta_data->>'given_name',\r\n        NEW.raw_user_meta_data->>'first_name',\r\n        'Friend'\r\n      )\r\n    );\r\n  END IF;\r\n  RETURN NEW;\r\nEND;\r\n$$ LANGUAGE plpgsql SECURITY DEFINER","-- 2. THE TRIGGER (Targets the 'auth' schema)\r\n-- We explicitly use the schema prefix 'auth.' before the table name 'users'\r\nDROP TRIGGER IF EXISTS on_auth_user_created ON auth.users","CREATE TRIGGER on_auth_user_created\r\n  AFTER INSERT ON auth.users -- <--- This 'auth.' prefix is what dictates the schema\r\n  FOR EACH ROW EXECUTE FUNCTION public.handle_new_auth_user()"}	fix_handle_new_auth_user_forfirstnames
20260208222909	{"-- 1. Update the function to catch more Google metadata keys\r\nCREATE OR REPLACE FUNCTION public.handle_new_auth_user()\r\nRETURNS TRIGGER AS $$\r\nBEGIN\r\n  IF EXISTS (SELECT 1 FROM public.\\"rbhc-table-profiles\\" WHERE email = NEW.email) THEN\r\n    UPDATE public.\\"rbhc-table-profiles\\"\r\n    SET \r\n      user_id = NEW.id,\r\n      first_name = COALESCE(\r\n        first_name, \r\n        NEW.raw_user_meta_data->>'first_name', -- Manual Signup\r\n        NEW.raw_user_meta_data->>'given_name', -- Google Standard\r\n        NEW.raw_user_meta_data->>'full_name',  -- Google Fallback\r\n        NEW.raw_user_meta_data->>'name',       -- Generic Fallback\r\n        'Friend'\r\n      )\r\n    WHERE email = NEW.email;\r\n  ELSE\r\n    INSERT INTO public.\\"rbhc-table-profiles\\" (user_id, email, first_name)\r\n    VALUES (\r\n      NEW.id,\r\n      NEW.email,\r\n      COALESCE(\r\n        NEW.raw_user_meta_data->>'first_name',\r\n        NEW.raw_user_meta_data->>'given_name',\r\n        NEW.raw_user_meta_data->>'full_name',\r\n        NEW.raw_user_meta_data->>'name',\r\n        'Friend'\r\n      )\r\n    );\r\n  END IF;\r\n  RETURN NEW;\r\nEND;\r\n$$ LANGUAGE plpgsql SECURITY DEFINER","-- 2. Add the missing column that your Dashboard is trying to save\r\nALTER TABLE public.\\"rbhc-table-profiles\\" \r\nADD COLUMN IF NOT EXISTS merch_preferences text[] DEFAULT '{}'","-- 3. Add the missing UPDATE policy so users can save their profile\r\nCREATE POLICY \\"Users can update their own profile\\" \r\nON public.\\"rbhc-table-profiles\\" \r\nFOR UPDATE \r\nTO authenticated \r\nUSING (auth.uid() = user_id) \r\nWITH CHECK (auth.uid() = user_id)"}	schema_updates_for_dashboard
20260208225000	{"CREATE OR REPLACE FUNCTION public.handle_new_auth_user() RETURNS trigger\r\n    LANGUAGE plpgsql SECURITY DEFINER\r\n    SET search_path TO 'public'\r\n    AS $$\r\nBEGIN\r\n  IF EXISTS (SELECT 1 FROM public.\\"rbhc-table-profiles\\" WHERE email = NEW.email) THEN\r\n    UPDATE public.\\"rbhc-table-profiles\\"\r\n    SET \r\n      user_id = NEW.id,\r\n      -- Extract first word from full_name if first_name is missing\r\n      first_name = COALESCE(\r\n        first_name, \r\n        NEW.raw_user_meta_data->>'first_name',\r\n        split_part(NEW.raw_user_meta_data->>'full_name', ' ', 1),\r\n        split_part(NEW.raw_user_meta_data->>'name', ' ', 1)\r\n      )\r\n    WHERE email = NEW.email;\r\n  ELSE\r\n    INSERT INTO public.\\"rbhc-table-profiles\\" (user_id, email, first_name)\r\n    VALUES (\r\n      NEW.id,\r\n      NEW.email,\r\n      COALESCE(\r\n        NEW.raw_user_meta_data->>'first_name',\r\n        split_part(NEW.raw_user_meta_data->>'full_name', ' ', 1),\r\n        split_part(NEW.raw_user_meta_data->>'name', ' ', 1)\r\n      )\r\n    );\r\n  END IF;\r\n  RETURN NEW;\r\nEND;\r\n$$"}	fixup_first_name_handler
20260208225135	{"-- Create the function to sync profile changes\r\nCREATE OR REPLACE FUNCTION public.sync_profile_to_brevo() RETURNS trigger\r\n    LANGUAGE plpgsql SECURITY DEFINER\r\n    SET search_path TO 'public', 'extensions'\r\n    AS $$\r\nBEGIN\r\n  -- LOOP PREVENTION: Only trigger if the name actually changed\r\n  IF (OLD.first_name IS DISTINCT FROM NEW.first_name) THEN\r\n    -- We reuse your existing logic but fetch the current tier first\r\n    DECLARE\r\n      v_tier_name TEXT;\r\n      v_service_key TEXT;\r\n    BEGIN\r\n      SELECT t.name INTO v_tier_name\r\n      FROM public.subscriptions s\r\n      JOIN public.subscription_tiers t ON s.tier_id = t.id\r\n      WHERE s.profile_id = NEW.id\r\n      LIMIT 1;\r\n\r\n      SELECT decrypted_secret INTO v_service_key \r\n      FROM vault.decrypted_secrets WHERE name = 'service_role_key';\r\n\r\n      PERFORM extensions.http_post(\r\n        'https://roqwrtsmcisdxhgthpem.supabase.co/functions/v1/sync-brevo-contact',\r\n        json_build_object(\r\n          'email', NEW.email,\r\n          'tier', COALESCE(v_tier_name, 'free'),\r\n          'first_name', NEW.first_name\r\n        )::jsonb,\r\n        headers := jsonb_build_object(\r\n          'Authorization', 'Bearer ' || v_service_key,\r\n          'Content-Type', 'application/json'\r\n        )\r\n      );\r\n    END;\r\n  END IF;\r\n  RETURN NEW;\r\nEND;\r\n$$","-- Attach the trigger to the profiles table\r\nCREATE TRIGGER on_profile_update_sync_brevo\r\n  AFTER UPDATE ON public.\\"rbhc-table-profiles\\"\r\n  FOR EACH ROW\r\n  EXECUTE FUNCTION public.sync_profile_to_brevo()"}	fixup_onupdate_rbhc_tosendnewfirstnametobrevo
20260208230224	{"-- 1. Ensure required extensions and schemas are accessible\r\nCREATE SCHEMA IF NOT EXISTS extensions","GRANT USAGE ON SCHEMA extensions TO postgres, authenticated, service_role","-- 2. Update Auth Signup Trigger (Handles Google/OAuth names)\r\n-- Extracts only the first word from the name provided by the provider\r\nCREATE OR REPLACE FUNCTION public.handle_new_auth_user() RETURNS trigger\r\n    LANGUAGE plpgsql SECURITY DEFINER\r\n    SET search_path TO 'public'\r\n    AS $$\r\nBEGIN\r\n  IF EXISTS (SELECT 1 FROM public.\\"rbhc-table-profiles\\" WHERE email = NEW.email) THEN\r\n    UPDATE public.\\"rbhc-table-profiles\\"\r\n    SET \r\n      user_id = NEW.id,\r\n      first_name = COALESCE(\r\n        first_name, \r\n        NEW.raw_user_meta_data->>'first_name',\r\n        split_part(NEW.raw_user_meta_data->>'full_name', ' ', 1),\r\n        split_part(NEW.raw_user_meta_data->>'name', ' ', 1),\r\n        'Friend'\r\n      )\r\n    WHERE email = NEW.email;\r\n  ELSE\r\n    INSERT INTO public.\\"rbhc-table-profiles\\" (user_id, email, first_name)\r\n    VALUES (\r\n      NEW.id,\r\n      NEW.email,\r\n      COALESCE(\r\n        NEW.raw_user_meta_data->>'first_name',\r\n        split_part(NEW.raw_user_meta_data->>'full_name', ' ', 1),\r\n        split_part(NEW.raw_user_meta_data->>'name', ' ', 1),\r\n        'Friend'\r\n      )\r\n    );\r\n  END IF;\r\n  RETURN NEW;\r\nEND;\r\n$$","-- 3. Brevo Sync Function (Logic & Edge Function Call)\r\n-- This includes loop prevention via the \\"IS DISTINCT FROM\\" check\r\nCREATE OR REPLACE FUNCTION public.sync_profile_to_brevo() RETURNS trigger\r\n    LANGUAGE plpgsql SECURITY DEFINER\r\n    SET search_path TO 'public', 'extensions', 'vault'\r\n    AS $$\r\nDECLARE\r\n  v_tier_name TEXT;\r\n  v_service_key TEXT;\r\nBEGIN\r\n  -- LOOP PREVENTION: Only trigger if the first_name actually changed\r\n  IF (OLD.first_name IS DISTINCT FROM NEW.first_name) THEN\r\n    \r\n    -- Fetch current subscription tier name\r\n    SELECT t.name INTO v_tier_name\r\n    FROM public.subscriptions s\r\n    JOIN public.subscription_tiers t ON s.tier_id = t.id\r\n    WHERE s.profile_id = NEW.id\r\n    LIMIT 1;\r\n\r\n    -- Fetch Service Role Key for Authorization\r\n    SELECT decrypted_secret INTO v_service_key \r\n    FROM vault.decrypted_secrets WHERE name = 'service_role_key';\r\n\r\n    -- Call Edge Function\r\n    PERFORM extensions.http_post(\r\n      'https://roqwrtsmcisdxhgthpem.supabase.co/functions/v1/sync-brevo-contact',\r\n      json_build_object(\r\n        'email', NEW.email,\r\n        'tier', COALESCE(v_tier_name, 'free'),\r\n        'first_name', NEW.first_name\r\n      )::jsonb,\r\n      headers := jsonb_build_object(\r\n        'Authorization', 'Bearer ' || v_service_key,\r\n        'Content-Type', 'application/json'\r\n      )\r\n    );\r\n  END IF;\r\n  RETURN NEW;\r\nEND;\r\n$$","-- 4. Re-attach Triggers\r\nDROP TRIGGER IF EXISTS on_profile_update_sync_brevo ON public.\\"rbhc-table-profiles\\"","CREATE TRIGGER on_profile_update_sync_brevo\r\n  AFTER UPDATE ON public.\\"rbhc-table-profiles\\"\r\n  FOR EACH ROW\r\n  EXECUTE FUNCTION public.sync_profile_to_brevo()","-- 5. Fix Permissions (Crucial to prevent 404/403 errors during update)\r\nGRANT USAGE ON SCHEMA vault TO postgres","GRANT SELECT ON vault.decrypted_secrets TO postgres"}	update_profile_logic_and_sync
20260209221441	{"CREATE OR REPLACE FUNCTION public.create_subscription_for_new_profile()\r\n RETURNS trigger\r\n LANGUAGE plpgsql\r\n SECURITY DEFINER\r\n -- This line fixes the warning\r\n SET search_path TO 'public', 'extensions'\r\nAS $$\r\nBEGIN\r\n  INSERT INTO public.subscriptions (profile_id, tier_id, status)\r\n  VALUES (NEW.id, 1, 'active');\r\n  RETURN NEW;\r\nEND;\r\n$$"}	searc_space_add
20260209221511	{"CREATE OR REPLACE FUNCTION public.handle_profile_insert_gatekeeper()\r\n RETURNS trigger\r\n LANGUAGE plpgsql\r\n SECURITY DEFINER\r\n -- This line fixes the warning\r\n SET search_path TO 'public'\r\nAS $$\r\nBEGIN\r\n  -- If user_id is null, it means it's a pre-sign-up entry (like an email capture)\r\n  -- We allow these to proceed.\r\n  IF NEW.user_id IS NULL THEN\r\n    RETURN NEW;\r\n  END IF;\r\n\r\n  -- If user_id is NOT null, it's an auth-linked profile. \r\n  -- We check if a profile already exists for this email.\r\n  IF EXISTS (\r\n    SELECT 1 FROM public.\\"rbhc-table-profiles\\" \r\n    WHERE email = NEW.email AND user_id IS NULL\r\n  ) THEN\r\n    -- If an orphan profile exists, we update it instead of inserting a new one\r\n    UPDATE public.\\"rbhc-table-profiles\\"\r\n    SET user_id = NEW.user_id,\r\n        first_name = COALESCE(NEW.first_name, first_name)\r\n    WHERE email = NEW.email AND user_id IS NULL;\r\n    RETURN NULL; -- Cancel the insert because we handled it via update\r\n  END IF;\r\n\r\n  RETURN NEW;\r\nEND;\r\n$$"}	search_space_add_2
20260209221755	{"CREATE OR REPLACE FUNCTION public.sync_profile_to_brevo()\r\n RETURNS trigger\r\n LANGUAGE plpgsql\r\n SECURITY DEFINER\r\n -- Fixes the security warning and ensures extensions are found\r\n SET search_path TO 'public', 'extensions', 'vault'\r\n AS $$\r\nDECLARE\r\n  res extensions.http_response;\r\n  response_json jsonb;\r\n  v_brevo_id text;\r\n  v_service_key TEXT;\r\n  v_email TEXT;\r\n  v_first_name TEXT;\r\n  v_tier_name TEXT;\r\nBEGIN\r\n  -- 1. Gather Profile and Tier details\r\n  -- NOTE: Based on your code, this trigger likely runs on a 'subscriptions' table\r\n  -- since it uses NEW.profile_id and NEW.tier_id\r\n  SELECT email, first_name INTO v_email, v_first_name\r\n  FROM public.\\"rbhc-table-profiles\\"\r\n  WHERE id = NEW.profile_id;\r\n\r\n  SELECT name INTO v_tier_name\r\n  FROM public.subscription_tiers\r\n  WHERE id = NEW.tier_id;\r\n\r\n  -- 2. Vault Secret Check\r\n  SELECT decrypted_secret INTO v_service_key \r\n  FROM vault.decrypted_secrets \r\n  WHERE name = 'service_role_key';\r\n\r\n  IF v_service_key IS NULL THEN\r\n    RAISE LOG 'Vault secret service_role_key not found!';\r\n    RETURN NEW;\r\n  END IF;\r\n\r\n  -- 3. Call Edge Function (Ensuring correct URL)\r\n  res := extensions.http(\r\n    (\r\n      'POST', \r\n      'https://roqwrtsmcisdxhgthpem.supabase.co/functions/v1/sync-brevo-contact',\r\n      ARRAY[\r\n        extensions.http_header('Authorization', 'Bearer ' || v_service_key),\r\n        extensions.http_header('Content-Type', 'application/json')\r\n      ],\r\n      'application/json',\r\n      json_build_object(\r\n        'email', v_email,\r\n        'tier', COALESCE(v_tier_name, 'oops'),\r\n        'first_name', COALESCE(v_first_name, 'oops')\r\n      )::text\r\n    )::extensions.http_request\r\n  );\r\n\r\n  -- 4. Parse response and update the CORRECT column\r\n  IF res.status = 201 THEN\r\n    response_json := res.content::jsonb;\r\n    v_brevo_id := response_json->>'brevo_contact_id';\r\n\r\n    IF v_brevo_id IS NOT NULL THEN\r\n      -- Use a direct update that won't re-trigger itself infinitely\r\n      UPDATE public.\\"rbhc-table-profiles\\"\r\n      SET brevo_contact_id = v_brevo_id,\r\n          last_synced = NOW()\r\n      WHERE id = NEW.profile_id;\r\n    END IF;\r\n  END IF;\r\n\r\n  RETURN NEW;\r\nEND;\r\n$$"}	security_fix_for_synctobrevo
20260209222041	{"-- 1. Optimized Policy for public.subscriptions\r\nDROP POLICY IF EXISTS \\"Users can view their own subscription\\" ON public.subscriptions","CREATE POLICY \\"Users can view their own subscription\\" \r\nON public.subscriptions \r\nFOR SELECT \r\nTO authenticated \r\nUSING (profile_id IN (SELECT id FROM public.\\"rbhc-table-profiles\\" WHERE user_id = (SELECT auth.uid())))","-- 2. Optimized Policy for public.orders\r\nDROP POLICY IF EXISTS \\"Users can view their own orders\\" ON public.orders","CREATE POLICY \\"Users can view their own orders\\" \r\nON public.orders \r\nFOR SELECT \r\nTO authenticated \r\nUSING (profile_id IN (SELECT id FROM public.\\"rbhc-table-profiles\\" WHERE user_id = (SELECT auth.uid())))","-- 3. Optimized Policy for public.order_items\r\n-- This assumes order_items are linked via an order_id to the orders table\r\nDROP POLICY IF EXISTS \\"Users can view order items for their orders\\" ON public.order_items","CREATE POLICY \\"Users can view order items for their orders\\" \r\nON public.order_items \r\nFOR SELECT \r\nTO authenticated \r\nUSING (\r\n  order_id IN (\r\n    SELECT id FROM public.orders WHERE profile_id IN (\r\n      SELECT id FROM public.\\"rbhc-table-profiles\\" WHERE user_id = (SELECT auth.uid())\r\n    )\r\n  )\r\n)","-- 4. Optimized Policy for public.\\"rbhc-table-profiles\\"\r\n-- Specifically fixing the UPDATE policy mentioned in your log\r\nDROP POLICY IF EXISTS \\"Users can update their own profile\\" ON public.\\"rbhc-table-profiles\\"","CREATE POLICY \\"Users can update their own profile\\" \r\nON public.\\"rbhc-table-profiles\\" \r\nFOR UPDATE \r\nTO authenticated \r\nUSING (user_id = (SELECT auth.uid()))\r\nWITH CHECK (user_id = (SELECT auth.uid()))","-- Also optimize the SELECT policy for profiles while we are at it\r\nDROP POLICY IF EXISTS \\"Users can view own profile\\" ON public.\\"rbhc-table-profiles\\"","CREATE POLICY \\"Users can view own profile\\" \r\nON public.\\"rbhc-table-profiles\\" \r\nFOR SELECT \r\nTO authenticated \r\nUSING (user_id = (SELECT auth.uid()))"}	RLS_performance_updates
20260209224350	{"-- 1. Hardened Sync Function with logic for partial updates (Name, Email, or Both)\r\nCREATE OR REPLACE FUNCTION public.sync_profile_to_brevo()\r\n RETURNS trigger\r\n LANGUAGE plpgsql\r\n SECURITY DEFINER\r\n SET search_path TO 'public', 'extensions', 'vault'\r\n AS $$\r\nDECLARE\r\n  res extensions.http_response;\r\n  v_service_key TEXT;\r\n  v_tier_name TEXT;\r\nBEGIN\r\n  -- LOOP & RECURSION PREVENTION\r\n  -- This check ensures we ONLY ping Brevo if the core identity data changed.\r\n  -- If only 'last_synced' or 'merch_preferences' changed, this returns immediately.\r\n  IF (OLD.first_name IS NOT DISTINCT FROM NEW.first_name) AND \r\n     (OLD.email IS NOT DISTINCT FROM NEW.email) THEN\r\n    RETURN NEW;\r\n  END IF;\r\n\r\n  -- DATA MAPPING\r\n  -- Find the subscription tier using the profile's primary key (id)\r\n  SELECT t.name INTO v_tier_name\r\n  FROM public.subscriptions s\r\n  JOIN public.subscription_tiers t ON s.tier_id = t.id\r\n  WHERE s.profile_id = NEW.id\r\n  LIMIT 1;\r\n\r\n  -- AUTHORIZATION\r\n  SELECT decrypted_secret INTO v_service_key \r\n  FROM vault.decrypted_secrets \r\n  WHERE name = 'service_role_key';\r\n\r\n  IF v_service_key IS NULL THEN\r\n    RAISE LOG 'Brevo Sync Failed: service_role_key not found in Vault';\r\n    RETURN NEW;\r\n  END IF;\r\n\r\n  -- EXTERNAL SYNC\r\n  -- Using the working extensions.http pattern\r\n  res := extensions.http(\r\n    (\r\n      'POST', \r\n      'https://roqwrtsmcisdxhgthpem.supabase.co/functions/v1/sync-brevo-contact',\r\n      ARRAY[\r\n        extensions.http_header('Authorization', 'Bearer ' || v_service_key),\r\n        extensions.http_header('Content-Type', 'application/json')\r\n      ],\r\n      'application/json',\r\n      json_build_object(\r\n        'email', NEW.email,\r\n        'tier', COALESCE(v_tier_name, 'free'),\r\n        'first_name', COALESCE(NEW.first_name, 'Friend')\r\n      )::text\r\n    )::extensions.http_request\r\n  );\r\n\r\n  RETURN NEW;\r\nEND;\r\n$$","-- 2. Ensure Trigger is attached correctly to the Profile table\r\nDROP TRIGGER IF EXISTS on_profile_update_sync_brevo ON public.\\"rbhc-table-profiles\\"","CREATE TRIGGER on_profile_update_sync_brevo\r\n  AFTER UPDATE ON public.\\"rbhc-table-profiles\\"\r\n  FOR EACH ROW\r\n  EXECUTE FUNCTION public.sync_profile_to_brevo()"}	robust_profile_sync
20260209231528	{"DROP POLICY IF EXISTS \\"Allow insert for email-only subscribers\\" ON public.\\"rbhc-table-profiles\\"","CREATE POLICY \\"Allow onboarding submission\\" \r\nON public.\\"rbhc-table-profiles\\" \r\nFOR INSERT \r\nTO anon, authenticated \r\nWITH CHECK (\r\n  -- This allows the insert to reach the Trigger/Gatekeeper\r\n  -- where your logic will then decide to UPDATE, FAIL, or PROCEED.\r\n  true \r\n)"}	rls_updates_for_authuser
20260209231953	{"DROP POLICY IF EXISTS \\"Allow onboarding submission\\" ON public.\\"rbhc-table-profiles\\"","CREATE POLICY \\"Allow onboarding submission\\" \r\nON public.\\"rbhc-table-profiles\\" \r\nFOR INSERT \r\nTO anon, authenticated \r\nWITH CHECK (\r\n  -- We allow the insert if an email is provided. \r\n  -- Our Gatekeeper Trigger will handle the \\"is it a duplicate?\\" logic.\r\n  email IS NOT NULL \r\n)"}	rls_updates_for_authuser_2
\.


--
-- Data for Name: seed_files; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.seed_files (path, hash) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
abc46386-fb9a-48c1-9221-ab61f5a6f07c	service_role_key	Internal key for triggering Edge Functions	9bamYx/c3DpQxwuTFOVpDZ1wX33eCUKAKbE76XVWd8SGU+PEb5mVgrlkhj0csGvqDEuihsKY0Cl8\ngH4fFlD5qy7wjn9UjjBvUeoWlznh4QO/qjnGhfAUNRQsw4laNZpWqKJda9pHf+HJwxNLoNMpaIMJ\nrh4X8JCRgWNxQDfo8hHfzW++DEKRg7L1uX3Sp9RSyJZkMO9EZDjOvscl/6sWqQxc52KELdx0+Ktn\n3ABmfOT+8gjwAL2l63oRQRv2/sURjuN7Mu2LfrqhOz45GhshNep++77cYC4Ksv+iJy3pEMD/xLOh\nmeWYR9dBOBknc+HybnJtjNtCuH6MN1k=	\N	\\x074fbd3ae492c7be1e3ecbb16303fa6f	2026-02-06 00:36:45.115706+00	2026-02-06 00:42:29.789661+00
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 195, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 1, false);


--
-- Name: rbhc-table-profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."rbhc-table-profiles_id_seq"', 45, true);


--
-- Name: subscription_tiers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_tiers_id_seq', 4, true);


--
-- Name: subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscriptions_id_seq', 18, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

\unrestrict aeH5dchGIjHkv40c5MsQkzd5GBWFWEd8eE63eC1nFCCkTzYMfrPvJfeViqRPJdz

