--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: booking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking (
    booking_id character varying(10) NOT NULL,
    date date,
    status character(1) NOT NULL,
    "time" time without time zone NOT NULL,
    num_people integer NOT NULL,
    special_request character varying(100),
    create_at timestamp without time zone NOT NULL,
    update_at timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT booking_status_check CHECK ((status = ANY (ARRAY['0'::bpchar, '1'::bpchar, '2'::bpchar]))),
    CONSTRAINT booking_time_check CHECK ((("time" >= '05:00:00'::time without time zone) OR ("time" <= '02:00:00'::time without time zone)))
);


ALTER TABLE public.booking OWNER TO postgres;

--
-- Name: cart_dish; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_dish (
    cart_id character varying(10) NOT NULL,
    dish_id integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.cart_dish OWNER TO postgres;

--
-- Name: dish; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dish (
    dish_name character varying(50) NOT NULL,
    category character varying(20) NOT NULL,
    dish_id integer NOT NULL,
    price numeric(18,0) NOT NULL,
    description character varying(1000),
    created_at timestamp without time zone NOT NULL,
    availability boolean NOT NULL
);


ALTER TABLE public.dish OWNER TO postgres;

--
-- Name: order_dish; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_dish (
    order_id character varying(10) NOT NULL,
    dish_id integer NOT NULL,
    quantity integer
);


ALTER TABLE public.order_dish OWNER TO postgres;

--
-- Name: order_food; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_food (
    order_id character varying(10) NOT NULL,
    order_date date NOT NULL,
    status character(1) NOT NULL,
    total_amount numeric(18,0) NOT NULL,
    delivery_address character varying(100) NOT NULL,
    create_at timestamp without time zone NOT NULL,
    update_at timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT order_food_status_check CHECK ((status = ANY (ARRAY['0'::bpchar, '1'::bpchar, '2'::bpchar, '3'::bpchar, '4'::bpchar])))
);


ALTER TABLE public.order_food OWNER TO postgres;

--
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    payment_id character varying(10) NOT NULL,
    amount numeric(18,0) NOT NULL,
    payment_method character(1),
    payment_status character(1),
    payment_date timestamp without time zone NOT NULL,
    order_id character varying(10) NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT payment_payment_method_check CHECK ((payment_method = ANY (ARRAY['0'::bpchar, '1'::bpchar]))),
    CONSTRAINT payment_payment_status_check CHECK ((payment_status = ANY (ARRAY['0'::bpchar, '1'::bpchar, '2'::bpchar])))
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- Name: payment_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_order (
    payment_id character varying(10) NOT NULL,
    order_id character varying(10) NOT NULL
);


ALTER TABLE public.payment_order OWNER TO postgres;

--
-- Name: shopping_cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shopping_cart (
    cart_id character varying(10) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    update_at timestamp without time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.shopping_cart OWNER TO postgres;

--
-- Name: user_cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_cart (
    cart_id character varying(10) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.user_cart OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_name character varying(20) NOT NULL,
    gender character(1) NOT NULL,
    age integer NOT NULL,
    user_password character varying(20) NOT NULL,
    user_role character(1) NOT NULL,
    phone character varying(11) NOT NULL,
    acc_name character varying(10) NOT NULL,
    CONSTRAINT users_age_check CHECK (((age >= 18) AND (age <= 65))),
    CONSTRAINT users_gender_check CHECK ((gender = ANY (ARRAY['M'::bpchar, 'F'::bpchar]))),
    CONSTRAINT users_user_password_check CHECK (((length((user_password)::text) >= 8) AND (length((user_password)::text) <= 20)))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking (booking_id, date, status, "time", num_people, special_request, create_at, update_at, user_id) FROM stdin;
0	2024-11-01	1	10:55:13	1	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-10-31 10:50:13	2024-11-01 11:25:13	1419
1	2024-11-01	0	10:26:27	10	Không dùng món ăn quá cay	2024-10-31 10:09:27	2024-11-01 11:04:27	70
2	2024-11-01	1	09:42:42	4	Thêm chỗ để xe đẩy cho trẻ em	2024-10-31 09:42:42	2024-11-01 10:21:42	575
3	2024-11-01	0	05:14:49	6		2024-10-31 04:41:49	2024-11-01 05:51:49	457
4	2024-11-01	1	06:01:49	10	Yêu cầu ghế trẻ em cho bé nhỏ	2024-10-31 05:48:49	2024-11-01 06:16:49	1190
5	2024-11-01	0	06:40:58	15	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-10-31 06:33:58	2024-11-01 06:50:58	1871
6	2024-11-01	1	07:06:17	4	Không thêm muối vào các món ăn	2024-10-31 06:28:17	2024-11-01 07:33:17	273
7	2024-11-01	1	06:14:03	14	Yêu cầu ghế trẻ em cho bé nhỏ	2024-10-31 06:00:03	2024-11-01 06:29:03	1811
8	2024-11-01	1	05:56:20	12	Chuẩn bị thực đơn thuần chay	2024-10-31 05:20:20	2024-11-01 05:57:20	192
9	2024-11-01	1	08:02:42	7	Cung cấp thực đơn không chứa gluten	2024-10-31 07:37:42	2024-11-01 08:33:42	1886
10	2024-11-01	1	09:59:04	10		2024-10-31 09:54:04	2024-11-01 10:33:04	1053
11	2024-11-01	1	16:08:20	1	Thêm một đĩa trái cây cho trẻ em	2024-10-31 16:02:20	2024-11-01 16:37:20	813
12	2024-11-01	1	13:46:22	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-10-31 13:03:22	2024-11-01 13:55:22	1455
13	2024-11-01	1	13:37:42	2	Phục vụ nhanh vì có trẻ em đi cùng	2024-10-31 12:54:42	2024-11-01 13:40:42	159
14	2024-11-01	1	12:06:57	5	Cung cấp thực đơn không chứa gluten	2024-10-31 11:28:57	2024-11-01 12:46:57	110
15	2024-11-01	2	17:36:45	20	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-10-31 17:27:45	2024-11-01 17:46:45	1045
16	2024-11-01	1	14:23:39	9	Có món ăn phù hợp với người lớn tuổi	2024-10-31 14:08:39	2024-11-01 15:02:39	1397
17	2024-11-01	1	14:50:51	3	Dành chỗ ngồi cho nhóm 10 người	2024-10-31 14:41:51	2024-11-01 15:09:51	121
18	2024-11-01	1	15:41:53	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-10-31 15:18:53	2024-11-01 16:09:53	1427
19	2024-11-01	0	14:46:20	19	Thêm chỗ để xe đẩy cho trẻ em	2024-10-31 14:28:20	2024-11-01 15:09:20	1182
20	2024-11-01	1	13:32:32	15	Chuẩn bị thực đơn thuần chay	2024-10-31 12:48:32	2024-11-01 13:33:32	956
21	2024-11-01	0	17:53:06	1		2024-10-31 17:35:06	2024-11-01 18:36:06	359
22	2024-11-01	1	17:36:43	11	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-10-31 17:07:43	2024-11-01 18:16:43	1511
23	2024-11-01	1	19:28:08	3	Thêm một đĩa trái cây cho trẻ em	2024-10-31 18:49:08	2024-11-01 19:58:08	1777
24	2024-11-01	1	19:26:57	20	Có món ăn phù hợp với người lớn tuổi	2024-10-31 19:12:57	2024-11-01 19:37:57	1991
25	2024-11-01	1	18:31:16	14	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-10-31 18:31:16	2024-11-01 19:09:16	1393
26	2024-11-01	1	18:28:20	3	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-10-31 17:57:20	2024-11-01 18:51:20	1506
27	2024-11-01	1	20:15:50	10	Có món ăn phù hợp với người lớn tuổi	2024-10-31 20:05:50	2024-11-01 20:45:50	1850
28	2024-11-01	0	20:45:21	1	Không dùng món ăn quá cay	2024-10-31 20:26:21	2024-11-01 21:20:21	574
29	2024-11-01	1	19:40:42	14	Thêm một đĩa trái cây cho trẻ em	2024-10-31 19:16:42	2024-11-01 19:56:42	1977
30	2024-11-01	1	20:32:52	14	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-10-31 20:05:52	2024-11-01 21:12:52	1389
31	2024-11-01	1	18:33:33	13	Không dùng hành hoặc tỏi trong món ăn	2024-10-31 18:03:33	2024-11-01 18:45:33	906
32	2024-11-01	1	20:57:45	16	Thêm chỗ để xe đẩy cho trẻ em	2024-10-31 20:54:45	2024-11-01 21:37:45	969
33	2024-11-01	1	21:48:40	11	Phục vụ nhanh vì có trẻ em đi cùng	2024-10-31 21:12:40	2024-11-01 22:06:40	223
34	2024-11-01	1	18:02:45	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-10-31 18:01:45	2024-11-01 18:33:45	170
35	2024-11-01	1	18:38:13	10	Phục vụ nhanh vì có trẻ em đi cùng	2024-10-31 18:16:13	2024-11-01 19:15:13	817
36	2024-11-01	1	18:21:58	3	Yêu cầu ghế trẻ em cho bé nhỏ	2024-10-31 18:00:58	2024-11-01 18:46:58	1404
37	2024-11-01	1	19:13:27	2	Không dùng món ăn quá cay	2024-10-31 18:48:27	2024-11-01 19:23:27	856
38	2024-11-01	1	21:52:16	3	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-10-31 21:16:16	2024-11-01 22:14:16	904
39	2024-11-01	1	23:16:50	9	Dọn sẵn đĩa và dao cắt bánh	2024-10-31 22:48:50	2024-11-01 23:48:50	145
40	2024-11-02	1	06:08:11	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-01 05:57:11	2024-11-02 06:41:11	1023
41	2024-11-02	1	10:37:44	3	Thêm một đĩa trái cây cho trẻ em	2024-11-01 09:55:44	2024-11-02 11:18:44	328
42	2024-11-02	1	07:58:32	3	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-01 07:44:32	2024-11-02 08:23:32	1349
43	2024-11-02	1	07:48:34	1	Không dùng hành hoặc tỏi trong món ăn	2024-11-01 07:28:34	2024-11-02 08:23:34	219
44	2024-11-02	1	07:49:41	1	Chuẩn bị thực đơn thuần chay	2024-11-01 07:27:41	2024-11-02 08:00:41	1920
45	2024-11-02	1	08:14:29	13	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-01 07:47:29	2024-11-02 08:41:29	1194
46	2024-11-02	1	08:18:14	17	Cung cấp thực đơn không chứa gluten	2024-11-01 07:41:14	2024-11-02 08:41:14	1830
47	2024-11-02	2	05:03:19	18	Có món ăn phù hợp với người lớn tuổi	2024-11-01 04:39:19	2024-11-02 05:15:19	479
48	2024-11-02	0	07:38:54	7	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-01 07:37:54	2024-11-02 07:44:54	1590
49	2024-11-02	0	07:04:51	7	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-01 06:37:51	2024-11-02 07:12:51	855
50	2024-11-02	1	08:34:14	16	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-01 08:13:14	2024-11-02 09:15:14	131
51	2024-11-02	0	14:40:15	16	Dọn sẵn đĩa và dao cắt bánh	2024-11-01 14:19:15	2024-11-02 14:40:15	413
52	2024-11-02	1	15:02:35	3	Không dùng món ăn quá cay	2024-11-01 14:45:35	2024-11-02 15:44:35	1912
53	2024-11-02	0	11:45:21	9	Có món ăn phù hợp với người lớn tuổi	2024-11-01 11:42:21	2024-11-02 12:08:21	1252
54	2024-11-02	2	15:03:23	10	Bàn gần cửa sổ để ngắm cảnh	2024-11-01 14:57:23	2024-11-02 15:24:23	1461
55	2024-11-02	1	13:42:18	3	Có món ăn phù hợp với người lớn tuổi	2024-11-01 13:37:18	2024-11-02 13:43:18	1713
56	2024-11-02	0	17:34:38	6	Không dùng món ăn quá cay	2024-11-01 17:09:38	2024-11-02 18:18:38	145
57	2024-11-02	1	14:52:39	12	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-01 14:21:39	2024-11-02 14:52:39	1591
58	2024-11-02	0	15:28:11	8	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-01 15:12:11	2024-11-02 15:45:11	1635
59	2024-11-02	0	12:34:27	3	Thêm chỗ để xe đẩy cho trẻ em	2024-11-01 12:34:27	2024-11-02 12:39:27	1538
60	2024-11-02	2	11:24:13	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-01 11:24:13	2024-11-02 12:06:13	1980
61	2024-11-02	0	15:17:34	14	Bàn gần cửa sổ để ngắm cảnh	2024-11-01 15:15:34	2024-11-02 15:37:34	1147
62	2024-11-02	1	12:44:22	3	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-01 12:44:22	2024-11-02 12:53:22	514
63	2024-11-02	1	19:36:58	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-01 19:29:58	2024-11-02 19:40:58	1285
64	2024-11-02	0	20:31:09	14	Không dùng hành hoặc tỏi trong món ăn	2024-11-01 20:09:09	2024-11-02 21:08:09	735
65	2024-11-02	1	18:39:28	3	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-01 18:17:28	2024-11-02 19:02:28	126
66	2024-11-02	1	18:34:49	7	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-01 18:24:49	2024-11-02 18:54:49	1599
67	2024-11-02	1	20:47:37	10	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-01 20:05:37	2024-11-02 20:56:37	1509
68	2024-11-02	0	19:11:30	3	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-01 18:40:30	2024-11-02 19:46:30	1873
69	2024-11-02	2	19:10:58	3	Dọn sẵn đĩa và dao cắt bánh	2024-11-01 18:55:58	2024-11-02 19:37:58	1079
70	2024-11-02	1	18:28:01	8	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-01 18:02:01	2024-11-02 19:07:01	1144
71	2024-11-02	0	19:20:44	2	Không dùng hành hoặc tỏi trong món ăn	2024-11-01 18:55:44	2024-11-02 19:30:44	461
72	2024-11-02	1	20:20:15	20	Có món ăn phù hợp với người lớn tuổi	2024-11-01 19:58:15	2024-11-02 20:28:15	196
73	2024-11-02	2	21:42:19	1	Thêm một đĩa trái cây cho trẻ em	2024-11-01 21:11:19	2024-11-02 21:46:19	1007
74	2024-11-02	1	19:15:51	4	Không dùng hành hoặc tỏi trong món ăn	2024-11-01 18:59:51	2024-11-02 19:50:51	401
75	2024-11-02	1	20:38:58	9	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-01 19:55:58	2024-11-02 21:14:58	211
76	2024-11-02	1	18:45:52	1		2024-11-01 18:12:52	2024-11-02 19:04:52	176
77	2024-11-02	2	19:52:24	1	Dành chỗ ngồi cho nhóm 10 người	2024-11-01 19:51:24	2024-11-02 20:25:24	1133
78	2024-11-02	1	20:19:35	4	Không thêm muối vào các món ăn	2024-11-01 19:37:35	2024-11-02 20:59:35	362
79	2024-11-03	0	01:02:17	3	Thêm một đĩa trái cây cho trẻ em	2024-11-02 00:31:17	2024-11-03 01:17:17	1182
80	2024-11-03	0	07:12:04	19	Có món ăn phù hợp với người lớn tuổi	2024-11-02 06:46:04	2024-11-03 07:40:04	1356
81	2024-11-03	1	10:33:40	6	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-02 10:20:40	2024-11-03 11:04:40	826
82	2024-11-03	1	07:29:39	4	Thêm chỗ để xe đẩy cho trẻ em	2024-11-02 07:15:39	2024-11-03 07:43:39	476
83	2024-11-03	0	06:29:36	11	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-02 06:02:36	2024-11-03 06:32:36	1362
84	2024-11-03	1	10:43:21	16	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-02 10:06:21	2024-11-03 11:02:21	1644
85	2024-11-03	1	09:54:32	3	Bàn gần cửa sổ để ngắm cảnh	2024-11-02 09:49:32	2024-11-03 10:14:32	1107
86	2024-11-03	1	08:03:14	2	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-02 07:19:14	2024-11-03 08:36:14	433
87	2024-11-03	0	09:22:32	20	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-02 08:44:32	2024-11-03 09:22:32	1214
88	2024-11-03	2	06:03:19	3	Dọn sẵn đĩa và dao cắt bánh	2024-11-02 05:24:19	2024-11-03 06:38:19	1102
89	2024-11-03	1	10:43:15	8	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-02 10:34:15	2024-11-03 11:03:15	643
90	2024-11-03	1	07:32:10	6	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-02 07:02:10	2024-11-03 08:11:10	1547
91	2024-11-03	1	11:41:48	8	Dành chỗ ngồi cho nhóm 10 người	2024-11-02 11:16:48	2024-11-03 12:17:48	459
92	2024-11-03	2	16:39:36	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-02 16:01:36	2024-11-03 17:17:36	585
93	2024-11-03	1	15:23:58	12	Không dùng hành hoặc tỏi trong món ăn	2024-11-02 15:09:58	2024-11-03 15:38:58	263
94	2024-11-03	1	12:37:53	4	Không dùng hành hoặc tỏi trong món ăn	2024-11-02 12:07:53	2024-11-03 12:54:53	1546
95	2024-11-03	1	16:42:49	19	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-02 16:18:49	2024-11-03 17:25:49	842
96	2024-11-03	2	15:36:19	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-02 15:23:19	2024-11-03 15:48:19	1256
97	2024-11-03	0	11:48:31	4	Không dùng món ăn quá cay	2024-11-02 11:11:31	2024-11-03 12:31:31	1401
98	2024-11-03	1	14:30:14	5		2024-11-02 13:58:14	2024-11-03 14:37:14	928
99	2024-11-03	1	15:53:51	6	Không dùng món ăn quá cay	2024-11-02 15:43:51	2024-11-03 16:01:51	1314
100	2024-11-03	2	17:10:40	2	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-02 16:29:40	2024-11-03 17:39:40	1940
101	2024-11-03	1	17:29:35	3	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-02 17:16:35	2024-11-03 18:04:35	783
102	2024-11-03	1	11:21:40	9	Thêm chỗ để xe đẩy cho trẻ em	2024-11-02 10:52:40	2024-11-03 12:06:40	588
103	2024-11-03	0	20:43:57	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-02 20:18:57	2024-11-03 21:19:57	842
104	2024-11-03	0	20:52:48	2	Không dùng hành hoặc tỏi trong món ăn	2024-11-02 20:13:48	2024-11-03 21:36:48	1832
105	2024-11-03	1	20:44:01	4	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-02 20:05:01	2024-11-03 21:28:01	607
106	2024-11-03	1	20:10:44	19	Dọn sẵn đĩa và dao cắt bánh	2024-11-02 19:45:44	2024-11-03 20:44:44	1868
107	2024-11-03	2	20:51:44	20	Không dùng món ăn quá cay	2024-11-02 20:07:44	2024-11-03 21:03:44	1730
108	2024-11-03	1	18:17:01	5	Thêm chỗ để xe đẩy cho trẻ em	2024-11-02 18:09:01	2024-11-03 18:35:01	141
109	2024-11-03	1	19:49:48	20	Thêm chỗ để xe đẩy cho trẻ em	2024-11-02 19:44:48	2024-11-03 20:14:48	1580
110	2024-11-03	2	18:48:19	1	Chuẩn bị thực đơn thuần chay	2024-11-02 18:42:19	2024-11-03 19:29:19	221
111	2024-11-03	0	19:48:07	20	Cung cấp thực đơn không chứa gluten	2024-11-02 19:45:07	2024-11-03 20:08:07	1997
112	2024-11-03	2	18:26:20	12	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-02 17:49:20	2024-11-03 18:57:20	722
113	2024-11-03	1	20:16:58	3	Không dùng hành hoặc tỏi trong món ăn	2024-11-02 19:40:58	2024-11-03 20:38:58	210
114	2024-11-03	1	18:55:32	3	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-02 18:29:32	2024-11-03 19:21:32	578
115	2024-11-03	1	19:58:45	9	Bàn gần cửa sổ để ngắm cảnh	2024-11-02 19:52:45	2024-11-03 20:18:45	512
116	2024-11-03	1	19:44:48	4	Dọn sẵn đĩa và dao cắt bánh	2024-11-02 19:06:48	2024-11-03 19:47:48	1591
117	2024-11-03	2	19:01:55	6	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-02 18:18:55	2024-11-03 19:15:55	1693
118	2024-11-03	1	20:07:04	14	Không dùng hành hoặc tỏi trong món ăn	2024-11-02 19:33:04	2024-11-03 20:19:04	1905
119	2024-11-03	1	23:05:48	11	Dọn sẵn đĩa và dao cắt bánh	2024-11-02 22:48:48	2024-11-03 23:37:48	1452
120	2024-11-04	1	06:12:53	3	Dành chỗ ngồi cho nhóm 10 người	2024-11-03 05:34:53	2024-11-04 06:25:53	1533
121	2024-11-04	1	07:26:28	16	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-03 07:18:28	2024-11-04 08:03:28	1418
122	2024-11-04	1	08:33:22	3	Không dùng hành hoặc tỏi trong món ăn	2024-11-03 08:28:22	2024-11-04 08:44:22	715
123	2024-11-04	1	07:32:47	4		2024-11-03 07:09:47	2024-11-04 07:49:47	1663
124	2024-11-04	1	08:38:24	4	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-03 08:11:24	2024-11-04 09:12:24	1090
125	2024-11-04	1	05:37:22	2	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-03 05:26:22	2024-11-04 05:49:22	1160
126	2024-11-04	0	05:18:58	8	Có món ăn phù hợp với người lớn tuổi	2024-11-03 05:15:58	2024-11-04 05:27:58	1154
127	2024-11-04	1	05:29:01	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-03 05:08:01	2024-11-04 05:34:01	935
128	2024-11-04	2	05:04:51	1	Chuẩn bị thực đơn thuần chay	2024-11-03 04:22:51	2024-11-04 05:44:51	1426
129	2024-11-04	1	09:38:58	15	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-03 09:36:58	2024-11-04 09:57:58	1385
130	2024-11-04	1	10:24:30	2	Bàn gần cửa sổ để ngắm cảnh	2024-11-03 09:47:30	2024-11-04 10:39:30	669
131	2024-11-04	2	11:37:40	18	Cung cấp thực đơn không chứa gluten	2024-11-03 10:55:40	2024-11-04 11:52:40	992
132	2024-11-04	2	11:51:54	9	Bàn gần cửa sổ để ngắm cảnh	2024-11-03 11:27:54	2024-11-04 12:17:54	772
133	2024-11-04	1	17:13:41	17	Không thêm muối vào các món ăn	2024-11-03 16:52:41	2024-11-04 17:20:41	1945
134	2024-11-04	1	11:34:07	2		2024-11-03 10:52:07	2024-11-04 12:18:07	825
135	2024-11-04	2	16:59:19	10	Thêm một đĩa trái cây cho trẻ em	2024-11-03 16:41:19	2024-11-04 17:35:19	1940
136	2024-11-04	2	17:47:53	8	Bàn gần cửa sổ để ngắm cảnh	2024-11-03 17:19:53	2024-11-04 18:03:53	372
137	2024-11-04	1	12:22:32	17	Không dùng món ăn quá cay	2024-11-03 11:57:32	2024-11-04 12:41:32	1180
138	2024-11-04	1	16:14:44	5	Dành chỗ ngồi cho nhóm 10 người	2024-11-03 15:44:44	2024-11-04 16:33:44	1899
139	2024-11-04	1	15:30:22	6	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-03 15:23:22	2024-11-04 15:32:22	450
140	2024-11-04	1	12:34:15	13	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-03 12:29:15	2024-11-04 13:17:15	85
141	2024-11-04	1	12:15:47	8	Có món ăn phù hợp với người lớn tuổi	2024-11-03 12:05:47	2024-11-04 13:00:47	222
142	2024-11-04	1	17:34:33	20	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-03 17:04:33	2024-11-04 17:52:33	782
143	2024-11-04	1	18:46:33	19	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-03 18:07:33	2024-11-04 19:05:33	104
144	2024-11-04	1	18:40:06	4	Có món ăn phù hợp với người lớn tuổi	2024-11-03 18:06:06	2024-11-04 18:49:06	1872
145	2024-11-04	1	19:33:04	4	Thêm chỗ để xe đẩy cho trẻ em	2024-11-03 19:17:04	2024-11-04 20:14:04	1753
146	2024-11-04	1	20:27:29	10	Thêm chỗ để xe đẩy cho trẻ em	2024-11-03 19:58:29	2024-11-04 21:11:29	1155
147	2024-11-04	1	19:46:59	8		2024-11-03 19:23:59	2024-11-04 20:15:59	551
148	2024-11-04	1	20:51:35	7	Có món ăn phù hợp với người lớn tuổi	2024-11-03 20:27:35	2024-11-04 21:12:35	331
149	2024-11-04	0	19:10:59	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-03 18:46:59	2024-11-04 19:49:59	113
150	2024-11-04	1	21:23:08	14	Chuẩn bị thực đơn thuần chay	2024-11-03 20:40:08	2024-11-04 21:56:08	1655
151	2024-11-04	2	21:34:43	17	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-03 21:18:43	2024-11-04 22:12:43	1401
152	2024-11-04	1	19:32:38	10	Không thêm muối vào các món ăn	2024-11-03 18:51:38	2024-11-04 19:59:38	212
153	2024-11-04	1	21:36:29	1	Dành chỗ ngồi cho nhóm 10 người	2024-11-03 21:33:29	2024-11-04 21:56:29	256
154	2024-11-04	1	19:09:53	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-03 18:42:53	2024-11-04 19:21:53	755
155	2024-11-04	0	20:31:58	2	Không dùng món ăn quá cay	2024-11-03 20:26:58	2024-11-04 20:43:58	1762
156	2024-11-04	1	18:27:20	1	Không dùng hành hoặc tỏi trong món ăn	2024-11-03 17:48:20	2024-11-04 18:44:20	68
157	2024-11-04	0	21:08:18	11	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-03 20:44:18	2024-11-04 21:14:18	1731
158	2024-11-04	1	21:24:32	1	Thêm chỗ để xe đẩy cho trẻ em	2024-11-03 20:58:32	2024-11-04 21:26:32	861
159	2024-11-05	1	00:23:21	12	Cung cấp thực đơn không chứa gluten	2024-11-03 23:53:21	2024-11-05 00:24:21	1225
160	2024-11-05	1	05:22:31	10	Cung cấp thực đơn không chứa gluten	2024-11-04 05:11:31	2024-11-05 05:49:31	707
161	2024-11-05	1	06:33:42	3	Có món ăn phù hợp với người lớn tuổi	2024-11-04 06:02:42	2024-11-05 06:35:42	913
162	2024-11-05	1	08:01:32	9	Chuẩn bị thực đơn thuần chay	2024-11-04 07:33:32	2024-11-05 08:34:32	942
163	2024-11-05	1	07:21:36	17	Thêm một đĩa trái cây cho trẻ em	2024-11-04 06:43:36	2024-11-05 07:56:36	10
164	2024-11-05	1	08:08:02	4	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-04 07:33:02	2024-11-05 08:17:02	91
165	2024-11-05	1	10:51:38	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-04 10:23:38	2024-11-05 11:10:38	1725
166	2024-11-05	0	08:04:07	5	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-04 07:32:07	2024-11-05 08:33:07	1748
167	2024-11-05	1	06:47:40	4	Bàn gần cửa sổ để ngắm cảnh	2024-11-04 06:16:40	2024-11-05 07:25:40	509
168	2024-11-05	1	08:09:17	1	Không dùng món ăn quá cay	2024-11-04 07:28:17	2024-11-05 08:43:17	133
169	2024-11-05	0	09:36:43	9	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-04 08:52:43	2024-11-05 10:18:43	984
170	2024-11-05	1	07:20:37	18	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-04 06:44:37	2024-11-05 07:57:37	1113
171	2024-11-05	1	13:48:04	16	Dành chỗ ngồi cho nhóm 10 người	2024-11-04 13:13:04	2024-11-05 14:27:04	203
172	2024-11-05	0	12:31:56	19	Có món ăn phù hợp với người lớn tuổi	2024-11-04 12:30:56	2024-11-05 12:32:56	600
173	2024-11-05	2	11:45:50	8	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-04 11:12:50	2024-11-05 12:05:50	1464
174	2024-11-05	0	14:32:41	15	Thêm chỗ để xe đẩy cho trẻ em	2024-11-04 13:56:41	2024-11-05 14:33:41	1665
175	2024-11-05	1	15:00:22	1	Bàn gần cửa sổ để ngắm cảnh	2024-11-04 14:55:22	2024-11-05 15:15:22	1260
176	2024-11-05	1	14:48:40	1	Không thêm muối vào các món ăn	2024-11-04 14:15:40	2024-11-05 14:54:40	1062
177	2024-11-05	0	12:14:10	11	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-04 11:38:10	2024-11-05 12:23:10	1728
178	2024-11-05	1	12:14:14	16	Không dùng hành hoặc tỏi trong món ăn	2024-11-04 11:44:14	2024-11-05 12:36:14	1315
179	2024-11-05	1	16:12:54	17	Thêm một đĩa trái cây cho trẻ em	2024-11-04 15:58:54	2024-11-05 16:53:54	1401
180	2024-11-05	1	11:11:57	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-04 10:30:57	2024-11-05 11:23:57	85
181	2024-11-05	1	15:51:09	2	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-04 15:30:09	2024-11-05 16:18:09	1919
182	2024-11-05	0	11:19:21	4	Chuẩn bị thực đơn thuần chay	2024-11-04 10:47:21	2024-11-05 11:51:21	590
183	2024-11-05	1	20:54:40	7	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-04 20:34:40	2024-11-05 21:13:40	993
184	2024-11-05	1	20:51:56	4	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-04 20:38:56	2024-11-05 20:52:56	1325
185	2024-11-05	1	19:09:07	19	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-04 18:45:07	2024-11-05 19:38:07	829
186	2024-11-05	1	19:05:50	20	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-04 18:33:50	2024-11-05 19:11:50	1782
187	2024-11-05	2	19:50:41	4	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-04 19:36:41	2024-11-05 19:55:41	1738
188	2024-11-05	1	21:57:32	3	Không dùng món ăn quá cay	2024-11-04 21:25:32	2024-11-05 22:15:32	190
189	2024-11-05	2	18:03:07	15	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-04 17:56:07	2024-11-05 18:20:07	1636
190	2024-11-05	1	19:34:05	1	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-04 19:25:05	2024-11-05 19:52:05	1984
191	2024-11-05	1	21:45:17	12	Dành chỗ ngồi cho nhóm 10 người	2024-11-04 21:05:17	2024-11-05 22:30:17	1972
192	2024-11-05	0	21:49:35	14	Thêm chỗ để xe đẩy cho trẻ em	2024-11-04 21:47:35	2024-11-05 22:30:35	1573
193	2024-11-05	0	20:42:59	12	Không dùng hành hoặc tỏi trong món ăn	2024-11-04 20:18:59	2024-11-05 21:19:59	759
194	2024-11-05	1	21:02:18	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-04 20:24:18	2024-11-05 21:39:18	970
195	2024-11-05	2	19:37:04	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-04 19:36:04	2024-11-05 19:51:04	88
196	2024-11-05	2	21:55:06	20	Bàn gần cửa sổ để ngắm cảnh	2024-11-04 21:47:06	2024-11-05 22:19:06	478
197	2024-11-05	2	20:20:48	6	Không dùng hành hoặc tỏi trong món ăn	2024-11-04 19:55:48	2024-11-05 20:23:48	936
198	2024-11-05	1	19:36:25	10	Không dùng món ăn quá cay	2024-11-04 19:14:25	2024-11-05 19:50:25	1582
199	2024-11-06	1	01:54:29	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-05 01:14:29	2024-11-06 02:00:29	1167
200	2024-11-06	1	05:32:12	1	Bàn gần cửa sổ để ngắm cảnh	2024-11-05 04:56:12	2024-11-06 06:10:12	791
201	2024-11-06	1	06:08:55	16	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-05 05:42:55	2024-11-06 06:33:55	804
202	2024-11-06	1	07:31:10	10	Không dùng hành hoặc tỏi trong món ăn	2024-11-05 07:30:10	2024-11-06 07:57:10	755
203	2024-11-06	1	10:38:03	5	Chuẩn bị thực đơn thuần chay	2024-11-05 09:54:03	2024-11-06 10:44:03	76
204	2024-11-06	0	07:08:55	12		2024-11-05 06:24:55	2024-11-06 07:39:55	1479
205	2024-11-06	0	10:25:00	15	Cung cấp thực đơn không chứa gluten	2024-11-05 09:52:00	2024-11-06 10:37:00	1107
206	2024-11-06	0	06:23:19	6	Không thêm muối vào các món ăn	2024-11-05 05:39:19	2024-11-06 06:34:19	997
207	2024-11-06	0	07:52:21	14	Không dùng món ăn quá cay	2024-11-05 07:38:21	2024-11-06 08:36:21	596
208	2024-11-06	1	07:57:11	9	Chuẩn bị thực đơn thuần chay	2024-11-05 07:41:11	2024-11-06 08:09:11	718
209	2024-11-06	1	08:02:34	14		2024-11-05 07:27:34	2024-11-06 08:03:34	1659
210	2024-11-06	1	07:59:47	3	Có món ăn phù hợp với người lớn tuổi	2024-11-05 07:40:47	2024-11-06 08:09:47	85
211	2024-11-06	0	15:17:54	6	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-05 14:54:54	2024-11-06 15:19:54	1320
212	2024-11-06	1	11:07:21	7	Bàn gần cửa sổ để ngắm cảnh	2024-11-05 10:55:21	2024-11-06 11:33:21	359
213	2024-11-06	1	14:48:48	12	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-05 14:29:48	2024-11-06 15:08:48	1013
214	2024-11-06	1	16:03:03	10	Cung cấp thực đơn không chứa gluten	2024-11-05 16:03:03	2024-11-06 16:25:03	1850
215	2024-11-06	1	11:24:17	4	Thêm một đĩa trái cây cho trẻ em	2024-11-05 10:40:17	2024-11-06 11:49:17	237
216	2024-11-06	1	14:45:04	15	Bàn gần cửa sổ để ngắm cảnh	2024-11-05 14:01:04	2024-11-06 14:57:04	353
217	2024-11-06	1	14:12:28	9		2024-11-05 14:06:28	2024-11-06 14:15:28	1706
218	2024-11-06	1	17:25:15	15	Dành chỗ ngồi cho nhóm 10 người	2024-11-05 17:01:15	2024-11-06 18:09:15	470
219	2024-11-06	1	14:48:38	20	Có món ăn phù hợp với người lớn tuổi	2024-11-05 14:24:38	2024-11-06 15:01:38	449
220	2024-11-06	2	11:45:30	4	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-05 11:35:30	2024-11-06 11:53:30	1672
221	2024-11-06	1	16:49:42	4	Thêm một đĩa trái cây cho trẻ em	2024-11-05 16:23:42	2024-11-06 17:24:42	144
222	2024-11-06	1	15:41:44	7	Chuẩn bị thực đơn thuần chay	2024-11-05 15:34:44	2024-11-06 16:22:44	1407
223	2024-11-06	1	20:19:41	3		2024-11-05 19:38:41	2024-11-06 20:22:41	1576
224	2024-11-06	1	18:07:15	3	Thêm một đĩa trái cây cho trẻ em	2024-11-05 17:50:15	2024-11-06 18:27:15	1687
225	2024-11-06	1	18:24:54	16	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-05 18:13:54	2024-11-06 18:37:54	1285
226	2024-11-06	1	20:56:32	1	Thêm một đĩa trái cây cho trẻ em	2024-11-05 20:18:32	2024-11-06 21:27:32	783
227	2024-11-06	1	19:12:14	4	Thêm chỗ để xe đẩy cho trẻ em	2024-11-05 18:49:14	2024-11-06 19:53:14	915
228	2024-11-06	2	21:09:29	8	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-05 21:03:29	2024-11-06 21:37:29	212
229	2024-11-06	2	18:03:37	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-05 18:00:37	2024-11-06 18:35:37	271
230	2024-11-06	1	18:36:01	15	Bàn gần cửa sổ để ngắm cảnh	2024-11-05 17:54:01	2024-11-06 18:37:01	737
231	2024-11-06	2	19:23:19	2	Thêm một đĩa trái cây cho trẻ em	2024-11-05 18:56:19	2024-11-06 19:54:19	226
232	2024-11-06	1	21:35:22	12	Bàn gần cửa sổ để ngắm cảnh	2024-11-05 20:59:22	2024-11-06 22:09:22	237
233	2024-11-06	1	20:25:14	17	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-05 19:59:14	2024-11-06 20:37:14	793
234	2024-11-06	1	20:08:58	5	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-05 19:33:58	2024-11-06 20:23:58	1614
235	2024-11-06	1	21:25:32	10	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-05 21:14:32	2024-11-06 21:32:32	416
236	2024-11-06	1	20:40:29	3	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-05 20:11:29	2024-11-06 21:25:29	1498
237	2024-11-06	2	20:27:22	16	Thêm một đĩa trái cây cho trẻ em	2024-11-05 19:50:22	2024-11-06 20:54:22	131
238	2024-11-06	1	19:49:28	18		2024-11-05 19:17:28	2024-11-06 20:16:28	1957
239	2024-11-06	0	23:42:06	9	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-05 23:31:06	2024-11-07 00:20:06	1759
240	2024-11-07	1	06:09:09	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-06 05:30:09	2024-11-07 06:32:09	1300
241	2024-11-07	1	10:22:25	3	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-06 10:15:25	2024-11-07 11:01:25	1145
242	2024-11-07	2	07:38:51	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-06 07:12:51	2024-11-07 07:54:51	1795
243	2024-11-07	1	06:35:39	2	Thêm một đĩa trái cây cho trẻ em	2024-11-06 05:59:39	2024-11-07 06:45:39	903
244	2024-11-07	1	06:32:24	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-06 06:03:24	2024-11-07 06:34:24	1096
245	2024-11-07	1	07:08:29	3	Dọn sẵn đĩa và dao cắt bánh	2024-11-06 06:24:29	2024-11-07 07:42:29	986
246	2024-11-07	1	07:15:31	20	Không dùng món ăn quá cay	2024-11-06 07:11:31	2024-11-07 07:16:31	654
247	2024-11-07	1	07:03:00	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-06 06:43:00	2024-11-07 07:47:00	1625
248	2024-11-07	1	06:26:35	14	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-06 06:08:35	2024-11-07 06:59:35	189
249	2024-11-07	1	06:27:57	14	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-06 06:24:57	2024-11-07 06:40:57	1000
250	2024-11-07	1	10:59:10	14	Không thêm muối vào các món ăn	2024-11-06 10:49:10	2024-11-07 11:32:10	1342
251	2024-11-07	0	11:47:26	20	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-06 11:24:26	2024-11-07 12:04:26	1460
252	2024-11-07	2	16:04:25	5	Dành chỗ ngồi cho nhóm 10 người	2024-11-06 15:42:25	2024-11-07 16:35:25	158
253	2024-11-07	1	16:55:07	7	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-06 16:53:07	2024-11-07 17:03:07	105
254	2024-11-07	2	14:06:49	9	Dành chỗ ngồi cho nhóm 10 người	2024-11-06 13:28:49	2024-11-07 14:12:49	461
255	2024-11-07	1	15:08:00	4	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-06 14:48:00	2024-11-07 15:53:00	66
256	2024-11-07	0	11:34:27	19	Dọn sẵn đĩa và dao cắt bánh	2024-11-06 11:16:27	2024-11-07 11:39:27	1743
257	2024-11-07	1	15:05:42	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-06 14:35:42	2024-11-07 15:40:42	671
258	2024-11-07	1	15:05:05	14	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-06 14:48:05	2024-11-07 15:29:05	742
259	2024-11-07	1	16:10:10	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-06 16:02:10	2024-11-07 16:25:10	749
260	2024-11-07	1	17:42:19	18	Dọn sẵn đĩa và dao cắt bánh	2024-11-06 17:23:19	2024-11-07 17:58:19	1536
261	2024-11-07	0	15:11:01	8	Cung cấp thực đơn không chứa gluten	2024-11-06 14:32:01	2024-11-07 15:14:01	850
262	2024-11-07	1	17:41:08	2	Thêm chỗ để xe đẩy cho trẻ em	2024-11-06 17:12:08	2024-11-07 17:49:08	6
263	2024-11-07	1	20:42:15	9	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-06 20:37:15	2024-11-07 20:48:15	260
264	2024-11-07	2	21:12:58	4	Thêm chỗ để xe đẩy cho trẻ em	2024-11-06 21:09:58	2024-11-07 21:48:58	1032
265	2024-11-07	0	19:14:35	2		2024-11-06 18:45:35	2024-11-07 19:55:35	1797
266	2024-11-07	1	20:46:26	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-06 20:07:26	2024-11-07 21:28:26	1956
267	2024-11-07	1	20:42:10	2	Cung cấp thực đơn không chứa gluten	2024-11-06 20:18:10	2024-11-07 21:07:10	848
268	2024-11-07	0	18:05:46	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-06 17:31:46	2024-11-07 18:07:46	488
269	2024-11-07	1	21:41:37	4	Có món ăn phù hợp với người lớn tuổi	2024-11-06 21:15:37	2024-11-07 21:49:37	274
270	2024-11-07	0	20:53:00	4	Không thêm muối vào các món ăn	2024-11-06 20:10:00	2024-11-07 21:27:00	47
271	2024-11-07	1	21:49:03	14	Thêm chỗ để xe đẩy cho trẻ em	2024-11-06 21:34:03	2024-11-07 22:26:03	1690
272	2024-11-07	2	20:09:39	5	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-06 19:50:39	2024-11-07 20:50:39	781
273	2024-11-07	1	20:24:53	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-06 20:02:53	2024-11-07 20:47:53	1333
274	2024-11-07	2	19:11:08	5	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-06 19:06:08	2024-11-07 19:20:08	1779
275	2024-11-07	1	19:55:25	16	Chuẩn bị thực đơn thuần chay	2024-11-06 19:33:25	2024-11-07 20:05:25	76
276	2024-11-07	0	19:52:52	20	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-06 19:17:52	2024-11-07 20:26:52	1176
277	2024-11-07	0	21:24:13	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-06 21:07:13	2024-11-07 22:05:13	1190
278	2024-11-07	0	20:34:31	2	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-06 20:07:31	2024-11-07 21:14:31	1171
279	2024-11-08	1	00:01:48	7	Chuẩn bị thực đơn thuần chay	2024-11-06 23:44:48	2024-11-08 00:30:48	1914
280	2024-11-08	1	06:25:59	4	Không dùng món ăn quá cay	2024-11-07 05:48:59	2024-11-08 06:31:59	351
281	2024-11-08	1	07:09:16	7	Không dùng hành hoặc tỏi trong món ăn	2024-11-07 06:37:16	2024-11-08 07:20:16	358
282	2024-11-08	1	09:42:21	19	Cung cấp thực đơn không chứa gluten	2024-11-07 09:35:21	2024-11-08 09:58:21	1723
283	2024-11-08	1	07:24:41	14	Không dùng món ăn quá cay	2024-11-07 06:55:41	2024-11-08 08:07:41	725
284	2024-11-08	1	06:28:30	19	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-07 06:07:30	2024-11-08 06:54:30	141
285	2024-11-08	0	07:11:03	12	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-07 06:37:03	2024-11-08 07:55:03	1449
286	2024-11-08	1	08:16:30	10	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-07 08:00:30	2024-11-08 08:58:30	162
287	2024-11-08	2	09:34:30	12	Thêm một đĩa trái cây cho trẻ em	2024-11-07 08:59:30	2024-11-08 09:52:30	894
288	2024-11-08	1	05:17:51	19	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-07 04:42:51	2024-11-08 05:50:51	1164
289	2024-11-08	1	05:25:31	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-07 05:14:31	2024-11-08 05:30:31	1290
290	2024-11-08	2	08:54:40	16	Không dùng hành hoặc tỏi trong món ăn	2024-11-07 08:45:40	2024-11-08 09:03:40	1917
291	2024-11-08	0	14:47:14	6	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-07 14:13:14	2024-11-08 15:32:14	1631
292	2024-11-08	1	15:41:58	6	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-07 15:40:58	2024-11-08 15:52:58	1650
293	2024-11-08	1	17:29:50	18	Không dùng hành hoặc tỏi trong món ăn	2024-11-07 16:46:50	2024-11-08 17:42:50	1401
294	2024-11-08	0	11:34:39	8	Dành chỗ ngồi cho nhóm 10 người	2024-11-07 11:17:39	2024-11-08 12:18:39	1607
295	2024-11-08	0	11:43:46	2	Không dùng món ăn quá cay	2024-11-07 11:18:46	2024-11-08 12:03:46	144
296	2024-11-08	1	14:47:59	6	Có món ăn phù hợp với người lớn tuổi	2024-11-07 14:21:59	2024-11-08 14:53:59	207
297	2024-11-08	1	17:36:51	15		2024-11-07 17:09:51	2024-11-08 18:12:51	1508
298	2024-11-08	2	12:34:57	4	Cung cấp thực đơn không chứa gluten	2024-11-07 12:07:57	2024-11-08 12:45:57	433
299	2024-11-08	0	14:09:42	4	Dọn sẵn đĩa và dao cắt bánh	2024-11-07 13:51:42	2024-11-08 14:37:42	886
300	2024-11-08	1	16:12:27	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-07 15:50:27	2024-11-08 16:28:27	1814
301	2024-11-08	2	14:31:18	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-07 14:08:18	2024-11-08 15:01:18	649
302	2024-11-08	0	16:52:54	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-07 16:30:54	2024-11-08 17:30:54	97
303	2024-11-08	2	21:22:19	2	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-07 21:00:19	2024-11-08 21:49:19	1252
304	2024-11-08	1	21:40:17	15	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-07 21:11:17	2024-11-08 21:55:17	1172
305	2024-11-08	1	21:45:29	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-07 21:31:29	2024-11-08 21:54:29	1723
306	2024-11-08	0	20:16:52	3	Thêm chỗ để xe đẩy cho trẻ em	2024-11-07 19:38:52	2024-11-08 20:52:52	1200
307	2024-11-08	2	18:50:50	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-07 18:46:50	2024-11-08 19:26:50	1945
308	2024-11-08	1	20:27:20	3	Không dùng món ăn quá cay	2024-11-07 19:47:20	2024-11-08 20:59:20	1135
309	2024-11-08	1	19:24:38	14	Không dùng hành hoặc tỏi trong món ăn	2024-11-07 19:01:38	2024-11-08 19:48:38	246
310	2024-11-08	1	20:19:51	14	Không dùng hành hoặc tỏi trong món ăn	2024-11-07 19:38:51	2024-11-08 20:51:51	55
311	2024-11-08	2	18:56:16	9		2024-11-07 18:26:16	2024-11-08 19:32:16	1204
312	2024-11-08	2	20:47:18	8	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-07 20:28:18	2024-11-08 21:00:18	552
313	2024-11-08	1	21:34:18	2	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-07 21:19:18	2024-11-08 22:09:18	963
314	2024-11-08	1	20:50:26	8	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-07 20:31:26	2024-11-08 21:14:26	1126
315	2024-11-08	1	21:37:03	12	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-07 21:10:03	2024-11-08 22:21:03	220
316	2024-11-08	1	20:26:02	4	Không dùng món ăn quá cay	2024-11-07 20:20:02	2024-11-08 20:51:02	1595
317	2024-11-08	1	18:12:53	14	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-07 18:02:53	2024-11-08 18:38:53	1592
318	2024-11-08	1	19:35:23	16		2024-11-07 19:01:23	2024-11-08 19:40:23	1983
319	2024-11-08	1	22:00:56	11	Bàn gần cửa sổ để ngắm cảnh	2024-11-07 21:29:56	2024-11-08 22:06:56	1767
320	2024-11-09	1	09:03:26	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-08 08:25:26	2024-11-09 09:31:26	498
321	2024-11-09	1	05:36:17	10		2024-11-08 05:33:17	2024-11-09 05:45:17	73
322	2024-11-09	1	07:34:49	10	Có món ăn phù hợp với người lớn tuổi	2024-11-08 07:28:49	2024-11-09 07:35:49	1059
323	2024-11-09	1	05:21:42	3	Chuẩn bị thực đơn thuần chay	2024-11-08 05:10:42	2024-11-09 06:03:42	612
324	2024-11-09	1	09:01:46	17	Thêm một đĩa trái cây cho trẻ em	2024-11-08 08:59:46	2024-11-09 09:38:46	22
325	2024-11-09	0	07:17:44	4	Thêm một đĩa trái cây cho trẻ em	2024-11-08 06:38:44	2024-11-09 07:58:44	1657
326	2024-11-09	1	10:14:43	13		2024-11-08 09:55:43	2024-11-09 10:19:43	746
327	2024-11-09	1	07:18:32	15	Dành chỗ ngồi cho nhóm 10 người	2024-11-08 06:39:32	2024-11-09 08:02:32	750
328	2024-11-09	1	05:46:28	3	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-08 05:21:28	2024-11-09 05:58:28	1564
329	2024-11-09	1	07:54:23	18	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-08 07:10:23	2024-11-09 08:33:23	34
330	2024-11-09	2	09:58:47	20	Bàn gần cửa sổ để ngắm cảnh	2024-11-08 09:45:47	2024-11-09 10:22:47	218
331	2024-11-09	1	14:13:31	4	Không thêm muối vào các món ăn	2024-11-08 14:11:31	2024-11-09 14:58:31	1851
332	2024-11-09	0	12:27:29	7	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-08 12:12:29	2024-11-09 12:43:29	267
333	2024-11-09	2	13:48:12	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-08 13:30:12	2024-11-09 13:58:12	259
334	2024-11-09	1	13:46:55	2	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-08 13:34:55	2024-11-09 14:11:55	461
335	2024-11-09	1	11:29:14	2		2024-11-08 10:49:14	2024-11-09 12:05:14	456
336	2024-11-09	1	12:13:33	13	Dọn sẵn đĩa và dao cắt bánh	2024-11-08 12:03:33	2024-11-09 12:22:33	706
337	2024-11-09	2	17:45:27	16	Có món ăn phù hợp với người lớn tuổi	2024-11-08 17:07:27	2024-11-09 17:49:27	1628
338	2024-11-09	1	13:30:33	14	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-08 12:57:33	2024-11-09 14:14:33	196
339	2024-11-09	1	14:36:39	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-08 14:20:39	2024-11-09 14:59:39	1380
340	2024-11-09	2	16:56:57	16	Không thêm muối vào các món ăn	2024-11-08 16:14:57	2024-11-09 17:11:57	767
341	2024-11-09	2	14:32:44	8	Cung cấp thực đơn không chứa gluten	2024-11-08 14:11:44	2024-11-09 14:39:44	1914
342	2024-11-09	1	15:24:06	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-08 14:52:06	2024-11-09 15:45:06	1908
343	2024-11-09	1	20:14:21	9	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-08 20:03:21	2024-11-09 20:22:21	119
344	2024-11-09	1	18:18:56	19	Không dùng hành hoặc tỏi trong món ăn	2024-11-08 17:40:56	2024-11-09 18:48:56	193
345	2024-11-09	1	19:40:21	4	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-08 19:34:21	2024-11-09 20:07:21	294
346	2024-11-09	2	19:47:42	11	Dành chỗ ngồi cho nhóm 10 người	2024-11-08 19:37:42	2024-11-09 19:50:42	3
347	2024-11-09	2	21:51:10	2	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-08 21:34:10	2024-11-09 22:09:10	764
348	2024-11-09	1	21:40:52	3	Dành chỗ ngồi cho nhóm 10 người	2024-11-08 21:40:52	2024-11-09 21:40:52	337
349	2024-11-09	1	21:03:47	3	Dành chỗ ngồi cho nhóm 10 người	2024-11-08 20:52:47	2024-11-09 21:36:47	965
350	2024-11-09	1	19:11:47	20	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-08 18:59:47	2024-11-09 19:38:47	1750
351	2024-11-09	1	18:29:04	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-08 17:54:04	2024-11-09 18:59:04	1221
352	2024-11-09	2	18:47:21	11	Dành chỗ ngồi cho nhóm 10 người	2024-11-08 18:45:21	2024-11-09 18:59:21	591
353	2024-11-09	1	18:51:07	5	Dành chỗ ngồi cho nhóm 10 người	2024-11-08 18:45:07	2024-11-09 19:29:07	1280
354	2024-11-09	0	18:09:28	11	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-08 18:02:28	2024-11-09 18:27:28	836
355	2024-11-09	1	18:07:02	5	Không dùng món ăn quá cay	2024-11-08 17:47:02	2024-11-09 18:34:02	1634
356	2024-11-09	1	19:33:34	4	Bàn gần cửa sổ để ngắm cảnh	2024-11-08 19:21:34	2024-11-09 19:48:34	1781
357	2024-11-09	1	21:12:43	20	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-08 20:38:43	2024-11-09 21:51:43	1794
358	2024-11-09	1	19:57:30	4	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-08 19:57:30	2024-11-09 20:02:30	103
359	2024-11-09	1	22:35:12	17	Chuẩn bị thực đơn thuần chay	2024-11-08 22:14:12	2024-11-09 22:35:12	835
360	2024-11-10	1	10:00:28	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-09 09:16:28	2024-11-10 10:25:28	1028
361	2024-11-10	2	08:04:19	18	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-09 07:45:19	2024-11-10 08:20:19	229
362	2024-11-10	1	06:20:18	4	Chuẩn bị thực đơn thuần chay	2024-11-09 05:49:18	2024-11-10 06:33:18	1907
363	2024-11-10	2	05:41:28	1	Có món ăn phù hợp với người lớn tuổi	2024-11-09 05:39:28	2024-11-10 05:49:28	140
364	2024-11-10	1	06:28:58	20	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-09 06:11:58	2024-11-10 06:42:58	1619
365	2024-11-10	2	07:05:04	8	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-09 06:33:04	2024-11-10 07:28:04	287
366	2024-11-10	2	10:06:25	11	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-09 09:31:25	2024-11-10 10:17:25	1242
367	2024-11-10	1	07:24:45	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-09 07:01:45	2024-11-10 07:37:45	1481
368	2024-11-10	1	06:15:41	6	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-09 05:52:41	2024-11-10 06:26:41	1765
369	2024-11-10	2	08:10:42	7	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-09 08:05:42	2024-11-10 08:10:42	1231
370	2024-11-10	1	07:14:28	2	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-09 07:03:28	2024-11-10 07:27:28	743
371	2024-11-10	1	14:25:59	3	Không thêm muối vào các món ăn	2024-11-09 14:18:59	2024-11-10 15:07:59	269
372	2024-11-10	1	11:24:53	20	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-09 11:07:53	2024-11-10 11:35:53	470
373	2024-11-10	2	17:54:35	1	Không dùng món ăn quá cay	2024-11-09 17:22:35	2024-11-10 18:19:35	1995
374	2024-11-10	1	14:47:23	14	Không dùng món ăn quá cay	2024-11-09 14:15:23	2024-11-10 15:13:23	812
375	2024-11-10	1	15:17:42	4	Thêm một đĩa trái cây cho trẻ em	2024-11-09 14:44:42	2024-11-10 16:01:42	1974
376	2024-11-10	0	12:56:00	2	Dành chỗ ngồi cho nhóm 10 người	2024-11-09 12:25:00	2024-11-10 13:08:00	1409
377	2024-11-10	1	11:39:38	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-09 11:19:38	2024-11-10 12:14:38	1679
378	2024-11-10	1	13:28:11	13	Bàn gần cửa sổ để ngắm cảnh	2024-11-09 13:05:11	2024-11-10 13:58:11	1466
379	2024-11-10	1	13:12:12	16	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-09 13:05:12	2024-11-10 13:33:12	1728
380	2024-11-10	1	14:13:02	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-09 13:57:02	2024-11-10 14:45:02	1182
381	2024-11-10	0	16:19:52	4	Thêm một đĩa trái cây cho trẻ em	2024-11-09 15:39:52	2024-11-10 16:59:52	1258
382	2024-11-10	2	11:18:36	20	Chuẩn bị thực đơn thuần chay	2024-11-09 10:42:36	2024-11-10 11:35:36	1128
383	2024-11-10	1	19:55:30	7	Cung cấp thực đơn không chứa gluten	2024-11-09 19:42:30	2024-11-10 20:23:30	62
384	2024-11-10	1	19:48:19	9	Thêm một đĩa trái cây cho trẻ em	2024-11-09 19:20:19	2024-11-10 20:31:19	565
385	2024-11-10	2	18:37:56	14	Không dùng hành hoặc tỏi trong món ăn	2024-11-09 17:58:56	2024-11-10 18:38:56	1269
386	2024-11-10	1	20:27:08	20	Chuẩn bị thực đơn thuần chay	2024-11-09 20:09:08	2024-11-10 21:07:08	21
387	2024-11-10	1	21:24:55	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-09 20:50:55	2024-11-10 22:04:55	1437
388	2024-11-10	1	20:01:09	16	Thêm một đĩa trái cây cho trẻ em	2024-11-09 19:24:09	2024-11-10 20:19:09	3
389	2024-11-10	1	20:01:36	1	Cung cấp thực đơn không chứa gluten	2024-11-09 19:40:36	2024-11-10 20:37:36	1947
390	2024-11-10	1	21:39:12	20	Thêm một đĩa trái cây cho trẻ em	2024-11-09 20:59:12	2024-11-10 22:23:12	1729
391	2024-11-10	1	18:28:40	9	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-09 18:17:40	2024-11-10 18:55:40	634
392	2024-11-10	2	20:40:04	9	Không thêm muối vào các món ăn	2024-11-09 19:58:04	2024-11-10 20:53:04	171
393	2024-11-10	1	19:49:48	3	Không dùng món ăn quá cay	2024-11-09 19:13:48	2024-11-10 20:26:48	701
394	2024-11-10	1	18:34:22	13	Thêm chỗ để xe đẩy cho trẻ em	2024-11-09 18:29:22	2024-11-10 18:49:22	868
395	2024-11-10	2	21:00:10	14	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-09 20:43:10	2024-11-10 21:40:10	1024
396	2024-11-10	2	18:18:29	6	Dọn sẵn đĩa và dao cắt bánh	2024-11-09 18:02:29	2024-11-10 18:18:29	1865
397	2024-11-10	2	20:35:06	15	Chuẩn bị thực đơn thuần chay	2024-11-09 20:32:06	2024-11-10 20:50:06	967
398	2024-11-10	2	18:54:29	15	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-09 18:49:29	2024-11-10 19:02:29	1755
399	2024-11-10	1	22:52:40	16	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-09 22:21:40	2024-11-10 23:04:40	1485
400	2024-11-11	1	05:24:54	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-10 04:58:54	2024-11-11 05:50:54	1094
401	2024-11-11	0	05:44:59	2	Cung cấp thực đơn không chứa gluten	2024-11-10 05:31:59	2024-11-11 05:54:59	1915
402	2024-11-11	1	05:44:02	9	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-10 05:03:02	2024-11-11 06:20:02	409
403	2024-11-11	1	09:48:53	3	Không dùng hành hoặc tỏi trong món ăn	2024-11-10 09:14:53	2024-11-11 10:09:53	776
404	2024-11-11	1	06:25:56	7	Dành chỗ ngồi cho nhóm 10 người	2024-11-10 06:16:56	2024-11-11 06:43:56	1381
405	2024-11-11	1	08:37:02	5	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-10 08:05:02	2024-11-11 09:10:02	1916
406	2024-11-11	2	10:11:00	5	Thêm chỗ để xe đẩy cho trẻ em	2024-11-10 09:30:00	2024-11-11 10:27:00	1120
407	2024-11-11	2	08:22:05	13	Thêm một đĩa trái cây cho trẻ em	2024-11-10 07:39:05	2024-11-11 08:46:05	1001
408	2024-11-11	1	09:05:15	4	Không dùng món ăn quá cay	2024-11-10 08:57:15	2024-11-11 09:08:15	599
409	2024-11-11	1	10:14:20	3	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-10 10:12:20	2024-11-11 10:51:20	784
410	2024-11-11	2	09:55:58	15	Có món ăn phù hợp với người lớn tuổi	2024-11-10 09:42:58	2024-11-11 10:23:58	1938
411	2024-11-11	1	11:49:15	8	Không dùng hành hoặc tỏi trong món ăn	2024-11-10 11:48:15	2024-11-11 12:34:15	1333
412	2024-11-11	1	16:38:11	11	Dành chỗ ngồi cho nhóm 10 người	2024-11-10 16:27:11	2024-11-11 16:50:11	1793
413	2024-11-11	1	16:46:04	5	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-10 16:17:04	2024-11-11 16:52:04	1356
414	2024-11-11	1	16:02:48	6	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-10 16:00:48	2024-11-11 16:41:48	1744
415	2024-11-11	0	16:34:38	1	Thêm một đĩa trái cây cho trẻ em	2024-11-10 16:09:38	2024-11-11 17:18:38	409
416	2024-11-11	2	14:33:49	11	Dành chỗ ngồi cho nhóm 10 người	2024-11-10 14:32:49	2024-11-11 14:59:49	766
417	2024-11-11	2	12:47:55	14	Chuẩn bị thực đơn thuần chay	2024-11-10 12:08:55	2024-11-11 12:47:55	1699
418	2024-11-11	1	13:48:03	10	Dành chỗ ngồi cho nhóm 10 người	2024-11-10 13:12:03	2024-11-11 14:09:03	145
419	2024-11-11	1	15:47:57	20		2024-11-10 15:21:57	2024-11-11 16:00:57	987
420	2024-11-11	1	12:28:42	16	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-10 12:05:42	2024-11-11 12:56:42	1612
421	2024-11-11	1	16:11:37	1	Thêm một đĩa trái cây cho trẻ em	2024-11-10 16:07:37	2024-11-11 16:13:37	1054
422	2024-11-11	2	16:04:50	1	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-10 15:36:50	2024-11-11 16:39:50	721
423	2024-11-11	2	20:45:19	7	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-10 20:31:19	2024-11-11 21:23:19	401
424	2024-11-11	1	21:40:31	16	Không dùng món ăn quá cay	2024-11-10 21:22:31	2024-11-11 21:56:31	466
425	2024-11-11	1	20:46:48	1	Dành chỗ ngồi cho nhóm 10 người	2024-11-10 20:08:48	2024-11-11 21:22:48	1123
426	2024-11-11	1	21:19:57	4	Bàn gần cửa sổ để ngắm cảnh	2024-11-10 21:04:57	2024-11-11 21:46:57	1686
427	2024-11-11	1	18:16:14	7	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-10 17:41:14	2024-11-11 18:49:14	758
428	2024-11-11	1	19:45:51	19	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-10 19:22:51	2024-11-11 20:29:51	829
429	2024-11-11	1	19:21:13	12	Không dùng món ăn quá cay	2024-11-10 19:06:13	2024-11-11 20:03:13	406
430	2024-11-11	1	19:19:15	13	Cung cấp thực đơn không chứa gluten	2024-11-10 18:52:15	2024-11-11 19:44:15	156
431	2024-11-11	1	20:59:16	4	Thêm chỗ để xe đẩy cho trẻ em	2024-11-10 20:27:16	2024-11-11 21:04:16	1573
432	2024-11-11	1	20:07:22	14	Không thêm muối vào các món ăn	2024-11-10 19:48:22	2024-11-11 20:43:22	1800
433	2024-11-11	1	21:46:43	3	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-10 21:14:43	2024-11-11 21:50:43	1220
434	2024-11-11	1	19:57:40	8		2024-11-10 19:36:40	2024-11-11 20:38:40	270
435	2024-11-11	2	21:38:33	4	Có món ăn phù hợp với người lớn tuổi	2024-11-10 21:30:33	2024-11-11 21:49:33	173
436	2024-11-11	1	19:32:19	8	Thêm chỗ để xe đẩy cho trẻ em	2024-11-10 18:55:19	2024-11-11 19:57:19	1170
437	2024-11-11	1	18:29:35	15	Thêm chỗ để xe đẩy cho trẻ em	2024-11-10 18:25:35	2024-11-11 19:08:35	716
438	2024-11-11	2	19:43:35	9	Không thêm muối vào các món ăn	2024-11-10 19:41:35	2024-11-11 20:27:35	1098
439	2024-11-12	0	00:08:24	9	Có món ăn phù hợp với người lớn tuổi	2024-11-11 00:03:24	2024-11-12 00:52:24	1955
440	2024-11-12	1	05:26:10	11	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-11 04:43:10	2024-11-12 06:09:10	957
441	2024-11-12	1	10:51:02	19	Có món ăn phù hợp với người lớn tuổi	2024-11-11 10:30:02	2024-11-12 11:20:02	1339
442	2024-11-12	1	05:30:08	14	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-11 04:52:08	2024-11-12 05:56:08	176
443	2024-11-12	1	07:42:35	18	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-11 07:06:35	2024-11-12 07:45:35	1264
444	2024-11-12	1	08:55:44	2	Dọn sẵn đĩa và dao cắt bánh	2024-11-11 08:28:44	2024-11-12 09:29:44	309
445	2024-11-12	1	08:44:09	10	Không dùng món ăn quá cay	2024-11-11 08:31:09	2024-11-12 09:21:09	1707
446	2024-11-12	1	07:30:23	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-11 07:00:23	2024-11-12 07:34:23	1933
447	2024-11-12	1	08:35:16	4	Chuẩn bị thực đơn thuần chay	2024-11-11 08:10:16	2024-11-12 08:57:16	92
448	2024-11-12	1	06:58:32	17	Dọn sẵn đĩa và dao cắt bánh	2024-11-11 06:45:32	2024-11-12 07:25:32	1846
449	2024-11-12	1	10:21:58	2	Không dùng hành hoặc tỏi trong món ăn	2024-11-11 10:03:58	2024-11-12 10:26:58	162
450	2024-11-12	2	10:34:03	15	Cung cấp thực đơn không chứa gluten	2024-11-11 09:59:03	2024-11-12 10:43:03	1886
451	2024-11-12	1	13:15:20	3		2024-11-11 12:53:20	2024-11-12 13:53:20	1201
452	2024-11-12	2	14:12:43	4	Thêm chỗ để xe đẩy cho trẻ em	2024-11-11 13:51:43	2024-11-12 14:20:43	270
453	2024-11-12	2	11:36:28	7	Thêm một đĩa trái cây cho trẻ em	2024-11-11 10:55:28	2024-11-12 12:19:28	592
454	2024-11-12	1	17:06:28	6	Dành chỗ ngồi cho nhóm 10 người	2024-11-11 16:53:28	2024-11-12 17:31:28	709
455	2024-11-12	1	11:08:28	3		2024-11-11 10:33:28	2024-11-12 11:41:28	1837
456	2024-11-12	1	17:13:33	4	Thêm một đĩa trái cây cho trẻ em	2024-11-11 16:57:33	2024-11-12 17:14:33	1227
457	2024-11-12	2	13:10:35	2	Không thêm muối vào các món ăn	2024-11-11 13:08:35	2024-11-12 13:35:35	1742
458	2024-11-12	1	17:14:47	1	Không dùng hành hoặc tỏi trong món ăn	2024-11-11 16:58:47	2024-11-12 17:36:47	344
459	2024-11-12	1	13:50:43	11	Không thêm muối vào các món ăn	2024-11-11 13:43:43	2024-11-12 14:06:43	1691
460	2024-11-12	1	12:45:32	16	Không dùng hành hoặc tỏi trong món ăn	2024-11-11 12:25:32	2024-11-12 12:49:32	321
461	2024-11-12	1	11:43:02	1	Thêm chỗ để xe đẩy cho trẻ em	2024-11-11 11:33:02	2024-11-12 12:26:02	1058
462	2024-11-12	0	13:53:42	3	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-11 13:15:42	2024-11-12 14:27:42	1034
463	2024-11-12	1	18:06:55	4	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-11 17:41:55	2024-11-12 18:09:55	62
464	2024-11-12	1	20:11:02	5	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-11 19:32:02	2024-11-12 20:17:02	293
465	2024-11-12	1	20:38:47	16	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-11 20:38:47	2024-11-12 21:14:47	1128
466	2024-11-12	2	19:40:35	6	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-11 19:06:35	2024-11-12 20:05:35	838
467	2024-11-12	1	21:15:06	2	Bàn gần cửa sổ để ngắm cảnh	2024-11-11 21:08:06	2024-11-12 21:57:06	1982
468	2024-11-12	2	20:35:33	3	Bàn gần cửa sổ để ngắm cảnh	2024-11-11 19:57:33	2024-11-12 21:13:33	1689
469	2024-11-12	1	20:02:01	5	Có món ăn phù hợp với người lớn tuổi	2024-11-11 19:30:01	2024-11-12 20:15:01	753
470	2024-11-12	1	18:41:48	19	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-11 18:33:48	2024-11-12 19:24:48	1451
471	2024-11-12	2	20:16:09	4	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-11 19:58:09	2024-11-12 20:56:09	715
472	2024-11-12	1	20:04:36	16	Thêm chỗ để xe đẩy cho trẻ em	2024-11-11 19:21:36	2024-11-12 20:13:36	1771
473	2024-11-12	1	21:15:18	2	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-11 20:47:18	2024-11-12 21:37:18	1815
474	2024-11-12	0	21:50:19	7	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-11 21:27:19	2024-11-12 22:03:19	760
475	2024-11-12	2	18:44:26	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-11 18:02:26	2024-11-12 19:05:26	878
476	2024-11-12	1	19:25:51	7		2024-11-11 19:19:51	2024-11-12 19:26:51	1265
477	2024-11-12	1	20:39:31	16	Không dùng hành hoặc tỏi trong món ăn	2024-11-11 20:10:31	2024-11-12 21:16:31	1940
478	2024-11-12	2	18:57:42	7	Có món ăn phù hợp với người lớn tuổi	2024-11-11 18:55:42	2024-11-12 19:01:42	1314
479	2024-11-12	1	23:36:56	13	Dành chỗ ngồi cho nhóm 10 người	2024-11-11 23:02:56	2024-11-13 00:21:56	503
480	2024-11-13	1	10:03:43	15	Chuẩn bị thực đơn thuần chay	2024-11-12 10:03:43	2024-11-13 10:03:43	779
481	2024-11-13	1	06:07:56	16	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-12 06:02:56	2024-11-13 06:09:56	1103
482	2024-11-13	1	09:16:16	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-12 09:10:16	2024-11-13 09:27:16	1221
483	2024-11-13	1	09:35:17	6	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-12 08:58:17	2024-11-13 09:37:17	168
484	2024-11-13	1	06:41:23	3	Bàn gần cửa sổ để ngắm cảnh	2024-11-12 06:18:23	2024-11-13 07:25:23	1342
485	2024-11-13	1	05:46:23	2	Thêm một đĩa trái cây cho trẻ em	2024-11-12 05:42:23	2024-11-13 06:16:23	1789
486	2024-11-13	1	05:14:04	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-12 04:39:04	2024-11-13 05:18:04	1946
487	2024-11-13	1	07:37:04	7	Chuẩn bị thực đơn thuần chay	2024-11-12 07:29:04	2024-11-13 07:48:04	611
488	2024-11-13	1	09:24:34	13	Có món ăn phù hợp với người lớn tuổi	2024-11-12 08:52:34	2024-11-13 10:02:34	1864
489	2024-11-13	1	08:25:01	12	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-12 07:45:01	2024-11-13 08:33:01	1897
490	2024-11-13	1	07:34:39	10	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-12 07:09:39	2024-11-13 07:38:39	1725
491	2024-11-13	1	11:49:46	19	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-12 11:09:46	2024-11-13 12:17:46	1537
492	2024-11-13	1	12:17:56	5		2024-11-12 11:49:56	2024-11-13 12:40:56	806
493	2024-11-13	1	11:35:57	17	Thêm một đĩa trái cây cho trẻ em	2024-11-12 10:56:57	2024-11-13 11:50:57	49
494	2024-11-13	0	15:11:59	4	Bàn gần cửa sổ để ngắm cảnh	2024-11-12 14:52:59	2024-11-13 15:44:59	47
495	2024-11-13	2	11:02:00	3	Bàn gần cửa sổ để ngắm cảnh	2024-11-12 10:38:00	2024-11-13 11:38:00	77
496	2024-11-13	0	12:37:46	3	Dành chỗ ngồi cho nhóm 10 người	2024-11-12 12:12:46	2024-11-13 13:12:46	299
497	2024-11-13	1	16:30:36	8	Không dùng món ăn quá cay	2024-11-12 15:48:36	2024-11-13 16:36:36	1362
498	2024-11-13	1	11:17:34	8	Cung cấp thực đơn không chứa gluten	2024-11-12 10:39:34	2024-11-13 11:53:34	1186
499	2024-11-13	1	16:18:25	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-12 15:59:25	2024-11-13 16:53:25	426
500	2024-11-13	1	16:45:31	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-12 16:28:31	2024-11-13 17:27:31	753
501	2024-11-13	1	16:30:58	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-12 16:01:58	2024-11-13 17:01:58	226
502	2024-11-13	0	16:29:14	13	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-12 16:19:14	2024-11-13 17:04:14	1162
503	2024-11-13	1	20:00:42	9	Có món ăn phù hợp với người lớn tuổi	2024-11-12 19:20:42	2024-11-13 20:15:42	1995
504	2024-11-13	1	19:49:41	4	Thêm một đĩa trái cây cho trẻ em	2024-11-12 19:16:41	2024-11-13 20:04:41	1328
505	2024-11-13	1	19:10:42	13	Thêm một đĩa trái cây cho trẻ em	2024-11-12 19:03:42	2024-11-13 19:13:42	1756
506	2024-11-13	1	18:17:42	9	Có món ăn phù hợp với người lớn tuổi	2024-11-12 18:14:42	2024-11-13 18:38:42	1757
507	2024-11-13	1	19:07:56	17	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-12 18:45:56	2024-11-13 19:39:56	1851
508	2024-11-13	2	19:04:15	7	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-12 18:20:15	2024-11-13 19:30:15	1139
509	2024-11-13	2	18:37:41	18	Không dùng món ăn quá cay	2024-11-12 18:01:41	2024-11-13 18:59:41	1311
510	2024-11-13	2	21:10:49	11	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-12 20:55:49	2024-11-13 21:49:49	341
511	2024-11-13	1	20:56:39	3	Bàn gần cửa sổ để ngắm cảnh	2024-11-12 20:47:39	2024-11-13 21:34:39	1234
512	2024-11-13	1	19:37:42	7	Thêm chỗ để xe đẩy cho trẻ em	2024-11-12 19:36:42	2024-11-13 20:14:42	1944
513	2024-11-13	1	19:45:45	5	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-12 19:04:45	2024-11-13 20:05:45	182
514	2024-11-13	1	21:03:55	4	Cung cấp thực đơn không chứa gluten	2024-11-12 20:50:55	2024-11-13 21:43:55	712
515	2024-11-13	1	18:22:38	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-12 17:58:38	2024-11-13 18:52:38	1184
516	2024-11-13	1	21:20:25	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-12 20:41:25	2024-11-13 22:03:25	290
517	2024-11-13	2	19:46:04	17	Có món ăn phù hợp với người lớn tuổi	2024-11-12 19:21:04	2024-11-13 20:30:04	1252
518	2024-11-13	0	21:21:08	19	Cung cấp thực đơn không chứa gluten	2024-11-12 21:18:08	2024-11-13 21:21:08	1551
519	2024-11-14	1	01:24:27	3	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-13 01:10:27	2024-11-14 02:00:27	1725
520	2024-11-14	1	06:46:01	2		2024-11-13 06:03:01	2024-11-14 07:11:01	452
521	2024-11-14	2	07:09:10	12	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-13 06:46:10	2024-11-14 07:30:10	1657
522	2024-11-14	2	09:53:17	4	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-13 09:12:17	2024-11-14 10:35:17	1323
523	2024-11-14	0	06:25:00	16	Bàn gần cửa sổ để ngắm cảnh	2024-11-13 06:17:00	2024-11-14 06:41:00	343
524	2024-11-14	1	08:19:33	16	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-13 07:38:33	2024-11-14 08:29:33	44
525	2024-11-14	1	09:29:59	17	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-13 09:28:59	2024-11-14 10:06:59	228
526	2024-11-14	2	08:20:45	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-13 08:04:45	2024-11-14 08:24:45	713
527	2024-11-14	1	07:37:08	8	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-13 06:55:08	2024-11-14 08:16:08	1503
528	2024-11-14	1	10:22:28	1		2024-11-13 10:12:28	2024-11-14 10:50:28	1733
529	2024-11-14	2	06:23:45	16	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-13 06:17:45	2024-11-14 06:57:45	1605
530	2024-11-14	0	06:03:41	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-13 05:45:41	2024-11-14 06:03:41	124
531	2024-11-14	1	11:59:03	17	Thêm một đĩa trái cây cho trẻ em	2024-11-13 11:16:03	2024-11-14 12:17:03	187
532	2024-11-14	2	14:29:57	9	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-13 14:11:57	2024-11-14 15:05:57	1441
533	2024-11-14	1	14:02:39	19	Không dùng món ăn quá cay	2024-11-13 13:18:39	2024-11-14 14:44:39	380
534	2024-11-14	1	16:39:53	3	Dành chỗ ngồi cho nhóm 10 người	2024-11-13 16:11:53	2024-11-14 17:06:53	1637
535	2024-11-14	1	12:05:42	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-13 11:49:42	2024-11-14 12:33:42	668
536	2024-11-14	1	12:45:49	5	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-13 12:41:49	2024-11-14 13:19:49	899
537	2024-11-14	1	13:54:00	1	Không dùng hành hoặc tỏi trong món ăn	2024-11-13 13:36:00	2024-11-14 14:26:00	1897
538	2024-11-14	0	17:42:47	9	Chuẩn bị thực đơn thuần chay	2024-11-13 17:07:47	2024-11-14 18:11:47	691
539	2024-11-14	1	17:35:42	3	Bàn gần cửa sổ để ngắm cảnh	2024-11-13 17:20:42	2024-11-14 18:04:42	204
540	2024-11-14	1	14:15:59	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-13 13:40:59	2024-11-14 14:56:59	1794
541	2024-11-14	0	11:02:54	2	Có món ăn phù hợp với người lớn tuổi	2024-11-13 10:22:54	2024-11-14 11:20:54	170
542	2024-11-14	2	14:23:09	20	Dành chỗ ngồi cho nhóm 10 người	2024-11-13 13:50:09	2024-11-14 14:37:09	1819
543	2024-11-14	1	19:21:14	15	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-13 18:47:14	2024-11-14 19:43:14	1937
544	2024-11-14	1	21:51:40	2	Cung cấp thực đơn không chứa gluten	2024-11-13 21:28:40	2024-11-14 22:24:40	1826
545	2024-11-14	1	19:20:25	13	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-13 18:37:25	2024-11-14 19:36:25	869
546	2024-11-14	2	21:02:55	1	Dành chỗ ngồi cho nhóm 10 người	2024-11-13 20:31:55	2024-11-14 21:31:55	191
547	2024-11-14	1	19:44:06	3	Không dùng món ăn quá cay	2024-11-13 19:17:06	2024-11-14 20:11:06	796
548	2024-11-14	2	18:08:16	6	Thêm một đĩa trái cây cho trẻ em	2024-11-13 17:35:16	2024-11-14 18:09:16	1164
549	2024-11-14	1	21:56:28	15	Không thêm muối vào các món ăn	2024-11-13 21:49:28	2024-11-14 22:15:28	257
550	2024-11-14	2	18:10:49	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-13 17:42:49	2024-11-14 18:15:49	1456
551	2024-11-14	2	19:18:10	3	Dọn sẵn đĩa và dao cắt bánh	2024-11-13 18:48:10	2024-11-14 19:44:10	788
552	2024-11-14	1	19:59:43	18	Dành chỗ ngồi cho nhóm 10 người	2024-11-13 19:29:43	2024-11-14 20:14:43	1394
553	2024-11-14	0	21:10:33	17	Không thêm muối vào các món ăn	2024-11-13 21:02:33	2024-11-14 21:11:33	940
554	2024-11-14	2	19:44:38	10	Bàn gần cửa sổ để ngắm cảnh	2024-11-13 19:21:38	2024-11-14 20:28:38	382
555	2024-11-14	1	18:38:59	15	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-13 18:22:59	2024-11-14 19:07:59	1866
556	2024-11-14	1	21:55:28	2	Thêm chỗ để xe đẩy cho trẻ em	2024-11-13 21:23:28	2024-11-14 22:18:28	542
557	2024-11-14	2	20:49:53	7	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-13 20:49:53	2024-11-14 21:15:53	1075
558	2024-11-14	1	20:45:13	13	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-13 20:19:13	2024-11-14 21:11:13	226
559	2024-11-14	1	23:44:03	11	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-13 23:05:03	2024-11-14 23:55:03	233
560	2024-11-15	1	10:36:07	12	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-14 10:19:07	2024-11-15 10:46:07	607
561	2024-11-15	1	07:11:19	15	Thêm chỗ để xe đẩy cho trẻ em	2024-11-14 07:06:19	2024-11-15 07:44:19	28
562	2024-11-15	1	08:21:28	9	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-14 07:49:28	2024-11-15 08:58:28	408
563	2024-11-15	2	06:32:33	5	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-14 06:03:33	2024-11-15 06:40:33	1434
564	2024-11-15	1	06:43:43	2		2024-11-14 06:32:43	2024-11-15 06:59:43	1511
565	2024-11-15	2	09:13:56	7	Chuẩn bị thực đơn thuần chay	2024-11-14 09:09:56	2024-11-15 09:29:56	1007
566	2024-11-15	1	06:34:07	5	Không dùng hành hoặc tỏi trong món ăn	2024-11-14 05:56:07	2024-11-15 06:47:07	300
567	2024-11-15	1	07:05:09	1	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-14 06:50:09	2024-11-15 07:39:09	1650
568	2024-11-15	1	05:26:37	19	Thêm chỗ để xe đẩy cho trẻ em	2024-11-14 04:46:37	2024-11-15 06:01:37	1261
569	2024-11-15	1	07:43:06	10	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-14 07:37:06	2024-11-15 08:00:06	1167
570	2024-11-15	2	06:28:46	2	Bàn gần cửa sổ để ngắm cảnh	2024-11-14 06:23:46	2024-11-15 06:49:46	965
571	2024-11-15	0	13:43:55	1	Thêm một đĩa trái cây cho trẻ em	2024-11-14 13:33:55	2024-11-15 14:08:55	1289
572	2024-11-15	1	17:57:11	4	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-14 17:34:11	2024-11-15 18:28:11	1499
573	2024-11-15	1	13:47:29	12	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-14 13:26:29	2024-11-15 14:18:29	344
574	2024-11-15	1	13:07:41	17	Thêm chỗ để xe đẩy cho trẻ em	2024-11-14 12:30:41	2024-11-15 13:14:41	1733
575	2024-11-15	0	13:52:51	16	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-14 13:14:51	2024-11-15 14:03:51	1203
576	2024-11-15	1	17:20:02	18	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-14 16:58:02	2024-11-15 17:53:02	1285
577	2024-11-15	1	14:21:59	11	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-14 13:55:59	2024-11-15 14:29:59	1265
578	2024-11-15	1	14:51:34	2	Dành chỗ ngồi cho nhóm 10 người	2024-11-14 14:21:34	2024-11-15 15:22:34	1881
579	2024-11-15	1	11:57:40	4	Thêm chỗ để xe đẩy cho trẻ em	2024-11-14 11:38:40	2024-11-15 12:03:40	1695
580	2024-11-15	2	11:43:21	4	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-14 11:29:21	2024-11-15 11:50:21	548
581	2024-11-15	1	11:52:23	18	Cung cấp thực đơn không chứa gluten	2024-11-14 11:43:23	2024-11-15 12:14:23	628
582	2024-11-15	1	16:14:34	12	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-14 16:12:34	2024-11-15 16:42:34	138
583	2024-11-15	1	21:34:44	4	Không dùng món ăn quá cay	2024-11-14 21:06:44	2024-11-15 22:01:44	604
584	2024-11-15	1	18:30:19	8	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-14 18:25:19	2024-11-15 18:56:19	1831
585	2024-11-15	1	20:50:02	3	Chuẩn bị thực đơn thuần chay	2024-11-14 20:09:02	2024-11-15 20:53:02	418
586	2024-11-15	1	19:13:32	1	Bàn gần cửa sổ để ngắm cảnh	2024-11-14 19:06:32	2024-11-15 19:31:32	988
587	2024-11-15	1	18:36:35	16	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-14 18:28:35	2024-11-15 19:02:35	699
588	2024-11-15	0	18:55:47	2	Không dùng món ăn quá cay	2024-11-14 18:34:47	2024-11-15 19:01:47	1043
589	2024-11-15	1	18:05:46	1	Bàn gần cửa sổ để ngắm cảnh	2024-11-14 17:33:46	2024-11-15 18:16:46	1683
590	2024-11-15	0	21:55:25	3	Có món ăn phù hợp với người lớn tuổi	2024-11-14 21:48:25	2024-11-15 21:55:25	99
591	2024-11-15	0	18:16:05	4	Thêm một đĩa trái cây cho trẻ em	2024-11-14 17:51:05	2024-11-15 18:16:05	1198
592	2024-11-15	0	21:27:20	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-14 20:47:20	2024-11-15 21:41:20	504
593	2024-11-15	1	21:17:21	17	Không dùng hành hoặc tỏi trong món ăn	2024-11-14 21:08:21	2024-11-15 22:02:21	1797
594	2024-11-15	1	18:34:10	1	Bàn gần cửa sổ để ngắm cảnh	2024-11-14 18:27:10	2024-11-15 18:54:10	1001
595	2024-11-15	2	19:05:04	4	Thêm chỗ để xe đẩy cho trẻ em	2024-11-14 18:41:04	2024-11-15 19:31:04	258
596	2024-11-15	1	21:45:02	3	Dành chỗ ngồi cho nhóm 10 người	2024-11-14 21:03:02	2024-11-15 22:00:02	670
597	2024-11-15	0	18:02:18	10		2024-11-14 17:27:18	2024-11-15 18:06:18	652
598	2024-11-15	1	18:34:39	3	Không dùng hành hoặc tỏi trong món ăn	2024-11-14 18:23:39	2024-11-15 18:35:39	1712
599	2024-11-15	2	22:29:10	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-14 21:55:10	2024-11-15 23:08:10	851
600	2024-11-16	1	07:51:35	7	Có món ăn phù hợp với người lớn tuổi	2024-11-15 07:28:35	2024-11-16 08:24:35	1592
601	2024-11-16	1	05:01:49	3	Dọn sẵn đĩa và dao cắt bánh	2024-11-15 04:48:49	2024-11-16 05:27:49	968
602	2024-11-16	1	08:55:16	2	Không dùng hành hoặc tỏi trong món ăn	2024-11-15 08:53:16	2024-11-16 09:19:16	646
603	2024-11-16	2	08:28:28	15	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-15 08:24:28	2024-11-16 08:44:28	794
604	2024-11-16	1	06:02:57	1	Cung cấp thực đơn không chứa gluten	2024-11-15 06:00:57	2024-11-16 06:02:57	1789
605	2024-11-16	1	07:23:29	4	Dọn sẵn đĩa và dao cắt bánh	2024-11-15 07:23:29	2024-11-16 07:54:29	654
606	2024-11-16	2	05:18:47	6	Cung cấp thực đơn không chứa gluten	2024-11-15 04:41:47	2024-11-16 05:33:47	388
607	2024-11-16	2	05:23:52	4	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-15 05:22:52	2024-11-16 06:00:52	567
608	2024-11-16	1	05:28:19	5	Không dùng hành hoặc tỏi trong món ăn	2024-11-15 05:01:19	2024-11-16 05:29:19	1646
609	2024-11-16	2	07:56:34	11	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-15 07:47:34	2024-11-16 08:22:34	612
610	2024-11-16	1	05:11:34	4	Có món ăn phù hợp với người lớn tuổi	2024-11-15 05:01:34	2024-11-16 05:48:34	1488
611	2024-11-16	1	15:30:14	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-15 15:30:14	2024-11-16 15:53:14	1942
612	2024-11-16	1	13:17:25	12	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-15 12:40:25	2024-11-16 13:56:25	1177
613	2024-11-16	1	13:07:19	3	Không dùng món ăn quá cay	2024-11-15 12:46:19	2024-11-16 13:48:19	1235
614	2024-11-16	1	15:17:51	16	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-15 14:44:51	2024-11-16 16:00:51	1853
615	2024-11-16	1	16:27:01	17	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-15 15:46:01	2024-11-16 17:11:01	1870
616	2024-11-16	1	16:28:42	9	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-15 16:28:42	2024-11-16 16:42:42	503
617	2024-11-16	1	14:33:39	4	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-15 14:25:39	2024-11-16 14:42:39	1740
618	2024-11-16	2	14:59:24	3	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-15 14:45:24	2024-11-16 15:24:24	703
619	2024-11-16	1	16:06:54	1	Cung cấp thực đơn không chứa gluten	2024-11-15 15:22:54	2024-11-16 16:32:54	1045
620	2024-11-16	1	14:34:21	20	Bàn gần cửa sổ để ngắm cảnh	2024-11-15 13:51:21	2024-11-16 14:34:21	390
621	2024-11-16	1	12:08:26	9	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-15 12:01:26	2024-11-16 12:28:26	551
622	2024-11-16	1	15:23:48	1	Không thêm muối vào các món ăn	2024-11-15 15:18:48	2024-11-16 16:04:48	164
623	2024-11-16	1	19:31:09	17	Có món ăn phù hợp với người lớn tuổi	2024-11-15 18:52:09	2024-11-16 19:44:09	1398
624	2024-11-16	1	18:19:22	7	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-15 17:59:22	2024-11-16 18:43:22	337
625	2024-11-16	0	20:31:04	1	Dành chỗ ngồi cho nhóm 10 người	2024-11-15 20:22:04	2024-11-16 20:34:04	1727
626	2024-11-16	1	19:12:02	4	Không dùng món ăn quá cay	2024-11-15 19:01:02	2024-11-16 19:44:02	1025
627	2024-11-16	1	19:15:57	20	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-15 19:09:57	2024-11-16 19:42:57	869
628	2024-11-16	1	19:39:42	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-15 19:10:42	2024-11-16 20:04:42	769
629	2024-11-16	1	18:56:05	3	Thêm một đĩa trái cây cho trẻ em	2024-11-15 18:44:05	2024-11-16 19:01:05	1920
630	2024-11-16	1	20:36:26	2	Không thêm muối vào các món ăn	2024-11-15 20:26:26	2024-11-16 20:54:26	1136
631	2024-11-16	2	18:35:44	8	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-15 17:51:44	2024-11-16 18:39:44	1623
632	2024-11-16	0	20:44:19	18	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-15 20:06:19	2024-11-16 21:27:19	880
633	2024-11-16	1	19:03:28	5	Thêm chỗ để xe đẩy cho trẻ em	2024-11-15 18:58:28	2024-11-16 19:30:28	1418
634	2024-11-16	1	18:42:52	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-15 18:36:52	2024-11-16 19:20:52	121
635	2024-11-16	1	18:41:35	4	Thêm một đĩa trái cây cho trẻ em	2024-11-15 17:57:35	2024-11-16 18:58:35	1342
636	2024-11-16	1	19:14:29	9	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-15 19:13:29	2024-11-16 19:30:29	815
637	2024-11-16	0	18:59:59	4	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-15 18:49:59	2024-11-16 19:20:59	1472
638	2024-11-16	1	19:18:37	20	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-15 19:16:37	2024-11-16 19:57:37	686
639	2024-11-16	2	23:40:42	8	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-15 23:40:42	2024-11-16 23:59:42	2000
640	2024-11-17	1	07:42:00	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-16 07:16:00	2024-11-17 07:59:00	806
641	2024-11-17	1	10:46:48	6	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-16 10:39:48	2024-11-17 11:29:48	710
642	2024-11-17	2	07:40:54	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-16 07:02:54	2024-11-17 07:47:54	819
643	2024-11-17	1	07:58:55	9	Dành chỗ ngồi cho nhóm 10 người	2024-11-16 07:38:55	2024-11-17 08:12:55	362
644	2024-11-17	2	08:04:10	4	Có món ăn phù hợp với người lớn tuổi	2024-11-16 07:59:10	2024-11-17 08:32:10	340
645	2024-11-17	1	08:00:33	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-16 07:26:33	2024-11-17 08:27:33	264
646	2024-11-17	2	10:15:50	1	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-16 09:34:50	2024-11-17 10:31:50	1431
647	2024-11-17	1	05:37:50	8	Dành chỗ ngồi cho nhóm 10 người	2024-11-16 05:16:50	2024-11-17 05:58:50	530
648	2024-11-17	0	07:37:17	1	Cung cấp thực đơn không chứa gluten	2024-11-16 07:22:17	2024-11-17 08:01:17	1740
649	2024-11-17	1	06:48:45	3	Không thêm muối vào các món ăn	2024-11-16 06:43:45	2024-11-17 07:10:45	465
650	2024-11-17	1	08:54:20	12	Thêm chỗ để xe đẩy cho trẻ em	2024-11-16 08:19:20	2024-11-17 09:02:20	1954
651	2024-11-17	1	14:18:02	1	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-16 13:38:02	2024-11-17 14:53:02	985
652	2024-11-17	0	13:50:45	10	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-16 13:19:45	2024-11-17 14:28:45	877
653	2024-11-17	1	14:13:38	20	Thêm một đĩa trái cây cho trẻ em	2024-11-16 13:59:38	2024-11-17 14:33:38	920
654	2024-11-17	0	14:24:30	2	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-16 13:42:30	2024-11-17 14:34:30	1587
655	2024-11-17	1	16:14:29	11	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-16 15:49:29	2024-11-17 16:18:29	28
656	2024-11-17	1	14:11:37	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-16 13:57:37	2024-11-17 14:19:37	56
657	2024-11-17	2	15:06:10	18	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-16 14:47:10	2024-11-17 15:24:10	1045
658	2024-11-17	1	17:36:03	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-16 17:20:03	2024-11-17 17:54:03	104
659	2024-11-17	1	14:52:21	2	Bàn gần cửa sổ để ngắm cảnh	2024-11-16 14:42:21	2024-11-17 14:53:21	1853
660	2024-11-17	1	14:03:51	7	Có món ăn phù hợp với người lớn tuổi	2024-11-16 13:48:51	2024-11-17 14:43:51	18
661	2024-11-17	1	11:11:49	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-16 10:30:49	2024-11-17 11:47:49	1718
662	2024-11-17	1	11:05:49	6	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-16 11:04:49	2024-11-17 11:46:49	859
663	2024-11-17	2	19:13:50	4	Chuẩn bị thực đơn thuần chay	2024-11-16 18:45:50	2024-11-17 19:13:50	1978
664	2024-11-17	1	19:22:06	4	Cung cấp thực đơn không chứa gluten	2024-11-16 19:12:06	2024-11-17 20:04:06	945
665	2024-11-17	0	18:35:32	3	Dọn sẵn đĩa và dao cắt bánh	2024-11-16 18:30:32	2024-11-17 19:20:32	1683
666	2024-11-17	0	19:28:56	5	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-16 19:11:56	2024-11-17 20:08:56	1864
667	2024-11-17	1	20:43:46	11	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-16 20:12:46	2024-11-17 21:08:46	347
668	2024-11-17	1	19:06:35	16	Thêm chỗ để xe đẩy cho trẻ em	2024-11-16 18:32:35	2024-11-17 19:14:35	1833
669	2024-11-17	1	20:13:22	9	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-16 19:31:22	2024-11-17 20:38:22	612
670	2024-11-17	2	18:05:53	1		2024-11-16 17:53:53	2024-11-17 18:39:53	563
671	2024-11-17	0	20:38:47	5	Chuẩn bị thực đơn thuần chay	2024-11-16 20:36:47	2024-11-17 21:12:47	1867
672	2024-11-17	1	19:11:42	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-16 19:08:42	2024-11-17 19:48:42	506
673	2024-11-17	0	21:21:34	8	Chuẩn bị thực đơn thuần chay	2024-11-16 20:42:34	2024-11-17 21:40:34	573
674	2024-11-17	1	20:23:05	7	Không dùng hành hoặc tỏi trong món ăn	2024-11-16 20:20:05	2024-11-17 20:46:05	514
675	2024-11-17	1	18:48:57	10	Dọn sẵn đĩa và dao cắt bánh	2024-11-16 18:15:57	2024-11-17 19:09:57	505
676	2024-11-17	1	18:10:28	4	Không thêm muối vào các món ăn	2024-11-16 18:04:28	2024-11-17 18:50:28	1584
677	2024-11-17	2	19:54:20	11	Không thêm muối vào các món ăn	2024-11-16 19:28:20	2024-11-17 20:29:20	1146
678	2024-11-17	1	19:56:48	18	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-16 19:23:48	2024-11-17 19:56:48	179
679	2024-11-17	1	23:08:41	1	Không dùng hành hoặc tỏi trong món ăn	2024-11-16 23:06:41	2024-11-17 23:43:41	1361
680	2024-11-18	2	06:58:04	15	Bàn gần cửa sổ để ngắm cảnh	2024-11-17 06:31:04	2024-11-18 07:02:04	1515
681	2024-11-18	2	06:05:12	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-17 05:22:12	2024-11-18 06:08:12	78
682	2024-11-18	2	09:45:06	19	Cung cấp thực đơn không chứa gluten	2024-11-17 09:44:06	2024-11-18 10:10:06	969
683	2024-11-18	1	08:29:38	18	Chuẩn bị thực đơn thuần chay	2024-11-17 08:06:38	2024-11-18 09:07:38	1724
684	2024-11-18	0	07:05:06	1	Không dùng món ăn quá cay	2024-11-17 06:38:06	2024-11-18 07:41:06	316
685	2024-11-18	1	10:38:57	18	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-17 10:07:57	2024-11-18 11:01:57	685
686	2024-11-18	1	10:14:22	2	Không dùng hành hoặc tỏi trong món ăn	2024-11-17 09:55:22	2024-11-18 10:19:22	1804
687	2024-11-18	2	07:15:09	7	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-17 07:09:09	2024-11-18 07:44:09	1625
688	2024-11-18	1	06:40:11	12	Không dùng món ăn quá cay	2024-11-17 06:13:11	2024-11-18 06:42:11	1004
689	2024-11-18	1	09:20:25	4	Không dùng món ăn quá cay	2024-11-17 08:38:25	2024-11-18 10:05:25	902
690	2024-11-18	1	09:40:25	2		2024-11-17 09:12:25	2024-11-18 10:02:25	1516
691	2024-11-18	1	17:05:40	4	Thêm một đĩa trái cây cho trẻ em	2024-11-17 16:54:40	2024-11-18 17:09:40	1132
692	2024-11-18	1	12:02:31	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-17 11:42:31	2024-11-18 12:19:31	371
693	2024-11-18	0	13:07:23	8	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-17 12:53:23	2024-11-18 13:20:23	1155
694	2024-11-18	0	13:42:52	13	Chuẩn bị thực đơn thuần chay	2024-11-17 13:38:52	2024-11-18 13:54:52	64
695	2024-11-18	2	16:50:53	7	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-17 16:40:53	2024-11-18 16:57:53	1758
696	2024-11-18	1	13:30:28	20	Không thêm muối vào các món ăn	2024-11-17 13:20:28	2024-11-18 13:59:28	1961
697	2024-11-18	1	13:52:20	16	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-17 13:18:20	2024-11-18 14:11:20	317
698	2024-11-18	1	17:46:26	13	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-17 17:42:26	2024-11-18 17:47:26	1481
699	2024-11-18	2	15:00:03	9	Không thêm muối vào các món ăn	2024-11-17 14:38:03	2024-11-18 15:45:03	364
700	2024-11-18	1	11:51:52	14	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-17 11:20:52	2024-11-18 12:08:52	1295
701	2024-11-18	2	12:11:10	12	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-17 12:07:10	2024-11-18 12:36:10	825
702	2024-11-18	2	16:13:10	8	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-17 15:39:10	2024-11-18 16:51:10	1765
703	2024-11-18	0	21:18:32	3	Có món ăn phù hợp với người lớn tuổi	2024-11-17 20:36:32	2024-11-18 21:20:32	657
704	2024-11-18	1	19:26:33	20	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-17 19:16:33	2024-11-18 19:27:33	233
705	2024-11-18	1	18:38:19	19	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-17 18:27:19	2024-11-18 18:58:19	186
706	2024-11-18	1	21:37:36	2	Không dùng hành hoặc tỏi trong món ăn	2024-11-17 21:35:36	2024-11-18 22:07:36	1407
707	2024-11-18	1	21:28:51	15	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-17 21:03:51	2024-11-18 21:37:51	869
708	2024-11-18	1	19:38:28	13	Thêm một đĩa trái cây cho trẻ em	2024-11-17 19:23:28	2024-11-18 20:02:28	260
709	2024-11-18	1	21:19:14	9	Thêm chỗ để xe đẩy cho trẻ em	2024-11-17 20:39:14	2024-11-18 22:01:14	624
710	2024-11-18	1	19:37:12	2	Dành chỗ ngồi cho nhóm 10 người	2024-11-17 18:58:12	2024-11-18 19:54:12	579
711	2024-11-18	2	20:26:05	12	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-17 20:21:05	2024-11-18 20:38:05	1994
712	2024-11-18	1	21:13:28	17	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-17 21:06:28	2024-11-18 21:34:28	139
713	2024-11-18	1	21:24:54	8	Không dùng món ăn quá cay	2024-11-17 21:08:54	2024-11-18 21:35:54	98
714	2024-11-18	2	20:56:32	3	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-17 20:33:32	2024-11-18 21:17:32	897
715	2024-11-18	2	19:01:50	2	Không dùng hành hoặc tỏi trong món ăn	2024-11-17 18:44:50	2024-11-18 19:37:50	1462
716	2024-11-18	1	19:15:57	17		2024-11-17 18:37:57	2024-11-18 19:33:57	1404
717	2024-11-18	1	21:55:05	3	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-17 21:34:05	2024-11-18 22:27:05	215
718	2024-11-18	0	19:04:04	11	Không dùng hành hoặc tỏi trong món ăn	2024-11-17 18:28:04	2024-11-18 19:08:04	344
719	2024-11-19	1	00:23:00	8	Không dùng hành hoặc tỏi trong món ăn	2024-11-18 00:11:00	2024-11-19 01:03:00	1079
720	2024-11-19	1	06:43:49	12	Không thêm muối vào các món ăn	2024-11-18 06:00:49	2024-11-19 07:26:49	768
721	2024-11-19	1	10:48:24	3	Không dùng hành hoặc tỏi trong món ăn	2024-11-18 10:10:24	2024-11-19 11:12:24	643
722	2024-11-19	1	08:55:27	17	Dành chỗ ngồi cho nhóm 10 người	2024-11-18 08:25:27	2024-11-19 09:00:27	1542
723	2024-11-19	1	09:34:40	7	Dành chỗ ngồi cho nhóm 10 người	2024-11-18 09:16:40	2024-11-19 10:14:40	1715
724	2024-11-19	2	05:04:26	19	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-18 04:24:26	2024-11-19 05:17:26	64
725	2024-11-19	0	06:13:52	14	Có món ăn phù hợp với người lớn tuổi	2024-11-18 06:13:52	2024-11-19 06:33:52	441
726	2024-11-19	0	05:35:04	10	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-18 05:21:04	2024-11-19 06:01:04	1185
727	2024-11-19	0	05:30:11	3	Có món ăn phù hợp với người lớn tuổi	2024-11-18 05:14:11	2024-11-19 06:08:11	1410
728	2024-11-19	1	08:20:09	7	Chuẩn bị thực đơn thuần chay	2024-11-18 08:14:09	2024-11-19 08:44:09	874
729	2024-11-19	1	06:45:05	1	Chuẩn bị thực đơn thuần chay	2024-11-18 06:27:05	2024-11-19 07:15:05	867
730	2024-11-19	2	08:18:55	10	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-18 07:36:55	2024-11-19 08:41:55	962
731	2024-11-19	0	17:20:38	9	Không dùng hành hoặc tỏi trong món ăn	2024-11-18 16:53:38	2024-11-19 18:01:38	18
732	2024-11-19	1	12:29:32	2	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-18 11:59:32	2024-11-19 12:32:32	947
733	2024-11-19	0	11:31:12	8	Có món ăn phù hợp với người lớn tuổi	2024-11-18 11:08:12	2024-11-19 11:49:12	674
734	2024-11-19	1	17:17:57	14	Không thêm muối vào các món ăn	2024-11-18 17:08:57	2024-11-19 18:02:57	1632
735	2024-11-19	1	12:45:39	9	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-18 12:41:39	2024-11-19 12:46:39	1162
736	2024-11-19	2	11:01:52	17	Không dùng món ăn quá cay	2024-11-18 10:34:52	2024-11-19 11:39:52	1052
737	2024-11-19	2	15:17:51	14	Thêm chỗ để xe đẩy cho trẻ em	2024-11-18 14:56:51	2024-11-19 15:26:51	1744
738	2024-11-19	1	13:23:47	15	Bàn gần cửa sổ để ngắm cảnh	2024-11-18 12:43:47	2024-11-19 14:02:47	712
739	2024-11-19	1	12:46:14	9	Thêm một đĩa trái cây cho trẻ em	2024-11-18 12:03:14	2024-11-19 13:27:14	1392
740	2024-11-19	1	15:05:00	6	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-18 14:42:00	2024-11-19 15:39:00	1122
741	2024-11-19	0	13:21:08	14	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-18 12:45:08	2024-11-19 14:02:08	1225
742	2024-11-19	1	11:43:06	2	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-18 11:19:06	2024-11-19 11:46:06	1302
743	2024-11-19	1	19:02:15	6	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-18 19:02:15	2024-11-19 19:40:15	377
744	2024-11-19	0	21:16:05	8	Không dùng món ăn quá cay	2024-11-18 21:04:05	2024-11-19 21:52:05	163
745	2024-11-19	1	18:51:01	3	Thêm một đĩa trái cây cho trẻ em	2024-11-18 18:09:01	2024-11-19 19:15:01	1733
746	2024-11-19	2	18:23:56	8	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-18 17:48:56	2024-11-19 18:43:56	840
747	2024-11-19	1	18:27:37	18	Thêm chỗ để xe đẩy cho trẻ em	2024-11-18 17:49:37	2024-11-19 18:45:37	1859
748	2024-11-19	2	18:30:03	8	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-18 18:06:03	2024-11-19 18:37:03	960
749	2024-11-19	1	19:25:51	5	Dọn sẵn đĩa và dao cắt bánh	2024-11-18 18:59:51	2024-11-19 20:01:51	1638
750	2024-11-19	2	21:57:48	14	Dành chỗ ngồi cho nhóm 10 người	2024-11-18 21:27:48	2024-11-19 22:40:48	516
751	2024-11-19	1	21:32:39	18	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-18 21:02:39	2024-11-19 21:55:39	1946
752	2024-11-19	1	19:02:09	14	Chuẩn bị thực đơn thuần chay	2024-11-18 18:58:09	2024-11-19 19:22:09	1944
753	2024-11-19	1	19:45:19	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-18 19:20:19	2024-11-19 20:02:19	16
754	2024-11-19	2	19:33:01	6	Cung cấp thực đơn không chứa gluten	2024-11-18 19:13:01	2024-11-19 20:11:01	165
755	2024-11-19	2	21:52:35	4	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-18 21:49:35	2024-11-19 22:26:35	608
756	2024-11-19	2	21:30:37	2	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-18 20:46:37	2024-11-19 22:02:37	1045
757	2024-11-19	2	18:33:09	6		2024-11-18 18:25:09	2024-11-19 18:37:09	178
758	2024-11-19	1	19:20:21	15	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-18 18:52:21	2024-11-19 19:27:21	1553
759	2024-11-20	2	01:49:36	2	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-19 01:49:36	2024-11-20 02:30:36	1878
760	2024-11-20	2	10:49:15	3	Dành chỗ ngồi cho nhóm 10 người	2024-11-19 10:48:15	2024-11-20 10:52:15	688
761	2024-11-20	1	10:51:47	17	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-19 10:22:47	2024-11-20 11:06:47	1662
762	2024-11-20	2	08:25:10	12	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-19 07:53:10	2024-11-20 08:49:10	868
763	2024-11-20	1	09:25:35	3	Bàn gần cửa sổ để ngắm cảnh	2024-11-19 08:59:35	2024-11-20 09:54:35	378
764	2024-11-20	0	06:23:37	2	Không dùng món ăn quá cay	2024-11-19 05:46:37	2024-11-20 06:23:37	1270
765	2024-11-20	1	07:36:23	3	Thêm một đĩa trái cây cho trẻ em	2024-11-19 07:35:23	2024-11-20 07:49:23	1987
766	2024-11-20	1	08:39:15	3	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-19 08:37:15	2024-11-20 09:03:15	346
767	2024-11-20	1	06:46:40	5	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-19 06:09:40	2024-11-20 07:02:40	753
768	2024-11-20	1	09:29:49	7	Có món ăn phù hợp với người lớn tuổi	2024-11-19 09:17:49	2024-11-20 10:02:49	1098
769	2024-11-20	0	06:18:19	4	Chuẩn bị thực đơn thuần chay	2024-11-19 05:58:19	2024-11-20 06:29:19	822
770	2024-11-20	1	07:32:54	4	Thêm chỗ để xe đẩy cho trẻ em	2024-11-19 07:09:54	2024-11-20 08:05:54	1043
771	2024-11-20	2	14:58:10	2	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-19 14:19:10	2024-11-20 15:37:10	1226
772	2024-11-20	1	13:14:03	3	Bàn gần cửa sổ để ngắm cảnh	2024-11-19 12:41:03	2024-11-20 13:15:03	1828
773	2024-11-20	1	11:34:33	4	Thêm chỗ để xe đẩy cho trẻ em	2024-11-19 11:06:33	2024-11-20 11:52:33	429
774	2024-11-20	2	17:08:42	3	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-19 17:00:42	2024-11-20 17:47:42	1285
775	2024-11-20	1	16:41:16	4	Không thêm muối vào các món ăn	2024-11-19 16:19:16	2024-11-20 17:05:16	1453
776	2024-11-20	1	12:27:33	4		2024-11-19 11:59:33	2024-11-20 12:50:33	1808
777	2024-11-20	1	17:29:58	6	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-19 17:00:58	2024-11-20 18:01:58	1035
778	2024-11-20	1	17:14:54	20	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-19 16:56:54	2024-11-20 17:36:54	598
779	2024-11-20	0	13:32:32	3	Dành chỗ ngồi cho nhóm 10 người	2024-11-19 13:11:32	2024-11-20 13:47:32	42
780	2024-11-20	0	14:19:10	11	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-19 13:42:10	2024-11-20 14:34:10	690
781	2024-11-20	0	13:29:52	11	Có món ăn phù hợp với người lớn tuổi	2024-11-19 13:22:52	2024-11-20 13:35:52	615
782	2024-11-20	1	11:01:22	10	Cung cấp thực đơn không chứa gluten	2024-11-19 10:22:22	2024-11-20 11:30:22	624
783	2024-11-20	1	19:46:24	4	Dọn sẵn đĩa và dao cắt bánh	2024-11-19 19:07:24	2024-11-20 20:31:24	104
784	2024-11-20	1	18:51:17	5	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-19 18:14:17	2024-11-20 19:06:17	1652
785	2024-11-20	1	19:59:34	2	Không dùng hành hoặc tỏi trong món ăn	2024-11-19 19:46:34	2024-11-20 20:15:34	601
786	2024-11-20	2	20:59:34	12	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-19 20:44:34	2024-11-20 20:59:34	958
787	2024-11-20	2	19:58:12	12	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-19 19:45:12	2024-11-20 20:21:12	1450
788	2024-11-20	0	18:10:38	13	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-19 17:30:38	2024-11-20 18:39:38	406
789	2024-11-20	2	21:06:36	19	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-19 20:33:36	2024-11-20 21:16:36	1351
790	2024-11-20	0	18:29:27	17	Bàn gần cửa sổ để ngắm cảnh	2024-11-19 18:20:27	2024-11-20 19:07:27	1095
791	2024-11-20	1	20:12:35	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-19 20:03:35	2024-11-20 20:50:35	28
792	2024-11-20	2	18:35:38	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-19 18:24:38	2024-11-20 18:57:38	1885
793	2024-11-20	2	19:15:11	12	Không dùng hành hoặc tỏi trong món ăn	2024-11-19 18:47:11	2024-11-20 19:23:11	317
794	2024-11-20	0	19:25:11	9	Có món ăn phù hợp với người lớn tuổi	2024-11-19 18:47:11	2024-11-20 19:49:11	1154
795	2024-11-20	2	18:22:30	4	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-19 18:06:30	2024-11-20 18:47:30	1806
796	2024-11-20	1	19:07:03	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-19 18:57:03	2024-11-20 19:23:03	1927
797	2024-11-20	0	18:15:28	12	Chuẩn bị thực đơn thuần chay	2024-11-19 17:47:28	2024-11-20 18:15:28	346
798	2024-11-20	2	21:17:18	12	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-19 20:49:18	2024-11-20 21:52:18	34
799	2024-11-20	2	23:49:58	3	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-19 23:22:58	2024-11-20 23:56:58	1942
800	2024-11-21	1	07:03:13	3	Thêm chỗ để xe đẩy cho trẻ em	2024-11-20 06:50:13	2024-11-21 07:34:13	1757
801	2024-11-21	1	05:55:20	13	Dành chỗ ngồi cho nhóm 10 người	2024-11-20 05:20:20	2024-11-21 06:35:20	1536
802	2024-11-21	2	05:41:46	6	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-20 05:29:46	2024-11-21 05:53:46	1359
803	2024-11-21	2	08:47:38	1	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-20 08:07:38	2024-11-21 08:51:38	44
804	2024-11-21	1	06:38:35	17	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-20 06:22:35	2024-11-21 07:02:35	1672
805	2024-11-21	0	08:10:06	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-20 07:47:06	2024-11-21 08:37:06	40
806	2024-11-21	0	08:11:39	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-20 07:32:39	2024-11-21 08:56:39	1936
807	2024-11-21	1	08:55:16	6	Dọn sẵn đĩa và dao cắt bánh	2024-11-20 08:54:16	2024-11-21 09:21:16	1813
808	2024-11-21	1	09:18:49	18	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-20 09:15:49	2024-11-21 09:38:49	144
809	2024-11-21	1	06:38:23	7	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-20 06:26:23	2024-11-21 07:08:23	602
810	2024-11-21	0	08:10:40	1	Chuẩn bị thực đơn thuần chay	2024-11-20 08:00:40	2024-11-21 08:42:40	1060
811	2024-11-21	1	13:52:03	2		2024-11-20 13:24:03	2024-11-21 14:03:03	291
812	2024-11-21	1	16:16:49	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-20 15:58:49	2024-11-21 16:26:49	1839
813	2024-11-21	1	15:22:32	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-20 15:21:32	2024-11-21 15:38:32	1429
814	2024-11-21	1	17:31:45	20	Chuẩn bị thực đơn thuần chay	2024-11-20 17:29:45	2024-11-21 18:16:45	1033
815	2024-11-21	1	15:35:00	20	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-20 15:07:00	2024-11-21 15:56:00	957
816	2024-11-21	1	13:29:21	8	Không dùng hành hoặc tỏi trong món ăn	2024-11-20 12:55:21	2024-11-21 13:44:21	405
817	2024-11-21	0	11:22:15	1	Không dùng món ăn quá cay	2024-11-20 11:14:15	2024-11-21 12:04:15	1478
818	2024-11-21	2	17:39:29	5	Chuẩn bị thực đơn thuần chay	2024-11-20 17:28:29	2024-11-21 18:24:29	493
819	2024-11-21	1	11:46:26	4	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-20 11:36:26	2024-11-21 12:27:26	1688
820	2024-11-21	1	12:39:42	16	Có món ăn phù hợp với người lớn tuổi	2024-11-20 12:20:42	2024-11-21 12:54:42	1841
821	2024-11-21	0	15:34:03	19	Không dùng món ăn quá cay	2024-11-20 15:27:03	2024-11-21 16:00:03	1831
822	2024-11-21	2	16:40:45	10	Không dùng hành hoặc tỏi trong món ăn	2024-11-20 16:37:45	2024-11-21 16:54:45	1527
823	2024-11-21	1	19:32:19	13	Dọn sẵn đĩa và dao cắt bánh	2024-11-20 19:01:19	2024-11-21 19:59:19	812
824	2024-11-21	0	21:19:09	19		2024-11-20 20:44:09	2024-11-21 21:55:09	1507
825	2024-11-21	1	19:00:51	1	Có món ăn phù hợp với người lớn tuổi	2024-11-20 18:24:51	2024-11-21 19:34:51	215
826	2024-11-21	1	20:18:09	14	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-20 19:49:09	2024-11-21 21:00:09	787
827	2024-11-21	1	19:11:02	12	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-20 18:41:02	2024-11-21 19:41:02	1530
828	2024-11-21	1	20:25:41	4	Không thêm muối vào các món ăn	2024-11-20 20:10:41	2024-11-21 20:52:41	594
829	2024-11-21	1	21:27:13	3	Không dùng món ăn quá cay	2024-11-20 21:02:13	2024-11-21 21:43:13	737
830	2024-11-21	1	20:21:08	20	Không dùng món ăn quá cay	2024-11-20 20:07:08	2024-11-21 20:35:08	257
831	2024-11-21	1	18:09:49	8	Không dùng hành hoặc tỏi trong món ăn	2024-11-20 18:05:49	2024-11-21 18:13:49	979
832	2024-11-21	1	18:18:50	13	Không dùng món ăn quá cay	2024-11-20 17:38:50	2024-11-21 19:02:50	1861
833	2024-11-21	1	19:48:36	20	Không thêm muối vào các món ăn	2024-11-20 19:22:36	2024-11-21 20:00:36	1873
834	2024-11-21	1	20:12:52	7	Thêm một đĩa trái cây cho trẻ em	2024-11-20 19:51:52	2024-11-21 20:12:52	762
835	2024-11-21	1	21:16:49	1	Cung cấp thực đơn không chứa gluten	2024-11-20 20:51:49	2024-11-21 21:18:49	188
836	2024-11-21	1	21:52:24	16	Cung cấp thực đơn không chứa gluten	2024-11-20 21:16:24	2024-11-21 22:37:24	100
837	2024-11-21	2	18:03:06	11	Không dùng món ăn quá cay	2024-11-20 17:53:06	2024-11-21 18:41:06	268
838	2024-11-21	1	20:05:34	1		2024-11-20 20:00:34	2024-11-21 20:36:34	1731
839	2024-11-22	1	01:05:13	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-21 00:52:13	2024-11-22 01:46:13	1733
840	2024-11-22	2	09:35:59	5	Có món ăn phù hợp với người lớn tuổi	2024-11-21 09:35:59	2024-11-22 09:35:59	93
841	2024-11-22	2	10:47:06	11	Thêm một đĩa trái cây cho trẻ em	2024-11-21 10:08:06	2024-11-22 11:19:06	1839
842	2024-11-22	1	06:33:31	20	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-21 06:13:31	2024-11-22 07:13:31	285
843	2024-11-22	1	10:11:44	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-21 09:35:44	2024-11-22 10:36:44	1918
844	2024-11-22	2	09:05:09	5	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-21 08:38:09	2024-11-22 09:18:09	1405
845	2024-11-22	1	05:48:30	2	Chuẩn bị thực đơn thuần chay	2024-11-21 05:09:30	2024-11-22 06:10:30	471
846	2024-11-22	1	06:24:53	6	Không thêm muối vào các món ăn	2024-11-21 05:51:53	2024-11-22 06:49:53	857
847	2024-11-22	0	07:28:40	7	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-21 07:16:40	2024-11-22 08:07:40	1819
848	2024-11-22	2	09:38:34	7	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-21 09:16:34	2024-11-22 09:42:34	109
849	2024-11-22	1	05:23:39	5	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-21 04:41:39	2024-11-22 05:32:39	646
850	2024-11-22	0	05:52:06	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-21 05:37:06	2024-11-22 06:34:06	276
851	2024-11-22	1	11:50:26	17	Bàn gần cửa sổ để ngắm cảnh	2024-11-21 11:30:26	2024-11-22 11:54:26	888
852	2024-11-22	2	11:33:04	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-21 11:31:04	2024-11-22 11:58:04	1550
853	2024-11-22	1	13:40:35	2	Không dùng món ăn quá cay	2024-11-21 13:18:35	2024-11-22 14:24:35	78
854	2024-11-22	1	15:27:03	17	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-21 15:01:03	2024-11-22 15:27:03	1466
855	2024-11-22	1	15:49:39	19	Chuẩn bị thực đơn thuần chay	2024-11-21 15:31:39	2024-11-22 16:26:39	907
856	2024-11-22	1	16:19:40	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-21 15:54:40	2024-11-22 16:47:40	933
857	2024-11-22	1	13:04:26	16	Bàn gần cửa sổ để ngắm cảnh	2024-11-21 12:52:26	2024-11-22 13:43:26	671
858	2024-11-22	1	15:13:24	3	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-21 14:44:24	2024-11-22 15:53:24	467
859	2024-11-22	1	15:02:54	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-21 14:49:54	2024-11-22 15:22:54	1359
860	2024-11-22	1	13:57:48	4	Chuẩn bị thực đơn thuần chay	2024-11-21 13:30:48	2024-11-22 14:19:48	611
861	2024-11-22	1	12:26:10	19	Không thêm muối vào các món ăn	2024-11-21 12:05:10	2024-11-22 12:49:10	497
862	2024-11-22	1	14:25:55	11	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-21 13:46:55	2024-11-22 15:06:55	782
863	2024-11-22	2	20:08:17	11	Chuẩn bị thực đơn thuần chay	2024-11-21 19:54:17	2024-11-22 20:16:17	739
864	2024-11-22	2	18:25:30	8	Dành chỗ ngồi cho nhóm 10 người	2024-11-21 17:54:30	2024-11-22 18:40:30	1318
865	2024-11-22	2	19:44:30	6	Dọn sẵn đĩa và dao cắt bánh	2024-11-21 19:37:30	2024-11-22 20:27:30	102
866	2024-11-22	2	21:47:16	13	Không dùng hành hoặc tỏi trong món ăn	2024-11-21 21:42:16	2024-11-22 21:48:16	946
867	2024-11-22	1	19:26:21	8	Có món ăn phù hợp với người lớn tuổi	2024-11-21 19:14:21	2024-11-22 20:04:21	924
868	2024-11-22	1	18:22:44	2	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-21 17:38:44	2024-11-22 18:38:44	1667
869	2024-11-22	1	18:36:36	5		2024-11-21 18:01:36	2024-11-22 18:55:36	1039
870	2024-11-22	0	19:55:14	13	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-21 19:32:14	2024-11-22 20:30:14	1169
871	2024-11-22	1	19:25:00	12	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-21 18:50:00	2024-11-22 20:03:00	1471
872	2024-11-22	1	19:37:59	3	Chuẩn bị thực đơn thuần chay	2024-11-21 18:58:59	2024-11-22 19:55:59	1621
873	2024-11-22	1	20:49:54	3	Không dùng hành hoặc tỏi trong món ăn	2024-11-21 20:35:54	2024-11-22 20:56:54	1732
874	2024-11-22	2	20:34:33	3	Dọn sẵn đĩa và dao cắt bánh	2024-11-21 19:59:33	2024-11-22 21:10:33	262
875	2024-11-22	2	21:33:11	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-21 20:58:11	2024-11-22 22:08:11	1862
876	2024-11-22	2	18:29:43	17	Không thêm muối vào các món ăn	2024-11-21 18:25:43	2024-11-22 18:53:43	364
877	2024-11-22	1	20:14:11	11	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-21 19:51:11	2024-11-22 20:30:11	766
878	2024-11-22	2	21:30:16	3	Thêm một đĩa trái cây cho trẻ em	2024-11-21 21:10:16	2024-11-22 22:08:16	705
879	2024-11-23	1	00:44:21	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-22 00:19:21	2024-11-23 00:54:21	1626
880	2024-11-23	2	10:56:45	10	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-22 10:50:45	2024-11-23 11:35:45	1165
881	2024-11-23	1	05:12:57	19	Không dùng món ăn quá cay	2024-11-22 04:28:57	2024-11-23 05:43:57	1828
882	2024-11-23	1	06:30:23	3	Không dùng món ăn quá cay	2024-11-22 06:14:23	2024-11-23 07:06:23	883
883	2024-11-23	1	06:50:02	1	Chuẩn bị thực đơn thuần chay	2024-11-22 06:13:02	2024-11-23 07:26:02	731
884	2024-11-23	0	08:02:56	19	Thêm chỗ để xe đẩy cho trẻ em	2024-11-22 07:26:56	2024-11-23 08:45:56	41
885	2024-11-23	2	07:48:58	20	Dành chỗ ngồi cho nhóm 10 người	2024-11-22 07:21:58	2024-11-23 07:56:58	932
886	2024-11-23	1	07:43:17	9	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-22 07:24:17	2024-11-23 07:45:17	746
887	2024-11-23	2	08:24:48	4	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-22 08:21:48	2024-11-23 09:01:48	1551
888	2024-11-23	1	05:03:42	3	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-22 04:24:42	2024-11-23 05:41:42	763
889	2024-11-23	0	07:02:22	3	Không thêm muối vào các món ăn	2024-11-22 06:59:22	2024-11-23 07:06:22	254
890	2024-11-23	1	05:23:00	1	Chuẩn bị thực đơn thuần chay	2024-11-22 05:19:00	2024-11-23 05:38:00	569
891	2024-11-23	2	11:53:53	16	Có món ăn phù hợp với người lớn tuổi	2024-11-22 11:37:53	2024-11-23 12:35:53	100
892	2024-11-23	1	17:39:59	13	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-22 17:26:59	2024-11-23 18:12:59	1455
893	2024-11-23	1	16:26:58	9	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-22 16:12:58	2024-11-23 16:37:58	1796
894	2024-11-23	1	17:57:06	16	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-22 17:22:06	2024-11-23 18:11:06	223
895	2024-11-23	1	14:17:19	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-22 13:47:19	2024-11-23 14:36:19	395
896	2024-11-23	1	13:05:13	15	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-22 12:47:13	2024-11-23 13:34:13	1238
897	2024-11-23	1	15:50:43	12	Thêm chỗ để xe đẩy cho trẻ em	2024-11-22 15:20:43	2024-11-23 15:55:43	1246
898	2024-11-23	1	13:37:40	2	Dọn sẵn đĩa và dao cắt bánh	2024-11-22 12:55:40	2024-11-23 14:21:40	1504
899	2024-11-23	1	13:37:47	2	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-22 12:58:47	2024-11-23 14:00:47	1677
900	2024-11-23	1	17:13:56	11	Dọn sẵn đĩa và dao cắt bánh	2024-11-22 16:59:56	2024-11-23 17:35:56	1822
901	2024-11-23	1	12:58:37	6	Có món ăn phù hợp với người lớn tuổi	2024-11-22 12:42:37	2024-11-23 13:04:37	870
902	2024-11-23	1	12:45:14	1		2024-11-22 12:15:14	2024-11-23 12:52:14	1983
903	2024-11-23	2	21:37:02	18	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-22 21:18:02	2024-11-23 22:18:02	1906
904	2024-11-23	1	19:26:49	6	Chuẩn bị thực đơn thuần chay	2024-11-22 18:52:49	2024-11-23 19:35:49	1303
905	2024-11-23	0	18:26:30	2	Cung cấp thực đơn không chứa gluten	2024-11-22 18:13:30	2024-11-23 18:40:30	337
906	2024-11-23	2	20:07:26	19	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-22 19:49:26	2024-11-23 20:07:26	1480
907	2024-11-23	0	20:05:55	10	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-22 19:49:55	2024-11-23 20:40:55	674
908	2024-11-23	0	21:17:36	1	Không thêm muối vào các món ăn	2024-11-22 20:51:36	2024-11-23 21:42:36	1396
909	2024-11-23	0	18:28:02	9	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-22 18:00:02	2024-11-23 18:28:02	238
910	2024-11-23	2	19:22:33	1	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-22 19:21:33	2024-11-23 19:30:33	1242
911	2024-11-23	0	18:39:24	17	Thêm chỗ để xe đẩy cho trẻ em	2024-11-22 18:25:24	2024-11-23 19:23:24	716
912	2024-11-23	2	18:55:10	19	Dành chỗ ngồi cho nhóm 10 người	2024-11-22 18:16:10	2024-11-23 19:39:10	1908
913	2024-11-23	1	19:32:13	20	Bàn gần cửa sổ để ngắm cảnh	2024-11-22 19:03:13	2024-11-23 19:51:13	867
914	2024-11-23	1	20:19:28	1	Dành chỗ ngồi cho nhóm 10 người	2024-11-22 20:13:28	2024-11-23 20:32:28	1636
915	2024-11-23	1	19:00:30	3	Không dùng món ăn quá cay	2024-11-22 18:41:30	2024-11-23 19:09:30	1714
916	2024-11-23	0	21:25:04	15	Có món ăn phù hợp với người lớn tuổi	2024-11-22 21:12:04	2024-11-23 21:35:04	6
917	2024-11-23	1	20:55:42	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-22 20:49:42	2024-11-23 20:55:42	31
918	2024-11-23	2	20:23:37	8	Dọn sẵn đĩa và dao cắt bánh	2024-11-22 20:08:37	2024-11-23 20:26:37	1616
919	2024-11-23	1	22:46:22	5	Thêm một đĩa trái cây cho trẻ em	2024-11-22 22:46:22	2024-11-23 23:19:22	1570
920	2024-11-24	0	10:39:24	8	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-23 10:37:24	2024-11-24 10:41:24	231
921	2024-11-24	1	10:47:58	19	Chuẩn bị thực đơn thuần chay	2024-11-23 10:19:58	2024-11-24 11:27:58	164
922	2024-11-24	1	10:07:38	7	Dành chỗ ngồi cho nhóm 10 người	2024-11-23 09:39:38	2024-11-24 10:23:38	1888
923	2024-11-24	1	10:04:18	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-23 09:39:18	2024-11-24 10:13:18	1390
924	2024-11-24	1	09:08:48	2	Không thêm muối vào các món ăn	2024-11-23 08:49:48	2024-11-24 09:20:48	939
925	2024-11-24	1	07:56:35	9		2024-11-23 07:38:35	2024-11-24 08:34:35	1963
926	2024-11-24	1	09:24:30	19	Cung cấp thực đơn không chứa gluten	2024-11-23 09:18:30	2024-11-24 09:45:30	89
927	2024-11-24	2	09:53:10	1		2024-11-23 09:45:10	2024-11-24 10:22:10	350
928	2024-11-24	2	08:55:33	5	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-23 08:24:33	2024-11-24 09:21:33	751
929	2024-11-24	1	08:53:36	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-23 08:48:36	2024-11-24 09:13:36	143
930	2024-11-24	1	05:42:28	16	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-23 05:07:28	2024-11-24 05:45:28	227
931	2024-11-24	2	13:22:12	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-23 12:38:12	2024-11-24 14:07:12	223
932	2024-11-24	2	14:25:10	4	Bàn gần cửa sổ để ngắm cảnh	2024-11-23 14:11:10	2024-11-24 14:38:10	174
933	2024-11-24	1	14:36:50	11		2024-11-23 14:08:50	2024-11-24 15:13:50	535
934	2024-11-24	0	14:47:08	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-23 14:47:08	2024-11-24 15:11:08	314
935	2024-11-24	1	15:17:29	18	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-23 14:51:29	2024-11-24 15:35:29	873
936	2024-11-24	1	14:47:52	3	Không thêm muối vào các món ăn	2024-11-23 14:41:52	2024-11-24 14:50:52	1873
937	2024-11-24	1	16:10:21	2	Chuẩn bị thực đơn thuần chay	2024-11-23 15:34:21	2024-11-24 16:20:21	1547
938	2024-11-24	1	14:54:48	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-23 14:12:48	2024-11-24 15:08:48	759
939	2024-11-24	1	14:58:36	2	Dọn sẵn đĩa và dao cắt bánh	2024-11-23 14:48:36	2024-11-24 14:58:36	27
940	2024-11-24	1	13:45:53	6	Thêm chỗ để xe đẩy cho trẻ em	2024-11-23 13:31:53	2024-11-24 14:00:53	164
941	2024-11-24	1	13:13:49	5	Dọn sẵn đĩa và dao cắt bánh	2024-11-23 12:56:49	2024-11-24 13:48:49	842
942	2024-11-24	1	17:43:45	12	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-23 17:05:45	2024-11-24 18:07:45	1304
943	2024-11-24	2	20:55:21	5	Dành chỗ ngồi cho nhóm 10 người	2024-11-23 20:26:21	2024-11-24 21:38:21	1172
944	2024-11-24	2	20:45:25	7	Không dùng món ăn quá cay	2024-11-23 20:12:25	2024-11-24 20:45:25	1160
945	2024-11-24	2	19:35:53	15	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-23 19:12:53	2024-11-24 20:01:53	387
946	2024-11-24	1	18:35:27	1	Thêm một đĩa trái cây cho trẻ em	2024-11-23 18:23:27	2024-11-24 18:38:27	1603
947	2024-11-24	1	19:39:12	3	Không dùng món ăn quá cay	2024-11-23 19:31:12	2024-11-24 20:08:12	1505
948	2024-11-24	1	18:23:59	3	Thêm một đĩa trái cây cho trẻ em	2024-11-23 17:56:59	2024-11-24 18:30:59	1901
949	2024-11-24	0	19:17:00	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-23 19:13:00	2024-11-24 19:20:00	243
950	2024-11-24	1	21:06:26	11	Không dùng hành hoặc tỏi trong món ăn	2024-11-23 20:22:26	2024-11-24 21:29:26	1038
951	2024-11-24	1	21:40:56	8		2024-11-23 21:27:56	2024-11-24 21:43:56	450
952	2024-11-24	0	20:30:04	20	Thêm chỗ để xe đẩy cho trẻ em	2024-11-23 20:21:04	2024-11-24 20:39:04	492
953	2024-11-24	1	19:19:03	6	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-23 18:56:03	2024-11-24 19:29:03	354
954	2024-11-24	1	21:35:11	3	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-23 21:12:11	2024-11-24 21:53:11	525
955	2024-11-24	1	18:52:36	5	Không thêm muối vào các món ăn	2024-11-23 18:50:36	2024-11-24 19:31:36	1117
956	2024-11-24	1	18:57:45	2	Thêm chỗ để xe đẩy cho trẻ em	2024-11-23 18:37:45	2024-11-24 19:13:45	1724
957	2024-11-24	0	21:49:26	13		2024-11-23 21:47:26	2024-11-24 22:08:26	1831
958	2024-11-24	2	18:12:56	12	Không dùng hành hoặc tỏi trong món ăn	2024-11-23 17:46:56	2024-11-24 18:24:56	685
959	2024-11-25	1	00:53:49	17	Thêm chỗ để xe đẩy cho trẻ em	2024-11-24 00:23:49	2024-11-25 01:12:49	1004
960	2024-11-25	1	10:30:44	1	Không thêm muối vào các món ăn	2024-11-24 09:59:44	2024-11-25 11:09:44	964
961	2024-11-25	1	05:37:19	3		2024-11-24 05:17:19	2024-11-25 05:42:19	471
962	2024-11-25	1	08:22:28	13	Bàn gần cửa sổ để ngắm cảnh	2024-11-24 07:40:28	2024-11-25 08:57:28	1870
963	2024-11-25	1	10:25:28	5	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-24 10:12:28	2024-11-25 11:04:28	1457
964	2024-11-25	0	07:26:11	13	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-24 06:52:11	2024-11-25 07:51:11	1459
965	2024-11-25	1	08:53:40	11	Không dùng hành hoặc tỏi trong món ăn	2024-11-24 08:41:40	2024-11-25 08:54:40	78
966	2024-11-25	1	07:23:45	15	Cung cấp thực đơn không chứa gluten	2024-11-24 06:57:45	2024-11-25 07:30:45	190
967	2024-11-25	2	06:26:04	17	Thêm chỗ để xe đẩy cho trẻ em	2024-11-24 06:01:04	2024-11-25 07:01:04	326
968	2024-11-25	1	08:27:14	8	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-24 08:09:14	2024-11-25 09:08:14	1216
969	2024-11-25	1	07:18:09	6	Không dùng món ăn quá cay	2024-11-24 07:06:09	2024-11-25 07:57:09	68
970	2024-11-25	0	07:59:53	4		2024-11-24 07:26:53	2024-11-25 08:09:53	1015
971	2024-11-25	1	13:54:35	4	Thêm một đĩa trái cây cho trẻ em	2024-11-24 13:29:35	2024-11-25 14:09:35	80
972	2024-11-25	1	14:14:37	7		2024-11-24 13:49:37	2024-11-25 14:53:37	331
973	2024-11-25	2	17:13:12	19	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-24 16:36:12	2024-11-25 17:16:12	1609
974	2024-11-25	2	17:11:41	4	Bàn gần cửa sổ để ngắm cảnh	2024-11-24 16:35:41	2024-11-25 17:41:41	1756
975	2024-11-25	2	12:25:00	20	Thêm chỗ để xe đẩy cho trẻ em	2024-11-24 11:52:00	2024-11-25 12:48:00	906
976	2024-11-25	1	15:42:36	5	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-24 15:04:36	2024-11-25 16:07:36	1599
977	2024-11-25	1	11:32:10	1	Dành chỗ ngồi cho nhóm 10 người	2024-11-24 11:19:10	2024-11-25 12:05:10	1376
978	2024-11-25	1	16:40:11	12	Thêm một đĩa trái cây cho trẻ em	2024-11-24 16:36:11	2024-11-25 17:00:11	703
979	2024-11-25	1	11:17:33	5	Cung cấp thực đơn không chứa gluten	2024-11-24 11:00:33	2024-11-25 11:24:33	274
980	2024-11-25	1	17:31:49	16	Không dùng món ăn quá cay	2024-11-24 16:51:49	2024-11-25 17:47:49	876
981	2024-11-25	0	14:15:22	17	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-24 13:49:22	2024-11-25 14:46:22	113
982	2024-11-25	1	11:50:01	2	Không thêm muối vào các món ăn	2024-11-24 11:11:01	2024-11-25 12:22:01	1187
983	2024-11-25	0	21:48:15	3	Bàn gần cửa sổ để ngắm cảnh	2024-11-24 21:33:15	2024-11-25 22:30:15	1908
984	2024-11-25	1	19:46:06	18	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-24 19:37:06	2024-11-25 20:09:06	43
985	2024-11-25	1	20:13:49	3	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-24 19:56:49	2024-11-25 20:29:49	1608
986	2024-11-25	2	18:06:54	10	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-24 17:51:54	2024-11-25 18:25:54	504
987	2024-11-25	1	19:01:37	7		2024-11-24 18:53:37	2024-11-25 19:22:37	999
988	2024-11-25	1	21:32:03	2	Có món ăn phù hợp với người lớn tuổi	2024-11-24 21:25:03	2024-11-25 22:10:03	851
989	2024-11-25	1	21:43:31	2	Thêm chỗ để xe đẩy cho trẻ em	2024-11-24 21:27:31	2024-11-25 22:16:31	1921
990	2024-11-25	1	21:20:47	6	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-24 21:07:47	2024-11-25 22:04:47	1034
991	2024-11-25	1	19:34:09	7	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-24 19:04:09	2024-11-25 19:34:09	690
992	2024-11-25	2	19:05:13	2	Cung cấp thực đơn không chứa gluten	2024-11-24 18:48:13	2024-11-25 19:47:13	1547
993	2024-11-25	2	19:36:03	18		2024-11-24 19:10:03	2024-11-25 20:15:03	1018
994	2024-11-25	1	20:53:25	15	Không dùng món ăn quá cay	2024-11-24 20:51:25	2024-11-25 21:07:25	1078
995	2024-11-25	1	20:43:35	14	Không dùng món ăn quá cay	2024-11-24 20:12:35	2024-11-25 20:57:35	19
996	2024-11-25	1	19:08:17	8	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-24 18:37:17	2024-11-25 19:53:17	1403
997	2024-11-25	0	18:06:50	3	Thêm một đĩa trái cây cho trẻ em	2024-11-24 18:04:50	2024-11-25 18:43:50	1434
998	2024-11-25	2	21:53:04	4	Bàn gần cửa sổ để ngắm cảnh	2024-11-24 21:25:04	2024-11-25 22:10:04	1113
999	2024-11-26	1	00:22:49	5	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-24 23:54:49	2024-11-26 00:23:49	204
1000	2024-11-26	1	06:29:58	1	Có món ăn phù hợp với người lớn tuổi	2024-11-25 06:16:58	2024-11-26 07:03:58	384
1001	2024-11-26	1	09:38:13	15	Có món ăn phù hợp với người lớn tuổi	2024-11-25 09:22:13	2024-11-26 09:59:13	1003
1002	2024-11-26	0	05:18:51	2	Chuẩn bị thực đơn thuần chay	2024-11-25 04:44:51	2024-11-26 05:29:51	1730
1003	2024-11-26	2	06:20:04	7	Không thêm muối vào các món ăn	2024-11-25 05:43:04	2024-11-26 07:02:04	1060
1004	2024-11-26	1	10:17:41	3	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-25 10:14:41	2024-11-26 10:42:41	1734
1005	2024-11-26	1	06:46:54	2	Không dùng món ăn quá cay	2024-11-25 06:11:54	2024-11-26 06:55:54	850
1006	2024-11-26	2	05:45:44	4	Dành chỗ ngồi cho nhóm 10 người	2024-11-25 05:33:44	2024-11-26 06:03:44	1213
1007	2024-11-26	2	06:40:33	6	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-25 06:26:33	2024-11-26 06:55:33	235
1008	2024-11-26	1	08:46:10	12	Bàn gần cửa sổ để ngắm cảnh	2024-11-25 08:12:10	2024-11-26 08:50:10	494
1009	2024-11-26	0	07:42:07	6		2024-11-25 07:06:07	2024-11-26 07:53:07	764
1010	2024-11-26	1	06:47:55	9	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-25 06:26:55	2024-11-26 07:18:55	1134
1011	2024-11-26	1	12:02:36	16	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-25 11:50:36	2024-11-26 12:19:36	440
1012	2024-11-26	2	17:51:11	3	Thêm một đĩa trái cây cho trẻ em	2024-11-25 17:23:11	2024-11-26 18:04:11	907
1013	2024-11-26	1	14:45:14	10	Dành chỗ ngồi cho nhóm 10 người	2024-11-25 14:10:14	2024-11-26 14:59:14	1523
1014	2024-11-26	2	13:33:39	9	Bàn gần cửa sổ để ngắm cảnh	2024-11-25 13:26:39	2024-11-26 13:41:39	62
1015	2024-11-26	1	11:56:27	17	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-25 11:46:27	2024-11-26 12:35:27	65
1016	2024-11-26	1	16:14:06	9	Cung cấp thực đơn không chứa gluten	2024-11-25 15:54:06	2024-11-26 16:58:06	1226
1017	2024-11-26	2	17:19:42	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-25 16:40:42	2024-11-26 17:39:42	1603
1018	2024-11-26	0	11:54:12	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-25 11:11:12	2024-11-26 12:31:12	1840
1019	2024-11-26	1	14:15:38	17	Dọn sẵn đĩa và dao cắt bánh	2024-11-25 13:57:38	2024-11-26 14:48:38	246
1020	2024-11-26	1	15:09:37	9	Dành chỗ ngồi cho nhóm 10 người	2024-11-25 14:53:37	2024-11-26 15:29:37	1588
1021	2024-11-26	1	11:11:52	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-25 11:11:52	2024-11-26 11:36:52	169
1022	2024-11-26	2	14:20:05	10	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-25 14:14:05	2024-11-26 14:43:05	1219
1023	2024-11-26	1	21:11:48	10	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-25 20:34:48	2024-11-26 21:28:48	1651
1024	2024-11-26	0	18:30:09	5	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-25 17:51:09	2024-11-26 18:55:09	316
1025	2024-11-26	1	21:02:27	11	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-25 20:23:27	2024-11-26 21:40:27	964
1026	2024-11-26	1	19:44:41	13	Dành chỗ ngồi cho nhóm 10 người	2024-11-25 19:40:41	2024-11-26 20:26:41	1169
1027	2024-11-26	0	18:48:14	6	Không thêm muối vào các món ăn	2024-11-25 18:36:14	2024-11-26 19:10:14	1173
1028	2024-11-26	2	19:33:38	4	Thêm chỗ để xe đẩy cho trẻ em	2024-11-25 19:19:38	2024-11-26 19:44:38	14
1029	2024-11-26	0	18:47:53	4	Có món ăn phù hợp với người lớn tuổi	2024-11-25 18:05:53	2024-11-26 19:17:53	1293
1030	2024-11-26	1	18:12:34	4	Không thêm muối vào các món ăn	2024-11-25 17:29:34	2024-11-26 18:25:34	1543
1031	2024-11-26	0	18:12:51	4	Có món ăn phù hợp với người lớn tuổi	2024-11-25 18:05:51	2024-11-26 18:20:51	1512
1032	2024-11-26	0	21:31:42	12	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-25 21:29:42	2024-11-26 22:03:42	98
1033	2024-11-26	1	19:24:52	7	Dọn sẵn đĩa và dao cắt bánh	2024-11-25 18:44:52	2024-11-26 19:55:52	1506
1034	2024-11-26	2	21:07:49	15	Không dùng món ăn quá cay	2024-11-25 20:57:49	2024-11-26 21:11:49	314
1035	2024-11-26	1	21:58:35	7	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-25 21:45:35	2024-11-26 22:14:35	397
1036	2024-11-26	1	21:01:14	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-25 20:39:14	2024-11-26 21:24:14	1571
1037	2024-11-26	1	21:16:01	19	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-25 20:34:01	2024-11-26 21:57:01	264
1038	2024-11-26	2	20:10:23	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-25 19:32:23	2024-11-26 20:42:23	791
1039	2024-11-27	2	01:07:36	8	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-26 00:27:36	2024-11-27 01:17:36	1231
1040	2024-11-27	1	10:29:03	4	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-26 09:47:03	2024-11-27 10:54:03	908
1041	2024-11-27	2	05:15:09	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-26 05:02:09	2024-11-27 05:52:09	1371
1042	2024-11-27	2	08:54:04	10		2024-11-26 08:45:04	2024-11-27 09:29:04	1419
1043	2024-11-27	1	10:06:22	5	Không thêm muối vào các món ăn	2024-11-26 09:40:22	2024-11-27 10:16:22	1562
1044	2024-11-27	0	09:06:47	8	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-26 08:50:47	2024-11-27 09:38:47	1601
1045	2024-11-27	1	07:58:36	5	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-26 07:57:36	2024-11-27 08:41:36	14
1046	2024-11-27	2	08:47:27	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-26 08:38:27	2024-11-27 09:28:27	905
1047	2024-11-27	1	08:20:27	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-26 07:55:27	2024-11-27 08:21:27	1615
1048	2024-11-27	2	08:45:49	9	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-26 08:36:49	2024-11-27 08:54:49	454
1049	2024-11-27	1	07:19:18	4		2024-11-26 07:17:18	2024-11-27 07:25:18	806
1050	2024-11-27	2	08:33:18	17		2024-11-26 08:29:18	2024-11-27 09:12:18	993
1051	2024-11-27	1	17:19:26	4	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-26 16:46:26	2024-11-27 17:46:26	347
1052	2024-11-27	1	16:41:05	9	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-26 16:31:05	2024-11-27 17:11:05	380
1053	2024-11-27	1	17:55:28	3	Cung cấp thực đơn không chứa gluten	2024-11-26 17:11:28	2024-11-27 18:04:28	1953
1054	2024-11-27	1	11:19:28	9	Cung cấp thực đơn không chứa gluten	2024-11-26 10:54:28	2024-11-27 11:26:28	1603
1055	2024-11-27	0	13:55:12	14	Có món ăn phù hợp với người lớn tuổi	2024-11-26 13:47:12	2024-11-27 14:24:12	388
1056	2024-11-27	1	12:57:21	16	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-26 12:21:21	2024-11-27 13:18:21	341
1057	2024-11-27	1	11:34:55	3	Không thêm muối vào các món ăn	2024-11-26 11:31:55	2024-11-27 11:34:55	619
1058	2024-11-27	2	15:02:50	3	Chuẩn bị thực đơn thuần chay	2024-11-26 14:28:50	2024-11-27 15:32:50	1751
1059	2024-11-27	0	14:44:12	2	Không dùng hành hoặc tỏi trong món ăn	2024-11-26 14:33:12	2024-11-27 15:22:12	1837
1060	2024-11-27	2	12:56:46	6	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-26 12:56:46	2024-11-27 13:02:46	1767
1061	2024-11-27	2	15:48:42	8	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-26 15:29:42	2024-11-27 15:50:42	1577
1062	2024-11-27	0	13:22:57	4	Chuẩn bị thực đơn thuần chay	2024-11-26 12:44:57	2024-11-27 13:23:57	717
1063	2024-11-27	0	21:47:50	9	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-26 21:27:50	2024-11-27 22:26:50	1775
1064	2024-11-27	1	20:22:43	1	Dành chỗ ngồi cho nhóm 10 người	2024-11-26 20:11:43	2024-11-27 20:25:43	143
1065	2024-11-27	1	21:15:24	6	Dành chỗ ngồi cho nhóm 10 người	2024-11-26 20:53:24	2024-11-27 21:34:24	654
1066	2024-11-27	2	21:14:35	4	Không dùng món ăn quá cay	2024-11-26 20:33:35	2024-11-27 21:19:35	338
1067	2024-11-27	1	19:11:14	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-26 19:09:14	2024-11-27 19:29:14	294
1068	2024-11-27	1	18:30:15	3	Cung cấp thực đơn không chứa gluten	2024-11-26 17:52:15	2024-11-27 19:06:15	1373
1069	2024-11-27	0	21:25:38	2	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-26 21:03:38	2024-11-27 21:25:38	1996
1070	2024-11-27	1	20:18:08	4	Không thêm muối vào các món ăn	2024-11-26 20:02:08	2024-11-27 20:52:08	1852
1071	2024-11-27	2	19:53:14	11	Bàn gần cửa sổ để ngắm cảnh	2024-11-26 19:14:14	2024-11-27 20:32:14	1399
1072	2024-11-27	1	19:33:09	1	Không dùng món ăn quá cay	2024-11-26 19:30:09	2024-11-27 19:59:09	1681
1073	2024-11-27	0	19:09:32	15	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-26 19:09:32	2024-11-27 19:24:32	987
1074	2024-11-27	1	20:29:41	8	Thêm chỗ để xe đẩy cho trẻ em	2024-11-26 20:09:41	2024-11-27 21:01:41	254
1075	2024-11-27	0	20:22:48	3	Có món ăn phù hợp với người lớn tuổi	2024-11-26 20:12:48	2024-11-27 20:56:48	1924
1076	2024-11-27	0	19:36:36	7	Không thêm muối vào các món ăn	2024-11-26 19:05:36	2024-11-27 20:05:36	843
1077	2024-11-27	2	19:28:16	2	Thêm một đĩa trái cây cho trẻ em	2024-11-26 19:22:16	2024-11-27 20:04:16	1644
1078	2024-11-27	0	20:29:28	14	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-26 20:05:28	2024-11-27 21:04:28	1943
1079	2024-11-27	2	22:16:10	8	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-26 21:38:10	2024-11-27 22:26:10	703
1080	2024-11-28	2	07:16:54	3	Không thêm muối vào các món ăn	2024-11-27 07:13:54	2024-11-28 07:49:54	958
1081	2024-11-28	2	09:10:37	11	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-27 08:43:37	2024-11-28 09:22:37	1228
1082	2024-11-28	2	06:56:10	11	Bàn gần cửa sổ để ngắm cảnh	2024-11-27 06:41:10	2024-11-28 07:05:10	678
1083	2024-11-28	1	06:11:03	13	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-27 05:51:03	2024-11-28 06:49:03	1298
1084	2024-11-28	1	10:27:14	1	Thêm một đĩa trái cây cho trẻ em	2024-11-27 09:47:14	2024-11-28 11:09:14	856
1085	2024-11-28	1	07:31:26	3	Có món ăn phù hợp với người lớn tuổi	2024-11-27 06:59:26	2024-11-28 07:57:26	312
1086	2024-11-28	1	09:47:30	6	Cung cấp thực đơn không chứa gluten	2024-11-27 09:28:30	2024-11-28 10:06:30	935
1087	2024-11-28	1	08:30:21	9	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-27 08:00:21	2024-11-28 09:02:21	691
1088	2024-11-28	0	08:04:53	16	Dọn sẵn đĩa và dao cắt bánh	2024-11-27 07:24:53	2024-11-28 08:37:53	940
1089	2024-11-28	1	07:15:00	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-27 06:53:00	2024-11-28 07:44:00	422
1090	2024-11-28	1	05:43:05	18	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-27 05:05:05	2024-11-28 06:07:05	1123
1091	2024-11-28	1	16:14:44	17	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-27 16:02:44	2024-11-28 16:47:44	917
1092	2024-11-28	2	16:34:34	18	Thêm một đĩa trái cây cho trẻ em	2024-11-27 16:03:34	2024-11-28 16:47:34	693
1093	2024-11-28	1	12:19:41	3	Dành chỗ ngồi cho nhóm 10 người	2024-11-27 12:11:41	2024-11-28 13:04:41	1920
1094	2024-11-28	1	12:39:23	6	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-27 12:03:23	2024-11-28 13:10:23	1654
1095	2024-11-28	1	11:23:21	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-27 11:06:21	2024-11-28 11:36:21	1888
1096	2024-11-28	1	17:56:42	17	Không thêm muối vào các món ăn	2024-11-27 17:54:42	2024-11-28 18:22:42	1798
1097	2024-11-28	1	16:15:57	7	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-27 16:14:57	2024-11-28 16:43:57	974
1098	2024-11-28	2	13:04:06	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-27 12:34:06	2024-11-28 13:44:06	16
1099	2024-11-28	0	12:25:37	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-27 11:46:37	2024-11-28 12:49:37	1873
1100	2024-11-28	1	12:01:15	4	Dọn sẵn đĩa và dao cắt bánh	2024-11-27 11:53:15	2024-11-28 12:34:15	1599
1101	2024-11-28	1	14:52:53	1	Chuẩn bị thực đơn thuần chay	2024-11-27 14:25:53	2024-11-28 15:12:53	1262
1102	2024-11-28	1	16:24:12	18	Dành chỗ ngồi cho nhóm 10 người	2024-11-27 16:23:12	2024-11-28 16:40:12	6
1103	2024-11-28	1	20:03:08	5	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-27 19:28:08	2024-11-28 20:23:08	1912
1104	2024-11-28	2	19:14:12	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-27 18:43:12	2024-11-28 19:41:12	1534
1105	2024-11-28	1	20:32:37	4	Bàn gần cửa sổ để ngắm cảnh	2024-11-27 19:53:37	2024-11-28 20:33:37	1965
1106	2024-11-28	1	19:21:59	3	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-27 19:03:59	2024-11-28 19:47:59	1326
1107	2024-11-28	1	19:27:55	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-27 18:52:55	2024-11-28 19:56:55	1535
1108	2024-11-28	2	19:54:04	18	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-27 19:47:04	2024-11-28 20:31:04	971
1109	2024-11-28	1	20:05:20	20	Cung cấp thực đơn không chứa gluten	2024-11-27 19:37:20	2024-11-28 20:46:20	309
1110	2024-11-28	0	20:55:47	11	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-27 20:21:47	2024-11-28 21:25:47	56
1111	2024-11-28	0	20:26:54	14	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-27 20:04:54	2024-11-28 20:55:54	1763
1112	2024-11-28	1	18:42:41	11	Không dùng hành hoặc tỏi trong món ăn	2024-11-27 17:58:41	2024-11-28 18:43:41	456
1113	2024-11-28	2	18:55:40	4	Chuẩn bị thực đơn thuần chay	2024-11-27 18:47:40	2024-11-28 19:28:40	1423
1114	2024-11-28	1	21:15:16	3	Không dùng hành hoặc tỏi trong món ăn	2024-11-27 20:42:16	2024-11-28 21:24:16	757
1115	2024-11-28	1	20:30:01	12	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-27 20:24:01	2024-11-28 20:48:01	1336
1116	2024-11-28	1	20:13:50	7	Không dùng hành hoặc tỏi trong món ăn	2024-11-27 20:00:50	2024-11-28 20:26:50	1110
1117	2024-11-28	0	21:54:27	7	Thêm một đĩa trái cây cho trẻ em	2024-11-27 21:17:27	2024-11-28 22:25:27	169
1118	2024-11-28	1	19:37:04	9	Dọn sẵn đĩa và dao cắt bánh	2024-11-27 19:09:04	2024-11-28 19:55:04	961
1119	2024-11-29	1	00:41:46	4	Không dùng hành hoặc tỏi trong món ăn	2024-11-28 00:00:46	2024-11-29 01:21:46	1536
1120	2024-11-29	1	06:58:49	9	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-28 06:53:49	2024-11-29 07:38:49	1620
1121	2024-11-29	1	10:50:22	5		2024-11-28 10:07:22	2024-11-29 11:17:22	1770
1122	2024-11-29	0	10:54:33	9	Thêm một đĩa trái cây cho trẻ em	2024-11-28 10:18:33	2024-11-29 11:00:33	228
1123	2024-11-29	2	08:51:17	2	Không dùng hành hoặc tỏi trong món ăn	2024-11-28 08:32:17	2024-11-29 09:07:17	1346
1124	2024-11-29	1	06:43:05	18	Bàn gần cửa sổ để ngắm cảnh	2024-11-28 06:39:05	2024-11-29 07:28:05	493
1125	2024-11-29	1	06:35:51	19	Không dùng món ăn quá cay	2024-11-28 06:09:51	2024-11-29 07:12:51	119
1126	2024-11-29	0	05:45:08	17	Cung cấp thực đơn không chứa gluten	2024-11-28 05:42:08	2024-11-29 06:19:08	448
1127	2024-11-29	1	08:07:33	17	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-28 07:32:33	2024-11-29 08:13:33	487
1128	2024-11-29	0	09:00:36	7	Chuẩn bị thực đơn thuần chay	2024-11-28 08:49:36	2024-11-29 09:03:36	1706
1129	2024-11-29	2	06:08:05	7	Không dùng món ăn quá cay	2024-11-28 05:42:05	2024-11-29 06:45:05	1621
1130	2024-11-29	2	09:02:51	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-28 08:37:51	2024-11-29 09:35:51	1465
1131	2024-11-29	1	11:04:21	1	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-28 10:47:21	2024-11-29 11:19:21	555
1132	2024-11-29	0	15:06:31	2	Dành chỗ ngồi cho nhóm 10 người	2024-11-28 14:58:31	2024-11-29 15:13:31	932
1133	2024-11-29	2	17:47:04	14	Dành chỗ ngồi cho nhóm 10 người	2024-11-28 17:18:04	2024-11-29 18:01:04	388
1134	2024-11-29	1	12:40:49	20	Thêm chỗ để xe đẩy cho trẻ em	2024-11-28 12:03:49	2024-11-29 13:21:49	1360
1135	2024-11-29	1	12:41:18	2		2024-11-28 12:07:18	2024-11-29 12:45:18	796
1136	2024-11-29	1	15:27:40	2	Bàn gần cửa sổ để ngắm cảnh	2024-11-28 15:04:40	2024-11-29 15:31:40	674
1137	2024-11-29	2	15:22:08	15	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-28 14:51:08	2024-11-29 16:01:08	1946
1138	2024-11-29	1	13:48:08	16	Có món ăn phù hợp với người lớn tuổi	2024-11-28 13:33:08	2024-11-29 14:27:08	396
1139	2024-11-29	1	12:33:24	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-28 12:28:24	2024-11-29 12:47:24	303
1140	2024-11-29	2	12:56:20	5	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-28 12:27:20	2024-11-29 13:36:20	1405
1141	2024-11-29	0	16:30:34	17	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-28 16:09:34	2024-11-29 17:01:34	1200
1142	2024-11-29	1	15:01:58	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-28 14:18:58	2024-11-29 15:18:58	1368
1143	2024-11-29	1	21:43:05	19	Thêm một đĩa trái cây cho trẻ em	2024-11-28 21:23:05	2024-11-29 22:18:05	1190
1144	2024-11-29	0	19:59:00	13	Có món ăn phù hợp với người lớn tuổi	2024-11-28 19:18:00	2024-11-29 20:19:00	290
1145	2024-11-29	2	20:30:43	18	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-28 20:24:43	2024-11-29 21:04:43	1449
1146	2024-11-29	1	20:29:36	9	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-28 20:22:36	2024-11-29 21:04:36	556
1147	2024-11-29	1	21:51:42	5	Không dùng món ăn quá cay	2024-11-28 21:46:42	2024-11-29 21:56:42	373
1148	2024-11-29	0	21:52:20	14	Thêm một đĩa trái cây cho trẻ em	2024-11-28 21:33:20	2024-11-29 22:08:20	1929
1149	2024-11-29	1	18:06:59	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-28 17:31:59	2024-11-29 18:40:59	1373
1150	2024-11-29	1	19:05:08	2	Chuẩn bị thực đơn thuần chay	2024-11-28 18:42:08	2024-11-29 19:48:08	768
1151	2024-11-29	1	21:36:42	16	Không dùng món ăn quá cay	2024-11-28 20:55:42	2024-11-29 22:21:42	851
1152	2024-11-29	1	21:22:00	4	Chuẩn bị thực đơn thuần chay	2024-11-28 21:15:00	2024-11-29 21:56:00	871
1153	2024-11-29	1	20:18:56	10	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-28 19:58:56	2024-11-29 20:37:56	935
1154	2024-11-29	1	18:13:52	10	Dành chỗ ngồi cho nhóm 10 người	2024-11-28 17:41:52	2024-11-29 18:54:52	168
1155	2024-11-29	1	20:39:41	12	Phục vụ nhanh vì có trẻ em đi cùng	2024-11-28 20:14:41	2024-11-29 21:01:41	1056
1156	2024-11-29	1	18:16:57	9	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-28 17:45:57	2024-11-29 18:47:57	1110
1157	2024-11-29	1	20:43:48	8	Không dùng hành hoặc tỏi trong món ăn	2024-11-28 20:26:48	2024-11-29 20:55:48	299
1158	2024-11-29	0	21:39:28	15	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-28 21:28:28	2024-11-29 22:00:28	118
1159	2024-11-30	1	01:59:32	14	Thêm một đĩa trái cây cho trẻ em	2024-11-29 01:40:32	2024-11-30 02:26:32	1851
1160	2024-11-30	1	10:29:06	20	Thêm chỗ để xe đẩy cho trẻ em	2024-11-29 09:56:06	2024-11-30 10:39:06	1481
1161	2024-11-30	1	06:11:57	8	Không thêm muối vào các món ăn	2024-11-29 05:37:57	2024-11-30 06:53:57	1811
1162	2024-11-30	1	06:48:44	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-29 06:06:44	2024-11-30 07:13:44	637
1163	2024-11-30	1	10:04:43	3	Thêm một đĩa trái cây cho trẻ em	2024-11-29 09:31:43	2024-11-30 10:38:43	112
1164	2024-11-30	1	05:49:21	5	Có món ăn phù hợp với người lớn tuổi	2024-11-29 05:24:21	2024-11-30 05:51:21	877
1165	2024-11-30	1	08:58:58	3	Thêm chỗ để xe đẩy cho trẻ em	2024-11-29 08:31:58	2024-11-30 09:15:58	1852
1166	2024-11-30	0	08:12:18	8	Cung cấp thực đơn không chứa gluten	2024-11-29 08:07:18	2024-11-30 08:24:18	397
1167	2024-11-30	1	09:30:44	12	Không dùng hành hoặc tỏi trong món ăn	2024-11-29 09:25:44	2024-11-30 09:53:44	1231
1168	2024-11-30	1	06:08:23	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-29 05:33:23	2024-11-30 06:36:23	1133
1169	2024-11-30	1	09:52:40	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-29 09:19:40	2024-11-30 10:14:40	1247
1170	2024-11-30	1	10:48:01	5	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-29 10:47:01	2024-11-30 11:09:01	967
1171	2024-11-30	0	16:08:44	9	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-29 15:36:44	2024-11-30 16:34:44	391
1172	2024-11-30	1	13:19:12	3	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-29 13:17:12	2024-11-30 13:34:12	1260
1173	2024-11-30	1	14:40:50	20	Bàn gần cửa sổ để ngắm cảnh	2024-11-29 14:18:50	2024-11-30 15:24:50	1433
1174	2024-11-30	1	16:10:20	8	Có món ăn phù hợp với người lớn tuổi	2024-11-29 15:43:20	2024-11-30 16:14:20	470
1175	2024-11-30	1	12:27:42	19	Chuẩn bị thực đơn thuần chay	2024-11-29 11:54:42	2024-11-30 12:35:42	555
1176	2024-11-30	0	13:56:29	1	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-29 13:24:29	2024-11-30 14:37:29	1469
1177	2024-11-30	1	16:17:20	1	Bàn gần cửa sổ để ngắm cảnh	2024-11-29 16:11:20	2024-11-30 17:02:20	1742
1178	2024-11-30	1	14:58:17	12	Dành chỗ ngồi cho nhóm 10 người	2024-11-29 14:46:17	2024-11-30 15:27:17	1123
1179	2024-11-30	1	13:33:23	18	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-29 13:16:23	2024-11-30 13:49:23	970
1180	2024-11-30	1	12:10:37	19	Dành chỗ ngồi cho nhóm 10 người	2024-11-29 11:32:37	2024-11-30 12:49:37	711
1181	2024-11-30	2	11:38:21	2	Không thêm muối vào các món ăn	2024-11-29 11:13:21	2024-11-30 12:00:21	1334
1182	2024-11-30	1	12:41:53	10	Dọn sẵn đĩa và dao cắt bánh	2024-11-29 12:08:53	2024-11-30 13:16:53	424
1183	2024-11-30	1	19:12:11	6	Không dùng hành hoặc tỏi trong món ăn	2024-11-29 18:37:11	2024-11-30 19:44:11	3
1184	2024-11-30	1	20:38:45	12	Thêm chỗ để xe đẩy cho trẻ em	2024-11-29 20:11:45	2024-11-30 20:56:45	566
1185	2024-11-30	2	21:27:41	6	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-29 21:22:41	2024-11-30 21:28:41	825
1186	2024-11-30	0	20:39:44	10	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-29 20:37:44	2024-11-30 21:23:44	1194
1187	2024-11-30	1	21:21:51	13	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-29 21:06:51	2024-11-30 21:54:51	97
1188	2024-11-30	1	21:46:22	11	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-29 21:06:22	2024-11-30 22:05:22	392
1189	2024-11-30	1	21:06:30	11	Không dùng món ăn quá cay	2024-11-29 20:52:30	2024-11-30 21:10:30	881
1190	2024-11-30	0	21:30:44	3	Không dùng hành hoặc tỏi trong món ăn	2024-11-29 21:29:44	2024-11-30 22:10:44	457
1191	2024-11-30	1	18:53:58	9	Dành chỗ ngồi cho nhóm 10 người	2024-11-29 18:11:58	2024-11-30 19:34:58	1455
1192	2024-11-30	0	21:42:15	6	Thêm chỗ để xe đẩy cho trẻ em	2024-11-29 21:09:15	2024-11-30 22:20:15	1789
1193	2024-11-30	1	19:39:45	6		2024-11-29 19:15:45	2024-11-30 20:10:45	1197
1194	2024-11-30	1	20:05:06	17	Dành chỗ ngồi cho nhóm 10 người	2024-11-29 19:49:06	2024-11-30 20:16:06	1774
1195	2024-11-30	1	20:43:39	1	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-29 20:43:39	2024-11-30 20:55:39	1954
1196	2024-11-30	1	21:01:55	8	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-29 20:38:55	2024-11-30 21:04:55	1367
1197	2024-11-30	1	21:00:54	15	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-29 20:51:54	2024-11-30 21:27:54	1947
1198	2024-11-30	2	21:02:31	18	Cung cấp thực đơn không chứa gluten	2024-11-29 20:19:31	2024-11-30 21:28:31	342
1199	2024-11-30	0	23:14:30	5	Không thêm muối vào các món ăn	2024-11-29 23:00:30	2024-11-30 23:41:30	787
1200	2024-12-01	1	05:32:09	4	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-30 05:11:09	2024-12-01 06:13:09	82
1201	2024-12-01	0	09:28:34	14	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-30 09:17:34	2024-12-01 09:41:34	971
1202	2024-12-01	1	10:54:51	7	Bàn gần cửa sổ để ngắm cảnh	2024-11-30 10:41:51	2024-12-01 11:13:51	1105
1203	2024-12-01	2	07:43:40	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-30 07:43:40	2024-12-01 07:51:40	1907
1204	2024-12-01	1	08:41:42	4	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-30 08:33:42	2024-12-01 08:47:42	1218
1205	2024-12-01	0	08:24:49	1	Không dùng món ăn quá cay	2024-11-30 08:20:49	2024-12-01 08:50:49	1564
1206	2024-12-01	1	06:20:34	8	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-30 06:15:34	2024-12-01 06:48:34	152
1207	2024-12-01	0	05:07:54	2	Thêm một đĩa trái cây cho trẻ em	2024-11-30 04:50:54	2024-12-01 05:19:54	1996
1208	2024-12-01	1	07:13:36	3	Có món ăn phù hợp với người lớn tuổi	2024-11-30 06:46:36	2024-12-01 07:27:36	1600
1209	2024-12-01	2	08:44:50	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-30 08:08:50	2024-12-01 09:22:50	1629
1210	2024-12-01	1	05:24:24	19	Có món ăn phù hợp với người lớn tuổi	2024-11-30 05:24:24	2024-12-01 05:57:24	1478
1211	2024-12-01	0	12:34:30	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-30 12:13:30	2024-12-01 13:07:30	616
1212	2024-12-01	1	15:38:56	12	Chuẩn bị thực đơn thuần chay	2024-11-30 14:58:56	2024-12-01 15:49:56	1099
1213	2024-12-01	2	15:14:16	8	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-30 14:47:16	2024-12-01 15:33:16	852
1214	2024-12-01	2	16:40:05	6	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-30 16:37:05	2024-12-01 17:11:05	363
1215	2024-12-01	2	16:14:59	8	Không dùng hành hoặc tỏi trong món ăn	2024-11-30 16:07:59	2024-12-01 16:31:59	1930
1216	2024-12-01	0	11:13:20	9	Bàn gần cửa sổ để ngắm cảnh	2024-11-30 11:00:20	2024-12-01 11:30:20	985
1217	2024-12-01	2	12:38:02	19	Chuẩn bị thực đơn thuần chay	2024-11-30 12:20:02	2024-12-01 13:16:02	91
1218	2024-12-01	1	15:14:37	8	Chuẩn bị thực đơn thuần chay	2024-11-30 14:53:37	2024-12-01 15:58:37	1095
1219	2024-12-01	2	14:37:18	4	Không dùng món ăn quá cay	2024-11-30 14:27:18	2024-12-01 15:21:18	600
1220	2024-12-01	0	13:16:31	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-30 13:03:31	2024-12-01 13:17:31	1576
1221	2024-12-01	2	15:45:05	12	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-30 15:44:05	2024-12-01 15:49:05	1267
1222	2024-12-01	2	13:07:09	20	Thêm chỗ để xe đẩy cho trẻ em	2024-11-30 12:45:09	2024-12-01 13:19:09	27
1223	2024-12-01	1	19:14:23	9	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-11-30 19:01:23	2024-12-01 19:15:23	878
1224	2024-12-01	1	20:37:09	18	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-11-30 20:04:09	2024-12-01 21:08:09	980
1225	2024-12-01	1	21:57:38	5	Tách hóa đơn riêng cho từng người trong nhóm	2024-11-30 21:51:38	2024-12-01 22:42:38	1055
1226	2024-12-01	2	21:55:30	1	Có món ăn phù hợp với người lớn tuổi	2024-11-30 21:15:30	2024-12-01 22:16:30	113
1227	2024-12-01	0	19:28:11	10	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-11-30 19:26:11	2024-12-01 19:52:11	1711
1228	2024-12-01	1	21:55:59	3	Không dùng món ăn quá cay	2024-11-30 21:25:59	2024-12-01 22:27:59	1369
1229	2024-12-01	1	21:52:15	20	Dọn sẵn đĩa và dao cắt bánh	2024-11-30 21:20:15	2024-12-01 22:27:15	6
1230	2024-12-01	1	20:55:35	19	Không dùng hành hoặc tỏi trong món ăn	2024-11-30 20:24:35	2024-12-01 21:34:35	880
1231	2024-12-01	1	20:56:10	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-30 20:12:10	2024-12-01 21:18:10	1513
1232	2024-12-01	1	20:27:40	4	Thêm một đĩa trái cây cho trẻ em	2024-11-30 20:11:40	2024-12-01 20:47:40	1587
1233	2024-12-01	0	19:16:41	4	Dành chỗ ngồi cho nhóm 10 người	2024-11-30 19:10:41	2024-12-01 19:44:41	1112
1234	2024-12-01	0	19:08:29	6	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-11-30 19:01:29	2024-12-01 19:32:29	1923
1235	2024-12-01	1	18:16:29	20	Không dùng hành hoặc tỏi trong món ăn	2024-11-30 17:38:29	2024-12-01 18:41:29	1167
1236	2024-12-01	1	18:12:46	7	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-11-30 17:39:46	2024-12-01 18:54:46	1121
1237	2024-12-01	1	20:10:29	8	Yêu cầu ghế trẻ em cho bé nhỏ	2024-11-30 19:27:29	2024-12-01 20:28:29	1569
1238	2024-12-01	2	18:26:16	3	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-11-30 17:49:16	2024-12-01 18:32:16	1274
1239	2024-12-01	1	23:15:49	4	Dọn sẵn đĩa và dao cắt bánh	2024-11-30 23:03:49	2024-12-01 23:44:49	620
1240	2024-12-02	1	05:39:03	11	Cung cấp thực đơn không chứa gluten	2024-12-01 05:21:03	2024-12-02 05:57:03	1362
1241	2024-12-02	1	09:09:01	3	Dành chỗ ngồi cho nhóm 10 người	2024-12-01 09:05:01	2024-12-02 09:38:01	1505
1242	2024-12-02	0	07:10:18	7	Có món ăn phù hợp với người lớn tuổi	2024-12-01 07:04:18	2024-12-02 07:26:18	798
1243	2024-12-02	1	09:32:22	16	Thêm chỗ để xe đẩy cho trẻ em	2024-12-01 09:03:22	2024-12-02 09:44:22	290
1244	2024-12-02	1	09:46:44	1	Không dùng hành hoặc tỏi trong món ăn	2024-12-01 09:18:44	2024-12-02 10:26:44	845
1245	2024-12-02	1	09:58:37	20	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-01 09:28:37	2024-12-02 10:13:37	264
1246	2024-12-02	1	08:05:08	2	Thêm một đĩa trái cây cho trẻ em	2024-12-01 07:37:08	2024-12-02 08:20:08	1300
1247	2024-12-02	1	05:12:57	7	Có món ăn phù hợp với người lớn tuổi	2024-12-01 05:12:57	2024-12-02 05:24:57	661
1248	2024-12-02	1	06:21:10	1	Dành chỗ ngồi cho nhóm 10 người	2024-12-01 05:41:10	2024-12-02 06:32:10	241
1249	2024-12-02	1	08:05:33	1	Thêm chỗ để xe đẩy cho trẻ em	2024-12-01 07:33:33	2024-12-02 08:29:33	1437
1250	2024-12-02	1	08:18:27	16	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-01 07:36:27	2024-12-02 08:24:27	779
1251	2024-12-02	2	14:22:49	15	Chuẩn bị thực đơn thuần chay	2024-12-01 13:56:49	2024-12-02 14:41:49	1351
1252	2024-12-02	1	13:58:19	1		2024-12-01 13:26:19	2024-12-02 14:08:19	804
1253	2024-12-02	2	15:12:00	3	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-01 15:01:00	2024-12-02 15:55:00	442
1254	2024-12-02	1	13:28:29	18	Có món ăn phù hợp với người lớn tuổi	2024-12-01 12:45:29	2024-12-02 13:53:29	711
1255	2024-12-02	1	11:57:39	1	Có món ăn phù hợp với người lớn tuổi	2024-12-01 11:15:39	2024-12-02 12:35:39	345
1256	2024-12-02	1	12:22:16	10	Thêm một đĩa trái cây cho trẻ em	2024-12-01 12:22:16	2024-12-02 12:48:16	1940
1257	2024-12-02	2	16:58:21	20	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-01 16:34:21	2024-12-02 17:07:21	1931
1258	2024-12-02	1	14:22:01	12	Bàn gần cửa sổ để ngắm cảnh	2024-12-01 13:53:01	2024-12-02 14:46:01	1944
1259	2024-12-02	1	11:54:53	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-01 11:12:53	2024-12-02 12:10:53	1581
1260	2024-12-02	0	16:48:35	17	Dành chỗ ngồi cho nhóm 10 người	2024-12-01 16:05:35	2024-12-02 16:55:35	1721
1261	2024-12-02	1	17:14:26	11	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-01 16:45:26	2024-12-02 17:46:26	1542
1262	2024-12-02	1	11:04:11	20	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-01 10:49:11	2024-12-02 11:06:11	1286
1263	2024-12-02	1	20:53:46	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-01 20:37:46	2024-12-02 20:56:46	1330
1264	2024-12-02	1	18:49:04	2	Không thêm muối vào các món ăn	2024-12-01 18:26:04	2024-12-02 19:19:04	887
1265	2024-12-02	1	20:50:58	4	Dọn sẵn đĩa và dao cắt bánh	2024-12-01 20:43:58	2024-12-02 21:29:58	941
1266	2024-12-02	0	19:05:53	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-01 18:45:53	2024-12-02 19:40:53	914
1267	2024-12-02	1	20:42:51	12	Thêm chỗ để xe đẩy cho trẻ em	2024-12-01 20:22:51	2024-12-02 20:52:51	1644
1268	2024-12-02	1	21:30:00	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-01 21:16:00	2024-12-02 22:06:00	806
1269	2024-12-02	2	19:28:48	14	Có món ăn phù hợp với người lớn tuổi	2024-12-01 19:17:48	2024-12-02 19:54:48	403
1270	2024-12-02	1	20:34:25	11		2024-12-01 20:18:25	2024-12-02 20:48:25	793
1271	2024-12-02	1	18:52:03	10	Cung cấp thực đơn không chứa gluten	2024-12-01 18:25:03	2024-12-02 19:24:03	1213
1272	2024-12-02	0	19:15:49	4	Cung cấp thực đơn không chứa gluten	2024-12-01 18:37:49	2024-12-02 19:18:49	1425
1273	2024-12-02	1	20:06:45	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-01 19:52:45	2024-12-02 20:22:45	1991
1274	2024-12-02	1	18:06:03	7	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-01 17:50:03	2024-12-02 18:44:03	120
1275	2024-12-02	1	18:49:56	4	Thêm một đĩa trái cây cho trẻ em	2024-12-01 18:22:56	2024-12-02 19:01:56	649
1276	2024-12-02	2	20:04:06	1	Không thêm muối vào các món ăn	2024-12-01 20:02:06	2024-12-02 20:27:06	1816
1277	2024-12-02	1	19:50:31	15	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-01 19:32:31	2024-12-02 19:58:31	1869
1278	2024-12-02	0	20:30:45	9	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-01 19:48:45	2024-12-02 20:55:45	1133
1279	2024-12-03	1	00:36:27	1	Thêm chỗ để xe đẩy cho trẻ em	2024-12-02 00:35:27	2024-12-03 00:36:27	741
1280	2024-12-03	1	08:08:31	9	Không dùng hành hoặc tỏi trong món ăn	2024-12-02 08:00:31	2024-12-03 08:30:31	158
1281	2024-12-03	0	09:49:55	9	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-02 09:46:55	2024-12-03 10:19:55	1262
1282	2024-12-03	1	05:45:02	6	Không dùng hành hoặc tỏi trong món ăn	2024-12-02 05:40:02	2024-12-03 06:03:02	1824
1283	2024-12-03	1	06:20:54	11	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-02 05:49:54	2024-12-03 06:54:54	289
1284	2024-12-03	1	06:46:34	4	Có món ăn phù hợp với người lớn tuổi	2024-12-02 06:46:34	2024-12-03 07:21:34	549
1285	2024-12-03	1	09:05:01	9	Thêm chỗ để xe đẩy cho trẻ em	2024-12-02 08:43:01	2024-12-03 09:05:01	1950
1286	2024-12-03	2	05:14:28	15	Dọn sẵn đĩa và dao cắt bánh	2024-12-02 04:55:28	2024-12-03 05:40:28	1619
1287	2024-12-03	1	06:08:38	16	Không dùng hành hoặc tỏi trong món ăn	2024-12-02 06:03:38	2024-12-03 06:30:38	1766
1288	2024-12-03	0	10:19:17	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-02 10:09:17	2024-12-03 10:53:17	1766
1289	2024-12-03	1	09:23:40	8	Dành chỗ ngồi cho nhóm 10 người	2024-12-02 09:04:40	2024-12-03 09:45:40	1087
1290	2024-12-03	1	07:27:01	2	Thêm một đĩa trái cây cho trẻ em	2024-12-02 07:20:01	2024-12-03 08:10:01	456
1291	2024-12-03	1	17:56:40	2	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-02 17:31:40	2024-12-03 18:17:40	1689
1292	2024-12-03	1	17:04:54	19	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-02 16:46:54	2024-12-03 17:12:54	1488
1293	2024-12-03	2	15:15:50	6	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-02 14:45:50	2024-12-03 15:32:50	236
1294	2024-12-03	1	17:11:11	5		2024-12-02 16:30:11	2024-12-03 17:16:11	1605
1295	2024-12-03	1	17:54:37	9	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-02 17:47:37	2024-12-03 18:30:37	1374
1296	2024-12-03	1	16:14:23	10	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-02 15:57:23	2024-12-03 16:32:23	1992
1297	2024-12-03	1	12:14:05	19	Có món ăn phù hợp với người lớn tuổi	2024-12-02 11:59:05	2024-12-03 12:53:05	1730
1298	2024-12-03	2	17:55:24	2	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-02 17:43:24	2024-12-03 18:29:24	1536
1299	2024-12-03	1	13:43:36	7	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-02 13:07:36	2024-12-03 14:09:36	1638
1300	2024-12-03	1	17:14:46	7	Có món ăn phù hợp với người lớn tuổi	2024-12-02 16:47:46	2024-12-03 17:31:46	300
1301	2024-12-03	1	13:17:10	12		2024-12-02 13:05:10	2024-12-03 13:40:10	31
1302	2024-12-03	1	15:27:34	11	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-02 15:04:34	2024-12-03 15:58:34	1738
1303	2024-12-03	2	19:56:48	16	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-02 19:19:48	2024-12-03 20:02:48	928
1304	2024-12-03	2	20:37:06	5	Không dùng món ăn quá cay	2024-12-02 20:06:06	2024-12-03 21:22:06	487
1305	2024-12-03	1	19:23:05	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-02 18:44:05	2024-12-03 19:31:05	1307
1306	2024-12-03	1	20:41:27	1	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-02 20:30:27	2024-12-03 21:15:27	453
1307	2024-12-03	0	18:24:03	12	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-02 17:43:03	2024-12-03 18:40:03	416
1308	2024-12-03	1	20:19:58	7	Dọn sẵn đĩa và dao cắt bánh	2024-12-02 19:55:58	2024-12-03 20:48:58	493
1309	2024-12-03	1	19:08:21	9	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-02 18:35:21	2024-12-03 19:09:21	125
1310	2024-12-03	1	20:18:27	14	Có món ăn phù hợp với người lớn tuổi	2024-12-02 20:08:27	2024-12-03 20:46:27	465
1311	2024-12-03	1	18:32:31	3	Chuẩn bị thực đơn thuần chay	2024-12-02 17:55:31	2024-12-03 18:54:31	420
1312	2024-12-03	1	21:04:04	11	Không thêm muối vào các món ăn	2024-12-02 20:38:04	2024-12-03 21:35:04	1893
1313	2024-12-03	2	19:05:20	4	Có món ăn phù hợp với người lớn tuổi	2024-12-02 18:39:20	2024-12-03 19:40:20	1645
1314	2024-12-03	1	21:02:53	2	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-02 20:41:53	2024-12-03 21:08:53	1551
1315	2024-12-03	1	20:20:30	9	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-02 20:05:30	2024-12-03 20:37:30	1017
1316	2024-12-03	1	21:39:24	16	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-02 21:16:24	2024-12-03 22:14:24	1143
1317	2024-12-03	1	18:41:14	4	Bàn gần cửa sổ để ngắm cảnh	2024-12-02 18:16:14	2024-12-03 19:23:14	1747
1318	2024-12-03	0	19:38:05	12	Bàn gần cửa sổ để ngắm cảnh	2024-12-02 19:09:05	2024-12-03 19:48:05	1888
1319	2024-12-03	2	23:18:31	17	Có món ăn phù hợp với người lớn tuổi	2024-12-02 22:37:31	2024-12-03 23:47:31	1132
1320	2024-12-04	1	10:14:55	14	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-03 09:33:55	2024-12-04 10:20:55	1445
1321	2024-12-04	1	10:50:36	20	Cung cấp thực đơn không chứa gluten	2024-12-03 10:23:36	2024-12-04 11:17:36	701
1322	2024-12-04	1	08:56:27	1	Bàn gần cửa sổ để ngắm cảnh	2024-12-03 08:52:27	2024-12-04 09:33:27	1263
1323	2024-12-04	1	05:34:52	6	Có món ăn phù hợp với người lớn tuổi	2024-12-03 05:04:52	2024-12-04 06:08:52	1391
1324	2024-12-04	2	05:21:25	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-03 04:45:25	2024-12-04 05:54:25	1074
1325	2024-12-04	1	06:42:50	12	Có món ăn phù hợp với người lớn tuổi	2024-12-03 06:34:50	2024-12-04 06:45:50	1640
1326	2024-12-04	1	10:52:20	10	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-03 10:17:20	2024-12-04 11:17:20	1153
1327	2024-12-04	1	07:17:24	15	Thêm chỗ để xe đẩy cho trẻ em	2024-12-03 06:54:24	2024-12-04 07:37:24	1552
1328	2024-12-04	0	05:06:42	16	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-03 04:34:42	2024-12-04 05:51:42	1125
1329	2024-12-04	0	09:19:21	19	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-03 09:18:21	2024-12-04 09:39:21	918
1330	2024-12-04	1	06:31:38	10	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-03 06:29:38	2024-12-04 06:42:38	1250
1331	2024-12-04	1	16:23:23	18	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-03 16:14:23	2024-12-04 16:57:23	1129
1332	2024-12-04	0	17:42:23	3	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-03 17:38:23	2024-12-04 18:09:23	59
1333	2024-12-04	1	15:37:14	1	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-03 15:09:14	2024-12-04 16:21:14	1054
1334	2024-12-04	0	14:08:58	3	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-03 13:38:58	2024-12-04 14:31:58	355
1335	2024-12-04	2	11:58:53	19	Cung cấp thực đơn không chứa gluten	2024-12-03 11:25:53	2024-12-04 12:41:53	1481
1336	2024-12-04	1	13:14:05	11	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-03 12:42:05	2024-12-04 13:37:05	391
1337	2024-12-04	2	13:55:58	6	Dọn sẵn đĩa và dao cắt bánh	2024-12-03 13:30:58	2024-12-04 13:58:58	1982
1338	2024-12-04	1	16:20:39	11	Bàn gần cửa sổ để ngắm cảnh	2024-12-03 15:58:39	2024-12-04 16:34:39	428
1339	2024-12-04	2	16:47:48	1	Không dùng hành hoặc tỏi trong món ăn	2024-12-03 16:33:48	2024-12-04 16:50:48	372
1340	2024-12-04	1	14:30:54	19	Bàn gần cửa sổ để ngắm cảnh	2024-12-03 14:01:54	2024-12-04 14:54:54	1857
1341	2024-12-04	1	11:08:44	2	Không dùng hành hoặc tỏi trong món ăn	2024-12-03 10:54:44	2024-12-04 11:41:44	184
1342	2024-12-04	1	12:25:44	17	Dọn sẵn đĩa và dao cắt bánh	2024-12-03 12:06:44	2024-12-04 13:01:44	1828
1343	2024-12-04	1	20:37:56	7		2024-12-03 20:17:56	2024-12-04 21:08:56	603
1344	2024-12-04	0	19:16:19	13	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-03 19:03:19	2024-12-04 19:33:19	847
1345	2024-12-04	1	21:04:54	13	Thêm một đĩa trái cây cho trẻ em	2024-12-03 20:31:54	2024-12-04 21:32:54	1001
1346	2024-12-04	1	18:06:14	5	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-03 17:38:14	2024-12-04 18:40:14	1888
1347	2024-12-04	2	19:49:31	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-03 19:28:31	2024-12-04 20:06:31	1126
1348	2024-12-04	1	21:58:32	10	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-03 21:58:32	2024-12-04 22:19:32	1230
1349	2024-12-04	1	18:16:19	3	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-03 18:02:19	2024-12-04 18:22:19	600
1350	2024-12-04	0	18:04:03	14	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-03 17:55:03	2024-12-04 18:45:03	146
1351	2024-12-04	1	18:15:24	3	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-03 17:43:24	2024-12-04 18:22:24	210
1352	2024-12-04	2	20:50:13	3	Chuẩn bị thực đơn thuần chay	2024-12-03 20:36:13	2024-12-04 21:35:13	238
1353	2024-12-04	1	21:57:38	10	Dọn sẵn đĩa và dao cắt bánh	2024-12-03 21:53:38	2024-12-04 22:36:38	1532
1354	2024-12-04	1	20:46:20	4	Dọn sẵn đĩa và dao cắt bánh	2024-12-03 20:21:20	2024-12-04 21:14:20	1983
1355	2024-12-04	1	21:55:39	12	Dành chỗ ngồi cho nhóm 10 người	2024-12-03 21:25:39	2024-12-04 22:28:39	723
1356	2024-12-04	1	20:08:47	14	Không thêm muối vào các món ăn	2024-12-03 19:52:47	2024-12-04 20:32:47	691
1357	2024-12-04	1	21:21:56	15	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-03 21:12:56	2024-12-04 21:34:56	463
1358	2024-12-04	1	19:45:56	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-03 19:03:56	2024-12-04 20:18:56	1158
1359	2024-12-04	1	22:59:46	6	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-03 22:22:46	2024-12-04 23:23:46	815
1360	2024-12-05	1	09:18:51	8	Thêm một đĩa trái cây cho trẻ em	2024-12-04 08:53:51	2024-12-05 09:27:51	1432
1361	2024-12-05	0	10:18:20	11	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-04 10:08:20	2024-12-05 11:03:20	237
1362	2024-12-05	1	07:46:08	11	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-04 07:32:08	2024-12-05 07:51:08	814
1363	2024-12-05	1	05:19:00	6	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-04 05:05:00	2024-12-05 05:35:00	1944
1364	2024-12-05	1	07:15:45	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-04 06:38:45	2024-12-05 07:35:45	830
1365	2024-12-05	1	05:40:25	4	Dành chỗ ngồi cho nhóm 10 người	2024-12-04 04:57:25	2024-12-05 06:14:25	1425
1366	2024-12-05	1	10:42:32	20	Dọn sẵn đĩa và dao cắt bánh	2024-12-04 10:40:32	2024-12-05 10:48:32	622
1367	2024-12-05	1	05:53:21	13	Dọn sẵn đĩa và dao cắt bánh	2024-12-04 05:11:21	2024-12-05 06:38:21	1598
1368	2024-12-05	1	05:10:59	3	Không dùng món ăn quá cay	2024-12-04 04:31:59	2024-12-05 05:39:59	101
1369	2024-12-05	2	05:05:06	10	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-04 04:38:06	2024-12-05 05:36:06	1022
1370	2024-12-05	1	08:34:46	18	Không dùng hành hoặc tỏi trong món ăn	2024-12-04 08:25:46	2024-12-05 08:42:46	16
1371	2024-12-05	1	13:44:20	20	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-04 13:14:20	2024-12-05 14:07:20	1405
1372	2024-12-05	1	17:26:30	2	Cung cấp thực đơn không chứa gluten	2024-12-04 17:12:30	2024-12-05 18:09:30	964
1373	2024-12-05	1	15:21:43	7	Có món ăn phù hợp với người lớn tuổi	2024-12-04 14:42:43	2024-12-05 15:46:43	461
1374	2024-12-05	1	15:55:48	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-04 15:46:48	2024-12-05 16:14:48	687
1375	2024-12-05	2	12:33:18	10	Không thêm muối vào các món ăn	2024-12-04 12:00:18	2024-12-05 12:41:18	1922
1376	2024-12-05	1	17:31:45	6	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-04 17:12:45	2024-12-05 17:33:45	83
1377	2024-12-05	1	16:11:57	12	Dọn sẵn đĩa và dao cắt bánh	2024-12-04 15:56:57	2024-12-05 16:56:57	1760
1378	2024-12-05	1	11:43:46	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-04 11:37:46	2024-12-05 12:13:46	221
1379	2024-12-05	1	12:28:19	20	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-04 12:25:19	2024-12-05 13:00:19	1133
1380	2024-12-05	2	15:41:08	7	Dành chỗ ngồi cho nhóm 10 người	2024-12-04 15:06:08	2024-12-05 16:18:08	894
1381	2024-12-05	2	15:28:36	8	Thêm một đĩa trái cây cho trẻ em	2024-12-04 15:07:36	2024-12-05 16:09:36	24
1382	2024-12-05	1	15:39:34	6	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-04 14:56:34	2024-12-05 16:19:34	1305
1383	2024-12-05	1	19:11:19	4		2024-12-04 19:08:19	2024-12-05 19:24:19	86
1384	2024-12-05	2	21:53:13	20	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-04 21:17:13	2024-12-05 22:02:13	1665
1385	2024-12-05	1	20:30:26	7	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-04 19:58:26	2024-12-05 20:34:26	866
1386	2024-12-05	1	21:29:47	4	Thêm một đĩa trái cây cho trẻ em	2024-12-04 21:13:47	2024-12-05 21:53:47	504
1387	2024-12-05	1	19:18:29	4	Bàn gần cửa sổ để ngắm cảnh	2024-12-04 18:34:29	2024-12-05 19:45:29	143
1388	2024-12-05	2	18:30:53	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-04 18:17:53	2024-12-05 18:54:53	1301
1389	2024-12-05	2	19:27:58	5	Thêm chỗ để xe đẩy cho trẻ em	2024-12-04 19:16:58	2024-12-05 19:39:58	966
1390	2024-12-05	1	19:13:49	3	Bàn gần cửa sổ để ngắm cảnh	2024-12-04 18:48:49	2024-12-05 19:40:49	1949
1391	2024-12-05	1	21:57:51	7		2024-12-04 21:27:51	2024-12-05 22:17:51	1551
1392	2024-12-05	1	18:04:12	15	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-04 17:49:12	2024-12-05 18:32:12	1744
1393	2024-12-05	0	21:14:13	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-04 20:52:13	2024-12-05 21:45:13	1000
1394	2024-12-05	2	18:21:25	4	Thêm một đĩa trái cây cho trẻ em	2024-12-04 18:21:25	2024-12-05 18:53:25	137
1395	2024-12-05	1	19:38:21	9	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-04 19:22:21	2024-12-05 20:13:21	578
1396	2024-12-05	1	20:47:01	13	Chuẩn bị thực đơn thuần chay	2024-12-04 20:36:01	2024-12-05 21:14:01	219
1397	2024-12-05	1	21:18:44	19	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-04 21:15:44	2024-12-05 21:38:44	1315
1398	2024-12-05	1	19:20:05	3	Không dùng món ăn quá cay	2024-12-04 19:16:05	2024-12-05 19:53:05	1360
1399	2024-12-05	2	22:54:22	1	Bàn gần cửa sổ để ngắm cảnh	2024-12-04 22:11:22	2024-12-05 22:55:22	185
1400	2024-12-06	2	07:21:14	8	Thêm chỗ để xe đẩy cho trẻ em	2024-12-05 06:56:14	2024-12-06 07:45:14	1748
1401	2024-12-06	1	09:55:42	13	Cung cấp thực đơn không chứa gluten	2024-12-05 09:49:42	2024-12-06 10:07:42	1566
1402	2024-12-06	0	09:51:03	15	Thêm chỗ để xe đẩy cho trẻ em	2024-12-05 09:33:03	2024-12-06 10:15:03	673
1403	2024-12-06	1	06:40:38	18	Thêm chỗ để xe đẩy cho trẻ em	2024-12-05 06:05:38	2024-12-06 07:13:38	840
1404	2024-12-06	1	08:24:06	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-05 07:52:06	2024-12-06 08:45:06	1699
1405	2024-12-06	1	05:01:37	6	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-05 04:19:37	2024-12-06 05:12:37	685
1406	2024-12-06	0	06:38:50	19	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-05 06:04:50	2024-12-06 07:05:50	1992
1407	2024-12-06	1	06:47:25	14	Dành chỗ ngồi cho nhóm 10 người	2024-12-05 06:25:25	2024-12-06 07:17:25	478
1408	2024-12-06	1	05:16:29	18	Cung cấp thực đơn không chứa gluten	2024-12-05 05:03:29	2024-12-06 05:25:29	473
1409	2024-12-06	1	10:14:53	1	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-05 10:13:53	2024-12-06 10:38:53	1349
1410	2024-12-06	1	09:53:22	12	Dành chỗ ngồi cho nhóm 10 người	2024-12-05 09:29:22	2024-12-06 10:20:22	1685
1411	2024-12-06	1	13:18:41	20	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-05 13:09:41	2024-12-06 13:21:41	1016
1412	2024-12-06	1	12:41:28	8	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-05 12:32:28	2024-12-06 13:09:28	851
1413	2024-12-06	0	11:19:55	20	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-05 10:50:55	2024-12-06 11:58:55	803
1414	2024-12-06	0	13:49:21	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-05 13:07:21	2024-12-06 13:58:21	1132
1415	2024-12-06	1	11:54:38	2	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-05 11:40:38	2024-12-06 12:18:38	1191
1416	2024-12-06	1	14:57:27	4	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-05 14:26:27	2024-12-06 15:32:27	339
1417	2024-12-06	1	11:01:15	6	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-05 10:24:15	2024-12-06 11:18:15	1257
1418	2024-12-06	1	16:03:37	10	Không dùng hành hoặc tỏi trong món ăn	2024-12-05 15:35:37	2024-12-06 16:26:37	879
1419	2024-12-06	1	16:30:10	20	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-05 16:10:10	2024-12-06 17:12:10	352
1420	2024-12-06	1	12:05:06	7	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-05 11:26:06	2024-12-06 12:17:06	775
1421	2024-12-06	0	11:12:21	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-05 11:06:21	2024-12-06 11:50:21	621
1422	2024-12-06	2	12:40:45	2	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-05 12:28:45	2024-12-06 12:54:45	1384
1423	2024-12-06	1	19:05:45	5	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-05 18:50:45	2024-12-06 19:44:45	848
1424	2024-12-06	1	19:50:03	11	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-05 19:46:03	2024-12-06 20:34:03	605
1425	2024-12-06	1	21:01:11	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-05 20:36:11	2024-12-06 21:01:11	1867
1426	2024-12-06	0	21:19:13	10	Không dùng hành hoặc tỏi trong món ăn	2024-12-05 21:05:13	2024-12-06 21:38:13	96
1427	2024-12-06	1	20:29:44	1	Có món ăn phù hợp với người lớn tuổi	2024-12-05 19:49:44	2024-12-06 20:31:44	842
1428	2024-12-06	1	19:59:52	1	Dành chỗ ngồi cho nhóm 10 người	2024-12-05 19:51:52	2024-12-06 20:02:52	1388
1429	2024-12-06	2	18:13:25	14	Cung cấp thực đơn không chứa gluten	2024-12-05 17:56:25	2024-12-06 18:35:25	1557
1430	2024-12-06	1	18:45:33	15	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-05 18:45:33	2024-12-06 19:09:33	376
1431	2024-12-06	2	19:33:49	4	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-05 19:02:49	2024-12-06 19:50:49	662
1432	2024-12-06	0	19:00:53	5	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-05 18:24:53	2024-12-06 19:15:53	1264
1433	2024-12-06	1	18:20:23	15	Thêm một đĩa trái cây cho trẻ em	2024-12-05 18:10:23	2024-12-06 18:41:23	92
1434	2024-12-06	1	20:03:08	7	Không thêm muối vào các món ăn	2024-12-05 19:26:08	2024-12-06 20:23:08	1519
1435	2024-12-06	1	18:03:47	9	Chuẩn bị thực đơn thuần chay	2024-12-05 17:19:47	2024-12-06 18:45:47	124
1436	2024-12-06	2	18:41:46	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-05 18:23:46	2024-12-06 18:47:46	643
1437	2024-12-06	1	19:13:38	14	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-05 19:04:38	2024-12-06 19:26:38	882
1438	2024-12-06	1	20:34:00	6	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-05 19:54:00	2024-12-06 20:47:00	1119
1439	2024-12-07	1	00:26:41	15	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-06 00:10:41	2024-12-07 00:49:41	3
1440	2024-12-07	1	10:33:50	8	Không thêm muối vào các món ăn	2024-12-06 10:17:50	2024-12-07 11:13:50	844
1441	2024-12-07	1	09:46:36	16	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-06 09:16:36	2024-12-07 10:15:36	379
1442	2024-12-07	0	10:12:16	16	Dọn sẵn đĩa và dao cắt bánh	2024-12-06 09:32:16	2024-12-07 10:28:16	1830
1443	2024-12-07	1	07:36:29	5	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-06 07:28:29	2024-12-07 07:56:29	911
1444	2024-12-07	0	06:58:58	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-06 06:34:58	2024-12-07 07:01:58	1241
1445	2024-12-07	1	09:40:11	12	Thêm một đĩa trái cây cho trẻ em	2024-12-06 09:21:11	2024-12-07 10:09:11	1854
1446	2024-12-07	2	09:10:50	1	Dọn sẵn đĩa và dao cắt bánh	2024-12-06 08:56:50	2024-12-07 09:17:50	1821
1447	2024-12-07	1	10:11:47	5	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-06 09:31:47	2024-12-07 10:30:47	1376
1448	2024-12-07	1	09:30:12	17	Cung cấp thực đơn không chứa gluten	2024-12-06 09:22:12	2024-12-07 10:06:12	1123
1449	2024-12-07	1	09:36:10	11	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-06 09:25:10	2024-12-07 10:11:10	4
1450	2024-12-07	1	09:10:20	2	Có món ăn phù hợp với người lớn tuổi	2024-12-06 08:40:20	2024-12-07 09:26:20	1061
1451	2024-12-07	1	12:43:45	4	Dành chỗ ngồi cho nhóm 10 người	2024-12-06 12:43:45	2024-12-07 12:44:45	252
1452	2024-12-07	1	12:18:17	15	Không dùng món ăn quá cay	2024-12-06 11:41:17	2024-12-07 12:37:17	453
1453	2024-12-07	1	14:28:32	16	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-06 14:02:32	2024-12-07 15:12:32	1068
1454	2024-12-07	2	13:49:04	11	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-06 13:24:04	2024-12-07 13:52:04	7
1455	2024-12-07	0	15:28:24	1	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-06 14:44:24	2024-12-07 15:35:24	1769
1456	2024-12-07	0	15:05:59	18	Thêm một đĩa trái cây cho trẻ em	2024-12-06 14:45:59	2024-12-07 15:12:59	1341
1457	2024-12-07	1	11:22:18	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-06 10:39:18	2024-12-07 11:49:18	900
1458	2024-12-07	0	15:25:09	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-06 15:07:09	2024-12-07 15:25:09	1268
1459	2024-12-07	0	16:25:57	15	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-06 16:18:57	2024-12-07 16:54:57	264
1460	2024-12-07	1	13:56:35	4	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-06 13:35:35	2024-12-07 14:11:35	158
1461	2024-12-07	1	14:58:15	15	Không dùng món ăn quá cay	2024-12-06 14:25:15	2024-12-07 15:09:15	1723
1462	2024-12-07	1	15:48:02	4	Bàn gần cửa sổ để ngắm cảnh	2024-12-06 15:17:02	2024-12-07 16:33:02	617
1463	2024-12-07	0	19:46:11	8	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-06 19:16:11	2024-12-07 20:00:11	1579
1464	2024-12-07	1	19:01:24	16	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-06 18:47:24	2024-12-07 19:02:24	1781
1465	2024-12-07	1	20:01:23	3	Dọn sẵn đĩa và dao cắt bánh	2024-12-06 19:38:23	2024-12-07 20:19:23	616
1466	2024-12-07	1	21:12:57	3	Dọn sẵn đĩa và dao cắt bánh	2024-12-06 20:41:57	2024-12-07 21:12:57	1331
1467	2024-12-07	1	19:24:38	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-06 18:52:38	2024-12-07 19:46:38	1147
1468	2024-12-07	1	19:51:47	4	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-06 19:22:47	2024-12-07 20:28:47	837
1469	2024-12-07	1	18:25:34	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-06 17:58:34	2024-12-07 18:26:34	643
1470	2024-12-07	1	20:01:16	18	Thêm chỗ để xe đẩy cho trẻ em	2024-12-06 19:42:16	2024-12-07 20:41:16	1536
1471	2024-12-07	1	18:01:31	14	Bàn gần cửa sổ để ngắm cảnh	2024-12-06 17:46:31	2024-12-07 18:08:31	564
1472	2024-12-07	1	21:00:33	3	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-06 20:35:33	2024-12-07 21:21:33	1566
1473	2024-12-07	0	21:48:17	3	Không thêm muối vào các món ăn	2024-12-06 21:41:17	2024-12-07 22:20:17	1869
1474	2024-12-07	0	19:00:45	19		2024-12-06 18:28:45	2024-12-07 19:12:45	1689
1475	2024-12-07	1	19:09:19	11	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-06 18:52:19	2024-12-07 19:47:19	803
1476	2024-12-07	1	19:42:43	2	Dành chỗ ngồi cho nhóm 10 người	2024-12-06 19:41:43	2024-12-07 19:48:43	41
1477	2024-12-07	1	20:21:13	14	Cung cấp thực đơn không chứa gluten	2024-12-06 20:11:13	2024-12-07 20:55:13	1483
1478	2024-12-07	1	18:08:04	6	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-06 17:50:04	2024-12-07 18:15:04	334
1479	2024-12-08	0	00:20:29	11	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-06 23:53:29	2024-12-08 01:01:29	1361
1480	2024-12-08	1	10:29:54	11	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-07 10:01:54	2024-12-08 10:29:54	446
1481	2024-12-08	2	10:20:17	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-07 09:52:17	2024-12-08 10:40:17	1111
1482	2024-12-08	0	08:10:45	13	Không dùng món ăn quá cay	2024-12-07 08:07:45	2024-12-08 08:39:45	1604
1483	2024-12-08	0	08:57:21	13	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-07 08:16:21	2024-12-08 09:14:21	815
1484	2024-12-08	1	07:01:35	20	Không thêm muối vào các món ăn	2024-12-07 06:45:35	2024-12-08 07:14:35	1234
1485	2024-12-08	1	06:04:37	20	Không thêm muối vào các món ăn	2024-12-07 05:25:37	2024-12-08 06:08:37	1805
1486	2024-12-08	1	08:10:41	12	Không dùng hành hoặc tỏi trong món ăn	2024-12-07 08:07:41	2024-12-08 08:10:41	1610
1487	2024-12-08	1	06:21:46	1	Dọn sẵn đĩa và dao cắt bánh	2024-12-07 05:53:46	2024-12-08 06:42:46	1867
1488	2024-12-08	0	07:20:18	20	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-07 07:01:18	2024-12-08 07:30:18	1712
1489	2024-12-08	1	10:54:16	20	Chuẩn bị thực đơn thuần chay	2024-12-07 10:11:16	2024-12-08 11:28:16	1866
1490	2024-12-08	1	09:27:39	15	Bàn gần cửa sổ để ngắm cảnh	2024-12-07 09:01:39	2024-12-08 09:42:39	1459
1491	2024-12-08	1	17:45:41	6	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-07 17:26:41	2024-12-08 18:05:41	1556
1492	2024-12-08	1	16:56:38	10	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-07 16:36:38	2024-12-08 17:17:38	1020
1493	2024-12-08	1	13:31:33	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-07 13:16:33	2024-12-08 13:49:33	1437
1494	2024-12-08	1	11:23:34	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-07 10:56:34	2024-12-08 11:30:34	346
1495	2024-12-08	0	14:12:05	1	Bàn gần cửa sổ để ngắm cảnh	2024-12-07 13:32:05	2024-12-08 14:30:05	1086
1496	2024-12-08	1	11:41:36	9	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-07 11:28:36	2024-12-08 11:57:36	4
1497	2024-12-08	1	17:49:11	11	Thêm một đĩa trái cây cho trẻ em	2024-12-07 17:38:11	2024-12-08 18:09:11	419
1498	2024-12-08	2	17:26:48	8	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-07 17:07:48	2024-12-08 17:59:48	404
1499	2024-12-08	2	12:54:55	2	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-07 12:53:55	2024-12-08 13:32:55	247
1500	2024-12-08	1	15:00:26	8		2024-12-07 14:20:26	2024-12-08 15:37:26	294
1501	2024-12-08	1	14:53:30	4	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-07 14:51:30	2024-12-08 15:05:30	234
1502	2024-12-08	2	11:49:29	3	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-07 11:44:29	2024-12-08 11:57:29	1101
1503	2024-12-08	0	21:30:07	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-07 20:49:07	2024-12-08 21:58:07	495
1504	2024-12-08	1	18:33:16	16		2024-12-07 18:14:16	2024-12-08 19:14:16	613
1505	2024-12-08	1	20:53:48	3	Thêm một đĩa trái cây cho trẻ em	2024-12-07 20:12:48	2024-12-08 20:54:48	345
1506	2024-12-08	0	18:53:54	20	Không dùng món ăn quá cay	2024-12-07 18:15:54	2024-12-08 19:24:54	265
1507	2024-12-08	2	20:27:18	18	Thêm chỗ để xe đẩy cho trẻ em	2024-12-07 20:24:18	2024-12-08 20:51:18	968
1508	2024-12-08	1	20:05:58	2	Thêm một đĩa trái cây cho trẻ em	2024-12-07 19:48:58	2024-12-08 20:16:58	1769
1509	2024-12-08	1	18:25:18	14	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-07 17:53:18	2024-12-08 18:55:18	765
1510	2024-12-08	1	21:00:57	1	Cung cấp thực đơn không chứa gluten	2024-12-07 20:33:57	2024-12-08 21:27:57	986
1511	2024-12-08	1	20:04:21	13	Cung cấp thực đơn không chứa gluten	2024-12-07 19:20:21	2024-12-08 20:24:21	1951
1512	2024-12-08	1	20:22:24	8	Bàn gần cửa sổ để ngắm cảnh	2024-12-07 20:17:24	2024-12-08 20:45:24	1213
1513	2024-12-08	2	20:42:11	14	Có món ăn phù hợp với người lớn tuổi	2024-12-07 20:09:11	2024-12-08 21:27:11	191
1514	2024-12-08	1	21:19:48	5		2024-12-07 20:53:48	2024-12-08 21:26:48	1886
1515	2024-12-08	1	21:28:40	15	Không dùng món ăn quá cay	2024-12-07 21:01:40	2024-12-08 22:06:40	1201
1516	2024-12-08	1	19:24:25	17	Bàn gần cửa sổ để ngắm cảnh	2024-12-07 18:41:25	2024-12-08 19:54:25	422
1517	2024-12-08	2	19:50:24	8	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-07 19:45:24	2024-12-08 19:57:24	1813
1518	2024-12-08	1	20:23:18	14	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-07 19:50:18	2024-12-08 21:08:18	1686
1519	2024-12-08	1	22:41:15	3		2024-12-07 22:17:15	2024-12-08 22:57:15	526
1520	2024-12-09	2	09:35:25	1	Không dùng hành hoặc tỏi trong món ăn	2024-12-08 09:19:25	2024-12-09 10:13:25	1372
1521	2024-12-09	2	05:17:05	10	Cung cấp thực đơn không chứa gluten	2024-12-08 05:14:05	2024-12-09 05:29:05	1248
1522	2024-12-09	1	08:45:34	19	Cung cấp thực đơn không chứa gluten	2024-12-08 08:41:34	2024-12-09 09:23:34	1898
1523	2024-12-09	1	05:41:42	13	Chuẩn bị thực đơn thuần chay	2024-12-08 05:36:42	2024-12-09 05:46:42	184
1524	2024-12-09	1	06:20:36	16	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-08 05:47:36	2024-12-09 06:50:36	1550
1525	2024-12-09	1	10:42:36	16	Cung cấp thực đơn không chứa gluten	2024-12-08 10:23:36	2024-12-09 10:56:36	1838
1526	2024-12-09	1	05:48:15	11	Dọn sẵn đĩa và dao cắt bánh	2024-12-08 05:43:15	2024-12-09 06:30:15	1845
1527	2024-12-09	1	10:18:12	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-08 10:10:12	2024-12-09 10:30:12	1531
1528	2024-12-09	2	09:08:56	11	Cung cấp thực đơn không chứa gluten	2024-12-08 08:44:56	2024-12-09 09:40:56	1755
1529	2024-12-09	1	09:32:48	8	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-08 09:00:48	2024-12-09 09:42:48	388
1530	2024-12-09	1	09:49:04	5	Thêm một đĩa trái cây cho trẻ em	2024-12-08 09:31:04	2024-12-09 09:54:04	1090
1531	2024-12-09	1	13:19:02	2	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-08 12:57:02	2024-12-09 14:00:02	1791
1532	2024-12-09	0	13:41:12	1	Không thêm muối vào các món ăn	2024-12-08 13:22:12	2024-12-09 14:06:12	1208
1533	2024-12-09	1	15:06:09	7	Chuẩn bị thực đơn thuần chay	2024-12-08 14:47:09	2024-12-09 15:20:09	1980
1534	2024-12-09	2	17:06:41	17	Không dùng hành hoặc tỏi trong món ăn	2024-12-08 16:49:41	2024-12-09 17:16:41	1993
1535	2024-12-09	1	13:01:11	3	Không dùng món ăn quá cay	2024-12-08 12:49:11	2024-12-09 13:45:11	1516
1536	2024-12-09	2	17:06:39	2	Thêm chỗ để xe đẩy cho trẻ em	2024-12-08 16:33:39	2024-12-09 17:51:39	1749
1537	2024-12-09	1	14:32:07	2	Không dùng hành hoặc tỏi trong món ăn	2024-12-08 13:49:07	2024-12-09 15:09:07	19
1538	2024-12-09	1	12:42:16	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-08 12:03:16	2024-12-09 13:11:16	1066
1539	2024-12-09	1	16:17:02	7	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-08 16:07:02	2024-12-09 16:37:02	1595
1540	2024-12-09	0	17:39:52	11		2024-12-08 17:00:52	2024-12-09 17:39:52	908
1541	2024-12-09	1	17:16:52	3	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-08 17:09:52	2024-12-09 17:24:52	1398
1542	2024-12-09	0	11:42:18	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-08 11:10:18	2024-12-09 12:17:18	1069
1543	2024-12-09	0	18:25:09	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-08 17:43:09	2024-12-09 18:54:09	1811
1544	2024-12-09	2	19:54:09	13	Chuẩn bị thực đơn thuần chay	2024-12-08 19:14:09	2024-12-09 20:07:09	58
1545	2024-12-09	1	20:36:02	9	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-08 20:26:02	2024-12-09 20:40:02	1453
1546	2024-12-09	0	21:06:52	12	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-08 20:59:52	2024-12-09 21:45:52	733
1547	2024-12-09	1	20:56:17	11	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-08 20:13:17	2024-12-09 21:32:17	1104
1548	2024-12-09	2	18:19:27	6	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-08 18:09:27	2024-12-09 18:47:27	235
1549	2024-12-09	1	19:45:37	7	Dành chỗ ngồi cho nhóm 10 người	2024-12-08 19:21:37	2024-12-09 20:02:37	426
1550	2024-12-09	1	18:55:15	9	Không thêm muối vào các món ăn	2024-12-08 18:12:15	2024-12-09 19:14:15	1277
1551	2024-12-09	2	19:55:04	7	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-08 19:36:04	2024-12-09 20:40:04	451
1552	2024-12-09	0	18:53:54	4	Không thêm muối vào các món ăn	2024-12-08 18:35:54	2024-12-09 19:25:54	253
1553	2024-12-09	1	19:27:53	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-08 19:16:53	2024-12-09 19:42:53	595
1554	2024-12-09	1	19:47:31	2	Bàn gần cửa sổ để ngắm cảnh	2024-12-08 19:29:31	2024-12-09 19:58:31	1515
1555	2024-12-09	2	18:12:59	4	Không thêm muối vào các món ăn	2024-12-08 17:29:59	2024-12-09 18:54:59	1842
1556	2024-12-09	1	21:29:54	20	Không thêm muối vào các món ăn	2024-12-08 20:45:54	2024-12-09 22:11:54	1293
1557	2024-12-09	0	19:07:29	10	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-08 19:06:29	2024-12-09 19:40:29	549
1558	2024-12-09	1	19:17:45	2	Dọn sẵn đĩa và dao cắt bánh	2024-12-08 19:07:45	2024-12-09 19:31:45	751
1559	2024-12-10	0	00:44:58	19	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-09 00:15:58	2024-12-10 01:25:58	130
1560	2024-12-10	1	08:31:15	9	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-09 08:11:15	2024-12-10 08:59:15	622
1561	2024-12-10	1	08:59:52	4	Dành chỗ ngồi cho nhóm 10 người	2024-12-09 08:15:52	2024-12-10 09:29:52	1533
1562	2024-12-10	1	09:40:09	17	Dành chỗ ngồi cho nhóm 10 người	2024-12-09 09:28:09	2024-12-10 09:48:09	52
1563	2024-12-10	1	06:28:44	19		2024-12-09 06:11:44	2024-12-10 06:59:44	105
1564	2024-12-10	1	09:54:43	9	Dọn sẵn đĩa và dao cắt bánh	2024-12-09 09:21:43	2024-12-10 09:57:43	450
1565	2024-12-10	1	06:28:43	1	Cung cấp thực đơn không chứa gluten	2024-12-09 06:13:43	2024-12-10 06:35:43	1474
1566	2024-12-10	0	05:41:50	6	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-09 05:41:50	2024-12-10 05:51:50	255
1567	2024-12-10	1	08:45:33	11	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-09 08:10:33	2024-12-10 09:22:33	1333
1568	2024-12-10	1	09:36:32	15	Không thêm muối vào các món ăn	2024-12-09 08:58:32	2024-12-10 09:43:32	1645
1569	2024-12-10	0	08:46:59	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-09 08:19:59	2024-12-10 08:50:59	1926
1570	2024-12-10	1	10:16:39	5	Thêm chỗ để xe đẩy cho trẻ em	2024-12-09 10:04:39	2024-12-10 10:55:39	754
1571	2024-12-10	1	16:11:30	3	Thêm một đĩa trái cây cho trẻ em	2024-12-09 16:09:30	2024-12-10 16:41:30	1805
1572	2024-12-10	1	15:01:49	14	Không thêm muối vào các món ăn	2024-12-09 14:33:49	2024-12-10 15:41:49	1383
1573	2024-12-10	0	16:54:23	11	Không thêm muối vào các món ăn	2024-12-09 16:43:23	2024-12-10 17:03:23	1544
1574	2024-12-10	2	15:27:33	1	Có món ăn phù hợp với người lớn tuổi	2024-12-09 14:44:33	2024-12-10 15:40:33	1379
1575	2024-12-10	2	15:25:36	4	Dành chỗ ngồi cho nhóm 10 người	2024-12-09 15:04:36	2024-12-10 16:08:36	1975
1576	2024-12-10	1	15:52:08	1	Chuẩn bị thực đơn thuần chay	2024-12-09 15:16:08	2024-12-10 16:23:08	1758
1577	2024-12-10	2	13:52:18	8	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-09 13:10:18	2024-12-10 14:18:18	1566
1578	2024-12-10	1	14:23:59	2	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-09 14:04:59	2024-12-10 15:07:59	636
1579	2024-12-10	1	13:53:35	9	Dành chỗ ngồi cho nhóm 10 người	2024-12-09 13:16:35	2024-12-10 14:27:35	1769
1580	2024-12-10	0	12:12:24	13	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-09 11:39:24	2024-12-10 12:18:24	4
1581	2024-12-10	1	13:30:27	9	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-09 13:11:27	2024-12-10 14:02:27	515
1582	2024-12-10	1	17:13:21	3		2024-12-09 16:56:21	2024-12-10 17:25:21	545
1583	2024-12-10	2	20:29:13	11	Thêm chỗ để xe đẩy cho trẻ em	2024-12-09 20:21:13	2024-12-10 20:36:13	1512
1584	2024-12-10	1	19:43:30	20	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-09 19:25:30	2024-12-10 20:27:30	1117
1585	2024-12-10	1	18:12:17	16	Không dùng hành hoặc tỏi trong món ăn	2024-12-09 17:29:17	2024-12-10 18:21:17	1473
1586	2024-12-10	2	20:47:02	9	Thêm chỗ để xe đẩy cho trẻ em	2024-12-09 20:43:02	2024-12-10 21:17:02	164
1587	2024-12-10	1	21:47:34	15	Không dùng món ăn quá cay	2024-12-09 21:15:34	2024-12-10 22:27:34	1866
1588	2024-12-10	0	21:03:58	7	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-09 20:35:58	2024-12-10 21:48:58	1213
1589	2024-12-10	1	19:29:31	1	Cung cấp thực đơn không chứa gluten	2024-12-09 18:56:31	2024-12-10 20:00:31	772
1590	2024-12-10	2	20:16:23	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-09 19:46:23	2024-12-10 20:29:23	1149
1591	2024-12-10	1	18:21:19	3	Dành chỗ ngồi cho nhóm 10 người	2024-12-09 17:57:19	2024-12-10 18:59:19	1990
1592	2024-12-10	1	20:43:07	6	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-09 20:43:07	2024-12-10 21:25:07	1071
1593	2024-12-10	1	20:21:51	3	Cung cấp thực đơn không chứa gluten	2024-12-09 19:42:51	2024-12-10 20:25:51	1162
1594	2024-12-10	1	18:31:51	3	Dành chỗ ngồi cho nhóm 10 người	2024-12-09 17:58:51	2024-12-10 18:46:51	963
1595	2024-12-10	2	18:58:04	1	Có món ăn phù hợp với người lớn tuổi	2024-12-09 18:30:04	2024-12-10 19:22:04	799
1596	2024-12-10	1	19:32:57	12	Thêm một đĩa trái cây cho trẻ em	2024-12-09 19:03:57	2024-12-10 19:44:57	397
1597	2024-12-10	1	21:00:24	18	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-09 20:33:24	2024-12-10 21:26:24	262
1598	2024-12-10	1	20:52:50	2	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-09 20:47:50	2024-12-10 21:08:50	761
1599	2024-12-10	0	23:37:20	18	Dành chỗ ngồi cho nhóm 10 người	2024-12-09 23:03:20	2024-12-11 00:14:20	872
1600	2024-12-11	1	10:00:58	6	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-10 09:36:58	2024-12-11 10:43:58	656
1601	2024-12-11	1	10:54:19	8	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-10 10:14:19	2024-12-11 11:06:19	177
1602	2024-12-11	1	10:16:18	20	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-10 10:12:18	2024-12-11 10:43:18	1313
1603	2024-12-11	2	05:56:17	14	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-10 05:49:17	2024-12-11 06:12:17	749
1604	2024-12-11	1	07:46:13	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-10 07:18:13	2024-12-11 07:48:13	1075
1605	2024-12-11	1	08:38:25	1	Không dùng món ăn quá cay	2024-12-10 08:01:25	2024-12-11 08:58:25	1159
1606	2024-12-11	1	08:05:05	15	Không dùng món ăn quá cay	2024-12-10 07:45:05	2024-12-11 08:50:05	1913
1607	2024-12-11	2	06:35:49	7	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-10 06:07:49	2024-12-11 07:03:49	1819
1608	2024-12-11	1	06:08:47	7	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-10 05:52:47	2024-12-11 06:51:47	1215
1609	2024-12-11	1	08:14:48	4	Không dùng món ăn quá cay	2024-12-10 07:46:48	2024-12-11 08:32:48	684
1610	2024-12-11	1	08:01:18	12	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-10 07:30:18	2024-12-11 08:14:18	656
1611	2024-12-11	1	15:35:31	17	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-10 15:31:31	2024-12-11 15:58:31	1622
1612	2024-12-11	0	15:36:32	10	Chuẩn bị thực đơn thuần chay	2024-12-10 15:14:32	2024-12-11 15:40:32	1146
1613	2024-12-11	1	13:32:29	3	Không dùng món ăn quá cay	2024-12-10 13:17:29	2024-12-11 13:46:29	12
1614	2024-12-11	1	11:33:25	18	Cung cấp thực đơn không chứa gluten	2024-12-10 11:05:25	2024-12-11 11:46:25	94
1615	2024-12-11	1	13:01:59	4	Thêm chỗ để xe đẩy cho trẻ em	2024-12-10 12:39:59	2024-12-11 13:20:59	741
1616	2024-12-11	1	17:10:51	7	Cung cấp thực đơn không chứa gluten	2024-12-10 16:46:51	2024-12-11 17:38:51	1736
1617	2024-12-11	1	16:59:56	6	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-10 16:36:56	2024-12-11 17:06:56	1334
1618	2024-12-11	1	13:20:44	2	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-10 13:01:44	2024-12-11 13:33:44	1376
1619	2024-12-11	1	13:04:45	19	Không thêm muối vào các món ăn	2024-12-10 12:36:45	2024-12-11 13:09:45	688
1620	2024-12-11	1	13:34:35	1	Dành chỗ ngồi cho nhóm 10 người	2024-12-10 13:30:35	2024-12-11 13:49:35	570
1621	2024-12-11	1	12:41:51	17	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-10 12:17:51	2024-12-11 12:41:51	1378
1622	2024-12-11	1	13:42:27	5	Bàn gần cửa sổ để ngắm cảnh	2024-12-10 13:09:27	2024-12-11 13:52:27	225
1623	2024-12-11	2	20:18:55	3	Thêm một đĩa trái cây cho trẻ em	2024-12-10 19:35:55	2024-12-11 20:51:55	1156
1624	2024-12-11	0	21:53:27	3	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-10 21:47:27	2024-12-11 22:13:27	1594
1625	2024-12-11	1	18:08:20	8	Chuẩn bị thực đơn thuần chay	2024-12-10 18:04:20	2024-12-11 18:44:20	413
1626	2024-12-11	1	19:14:41	9	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-10 19:00:41	2024-12-11 19:58:41	1586
1627	2024-12-11	1	20:37:25	5	Thêm chỗ để xe đẩy cho trẻ em	2024-12-10 20:25:25	2024-12-11 21:04:25	147
1628	2024-12-11	1	19:31:04	9	Cung cấp thực đơn không chứa gluten	2024-12-10 19:19:04	2024-12-11 20:07:04	713
1629	2024-12-11	0	18:15:51	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-10 17:44:51	2024-12-11 18:20:51	1636
1630	2024-12-11	2	20:02:20	2	Cung cấp thực đơn không chứa gluten	2024-12-10 19:26:20	2024-12-11 20:40:20	730
1631	2024-12-11	0	20:58:26	10	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-10 20:47:26	2024-12-11 21:19:26	285
1632	2024-12-11	1	21:25:13	7	Dọn sẵn đĩa và dao cắt bánh	2024-12-10 20:56:13	2024-12-11 21:45:13	424
1633	2024-12-11	2	20:20:28	11		2024-12-10 19:49:28	2024-12-11 20:59:28	896
1634	2024-12-11	1	20:01:49	4	Cung cấp thực đơn không chứa gluten	2024-12-10 19:25:49	2024-12-11 20:07:49	584
1635	2024-12-11	2	21:08:09	18	Không dùng món ăn quá cay	2024-12-10 20:36:09	2024-12-11 21:44:09	960
1636	2024-12-11	1	18:54:13	1	Chuẩn bị thực đơn thuần chay	2024-12-10 18:46:13	2024-12-11 19:33:13	1972
1637	2024-12-11	2	18:08:45	15	Chuẩn bị thực đơn thuần chay	2024-12-10 17:31:45	2024-12-11 18:35:45	1919
1638	2024-12-11	1	20:39:27	18	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-10 20:19:27	2024-12-11 21:20:27	1051
1639	2024-12-11	1	23:22:35	6	Chuẩn bị thực đơn thuần chay	2024-12-10 22:57:35	2024-12-11 23:39:35	1370
1640	2024-12-12	1	05:09:52	3	Không thêm muối vào các món ăn	2024-12-11 05:07:52	2024-12-12 05:20:52	1214
1641	2024-12-12	2	10:01:56	18	Dọn sẵn đĩa và dao cắt bánh	2024-12-11 09:42:56	2024-12-12 10:24:56	1601
1642	2024-12-12	1	06:10:16	12	Có món ăn phù hợp với người lớn tuổi	2024-12-11 05:38:16	2024-12-12 06:28:16	797
1643	2024-12-12	1	05:14:28	3	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-11 05:02:28	2024-12-12 05:37:28	1692
1644	2024-12-12	0	10:21:14	2	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-11 10:11:14	2024-12-12 11:01:14	1556
1645	2024-12-12	1	09:10:30	10	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-11 08:32:30	2024-12-12 09:52:30	1065
1646	2024-12-12	1	07:25:05	6	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-11 07:12:05	2024-12-12 07:53:05	401
1647	2024-12-12	1	05:31:41	18	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-11 05:00:41	2024-12-12 05:59:41	1315
1648	2024-12-12	1	09:07:50	13	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-11 08:36:50	2024-12-12 09:45:50	528
1649	2024-12-12	1	05:29:18	11	Bàn gần cửa sổ để ngắm cảnh	2024-12-11 05:07:18	2024-12-12 06:12:18	1481
1650	2024-12-12	1	10:37:47	17	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-11 10:26:47	2024-12-12 10:52:47	1821
1651	2024-12-12	1	12:51:55	6	Dành chỗ ngồi cho nhóm 10 người	2024-12-11 12:49:55	2024-12-12 13:11:55	829
1652	2024-12-12	1	15:17:38	9	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-11 14:51:38	2024-12-12 15:48:38	1538
1653	2024-12-12	2	17:00:33	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-11 16:35:33	2024-12-12 17:42:33	1685
1654	2024-12-12	2	12:02:34	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-11 11:52:34	2024-12-12 12:46:34	1323
1655	2024-12-12	0	11:39:35	16	Bàn gần cửa sổ để ngắm cảnh	2024-12-11 10:58:35	2024-12-12 12:20:35	779
1656	2024-12-12	1	13:23:55	10	Dành chỗ ngồi cho nhóm 10 người	2024-12-11 12:45:55	2024-12-12 13:28:55	1516
1657	2024-12-12	1	14:04:00	8	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-11 13:48:00	2024-12-12 14:16:00	447
1658	2024-12-12	1	14:58:02	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-11 14:28:02	2024-12-12 15:37:02	1586
1659	2024-12-12	0	13:01:05	18	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-11 12:25:05	2024-12-12 13:30:05	1711
1660	2024-12-12	1	17:53:51	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-11 17:39:51	2024-12-12 18:18:51	436
1661	2024-12-12	2	15:07:51	11		2024-12-11 14:29:51	2024-12-12 15:28:51	654
1662	2024-12-12	1	16:38:47	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-11 16:25:47	2024-12-12 16:48:47	1722
1663	2024-12-12	2	21:32:08	17	Không dùng món ăn quá cay	2024-12-11 21:20:08	2024-12-12 22:13:08	456
1664	2024-12-12	1	18:59:43	2		2024-12-11 18:46:43	2024-12-12 19:24:43	271
1665	2024-12-12	0	21:19:51	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-11 20:54:51	2024-12-12 21:33:51	1309
1666	2024-12-12	1	18:07:06	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-11 17:47:06	2024-12-12 18:37:06	184
1667	2024-12-12	2	21:34:07	7	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-11 21:04:07	2024-12-12 22:19:07	259
1668	2024-12-12	1	21:51:44	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-11 21:39:44	2024-12-12 22:27:44	1704
1669	2024-12-12	1	19:21:31	4	Có món ăn phù hợp với người lớn tuổi	2024-12-11 19:18:31	2024-12-12 19:36:31	727
1670	2024-12-12	1	19:44:26	4	Thêm một đĩa trái cây cho trẻ em	2024-12-11 19:25:26	2024-12-12 19:58:26	1915
1671	2024-12-12	1	21:22:59	17	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-11 21:10:59	2024-12-12 21:37:59	1038
1672	2024-12-12	1	18:13:52	7	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-11 17:50:52	2024-12-12 18:51:52	1714
1673	2024-12-12	1	21:45:10	14	Cung cấp thực đơn không chứa gluten	2024-12-11 21:09:10	2024-12-12 22:07:10	1000
1674	2024-12-12	0	19:04:47	13	Không thêm muối vào các món ăn	2024-12-11 18:38:47	2024-12-12 19:27:47	1891
1675	2024-12-12	0	18:43:35	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-11 18:16:35	2024-12-12 19:16:35	886
1676	2024-12-12	0	21:34:32	9	Thêm chỗ để xe đẩy cho trẻ em	2024-12-11 21:10:32	2024-12-12 22:11:32	818
1677	2024-12-12	1	20:09:43	16	Không dùng hành hoặc tỏi trong món ăn	2024-12-11 19:29:43	2024-12-12 20:30:43	1521
1678	2024-12-12	1	20:21:28	9	Dọn sẵn đĩa và dao cắt bánh	2024-12-11 19:43:28	2024-12-12 20:23:28	834
1679	2024-12-13	2	01:13:06	5	Không thêm muối vào các món ăn	2024-12-12 01:01:06	2024-12-13 01:23:06	931
1680	2024-12-13	1	09:15:29	13	Không dùng hành hoặc tỏi trong món ăn	2024-12-12 09:09:29	2024-12-13 09:25:29	92
1681	2024-12-13	1	07:49:58	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-12 07:15:58	2024-12-13 08:03:58	951
1682	2024-12-13	1	05:41:24	10	Cung cấp thực đơn không chứa gluten	2024-12-12 05:01:24	2024-12-13 05:48:24	1606
1683	2024-12-13	1	06:11:51	8	Không dùng món ăn quá cay	2024-12-12 05:37:51	2024-12-13 06:18:51	1747
1684	2024-12-13	2	06:12:14	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-12 06:09:14	2024-12-13 06:12:14	1185
1685	2024-12-13	1	08:36:31	13	Thêm một đĩa trái cây cho trẻ em	2024-12-12 07:56:31	2024-12-13 08:57:31	1867
1686	2024-12-13	1	07:56:13	12	Bàn gần cửa sổ để ngắm cảnh	2024-12-12 07:49:13	2024-12-13 08:10:13	642
1687	2024-12-13	1	06:47:12	13	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-12 06:47:12	2024-12-13 06:47:12	1134
1688	2024-12-13	1	05:56:13	7	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-12 05:29:13	2024-12-13 06:08:13	301
1689	2024-12-13	1	09:03:34	5	Dành chỗ ngồi cho nhóm 10 người	2024-12-12 08:34:34	2024-12-13 09:04:34	1737
1690	2024-12-13	0	05:11:49	4	Có món ăn phù hợp với người lớn tuổi	2024-12-12 04:34:49	2024-12-13 05:35:49	427
1691	2024-12-13	1	15:51:01	1	Dành chỗ ngồi cho nhóm 10 người	2024-12-12 15:30:01	2024-12-13 15:54:01	1247
1692	2024-12-13	1	16:41:39	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-12 16:36:39	2024-12-13 17:17:39	992
1693	2024-12-13	1	16:07:09	10	Không thêm muối vào các món ăn	2024-12-12 15:45:09	2024-12-13 16:21:09	239
1694	2024-12-13	2	11:58:39	2	Dành chỗ ngồi cho nhóm 10 người	2024-12-12 11:34:39	2024-12-13 12:40:39	712
1695	2024-12-13	1	13:57:08	17	Thêm chỗ để xe đẩy cho trẻ em	2024-12-12 13:17:08	2024-12-13 14:32:08	721
1696	2024-12-13	0	14:03:52	18	Dọn sẵn đĩa và dao cắt bánh	2024-12-12 13:59:52	2024-12-13 14:11:52	1897
1697	2024-12-13	2	17:24:25	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-12 16:55:25	2024-12-13 17:32:25	383
1698	2024-12-13	1	17:44:33	1	Dọn sẵn đĩa và dao cắt bánh	2024-12-12 17:23:33	2024-12-13 17:51:33	136
1699	2024-12-13	2	11:21:48	9	Cung cấp thực đơn không chứa gluten	2024-12-12 10:41:48	2024-12-13 11:39:48	770
1700	2024-12-13	0	17:03:49	19	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-12 17:02:49	2024-12-13 17:15:49	1741
1701	2024-12-13	1	16:46:05	1	Dọn sẵn đĩa và dao cắt bánh	2024-12-12 16:30:05	2024-12-13 16:54:05	1286
1702	2024-12-13	1	14:01:34	5	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-12 13:44:34	2024-12-13 14:41:34	958
1703	2024-12-13	1	20:46:11	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-12 20:19:11	2024-12-13 21:10:11	119
1704	2024-12-13	1	19:20:42	19	Cung cấp thực đơn không chứa gluten	2024-12-12 18:42:42	2024-12-13 19:29:42	1490
1705	2024-12-13	1	19:00:31	12	Cung cấp thực đơn không chứa gluten	2024-12-12 18:47:31	2024-12-13 19:18:31	974
1706	2024-12-13	1	21:07:52	19	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-12 20:51:52	2024-12-13 21:46:52	1948
1707	2024-12-13	1	21:36:49	6	Có món ăn phù hợp với người lớn tuổi	2024-12-12 21:01:49	2024-12-13 22:14:49	383
1708	2024-12-13	1	20:22:37	20	Không dùng hành hoặc tỏi trong món ăn	2024-12-12 19:46:37	2024-12-13 20:50:37	60
1709	2024-12-13	1	19:02:50	9	Không dùng hành hoặc tỏi trong món ăn	2024-12-12 18:59:50	2024-12-13 19:14:50	6
1710	2024-12-13	0	20:07:17	12	Không dùng món ăn quá cay	2024-12-12 19:52:17	2024-12-13 20:45:17	498
1711	2024-12-13	2	21:12:05	3	Không thêm muối vào các món ăn	2024-12-12 20:51:05	2024-12-13 21:35:05	1319
1712	2024-12-13	1	21:42:06	5	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-12 21:38:06	2024-12-13 21:53:06	710
1713	2024-12-13	1	20:35:28	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-12 20:26:28	2024-12-13 21:16:28	846
1714	2024-12-13	1	20:21:41	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-12 19:54:41	2024-12-13 20:46:41	1343
1715	2024-12-13	2	20:49:47	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-12 20:07:47	2024-12-13 20:59:47	1008
1716	2024-12-13	1	20:00:33	3	Không dùng món ăn quá cay	2024-12-12 19:29:33	2024-12-13 20:09:33	1197
1717	2024-12-13	0	20:11:38	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-12 19:51:38	2024-12-13 20:33:38	854
1718	2024-12-13	1	20:33:05	15	Có món ăn phù hợp với người lớn tuổi	2024-12-12 19:59:05	2024-12-13 20:49:05	193
1719	2024-12-13	1	22:21:19	13	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-12 22:13:19	2024-12-13 22:47:19	1485
1720	2024-12-14	1	08:14:13	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-13 07:55:13	2024-12-14 08:16:13	1604
1721	2024-12-14	1	05:39:24	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-13 05:16:24	2024-12-14 05:49:24	837
1722	2024-12-14	1	10:11:12	7	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-13 10:11:12	2024-12-14 10:44:12	810
1723	2024-12-14	2	06:30:40	15	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-13 06:11:40	2024-12-14 06:43:40	1713
1724	2024-12-14	2	05:44:58	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-13 05:04:58	2024-12-14 05:44:58	452
1725	2024-12-14	1	07:42:54	3	Bàn gần cửa sổ để ngắm cảnh	2024-12-13 07:04:54	2024-12-14 07:46:54	1349
1726	2024-12-14	2	10:21:21	20	Thêm một đĩa trái cây cho trẻ em	2024-12-13 09:40:21	2024-12-14 10:50:21	1243
1727	2024-12-14	2	08:17:55	7	Dành chỗ ngồi cho nhóm 10 người	2024-12-13 07:43:55	2024-12-14 08:33:55	386
1728	2024-12-14	2	05:21:32	11	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-13 04:58:32	2024-12-14 05:48:32	1386
1729	2024-12-14	1	06:02:20	6	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-13 05:40:20	2024-12-14 06:43:20	1538
1730	2024-12-14	1	10:26:07	10	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-13 09:48:07	2024-12-14 11:08:07	302
1731	2024-12-14	1	14:49:51	6	Không thêm muối vào các món ăn	2024-12-13 14:19:51	2024-12-14 15:32:51	1507
1732	2024-12-14	2	12:17:53	2	Cung cấp thực đơn không chứa gluten	2024-12-13 11:38:53	2024-12-14 12:21:53	584
1733	2024-12-14	1	13:39:16	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-13 13:19:16	2024-12-14 14:05:16	1643
1734	2024-12-14	2	15:51:47	16	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-13 15:15:47	2024-12-14 16:28:47	1487
1735	2024-12-14	0	15:50:34	3		2024-12-13 15:50:34	2024-12-14 16:04:34	1680
1736	2024-12-14	1	12:09:27	9	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-13 11:36:27	2024-12-14 12:19:27	667
1737	2024-12-14	2	11:40:58	8	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-13 11:04:58	2024-12-14 11:46:58	1646
1738	2024-12-14	1	17:08:12	10	Cung cấp thực đơn không chứa gluten	2024-12-13 16:46:12	2024-12-14 17:10:12	281
1739	2024-12-14	1	12:34:20	11	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-13 12:02:20	2024-12-14 12:36:20	1559
1740	2024-12-14	2	14:04:15	20	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-13 13:40:15	2024-12-14 14:31:15	745
1741	2024-12-14	1	13:42:44	9	Thêm chỗ để xe đẩy cho trẻ em	2024-12-13 13:25:44	2024-12-14 14:13:44	1398
1742	2024-12-14	2	17:42:23	1	Không dùng hành hoặc tỏi trong món ăn	2024-12-13 17:31:23	2024-12-14 18:19:23	49
1743	2024-12-14	2	21:13:35	16	Có món ăn phù hợp với người lớn tuổi	2024-12-13 21:12:35	2024-12-14 21:28:35	796
1744	2024-12-14	1	18:08:57	20	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-13 17:29:57	2024-12-14 18:32:57	4
1745	2024-12-14	1	21:01:53	10	Thêm một đĩa trái cây cho trẻ em	2024-12-13 21:00:53	2024-12-14 21:10:53	410
1746	2024-12-14	2	18:21:52	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-13 18:06:52	2024-12-14 18:22:52	330
1747	2024-12-14	1	19:46:52	1	Thêm một đĩa trái cây cho trẻ em	2024-12-13 19:30:52	2024-12-14 20:24:52	401
1748	2024-12-14	1	18:36:41	17	Thêm một đĩa trái cây cho trẻ em	2024-12-13 18:09:41	2024-12-14 19:11:41	533
1749	2024-12-14	1	18:48:36	8	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-13 18:43:36	2024-12-14 19:08:36	999
1750	2024-12-14	1	20:48:46	11	Dọn sẵn đĩa và dao cắt bánh	2024-12-13 20:08:46	2024-12-14 21:00:46	3
1751	2024-12-14	1	19:32:09	3	Dọn sẵn đĩa và dao cắt bánh	2024-12-13 19:08:09	2024-12-14 19:33:09	757
1752	2024-12-14	1	21:22:07	1	Cung cấp thực đơn không chứa gluten	2024-12-13 20:47:07	2024-12-14 21:48:07	1212
1753	2024-12-14	2	18:33:02	2	Bàn gần cửa sổ để ngắm cảnh	2024-12-13 18:20:02	2024-12-14 19:10:02	1187
1754	2024-12-14	1	20:37:02	13	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-13 20:33:02	2024-12-14 21:13:02	763
1755	2024-12-14	0	18:42:33	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-13 18:10:33	2024-12-14 18:51:33	585
1756	2024-12-14	2	18:58:05	11	Không dùng hành hoặc tỏi trong món ăn	2024-12-13 18:58:05	2024-12-14 19:25:05	977
1757	2024-12-14	1	20:08:54	4	Không dùng món ăn quá cay	2024-12-13 19:50:54	2024-12-14 20:32:54	685
1758	2024-12-14	1	21:28:00	2	Không dùng món ăn quá cay	2024-12-13 21:09:00	2024-12-14 21:30:00	1432
1759	2024-12-15	1	01:31:05	4	Dành chỗ ngồi cho nhóm 10 người	2024-12-14 00:50:05	2024-12-15 02:06:05	1342
1760	2024-12-15	1	08:17:43	3	Không dùng hành hoặc tỏi trong món ăn	2024-12-14 07:55:43	2024-12-15 08:21:43	793
1761	2024-12-15	1	07:37:14	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-14 07:06:14	2024-12-15 07:57:14	1419
1762	2024-12-15	1	07:36:33	2	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-14 07:15:33	2024-12-15 08:03:33	1807
1763	2024-12-15	1	07:51:08	12	Không thêm muối vào các món ăn	2024-12-14 07:15:08	2024-12-15 08:02:08	1525
1764	2024-12-15	2	09:06:32	6	Không dùng hành hoặc tỏi trong món ăn	2024-12-14 08:22:32	2024-12-15 09:41:32	526
1765	2024-12-15	0	06:03:05	16	Dành chỗ ngồi cho nhóm 10 người	2024-12-14 05:59:05	2024-12-15 06:20:05	1557
1766	2024-12-15	1	08:40:27	14	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-14 08:35:27	2024-12-15 08:41:27	1440
1767	2024-12-15	1	09:35:43	7	Dọn sẵn đĩa và dao cắt bánh	2024-12-14 09:31:43	2024-12-15 09:42:43	1777
1768	2024-12-15	1	07:21:54	19	Có món ăn phù hợp với người lớn tuổi	2024-12-14 06:44:54	2024-12-15 07:58:54	1129
1769	2024-12-15	1	10:26:04	18	Bàn gần cửa sổ để ngắm cảnh	2024-12-14 10:23:04	2024-12-15 10:53:04	1120
1770	2024-12-15	1	10:10:22	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-14 09:32:22	2024-12-15 10:53:22	1024
1771	2024-12-15	1	15:15:46	11	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-14 15:15:46	2024-12-15 15:21:46	829
1772	2024-12-15	1	12:33:21	16	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-14 12:32:21	2024-12-15 12:50:21	342
1773	2024-12-15	0	17:36:01	6	Cung cấp thực đơn không chứa gluten	2024-12-14 17:33:01	2024-12-15 18:15:01	1108
1774	2024-12-15	0	17:36:26	10	Thêm một đĩa trái cây cho trẻ em	2024-12-14 17:06:26	2024-12-15 18:00:26	644
1775	2024-12-15	2	16:05:59	2	Không dùng hành hoặc tỏi trong món ăn	2024-12-14 15:39:59	2024-12-15 16:34:59	1623
1776	2024-12-15	2	16:32:18	17	Không dùng hành hoặc tỏi trong món ăn	2024-12-14 16:22:18	2024-12-15 16:37:18	934
1777	2024-12-15	1	14:33:08	9	Cung cấp thực đơn không chứa gluten	2024-12-14 13:50:08	2024-12-15 14:35:08	463
1778	2024-12-15	0	17:48:59	9	Cung cấp thực đơn không chứa gluten	2024-12-14 17:21:59	2024-12-15 18:24:59	1968
1779	2024-12-15	1	17:14:14	3	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-14 16:46:14	2024-12-15 17:58:14	1422
1780	2024-12-15	1	15:46:51	3	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-14 15:21:51	2024-12-15 15:51:51	55
1781	2024-12-15	2	14:12:28	15	Bàn gần cửa sổ để ngắm cảnh	2024-12-14 13:54:28	2024-12-15 14:28:28	56
1782	2024-12-15	0	16:51:18	18	Cung cấp thực đơn không chứa gluten	2024-12-14 16:16:18	2024-12-15 17:29:18	678
1783	2024-12-15	1	18:49:01	8	Có món ăn phù hợp với người lớn tuổi	2024-12-14 18:47:01	2024-12-15 19:27:01	588
1784	2024-12-15	1	18:06:11	6	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-14 17:43:11	2024-12-15 18:15:11	1936
1785	2024-12-15	1	18:02:31	11	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-14 18:00:31	2024-12-15 18:24:31	201
1786	2024-12-15	2	18:01:28	13	Dành chỗ ngồi cho nhóm 10 người	2024-12-14 17:46:28	2024-12-15 18:05:28	975
1787	2024-12-15	1	18:55:36	12	Chuẩn bị thực đơn thuần chay	2024-12-14 18:35:36	2024-12-15 19:33:36	561
1788	2024-12-15	1	18:57:57	14	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-14 18:14:57	2024-12-15 18:58:57	1131
1789	2024-12-15	0	20:56:31	1		2024-12-14 20:21:31	2024-12-15 21:23:31	759
1790	2024-12-15	2	21:27:49	8	Có món ăn phù hợp với người lớn tuổi	2024-12-14 21:08:49	2024-12-15 21:34:49	1784
1791	2024-12-15	0	18:17:02	2	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-14 18:00:02	2024-12-15 18:49:02	1984
1792	2024-12-15	1	20:57:28	4	Không dùng món ăn quá cay	2024-12-14 20:16:28	2024-12-15 21:37:28	1530
1793	2024-12-15	0	21:44:08	16	Cung cấp thực đơn không chứa gluten	2024-12-14 21:04:08	2024-12-15 22:06:08	533
1794	2024-12-15	1	20:28:43	16		2024-12-14 19:53:43	2024-12-15 21:04:43	1498
1795	2024-12-15	1	20:35:22	4	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-14 20:09:22	2024-12-15 20:55:22	206
1796	2024-12-15	1	21:58:39	12	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-14 21:34:39	2024-12-15 22:18:39	143
1797	2024-12-15	1	19:37:21	14	Có món ăn phù hợp với người lớn tuổi	2024-12-14 19:20:21	2024-12-15 19:44:21	1559
1798	2024-12-15	1	19:11:36	12	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-14 19:04:36	2024-12-15 19:26:36	1644
1799	2024-12-15	0	22:31:11	7	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-14 22:31:11	2024-12-15 23:15:11	1260
1800	2024-12-16	2	07:07:29	3	Chuẩn bị thực đơn thuần chay	2024-12-15 06:38:29	2024-12-16 07:31:29	1896
1801	2024-12-16	1	05:31:34	1	Có món ăn phù hợp với người lớn tuổi	2024-12-15 05:22:34	2024-12-16 06:03:34	595
1802	2024-12-16	1	08:26:51	14	Dành chỗ ngồi cho nhóm 10 người	2024-12-15 07:49:51	2024-12-16 08:53:51	1273
1803	2024-12-16	2	10:10:09	13	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-15 09:31:09	2024-12-16 10:47:09	1071
1804	2024-12-16	2	06:18:42	13	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-15 06:09:42	2024-12-16 06:41:42	1879
1805	2024-12-16	1	06:52:57	9	Không dùng món ăn quá cay	2024-12-15 06:49:57	2024-12-16 07:33:57	1133
1806	2024-12-16	1	06:34:15	9	Có món ăn phù hợp với người lớn tuổi	2024-12-15 05:50:15	2024-12-16 06:36:15	1125
1807	2024-12-16	2	10:09:48	19		2024-12-15 10:02:48	2024-12-16 10:28:48	1303
1808	2024-12-16	1	08:41:20	6	Dọn sẵn đĩa và dao cắt bánh	2024-12-15 07:59:20	2024-12-16 08:51:20	1455
1809	2024-12-16	1	07:49:13	8	Bàn gần cửa sổ để ngắm cảnh	2024-12-15 07:22:13	2024-12-16 07:54:13	1128
1810	2024-12-16	1	09:58:41	3		2024-12-15 09:53:41	2024-12-16 10:40:41	1382
1811	2024-12-16	0	13:12:21	20		2024-12-15 12:53:21	2024-12-16 13:48:21	247
1812	2024-12-16	1	14:06:54	1	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-15 13:50:54	2024-12-16 14:33:54	814
1813	2024-12-16	1	14:29:03	5	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-15 14:04:03	2024-12-16 15:09:03	492
1814	2024-12-16	2	14:47:19	15	Thêm một đĩa trái cây cho trẻ em	2024-12-15 14:36:19	2024-12-16 15:31:19	533
1815	2024-12-16	1	16:33:33	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-15 15:55:33	2024-12-16 16:58:33	1989
1816	2024-12-16	1	15:22:46	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-15 14:46:46	2024-12-16 15:39:46	1149
1817	2024-12-16	1	12:55:36	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-15 12:40:36	2024-12-16 13:21:36	297
1818	2024-12-16	1	15:38:31	20	Dành chỗ ngồi cho nhóm 10 người	2024-12-15 15:12:31	2024-12-16 15:39:31	1176
1819	2024-12-16	1	15:49:54	9		2024-12-15 15:12:54	2024-12-16 16:13:54	1588
1820	2024-12-16	2	15:23:11	9	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-15 15:23:11	2024-12-16 15:57:11	31
1821	2024-12-16	1	11:42:32	10	Cung cấp thực đơn không chứa gluten	2024-12-15 11:23:32	2024-12-16 12:17:32	178
1822	2024-12-16	1	17:47:00	7	Dành chỗ ngồi cho nhóm 10 người	2024-12-15 17:28:00	2024-12-16 17:56:00	1715
1823	2024-12-16	2	20:02:14	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-15 19:57:14	2024-12-16 20:44:14	56
1824	2024-12-16	1	21:35:00	12	Chuẩn bị thực đơn thuần chay	2024-12-15 21:16:00	2024-12-16 22:14:00	200
1825	2024-12-16	1	19:41:54	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-15 19:41:54	2024-12-16 20:18:54	1607
1826	2024-12-16	0	20:36:42	7	Không dùng hành hoặc tỏi trong món ăn	2024-12-15 20:29:42	2024-12-16 21:01:42	1986
1827	2024-12-16	0	19:16:44	7	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-15 18:32:44	2024-12-16 19:33:44	510
1828	2024-12-16	2	21:37:10	6	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-15 21:06:10	2024-12-16 21:43:10	861
1829	2024-12-16	1	21:11:02	3	Có món ăn phù hợp với người lớn tuổi	2024-12-15 20:55:02	2024-12-16 21:53:02	783
1830	2024-12-16	1	20:56:30	8	Không dùng hành hoặc tỏi trong món ăn	2024-12-15 20:16:30	2024-12-16 21:21:30	550
1831	2024-12-16	1	20:48:08	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-15 20:33:08	2024-12-16 21:11:08	1578
1832	2024-12-16	0	21:51:25	8	Không dùng hành hoặc tỏi trong món ăn	2024-12-15 21:37:25	2024-12-16 22:32:25	1470
1833	2024-12-16	1	21:40:14	13		2024-12-15 21:05:14	2024-12-16 21:51:14	241
1834	2024-12-16	2	18:47:12	3		2024-12-15 18:28:12	2024-12-16 18:59:12	1888
1835	2024-12-16	1	20:13:18	14	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-15 19:39:18	2024-12-16 20:20:18	1887
1836	2024-12-16	1	21:23:33	14	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-15 21:17:33	2024-12-16 21:41:33	1711
1837	2024-12-16	1	19:57:41	3	Thêm một đĩa trái cây cho trẻ em	2024-12-15 19:39:41	2024-12-16 20:28:41	1403
1838	2024-12-16	1	20:19:10	1	Chuẩn bị thực đơn thuần chay	2024-12-15 19:50:10	2024-12-16 21:03:10	161
1839	2024-12-16	2	22:48:11	3	Thêm một đĩa trái cây cho trẻ em	2024-12-15 22:26:11	2024-12-16 23:09:11	906
1840	2024-12-17	1	08:50:46	5	Thêm một đĩa trái cây cho trẻ em	2024-12-16 08:11:46	2024-12-17 09:05:46	229
1841	2024-12-17	1	09:24:09	16	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-16 09:09:09	2024-12-17 09:57:09	755
1842	2024-12-17	1	06:19:44	5	Không thêm muối vào các món ăn	2024-12-16 06:04:44	2024-12-17 06:46:44	988
1843	2024-12-17	1	07:22:49	6		2024-12-16 06:55:49	2024-12-17 07:47:49	308
1844	2024-12-17	2	07:38:54	10	Cung cấp thực đơn không chứa gluten	2024-12-16 07:04:54	2024-12-17 07:53:54	1347
1845	2024-12-17	2	07:32:21	16	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-16 07:24:21	2024-12-17 08:08:21	1586
1846	2024-12-17	2	06:53:49	5	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-16 06:28:49	2024-12-17 07:10:49	671
1847	2024-12-17	2	07:23:39	1	Không thêm muối vào các món ăn	2024-12-16 07:09:39	2024-12-17 08:07:39	646
1848	2024-12-17	0	09:58:03	9	Thêm chỗ để xe đẩy cho trẻ em	2024-12-16 09:24:03	2024-12-17 10:14:03	1099
1849	2024-12-17	2	09:35:47	18	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-16 09:33:47	2024-12-17 09:51:47	1831
1850	2024-12-17	2	10:39:33	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-16 10:23:33	2024-12-17 10:45:33	1709
1851	2024-12-17	1	11:25:43	13	Không dùng món ăn quá cay	2024-12-16 10:59:43	2024-12-17 12:02:43	825
1852	2024-12-17	1	16:24:45	19	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-16 15:47:45	2024-12-17 16:28:45	1189
1853	2024-12-17	1	16:18:24	11	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-16 16:01:24	2024-12-17 17:00:24	1236
1854	2024-12-17	1	17:17:47	3	Không dùng món ăn quá cay	2024-12-16 16:39:47	2024-12-17 17:33:47	1118
1855	2024-12-17	2	12:58:42	1	Có món ăn phù hợp với người lớn tuổi	2024-12-16 12:42:42	2024-12-17 13:01:42	258
1856	2024-12-17	1	15:54:30	1	Dọn sẵn đĩa và dao cắt bánh	2024-12-16 15:11:30	2024-12-17 16:28:30	1350
1857	2024-12-17	1	11:58:00	2	Thêm một đĩa trái cây cho trẻ em	2024-12-16 11:53:00	2024-12-17 12:43:00	877
1858	2024-12-17	1	17:03:07	16	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-16 16:35:07	2024-12-17 17:16:07	149
1859	2024-12-17	1	13:46:03	11	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-16 13:20:03	2024-12-17 14:30:03	291
1860	2024-12-17	1	16:27:11	5	Không thêm muối vào các món ăn	2024-12-16 16:27:11	2024-12-17 17:01:11	316
1861	2024-12-17	0	16:27:06	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-16 15:47:06	2024-12-17 16:32:06	1544
1862	2024-12-17	2	16:16:42	4	Bàn gần cửa sổ để ngắm cảnh	2024-12-16 15:35:42	2024-12-17 16:48:42	888
1863	2024-12-17	1	19:09:26	8	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-16 18:28:26	2024-12-17 19:42:26	1851
1864	2024-12-17	0	18:41:39	14	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-16 18:23:39	2024-12-17 19:00:39	1951
1865	2024-12-17	1	18:14:34	3	Chuẩn bị thực đơn thuần chay	2024-12-16 18:11:34	2024-12-17 18:49:34	712
1866	2024-12-17	1	21:12:16	17	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-16 20:59:16	2024-12-17 21:31:16	862
1867	2024-12-17	1	21:54:17	1	Thêm một đĩa trái cây cho trẻ em	2024-12-16 21:40:17	2024-12-17 22:13:17	178
1868	2024-12-17	0	18:23:42	6	Không dùng hành hoặc tỏi trong món ăn	2024-12-16 17:40:42	2024-12-17 18:50:42	835
1869	2024-12-17	1	20:29:07	2	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-16 20:03:07	2024-12-17 20:48:07	700
1870	2024-12-17	1	19:41:37	7	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-16 19:27:37	2024-12-17 20:00:37	1600
1871	2024-12-17	1	19:57:56	9	Có món ăn phù hợp với người lớn tuổi	2024-12-16 19:36:56	2024-12-17 20:37:56	1870
1872	2024-12-17	1	20:22:49	1	Cung cấp thực đơn không chứa gluten	2024-12-16 20:21:49	2024-12-17 20:36:49	1180
1873	2024-12-17	0	20:31:47	7	Dành chỗ ngồi cho nhóm 10 người	2024-12-16 20:00:47	2024-12-17 20:55:47	741
1874	2024-12-17	1	18:27:09	7	Thêm một đĩa trái cây cho trẻ em	2024-12-16 18:15:09	2024-12-17 19:11:09	1111
1875	2024-12-17	1	20:25:09	4	Thêm một đĩa trái cây cho trẻ em	2024-12-16 20:12:09	2024-12-17 20:57:09	773
1876	2024-12-17	1	18:55:56	3	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-16 18:45:56	2024-12-17 19:40:56	1785
1877	2024-12-17	1	20:32:16	10	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-16 19:55:16	2024-12-17 20:42:16	1150
1878	2024-12-17	1	20:56:20	5	Không dùng hành hoặc tỏi trong món ăn	2024-12-16 20:44:20	2024-12-17 21:21:20	1598
1879	2024-12-18	2	01:34:34	17	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-17 00:55:34	2024-12-18 01:38:34	1907
1880	2024-12-18	2	10:41:55	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-17 10:17:55	2024-12-18 11:12:55	1783
1881	2024-12-18	1	10:21:34	19	Không dùng món ăn quá cay	2024-12-17 09:37:34	2024-12-18 10:37:34	810
1882	2024-12-18	1	10:23:37	1	Dành chỗ ngồi cho nhóm 10 người	2024-12-17 09:43:37	2024-12-18 10:35:37	538
1883	2024-12-18	1	08:59:06	3	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-17 08:46:06	2024-12-18 09:40:06	1312
1884	2024-12-18	2	07:50:36	8	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-17 07:22:36	2024-12-18 07:59:36	1438
1885	2024-12-18	1	06:42:36	6	Không thêm muối vào các món ăn	2024-12-17 06:34:36	2024-12-18 07:21:36	1868
1886	2024-12-18	1	05:47:33	8	Không dùng món ăn quá cay	2024-12-17 05:25:33	2024-12-18 06:00:33	793
1887	2024-12-18	2	09:34:17	4	Dọn sẵn đĩa và dao cắt bánh	2024-12-17 09:22:17	2024-12-18 10:01:17	1125
1888	2024-12-18	1	08:35:00	8	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-17 08:08:00	2024-12-18 08:41:00	455
1889	2024-12-18	0	05:08:24	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-17 04:31:24	2024-12-18 05:41:24	1307
1890	2024-12-18	1	06:36:27	11	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-17 06:05:27	2024-12-18 06:47:27	462
1891	2024-12-18	0	11:29:11	3	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-17 10:51:11	2024-12-18 11:35:11	1912
1892	2024-12-18	1	17:06:54	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-17 17:00:54	2024-12-18 17:12:54	549
1893	2024-12-18	1	13:00:41	9	Có món ăn phù hợp với người lớn tuổi	2024-12-17 12:56:41	2024-12-18 13:44:41	1519
1894	2024-12-18	1	16:33:07	14	Không thêm muối vào các món ăn	2024-12-17 16:05:07	2024-12-18 16:34:07	590
1895	2024-12-18	1	17:00:41	9	Cung cấp thực đơn không chứa gluten	2024-12-17 16:25:41	2024-12-18 17:18:41	1967
1896	2024-12-18	0	14:24:23	2	Không dùng món ăn quá cay	2024-12-17 13:54:23	2024-12-18 14:43:23	1823
1897	2024-12-18	1	17:42:03	11	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-17 17:37:03	2024-12-18 18:05:03	1569
1898	2024-12-18	2	12:52:00	7	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-17 12:46:00	2024-12-18 13:22:00	587
1899	2024-12-18	1	14:26:11	4	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-17 14:25:11	2024-12-18 14:42:11	149
1900	2024-12-18	0	12:11:22	2	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-17 12:00:22	2024-12-18 12:36:22	1856
1901	2024-12-18	2	17:10:05	14	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-17 16:58:05	2024-12-18 17:30:05	298
1902	2024-12-18	2	15:08:56	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-17 15:02:56	2024-12-18 15:50:56	742
1903	2024-12-18	1	18:06:32	1	Không dùng hành hoặc tỏi trong món ăn	2024-12-17 17:33:32	2024-12-18 18:28:32	1683
1904	2024-12-18	2	21:53:47	17	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-17 21:27:47	2024-12-18 22:20:47	1437
1905	2024-12-18	1	18:14:28	3	Dọn sẵn đĩa và dao cắt bánh	2024-12-17 17:31:28	2024-12-18 18:59:28	522
1906	2024-12-18	1	19:56:25	13	Không thêm muối vào các món ăn	2024-12-17 19:50:25	2024-12-18 19:57:25	2
1907	2024-12-18	1	19:46:23	15		2024-12-17 19:29:23	2024-12-18 20:08:23	1021
1908	2024-12-18	1	20:12:31	19	Bàn gần cửa sổ để ngắm cảnh	2024-12-17 19:35:31	2024-12-18 20:38:31	1282
1909	2024-12-18	1	19:24:33	1	Thêm một đĩa trái cây cho trẻ em	2024-12-17 19:03:33	2024-12-18 20:09:33	1408
1910	2024-12-18	1	21:33:13	5	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-17 20:57:13	2024-12-18 22:18:13	1698
1911	2024-12-18	0	18:15:02	16	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-17 18:03:02	2024-12-18 18:53:02	209
1912	2024-12-18	1	18:13:44	1	Bàn gần cửa sổ để ngắm cảnh	2024-12-17 18:04:44	2024-12-18 18:50:44	272
1913	2024-12-18	2	21:06:30	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-17 21:06:30	2024-12-18 21:45:30	523
1914	2024-12-18	1	20:29:42	3	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-17 19:46:42	2024-12-18 21:02:42	1753
1915	2024-12-18	0	18:26:27	20	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-17 17:50:27	2024-12-18 19:10:27	656
1916	2024-12-18	1	21:32:14	4	Không thêm muối vào các món ăn	2024-12-17 21:12:14	2024-12-18 22:15:14	1377
1917	2024-12-18	1	21:31:21	14	Bàn gần cửa sổ để ngắm cảnh	2024-12-17 21:03:21	2024-12-18 21:34:21	974
1918	2024-12-18	1	18:35:46	10	Không thêm muối vào các món ăn	2024-12-17 18:18:46	2024-12-18 19:02:46	183
1919	2024-12-19	1	01:50:16	10	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-18 01:50:16	2024-12-19 01:50:16	1503
1920	2024-12-19	1	09:15:48	10	Thêm chỗ để xe đẩy cho trẻ em	2024-12-18 08:58:48	2024-12-19 09:54:48	105
1921	2024-12-19	1	05:56:57	13	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-18 05:21:57	2024-12-19 06:37:57	1646
1922	2024-12-19	1	10:54:17	14	Không dùng hành hoặc tỏi trong món ăn	2024-12-18 10:10:17	2024-12-19 11:29:17	944
1923	2024-12-19	1	06:28:22	12	Thêm chỗ để xe đẩy cho trẻ em	2024-12-18 06:00:22	2024-12-19 07:07:22	1013
1924	2024-12-19	1	06:44:58	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-18 06:25:58	2024-12-19 07:06:58	1919
1925	2024-12-19	1	08:12:23	7	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-18 08:08:23	2024-12-19 08:32:23	971
1926	2024-12-19	2	06:17:31	17	Không dùng món ăn quá cay	2024-12-18 05:47:31	2024-12-19 06:32:31	103
1927	2024-12-19	2	05:40:27	8	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-18 05:40:27	2024-12-19 06:07:27	52
1928	2024-12-19	1	05:25:03	16	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-18 05:17:03	2024-12-19 05:28:03	244
1929	2024-12-19	0	09:36:54	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-18 09:35:54	2024-12-19 10:02:54	52
1930	2024-12-19	0	09:44:21	9	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-18 09:37:21	2024-12-19 10:09:21	186
1931	2024-12-19	2	17:23:29	10	Thêm chỗ để xe đẩy cho trẻ em	2024-12-18 17:20:29	2024-12-19 17:38:29	1118
1932	2024-12-19	2	11:46:13	18	Không dùng hành hoặc tỏi trong món ăn	2024-12-18 11:45:13	2024-12-19 12:24:13	312
1933	2024-12-19	2	11:48:35	1	Dọn sẵn đĩa và dao cắt bánh	2024-12-18 11:40:35	2024-12-19 12:11:35	352
1934	2024-12-19	1	13:40:42	15	Chuẩn bị thực đơn thuần chay	2024-12-18 13:01:42	2024-12-19 13:47:42	20
1935	2024-12-19	1	11:20:46	15	Thêm một đĩa trái cây cho trẻ em	2024-12-18 10:36:46	2024-12-19 11:55:46	1184
1936	2024-12-19	1	14:07:51	9	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-18 13:44:51	2024-12-19 14:34:51	1650
1937	2024-12-19	2	16:02:38	18	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-18 15:31:38	2024-12-19 16:07:38	709
1938	2024-12-19	2	14:49:09	15	Thêm chỗ để xe đẩy cho trẻ em	2024-12-18 14:47:09	2024-12-19 14:59:09	1229
1939	2024-12-19	1	16:05:10	13	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-18 15:29:10	2024-12-19 16:32:10	1110
1940	2024-12-19	1	17:21:26	3	Thêm chỗ để xe đẩy cho trẻ em	2024-12-18 16:58:26	2024-12-19 17:35:26	743
1941	2024-12-19	2	11:49:33	14	Không thêm muối vào các món ăn	2024-12-18 11:44:33	2024-12-19 12:24:33	398
1942	2024-12-19	2	13:54:50	8	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-18 13:17:50	2024-12-19 13:56:50	182
1943	2024-12-19	2	19:52:26	2	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-18 19:38:26	2024-12-19 20:36:26	1406
1944	2024-12-19	1	21:39:52	5	Dành chỗ ngồi cho nhóm 10 người	2024-12-18 21:38:52	2024-12-19 22:06:52	1374
1945	2024-12-19	1	20:42:33	1	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-18 20:30:33	2024-12-19 21:23:33	132
1946	2024-12-19	1	19:49:32	2	Thêm một đĩa trái cây cho trẻ em	2024-12-18 19:07:32	2024-12-19 20:20:32	327
1947	2024-12-19	1	20:36:14	11	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-18 20:33:14	2024-12-19 21:17:14	602
1948	2024-12-19	1	18:43:00	19	Bàn gần cửa sổ để ngắm cảnh	2024-12-18 18:17:00	2024-12-19 19:16:00	1795
1949	2024-12-19	1	20:43:10	11		2024-12-18 19:59:10	2024-12-19 21:07:10	958
1950	2024-12-19	1	21:49:50	19	Dọn sẵn đĩa và dao cắt bánh	2024-12-18 21:26:50	2024-12-19 21:53:50	1049
1951	2024-12-19	1	20:52:58	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-18 20:35:58	2024-12-19 21:28:58	801
1952	2024-12-19	2	18:10:52	12	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-18 17:48:52	2024-12-19 18:20:52	939
1953	2024-12-19	1	21:53:04	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-18 21:46:04	2024-12-19 21:55:04	1901
1954	2024-12-19	0	21:27:35	1	Thêm chỗ để xe đẩy cho trẻ em	2024-12-18 20:54:35	2024-12-19 21:32:35	1778
1955	2024-12-19	1	18:47:20	12		2024-12-18 18:23:20	2024-12-19 19:28:20	421
1956	2024-12-19	1	20:07:07	9	Không dùng món ăn quá cay	2024-12-18 19:55:07	2024-12-19 20:41:07	1869
1957	2024-12-19	1	18:47:49	3	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-18 18:12:49	2024-12-19 19:26:49	1927
1958	2024-12-19	1	18:14:20	14		2024-12-18 17:48:20	2024-12-19 18:43:20	145
1959	2024-12-20	1	01:54:40	4	Cung cấp thực đơn không chứa gluten	2024-12-19 01:51:40	2024-12-20 01:59:40	1531
1960	2024-12-20	1	10:26:35	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-19 10:05:35	2024-12-20 11:10:35	691
1961	2024-12-20	1	05:54:33	4	Dành chỗ ngồi cho nhóm 10 người	2024-12-19 05:52:33	2024-12-20 06:10:33	379
1962	2024-12-20	1	06:43:11	1	Không dùng món ăn quá cay	2024-12-19 06:16:11	2024-12-20 06:43:11	1408
1963	2024-12-20	1	07:00:29	17	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-19 06:54:29	2024-12-20 07:05:29	1652
1964	2024-12-20	1	06:54:36	3	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-19 06:29:36	2024-12-20 07:06:36	402
1965	2024-12-20	1	07:14:10	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-19 07:08:10	2024-12-20 07:19:10	1555
1966	2024-12-20	2	05:23:26	8	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-19 05:12:26	2024-12-20 06:03:26	247
1967	2024-12-20	1	07:04:58	1	Dành chỗ ngồi cho nhóm 10 người	2024-12-19 06:48:58	2024-12-20 07:07:58	587
1968	2024-12-20	1	07:40:20	2	Có món ăn phù hợp với người lớn tuổi	2024-12-19 07:03:20	2024-12-20 07:58:20	1046
1969	2024-12-20	1	08:27:19	11	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-19 07:56:19	2024-12-20 08:54:19	964
1970	2024-12-20	2	06:37:36	19	Dọn sẵn đĩa và dao cắt bánh	2024-12-19 06:28:36	2024-12-20 06:47:36	953
1971	2024-12-20	1	13:20:51	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-19 12:49:51	2024-12-20 13:38:51	769
1972	2024-12-20	0	11:05:36	19	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-19 10:38:36	2024-12-20 11:22:36	1542
1973	2024-12-20	0	14:19:40	4	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-19 13:44:40	2024-12-20 14:25:40	880
1974	2024-12-20	1	12:59:58	8	Không dùng món ăn quá cay	2024-12-19 12:42:58	2024-12-20 13:21:58	13
1975	2024-12-20	1	14:34:20	3	Dành chỗ ngồi cho nhóm 10 người	2024-12-19 14:02:20	2024-12-20 14:45:20	1619
1976	2024-12-20	1	13:55:24	4		2024-12-19 13:51:24	2024-12-20 14:07:24	1731
1977	2024-12-20	2	12:58:45	5	Dành chỗ ngồi cho nhóm 10 người	2024-12-19 12:54:45	2024-12-20 13:27:45	1594
1978	2024-12-20	1	16:23:17	4	Không dùng hành hoặc tỏi trong món ăn	2024-12-19 16:09:17	2024-12-20 16:48:17	1737
1979	2024-12-20	1	11:01:34	1	Có món ăn phù hợp với người lớn tuổi	2024-12-19 10:44:34	2024-12-20 11:21:34	613
1980	2024-12-20	1	16:32:26	2	Có món ăn phù hợp với người lớn tuổi	2024-12-19 15:56:26	2024-12-20 17:17:26	691
1981	2024-12-20	0	11:45:45	1	Cung cấp thực đơn không chứa gluten	2024-12-19 11:31:45	2024-12-20 12:23:45	1413
1982	2024-12-20	0	13:19:48	1	Dành chỗ ngồi cho nhóm 10 người	2024-12-19 12:58:48	2024-12-20 13:23:48	417
1983	2024-12-20	1	20:33:26	4	Bàn gần cửa sổ để ngắm cảnh	2024-12-19 20:19:26	2024-12-20 20:55:26	1225
1984	2024-12-20	1	20:24:31	2	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-19 20:04:31	2024-12-20 20:36:31	238
1985	2024-12-20	1	19:19:26	3	Dành chỗ ngồi cho nhóm 10 người	2024-12-19 18:37:26	2024-12-20 20:00:26	1088
1986	2024-12-20	2	19:53:13	1	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-19 19:38:13	2024-12-20 20:04:13	275
1987	2024-12-20	1	20:02:54	1		2024-12-19 19:45:54	2024-12-20 20:15:54	1250
1988	2024-12-20	1	21:08:32	3	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-19 20:35:32	2024-12-20 21:10:32	645
1989	2024-12-20	1	19:13:32	14	Không dùng món ăn quá cay	2024-12-19 18:31:32	2024-12-20 19:34:32	455
1990	2024-12-20	0	20:05:04	9	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-19 19:51:04	2024-12-20 20:18:04	1504
1991	2024-12-20	1	18:55:27	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-19 18:28:27	2024-12-20 18:55:27	1676
1992	2024-12-20	1	18:59:50	4	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-19 18:27:50	2024-12-20 19:40:50	219
1993	2024-12-20	2	21:35:22	9		2024-12-19 20:52:22	2024-12-20 22:05:22	361
1994	2024-12-20	1	19:41:38	8	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-19 19:17:38	2024-12-20 20:26:38	1011
1995	2024-12-20	0	18:00:17	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-19 17:29:17	2024-12-20 18:03:17	688
1996	2024-12-20	2	19:23:37	4	Có món ăn phù hợp với người lớn tuổi	2024-12-19 19:11:37	2024-12-20 19:38:37	371
1997	2024-12-20	0	20:39:34	5	Có món ăn phù hợp với người lớn tuổi	2024-12-19 20:15:34	2024-12-20 20:48:34	1651
1998	2024-12-20	0	19:09:16	14	Có món ăn phù hợp với người lớn tuổi	2024-12-19 18:30:16	2024-12-20 19:43:16	1780
1999	2024-12-20	1	23:31:17	10	Thêm một đĩa trái cây cho trẻ em	2024-12-19 23:02:17	2024-12-20 23:43:17	742
2000	2024-12-21	1	07:07:47	6	Cung cấp thực đơn không chứa gluten	2024-12-20 06:33:47	2024-12-21 07:28:47	1792
2001	2024-12-21	1	09:31:10	18	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-20 08:55:10	2024-12-21 09:56:10	1889
2002	2024-12-21	1	07:01:52	19	Thêm một đĩa trái cây cho trẻ em	2024-12-20 07:01:52	2024-12-21 07:44:52	389
2003	2024-12-21	1	05:23:12	1	Không thêm muối vào các món ăn	2024-12-20 05:18:12	2024-12-21 05:47:12	1025
2004	2024-12-21	1	10:29:12	3	Thêm chỗ để xe đẩy cho trẻ em	2024-12-20 10:11:12	2024-12-21 11:06:12	1841
2005	2024-12-21	1	06:53:07	3	Không dùng món ăn quá cay	2024-12-20 06:14:07	2024-12-21 07:06:07	150
2006	2024-12-21	1	06:03:43	3	Bàn gần cửa sổ để ngắm cảnh	2024-12-20 06:02:43	2024-12-21 06:19:43	28
2007	2024-12-21	1	06:32:12	11	Không thêm muối vào các món ăn	2024-12-20 06:13:12	2024-12-21 06:51:12	340
2008	2024-12-21	2	09:44:37	1	Dành chỗ ngồi cho nhóm 10 người	2024-12-20 09:35:37	2024-12-21 09:46:37	309
2009	2024-12-21	0	08:50:30	2	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-20 08:30:30	2024-12-21 08:55:30	1240
2010	2024-12-21	1	06:04:00	3	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-20 05:41:00	2024-12-21 06:37:00	1386
2011	2024-12-21	1	16:35:13	3	Không thêm muối vào các món ăn	2024-12-20 16:05:13	2024-12-21 16:45:13	60
2012	2024-12-21	1	17:47:36	2	Có món ăn phù hợp với người lớn tuổi	2024-12-20 17:22:36	2024-12-21 17:48:36	343
2013	2024-12-21	0	15:35:53	6	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-20 15:02:53	2024-12-21 15:57:53	1601
2014	2024-12-21	1	11:25:03	14	Bàn gần cửa sổ để ngắm cảnh	2024-12-20 11:20:03	2024-12-21 11:44:03	1912
2015	2024-12-21	0	16:15:18	17	Chuẩn bị thực đơn thuần chay	2024-12-20 15:53:18	2024-12-21 16:29:18	1027
2016	2024-12-21	1	12:42:00	1	Có món ăn phù hợp với người lớn tuổi	2024-12-20 12:29:00	2024-12-21 13:07:00	987
2017	2024-12-21	1	13:41:51	18	Không dùng món ăn quá cay	2024-12-20 13:28:51	2024-12-21 14:08:51	1383
2018	2024-12-21	1	17:50:25	6	Bàn gần cửa sổ để ngắm cảnh	2024-12-20 17:50:25	2024-12-21 18:12:25	1440
2019	2024-12-21	1	12:52:06	18	Dành chỗ ngồi cho nhóm 10 người	2024-12-20 12:24:06	2024-12-21 12:52:06	1890
2020	2024-12-21	1	12:27:18	14	Không dùng hành hoặc tỏi trong món ăn	2024-12-20 12:13:18	2024-12-21 12:27:18	1878
2021	2024-12-21	1	11:05:19	2	Bàn gần cửa sổ để ngắm cảnh	2024-12-20 10:43:19	2024-12-21 11:43:19	795
2022	2024-12-21	1	17:45:50	3	Bàn gần cửa sổ để ngắm cảnh	2024-12-20 17:41:50	2024-12-21 18:16:50	490
2023	2024-12-21	1	21:08:11	6	Không dùng món ăn quá cay	2024-12-20 20:42:11	2024-12-21 21:10:11	1617
2024	2024-12-21	1	18:59:58	4	Thêm một đĩa trái cây cho trẻ em	2024-12-20 18:16:58	2024-12-21 19:27:58	331
2025	2024-12-21	2	20:05:43	19		2024-12-20 19:31:43	2024-12-21 20:30:43	529
2026	2024-12-21	2	19:46:51	9	Thêm một đĩa trái cây cho trẻ em	2024-12-20 19:16:51	2024-12-21 19:56:51	349
2027	2024-12-21	1	19:10:46	1	Không dùng món ăn quá cay	2024-12-20 18:48:46	2024-12-21 19:36:46	496
2028	2024-12-21	1	19:20:44	7	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-20 19:06:44	2024-12-21 20:05:44	577
2029	2024-12-21	1	18:16:53	3	Có món ăn phù hợp với người lớn tuổi	2024-12-20 18:08:53	2024-12-21 18:43:53	1014
2030	2024-12-21	1	21:49:20	5	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-20 21:36:20	2024-12-21 22:25:20	600
2031	2024-12-21	1	19:06:51	3	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-20 19:00:51	2024-12-21 19:47:51	1570
2032	2024-12-21	1	19:00:29	7	Không dùng món ăn quá cay	2024-12-20 18:33:29	2024-12-21 19:01:29	225
2033	2024-12-21	0	21:36:02	15	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-20 20:52:02	2024-12-21 22:04:02	1075
2034	2024-12-21	1	20:41:21	7	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-20 20:28:21	2024-12-21 20:58:21	634
2035	2024-12-21	1	18:59:19	12	Dọn sẵn đĩa và dao cắt bánh	2024-12-20 18:44:19	2024-12-21 19:40:19	932
2036	2024-12-21	0	18:23:28	9	Không thêm muối vào các món ăn	2024-12-20 17:46:28	2024-12-21 18:38:28	1166
2037	2024-12-21	1	21:04:34	11	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-20 20:21:34	2024-12-21 21:45:34	43
2038	2024-12-21	1	19:49:36	3	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-20 19:40:36	2024-12-21 20:00:36	311
2039	2024-12-22	1	01:49:19	18	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-21 01:22:19	2024-12-22 02:29:19	93
2040	2024-12-22	2	10:48:11	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-21 10:35:11	2024-12-22 11:12:11	1508
2041	2024-12-22	1	08:24:39	8	Cung cấp thực đơn không chứa gluten	2024-12-21 07:43:39	2024-12-22 08:47:39	1853
2042	2024-12-22	1	10:15:21	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-21 09:40:21	2024-12-22 10:28:21	468
2043	2024-12-22	1	10:53:54	3	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-21 10:37:54	2024-12-22 11:28:54	1336
2044	2024-12-22	1	05:24:25	2	Thêm một đĩa trái cây cho trẻ em	2024-12-21 05:16:25	2024-12-22 05:29:25	1810
2045	2024-12-22	1	09:55:07	9	Cung cấp thực đơn không chứa gluten	2024-12-21 09:30:07	2024-12-22 10:24:07	1199
2046	2024-12-22	2	05:20:52	2		2024-12-21 04:54:52	2024-12-22 05:39:52	1418
2047	2024-12-22	1	06:12:18	8	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-21 06:03:18	2024-12-22 06:22:18	635
2048	2024-12-22	1	07:44:59	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-21 07:41:59	2024-12-22 07:54:59	2
2049	2024-12-22	2	05:48:26	1	Không dùng hành hoặc tỏi trong món ăn	2024-12-21 05:44:26	2024-12-22 06:11:26	1998
2050	2024-12-22	1	07:14:33	1		2024-12-21 07:05:33	2024-12-22 07:48:33	1192
2051	2024-12-22	1	12:34:30	18	Có món ăn phù hợp với người lớn tuổi	2024-12-21 12:07:30	2024-12-22 12:45:30	1770
2052	2024-12-22	2	15:13:01	3	Không dùng hành hoặc tỏi trong món ăn	2024-12-21 15:03:01	2024-12-22 15:51:01	642
2053	2024-12-22	1	13:14:47	4	Không dùng hành hoặc tỏi trong món ăn	2024-12-21 13:11:47	2024-12-22 13:50:47	670
2054	2024-12-22	0	12:37:19	19	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-21 11:58:19	2024-12-22 13:01:19	1035
2055	2024-12-22	2	14:21:29	1	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-21 14:07:29	2024-12-22 14:51:29	1321
2056	2024-12-22	2	13:37:17	3	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-21 13:08:17	2024-12-22 13:43:17	562
2057	2024-12-22	1	14:11:57	1	Dọn sẵn đĩa và dao cắt bánh	2024-12-21 14:02:57	2024-12-22 14:53:57	18
2058	2024-12-22	1	11:55:06	12	Dọn sẵn đĩa và dao cắt bánh	2024-12-21 11:40:06	2024-12-22 12:30:06	1976
2059	2024-12-22	1	16:48:46	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-21 16:34:46	2024-12-22 17:17:46	236
2060	2024-12-22	2	11:31:11	6	Cung cấp thực đơn không chứa gluten	2024-12-21 10:59:11	2024-12-22 11:32:11	1045
2061	2024-12-22	2	16:16:53	2	Dành chỗ ngồi cho nhóm 10 người	2024-12-21 15:47:53	2024-12-22 16:45:53	717
2062	2024-12-22	1	11:16:21	1		2024-12-21 11:10:21	2024-12-22 11:19:21	882
2063	2024-12-22	2	18:34:11	17	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-21 18:02:11	2024-12-22 18:46:11	61
2064	2024-12-22	1	21:11:28	2		2024-12-21 21:00:28	2024-12-22 21:29:28	299
2065	2024-12-22	1	18:55:32	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-21 18:16:32	2024-12-22 19:37:32	244
2066	2024-12-22	1	19:14:17	18	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-21 18:37:17	2024-12-22 19:36:17	1259
2067	2024-12-22	0	18:10:26	15	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-21 17:55:26	2024-12-22 18:27:26	1290
2068	2024-12-22	1	18:58:33	2	Bàn gần cửa sổ để ngắm cảnh	2024-12-21 18:28:33	2024-12-22 19:07:33	1817
2069	2024-12-22	1	21:25:25	18	Thêm chỗ để xe đẩy cho trẻ em	2024-12-21 20:59:25	2024-12-22 21:59:25	885
2070	2024-12-22	1	18:12:17	6	Không dùng hành hoặc tỏi trong món ăn	2024-12-21 17:54:17	2024-12-22 18:43:17	727
2071	2024-12-22	1	18:55:54	9	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-21 18:20:54	2024-12-22 18:58:54	1438
2072	2024-12-22	0	20:46:20	1	Thêm một đĩa trái cây cho trẻ em	2024-12-21 20:21:20	2024-12-22 20:54:20	413
2073	2024-12-22	1	19:23:58	15	Có món ăn phù hợp với người lớn tuổi	2024-12-21 18:39:58	2024-12-22 19:59:58	383
2074	2024-12-22	1	19:11:14	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-21 19:03:14	2024-12-22 19:16:14	42
2075	2024-12-22	0	18:30:09	5	Thêm một đĩa trái cây cho trẻ em	2024-12-21 18:04:09	2024-12-22 19:06:09	1883
2076	2024-12-22	1	21:22:08	11	Dành chỗ ngồi cho nhóm 10 người	2024-12-21 21:13:08	2024-12-22 21:25:08	1028
2077	2024-12-22	1	18:10:02	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-21 17:37:02	2024-12-22 18:43:02	1872
2078	2024-12-22	1	18:58:50	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-21 18:19:50	2024-12-22 19:21:50	1473
2079	2024-12-22	0	22:40:11	3	Không thêm muối vào các món ăn	2024-12-21 22:18:11	2024-12-22 22:57:11	797
2080	2024-12-23	1	07:29:05	12	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-22 07:03:05	2024-12-23 07:48:05	1459
2081	2024-12-23	1	05:41:05	9	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-22 05:13:05	2024-12-23 06:15:05	630
2082	2024-12-23	1	07:05:31	2	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-22 06:59:31	2024-12-23 07:26:31	852
2083	2024-12-23	1	09:49:48	9	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-22 09:31:48	2024-12-23 10:32:48	1083
2084	2024-12-23	1	06:11:02	11	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-22 05:43:02	2024-12-23 06:44:02	1769
2085	2024-12-23	2	09:05:49	2	Dành chỗ ngồi cho nhóm 10 người	2024-12-22 08:26:49	2024-12-23 09:28:49	1448
2086	2024-12-23	1	08:31:10	11	Không thêm muối vào các món ăn	2024-12-22 08:14:10	2024-12-23 09:08:10	1224
2087	2024-12-23	1	10:04:48	3	Thêm chỗ để xe đẩy cho trẻ em	2024-12-22 10:00:48	2024-12-23 10:15:48	1776
2088	2024-12-23	1	08:22:02	2	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-22 08:02:02	2024-12-23 08:58:02	174
2089	2024-12-23	1	10:25:02	9	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-22 09:43:02	2024-12-23 10:55:02	203
2090	2024-12-23	1	08:23:28	16		2024-12-22 08:01:28	2024-12-23 08:46:28	1416
2091	2024-12-23	1	16:40:25	20	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-22 16:06:25	2024-12-23 17:21:25	1250
2092	2024-12-23	1	16:12:41	12	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-22 15:38:41	2024-12-23 16:19:41	603
2093	2024-12-23	2	14:20:24	3	Thêm một đĩa trái cây cho trẻ em	2024-12-22 13:55:24	2024-12-23 14:26:24	1009
2094	2024-12-23	0	17:38:24	19	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-22 17:08:24	2024-12-23 18:04:24	721
2095	2024-12-23	1	17:35:00	6	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-22 17:04:00	2024-12-23 18:07:00	1916
2096	2024-12-23	1	13:59:42	16	Thêm chỗ để xe đẩy cho trẻ em	2024-12-22 13:15:42	2024-12-23 14:44:42	217
2097	2024-12-23	1	16:32:10	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-22 16:03:10	2024-12-23 17:09:10	842
2098	2024-12-23	0	12:04:14	3	Chuẩn bị thực đơn thuần chay	2024-12-22 11:59:14	2024-12-23 12:44:14	83
2099	2024-12-23	2	11:08:54	15	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-22 10:51:54	2024-12-23 11:16:54	1170
2100	2024-12-23	1	13:31:24	4	Dành chỗ ngồi cho nhóm 10 người	2024-12-22 13:17:24	2024-12-23 13:33:24	832
2101	2024-12-23	1	11:32:08	1	Dành chỗ ngồi cho nhóm 10 người	2024-12-22 11:24:08	2024-12-23 11:38:08	168
2102	2024-12-23	1	16:39:32	12	Không thêm muối vào các món ăn	2024-12-22 16:18:32	2024-12-23 17:10:32	1877
2103	2024-12-23	0	20:53:09	17	Thêm chỗ để xe đẩy cho trẻ em	2024-12-22 20:13:09	2024-12-23 21:24:09	1069
2104	2024-12-23	0	18:54:26	13	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-22 18:47:26	2024-12-23 19:08:26	1579
2105	2024-12-23	1	19:14:52	1	Bàn gần cửa sổ để ngắm cảnh	2024-12-22 18:51:52	2024-12-23 19:42:52	1726
2106	2024-12-23	1	20:22:14	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-22 19:46:14	2024-12-23 21:02:14	317
2107	2024-12-23	1	18:37:20	5	Thêm chỗ để xe đẩy cho trẻ em	2024-12-22 18:13:20	2024-12-23 19:22:20	1471
2108	2024-12-23	1	18:17:50	5	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-22 17:54:50	2024-12-23 18:18:50	1975
2109	2024-12-23	1	21:11:26	7	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-22 20:33:26	2024-12-23 21:42:26	1533
2110	2024-12-23	1	20:08:52	18	Dọn sẵn đĩa và dao cắt bánh	2024-12-22 19:42:52	2024-12-23 20:42:52	143
2111	2024-12-23	0	19:29:52	13		2024-12-22 19:03:52	2024-12-23 19:46:52	855
2112	2024-12-23	2	18:15:30	2	Không dùng hành hoặc tỏi trong món ăn	2024-12-22 17:37:30	2024-12-23 18:48:30	1022
2113	2024-12-23	1	18:13:35	3	Không dùng hành hoặc tỏi trong món ăn	2024-12-22 18:02:35	2024-12-23 18:18:35	633
2114	2024-12-23	1	19:10:44	17	Thêm chỗ để xe đẩy cho trẻ em	2024-12-22 18:27:44	2024-12-23 19:45:44	1521
2115	2024-12-23	1	21:21:45	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-22 20:56:45	2024-12-23 21:33:45	1501
2116	2024-12-23	2	21:53:59	4		2024-12-22 21:25:59	2024-12-23 22:10:59	1855
2117	2024-12-23	1	19:32:46	3	Có món ăn phù hợp với người lớn tuổi	2024-12-22 19:23:46	2024-12-23 19:42:46	1508
2118	2024-12-23	1	18:43:28	11	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-22 18:04:28	2024-12-23 19:24:28	604
2119	2024-12-23	0	23:23:54	11	Bàn gần cửa sổ để ngắm cảnh	2024-12-22 22:54:54	2024-12-24 00:08:54	262
2120	2024-12-24	2	05:01:49	18	Thêm một đĩa trái cây cho trẻ em	2024-12-23 04:51:49	2024-12-24 05:25:49	1217
2121	2024-12-24	2	08:39:03	9	Dành chỗ ngồi cho nhóm 10 người	2024-12-23 08:23:03	2024-12-24 08:56:03	105
2122	2024-12-24	1	10:20:00	20		2024-12-23 09:54:00	2024-12-24 10:42:00	390
2123	2024-12-24	1	09:13:26	14	Bàn gần cửa sổ để ngắm cảnh	2024-12-23 08:56:26	2024-12-24 09:21:26	1128
2124	2024-12-24	1	10:11:34	9		2024-12-23 09:47:34	2024-12-24 10:21:34	1960
2125	2024-12-24	1	09:47:40	3	Không thêm muối vào các món ăn	2024-12-23 09:36:40	2024-12-24 10:18:40	1107
2126	2024-12-24	0	08:16:15	18	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-23 07:41:15	2024-12-24 08:47:15	541
2127	2024-12-24	2	07:29:22	9	Không dùng món ăn quá cay	2024-12-23 07:14:22	2024-12-24 08:03:22	1443
2128	2024-12-24	1	09:52:11	2	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-23 09:43:11	2024-12-24 10:12:11	1200
2129	2024-12-24	1	09:22:08	7	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-23 09:14:08	2024-12-24 09:22:08	1013
2130	2024-12-24	1	10:27:57	3	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-23 09:54:57	2024-12-24 10:30:57	636
2131	2024-12-24	1	16:35:48	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-23 16:11:48	2024-12-24 16:57:48	358
2132	2024-12-24	1	11:09:21	2	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-23 10:41:21	2024-12-24 11:21:21	1515
2133	2024-12-24	1	16:38:52	12	Thêm chỗ để xe đẩy cho trẻ em	2024-12-23 16:20:52	2024-12-24 16:49:52	1118
2134	2024-12-24	0	14:29:53	13	Bàn gần cửa sổ để ngắm cảnh	2024-12-23 14:11:53	2024-12-24 14:42:53	717
2135	2024-12-24	1	14:24:29	2	Không dùng món ăn quá cay	2024-12-23 13:44:29	2024-12-24 14:26:29	318
2136	2024-12-24	1	14:19:36	14	Không dùng món ăn quá cay	2024-12-23 14:10:36	2024-12-24 14:22:36	883
2137	2024-12-24	1	12:28:29	5	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-23 12:22:29	2024-12-24 13:02:29	1985
2138	2024-12-24	1	17:37:40	11	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-23 17:25:40	2024-12-24 17:39:40	750
2139	2024-12-24	1	15:25:13	9	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-23 15:25:13	2024-12-24 15:40:13	1800
2140	2024-12-24	1	14:03:02	6	Không thêm muối vào các món ăn	2024-12-23 13:24:02	2024-12-24 14:20:02	680
2141	2024-12-24	1	13:21:53	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-23 12:43:53	2024-12-24 13:24:53	1725
2142	2024-12-24	1	17:01:43	1	Không dùng hành hoặc tỏi trong món ăn	2024-12-23 16:20:43	2024-12-24 17:25:43	1216
2143	2024-12-24	1	19:49:07	2	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-23 19:25:07	2024-12-24 20:29:07	1086
2144	2024-12-24	1	19:29:12	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-23 19:05:12	2024-12-24 20:05:12	1570
2145	2024-12-24	1	21:16:11	13	Dành chỗ ngồi cho nhóm 10 người	2024-12-23 21:03:11	2024-12-24 21:20:11	1387
2146	2024-12-24	1	20:10:33	5	Không thêm muối vào các món ăn	2024-12-23 19:35:33	2024-12-24 20:36:33	557
2147	2024-12-24	1	19:10:52	20	Không dùng hành hoặc tỏi trong món ăn	2024-12-23 18:46:52	2024-12-24 19:32:52	1628
2148	2024-12-24	0	18:44:37	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-23 18:18:37	2024-12-24 19:09:37	1758
2149	2024-12-24	1	21:47:10	10	Dọn sẵn đĩa và dao cắt bánh	2024-12-23 21:20:10	2024-12-24 22:18:10	1953
2150	2024-12-24	1	21:20:55	1	Chuẩn bị thực đơn thuần chay	2024-12-23 20:38:55	2024-12-24 21:37:55	979
2151	2024-12-24	1	18:25:29	5	Bàn gần cửa sổ để ngắm cảnh	2024-12-23 18:17:29	2024-12-24 18:48:29	1051
2152	2024-12-24	1	20:12:50	7	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-23 20:12:50	2024-12-24 20:43:50	908
2153	2024-12-24	2	20:12:34	19	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-23 20:03:34	2024-12-24 20:15:34	1530
2154	2024-12-24	0	18:10:01	9	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-23 17:52:01	2024-12-24 18:48:01	39
2155	2024-12-24	2	21:29:00	4	Không dùng hành hoặc tỏi trong món ăn	2024-12-23 21:11:00	2024-12-24 21:39:00	1222
2156	2024-12-24	0	19:37:12	13	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-23 18:53:12	2024-12-24 20:19:12	1571
2157	2024-12-24	1	20:31:27	15	Không dùng món ăn quá cay	2024-12-23 20:10:27	2024-12-24 21:00:27	297
2158	2024-12-24	1	21:40:28	2	Thêm chỗ để xe đẩy cho trẻ em	2024-12-23 21:27:28	2024-12-24 22:22:28	1285
2159	2024-12-24	1	22:34:29	4	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-23 22:21:29	2024-12-24 22:54:29	1111
2160	2024-12-25	2	08:48:11	2	Thêm một đĩa trái cây cho trẻ em	2024-12-24 08:19:11	2024-12-25 09:31:11	1043
2161	2024-12-25	0	06:07:33	9	Bàn gần cửa sổ để ngắm cảnh	2024-12-24 05:33:33	2024-12-25 06:52:33	265
2162	2024-12-25	1	05:51:36	4	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-24 05:20:36	2024-12-25 05:53:36	461
2163	2024-12-25	1	06:10:39	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-24 05:28:39	2024-12-25 06:36:39	703
2164	2024-12-25	1	06:05:06	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-24 05:47:06	2024-12-25 06:45:06	1152
2165	2024-12-25	0	06:53:43	9	Không dùng món ăn quá cay	2024-12-24 06:29:43	2024-12-25 07:17:43	1710
2166	2024-12-25	0	05:23:42	5	Cung cấp thực đơn không chứa gluten	2024-12-24 05:21:42	2024-12-25 05:57:42	743
2167	2024-12-25	1	08:15:09	3	Bàn gần cửa sổ để ngắm cảnh	2024-12-24 07:38:09	2024-12-25 08:17:09	968
2168	2024-12-25	2	07:38:15	15	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-24 07:30:15	2024-12-25 07:45:15	1365
2169	2024-12-25	1	06:14:24	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-24 05:41:24	2024-12-25 06:56:24	1600
2170	2024-12-25	1	07:37:13	18	Dành chỗ ngồi cho nhóm 10 người	2024-12-24 07:30:13	2024-12-25 07:52:13	825
2171	2024-12-25	2	11:24:27	4	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-24 10:50:27	2024-12-25 11:52:27	1339
2172	2024-12-25	1	16:16:49	9	Chuẩn bị thực đơn thuần chay	2024-12-24 16:03:49	2024-12-25 16:33:49	35
2173	2024-12-25	2	12:39:30	2	Thêm một đĩa trái cây cho trẻ em	2024-12-24 12:02:30	2024-12-25 12:53:30	1645
2174	2024-12-25	0	17:13:20	20	Cung cấp thực đơn không chứa gluten	2024-12-24 16:47:20	2024-12-25 17:34:20	1285
2175	2024-12-25	1	16:34:51	9	Thêm một đĩa trái cây cho trẻ em	2024-12-24 16:04:51	2024-12-25 17:17:51	1453
2176	2024-12-25	1	15:46:41	14	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-24 15:34:41	2024-12-25 16:21:41	438
2177	2024-12-25	2	15:42:51	9	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-24 15:13:51	2024-12-25 15:42:51	1012
2178	2024-12-25	1	15:57:58	10	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-24 15:35:58	2024-12-25 16:39:58	1395
2179	2024-12-25	1	13:01:18	13	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-24 12:35:18	2024-12-25 13:35:18	585
2180	2024-12-25	1	16:14:19	5	Dọn sẵn đĩa và dao cắt bánh	2024-12-24 15:58:19	2024-12-25 16:53:19	1977
2181	2024-12-25	1	14:11:16	6	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-24 13:30:16	2024-12-25 14:31:16	805
2182	2024-12-25	1	12:44:53	10	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-24 12:04:53	2024-12-25 12:56:53	1865
2183	2024-12-25	1	20:41:26	4	Bàn gần cửa sổ để ngắm cảnh	2024-12-24 20:38:26	2024-12-25 20:59:26	203
2184	2024-12-25	1	18:35:39	3	Có món ăn phù hợp với người lớn tuổi	2024-12-24 17:55:39	2024-12-25 18:43:39	864
2185	2024-12-25	1	18:53:09	2		2024-12-24 18:40:09	2024-12-25 19:30:09	1036
2186	2024-12-25	0	18:14:31	9	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-24 17:55:31	2024-12-25 18:40:31	967
2187	2024-12-25	2	21:47:13	4	Dành chỗ ngồi cho nhóm 10 người	2024-12-24 21:45:13	2024-12-25 22:12:13	646
2188	2024-12-25	1	20:37:10	17	Cung cấp thực đơn không chứa gluten	2024-12-24 20:22:10	2024-12-25 20:56:10	304
2189	2024-12-25	2	21:41:28	11		2024-12-24 21:09:28	2024-12-25 22:04:28	1764
2190	2024-12-25	1	19:14:02	6	Không dùng hành hoặc tỏi trong món ăn	2024-12-24 18:35:02	2024-12-25 19:51:02	1937
2191	2024-12-25	2	20:23:21	4	Bàn gần cửa sổ để ngắm cảnh	2024-12-24 20:09:21	2024-12-25 20:35:21	1554
2192	2024-12-25	1	19:37:10	3	Bàn gần cửa sổ để ngắm cảnh	2024-12-24 19:21:10	2024-12-25 20:02:10	1194
2193	2024-12-25	1	19:59:05	14	Không thêm muối vào các món ăn	2024-12-24 19:52:05	2024-12-25 20:13:05	971
2194	2024-12-25	1	21:45:41	6	Có món ăn phù hợp với người lớn tuổi	2024-12-24 21:08:41	2024-12-25 22:28:41	725
2195	2024-12-25	0	21:07:18	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-24 20:24:18	2024-12-25 21:51:18	487
2196	2024-12-25	2	19:17:24	2	Cung cấp thực đơn không chứa gluten	2024-12-24 18:34:24	2024-12-25 19:57:24	614
2197	2024-12-25	0	18:28:31	4	Không dùng món ăn quá cay	2024-12-24 18:23:31	2024-12-25 18:46:31	1163
2198	2024-12-25	1	20:58:40	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-24 20:45:40	2024-12-25 21:19:40	1371
2199	2024-12-26	1	01:07:10	1	Chuẩn bị thực đơn thuần chay	2024-12-25 00:44:10	2024-12-26 01:52:10	949
2200	2024-12-26	2	05:44:54	19	Bàn gần cửa sổ để ngắm cảnh	2024-12-25 05:05:54	2024-12-26 06:11:54	1646
2201	2024-12-26	1	06:06:51	4	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-25 05:23:51	2024-12-26 06:16:51	976
2202	2024-12-26	0	09:37:34	11	Không dùng hành hoặc tỏi trong món ăn	2024-12-25 09:00:34	2024-12-26 09:45:34	1943
2203	2024-12-26	1	08:46:36	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-25 08:32:36	2024-12-26 09:27:36	1770
2204	2024-12-26	1	07:03:12	14	Thêm một đĩa trái cây cho trẻ em	2024-12-25 06:26:12	2024-12-26 07:34:12	1404
2205	2024-12-26	0	09:13:05	12	Bàn gần cửa sổ để ngắm cảnh	2024-12-25 08:57:05	2024-12-26 09:23:05	1082
2206	2024-12-26	1	10:13:27	19	Chuẩn bị thực đơn thuần chay	2024-12-25 09:40:27	2024-12-26 10:47:27	103
2207	2024-12-26	1	06:53:15	4	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-25 06:18:15	2024-12-26 07:31:15	1928
2208	2024-12-26	0	10:17:15	10	Thêm chỗ để xe đẩy cho trẻ em	2024-12-25 10:04:15	2024-12-26 10:36:15	1742
2209	2024-12-26	1	09:30:50	4	Dành chỗ ngồi cho nhóm 10 người	2024-12-25 09:15:50	2024-12-26 09:51:50	316
2210	2024-12-26	2	10:49:52	4	Bàn gần cửa sổ để ngắm cảnh	2024-12-25 10:46:52	2024-12-26 11:29:52	756
2211	2024-12-26	0	12:56:18	18	Dọn sẵn đĩa và dao cắt bánh	2024-12-25 12:32:18	2024-12-26 13:25:18	367
2212	2024-12-26	1	15:02:10	1	Dọn sẵn đĩa và dao cắt bánh	2024-12-25 14:47:10	2024-12-26 15:27:10	1852
2213	2024-12-26	1	12:53:49	9	Chuẩn bị thực đơn thuần chay	2024-12-25 12:53:49	2024-12-26 12:54:49	175
2214	2024-12-26	0	12:10:38	7	Chuẩn bị thực đơn thuần chay	2024-12-25 11:55:38	2024-12-26 12:46:38	1167
2215	2024-12-26	1	17:33:37	9	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-25 17:09:37	2024-12-26 17:40:37	198
2216	2024-12-26	1	12:19:38	5	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-25 11:43:38	2024-12-26 12:50:38	1360
2217	2024-12-26	1	13:10:11	12	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-25 12:55:11	2024-12-26 13:18:11	656
2218	2024-12-26	1	14:50:00	20	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-25 14:37:00	2024-12-26 15:12:00	33
2219	2024-12-26	0	13:14:39	1	Chuẩn bị thực đơn thuần chay	2024-12-25 12:42:39	2024-12-26 13:19:39	687
2220	2024-12-26	0	11:08:23	20	Dành chỗ ngồi cho nhóm 10 người	2024-12-25 10:34:23	2024-12-26 11:20:23	1037
2221	2024-12-26	1	14:43:52	2	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-25 14:28:52	2024-12-26 15:18:52	112
2222	2024-12-26	1	12:51:01	19		2024-12-25 12:08:01	2024-12-26 13:31:01	561
2223	2024-12-26	0	20:14:08	14	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-25 19:54:08	2024-12-26 20:42:08	390
2224	2024-12-26	1	19:23:53	15	Không thêm muối vào các món ăn	2024-12-25 19:14:53	2024-12-26 19:46:53	1339
2225	2024-12-26	1	18:38:10	15	Thêm một đĩa trái cây cho trẻ em	2024-12-25 18:20:10	2024-12-26 18:56:10	279
2226	2024-12-26	1	20:22:30	15	Bàn gần cửa sổ để ngắm cảnh	2024-12-25 19:38:30	2024-12-26 20:44:30	1240
2227	2024-12-26	1	19:54:07	16	Dành chỗ ngồi cho nhóm 10 người	2024-12-25 19:48:07	2024-12-26 20:26:07	397
2228	2024-12-26	2	20:02:38	3	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-25 19:38:38	2024-12-26 20:07:38	1467
2229	2024-12-26	1	21:44:56	13	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-25 21:04:56	2024-12-26 22:05:56	1442
2230	2024-12-26	1	21:46:49	1	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-25 21:08:49	2024-12-26 22:00:49	1359
2231	2024-12-26	2	18:49:24	4	Dành chỗ ngồi cho nhóm 10 người	2024-12-25 18:43:24	2024-12-26 19:02:24	1266
2232	2024-12-26	2	21:29:26	12	Không dùng hành hoặc tỏi trong món ăn	2024-12-25 21:23:26	2024-12-26 21:36:26	1680
2233	2024-12-26	1	20:41:54	11	Không dùng hành hoặc tỏi trong món ăn	2024-12-25 20:33:54	2024-12-26 20:59:54	1756
2234	2024-12-26	0	19:59:15	2	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-25 19:54:15	2024-12-26 20:42:15	1796
2235	2024-12-26	1	19:22:31	3	Không thêm muối vào các món ăn	2024-12-25 18:50:31	2024-12-26 19:53:31	1847
2236	2024-12-26	1	18:10:15	20	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-25 17:52:15	2024-12-26 18:55:15	1705
2237	2024-12-26	1	18:29:49	2	Dọn sẵn đĩa và dao cắt bánh	2024-12-25 18:00:49	2024-12-26 18:56:49	1537
2238	2024-12-26	1	20:59:53	2	Không dùng hành hoặc tỏi trong món ăn	2024-12-25 20:43:53	2024-12-26 21:42:53	324
2239	2024-12-27	0	00:06:10	7	Bàn gần cửa sổ để ngắm cảnh	2024-12-25 23:29:10	2024-12-27 00:09:10	1105
2240	2024-12-27	1	05:38:53	16	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-26 05:38:53	2024-12-27 05:39:53	556
2241	2024-12-27	2	05:29:22	20	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-26 04:46:22	2024-12-27 05:35:22	635
2242	2024-12-27	1	10:55:51	12	Thêm chỗ để xe đẩy cho trẻ em	2024-12-26 10:22:51	2024-12-27 11:22:51	757
2243	2024-12-27	2	05:04:34	17	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-26 04:56:34	2024-12-27 05:26:34	333
2244	2024-12-27	1	05:48:49	10	Bàn gần cửa sổ để ngắm cảnh	2024-12-26 05:18:49	2024-12-27 06:10:49	1438
2245	2024-12-27	1	10:14:27	5	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-26 10:12:27	2024-12-27 10:19:27	983
2246	2024-12-27	1	09:53:59	14	Không thêm muối vào các món ăn	2024-12-26 09:22:59	2024-12-27 10:04:59	1810
2247	2024-12-27	1	09:17:51	17	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-26 08:55:51	2024-12-27 09:56:51	1362
2248	2024-12-27	1	10:16:42	4	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-26 09:56:42	2024-12-27 10:18:42	1254
2249	2024-12-27	1	06:14:04	1	Cung cấp thực đơn không chứa gluten	2024-12-26 06:03:04	2024-12-27 06:33:04	275
2250	2024-12-27	1	06:06:36	9	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-26 05:53:36	2024-12-27 06:06:36	36
2251	2024-12-27	1	13:21:58	8	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-26 12:47:58	2024-12-27 13:47:58	1716
2252	2024-12-27	1	11:39:19	8	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-26 11:33:19	2024-12-27 12:04:19	568
2253	2024-12-27	1	11:47:54	20	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-26 11:12:54	2024-12-27 12:16:54	1922
2254	2024-12-27	1	12:38:17	18		2024-12-26 12:01:17	2024-12-27 12:49:17	787
2255	2024-12-27	1	15:43:48	20	Dọn sẵn đĩa và dao cắt bánh	2024-12-26 15:11:48	2024-12-27 16:14:48	1798
2256	2024-12-27	1	13:21:30	12	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-26 13:12:30	2024-12-27 13:50:30	1185
2257	2024-12-27	1	15:26:58	12	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-26 14:44:58	2024-12-27 15:35:58	1464
2258	2024-12-27	2	13:28:12	3	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-26 13:21:12	2024-12-27 14:13:12	1729
2259	2024-12-27	1	16:32:26	1	Có món ăn phù hợp với người lớn tuổi	2024-12-26 16:04:26	2024-12-27 16:59:26	1134
2260	2024-12-27	1	16:12:14	1	Bàn gần cửa sổ để ngắm cảnh	2024-12-26 15:40:14	2024-12-27 16:41:14	1993
2261	2024-12-27	1	12:39:18	11	Dành chỗ ngồi cho nhóm 10 người	2024-12-26 12:10:18	2024-12-27 13:05:18	1590
2262	2024-12-27	0	13:13:41	13	Có món ăn phù hợp với người lớn tuổi	2024-12-26 12:41:41	2024-12-27 13:15:41	451
2263	2024-12-27	1	20:12:40	3	Bàn gần cửa sổ để ngắm cảnh	2024-12-26 20:04:40	2024-12-27 20:30:40	425
2264	2024-12-27	1	18:31:07	7	Có món ăn phù hợp với người lớn tuổi	2024-12-26 18:11:07	2024-12-27 18:51:07	1536
2265	2024-12-27	1	20:26:44	3	Có món ăn phù hợp với người lớn tuổi	2024-12-26 20:00:44	2024-12-27 21:08:44	1247
2266	2024-12-27	1	18:23:14	16	Dọn sẵn đĩa và dao cắt bánh	2024-12-26 18:11:14	2024-12-27 18:23:14	518
2267	2024-12-27	1	18:48:25	8	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-26 18:18:25	2024-12-27 18:48:25	660
2268	2024-12-27	0	19:50:53	10	Thêm chỗ để xe đẩy cho trẻ em	2024-12-26 19:07:53	2024-12-27 19:58:53	367
2269	2024-12-27	1	19:56:56	1	Không dùng món ăn quá cay	2024-12-26 19:45:56	2024-12-27 20:18:56	152
2270	2024-12-27	1	21:35:25	5	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-26 21:13:25	2024-12-27 21:58:25	590
2271	2024-12-27	1	20:48:35	9	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-26 20:08:35	2024-12-27 20:49:35	1138
2272	2024-12-27	0	19:29:15	12	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-26 19:19:15	2024-12-27 19:50:15	786
2273	2024-12-27	1	19:03:52	4	Không dùng hành hoặc tỏi trong món ăn	2024-12-26 18:43:52	2024-12-27 19:19:52	1338
2274	2024-12-27	1	21:15:37	9	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-26 21:08:37	2024-12-27 21:41:37	899
2275	2024-12-27	1	19:00:32	6	Dành chỗ ngồi cho nhóm 10 người	2024-12-26 18:25:32	2024-12-27 19:21:32	683
2276	2024-12-27	2	21:04:07	10	Không dùng món ăn quá cay	2024-12-26 20:29:07	2024-12-27 21:34:07	572
2277	2024-12-27	1	18:25:50	4	Không dùng món ăn quá cay	2024-12-26 17:59:50	2024-12-27 18:38:50	1689
2278	2024-12-27	2	20:47:09	8	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-26 20:19:09	2024-12-27 20:57:09	662
2279	2024-12-28	1	00:49:22	19	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-27 00:11:22	2024-12-28 01:33:22	1575
2280	2024-12-28	1	08:36:42	7	Thêm một đĩa trái cây cho trẻ em	2024-12-27 08:03:42	2024-12-28 08:49:42	1847
2281	2024-12-28	1	05:30:32	3	Bàn gần cửa sổ để ngắm cảnh	2024-12-27 05:07:32	2024-12-28 05:55:32	1594
2282	2024-12-28	1	09:34:00	4	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-27 09:11:00	2024-12-28 09:45:00	1314
2283	2024-12-28	2	06:05:39	5	Bàn gần cửa sổ để ngắm cảnh	2024-12-27 05:55:39	2024-12-28 06:22:39	1934
2284	2024-12-28	2	05:14:50	2	Cung cấp thực đơn không chứa gluten	2024-12-27 05:13:50	2024-12-28 05:24:50	984
2285	2024-12-28	1	05:02:47	13	Có món ăn phù hợp với người lớn tuổi	2024-12-27 04:23:47	2024-12-28 05:33:47	1352
2286	2024-12-28	0	07:51:43	4	Dọn sẵn đĩa và dao cắt bánh	2024-12-27 07:22:43	2024-12-28 08:22:43	571
2287	2024-12-28	1	06:22:17	2	Không dùng món ăn quá cay	2024-12-27 06:12:17	2024-12-28 06:24:17	884
2288	2024-12-28	1	07:45:59	2	Không thêm muối vào các món ăn	2024-12-27 07:24:59	2024-12-28 07:55:59	1899
2289	2024-12-28	1	09:57:23	6	Dành chỗ ngồi cho nhóm 10 người	2024-12-27 09:27:23	2024-12-28 10:17:23	1066
2290	2024-12-28	1	05:52:01	3	Dành chỗ ngồi cho nhóm 10 người	2024-12-27 05:51:01	2024-12-28 06:10:01	1337
2291	2024-12-28	1	14:24:42	8	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-27 14:21:42	2024-12-28 15:06:42	1531
2292	2024-12-28	2	17:15:59	3	Bàn gần cửa sổ để ngắm cảnh	2024-12-27 17:08:59	2024-12-28 17:47:59	1324
2293	2024-12-28	0	13:27:24	5	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-27 13:16:24	2024-12-28 13:55:24	1159
2294	2024-12-28	1	11:51:24	16	Có món ăn phù hợp với người lớn tuổi	2024-12-27 11:23:24	2024-12-28 12:11:24	1470
2295	2024-12-28	1	17:09:00	2		2024-12-27 17:03:00	2024-12-28 17:41:00	403
2296	2024-12-28	1	13:12:15	19	Không dùng món ăn quá cay	2024-12-27 12:53:15	2024-12-28 13:30:15	1729
2297	2024-12-28	1	14:41:03	7	Thêm chỗ để xe đẩy cho trẻ em	2024-12-27 14:18:03	2024-12-28 14:48:03	792
2298	2024-12-28	1	15:33:35	14	Không dùng hành hoặc tỏi trong món ăn	2024-12-27 15:32:35	2024-12-28 16:06:35	1969
2299	2024-12-28	0	16:47:11	11	Thêm một đĩa trái cây cho trẻ em	2024-12-27 16:38:11	2024-12-28 17:21:11	1294
2300	2024-12-28	1	11:37:57	7	Bàn gần cửa sổ để ngắm cảnh	2024-12-27 11:31:57	2024-12-28 12:12:57	10
2301	2024-12-28	0	17:36:53	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-27 17:10:53	2024-12-28 18:08:53	417
2302	2024-12-28	0	13:06:43	4	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-27 13:05:43	2024-12-28 13:38:43	1451
2303	2024-12-28	2	19:02:36	4	Dành chỗ ngồi cho nhóm 10 người	2024-12-27 18:44:36	2024-12-28 19:25:36	127
2304	2024-12-28	2	18:34:14	19	Có món ăn phù hợp với người lớn tuổi	2024-12-27 17:51:14	2024-12-28 18:46:14	1971
2305	2024-12-28	2	21:10:46	16	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2024-12-27 20:54:46	2024-12-28 21:45:46	1326
2306	2024-12-28	1	19:15:12	2	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-27 19:04:12	2024-12-28 19:48:12	1473
2307	2024-12-28	1	18:49:52	6		2024-12-27 18:35:52	2024-12-28 19:01:52	668
2308	2024-12-28	1	20:07:53	1	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-27 19:56:53	2024-12-28 20:37:53	1120
2309	2024-12-28	1	18:23:57	8	Bàn gần cửa sổ để ngắm cảnh	2024-12-27 18:09:57	2024-12-28 19:03:57	347
2310	2024-12-28	1	20:25:49	12	Không dùng hành hoặc tỏi trong món ăn	2024-12-27 20:01:49	2024-12-28 20:35:49	51
2311	2024-12-28	0	21:46:34	2	Có món ăn phù hợp với người lớn tuổi	2024-12-27 21:25:34	2024-12-28 22:15:34	371
2312	2024-12-28	2	20:22:03	3	Dọn sẵn đĩa và dao cắt bánh	2024-12-27 20:17:03	2024-12-28 20:43:03	1459
2313	2024-12-28	1	21:57:22	5	Có món ăn phù hợp với người lớn tuổi	2024-12-27 21:49:22	2024-12-28 22:00:22	298
2314	2024-12-28	0	20:37:10	6	Không thêm muối vào các món ăn	2024-12-27 19:57:10	2024-12-28 20:42:10	1343
2315	2024-12-28	1	21:45:14	11	Chuẩn bị thực đơn thuần chay	2024-12-27 21:09:14	2024-12-28 22:17:14	1968
2316	2024-12-28	0	18:09:43	19	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-27 17:38:43	2024-12-28 18:48:43	1253
2317	2024-12-28	1	19:05:10	1	Không thêm muối vào các món ăn	2024-12-27 18:38:10	2024-12-28 19:11:10	331
2318	2024-12-28	1	20:22:31	6	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-27 20:20:31	2024-12-28 20:44:31	573
2319	2024-12-28	1	23:05:16	2	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-27 22:23:16	2024-12-28 23:45:16	1576
2320	2024-12-29	1	09:05:14	1	Không dùng món ăn quá cay	2024-12-28 08:54:14	2024-12-29 09:19:14	1021
2321	2024-12-29	1	10:11:45	20	Bàn gần cửa sổ để ngắm cảnh	2024-12-28 10:11:45	2024-12-29 10:48:45	1214
2322	2024-12-29	0	08:39:58	6	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-28 08:32:58	2024-12-29 08:58:58	760
2323	2024-12-29	1	05:17:07	2	Không dùng món ăn quá cay	2024-12-28 04:54:07	2024-12-29 05:36:07	731
2324	2024-12-29	1	05:38:48	11	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-28 05:26:48	2024-12-29 05:56:48	21
2325	2024-12-29	1	08:47:29	14	Có món ăn phù hợp với người lớn tuổi	2024-12-28 08:12:29	2024-12-29 08:55:29	1812
2326	2024-12-29	1	06:12:21	3	Không dùng món ăn quá cay	2024-12-28 05:48:21	2024-12-29 06:37:21	1403
2327	2024-12-29	1	05:16:41	3	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-28 04:59:41	2024-12-29 05:34:41	1334
2328	2024-12-29	1	09:31:25	14	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-28 09:20:25	2024-12-29 09:49:25	937
2329	2024-12-29	1	07:06:07	11	Cung cấp thực đơn không chứa gluten	2024-12-28 07:06:07	2024-12-29 07:06:07	1914
2330	2024-12-29	1	05:09:09	4	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-28 04:32:09	2024-12-29 05:47:09	1129
2331	2024-12-29	1	15:37:36	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-28 15:14:36	2024-12-29 16:04:36	1195
2332	2024-12-29	1	17:59:52	8	Dành chỗ ngồi cho nhóm 10 người	2024-12-28 17:49:52	2024-12-29 18:09:52	363
2333	2024-12-29	1	13:19:25	5	Chuẩn bị thực đơn thuần chay	2024-12-28 13:03:25	2024-12-29 13:28:25	607
2334	2024-12-29	1	14:44:12	20	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-28 14:08:12	2024-12-29 14:56:12	803
2335	2024-12-29	0	15:35:11	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2024-12-28 15:11:11	2024-12-29 16:09:11	365
2336	2024-12-29	1	12:14:16	3	Có món ăn phù hợp với người lớn tuổi	2024-12-28 11:45:16	2024-12-29 12:37:16	1807
2337	2024-12-29	1	16:15:10	3	Có món ăn phù hợp với người lớn tuổi	2024-12-28 16:13:10	2024-12-29 16:31:10	260
2338	2024-12-29	2	13:00:46	10	Dành chỗ ngồi cho nhóm 10 người	2024-12-28 12:57:46	2024-12-29 13:32:46	343
2339	2024-12-29	0	17:11:25	1	Dành chỗ ngồi cho nhóm 10 người	2024-12-28 16:31:25	2024-12-29 17:13:25	1246
2340	2024-12-29	1	12:15:21	2		2024-12-28 12:04:21	2024-12-29 12:56:21	1001
2341	2024-12-29	0	15:05:53	5	Thêm chỗ để xe đẩy cho trẻ em	2024-12-28 14:53:53	2024-12-29 15:13:53	282
2342	2024-12-29	1	17:01:52	9	Cung cấp thực đơn không chứa gluten	2024-12-28 16:54:52	2024-12-29 17:41:52	204
2343	2024-12-29	1	19:04:46	11	Chuẩn bị thực đơn thuần chay	2024-12-28 18:33:46	2024-12-29 19:36:46	953
2344	2024-12-29	1	21:40:01	1	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-28 21:24:01	2024-12-29 22:15:01	2000
2345	2024-12-29	1	19:14:48	11	Dành chỗ ngồi cho nhóm 10 người	2024-12-28 19:02:48	2024-12-29 19:34:48	1817
2346	2024-12-29	2	19:54:22	4	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-28 19:53:22	2024-12-29 20:21:22	1944
2347	2024-12-29	0	19:10:29	6	Không dùng hành hoặc tỏi trong món ăn	2024-12-28 18:44:29	2024-12-29 19:40:29	1260
2348	2024-12-29	2	21:11:04	6	Không dùng món ăn quá cay	2024-12-28 21:05:04	2024-12-29 21:23:04	468
2349	2024-12-29	0	19:38:04	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-28 19:26:04	2024-12-29 19:56:04	567
2350	2024-12-29	0	19:03:29	2	Thêm chỗ để xe đẩy cho trẻ em	2024-12-28 18:42:29	2024-12-29 19:36:29	106
2351	2024-12-29	1	19:22:47	6	Thêm chỗ để xe đẩy cho trẻ em	2024-12-28 19:00:47	2024-12-29 19:50:47	1418
2352	2024-12-29	1	21:50:45	5	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-28 21:06:45	2024-12-29 22:16:45	952
2353	2024-12-29	1	18:21:16	1	Có món ăn phù hợp với người lớn tuổi	2024-12-28 18:13:16	2024-12-29 18:57:16	1257
2354	2024-12-29	1	20:01:41	20	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-28 19:52:41	2024-12-29 20:08:41	1073
2355	2024-12-29	1	19:30:53	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-28 19:19:53	2024-12-29 19:57:53	1911
2356	2024-12-29	0	19:43:06	5	Thêm chỗ để xe đẩy cho trẻ em	2024-12-28 19:14:06	2024-12-29 20:26:06	1337
2357	2024-12-29	1	21:59:27	13	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-28 21:58:27	2024-12-29 22:34:27	1382
2358	2024-12-29	2	21:21:24	2	Cung cấp thực đơn không chứa gluten	2024-12-28 21:04:24	2024-12-29 21:42:24	207
2359	2024-12-29	2	22:47:34	8	Cung cấp thực đơn không chứa gluten	2024-12-28 22:16:34	2024-12-29 23:03:34	983
2360	2024-12-30	1	05:55:46	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-29 05:12:46	2024-12-30 06:14:46	280
2361	2024-12-30	1	10:58:09	6	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-29 10:16:09	2024-12-30 11:05:09	1770
2362	2024-12-30	1	10:06:42	5	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-29 09:34:42	2024-12-30 10:18:42	1417
2363	2024-12-30	1	05:15:54	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-29 04:31:54	2024-12-30 05:27:54	158
2364	2024-12-30	1	06:55:11	4	Chuẩn bị thực đơn thuần chay	2024-12-29 06:29:11	2024-12-30 07:06:11	710
2365	2024-12-30	1	05:18:51	12	Không dùng hành hoặc tỏi trong món ăn	2024-12-29 05:13:51	2024-12-30 05:34:51	1239
2366	2024-12-30	1	05:07:53	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-29 05:01:53	2024-12-30 05:07:53	484
2367	2024-12-30	1	06:27:24	4		2024-12-29 06:19:24	2024-12-30 06:55:24	1907
2368	2024-12-30	1	08:28:05	3	Không thêm muối vào các món ăn	2024-12-29 07:57:05	2024-12-30 08:58:05	1540
2369	2024-12-30	2	09:21:24	16	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-29 09:05:24	2024-12-30 10:03:24	1976
2370	2024-12-30	1	10:22:33	1		2024-12-29 09:50:33	2024-12-30 10:54:33	192
2371	2024-12-30	1	15:52:06	6	Dành chỗ ngồi cho nhóm 10 người	2024-12-29 15:40:06	2024-12-30 16:34:06	1241
2372	2024-12-30	1	11:31:20	20	Không dùng món ăn quá cay	2024-12-29 11:26:20	2024-12-30 12:00:20	1580
2373	2024-12-30	1	17:44:03	8	Dọn sẵn đĩa và dao cắt bánh	2024-12-29 17:16:03	2024-12-30 17:44:03	1783
2374	2024-12-30	0	14:22:49	2	Dành chỗ ngồi cho nhóm 10 người	2024-12-29 14:05:49	2024-12-30 14:34:49	1678
2375	2024-12-30	0	14:26:51	11	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-29 14:11:51	2024-12-30 14:43:51	1832
2376	2024-12-30	1	15:37:42	1	Không dùng hành hoặc tỏi trong món ăn	2024-12-29 15:22:42	2024-12-30 16:04:42	848
2377	2024-12-30	0	12:08:06	9	Chuẩn bị thực đơn thuần chay	2024-12-29 11:38:06	2024-12-30 12:18:06	595
2378	2024-12-30	1	17:34:08	17	Không dùng rượu trong món ăn cho trẻ nhỏ	2024-12-29 17:23:08	2024-12-30 17:39:08	607
2379	2024-12-30	0	17:13:47	10	Chuẩn bị thực đơn thuần chay	2024-12-29 16:50:47	2024-12-30 17:26:47	958
2380	2024-12-30	1	17:45:22	1	Chuẩn bị thực đơn thuần chay	2024-12-29 17:18:22	2024-12-30 17:55:22	507
2381	2024-12-30	1	11:59:19	17	Thêm chỗ để xe đẩy cho trẻ em	2024-12-29 11:19:19	2024-12-30 12:17:19	1146
2382	2024-12-30	0	16:39:40	8	Thêm một đĩa trái cây cho trẻ em	2024-12-29 16:25:40	2024-12-30 17:10:40	1584
2383	2024-12-30	0	20:13:41	4	Dành chỗ ngồi cho nhóm 10 người	2024-12-29 20:06:41	2024-12-30 20:15:41	425
2384	2024-12-30	2	18:58:46	3	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-29 18:41:46	2024-12-30 19:04:46	933
2385	2024-12-30	0	19:46:21	2	Không dùng món ăn quá cay	2024-12-29 19:09:21	2024-12-30 20:23:21	951
2386	2024-12-30	1	21:35:09	4	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2024-12-29 21:25:09	2024-12-30 21:36:09	1736
2387	2024-12-30	1	20:53:14	2	Không dùng món ăn quá cay	2024-12-29 20:49:14	2024-12-30 21:06:14	1256
2388	2024-12-30	1	18:56:53	4	Không thêm muối vào các món ăn	2024-12-29 18:20:53	2024-12-30 18:56:53	592
2389	2024-12-30	1	20:09:52	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-29 19:38:52	2024-12-30 20:34:52	322
2390	2024-12-30	1	21:06:56	3	Tách hóa đơn riêng cho từng người trong nhóm	2024-12-29 21:00:56	2024-12-30 21:16:56	1547
2391	2024-12-30	1	19:13:46	9	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-29 18:39:46	2024-12-30 19:27:46	1364
2392	2024-12-30	1	20:28:25	11	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2024-12-29 20:13:25	2024-12-30 20:56:25	1621
2393	2024-12-30	1	18:47:25	7	Phục vụ nhanh vì có trẻ em đi cùng	2024-12-29 18:22:25	2024-12-30 18:53:25	795
2394	2024-12-30	1	19:06:14	5	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-29 18:47:14	2024-12-30 19:09:14	1066
2395	2024-12-30	0	20:45:15	12	Không dùng hành hoặc tỏi trong món ăn	2024-12-29 20:04:15	2024-12-30 20:58:15	626
2396	2024-12-30	1	20:27:49	2	Dọn sẵn đĩa và dao cắt bánh	2024-12-29 20:19:49	2024-12-30 20:58:49	1329
2397	2024-12-30	1	19:04:28	11	Dành chỗ ngồi cho nhóm 10 người	2024-12-29 18:36:28	2024-12-30 19:07:28	1499
2398	2024-12-30	1	18:42:08	2	Yêu cầu ghế trẻ em cho bé nhỏ	2024-12-29 18:39:08	2024-12-30 18:54:08	1361
2399	2024-12-30	1	23:50:46	4	Phục vụ trà nóng thay nước lạnh cho người lớn	2024-12-29 23:12:46	2024-12-31 00:16:46	176
\.


--
-- Data for Name: cart_dish; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_dish (cart_id, dish_id, quantity) FROM stdin;
\.


--
-- Data for Name: dish; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dish (dish_name, category, dish_id, price, description, created_at, availability) FROM stdin;
Súp gà rau củ	Khai vị	1	30000	Món súp gà với nước dùng thanh ngọt, nấu từ gà thả vườn hầm kỹ, kết hợp với nấm và bắp ngọt tạo nên vị dịu nhẹ và ấm áp. Thịt gà mềm, thơm, đem lại cảm giác dễ chịu và bổ dưỡng, giúp kích thích vị giác cho bữa ăn thêm ngon miệng.	2024-11-13 22:55:33	t
Nộm gà hoa chuối	Khai vị	2	60000	Hoa chuối bào sợi giòn giòn, thịt gà xé nhỏ thấm đều gia vị, cùng với đậu phộng rang và rau thơm tạo nên một món nộm hấp dẫn. Món ăn có vị chua ngọt vừa phải, thơm lừng, kích thích vị giác, đem lại cảm giác dân dã và đậm đà cho bữa ăn.	2024-11-13 22:55:33	t
Bún rối	Món phụ	3	5000	Những sợi bún trắng ngần, mềm mại và dẻo dai, thường dùng để ăn kèm với các món nước chấm hoặc nước lèo, giúp tăng thêm hương vị và tạo cảm giác ngon miệng, dễ ăn, phù hợp trong các bữa cơm gia đình Việt.	2024-11-13 22:55:33	t
Mì tôm	Món phụ	4	5000	Mì tôm vàng óng, dai và nhanh chín, là món ăn nhanh quen thuộc và dễ chế biến. Khi kết hợp với các nguyên liệu khác như thịt, rau xanh, hay trứng, mì tôm tạo ra một bữa ăn đơn giản nhưng vẫn ngon lành, tiện lợi.	2024-11-13 22:55:33	t
Miến rong	Món phụ	5	9000	Miến rong với sợi trong suốt, dai và giòn tự nhiên, thường được chế biến trong các món nước hoặc xào. Miến rong là lựa chọn hoàn hảo cho những ai muốn một món ăn nhẹ nhàng, không gây cảm giác nặng nề nhưng vẫn no lâu.	2024-11-13 22:55:33	t
Sung muối xả ớt	Món phụ	6	10000	Sung được muối chua với hương thơm đặc trưng của xả và chút cay nhẹ từ ớt. Món sung muối giòn tan, vị chua cay dễ chịu, là món ăn kèm giúp tăng thêm phần hấp dẫn cho bữa cơm, đặc biệt khi dùng chung với thịt cá.	2024-11-13 22:55:33	t
Cà pháo 	Món phụ	7	7000	Cà pháo nhỏ nhắn, giòn rụm được muối chua với vị đậm đà vừa ăn, thường là món ăn dân dã quen thuộc. Với hương vị thơm mát, cà pháo giúp kích thích vị giác, tăng sự hấp dẫn khi ăn cùng cơm hoặc các món canh.	2024-11-13 22:55:33	t
Dưa chua	Món phụ	8	8000	Dưa chua làm từ cải bẹ xanh được muối lên men tự nhiên, có vị chua nhẹ, thơm nồng. Món dưa chua không chỉ là món ăn kèm dễ ăn, giúp giải ngán, mà còn có thể tặng hương vị thơm dịu cho các món canh độc đáo.	2024-11-13 22:55:33	t
Bánh tráng	Món phụ	9	10000	Bánh tráng mỏng và dai nhẹ, có thể được ăn kèm hoặc dùng để cuốn các loại rau, thịt. Với hương vị đơn giản nhưng thơm bùi, bánh tráng làm tăng thêm phần hấp dẫn cho các món cuốn Việt Nam, đặc biệt khi chấm kèm nước chấm đậm đà.	2024-11-13 22:55:33	t
Tóp mỡ	Món phụ	10	10000	Tóp mỡ là một món chiên vô cùng thơm ngon, được chiên ngập dầu cho đến khi vàng ruộm, giòn rụm. Với hương vị béo ngậy đặc trưng, tóp mỡ là món ăn kèm thú vị cho món cơm, hay bún.	2024-11-13 22:55:33	t
Đậu phụ rán 	Món phụ	11	5000	Đậu phụ rán vàng, lớp ngoài giòn rụm, bên trong mềm mịn, ngọt bùi, là món ăn dân dã mà hấp dẫn. Đậu phụ rán thường chấm với nước tương hoặc mắm tỏi ớt hay ăn kèm trong các món bún, đem lại cảm giác thanh đạm nhưng vẫn rất ngon miệng.	2024-11-13 22:55:33	t
Súp hải sản	Khai vị	12	35000	Súp hải sản là sự kết hợp giữa các loại hải sản tươi như tôm, cua, mực cùng với rau củ, tạo nên vị ngọt đậm đà. Nước dùng trong vắt và sánh mịn, hương vị thơm ngon hòa quyện với độ dai của hải sản, đem lại trải nghiệm tròn vị cho thực khách.	2024-11-13 22:55:33	t
Giò lụa	Món phụ	13	8000	Giò lụa được làm từ hai nguyên liệu cơ bản là thịt nạc thăn lợn giã nhuyễn kết hợp với nước mắm ngon, hương thơm nhẹ được gói trong lá chuối và luộc chín và độ giòn vừa phải. Đây là món ăn truyền thống quen thuộc trong mâm cỗ Việt, có thể ăn trực tiếp hoặc kết hợp với các món khác, mang đến hương vị hài hòa, tinh tế.	2024-11-13 22:55:33	t
Nước sấu	Đồ uống	14	15000	Nước sấu chua thanh, mát lạnh, với vị ngọt nhẹ nhàng từ sấu ngâm đường. Đây là thức uống truyền thống phổ biến, đặc biệt vào mùa hè, giúp giải nhiệt và làm mát cơ thể, mang lại cảm giác sảng khoái.	2024-11-13 22:55:33	t
Nước me	Đồ uống	15	15000	Nước me chua dịu, pha chút ngọt và hương thơm nhẹ từ me chín, là thức uống giải khát tuyệt vời cho những ngày nóng bức. Hương vị đặc trưng của me khiến món nước này có khả năng giải khát và giúp kích thích vị giác.	2024-11-13 22:55:33	t
Nước mơ	Đồ uống	16	15000	Nước mơ với vị chua ngọt, hương thơm đặc trưng của mơ ngâm, mang lại cảm giác sảng khoái. Là loại nước giải khát quen thuộc, nước mơ không chỉ ngon mà còn có tác dụng thanh nhiệt, làm dịu cơn khát hiệu quả.	2024-11-13 22:55:33	t
Nước chanh muối	Đồ uống	17	15000	Nước chanh muối có vị chua mặn vừa phải, kết hợp giữa chanh tươi và chút muối giúp bù khoáng, rất thích hợp để giải nhiệt và hỗ trợ tiêu hóa. Thức uống này giúp cơ thể hồi phục nhanh chóng trong những ngày nắng nóng hoặc sau khi vận động.	2024-11-13 22:55:33	t
Rau má đậu xanh	Đồ uống	18	20000	Rau má tươi mát kết hợp với đậu xanh bùi béo, tạo thành thức uống dinh dưỡng, tốt cho sức khỏe. Nước rau má đậu xanh không chỉ giúp thanh nhiệt mà còn có tác dụng làm mát gan, giải độc tự nhiên cho cơ thể.	2024-11-13 22:55:33	t
Trà chanh mật ong	Đồ uống	19	15000	Trà chanh mật ong với vị chua dịu của chanh và vị ngọt thanh từ mật ong, tạo nên thức uống vừa thơm ngon vừa bổ dưỡng. Đây là loại nước uống có tính kháng khuẩn cao, giúp làm dịu cổ họng và tăng cường hệ miễn dịch.	2024-11-13 22:55:33	t
Trà đào cam sả	Đồ uống	20	20000	Hương thơm nồng nàn của sả, vị ngọt từ đào và chút chua dịu từ cam, tất cả hòa quyện tạo nên ly trà đào cam sả thơm lừng, mát lạnh. Thức uống này không chỉ giải khát mà còn giúp thư giãn tinh thần, rất phù hợp để nhâm nhi.	2024-11-13 22:55:33	t
Trà atiso	Đồ uống	21	15000	Trà atiso có vị thanh mát, hơi ngọt và dịu nhẹ, là loại thức uống rất tốt cho sức khỏe, đặc biệt là gan và hệ tiêu hóa. Với màu đỏ tự nhiên đẹp mắt và hương vị dễ chịu, trà atiso thích hợp để uống mỗi ngày giúp thanh lọc cơ thể.	2024-11-13 22:55:33	t
Cà phê trứng	Đồ uống	22	25000	Cà phê trứng là món đặc sản độc đáo với lớp kem trứng béo mịn phủ lên cà phê đậm đà, tạo thành sự hòa quyện tuyệt vời giữa vị ngọt béo và vị đắng nhẹ. Thức uống này đem lại cảm giác vừa ấm áp vừa lạ miệng, thu hút nhiều thực khách yêu cà phê.	2024-11-13 22:55:33	t
Súp bào ngư vi cá	Khai vị	23	100000	Là món súp cao cấp, bào ngư và vi cá được ninh chín mềm trong nước dùng đậm đà từ xương, kết hợp cùng các loại gia vị tinh tế. Vị ngọt thanh và hậu vị béo ngậy từ bào ngư vi cá khiến món ăn này trở nên sang trọng, bổ dưỡng, thích hợp cho những buổi tiệc trang trọng.	2024-11-13 22:55:33	t
Cà phê muối	Đồ uống	24	20000	Cà phê muối có sự kết hợp tinh tế giữa cà phê đậm đà và chút muối mặn, giúp làm nổi bật hương vị tự nhiên của cà phê. Đây là món uống mang đến trải nghiệm mới mẻ với vị đắng nhẹ nhàng, hậu vị dịu ngọt, rất độc đáo.	2024-11-13 22:55:33	t
Rượu ngô	Đồ uống	25	120000	Rượu ngô với hương thơm đặc trưng từ ngô được ủ lâu, mang lại vị ngọt dịu, đậm đà của miền núi phía Bắc. Là loại rượu truyền thống, rượu ngô thường có nồng độ nhẹ, dễ uống và rất được ưa chuộng trong các dịp lễ hội.	2024-11-13 22:55:33	t
Rượu mơ	Đồ uống	26	150000	Rượu mơ thơm dịu, có vị chua ngọt đặc trưng của mơ ngâm, là loại rượu nhẹ nhàng dễ uống. Món rượu này thường dùng trong các bữa tiệc để khai vị hoặc uống thư giãn, rất được yêu thích bởi hương vị đặc trưng và dịu nhẹ.	2024-11-13 22:55:33	t
Bia hơi	Đồ uống	27	15000	Bia hơi có màu vàng nhạt, bọt mịn, vị đắng nhẹ, là loại bia quen thuộc của người Việt, đặc biệt phổ biến trong các buổi tụ tập bạn bè. Bia hơi mát lạnh và dễ uống, thích hợp cho những buổi gặp gỡ thư giãn, tạo không khí vui tươi và gần gũi.	2024-11-13 22:55:33	t
Bún chả	Món chính	28	50000		2024-11-13 22:55:33	t
Bánh đa cua	Món chính	29	50000		2024-11-13 22:55:33	t
Phở bò	Món chính	30	50000		2024-11-13 22:55:33	t
Gỏi cá mè	Món chính	31	70000		2024-11-13 22:55:33	t
Chả mực Hạ Long	Món chính	32	100000		2024-11-13 22:55:33	t
Thịt trâu gác	Món chính	33	150000		2024-11-13 22:55:33	t
Súp kem nấm	Khai vị	34	35000	Súp kem nấm với hương vị ngọt dịu, béo ngậy từ kem tươi, kết hợp cùng nấm tươi giòn ngọt tạo nên món khai vị hấp dẫn. Vị thơm đặc trưng từ nấm và độ sánh mịn của súp khiến món ăn trở nên thanh lịch và dễ chịu, phù hợp với mọi thực khách.	2024-11-13 22:55:33	t
Ốc suối hấp	Món chính	35	100000		2024-11-13 22:55:33	t
Bánh tráng cuốn thịt heo	Món chính	36	70000		2024-11-13 22:55:33	t
Phở khô	Món chính	37	50000		2024-11-13 22:55:33	t
Gỏi cá đục	Món chính	38	100000		2024-11-13 22:55:33	t
Nem nướng Ninh Hòa	Món chính	39	100000		2024-11-13 22:55:33	t
Súp lươn	Món chính	40	70000		2024-11-13 22:55:33	t
Bánh căn	Món chính	41	50000		2024-11-13 22:55:33	t
Cá ngừ đại dương	Món chính	42	200000		2024-11-13 22:55:33	t
Mì Quảng	Món chính	43	80000		2024-11-13 22:55:33	t
Bún bò	Món chính	44	70000		2024-11-13 22:55:33	t
Gỏi ngó sen tôm thịt	Khai vị	45	80000	Món gỏi ngó sen tôm thịt là sự hòa quyện của ngó sen giòn tươi, tôm ngọt và thịt heo mềm, tất cả thấm đều trong nước mắm chua ngọt đậm đà. Món gỏi này đem lại cảm giác thanh mát và hài hòa, khơi dậy vị giác và chuẩn bị cho các món ăn tiếp theo.	2024-11-13 22:55:33	t
Bánh khọt	Món chính	46	50000		2024-11-13 22:55:33	t
Bún bò cay	Món chính	47	70000		2024-11-13 22:55:33	t
Cơm trái dừa	Món chính	48	150000		2024-11-13 22:55:33	t
Vịt nấu chao	Món chính	49	100000		2024-11-13 22:55:33	t
Bò tơ Củ Chi	Món chính	50	150000		2024-11-13 22:55:33	t
Hủ tiếu Mỹ Tho	Món chính	51	80000		2024-11-13 22:55:33	t
Gỏi cá trích	Món chính	52	70000		2024-11-13 22:55:33	t
Gỏi bò ngũ sắc	Khai vị	53	65000	Với nguyên liệu đa dạng từ rau củ nhiều màu sắc như ớt chuông, cà rốt, dưa leo cùng thịt bò mềm dai, món gỏi bò ngũ sắc không chỉ bắt mắt mà còn rất ngon miệng. Gia vị chua ngọt làm món ăn dậy vị, tươi mát và đầy đủ dưỡng chất.	2024-11-13 22:55:33	t
Nộm bò khô đu đủ	Khai vị	54	70000	Đu đủ bào sợi giòn ngọt, kết hợp với bò khô dai thơm, thêm ít rau thơm và đậu phộng rang, tất cả được trộn đều với nước sốt chua ngọt độc đáo. Món nộm này là sự kết hợp hài hòa giữa vị giòn, ngọt, chua cay nhẹ, tạo cảm giác vui miệng khi thưởng thức.	2024-11-13 22:55:33	t
Nộm sứa	Khai vị	55	90000	Món nộm sứa tươi mát với sứa giòn sần sật, kèm theo các loại rau thơm, cà rốt, dưa chuột và hành tím. Nước mắm pha chua ngọt tạo nên hương vị thanh mát, hấp dẫn, rất thích hợp cho những ai muốn khởi đầu bữa ăn nhẹ nhàng và tươi mới.	2024-11-13 22:55:33	t
Nộm rau muống	Khai vị	56	50000	Rau muống non được trộn đều với các gia vị chua ngọt, tạo nên một món nộm giòn tan và dễ ăn. Với hương vị đặc trưng của rau muống cùng chút cay từ ớt và đậm đà của nước mắm, món nộm này là lựa chọn hoàn hảo cho thực khách yêu thích sự giản dị.	2024-11-13 22:55:33	t
\.


--
-- Data for Name: order_dish; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_dish (order_id, dish_id, quantity) FROM stdin;
1	42	5
1	31	3
1	37	3
1	32	3
1	11	2
1	9	2
1	34	2
1	14	2
2	33	2
2	52	2
2	29	4
2	49	3
2	7	2
2	11	2
2	12	2
2	54	1
2	26	4
2	20	2
2	16	2
3	28	1
3	40	4
3	6	1
3	10	2
3	45	1
3	53	1
3	14	2
3	22	2
4	41	2
4	43	1
4	51	2
4	29	1
4	30	4
4	7	1
4	12	2
4	34	1
5	29	1
5	36	1
5	41	1
5	43	3
5	6	2
5	4	2
5	55	1
5	56	1
5	22	2
6	44	2
6	50	2
6	47	2
6	39	1
6	42	2
6	13	1
6	4	2
6	12	1
6	18	2
7	40	5
7	44	2
7	38	4
7	30	1
7	11	2
7	10	2
7	54	2
7	15	4
8	48	1
8	43	1
8	9	1
8	3	1
8	53	2
8	21	2
9	38	3
9	36	4
9	52	3
9	9	1
9	8	1
9	45	2
9	19	4
9	18	4
9	17	4
10	39	1
10	28	2
10	29	1
10	4	2
10	6	1
10	53	1
10	56	2
11	32	1
11	48	1
11	35	2
11	44	1
11	11	1
11	8	2
11	34	2
11	15	4
11	20	4
12	35	3
12	42	2
12	3	1
12	34	1
12	2	1
13	35	2
13	47	1
13	48	2
13	13	1
13	1	1
13	2	2
14	43	2
14	29	1
14	39	5
14	49	3
14	10	1
14	9	2
14	34	2
14	20	2
15	52	3
15	29	3
15	33	1
15	41	4
15	6	1
15	56	1
15	19	2
16	50	1
16	48	3
16	47	3
16	4	1
16	12	2
16	14	2
17	30	1
17	52	1
17	6	2
17	1	1
17	26	2
17	21	2
17	14	2
18	40	3
18	28	1
18	10	1
18	12	2
18	14	4
19	44	3
19	51	3
19	40	2
19	6	1
19	2	2
19	16	4
19	27	4
20	38	2
20	40	2
20	46	2
20	35	3
20	48	1
20	9	2
20	3	2
20	55	2
20	19	4
20	27	2
20	21	4
21	29	2
21	38	3
21	4	2
21	6	2
21	2	1
21	12	2
22	48	3
22	38	3
22	37	2
22	13	1
22	1	1
22	24	4
22	27	4
22	20	2
23	28	3
23	41	2
23	5	2
23	13	2
23	54	1
23	34	1
23	22	4
23	20	4
24	44	4
24	35	3
24	7	1
24	5	2
24	23	1
24	16	2
25	43	2
25	46	4
25	13	1
25	54	2
25	25	2
26	52	3
26	46	4
26	48	2
26	7	1
26	9	1
26	55	1
26	1	2
27	48	4
27	31	4
27	47	4
27	33	1
27	3	2
27	10	1
27	12	1
28	43	5
28	51	4
28	29	2
28	39	3
28	47	1
28	5	2
28	45	2
28	16	4
28	15	2
28	20	2
29	39	4
29	36	4
29	29	2
29	33	1
29	11	1
29	4	2
29	53	2
29	20	2
30	48	2
30	32	5
30	6	2
30	34	2
30	21	4
31	37	2
31	32	2
31	13	1
31	1	1
31	2	1
31	17	4
32	31	3
32	36	4
32	3	2
32	34	2
32	27	4
32	21	4
32	19	4
33	30	3
33	43	2
33	39	4
33	7	1
33	3	1
33	54	2
33	55	1
33	24	2
34	39	4
34	50	2
34	31	3
34	49	3
34	36	1
34	5	1
34	34	1
34	55	2
34	27	2
35	42	1
35	39	3
35	29	1
35	3	1
35	11	1
35	55	1
35	16	4
35	17	4
35	25	4
36	32	5
36	31	4
36	5	1
36	34	1
36	55	2
36	21	4
36	24	4
36	15	2
37	42	1
37	49	4
37	39	3
37	50	2
37	11	1
37	8	1
37	34	1
37	54	2
37	24	4
37	19	2
38	40	1
38	35	2
38	5	1
38	23	1
38	19	4
39	36	5
39	44	1
39	47	1
39	10	2
39	12	2
39	56	1
39	25	2
40	37	1
40	32	1
40	10	2
40	54	2
40	2	1
40	20	4
40	19	4
40	25	2
41	38	1
41	48	1
41	3	1
41	10	2
41	53	2
41	17	2
41	18	2
41	15	2
42	44	1
42	39	2
42	10	2
42	53	2
42	27	4
43	39	2
43	50	2
43	10	1
43	1	2
43	22	4
43	16	2
44	52	5
44	46	2
44	31	1
44	35	1
44	40	4
44	13	2
44	3	2
44	2	2
44	25	2
44	16	2
45	31	4
45	49	4
45	50	3
45	30	2
45	51	4
45	3	1
45	4	1
45	45	2
46	30	3
46	52	2
46	44	2
46	9	1
46	34	2
46	54	1
46	25	2
46	20	4
47	35	1
47	36	2
47	51	2
47	49	3
47	5	2
47	2	2
47	21	4
48	46	2
48	40	3
48	6	2
48	55	1
49	47	2
49	38	2
49	4	1
49	12	2
49	55	1
49	19	2
49	21	4
50	30	4
50	33	1
50	28	1
50	44	5
50	11	1
50	34	2
51	28	3
51	42	1
51	51	3
51	38	1
51	11	1
51	8	2
51	23	2
51	2	1
52	28	2
52	32	2
52	10	2
52	1	2
52	53	1
52	25	2
52	26	2
52	15	4
53	33	4
53	36	3
53	4	1
53	55	1
53	56	1
53	20	4
53	24	2
53	18	2
54	31	3
54	52	3
54	35	4
54	11	1
54	7	1
54	53	1
54	2	1
54	26	4
54	18	4
55	29	1
55	41	4
55	44	3
55	48	2
55	3	1
55	11	2
55	45	2
55	16	4
56	48	2
56	42	1
56	46	2
56	49	1
56	43	4
56	5	2
56	10	1
56	23	2
56	12	2
57	37	1
57	51	1
57	28	2
57	50	1
57	30	3
57	13	2
57	34	2
57	14	2
58	52	3
58	38	1
58	30	3
58	8	2
58	6	1
58	34	1
58	23	2
58	24	4
58	19	4
58	25	2
59	38	2
59	30	1
59	39	2
59	28	5
59	8	1
59	56	1
59	18	2
59	25	4
59	17	4
60	33	2
60	50	1
60	32	2
60	37	2
60	41	3
60	13	1
60	56	2
60	27	2
60	20	2
61	31	3
61	44	2
61	6	2
61	45	2
61	15	4
61	16	4
61	14	4
62	44	1
62	35	2
62	39	3
62	38	2
62	11	2
62	8	1
62	23	1
62	16	4
62	25	2
63	35	4
63	43	1
63	31	1
63	5	1
63	3	2
63	53	2
63	23	2
63	19	4
64	35	1
64	43	3
64	32	4
64	6	2
64	11	2
64	2	1
64	14	2
65	30	1
65	28	2
65	6	1
65	45	1
65	2	2
65	26	2
66	35	2
66	30	1
66	33	2
66	49	2
66	32	3
66	9	1
66	45	2
66	12	2
66	27	4
66	22	2
66	19	2
67	46	2
67	50	5
67	40	1
67	35	1
67	47	2
67	8	2
67	4	2
67	53	1
67	56	2
67	20	2
67	24	2
67	14	2
68	44	4
68	28	4
68	33	4
68	38	1
68	32	2
68	4	2
68	54	1
68	19	2
68	26	4
69	49	1
69	29	2
69	13	2
69	2	1
69	45	2
70	43	1
70	46	3
70	52	2
70	3	2
70	1	2
71	41	1
71	32	3
71	33	2
71	3	2
71	1	2
71	45	1
71	15	4
71	19	4
72	30	4
72	47	3
72	49	1
72	44	3
72	37	4
72	11	1
72	13	1
72	1	1
73	38	1
73	48	2
73	9	1
73	8	2
73	12	1
73	23	1
73	14	2
74	36	1
74	37	2
74	48	3
74	43	3
74	40	2
74	4	2
74	7	2
74	34	1
74	2	1
74	22	4
74	20	2
74	27	4
75	43	4
75	30	5
75	9	1
75	34	1
75	20	2
75	19	4
76	39	1
76	31	3
76	30	1
76	38	2
76	51	2
76	6	1
76	11	2
76	45	1
77	42	3
77	49	3
77	36	3
77	6	2
77	53	2
77	1	2
77	19	2
77	25	2
78	47	2
78	38	1
78	31	2
78	35	1
78	32	1
78	7	1
78	34	1
78	55	1
78	21	2
79	30	4
79	52	1
79	36	2
79	28	4
79	9	2
79	6	2
79	53	2
79	12	1
79	21	4
79	26	4
80	49	4
80	50	4
80	37	4
80	10	1
80	45	1
80	54	2
80	22	4
80	25	4
81	35	2
81	51	2
81	52	4
81	10	2
81	54	1
81	1	1
81	21	2
82	52	1
82	31	1
82	3	2
82	9	1
82	12	1
82	15	4
82	24	2
83	29	3
83	43	2
83	7	2
83	34	2
83	12	2
83	20	2
84	46	2
84	40	2
84	33	2
84	41	3
84	11	2
84	3	1
84	23	2
84	34	1
84	24	4
84	26	2
84	17	4
85	49	1
85	30	2
85	29	1
85	38	2
85	50	3
85	4	1
85	45	2
85	56	2
85	16	2
85	20	4
86	33	1
86	31	1
86	42	3
86	11	2
86	7	2
86	2	1
86	26	4
86	14	2
87	47	4
87	30	1
87	41	1
87	7	1
87	11	2
87	34	2
87	20	4
88	42	2
88	43	5
88	33	3
88	30	1
88	13	1
88	34	1
88	54	2
88	18	4
88	20	2
88	26	4
89	46	1
89	43	4
89	39	4
89	9	2
89	6	2
89	34	2
89	56	2
89	16	4
89	19	4
89	24	2
90	46	3
90	42	3
90	30	3
90	41	1
90	4	2
90	45	1
90	16	4
90	24	4
90	21	2
91	41	2
91	50	2
91	32	1
91	52	5
91	6	2
91	2	2
91	26	2
91	14	4
92	44	5
92	50	2
92	29	2
92	7	2
92	2	2
92	12	2
92	22	2
92	24	4
92	15	4
93	35	1
93	49	1
93	43	5
93	44	1
93	9	2
93	10	2
93	1	2
93	45	2
94	50	1
94	51	4
94	5	2
94	9	1
94	23	1
94	45	1
94	25	4
94	18	4
95	51	1
95	44	2
95	39	1
95	36	1
95	47	3
95	10	1
95	6	2
95	45	2
95	2	2
95	22	4
96	32	3
96	48	3
96	9	2
96	6	1
96	23	1
96	54	1
96	18	2
96	14	4
97	36	2
97	31	2
97	13	1
97	34	2
97	14	2
98	49	4
98	37	1
98	29	1
98	52	2
98	11	1
98	8	1
98	23	2
98	56	2
98	26	2
98	18	4
99	41	5
99	37	4
99	43	1
99	39	1
99	8	1
99	7	1
99	23	2
99	12	1
99	20	2
100	46	5
100	28	1
100	5	2
100	4	1
100	55	2
100	14	2
101	29	2
101	38	2
101	44	3
101	51	2
101	3	1
101	45	2
101	24	2
101	22	4
101	16	2
102	41	2
102	42	4
102	46	1
102	31	4
102	47	4
102	13	1
102	5	2
102	2	2
103	41	3
103	36	4
103	31	2
103	33	1
103	3	2
103	23	1
103	21	4
104	42	1
104	43	1
104	49	2
104	4	1
104	9	1
104	53	2
104	34	1
105	41	3
105	52	3
105	50	2
105	44	2
105	47	2
105	9	1
105	10	2
105	34	1
105	14	2
105	25	2
105	20	2
106	44	1
106	43	1
106	9	1
106	56	2
106	23	1
106	25	4
106	17	4
107	37	5
107	38	1
107	3	1
107	45	1
107	12	2
108	46	1
108	29	3
108	30	3
108	39	4
108	7	2
108	6	2
108	53	2
108	2	1
109	36	4
109	35	3
109	29	1
109	41	1
109	38	2
109	5	2
109	53	2
109	45	2
109	20	2
109	27	2
110	33	1
110	50	3
110	38	2
110	49	4
110	6	1
110	4	1
110	12	1
110	55	1
110	25	4
111	40	5
111	47	3
111	32	3
111	9	1
111	2	2
111	20	2
111	19	4
111	25	4
112	40	2
112	39	3
112	51	2
112	33	3
112	7	2
112	56	1
112	2	2
112	20	2
112	27	4
112	15	2
113	43	3
113	39	1
113	33	1
113	10	2
113	54	1
113	1	1
113	22	4
113	25	2
114	52	3
114	38	4
114	50	1
114	43	1
114	44	1
114	5	2
114	3	2
114	23	2
114	45	2
114	24	4
114	14	4
114	18	2
115	28	3
115	50	2
115	52	4
115	10	2
115	8	1
115	45	2
115	20	4
115	17	4
115	27	2
116	35	5
116	52	4
116	10	2
116	53	1
116	19	2
117	47	1
117	48	1
117	44	1
117	33	1
117	7	1
117	6	2
117	56	2
117	22	2
117	21	2
117	25	2
118	38	2
118	35	2
118	32	3
118	31	1
118	4	2
118	12	1
118	19	2
119	30	5
119	42	2
119	41	2
119	28	4
119	44	4
119	13	2
119	34	2
119	16	4
119	27	4
119	21	2
120	35	2
120	46	1
120	9	2
120	8	1
120	12	1
121	42	2
121	50	2
121	5	1
121	55	1
122	50	4
122	48	1
122	7	1
122	34	2
122	53	2
122	27	4
123	33	1
123	39	4
123	46	4
123	5	2
123	11	2
123	23	2
123	34	1
123	27	4
123	22	4
124	28	4
124	48	5
124	11	1
124	3	2
124	56	2
124	12	2
124	21	2
124	24	4
125	41	1
125	37	3
125	10	1
125	53	2
126	36	2
126	43	2
126	5	1
126	8	2
126	56	2
126	21	4
127	32	1
127	43	1
127	36	4
127	52	1
127	46	2
127	13	1
127	53	2
127	24	4
127	26	2
128	47	3
128	29	3
128	44	4
128	46	3
128	48	1
128	11	2
128	3	1
128	54	2
128	24	4
128	15	4
129	28	4
129	51	5
129	52	2
129	35	3
129	7	1
129	12	1
129	19	2
129	16	2
130	42	3
130	50	1
130	13	2
130	12	1
131	39	4
131	41	4
131	49	3
131	32	2
131	3	1
131	56	2
131	1	1
131	17	2
131	21	4
131	25	2
132	38	4
132	49	3
132	28	2
132	42	1
132	52	3
132	10	1
132	45	2
132	53	2
132	27	4
132	19	2
133	47	1
133	43	4
133	29	1
133	51	2
133	39	1
133	3	2
133	5	2
133	2	2
133	24	4
133	27	2
134	32	4
134	40	4
134	29	4
134	50	5
134	52	3
134	13	1
134	2	2
134	14	2
135	47	2
135	40	2
135	13	2
135	5	1
135	45	2
135	54	2
135	19	4
136	50	1
136	46	5
136	32	4
136	8	1
136	4	1
136	45	1
137	48	2
137	41	4
137	43	2
137	46	4
137	5	1
137	45	2
137	54	2
138	39	2
138	49	4
138	28	5
138	36	1
138	5	2
138	54	1
138	24	2
138	22	2
139	32	1
139	41	5
139	13	1
139	55	2
139	53	2
139	18	4
139	22	4
139	21	2
140	31	3
140	29	3
140	50	1
140	11	1
140	7	1
140	23	2
141	35	5
141	28	1
141	6	1
141	8	2
141	54	1
141	14	2
142	48	5
142	28	4
142	39	3
142	49	1
142	32	2
142	7	2
142	55	1
142	56	2
142	17	4
142	18	4
142	20	4
143	44	2
143	33	3
143	39	4
143	43	2
143	35	4
143	13	1
143	12	2
143	45	1
143	27	4
143	25	4
143	15	2
144	37	2
144	32	3
144	30	2
144	52	1
144	11	2
144	5	2
144	55	1
144	54	2
145	42	1
145	41	5
145	49	4
145	33	3
145	43	2
145	8	1
145	10	2
145	1	2
145	20	2
145	22	2
146	42	2
146	36	1
146	46	1
146	48	2
146	3	1
146	45	1
147	38	5
147	46	1
147	31	2
147	8	2
147	56	1
147	34	1
147	14	4
147	25	2
148	31	1
148	52	1
148	43	4
148	5	2
148	34	2
148	19	4
148	21	4
148	17	2
149	31	2
149	38	1
149	30	1
149	5	1
149	4	2
149	2	2
149	45	1
149	21	2
149	20	2
149	26	4
150	50	1
150	40	1
150	49	1
150	33	3
150	10	2
150	54	1
150	2	1
150	21	2
150	18	2
150	20	4
151	31	3
151	33	4
151	43	4
151	28	3
151	35	3
151	6	2
151	34	2
151	56	1
151	18	4
151	22	4
151	21	4
152	36	3
152	49	1
152	42	3
152	6	2
152	8	2
152	23	2
152	20	2
153	48	1
153	44	1
153	46	5
153	51	1
153	3	2
153	2	1
153	56	2
153	20	2
154	44	5
154	42	1
154	46	1
154	28	1
154	32	2
154	3	2
154	11	2
154	34	1
154	2	1
154	22	2
154	20	2
155	38	1
155	36	3
155	30	3
155	37	3
155	10	1
155	8	2
155	2	2
156	29	1
156	44	1
156	37	5
156	36	3
156	6	1
156	56	2
156	55	2
157	42	4
157	51	4
157	47	2
157	35	1
157	50	1
157	13	2
157	34	2
157	1	1
157	22	4
158	43	1
158	46	3
158	38	4
158	37	4
158	11	2
158	12	1
158	25	2
158	27	2
159	35	1
159	32	1
159	5	2
159	13	2
159	56	2
159	16	2
159	19	2
159	17	2
160	49	2
160	35	2
160	33	3
160	44	1
160	7	2
160	34	2
160	45	2
160	24	2
160	25	2
161	28	3
161	37	3
161	30	2
161	42	4
161	5	1
161	23	2
161	34	2
161	27	4
162	40	5
162	33	4
162	41	1
162	4	2
162	53	2
162	55	1
163	39	1
163	40	2
163	28	2
163	6	1
163	1	2
163	2	2
163	16	2
164	37	1
164	29	4
164	46	1
164	4	1
164	53	1
164	23	2
164	22	2
165	35	2
165	40	2
165	5	2
165	13	1
165	54	2
165	15	2
166	35	1
166	29	1
166	6	1
166	54	2
166	25	4
166	17	2
166	27	2
167	43	4
167	44	4
167	13	1
167	53	2
167	1	2
167	16	2
168	42	3
168	32	1
168	50	1
168	43	4
168	52	4
168	11	2
168	55	2
168	24	4
168	17	2
168	18	2
169	33	5
169	38	2
169	43	2
169	6	2
169	4	1
169	55	2
169	53	1
170	49	3
170	30	2
170	42	4
170	31	4
170	8	2
170	5	2
170	12	2
170	16	4
170	27	2
170	15	4
171	29	2
171	30	1
171	4	1
171	12	1
172	43	1
172	39	1
172	36	4
172	29	1
172	37	5
172	6	2
172	10	1
172	23	1
172	18	2
173	29	2
173	39	4
173	46	4
173	35	2
173	41	3
173	13	2
173	5	1
173	54	1
173	53	2
173	15	4
174	44	2
174	42	3
174	6	1
174	13	1
174	45	1
174	26	4
175	28	4
175	38	1
175	46	2
175	8	1
175	34	2
175	18	2
175	20	4
175	17	2
176	51	3
176	47	1
176	43	2
176	5	2
176	6	1
176	1	2
176	2	1
176	18	4
176	21	4
177	30	2
177	47	1
177	32	3
177	37	1
177	4	1
177	55	2
177	25	2
177	20	2
177	21	2
178	36	2
178	47	3
178	52	1
178	6	2
178	54	2
178	56	1
178	24	4
179	39	2
179	48	2
179	41	4
179	9	1
179	23	1
179	45	1
179	14	2
179	21	2
179	17	2
180	39	4
180	30	3
180	50	1
180	37	5
180	5	1
180	53	1
180	54	2
180	14	4
180	24	2
181	46	3
181	30	3
181	38	3
181	3	1
181	8	2
181	12	2
181	56	1
181	22	2
182	49	2
182	37	2
182	40	1
182	31	3
182	44	1
182	5	2
182	4	2
182	54	1
183	46	3
183	39	1
183	37	2
183	4	1
183	2	1
183	1	1
184	39	5
184	42	2
184	6	1
184	56	2
184	23	1
184	19	4
185	36	4
185	30	2
185	40	3
185	38	5
185	46	2
185	7	1
185	53	2
186	36	2
186	41	3
186	44	4
186	30	2
186	47	2
186	4	2
186	1	1
186	56	1
186	26	4
187	36	1
187	37	5
187	41	4
187	7	2
187	12	2
187	55	2
187	21	2
188	33	3
188	36	1
188	35	4
188	42	3
188	11	1
188	9	1
188	45	1
188	17	2
189	30	4
189	32	3
189	28	2
189	33	1
189	52	1
189	7	1
189	3	1
189	45	2
189	15	2
189	16	2
190	47	1
190	37	1
190	51	1
190	4	1
190	55	2
190	53	1
191	29	1
191	50	1
191	30	3
191	48	2
191	10	1
191	8	2
191	55	2
192	52	1
192	28	1
192	37	1
192	43	5
192	35	4
192	9	1
192	11	1
192	55	1
193	42	4
193	48	2
193	31	1
193	3	2
193	8	2
193	55	2
193	23	1
194	43	3
194	46	2
194	11	2
194	8	2
194	1	2
194	54	1
194	24	2
194	17	2
194	21	4
195	52	2
195	40	2
195	51	1
195	3	1
195	1	1
195	17	4
195	25	4
196	36	5
196	49	3
196	50	2
196	35	1
196	3	1
196	4	1
196	45	2
197	52	4
197	39	5
197	13	1
197	6	2
197	2	1
197	1	2
198	38	4
198	35	2
198	42	1
198	46	3
198	5	2
198	2	2
198	14	4
198	25	2
198	18	4
199	31	2
199	35	4
199	52	2
199	48	2
199	44	4
199	7	1
199	10	2
199	55	1
199	45	2
200	41	3
200	50	2
200	52	1
200	51	4
200	29	5
200	5	2
200	6	1
200	45	2
200	25	4
200	22	2
200	18	2
201	50	2
201	48	2
201	9	2
201	10	1
201	45	1
201	16	2
201	21	4
202	44	1
202	28	3
202	37	3
202	3	2
202	34	1
202	45	1
202	16	4
202	21	4
203	43	1
203	29	2
203	13	2
203	1	1
203	34	1
203	17	2
203	21	2
204	51	1
204	42	3
204	43	1
204	32	2
204	37	5
204	11	2
204	5	1
204	55	1
205	37	2
205	32	2
205	39	1
205	29	3
205	38	2
205	5	2
205	1	2
205	18	2
205	21	2
206	37	1
206	52	2
206	35	2
206	36	1
206	40	2
206	7	2
206	10	1
206	45	1
206	22	2
206	14	2
207	47	2
207	40	1
207	6	2
207	4	2
207	53	2
207	54	1
207	25	4
207	22	2
208	33	1
208	39	1
208	31	3
208	5	2
208	1	2
208	23	1
208	19	2
209	30	4
209	48	1
209	39	1
209	35	4
209	43	3
209	13	2
209	34	2
209	2	1
209	17	2
210	50	2
210	37	3
210	6	1
210	56	1
210	54	1
210	21	4
210	26	2
211	49	1
211	48	5
211	35	2
211	7	1
211	53	1
211	45	2
211	26	4
211	19	2
211	25	4
212	39	2
212	49	1
212	33	2
212	3	2
212	9	2
212	54	2
213	52	1
213	46	1
213	40	1
213	11	2
213	10	2
213	12	1
213	56	1
213	16	2
213	27	4
214	50	2
214	37	3
214	35	3
214	6	2
214	9	2
214	34	2
214	54	2
214	24	4
214	27	4
214	22	2
215	35	1
215	46	2
215	44	2
215	47	1
215	38	4
215	9	2
215	56	2
215	16	4
215	26	4
215	21	2
216	47	2
216	37	1
216	38	2
216	11	1
216	10	2
216	53	1
216	20	4
216	26	4
216	27	4
217	29	1
217	43	4
217	28	3
217	40	3
217	48	3
217	9	1
217	12	2
218	30	3
218	41	3
218	35	1
218	8	1
218	10	1
218	12	2
218	54	1
218	16	4
219	33	1
219	47	3
219	35	2
219	29	4
219	3	1
219	9	1
219	45	2
219	1	2
220	32	1
220	30	1
220	13	1
220	56	1
220	45	2
220	27	2
220	21	2
221	42	2
221	36	3
221	50	2
221	28	2
221	29	1
221	7	2
221	11	2
221	12	1
221	16	4
221	22	2
221	14	4
222	30	3
222	46	1
222	33	5
222	35	1
222	6	2
222	4	2
222	56	2
222	26	4
222	27	2
223	52	4
223	44	3
223	46	1
223	6	2
223	8	1
223	54	1
223	56	1
223	26	2
224	46	2
224	42	1
224	37	5
224	11	2
224	23	1
224	53	2
225	46	4
225	41	3
225	7	1
225	54	1
225	22	4
225	26	2
225	20	2
226	36	2
226	29	2
226	35	2
226	32	2
226	4	1
226	45	2
226	16	4
227	37	1
227	40	1
227	31	1
227	9	2
227	11	2
227	23	2
227	56	1
227	22	2
227	20	4
227	25	4
228	43	4
228	32	3
228	6	2
228	54	1
228	27	2
228	25	4
228	17	4
229	36	1
229	40	1
229	30	3
229	49	1
229	38	4
229	4	2
229	56	2
229	27	2
230	38	1
230	41	3
230	42	3
230	47	1
230	50	2
230	10	2
230	53	2
230	12	1
230	21	2
230	19	4
231	38	2
231	42	1
231	37	1
231	41	1
231	43	4
231	10	1
231	8	1
231	34	2
231	19	2
232	52	2
232	28	2
232	33	1
232	51	3
232	36	2
232	7	2
232	23	2
232	45	1
232	21	4
232	25	2
233	35	2
233	44	3
233	36	3
233	42	3
233	5	2
233	1	2
233	55	2
234	52	4
234	41	2
234	48	2
234	47	2
234	43	4
234	10	2
234	2	2
234	21	4
234	22	4
234	25	4
235	51	2
235	29	1
235	9	2
235	4	1
235	53	1
235	56	1
235	15	2
236	52	2
236	40	1
236	39	1
236	8	1
236	5	2
236	45	2
236	12	1
236	15	2
236	19	4
237	30	1
237	41	1
237	29	1
237	42	2
237	7	2
237	8	2
237	34	2
237	1	2
237	14	4
237	27	4
238	46	3
238	37	2
238	5	1
238	2	1
238	23	1
239	39	2
239	40	4
239	41	3
239	29	2
239	36	5
239	6	2
239	56	1
239	19	4
239	17	4
240	50	3
240	30	1
240	33	2
240	52	1
240	36	1
240	5	1
240	13	1
240	56	2
240	17	2
240	16	2
240	25	4
241	47	2
241	50	1
241	31	1
241	44	4
241	43	3
241	3	2
241	8	1
241	56	2
241	14	4
241	26	2
241	20	4
242	46	1
242	52	3
242	30	2
242	35	1
242	51	2
242	6	1
242	13	1
242	53	1
242	24	4
243	40	2
243	42	2
243	41	4
243	32	3
243	7	1
243	5	2
243	45	2
243	34	2
243	17	2
243	22	4
243	24	2
244	50	1
244	49	2
244	48	2
244	32	2
244	7	1
244	9	1
244	12	2
245	51	1
245	36	3
245	37	1
245	8	2
245	23	1
245	55	1
246	52	3
246	49	2
246	48	1
246	29	2
246	30	2
246	6	1
246	5	2
246	1	2
246	53	2
247	52	2
247	35	5
247	47	5
247	41	1
247	13	2
247	2	2
248	43	3
248	48	3
248	40	4
248	5	2
248	13	2
248	2	2
248	53	1
249	31	1
249	44	4
249	36	5
249	30	4
249	5	2
249	34	1
249	14	4
249	21	2
250	40	4
250	36	4
250	50	2
250	51	2
250	44	4
250	7	1
250	11	1
250	53	1
250	2	2
250	19	4
250	27	4
250	20	4
251	47	2
251	50	1
251	29	1
251	6	2
251	9	1
251	1	1
251	53	1
251	25	2
251	19	2
251	17	4
252	39	3
252	51	5
252	29	2
252	28	2
252	13	2
252	9	1
252	23	2
252	54	1
252	21	4
252	27	2
253	39	1
253	33	1
253	32	1
253	28	5
253	4	1
253	3	1
253	54	1
253	22	4
254	44	5
254	50	3
254	36	1
254	49	2
254	48	1
254	13	2
254	2	2
255	50	4
255	32	1
255	43	4
255	40	2
255	4	2
255	2	2
255	25	2
255	15	4
256	33	4
256	30	2
256	41	1
256	11	2
256	9	2
256	34	1
256	1	1
256	25	2
257	47	2
257	30	5
257	5	2
257	4	1
257	34	2
257	27	2
258	36	1
258	28	2
258	48	3
258	13	2
258	4	2
258	2	1
258	23	1
258	19	2
258	27	4
259	35	2
259	43	1
259	7	1
259	6	2
259	34	1
259	24	2
259	17	4
260	42	1
260	38	4
260	50	2
260	44	2
260	48	4
260	11	2
260	23	1
260	55	2
260	24	4
260	15	4
260	16	2
261	37	2
261	44	3
261	13	2
261	12	2
261	55	1
261	16	2
262	52	1
262	43	5
262	8	1
262	12	2
262	17	4
263	29	1
263	51	2
263	44	4
263	48	2
263	5	1
263	7	1
263	2	2
263	23	1
263	16	4
263	20	4
263	21	2
264	49	2
264	44	4
264	29	2
264	6	2
264	55	2
265	44	1
265	39	3
265	32	3
265	3	2
265	34	2
266	28	3
266	49	2
266	51	1
266	32	1
266	40	1
266	3	2
266	23	2
266	55	1
266	22	4
266	17	4
267	31	2
267	29	1
267	43	2
267	36	1
267	28	1
267	7	2
267	11	2
267	55	1
267	22	4
267	27	4
267	21	4
268	33	1
268	28	1
268	42	2
268	35	2
268	51	3
268	6	2
268	5	2
268	55	2
268	34	2
268	19	2
269	46	4
269	37	3
269	52	1
269	13	2
269	6	1
269	56	1
269	24	2
270	46	2
270	43	2
270	13	2
270	23	1
270	17	4
271	29	2
271	44	4
271	33	3
271	47	5
271	49	2
271	5	1
271	1	1
272	48	1
272	47	1
272	35	3
272	46	2
272	40	2
272	3	1
272	55	2
273	30	1
273	50	3
273	38	1
273	47	1
273	52	4
273	5	1
273	45	1
273	53	1
273	24	4
274	44	2
274	47	1
274	39	3
274	48	4
274	49	1
274	8	2
274	56	1
274	18	4
275	48	2
275	52	1
275	31	1
275	9	1
275	4	1
275	2	2
275	23	2
276	41	2
276	28	1
276	5	2
276	54	1
276	55	1
277	38	1
277	29	3
277	43	5
277	49	2
277	28	2
277	4	2
277	1	1
277	27	4
278	43	2
278	29	1
278	31	3
278	32	1
278	9	2
278	53	1
278	1	1
278	21	2
278	25	4
278	27	4
279	42	2
279	29	2
279	32	1
279	11	1
279	2	2
279	26	2
279	14	2
280	52	1
280	41	1
280	3	2
280	55	1
280	14	2
280	25	4
280	21	4
281	42	1
281	47	4
281	50	1
281	6	2
281	13	1
281	23	2
281	1	1
281	18	4
281	27	2
281	24	4
282	37	3
282	38	3
282	31	2
282	32	3
282	3	1
282	8	1
282	23	1
282	1	1
282	14	4
283	36	3
283	35	3
283	50	1
283	33	1
283	31	2
283	10	2
283	12	1
283	26	2
283	16	2
284	52	1
284	43	3
284	28	2
284	42	2
284	48	1
284	3	1
284	34	2
284	18	2
285	30	4
285	29	1
285	41	4
285	8	1
285	2	2
285	1	2
286	38	2
286	44	1
286	52	5
286	51	1
286	41	3
286	5	1
286	9	2
286	2	1
286	26	2
286	17	2
287	39	2
287	35	3
287	36	1
287	52	3
287	31	1
287	8	2
287	7	1
287	23	1
287	26	4
287	14	4
287	24	2
288	51	4
288	33	3
288	50	4
288	29	3
288	31	4
288	7	1
288	8	1
288	56	1
288	55	2
288	19	4
288	21	4
289	49	4
289	36	1
289	37	2
289	51	1
289	4	1
289	9	1
289	45	2
289	20	4
289	19	2
290	48	2
290	41	2
290	42	3
290	3	2
290	13	1
290	53	2
291	38	2
291	37	2
291	50	3
291	51	1
291	28	1
291	4	2
291	54	2
291	17	2
292	44	3
292	38	3
292	48	2
292	10	1
292	53	1
292	22	2
292	26	4
293	31	3
293	48	3
293	42	1
293	51	2
293	6	2
293	53	1
294	36	2
294	43	1
294	32	2
294	31	1
294	10	1
294	12	2
294	53	2
294	20	4
294	25	2
294	14	2
295	39	3
295	32	3
295	9	1
295	5	2
295	55	2
295	26	2
295	22	2
295	14	4
296	37	3
296	48	2
296	36	1
296	40	1
296	7	1
296	6	1
296	53	1
296	54	1
296	22	2
296	25	4
296	14	2
297	36	2
297	52	2
297	51	1
297	28	3
297	40	4
297	4	2
297	53	1
297	1	2
297	16	2
298	40	1
298	33	1
298	44	2
298	28	5
298	38	3
298	5	2
298	2	2
298	53	2
298	22	2
298	16	4
299	30	3
299	39	2
299	47	3
299	5	1
299	23	1
299	45	2
299	15	2
300	30	4
300	31	2
300	42	3
300	41	2
300	38	3
300	8	2
300	53	1
300	45	1
300	15	4
300	26	2
301	28	4
301	41	3
301	49	1
301	43	3
301	37	1
301	6	1
301	3	2
301	23	1
301	22	2
301	24	4
302	52	1
302	48	4
302	33	1
302	49	1
302	5	2
302	56	2
302	23	1
303	39	1
303	30	4
303	32	2
303	51	2
303	46	2
303	13	1
303	34	1
303	23	2
303	16	2
303	21	4
303	14	2
304	37	1
304	42	1
304	51	1
304	9	1
304	3	2
304	23	2
304	26	2
305	40	4
305	37	1
305	38	3
305	33	1
305	47	1
305	13	2
305	5	2
305	23	2
305	15	2
306	38	4
306	28	4
306	46	4
306	35	2
306	10	2
306	8	1
306	2	1
306	12	2
306	27	2
306	22	4
306	14	2
307	33	2
307	41	1
307	11	2
307	34	1
307	25	2
308	38	4
308	32	1
308	42	4
308	36	1
308	44	1
308	4	1
308	8	2
308	12	1
308	45	2
308	20	2
308	24	2
308	14	2
309	35	2
309	40	2
309	11	2
309	9	1
309	23	1
309	45	2
309	19	4
309	16	4
310	51	4
310	46	2
310	30	3
310	52	3
310	9	1
310	53	2
311	30	1
311	47	3
311	32	1
311	5	2
311	23	1
311	2	2
312	47	1
312	42	1
312	41	1
312	44	1
312	7	2
312	23	1
312	2	1
312	21	2
313	48	1
313	30	3
313	29	2
313	37	2
313	33	3
313	8	1
313	12	2
313	55	1
313	19	4
313	14	2
313	26	4
314	43	5
314	37	1
314	42	1
314	44	1
314	13	2
314	54	1
314	53	2
315	32	5
315	49	5
315	47	2
315	51	2
315	6	1
315	3	1
315	23	1
315	54	1
316	28	2
316	40	3
316	47	1
316	5	1
316	10	2
316	45	2
316	12	1
317	51	1
317	31	2
317	28	4
317	10	2
317	3	2
317	56	1
317	24	4
318	42	2
318	43	3
318	36	4
318	10	2
318	34	1
318	55	2
318	26	4
318	22	2
318	21	4
319	29	1
319	51	3
319	30	1
319	28	1
319	50	2
319	8	1
319	7	1
319	56	1
319	14	2
319	24	2
320	29	4
320	40	1
320	32	1
320	44	2
320	33	1
320	9	1
320	34	2
320	55	2
321	32	1
321	41	2
321	51	1
321	42	1
321	38	2
321	7	2
321	11	1
321	56	2
322	43	2
322	29	2
322	31	2
322	30	4
322	28	1
322	8	1
322	53	2
322	55	1
322	26	4
323	44	1
323	31	1
323	52	4
323	37	1
323	35	1
323	4	2
323	11	1
323	2	1
323	26	2
323	18	2
324	31	1
324	49	3
324	8	2
324	3	1
324	1	2
324	22	4
325	40	4
325	38	3
325	11	2
325	9	1
325	23	1
325	21	2
325	15	2
326	33	4
326	38	1
326	46	4
326	42	4
326	13	1
326	12	2
326	22	4
326	20	2
326	26	4
327	35	4
327	32	1
327	51	3
327	31	3
327	9	2
327	11	2
327	34	2
327	45	2
328	31	3
328	44	2
328	7	2
328	45	1
328	22	4
328	21	4
329	32	2
329	31	3
329	5	2
329	54	1
329	16	4
329	18	2
330	41	2
330	46	2
330	33	2
330	7	2
330	12	2
330	22	2
331	38	1
331	51	4
331	35	2
331	49	1
331	11	1
331	10	1
331	34	2
331	55	1
332	51	1
332	46	2
332	40	5
332	5	1
332	8	1
332	2	2
332	16	2
332	19	4
332	25	4
333	39	1
333	37	2
333	49	4
333	48	2
333	51	2
333	7	2
333	11	1
333	34	2
334	46	1
334	29	3
334	50	2
334	13	2
334	55	2
334	45	2
335	33	2
335	51	4
335	36	5
335	40	2
335	7	2
335	53	1
335	14	4
335	27	2
336	39	1
336	50	2
336	29	1
336	7	2
336	11	1
336	45	1
336	2	1
337	28	5
337	36	2
337	49	1
337	39	1
337	11	2
337	12	1
337	56	1
338	47	2
338	33	3
338	43	1
338	11	2
338	9	1
338	55	2
339	49	3
339	51	1
339	47	1
339	3	2
339	9	2
339	12	1
339	23	1
340	51	3
340	33	3
340	11	2
340	4	2
340	1	2
340	53	2
340	24	2
340	21	4
341	49	2
341	33	4
341	38	1
341	37	2
341	13	2
341	45	1
341	27	4
341	17	4
341	25	2
342	41	3
342	29	3
342	43	1
342	10	1
342	54	1
342	12	1
342	16	4
343	39	5
343	43	1
343	40	4
343	41	1
343	10	1
343	3	1
343	23	1
343	24	2
343	22	2
343	17	2
344	49	1
344	51	2
344	46	2
344	11	1
344	54	1
344	14	4
344	21	4
344	27	2
345	42	1
345	46	2
345	51	4
345	37	2
345	32	1
345	4	2
345	3	2
345	53	2
346	38	3
346	37	3
346	41	4
346	42	2
346	10	2
346	6	2
346	55	2
346	1	1
347	33	3
347	37	2
347	30	1
347	9	1
347	13	1
347	12	1
347	26	2
348	48	2
348	28	2
348	44	1
348	41	2
348	10	2
348	9	2
348	54	1
348	23	2
348	16	4
349	49	2
349	35	1
349	6	2
349	54	1
349	23	2
349	22	4
349	20	4
349	17	4
350	41	2
350	49	1
350	4	1
350	34	1
350	16	2
350	18	2
351	32	2
351	35	2
351	47	2
351	5	1
351	23	2
351	55	2
351	22	4
351	16	4
351	25	2
352	41	2
352	30	2
352	43	3
352	29	2
352	7	1
352	5	1
352	2	2
352	20	4
352	18	4
352	25	4
353	38	4
353	42	2
353	44	1
353	13	2
353	12	2
353	56	1
354	28	2
354	44	2
354	49	3
354	7	1
354	6	1
354	56	1
354	15	2
355	35	3
355	38	3
355	3	2
355	45	2
355	15	4
355	17	2
356	30	4
356	47	3
356	29	1
356	32	2
356	40	3
356	6	1
356	4	1
356	12	1
356	19	2
356	16	4
356	14	2
357	40	3
357	32	2
357	9	1
357	1	2
357	25	4
357	19	2
358	49	2
358	28	1
358	32	2
358	30	1
358	52	1
358	5	1
358	13	2
358	34	1
358	21	2
358	26	4
358	20	4
359	46	2
359	50	1
359	9	1
359	54	1
359	19	4
359	16	2
359	27	4
360	35	1
360	50	2
360	38	3
360	52	1
360	6	2
360	54	1
360	17	2
360	26	2
360	24	2
361	47	1
361	31	2
361	39	2
361	46	2
361	33	3
361	6	1
361	3	1
361	53	2
361	25	2
362	46	1
362	39	4
362	40	2
362	37	1
362	52	3
362	6	1
362	4	2
362	56	1
362	54	1
362	27	2
362	22	2
363	51	1
363	36	1
363	37	2
363	3	2
363	11	2
363	53	2
363	19	2
363	21	4
363	20	2
364	52	1
364	48	2
364	29	1
364	11	2
364	23	1
364	54	2
365	36	1
365	30	4
365	42	3
365	5	1
365	11	1
365	56	1
365	34	2
366	49	3
366	36	3
366	39	2
366	6	1
366	3	2
366	23	2
366	45	1
366	14	4
367	36	1
367	39	2
367	30	3
367	5	2
367	12	2
367	20	2
367	22	4
368	35	3
368	42	1
368	9	2
368	13	2
368	54	1
368	16	2
368	24	2
368	18	4
369	49	1
369	36	2
369	51	1
369	47	2
369	13	2
369	53	2
369	21	2
369	26	4
369	24	2
370	37	2
370	47	1
370	5	1
370	2	1
370	20	4
370	18	4
371	30	2
371	37	4
371	6	2
371	54	2
371	16	4
372	30	1
372	49	2
372	11	2
372	45	1
372	2	1
372	17	2
372	22	2
373	37	3
373	41	4
373	32	1
373	3	2
373	56	2
373	2	1
374	48	2
374	44	1
374	32	1
374	50	3
374	35	1
374	8	1
374	23	1
374	12	2
374	24	4
375	33	1
375	36	2
375	31	3
375	52	3
375	28	2
375	11	1
375	8	1
375	45	2
375	56	1
375	14	4
375	24	2
376	44	4
376	47	2
376	35	1
376	28	2
376	10	2
376	56	2
376	12	1
376	25	4
376	14	2
377	30	4
377	43	2
377	47	3
377	4	1
377	11	2
377	56	1
377	18	2
377	21	2
378	40	1
378	31	4
378	44	2
378	4	1
378	54	1
378	56	1
378	26	4
378	17	2
378	22	4
379	29	3
379	38	1
379	32	3
379	6	1
379	11	2
379	23	1
379	12	1
379	14	2
379	25	4
380	33	3
380	30	4
380	31	2
380	32	3
380	7	2
380	34	2
380	56	1
380	16	2
380	27	4
381	40	5
381	39	2
381	37	2
381	4	2
381	2	2
382	38	1
382	29	3
382	6	1
382	55	2
383	37	1
383	50	5
383	8	1
383	12	1
383	54	1
383	27	4
383	14	2
383	16	2
384	35	2
384	49	2
384	4	1
384	10	1
384	45	2
384	24	2
384	18	4
384	25	2
385	31	2
385	29	2
385	44	4
385	3	2
385	13	1
385	1	1
385	2	1
386	36	2
386	29	1
386	35	3
386	10	2
386	13	1
386	55	1
386	54	2
386	26	4
387	28	4
387	43	2
387	44	4
387	4	1
387	1	1
387	2	2
387	18	4
388	50	1
388	49	1
388	8	1
388	2	1
388	23	1
388	25	2
388	16	4
388	22	4
389	46	2
389	43	1
389	31	2
389	35	3
389	49	4
389	13	2
389	45	1
389	56	2
389	20	2
390	32	1
390	43	3
390	8	2
390	11	1
390	23	1
390	2	2
390	15	2
390	22	2
390	19	2
391	49	2
391	38	5
391	13	2
391	6	2
391	56	2
392	35	4
392	42	4
392	28	4
392	46	1
392	7	2
392	23	1
392	12	1
392	18	2
392	26	4
393	30	1
393	40	1
393	50	3
393	44	3
393	52	2
393	8	1
393	12	1
394	48	4
394	33	2
394	37	4
394	31	5
394	6	1
394	10	2
394	45	1
394	23	1
394	27	4
394	17	2
395	35	3
395	47	4
395	36	2
395	43	1
395	3	1
395	45	1
396	35	2
396	48	2
396	51	1
396	6	1
396	2	2
396	26	2
397	40	1
397	36	1
397	37	1
397	31	2
397	7	2
397	1	1
397	55	2
397	18	2
398	29	1
398	43	1
398	3	1
398	4	2
398	23	1
399	39	1
399	43	4
399	31	2
399	42	1
399	11	2
399	56	1
400	31	4
400	40	1
400	13	1
400	6	1
400	54	1
400	45	2
400	20	2
400	26	4
400	21	4
401	29	3
401	47	4
401	50	3
401	37	3
401	32	1
401	11	2
401	23	2
401	56	2
402	35	1
402	29	2
402	52	5
402	4	2
402	12	1
402	56	2
402	19	4
402	18	4
403	52	2
403	38	3
403	48	4
403	5	2
403	2	1
403	16	4
403	15	4
404	50	1
404	37	1
404	5	1
404	34	2
404	25	2
405	28	2
405	47	2
405	30	2
405	41	3
405	38	4
405	7	2
405	56	2
405	26	4
405	17	2
406	51	2
406	28	5
406	4	2
406	6	1
406	1	1
406	34	1
406	16	2
406	18	4
406	26	4
407	35	1
407	43	1
407	3	2
407	11	2
407	55	1
407	56	2
408	29	1
408	48	1
408	39	1
408	3	1
408	4	2
408	54	2
408	25	2
408	19	4
408	24	2
409	32	3
409	52	4
409	39	2
409	48	3
409	41	1
409	5	1
409	12	2
409	22	4
410	49	2
410	41	1
410	47	3
410	9	1
410	10	2
410	23	1
410	55	1
410	19	2
410	27	4
411	48	1
411	33	4
411	37	2
411	47	1
411	52	2
411	6	2
411	56	2
412	35	3
412	38	3
412	42	4
412	30	1
412	46	2
412	10	1
412	13	2
412	12	1
412	21	4
412	20	2
412	22	2
413	33	2
413	50	2
413	10	2
413	3	1
413	23	2
413	26	2
414	43	3
414	49	2
414	52	3
414	51	2
414	50	2
414	4	2
414	3	2
414	2	1
414	34	2
415	49	5
415	44	2
415	42	3
415	7	2
415	4	2
415	34	2
415	23	2
415	14	4
416	32	1
416	48	2
416	36	2
416	8	1
416	9	1
416	56	1
416	45	2
416	20	4
417	32	1
417	49	2
417	29	2
417	42	1
417	11	2
417	7	2
417	1	1
417	45	2
417	26	4
417	17	4
418	28	5
418	29	1
418	8	2
418	13	1
418	1	1
418	20	2
419	40	2
419	46	1
419	13	2
419	8	1
419	54	2
419	20	4
420	30	3
420	35	1
420	51	4
420	40	2
420	36	1
420	13	2
420	12	2
420	34	2
420	22	2
421	40	2
421	42	3
421	36	3
421	38	2
421	31	2
421	7	2
421	8	1
421	55	2
421	54	2
422	44	2
422	36	2
422	29	1
422	38	2
422	37	2
422	3	2
422	53	2
423	38	1
423	49	4
423	13	2
423	56	2
423	19	2
423	18	4
423	27	2
424	29	4
424	46	1
424	44	5
424	30	4
424	40	4
424	8	2
424	1	2
424	53	2
424	19	2
425	38	2
425	43	1
425	28	1
425	4	2
425	45	1
425	19	4
426	43	3
426	37	1
426	33	2
426	40	2
426	31	2
426	4	1
426	6	1
426	23	2
426	19	4
426	20	2
426	25	2
427	28	2
427	48	1
427	47	3
427	39	4
427	51	3
427	5	2
427	23	1
427	16	4
427	15	4
427	22	4
428	50	2
428	33	3
428	39	2
428	28	1
428	49	1
428	7	2
428	2	1
428	12	1
429	32	1
429	30	1
429	39	2
429	35	1
429	4	2
429	7	2
429	2	2
430	35	2
430	37	1
430	42	3
430	39	2
430	4	1
430	7	1
430	54	2
431	33	1
431	38	2
431	42	2
431	9	2
431	55	2
431	20	2
431	19	2
432	48	2
432	40	3
432	43	3
432	47	1
432	7	2
432	54	1
432	34	2
432	15	4
433	33	1
433	37	2
433	40	1
433	6	1
433	10	2
433	54	1
433	18	2
433	16	4
433	15	2
434	51	1
434	37	1
434	30	1
434	35	2
434	8	1
434	13	1
434	2	2
435	38	5
435	50	2
435	41	1
435	29	1
435	5	2
435	34	2
435	27	4
435	26	4
436	43	4
436	42	4
436	39	1
436	50	1
436	8	1
436	56	1
436	15	2
436	24	2
436	16	4
437	44	1
437	42	2
437	32	5
437	10	2
437	12	2
437	23	1
438	33	2
438	42	1
438	28	3
438	41	4
438	4	2
438	7	2
438	45	2
438	23	1
439	50	4
439	42	2
439	52	3
439	43	1
439	11	1
439	55	2
439	12	1
439	25	2
439	26	4
439	16	2
440	38	1
440	43	1
440	41	2
440	37	2
440	33	4
440	6	1
440	13	1
440	34	2
440	45	1
440	25	2
441	51	4
441	30	2
441	33	2
441	5	1
441	7	2
441	56	2
441	22	2
442	31	3
442	28	4
442	52	4
442	32	1
442	3	2
442	45	1
442	56	1
442	20	4
443	29	1
443	52	2
443	9	2
443	55	1
443	12	1
443	15	2
444	52	4
444	51	4
444	37	2
444	41	5
444	9	2
444	45	2
445	43	1
445	42	4
445	48	1
445	10	1
445	56	2
445	19	4
445	26	2
445	14	4
446	47	5
446	44	2
446	29	4
446	35	2
446	37	1
446	5	1
446	45	1
446	2	1
446	20	2
446	22	2
447	47	1
447	36	2
447	37	1
447	48	4
447	31	1
447	8	1
447	55	1
448	31	1
448	29	1
448	10	2
448	1	2
448	2	2
448	15	2
448	21	2
448	27	2
449	40	2
449	31	2
449	50	4
449	8	2
449	56	2
449	24	2
449	26	4
449	27	4
450	33	1
450	48	3
450	47	2
450	4	2
450	12	1
450	25	2
451	51	4
451	37	3
451	38	2
451	42	1
451	46	4
451	10	1
451	6	1
451	55	2
451	22	2
452	35	2
452	29	2
452	38	1
452	11	1
452	34	1
452	18	2
453	38	1
453	50	2
453	3	2
453	4	2
453	34	1
453	1	1
454	37	3
454	31	2
454	7	1
454	2	1
455	43	1
455	52	3
455	48	1
455	37	1
455	9	1
455	11	2
455	1	1
455	19	4
455	22	4
456	42	3
456	47	2
456	36	1
456	41	3
456	9	1
456	53	1
456	27	4
456	18	4
456	22	2
457	41	3
457	46	1
457	51	2
457	31	4
457	50	2
457	8	2
457	54	2
457	45	2
457	14	4
457	16	4
457	24	2
458	33	5
458	32	3
458	35	2
458	8	1
458	5	2
458	2	2
458	15	2
458	27	4
458	20	2
459	44	2
459	29	4
459	35	2
459	9	2
459	45	2
459	12	1
459	19	2
460	36	4
460	35	4
460	30	1
460	9	2
460	34	1
460	55	1
460	15	4
460	27	2
460	25	2
461	52	2
461	29	4
461	38	3
461	4	1
461	56	1
461	17	4
461	18	2
461	20	4
462	42	1
462	29	1
462	38	1
462	51	3
462	40	1
462	3	1
462	55	1
462	27	4
462	21	4
463	32	1
463	36	4
463	9	2
463	3	1
463	55	2
463	1	1
463	20	2
463	22	4
464	28	1
464	39	4
464	50	3
464	8	2
464	13	2
464	56	1
465	49	1
465	40	3
465	38	3
465	7	2
465	1	1
465	23	1
466	51	1
466	50	2
466	28	4
466	7	2
466	11	1
466	53	2
466	24	2
467	47	2
467	48	2
467	32	3
467	51	4
467	40	1
467	11	2
467	23	1
467	2	1
467	16	4
468	42	1
468	30	2
468	48	1
468	3	1
468	54	2
468	22	4
469	30	3
469	40	1
469	10	1
469	1	2
469	26	2
470	39	2
470	42	3
470	33	1
470	32	2
470	3	2
470	56	2
470	20	4
471	31	1
471	47	1
471	8	1
471	55	2
472	39	5
472	49	2
472	8	1
472	56	1
472	12	1
472	24	2
473	52	1
473	35	3
473	49	3
473	9	1
473	7	1
473	23	2
473	1	1
473	24	2
474	38	3
474	42	4
474	9	1
474	6	2
474	12	2
474	14	2
475	37	2
475	33	1
475	41	1
475	6	2
475	10	2
475	56	1
475	19	2
475	14	2
476	37	2
476	51	5
476	32	1
476	11	1
476	54	2
476	22	2
477	40	1
477	48	1
477	36	4
477	13	2
477	3	2
477	23	2
477	17	2
477	27	4
477	25	4
478	46	2
478	48	3
478	28	1
478	6	2
478	13	2
478	55	2
478	17	2
479	43	4
479	42	5
479	50	3
479	46	3
479	51	4
479	13	1
479	23	2
479	2	2
480	36	1
480	31	2
480	28	2
480	9	2
480	7	2
480	34	2
481	35	3
481	38	4
481	13	2
481	45	1
481	12	1
481	15	4
482	32	1
482	47	3
482	52	2
482	4	1
482	34	2
482	54	2
482	14	2
482	22	4
482	20	4
483	30	1
483	28	1
483	36	2
483	13	1
483	34	2
483	54	2
483	18	2
483	15	4
483	14	4
484	35	4
484	48	1
484	10	1
484	11	1
484	55	2
484	1	2
484	22	2
485	44	1
485	36	2
485	4	2
485	6	2
485	45	1
485	27	4
485	19	2
485	24	4
486	42	3
486	44	2
486	39	3
486	7	1
486	3	1
486	45	1
486	53	1
486	21	2
487	46	2
487	48	4
487	32	4
487	10	1
487	55	2
487	14	2
488	41	1
488	29	2
488	5	1
488	12	2
489	41	1
489	30	1
489	5	2
489	12	2
489	56	2
489	16	2
490	39	2
490	48	1
490	41	1
490	52	4
490	5	2
490	7	1
490	34	1
490	27	4
490	14	2
491	40	4
491	33	1
491	47	5
491	32	1
491	11	2
491	10	2
491	12	2
491	20	2
492	38	1
492	42	4
492	52	2
492	41	4
492	44	2
492	6	1
492	34	1
493	29	1
493	52	1
493	51	3
493	43	1
493	38	2
493	3	2
493	10	1
493	23	2
493	45	1
493	19	2
493	22	4
493	24	4
494	49	3
494	38	4
494	35	3
494	40	1
494	36	4
494	5	1
494	7	2
494	12	1
494	54	2
494	19	4
495	52	1
495	28	3
495	51	1
495	33	2
495	47	5
495	11	2
495	45	2
495	26	4
496	31	1
496	52	3
496	51	1
496	7	2
496	45	2
496	26	4
496	20	4
497	35	2
497	50	2
497	31	5
497	33	1
497	42	2
497	13	1
497	10	2
497	34	1
497	20	2
497	26	2
498	47	2
498	29	3
498	40	2
498	5	1
498	54	1
498	53	1
498	24	4
499	49	1
499	47	5
499	10	2
499	7	2
499	45	1
499	15	2
500	52	2
500	42	3
500	38	3
500	9	2
500	6	1
500	45	2
500	23	2
500	27	2
500	21	4
500	17	2
501	47	4
501	32	1
501	9	1
501	53	2
501	2	1
501	20	4
502	33	4
502	44	2
502	32	1
502	40	4
502	4	2
502	34	1
502	2	2
502	19	2
503	44	2
503	28	4
503	41	1
503	51	4
503	6	2
503	23	2
503	25	2
504	36	3
504	31	2
504	46	1
504	44	1
504	32	5
504	8	1
504	55	1
504	25	2
505	37	4
505	39	4
505	38	1
505	33	3
505	11	1
505	23	2
505	16	4
505	14	2
506	44	4
506	46	1
506	41	1
506	10	1
506	6	2
506	55	1
506	23	1
506	16	4
507	31	3
507	39	4
507	38	1
507	29	1
507	42	3
507	13	1
507	9	2
507	23	1
507	12	2
507	26	2
507	24	4
507	21	2
508	41	2
508	42	1
508	29	5
508	31	2
508	48	1
508	4	2
508	23	2
508	54	1
508	26	4
508	16	4
\.


--
-- Data for Name: order_food; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_food (order_id, order_date, status, total_amount, delivery_address, create_at, update_at, user_id) FROM stdin;
1	2024-11-01	3	1790000	42 Dương Xá, Dương Xá, Hoài Đức, Hà Nội	2024-11-01 08:36:35	2024-11-01 08:41:35	1878
2	2024-11-01	3	1774000	39 Cổ Loa, Cổ Loa, Đan Phượng, Hà Nội	2024-11-01 19:55:46	2024-11-01 20:08:46	1234
3	2024-11-01	3	585000	16 An Thượng, An Thượng, Sóc Sơn, Hà Nội	2024-11-01 18:06:57	2024-11-01 18:23:57	1321
4	2024-11-01	1	702000	36 Liên Ninh, Liên Ninh, Phúc Thọ, Hà Nội	2024-11-01 20:48:57	2024-11-01 20:53:57	1066
5	2024-11-01	3	630000	74 An Khánh, An Khánh, Sóc Sơn, Hà Nội	2024-11-01 18:50:40	2024-11-01 18:56:40	920
6	2024-11-01	0	1173000	52 Kiêu Kỵ, Kiêu Kỵ, Hoài Đức, Hà Nội	2024-11-01 15:44:42	2024-11-01 15:51:42	1267
7	2024-11-01	1	1170000	7 Nguyễn Văn Lộc, Mộ Lao, Mê Linh, Hà Nội	2024-11-01 12:08:56	2024-11-01 12:13:56	1065
8	2024-11-01	3	405000	29 Cổ Bi, Cổ Bi, Hoài Đức, Hà Nội	2024-11-01 20:32:25	2024-11-01 20:37:25	1030
9	2024-11-01	3	1168000	65 Cự Khối, Cự Khối, Hà Đông, Hà Nội	2024-11-01 20:13:38	2024-11-01 20:20:38	1809
10	2024-11-02	1	435000	40 Giảng Võ, Giảng Võ, Ba Đình, Hà Nội	2024-11-02 14:09:28	2024-11-02 14:17:28	1856
11	2024-11-02	3	751000	7 Hàng Bạc, Hàng Bạc, Hoàn Kiếm, Hà Nội	2024-11-02 05:42:50	2024-11-02 05:58:50	211
12	2024-11-02	3	800000	17 Dương Xá, Dương Xá, Hoài Đức, Hà Nội	2024-11-02 06:01:21	2024-11-02 06:18:21	1073
13	2024-11-02	3	728000	100 Kim Mã, Kim Mã, Ba Đình, Hà Nội	2024-11-02 20:26:53	2024-11-02 20:31:53	1579
14	2024-11-02	3	1150000	28 Láng Hạ, Láng Hạ, Long Biên, Hà Nội	2024-11-02 15:26:07	2024-11-02 15:36:07	1771
15	2024-11-02	1	800000	82 Đặng Thai Mai, Quảng An, Cầu Giấy, Hà Nội	2024-11-02 09:38:29	2024-11-02 09:43:29	939
16	2024-11-02	3	915000	45 Quan Hoa, Quan Hoa, Đống Đa, Hà Nội	2024-11-02 09:00:13	2024-11-02 09:05:13	1943
17	2024-11-03	3	530000	59 Nam Hồng, Nam Hồng, Đan Phượng, Hà Nội	2024-11-03 21:57:44	2024-11-03 22:02:44	476
18	2024-11-03	3	400000	31 Đại Áng, Đại Áng, Phúc Thọ, Hà Nội	2024-11-03 18:28:31	2024-11-03 18:34:31	273
19	2024-11-03	1	840000	63 Đại Mỗ, Tây Mỗ, Bắc Từ Liêm, Hà Nội	2024-11-03 14:13:19	2024-11-03 14:23:19	1366
20	2024-11-03	3	1250000	82 Minh Khai, Minh Khai, Tây Hồ, Hà Nội	2024-11-03 20:12:14	2024-11-03 20:34:14	1543
21	2024-11-03	3	560000	27 Ngô Quyền, Lý Thái Tổ, Hoàn Kiếm, Hà Nội	2024-11-03 11:22:13	2024-11-03 11:27:13	297
22	2024-11-03	3	1068000	76 Hàng Đào, Hàng Đào, Hoàn Kiếm, Hà Nội	2024-11-03 06:19:45	2024-11-03 06:32:45	782
23	2024-11-03	2	569000	6 Mễ Trì, Mễ Trì, Bắc Từ Liêm, Hà Nội	2024-11-03 16:32:13	2024-11-03 17:06:13	416
24	2024-11-03	0	735000	47 Cát Linh, Cát Linh, Long Biên, Hà Nội	2024-11-03 19:07:42	2024-11-03 19:36:42	1337
25	2024-11-04	3	748000	85 Xuân La, Xuân La, Cầu Giấy, Hà Nội	2024-11-04 21:58:49	2024-11-04 22:06:49	1274
26	2024-11-04	4	877000	18 Đông Hội, Đông Hội, Đan Phượng, Hà Nội	2024-11-04 18:55:24	2024-11-04 19:00:24	1528
27	2024-11-04	3	1365000	90 An Thượng, An Thượng, Sóc Sơn, Hà Nội	2024-11-04 08:00:20	2024-11-04 08:40:20	1766
28	2024-11-04	3	1498000	43 Dương Xá, Dương Xá, Hoài Đức, Hà Nội	2024-11-04 11:14:27	2024-11-04 11:24:27	518
29	2024-11-04	3	1115000	36 Đại Mỗ, Tây Mỗ, Bắc Từ Liêm, Hà Nội	2024-11-04 21:13:33	2024-11-04 21:35:33	1641
30	2024-11-04	3	950000	7 Thụy Khuê, Thụy Khuê, Cầu Giấy, Hà Nội	2024-11-04 20:46:24	2024-11-04 20:51:24	1604
31	2024-11-04	1	458000	38 Gia Thụy, Gia Thụy, Hà Đông, Hà Nội	2024-11-04 20:13:42	2024-11-04 20:18:42	428
32	2024-11-05	3	750000	5 Tôn Đức Thắng, Hàng Bột, Long Biên, Hà Nội	2024-11-05 20:18:42	2024-11-05 20:34:42	1321
33	2024-11-05	3	992000	23 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-11-05 06:24:13	2024-11-05 06:29:13	1827
34	2024-11-05	3	1534000	53 Quan Hoa, Quan Hoa, Đống Đa, Hà Nội	2024-11-05 07:14:04	2024-11-05 07:19:04	1195
35	2024-11-05	3	1250000	73 Hoàng Diệu, Điện Biên, Ba Đình, Hà Nội	2024-11-05 19:34:50	2024-11-05 19:39:50	1469
36	2024-11-05	2	1174000	91 Hải Bối, Hải Bối, Đan Phượng, Hà Nội	2024-11-05 19:27:47	2024-11-05 19:32:47	846
37	2024-11-05	3	1498000	25 Yên Nghĩa, Yên Nghĩa, Mê Linh, Hà Nội	2024-11-05 17:10:50	2024-11-05 17:29:50	1837
38	2024-11-05	3	439000	96 Giải Phóng, Đồng Tâm, Tây Hồ, Hà Nội	2024-11-05 10:16:35	2024-11-05 10:28:35	1533
39	2024-11-05	3	870000	8 Hồ Tùng Mậu, Mai Dịch, Đống Đa, Hà Nội	2024-11-05 21:24:07	2024-11-05 21:52:07	609
40	2024-11-05	3	750000	39 Phú Diễn, Phú Diễn, Nam Từ Liêm, Hà Nội	2024-11-05 14:43:42	2024-11-05 14:48:42	87
41	2024-11-05	3	505000	7 Đông Mỹ, Đông Mỹ, Phúc Thọ, Hà Nội	2024-11-05 18:09:55	2024-11-05 18:14:55	316
42	2024-11-06	2	480000	4 Cầu Giấy, Dịch Vọng, Đống Đa, Hà Nội	2024-11-06 17:18:08	2024-11-06 18:03:08	242
43	2024-11-06	2	700000	60 Cự Khối, Cự Khối, Hà Đông, Hà Nội	2024-11-06 10:13:15	2024-11-06 10:18:15	358
44	2024-11-06	3	1316000	46 Đặng Thai Mai, Quảng An, Cầu Giấy, Hà Nội	2024-11-06 09:08:24	2024-11-06 09:13:24	1898
45	2024-11-06	0	1720000	48 La Phù, La Phù, Sóc Sơn, Hà Nội	2024-11-06 21:18:52	2024-11-06 21:23:52	481
46	2024-11-06	3	900000	23 Hoàng Văn Thái, Khương Mai, Hai Bà Trưng, Hà Nội	2024-11-06 18:11:32	2024-11-06 18:32:32	1226
47	2024-11-06	3	898000	96 Hàng Đào, Hàng Đào, Hoàn Kiếm, Hà Nội	2024-11-06 16:11:48	2024-11-06 16:16:48	677
48	2024-11-06	3	420000	58 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-11-06 12:57:54	2024-11-06 13:03:54	437
49	2024-11-06	3	595000	39 Nguyễn Hữu Thọ, Hoàng Liệt, Thanh Xuân, Hà Nội	2024-11-06 06:31:08	2024-11-06 06:38:08	1031
50	2024-11-07	0	825000	75 Cổ Nhuế, Cổ Nhuế 1, Nam Từ Liêm, Hà Nội	2024-11-07 06:59:26	2024-11-07 07:04:26	1015
51	2024-11-07	3	971000	40 Nguyễn Hữu Thọ, Hoàng Liệt, Thanh Xuân, Hà Nội	2024-11-07 06:53:11	2024-11-07 07:09:11	204
52	2024-11-07	3	1045000	54 Hàng Bài, Hàng Bài, Hoàn Kiếm, Hà Nội	2024-11-07 13:11:22	2024-11-07 13:16:22	1409
53	2024-11-07	3	1115000	52 Nguyễn Văn Cừ, Ngọc Lâm, Hà Đông, Hà Nội	2024-11-07 18:14:55	2024-11-07 18:19:55	700
54	2024-11-07	3	1637000	90 Đại Áng, Đại Áng, Phúc Thọ, Hà Nội	2024-11-07 19:31:36	2024-11-07 19:52:36	558
55	2024-11-07	2	995000	89 Phú Đô, Phú Đô, Bắc Từ Liêm, Hà Nội	2024-11-07 15:08:51	2024-11-07 15:49:51	1693
56	2024-11-07	2	1318000	11 Kim Mã, Kim Mã, Ba Đình, Hà Nội	2024-11-07 13:01:40	2024-11-07 13:10:40	1599
57	2024-11-08	2	646000	49 Nam Hồng, Nam Hồng, Đan Phượng, Hà Nội	2024-11-08 14:04:29	2024-11-08 14:12:29	1731
58	2024-11-08	1	1101000	47 Hàng Bài, Hàng Bài, Hoàn Kiếm, Hà Nội	2024-11-08 11:30:46	2024-11-08 12:01:46	1651
59	2024-11-08	2	1338000	8 Yên Viên, Yên Viên, Hoài Đức, Hà Nội	2024-11-08 15:23:14	2024-11-08 15:37:14	1670
60	2024-11-08	1	1078000	99 Quan Hoa, Quan Hoa, Đống Đa, Hà Nội	2024-11-08 19:11:55	2024-11-08 19:16:55	1574
61	2024-11-08	3	710000	61 Đông Hội, Đông Hội, Đan Phượng, Hà Nội	2024-11-08 12:57:02	2024-11-08 13:07:02	919
62	2024-11-08	1	1188000	16 Minh Khai, Minh Khai, Tây Hồ, Hà Nội	2024-11-08 12:01:59	2024-11-08 12:06:59	1661
63	2024-11-08	1	959000	42 Cổ Loa, Cổ Loa, Đan Phượng, Hà Nội	2024-11-08 14:15:36	2024-11-08 14:23:36	1145
64	2024-11-08	3	860000	63 Cự Khối, Cự Khối, Hà Đông, Hà Nội	2024-11-08 21:55:18	2024-11-08 22:10:18	1672
65	2024-11-08	3	660000	49 Hạ Đình, Hạ Đình, Hai Bà Trưng, Hà Nội	2024-11-08 18:07:06	2024-11-08 18:29:06	291
66	2024-11-08	3	1430000	5 Đặng Thai Mai, Quảng An, Cầu Giấy, Hà Nội	2024-11-08 19:36:51	2024-11-08 19:41:51	1300
67	2024-11-09	3	1461000	39 Ngô Quyền, Lý Thái Tổ, Hoàn Kiếm, Hà Nội	2024-11-09 21:12:59	2024-11-09 21:22:59	1672
68	2024-11-09	3	2090000	52 Vân Canh, Vân Canh, Sóc Sơn, Hà Nội	2024-11-09 20:22:28	2024-11-09 20:35:28	530
69	2024-11-09	2	436000	7 Nguyễn Văn Cừ, Ngọc Lâm, Hà Đông, Hà Nội	2024-11-09 20:14:12	2024-11-09 20:19:12	220
70	2024-11-09	3	440000	71 Kim Giang, Đại Kim, Thanh Xuân, Hà Nội	2024-11-09 07:20:50	2024-11-09 07:49:50	1998
71	2024-11-09	1	920000	65 Hạ Đình, Hạ Đình, Hai Bà Trưng, Hà Nội	2024-11-09 06:58:39	2024-11-09 07:03:39	982
72	2024-11-09	1	963000	36 Cổ Bi, Cổ Bi, Hoài Đức, Hà Nội	2024-11-09 21:22:27	2024-11-09 21:29:27	1074
73	2024-11-09	4	591000	16 Đông Mỹ, Đông Mỹ, Phúc Thọ, Hà Nội	2024-11-09 12:04:05	2024-11-09 12:11:05	846
74	2024-11-10	3	1319000	98 Nguyễn Khánh Toàn, Nghĩa Đô, Đống Đa, Hà Nội	2024-11-10 11:54:02	2024-11-10 11:59:02	913
75	2024-11-10	0	715000	39 Mễ Trì, Mễ Trì, Bắc Từ Liêm, Hà Nội	2024-11-10 11:42:58	2024-11-10 11:47:58	1486
76	2024-11-10	3	820000	24 Tây Mỗ, Đại Mỗ, Bắc Từ Liêm, Hà Nội	2024-11-10 15:58:00	2024-11-10 16:09:00	1767
77	2024-11-10	3	1590000	18 Kiêu Kỵ, Kiêu Kỵ, Hoài Đức, Hà Nội	2024-11-10 17:40:55	2024-11-10 17:45:55	506
78	2024-11-10	3	742000	76 Hoàng Văn Thái, Khương Mai, Hai Bà Trưng, Hà Nội	2024-11-10 19:13:37	2024-11-10 19:18:37	1371
79	2024-11-10	4	1475000	11 Tả Thanh Oai, Tả Thanh Oai, Phúc Thọ, Hà Nội	2024-11-10 09:18:50	2024-11-10 09:49:50	98
80	2024-11-10	3	2010000	44 Cổ Nhuế, Cổ Nhuế 1, Nam Từ Liêm, Hà Nội	2024-11-10 12:24:27	2024-11-10 12:36:27	681
81	2024-11-10	2	790000	89 Nguyễn Văn Cừ, Ngọc Lâm, Hà Đông, Hà Nội	2024-11-10 09:53:44	2024-11-10 09:58:44	1149
82	2024-11-10	0	295000	39 Nam Hồng, Nam Hồng, Đan Phượng, Hà Nội	2024-11-10 19:41:02	2024-11-10 19:46:02	362
83	2024-11-11	0	504000	52 Cát Linh, Cát Linh, Long Biên, Hà Nội	2024-11-11 19:55:23	2024-11-11 20:13:23	835
84	2024-11-11	2	1380000	16 Ngọc Hà, Ngọc Hà, Ba Đình, Hà Nội	2024-11-11 18:22:13	2024-11-11 18:33:13	991
85	2024-11-11	3	1275000	83 Cầu Giấy, Dịch Vọng, Đống Đa, Hà Nội	2024-11-11 15:03:22	2024-11-11 15:16:22	87
86	2024-11-11	3	1534000	86 Đông Hội, Đông Hội, Đan Phượng, Hà Nội	2024-11-11 20:19:49	2024-11-11 20:41:49	663
87	2024-11-11	3	547000	65 Định Công, Định Công, Thanh Xuân, Hà Nội	2024-11-11 18:15:15	2024-11-11 18:26:15	1064
88	2024-11-11	4	2203000	96 Giải Phóng, Đồng Tâm, Tây Hồ, Hà Nội	2024-11-11 14:16:39	2024-11-11 14:46:39	476
89	2024-11-11	3	1140000	30 Định Công, Định Công, Thanh Xuân, Hà Nội	2024-11-11 18:42:11	2024-11-11 18:47:11	1973
90	2024-11-11	1	1210000	78 Hồ Tùng Mậu, Mai Dịch, Đống Đa, Hà Nội	2024-11-11 14:08:21	2024-11-11 14:13:21	782
91	2024-11-12	3	1350000	1 Nguyễn Văn Lộc, Mộ Lao, Mê Linh, Hà Nội	2024-11-12 21:28:08	2024-11-12 21:33:08	1497
92	2024-11-12	3	1144000	10 Xuân Canh, Xuân Canh, Đan Phượng, Hà Nội	2024-11-12 18:52:38	2024-11-12 18:59:38	700
93	2024-11-12	3	930000	63 Ngô Quyền, Lý Thái Tổ, Hoàn Kiếm, Hà Nội	2024-11-12 17:30:45	2024-11-12 17:43:45	803
94	2024-11-12	3	1238000	59 Ngô Quyền, Lý Thái Tổ, Hoàn Kiếm, Hà Nội	2024-11-12 21:25:59	2024-11-12 21:30:59	371
95	2024-11-12	4	1010000	45 Minh Khai, Minh Khai, Tây Hồ, Hà Nội	2024-11-12 21:33:30	2024-11-12 21:38:30	1054
96	2024-11-12	3	1050000	77 Hàng Đào, Hàng Đào, Hoàn Kiếm, Hà Nội	2024-11-12 20:42:47	2024-11-12 20:47:47	474
97	2024-11-12	3	388000	30 Đa Tốn, Đa Tốn, Hoài Đức, Hà Nội	2024-11-12 05:04:41	2024-11-12 05:22:41	196
98	2024-11-12	3	1333000	72 Hạ Đình, Hạ Đình, Hai Bà Trưng, Hà Nội	2024-11-12 16:24:27	2024-11-12 16:29:27	1916
99	2024-11-13	0	920000	51 Tôn Đức Thắng, Hàng Bột, Long Biên, Hà Nội	2024-11-13 17:28:22	2024-11-13 17:33:22	1603
100	2024-11-13	2	533000	63 Đông Ngạc, Đông Ngạc, Nam Từ Liêm, Hà Nội	2024-11-13 15:41:55	2024-11-13 15:50:55	1976
101	2024-11-13	3	1005000	87 Dương Xá, Dương Xá, Hoài Đức, Hà Nội	2024-11-13 14:37:09	2024-11-13 14:47:09	1145
102	2024-11-13	1	1656000	83 Đông Mỹ, Đông Mỹ, Phúc Thọ, Hà Nội	2024-11-13 15:22:23	2024-11-13 15:27:23	1088
103	2024-11-13	3	890000	47 Giải Phóng, Đồng Tâm, Tây Hồ, Hà Nội	2024-11-13 05:18:46	2024-11-13 05:23:46	836
104	2024-11-13	3	660000	24 Bạch Mai, Bạch Mai, Tây Hồ, Hà Nội	2024-11-13 21:13:03	2024-11-13 21:22:03	378
105	2024-11-13	3	1315000	71 Định Công, Định Công, Thanh Xuân, Hà Nội	2024-11-13 20:37:20	2024-11-13 20:42:20	1230
106	2024-11-13	3	900000	13 Cầu Giấy, Dịch Vọng, Đống Đa, Hà Nội	2024-11-13 15:35:31	2024-11-13 15:44:31	673
107	2024-11-13	3	505000	59 Khâm Thiên, Khâm Thiên, Long Biên, Hà Nội	2024-11-13 18:03:30	2024-11-13 18:11:30	1149
108	2024-11-13	3	974000	59 Yên Phụ, Yên Phụ, Cầu Giấy, Hà Nội	2024-11-13 20:38:57	2024-11-13 21:05:57	1451
109	2024-11-14	3	1258000	6 Dương Xá, Dương Xá, Hoài Đức, Hà Nội	2024-11-14 12:16:13	2024-11-14 12:21:13	1740
110	2024-11-14	2	1820000	90 Yên Viên, Yên Viên, Hoài Đức, Hà Nội	2024-11-14 07:51:56	2024-11-14 07:56:56	1625
111	2024-11-14	3	1570000	72 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-11-14 08:26:24	2024-11-14 08:31:24	1634
112	2024-11-14	2	1364000	58 Tây Mỗ, Đại Mỗ, Bắc Từ Liêm, Hà Nội	2024-11-14 21:54:39	2024-11-14 21:59:39	522
113	2024-11-14	3	950000	59 Nguyễn Trãi, Thanh Xuân Trung, Hai Bà Trưng, Hà Nội	2024-11-14 08:22:26	2024-11-14 08:27:26	1022
114	2024-11-14	3	1478000	84 Ngọc Hà, Ngọc Hà, Ba Đình, Hà Nội	2024-11-14 05:57:10	2024-11-14 06:08:10	1012
115	2024-11-14	3	1088000	47 Hoàng Diệu, Điện Biên, Ba Đình, Hà Nội	2024-11-14 19:23:04	2024-11-14 19:28:04	1752
116	2024-11-14	3	895000	75 Quan Hoa, Quan Hoa, Đống Đa, Hà Nội	2024-11-14 17:05:15	2024-11-14 17:10:15	373
117	2024-11-15	3	887000	53 Lê Thanh Nghị, Bách Khoa, Tây Hồ, Hà Nội	2024-11-15 14:18:38	2024-11-15 14:23:38	454
118	2024-11-15	3	845000	15 Giảng Võ, Giảng Võ, Ba Đình, Hà Nội	2024-11-15 20:49:42	2024-11-15 21:04:42	1615
119	2024-11-15	2	1466000	79 Kim Giang, Đại Kim, Thanh Xuân, Hà Nội	2024-11-15 13:07:33	2024-11-15 13:12:33	1380
120	2024-11-15	3	313000	31 An Thượng, An Thượng, Sóc Sơn, Hà Nội	2024-11-15 06:29:18	2024-11-15 06:34:18	213
121	2024-11-15	1	799000	42 Liên Ninh, Liên Ninh, Phúc Thọ, Hà Nội	2024-11-15 21:42:55	2024-11-15 21:47:55	798
122	2024-11-15	3	1017000	89 Hoàng Văn Thái, Khương Mai, Hai Bà Trưng, Hà Nội	2024-11-15 15:18:28	2024-11-15 15:37:28	571
123	2024-11-15	3	1173000	88 Phú Diễn, Phú Diễn, Nam Từ Liêm, Hà Nội	2024-11-15 12:15:05	2024-11-15 12:50:05	1520
124	2024-11-16	3	1245000	54 Ngọc Hà, Ngọc Hà, Ba Đình, Hà Nội	2024-11-16 06:57:27	2024-11-16 07:02:27	279
125	2024-11-16	2	340000	49 Kim Giang, Đại Kim, Thanh Xuân, Hà Nội	2024-11-16 06:50:02	2024-11-16 07:25:02	676
126	2024-11-16	3	485000	21 Đa Tốn, Đa Tốn, Hoài Đức, Hà Nội	2024-11-16 14:22:14	2024-11-16 14:27:14	166
127	2024-11-16	2	1148000	89 An Thượng, An Thượng, Sóc Sơn, Hà Nội	2024-11-16 19:12:40	2024-11-16 19:17:40	914
128	2024-11-16	2	1235000	12 Đại Áng, Đại Áng, Phúc Thọ, Hà Nội	2024-11-16 06:36:57	2024-11-16 06:47:57	507
129	2024-11-16	3	1142000	63 Tân Mai, Tân Mai, Thanh Xuân, Hà Nội	2024-11-16 19:06:25	2024-11-16 19:13:25	1169
130	2024-11-16	3	801000	31 Thụy Khuê, Thụy Khuê, Cầu Giấy, Hà Nội	2024-11-16 11:02:49	2024-11-16 11:07:49	123
131	2024-11-16	1	1565000	32 Lê Thanh Nghị, Bách Khoa, Tây Hồ, Hà Nội	2024-11-16 09:41:29	2024-11-16 09:48:29	1807
132	2024-11-17	1	1600000	84 Ngũ Hiệp, Ngũ Hiệp, Phúc Thọ, Hà Nội	2024-11-17 11:39:08	2024-11-17 11:49:08	123
133	2024-11-17	2	958000	97 An Khánh, An Khánh, Sóc Sơn, Hà Nội	2024-11-17 19:26:07	2024-11-17 19:31:07	992
134	2024-11-17	4	1998000	65 Láng Hạ, Láng Hạ, Long Biên, Hà Nội	2024-11-17 10:39:05	2024-11-17 11:00:05	864
135	2024-11-17	2	665000	79 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-11-17 17:55:32	2024-11-17 18:06:32	901
136	2024-11-17	2	893000	93 Tôn Đức Thắng, Hàng Bột, Long Biên, Hà Nội	2024-11-17 20:42:05	2024-11-17 20:50:05	1651
137	2024-11-17	2	1169000	32 Hải Bối, Hải Bối, Đan Phượng, Hà Nội	2024-11-17 05:45:37	2024-11-17 05:50:37	376
138	2024-11-17	1	1098000	31 Xuân La, Xuân La, Cầu Giấy, Hà Nội	2024-11-17 15:36:19	2024-11-17 15:51:19	628
139	2024-11-17	2	878000	58 Giảng Võ, Giảng Võ, Ba Đình, Hà Nội	2024-11-17 13:57:15	2024-11-17 14:07:15	1045
140	2024-11-18	1	722000	71 Cát Linh, Cát Linh, Long Biên, Hà Nội	2024-11-18 13:32:27	2024-11-18 13:37:27	671
141	2024-11-18	3	676000	42 Gia Thụy, Gia Thụy, Hà Đông, Hà Nội	2024-11-18 15:01:10	2024-11-18 15:06:10	1147
142	2024-11-18	3	1974000	61 Nam Hồng, Nam Hồng, Đan Phượng, Hà Nội	2024-11-18 17:39:52	2024-11-18 18:13:52	999
143	2024-11-18	2	2278000	34 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-11-18 08:58:52	2024-11-18 09:03:52	1615
144	2024-11-18	3	828000	2 Phú Đô, Phú Đô, Bắc Từ Liêm, Hà Nội	2024-11-18 20:12:29	2024-11-18 20:39:29	1045
145	2024-11-18	3	1638000	23 Xuân La, Xuân La, Cầu Giấy, Hà Nội	2024-11-18 18:47:01	2024-11-18 18:58:01	1189
146	2024-11-18	3	905000	94 Đông Hội, Đông Hội, Đan Phượng, Hà Nội	2024-11-18 21:06:00	2024-11-18 21:11:00	1315
147	2024-11-19	3	1091000	68 Lê Thanh Nghị, Bách Khoa, Tây Hồ, Hà Nội	2024-11-19 09:12:43	2024-11-19 09:21:43	706
148	2024-11-19	3	698000	71 Hàng Bạc, Hàng Bạc, Hoàn Kiếm, Hà Nội	2024-11-19 06:08:14	2024-11-19 06:13:14	1190
149	2024-11-19	1	1179000	79 Liên Ninh, Liên Ninh, Phúc Thọ, Hà Nội	2024-11-19 13:14:34	2024-11-19 13:21:34	1943
150	2024-11-19	3	1070000	77 Cầu Giấy, Dịch Vọng, Đống Đa, Hà Nội	2024-11-19 11:20:12	2024-11-19 11:25:12	1604
151	2024-11-19	3	1960000	24 Ngô Quyền, Lý Thái Tổ, Hoàn Kiếm, Hà Nội	2024-11-19 14:27:33	2024-11-19 14:32:33	1611
152	2024-11-19	3	1186000	12 Ngọc Lâm, Bồ Đề, Hà Đông, Hà Nội	2024-11-19 15:35:15	2024-11-19 15:57:15	743
153	2024-11-19	3	760000	86 Ngô Gia Tự, Đức Giang, Hà Đông, Hà Nội	2024-11-19 21:09:27	2024-11-19 21:14:27	1050
154	2024-11-19	3	1055000	14 Yên Phụ, Yên Phụ, Cầu Giấy, Hà Nội	2024-11-19 15:56:43	2024-11-19 16:01:43	580
155	2024-11-19	2	756000	51 Phú Diễn, Phú Diễn, Nam Từ Liêm, Hà Nội	2024-11-19 07:59:30	2024-11-19 08:44:30	546
156	2024-11-19	3	870000	13 Liên Mạc, Liên Mạc, Nam Từ Liêm, Hà Nội	2024-11-19 06:19:55	2024-11-19 06:33:55	1051
157	2024-11-20	1	1726000	48 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-11-20 06:46:42	2024-11-20 06:56:42	823
158	2024-11-20	3	1145000	72 Láng Hạ, Láng Hạ, Long Biên, Hà Nội	2024-11-20 19:46:53	2024-11-20 19:52:53	1888
159	2024-11-20	3	424000	24 Đa Tốn, Đa Tốn, Hoài Đức, Hà Nội	2024-11-20 07:26:59	2024-11-20 07:31:59	1356
160	2024-11-20	3	1444000	81 Tả Thanh Oai, Tả Thanh Oai, Phúc Thọ, Hà Nội	2024-11-20 17:01:21	2024-11-20 17:06:21	1434
161	2024-11-20	3	1539000	83 Cổ Bi, Cổ Bi, Hoài Đức, Hà Nội	2024-11-20 07:38:38	2024-11-20 07:43:38	1986
162	2024-11-20	3	1230000	90 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-11-20 06:59:13	2024-11-20 07:23:13	763
163	2024-11-20	3	560000	50 Lê Lợi, Hà Cầu, Mê Linh, Hà Nội	2024-11-20 08:01:24	2024-11-20 08:06:24	820
164	2024-11-20	1	620000	15 Cổ Bi, Cổ Bi, Hoài Đức, Hà Nội	2024-11-20 12:15:38	2024-11-20 12:20:38	1205
165	2024-11-21	3	536000	87 Hồ Tùng Mậu, Mai Dịch, Đống Đa, Hà Nội	2024-11-21 19:52:57	2024-11-21 19:58:57	1238
166	2024-11-21	3	840000	64 Ngọc Lâm, Bồ Đề, Hà Đông, Hà Nội	2024-11-21 19:19:31	2024-11-21 19:30:31	738
167	2024-11-21	3	828000	37 Hải Bối, Hải Bối, Đan Phượng, Hà Nội	2024-11-21 18:38:31	2024-11-21 18:46:31	126
168	2024-11-21	4	1790000	24 Kim Mã, Kim Mã, Ba Đình, Hà Nội	2024-11-21 15:19:56	2024-11-21 15:39:56	367
169	2024-11-21	3	1380000	73 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-11-21 11:22:10	2024-11-21 11:27:10	330
170	2024-11-21	2	1734000	66 Liên Mạc, Liên Mạc, Nam Từ Liêm, Hà Nội	2024-11-21 14:38:31	2024-11-21 14:43:31	1132
171	2024-11-21	1	190000	55 Kiêu Kỵ, Kiêu Kỵ, Hoài Đức, Hà Nội	2024-11-21 07:19:08	2024-11-21 07:24:08	289
172	2024-11-21	3	930000	62 Dương Liễu, Dương Liễu, Sóc Sơn, Hà Nội	2024-11-21 08:51:35	2024-11-21 08:56:35	1095
173	2024-11-22	3	1335000	74 Láng Hạ, Láng Hạ, Long Biên, Hà Nội	2024-11-22 19:41:30	2024-11-22 19:46:30	598
174	2024-11-22	4	1438000	99 Gia Thụy, Gia Thụy, Hà Đông, Hà Nội	2024-11-22 18:42:11	2024-11-22 18:52:11	299
175	2024-11-22	2	628000	52 Giải Phóng, Đồng Tâm, Tây Hồ, Hà Nội	2024-11-22 07:45:39	2024-11-22 07:50:39	1450
176	2024-11-22	3	758000	90 Lê Thanh Nghị, Bách Khoa, Tây Hồ, Hà Nội	2024-11-22 11:03:40	2024-11-22 11:08:40	1665
177	2024-11-22	2	1015000	73 Khâm Thiên, Khâm Thiên, Long Biên, Hà Nội	2024-11-22 18:16:20	2024-11-22 18:21:20	1724
178	2024-11-22	3	710000	4 Hồ Tùng Mậu, Mai Dịch, Đống Đa, Hà Nội	2024-11-22 10:03:31	2024-11-22 10:08:31	1233
179	2024-11-22	3	980000	68 Mễ Trì, Mễ Trì, Bắc Từ Liêm, Hà Nội	2024-11-22 21:49:50	2024-11-22 22:06:50	629
180	2024-11-22	0	1264000	36 Yên Viên, Yên Viên, Hoài Đức, Hà Nội	2024-11-22 07:46:56	2024-11-22 07:53:56	352
181	2024-11-22	2	791000	31 Hạ Đình, Hạ Đình, Hai Bà Trưng, Hà Nội	2024-11-22 10:59:16	2024-11-22 11:21:16	1254
182	2024-11-23	3	748000	13 Hải Bối, Hải Bối, Đan Phượng, Hà Nội	2024-11-23 05:39:47	2024-11-23 05:44:47	1407
183	2024-11-23	3	445000	88 Dương Xá, Dương Xá, Hoài Đức, Hà Nội	2024-11-23 11:28:16	2024-11-23 11:33:16	1228
184	2024-11-23	3	1170000	51 Cổ Bi, Cổ Bi, Hoài Đức, Hà Nội	2024-11-23 19:49:01	2024-11-23 19:54:01	927
185	2024-11-23	3	1327000	82 Kim Giang, Đại Kim, Thanh Xuân, Hà Nội	2024-11-23 11:22:45	2024-11-23 11:29:45	581
186	2024-11-23	2	1500000	57 Đại Áng, Đại Áng, Phúc Thọ, Hà Nội	2024-11-23 05:52:34	2024-11-23 06:25:34	1059
187	2024-11-23	3	814000	18 Kim Giang, Đại Kim, Thanh Xuân, Hà Nội	2024-11-23 12:49:24	2024-11-23 13:04:24	1861
188	2024-11-23	3	1645000	85 Ngô Gia Tự, Đức Giang, Hà Đông, Hà Nội	2024-11-23 09:00:20	2024-11-23 09:08:20	730
189	2024-11-23	1	1052000	8 Kim Mã, Kim Mã, Ba Đình, Hà Nội	2024-11-23 21:23:01	2024-11-23 21:28:01	274
190	2024-11-23	0	450000	15 Tả Thanh Oai, Tả Thanh Oai, Phúc Thọ, Hà Nội	2024-11-23 21:53:07	2024-11-23 21:58:07	656
191	2024-11-23	3	856000	25 Kim Mã, Kim Mã, Ba Đình, Hà Nội	2024-11-23 09:28:46	2024-11-23 09:40:46	831
192	2024-11-24	3	1075000	60 Cự Khối, Cự Khối, Hà Đông, Hà Nội	2024-11-24 19:29:02	2024-11-24 19:34:02	190
193	2024-11-24	4	1476000	64 Liên Mạc, Liên Mạc, Nam Từ Liêm, Hà Nội	2024-11-24 19:05:21	2024-11-24 19:10:21	746
194	2024-11-24	1	626000	68 Đào Tấn, Cống Vị, Ba Đình, Hà Nội	2024-11-24 18:19:47	2024-11-24 18:31:47	139
195	2024-11-24	0	935000	38 Ngũ Hiệp, Ngũ Hiệp, Phúc Thọ, Hà Nội	2024-11-24 05:44:30	2024-11-24 05:58:30	141
196	2024-11-24	2	1220000	42 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-11-24 16:53:00	2024-11-24 17:30:00	486
197	2024-11-24	3	928000	44 Kim Mã, Kim Mã, Ba Đình, Hà Nội	2024-11-24 16:43:50	2024-11-24 16:49:50	514
198	2024-11-24	3	1468000	51 Lê Thanh Nghị, Bách Khoa, Tây Hồ, Hà Nội	2024-11-24 10:13:36	2024-11-24 10:24:36	1740
199	2024-11-25	3	1537000	33 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-11-25 21:00:42	2024-11-25 21:10:42	1234
200	2024-11-25	3	1848000	23 Phú Diễn, Phú Diễn, Nam Từ Liêm, Hà Nội	2024-11-25 16:11:55	2024-11-25 16:16:55	1178
201	2024-11-25	3	800000	34 Đào Tấn, Cống Vị, Ba Đình, Hà Nội	2024-11-25 11:43:41	2024-11-25 11:48:41	738
202	2024-11-25	3	615000	5 Kim Mã, Kim Mã, Ba Đình, Hà Nội	2024-11-25 18:59:51	2024-11-25 19:04:51	1362
203	2024-11-25	2	321000	60 Hàng Bạc, Hàng Bạc, Hoàn Kiếm, Hà Nội	2024-11-25 21:05:29	2024-11-25 21:10:29	760
204	2024-11-25	1	1319000	40 Xã Đàn, Ô Chợ Dừa, Long Biên, Hà Nội	2024-11-25 21:27:58	2024-11-25 21:32:58	1758
205	2024-11-25	0	898000	23 La Phù, La Phù, Sóc Sơn, Hà Nội	2024-11-25 13:16:44	2024-11-25 13:25:44	1182
206	2024-11-25	3	784000	13 Kiêu Kỵ, Kiêu Kỵ, Hoài Đức, Hà Nội	2024-11-25 11:21:45	2024-11-25 11:34:45	106
207	2024-11-25	1	970000	86 Đông Ngạc, Đông Ngạc, Nam Từ Liêm, Hà Nội	2024-11-25 19:53:47	2024-11-25 19:58:47	113
208	2024-11-25	3	668000	57 Tả Thanh Oai, Tả Thanh Oai, Phúc Thọ, Hà Nội	2024-11-25 20:23:03	2024-11-25 20:28:03	1967
209	2024-11-26	3	1266000	84 La Phù, La Phù, Sóc Sơn, Hà Nội	2024-11-26 07:50:33	2024-11-26 07:55:33	648
210	2024-11-26	3	940000	10 Hàng Bài, Hàng Bài, Hoàn Kiếm, Hà Nội	2024-11-26 08:04:55	2024-11-26 08:32:55	1181
211	2024-11-26	0	2392000	15 Đại Mỗ, Tây Mỗ, Bắc Từ Liêm, Hà Nội	2024-11-26 08:34:13	2024-11-26 08:39:13	1581
212	2024-11-26	3	770000	23 Hàng Bạc, Hàng Bạc, Hoàn Kiếm, Hà Nội	2024-11-26 14:10:52	2024-11-26 14:28:52	464
213	2024-11-26	3	395000	95 Đông Mỹ, Đông Mỹ, Phúc Thọ, Hà Nội	2024-11-26 10:36:48	2024-11-26 10:48:48	1977
214	2024-11-26	1	1190000	77 Nguyễn Trãi, Thanh Xuân Trung, Hai Bà Trưng, Hà Nội	2024-11-26 06:20:49	2024-11-26 06:29:49	477
215	2024-11-26	3	1620000	4 Giảng Võ, Giảng Võ, Ba Đình, Hà Nội	2024-11-26 10:15:15	2024-11-26 10:20:15	1510
216	2024-11-26	3	1220000	61 Kiêu Kỵ, Kiêu Kỵ, Hoài Đức, Hà Nội	2024-11-26 21:07:51	2024-11-26 21:12:51	609
217	2024-11-27	3	1260000	87 Khâm Thiên, Khâm Thiên, Long Biên, Hà Nội	2024-11-27 06:57:41	2024-11-27 07:05:41	1781
218	2024-11-27	1	618000	37 Đại Mỗ, Tây Mỗ, Bắc Từ Liêm, Hà Nội	2024-11-27 09:38:08	2024-11-27 09:44:08	1051
219	2024-11-27	3	995000	3 Nguyễn Trãi, Thanh Xuân Trung, Hai Bà Trưng, Hà Nội	2024-11-27 07:58:06	2024-11-27 08:03:06	1664
220	2024-11-27	4	428000	18 Âu Cơ, Nhật Tân, Cầu Giấy, Hà Nội	2024-11-27 19:49:17	2024-11-27 19:54:17	800
221	2024-11-27	3	1289000	83 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-11-27 17:57:30	2024-11-27 18:29:30	358
222	2024-11-27	3	1810000	79 Cổ Nhuế, Cổ Nhuế 1, Nam Từ Liêm, Hà Nội	2024-11-27 11:17:55	2024-11-27 11:29:55	64
223	2024-11-27	3	988000	8 Hồ Tùng Mậu, Mai Dịch, Đống Đa, Hà Nội	2024-11-27 21:14:37	2024-11-27 21:19:37	1796
224	2024-11-28	3	790000	79 An Khánh, An Khánh, Sóc Sơn, Hà Nội	2024-11-28 14:18:00	2024-11-28 14:30:00	577
225	2024-11-28	3	867000	88 Đông Ngạc, Đông Ngạc, Nam Từ Liêm, Hà Nội	2024-11-28 21:58:15	2024-11-28 22:03:15	580
226	2024-11-28	2	865000	54 Khâm Thiên, Khâm Thiên, Long Biên, Hà Nội	2024-11-28 09:48:22	2024-11-28 09:53:22	509
227	2024-11-28	3	1080000	30 Định Công, Định Công, Thanh Xuân, Hà Nội	2024-11-28 06:37:49	2024-11-28 06:49:49	453
228	2024-11-28	3	1280000	97 Yên Phụ, Yên Phụ, Cầu Giấy, Hà Nội	2024-11-28 20:30:24	2024-11-28 20:35:24	928
229	2024-11-28	1	930000	50 Hoàng Văn Thái, Khương Mai, Hai Bà Trưng, Hà Nội	2024-11-28 16:54:02	2024-11-28 16:59:02	663
230	2024-11-28	3	1495000	74 Vân Canh, Vân Canh, Sóc Sơn, Hà Nội	2024-11-28 17:42:54	2024-11-28 18:18:54	622
231	2024-11-28	1	938000	42 Nguyễn Văn Lộc, Mộ Lao, Mê Linh, Hà Nội	2024-11-28 18:30:33	2024-11-28 18:36:33	971
232	2024-11-28	3	1364000	10 Đông Ngạc, Đông Ngạc, Nam Từ Liêm, Hà Nội	2024-11-28 18:57:22	2024-11-28 19:09:22	78
233	2024-11-28	3	1478000	58 Cổ Loa, Cổ Loa, Đan Phượng, Hà Nội	2024-11-28 21:45:33	2024-11-28 21:56:33	1525
234	2024-11-29	3	1920000	35 Yên Viên, Yên Viên, Hoài Đức, Hà Nội	2024-11-29 16:10:54	2024-11-29 16:15:54	716
235	2024-11-29	3	380000	99 Gia Thụy, Gia Thụy, Hà Đông, Hà Nội	2024-11-29 17:10:08	2024-11-29 17:18:08	1127
236	2024-11-29	3	621000	91 Tân Mai, Tân Mai, Thanh Xuân, Hà Nội	2024-11-29 20:24:07	2024-11-29 20:29:07	1366
237	2024-11-29	0	830000	65 Xã Đàn, Ô Chợ Dừa, Long Biên, Hà Nội	2024-11-29 08:23:14	2024-11-29 08:46:14	1896
238	2024-11-29	1	419000	71 Đại Áng, Đại Áng, Phúc Thọ, Hà Nội	2024-11-29 12:38:38	2024-11-29 12:49:38	1947
239	2024-11-29	3	1270000	42 An Thượng, An Thượng, Sóc Sơn, Hà Nội	2024-11-29 17:13:34	2024-11-29 17:18:34	368
240	2024-11-29	3	1597000	24 Nguyễn Văn Cừ, Ngọc Lâm, Hà Đông, Hà Nội	2024-11-29 19:49:12	2024-11-29 19:58:12	1556
241	2024-11-29	2	1438000	39 Âu Cơ, Nhật Tân, Cầu Giấy, Hà Nội	2024-11-29 18:27:55	2024-11-29 18:32:55	1057
242	2024-11-29	3	783000	62 Yên Viên, Yên Viên, Hoài Đức, Hà Nội	2024-11-29 19:01:42	2024-11-29 19:09:42	1611
243	2024-11-29	3	1465000	52 Hàng Đào, Hàng Đào, Hoàn Kiếm, Hà Nội	2024-11-29 19:56:42	2024-11-29 20:01:42	981
244	2024-11-30	1	937000	5 Quan Hoa, Quan Hoa, Đống Đa, Hà Nội	2024-11-30 11:01:14	2024-11-30 11:06:14	647
245	2024-11-30	3	546000	56 Hải Bối, Hải Bối, Đan Phượng, Hà Nội	2024-11-30 21:06:41	2024-11-30 21:11:41	1326
246	2024-11-30	2	978000	96 Kim Giang, Đại Kim, Thanh Xuân, Hà Nội	2024-11-30 10:25:20	2024-11-30 10:30:20	1839
247	2024-11-30	2	1176000	25 Đại Mỗ, Tây Mỗ, Bắc Từ Liêm, Hà Nội	2024-11-30 10:44:16	2024-11-30 10:53:16	736
248	2024-11-30	3	1189000	68 Nguyễn Văn Cừ, Ngọc Lâm, Hà Đông, Hà Nội	2024-11-30 14:27:28	2024-11-30 14:35:28	1845
249	2024-11-30	3	1043000	72 Gia Thụy, Gia Thụy, Hà Đông, Hà Nội	2024-11-30 20:58:07	2024-11-30 21:04:07	1130
250	2024-11-30	3	1697000	42 Dương Xá, Dương Xá, Hoài Đức, Hà Nội	2024-11-30 19:50:32	2024-11-30 19:55:32	1962
251	2024-11-30	3	795000	59 Giáp Bát, Giáp Bát, Thanh Xuân, Hà Nội	2024-11-30 19:59:43	2024-11-30 20:09:43	797
252	2024-12-01	3	1286000	96 Ngô Quyền, Lý Thái Tổ, Hoàn Kiếm, Hà Nội	2024-12-01 19:26:09	2024-12-01 19:34:09	1935
253	2024-12-01	3	780000	24 Khâm Thiên, Khâm Thiên, Long Biên, Hà Nội	2024-12-01 13:35:36	2024-12-01 13:58:36	452
254	2024-12-01	3	1356000	73 Hải Bối, Hải Bối, Đan Phượng, Hà Nội	2024-12-01 11:27:56	2024-12-01 11:52:56	182
255	2024-12-01	2	1590000	64 Nguyễn Khánh Toàn, Nghĩa Đô, Đống Đa, Hà Nội	2024-12-01 14:41:10	2024-12-01 14:46:10	54
256	2024-12-01	1	1085000	62 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-12-01 18:14:07	2024-12-01 18:24:07	1527
257	2024-12-01	2	513000	46 Tả Thanh Oai, Tả Thanh Oai, Phúc Thọ, Hà Nội	2024-12-01 15:58:13	2024-12-01 16:12:13	454
258	2024-12-01	2	896000	98 Nguyễn Hữu Thọ, Hoàng Liệt, Thanh Xuân, Hà Nội	2024-12-01 20:40:59	2024-12-01 20:51:59	1012
259	2024-12-01	0	442000	53 Xuân La, Xuân La, Cầu Giấy, Hà Nội	2024-12-01 21:59:35	2024-12-01 22:09:35	1533
260	2024-12-01	3	2100000	25 An Thượng, An Thượng, Sóc Sơn, Hà Nội	2024-12-01 20:59:27	2024-12-01 21:04:27	1986
261	2024-12-02	2	516000	84 Bạch Mai, Bạch Mai, Tây Hồ, Hà Nội	2024-12-02 09:32:30	2024-12-02 09:47:30	1744
262	2024-12-02	3	608000	84 Nguyễn Văn Cừ, Ngọc Lâm, Hà Đông, Hà Nội	2024-12-02 15:22:32	2024-12-02 15:27:32	1672
263	2024-12-02	3	1196000	91 Hàng Bạc, Hàng Bạc, Hoàn Kiếm, Hà Nội	2024-12-02 07:28:38	2024-12-02 07:35:38	1850
264	2024-12-02	3	780000	48 Cổ Bi, Cổ Bi, Hoài Đức, Hà Nội	2024-12-02 17:01:50	2024-12-02 17:06:50	211
265	2024-12-02	0	750000	74 Hoàng Văn Thái, Khương Mai, Hai Bà Trưng, Hà Nội	2024-12-02 09:34:56	2024-12-02 09:39:56	1752
266	2024-12-02	1	1060000	97 Nguyễn Trãi, Thanh Xuân Trung, Hai Bà Trưng, Hà Nội	2024-12-02 14:46:12	2024-12-02 14:51:12	673
267	2024-12-02	3	804000	92 Dương Liễu, Dương Liễu, Sóc Sơn, Hà Nội	2024-12-02 12:53:25	2024-12-02 12:58:25	1870
268	2024-12-02	3	1358000	89 Yên Nghĩa, Yên Nghĩa, Mê Linh, Hà Nội	2024-12-02 13:29:55	2024-12-02 13:34:55	461
269	2024-12-03	2	536000	71 Tân Mai, Tân Mai, Thanh Xuân, Hà Nội	2024-12-03 17:15:41	2024-12-03 17:48:41	508
270	2024-12-03	1	436000	60 Xã Đàn, Ô Chợ Dừa, Long Biên, Hà Nội	2024-12-03 14:48:00	2024-12-03 14:54:00	1677
271	2024-12-03	1	1419000	90 Đông Ngạc, Đông Ngạc, Nam Từ Liêm, Hà Nội	2024-12-03 07:47:02	2024-12-03 07:52:02	1360
272	2024-12-03	3	945000	85 Yên Nghĩa, Yên Nghĩa, Mê Linh, Hà Nội	2024-12-03 15:05:27	2024-12-03 15:14:27	181
273	2024-12-03	2	1184000	75 Khâm Thiên, Khâm Thiên, Long Biên, Hà Nội	2024-12-03 14:40:11	2024-12-03 14:45:11	945
274	2024-12-03	3	1356000	39 Tây Mỗ, Đại Mỗ, Bắc Từ Liêm, Hà Nội	2024-12-03 19:44:09	2024-12-03 20:29:09	369
275	2024-12-03	3	775000	88 La Phù, La Phù, Sóc Sơn, Hà Nội	2024-12-03 21:31:09	2024-12-03 21:36:09	1508
276	2024-12-03	3	328000	97 Thụy Phương, Thụy Phương, Nam Từ Liêm, Hà Nội	2024-12-03 20:40:16	2024-12-03 20:45:16	1540
277	2024-12-04	3	1050000	20 Tôn Đức Thắng, Hàng Bột, Long Biên, Hà Nội	2024-12-04 21:51:29	2024-12-04 21:56:29	1282
278	2024-12-04	3	1205000	16 Xã Đàn, Ô Chợ Dừa, Long Biên, Hà Nội	2024-12-04 19:32:08	2024-12-04 20:07:08	1958
279	2024-12-04	3	1055000	40 Gia Thụy, Gia Thụy, Hà Đông, Hà Nội	2024-12-04 17:45:04	2024-12-04 17:50:04	352
280	2024-12-04	3	790000	6 An Thượng, An Thượng, Sóc Sơn, Hà Nội	2024-12-04 08:00:19	2024-12-04 08:05:19	1716
281	2024-12-04	2	1078000	89 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-12-04 12:35:08	2024-12-04 12:40:08	521
282	2024-12-04	1	1093000	93 Gia Thụy, Gia Thụy, Hà Đông, Hà Nội	2024-12-04 16:55:38	2024-12-04 17:13:38	1990
283	2024-12-04	3	1335000	6 Giảng Võ, Giảng Võ, Ba Đình, Hà Nội	2024-12-04 06:09:39	2024-12-04 06:21:39	720
284	2024-12-04	1	1075000	44 Thụy Phương, Thụy Phương, Nam Từ Liêm, Hà Nội	2024-12-04 08:32:00	2024-12-04 08:40:00	1726
285	2024-12-04	1	638000	29 Lê Lợi, Hà Cầu, Mê Linh, Hà Nội	2024-12-04 20:35:31	2024-12-04 20:40:31	1407
286	2024-12-05	1	1269000	66 Bạch Mai, Bạch Mai, Tây Hồ, Hà Nội	2024-12-05 13:13:40	2024-12-05 13:32:40	700
287	2024-12-05	3	1673000	98 Đại Mỗ, Tây Mỗ, Bắc Từ Liêm, Hà Nội	2024-12-05 19:54:50	2024-12-05 20:00:50	1994
288	2024-12-05	3	2165000	38 Giải Phóng, Đồng Tâm, Tây Hồ, Hà Nội	2024-12-05 21:58:57	2024-12-05 22:07:57	622
289	2024-12-05	3	935000	56 Nguyễn Trãi, Thanh Xuân Trung, Hai Bà Trưng, Hà Nội	2024-12-05 12:36:55	2024-12-05 12:47:55	620
290	2024-12-05	3	1148000	5 Cự Khối, Cự Khối, Hà Đông, Hà Nội	2024-12-05 18:17:12	2024-12-05 18:47:12	1778
291	2024-12-05	3	1060000	54 Gia Thụy, Gia Thụy, Hà Đông, Hà Nội	2024-12-05 16:04:57	2024-12-05 16:10:57	1192
292	2024-12-05	2	1535000	29 Xã Đàn, Ô Chợ Dừa, Long Biên, Hà Nội	2024-12-05 19:50:51	2024-12-05 19:56:51	771
293	2024-12-05	0	1105000	61 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-12-05 18:07:02	2024-12-05 18:24:02	556
294	2024-12-06	1	1050000	26 An Thượng, An Thượng, Sóc Sơn, Hà Nội	2024-12-06 13:17:00	2024-12-06 14:02:00	1748
295	2024-12-06	3	1218000	65 An Khánh, An Khánh, Sóc Sơn, Hà Nội	2024-12-06 18:18:43	2024-12-06 18:23:43	1887
296	2024-12-06	3	1302000	60 Giáp Bát, Giáp Bát, Thanh Xuân, Hà Nội	2024-12-06 19:25:51	2024-12-06 19:39:51	1233
297	2024-12-06	3	955000	22 Đông Mỹ, Đông Mỹ, Phúc Thọ, Hà Nội	2024-12-06 09:03:01	2024-12-06 09:08:01	1483
298	2024-12-06	3	1288000	83 Kim Giang, Đại Kim, Thanh Xuân, Hà Nội	2024-12-06 13:00:33	2024-12-06 13:05:33	1987
299	2024-12-06	3	859000	25 Tả Thanh Oai, Tả Thanh Oai, Phúc Thọ, Hà Nội	2024-12-06 20:15:25	2024-12-06 20:20:25	927
300	2024-12-06	2	1861000	84 Nguyễn Văn Cừ, Ngọc Lâm, Hà Đông, Hà Nội	2024-12-06 18:19:14	2024-12-06 18:36:14	299
301	2024-12-06	3	990000	23 Cổ Bi, Cổ Bi, Hoài Đức, Hà Nội	2024-12-06 20:02:40	2024-12-06 20:07:40	1262
302	2024-12-07	3	1138000	38 Cầu Giấy, Dịch Vọng, Đống Đa, Hà Nội	2024-12-07 09:25:37	2024-12-07 09:30:37	700
303	2024-12-07	3	1123000	15 Minh Khai, Minh Khai, Tây Hồ, Hà Nội	2024-12-07 17:17:54	2024-12-07 17:22:54	1031
304	2024-12-07	3	850000	45 Cổ Loa, Cổ Loa, Đan Phượng, Hà Nội	2024-12-07 21:24:09	2024-12-07 21:29:09	1788
305	2024-12-07	3	1114000	67 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-12-07 09:32:51	2024-12-07 09:42:51	491
306	2024-12-07	3	1318000	91 Giảng Võ, Giảng Võ, Ba Đình, Hà Nội	2024-12-07 20:04:00	2024-12-07 20:10:00	1022
307	2024-12-07	3	635000	20 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-12-07 10:40:18	2024-12-07 10:45:18	716
308	2024-12-07	4	1766000	76 Cự Khối, Cự Khối, Hà Đông, Hà Nội	2024-12-07 05:15:53	2024-12-07 05:38:53	671
309	2024-12-07	2	740000	13 Ngô Gia Tự, Đức Giang, Hà Đông, Hà Nội	2024-12-07 20:30:24	2024-12-07 20:42:24	1240
310	2024-12-08	2	920000	30 Xuân Canh, Xuân Canh, Đan Phượng, Hà Nội	2024-12-08 12:22:02	2024-12-08 12:29:02	1440
311	2024-12-08	3	598000	39 Gia Thụy, Gia Thụy, Hà Đông, Hà Nội	2024-12-08 14:48:49	2024-12-08 14:53:49	1105
312	2024-12-08	3	594000	44 Mễ Trì, Mễ Trì, Bắc Từ Liêm, Hà Nội	2024-12-08 07:26:28	2024-12-08 07:56:28	577
313	2024-12-08	3	1808000	52 Tôn Đức Thắng, Hàng Bột, Long Biên, Hà Nội	2024-12-08 20:56:03	2024-12-08 21:04:03	267
314	2024-12-08	3	936000	14 Xuân Canh, Xuân Canh, Đan Phượng, Hà Nội	2024-12-08 06:56:43	2024-12-08 07:01:43	1489
315	2024-12-08	3	1485000	64 Đại Mỗ, Tây Mỗ, Bắc Từ Liêm, Hà Nội	2024-12-08 21:02:26	2024-12-08 21:47:26	1182
316	2024-12-08	3	604000	66 Liên Mạc, Liên Mạc, Nam Từ Liêm, Hà Nội	2024-12-08 20:40:30	2024-12-08 20:53:30	1362
317	2024-12-09	3	580000	98 Cầu Giấy, Dịch Vọng, Đống Đa, Hà Nội	2024-12-09 20:09:49	2024-12-09 20:14:49	882
318	2024-12-09	2	1865000	41 Nguyễn Văn Lộc, Mộ Lao, Mê Linh, Hà Nội	2024-12-09 12:37:23	2024-12-09 12:42:23	403
319	2024-12-09	3	825000	76 Hồ Tùng Mậu, Mai Dịch, Đống Đa, Hà Nội	2024-12-09 21:54:40	2024-12-09 22:04:40	1465
320	2024-12-09	3	920000	6 Tân Mai, Tân Mai, Thanh Xuân, Hà Nội	2024-12-09 14:28:59	2024-12-09 15:13:59	507
321	2024-12-09	3	799000	19 Nguyễn Văn Cừ, Ngọc Lâm, Hà Đông, Hà Nội	2024-12-09 18:29:11	2024-12-09 18:46:11	857
322	2024-12-09	0	1478000	27 Cổ Bi, Cổ Bi, Hoài Đức, Hà Nội	2024-12-09 21:10:11	2024-12-09 21:15:11	1169
323	2024-12-09	3	985000	39 Hàng Đào, Hàng Đào, Hoàn Kiếm, Hà Nội	2024-12-09 08:39:46	2024-12-09 08:44:46	1280
324	2024-12-09	4	551000	75 Hàng Bài, Hàng Bài, Hoàn Kiếm, Hà Nội	2024-12-09 11:37:49	2024-12-09 11:42:49	1581
325	2024-12-09	4	760000	18 Ngọc Lâm, Bồ Đề, Hà Đông, Hà Nội	2024-12-09 06:22:11	2024-12-09 06:35:11	927
326	2024-12-09	1	2518000	23 Đào Tấn, Cống Vị, Ba Đình, Hà Nội	2024-12-09 14:50:22	2024-12-09 14:55:22	1763
327	2024-12-10	3	1210000	80 Mễ Trì, Mễ Trì, Bắc Từ Liêm, Hà Nội	2024-12-10 19:49:37	2024-12-10 19:54:37	734
328	2024-12-10	2	604000	39 Ngọc Hà, Ngọc Hà, Ba Đình, Hà Nội	2024-12-10 06:37:42	2024-12-10 06:42:42	534
329	2024-12-10	3	598000	38 Dương Xá, Dương Xá, Hoài Đức, Hà Nội	2024-12-10 21:24:34	2024-12-10 22:09:34	1581
330	2024-12-10	1	634000	2 Đông Hội, Đông Hội, Đan Phượng, Hà Nội	2024-12-10 19:40:51	2024-12-10 19:45:51	1790
331	2024-12-10	2	895000	61 Nguyễn Văn Lộc, Mộ Lao, Mê Linh, Hà Nội	2024-12-10 10:52:40	2024-12-10 11:18:40	414
332	2024-12-10	3	1237000	60 Ngô Gia Tự, Đức Giang, Hà Đông, Hà Nội	2024-12-10 05:35:10	2024-12-10 05:40:10	1506
333	2024-12-10	2	1149000	35 Nguyễn Trãi, Thanh Xuân Trung, Hai Bà Trưng, Hà Nội	2024-12-10 07:29:45	2024-12-10 07:34:45	386
334	2024-12-10	3	856000	36 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-12-10 21:14:12	2024-12-10 21:24:12	93
335	2024-12-11	2	1279000	62 Cát Linh, Cát Linh, Long Biên, Hà Nội	2024-12-11 05:58:13	2024-12-11 06:12:13	1234
336	2024-12-11	3	609000	35 Tân Mai, Tân Mai, Thanh Xuân, Hà Nội	2024-12-11 05:12:54	2024-12-11 05:27:54	1099
337	2024-12-11	3	685000	2 Nguyễn Trãi, Thanh Xuân Trung, Hai Bà Trưng, Hà Nội	2024-12-11 06:35:20	2024-12-11 06:40:20	1149
338	2024-12-11	3	870000	70 Gia Thụy, Gia Thụy, Hà Đông, Hà Nội	2024-12-11 15:51:39	2024-12-11 15:58:39	1971
339	2024-12-11	3	615000	36 Kim Giang, Đại Kim, Thanh Xuân, Hà Nội	2024-12-11 14:20:28	2024-12-11 14:25:28	1161
340	2024-12-11	3	1000000	2 Kim Mã, Kim Mã, Ba Đình, Hà Nội	2024-12-11 21:26:22	2024-12-11 21:38:22	671
341	2024-12-11	3	1456000	63 Hồ Tùng Mậu, Mai Dịch, Đống Đa, Hà Nội	2024-12-11 21:41:45	2024-12-11 21:58:45	225
342	2024-12-11	1	555000	97 Tây Mỗ, Đại Mỗ, Bắc Từ Liêm, Hà Nội	2024-12-11 19:20:36	2024-12-11 19:36:36	289
343	2024-12-11	2	1145000	86 Hàng Bài, Hàng Bài, Hoàn Kiếm, Hà Nội	2024-12-11 16:30:27	2024-12-11 16:35:27	1148
344	2024-12-12	1	585000	91 Hàng Bạc, Hàng Bạc, Hoàn Kiếm, Hà Nội	2024-12-12 09:22:18	2024-12-12 09:29:18	309
345	2024-12-12	3	970000	18 Dương Liễu, Dương Liễu, Sóc Sơn, Hà Nội	2024-12-12 05:14:09	2024-12-12 05:19:09	1079
346	2024-12-12	1	1300000	70 Kim Giang, Đại Kim, Thanh Xuân, Hà Nội	2024-12-12 18:27:03	2024-12-12 18:43:03	715
347	2024-12-12	2	953000	31 Nguyễn Hữu Thọ, Hoàng Liệt, Thanh Xuân, Hà Nội	2024-12-12 20:57:28	2024-12-12 21:22:28	19
348	2024-12-12	2	940000	68 Đông Ngạc, Đông Ngạc, Nam Từ Liêm, Hà Nội	2024-12-12 11:59:05	2024-12-12 12:08:05	992
349	2024-12-12	0	830000	12 Tràng Tiền, Tràng Tiền, Hoàn Kiếm, Hà Nội	2024-12-12 14:18:26	2024-12-12 14:23:26	1898
350	2024-12-12	3	310000	23 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-12-12 10:49:54	2024-12-12 10:54:54	742
351	2024-12-12	1	1329000	57 Vân Canh, Vân Canh, Sóc Sơn, Hà Nội	2024-12-12 16:35:33	2024-12-12 16:46:33	1665
352	2024-12-13	3	1316000	12 Yên Viên, Yên Viên, Hoài Đức, Hà Nội	2024-12-13 05:59:01	2024-12-13 06:21:01	1401
353	2024-12-13	3	1006000	61 Liên Ninh, Liên Ninh, Phúc Thọ, Hà Nội	2024-12-13 16:07:21	2024-12-13 16:33:21	1788
354	2024-12-13	3	637000	7 Bạch Mai, Bạch Mai, Tây Hồ, Hà Nội	2024-12-13 20:22:44	2024-12-13 20:27:44	620
355	2024-12-13	3	860000	13 Cự Khối, Cự Khối, Hà Đông, Hà Nội	2024-12-13 16:30:55	2024-12-13 16:35:55	1614
356	2024-12-13	3	1040000	60 Thụy Phương, Thụy Phương, Nam Từ Liêm, Hà Nội	2024-12-13 10:00:09	2024-12-13 10:44:09	1527
357	2024-12-13	1	990000	10 Mễ Trì, Mễ Trì, Bắc Từ Liêm, Hà Nội	2024-12-13 06:34:30	2024-12-13 06:39:30	903
358	2024-12-13	1	1340000	31 Hàng Đào, Hàng Đào, Hoàn Kiếm, Hà Nội	2024-12-13 15:33:43	2024-12-13 15:39:43	1255
359	2024-12-13	1	480000	96 Đa Tốn, Đa Tốn, Hoài Đức, Hà Nội	2024-12-13 09:55:25	2024-12-13 10:00:25	362
360	2024-12-13	0	1230000	30 Quan Hoa, Quan Hoa, Đống Đa, Hà Nội	2024-12-13 17:41:50	2024-12-13 17:53:50	634
361	2024-12-13	0	1345000	78 Hàng Bài, Hàng Bài, Hoàn Kiếm, Hà Nội	2024-12-13 09:43:25	2024-12-13 09:48:25	553
362	2024-12-14	3	1070000	46 Đông Mỹ, Đông Mỹ, Phúc Thọ, Hà Nội	2024-12-14 20:19:34	2024-12-14 20:24:34	1748
363	2024-12-14	3	530000	72 Hồ Tùng Mậu, Mai Dịch, Đống Đa, Hà Nội	2024-12-14 18:13:05	2024-12-14 18:24:05	481
364	2024-12-14	3	670000	3 Vân Canh, Vân Canh, Sóc Sơn, Hà Nội	2024-12-14 15:28:25	2024-12-14 15:33:25	556
365	2024-12-14	3	1004000	79 Đào Tấn, Cống Vị, Ba Đình, Hà Nội	2024-12-14 16:57:23	2024-12-14 17:04:23	10
366	2024-12-14	3	1070000	1 Cát Linh, Cát Linh, Long Biên, Hà Nội	2024-12-14 13:30:56	2024-12-14 13:49:56	906
367	2024-12-14	3	648000	91 Cầu Giấy, Dịch Vọng, Đống Đa, Hà Nội	2024-12-14 15:06:53	2024-12-14 15:30:53	1385
368	2024-12-14	3	756000	16 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-12-14 20:29:24	2024-12-14 20:34:24	1313
369	2024-12-14	3	1276000	68 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-12-14 05:21:58	2024-12-14 05:26:58	743
370	2024-12-15	3	399000	82 Xuân La, Xuân La, Cầu Giấy, Hà Nội	2024-12-15 20:20:57	2024-12-15 20:25:57	1256
371	2024-12-15	3	520000	58 Yên Nghĩa, Yên Nghĩa, Mê Linh, Hà Nội	2024-12-15 10:10:05	2024-12-15 10:16:05	1215
372	2024-12-15	3	480000	96 Cổ Bi, Cổ Bi, Hoài Đức, Hà Nội	2024-12-15 20:48:37	2024-12-15 21:25:37	387
373	2024-12-15	3	620000	39 Quan Hoa, Quan Hoa, Đống Đa, Hà Nội	2024-12-15 20:44:00	2024-12-15 20:49:00	1842
374	2024-12-15	3	1278000	18 An Thượng, An Thượng, Sóc Sơn, Hà Nội	2024-12-15 10:42:23	2024-12-15 10:48:23	324
375	2024-12-15	3	1133000	89 Đông Hội, Đông Hội, Đan Phượng, Hà Nội	2024-12-15 06:34:22	2024-12-15 06:39:22	1716
376	2024-12-15	2	1285000	11 Vân Canh, Vân Canh, Sóc Sơn, Hà Nội	2024-12-15 19:35:43	2024-12-15 19:43:43	691
377	2024-12-15	3	705000	40 Láng Hạ, Láng Hạ, Long Biên, Hà Nội	2024-12-15 07:03:57	2024-12-15 07:21:57	912
378	2024-12-16	3	1345000	89 Mễ Trì, Mễ Trì, Bắc Từ Liêm, Hà Nội	2024-12-16 19:17:57	2024-12-16 19:46:57	1233
379	2024-12-16	3	1215000	27 Nguyễn Văn Lộc, Mộ Lao, Mê Linh, Hà Nội	2024-12-16 15:29:50	2024-12-16 15:34:50	842
380	2024-12-16	4	1314000	9 Liên Mạc, Liên Mạc, Nam Từ Liêm, Hà Nội	2024-12-16 15:55:49	2024-12-16 16:00:49	245
381	2024-12-16	2	780000	91 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-12-16 09:24:14	2024-12-16 09:31:14	991
382	2024-12-16	3	440000	14 Giải Phóng, Đồng Tâm, Tây Hồ, Hà Nội	2024-12-16 13:37:00	2024-12-16 13:42:00	1587
383	2024-12-16	3	1033000	94 Bạch Mai, Bạch Mai, Tây Hồ, Hà Nội	2024-12-16 11:45:31	2024-12-16 12:03:31	321
384	2024-12-16	0	935000	11 Ngọc Hà, Ngọc Hà, Ba Đình, Hà Nội	2024-12-16 11:04:33	2024-12-16 11:16:33	634
385	2024-12-16	2	628000	88 Xuân La, Xuân La, Cầu Giấy, Hà Nội	2024-12-16 16:57:57	2024-12-16 17:02:57	799
386	2024-12-17	3	1348000	79 Nguyễn Hữu Thọ, Hoàng Liệt, Thanh Xuân, Hà Nội	2024-12-17 15:16:17	2024-12-17 15:21:17	857
387	2024-12-17	4	875000	24 Đông Mỹ, Đông Mỹ, Phúc Thọ, Hà Nội	2024-12-17 14:03:10	2024-12-17 14:14:10	203
388	2024-12-17	3	818000	42 Đại Mỗ, Tây Mỗ, Bắc Từ Liêm, Hà Nội	2024-12-17 21:41:52	2024-12-17 21:57:52	1116
389	2024-12-17	2	1256000	77 Thụy Khuê, Thụy Khuê, Cầu Giấy, Hà Nội	2024-12-17 08:52:18	2024-12-17 08:57:18	1207
390	2024-12-17	3	691000	93 Yên Viên, Yên Viên, Hoài Đức, Hà Nội	2024-12-17 12:47:38	2024-12-17 12:52:38	903
391	2024-12-17	0	836000	27 Quan Hoa, Quan Hoa, Đống Đa, Hà Nội	2024-12-17 13:05:44	2024-12-17 13:42:44	798
392	2024-12-17	2	2239000	58 Bạch Mai, Bạch Mai, Tây Hồ, Hà Nội	2024-12-17 20:46:49	2024-12-17 21:06:49	1845
393	2024-12-18	1	963000	85 Trần Duy Hưng, Trung Hòa, Đống Đa, Hà Nội	2024-12-18 16:38:18	2024-12-18 16:43:18	1357
394	2024-12-18	2	1750000	9 Đại Mỗ, Tây Mỗ, Bắc Từ Liêm, Hà Nội	2024-12-18 21:32:09	2024-12-18 21:43:09	920
395	2024-12-18	1	885000	76 Giảng Võ, Giảng Võ, Ba Đình, Hà Nội	2024-12-18 07:51:37	2024-12-18 07:56:37	1469
396	2024-12-18	2	1010000	66 Hồ Tùng Mậu, Mai Dịch, Đống Đa, Hà Nội	2024-12-18 12:16:58	2024-12-18 12:24:58	843
397	2024-12-18	2	594000	45 Nguyễn Trãi, Thanh Xuân Trung, Hai Bà Trưng, Hà Nội	2024-12-18 19:33:22	2024-12-18 19:47:22	622
398	2024-12-18	2	245000	1 Cổ Nhuế, Cổ Nhuế 1, Nam Từ Liêm, Hà Nội	2024-12-18 06:38:39	2024-12-18 06:53:39	828
399	2024-12-18	3	820000	6 Tây Mỗ, Đại Mỗ, Bắc Từ Liêm, Hà Nội	2024-12-18 20:40:43	2024-12-18 20:46:43	1181
400	2024-12-18	0	1298000	34 An Khánh, An Khánh, Sóc Sơn, Hà Nội	2024-12-18 08:42:55	2024-12-18 08:51:55	997
401	2024-12-18	3	1440000	92 Hạ Đình, Hạ Đình, Hai Bà Trưng, Hà Nội	2024-12-18 18:42:35	2024-12-18 18:47:35	1263
402	2024-12-19	3	835000	66 Liên Mạc, Liên Mạc, Nam Từ Liêm, Hà Nội	2024-12-19 13:25:57	2024-12-19 13:32:57	853
403	2024-12-19	3	1238000	53 Tràng Tiền, Tràng Tiền, Hoàn Kiếm, Hà Nội	2024-12-19 10:36:39	2024-12-19 10:43:39	585
404	2024-12-19	3	519000	7 Đặng Thai Mai, Quảng An, Cầu Giấy, Hà Nội	2024-12-19 10:38:19	2024-12-19 11:14:19	858
405	2024-12-19	1	1634000	17 La Phù, La Phù, Sóc Sơn, Hà Nội	2024-12-19 18:42:00	2024-12-19 18:47:00	486
406	2024-12-19	2	1205000	99 Khâm Thiên, Khâm Thiên, Long Biên, Hà Nội	2024-12-19 18:58:57	2024-12-19 19:03:57	1809
407	2024-12-19	4	390000	63 Quan Hoa, Quan Hoa, Đống Đa, Hà Nội	2024-12-19 07:41:49	2024-12-19 07:47:49	1427
408	2024-12-19	2	795000	8 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-12-19 21:08:49	2024-12-19 21:16:49	1526
409	2024-12-19	2	1459000	66 Định Công, Định Công, Thanh Xuân, Hà Nội	2024-12-19 10:44:53	2024-12-19 10:49:53	95
410	2024-12-19	1	770000	89 Nguyễn Văn Lộc, Mộ Lao, Mê Linh, Hà Nội	2024-12-19 21:11:02	2024-12-19 21:39:02	937
411	2024-12-19	4	1180000	97 Đào Tấn, Cống Vị, Ba Đình, Hà Nội	2024-12-19 18:21:58	2024-12-19 18:34:58	415
412	2024-12-20	2	1761000	76 Thụy Khuê, Thụy Khuê, Cầu Giấy, Hà Nội	2024-12-20 18:30:55	2024-12-20 18:52:55	1101
413	2024-12-20	2	1125000	41 Cổ Bi, Cổ Bi, Hoài Đức, Hà Nội	2024-12-20 20:39:56	2024-12-20 20:44:56	1853
414	2024-12-20	3	1260000	28 Biên Giang, Biên Giang, Mê Linh, Hà Nội	2024-12-20 11:47:15	2024-12-20 12:23:15	1120
415	2024-12-20	3	1594000	58 Dương Liễu, Dương Liễu, Sóc Sơn, Hà Nội	2024-12-20 19:51:23	2024-12-20 20:03:23	1778
416	2024-12-20	3	848000	96 Giảng Võ, Giảng Võ, Ba Đình, Hà Nội	2024-12-20 21:29:31	2024-12-20 21:34:31	1857
417	2024-12-20	3	1474000	65 Đông Ngạc, Đông Ngạc, Nam Từ Liêm, Hà Nội	2024-12-20 06:30:50	2024-12-20 06:37:50	928
418	2024-12-20	3	394000	56 Kim Mã, Kim Mã, Ba Đình, Hà Nội	2024-12-20 18:02:09	2024-12-20 18:07:09	1014
419	2024-12-21	3	434000	44 Tây Mỗ, Đại Mỗ, Bắc Từ Liêm, Hà Nội	2024-12-21 21:52:45	2024-12-21 22:10:45	1300
420	2024-12-21	3	986000	82 Yên Viên, Yên Viên, Hoài Đức, Hà Nội	2024-12-21 08:52:47	2024-12-21 09:08:47	1831
421	2024-12-21	3	1632000	55 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-12-21 17:30:49	2024-12-21 17:35:49	999
422	2024-12-21	3	770000	71 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-12-21 20:42:38	2024-12-21 20:47:38	1971
423	2024-12-21	3	756000	91 Cát Linh, Cát Linh, Long Biên, Hà Nội	2024-12-21 05:41:44	2024-12-21 06:06:44	835
424	2024-12-21	1	1316000	61 Minh Khai, Minh Khai, Tây Hồ, Hà Nội	2024-12-21 14:23:14	2024-12-21 14:34:14	119
425	2024-12-21	3	480000	32 Cổ Nhuế, Cổ Nhuế 1, Nam Từ Liêm, Hà Nội	2024-12-21 07:50:21	2024-12-21 07:55:21	355
426	2024-12-21	3	1425000	86 Yên Phụ, Yên Phụ, Cầu Giấy, Hà Nội	2024-12-21 13:43:09	2024-12-21 13:48:09	1959
427	2024-12-22	3	1438000	94 Tân Mai, Tân Mai, Thanh Xuân, Hà Nội	2024-12-22 14:20:10	2024-12-22 14:25:10	681
428	2024-12-22	0	1209000	48 Kim Giang, Đại Kim, Thanh Xuân, Hà Nội	2024-12-22 15:12:38	2024-12-22 15:17:38	156
429	2024-12-22	1	594000	11 Khương Đình, Khương Đình, Hai Bà Trưng, Hà Nội	2024-12-22 13:25:20	2024-12-22 13:30:20	94
430	2024-12-22	3	1202000	77 Mễ Trì, Mễ Trì, Bắc Từ Liêm, Hà Nội	2024-12-22 18:21:37	2024-12-22 18:44:37	1552
431	2024-12-22	4	1020000	20 Hải Bối, Hải Bối, Đan Phượng, Hà Nội	2024-12-22 18:36:15	2024-12-22 18:46:15	1007
432	2024-12-22	3	1034000	9 Tây Mỗ, Đại Mỗ, Bắc Từ Liêm, Hà Nội	2024-12-22 17:22:53	2024-12-22 17:36:53	481
433	2024-12-22	3	550000	23 Cổ Bi, Cổ Bi, Hoài Đức, Hà Nội	2024-12-22 08:32:41	2024-12-22 08:37:41	172
434	2024-12-22	2	516000	8 Thụy Khuê, Thụy Khuê, Cầu Giấy, Hà Nội	2024-12-22 21:48:16	2024-12-22 21:53:16	1528
435	2024-12-22	3	1648000	81 Thanh Nhàn, Quỳnh Mai, Tây Hồ, Hà Nội	2024-12-22 15:14:05	2024-12-22 15:27:05	1736
436	2024-12-22	3	1558000	27 Mễ Trì, Mễ Trì, Bắc Từ Liêm, Hà Nội	2024-12-22 09:31:17	2024-12-22 09:37:17	1169
437	2024-12-23	3	1160000	1 Đông Mỹ, Đông Mỹ, Phúc Thọ, Hà Nội	2024-12-23 20:15:05	2024-12-23 20:20:05	1266
438	2024-12-23	3	1134000	33 Ngọc Hà, Ngọc Hà, Ba Đình, Hà Nội	2024-12-23 16:05:40	2024-12-23 16:30:40	982
439	2024-12-23	3	2380000	95 Tả Thanh Oai, Tả Thanh Oai, Phúc Thọ, Hà Nội	2024-12-23 21:21:35	2024-12-23 21:44:35	1407
440	2024-12-23	3	1388000	89 Ngọc Lâm, Bồ Đề, Hà Đông, Hà Nội	2024-12-23 13:45:49	2024-12-23 13:54:49	1664
441	2024-12-23	1	893000	17 Nam Hồng, Nam Hồng, Đan Phượng, Hà Nội	2024-12-23 16:17:40	2024-12-23 16:26:40	921
442	2024-12-23	1	1010000	26 Minh Khai, Minh Khai, Tây Hồ, Hà Nội	2024-12-23 10:11:06	2024-12-23 10:16:06	1481
443	2024-12-23	4	365000	40 Nguyễn Trãi, Thanh Xuân Trung, Hai Bà Trưng, Hà Nội	2024-12-23 10:53:27	2024-12-23 11:03:27	598
444	2024-12-23	0	1130000	84 Âu Cơ, Nhật Tân, Cầu Giấy, Hà Nội	2024-12-23 17:20:58	2024-12-23 17:25:58	604
445	2024-12-23	3	1560000	27 Định Công, Định Công, Thanh Xuân, Hà Nội	2024-12-23 07:12:51	2024-12-23 07:22:51	1652
446	2024-12-24	3	1179000	27 Liên Mạc, Liên Mạc, Nam Từ Liêm, Hà Nội	2024-12-24 19:49:52	2024-12-24 20:05:52	1708
447	2024-12-24	3	1028000	97 Đa Tốn, Đa Tốn, Hoài Đức, Hà Nội	2024-12-24 14:49:06	2024-12-24 15:00:06	243
448	2024-12-24	3	410000	91 Ngô Quyền, Lý Thái Tổ, Hoàn Kiếm, Hà Nội	2024-12-24 20:58:05	2024-12-24 21:03:05	1061
449	2024-12-24	3	1696000	43 Yên Phụ, Yên Phụ, Cầu Giấy, Hà Nội	2024-12-24 18:55:04	2024-12-24 19:00:04	778
450	2024-12-24	0	1025000	13 Nguyễn Văn Cừ, Ngọc Lâm, Hà Đông, Hà Nội	2024-12-24 09:32:40	2024-12-24 09:37:40	396
451	2024-12-24	2	1320000	7 Định Công, Định Công, Thanh Xuân, Hà Nội	2024-12-24 19:15:14	2024-12-24 19:20:14	1207
452	2024-12-24	3	480000	42 Hàng Bạc, Hàng Bạc, Hoàn Kiếm, Hà Nội	2024-12-24 21:32:30	2024-12-24 21:37:30	586
453	2024-12-24	3	485000	97 Quan Hoa, Quan Hoa, Đống Đa, Hà Nội	2024-12-24 12:56:09	2024-12-24 13:14:09	1607
454	2024-12-24	3	357000	27 Giảng Võ, Giảng Võ, Ba Đình, Hà Nội	2024-12-24 20:37:35	2024-12-24 20:42:35	1954
455	2024-12-25	3	700000	67 Bạch Mai, Bạch Mai, Tây Hồ, Hà Nội	2024-12-25 20:47:41	2024-12-25 20:57:41	1214
456	2024-12-25	2	1225000	100 Đặng Thai Mai, Quảng An, Cầu Giấy, Hà Nội	2024-12-25 17:25:44	2024-12-25 17:33:44	351
457	2024-12-25	3	1416000	76 Hoàng Văn Thái, Khương Mai, Hai Bà Trưng, Hà Nội	2024-12-25 11:10:16	2024-12-25 11:35:16	85
458	2024-12-25	3	1526000	44 Tôn Đức Thắng, Hàng Bột, Long Biên, Hà Nội	2024-12-25 17:55:10	2024-12-25 18:00:10	1870
459	2024-12-25	3	785000	63 Nguyễn Trãi, Thanh Xuân Trung, Hai Bà Trưng, Hà Nội	2024-12-25 21:08:05	2024-12-25 21:20:05	1148
460	2024-12-25	3	1205000	95 Yên Viên, Yên Viên, Hoài Đức, Hà Nội	2024-12-25 21:23:23	2024-12-25 21:34:23	991
461	2024-12-25	3	875000	85 Xã Đàn, Ô Chợ Dừa, Long Biên, Hà Nội	2024-12-25 19:54:36	2024-12-25 20:28:36	1923
462	2024-12-25	2	875000	40 Cổ Nhuế, Cổ Nhuế 1, Nam Từ Liêm, Hà Nội	2024-12-25 21:11:16	2024-12-25 21:16:16	516
463	2024-12-25	3	755000	16 Xuân Canh, Xuân Canh, Đan Phượng, Hà Nội	2024-12-25 18:36:26	2024-12-25 19:21:26	1526
464	2024-12-26	2	982000	3 Yên Nghĩa, Yên Nghĩa, Mê Linh, Hà Nội	2024-12-26 19:12:06	2024-12-26 19:17:06	915
465	2024-12-26	4	754000	43 Tôn Đức Thắng, Hàng Bột, Long Biên, Hà Nội	2024-12-26 20:17:00	2024-12-26 20:28:00	673
466	2024-12-26	3	769000	68 Định Công, Định Công, Thanh Xuân, Hà Nội	2024-12-26 18:35:59	2024-12-26 18:46:59	699
467	2024-12-26	3	1360000	1 Nguyễn Trãi, Thanh Xuân Trung, Hai Bà Trưng, Hà Nội	2024-12-26 20:52:34	2024-12-26 20:57:34	1701
468	2024-12-26	3	695000	10 Hoàng Văn Thái, Khương Mai, Hai Bà Trưng, Hà Nội	2024-12-26 21:30:27	2024-12-26 21:40:27	1508
469	2024-12-26	3	590000	54 Vân Canh, Vân Canh, Sóc Sơn, Hà Nội	2024-12-26 19:21:26	2024-12-26 19:27:26	1716
470	2024-12-26	1	1340000	33 An Thượng, An Thượng, Sóc Sơn, Hà Nội	2024-12-26 17:18:29	2024-12-26 17:46:29	273
471	2024-12-27	3	328000	96 Yên Nghĩa, Yên Nghĩa, Mê Linh, Hà Nội	2024-12-27 13:55:31	2024-12-27 14:00:31	1046
472	2024-12-27	3	833000	61 Yên Viên, Yên Viên, Hoài Đức, Hà Nội	2024-12-27 16:56:06	2024-12-27 17:04:06	1790
473	2024-12-27	3	957000	10 Giải Phóng, Đồng Tâm, Tây Hồ, Hà Nội	2024-12-27 18:33:50	2024-12-27 18:40:50	1190
474	2024-12-27	1	1230000	48 Trần Phú, Văn Quán, Mê Linh, Hà Nội	2024-12-27 10:54:14	2024-12-27 10:59:14	334
475	2024-12-27	4	450000	51 Giảng Võ, Giảng Võ, Ba Đình, Hà Nội	2024-12-27 16:08:41	2024-12-27 16:13:41	254
476	2024-12-27	3	795000	82 Ngọc Hà, Ngọc Hà, Ba Đình, Hà Nội	2024-12-27 08:40:30	2024-12-27 08:45:30	92
477	2024-12-27	3	1296000	27 Mễ Trì, Mễ Trì, Bắc Từ Liêm, Hà Nội	2024-12-27 21:35:07	2024-12-27 22:04:07	1887
478	2024-12-27	1	846000	10 Hải Bối, Hải Bối, Đan Phượng, Hà Nội	2024-12-27 15:44:12	2024-12-27 15:49:12	324
479	2024-12-27	3	2568000	43 Tràng Tiền, Tràng Tiền, Hoàn Kiếm, Hà Nội	2024-12-27 13:54:56	2024-12-27 13:59:56	1962
480	2024-12-28	0	414000	90 Hải Bối, Hải Bối, Đan Phượng, Hà Nội	2024-12-28 12:03:27	2024-12-28 12:08:27	1549
481	2024-12-28	3	891000	71 Hàng Bài, Hàng Bài, Hoàn Kiếm, Hà Nội	2024-12-28 07:24:09	2024-12-28 07:29:09	1274
482	2024-12-28	4	875000	52 Yên Nghĩa, Yên Nghĩa, Mê Linh, Hà Nội	2024-12-28 21:48:38	2024-12-28 22:16:38	85
483	2024-12-28	3	618000	12 Tả Thanh Oai, Tả Thanh Oai, Phúc Thọ, Hà Nội	2024-12-28 18:44:29	2024-12-28 19:08:29	686
484	2024-12-28	3	855000	99 An Thượng, An Thượng, Sóc Sơn, Hà Nội	2024-12-28 15:19:17	2024-12-28 15:24:17	461
485	2024-12-28	3	490000	93 Nguyễn Văn Lộc, Mộ Lao, Mê Linh, Hà Nội	2024-12-28 19:03:23	2024-12-28 19:08:23	1585
486	2024-12-28	2	1227000	69 Dương Liễu, Dương Liễu, Sóc Sơn, Hà Nội	2024-12-28 06:15:39	2024-12-28 06:20:39	1935
487	2024-12-28	3	1320000	59 Tây Mỗ, Đại Mỗ, Bắc Từ Liêm, Hà Nội	2024-12-28 16:17:47	2024-12-28 16:22:47	601
488	2024-12-28	3	229000	5 Hàng Đào, Hàng Đào, Hoàn Kiếm, Hà Nội	2024-12-28 17:19:22	2024-12-28 17:24:22	572
489	2024-12-28	1	318000	43 Kiêu Kỵ, Kiêu Kỵ, Hoài Đức, Hà Nội	2024-12-28 16:42:36	2024-12-28 16:47:36	604
490	2024-12-29	3	830000	72 Xuân La, Xuân La, Cầu Giấy, Hà Nội	2024-12-29 12:40:09	2024-12-29 12:53:09	156
491	2024-12-29	1	1020000	27 Đa Tốn, Đa Tốn, Hoài Đức, Hà Nội	2024-12-29 20:42:02	2024-12-29 20:47:02	1721
492	2024-12-29	3	1425000	11 Yên Nghĩa, Yên Nghĩa, Mê Linh, Hà Nội	2024-12-29 19:52:35	2024-12-29 19:57:35	1250
493	2024-12-29	2	1150000	57 Trần Duy Hưng, Trung Hòa, Đống Đa, Hà Nội	2024-12-29 07:11:36	2024-12-29 07:16:36	1738
494	2024-12-29	2	1608000	60 Phú Diễn, Phú Diễn, Nam Từ Liêm, Hà Nội	2024-12-29 12:43:29	2024-12-29 12:48:29	824
495	2024-12-29	3	1720000	77 Gia Thụy, Gia Thụy, Hà Đông, Hà Nội	2024-12-29 08:47:22	2024-12-29 09:05:22	1965
496	2024-12-29	1	1214000	97 Hồ Tùng Mậu, Mai Dịch, Đống Đa, Hà Nội	2024-12-29 19:36:48	2024-12-29 19:41:48	1178
497	2024-12-29	3	1803000	51 Đông Hội, Đông Hội, Đan Phượng, Hà Nội	2024-12-29 11:56:51	2024-12-29 12:08:51	78
498	2024-12-29	4	654000	22 Ngũ Hiệp, Ngũ Hiệp, Phúc Thọ, Hà Nội	2024-12-29 20:07:51	2024-12-29 20:12:51	1416
499	2024-12-30	3	594000	96 Hàng Đào, Hàng Đào, Hoàn Kiếm, Hà Nội	2024-12-30 14:39:54	2024-12-30 14:46:54	922
500	2024-12-30	3	1550000	43 Trần Duy Hưng, Trung Hòa, Đống Đa, Hà Nội	2024-12-30 19:58:12	2024-12-30 20:03:12	105
501	2024-12-30	4	660000	62 Nguyễn Hữu Thọ, Hoàng Liệt, Thanh Xuân, Hà Nội	2024-12-30 17:54:12	2024-12-30 18:01:12	1873
502	2024-12-30	3	1315000	81 Thụy Khuê, Thụy Khuê, Cầu Giấy, Hà Nội	2024-12-30 13:18:42	2024-12-30 13:28:42	291
503	2024-12-30	3	1170000	86 Nguyễn Khánh Toàn, Nghĩa Đô, Đống Đa, Hà Nội	2024-12-30 10:35:29	2024-12-30 10:47:29	1634
504	2024-12-30	3	1308000	82 Minh Khai, Minh Khai, Tây Hồ, Hà Nội	2024-12-30 06:13:50	2024-12-30 06:24:50	982
505	2024-12-30	2	1445000	27 Khâm Thiên, Khâm Thiên, Long Biên, Hà Nội	2024-12-30 11:05:35	2024-12-30 11:44:35	1604
506	2024-12-30	2	660000	90 Gia Thụy, Gia Thụy, Hà Đông, Hà Nội	2024-12-30 11:58:16	2024-12-30 12:09:16	324
507	2024-12-30	3	1968000	62 Tả Thanh Oai, Tả Thanh Oai, Phúc Thọ, Hà Nội	2024-12-30 11:25:07	2024-12-30 11:30:07	1072
508	2024-12-30	3	1780000	1 Trần Duy Hưng, Trung Hòa, Đống Đa, Hà Nội	2024-12-30 20:16:59	2024-12-30 20:21:59	1770
\.


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (payment_id, amount, payment_method, payment_status, payment_date, order_id, user_id) FROM stdin;
1	1790000	0	0	2024-11-01 08:36:35	1	1878
2	1774000	1	0	2024-11-01 19:55:46	2	1234
3	585000	0	0	2024-11-01 18:06:57	3	1321
4	702000	0	0	2024-11-01 20:48:57	4	1066
5	630000	0	0	2024-11-01 18:50:40	5	920
6	1173000	1	0	2024-11-01 15:44:42	6	1267
7	1170000	1	0	2024-11-01 12:08:56	7	1065
8	405000	0	0	2024-11-01 20:32:25	8	1030
9	1168000	0	0	2024-11-01 20:13:38	9	1809
10	435000	0	0	2024-11-02 14:09:28	10	1856
11	751000	1	0	2024-11-02 05:42:50	11	211
12	800000	0	0	2024-11-02 06:01:21	12	1073
13	728000	1	0	2024-11-02 20:26:53	13	1579
14	1150000	1	0	2024-11-02 15:26:07	14	1771
15	800000	0	0	2024-11-02 09:38:29	15	939
16	915000	0	0	2024-11-02 09:00:13	16	1943
17	530000	0	0	2024-11-03 21:57:44	17	476
18	400000	0	0	2024-11-03 18:28:31	18	273
19	840000	1	0	2024-11-03 14:13:19	19	1366
20	1250000	0	0	2024-11-03 20:12:14	20	1543
21	560000	0	0	2024-11-03 11:22:13	21	297
22	1068000	0	0	2024-11-03 06:19:45	22	782
23	569000	0	0	2024-11-03 16:32:13	23	416
24	735000	0	1	2024-11-03 19:07:42	24	1337
25	748000	1	0	2024-11-04 21:58:49	25	1274
26	877000	1	0	2024-11-04 18:55:24	26	1528
27	1365000	1	0	2024-11-04 08:00:20	27	1766
28	1498000	1	0	2024-11-04 11:14:27	28	518
29	1115000	1	0	2024-11-04 21:13:33	29	1641
30	950000	1	0	2024-11-04 20:46:24	30	1604
31	458000	0	0	2024-11-04 20:13:42	31	428
32	750000	0	1	2024-11-05 20:18:42	32	1321
33	992000	0	0	2024-11-05 06:24:13	33	1827
34	1534000	0	0	2024-11-05 07:14:04	34	1195
35	1250000	1	0	2024-11-05 19:34:50	35	1469
36	1174000	1	0	2024-11-05 19:27:47	36	846
37	1498000	1	0	2024-11-05 17:10:50	37	1837
38	439000	0	0	2024-11-05 10:16:35	38	1533
39	870000	1	1	2024-11-05 21:24:07	39	609
40	750000	0	1	2024-11-05 14:43:42	40	87
41	505000	0	0	2024-11-05 18:09:55	41	316
42	480000	0	0	2024-11-06 17:18:08	42	242
43	700000	0	0	2024-11-06 10:13:15	43	358
44	1316000	0	0	2024-11-06 09:08:24	44	1898
45	1720000	0	0	2024-11-06 21:18:52	45	481
46	900000	1	0	2024-11-06 18:11:32	46	1226
47	898000	0	1	2024-11-06 16:11:48	47	677
48	420000	0	0	2024-11-06 12:57:54	48	437
49	595000	1	0	2024-11-06 06:31:08	49	1031
50	825000	1	0	2024-11-07 06:59:26	50	1015
51	971000	0	0	2024-11-07 06:53:11	51	204
52	1045000	0	0	2024-11-07 13:11:22	52	1409
53	1115000	0	0	2024-11-07 18:14:55	53	700
54	1637000	0	0	2024-11-07 19:31:36	54	558
55	995000	0	1	2024-11-07 15:08:51	55	1693
56	1318000	1	0	2024-11-07 13:01:40	56	1599
57	646000	1	0	2024-11-08 14:04:29	57	1731
58	1101000	0	0	2024-11-08 11:30:46	58	1651
59	1338000	0	0	2024-11-08 15:23:14	59	1670
60	1078000	1	1	2024-11-08 19:11:55	60	1574
61	710000	1	2	2024-11-08 12:57:02	61	919
62	1188000	1	0	2024-11-08 12:01:59	62	1661
63	959000	1	0	2024-11-08 14:15:36	63	1145
64	860000	1	0	2024-11-08 21:55:18	64	1672
65	660000	0	0	2024-11-08 18:07:06	65	291
66	1430000	0	0	2024-11-08 19:36:51	66	1300
67	1461000	0	1	2024-11-09 21:12:59	67	1672
68	2090000	0	0	2024-11-09 20:22:28	68	530
69	436000	1	0	2024-11-09 20:14:12	69	220
70	440000	0	0	2024-11-09 07:20:50	70	1998
71	920000	0	0	2024-11-09 06:58:39	71	982
72	963000	0	0	2024-11-09 21:22:27	72	1074
73	591000	0	0	2024-11-09 12:04:05	73	846
74	1319000	1	0	2024-11-10 11:54:02	74	913
75	715000	1	0	2024-11-10 11:42:58	75	1486
76	820000	0	1	2024-11-10 15:58:00	76	1767
77	1590000	0	0	2024-11-10 17:40:55	77	506
78	742000	0	0	2024-11-10 19:13:37	78	1371
79	1475000	1	1	2024-11-10 09:18:50	79	98
80	2010000	0	0	2024-11-10 12:24:27	80	681
81	790000	1	1	2024-11-10 09:53:44	81	1149
82	295000	1	1	2024-11-10 19:41:02	82	362
83	504000	1	1	2024-11-11 19:55:23	83	835
84	1380000	0	1	2024-11-11 18:22:13	84	991
85	1275000	0	1	2024-11-11 15:03:22	85	87
86	1534000	0	0	2024-11-11 20:19:49	86	663
87	547000	0	0	2024-11-11 18:15:15	87	1064
88	2203000	0	1	2024-11-11 14:16:39	88	476
89	1140000	0	0	2024-11-11 18:42:11	89	1973
90	1210000	0	1	2024-11-11 14:08:21	90	782
91	1350000	0	1	2024-11-12 21:28:08	91	1497
92	1144000	1	0	2024-11-12 18:52:38	92	700
93	930000	0	0	2024-11-12 17:30:45	93	803
94	1238000	1	0	2024-11-12 21:25:59	94	371
95	1010000	1	0	2024-11-12 21:33:30	95	1054
96	1050000	0	0	2024-11-12 20:42:47	96	474
97	388000	0	0	2024-11-12 05:04:41	97	196
98	1333000	1	1	2024-11-12 16:24:27	98	1916
99	920000	0	0	2024-11-13 17:28:22	99	1603
100	533000	1	0	2024-11-13 15:41:55	100	1976
101	1005000	1	0	2024-11-13 14:37:09	101	1145
102	1656000	0	1	2024-11-13 15:22:23	102	1088
103	890000	0	1	2024-11-13 05:18:46	103	836
104	660000	0	0	2024-11-13 21:13:03	104	378
105	1315000	0	0	2024-11-13 20:37:20	105	1230
106	900000	0	0	2024-11-13 15:35:31	106	673
107	505000	1	0	2024-11-13 18:03:30	107	1149
108	974000	0	0	2024-11-13 20:38:57	108	1451
109	1258000	1	1	2024-11-14 12:16:13	109	1740
110	1820000	1	1	2024-11-14 07:51:56	110	1625
111	1570000	1	0	2024-11-14 08:26:24	111	1634
112	1364000	1	0	2024-11-14 21:54:39	112	522
113	950000	1	1	2024-11-14 08:22:26	113	1022
114	1478000	0	0	2024-11-14 05:57:10	114	1012
115	1088000	1	0	2024-11-14 19:23:04	115	1752
116	895000	1	0	2024-11-14 17:05:15	116	373
117	887000	1	0	2024-11-15 14:18:38	117	454
118	845000	0	0	2024-11-15 20:49:42	118	1615
119	1466000	0	0	2024-11-15 13:07:33	119	1380
120	313000	0	1	2024-11-15 06:29:18	120	213
121	799000	1	0	2024-11-15 21:42:55	121	798
122	1017000	0	0	2024-11-15 15:18:28	122	571
123	1173000	1	2	2024-11-15 12:15:05	123	1520
124	1245000	1	0	2024-11-16 06:57:27	124	279
125	340000	0	0	2024-11-16 06:50:02	125	676
126	485000	0	0	2024-11-16 14:22:14	126	166
127	1148000	1	0	2024-11-16 19:12:40	127	914
128	1235000	0	0	2024-11-16 06:36:57	128	507
129	1142000	0	1	2024-11-16 19:06:25	129	1169
130	801000	0	0	2024-11-16 11:02:49	130	123
131	1565000	0	0	2024-11-16 09:41:29	131	1807
132	1600000	0	0	2024-11-17 11:39:08	132	123
133	958000	0	0	2024-11-17 19:26:07	133	992
134	1998000	0	0	2024-11-17 10:39:05	134	864
135	665000	1	0	2024-11-17 17:55:32	135	901
136	893000	0	2	2024-11-17 20:42:05	136	1651
137	1169000	0	0	2024-11-17 05:45:37	137	376
138	1098000	0	0	2024-11-17 15:36:19	138	628
139	878000	1	0	2024-11-17 13:57:15	139	1045
140	722000	0	0	2024-11-18 13:32:27	140	671
141	676000	0	0	2024-11-18 15:01:10	141	1147
142	1974000	0	0	2024-11-18 17:39:52	142	999
143	2278000	0	0	2024-11-18 08:58:52	143	1615
144	828000	1	0	2024-11-18 20:12:29	144	1045
145	1638000	1	0	2024-11-18 18:47:01	145	1189
146	905000	1	0	2024-11-18 21:06:00	146	1315
147	1091000	0	0	2024-11-19 09:12:43	147	706
148	698000	0	0	2024-11-19 06:08:14	148	1190
149	1179000	1	0	2024-11-19 13:14:34	149	1943
150	1070000	0	0	2024-11-19 11:20:12	150	1604
151	1960000	0	0	2024-11-19 14:27:33	151	1611
152	1186000	1	0	2024-11-19 15:35:15	152	743
153	760000	1	1	2024-11-19 21:09:27	153	1050
154	1055000	0	0	2024-11-19 15:56:43	154	580
155	756000	1	0	2024-11-19 07:59:30	155	546
156	870000	1	0	2024-11-19 06:19:55	156	1051
157	1726000	0	1	2024-11-20 06:46:42	157	823
158	1145000	1	0	2024-11-20 19:46:53	158	1888
159	424000	1	0	2024-11-20 07:26:59	159	1356
160	1444000	1	0	2024-11-20 17:01:21	160	1434
161	1539000	1	0	2024-11-20 07:38:38	161	1986
162	1230000	0	0	2024-11-20 06:59:13	162	763
163	560000	0	0	2024-11-20 08:01:24	163	820
164	620000	0	0	2024-11-20 12:15:38	164	1205
165	536000	0	1	2024-11-21 19:52:57	165	1238
166	840000	1	0	2024-11-21 19:19:31	166	738
167	828000	1	0	2024-11-21 18:38:31	167	126
168	1790000	0	0	2024-11-21 15:19:56	168	367
169	1380000	0	1	2024-11-21 11:22:10	169	330
170	1734000	0	0	2024-11-21 14:38:31	170	1132
171	190000	0	2	2024-11-21 07:19:08	171	289
172	930000	1	0	2024-11-21 08:51:35	172	1095
173	1335000	0	0	2024-11-22 19:41:30	173	598
174	1438000	1	0	2024-11-22 18:42:11	174	299
175	628000	0	0	2024-11-22 07:45:39	175	1450
176	758000	0	1	2024-11-22 11:03:40	176	1665
177	1015000	0	0	2024-11-22 18:16:20	177	1724
178	710000	0	0	2024-11-22 10:03:31	178	1233
179	980000	0	0	2024-11-22 21:49:50	179	629
180	1264000	0	0	2024-11-22 07:46:56	180	352
181	791000	0	0	2024-11-22 10:59:16	181	1254
182	748000	0	0	2024-11-23 05:39:47	182	1407
183	445000	1	0	2024-11-23 11:28:16	183	1228
184	1170000	1	0	2024-11-23 19:49:01	184	927
185	1327000	1	0	2024-11-23 11:22:45	185	581
186	1500000	0	0	2024-11-23 05:52:34	186	1059
187	814000	1	0	2024-11-23 12:49:24	187	1861
188	1645000	1	0	2024-11-23 09:00:20	188	730
189	1052000	1	0	2024-11-23 21:23:01	189	274
190	450000	1	1	2024-11-23 21:53:07	190	656
191	856000	1	0	2024-11-23 09:28:46	191	831
192	1075000	0	0	2024-11-24 19:29:02	192	190
193	1476000	1	2	2024-11-24 19:05:21	193	746
194	626000	0	0	2024-11-24 18:19:47	194	139
195	935000	0	2	2024-11-24 05:44:30	195	141
196	1220000	0	0	2024-11-24 16:53:00	196	486
197	928000	0	0	2024-11-24 16:43:50	197	514
198	1468000	0	0	2024-11-24 10:13:36	198	1740
199	1537000	1	0	2024-11-25 21:00:42	199	1234
200	1848000	1	0	2024-11-25 16:11:55	200	1178
201	800000	0	0	2024-11-25 11:43:41	201	738
202	615000	0	0	2024-11-25 18:59:51	202	1362
203	321000	0	0	2024-11-25 21:05:29	203	760
204	1319000	0	0	2024-11-25 21:27:58	204	1758
205	898000	0	0	2024-11-25 13:16:44	205	1182
206	784000	0	0	2024-11-25 11:21:45	206	106
207	970000	0	0	2024-11-25 19:53:47	207	113
208	668000	1	0	2024-11-25 20:23:03	208	1967
209	1266000	1	0	2024-11-26 07:50:33	209	648
210	940000	1	0	2024-11-26 08:04:55	210	1181
211	2392000	0	0	2024-11-26 08:34:13	211	1581
212	770000	1	0	2024-11-26 14:10:52	212	464
213	395000	1	0	2024-11-26 10:36:48	213	1977
214	1190000	1	0	2024-11-26 06:20:49	214	477
215	1620000	0	0	2024-11-26 10:15:15	215	1510
216	1220000	0	0	2024-11-26 21:07:51	216	609
217	1260000	0	0	2024-11-27 06:57:41	217	1781
218	618000	0	0	2024-11-27 09:38:08	218	1051
219	995000	0	0	2024-11-27 07:58:06	219	1664
220	428000	0	0	2024-11-27 19:49:17	220	800
221	1289000	0	0	2024-11-27 17:57:30	221	358
222	1810000	1	0	2024-11-27 11:17:55	222	64
223	988000	0	1	2024-11-27 21:14:37	223	1796
224	790000	0	0	2024-11-28 14:18:00	224	577
225	867000	1	0	2024-11-28 21:58:15	225	580
226	865000	0	0	2024-11-28 09:48:22	226	509
227	1080000	1	1	2024-11-28 06:37:49	227	453
228	1280000	0	2	2024-11-28 20:30:24	228	928
229	930000	1	0	2024-11-28 16:54:02	229	663
230	1495000	0	0	2024-11-28 17:42:54	230	622
231	938000	0	0	2024-11-28 18:30:33	231	971
232	1364000	1	0	2024-11-28 18:57:22	232	78
233	1478000	0	0	2024-11-28 21:45:33	233	1525
234	1920000	1	0	2024-11-29 16:10:54	234	716
235	380000	1	0	2024-11-29 17:10:08	235	1127
236	621000	0	0	2024-11-29 20:24:07	236	1366
237	830000	1	0	2024-11-29 08:23:14	237	1896
238	419000	0	0	2024-11-29 12:38:38	238	1947
239	1270000	0	0	2024-11-29 17:13:34	239	368
240	1597000	0	0	2024-11-29 19:49:12	240	1556
241	1438000	1	0	2024-11-29 18:27:55	241	1057
242	783000	0	0	2024-11-29 19:01:42	242	1611
243	1465000	0	0	2024-11-29 19:56:42	243	981
244	937000	0	1	2024-11-30 11:01:14	244	647
245	546000	1	1	2024-11-30 21:06:41	245	1326
246	978000	0	0	2024-11-30 10:25:20	246	1839
247	1176000	1	0	2024-11-30 10:44:16	247	736
248	1189000	1	0	2024-11-30 14:27:28	248	1845
249	1043000	1	0	2024-11-30 20:58:07	249	1130
250	1697000	0	0	2024-11-30 19:50:32	250	1962
251	795000	0	0	2024-11-30 19:59:43	251	797
252	1286000	1	0	2024-12-01 19:26:09	252	1935
253	780000	0	0	2024-12-01 13:35:36	253	452
254	1356000	0	0	2024-12-01 11:27:56	254	182
255	1590000	1	0	2024-12-01 14:41:10	255	54
256	1085000	0	0	2024-12-01 18:14:07	256	1527
257	513000	1	1	2024-12-01 15:58:13	257	454
258	896000	0	0	2024-12-01 20:40:59	258	1012
259	442000	1	0	2024-12-01 21:59:35	259	1533
260	2100000	0	0	2024-12-01 20:59:27	260	1986
261	516000	1	0	2024-12-02 09:32:30	261	1744
262	608000	0	0	2024-12-02 15:22:32	262	1672
263	1196000	1	0	2024-12-02 07:28:38	263	1850
264	780000	1	0	2024-12-02 17:01:50	264	211
265	750000	1	0	2024-12-02 09:34:56	265	1752
266	1060000	1	1	2024-12-02 14:46:12	266	673
267	804000	0	2	2024-12-02 12:53:25	267	1870
268	1358000	1	0	2024-12-02 13:29:55	268	461
269	536000	0	0	2024-12-03 17:15:41	269	508
270	436000	0	0	2024-12-03 14:48:00	270	1677
271	1419000	0	0	2024-12-03 07:47:02	271	1360
272	945000	0	0	2024-12-03 15:05:27	272	181
273	1184000	1	0	2024-12-03 14:40:11	273	945
274	1356000	0	0	2024-12-03 19:44:09	274	369
275	775000	0	0	2024-12-03 21:31:09	275	1508
276	328000	0	0	2024-12-03 20:40:16	276	1540
277	1050000	0	0	2024-12-04 21:51:29	277	1282
278	1205000	1	0	2024-12-04 19:32:08	278	1958
279	1055000	1	0	2024-12-04 17:45:04	279	352
280	790000	1	0	2024-12-04 08:00:19	280	1716
281	1078000	1	1	2024-12-04 12:35:08	281	521
282	1093000	0	0	2024-12-04 16:55:38	282	1990
283	1335000	1	0	2024-12-04 06:09:39	283	720
284	1075000	0	0	2024-12-04 08:32:00	284	1726
285	638000	0	0	2024-12-04 20:35:31	285	1407
286	1269000	0	0	2024-12-05 13:13:40	286	700
287	1673000	0	0	2024-12-05 19:54:50	287	1994
288	2165000	1	0	2024-12-05 21:58:57	288	622
289	935000	1	0	2024-12-05 12:36:55	289	620
290	1148000	0	0	2024-12-05 18:17:12	290	1778
291	1060000	1	2	2024-12-05 16:04:57	291	1192
292	1535000	0	0	2024-12-05 19:50:51	292	771
293	1105000	0	0	2024-12-05 18:07:02	293	556
294	1050000	0	1	2024-12-06 13:17:00	294	1748
295	1218000	1	2	2024-12-06 18:18:43	295	1887
296	1302000	1	0	2024-12-06 19:25:51	296	1233
297	955000	0	0	2024-12-06 09:03:01	297	1483
298	1288000	0	0	2024-12-06 13:00:33	298	1987
299	859000	0	0	2024-12-06 20:15:25	299	927
300	1861000	1	0	2024-12-06 18:19:14	300	299
301	990000	0	0	2024-12-06 20:02:40	301	1262
302	1138000	0	0	2024-12-07 09:25:37	302	700
303	1123000	1	0	2024-12-07 17:17:54	303	1031
304	850000	0	2	2024-12-07 21:24:09	304	1788
305	1114000	1	0	2024-12-07 09:32:51	305	491
306	1318000	0	0	2024-12-07 20:04:00	306	1022
307	635000	0	0	2024-12-07 10:40:18	307	716
308	1766000	1	0	2024-12-07 05:15:53	308	671
309	740000	1	0	2024-12-07 20:30:24	309	1240
310	920000	0	2	2024-12-08 12:22:02	310	1440
311	598000	1	2	2024-12-08 14:48:49	311	1105
312	594000	0	1	2024-12-08 07:26:28	312	577
313	1808000	1	0	2024-12-08 20:56:03	313	267
314	936000	0	0	2024-12-08 06:56:43	314	1489
315	1485000	0	0	2024-12-08 21:02:26	315	1182
316	604000	1	0	2024-12-08 20:40:30	316	1362
317	580000	0	0	2024-12-09 20:09:49	317	882
318	1865000	1	1	2024-12-09 12:37:23	318	403
319	825000	0	0	2024-12-09 21:54:40	319	1465
320	920000	1	0	2024-12-09 14:28:59	320	507
321	799000	0	0	2024-12-09 18:29:11	321	857
322	1478000	1	0	2024-12-09 21:10:11	322	1169
323	985000	0	0	2024-12-09 08:39:46	323	1280
324	551000	1	0	2024-12-09 11:37:49	324	1581
325	760000	0	0	2024-12-09 06:22:11	325	927
326	2518000	0	0	2024-12-09 14:50:22	326	1763
327	1210000	0	0	2024-12-10 19:49:37	327	734
328	604000	0	0	2024-12-10 06:37:42	328	534
329	598000	1	0	2024-12-10 21:24:34	329	1581
330	634000	1	0	2024-12-10 19:40:51	330	1790
331	895000	1	0	2024-12-10 10:52:40	331	414
332	1237000	0	0	2024-12-10 05:35:10	332	1506
333	1149000	0	0	2024-12-10 07:29:45	333	386
334	856000	0	0	2024-12-10 21:14:12	334	93
335	1279000	1	0	2024-12-11 05:58:13	335	1234
336	609000	1	0	2024-12-11 05:12:54	336	1099
337	685000	1	0	2024-12-11 06:35:20	337	1149
338	870000	1	0	2024-12-11 15:51:39	338	1971
339	615000	1	0	2024-12-11 14:20:28	339	1161
340	1000000	0	0	2024-12-11 21:26:22	340	671
341	1456000	0	1	2024-12-11 21:41:45	341	225
342	555000	0	0	2024-12-11 19:20:36	342	289
343	1145000	0	0	2024-12-11 16:30:27	343	1148
344	585000	0	0	2024-12-12 09:22:18	344	309
345	970000	0	0	2024-12-12 05:14:09	345	1079
346	1300000	0	0	2024-12-12 18:27:03	346	715
347	953000	1	0	2024-12-12 20:57:28	347	19
348	940000	1	0	2024-12-12 11:59:05	348	992
349	830000	1	0	2024-12-12 14:18:26	349	1898
350	310000	1	0	2024-12-12 10:49:54	350	742
351	1329000	1	0	2024-12-12 16:35:33	351	1665
352	1316000	1	0	2024-12-13 05:59:01	352	1401
353	1006000	1	0	2024-12-13 16:07:21	353	1788
354	637000	0	0	2024-12-13 20:22:44	354	620
355	860000	0	1	2024-12-13 16:30:55	355	1614
356	1040000	0	0	2024-12-13 10:00:09	356	1527
357	990000	1	0	2024-12-13 06:34:30	357	903
358	1340000	0	0	2024-12-13 15:33:43	358	1255
359	480000	1	0	2024-12-13 09:55:25	359	362
360	1230000	1	0	2024-12-13 17:41:50	360	634
361	1345000	0	0	2024-12-13 09:43:25	361	553
362	1070000	0	0	2024-12-14 20:19:34	362	1748
363	530000	1	0	2024-12-14 18:13:05	363	481
364	670000	0	0	2024-12-14 15:28:25	364	556
365	1004000	0	0	2024-12-14 16:57:23	365	10
366	1070000	0	0	2024-12-14 13:30:56	366	906
367	648000	0	0	2024-12-14 15:06:53	367	1385
368	756000	1	0	2024-12-14 20:29:24	368	1313
369	1276000	1	0	2024-12-14 05:21:58	369	743
370	399000	0	1	2024-12-15 20:20:57	370	1256
371	520000	1	0	2024-12-15 10:10:05	371	1215
372	480000	0	0	2024-12-15 20:48:37	372	387
373	620000	0	0	2024-12-15 20:44:00	373	1842
374	1278000	0	0	2024-12-15 10:42:23	374	324
375	1133000	0	0	2024-12-15 06:34:22	375	1716
376	1285000	0	0	2024-12-15 19:35:43	376	691
377	705000	0	0	2024-12-15 07:03:57	377	912
378	1345000	1	0	2024-12-16 19:17:57	378	1233
379	1215000	0	0	2024-12-16 15:29:50	379	842
380	1314000	0	0	2024-12-16 15:55:49	380	245
381	780000	1	0	2024-12-16 09:24:14	381	991
382	440000	1	0	2024-12-16 13:37:00	382	1587
383	1033000	1	0	2024-12-16 11:45:31	383	321
384	935000	1	0	2024-12-16 11:04:33	384	634
385	628000	0	0	2024-12-16 16:57:57	385	799
386	1348000	0	1	2024-12-17 15:16:17	386	857
387	875000	0	0	2024-12-17 14:03:10	387	203
388	818000	1	0	2024-12-17 21:41:52	388	1116
389	1256000	0	0	2024-12-17 08:52:18	389	1207
390	691000	1	0	2024-12-17 12:47:38	390	903
391	836000	1	0	2024-12-17 13:05:44	391	798
392	2239000	0	0	2024-12-17 20:46:49	392	1845
393	963000	1	0	2024-12-18 16:38:18	393	1357
394	1750000	0	0	2024-12-18 21:32:09	394	920
395	885000	1	0	2024-12-18 07:51:37	395	1469
396	1010000	0	0	2024-12-18 12:16:58	396	843
397	594000	0	0	2024-12-18 19:33:22	397	622
398	245000	1	1	2024-12-18 06:38:39	398	828
399	820000	1	0	2024-12-18 20:40:43	399	1181
400	1298000	1	0	2024-12-18 08:42:55	400	997
401	1440000	1	0	2024-12-18 18:42:35	401	1263
402	835000	1	0	2024-12-19 13:25:57	402	853
403	1238000	0	1	2024-12-19 10:36:39	403	585
404	519000	0	0	2024-12-19 10:38:19	404	858
405	1634000	0	0	2024-12-19 18:42:00	405	486
406	1205000	0	0	2024-12-19 18:58:57	406	1809
407	390000	0	0	2024-12-19 07:41:49	407	1427
408	795000	0	0	2024-12-19 21:08:49	408	1526
409	1459000	0	0	2024-12-19 10:44:53	409	95
410	770000	0	0	2024-12-19 21:11:02	410	937
411	1180000	0	0	2024-12-19 18:21:58	411	415
412	1761000	0	0	2024-12-20 18:30:55	412	1101
413	1125000	1	0	2024-12-20 20:39:56	413	1853
414	1260000	1	1	2024-12-20 11:47:15	414	1120
415	1594000	1	1	2024-12-20 19:51:23	415	1778
416	848000	1	0	2024-12-20 21:29:31	416	1857
417	1474000	1	0	2024-12-20 06:30:50	417	928
418	394000	0	0	2024-12-20 18:02:09	418	1014
419	434000	1	2	2024-12-21 21:52:45	419	1300
420	986000	0	0	2024-12-21 08:52:47	420	1831
421	1632000	1	0	2024-12-21 17:30:49	421	999
422	770000	0	0	2024-12-21 20:42:38	422	1971
423	756000	1	0	2024-12-21 05:41:44	423	835
424	1316000	0	0	2024-12-21 14:23:14	424	119
425	480000	0	0	2024-12-21 07:50:21	425	355
426	1425000	0	1	2024-12-21 13:43:09	426	1959
427	1438000	1	1	2024-12-22 14:20:10	427	681
428	1209000	0	1	2024-12-22 15:12:38	428	156
429	594000	1	0	2024-12-22 13:25:20	429	94
430	1202000	0	0	2024-12-22 18:21:37	430	1552
431	1020000	0	0	2024-12-22 18:36:15	431	1007
432	1034000	0	0	2024-12-22 17:22:53	432	481
433	550000	0	0	2024-12-22 08:32:41	433	172
434	516000	0	0	2024-12-22 21:48:16	434	1528
435	1648000	1	0	2024-12-22 15:14:05	435	1736
436	1558000	0	1	2024-12-22 09:31:17	436	1169
437	1160000	1	0	2024-12-23 20:15:05	437	1266
438	1134000	1	0	2024-12-23 16:05:40	438	982
439	2380000	0	0	2024-12-23 21:21:35	439	1407
440	1388000	1	0	2024-12-23 13:45:49	440	1664
441	893000	0	0	2024-12-23 16:17:40	441	921
442	1010000	0	0	2024-12-23 10:11:06	442	1481
443	365000	0	0	2024-12-23 10:53:27	443	598
444	1130000	0	0	2024-12-23 17:20:58	444	604
445	1560000	0	0	2024-12-23 07:12:51	445	1652
446	1179000	0	0	2024-12-24 19:49:52	446	1708
447	1028000	0	0	2024-12-24 14:49:06	447	243
448	410000	1	1	2024-12-24 20:58:05	448	1061
449	1696000	0	0	2024-12-24 18:55:04	449	778
450	1025000	1	0	2024-12-24 09:32:40	450	396
451	1320000	0	0	2024-12-24 19:15:14	451	1207
452	480000	0	0	2024-12-24 21:32:30	452	586
453	485000	1	0	2024-12-24 12:56:09	453	1607
454	357000	1	0	2024-12-24 20:37:35	454	1954
455	700000	0	0	2024-12-25 20:47:41	455	1214
456	1225000	0	0	2024-12-25 17:25:44	456	351
457	1416000	1	0	2024-12-25 11:10:16	457	85
458	1526000	0	0	2024-12-25 17:55:10	458	1870
459	785000	0	0	2024-12-25 21:08:05	459	1148
460	1205000	1	0	2024-12-25 21:23:23	460	991
461	875000	1	0	2024-12-25 19:54:36	461	1923
462	875000	0	0	2024-12-25 21:11:16	462	516
463	755000	1	1	2024-12-25 18:36:26	463	1526
464	982000	1	0	2024-12-26 19:12:06	464	915
465	754000	1	0	2024-12-26 20:17:00	465	673
466	769000	0	0	2024-12-26 18:35:59	466	699
467	1360000	1	0	2024-12-26 20:52:34	467	1701
468	695000	0	0	2024-12-26 21:30:27	468	1508
469	590000	0	0	2024-12-26 19:21:26	469	1716
470	1340000	1	0	2024-12-26 17:18:29	470	273
471	328000	0	0	2024-12-27 13:55:31	471	1046
472	833000	1	0	2024-12-27 16:56:06	472	1790
473	957000	1	0	2024-12-27 18:33:50	473	1190
474	1230000	0	1	2024-12-27 10:54:14	474	334
475	450000	1	0	2024-12-27 16:08:41	475	254
476	795000	0	2	2024-12-27 08:40:30	476	92
477	1296000	1	0	2024-12-27 21:35:07	477	1887
478	846000	0	0	2024-12-27 15:44:12	478	324
479	2568000	0	0	2024-12-27 13:54:56	479	1962
480	414000	0	0	2024-12-28 12:03:27	480	1549
481	891000	0	0	2024-12-28 07:24:09	481	1274
482	875000	0	0	2024-12-28 21:48:38	482	85
483	618000	0	2	2024-12-28 18:44:29	483	686
484	855000	1	0	2024-12-28 15:19:17	484	461
485	490000	1	0	2024-12-28 19:03:23	485	1585
486	1227000	0	0	2024-12-28 06:15:39	486	1935
487	1320000	0	0	2024-12-28 16:17:47	487	601
488	229000	0	0	2024-12-28 17:19:22	488	572
489	318000	1	0	2024-12-28 16:42:36	489	604
490	830000	0	0	2024-12-29 12:40:09	490	156
491	1020000	1	0	2024-12-29 20:42:02	491	1721
492	1425000	1	0	2024-12-29 19:52:35	492	1250
493	1150000	0	0	2024-12-29 07:11:36	493	1738
494	1608000	0	0	2024-12-29 12:43:29	494	824
495	1720000	1	2	2024-12-29 08:47:22	495	1965
496	1214000	1	0	2024-12-29 19:36:48	496	1178
497	1803000	0	0	2024-12-29 11:56:51	497	78
498	654000	0	0	2024-12-29 20:07:51	498	1416
499	594000	0	0	2024-12-30 14:39:54	499	922
500	1550000	0	0	2024-12-30 19:58:12	500	105
501	660000	0	0	2024-12-30 17:54:12	501	1873
502	1315000	0	0	2024-12-30 13:18:42	502	291
503	1170000	0	0	2024-12-30 10:35:29	503	1634
504	1308000	0	0	2024-12-30 06:13:50	504	982
505	1445000	0	2	2024-12-30 11:05:35	505	1604
506	660000	0	0	2024-12-30 11:58:16	506	324
507	1968000	0	1	2024-12-30 11:25:07	507	1072
508	1780000	1	0	2024-12-30 20:16:59	508	1770
\.


--
-- Data for Name: payment_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_order (payment_id, order_id) FROM stdin;
1	1
2	2
3	3
4	4
5	5
6	6
7	7
8	8
9	9
10	10
11	11
12	12
13	13
14	14
15	15
16	16
17	17
18	18
19	19
20	20
21	21
22	22
23	23
24	24
25	25
26	26
27	27
28	28
29	29
30	30
31	31
32	32
33	33
34	34
35	35
36	36
37	37
38	38
39	39
40	40
41	41
42	42
43	43
44	44
45	45
46	46
47	47
48	48
49	49
50	50
51	51
52	52
53	53
54	54
55	55
56	56
57	57
58	58
59	59
60	60
61	61
62	62
63	63
64	64
65	65
66	66
67	67
68	68
69	69
70	70
71	71
72	72
73	73
74	74
75	75
76	76
77	77
78	78
79	79
80	80
81	81
82	82
83	83
84	84
85	85
86	86
87	87
88	88
89	89
90	90
91	91
92	92
93	93
94	94
95	95
96	96
97	97
98	98
99	99
100	100
101	101
102	102
103	103
104	104
105	105
106	106
107	107
108	108
109	109
110	110
111	111
112	112
113	113
114	114
115	115
116	116
117	117
118	118
119	119
120	120
121	121
122	122
123	123
124	124
125	125
126	126
127	127
128	128
129	129
130	130
131	131
132	132
133	133
134	134
135	135
136	136
137	137
138	138
139	139
140	140
141	141
142	142
143	143
144	144
145	145
146	146
147	147
148	148
149	149
150	150
151	151
152	152
153	153
154	154
155	155
156	156
157	157
158	158
159	159
160	160
161	161
162	162
163	163
164	164
165	165
166	166
167	167
168	168
169	169
170	170
171	171
172	172
173	173
174	174
175	175
176	176
177	177
178	178
179	179
180	180
181	181
182	182
183	183
184	184
185	185
186	186
187	187
188	188
189	189
190	190
191	191
192	192
193	193
194	194
195	195
196	196
197	197
198	198
199	199
200	200
201	201
202	202
203	203
204	204
205	205
206	206
207	207
208	208
209	209
210	210
211	211
212	212
213	213
214	214
215	215
216	216
217	217
218	218
219	219
220	220
221	221
222	222
223	223
224	224
225	225
226	226
227	227
228	228
229	229
230	230
231	231
232	232
233	233
234	234
235	235
236	236
237	237
238	238
239	239
240	240
241	241
242	242
243	243
244	244
245	245
246	246
247	247
248	248
249	249
250	250
251	251
252	252
253	253
254	254
255	255
256	256
257	257
258	258
259	259
260	260
261	261
262	262
263	263
264	264
265	265
266	266
267	267
268	268
269	269
270	270
271	271
272	272
273	273
274	274
275	275
276	276
277	277
278	278
279	279
280	280
281	281
282	282
283	283
284	284
285	285
286	286
287	287
288	288
289	289
290	290
291	291
292	292
293	293
294	294
295	295
296	296
297	297
298	298
299	299
300	300
301	301
302	302
303	303
304	304
305	305
306	306
307	307
308	308
309	309
310	310
311	311
312	312
313	313
314	314
315	315
316	316
317	317
318	318
319	319
320	320
321	321
322	322
323	323
324	324
325	325
326	326
327	327
328	328
329	329
330	330
331	331
332	332
333	333
334	334
335	335
336	336
337	337
338	338
339	339
340	340
341	341
342	342
343	343
344	344
345	345
346	346
347	347
348	348
349	349
350	350
351	351
352	352
353	353
354	354
355	355
356	356
357	357
358	358
359	359
360	360
361	361
362	362
363	363
364	364
365	365
366	366
367	367
368	368
369	369
370	370
371	371
372	372
373	373
374	374
375	375
376	376
377	377
378	378
379	379
380	380
381	381
382	382
383	383
384	384
385	385
386	386
387	387
388	388
389	389
390	390
391	391
392	392
393	393
394	394
395	395
396	396
397	397
398	398
399	399
400	400
401	401
402	402
403	403
404	404
405	405
406	406
407	407
408	408
409	409
410	410
411	411
412	412
413	413
414	414
415	415
416	416
417	417
418	418
419	419
420	420
421	421
422	422
423	423
424	424
425	425
426	426
427	427
428	428
429	429
430	430
431	431
432	432
433	433
434	434
435	435
436	436
437	437
438	438
439	439
440	440
441	441
442	442
443	443
444	444
445	445
446	446
447	447
448	448
449	449
450	450
451	451
452	452
453	453
454	454
455	455
456	456
457	457
458	458
459	459
460	460
461	461
462	462
463	463
464	464
465	465
466	466
467	467
468	468
469	469
470	470
471	471
472	472
473	473
474	474
475	475
476	476
477	477
478	478
479	479
480	480
481	481
482	482
483	483
484	484
485	485
486	486
487	487
488	488
489	489
490	490
491	491
492	492
493	493
494	494
495	495
496	496
497	497
498	498
499	499
500	500
501	501
502	502
503	503
504	504
505	505
506	506
507	507
508	508
\.


--
-- Data for Name: shopping_cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shopping_cart (cart_id, created_at, update_at, user_id) FROM stdin;
\.


--
-- Data for Name: user_cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_cart (cart_id, user_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, user_name, gender, age, user_password, user_role, phone, acc_name) FROM stdin;
1	Trần Khánh Lan	F	60	q#/c)^6uDoY	0	0129125522	llKQzeQhEO
2	Ngô Tuệ Chi	F	57	tuSg?bI:	0	0535752803	TUWXX6HIEc
3	Trần Minh Huy	M	61	e!ON|]HtbiFR}	0	0627861328	1jNTPjB6dP
4	Vũ Thị Chi	F	56	bE)HR>HA3	0	0966635256	7MPJrxPaJx
5	Dương Khánh Thư	F	50	la}+#KWl@	0	0638791971	BG9nPEpko1
6	Hồ Thùy Như	F	38	D+r9ZI(t	0	0415456691	lEKVhj6T6V
7	Đỗ Quang Khoa	M	43	]SdZD8n};A	0	0391375818	hyz09ot1mn
8	Vũ Tuệ Như	F	39	]zD-3%w>*;W0	0	0354671797	9iZET5Joi8
9	Hồ Minh Minh	M	54	:z*=m_]d:xyp5	0	0667985305	4VbCIv9Smy
10	Hồ Thị Như	F	19	|M$!o}Wy9/ld=X	0	0928362266	QpqrVY0Jvq
11	Huỳnh Gia Minh	M	47	eY}LvV)Nv68:rLBH@}!s	0	0414521882	p1vIF7WE0Y
12	Ngô Anh Khang	M	55	M^(%Pxiz	0	0369774112	mGskUliNoJ
13	Vũ Thiên Khang	M	52	U/Ru.]@8C!o^uBYcY	0	0360659980	03YvBqFJWb
14	Đặng An Chi	F	58	Q/Xb_B8S0j[	0	0580634195	lyIOFLLegy
15	Lê Anh Minh	M	47	[r_sBf1xp/	0	0625675681	A2ST0gjnEq
16	Hồ Thùy Linh	F	24	4(d^0G;RsfHyp|$63r?E	0	0349142032	KhD07yCaZP
17	Đặng Bích Linh	F	58	hZ=cUPW8mNJ|9jPK%@P0	0	0905309678	mzVbyoCQpr
18	Phạm Văn Phúc	M	25	AtR*6!_]::h3nWR^L$7!	0	0812466831	04hLQhKuuI
19	Dương Thu Lan	F	23	c#b)@</k	0	0943780528	u4UcmyndJ1
20	Đỗ Thu Chi	F	65	c!-2^YPm>/2	0	0496123253	qTHdDta3zb
21	Trần Anh Bảo	M	54	3@m(}UY)u}	0	0852680169	L6AG640sZm
22	Bùi Anh Phúc	M	48	u@,*$0.env!td	0	0530038796	vczWpAkkbs
23	Đặng Thị Nguyệt	F	54	2C#q_2jp%h*+HYy4U%K	0	0799165615	fbUDLDZG89
24	Võ An Nguyệt	F	18	b_-nv.n@}Y0tsK]*	0	0220309640	a84Flc3Zj9
25	Lý Gia Huy	M	36	jQ_SFPa?vsPM	0	0703850565	hWyjQzh1rM
26	Huỳnh Minh Phúc	M	54	TmFgo,yn.;M$	0	0488798044	IBOszSirgU
27	Lý Văn Phúc	M	48	2O}}5^kTYyW	0	0380496039	29hTjtvmo5
28	Lê Gia Khoa	M	62	_LhX:,f>eBwrR<DXi8j	0	0664426225	LHRNIKal0l
29	Đặng Khánh Như	F	21	U8KBxveYmGEjbw%:6J	0	0116219424	5Ow08qSCEr
30	Vũ An Chi	F	43	!L%4UJE@1QS	0	0828706933	5LJQwUIrqK
31	Trần Thùy Thư	F	49	qz:aAs!+gE<NJQ[hXPE	0	0216186668	LDGMgkkAOK
32	Vũ Minh Phúc	M	40	<a#Em4yb	0	0444678489	m4vBG13P3a
33	Võ Khánh Nguyệt	F	32	eK%A3suF(W[[YGZ#j@	0	0549113562	YTI0jkk81T
34	Ngô An Thư	F	29	yT%^5im9O	0	0571824893	Xx8nBDhCtC
35	Đặng Khánh Thư	F	63	gMIFxsG/_	0	0767018319	3vIowGvnNj
36	Trần Gia Minh	M	59	LcO^[,}IYqkR4U_	0	0768783539	XyjMXqkm31
37	Bùi Thu Như	F	53	lRODBeR>D8mAXw?El3&|	0	0169750969	oTzeWQFjm1
38	Vũ Tuệ Chi	F	47	N3G^,;i0BFv)x>>5WGkd	0	0589734354	hHFTaIraqT
39	Hoàng Minh Minh	M	32	+PrK-ixVKNe,H*	0	0189481915	E29hq1rJn1
40	Nguyễn Thu Thư	F	23	!E1}-?_t	0	0427365942	OAymwn3Gac
41	Lê Bích Linh	F	50	:b^SM,gtVlZh*	0	0490235262	kaC6Msos2U
42	Phạm Khánh Chi	F	44	6Mfw1#cv#&S>}}=!	0	0714313212	KduVmf6dS9
43	Nguyễn Gia Bảo	M	54	Yc+,GTC?[9)u[AIH	0	0779967880	Al5LvcJlkU
44	Trần Bích Như	F	41	ksoma?[gCG	0	0470981024	8UKMkfejIi
45	Bùi Khánh Linh	F	36	vJJ>7<C#	0	0715093086	OQ63q0Ckvi
46	Huỳnh Thùy Chi	F	57	2c@x$.>?J	0	0788254913	PiCWMaPIfG
47	Vũ Anh Minh	M	23	e9nV4q&YF	0	0810677594	o1McAgCRxY
48	Đỗ Tuệ Như	F	46	f!z.U5(I	0	0535514787	FkQIzOQ45n
49	Ngô Khánh Như	F	30	(!(&v)0<X]	0	0784529800	rhcAwIpf7E
50	Võ Văn Phúc	M	56	@Vj6E%SKa+UU{	0	0620472794	aK9javb0xH
51	Bùi Thị Lan	F	23	{-|T-F&nh	0	0690853418	KLAXjzt5XG
52	Dương Minh Minh	M	45	,5Z;2v|PMa	0	0328082050	qwQMh8NIou
53	Huỳnh Gia Khoa	M	55	{sF4>1pWL8|,/fwd!	0	0363184511	f1EtXKVvFd
54	Lê Tuệ Linh	F	24	:|<c{hoa	0	0211987967	1Ukm23YOnn
55	Phạm Gia Khang	M	45	rEg[cnD>tG(NY8r)lc	0	0953247276	jV1gCA05yU
56	Nguyễn Thùy Lan	F	18	0[_hu;0pOOB&:(]kB{2M	0	0521538462	uAddk8AfoN
57	Võ Thùy Nguyệt	F	38	{lho]Ks&tyll!70!	0	0964070880	dTWMsAff0Y
58	Phạm Thu Thư	F	49	EI0ryhpzyb.7[	0	0420069810	BnPUkZIFSl
59	Trần Quang Huy	M	60	lT:&/eFMV	0	0930969851	rI0DSYzOf2
60	Trần Thị Thư	F	31	Evf-=q})ic.Aj9kENt	0	0418383897	a8RXHBO9VD
61	Ngô Thu Linh	F	58	T@5[%a*hoV8	0	0282892021	0jwnDMaXgi
62	Hoàng Thị Linh	F	29	TW%OrJ#i:z	0	0355998746	epiInAcTqa
63	Ngô Minh Khang	M	39	d;zi=:G;c)Cz}a+B;pZ	0	0205871679	1KmLFI73Ty
64	Dương Thị Lan	F	18	U#-Rmea2BK7$!uj[;{k-	0	0175248916	1iSye2smkC
65	Đỗ Thiên Huy	M	39	[6(,,c<0Jv->	0	0811688552	T6j5QFv5aQ
66	Lê Văn Huy	M	18	3uB)YT$4fVOmQ$9b	0	0714493229	RBoO8Ot8I4
67	Bùi Tuệ Như	F	55	5Dnzr>&,TZ	0	0662510671	6H18wf5Oif
68	Lý Văn Khang	M	51	}TZ]kytq,T.z	0	0872137792	xUcYI1wOMq
69	Phan Thu Lan	F	31	y)VX!-{7C!oco^PA0!	0	0784614665	QiO2vSTuYj
70	Huỳnh Gia Khang	M	50	*gH!HN-vV	0	0637660324	7FhlF4XMJV
71	Ngô An Như	F	43	E%S+,jZrTPq	0	0874855975	waEG1E7xAe
72	Bùi Thiên Khoa	M	46	C{e2E|^w&_,}ME|4en	0	0801100858	1l2TVykY5F
73	Ngô Bích Linh	F	45	EolVd!,=E7a,	0	0248632614	4qA25tnfMh
74	Hồ Anh Huy	M	65	Z&GHcA8m<v1d-	0	0740578391	ZzwpNuuvS7
75	Hoàng Anh Bảo	M	54	4|3l2:!W,avR	0	0849595867	WwydQ1C0el
76	Bùi Thu Nguyệt	F	45	27uK>Tt&N(aXn	0	0525141514	NL72lfItAx
77	Võ Tuệ Linh	F	63	>qk%v[7m;1Bc9	0	0739680071	WtwVfuLI8o
78	Phạm Khánh Chi	F	21	/|bN-1odrBebOZ@fg2y	0	0587525309	GEciTWsnUF
79	Lý Thị Thư	F	39	f<-O&Zwu/#	0	0349146892	xHd3CLLHyV
80	Lý An Nguyệt	F	61	vB5-B#sy!d	0	0151081243	JXLJZ7BmXk
81	Lý Bích Lan	F	61	&<O4CxKY}zqaY;	0	0753920720	I0PHCtLshf
82	Hồ An Như	F	48	T8M,J]El,Iy	0	0212341839	cyhZoRKbLW
83	Hoàng Quang Minh	M	56	Jp{<9inAs7umZ{,{Eye	0	0412780278	EQPU56qH0T
84	Nguyễn Anh Phúc	M	39	TV1q!SYWp7$CxS	0	0132792962	3wvru7BGah
85	Vũ Anh Huy	M	33	AEm=%P<qd}wY8fg>(DI	0	0206156160	4QFTJBYGoT
86	Hoàng Anh Phúc	M	54	GujQxk>T87O_1-Y)CY	0	0875470848	JIDIRqXSNp
87	Hồ Thiên Khoa	M	21	{&9d}3|-:	0	0812237191	uUvklGjvXX
88	Ngô Quang Bảo	M	36	^t=wT#kJIZ?]HP!aCL	0	0365759629	a0lUKYls5k
89	Lê Quang Minh	M	52	:F;@QmoBY(D69]K*	0	0132426300	izFSn0Ct4H
90	Võ An Thư	F	27	l#*!KfXYt-+BP.z	0	0967380213	1ZxkCu8qpn
91	Võ Khánh Nguyệt	F	51	y-[i}}4J2]h]_G^ps	0	0392325657	OBLloo6zTr
92	Hồ Khánh Chi	F	27	%A.Q:)+z}ftqzf@.6zs	0	0515353668	RqH7vu9cIt
93	Phan Minh Khang	M	31	H0CgA]^nOT1fOWXaU,	0	0619195607	T203FbzO2i
94	Nguyễn Bích Lan	F	32	+Lh:9>KSBm04{:).$	0	0897275009	1yVKU9GebH
95	Đặng Anh Minh	M	18	-O)zsY$nf;$>>1I	0	0894474956	7OAO7z1LGN
96	Đỗ Minh Khoa	M	37	RZKv*)?B9eDn,i0]Ub4	0	0766781129	NhcCxth64k
97	Dương Quang Khoa	M	65	,?q->ci<*&F;l	0	0620495904	8MRQrMhCqH
98	Dương Anh Huy	M	34	_Z]|04le-OwENy	0	0347853599	fINhXQQ1jU
99	Nguyễn Quang Phúc	M	46	jg-jR[Sd:$8	0	0216156358	iyrmzMY2MX
100	Lý Anh Phúc	M	38	d6>A#=._	0	0252287114	4E5yiXKfkG
101	Trần Thiên Khoa	M	57	7zCy|AJ0?Xq3Ew	0	0635693845	dyjNiYaduv
102	Phạm Gia Khoa	M	30	x3d5$8z:;W})W16p/:VP	0	0337051443	IVDFLvBp3m
103	Lý Quang Minh	M	44	PH7>(L#$z_oggFB	0	0597534603	0racv1Byl1
104	Vũ An Chi	F	59	xs^n>&?)nyTi	0	0812187656	pfDjkkXL4V
105	Trần Thùy Thư	F	31	R,%9g@vGFV&)UW	0	0827180581	eOFExAMDXI
106	Hoàng Quang Huy	M	30	c+#tuH}h>(s	0	0407909630	xT6aevsWEw
107	Nguyễn Gia Phúc	M	49	=|Gh>k,}FO8	0	0494294332	0SsWHopyUq
108	Hoàng Bích Nguyệt	F	48	)NT:n3j/7	0	0600082728	Dl4fmVmMCs
109	Trần Quang Huy	M	49	hsM=]SuV2[&}qe=J$	0	0459146253	32iVEGrwI6
110	Lý Bích Linh	F	61	6UV<y>[N}p)n{:*uODbg	0	0113349303	dAyco0sWI6
111	Huỳnh Khánh Thư	F	36	DI6%@^?0IB{w;&G2	0	0857826226	t9rGZA4Jum
112	Đỗ Thiên Khoa	M	21	t]IAXir@	0	0685651099	55Kj7DCz8G
113	Huỳnh Văn Huy	M	32	+)#,/aU#0L7WQ(}Q}A	0	0921563236	gfhi9Gd5iR
114	Ngô Bích Nguyệt	F	58	|v*;5?z@.W-e>N&S^SM	0	0816035428	5KyLqQLsb6
115	Trần Khánh Linh	F	45	uN@WB)Q-	0	0170166438	hwxPSl7kh3
116	Ngô Bích Nguyệt	F	48	Q8Fo_:*nb)w%gSF$A8{P	0	0934147237	u09ogxq1iD
117	Hoàng Khánh Lan	F	55	AGuL^99;]P=m>/d#)0	0	0504075498	Rf1UBophLV
118	Trần Gia Minh	M	58	y%,A5%OH.Y%	0	0528716175	N7dcctGmMw
119	Võ Minh Khang	M	34	(<s%!Rs:}	0	0407717531	a01sfgb9KV
120	Hoàng Thiên Minh	M	63	&cPn),*H	0	0374018832	X3abULUWf0
121	Lê Quang Phúc	M	64	TuQ%4kLp	0	0233869846	WvtENEVogB
122	Võ Khánh Chi	F	30	)4NIaa#Fq[%/X^	0	0262026392	XUFzIaxETz
123	Phan Quang Khoa	M	33	L=cD|)bO9h%5tA-V	0	0561720926	Fo1C9LSn1j
124	Trần Bích Linh	F	43	7}ZxwEGl6bkg(s$GfbR@	0	0666943160	YZ48LG9NaQ
125	Đỗ Khánh Như	F	25	V[A=d1<Lk8&1>*%	0	0574510659	dBnMLXSuRh
126	Trần Khánh Lan	F	25	|swal,yx$	0	0350858068	KIS9WDyZvZ
127	Võ Văn Minh	M	64	9a7&q.TZ:WYsW5	0	0349537929	23ai9F19GX
128	Ngô Thu Thư	F	51	sT<:4z=V+rm/	0	0798990451	imxiEXICdx
129	Đỗ Quang Bảo	M	42	{^rOYTejgvbYp|Zi	0	0565356154	vWRJASmCa8
130	Huỳnh Thùy Nguyệt	F	18	37KEK_[J^@5dL9u	0	0995803926	Xi5B2WEMjF
131	Đỗ Thùy Lan	F	64	1MY)d]u(wJGj)0g%xI	0	0833833168	SmJsSrZ1bO
132	Dương Văn Bảo	M	52	y&5|[&]!	0	0733269234	Jb4jnvVJ5u
133	Hồ Minh Bảo	M	47	yBN<%+^M#wi2bQO-H*|	0	0594569522	SkymsVPKSI
134	Lý Thu Lan	F	40	?=&2ii.r	0	0157021695	mJ5hhvN4JY
135	Phan Anh Khoa	M	43	TPP1t(wIiMUe[HIN)V,=	0	0318865094	6ubUbTtGWh
136	Ngô Thu Linh	F	34	gGW!Kh.4$JM]j	0	0532446575	6s4Q4WAit1
137	Ngô Thùy Chi	F	60	bV%WC>uZmn	0	0197127015	HaeubJDrCY
138	Trần Thu Chi	F	47	l>a)max#0k	0	0912517251	6PMkmfy4RG
139	Đặng Anh Khoa	M	33	D/v-K]@K_O	0	0199835501	s3HwwE2T1f
140	Dương Thu Như	F	62	1gI@^ai]E=	0	0384036331	5iuq312CKq
141	Ngô Bích Chi	F	35	Z!#IV3%z!G#>0^	0	0971545752	05Kmjaf9XZ
142	Đỗ Thị Như	F	29	+75)}8;(V/JHy%1dsn:	0	0122598705	0NsRdU0rAt
143	Bùi Bích Chi	F	43	3)m}vV#a	0	0854434149	arTeZaSODo
144	Phạm Thị Nguyệt	F	22	-|1|v7rG	0	0760455403	9F4YkiqWSs
145	Lê An Chi	F	40	8)AF_i|4U	0	0234427397	ssAeExSrf4
146	Phan An Linh	F	18	rE?a)AV>?g	0	0138091572	mGWjvoJTci
147	Đỗ Khánh Linh	F	21	h4dy?PaR(	0	0841463053	XtQmAGZ1WB
148	Lê Gia Huy	M	32	3QLB_{4%G{ivX	0	0189759608	6CLXFVoJO5
149	Hồ Khánh Linh	F	41	qa,mA9DG@%5?}2b	0	0215554225	qTBgTqCwly
150	Ngô Bích Chi	F	26	WLHLJl<fqUFc[&	0	0902203350	KGkxqNwJ1J
151	Lê Anh Bảo	M	38	8.r%fd[y2lt#Ztut	0	0979947506	ecf73U0oGk
152	Hồ Tuệ Như	F	24	HkqID}13X?;p#z	0	0706802611	nrO8y9H8B9
153	Trần Quang Khoa	M	33	=bd^Ua%?	0	0799318628	fi4qldL4rd
154	Hoàng Thiên Bảo	M	50	)k%cWI%8.x6Ry	0	0779894901	8g1NTNaLJI
155	Nguyễn Tuệ Lan	F	18	sxC)gWTS?#({g{cfdGs	0	0649030136	p2UoRNZQpm
156	Dương Thu Chi	F	21	.lms>$%gCiqfIg^&+b	0	0293370126	mvr3gxUGCx
157	Dương Anh Phúc	M	54	v<%K!{fiE!t]Y]Mle	0	0218142150	liyc6HsDO2
158	Ngô An Lan	F	37	Ia:,%83W7-J)%%w	0	0704850023	opDgr8gutC
159	Trần Bích Thư	F	40	1=x#+{DOG_O;	0	0179642369	45mKrtn3Wm
160	Đặng An Thư	F	35	x|x]Y(_#D#@oQ8}-<u	0	0341214831	X69hO7ygnm
161	Trần Quang Huy	M	53	QY<9;?Rf8+	0	0426107806	U7U4H4DZhy
162	Phạm Minh Huy	M	41	dB#eF5yW$zA86Jei*H$)	0	0772771310	qWLzhMX8o0
163	Ngô Minh Khoa	M	18	p:UK,!(mMK	0	0602905449	ljQm6x0dYk
164	Huỳnh An Linh	F	57	R3xc%R;,c!l}4c-A	0	0114146924	6zFVHly1PH
165	Nguyễn Văn Huy	M	39	d<%upJtNF9:l	0	0645472819	mDkuZy8OJ7
166	Huỳnh Tuệ Lan	F	52	h96gla[x|JNql+nI	0	0343790885	yYfkmPJ9ds
167	Lê Bích Lan	F	21	?ZW|j=:o2h<]QHg}AVN	0	0907157764	1nqcfdPizc
168	Vũ Tuệ Lan	F	64	AKK4sZ2[5@kgZj2-zO	0	0861494973	ZcxTyxwOdk
169	Phạm Gia Huy	M	51	C)q@2}Mqtl?M	0	0339190131	Lh2QN6Xkhj
170	Ngô Gia Khoa	M	53	T^ZP8aMyMMXcT	0	0557300364	stDFPPMVrI
171	Vũ Quang Bảo	M	57	yVzdKs$DR	0	0265829744	trfMVT0q2D
172	Dương Minh Minh	M	28	>+zzF%$6!/Zh>e$f	0	0484767939	i8ffX4Pj0k
173	Dương Minh Bảo	M	47	+>6%c){V3QU:)T?V	0	0997200560	oO32k9opCC
174	Hoàng An Nguyệt	F	54	;W}UQifWZ92+	0	0386823323	sXTg44TMzS
175	Trần Thùy Thư	F	32	r9A&Ac:.dmUX#ii4?$	0	0656419469	WCxgM2OFOg
176	Phạm Minh Minh	M	58	<P9h7,q)#;	0	0227090435	LYz8rE0Ejh
177	Trần Minh Huy	M	51	[+8.8,Y21W/x]hUS2oP	0	0556550379	I8RrDPNl7G
178	Lê Thiên Phúc	M	50	>l.JJ]i@OsLd>Q4]	0	0476650472	LzNBZRLtlC
179	Hoàng Thị Lan	F	63	wcbp8eL{BbGmd<	0	0175231092	2Rn2Ccv718
180	Hoàng Anh Khang	M	60	iZ]-6+n6MpPn045<3@	0	0193744126	kpcB6cn3zE
181	Dương Anh Phúc	M	20	e3=](;WV30dO.n1K	0	0553590943	Wtj13xiT7W
182	Hoàng Thị Lan	F	26	l-,q6jm66RCRQ&LL	0	0685863867	0wrgaENqL3
183	Nguyễn Thị Chi	F	38	x<ii2*Cu2e:}k;ZjTON	0	0386019160	T6Jmuo8Sck
184	Phạm Quang Huy	M	36	>?i1!oHv+I	0	0135297254	W0uzLQ3pKK
185	Dương Tuệ Chi	F	21	H_oWf5Dwa5	0	0537467353	HqCeuUnKf5
186	Bùi Quang Phúc	M	23	GRr@}:SYyY!]{H=_4ff	0	0838129004	Geh6oLiryx
187	Hồ Thùy Lan	F	21	fg}wxcyTC5?	0	0175073720	AMlUaZEtDE
188	Dương Thị Chi	F	44	[O=rtt,Yc?grHfp@)M	0	0830264849	dBsp2pfqNK
189	Vũ Thị Chi	F	63	@lNNI)^Z;gx|z!qF[et	0	0119539417	zLdSmpuzP3
190	Hồ Bích Linh	F	30	@qH%vRl2uA<w:%LF&	0	0445375965	gB23rj0BfD
191	Dương Thùy Nguyệt	F	33	@$A)<rST&{MsTceX	0	0123294701	yv6bHUyQBz
192	Lê An Thư	F	61	j1bo=)uPxRgYi:|	0	0389238198	gjZwQpiCb0
193	Dương Văn Phúc	M	22	[]:y02Wz	0	0771936752	M5685Dnv68
194	Đỗ An Linh	F	52	=c{S9kX(8R8u	0	0195093592	Il8FoBwhah
195	Nguyễn Minh Khoa	M	38	}FO2dUg!;I&a&	0	0167629616	tSRLNQsE93
196	Trần An Thư	F	49	{0Yh3Z3|tct)Ee7z$	0	0638762452	EMnfCn9qjr
197	Huỳnh Văn Huy	M	51	IOv]f$T<	0	0361140690	LjS7WqUj7x
198	Vũ Văn Phúc	M	19	z(qj_pnt![rt9m;wK	0	0608965696	yosgsS1fRf
199	Vũ Thu Chi	F	40	::n/xYbWyK(iA$M	0	0518591097	IKAdlFYyXb
200	Đỗ Thu Linh	F	37	@oaYi%NH<Hb,mKY	0	0614367401	7kcBcViyAd
201	Hồ Gia Minh	M	45	?hzHEToGw!Z0-z5vQ	0	0143528963	3rYhdUYXvZ
202	Hồ Khánh Nguyệt	F	63	yd|B(CB6vt9.Iqr,51mp	0	0673230295	rdl6ptmvnJ
203	Đặng Anh Minh	M	22	+Qm[O;)!	0	0451622046	RfdLHbhKYg
204	Vũ Thiên Bảo	M	24	$8_9JvePxn#}t|;	0	0783502045	eSKsNSnVMX
205	Huỳnh Anh Huy	M	52	nc$q[zMjqoPh1JJ;+:y	0	0346102783	gxHbla5Rpr
206	Trần Thiên Huy	M	53	1;C5D!lzjP{VJ0=nR[I	0	0239170311	NIW36lwANA
207	Hồ Bích Chi	F	36	+T|-QTPX+eQF	0	0770877927	ssQDKfEupd
208	Đỗ An Như	F	49	aqo:kgq-LM&mqyNFv	0	0765120554	dOkWYhyE2v
209	Đặng Thị Lan	F	30	ONvj|;@ql	0	0401909602	kJnpAgsYbk
210	Võ Tuệ Linh	F	39	%cj2nc$QNt:S9	0	0227396336	nuK5cAduFq
211	Trần Tuệ Linh	F	22	4yDN@M$^,l^=,|V	0	0898676697	v7RWqaOkPX
212	Đỗ Anh Minh	M	59	Q.sD;Y41H7dE=JnMY!H	0	0914947591	G5y9IqsxBS
213	Hoàng Văn Khoa	M	40	I}dU!y<#j@I:KtR	0	0914217783	MBnwdTzif3
214	Trần Thu Như	F	32	9lWh2v8yTlV1@<N	0	0233123291	1fBx83HcKi
215	Phan Anh Bảo	M	55	*Lm))L_!;P;[e/	0	0731795134	EeNGQgQv4L
216	Hoàng Anh Bảo	M	63	|jd;/L_Y-4],	0	0126077338	YEOIz1FR6m
217	Vũ Thùy Như	F	46	8(o0o>HF	0	0539060987	74MpGDEFdH
218	Dương Gia Khang	M	51	cb_*3O_E%)F	0	0899671296	HMWuNXIyyr
219	Trần Tuệ Như	F	58	o9Rq+ow644Zg+:S?@,0x	0	0864389142	YQsIostmY4
220	Võ Văn Huy	M	40	m)S=JOOk++}D64XAK?B:	0	0487151812	ZZEC9h5won
221	Đỗ Văn Bảo	M	47	&/a[4/]/*	0	0376705756	ITjewVF5KM
222	Hồ Gia Huy	M	26	_*V<t|&aX!-	0	0299580116	8KVRUkPNOh
223	Lê Bích Như	F	59	@X>g*3JQp	0	0195140441	Mmj0fsuMBB
224	Vũ Văn Khoa	M	60	(|HIXlRMJ+U7#u8_S6#	0	0880820495	yi7kC4nC9P
225	Lê Văn Minh	M	26	yFN2&/BZQn[2K]{	0	0302525502	PjNNXhkZDy
226	Bùi Quang Huy	M	52	+ZgBk<k[i$	0	0814342625	rfcnXVROUu
227	Vũ Thiên Khoa	M	42	u=FwKY^L?JIjd	0	0742037326	mQbP4MDgXF
228	Bùi Thị Lan	F	59	nhEzqi|!	0	0423366373	JHUHB6697s
229	Hoàng Quang Bảo	M	23	F/=.l0kQ6FBhLu?1#QVL	0	0540540917	PtAuKt1kb3
230	Nguyễn Gia Bảo	M	50	O<5pyz#2}41p|=Zo5:{	0	0923577644	Q00O6pHAL1
231	Bùi Quang Khang	M	25	A+p>d_bSzqVRs#@s^T	0	0816277891	wwS63sA207
232	Hoàng Anh Khang	M	48	zWMx2eE|z=31	0	0208104266	9AZDNBwxeI
233	Bùi Thùy Nguyệt	F	33	Y#[nxY)70:;	0	0629469215	hZjhsO3Uk8
234	Đỗ Thị Chi	F	46	xyd1^I2?:5gB	0	0844361103	HKEyyvZ9zr
235	Nguyễn Tuệ Thư	F	51	k!N*v.2VQ$Mr	0	0795998087	flelYEIkod
236	Võ Gia Minh	M	63	mOCB3)e67})*	0	0494913613	DgNFc2bWyo
237	Võ An Linh	F	63	fWBj=%M8+5;VT|E	0	0791645467	okDaHPARO2
238	Hoàng Anh Minh	M	41	]iF+]sx$,fikxBzk	0	0294122395	JJ58RtSkRU
239	Hồ Tuệ Thư	F	54	6]@MV*j<-(4j	0	0891218717	4vfbPbnb1H
240	Hoàng Thùy Lan	F	55	X*U3bg{?$3g/_X%E	0	0350782230	b2RfJBuO1b
241	Dương Khánh Linh	F	29	T42<Q%{VaAJ--5n%t0=/	0	0272749507	MXvVFuU1o4
242	Bùi Anh Bảo	M	46	)2?LBNum$kt{?4)X	0	0314851400	1oAiXxYEMx
243	Hoàng Anh Phúc	M	29	r_&$+O,CR	0	0189392311	IxqD5NZBkB
244	Đặng Gia Huy	M	65	]w6uglC;	0	0113355448	gGwkSxjXOL
245	Hồ Văn Khang	M	24	.]-t+[ZRL	0	0368286444	Z4fxxNMuOw
246	Phan Anh Khang	M	58	jzvoa;63Us&9	0	0798221478	jaMknXWncC
247	Hồ Thu Chi	F	19	/fXwe:BnP@XnW.#4	0	0378553283	6dbeqx7pA8
248	Trần Thùy Thư	F	64	]6!}6|QQ$7*{F	0	0332913098	uHs3jNk4eo
249	Lý An Như	F	33	=?b@OV#]O	0	0148664075	xT6HvRdqXY
250	Hoàng Thu Linh	F	38	%Nhv62W#e7>%(P;	0	0714551627	k0z9iY7og0
251	Dương An Lan	F	36	mn)RR)F7o<)^X|>M*b}^	0	0526311546	uNqOvJJKoZ
252	Lý Khánh Linh	F	37	JvfW(mvf<SL#Fb	0	0953525013	AfcSUTMPi5
253	Lê Bích Nguyệt	F	62	1&#<^@qdki8QT/L,fIr	0	0646495375	Q3exJvHGsW
254	Phan Văn Minh	M	47	,A?)rW<I	0	0920986751	exFCNPW90h
255	Huỳnh Thùy Lan	F	60	uBGLn??[/I0N,^G	0	0707088650	wiga3l2QiL
256	Hoàng Gia Khang	M	43	G|3L.<h{#+	0	0949412065	OIYxzAS6Wj
257	Võ Thùy Nguyệt	F	35	X+u.M&9gw	0	0955264496	LbWiFwP3zd
258	Lý Thu Thư	F	37	ObJv#CZT%.61024[6&	0	0758235781	m6Rycb5Hxv
259	Đặng Gia Khang	M	65	cXB)v<d;reicCO	0	0839175524	MM2TRjQIcz
260	Vũ Bích Nguyệt	F	62	WpQgk&hwik&>:	0	0567599532	nIsfzEl3qO
261	Bùi Văn Huy	M	53	iJv{i5#TGS8B!h-r	0	0451841591	DYTeMIf5X5
262	Lý Thu Chi	F	50	.0b6I.H.	0	0546537324	JaPudq17j7
263	Trần Anh Huy	M	46	Tvh9()vg[;>dP	0	0384376382	g4He5yk0Vn
264	Hoàng Anh Minh	M	50	:AI8*&S+b	0	0255463158	Sp8XpIl450
265	Hoàng Anh Phúc	M	64	vG$_abU:	0	0760736332	fNXkH2nbZx
266	Hồ Anh Minh	M	37	rQ_wg&!wdO	0	0119591221	jTEqkrWleV
267	Dương Thị Lan	F	21	|U,Sg8r[v_P	0	0999306579	gIeM95a9Z5
268	Vũ Thiên Khoa	M	21	p(g?^|f%[5	0	0618010068	9elmuUiiOt
269	Lê Bích Chi	F	40	RDs^/ry>iL@	0	0354228445	naozMt3EJZ
270	Trần Thùy Chi	F	31	dUDN,%3zV	0	0751874447	w2jYtIa5kN
271	Phan Văn Khang	M	44	U{(h^yMGXS)lm<	0	0658638368	SfTjsLJ42o
272	Vũ Minh Huy	M	46	{&0u}8mp2T+-j}DRi	0	0487149454	dBjkS67ky1
273	Đặng Minh Bảo	M	28	%/57-GQzu_,}T5	0	0378703092	fcHmCZimqY
274	Đặng Minh Bảo	M	29	wJbSL-4e&:h6x-,C	0	0333392115	FgaVrx3E8U
275	Hoàng Minh Khang	M	62	&&#xfZ$aa?GA_<0XCEc	0	0857678986	OtHTtj6ok8
276	Trần An Chi	F	23	=A+{Znycb.	0	0238280823	VpsXG8BYLE
277	Trần Anh Minh	M	44	;@}B?Uw@xo)i	0	0705459275	JuafQJ2KzS
278	Nguyễn Thị Nguyệt	F	65	OPjl+IJ2/	0	0110484117	mxgQ6GP8SJ
279	Trần Minh Huy	M	34	j2yw<)_{5a^;:^}sg}	0	0819747242	G1ul5zbE1N
280	Hồ Khánh Nguyệt	F	40	1e_jplh{	0	0383276981	o79fN26V0p
281	Dương Thùy Linh	F	32	hTXwyChAIevjN7*H	0	0400296416	OckQZXmUj6
282	Đỗ Quang Khoa	M	26	##10umn2u*A	0	0274081876	iqyT4OvG6a
283	Vũ Thị Chi	F	51	DmN<>;Wz)&Y	0	0846089663	Ypq6qc18nM
284	Lê Thị Như	F	41	-x<*?E(W_xs	0	0784347016	FGzeFi1lZk
285	Dương Anh Minh	M	40	e2MA?3&8e=KwfUI{	0	0857822817	Mc0cjhRTxO
286	Bùi Quang Huy	M	41	,kj*iSeW29	0	0611451090	G41puzvk2w
287	Phan Gia Khang	M	63	zo6*5mym)9&/	0	0760497492	3zHAAEn2NK
288	Phan Thu Lan	F	25	P[%qJ;P;W#k1	0	0994176841	MDvuUbozVg
289	Phan Văn Khang	M	26	-OeXpu9^^OjFLf5=f4&	0	0655632232	zhTHFQn5rj
290	Phạm Khánh Thư	F	39	$;&hn?Enim:cy[	0	0902626477	uZqbHA8IF1
291	Vũ Văn Bảo	M	20	7Q=cr^hQ	0	0884257972	gvOutgD3Nw
292	Lê Văn Khang	M	63	a@q1+!/h;WgEh5{:	0	0720805253	FOMbfojMa2
293	Lý Tuệ Lan	F	29	;.L?[kc4J|f,:m	0	0538664793	JqgcbLW70w
294	Đặng Thị Thư	F	41	]RX/0<3%K-	0	0397092044	gGLO8L3RtX
295	Huỳnh Anh Huy	M	39	8HbRI(N:9:Q7,	0	0594106235	vSwKicaJuG
296	Đặng Văn Khang	M	28	%hvv0>IW|tp	0	0159960460	ATj2R3KwGh
297	Hồ Anh Khang	M	20	>^v9s^{)N?o]X#	0	0468274886	VUf0pzcgcl
298	Võ Anh Huy	M	57	,x51R;3.u?1	0	0719689187	aUdTyfyK9o
299	Hoàng Minh Phúc	M	30	BFVzn7OiwAgU)Pt#	0	0355776254	SbS6heaOCx
300	Bùi Văn Huy	M	49	/DdPDo$h	0	0866224847	S3HeFHu258
301	Vũ Thùy Như	F	60	X@{d4#aA1nz,C9o@^mX	0	0349709530	ea36MuQwNv
302	Phạm Văn Khang	M	47	j!FKN@B^R,5b#_Aem!	0	0779343743	Fv3c0ITSIq
303	Đặng Văn Khang	M	43	5Dxxb*V7i&)9a$&_fc_M	0	0124697887	UjY53kDF0P
304	Ngô An Nguyệt	F	20	uoK2MJQz+s+[YI	0	0534657055	50EHYTRm68
305	Hồ Khánh Chi	F	55	(;E5R{[z5c	0	0829817319	hdaTN3dPKK
306	Nguyễn Thu Thư	F	38	W|BuRo_)*	0	0613566993	coImHSmIn7
307	Hồ An Chi	F	38	C-t@Q+y-&=Nm=gK8	0	0866233202	OXFK1u8xPt
308	Dương Thiên Khang	M	37	D:cebrIX	0	0407089203	EVqknjU3U0
309	Nguyễn Bích Lan	F	31	BG=eZ_I(VE_!X;|>}b	0	0411389596	Ra37O0xnhu
310	Trần Minh Minh	M	21	1|:4TFzKmZv.	0	0567846584	0Wciypb3e2
311	Võ Bích Nguyệt	F	43	.-;joMO&{L>	0	0467652617	vBReuNkOqu
312	Dương Quang Phúc	M	47	(>|%SH@BB	0	0968148679	7TX5eglxne
313	Ngô Thiên Phúc	M	51	e-tA)];MF}	0	0489845462	rp39fD2U21
314	Đỗ Thiên Minh	M	65	kJA}Fe9r9Fbee<	0	0430839684	147pPg643t
315	Trần Minh Phúc	M	49	07NY0,/hPp;@5_#	0	0955974976	Z5EvllKuAx
316	Trần Thị Thư	F	33	j3)^,rf;	0	0975912703	fbKMWkDj60
317	Phan An Lan	F	60	{b^DLmb:	0	0292798457	FvjXaFHmNz
318	Lê An Chi	F	56	LRe)yF_pvlaETJ|ur%	0	0483708519	0sDcXQGDFH
319	Bùi An Như	F	25	z+2UWXZ6_H^<	0	0929827417	Q4zUXNCbeN
320	Vũ Văn Khoa	M	28	x0F>HLY4]2Oi;o>	0	0258238774	WwVwpsdcv9
321	Huỳnh Văn Khang	M	30	(mN*klJ+?Al,e)tzn	0	0743850531	PnK3ayJVHM
322	Đặng Khánh Lan	F	35	w/?Mv+6;	0	0751061412	CVPzSuSyEu
323	Lê An Lan	F	41	}.d9<&oki+:]	0	0441441164	41Bs9sUSXs
324	Lý Minh Bảo	M	31	c.P-DYvj2P3#GJx>CH8S	0	0644369087	YG3bG15O0L
325	Đỗ Văn Minh	M	50	[eGUcEw&.:#,	0	0625770097	u0lpuNBtYv
326	Phan Thiên Bảo	M	40	Cgz$!Xu{t!1t|D{y	0	0389168135	yZX6FPZEGp
327	Võ Thu Như	F	21	XJff_$]&X*MsT,_*<	0	0275812393	h7n25576o3
328	Võ Thu Như	F	46	PB:5g*qZMUZd(	0	0840765965	LbQYgnvLZi
329	Hoàng Anh Huy	M	29	^?oJ}+Z=X+u34	0	0232956141	CbIDnTTGCI
330	Ngô Anh Bảo	M	22	jG#a?&#.0<!zH06B	0	0487783963	pu6ffK56y6
331	Nguyễn Khánh Như	F	47	:5]^Zph)ByDQM$$	0	0341026892	6riZQkT6Ko
332	Hồ Thùy Chi	F	19	sD4?[:,2	0	0532552734	2lFD9ZBEyr
333	Phạm Gia Huy	M	53	Dcg/=5Rr	0	0938790745	lIEaPn6HCe
334	Bùi Văn Bảo	M	26	]zMWCKy#6	0	0413062339	jLib6SbsgO
335	Bùi Minh Huy	M	55	:}bWb^@$ViG	0	0405619983	5xjZECasXz
336	Lý Thùy Chi	F	48	+ccLwn/D|?0Qo^d^h({	0	0872431755	AOhyHnnTmd
337	Trần Anh Huy	M	45	.2.^q;F=YO	0	0389158485	MiHXXVzSHR
338	Hồ Minh Huy	M	60	C.:H:Q;T_$0eh	0	0370867525	eVAvtpmIf3
339	Phạm Bích Nguyệt	F	63	01];Kz*fV|/H%D.r5H6|	0	0601142166	sQ0IPNFTPR
340	Huỳnh Thùy Lan	F	62	3i=^O0@zrMKW0L8l	0	0975270054	KGeiXwBl4G
341	Lý Minh Minh	M	37	DlX>p*?rDn]5s|	0	0325710809	7dbbZV2i2Z
342	Vũ Minh Huy	M	57	$&R-D0B>rGHw%	0	0744172464	n4UMhANrWR
343	Lê Bích Chi	F	54	a<>E#/4l<ZPM(	0	0991355664	I98UKM3p0z
344	Lê Gia Minh	M	55	}{{-i3j48!wjT	0	0103266230	atXCYHzB1f
345	Đỗ An Nguyệt	F	45	kG<)Qn/1OI0U	0	0906927762	SciDTo1aJW
346	Huỳnh Tuệ Như	F	52	:a#X@aFK*ah?{;]]lI	0	0259736010	OjPe04lzNF
347	Vũ Gia Khoa	M	19	Y<1h|^:an/:sO	0	0537279185	HDDQw1ZArO
348	Đặng Thiên Khoa	M	51	h7%%<h?b=c)*	0	0646666053	7go8uAM9Ed
349	Dương Thùy Linh	F	50	^3ZiX3Q[pd	0	0224809796	8rliLiNtlH
350	Bùi Thị Linh	F	57	X8x&e.:U$yQTmx	0	0452819341	SxdbFEiUsD
351	Võ Thị Nguyệt	F	27	Wjps>6BFOrX1+//	0	0363289856	smKLd95rwg
352	Võ Khánh Như	F	33	mOl2]2TTn8;UtLTA	0	0798682235	6aPOfnFXGr
353	Võ Minh Bảo	M	63	_*ceD])5mIy+@Uwv$G	0	0871124339	Q40uNlmBha
354	Huỳnh Quang Minh	M	35	(Puz5^OV/Ni=bw.]	0	0524641050	8anEO8K62M
355	Lê Bích Thư	F	58	@Mj[YW)o6b>L;E4	0	0910501112	NSSf9JjHqw
356	Huỳnh Thu Linh	F	25	TdZ{qyl%;@;}@8vY}	0	0464136339	Vn6kuRmfId
357	Phan Thiên Minh	M	57	(-N]IZ>{	0	0146909840	nJDAD6ysKX
358	Hồ Thị Nguyệt	F	21	u+0TX%O9V	0	0597917478	HpeKTqSeHQ
359	Lý Minh Phúc	M	65	,*WJB$])jlnIzv_R*^	0	0198404409	kqyAiL0Dd3
360	Huỳnh Thiên Huy	M	61	+9[v)0+PP|	0	0774873375	BHfPN96tUL
361	Hồ Thùy Thư	F	20	R/@@GJi[iD|Mm0,k;LE	0	0969882649	JtuIOk3q1n
362	Đỗ Minh Khoa	M	57	9,&|.*@tqZnb	0	0129733220	viA2lKeQ28
363	Lý Văn Khang	M	18	pL#}lxvubkLHBmLq+$<O	0	0698212028	YetbL38Kvn
364	Trần An Nguyệt	F	60	=vM-sY!]9fp<f]Delt	0	0659420809	ZbOVky2ikS
365	Hoàng Anh Khoa	M	50	E!+J{SZF<Nuk(	0	0635055576	x3qis9O1N3
366	Lê Gia Khang	M	18	X{PudPc(8PY=,b$	0	0950745342	RSYS6vGFgr
367	Nguyễn Khánh Như	F	31	a6(O-+.!igndAN[	0	0485402905	Ys1GyTSdCj
368	Đặng Minh Phúc	M	29	L_Hi&Y2$VfM!p(?%?s	0	0154686547	F8aDn45px9
369	Bùi Bích Thư	F	33	4X*yYoJp>en}o?Z1i9%Z	0	0520472752	z8WwAEyz3r
370	Dương An Lan	F	61	H%zY}<|%cIn	0	0606035069	aAlSiIkBO7
371	Hoàng Thu Linh	F	28	S!B*?@e:^o&W	0	0822821181	psqgBHHOz2
372	Đỗ Anh Khang	M	52	Xx4qOJt=	0	0567427109	SMs29cYNFs
373	Nguyễn Thiên Minh	M	22	8V:1Qgn9T{l$<	0	0849229426	KAVuNLHEfE
374	Hồ Thu Chi	F	32	o(Bb68Z2$M:T%P=|0	0	0860078128	TZT827Rn4D
375	Phan Anh Khang	M	49	cEzC:KS+]AY7x0ST	0	0249825433	GKg54LDgBk
376	Huỳnh Thu Thư	F	33	@j/[t6c@R	0	0748343475	QHvCabE3pE
377	Hoàng Bích Lan	F	63	e[Wt6uC#@EB5>8P	0	0425666628	vKOfVRHbrE
378	Hoàng Văn Bảo	M	28	jM:S:Q8A3u	0	0810437264	oLPuTsFZmi
379	Võ Thùy Thư	F	58	C}3DeD_lR	0	0197817568	Q1C7sRak1M
380	Hồ Khánh Như	F	31	e9y>0[dUliD3*;|C	0	0214239015	aSwNHD2YsH
381	Võ Tuệ Chi	F	41	)GQ_v(:V+.g	0	0209327696	OIwBgwSLi1
382	Lê Tuệ Thư	F	58	i#WW&yBF%e=	0	0857588837	9gNP1lMNad
383	Bùi Minh Bảo	M	49	)$pkP+Q|	0	0103563462	gx3cW8SRGr
384	Vũ Thiên Huy	M	50	w+Lk!^Ou9n	0	0655821796	EFuGYaBZEA
385	Dương Thu Như	F	50	Cc=#6/7@5[+QL	0	0376634988	qXFYVXsQtY
386	Phan An Thư	F	26	HNu]+loRY2	0	0226099975	77GehyqrvP
387	Vũ Thiên Khang	M	52	RP0f[e]9UOU}O	0	0576854542	7iOjBMBYle
388	Trần Minh Phúc	M	56	s*e+5y#@w	0	0375657572	9HCAfcbkZM
389	Phan Quang Khoa	M	20	rDHPY6}C]Th	0	0996617099	WVD1yUxUBW
390	Lý Bích Nguyệt	F	45	>.Rfj!LTC	0	0643920685	d3l6eiFCPf
391	Phạm Thiên Bảo	M	33	W%!qHIS$.Vh+gWN	0	0243949484	CwXTVxLGfr
392	Lê Văn Khoa	M	50	{O5rN[E6h3gsvwM2	0	0165804780	yOZwX4DIIY
393	Dương Thu Thư	F	45	_JhA(x|3itL&	0	0617105470	xtZycYivzZ
394	Ngô Tuệ Thư	F	42	+L7I^O;#>Ig_=	0	0101375656	fn6ILMy4A9
395	Đặng Văn Huy	M	31	47oJ!<>h$	0	0614392265	6NhacfSFQp
396	Lê Thiên Minh	M	22	E.HWyxk<L5+qa!yr]	0	0336909272	h3BT2KKdhz
397	Đặng Khánh Thư	F	35	oau+!*1[	0	0533038445	arSlXuJUs8
398	Phan Thiên Bảo	M	42	S=3>J]Xy]mLI|q}a0B	0	0250124304	0560Vqagzh
399	Hồ Văn Bảo	M	24	d=SC(_.LUL)	0	0140181532	AEvD2Xmq1n
400	Phạm Thu Linh	F	35	[0xmooK&QZ^A8as9	0	0239559462	7pkwzudiAu
401	Đỗ An Linh	F	58	;}:Cv=4Qx	0	0159008018	l7M932p6aX
402	Ngô Tuệ Nguyệt	F	48	^sX_@L=e>@uj9fw=(]&.	0	0502176076	GdcgXaCZsq
403	Phạm Tuệ Như	F	33	Y)6I$wOI|6	0	0178503142	K7SH8IUt0H
404	Lê Thùy Như	F	47	+gg:)Q}c]KsSA6e/7-N	0	0267679682	Lj0UzmN0Lv
405	Phan An Nguyệt	F	55	WaU}}1bvFxa/R{	0	0346323868	dNL616oW6d
406	Nguyễn Thu Thư	F	28	c6J*4(pOdB	0	0472838944	EBlPPBuwwz
407	Nguyễn Khánh Như	F	42	b?G2%!Z@GSlq7@!KI	0	0380148787	bQLVUrMppH
408	Hồ Gia Bảo	M	39	uRs>tNosz>|$	0	0535379302	jd8Lp814DF
409	Huỳnh Văn Phúc	M	30	0YX;1OZI	0	0601558173	HjIfJTiZvF
410	Lý Gia Bảo	M	39	bAy_$S,{6g?	0	0999536242	zEBkzWc7O7
411	Hoàng Văn Minh	M	64	Z@1$,Z@B[9_	0	0964751717	1ItBF3lu69
412	Hồ Minh Khang	M	30	qe!MZvfKGme	0	0231692835	cChEbqe7GA
413	Vũ An Lan	F	55	M6H.wV[V:q(Hf^7!R	0	0874161741	q4ok3wGmDH
414	Trần Quang Bảo	M	35	u8HnH]#{z36:+Gy	0	0613262031	s2CUlh3uoO
415	Phạm Tuệ Chi	F	33	^JM-P7vX&6vv]._	0	0768808734	LAqC19TgQq
416	Đỗ Văn Bảo	M	29	1gV%@/OS	0	0960253951	GPANRiimcG
417	Nguyễn Khánh Thư	F	53	{&XBK%h<qKK	0	0157479288	0GOqMy2NgP
418	Hoàng Gia Bảo	M	64	9%^91{++JCM8	0	0643036907	KSr7ylTkoo
419	Vũ Khánh Lan	F	36	<g{a1XHxf}.ebGZj+	0	0882033729	OPvmzqMCti
420	Vũ Văn Khoa	M	26	!$N{TV2z/$ha*	0	0294813617	j2gO1QvqqT
421	Võ Minh Phúc	M	51	)H-&%1I@[V	0	0614267463	OzKo8Wu0rF
422	Dương An Thư	F	44	16F>+%ydO|,$(Bcn	0	0585190871	QdDBPVoX8p
423	Lý Tuệ Thư	F	46	Cq[:/.nL9,vB,	0	0356039484	4Wc3Q6SrzE
424	Đỗ Văn Khang	M	60	!v,(oJ@3(viJ}C	0	0151916619	xic0izmfIa
425	Phạm Thiên Khang	M	52	A(?mZ#5My=?3u{(mW	0	0266947839	c3dLMlUT89
426	Hoàng Thị Chi	F	38	;DU?Ez4dSb(+jm5,&<	0	0156463531	uPb3NBaDQS
427	Bùi Anh Khoa	M	61	c^CI;}>e&PvY	0	0465663426	8hKjGQ0rRm
428	Phạm Minh Bảo	M	59	k[3D6/!Va	0	0129276248	W729lG49eL
429	Phan Bích Nguyệt	F	60	K[{=a_GVj-@	0	0557741225	yHeGm3EKQC
430	Hồ An Lan	F	38	0MZO*LuL+N6^	0	0269817396	J5tErDnURD
431	Trần Văn Bảo	M	47	%z7>P9)5]	0	0870862658	2itQ8hW8GU
432	Bùi Khánh Thư	F	55	-c;e!zUf.hNKVD8EOx*	0	0890815377	czci7dYV1v
433	Lê Thiên Minh	M	20	#@@Msd<O	0	0631524677	9Vy2A0lzHF
434	Đặng Khánh Chi	F	59	W(^byiR89h&	0	0172712061	erDIY2nF3s
435	Phạm Anh Phúc	M	48	1u(8z&J)qohn2FU	0	0592585128	GgOPa5DK4s
436	Phạm Gia Khoa	M	61	lI*az$.eM08#ph3CBMH	0	0640971766	KQfUt54Dlb
437	Phạm Thị Lan	F	58	>D}}GfM02-y2{sg	0	0385660574	NDigX1IZO8
438	Ngô Thiên Khang	M	65	R}.gR5k%)9	0	0658026607	4KpcXa0jfR
439	Ngô Bích Nguyệt	F	42	<N6M.oLiil8B0sl!^{	0	0108745112	G0kQNElvpQ
440	Lê Quang Khoa	M	61	fi0-FJbFI2a<zE7-	0	0180506995	nTdjwodCG2
441	Bùi Tuệ Linh	F	50	@{Bn,i_+	0	0222194794	VCamLkwrWZ
442	Phạm Minh Khang	M	65	@U:s@nz-	0	0483234136	9ZdmVDt2Mm
443	Đỗ Gia Khang	M	46	DP*Y=+?rx7p8mrkn	0	0548703082	hE1MYGx493
444	Phan Thiên Huy	M	43	)x|0YA{5	0	0138943552	dqUgysvliL
445	Võ Anh Khang	M	54	#PO3pWz}V(s9[	0	0102074642	2mswYpZTri
446	Hồ Gia Khoa	M	53	jHg&v,#w:+p	0	0468517030	0CwUJm4Ppn
447	Võ Thị Lan	F	52	.d]x#|Z1{0(}W	0	0938439014	Ea3a6UMpwy
448	Võ An Chi	F	48	.&,@R@l?n2j31_	0	0293199778	FLN0trO2SP
449	Hồ Minh Phúc	M	24	j;^I,MMY<1,3	0	0109401389	gLMvDV317k
450	Đặng Bích Chi	F	39	#Vh0*o-OqI:lMQ	0	0749961269	a2C1mbuPwt
451	Vũ Thiên Khoa	M	57	RVa7t()zB;uC	0	0289902021	V4XvGxYsBE
452	Lý Khánh Linh	F	31	;Szh_Q($f	0	0597222463	Sm1Ct1K1UC
453	Dương Bích Như	F	26	nU:|*p2u[+P7rtp(xU	0	0646583098	2isLKEZcrh
454	Dương Minh Khoa	M	35	M7yL;_gO>p7.dWY:9	0	0549122163	E37acZNTVp
455	Đỗ Khánh Linh	F	18	gB$IfF|prD$D	0	0642630343	ambwpNNLYG
456	Đỗ Thiên Khoa	M	63	gN}-i!b4pkPweo1&5q5|	0	0906069703	IbeyF2eU8G
457	Phạm Bích Chi	F	32	TOHv|3%ML^X%]&vh	0	0995222344	AvezhSSyw4
458	Lê Tuệ Chi	F	33	1Ouu}o/N#-Rn>{	0	0274528826	MgbDS2NB5u
459	Bùi Bích Như	F	49	!CxAKCY)Y8dh@6}	0	0998176269	qrpCZvBBvT
460	Lê Anh Bảo	M	48	.r>wj$!sc{_J$@ND{+v	0	0773017316	kLuHEpetQ7
461	Hồ Tuệ Chi	F	27	U5Tw|swcj.ZxXnXTY.)	0	0209302677	qHOJaCH4pt
462	Võ Quang Khang	M	47	n]/uRTy{5Iw	0	0857075734	JAWV31w2Dz
463	Lý Anh Khang	M	61	9>7(,?f%>o	0	0215967833	0vKPnKlsso
464	Lê Thị Linh	F	24	eZC}=GV1A	0	0649038406	YjxLD3WLsI
465	Trần Bích Nguyệt	F	51	umO=<<%+5z2ZICUm,IDE	0	0344175276	gd13Zbnlew
466	Dương Gia Huy	M	60	;x5;?tF7lXz{|k}	0	0373310875	YlTLw51mtm
467	Huỳnh Thiên Khang	M	43	zI_u<I[R,GZ>4&	0	0962058831	pdQNKZkdsw
468	Hoàng Văn Khoa	M	60	1>]m>w>&	0	0395675060	C8xbBgNG4Y
469	Đặng Tuệ Chi	F	55	SSN*g:>h]	0	0115636494	ktxVapStT0
470	Vũ Khánh Thư	F	19	u|juevhx6%	0	0105152223	OvQfWivYxV
471	Bùi Minh Phúc	M	51	<o>fJNd[%=_	0	0271533234	lLfTHcr3h5
472	Trần Thùy Chi	F	28	7T-,KCJA3	0	0738000261	aBTfdGdHUM
473	Trần Gia Khang	M	54	Iwp*k07C)g*{Y	0	0786940313	s29EvLEFor
474	Phan Quang Phúc	M	32	R34Z%-ti.59(eW	0	0356490638	MH3tx3FW7k
475	Ngô An Nguyệt	F	42	z1k1z_X3{!dO/Jd3C;_	0	0709505174	rpQn2teaLB
476	Phan Quang Minh	M	29	HGc6Yd-u{ij30l(do-5/	0	0809449100	y4P9AMBd1M
477	Huỳnh Văn Khoa	M	22	/}=ei/kc5DHx8.;d	0	0594392872	a8G1M0CJq0
478	Hoàng Văn Khoa	M	54	q]Q|V>NW59T&	0	0276463059	sDs6DszEA3
479	Ngô Thu Linh	F	52	gzFE}|bD	0	0836617093	ljKYMsqJZo
480	Ngô Gia Minh	M	65	Vh$u$+;EZQu	0	0167472074	VDixNT7zJV
481	Hoàng Văn Phúc	M	21	$,(m,b-:|[,)TxSz1	0	0114035996	A2XITzWrFl
482	Ngô Anh Khang	M	64	!R-7LI/}	0	0722886879	DRgnJZ8jlV
483	Lê Văn Bảo	M	45	8M3AeJZA+3:RB*>(LOUv	0	0466598458	VYoBklqOV1
484	Lê Gia Phúc	M	46	{Ur!rV,.{D=F(	0	0429330683	Q8HRnbz3KN
485	Huỳnh Thiên Huy	M	60	p$GiB*!5)-rVFm	0	0470918343	sv7RPMGBZa
486	Huỳnh An Như	F	28	]vY]4!R:c%js:	0	0928311891	qODiPkn0Kz
487	Phan Anh Khang	M	38	%DZd^_&*Fb	0	0395370085	l0Wma6OWYz
488	Bùi Khánh Nguyệt	F	36	$E%QGw)}Oo*EZs_{A}{,	0	0710614818	7wHaP3B4sj
489	Phan Minh Khoa	M	43	Rzz8VMB.95=iA	0	0752111529	WKPjFiGyCx
490	Lý Anh Minh	M	32	daVT5cmP%->E{2WzapCn	0	0862825769	BwtlH5Q32d
491	Trần Thị Như	F	34	DorX12;-rb	0	0757875502	yb9LZSbM1p
492	Ngô Thu Nguyệt	F	29	]HVshJ,pA|y*9	0	0707608202	HFheq5n4ab
493	Huỳnh An Chi	F	63	:};U;fJ>%,1	0	0841213647	jbn3P6u6QP
494	Vũ Quang Phúc	M	44	?Y3&@%x,3eJ:(	0	0116423027	ZZGE8tyKSD
495	Vũ Thùy Nguyệt	F	45	ZXa=#le|yy6?JmPcCG#-	0	0104053608	RljLQc7INp
496	Phạm Minh Khang	M	50	wyz!2<<IO$x16$$(n	0	0541057083	dTDwynrr2O
497	Trần Thùy Nguyệt	F	58	pRsX{)m_@#];@-,	0	0961541069	XkvR7yH6En
498	Võ Minh Huy	M	59	WzN<<#.$Cf?C<	0	0123177225	NvhfJkRzPu
499	Đặng An Linh	F	50	V^+r=^w7rLfSO#,x;r=Q	0	0158342149	k3OD3Bsh5D
500	Hoàng Quang Khang	M	51	c=ch+uwnx8hP<#T&aQ	0	0719857521	j0243sWdyi
501	Võ Khánh Chi	F	39	SdI_i-M;;	0	0609768307	V4tLaDYlfc
502	Vũ Minh Khang	M	55	d)U7.G@fKx$	0	0184418110	RFNsvFS4Bg
503	Đỗ Khánh Linh	F	38	n=WH<YF*LJ4E|.8U	0	0714436389	mpkSQxJJn4
504	Huỳnh Quang Phúc	M	45	#0l]8<;7jy]	0	0844574063	NViUkDV3Ji
505	Hoàng Khánh Nguyệt	F	32	WMU<.$P*gV1[=A3I	0	0528281143	v11SiKqZDh
506	Bùi Thiên Huy	M	25	bn*U>3K_YM|M_4k	0	0870664973	ONmTV5CLtJ
507	Hoàng Anh Huy	M	20	l5ek_&>j.L]	0	0976756264	C7G6YlYxLU
508	Huỳnh Gia Phúc	M	21	uJVWEri7jfyD|M3.	0	0398496968	q8fThVorMw
509	Đặng Bích Linh	F	23	f#>*UNiD?]CG7	0	0993126372	hmn65XuksQ
510	Đặng Thu Như	F	50	Us,Bx-}K478])1Ek	0	0820509044	xYOzwy6cAs
511	Đỗ Văn Khoa	M	62	80Yw|JN**	0	0313096428	Ry4BO8sYhL
512	Bùi Khánh Chi	F	64	09MR/,yCEp3X9)	0	0422355027	mK4KNdcK5O
513	Đặng Quang Huy	M	48	*BZ|_k,^zZaUj)BN	0	0303630102	hmS5nsyFoB
514	Bùi Bích Thư	F	31	il%v#]4*9At4V	0	0550503979	5TdPtJxt8e
515	Lê Thu Thư	F	38	aVzG,Ou6(w@g	0	0618196541	M1klayece6
516	Hồ Minh Phúc	M	24	>Jo<!z]Os:@ibsu8C%F	0	0857977402	epFjV1dHMP
517	Trần Quang Khang	M	50	gDec&p20za0wI7(G}}X	0	0842032410	k0fMzGC5F8
518	Ngô Tuệ Linh	F	24	L+[,]p)K7<}JrPK$	0	0307034209	jwJc7M73mj
519	Đặng Gia Khoa	M	19	N,fvvlX(9>A_;b1s56	0	0644715561	am7o9nja81
520	Lý An Nguyệt	F	60	xv]_3O:6<?,?	0	0775666800	vkba4RAJho
521	Hoàng Gia Khoa	M	32	)=*wg)o;MXWeU8-	0	0514155024	44CkfQLiTY
522	Huỳnh Tuệ Lan	F	22	a@8Pze_lrx1D/FCh	0	0686565775	cQnTc7bCyd
523	Lý An Như	F	41	hS[{e-Ev	0	0574587428	5WyA1ZGpDV
524	Huỳnh Minh Minh	M	55	}[*Dt$Q/<$<tRJS	0	0938544218	ocZuYwCOYb
525	Phan Gia Minh	M	60	}V2G03$6!;[}	0	0487335272	ryKPaeS6fJ
526	Vũ Thu Thư	F	62	oM<$yGyoNoO4Af)c&6I^	0	0917956714	92IJ1A49nO
527	Phạm Thiên Khoa	M	47	Na=[hD?%kf	0	0172931890	QvjlOUauiQ
528	Đặng Văn Khang	M	37	NO{p(bF@leV.!|	0	0394897563	GEJkf6XX3W
529	Vũ Minh Bảo	M	29	]}hrCjL.A	0	0277094586	VDl0kZ1WYU
530	Lê An Chi	F	34	Vpn[P/)x,Vwr-|KJOW]^	0	0417718348	4TRNdXM0QP
531	Huỳnh Anh Khoa	M	29	47FiKEXKjM69/-0A2C	0	0316485744	4LAM8IWCKL
532	Hoàng Thiên Phúc	M	64	2vMLW*]5$F:[	0	0711578257	H7C5qrD7OX
533	Ngô Minh Minh	M	37	<cSE$e-P#mH=]%w+Z&aK	0	0234014786	ILAXE7DB7U
534	Ngô Quang Khang	M	34	*UL8=eCLe	0	0539344179	BjO15NO1aU
535	Hồ Thu Chi	F	62	gKR^/R)O|O%V>	0	0785080095	Jy3anE1OaD
536	Hồ Minh Phúc	M	62	Dp?&g$Yc|Sg.pN6.	0	0955791561	WULGARO0SS
537	Hồ Anh Khoa	M	60	1TlN5Gctx{!D21&(gT	0	0402711087	0gkdbMGN0Q
538	Võ An Thư	F	53	&+<[Tm>Ab*1J8t<tJ_	0	0287282135	Ihs3zwGAij
539	Hồ Thị Chi	F	43	ub=[a7?2OUfE^BE6Bg	0	0399160625	0myGtG8pCh
540	Lý Khánh Lan	F	25	&>l@oNi?[jl	0	0659956109	B3iYjqr2m6
541	Hồ Khánh Lan	F	47	7Gue);:qTq*8f%qG	0	0215026477	dbLzr13WqN
542	Lý Thiên Khoa	M	47	(+?,QMKK0ir$Jam	0	0752583207	kUYJh1RLTF
543	Hoàng Thùy Thư	F	65	o@6C^0t+h}$8p[Q?T/V]	0	0551873018	D99lYKZdIA
544	Đỗ Thiên Khang	M	42	{I$30-T&u!	0	0865430256	DfkxBUQ8BX
545	Bùi Văn Phúc	M	57	uTl1ySV1=$	0	0849520944	Ol7JbLLJed
546	Bùi Thị Lan	F	24	-TPI}*?%MLIJE	0	0516146853	LaGEwHEXvY
547	Hồ Quang Khoa	M	61	#M?.:]x&1S{rI_VD0	0	0591397294	LlQ2ilYGaZ
548	Ngô Minh Khoa	M	53	[E0vl8s_#x>3{uw!%Y.	0	0294933574	4kHAboD7aY
549	Hoàng Thị Thư	F	23	r#gjgGy]}wv)5	0	0358787159	y9NmsRFfj3
550	Hồ Bích Thư	F	54	<c?M,29]VR8	0	0788307860	18ZUnxnz59
551	Ngô Thiên Phúc	M	37	z*&u>E.2illic|F	0	0577823259	cvY5Pem4N3
552	Võ Thị Nguyệt	F	32	FN)y.MZE+6	0	0578823619	E8ArF369Ip
553	Ngô Khánh Lan	F	33	uwG]e85b1;I95O;b[Z!C	0	0900325634	cI1aYPKhV5
554	Bùi Tuệ Lan	F	32	4|5{Fuh=!>s94^Anx#U	0	0413252066	VVTNSq60tb
555	Phạm Anh Khoa	M	56	dtSLg68tFa?U$2mG	0	0471819609	CABhLIGzVc
556	Phạm Quang Khoa	M	31	<1:DZ%fgOSuqEX,G	0	0355573026	kzcNuZJJ4z
557	Huỳnh Thùy Chi	F	37	:*mS|o657%	0	0303985616	Yk6CNI6Xo6
558	Lê An Linh	F	34	(j)mcF+P	0	0373601880	ifCs9bRdyU
559	Hoàng Thiên Minh	M	21	vS.LfS%<DAaJA	0	0468505257	WCV8r8qVtT
560	Võ Thị Linh	F	41	a-rFOQH)_?x{VM]p#[	0	0916731184	7cSrJpTTkW
561	Hồ Bích Chi	F	27	rrM^leJH@nW	0	0884723810	OmPXUfX0Ba
562	Phan Thị Như	F	25	u<n,)BRT5<Uk,M8	0	0586111089	ARl7CIfFJK
563	Bùi Minh Huy	M	52	RbbPX3[TpH?N!{_E7n	0	0364909363	qvkwunU1hy
564	Vũ Bích Chi	F	51	<cvA2BSMIO#$?RU6	0	0868783600	u1hYI9rWSC
565	Phạm Anh Minh	M	60	S#P[x$!jX^>OMW_	0	0527021438	xSVn6M8EhR
566	Nguyễn Gia Khoa	M	19	x&1&jKOf&c$;@	0	0651780922	FrbtCk0FTn
567	Trần Thị Chi	F	27	j;wI]o:^T[Dr	0	0130956424	m4WA153t4S
568	Hoàng Khánh Chi	F	23	rBr,Y.y<Oc7<s	0	0138198337	psPx84QcAr
569	Phạm Thiên Phúc	M	35	t%C,[NPc	0	0232966282	D9CGVeiz8W
570	Hoàng Văn Bảo	M	49	H0Y$b;2>e	0	0421849587	fJQ1JjdAKT
571	Hoàng Văn Huy	M	34	Io^NN>qRo!H2#[{RZ&Ua	0	0905490497	eGC5U70Fp2
572	Võ An Nguyệt	F	34	$5%}imNj)+nxx_l	0	0650762876	AlalNHYNMq
573	Hoàng Minh Khang	M	60	@J]VQD}T|ym>@l	0	0564674543	kauMnpwV7Z
574	Vũ Thùy Như	F	47	sjbLP.mDmS1]g	0	0797147426	cjaqt3U3Mw
575	Hồ Anh Khang	M	65	25:L+t3/L$y:h	0	0442472124	JtL95GVwDd
576	Hồ Văn Khoa	M	51	0m3em8vm}@+b	0	0278112274	SaLjb84mCQ
577	Lý Thu Lan	F	19	m/USNW?($;XDv**|[Ur	0	0300606391	uiJcB6vyk9
578	Lê Văn Khoa	M	62	kpS-yhDQ:hOQ}IW,T#	0	0324880379	QUFbJSDupS
579	Trần Minh Bảo	M	39	:kLx|g5L;u3I+M	0	0845339505	QrIkcVPUiV
580	Hoàng Thiên Khoa	M	33	=}Hz-,eYdK7[-tNg]L	0	0428703411	Z47P2H8rgU
581	Trần Thiên Huy	M	29	zuTF)iZ=M;	0	0673209519	a1Jfzs9tSP
582	Hồ Văn Huy	M	24	5xzb2S-t:v	0	0463329293	ADFDoOGL90
583	Lê Quang Bảo	M	39	HAhroWn)|:*Z3x-{@	0	0994579494	AjSlkcj4yu
584	Vũ Anh Khoa	M	31	R:2m|A^[gBiXz[:*^	0	0318837074	N7QgHyFdJh
585	Huỳnh Gia Khang	M	28	^St.:_jgS-$AB0KY(.	0	0635626688	mxhCPml65v
586	Huỳnh Thiên Khoa	M	52	R&k3C$64.lKY%m4F	0	0585331676	0YI9PSThgU
587	Ngô Văn Khoa	M	59	g*atZ=nJ0	0	0183384504	NKSH6pxbUl
588	Trần Thị Linh	F	39	E{yX}yxy7{N2-D3	0	0654125026	shGYCalcwe
589	Hoàng An Lan	F	46	22U&$7Oa7imKi$p>3$r	0	0914784561	5kFTiEo3n3
590	Bùi Văn Khang	M	43	Xl6$*e4=b4	0	0570122748	vlgxcah5xN
591	Bùi Quang Minh	M	60	+xpUG+j*	0	0563354220	2kRyTcEZfR
592	Võ Khánh Thư	F	52	Wg.YvtO@cf%X	0	0759525769	XtGQKwNK58
593	Lê Bích Thư	F	65	dBQ4H)&8l}YqL3V	0	0368566387	ECQh4jAmjv
594	Võ Bích Thư	F	44	HAs-10g_nXtkDT%	0	0256095503	dvsgx9sDic
595	Hoàng Văn Bảo	M	32	>A&4g&2piLS:JT_	0	0873188884	BvlEDpI0UW
596	Đỗ Thu Như	F	34	v$f:{yv8	0	0812333758	xSUYZXFrGr
597	Ngô Thùy Linh	F	27	)ARC(D,L	0	0515121134	1IG5DkF4rk
598	Trần Thu Chi	F	22	7Izs3B_%QePI]rFjWwJ	0	0145907451	E0ui1QydlI
599	Nguyễn Minh Minh	M	51	LR-T+e,w5EIZ^	0	0894945735	IIlsx9Q8wi
600	Nguyễn Văn Huy	M	48	2Mg*iu,N>se.A	0	0649396176	hoJl8dYiyA
601	Bùi Thu Như	F	20	:Fva6pPxWK)HJw	0	0926209625	EoTyJy82Hd
602	Trần Thiên Phúc	M	46	NH<G52UK	0	0923056813	uNplY5hWf4
603	Lý Thiên Huy	M	39	t!b}t?rOx,Y%=g{H	0	0436302739	wkHdZsNRU7
604	Đặng Thiên Phúc	M	23	]OtC&U4^	0	0272337975	WcQ3eHlzxK
605	Lê Thùy Lan	F	31	k/9[/rgt#*Q	0	0752855266	jDJrMbZu17
606	Trần Tuệ Như	F	51	%-1sqe.DE0sgMU.x=	0	0278609870	yUSZEtFVSq
607	Trần Anh Phúc	M	30	!,9x=7Y3{R^x14m5Tf)	0	0209793643	3seYcTGa16
608	Võ Gia Huy	M	53	kp]^jw(IH-7=;)..b%x	0	0136827797	ZRXEmnSwKH
609	Trần Minh Minh	M	20	00D/C)[U.}=]	0	0855177560	rpbVNHAbJh
610	Trần Thùy Thư	F	31	_.b%)Tn0^-GA[?;	0	0286341342	cxBXeenaf6
611	Nguyễn Văn Khang	M	52	bVnFS1gFZ}	0	0277121776	tyVTRqbrhW
612	Hoàng Văn Khang	M	29	S;ro0mp?azgI9	0	0602128447	uBcNWS0xKs
613	Phan Tuệ Nguyệt	F	53	DCkwT]sC6Gg^FA}a$5[U	0	0367705024	qvOODmC5ZY
614	Hoàng Minh Khang	M	52	@E%[/4.X3	0	0473167132	PLecp4sJqb
615	Hồ Thu Chi	F	35	:gr9#J*alw2XRz_|5m	0	0370629713	jPvokq2D79
616	Phan Thu Nguyệt	F	32	/,r6A>?7]OT?*O:X9	0	0151678893	reoMgZwEj1
617	Lê Tuệ Như	F	58	96nt!@V}ixW}ktRg	0	0243805160	UF1Swmclc2
618	Bùi Thu Như	F	29	4ED(GB.;WWpwpI	0	0943930829	JmXxxFnYWM
619	Vũ Anh Bảo	M	33	FL=/p:F&*o:f9d	0	0936709867	GCi0qq8AUZ
620	Hoàng Văn Huy	M	29	aU>dacR+&ypG/enmlgH	0	0248144234	nkSex4jE3t
621	Huỳnh Thị Thư	F	63	^hK)G/NZ/yNt0	0	0804499514	2NdqGCvLOH
622	Lý Thị Lan	F	29	=fpdY{S3a,{	0	0374726853	Zka7oxdgjH
623	Vũ An Lan	F	39	+Lq1y+1<	0	0732680928	01a9xNUCaX
624	Đỗ Thùy Nguyệt	F	47	q8<%{?]V9Y9KmVe	0	0757310976	jpV6sLVNl6
625	Bùi Thị Chi	F	33	wo_bkQb)wx	0	0975415562	ZihDybrqmm
626	Vũ Quang Bảo	M	52	SF>G@BJ,Vu	0	0858161819	R8j8TeRMOY
627	Phạm Khánh Thư	F	38	8=lN$MO?Za	0	0339392351	HaUN7boBxi
628	Hồ Văn Khang	M	35	p>zv)?m([CN+	0	0477737594	gz7QPUtdND
629	Võ Bích Nguyệt	F	30	6zUE#?,N[[__&&]=	0	0728127567	U7bICWOuFz
630	Đỗ Anh Huy	M	56	B#d5N6*h-swQHoOD]	0	0760617771	VBQRQCEqht
631	Bùi Quang Minh	M	58	9L5/@2*{c!&>mR	0	0458418444	GUX3pJa51D
632	Phạm Tuệ Như	F	49	}O@fb^3A	0	0481642454	JYePx6Z1Zf
633	Vũ Văn Minh	M	30	tfu=I}n%yNeI5o-Si	0	0855489913	mq52ylICcP
634	Võ Khánh Thư	F	35	WMBh;0*[sGv=8LF7&_,]	0	0976638760	AfxUg1byHl
635	Bùi Văn Minh	M	51	@%K#EF.f	0	0557205013	tc6r7BMvT9
636	Võ Gia Minh	M	20	r22YjpgOp?K	0	0593785598	wRblz8t39q
637	Phan Thị Chi	F	56	7Bw$ok]%	0	0188268763	4uBXnHRLaJ
638	Hoàng Văn Khang	M	27	_:ZD,_)&RKq%x	0	0807920683	IftckF7ZYf
639	Bùi Tuệ Linh	F	28	V3P-]Mp92[E-+e7RQc/	0	0312958188	S3eG9qZCHo
640	Phan Minh Khoa	M	50	t<3PKx>$;	0	0475636423	19Ab6UgJML
641	Dương Quang Bảo	M	23	x>|rmheq[+gEB+iK	0	0400533492	u82s5kcPAG
642	Hoàng Thùy Lan	F	40	wj3oA!d)R+v&/Go	0	0635910638	GQkQs8IelQ
643	Bùi Anh Khoa	M	51	BEik9TU3O#!WA?p#	0	0413081670	h9LEKu1sTy
644	Trần Thị Nguyệt	F	57	%I},^j*}c{ulB	0	0341753252	aS5lSDQzSY
645	Bùi Gia Minh	M	45	6-$*Xph3@m	0	0517142841	2FjbzP3evB
646	Lê Thiên Bảo	M	49	t8zqWdt!ZH-:-	0	0393426393	rNsrY5vBmn
647	Trần Bích Linh	F	30	x_;@K{MSFAi	0	0382350253	1uOJ2t4cyH
648	Ngô Thị Linh	F	22	0#Dp;r/D%ho<9L	0	0570640324	6YVhpsvCjx
649	Bùi Bích Linh	F	58	n>@eli(#	0	0347059230	shRVcBIjyt
650	Hoàng Thu Chi	F	39	F-f[Q<&{VS	0	0421731423	jwGLi9DY86
651	Phạm An Lan	F	36	RIz-D_bEY|k7;,/	0	0479680411	ykzMTbfbbr
652	Dương Văn Phúc	M	39	{PFJF8HH>AJDCi	0	0452884793	Xj9S77AzPl
653	Dương Anh Huy	M	28	!2g7&V=Pb*	0	0347591144	arxNnWZxfb
654	Bùi Thu Linh	F	64	)htPxo;_dR9${FrL	0	0285713418	nEpqRz9e6x
655	Lê Thùy Linh	F	18	YBuYY*]CD0Hm&,Jfa3f	0	0569256439	2JcwXr9alk
656	Bùi Gia Minh	M	61	yV8{i07S!YFC7A	0	0394022140	9DIsc0uoPh
657	Vũ Văn Huy	M	43	II6&$#<%	0	0906352560	XG9W34JsSU
658	Huỳnh Thùy Thư	F	34	K2>tIM+MygJG0^Qai	0	0483885116	K9R1NHnI3k
659	Hồ Thu Linh	F	45	]^W,fJ#D	0	0983618432	RU5wDKXHEv
660	Lý Văn Huy	M	52	FKDi/@&|	0	0140071474	5piNWmfqC3
661	Hồ Văn Phúc	M	22	n@FD?B(>73kQS9w)l	0	0876976813	4WWcYEBARM
662	Võ Thiên Minh	M	51	m.MFwjceCvVGE>;	0	0765574436	PTvxCfLi5G
663	Lê Thiên Bảo	M	22	B:GKf*+&#oM3n.&bk/	0	0365577712	d3NTVP0VGX
664	Trần Minh Huy	M	37	oZeM|Unp+p>q*a2	0	0380026840	ARqV3lD1dX
665	Đặng Văn Khang	M	36	]|3:y)5$#ms)#yyr4w	0	0653215676	EpmDhmXYdt
666	Võ Thiên Khang	M	27	/mG{&xSA$	0	0812313718	z1UMGD2eR1
667	Vũ Bích Như	F	35	c|YbI6e);y	0	0664087097	ETFF3b38EX
668	Hoàng An Lan	F	44	q-ejp#9c;z2v]3	0	0211103537	ddS5REVNcQ
669	Lê Bích Thư	F	61	eou<=xeA[	0	0685721499	z5nWWNmWEl
670	Trần Thu Lan	F	19	4{=iG{PX+J%7]ewY:b	0	0191743128	tpyKiIBntS
671	Lê Minh Khang	M	35	_BU)k=5jGVp	0	0911035935	sVJwtFNFGZ
672	Đặng Thu Thư	F	65	g&@_#(AW--f.Sgdc915	0	0611057693	nil9HLtSLr
673	Hồ Minh Khoa	M	25	#[;[pW%2C1:>9;kBu	0	0974207118	hO4H3jFmRU
674	Huỳnh Anh Huy	M	30	MvDfL)SM>/#IxO2!@	0	0638169894	Ky5A8dhikb
675	Phan Khánh Thư	F	61	dJz,jXy0O;#9	0	0693902511	nIirJXA4t5
676	Bùi Văn Phúc	M	38	_X6,<&GB^g=CH)M#f	0	0482474039	KCkWlzoahZ
677	Nguyễn Anh Huy	M	22	@m_:sAj]<	0	0323832972	Gm5U21Tgm3
678	Lý Bích Linh	F	52	3nu=:m}Jb4Pmy5d	0	0716705232	pBjFAYIbbj
679	Hoàng Minh Bảo	M	46	<8Y;?-Qs_)h;v%	0	0707924369	eJL69yLRh0
680	Võ An Nguyệt	F	43	MgxF>Km^c#zQ%%93	0	0746940440	z4ZPBaaVpM
681	Huỳnh Anh Huy	M	22	M,nA39AWXy{]{:wA.	0	0869545488	B9WcQpM4sH
682	Lê Thiên Bảo	M	64	|ebk6/Ym5rvCRK:_4	0	0328970308	P6MGMT0C1u
683	Bùi Tuệ Linh	F	58	*X8&7%-O&XODg.o7x	0	0309545830	VO8zQ7WHBN
684	Trần Anh Minh	M	21	_@Rjm&p0Uv&g=	0	0256073189	yc2c6Qg580
685	Lê Văn Khang	M	51	MX.x2*Mk9}L23(el^sS	0	0159843309	CBdTSdiPwz
686	Đặng Thu Linh	F	22	{.]z5<{?[Jv$hBfKq	0	0267741118	kBcWbiiQFc
687	Hoàng Minh Khang	M	62	B8|LNiP?3pQS=<M]	0	0873731157	dZ1Iu4JfeR
688	Huỳnh Thùy Như	F	40	B_w1!?WKG!su./P#rDTq	0	0108293545	vR5KakXAob
689	Hoàng Bích Linh	F	40	5w+BE%j&c!w9eW._8mN=	0	0586621271	AwCnrzQ8b6
690	Ngô Quang Khoa	M	32	jb+hUJa*Vbl	0	0838878541	lqsUk0Z6cK
691	Trần Thị Linh	F	30	c@&W)WGR5!D2p5621	0	0832878423	Tj95V4bBGT
692	Vũ Thiên Phúc	M	57	ArcOx-,o7	0	0900296082	S6ugQpSUiD
693	Dương Thu Nguyệt	F	24	Ow_4N%N8^nG[/FJXY?	0	0878432050	naVz7UQcgy
694	Ngô Thùy Chi	F	42	&%-58o{}:&}	0	0899345371	NiZ99RP3RA
695	Dương Bích Thư	F	43	W!G(q+p=i)sPsX)TC	0	0330112398	0h0JmLgE8b
696	Hồ Thùy Chi	F	65	(+MdD?}u^	0	0407543031	NNoe91ToTz
697	Lê Thu Nguyệt	F	36	bXAC:+Gn7C26hk]HK>P	0	0541757337	JNX88Kq65B
698	Lý Văn Khang	M	31	eF8{XKoi|(	0	0139151132	fzcpAQ06xS
699	Hoàng Anh Phúc	M	30	ODnVJ6_^YrrkAz	0	0838713443	WjIPVMsZnb
700	Lý An Thư	F	30	vr:lS3(!k-?rxmg.DV	0	0476768906	AvcyXzvSdB
701	Trần Thiên Huy	M	22	{<H:1$^=7P9rR7;-O	0	0820273456	4XarbsiH2Q
702	Ngô Quang Bảo	M	45	x:@{$DU5I^@	0	0902041852	XtUZyoakbg
703	Hồ An Nguyệt	F	25	_H!V2v+%X.)pOaQqi	0	0548522092	5PDIuZOZIz
704	Đặng Thùy Lan	F	55	pv8eI$E:>YVZKOl;{ZEG	0	0477776631	1U4WxcSWL1
705	Hồ Thị Chi	F	37	}zw()klOZb3V#h+y	0	0292167532	srKrEIMBzU
706	Đỗ Thùy Linh	F	22	DQ#6+^N:ppt-%v5!UB	0	0356005414	ziVjuKsATR
707	Hoàng Minh Khang	M	35	94:j=oUM@B!	0	0736058925	MgoZfkCDcR
708	Đỗ Quang Khoa	M	53	[H}atuT]O=.worer|%	0	0351310325	evApWv6hdV
709	Hoàng Thu Nguyệt	F	64	a:x)$o(ZP	0	0168548451	GHzelIazVM
710	Phan Thùy Như	F	46	sH[7jPqCPpdJ$nhr	0	0472453535	QbiCYwJQaD
711	Bùi Thùy Linh	F	22	Zie2>]R[GO6Gi*	0	0697446534	zHqjC4rcst
712	Bùi Thiên Khoa	M	26	sh3>c-3|>,=G	0	0700295608	LN6CvilgIJ
713	Đặng Thiên Phúc	M	64	L4o{#OZ>[ZZ	0	0544404424	lTNyImNEWc
714	Dương Thùy Linh	F	63	c[bj+h%=^5]QH<,1.i,5	0	0446403053	Cl013asj3q
715	Dương Anh Bảo	M	32	@jkJi}hi}oy&s!C	0	0322511872	gPuFsFIkLZ
716	Dương Khánh Nguyệt	F	26	Bwvyo#Yj:6Qc8I#{};	0	0264733168	S6nEn1NAUf
717	Võ Thu Linh	F	59	3hPy[[JTjI&a$k	0	0742593114	PvZ1OYR7h7
718	Huỳnh Anh Khoa	M	63	B.@.sth%C:z5!5c%.	0	0139060731	3TiRB8whE3
719	Ngô Thị Như	F	59	eP+w$-Ox.F	0	0281564628	tJgVPVXYn1
720	Trần Thiên Khang	M	23	#C-U|^R9zn&	0	0610193935	72FpVZyR79
721	Nguyễn Quang Khoa	M	58	6S^^;#FE	0	0983183486	KS4ZDcGXHu
722	Phan Thùy Nguyệt	F	40	[%@rOKNE*N	0	0329055933	Rvsd5OBRDN
723	Lý Quang Minh	M	42	N+LU%hjT!MH	0	0308112029	unSxEqKncO
724	Trần Thiên Phúc	M	56	pCJgI/,}&g[^|2%{(?]?	0	0788094252	HXoafQGhyK
725	Đỗ Thị Chi	F	36	NuxeOx*?zi	0	0163355089	TG1uGGBAxV
726	Dương Tuệ Lan	F	47	>+fzvW8t#k	0	0212769721	Gb75AlMQvs
727	Đặng Thu Chi	F	33	aJ&u_!]W}c	0	0682264359	6yR4oKqR9d
728	Ngô Anh Bảo	M	40	u!q*z-uDa:jwt;q	0	0464781413	lyA5Dz3Ih8
729	Lê Anh Phúc	M	38	*&$m?S[|<^q|lU]Z*I1	0	0477465425	Glwqk90dky
730	Huỳnh Anh Bảo	M	29	Rc%*7_q7:ekC|3m_kq	0	0198508489	NmfqH7P8cv
731	Hồ Anh Khang	M	53	.v}3x}x4IH^n	0	0338282326	PRMUXjKvCA
732	Lý Tuệ Nguyệt	F	52	q_g_Adi{L	0	0697537253	6DK4PcA51M
733	Ngô Anh Khoa	M	56	m@C>G/Mm	0	0347229797	POGFK3CJW1
734	Võ Bích Lan	F	29	C0>[g:g)O@	0	0223015664	v5Urq9VMOy
735	Ngô Tuệ Như	F	35	]_sZFfR;Ufw,	0	0281165831	ZTHPx33wJ2
736	Bùi Khánh Chi	F	26	:Cr(I.d/G	0	0853875605	y9pjvR82Mp
737	Phạm Anh Huy	M	37	lb9Y:cMV/+Z58$$f|	0	0568781531	BeI79WfRUz
738	Huỳnh An Lan	F	24	C;SsdT7.1?>	0	0596432353	gViD84jz1v
739	Phan Bích Linh	F	57	mhgzz?GdUN*5|)rg!	0	0615708209	nZs1DLezWl
740	Lý Tuệ Như	F	59	+1!,X&]^/(l=3jt^	0	0503457728	zTwdKWIBuU
741	Lý Thùy Nguyệt	F	49	Sr%>51npv	0	0179544216	qvPqLhLG3R
742	Ngô Thùy Lan	F	45	/ec}5:fi7HMa	0	0602350942	CbqEHln9qp
743	Hoàng Gia Khang	M	19	DEH4r;R!hv1.;o	0	0759761366	rHSMJti7Je
744	Bùi Thu Như	F	39	;?q]x^.wGp?W8Ud	0	0297509901	5TpDLIil7S
745	Trần Anh Khang	M	43	mda(AaHa0y{aog%	0	0873615833	RHnqeKdclR
746	Hồ Bích Nguyệt	F	28	GX7X^435$#HoZVf8x@V	0	0291082592	4Lo31w6Y5X
747	Đặng An Như	F	31	w6A1d6}]_gzN8Yzm)YK-	0	0292287652	9upjTQLdhR
748	Trần Quang Khang	M	50	!li}%jDO)	0	0605227377	RX0aTGX19F
749	Phạm Văn Phúc	M	46	qo3;93)EPInML.W!N	0	0464359989	dPaIIYEukv
750	Huỳnh Gia Khoa	M	32	j8<W{^rArX	0	0699618898	91ksUQJYhX
751	Hồ Thu Thư	F	44	brm7<5M*(7t6>	0	0742692713	eUyoVg7cQQ
752	Lê Gia Huy	M	61	PP]_d$Ocr|<u@*	0	0569586622	0TagihV1rO
753	Vũ Thiên Minh	M	25	U)j5:Yh0	0	0130494528	aMml0yec9W
754	Phạm Gia Minh	M	35	NYqV5<2A!Uqapz	0	0158785162	9o0GNYxSBs
755	Đặng Bích Như	F	48	_ht>pe5TmDi{(S	0	0894120696	RuMSJUpUmq
756	Hoàng Thu Lan	F	55	wz%_0-H:m,C2	0	0443886161	VJTdrnrxNP
757	Đặng Minh Phúc	M	61	dWEcIU:iHT!^	0	0937110043	BUetR7mwgr
758	Lê An Nguyệt	F	61	Z^;u(b&W	0	0136255489	qqCqcKPAWl
759	Đỗ Quang Khoa	M	56	SBJsV8^s&q)r3]CCX;	0	0503984655	EQuyEymyem
760	Dương Minh Khang	M	31	$ps2.)CJn&.k<-{	0	0987991394	fEgLM13cu0
761	Nguyễn An Như	F	19	FuQB$V.bw^8wAH0rrc0^	0	0865235620	53pJVcuoBq
762	Lê Tuệ Lan	F	42	Hr7ze9>B*,vCLfUq<(/k	0	0206061549	GlS6Ngu9QQ
763	Ngô Thiên Khoa	M	30	!3-0yP[:e?p2<g%	0	0394076556	sx4cPtGGv5
764	Huỳnh Anh Khang	M	45	_grbwsE_KEn-98-	0	0155415029	1sgyEgHohi
765	Phan Thiên Phúc	M	62	}^uGTwXJj	0	0269477349	cWYwFzjLri
766	Hồ Tuệ Lan	F	53	A?|gfQ::]6SGN8	0	0993204271	HJjOy8AOrW
767	Huỳnh Bích Lan	F	48	z$f{f#dOX{9t98Tn5d	0	0382575372	f5HEtF3k0T
768	Hồ Văn Phúc	M	27	}Gi{:@zHXxtA&i|wL}	0	0300055479	w0JgWf9s6g
769	Đặng Thiên Khang	M	51	B4;3{^lU,x]|iu}%vmy5	0	0634652363	1Hlc2QGwsi
770	Hoàng Văn Phúc	M	24	9-4wYuo!	0	0629240947	TpCu7hczMy
771	Đặng Thị Thư	F	26	Wx/XoyVqAS,tWOa	0	0818832120	vyxqIWLYga
772	Phạm Thùy Thư	F	59	]O]yJzr?{	0	0410444415	Zvyr9b0Jjw
773	Bùi Anh Phúc	M	26	N#>>uGUJ&x	0	0651759177	oYWecIh6kd
774	Hoàng Minh Khoa	M	38	{aI=Q$9,kxP.)Y	0	0987405302	mbfLDQS8cM
775	Lê Anh Phúc	M	56	FUzX&}3|4,m	0	0949954010	X2LU8ZvufA
776	Hồ Tuệ Linh	F	46	H1pS-1J(	0	0303226954	NNIGtQPxbp
777	Võ Quang Phúc	M	22	DX1+(,N*k[CX;	0	0430163247	eLcREMJsX8
778	Dương Thiên Bảo	M	31	l&D$h-{@3	0	0928702712	3mFg1UOPBd
779	Bùi Tuệ Lan	F	39	XZv0oJ*rV/8|%6	0	0777483263	kFyimcgJj9
780	Đỗ Anh Phúc	M	55	X1s]!Ot.4<J	0	0905214579	lH6SSQopoA
781	Ngô Thiên Bảo	M	65	?tL.z{K&rL*K?PE^	0	0879779315	v7clk7QQvr
782	Võ An Nguyệt	F	30	[WtxxkM+F?}?vMjWvVUJ	0	0234716905	LkT1y78F9f
783	Hồ Quang Khang	M	52	?JH8%b=-%I8kkK-6	0	0797782894	Suo87JX4Q6
784	Trần An Thư	F	60	U{ixS1QbH>t{YB?D	0	0460562858	AbXP6arEcc
785	Phạm Minh Phúc	M	38	?yiT@2nOC	0	0691959131	ie5POgPHp3
786	Huỳnh Thu Lan	F	53	3xP.p:($O^O6sk$[	0	0318291681	SkTFyblmvJ
787	Phạm Tuệ Như	F	38	_g=Xhnl.	0	0969255441	0Yqh2sfrWH
788	Bùi Thiên Bảo	M	55	azJ+|<);9=	0	0504463983	xoXRq1ZDqZ
789	Phạm Anh Khoa	M	37	QIKh(w}d5&V^fR	0	0446086233	6bEAkWUCXj
790	Võ Anh Huy	M	53	:@v@ySz8O8<T_);<[	0	0517898089	4vVGdudXGo
791	Huỳnh Quang Phúc	M	61	lIfd_;jefeOF#Gmy	0	0328559850	5VWLBvpD96
792	Đặng Thu Lan	F	42	#F;$c%HA	0	0162237760	PHSIcvp5GL
793	Ngô An Chi	F	59	[oWvCn/.;:$tep	0	0178101335	KpEAX1VdeF
794	Trần Thiên Khoa	M	57	EFJ<7Epf0_gB	0	0938538458	WCpq58bzd1
795	Lê Gia Khang	M	62	s[vf(CJ!A+hgN+BY	0	0416041042	cjQCVhvefT
796	Hồ Bích Như	F	24	ue/hFtk9l5t|ik{x}+=	0	0173256763	L03JibyWxB
797	Bùi Minh Huy	M	30	$dq/=I=$	0	0614132589	Thy8Gr8Ybh
798	Lý Bích Chi	F	23	xz6mv:D.k{	0	0293982336	zzxYUn71CC
799	Trần Minh Phúc	M	21	].eggnS]X?pfPE	0	0868386261	irWVeRWuwY
800	Đặng Thu Thư	F	33	pOUK|k]HU0Z]	0	0154521279	fjil1Pl3vY
801	Nguyễn Thùy Linh	F	55	!?<TtFQ!JO;?DP[hw	0	0885797332	QK2bVKjF9x
802	Phan An Chi	F	26	M)W]UY|,BQ9!d	0	0114292434	w3vVUG4CSL
803	Phạm Thùy Linh	F	22	eClTZj*NJ1H$-h2p.xR	0	0973793065	hpGPAxtBlC
804	Lý Khánh Nguyệt	F	47	2R]XCVeP@b785@	0	0334185442	cSBjsF9iWJ
805	Đặng Văn Phúc	M	47	q&$%bQ,C@6O5s]	0	0432460348	h5G33MxsBY
806	Hồ Thùy Như	F	60	yqWiO@-8-.w(,1S	0	0178056546	bKyc4x4s6z
807	Phan Thị Như	F	59	Ej+FQUcK}?rw3D#(>iP	0	0800613214	I3yXYIMkMH
808	Hoàng Khánh Linh	F	48	97>]2b,W^0&0N	0	0283311316	8yKOCO4BLs
809	Bùi Bích Thư	F	31	3#=(shULnm;!btk(N])A	0	0200317185	823G3cAPBT
810	Hoàng Thị Nguyệt	F	37	Jx4j^<+M>^J3|su	0	0871762387	RJQxJSs2LJ
811	Dương An Linh	F	64	L9{?g--Kg,t/>V}	0	0955387942	FC34LjVfnG
812	Hồ Anh Khoa	M	45	zO;K=/>N/#j:l$Q*	0	0158903833	GRJnV5Hs48
813	Hoàng Gia Minh	M	44	(>7HqpV^pC@Y	0	0389769598	XTakc5Z7EO
814	Hồ Thùy Như	F	57	#6&g-7eVG.grF3/	0	0587560468	GcOQQDmVUS
815	Đỗ Thiên Bảo	M	44	Nyh?S6]i(	0	0170697679	fNz14Ds6xy
816	Bùi An Lan	F	58	&@^P?z,rx0rvR-g	0	0557142358	YMnCk1Z3i9
817	Huỳnh Khánh Lan	F	63	*|-{;a#+Q1n.Qo3F	0	0292002504	GTVi9TyJuC
818	Trần Thu Linh	F	21	^jucnqd!{+_?,Yi	0	0769753870	D4Js4DRXjz
819	Bùi Bích Thư	F	61	A*RTAUf2!>#ci.R?	0	0196638580	ToSfszcoPJ
820	Ngô Thu Linh	F	22	={Lc|:-*?)NKw>Q=	0	0288019829	NcAlSEUVSV
821	Đặng Gia Bảo	M	33	xtf?Z-LiRjO%vy[@9j<	0	0663527882	7j6vhLgBwl
822	Lý Thị Thư	F	65	Bma[,L6z	0	0271293286	2ahsyVXmHM
823	Nguyễn Thị Nguyệt	F	30	y/<hhF.W1	0	0812991989	GQ5ZWPgvRL
824	Võ Thùy Nguyệt	F	21	l|AZu{N?H%D(2;&	0	0349630635	jc5Sg1D0At
825	Võ Anh Khoa	M	63	_;;xcE*sz;v4lI=^ws	0	0602473643	GSsER1Izdj
826	Hồ Thùy Thư	F	35	+e,kWUa;qf=	0	0809056615	zQKIh4jOYs
827	Ngô Thiên Minh	M	48	H=YkU%oaOr(5$G0D	0	0802354708	Rk4Neaowy1
828	Lê An Linh	F	33	z^_rs%[9jy|P|lJCv;/	0	0966481013	gEnXQN5IHm
829	Trần Bích Như	F	40	<lE]gk.qz!+K	0	0400424716	zW1lKxeVLg
830	Hồ Khánh Nguyệt	F	57	DJ[86wqq!y	0	0904080612	4uhHOXvDzx
831	Võ Thiên Huy	M	22	vF|.U-:{Z=J}|*;I1Y88	0	0334520147	vqY4kgSXAS
832	Lý Tuệ Nguyệt	F	50	c3BEp|v}kH+	0	0193356649	NxWcmvnRiY
833	Ngô Tuệ Như	F	54	YKK!IPJh,sbK;	0	0411456946	PyABH61JvP
834	Lý Thiên Phúc	M	64	[=L80!5.Hh$	0	0835704181	ydtBQZt2mz
835	Dương An Lan	F	20	K$fJa1+{r	0	0451030502	otgHO8FY2w
836	Ngô An Như	F	30	w*GO<o05XLxi$B2	0	0707578568	D1rpiulLmw
837	Vũ Quang Khoa	M	51	|cCK]+ey-Z	0	0187124332	aXBRXBfogX
838	Vũ Thùy Thư	F	55	w((n$C$rN,e$i@:]W	0	0185876887	YVG3xpeZii
839	Bùi Tuệ Nguyệt	F	35	t_fH?XtZ	0	0622308585	WV2vfQxxGr
840	Phạm Thiên Khoa	M	19	a!A=HogyB5NAB	0	0109396649	7ESnpWCUKD
841	Hồ Tuệ Nguyệt	F	52	)TDZz0Yz}6m1*)d	0	0706669103	pho4AHSs6v
842	Phan Thùy Linh	F	29	(#%J8^bo1!z4	0	0826984606	StkGoX9IIN
843	Hoàng Quang Minh	M	32	A}AhHzL]	0	0654378587	vZ4Z15PTdY
844	Đặng Bích Thư	F	61	T;Lg02&ZXg[0B.	0	0903437318	MBFT3Ggh2u
845	Huỳnh Gia Phúc	M	41	[%$h>B*?R*w	0	0266180334	K7me8W6Ajp
846	Hoàng Thùy Như	F	30	aPR!y}im[NV>[Pn	0	0338359254	Jaw55bM0AU
847	Võ Anh Minh	M	47	sC.0m>URM	0	0762360145	MUUBT6pR5L
848	Nguyễn Bích Thư	F	50	h&]j31;Lzo|Pgq	0	0443490048	dEnYimwlcy
849	Võ An Nguyệt	F	36	SLi@A}!<V)Y4	0	0548083750	oKogqgTZQ7
850	Võ Gia Phúc	M	58	R$ss.7nSCILEy$D,q@3{	0	0215498243	qdeRNhri5O
851	Huỳnh Thiên Phúc	M	25	&DtKpt.E$(0ro	0	0168955757	TooSo0I0XI
852	Lý Thùy Chi	F	28	l?Ia+W1j<rbwJ]@;K#	0	0831841452	elxPcPt9KP
853	Lý Quang Phúc	M	34	q^YAaV/V0<k9	0	0665236173	fGYXnzoxCN
854	Võ Thùy Thư	F	38	F2j>.{?DA5[RScB/S	0	0484218834	keJmNdud9Q
855	Bùi Quang Khoa	M	56	o:xwk<v7z|(	0	0702004567	3LdpvMLraJ
856	Lê Thiên Minh	M	18	2&sorhrp;W1iR-lI|-	0	0563315281	J25JRaIMPG
857	Ngô Anh Minh	M	21	3U$(]e./hk_iM9+:.p@	0	0846064173	Xw6oojQJqL
858	Trần Bích Linh	F	21	(j>%h>Y2	0	0897722322	5UCLukHeIC
859	Lý Thùy Thư	F	62	7|90D2.Iiu]	0	0966481666	khA1chFY9X
860	Phạm An Thư	F	40	.@m${rJq,[N%/s^CC	0	0449938246	GJsKBRLLl1
861	Vũ Quang Khang	M	53	0_N#YfMYu&d	0	0962019921	Lomea0f40a
862	Phạm Gia Minh	M	38	;R@)^_-=+we[c	0	0759730515	eWuwBd9QuC
863	Phan An Linh	F	27	s!bFP<5>#FO(k>J%eNw	0	0391848615	DrPtV20uO4
864	Võ Anh Minh	M	18	:GEdtc!j6Pxg	0	0965578449	moBmppUQbJ
865	Ngô Thùy Như	F	57	!.iNiIFL!RosaRfsI%x	0	0280824580	zDVYxmU8ax
866	Ngô Văn Minh	M	46	{;>)grhV	0	0171241287	vrzOlwOJWX
867	Vũ Văn Phúc	M	47	@wZE1ou2@nYXu;|fsuS:	0	0125355814	KzEzKh37Lh
868	Lý Minh Bảo	M	64	7,jm$d)Zx$R/dp}$$Wg	0	0523017242	7VHPRUwWDc
869	Hoàng Quang Bảo	M	31	g+{;q>nB|Jo,h	0	0449665743	sOMSOZfSQI
870	Nguyễn Văn Minh	M	53	#jN)qu3@j=zE	0	0910487722	EbzX6QUyqo
871	Lê Khánh Nguyệt	F	63	8-O.%;aG	0	0112310993	1LfWo4AEbv
872	Hoàng Thùy Lan	F	28	09T>lJIgeJZFkV$	0	0384168341	Wco8mE9UJs
873	Lê Thu Linh	F	23	!>Uf2g)D$)xY&Z+s!	0	0798781420	YYmTfKimEI
874	Đặng Bích Như	F	29	<Hz)tR[Cv0@=8Q*	0	0888385630	XzI5NsJkb0
875	Vũ Tuệ Như	F	59	*sZmR0=+6xP8%:C	0	0542855940	8UsIAdTmfJ
876	Đặng Thiên Khoa	M	32	6s*^amti!hzWdj4u*	0	0994318250	OEz7QwjvbI
877	Ngô Thiên Khoa	M	65	er%aGsY(!S^	0	0303189734	FKk4LhzZba
878	Hoàng Thiên Khoa	M	19	T)[O)gvkTLLgfzy	0	0945108778	8168cFN3Cw
879	Vũ Thiên Khoa	M	40	1|7[?:_<>	0	0170653021	FQsAJ88zng
880	Bùi Anh Bảo	M	43	@/W}BBQCN%Ra&+9	0	0335865127	T6zO9Ng59p
881	Dương Anh Phúc	M	62	+9ZN%,/||,wfQ7(+,>	0	0506724403	x501TTXSlL
882	Ngô Bích Như	F	27	B9K7NZr!ga]p	0	0283658206	oCyKoRrbej
883	Đỗ Anh Huy	M	59	uAh-oi5M.:d*omlV?+-&	0	0984325570	nhASZ1trHH
884	Huỳnh Khánh Thư	F	39	-Ms%5J?:&d,rI}(7	0	0719358223	bZ7wNydLjL
885	Vũ Thùy Chi	F	57	h0zy|A/@	0	0205251758	XblnheFsc2
886	Lý Minh Minh	M	48	&@KV||XpNY*uj	0	0507201484	RHyuUKRjmQ
887	Đỗ Bích Linh	F	40	xOlom[D@Rm]}nVs|5pzc	0	0407321670	27q8MhW0wb
888	Ngô Minh Phúc	M	23	^)@sXK5jGsfO6Zlj	0	0690852418	d0VgXewclz
889	Đặng Bích Thư	F	45	^#0GQNoT	0	0187166824	ARzQpO4qFH
890	Lê Văn Khoa	M	57	/|_2_|^6c{	0	0731001052	1dVOAcWise
891	Vũ Anh Phúc	M	24	>8sNy:Nirtu/a	0	0926439334	qqt0Z8DrFz
892	Lê Minh Minh	M	39	y{JKu*],54r.-	0	0454382377	zzF0BozxuN
893	Đỗ Quang Bảo	M	23	dSgyE,3eW?%%y+$	0	0607687950	TZgogfG4Kx
894	Võ Khánh Thư	F	31	>!@[xE2S:!,_u|$u@	0	0462090233	qIF68buYtR
895	Đặng An Lan	F	61	Ue1*<Yf@wH^X^9#fu	0	0893214954	2jQEBPyop6
896	Bùi Thị Nguyệt	F	40	[q;Q]}&YG)Jj	0	0587601316	xxHYwgBNXt
897	Lê Thùy Như	F	64	MfebkWui.(=QCH=p)q	0	0324191280	wumgK2JstI
898	Trần Anh Huy	M	50	/CZvy$!8Khg?ta$	0	0825232613	hwBd8KglYT
899	Đỗ Thùy Thư	F	44	kC>>T=JQsZ	0	0149721517	scNMhMDXRy
900	Bùi Văn Minh	M	55	qVC%,A@G2lNt|&C[Ada&	0	0773160833	LuqxpyXRrt
901	Hồ Quang Huy	M	34	AV9]F&u}q;{>Ln{%	0	0696103936	z27I1w6e8F
902	Đặng Anh Huy	M	37	&&b(wdJ,/W2QfY:B	0	0491356958	wLmjTOkPYk
903	Huỳnh Quang Minh	M	21	JRY]ydV!<0GZ	0	0507749321	F6dONxucy4
904	Ngô Tuệ Nguyệt	F	60	zp<X-r6<WnZPZdFc	0	0141088915	DM72VlwkLU
905	Bùi Thu Chi	F	55	(P$k7.Ge	0	0139830298	WgQD0PzTnj
906	Vũ An Nguyệt	F	34	8?#vVcl[.@?	0	0797401680	QXUvX4waGq
907	Nguyễn Thị Chi	F	59	1L?H/iKSEg)C=@{ZPiD	0	0359323160	mKgNRg3Maw
908	Phạm Thị Như	F	24	8L+6E1;o	0	0900289863	cM1dCQUIe5
909	Ngô Minh Khang	M	26	2FwS/3(H&]^	0	0600148589	Wph7D9BGs2
910	Hồ Minh Khang	M	21	R!Eke,O|I1<*X2:	0	0107128710	So9XqBUDEJ
911	Hoàng Anh Minh	M	52	sy9U?)4tPh[	0	0593142241	gYTGLKrXVu
912	Nguyễn Văn Khoa	M	27	3E<*rGyM	0	0128345994	hmOXVkXLFy
913	Huỳnh Khánh Như	F	28	CNy$LTK/	0	0572855717	Sg3J0ZjuKd
914	Trần Bích Linh	F	21	r;9Hqnlm	0	0713787866	FSCEtbyam5
915	Hồ Tuệ Linh	F	25	[{e#PGcxE=P#	0	0423454751	6rk1WDs1MY
916	Đỗ Minh Bảo	M	59	=FlWh)#f4h	0	0606763597	BrOL71giJk
917	Võ Thùy Lan	F	37	a,c(*D*|pZ=^569?B	0	0210592268	RXjLh79t8g
918	Đặng Anh Huy	M	28	X_A,|cxf$C.|NcAvWU	0	0895783294	ZhDRyUI0eX
919	Huỳnh Thu Nguyệt	F	31	7+n9O0zg8g?%TU|	0	0838130701	HmWuaUTu7G
920	Lê Bích Lan	F	18	3p?ma,Kog.&q,;*pY	0	0758777524	SKZLWjW9Bd
921	Hoàng Thùy Linh	F	20	&t@dhrx>[/^}f/FL4e1-	0	0626011882	i6C2mIK8rq
922	Lý Tuệ Nguyệt	F	35	@*hXd9_q_SCFYq	0	0699953922	hY374zFd84
923	Hồ Quang Phúc	M	35	G0A:{zo]bvaTHD	0	0613864593	2IG4NzzmEw
924	Đỗ An Thư	F	28	oyW?J&Dg+<i^YRrcQb	0	0467065686	cQDupFGYQA
925	Phạm Thiên Khoa	M	33	q([hb8e]SL}	0	0111246219	u9gJW2HiGr
926	Dương Minh Khoa	M	48	Qb&+d*2|.Aofr7,Dj;E	0	0685485642	lK3cwrCCgW
927	Dương Anh Phúc	M	34	sGZV.C*EyL5-	0	0903705998	QyCkLxPzai
928	Lê Thu Chi	F	20	hSxJ!2X;f${pp_qV7:>	0	0690201975	0Tr2YQHoH4
929	Đỗ Văn Minh	M	34	AI*Y6@u.YXEa8-C@Ne0B	0	0331139404	EUHcN2nDGA
930	Võ Tuệ Thư	F	65	k&edH_aoU5?=v:]Ih	0	0618239611	51sRpItq8a
931	Hồ Khánh Lan	F	51	l=OOK/^O5D7IzCzb	0	0457609143	rkBZwlopTY
932	Dương Gia Khoa	M	65	+OwhJu+x4c)?+2)	0	0806153601	twQSJRL1eu
933	Vũ Minh Huy	M	58	8yE%)O>0	0	0257402151	ghzrZeJBig
934	Bùi Văn Khoa	M	30	s(C%hBz885X/<p@Z	0	0415816945	kMQbATOAAW
935	Ngô Thị Thư	F	58	?3w(u]axsVBPZ	0	0360282233	Es2TIxwwmG
936	Bùi Minh Phúc	M	50	-Vt?,BbkH8$?]	0	0655063077	n9OLWkfgtQ
937	Phạm Thiên Bảo	M	23	8?bqj9-t6)wYs&z33@P	0	0135806639	TtCDAEi5zN
938	Bùi Anh Bảo	M	46	lHVB6J<@6>z1_0;%Lc	0	0243787540	Qf3kGKF6p0
939	Lý Thị Thư	F	20	;QS%h7@3Yv#QQ=FF	0	0150171479	pts1PUZFPf
940	Đặng Anh Minh	M	42	$6ZlwIV,e.:1|*)	0	0745074900	uDFdomcR0K
941	Lê Văn Bảo	M	58	$4X*%[L;DF?xmzh	0	0102292478	yMhdSnNkYr
942	Lê An Nguyệt	F	36	y4F-&AiT-&neI#	0	0714728807	fB5eY0YZQS
943	Đỗ Khánh Thư	F	27	8j-P:v_ZHTH	0	0986295379	qtTx3h8CuM
944	Trần Khánh Như	F	45	itK7I7m+|1Z)jP?S	0	0640345189	Nqgw5S5Zoz
945	Phan Anh Phúc	M	21	X==[]U*os0	0	0677939695	vWUo7WoPbe
946	Nguyễn Bích Linh	F	49	Dey()b=.&GUSmxU]F	0	0486862580	2OAH8ifMFC
947	Trần Khánh Thư	F	56	_)OP)*/5o5B}%.DM185	0	0999840937	bIEzh6wVZ6
948	Hoàng Thị Linh	F	59	Lkap}[?r!$	0	0906233655	bVX1EWuE9M
949	Hồ Quang Bảo	M	28	a[p4F$8@y	0	0633765860	VWro4SjZt4
950	Lê Khánh Nguyệt	F	63	M|J+F@Do	0	0101127194	cUz6tdm5rT
951	Nguyễn Khánh Nguyệt	F	24	RE/m^m.5Ei^x8%<{nUu+	0	0365843932	0yvmarY7aL
952	Lý Thị Thư	F	59	KG|S^]#</X,3	0	0520950170	qNU3kj2Q7s
953	Đặng Gia Bảo	M	33	ryWYE:t51]&)EgmvO	0	0791627668	o7hTp1xpzP
954	Đặng Thùy Chi	F	36	aS946NJ+ai6}&;q	0	0207484237	eHStRyXecu
955	Bùi Anh Huy	M	32	d-bC5|vVG;{$	0	0775770579	6IaWiOewtu
956	Đỗ Thùy Thư	F	29	+^Nwrs&gkI#BRQ5J>HR*	0	0530737411	n2qIZO2vko
957	Hoàng Thu Như	F	63	b4/hbG1,y>9jko([Mmio	0	0539550718	rgvROSRADQ
958	Hoàng Minh Huy	M	52	[<}YFpm(dP]<Gp/_>	0	0431088548	uxCQlCJvw9
959	Nguyễn Bích Chi	F	36	wKz72ki!^6kr}:pnRIIW	0	0658130454	aBO4srXtLD
960	Ngô Thiên Khang	M	57	0+:S1k&+&RX9#Tq1	0	0816420894	Sv4tMV03vu
961	Trần Gia Phúc	M	20	z##DjMe[.M(mJu>tO	0	0847334301	FXgj1q3AGB
962	Võ Văn Phúc	M	48	G#dhL$w_mWV4{XD;#	0	0966790329	uh0WQ6HJkH
963	Vũ Thị Chi	F	18	tnLs8n]bWOhT@+<3UE	0	0363733222	mqxmLrmshV
964	Hoàng An Lan	F	19	]ho;R03w|1Ufv-y	0	0359387336	PyZl5q9e14
965	Vũ Quang Huy	M	59	&eUp1?KpCrr9g	0	0432927585	0fu9pb70w8
966	Bùi Thu Thư	F	63	%a19LA+O(W)CWnun	0	0357971863	QgJW5HtxGr
967	Ngô Bích Nguyệt	F	52	]BW3KZ[=7*OMB%#	0	0984184038	YsrUmk4KFl
968	Hồ An Lan	F	44	p]6|=p-([	0	0167196597	dS7B50Wrsd
969	Lê Thiên Minh	M	38	^dcw=Fud%$(}[^R$gG	0	0905651776	aCjRGDr5ce
970	Vũ Gia Khoa	M	31	4SAVyFrg!K;hV.px9	0	0856773502	22i8w84tvt
971	Lê Thị Thư	F	23	oF5./<QJ(@XDy/qEQ	0	0351133780	RrT242jkuN
972	Huỳnh Gia Huy	M	50	N)Wm/_*3Zn7-t	0	0231560799	gMSBTcNRe4
973	Ngô Minh Khang	M	34	BW*.Zty,A7T*Jl	0	0818555091	kkVHFDkqCh
974	Dương Tuệ Thư	F	41	4tuDhTajs)N#R;	0	0343585377	1ma05FpIzy
975	Trần Văn Phúc	M	48	^^Tn.!j2Oe4y63g$.Z	0	0511920116	3NYoH2uSif
976	Võ Gia Phúc	M	43	^Ej;3;RZCzMO@?6.Js	0	0417596362	RjZxcj4fwg
977	Phan Bích Linh	F	41	P7OO?a#6	0	0413034808	GNDaZwMUSW
978	Đỗ Thiên Phúc	M	62	tLK>-ve@RQG.W<_	0	0751487067	QfpWAJYIf8
979	Dương Thiên Huy	M	57	H;H9T=!eR[TZ]SFh	0	0922005168	luuKe1RZjR
980	Võ Anh Khoa	M	41	*[2qX.R(9AneHEn6	0	0267965354	aVLS8uYTZa
981	Hoàng Minh Khoa	M	26	u8zWS;&+-7	0	0514192019	y0WTcGIWgv
982	Phạm Thùy Linh	F	22	C7[J:fM@0i$	0	0975974474	XOVtuCqpER
983	Dương Thị Thư	F	47	JBsky#8?H3Y	0	0450748160	zYh36yNzIp
984	Vũ An Chi	F	40	GW:XX?aust%;E?	0	0200778310	mAk2keMcuh
985	Võ Khánh Nguyệt	F	31	2tGrY8KZn$Ykp!ZqcPg_	0	0480905114	cTM5FaERgd
986	Bùi Thị Chi	F	63	@E}*,balh^	0	0661064881	7GEDDg6r09
987	Trần Thiên Huy	M	57	ko2_-@718u|el|7CISh	0	0781205146	AwplOL42MC
988	Phan Khánh Linh	F	33	,UiO.<j|^Bf^(	0	0484231797	CFDGvnoDOa
989	Trần Khánh Như	F	52	Ua{/b(U@7I<9YXGwvf:	0	0252614241	ZtrrVerc5a
990	Trần Bích Chi	F	47	n-Z0BDlFwI9mxV1Qzb$	0	0474281006	q9ME96wI6O
991	Đỗ Văn Khoa	M	19	*1tV1_6r4/-1u=?hBN(R	0	0579699753	daFoS2Benb
992	Lý Thu Chi	F	20	ZgB;0:!L[9kj=z+pAD>6	0	0883524819	Dc3e7xN3Yr
993	Phan Anh Khang	M	44	c&Ul!P7qu|B8de|r<(4f	0	0772989267	NgoWVg44fL
994	Bùi Thị Chi	F	58	sG%H(.<A_wc*?S^r	0	0798584623	FBifTz2vHK
995	Phạm Văn Minh	M	35	kW:8ht>_md37{87	0	0553903189	Wv26hrKEMl
996	Huỳnh Khánh Thư	F	43	P?DQcJmg1-	0	0960928556	4iQ206dOJT
997	Hoàng Quang Khang	M	22	^ht@Tf[0)!Jj]	0	0290741941	J47xKaQdXl
998	Lý Khánh Nguyệt	F	45	E,Q2c&D*rt	0	0862602164	AqzxRrSOit
999	Lê An Như	F	32	K7GE<%(&&!	0	0479168831	N8U5v2DMs3
1000	Lê Văn Bảo	M	23	bCBxPwMuSEu>	0	0990337603	qe1t4BDX7V
1001	Phạm Thiên Khoa	M	33	Y1Z@UB*Ejk&:pNggO?6%	0	0795932719	QIkRKScM4K
1002	Huỳnh Gia Khang	M	45	y!U(lR{hTx^*&;>w	0	0995720517	JiogLS6cS0
1003	Đỗ Tuệ Như	F	59	6$Y,s;=U_d-}&Rcv/	0	0732690651	HW0MGDbPs1
1004	Lý Thu Lan	F	37	_$s2zV632]Yp	0	0460210342	IPTqpVAUix
1005	Hồ Thiên Bảo	M	41	%-fv^kL}r<VC%sG),KE	0	0467187040	0d2wxPZyZf
1006	Phan Gia Huy	M	63	(qBZ[[Q:|:0>F)	0	0268316933	BRtG0nnB8V
1007	Vũ Thiên Bảo	M	20	Q|SW7oVderg#WC,	0	0210466420	eHJ7CnA1Ct
1008	Võ Quang Bảo	M	23	tjvnsvN%,KasJel-N	0	0581158105	LcuXkRa6nx
1009	Bùi Tuệ Chi	F	47	]T+K$@!1?A.:vV_Gr	0	0615176899	9qu3fwZcqd
1010	Nguyễn Quang Bảo	M	20	N-lj*]KZ_vZ)6Z{OBVD	0	0372525401	TgdTmAXhSv
1011	Nguyễn Quang Khoa	M	54	C,0_y:]EhRi_ks]9sO	0	0704104917	u6RmCRNyRr
1012	Phan Gia Khoa	M	30	W/JW#.k1}l.9UA;	0	0476435202	6tg5TJi62y
1013	Dương Anh Khoa	M	60	S_=7%QY,	0	0831486231	r8AiR7cefJ
1014	Lê Minh Minh	M	52	]p{q)XOL	0	0704305315	XvO2Plh5j9
1015	Hồ Khánh Linh	F	33	a(VkO<|J(u07/:h-:[	0	0732170048	yOoCjNPM3L
1016	Võ Anh Bảo	M	59	S9]]&bN(j0ePY+qYun	0	0562285288	c5Id5MM5QZ
1017	Đặng Thu Linh	F	60	:;?x2K[m+nAe*cB	0	0510936498	BYvL4O7hgN
1018	Dương Văn Khoa	M	40	&p5B808#_,8^_	0	0496467475	BsbCNgGpxA
1019	Hồ Văn Phúc	M	29	L[,znDi<H	0	0506407779	JYx76HaxDY
1020	Phạm Bích Thư	F	32	(4)Q|N&4V>*4jvj;9s@	0	0810335998	yAcb7QQDnu
1021	Võ Quang Huy	M	63	!,Kyt_?,Zm<.qdbC	0	0501899804	V5C2dH8jAN
1022	Đỗ Thùy Chi	F	25	998/^4%yw8jZu0#s	0	0702146046	oWWHiZKFof
1023	Ngô Thùy Thư	F	22	eTaeO9xMvQ$s	0	0160877640	rlFh1mkRlN
1024	Vũ Minh Minh	M	47	Sz-_xCLW@N$a_?H_^(^	0	0982991082	Uyyi1M332v
1025	Võ Thiên Bảo	M	24	q?Z<;$oZ	0	0138901794	8huLETUze0
1026	Phan Minh Bảo	M	23	ga7}hE4GZ)r=1osB#PA	0	0134475504	kLUqUzjcY1
1027	Hồ Tuệ Chi	F	65	FE[+Q6d=a/zG>t4;,	0	0972118521	fV0GppxrCx
1028	Phan Anh Phúc	M	60	<VF(pnAKFIwT&QI	0	0300741041	xWLLTstjMs
1029	Bùi Thiên Bảo	M	56	CTWYh(>on?Bw	0	0506917862	VL0D6DW3VJ
1030	Nguyễn Thùy Lan	F	46	msVCeik!/*C3k	0	0789933632	tUrFDQ3cuP
1031	Đặng Bích Nguyệt	F	22	R!AKWb2>u	0	0410534370	Ty2R0fFyZa
1032	Ngô Bích Linh	F	38	B<|H8Gp[r?]JN	0	0960128144	vXgjBZBp4V
1033	Đỗ Thị Linh	F	24	6<>!EO;]O2	0	0160137078	eqqf2jKgXO
1034	Lê Văn Huy	M	28	ap-]Ufrte@*)^y$n	0	0493385816	975nAIlN6O
1035	Hoàng Tuệ Thư	F	31	YgJk4b@;1s_d2]M%	0	0342643493	FWTmSAT99m
1036	Nguyễn Văn Phúc	M	40	(W#,..}?	0	0189021349	uMWO9zNLcO
1037	Đặng Thị Như	F	61	6XA7W%{xK@EL.h],>Kf@	0	0780189441	DQ6c0h9HWh
1038	Trần Tuệ Thư	F	28	R+,;3s^289bv	0	0977350941	6bY2p20nUD
1039	Trần Minh Phúc	M	63	d$SdG+u(fvdj5xt>	0	0952468802	9Pyt7u3d8U
1040	Vũ Thị Chi	F	49	{T+4-Gu!eY&VlNQ	0	0496738985	hnucElsksr
1041	Phạm An Chi	F	33	L*QOQdH)	0	0584511802	PDVRjR1TdN
1042	Nguyễn An Như	F	39	l:Po,9<!DXL_]}hPv0%	0	0420927569	0HvFA0TYJ0
1043	Vũ Tuệ Linh	F	56	1oD2eQ^;TT#G	0	0850868812	8e2D093XQC
1044	Võ Minh Huy	M	39	0Pz1?Uz<P?|<R	0	0858103067	NqHnYnJovd
1045	Lý Minh Minh	M	34	A@}T5S=m_	0	0798231838	9oLHODzm3q
1046	Đặng Thùy Như	F	51	AGqH%4%S	0	0989006236	UHJiZi54ZV
1047	Ngô Quang Khang	M	30	nUb@)#*xR}av?KC,:@k=	0	0230224151	FFlgRKhNMN
1048	Lê Văn Khoa	M	45	:<L@rEfY_wa3+<8Z?-&	0	0765319771	63k12IqBAA
1049	Hoàng Gia Khoa	M	41	7Z#n0Tp*p<_m>U2	0	0810414240	3kTMbZ8uTc
1050	Vũ Thùy Thư	F	23	,*U;9ku%1)[S#3R:qe#	0	0309792589	30dqxqITAY
1051	Võ An Lan	F	21	)+khW%iC	0	0415398254	FC9ay3fhtx
1052	Phan Thị Linh	F	63	KK8t^=PSVnX	0	0136843255	xvIDukfquF
1053	Đặng An Thư	F	59	q@UQJgP=S2or1B	0	0108657341	a1PJKpgqIS
1054	Phạm Thị Linh	F	35	$A5WJ;vQ.HTVbn	0	0727678196	MZI2B6bKDU
1055	Đỗ Thu Nguyệt	F	19	;|,]g8U3EHt3)ZMO	0	0749534165	b2Bx4S1Rzv
1056	Hồ Thiên Minh	M	65	V+_6:j_X]XAc;@<xvE]q	0	0850320984	8ICm3xU9rP
1057	Huỳnh Bích Chi	F	21	.3TybsK/;qnKNO:z}}8	0	0305934869	Bd0rq8LcI5
1058	Ngô Khánh Chi	F	30	OQow*oJn^g	0	0567151685	BNivV9NGV5
1059	Bùi Khánh Lan	F	35	Xp,K=*-b	0	0569563472	UAuMO5EFSE
1060	Đỗ Tuệ Nguyệt	F	55	o&s_Zoy<G2sN	0	0935919047	dtuc4m5yWE
1061	Lý Văn Phúc	M	18	5@f|_8he}xRfBt(	0	0834118304	jl78SAFkeR
1062	Phan Khánh Linh	F	55	}9-9g#&EfZR7/A	0	0738276350	dTxEa72AtB
1063	Huỳnh Gia Huy	M	24	(KkNQo#S#	0	0726607477	x1F85dWw7e
1064	Hoàng Quang Huy	M	34	vuHa}9|j_mbpA$P	0	0281389835	dFnHYelTJH
1065	Lý Thiên Phúc	M	22	I.y*@/P+6A@	0	0510371377	fVPifAWn6A
1066	Ngô Tuệ Thư	F	32	uDBR}opM+t6sfx-	0	0326959226	7Tc5tOzxG2
1067	Lê Quang Khoa	M	33	}J*Elk]?6_M$niN{8m)y	0	0322252666	h7C2WvcoTQ
1068	Phan Anh Khoa	M	46	y?E811A!Yj|9}+Ow	0	0528605236	EoYmPhnR1c
1069	Ngô Anh Bảo	M	53	zWBx8:;J	0	0548912575	yljA5o1HPe
1070	Nguyễn Minh Huy	M	37	$AK^M{{YUu;nS<$	0	0369779627	mNtVukKiKU
1071	Hoàng Thị Linh	F	20	]X,2Me_89hVNwFw$>	0	0140665902	zgV6qXzjtf
1072	Lê Anh Phúc	M	21	f+(pKvG:)	0	0164351946	6FIviX0uTr
1073	Lý Thiên Phúc	M	25	&CsKnV;bI5	0	0641213887	GJAOLnCS1h
1074	Lý Gia Khang	M	35	8<1Ij3{);	0	0682144632	USzMzNf2in
1075	Võ Văn Huy	M	61	^][D;.iG|Wy.6	0	0384869215	aLjg6rMyqH
1076	Dương Thiên Khang	M	57	3E6e}hkV{wtsC@/A/*	0	0402157898	XDbRyauqfJ
1077	Đặng Thu Chi	F	45	[8Q|}fMD[FpI%b	0	0573033780	EXu3BsYhQq
1078	Phạm Quang Huy	M	32	>}Yc!WSlcHi	0	0809411958	nR0aGELu7V
1079	Đỗ Anh Bảo	M	34	>iD7(?I(tjVOUpbS	0	0303168508	P7y61qgIzh
1080	Huỳnh Anh Khoa	M	18	T}ZjYh8kA	0	0302665540	4eVLn48Ww7
1081	Hồ Thị Chi	F	19	U(cb)k4W[R	0	0613764741	M92ZcS2zuT
1082	Đỗ Quang Huy	M	59	$U%1Snw*%Yht	0	0263365072	kVsdfVsNXm
1083	Vũ An Lan	F	62	[_#p>4-msFQ	0	0759992142	cUSAPJz6gq
1084	Bùi Thị Chi	F	49	}y_@k{}nX	0	0181477655	25orRAMS3e
1085	Đỗ Văn Phúc	M	59	Mg{01NFU9M:=<i4-uixW	0	0227463731	de3UoUpJCl
1086	Trần Văn Bảo	M	22	KM+x#3)b8@	0	0696896944	WDSpr7ldx5
1087	Phan Thùy Linh	F	61	0R-=Ma?#g	0	0498997459	n9xUBnXTQE
1088	Lê Khánh Như	F	28	>Q-%:#x{#-jP^	0	0719572763	x8Hahhdrel
1089	Phạm Thị Lan	F	64	KG:M}lC;rPI}]O	0	0525014260	QUsqxyl3pg
1090	Hoàng Thu Chi	F	31	ZQr(UA|m<q	0	0709354233	zaiwu9wBo2
1091	Trần Bích Thư	F	44	4X}Ktr[@2T(R%2*A@@h#	0	0633442755	6f3boNVkrN
1092	Ngô Anh Huy	M	61	nw4d|h*3s!q	0	0739071401	mu7NOXbBxU
1093	Vũ Thiên Huy	M	31	$+}mi1{]n	0	0333966809	mtHYT5Jfru
1094	Trần Bích Lan	F	46	Q)Uf?d(hY*	0	0500670551	Gq8GxsFmtk
1095	Hoàng Tuệ Nguyệt	F	28	YI7)od%D_!i;t#kjzN	0	0763058533	uyVd3po1yK
1096	Dương An Linh	F	45	0WO%0+dDTG^?@jIU43X;	0	0715935792	4C0PUooTjk
1097	Vũ Khánh Linh	F	57	c*-b;S3!#P	0	0138089748	kHZiFoMXkA
1098	Vũ Thị Thư	F	41	t_gXMi(>Z{z	0	0597949939	HRX8z6Cu49
1099	Nguyễn Văn Bảo	M	26	zHtF|uri<zvK_<>z	0	0622533626	uGj81MjFwc
1100	Phan Quang Khang	M	59	}-v-ls>/;TA?/1%s	0	0155835750	WCzoXSrrcW
1101	Huỳnh An Chi	F	27	789-{Ud#	0	0772458795	I6n3Ni1gFy
1102	Nguyễn Quang Bảo	M	65	Ktz^i{)B0m	0	0673452916	9OPYHG8gPV
1103	Bùi Thùy Thư	F	37	bp5Rz#4W0r51)5	0	0260426456	kbUwEMa9UG
1104	Ngô Thiên Minh	M	31	#1%iI?rx&Cl=WX7;Q	0	0598969958	WkXhPc5cgG
1105	Vũ Bích Nguyệt	F	30	yq-V{1}m	0	0174029416	Nnde7Dmvp1
1106	Phạm Thị Lan	F	26	oC:D:N]A?O-6om|M{	0	0807322298	SHFj2j7D0l
1107	Lê Minh Phúc	M	18	U{&<(9lTS#H::[Ef)i!	0	0638101086	FRKbzWPFTp
1108	Phan Thị Linh	F	20	x*<$,c/[_	0	0113976578	qLBySWBdL6
1109	Phan Gia Minh	M	47	39EveWu+JBtlw}wST=	0	0351375244	aTbJPNHXl8
1110	Nguyễn Gia Phúc	M	18	K_%y@N}<gjNqA^d@4s$M	0	0298340183	Hgmu76E5IS
1111	Đỗ Gia Khoa	M	38	=jY3&b2ovXn|]/1U	0	0796242831	DScryiOca1
1112	Trần Văn Huy	M	53	VzU,N1+)A2gqxbi	0	0491536376	hmxOHkYkXJ
1113	Lê Quang Khoa	M	64	iLOWiG)<ul7xItM1h?	0	0241670057	KinNr26uXz
1114	Hoàng Tuệ Thư	F	40	vBDDs62hF&@[6<KpQ	0	0588916521	BbcWeWIgJ2
1115	Huỳnh Anh Phúc	M	46	2XLYX|i#dm*	0	0917248346	sVGC48KrbJ
1116	Lý Thu Linh	F	34	=!Rm[C()0|@K	0	0239590265	S3YIbTORdZ
1117	Võ Tuệ Chi	F	56	I,r{{7-#!Fl$	0	0545438918	igIg3Btj6a
1118	Dương Thu Thư	F	30	h:<)IzgqH=	0	0802014239	Pkw4PcOOm2
1119	Huỳnh Minh Huy	M	54	dq2=RYt,[kyox<3D8s>>	0	0412878274	LWf8cCNCle
1120	Lý Thiên Bảo	M	29	,0bl&.E.tN#6+TZ	0	0281018990	Pf0riusVLC
1121	Đặng Tuệ Linh	F	49	6v[)/]*-!W(Q{	0	0819048951	tsJ86cc4XG
1122	Võ Khánh Chi	F	45	/p0@Rin!	0	0391738186	q3J59t0xK3
1123	Vũ Anh Phúc	M	64	z(bq2|sk,	0	0812381211	JnALB0VWz5
1124	Lý Tuệ Linh	F	32	6B&ir=z:/yZv	0	0188182593	xvXhNJypxH
1125	Phạm Bích Như	F	54	Fwf6KI%:N)tbz]	0	0962024637	ylW2bYBhYo
1126	Lý Văn Khang	M	42	2V_m/o.Yp=4&B	0	0792383467	q0i9OW3wO6
1127	Dương Thị Chi	F	41	IhO7}/m8odgBj0;;	0	0138675401	5DtDLh34af
1128	Hồ Bích Như	F	47	HtP}:-IRG]&7{W$	0	0568279424	eRDeC0eelP
1129	Hồ Khánh Nguyệt	F	47	1FxKX|T@9	0	0482312409	1iOuVcByHO
1130	Võ Tuệ Linh	F	32	wl(0/c,m%;$(M^X	0	0613216041	uwCsFtpYA7
1131	Dương Khánh Lan	F	51	LM;3Cp:=	0	0181670204	k5HnlJxVKj
1132	Hồ Văn Huy	M	33	*%?f;lu2g%5|	0	0545816990	YRwLTjhUSo
1133	Hồ Minh Bảo	M	61	#-M/K&+CR|	0	0570914081	xeZMWqxljf
1134	Nguyễn Bích Thư	F	30	0xn|0t-Fw:JJwG_emM?C	0	0635211507	4L777OlTcR
1135	Vũ Tuệ Lan	F	40	1!nqE_uonB$m	0	0406006729	KzvPU8MKYz
1136	Dương Thùy Chi	F	65	W:|Yjg$+Ud@	0	0486433732	Ch3mAtcrts
1137	Nguyễn Minh Khoa	M	61	<QKI,0k+ZJq%]	0	0568864840	vSTQDVypDS
1138	Võ Văn Khang	M	59	FQgN-UI#1z>?/M6M:fr	0	0374920400	zPbZMqNB9S
1139	Trần Minh Khoa	M	50	R(MqO_v$X-oB[}	0	0184298578	3si3V1aB8l
1140	Lê Thu Nguyệt	F	55	[|1*&jF&M0W$MoxBx?m	0	0867183223	QQU0EVvA83
1141	Lý Thùy Chi	F	18	A)cp/Hh{ij1pi/J	0	0728777463	iOxEkor6cs
1142	Lê Quang Huy	M	40	KS}^J-$NN%j	0	0527936118	VcEVkdAwtI
1143	Vũ Văn Huy	M	19	IbgKo;%;J}2^y@11	0	0757514613	Y9yg4BwSe5
1144	Bùi Quang Phúc	M	63	CQBeu%!P!o}z<0cKa	0	0662588482	jzVDGF47mz
1145	Nguyễn Thị Thư	F	23	oPoJ-fNT=*L	0	0832166814	5I3NZm2xSY
1146	Nguyễn Gia Minh	M	60	fMqWOPzY9,u)	0	0516362978	Cm1LDtKrhp
1147	Đỗ Quang Khoa	M	19	_@#A<WF/bBdpKu{&!)	0	0119691331	L1ZqfBFxlF
1148	Đỗ Quang Khoa	M	33	NlKaD*%2q0$IbZk4iY	0	0845019258	Y4LL6G0R2f
1149	Bùi Quang Minh	M	30	:(IM&lqz%8]xRcb:W	0	0283549112	7i06LfZHNk
1150	Ngô Khánh Thư	F	49	^|6=09,_<_Ki	0	0335657739	2BFBAYtwX5
1151	Đặng Gia Khang	M	57	[#-ffLts:]2_D	0	0140461095	NmzTJOuW3B
1152	Hồ Quang Minh	M	38	2Abipyjs3@:;>&	0	0879917407	IOLDwTCA6O
1153	Lý Thùy Nguyệt	F	33	1GBcS_x7mjOdt	0	0954861705	yqwJRzKya1
1154	Hoàng An Thư	F	38	8/Wn-!Q=	0	0530705504	AOx2jzZJEG
1155	Vũ An Linh	F	46	JuuIg-4Z.c@5XNI/&;	0	0141918513	mQtBbzCZxF
1156	Đặng Tuệ Linh	F	18	]T7.5ov9j+)NIQ.P}LA	0	0480623375	VkEKZzwndH
1157	Lê Gia Khang	M	24	jY=Q_3+gO#x	0	0873090221	STPxR44koB
1158	Nguyễn Anh Khoa	M	20	UI3BHSzfvB^9	0	0439831905	MspzvvLTaE
1159	Hoàng Anh Phúc	M	60	6h&pmdU)&;*+{3{r:b+	0	0707783748	06vT9DejLg
1160	Phan Thị Lan	F	26	q|Uusu2%.el#ZU0V	0	0890069370	vGkEcg4q4T
1161	Lê Thiên Khang	M	32	^?VM6mMu%	0	0723029623	xYeHkKbZ5k
1162	Phan Gia Bảo	M	22	kre8d[_R	0	0296262451	6thNRfSX49
1163	Trần Khánh Lan	F	40	J$V?d..jpFsBVPh@	0	0566043644	y7KtWxgl3G
1164	Trần Khánh Nguyệt	F	26	KjbM>(Uwt3MgBAmdY	0	0741203090	2EoyF9A3SH
1165	Vũ Thu Như	F	56	&lq64ljW@R8	0	0506265022	NCocN4pwLK
1166	Bùi Khánh Linh	F	57	-B4P!4HfVCtEe:r	0	0402718085	PKaLol9KLL
1167	Đặng Thiên Phúc	M	39	AkWb(Ue0	0	0818433205	YG4Qh3lljK
1168	Nguyễn Khánh Thư	F	44	EU[w=ZjzzOXx.$)Q	0	0882840449	axUww9ZQP4
1169	Huỳnh Tuệ Như	F	24	!RHoHp:l70_	0	0445574970	5zxMHEXStL
1170	Dương Văn Khoa	M	25	OitN.}C5j9a>Q?,XI6L	0	0909410352	eo8kO9OXZ8
1171	Đỗ Tuệ Thư	F	21	JvZc+r>:Ji?=j66!	0	0703774154	BmTpCT5f4O
1172	Nguyễn Thùy Chi	F	33	(P-?ebm*1@nie:PK	0	0189467654	LXASFJQ749
1173	Vũ Bích Lan	F	55	VVHLQp7+coy*Qk_}!	0	0325205419	pQG8Ox6alS
1174	Bùi Quang Khang	M	61	v0z-j<&H!&+G5	0	0315947374	g6dCefkFGd
1175	Ngô Tuệ Linh	F	45	h*+xB_fHW[q$NX=Ym1	0	0373390776	sNju6fmSPn
1176	Đỗ Văn Khoa	M	35	:@U|j?SBP6	0	0263022438	c0AyWcc2Mv
1177	Đỗ Quang Khoa	M	47	oz6ys8,9A(]/:{	0	0802002866	YA36FMh2TH
1178	Võ Quang Bảo	M	27	cft1=_.js	0	0758308741	pG1t4jMIrT
1179	Trần Anh Minh	M	43	e%:TV5q03^Tis	0	0691418131	aFatYjyi4f
1180	Hoàng Thu Linh	F	60	|Qm[<CwboOA	0	0990028527	sZjUzPcNpa
1181	Phan Gia Bảo	M	35	3X0C^CVD|0Qd5V	0	0954963689	MJWOVpEMGK
1182	Đặng Văn Huy	M	33	J/xw=o|K4A7jjOv/R%1	0	0789522746	ttNiHsarAh
1183	Huỳnh Văn Bảo	M	45	R-;?kXB)5SQ@;N95Aa	0	0653755080	BgdB5KmWeh
1184	Trần Tuệ Như	F	35	N90i!oZW^Nn4	0	0343463278	5pVyAKwrGc
1185	Phan Gia Minh	M	30	D6p0%=GwKDn9)G|hp	0	0418084649	tgqARYxaAk
1186	Ngô Bích Thư	F	36	0ntJN%=nz	0	0526328984	zifmwyhe3I
1187	Đỗ Quang Minh	M	26	tmvg?&#k-+>3L{b&0i$D	0	0237809104	6sge9x42zp
1188	Dương Văn Phúc	M	59	.LIjlAu<=[Cd%;&	0	0894398554	zuScrkrZzt
1189	Lê Thiên Huy	M	34	m(I%D{>a9VC;(_STZP	0	0629920502	JZtnS0CIQk
1190	Đặng Bích Chi	F	28	dE+1KZM,Nc;+V	0	0345653611	KgsWemmoej
1191	Hoàng Tuệ Chi	F	61	rsYj*^qlhEpg1B4)h	0	0417500145	kACNVCf3vP
1192	Đỗ Văn Khoa	M	25	9r7>_HPflSS9<_%O	0	0349637450	B2Jwgl2meZ
1193	Đặng Gia Bảo	M	43	}w?{L21TJc	0	0254849237	ord7daZAmL
1194	Nguyễn Gia Bảo	M	56	:)zMZ[673B;W1<f[@JZV	0	0662675655	HRFoerAlRu
1195	Đặng Thùy Lan	F	30	oceB2(P&(	0	0481636427	GyHnZjXeqL
1196	Dương Thùy Nguyệt	F	48	7iYpVoMs-j)}W_h*+l	0	0588159200	mXx4KIRedY
1197	Phạm Anh Minh	M	60	xM#p)7PA_RR[	0	0131106751	eug2r7VgRH
1198	Võ Khánh Chi	F	23	:O#k_Ef,	0	0890390566	6seCRFIy25
1199	Đỗ Tuệ Linh	F	39	O>N=ZAZ6_kwxQq	0	0101914788	ubk9FOqH8J
1200	Dương Khánh Lan	F	36	]8C?y)y<9w8fWwuv)	0	0598592652	rlNoYFvrBO
1201	Huỳnh Minh Bảo	M	30	b6Cv]bP3$HB?R@N2z	0	0962120252	qSG4yyGvOU
1202	Vũ Văn Khang	M	45	r{2bltQC<*[#/.pXD2	0	0301828816	xvUKuxOMfx
1203	Phạm Khánh Thư	F	60	/k#%{@/sz/_/gM_.;O	0	0416232240	xgLcQfRUJj
1204	Đỗ Minh Khoa	M	56	,55ClJH^}f	0	0282707773	U6WC16Ez0V
1205	Lê Tuệ Thư	F	31	hh5@V5G{DLfC	0	0935933805	TbZ2pmU1sK
1206	Dương Văn Minh	M	51	2p%R#E>>,hZ$v6|A6{	0	0989093297	0uem5vzB6a
1207	Phạm Thùy Nguyệt	F	24	l&E}E;GOr?#]7ag2	0	0699625399	P7IQaByLwr
1208	Bùi Minh Khoa	M	47	F)$N=yy5q5E>a_m	0	0149938305	fxgxTxvdkE
1209	Đặng Tuệ Lan	F	57	OA&.y[6W1	0	0291725849	GAzLG9hEv8
1210	Vũ Gia Huy	M	43	O.dGo_a*r@t	0	0902034769	8bPSRCNqGh
1211	Huỳnh Tuệ Nguyệt	F	43	$Z$p8[#H2&#k+)(	0	0944511305	JAm5Djgvx7
1212	Nguyễn An Như	F	23	uG}|oSj[#/&RtK$R	0	0640608330	h9hYdZOwJj
1213	Hồ Quang Khang	M	44	9(:5l+&+(mT	0	0676635996	rfq4PK8vIf
1214	Lý Thùy Như	F	23	%ra;&Gh>09{L*&6}!	0	0361279099	Y9UcavrJHk
1215	Lý Bích Như	F	27	p5<QuOFs]A>J,$F	0	0938194938	Nv0AeWHzvX
1216	Lý Thiên Minh	M	46	T4iRH;K),	0	0926894788	b6JSey7ifv
1217	Ngô Khánh Lan	F	55	lRO>7A+g{^h	0	0894564687	KvAWekcw9P
1218	Bùi Khánh Nguyệt	F	24	^KBm-mN)*M;DJiMY	0	0575952532	oBnOWhgQjv
1219	Phạm Thu Linh	F	65	_Ln/LiD|^26:u;Da	0	0694371402	y1Skaibn1b
1220	Dương An Lan	F	22	<{M|#+}m|(=%aU:J?,>P	0	0380876774	8lScDQUZcu
1221	Bùi Văn Khoa	M	54	,Jd,g8AjJdXX/	0	0327620457	OfZN4sIdVT
1222	Võ Anh Khoa	M	59	R]tm+eYJ2u?k	0	0366726150	vyiR7SSWkW
1223	Hoàng Thiên Khang	M	65	NUu@8p@hfEwN-fHUO;O	0	0452278041	NAiQqYqHJO
1224	Lý Thùy Như	F	48	i21GM:#2=mR%.Te;	0	0849064572	Xbt1uOsOe9
1225	Ngô Thùy Thư	F	27	K#K@bhC31	0	0385004263	X58Ehb0sb0
1226	Lý Anh Phúc	M	34	B8GhdhLoc-NSF	0	0813568648	Xr0WMJTtIK
1227	Đặng Thiên Khoa	M	53	djZ{fm3;	0	0178176459	YyT0aQXfvm
1228	Lê Thùy Như	F	52	om%]Hp*rmQe;ns	0	0417184478	s2APbVA5cI
1229	Trần An Như	F	37	/,*ZtPeO	0	0680083780	OM2naDMFCT
1230	Võ Thùy Như	F	31	!sVw0g,5,N	0	0892884958	wEDhuZRP7H
1231	Vũ Minh Minh	M	33	rdsK{lOB{^88w2yuj@	0	0945978603	Jtz21ySdxf
1232	Trần Gia Bảo	M	30	9&kdwsjy1{qoN	0	0433090976	fCjuiIdbXz
1233	Trần Thiên Huy	M	28	/D)TK#(Ea=5	0	0149350452	vFvQODd5Bs
1234	Huỳnh Tuệ Nguyệt	F	24	7:@h;}*#:W/V	0	0638735225	B932BSCpLD
1235	Võ Thu Thư	F	40	]}^CCRN-	0	0227570938	PdmgHfUhS6
1236	Lê Văn Khoa	M	44	n:&*,JDg	0	0447479985	ZG574m4JPh
1237	Vũ Văn Huy	M	62	%(!B}/Jc[+i+zl.	0	0372228210	qYGnnFaghU
1238	Dương Gia Huy	M	33	}My*yUW:O]|gJ]O{bF	0	0496926181	2p6s5mcabc
1239	Hồ Thị Lan	F	41	fGg@!M+9|	0	0453959081	cx33QwiH9L
1240	Võ Bích Lan	F	22	hF={jkW[O+Dm_	0	0956485637	4DTPaeF37W
1241	Hoàng Thu Chi	F	55	[{FO_ctyM_,p7o	0	0116170913	13bksjeOWM
1242	Võ Thu Thư	F	64	Q@-knSo?mVxygGv/	0	0682737096	1GmjNMP5ru
1243	Đặng An Thư	F	26	o}*$?X@Z?/s	0	0748256114	SQcnp99ZOa
1244	Nguyễn Anh Khoa	M	55	aF<9Aqzj3^qL_)	0	0313673491	BSpz44yDdy
1245	Trần Minh Khang	M	27	$lVcY&Y{J0U<LHY1-	0	0431615307	ggf9PlaCNQ
1246	Nguyễn Thị Thư	F	41	tY)LMcd!xW.	0	0450704557	DCRgnvyjUU
1247	Ngô Thiên Khang	M	42	.y_5efOppW,s8{6vu$4	0	0258379129	fydGoSY45U
1248	Trần Gia Khang	M	40	#/,X0x-!	0	0907641523	16GXZ1PTrK
1249	Lý Anh Khoa	M	49	c%*J%#u>,=e!p	0	0486414411	e8KD9w41DT
1250	Lý Thu Thư	F	35	)NQ)CD:Hdl[W;|k	0	0490695821	sEXCG2Eo2O
1251	Lý Thu Lan	F	54	0Hekj|Z]$gDo5Sd_=Z|	0	0717297986	3UF3yASJmp
1252	Vũ Thùy Như	F	63	]/x:,Y-w.en59d[ec	0	0956676000	nOquSjjE2T
1253	Hoàng Gia Huy	M	20	<?1hDwg9%rie#u9o>sk:	0	0666294525	kPw6h2hVWg
1254	Hoàng Khánh Thư	F	19	[pU$c.PsWRNhjI@aBrt)	0	0424921258	Elog8Gunzb
1255	Nguyễn Quang Minh	M	29	#b&l(pKe]I_;+l!	0	0795753672	fflOVuwkJ8
1256	Trần Thị Thư	F	60	S0X:d,;PB?alEE&k	0	0959216982	suu7wuUw6H
1257	Hồ Minh Khang	M	51	jRV5)5_EfI_7c:UU	0	0465523250	uUYZJRMYiw
1258	Vũ Thiên Khang	M	18	M_hcuoouUJ!A{XU	0	0519794045	2EEkORrEF7
1259	Hồ Minh Minh	M	22	i66dYyJ:|S	0	0114696038	2Wc99KjO5I
1260	Huỳnh Thiên Minh	M	20	MgTxkBVqkY.)}&z	0	0125591431	EWLGjiBy08
1261	Hồ Thị Thư	F	46	2:US;:t=cL8;3gQ	0	0445483555	vLey8qr8S4
1262	Bùi Anh Bảo	M	25	<GMv=J=G%!lm#	0	0536686798	RT6zeDNGEG
1263	Hồ Văn Minh	M	19	glm_iv>AP	0	0683207337	gWDQEku0nU
1264	Phan Bích Lan	F	51	K/.s,ZWs$&o	0	0226225924	jv973PsQt8
1265	Bùi Tuệ Linh	F	21	6S9cF7,j4HYS1o;UIX	0	0740070431	bStcTmxJyu
1266	Dương Anh Bảo	M	21	uYZ>G+tZ^Hyq00#,l	0	0136983379	BU0Tle3OQI
1267	Huỳnh Thị Chi	F	20	;RUW{^|y	0	0802890999	KBhaDb05Yu
1268	Phạm An Thư	F	54	/+c=8a*i2z5J[_OtoH	0	0327069171	hHcxMDRM4D
1269	Lý Minh Minh	M	27	hw3w%/FN7[%g	0	0881379311	FKMEj9c8HQ
1270	Huỳnh Thùy Như	F	59	ckE17#.@/	0	0851674090	nCLJ15ThRY
1271	Đỗ Quang Bảo	M	38	[:.}+BrfXq(IoXr:	0	0129526672	r60IbVJe0o
1272	Hoàng Minh Khoa	M	54	Vp]tpf8Sn9!&ORy2NZ%|	0	0149143573	OIEgZGXpke
1273	Vũ Tuệ Lan	F	61	:C<i=QDm	0	0353014443	an3YiZWgXi
1274	Đỗ Khánh Thư	F	31	<+ncV&{W(Sc}lSg(pl}	0	0118713305	xMjnAJN0kH
1275	Lý Gia Phúc	M	38	Z?9)c09I9^(oVZ,	0	0505411769	Mah1VDKBpx
1276	Hoàng Thu Thư	F	64	|&#aI05b,Dr|q<2iTrm	0	0820853364	zknFIFZCTE
1277	Vũ Anh Huy	M	38	FI=}Z#VGFKB	0	0973143631	librtpIXIH
1278	Đặng Quang Phúc	M	59	Us3%y_)7@T/=60x3Bgqf	0	0630648446	hZoxBGcWGI
1279	Vũ Quang Huy	M	62	#ie%!#edKu#sv9@@?	0	0359831754	vS1DEickHp
1280	Hoàng Quang Huy	M	19	E%BSOPUr1?	0	0890215718	bYFGrxg5yE
1281	Lý Tuệ Lan	F	29	pU+]Ii1(wcDu|2	0	0831244860	c5j4SGW7xq
1282	Hoàng Thùy Chi	F	22	=G}6=Yq/X?mD	0	0285043023	QWuqBqvdwK
1283	Trần Gia Phúc	M	38	}>NM}:0b	0	0241467876	hZFn2I0JYA
1284	Nguyễn Thùy Như	F	59	%2$^d51n#J.#G.EV	0	0941119823	e9MucEWD2N
1285	Huỳnh An Linh	F	37	&qg=hz?Vq@jA(-	0	0661585644	sPiItaPajS
1286	Lý Minh Minh	M	62	>r4zqJ7o<]}r*1T	0	0940548429	HIo3VEmTON
1287	Vũ Thùy Chi	F	37	YABOdLGRhmIC{	0	0570784336	ZW5tR0BR46
1288	Ngô Thu Lan	F	52	-;BF0huyN	0	0150206088	RfvuJqhCQ5
1289	Bùi Thị Linh	F	25	(%BW@=t|/w^.juF^g	0	0845377130	BTuOPbA0Rz
1290	Hồ Thiên Minh	M	54	>0bAv--t+;m1Yvv	0	0837690609	cqf6ZsxirL
1291	Huỳnh Bích Thư	F	50	R2E1.Y:yEG2	0	0963226311	wZg2IWpret
1292	Huỳnh An Lan	F	21	_GNZH&wJ	0	0942282250	klWX8Jjkbt
1293	Huỳnh Anh Minh	M	38	2b/YQ[&8Z|V-a)j.?7j>	0	0650199900	MTHAT4jZyo
1294	Vũ Tuệ Chi	F	38	Zc3[kdPs4o+	0	0266552569	KaSFmkvxWw
1295	Phạm Minh Khoa	M	59	K]?h.=Nig3;D>vv	0	0943534428	gSeYTRTUwi
1296	Trần Thị Chi	F	47	+%a8/o(8]hgnabdE5t	0	0513238330	7adhcRDu1l
1297	Phạm Anh Bảo	M	22	7]{c46&6*6w@]Bfy)buH	0	0751939354	pAuwgDlJdY
1298	Hoàng Thu Nguyệt	F	64	Us$yV,3BHlph2V:f_%F	0	0162817341	EFGJYQIiD7
1299	Võ Thu Như	F	46	?M,9[_e68bjD	0	0201474745	99cDUD72ih
1300	Lý An Chi	F	30	V}Dx9;lm0]RqpD	0	0138531336	JxWNXuWkxE
1301	Lý Quang Minh	M	53	6,o;}UPQ#PdpA./%L	0	0418068408	a87EcXrryB
1302	Trần Thùy Nguyệt	F	50	o>uIQ1[]8%|Kxb-J*	0	0437108661	sALPTi97Ff
1303	Phạm Gia Khoa	M	44	(Wp]M8=q@	0	0297172162	L0YJ7PZw8R
1304	Võ Bích Lan	F	58	_!r%-CKrb$Kk.	0	0774278720	3H5Q6cuwNN
1305	Đỗ Anh Khoa	M	22	>7To%(mZgmX7o/G4j]	0	0709378725	vkjtidsDod
1306	Hồ Tuệ Linh	F	59	sLGYm|3EZG^7LM%IP	0	0306039413	qp53tHlj9p
1307	Phan Thiên Huy	M	55	MfE?ybAD>A?xqdrl	0	0447397942	Z7UfCRx1qs
1308	Hoàng Thị Lan	F	45	uXo{f{h}f(+h*>;LYX1A	0	0535230670	EJXTlzsp4l
1309	Đặng Thiên Khoa	M	34	>@G#$Sx:?;	0	0404672575	sJJp7b568n
1310	Lê Thùy Lan	F	20	.Xs0=**I	0	0368768259	BbdHm4Niuw
1311	Vũ Thiên Khoa	M	20	QcZBTEe)#,S]	0	0319862029	l4IYpLeedo
1312	Bùi Gia Bảo	M	61	>1Jv8au5rZya[<<+K$TJ	0	0330522734	pbnf02JsSq
1313	Đỗ Gia Khoa	M	22	5mZtdUN7KlrW,0yEpo!B	0	0337192317	zqjb5IYvqt
1314	Đỗ Anh Bảo	M	48	?(/|jVRN-Z	0	0857293881	86sPfrdrKa
1315	Ngô Minh Khang	M	24	J)&|r]{&u};	0	0462570068	QOEBc7Fvl9
1316	Ngô Thùy Nguyệt	F	40	5D@YFNMU(/6})zu	0	0988889383	UTCV9wxM9e
1317	Võ An Lan	F	39	62kh2vxu&N.FwMTg	0	0761702221	ZRddMv3Crv
1318	Trần Tuệ Chi	F	26	c)v$*#mt(@	0	0302540214	mMuQGsRL0P
1319	Hồ Khánh Nguyệt	F	36	7D/$*E:<*#JmE&&z]mO0	0	0602018267	r4eUBIyAfI
1320	Hoàng Gia Khang	M	39	&^]w4_{0	0	0139162873	RjcbS0xe5Q
1321	Lê Quang Khang	M	32	Dl#!=r$-!52=Z(!L	0	0279320584	TzeQQTPts3
1322	Huỳnh Thu Thư	F	24	8_U0Ik/f!j!Grwht	0	0971309039	LDGFOQ026T
1323	Phan An Nguyệt	F	33	ofh%)vmX$%	0	0370936227	PLiESxvOzm
1324	Dương Gia Phúc	M	61	@G,!![k.:	0	0915429729	njxRL4gWEX
1325	Hồ Quang Minh	M	40	}/_QKI;R:n	0	0151914956	awOe3xFlyw
1326	Đỗ Quang Khoa	M	35	Xc;XWi&goV?6u	0	0999902846	du0lCaqcyF
1327	Hoàng Tuệ Chi	F	51	#RWRM?o!gV._	0	0261803729	jbYNxhby9J
1328	Dương Bích Như	F	23	|&K_SL!2LdWPDg]Enk|8	0	0995188795	p5n8V3Ryf6
1329	Nguyễn Anh Khang	M	46	HpTeDNL0:!Bet	0	0970405987	bK8DN42Nh5
1330	Huỳnh Văn Huy	M	49	ZMw+(v,%)&&86Hl_	0	0474094646	yBHy1r9JUC
1331	Đỗ Thiên Huy	M	51	K,7bD@X$?co|HgUH	0	0470663817	X2XZ3roskj
1332	Hoàng Thị Thư	F	63	9i_p-SM$,UjI=XM<6[P	0	0375603926	n5bqGgrYTe
1333	Hoàng Gia Huy	M	38	[+aC:L|}	0	0810965947	tqk8YFXJaJ
1334	Lý Thị Chi	F	31	w@;q3=}*j9;iDBm(	0	0896908007	4Oa9IGDT59
1335	Võ An Chi	F	34	Y{A&AL^&fhg	0	0970750710	JJlY4iYodq
1336	Huỳnh Thiên Huy	M	50	_L,OH-5,ZASTN#)T#yD=	0	0245968469	QChMA8zLel
1337	Vũ Thùy Thư	F	30	$x$$K#6;$pgiJ(Y	0	0265466787	q4cN81Q5As
1338	Đỗ Anh Khang	M	50	p8${V:M&?Af	0	0562963367	8JOj9A229K
1339	Lê Khánh Linh	F	56	H+w-@qet_OBsJwzKvG	0	0421097612	V4x8WtAKPM
1340	Phan Thiên Huy	M	38	Ovy%n?U,taGWi	0	0989630664	Jbiv8UtkOV
1341	Dương Minh Bảo	M	39	EM)gkg6]AdR4/FX|#P?S	0	0704331430	4OrR2XEIML
1342	Lý Quang Minh	M	50	2$M/j?B:0]/	0	0566443185	dZPGYrzjXV
1343	Vũ Gia Khoa	M	51	t&4{OxZ>g	0	0999305024	2B1gZnnyYk
1344	Hồ Thu Nguyệt	F	40	TaBfGX1/6|FX1=j	0	0651181365	hsJQRVHDc1
1345	Hoàng Tuệ Như	F	39	tGvBjeRmxp+!5@GA.	0	0858980695	sy0wxZCO3Z
1346	Huỳnh Anh Khoa	M	64	a<g]Q$Bn=?GP{6$;Lu	0	0197842917	womvmgmKSZ
1347	Lý Quang Bảo	M	36	RPSs{-@_QtYjQ##DN	0	0660355437	B79rYR1EBY
1348	Vũ Bích Lan	F	43	5:W{>I[Z63vLXDs	0	0821559920	NGd5XDEqEN
1349	Bùi Tuệ Lan	F	38	pBoI*Pku@K8?[	0	0561263089	XMh4isKkPp
1350	Lý Thị Nguyệt	F	33	,B-#Pa_Fs*	0	0596051893	3wgG9qwkxj
1351	Phan Thùy Như	F	20	[K>Pt}P/h?.32]#]1	0	0564985404	nhe8iHUnrb
1352	Dương Thiên Phúc	M	57	IOwZeL]DH	0	0314385526	vQJugSSqyT
1353	Nguyễn Bích Linh	F	26	]^/&>6>7Td8	0	0372807910	l1MloPYOaJ
1354	Hồ An Lan	F	27	eF]lbCcxt	0	0949248029	vuYWqMlj3Z
1355	Võ Văn Bảo	M	47	{)4k:,lYBI-S	0	0632181620	UFao4ggMxX
1356	Đặng Tuệ Chi	F	38	c?Y.n76:e!.)m4	0	0407099803	251HpNztk2
1357	Hoàng Văn Phúc	M	24	|.p|4>$;g@[bTyN|	0	0501325439	gJntqCUKgN
1358	Vũ Anh Huy	M	60	O^v&[vNMjRGPw+l	0	0405771423	XcA4yZQa6N
1359	Võ Quang Khoa	M	59	:j:JFy:4,	0	0160769468	nD9a11kAtJ
1360	Phạm Bích Như	F	18	F40LFO[|#7yB	0	0528395688	rzfm7i7hht
1361	Hoàng Thu Thư	F	42	5Z[{TFV(	0	0889820249	ziQU2b9Jhj
1362	Đặng Thu Thư	F	31	FvCI;KKo:	0	0557061211	hHuxIkAwnI
1363	Phạm Thùy Như	F	39	NDC|/.)KSL,}.$&[9u,%	0	0975221825	eOaLHkbkcM
1364	Nguyễn Thu Lan	F	21	]0.A0B.Mn3>J[|	0	0688916611	zqx5trzjqE
1365	Trần Văn Phúc	M	60	#p+1p)1,	0	0964836758	aSBWgrMXWE
1366	Phan Văn Khang	M	34	ETd6{vx]m	0	0341573910	D9DU2tBSNm
1367	Lê Minh Bảo	M	41	4C0/J[X0LxPy#n	0	0717122763	ighUJiSFED
1368	Hồ Thiên Khoa	M	18	O;&OvqR5]	0	0521841223	yWrQJpJ9Fu
1369	Huỳnh Bích Chi	F	47	d0Z/NP5ga@7{	0	0679447104	1vBHaD8Mzr
1370	Nguyễn An Chi	F	24	R):I[iFc+/;+>g1{n?	0	0936525142	ec5mKrSdsX
1371	Huỳnh Quang Huy	M	35	v+d&4uVloA.p.GtQ6	0	0235862892	QZGsGNl303
1372	Dương Quang Khoa	M	42	/FU$1d>?8cJ:2;<=e	0	0192071270	GemcdzJdRz
1373	Đỗ Anh Phúc	M	61	5^Hc+Fn^::}UU85[PMM	0	0111729832	tUXHkM9jut
1374	Bùi Thiên Bảo	M	33	b25P9V$OM*2Y}=%	0	0600210609	sATiRmeiMM
1375	Dương Văn Minh	M	42	6/Om5{@w9!VzWjt8B!A$	0	0910996271	W9kSqGNrVD
1376	Đỗ Thị Linh	F	52	kZ5(,fxJdAZR*D=6%*L	0	0374864652	6cbAqVGDhY
1377	Lý Gia Khang	M	55	(T+,DgHKGMA?h	0	0960755470	xTcufK0Jv9
1378	Võ Bích Linh	F	34	k$>{c5|>c$ndl	0	0653527782	QzZJNEk4QM
1379	Hồ Khánh Linh	F	34	!Aq];Su}S	0	0805830444	CREWM15VSz
1380	Đỗ Bích Linh	F	30	^U<4lt_[]2+Z|G}	0	0996722261	LN3OSr73up
1381	Bùi Gia Khoa	M	41	Wg_NZw$|)=Cc/LaSV/	0	0526075884	IDJu5fZkBC
1382	Phạm Văn Huy	M	52	Tk#%WAHc|WxH=f	0	0408848900	qHcbStDDGi
1383	Hồ Thiên Minh	M	58	pIaS/7kEh=H!^}gj	0	0904234795	JhGjv27uSG
1384	Ngô Thùy Chi	F	37	O)iGx5KHzdN#y	0	0927819872	qHBVDysI1b
1385	Vũ Gia Bảo	M	28	X/iE1O(S2I-,	0	0747935890	ctZRw4I63R
1386	Phạm Thị Thư	F	22	P9p$*;[ngl	0	0829685939	AL6gIiOggK
1387	Vũ Anh Bảo	M	27	]S@nAZ*YMJ5	0	0578083005	iZ3UHmtGQb
1388	Huỳnh Anh Khoa	M	42	T+j?m)eI	0	0959271391	s7uKVtnFBj
1389	Huỳnh Minh Phúc	M	43	kL@48?,n^7*p8o	0	0444275244	7SPMLdG7qh
1390	Đặng Anh Phúc	M	46	</9/}a0#	0	0223143233	4DEWuHWgnW
1391	Ngô Thiên Phúc	M	43	D@h$JPTB(>W3!<	0	0335116995	Ik12Otkzyc
1392	Lê Văn Bảo	M	24	u9+i<>Bf}GaLl__	0	0539760974	F8ctEOZ5JU
1393	Trần Anh Khang	M	42	/Y>>fG?t,L>Zv	0	0200604829	1dEfS8zlpb
1394	Hồ Quang Khoa	M	55	gdJtSnlvhY[RX	0	0261886609	Ub877mM5Ns
1395	Ngô Anh Khang	M	28	DP(K=T.f)7o	0	0213073094	UtN8bftU2X
1396	Hoàng Thùy Như	F	57	C%:$x{rE>9(26EvRc	0	0653896512	Dt17XKNRL6
1397	Đỗ Minh Bảo	M	49	K*pw4W|6w!<+	0	0515934459	yYKeOaRSWU
1398	Bùi Minh Minh	M	36	_i3x6m^pa#:&zacwwH	0	0605264613	0HwQZlUD9w
1399	Dương An Chi	F	33	5,vP!5hbH@!IDt5qn	0	0121927616	2eSRTLmql7
1400	Hoàng An Như	F	46	RD-84&T#C	0	0824088205	Q3eqFGARUi
1401	Phan Thùy Thư	F	31	@9&PW6;<#{@)Z8d5>$^	0	0883071644	tdvLovCfzB
1402	Phan Khánh Như	F	46	)?ox>|+I	0	0261364844	tvkPK2pTlg
1403	Vũ Văn Minh	M	64	EBZ#57YBjoyc1	0	0658475596	wxFfZqL3qm
1404	Đỗ Thùy Chi	F	23	p{uc%>c|1S]ov&.&z@	0	0991517816	fkrXaQcKIM
1405	Bùi Bích Chi	F	65	/FtqGiWJ{hEfX98k	0	0529375182	RNdtbeqZ4e
1406	Nguyễn Thùy Thư	F	18	<mNx:rJ37}*Du@	0	0603763006	Gi97U7m7Fg
1407	Bùi An Nguyệt	F	23	F;slIHJaP<1$0r0@uv	0	0115297901	c4vAluSJoU
1408	Huỳnh Thị Chi	F	56	P2ePFf6xcECMN]noC])F	0	0634991508	EzpeDethN7
1409	Võ Thiên Phúc	M	22	w{VY3ji$BnYVIRT^)o2	0	0338398370	B3ZR71pfnk
1410	Ngô Gia Phúc	M	65	#p;sm|fTK0f%2PW05zHj	0	0599571712	uS3sWPFGAN
1411	Huỳnh Văn Bảo	M	44	IjYB:_a6<<zhF]|^	0	0715340648	veiY1xsz28
1412	Nguyễn Gia Minh	M	38	$3VRp-p]Y<Fpst5K!0U	0	0319440533	vQibqpt9n5
1413	Trần Anh Khang	M	28	@F0>}A|%AG	0	0616534769	0KlJYqEw0u
1414	Phạm Bích Chi	F	47	9Jv[}4@--	0	0596261909	Svp73mFa7K
1415	Huỳnh Thùy Linh	F	22	7+;X&{&S;%XQJuYJ	0	0179450522	rDemQ7AUsb
1416	Trần Khánh Thư	F	24	ix[@nW=!L,c5Xu	0	0665343207	tJRJl6UeFq
1417	Hoàng An Linh	F	30	=}=L:{VW]YFISmgro	0	0334370511	ZNz6z5eNVL
1418	Hoàng Minh Khoa	M	41	tR|&]UK)>#?=	0	0408152187	dF5pmq1UE9
1419	Lê Gia Minh	M	63	2aF--jlY1f]hO*<8ID	0	0405585859	oyg0pmhkJi
1420	Phan Thùy Lan	F	21	GG<cvUTRU_j[g0	0	0943416499	enUhBTKI3K
1421	Lý Anh Minh	M	30	O;W)dt)u_#FxFN?a8	0	0164900637	4BROFSOMES
1422	Hồ Minh Khoa	M	28	3J!ihNzcP	0	0485235318	Zy8Zf5LO92
1423	Hoàng Tuệ Thư	F	24	wj4a#@_T_}WA	0	0945078794	7cokGNFRov
1424	Bùi Thiên Huy	M	45	!9D8eN:E:V{a:>@	0	0662868302	F8DxixMluN
1425	Phan Khánh Như	F	48	b(9KyeMe%pa*	0	0932127698	3Hak1f7Nfz
1426	Lý Bích Như	F	50	_2+UI*F9zX;kvN,	0	0419126729	a4lViXiSK5
1427	Phan Minh Minh	M	30	Tc)!&z-MAANbLyYXV&	0	0175847417	e0FS0ruTwr
1428	Vũ Minh Khang	M	51	*l[T&}.XefQEFl:T	0	0943870518	Awndgtn3xd
1429	Dương Khánh Như	F	26	M9&MQ,yt;.	0	0975374881	J8lyYcYKue
1430	Trần Thiên Bảo	M	29	aAeq,KA_9W.t&_}+Z	0	0801044342	7H2MwALWSE
1431	Lý Thị Linh	F	22	B2?XR.c3#Zi=W?O	0	0906778166	0AQ9ryDr8A
1432	Huỳnh Minh Minh	M	52	|{1<kQ?+A1$f@}J	0	0332835452	d8TJPyalDP
1433	Võ Minh Minh	M	60	6)V87^>u	0	0637365882	9drqeBF5uV
1434	Lê Anh Minh	M	22	+>&o-F0]vr;8C*	0	0448076818	bcqlo9Da9F
1435	Huỳnh Minh Phúc	M	63	[i3O6>Q0]Haaw	0	0618471839	8vfX9ozWGm
1436	Lê Bích Thư	F	60	w[<XeNR2i	0	0972767895	rLG4e3AktT
1437	Hồ Quang Khang	M	33	K<j}@/l#LK{9Sp	0	0133285754	ixigh11onv
1438	Lê Minh Khoa	M	60	[w/Lh1Qq^Zq:n<=$X|y	0	0829229333	WZH434C0wk
1439	Lê Thùy Như	F	47	hbvBx)su+)(<	0	0882016669	WTUjzJtPKk
1440	Hoàng An Thư	F	30	IZjW4T}#	0	0176790560	nKSnXpFaZl
1441	Vũ Văn Bảo	M	59	$7BQz?*/e9C;kDA#=	0	0209536167	fWTUmyGqXy
1442	Ngô Văn Minh	M	54	-m3e^w,p_{HDK94*z#(u	0	0191282412	qGRd43E4SC
1443	Huỳnh An Linh	F	57	(/1PkWD+<	0	0326774008	ao916BRQQS
1444	Đặng Quang Huy	M	57	a+H*6lAFGK^4G$H2	0	0298335407	OyAEgasrxt
1445	Vũ Gia Bảo	M	51	*xi?>ql-	0	0299547267	yu3jJVxxRf
1446	Ngô Quang Khoa	M	62	1EtS+}Bnot	0	0319870160	BycjMwwyQ5
1447	Ngô Quang Bảo	M	46	y4+(|[1/%cN%	0	0911795191	hyvgH0cqCh
1448	Vũ Minh Minh	M	35	rXLYfe0qo+pDL/45zj*r	0	0464957528	ht2pm5KVSe
1449	Hồ Gia Khoa	M	31	>Rzd7v/Sv:{-h	0	0557904910	We0DnNNok6
1450	Phạm Thùy Chi	F	18	s3#UAa!!y8e;F	0	0517132858	UyHkN4Jw6F
1451	Trần Quang Huy	M	33	]L_[kideJ_D	0	0999988423	GbuTvKxoqS
1452	Võ Thu Lan	F	35	Z|&S)-}sIHfzys-F	0	0143690394	OnWmQumPzw
1453	Võ Thiên Phúc	M	53	z!+3o_d*RVx-|/)KbO	0	0761008331	RqUmnUgLOI
1454	Đặng Thiên Khoa	M	21	kPwXyhF[l	0	0356636146	xUwAuSoejS
1455	Phạm Khánh Thư	F	60	cOM;],aLA	0	0942229098	eHjDJQko3j
1456	Vũ Thị Thư	F	45	u]l/fi/K!;J8	0	0739863324	3BeoqYIhdB
1457	Ngô Khánh Linh	F	45	r#1qc7<z(L60;(%w	0	0540567663	fobm7N3psk
1458	Ngô Thu Nguyệt	F	55	{XOby^<L/o}C	0	0777772199	FwIGtfYZS4
1459	Dương Văn Minh	M	27	4r+q]{N23$5iT	0	0474849620	cVikIUQdew
1460	Lê Thiên Phúc	M	49	cuZP{A4htm;r@bDY@ZdK	0	0995041261	eXGHBaPhZu
1461	Bùi Quang Minh	M	23	<ic,nA*^Exlzlbf_v+	0	0738374600	3sAreak4Nw
1462	Huỳnh Thiên Khoa	M	35	fAIYv]q!2=	0	0286150259	1w7PZrE6z1
1463	Phạm Minh Bảo	M	36	?#>&j6@,l-!	0	0145262204	OMYqYyPZyP
1464	Hoàng Khánh Linh	F	22	3hNX>QO{Z<Oh	0	0418304487	JNBceIO8HB
1465	Đặng Thu Linh	F	25	-MT@-0J[nP}E?7N@S	0	0405707029	YLF6qPKxCw
1466	Bùi Quang Huy	M	32	UUs#KT3(6Do)G-	0	0962298410	62mBclj8xs
1467	Vũ Thu Chi	F	58	pd9x/^=?rfGw&,Y	0	0416014439	THypkIOUFz
1468	Phạm Quang Bảo	M	47	;I|6N3;w(e	0	0165875821	zmU6S2wy7a
1469	Lê Anh Phúc	M	29	L]/Ma)c|POzD[eb	0	0345866007	34B0t7xMsR
1470	Đặng Thiên Minh	M	43	+5Q!=<uu	0	0884375302	fXHx0nIzJt
1471	Huỳnh Khánh Thư	F	57	S%rIfreiTx8J,>/	0	0160854453	v6hlPCW1wF
1472	Hoàng Thiên Khang	M	60	!N4nEve]Kk}2+;u	0	0475870837	ZodBLLlDEc
1473	Ngô Quang Minh	M	64	kz(y2L[*3s=q^2cPJ	0	0440304472	SwhlPz7xmG
1474	Huỳnh Tuệ Chi	F	23	LA{/#mRNB,,	0	0647770888	ZmXFKtMFV8
1475	Lê Thị Chi	F	31	uKQK*^vB}PGqN8i;j#q	0	0934245246	mCvGMj19zG
1476	Dương Minh Khang	M	35	^k<}o-Um[X,kW%>a	0	0850806443	rrrnUm6SGb
1477	Đỗ Anh Phúc	M	58	5}tXU:{F*	0	0803393013	qBHZg1OUN9
1478	Phan Quang Phúc	M	57	i^q4{%5.}+@.^gIQ#.f	0	0681275996	bFZybGYwLi
1479	Dương Văn Bảo	M	62	vsB*(>DQs<:9=2d7MB2_	0	0444934684	dkCi4HiVqU
1480	Vũ An Linh	F	43	%bjb}TD(D#oLC	0	0812238996	OWN1rb4A4B
1481	Lê Thùy Nguyệt	F	22	Z*<5uRbE{bQ	0	0903936222	EO8KaW1P4t
1482	Lý Bích Như	F	40	Pp5LF5H%U	0	0849499009	TPSsrW8Ywi
1483	Nguyễn Tuệ Chi	F	24	T=ec*@uiVnSw3NH1	0	0631411354	AA7IRPEe2u
1484	Dương Thùy Linh	F	25	!>84Z5%Qm:;	0	0336446903	QKsTYefD6P
1485	Phan Văn Khang	M	34	jeG)0;.w	0	0251076105	J7z0e8UAp2
1486	Võ Thị Chi	F	30	f+7w^nF88f:c7=	0	0216483588	KUzIr2Z2xc
1487	Lý Khánh Nguyệt	F	48	yh.KPzdn$wd[rxPhv	0	0353780984	Szfakm2teZ
1488	Hồ Gia Huy	M	41	Gmk8F:>tf%a(Fg+	0	0678510532	SmN2kPXHbe
1489	Bùi Thu Chi	F	27	Oz$M,X^p	0	0495674973	a6NuOzZ7kX
1490	Phạm Minh Minh	M	64	vo;k|.a>t#^	0	0330471450	4nNtrrQ6gK
1491	Hoàng An Lan	F	58	xHfV&6VNLIPI.	0	0207378903	SIdlwiXRTT
1492	Lê Gia Phúc	M	64	@75vU%Kghr=&9	0	0859553438	IMa5Ia1eoa
1493	Trần Tuệ Thư	F	51	>=+RZc54_	0	0133844940	NXrO726IFK
1494	Hoàng Thu Nguyệt	F	35	?+%i@?pb,i?2Ds	0	0754475359	LIgA5YlgJd
1495	Lê Thùy Nguyệt	F	38	{0|iscYv<aT.}eh	0	0722648742	WKBfeulwkk
1496	Phạm An Lan	F	33	;&Twe(%|:!2Nd!*V/	0	0857077551	6HZB5Kah3k
1497	Phan Thiên Khoa	M	27	$3S=xt+f:<YI@N.(X	0	0419000454	JImC5J4sit
1498	Ngô Thị Chi	F	56	G0=T8wc>v@PyPw	0	0154110812	0dqhrJ1Lqh
1499	Hồ Khánh Linh	F	46	I(+!c90A-Di:RP-/LGmv	0	0862909120	jrS4aKL8iz
1500	Ngô Minh Khoa	M	25	1luk!q}>}b=h/9v[c9O	0	0601573072	QTiduX2b5r
1501	Huỳnh Anh Huy	M	18	}^/6Hsq3e=K!jTc	0	0657049422	DY7vsk5UNJ
1502	Nguyễn Thùy Lan	F	53	C?-yBE8jU8k	0	0547429895	fZte2NOiEP
1503	Lê Tuệ Linh	F	44	Bp)0n|nx	0	0750544767	ExtPfeOGqr
1504	Hồ Thiên Minh	M	41	Qh%wQ-kq7^	0	0603562902	3cs9aVBZ9A
1505	Nguyễn Thùy Nguyệt	F	30	R>(5$S]p[fu[=	0	0440133823	jpfOTUSNr6
1506	Huỳnh Văn Khoa	M	21	@I{1I8-+{WJ2l?j	0	0128373246	VCPBgJMYdj
1507	Phan Anh Bảo	M	49	,?$X4c@TL	0	0312756878	eY4mdApaDK
1508	Bùi Khánh Chi	F	20	e61]CgM|wX&rdr-	0	0927169149	AiH2awri8e
1509	Phan Văn Bảo	M	61	$(>l]qD#Gk:O	0	0177810967	s0zUUQu7ZU
1510	Vũ Anh Huy	M	25	Q,bXDk}!/V+U:-5>-	0	0422597390	PQTfQIy3gb
1511	Hồ Thiên Bảo	M	43	XGu=#6GpAR	0	0615354810	pk7tmT9epg
1512	Huỳnh Văn Khang	M	42	UJNo(3d[op,NERri2M[y	0	0521105082	Gh8vgCSISK
1513	Ngô Gia Bảo	M	44	[m#%=vX#9L:n;	0	0802162803	UUS89rk6m7
1514	Phạm Thùy Nguyệt	F	41	w0,Ud:z^;J%m,#:	0	0502835154	JByiiGKTNq
1515	Trần Thu Như	F	60	wm<A@ELr+@dWuL	0	0895488566	B0rmZyIvoD
1516	Hồ Quang Huy	M	38	n3q[C(#>jv#EI	0	0502400321	RbrCrt5wZW
1517	Huỳnh Thị Lan	F	42	i]<,(Ouvr!*(uir&i:YR	0	0971327847	gFhTW6Mdjg
1518	Phan Thiên Bảo	M	50	@K*bpWK$,0UXWtY1W5f	0	0704358532	xTIPiyXppA
1519	Bùi Văn Khoa	M	54	Ka/h$FD[&3Cf	0	0775073924	39g7e1nMJ2
1520	Dương Thu Như	F	24	Y=B;:{(9otaO..^	0	0741258537	3Ir8VTyIHO
1521	Đặng Thùy Như	F	60	fZIQl,^2):I	0	0953268977	UnKWCiSSbb
1522	Huỳnh Minh Phúc	M	47	*eNpF&7j.Z	0	0406680413	gRCnvg33T1
1523	Võ Thiên Bảo	M	54	(ED0J#UI8,<:#r)	0	0291847281	zB9sHPmFBv
1524	Võ Gia Minh	M	59	:Kye>N9,>Sl_lM	0	0831531327	lfx3oGQFYd
1525	Vũ Thị Lan	F	26	$V)&CZQ*=!S1p}C=K8{[	0	0822598733	SFF1u0cExy
1526	Lê Minh Khang	M	34	=P(fVFy#	0	0228048890	B28QVWzxvp
1527	Trần Thùy Chi	F	28	r-Ay}!VW}O(0VXv	0	0442839615	8CEBXoiQtf
1528	Vũ Thiên Khoa	M	30	c3dY97v@4D+?E	0	0426875483	sVEFw6BC0o
1529	Nguyễn Văn Minh	M	42	d^*z<+ro|=mX	0	0244276473	N7r9BAFfIa
1530	Lý Gia Phúc	M	30	E](aCqW?)]!!(r8	0	0243367355	LmyavEIHwq
1531	Lê Thùy Nguyệt	F	22	aD_Xai@8|.P]6[kv5sP	0	0643823779	O3CXA9UK0Q
1532	Đặng Văn Bảo	M	50	Ql<ef)8C73z^	0	0691406266	3NNOESrr0o
1533	Trần Thiên Phúc	M	56	)@$1dBc]1##E(;E	0	0852085678	EfmKj84g4m
1534	Bùi Thùy Lan	F	24	(dIIdR;.(B	0	0109863740	u5dvx8qbro
1535	Phạm Văn Minh	M	52	_j!oYE<m?Z3ZE<oah	0	0155053344	pSVVwT28Gf
1536	Hoàng Tuệ Lan	F	45	ItphkD-%Egyk_k,Y	0	0919602803	oFgZctFhBh
1537	Lý Gia Khoa	M	64	JW&y<YYZFR!j	0	0514531277	24nseKJDzF
1538	Đặng Thị Chi	F	41	ui)WgXJgg#Un.	0	0187358263	cJXe1sCsc1
1539	Lý Thị Nguyệt	F	65	U_niyBFf|{^%[XB	0	0282730041	JDzP2gglS8
1540	Hồ Anh Khoa	M	49	LSAu*?@e:j?L-	0	0512390095	Aw9ypBxTZL
1541	Đặng Tuệ Thư	F	29	nEZAZ_}G	0	0948269543	65zlGezNFR
1542	Nguyễn Khánh Chi	F	55	4^6J+<@g}IT]!!/s[a	0	0170830127	bShDIQ2iJy
1543	Hoàng Tuệ Nguyệt	F	25	P$4G+cRyUB}V	0	0219548919	ozh16qC8Yg
1544	Phạm Quang Huy	M	59	;eV0-pbrlS!2MyI<S+/	0	0649089339	jehvjjbmCj
1545	Đặng Thu Như	F	38	{ERy?|@:#mZ*X/V4<Y	0	0282134752	e03cvnYdo2
1546	Dương Bích Như	F	27	;K,W>?:XJ0wv(H	0	0443199108	uZXgSalhPK
1547	Trần Quang Phúc	M	56	UQM|(g*a	0	0475894256	tJ2rCAlOru
1548	Phạm Bích Nguyệt	F	43	hsD5#Sd+|&z	0	0243416035	KGnknMOquJ
1549	Phan Tuệ Lan	F	35	Y.Bm1<{Cy)3%+<2Nc;	0	0795446079	RV9CMTBHZV
1550	Võ Thu Nguyệt	F	59	_-lH:zw$RMk@&YP	0	0726079235	jlci33tmCx
1551	Lê Minh Phúc	M	48	]6i@_u3kopQ	0	0997556863	XJ8dMYHxhg
1552	Lý Gia Minh	M	31	*dFvJeyo	0	0662567120	8f0mnM7xGT
1553	Võ Minh Huy	M	31	FT97A@]z<^#i,LD	0	0430433347	u20kV0v4bH
1554	Trần Anh Phúc	M	59	k%KIe:p=Th	0	0579967372	Vpi4NSCLo9
1555	Nguyễn An Lan	F	56	mG-pjYPtZ{!%<5Q	0	0962086117	C03TIC34A8
1556	Đỗ Văn Phúc	M	22	HJJd$fD,>L]	0	0118610496	oyl9aJ47sC
1557	Hoàng Thùy Như	F	28	YQqPfI,^ob-	0	0510766625	cm5q5tZFPC
1558	Đặng Minh Khoa	M	51	l9NH[Y9F^Vha;692|	0	0135889102	5HwhthT4SQ
1559	Đỗ Thu Như	F	24	[Gz-pF[/<sHKA	0	0431572055	ByL0tmwNCw
1560	Ngô Thùy Như	F	41	>N%dX]yrR}tvA2	0	0428430862	ep2hCk4lzR
1561	Phan Anh Khoa	M	18	>OY8LYlA{#+.	0	0910686747	rDgWLGrfkb
1562	Đỗ Quang Bảo	M	61	Fh,tN&4%q	0	0285578791	nkKgEn9VRx
1563	Huỳnh Anh Phúc	M	47	8]T=|B_Hk7D	0	0561437679	AQQdr0qkZq
1564	Hồ Gia Khang	M	27	s$)$&I8Fz4,	0	0876155826	OYURILbcXH
1565	Ngô Thị Lan	F	53	ElU).jKD%t%%ks!+	0	0328071842	FOcJ0hM0m7
1566	Đỗ Thùy Linh	F	57	O)dK]kY&	0	0338154621	ZS6pr41Sfo
1567	Hoàng Quang Bảo	M	65	/DzZ>OFd{;v1j:0!	0	0662531952	nvvrGIEpkU
1568	Phạm Văn Khang	M	59	bBxZ2D[]%U#]|@	0	0335557303	bkUx1PzdES
1569	Phạm Thị Thư	F	63	uUE%B*yY#l,	0	0258895867	lsT0h8sDiM
1570	Ngô Khánh Chi	F	39	efFw^/?b(	0	0423400804	ky9gcmvZFd
1571	Hồ Tuệ Như	F	51	HtMA0^_2ZN=!-HW	0	0733745079	7cimMZJxnW
1572	Phạm Thùy Như	F	37	E^fsN,U?JF%Jn/tQ	0	0607273866	9cqoYDKpcM
1573	Phạm Thiên Phúc	M	22	BIWd^(>0D	0	0723829581	9tpBm6Goak
1574	Phạm Văn Minh	M	18	Q>)21-/&%Bv>R{.	0	0330915358	YrekFINKeR
1575	Phạm Văn Minh	M	38	}SKk;SL@c16Q6,eY	0	0927273281	xDcpqQueDc
1576	Lý Bích Linh	F	35	FQI,pX,f[]@SF	0	0819407753	qYx1j1iFOr
1577	Đỗ Văn Minh	M	26	N?,p}$%*BXv5/m	0	0466166501	M6l3g1eNEk
1578	Dương Gia Phúc	M	53	vT%Rm=!Y2!_iu	0	0612422960	57cNIuAqKf
1579	Hoàng Thu Chi	F	21	UK#z|pd$wf|>>*pYX.&	0	0494463049	06Ul5UWNnh
1580	Đỗ Thiên Khang	M	53	mw@}&m@Nz.}s;#[_&sjg	0	0696542959	UlBn420aFE
1581	Đỗ Anh Khang	M	34	LLwH<nw/J	0	0544779261	W0KIk5Kak2
1582	Đỗ Tuệ Thư	F	64	v2{;?3KnXk	0	0464150049	I3d3FY5tAv
1583	Huỳnh Thị Nguyệt	F	50	t6dM}s}v$78PIc^vQ[&	0	0230369375	sjSyI2xs3x
1584	Hoàng Gia Minh	M	61	NsEcO>=2(6e	0	0951448708	Eq0HQnzBg5
1585	Đặng Gia Khoa	M	61	g{7U!]q3n*hF[_r]vSK	0	0362733030	9CMPhY7Vpo
1586	Hoàng Thiên Huy	M	27	5m1)jUz>.B{Q^WP0l	0	0568186170	HgeQuYYllk
1587	Trần Khánh Như	F	56	[?Gz*PS@X[lq0,Y$W	0	0596300160	54xMJi1f8h
1588	Nguyễn Văn Khang	M	53	M#qZmVJy$?.h$M$p	0	0928656069	bMeEa3O4HW
1589	Trần Minh Huy	M	23	67}:d?4kN+0ugSa,	0	0233928880	11azQh1lji
1590	Ngô Tuệ Linh	F	46	{TN$b$c(!{	0	0645585739	vygzkBxfvk
1591	Lý Bích Linh	F	38	V*2K>^#=)-(l3JM/	0	0233182780	8Rb2eNTqEM
1592	Nguyễn Thiên Khang	M	51	15&Uv#X(%%beSD|IM#IB	0	0659773909	vivSGukpMb
1593	Hoàng Thị Như	F	38	qK[Ln)]7B	0	0905623184	MAhIHWxAgi
1594	Nguyễn Bích Thư	F	43	=K?0o@xJhhH&1Rd4<c4+	0	0208063170	3wVGCdbwvf
1595	Hồ Văn Khoa	M	28	=C9J_:cd^1O[	0	0376342258	1eY8FvoTGn
1596	Nguyễn Thu Lan	F	34	_:tVIPj^06r	0	0859462058	yna2wdUNAr
1597	Lý Bích Nguyệt	F	60	?*<%7=L:qicQsA	0	0179861434	9ss4fcNtUz
1598	Đặng Anh Bảo	M	29	e:/{]|Km]ZdN	0	0586901184	yMCJ1veMDC
1599	Phạm An Nguyệt	F	20	i2VbDSZ:Hv	0	0489288702	tfGakWRE4R
1600	Trần Anh Khoa	M	47	>.Myeod<3!+s	0	0855751131	r1DequPYnb
1601	Võ Văn Minh	M	27	+=jj=|jk>A0	0	0456087886	eUKtDB5BOx
1602	Huỳnh Gia Phúc	M	45	*BOD.6.O9e=i6[	0	0127188078	UFcP3MxQs3
1603	Lê Thị Lan	F	31	i*k(+pxMiKw	0	0375515142	m5DEpfr7y5
1604	Huỳnh An Thư	F	34	&;JMoA$&&	0	0564907483	bVEd77rOJF
1605	Trần Văn Minh	M	45	w?r=6kWr0?ZJqZ@<3	0	0475686325	0DQ7aoEjxa
1606	Dương Quang Phúc	M	63	*h]CH)[c,x3,c$	0	0593150343	Mh8mzcrozM
1607	Dương Bích Thư	F	53	+I2wg&?,oH+!	0	0195672786	x8tDKLf9fM
1608	Phạm Anh Khoa	M	18	E:*$mZ|=^qa	0	0273131948	23Yr352MIs
1609	Lý Anh Khang	M	32	BD*2w{$w	0	0196763442	3vzEVNG9JF
1610	Vũ An Như	F	63	-pg#$%U915%OEu1G-2p	0	0118768756	DAk4sRP5Zu
1611	Đỗ Gia Khoa	M	28	!Kb6M1+w	0	0290535668	Ew572vo19n
1612	Dương Thị Chi	F	30	{0++#0_9a*	0	0944579889	MLBUfej44p
1613	Võ Thiên Khoa	M	57	Syjd{],y	0	0618642858	HzybeqOZtD
1614	Phạm Minh Khang	M	31	YMs}EppFa{yn/!z,	0	0968959278	loEKqdBdL5
1615	Hoàng Thị Thư	F	29	NmYZKN5>-_%_:})3L	0	0586943615	CaBcqIW8Dy
1616	Hồ Minh Huy	M	24	@-e=f^)G*j:2t+	0	0493598875	1giOdemuu4
1617	Bùi Gia Minh	M	26	D+_X9K]l	0	0390321565	A8uSpecOsg
1618	Dương Gia Khang	M	49	:<YX<H%3]:VrX22&)*	0	0826600979	5vTTgTJQ03
1619	Nguyễn Bích Như	F	63	0XeJX*NI	0	0324808082	bLTXYR3wxo
1620	Ngô Minh Khang	M	41	$JpqV]fPjl>H4@&&p}	0	0347348910	k2cGYIzFpy
1621	Lý Bích Chi	F	20	RW^k9CpL?%	0	0867894114	MMNOhfQcLr
1622	Lê Quang Huy	M	61	#=d6<cxU	0	0646817626	N10LpCT5Kn
1623	Vũ Gia Phúc	M	53	7c|0yv+&i?_>xy9	0	0759196278	mIZKvs6Iy1
1624	Lê Khánh Linh	F	20	*}!m%Lnaz>Ehk=<	0	0161499454	jtf9q6mAvB
1625	Đặng Thùy Chi	F	24	:M[49X?[J$3|ow	0	0815200251	l7To4T1vj6
1626	Vũ Minh Khoa	M	58	S^b{Tl:Un{-	0	0596414404	IAvrcq89GR
1627	Vũ An Chi	F	58	.+:yI9<;Ix-!Zb+qz)	0	0878281167	sYqS9U1hRA
1628	Hồ Minh Minh	M	22	#3B1$xO-#	0	0429536696	NnNjE63PgS
1629	Hoàng Thu Thư	F	29	XB5#-j^W+kj3r	0	0349313105	g6IhyheSJB
1630	Bùi Thu Thư	F	41	L^-OPTjf}#P>bR#,6e	0	0805910598	YgKN2iaUsE
1631	Lý Thiên Khang	M	27	LTVxoUOb25#0@.V;	0	0404153679	On2SjVSbdK
1632	Huỳnh Minh Huy	M	20	;0ee{]EN;5ig	0	0140193275	iDqM8Xs7iQ
1633	Lê Thiên Phúc	M	63	ML&%xjHg_9{,?r.gJE	0	0805083767	Wf4DUD8OLz
1634	Đỗ An Linh	F	20	-4{e)$St=f2V.2(ked	0	0193677177	i7cNFdaNEi
1635	Nguyễn Tuệ Lan	F	21	*$3|76}#On>m7K{	0	0131345712	6mxmbk55De
1636	Đỗ Minh Khoa	M	61	i+C8;bH;fP&QF	0	0283851191	CUXxX5somT
1637	Bùi Bích Linh	F	45	f(kcvuU$r}CC!m<$2	0	0358897741	14SzKcqXEm
1638	Nguyễn Minh Phúc	M	47	Ld=B!E*7Ko2[;	0	0348435426	IrK2lEQHK3
1639	Ngô Thu Lan	F	36	vP<&%sMefh#ON;ac0u^o	0	0672823714	wbp0R4OZBN
1640	Phan Minh Khoa	M	63	;)>6gBW9=	0	0838625987	Sn6lCdwMtS
1641	Hồ Minh Minh	M	19	*bcy9?CF1	0	0820553311	Dx4A58SMsf
1642	Lê Văn Bảo	M	59	=)YJ)4_E$:-kX0Mw_/1D	0	0339817245	6TTIpEwpbU
1643	Võ Thiên Khoa	M	64	{[I]7A,j[	0	0467440436	e9sMaviSWv
1644	Nguyễn Bích Nguyệt	F	30	[,|[<#(yvcmSm]@rH	0	0427420494	j6rnvT47xk
1645	Nguyễn Tuệ Chi	F	37	+kS-&!/T$	0	0148530270	N9TDVlorqL
1646	Vũ Bích Nguyệt	F	35	>as8|vlH(]	0	0841702545	TVA6W0yuGk
1647	Trần Văn Khang	M	26	!7&J[^k%G	0	0710343418	rfaF9meAPD
1648	Lý An Nguyệt	F	31	#g[@}$pyz	0	0816710004	OK2rzoI3Ic
1649	Phan Thu Như	F	46	6>2:K*J9(uK(}i}{S	0	0692004654	FWmOmuPz4j
1650	Trần Bích Lan	F	18	2rf*mv8=O).JDd8!J	0	0581705003	WXLhls1Wrh
1651	Vũ Khánh Linh	F	22	FF*M0VT[AQ|,LIn	0	0218189174	9J2c7TNXTG
1652	Phan An Lan	F	26	;<)t&T>k0	0	0382221428	FUiPCKTLTG
1653	Bùi Tuệ Nguyệt	F	54	#K/8ck80FgDpNq	0	0420621131	xhltZUCN6H
1654	Hoàng Minh Khoa	M	42	oRjEPh.>9=.O_m	0	0553929714	8wDEuxHXlw
1655	Hồ Văn Bảo	M	51	[#eXJOCA!KAAa_6_	0	0774296037	d5kixQjGVz
1656	Nguyễn Gia Bảo	M	45	}Y5*mYDY:BVd_13qc@	0	0563386851	IljrJsab9G
1657	Phan An Chi	F	47	RCS&A9a*(N}04XA+m?Lj	0	0868957709	lYLvJaDZbb
1658	Lê Anh Phúc	M	61	=[Bn<6fB.m:jO#yLSk*	0	0996477333	VwcULniQJN
1659	Hồ Thị Chi	F	58	Ex4+c&Qu{5s=5q	0	0155525972	nQ3ThJODgR
1660	Đặng Quang Huy	M	55	$s;I@2PN-SYH	0	0178261480	wrLNq2SoSR
1661	Trần Thiên Khoa	M	26	vY3><syg{t>_	0	0309891781	Kc9loSVuWZ
1662	Vũ Gia Minh	M	58	JD4<0v[B,W>xQS	0	0317036979	jIivM6fKe8
1663	Đỗ Quang Minh	M	52	W<,hn^CQyVyQF;bOz-XX	0	0647275491	8R1K446HHO
1664	Vũ Quang Huy	M	29	qL)r}S*[%K>)ek7(r:W(	0	0176078675	vgIH873cOY
1665	Vũ Minh Bảo	M	25	T>pbBV+YEl.WNV-	0	0202221533	lmHLAbHP9Q
1666	Nguyễn Gia Minh	M	47	{z,:fJ-;NUn*#	0	0356306480	HcdCVekq2V
1667	Huỳnh Thị Thư	F	27	Km=HKyj3n^/;6C:)(^	0	0200408258	FvqXE024aq
1668	Nguyễn Tuệ Linh	F	39	xB5*-bQkF!H|	0	0597655670	rPuDY0NCuT
1669	Hoàng An Như	F	55	3Nv$*v0-eAer	0	0927087455	j6f98zDccF
1670	Bùi Thùy Lan	F	30	h.WkPD}/E*b	0	0239266816	BQsjieBvsh
1671	Dương Văn Huy	M	39	|.{Jcn|!^?8	0	0272527312	h68OPL7f08
1672	Huỳnh Anh Khoa	M	30	d.VM$b0fG4VCuuP-	0	0969334579	mnTaj8HPMr
1673	Trần Tuệ Nguyệt	F	41	*8j)Or}r>Q$G	0	0237201586	6TjeS5wePN
1674	Nguyễn Thiên Minh	M	65	A>HMx}p&0p4	0	0557629625	ugvJioCAKw
1675	Bùi Thiên Bảo	M	27	*rgTV#1xTz5w+pFDeSjS	0	0919186468	9HtQdpY1iv
1676	Dương Anh Phúc	M	35	A}>h;$2v/v+74;$I	0	0875184435	7OiACb5S5j
1677	Dương Minh Khoa	M	35	aG}y6gMgR^N	0	0927913253	aVcLSCd7Tb
1678	Phạm Minh Phúc	M	24	n$=f#XUf,+1oZ?/	0	0468508651	iMH8fV9ykS
1679	Hoàng Minh Huy	M	48	A[qIq2Q.cUJB}{	0	0307335083	goFqHJliaW
1680	Nguyễn Thiên Khang	M	57	WT>45w<#qZu#W	0	0548182044	lOIuBDbTlq
1681	Vũ Minh Khoa	M	65	(b(s<pEM	0	0107031683	NnyodgwBgE
1682	Võ Thị Chi	F	29	=F?G-d-M	0	0773326914	co5XCwelCG
1683	Huỳnh Thu Thư	F	52	Oo}nYwu]	0	0396993698	4xDeMDoDHa
1684	Bùi Thiên Huy	M	43	.XBLGWF<8$+syfc>	0	0880755279	TwlBdQvCyn
1685	Lý Minh Minh	M	38	WS.J2y<vgwjQr0,	0	0607001884	RenOUW6Wf7
1686	Ngô Tuệ Chi	F	45	w/!,M<a2s5=(_{)%9|A	0	0457786510	gzx15x3zgQ
1687	Lê Minh Minh	M	42	_lL:8=?[T,	0	0693707814	DjAdlxHoS9
1688	Phan Tuệ Lan	F	53	R,d$ln9p:|	0	0338224009	lNblSu0iEO
1689	Vũ Anh Huy	M	52	yVFb|=]!-5AscZa	0	0978794656	TpoHK3OQVs
1690	Võ Bích Chi	F	23	O<gH@Rjw:]	0	0194285777	R4tn8Ylucq
1691	Ngô Bích Lan	F	47	rvf|Z|,8!uK8K=	0	0335549616	l2RyPlYMlW
1692	Trần Quang Huy	M	32	p[28kgh.W>93a|b@	0	0135005998	aKBqZ9Dl2P
1693	Võ Thị Nguyệt	F	21	Y|AH[,>-]	0	0157602205	ZVrbU9kzpC
1694	Nguyễn Văn Minh	M	37	@Emo?5BX-Oi{0x<[&^	0	0173519374	ajGkibJNPZ
1695	Hồ Minh Huy	M	51	8Q?5&L$P?WI32c7>	0	0790658323	Fcb5c0C1dI
1696	Lý Bích Như	F	32	WZ|?QhBp&	0	0308131275	DsrEjaxXQK
1697	Huỳnh Anh Bảo	M	25	=Kb*##sT>rJ[?	0	0205195316	f5GkA8hnc2
1698	Lý Anh Huy	M	32	>:Z)lF2gmy$	0	0599857456	uxo2ENHOZR
1699	Vũ Anh Huy	M	36	%j=v@J9FR	0	0401107510	LCcVrZDq03
1700	Dương Anh Huy	M	40	3Pya^.j8%rgR(c,!lLO8	0	0962355500	IFAdwJdo2S
1701	Huỳnh Gia Khoa	M	18	[!0(e?bisr<wD&G(NFF	0	0419491316	0yO3jalsHf
1702	Hồ Thùy Linh	F	52	z58ztmN@Qku^x)L;:	0	0457357511	quNXHRDm0E
1703	Lý Thị Như	F	52	z?0mTuMTI5Q<5Hyd5	0	0151237688	QDxQoS8hXb
1704	Trần Tuệ Chi	F	44	>LNCe|?8	0	0136769037	C61B8QTNN0
1705	Nguyễn Quang Phúc	M	26	.@SwQNxDq	0	0636258010	dUTJDQ7uGh
1706	Phan Bích Như	F	63	z>B-NH?eCNIX	0	0761486210	QmSINysD1i
1707	Dương Thùy Nguyệt	F	65	3EF>y*/#!kRGyeQ?SD	0	0674746435	8W03jNFqZb
1708	Dương Tuệ Linh	F	30	h|;BKX}B%eU}J0	0	0665733979	behLgzH7I1
1709	Trần Thùy Linh	F	58	v/_LnCU&luHN	0	0719413823	Yx6wwEJHiV
1710	Lê An Linh	F	29	cC-lJ3PHm3IEG}h{9lg^	0	0133812296	MFGLXTiWT2
1711	Võ Bích Linh	F	40	$Ki[bbRK*	0	0618717686	QOjZ8KD0gq
1712	Lý Thu Chi	F	33	C&&2;T$f}]GMg	0	0845982310	2RmzIcG1nQ
1713	Bùi Tuệ Thư	F	41	R;_,b:<|@pd	0	0854076972	AcT87wclhR
1714	Lý An Thư	F	48	0R]w<vM>./	0	0787519164	YSlXKqB7Eq
1715	Đỗ Gia Khoa	M	23	b{el!U6;}<5PFk}W	0	0839864740	8SsF4d9Lex
1716	Lý An Thư	F	31	l?z1hl]LYu$im{.	0	0568164370	9OwXjsYUk2
1717	Huỳnh Thị Thư	F	24	@ln]5Dv:>3	0	0416335613	oWcG0KwA1O
1718	Dương Tuệ Chi	F	44	HmIbQWM3bY7kB;W@FC	0	0703480062	u7dGjsTgkX
1719	Đỗ Thị Linh	F	60	Q[h{!DBt	0	0196369451	AgyxIy6utX
1720	Hồ Thiên Bảo	M	22	h.*d^@/A]Q^mZ8N/-	0	0294589766	8hYM3ghDuZ
1721	Trần Gia Bảo	M	33	vc:wnAyE2R#urcg	0	0115014390	Rbox4CTvT4
1722	Hồ Gia Huy	M	60	%G0!]3F*	0	0101741119	H8j7PX07zg
1723	Đặng Quang Khoa	M	20	H]!3{w-L{5	0	0111965207	4tNysM4D0P
1724	Ngô Khánh Thư	F	33	0]PFSr&BR>rCO@	0	0123794068	2stA7tE9w3
1725	Vũ Thu Thư	F	55	:pe+c@]d*S_G+6cX	0	0449118621	mMnAhYn5U4
1726	Lê Thị Thư	F	19	TkUNdE+cv	0	0544556507	Usbl8yWLKA
1727	Hoàng Minh Khang	M	61	-5dw,O1Rx3c<i|MXc@	0	0390400051	4UegE6Z3oy
1728	Vũ Thu Linh	F	57	^/B.-QMV/k$?11MbNE%	0	0720220554	rUJvw5FZ35
1729	Lê Quang Khang	M	58	{vz$&+5!.e*UsXbd0d@	0	0248072140	xrNsi86wmM
1730	Võ Tuệ Như	F	57	#PIUyT(|Wi4tv7	0	0772555138	n4EwxqCkMm
1731	Đỗ Quang Huy	M	24	t%C0GUQm>>gs)K/=%	0	0391426896	wYdvdhf7a6
1732	Hoàng Khánh Như	F	62	#yTgUxWCo9310#YdIN	0	0682209240	UvhyJEeMuZ
1733	Đặng An Chi	F	44	Vf^csO@y=FX@*;}@a	0	0543453006	JAdFGNypED
1734	Lý Văn Khoa	M	20	l*Z&M)*YcWP.	0	0987796944	Mbc6rpPif8
1735	Hoàng Tuệ Như	F	43	iX7,5(Q*.MIiG	0	0126086889	A0TxxsBrfx
1736	Dương An Linh	F	32	%(+5O=9{CN_WFlko5mC	0	0664660000	F6HNPLseXa
1737	Hồ Thu Linh	F	65	Zo><ViD}	0	0841077317	cXXN37R1bj
1738	Đặng Thu Linh	F	18	Xt/w:;U!L?)&B	0	0863699456	Gc411cAWBh
1739	Huỳnh Minh Khang	M	27	=&11[?W<Vj>;_RoxHrY	0	0138233529	WM8DqarIW8
1740	Võ Văn Minh	M	20	_0>rwR(ApEaw}(&=	0	0846708195	O6obB0XTO3
1741	Hồ Thiên Khang	M	28	Dl_R!X:*rnp@^kUx	0	0504916913	hgeMQxu7je
1742	Nguyễn Văn Khoa	M	62	nh92g+DH8H]KTS!_$|o	0	0975445930	C8iZspoTep
1743	Trần Quang Phúc	M	58	HpsvuxKO%pr;	0	0703611666	3iD6bV5kRI
1744	Bùi Thu Chi	F	33	+1zgd{B&R	0	0971484476	TLEBfNTp1v
1745	Lê Bích Nguyệt	F	57	AM|#Z([r2	0	0402650761	59aQMSalv8
1746	Đỗ An Nguyệt	F	34	6$r=q])E<joz&(;l%k:	0	0371782506	63Ha8MUddl
1747	Hoàng Văn Phúc	M	31	e?0SI>ey)$i9qzP	0	0295928779	LEbIKuOAfG
1748	Đỗ An Lan	F	23	/O++GR1k+u[NL$Y/.	0	0965917250	J3c1rrEugK
1749	Hồ An Linh	F	62	1Ca($JU=x,q	0	0944011517	cHtnQV6THA
1750	Đỗ Thị Như	F	57	<kc%RUV1*[b]hX5x-y!	0	0379514299	Ed7quBUWwS
1751	Bùi Văn Minh	M	21	$_X>t,VfD0}QG	0	0210569696	e0cVjUoVIb
1752	Bùi Minh Bảo	M	19	XDH}h/x2xw.@	0	0154441136	9hDS6PbSpz
1753	Ngô Minh Khang	M	59	YV!b{I)[z_g	0	0349165268	szX6b04GqU
1754	Dương Văn Khang	M	63	mx^3+1q+_	0	0880189373	fSrFNz4qK9
1755	Võ Khánh Lan	F	53	TKiHZOJ^cT^$tUE|	0	0606162307	D7CFpuTVWj
1756	Phan Minh Phúc	M	38	^c@n]RKLnd4rf	0	0726875719	dvVLkDzVdn
1757	Dương Thị Chi	F	58	Q;0|v]kQZ	0	0148075603	dSKqo1sDCx
1758	Ngô Văn Khoa	M	28	M33Y,<4]2	0	0709028801	cHSeKdlVyq
1759	Huỳnh Khánh Lan	F	60	)#2ifIjD:Z+-HQhf	0	0910518203	mxODAi5QhV
1760	Trần Quang Minh	M	54	#Wt=Lub^,cP:;	0	0114259812	GodiviRZRA
1761	Ngô Tuệ Linh	F	36	JXV].WNjS0>UL.	0	0305689844	xZMZD1FYj7
1762	Trần Văn Khoa	M	64	mfY^R>c3!zsF	0	0329153041	cX2pszVFoP
1763	Lê Thiên Huy	M	19	._^Tclr+BIjl}Yn;aKD	0	0235612067	b4m5HRuc5c
1764	Lý Bích Như	F	35	:-B=yqZaE{XW+Zx-|	0	0714378648	RnS2UrrVHg
1765	Phan Thu Nguyệt	F	39	[VFZ&g?xk	0	0458023795	XgPB6RWozj
1766	Dương Thiên Khoa	M	28	M>f/l;B#/wI&4	0	0853176905	u5mXUlrAM0
1767	Võ Anh Huy	M	27	JDz$[+hV,ju	0	0166585652	KgIRariwYt
1768	Trần Gia Minh	M	45	N3bI{g@a8itb_	0	0362456217	uIvAgGDkbU
1769	Hoàng Quang Khang	M	60	7Spil2F5&	0	0558627541	J8RTO13Lak
1770	Vũ Thùy Lan	F	19	XCeVz]&%V	0	0802876057	ZmNiUgfufr
1771	Hồ Thị Thư	F	29	}lPB<.pGeCeh	0	0971564633	1sczdzRViG
1772	Võ Tuệ Linh	F	46	J3joP&1H+	0	0343288070	kPbmNAELvR
1773	Ngô Thùy Linh	F	49	I>fs@nM;Gg4s	0	0229759292	9n0u32cLuY
1774	Nguyễn Thiên Bảo	M	44	mXf4hxj#C}=ZFc[k@V	0	0919833558	0aJYpvAXE2
1775	Hồ Bích Chi	F	21	1)FAeNG.6)M:/_@U6	0	0874725608	mV1NUgunxi
1776	Vũ Thu Lan	F	23	*/(:I&4XtAI{}.	0	0956300164	TLoOqkPYQs
1777	Đặng Thiên Khoa	M	53	qnxW8p&&:*xN.Q]sE$	0	0237895268	OAiaHHNbg7
1778	Trần Khánh Nguyệt	F	35	XS?^+MTZ2_m^52(Vl	0	0898246812	CLNFWKzQyE
1779	Lý Gia Phúc	M	45	8;dmC8WQ(B*v!#	0	0895271239	3Rf7V3WzXS
1780	Võ Quang Minh	M	35	hCI786hM}2(	0	0966032122	onyzoZbXmU
1781	Trần Tuệ Nguyệt	F	30	<dAU{S*w|r5;RA?u18i	0	0998420681	ZfQZ0gd6oB
1782	Huỳnh Văn Huy	M	25	*BK[5,OD	0	0925194783	XUPNuoDugJ
1783	Ngô Tuệ Linh	F	55	rQSeq]_d,z#VEr	0	0246204559	mN2OH3WFXN
1784	Phạm Thị Nguyệt	F	23	uSqj_;%MkaQ+lUSBTo}	0	0584181983	2BU6SEG36T
1785	Võ Quang Minh	M	38	L[fT04^0O	0	0512029733	rSpRBO33xx
1786	Huỳnh Minh Bảo	M	51	A%4;e3I%KcOX_v35Pr1	0	0351087914	YZOlCQK5Qg
1787	Phạm Quang Khoa	M	60	jGUpN&^!@wg0;<wH70	0	0926524540	d3S1B02c57
1788	Vũ Quang Khoa	M	28	MBM[76#QnzyQX/bL_{	0	0476171515	xjkcm5QdpC
1789	Võ An Nguyệt	F	65	>S0jKM[iF,	0	0611431341	BKZ3ea8txV
1790	Nguyễn An Chi	F	21	:fq1--;I(	0	0990951735	gWTywvq8AI
1791	Lý Gia Bảo	M	21	HhM;I3F>(B<71Ie}NR	0	0360330384	Ld6Yt52uvo
1792	Ngô Anh Minh	M	25	8_j)qv7-?L{nI-A^	0	0382412114	W7IRVuntRf
1793	Lý Khánh Như	F	60	F^9zYuoA{T	0	0362196157	RS99Hk4gCk
1794	Đỗ Gia Phúc	M	39	I|zGBS4n^Ci9U%/l9.b^	0	0677619485	U9IQPL0Fr9
1795	Hoàng Bích Chi	F	29	P|1!Ub&yIe)	0	0182487833	3mUkIaWAG2
1796	Lê Bích Chi	F	34	,MJ$gRxDH	0	0220448771	ciiAdGKZ69
1797	Phan Tuệ Nguyệt	F	55	[AM1[Z_$	0	0982737122	wJ8SNRO1qD
1798	Lê Gia Bảo	M	56	p8>/MC|m5S](3!,?+3&	0	0924267758	5dD6hIfPpR
1799	Trần An Lan	F	53	tr6$i=;|qAB	0	0447437269	y1rklHGNBn
1800	Bùi Minh Khang	M	34	-7G8]9&?D>!xEM#	0	0394045150	NA0DxCJJK5
1801	Lê Quang Bảo	M	51	3iuF%jD$[KS$LQfFjQ	0	0682212854	2Zme2MNUy6
1802	Hoàng Anh Minh	M	51	&{ayh<XyXZ|q>_ZOkK	0	0349155130	367Nqn9YXQ
1803	Nguyễn Tuệ Như	F	44	MVNS:E6OP{cjQrd	0	0440581465	mSo77Rzx2C
1804	Đỗ Khánh Chi	F	56	6v:u+j};a/ic[o;axq	0	0522825821	eQfjVwG8GI
1805	Võ Minh Khoa	M	25	|#rD(t7i	0	0222126851	oJVSB2sQ9q
1806	Lê Thu Thư	F	63	6]Y[c+t|p1J!k^	0	0767133829	DXPhpyZ5H2
1807	Ngô Minh Phúc	M	35	C=?^<d<=m	0	0217593655	S9fDOG7cvB
1808	Phan Tuệ Lan	F	50	#$SpFAcF	0	0394517850	rrOZHm1dtv
1809	Trần Thùy Thư	F	21	toCZ3!^-	0	0683793425	9JpuPpnCde
1810	Bùi Thu Nguyệt	F	54	gr4#V_uJK&Q	0	0293680630	r68EdYlYqS
1811	Nguyễn Anh Khang	M	62	Qg^&CYzC+Bo	0	0190607574	SOS938C8zI
1812	Lê Gia Khang	M	49	H>.x^+.zUe/j:y*!r9S7	0	0749828386	ScHC3Co3SS
1813	Trần Khánh Nguyệt	F	65	>)f1i6>|!QYvA	0	0242212924	6sBnDcPCb9
1814	Phan Tuệ Chi	F	41	T9Dp?:B:z8Goa	0	0229150687	eQnVIeYCdR
1815	Hoàng Thùy Nguyệt	F	48	GID-F,<=a/	0	0954861356	FhSAGuu28C
1816	Đỗ Thiên Phúc	M	36	6Qg([o]y	0	0587795873	XkSxMoX6vO
1817	Lý Thùy Thư	F	38	&-@@&6@%0gW	0	0278369128	bc7AJP8KVB
1818	Bùi Văn Huy	M	47	r@!#;DPf&$F)x:NS9C/	0	0374041145	1K9ARB018m
1819	Hoàng Gia Huy	M	27	r[W6t<4]#]+O6ZKO	0	0328919957	ImgIbL5BRs
1820	Ngô Thiên Phúc	M	22	.#zo_a<%d$	0	0504235848	edbtsdGP8R
1821	Phan Thị Linh	F	54	g0@1_W8pa2MlSkc&fq	0	0110856262	6z9FQrJVbJ
1822	Ngô Anh Huy	M	48	?}j93=i>_mz&&Lkz2V	0	0849052756	WWkBvAYHom
1823	Bùi Quang Huy	M	23	/j)HV{0jaxuO)8Py	0	0393512858	kJJFyeVM1A
1824	Hoàng Quang Minh	M	36	S:OPv)|S[*(<?C.f^I	0	0827636580	hc4SKuUFJo
1825	Dương Anh Huy	M	50	@.L9P.Pt|v8%!-	0	0221865533	YVcgJXcb2N
1826	Đỗ Thiên Minh	M	32	XhE#/1/s@YLI	0	0721082106	fjHyU83avP
1827	Nguyễn Thu Chi	F	30	2,[ud*-:t	0	0778876160	Azo8q2NgQL
1828	Võ An Chi	F	40	s:AtMY%3D#X.<	0	0639112850	wlJLaunjiI
1829	Phạm Thu Chi	F	58	m}jW/E?[Yd;_l)	0	0901366762	CMZJvMEMvk
1830	Đặng An Như	F	29	Ji3EAn-y_4?]S9_9g12]	0	0313952466	iv0cOfis9k
1831	Huỳnh Thu Linh	F	31	5]RK_*8tmI#gUh>!1x%	0	0697884112	7IQBkRWo9g
1832	Bùi Văn Phúc	M	42	l9iU8zktKo,D	0	0770042921	IX5ArVeDcv
1833	Phan Quang Bảo	M	32	xKi$5W_wOvzFQE_X{#cD	0	0205441820	sI8Gf5srEq
1834	Ngô Gia Minh	M	58	k!8|@8Ss&U	0	0895640191	hNxFBo1UEr
1835	Trần Gia Huy	M	52	L;t<A8QqDHo]p@P,B	0	0379438980	QAWC4c1OWe
1836	Bùi Quang Huy	M	64	-S_w1<Y$G@<t?5i	0	0862193543	WmRp45UfHX
1837	Bùi Anh Bảo	M	25	R(44Hmn9t|lU4W-Hp7d.	0	0557493043	SVlkqbO5Hg
1838	Phạm Minh Khoa	M	20	/X%FOGzHpbj]<;{r;	0	0698154332	GWe5pMI6ni
1839	Trần Thị Thư	F	29	Vci-jHs>cG7G=rC	0	0304303513	msoO2mRy3J
1840	Hoàng Gia Huy	M	43	s,fx5Wl>-	0	0436995923	B2YUM0w75N
1841	Ngô Thu Lan	F	31	*!>w-Pa*}SUJX=#Ar	0	0412298770	r0T6HwUuYA
1842	Huỳnh Tuệ Như	F	19	//-/7R^Ye&EA	0	0600005915	gIzZN5RExe
1843	Nguyễn Thiên Khang	M	64	Db[lNAN-+A9!9(_	0	0440865614	8t4bXH07ex
1844	Dương Thiên Phúc	M	63	!|mA.g#1!}X{WK(Fp	0	0366417933	wyL6yXbJWE
1845	Phan Văn Khoa	M	34	S@A>#l:4q5Di7	0	0209846614	ESC7dzVX5P
1846	Lý Gia Minh	M	37	wTJ$2mDb]?QA|ah,m	0	0211970149	6uU54Wncrj
1847	Phạm An Linh	F	53	}_@-(rf3h(#3T(	0	0825148405	82vjtCmlBR
1848	Huỳnh Anh Bảo	M	20	,lVI&i<t8/u[ZM5]T3	0	0374524043	XlfDpK9hRc
1849	Trần Thiên Khoa	M	42	R!.EES$6b1m:e9FO|/_O	0	0800786613	kNlHhbTDlh
1850	Bùi Thu Thư	F	22	qyP?[*Jaz	0	0137715475	nV8xPupnDQ
1851	Phạm Khánh Linh	F	58	tMKv[C{TA2@d	0	0657455776	kQKfgJLuty
1852	Lê Quang Huy	M	19	qhdL(oO=h?*gmsU	0	0731530401	evRJ7qXm7E
1853	Đỗ Minh Khoa	M	19	6NSi_0vsvT5*jYP!,)ap	0	0760480749	hItpllUUQx
1854	Dương An Chi	F	53	-!}bf}z|p4iq	0	0473449238	B7Cuty7tGl
1855	Đỗ Văn Bảo	M	54	*E.O7fS;&4	0	0702186941	OAZRbzxJAs
1856	Huỳnh Thu Lan	F	46	,T!Yn&_LHM(^-|/	0	0472096397	z2qvf4LaZB
1857	Vũ Thị Như	F	34	mHV_z)j6	0	0267376682	RE8xMFIpQh
1858	Phan Anh Khoa	M	52	*P%*vF$B|*GyHXBF	0	0277878098	RRZgpQFmxb
1859	Phan Tuệ Như	F	39	^YO&vP^}+69Ev%b	0	0179625791	SIPFRF9zD1
1860	Lý An Linh	F	18	*g|0)N[Va1nu)bfx{.	0	0718227686	RMc28mNRRX
1861	Hồ Thị Như	F	28	/t0(oP!D9Q/nM	0	0425499296	13U4xPLwap
1862	Vũ Quang Minh	M	56	rnM#PGzuyP!e25SUxRm	0	0761211407	F6Vp6HOhdv
1863	Huỳnh Quang Minh	M	58	W1tqS(A*Zxyn+w}	0	0239734213	H8aKQygwf0
1864	Đỗ Gia Khoa	M	55	;kpKCEI]^^B{1l+SYo2&	0	0781195520	AzzBG2kqHP
1865	Nguyễn Anh Khang	M	22	HUe#Yxds!UsUNSD5^	0	0328620537	FsuN1fIZvi
1866	Phan Văn Phúc	M	25	=a<Prq^:Md	0	0481953141	7DyTPTv1Bm
1867	Đỗ Tuệ Nguyệt	F	22	0Hz%oZx}5JiKiUYl@zM	0	0828639692	5t6udsGW4t
1868	Trần Thu Nguyệt	F	32	^b,!gp%x/QWdbT	0	0332114485	ekImPD1QuK
1869	Đỗ Minh Minh	M	27	eZV^ovr86X?t{^	0	0362820139	Qh0eqffldp
1870	Trần Thùy Linh	F	28	HO^}[X{}	0	0515034509	bSaXjkcilU
1871	Đỗ Minh Huy	M	56	JNqT|F8=hKU$=	0	0557785846	gdtXJZjcLR
1872	Đặng An Như	F	49	GwnM-snzz75x1K^Uo95	0	0891770008	3OH2LwIA7x
1873	Nguyễn Thiên Khoa	M	26	YR{1U>Vi	0	0530354028	4lDvYJcgGg
1874	Nguyễn Thị Chi	F	59	<W+Uq&_u+@	0	0850116617	TH2Tp2F39R
1875	Hồ Tuệ Linh	F	55	>H}]c(fYEsl	0	0438909574	mZZzPkbTtL
1876	Dương Anh Khoa	M	62	{E&a^ijB	0	0640130838	EXnYn837XA
1877	Huỳnh Minh Khoa	M	29	8>:t!v)iOHO%13E)6Ka	0	0837274155	QqPYIpGJfg
1878	Phạm Tuệ Thư	F	22	F*EH?u&VGpkZQ;SR0	0	0889100151	pa1DH92dnS
1879	Hoàng Văn Khang	M	39	^_P@s@|I	0	0468655683	2PVjEvxrcE
1880	Vũ Minh Huy	M	59	Z/(qM9}r:2(}6kQkAr2	0	0473683423	OfsIH7Hc55
1881	Đỗ An Nguyệt	F	64	)v|jE=cv>V@{-p2*	0	0914186791	3TSWKIdue1
1882	Đặng Gia Khoa	M	38	.Bo),CBP!zLsj7w4rW	0	0238792536	6hTsuyALBu
1883	Võ Thị Lan	F	58	,T0z?SechQ{%Mm@Gd	0	0490795716	RsbQwPSjtm
1884	Dương Thu Lan	F	52	,*k[rHE$(.OH	0	0634738743	Jvh8Jptv34
1885	Lê Gia Khang	M	43	]lg7xwK&%A(a&u	0	0995614630	xrmVt1077u
1886	Đỗ Thiên Minh	M	49	Zgql_=?y|^r977^y	0	0724736111	RJu76aa9oW
1887	Bùi Anh Khoa	M	21	9)SJq{/r	0	0611356215	nrLQLcfCkb
1888	Bùi An Linh	F	24	It,EfPt9[=8F2S&	0	0470456932	6ErOBs94WE
1889	Hồ Minh Bảo	M	46	%I^$3SCR|&1OH)8,+D=	0	0528943015	6zonNG0FUE
1890	Hoàng Tuệ Lan	F	60	_8=<E#*e3u<8	0	0665175780	5jnMxrFtoz
1891	Hồ Gia Huy	M	47	Y9s<KBy<W%ruE_M%@	0	0217241674	TBKPvIcBve
1892	Hồ Anh Khoa	M	30	:K0-IuJZ!ky	0	0916228326	1oLdYRsMnx
1893	Lý Thiên Bảo	M	65	<uBN}a-V^)F!-*v5,V	0	0645646199	iLaDJnJ7O7
1894	Hoàng An Chi	F	58	)#;GVQsEdP	0	0931302872	A0iqqlQ1js
1895	Huỳnh Quang Minh	M	41	$N)+YsJnFlW	0	0716887982	xefazQJaWy
1896	Dương Gia Khoa	M	19	|yPTs=MHLOT	0	0702238263	6CtMMTsHY4
1897	Hồ Thu Thư	F	19	1H$?OHELw^a[$#i0	0	0912119969	T6VBCVGIGF
1898	Dương Thiên Phúc	M	31	GC8>:G{&)>Pnh	0	0393137112	akl4valoIk
1899	Đỗ Văn Khang	M	27	dzeC%9U[6UpGK{+a(Q6	0	0176881672	AoFm2nUm3E
1900	Lê Thị Nguyệt	F	39	{dooz;:O.5	0	0325521613	W2YSpeDelw
1901	Lý Khánh Nguyệt	F	60	<]8KQ9oBd	0	0364873782	Fup8EjypQY
1902	Hồ Gia Khang	M	30	+q1e{ysDU@C1}-91F	0	0855505714	pggmQm1BHa
1903	Đặng Thị Nguyệt	F	50	6DPGyj!9T=}Gr+	0	0943926258	fg5IqA4qZQ
1904	Võ Khánh Nguyệt	F	19	{@U-B!*5gNu_dguqL	0	0521005354	ED2LbKHJgG
1905	Huỳnh Bích Như	F	57	c4ph*m[4s	0	0862048977	L4MeBO42JI
1906	Lê Khánh Lan	F	44	1&1M]/qI	0	0311543514	CbQ5uLDIHd
1907	Nguyễn Thị Nguyệt	F	35	,f]>SU7|Xt[|6PhG	0	0801391432	TOvV3V92KL
1908	Nguyễn Quang Khoa	M	51	4I]**])m8,g(9tR^Hf	0	0999718246	gyFEq3Toc4
1909	Hồ Anh Huy	M	58	Bt]th:jBR	0	0929442045	BoqzpGOMCf
1910	Hồ Minh Phúc	M	25	AROHi94!h)/--	0	0417905988	OrJcx3pLlU
1911	Võ Thu Như	F	48	/5}9?9:3%aEnP	0	0252814892	S1YvjwgRiz
1912	Nguyễn Quang Minh	M	46	R]IcsvUk7$Cq=m0	0	0275515777	KkL09F1YEP
1913	Đặng Minh Minh	M	28	NNH[@_T/^S0P0f79C	0	0545209519	Z7HEFaChhY
1914	Võ Thiên Bảo	M	48	vw=O*=h]EKRR|S	0	0128026537	H3uf52cKyP
1915	Dương Thị Nguyệt	F	43	x{285csi{%sSxg3th|O	0	0445496961	QWTfNnWSam
1916	Hồ Thu Nguyệt	F	23	y=i}iPj?O$e(	0	0326529301	ElRPWdn1at
1917	Dương Khánh Thư	F	61	(AiX:dA:Hfw	0	0180967244	0D1OtzFZc4
1918	Phan Gia Huy	M	29	p%gCz[n}MUsx	0	0326611797	fY5U4ZwZ6T
1919	Đỗ Thị Chi	F	18	PcEn%3<EK.;&=$sP	0	0330521673	XWBO17UDPS
1920	Đặng Thị Lan	F	57	Yf|IoWtZxQ;?!D	0	0813033703	TZOpOmzX3y
1921	Bùi Thiên Bảo	M	48	U-@jCOuE?.<;	0	0192514454	wUdkKBGZz5
1922	Hồ Minh Phúc	M	41	U_HMn,=I.6HEF$8&	0	0426684833	O4duFejM6c
1923	Võ Bích Linh	F	32	z/e|JH_-	0	0339284426	m2uc5Lut8K
1924	Vũ Minh Huy	M	45	[oS&99F.|R	0	0890296477	SXxugD7wEG
1925	Phạm Văn Bảo	M	31	Hix$h#^ZDYH475f>B#C	0	0256765690	jFf92sDmGF
1926	Hoàng Văn Minh	M	57	d]+Mu.rU77|x9ZRC	0	0221451146	o98KdentNR
1927	Hồ Thiên Huy	M	61	pxPra2QpAPg1**KHAb	0	0844261621	n6pOPGXI1j
1928	Đỗ Thiên Bảo	M	45	bc.N<<|y%1I_uch	0	0157562245	WAfw33EImx
1929	Vũ Khánh Như	F	24	_mP{?k5Sn1=}aT}D	0	0356660802	REXITKRG9y
1930	Đặng Thiên Bảo	M	61	v,sQDC7}{O$q#zU	0	0893416475	travqzsaE7
1931	Trần Tuệ Nguyệt	F	54	g%*s*n3pYy;q}5n]	0	0167763717	4eKyKzct0a
1932	Phan Quang Bảo	M	30	1D!q;+Z#	0	0362559462	ByMWOuSqcx
1933	Đỗ Thiên Bảo	M	55	7wjj0s?57bD	0	0954671170	qAT99nYupu
1934	Trần An Chi	F	39	+D(WoH:vY#.]6	0	0732747626	lfrXcs4tze
1935	Bùi Quang Khoa	M	34	ULRfH9@2I68z1wB/[eaK	0	0203677509	qutH0gxHbH
1936	Phạm Bích Chi	F	22	NG<jZ|;?}0{U)SLf2+^O	0	0538071878	ekQ9RRiFH6
1937	Lê Quang Khoa	M	49	4E}-*t^:	0	0458815122	LT8T1MMWfb
1938	Đặng Gia Huy	M	65	$<B8_}n?2M	0	0307446377	O7Ahdqvsz4
1939	Bùi Gia Huy	M	30	k)C;jnd*fAaUv>	0	0774813233	GjBmU1a156
1940	Hoàng Thùy Thư	F	26	,jz9>B]4Prp;{#@	0	0874658374	aCOgWBrr7g
1941	Hoàng Tuệ Chi	F	49	n!!+z0H%M%z>	0	0887078354	33d8WnZoQs
1942	Võ Khánh Thư	F	61	Z9jYo17+5=7&	0	0279627550	TqlocAWEr5
1943	Huỳnh Thiên Minh	M	21	h=Oz9+gG	0	0287434379	4AaCy9AilX
1944	Vũ Khánh Chi	F	60	]Em2c(y?rwU	0	0605672881	h7zrX8L0Vb
1945	Lê Tuệ Như	F	53	zG@Px*}S}	0	0911067697	8z7XxOvIdc
1946	Vũ Bích Lan	F	54	c?K@9%m.g13ahN7E@	0	0604370036	TqJPTNGYSG
1947	Lê An Như	F	39	V<Er,.18J7C|t=;PE?b	0	0492681221	aUuRp3Rh2o
1948	Hoàng Thị Linh	F	63	b@lH-.rkw6247eKwOS8	0	0676610421	yUTGqK9ael
1949	Bùi Thùy Chi	F	51	i/wU%R-DTS7	0	0727244846	vDHZTeBTwL
1950	Trần Thiên Phúc	M	55	;%znJbU?os9R	0	0722151256	rQVJrOkOt7
1951	Vũ Anh Phúc	M	49	-#*fFlUA5Hx#	0	0686905775	eaFXtEUhHf
1952	Võ Thu Như	F	45	S*UGHH!r-3h?T	0	0244069614	7JqsAD9vgw
1953	Phan Thu Như	F	42	E,TW{P,m$-hOxvVlLL?	0	0401731490	Dc0e0B6YA4
1954	Võ Tuệ Như	F	40	Pz64H-kj!bU!by-	0	0404528195	UmDxsStTF4
1955	Đỗ Văn Bảo	M	39	4+joK&aUw}1@}/HVC8d	0	0898035816	h31kHobxqU
1956	Huỳnh Thiên Khang	M	22	EI>F6-H/uhqgnz	0	0764761921	1TF0tlC1Go
1957	Ngô Thiên Huy	M	45	WJ|}cN/h!Y?m(	0	0404686880	b6svm128WO
1958	Đặng Văn Bảo	M	35	imWDr7<;?o	0	0374919177	ZRA1poO1IE
1959	Đỗ Bích Chi	F	34	=<a|0v[%L.	0	0773644563	iVQr7fXZpq
1960	Lê Tuệ Nguyệt	F	31	?ZsXH5=3	0	0693195129	XPsdTbAc5d
1961	Đỗ Anh Bảo	M	18	z&|]@Qu-FR,<iwsca	0	0760098950	xs4FWCYqKj
1962	Đặng Tuệ Thư	F	21	^{[|2X9W?E#=	0	0710141372	hBAT7IkIwh
1963	Đặng Minh Khoa	M	53	$/pnq6-pn	0	0380677173	HdNF2AocY8
1964	Dương Thiên Khang	M	38	F@d99$bG7+	0	0384749032	SucJvWhgZG
1965	Võ Văn Phúc	M	19	9!C1HDhP3$a	0	0167224475	pedREUAVew
1966	Lý An Như	F	34	t5<MDOflqF;*)G4M	0	0180816957	YO5QVbnT16
1967	Nguyễn Quang Huy	M	27	/-:A.,A,Lug&{j(JO<sC	0	0920970719	prMwFQWful
1968	Đặng Quang Minh	M	44	fkBM5)xT	0	0331660967	YddnFYPfMl
1969	Võ Thu Nguyệt	F	62	MMx_q?j<%Vmw1!ab}	0	0415538620	k8xAw7nIXJ
1970	Vũ Thu Nguyệt	F	38	L8sr^w+c>L	0	0696270831	2OL0DeaCd4
1971	Trần An Như	F	26	&YGpr0th|*ADi?76[	0	0415412548	M6CtJFsWeL
1972	Trần Thị Như	F	40	$VW9[=Hue	0	0391410250	as544R5paA
1973	Lý Thị Thư	F	30	zYgNtUWrVR[	0	0693385120	J9NC5u4lqK
1974	Dương Gia Phúc	M	64	MaedjWv(/F#c^rw	0	0583234720	rNlLROWlTz
1975	Bùi Thùy Như	F	59	,%>j+6NZ^_!>gyz(El	0	0854814132	RsF1Cyp3HW
1976	Phan An Như	F	31	OSZvcY1@pxp{v5C(;EHQ	0	0429710690	sFPGpg1CrE
1977	Bùi Gia Phúc	M	57	WizR[,|wQF8	0	0200509304	EQ2AAnSWkm
1978	Vũ Gia Khoa	M	57	v)R>i7uB;b&WEwC	0	0788509054	AN5y8ln7mp
1979	Hồ An Lan	F	27	r>tq0z:t=	0	0517880386	AHeQKiEuEG
1980	Huỳnh Gia Khoa	M	19	/Y^bK.D,Mq%LbPX	0	0524934508	DwwSz4QGF5
1981	Ngô Thùy Linh	F	63	:P-/550Y5-%1-3	0	0930893897	han03d1IdB
1982	Bùi Thu Nguyệt	F	53	YU>]8^2,}d)	0	0561334503	4MZIO8TxE4
1983	Nguyễn Khánh Nguyệt	F	43	?mL6upa@a,w+5SqG	0	0679044776	BGPOgu5Vwv
1984	Ngô An Chi	F	22	#dyssxCU(5hKO|Re	0	0212378120	Tbb9SJeoif
1985	Hoàng Khánh Chi	F	55	_Dt9&Gd<Y6	0	0628895017	X8KIyVX5fv
1986	Vũ Thiên Phúc	M	20	K%Vw?b%3T/u%}H*4	0	0249341243	Z8a4f7HtuT
1987	Ngô Minh Phúc	M	30	|j<%<;m@t@;U580Y	0	0695063536	4VqXUUuN8b
1988	Dương Minh Bảo	M	62	[_;!&#m/J/<M	0	0938897636	DquQAPmNGM
1989	Nguyễn Gia Minh	M	46	-Xb7CIs.B8<P4N<|AR%	0	0421330494	dlbLndQkVl
1990	Trần Quang Bảo	M	18	hO8=6^i?I-)yh9dDte	0	0984770948	2OTSVJQvAB
1991	Hồ Gia Phúc	M	42	bL-oVK$nX@j|azxB&D&	0	0541809055	6yGaAuUdyq
1992	Đỗ Minh Huy	M	36	<^{S*;8&#<C)J	0	0351423766	2mHnMeVmck
1993	Hoàng Thùy Như	F	39	.S-9xH33WCTfWs:<&	0	0385235154	aW9rezHVWc
1994	Lý Quang Khoa	M	22	c+{,lUrl3&	0	0923162531	RpV49dkjiR
1995	Hoàng Thiên Khoa	M	28	Rca1#1uH}%Rg,uEG*d	0	0978412981	59M02yswwA
1996	Ngô Quang Khoa	M	41	H.OMWD*]8I-9p{BwT	0	0608795811	teRYzZaPL6
1997	Võ Tuệ Linh	F	24	Fj?:=wf!l	0	0183591576	STyJyQ5Bnn
1998	Phan Gia Bảo	M	52	=$fo?Wky<eG)ug	0	0290039289	FHb57p5vft
1999	Dương Minh Bảo	M	59	rG1ljxf8n.:L@	0	0308913525	Y8dt6UUJoI
2000	Hồ Thu Như	F	31	0=vefip|D?HG/Vt#7	0	0948319372	dmJy9qiTpe
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: booking booking_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_id_key UNIQUE (booking_id);


--
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (booking_id);


--
-- Name: cart_dish cart_dish_cart_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_dish
    ADD CONSTRAINT cart_dish_cart_id_key UNIQUE (cart_id);


--
-- Name: cart_dish cart_dish_dish_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_dish
    ADD CONSTRAINT cart_dish_dish_id_key UNIQUE (dish_id);


--
-- Name: users constraint_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT constraint_name UNIQUE (acc_name);


--
-- Name: dish dish_dish_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish
    ADD CONSTRAINT dish_dish_name_key UNIQUE (dish_name);


--
-- Name: dish dish_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish
    ADD CONSTRAINT dish_pkey PRIMARY KEY (dish_id);


--
-- Name: order_dish order_dish_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_dish
    ADD CONSTRAINT order_dish_pkey PRIMARY KEY (order_id, dish_id);


--
-- Name: order_food order_food_order_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_food
    ADD CONSTRAINT order_food_order_id UNIQUE (order_id);


--
-- Name: order_food order_food_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_food
    ADD CONSTRAINT order_food_pkey PRIMARY KEY (order_id);


--
-- Name: payment payment_order_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_order_id_key UNIQUE (order_id);


--
-- Name: payment_order payment_order_order_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_order
    ADD CONSTRAINT payment_order_order_id_key UNIQUE (order_id);


--
-- Name: payment_order payment_order_payment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_order
    ADD CONSTRAINT payment_order_payment_id_key UNIQUE (payment_id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- Name: shopping_cart shopping_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_pkey PRIMARY KEY (cart_id);


--
-- Name: shopping_cart shopping_cart_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_user_id_key UNIQUE (user_id);


--
-- Name: user_cart user_cart_cart_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_cart
    ADD CONSTRAINT user_cart_cart_id_key UNIQUE (cart_id);


--
-- Name: user_cart user_cart_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_cart
    ADD CONSTRAINT user_cart_user_id_key UNIQUE (user_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: booking booking_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: cart_dish cart_dish_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_dish
    ADD CONSTRAINT cart_dish_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.shopping_cart(cart_id);


--
-- Name: cart_dish dish_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_dish
    ADD CONSTRAINT dish_id FOREIGN KEY (dish_id) REFERENCES public.dish(dish_id);


--
-- Name: order_dish dish_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_dish
    ADD CONSTRAINT dish_id FOREIGN KEY (dish_id) REFERENCES public.dish(dish_id);


--
-- Name: order_dish order_dish_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_dish
    ADD CONSTRAINT order_dish_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.order_food(order_id);


--
-- Name: order_food order_food_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_food
    ADD CONSTRAINT order_food_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: payment payment_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.order_food(order_id);


--
-- Name: payment_order payment_order_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_order
    ADD CONSTRAINT payment_order_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.order_food(order_id);


--
-- Name: payment_order payment_order_payment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_order
    ADD CONSTRAINT payment_order_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES public.payment(payment_id);


--
-- Name: payment payment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_cart user_cart_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_cart
    ADD CONSTRAINT user_cart_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.shopping_cart(cart_id);


--
-- Name: user_cart user_cart_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_cart
    ADD CONSTRAINT user_cart_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

