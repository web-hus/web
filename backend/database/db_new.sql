--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-01-24 18:27:19

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
-- TOC entry 217 (class 1259 OID 32913)
-- Name: booking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking (
    booking_id integer NOT NULL,
    user_id integer NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    num_people integer NOT NULL,
    status integer,
    special_requests text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT booking_status_check CHECK ((status = ANY (ARRAY[0, 1, 2])))
);


ALTER TABLE public.booking OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 32921)
-- Name: booking_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_booking_id_seq OWNER TO postgres;

--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 218
-- Name: booking_booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_booking_id_seq OWNED BY public.booking.booking_id;


--
-- TOC entry 219 (class 1259 OID 32922)
-- Name: dish; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dish (
    dish_id character varying(10) NOT NULL,
    dish_name character varying(100) NOT NULL,
    product_category character varying(25),
    price numeric(15,0) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    availability integer,
    CONSTRAINT dish_availability_check CHECK ((availability = ANY (ARRAY[0, 1])))
);


ALTER TABLE public.dish OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 32929)
-- Name: order_dishes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_dishes (
    order_id integer NOT NULL,
    dish_id character varying(10) NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.order_dishes OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 32932)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    order_type integer DEFAULT 0,
    booking_id integer,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status integer,
    delivery_address text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT orders_check CHECK ((((order_type = 1) AND (status IS NOT NULL) AND (delivery_address IS NOT NULL)) OR ((order_type = 0) AND (status IS NULL) AND (delivery_address IS NULL)))),
    CONSTRAINT orders_order_type_check CHECK ((order_type = ANY (ARRAY[0, 1]))),
    CONSTRAINT orders_status_check CHECK ((status = ANY (ARRAY[0, 1, 2, 3, 4])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 32944)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 222
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 223 (class 1259 OID 32945)
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    payment_id integer NOT NULL,
    user_id integer NOT NULL,
    order_id integer,
    amount numeric(15,0) NOT NULL,
    payment_method integer,
    payment_status integer,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT payment_payment_method_check CHECK ((payment_method = ANY (ARRAY[0, 1]))),
    CONSTRAINT payment_payment_status_check CHECK ((payment_status = ANY (ARRAY[0, 1, 2])))
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 32951)
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_payment_id_seq OWNER TO postgres;

--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 224
-- Name: payment_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_payment_id_seq OWNED BY public.payment.payment_id;


--
-- TOC entry 231 (class 1259 OID 33063)
-- Name: pending_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pending_users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    age integer NOT NULL,
    gender character varying(1) NOT NULL,
    address text NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(15) NOT NULL,
    password text NOT NULL,
    verification_token character varying(255) NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.pending_users OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 33062)
-- Name: pending_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pending_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pending_users_id_seq OWNER TO postgres;

--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 230
-- Name: pending_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pending_users_id_seq OWNED BY public.pending_users.id;


--
-- TOC entry 225 (class 1259 OID 32952)
-- Name: shopping_cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shopping_cart (
    cart_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shopping_cart OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 32957)
-- Name: shopping_cart_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shopping_cart_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shopping_cart_cart_id_seq OWNER TO postgres;

--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 226
-- Name: shopping_cart_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shopping_cart_cart_id_seq OWNED BY public.shopping_cart.cart_id;


--
-- TOC entry 227 (class 1259 OID 32958)
-- Name: shopping_cart_dishes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shopping_cart_dishes (
    cart_id integer NOT NULL,
    dish_id character varying(10) NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.shopping_cart_dishes OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 32961)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_name character varying(255) NOT NULL,
    age integer NOT NULL,
    gender character(1),
    address text NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(15) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    password text NOT NULL,
    role integer,
    CONSTRAINT users_gender_check CHECK ((gender = ANY (ARRAY['M'::bpchar, 'F'::bpchar]))),
    CONSTRAINT users_role_check CHECK ((role = ANY (ARRAY[0, 1])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 32970)
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
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 229
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4779 (class 2604 OID 41254)
-- Name: booking booking_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking ALTER COLUMN booking_id SET DEFAULT nextval('public.booking_booking_id_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 41255)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 4788 (class 2604 OID 41256)
-- Name: payment payment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


--
-- TOC entry 4796 (class 2604 OID 41257)
-- Name: pending_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_users ALTER COLUMN id SET DEFAULT nextval('public.pending_users_id_seq'::regclass);


--
-- TOC entry 4790 (class 2604 OID 41258)
-- Name: shopping_cart cart_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart ALTER COLUMN cart_id SET DEFAULT nextval('public.shopping_cart_cart_id_seq'::regclass);


--
-- TOC entry 4793 (class 2604 OID 41259)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4989 (class 0 OID 32913)
-- Dependencies: 217
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking (booking_id, user_id, date, "time", num_people, status, special_requests, created_at, updated_at) FROM stdin;
1	655	2024-12-21	11:30:00	12	1	Bàn gần cửa sổ để ngắm cảnh	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
2	115	2024-10-15	10:00:00	3	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
3	26	2024-10-04	14:00:00	2	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
4	760	2025-01-03	13:30:00	6	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
5	282	2024-11-05	13:30:00	5	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
6	251	2024-11-01	12:00:00	5	1	Bàn gần cửa sổ để ngắm cảnh	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
7	229	2024-10-29	11:30:00	4	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
8	143	2024-10-18	22:00:00	3	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
9	755	2025-01-03	11:00:00	12	2	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
10	105	2024-10-14	20:00:00	10	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
11	693	2024-12-26	10:30:00	3	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
12	759	2025-01-03	10:00:00	11	1	Có món ăn phù hợp với người lớn tuổi	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
13	914	2025-01-23	11:00:00	8	0	Bàn gần cửa sổ để ngắm cảnh	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
14	559	2024-12-09	13:00:00	2	1	Dành chỗ ngồi cho nhóm 10 người	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
15	90	2024-10-12	13:30:00	2	1	Phục vụ nhanh vì có trẻ em đi cùng	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
16	605	2024-12-15	21:30:00	3	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
17	433	2024-11-24	10:00:00	5	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
18	33	2024-10-05	22:00:00	5	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
19	31	2024-10-04	13:00:00	10	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
20	96	2024-10-12	22:00:00	11	2		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
21	224	2024-10-28	20:00:00	2	2	Tách hóa đơn riêng cho từng người trong nhóm	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
22	239	2024-10-30	13:30:00	10	2		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
23	518	2024-12-04	20:30:00	5	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
24	617	2024-12-17	14:00:00	12	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
25	28	2024-10-04	10:00:00	10	1	Không dùng món ăn quá cay	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
26	575	2024-12-11	12:30:00	8	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
27	204	2024-10-26	20:00:00	5	2		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
28	734	2024-12-31	18:30:00	9	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
29	666	2024-12-23	14:00:00	11	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
30	719	2024-12-29	12:00:00	6	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
31	987	2024-12-09	13:00:00	2	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
32	430	2024-11-23	18:30:00	4	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
33	226	2024-10-29	11:30:00	8	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
34	460	2024-11-27	11:00:00	7	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
35	604	2024-12-15	19:30:00	6	2		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
36	285	2024-11-05	11:30:00	4	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
37	829	2025-01-12	19:00:00	5	0	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
38	891	2025-01-20	19:00:00	7	0		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
39	7	2024-10-01	14:00:00	3	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
40	778	2025-01-06	10:30:00	3	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
41	826	2025-01-12	20:30:00	8	0	Dành chỗ ngồi cho nhóm 10 người	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
42	164	2024-10-21	22:00:00	3	2	Chuẩn bị thực đơn thuần chay	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
43	715	2024-12-29	11:30:00	7	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
44	984	2024-11-24	19:30:00	7	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
45	349	2024-11-13	11:00:00	11	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
46	965	2024-11-05	22:00:00	6	2		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
47	160	2024-10-20	18:00:00	2	2		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
48	221	2024-10-28	19:00:00	9	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
49	782	2025-01-31	13:00:00	10	0		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
50	345	2025-01-06	11:00:00	3	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
51	991	2024-11-13	10:30:00	8	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
52	95	2024-10-14	13:30:00	3	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
53	390	2024-10-12	18:00:00	10	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
54	100	2024-11-18	11:00:00	6	1	Phục vụ nhanh vì có trẻ em đi cùng	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
55	368	2024-10-13	13:30:00	12	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
56	868	2024-11-15	11:30:00	11	1	Có món ăn phù hợp với người lớn tuổi	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
57	353	2025-01-17	19:30:00	7	0		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
58	619	2024-11-14	14:00:00	11	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
59	271	2024-12-17	20:30:00	5	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
60	827	2024-11-03	19:00:00	3	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
61	45	2025-01-12	12:30:00	2	0	Không dùng rượu trong món ăn cho trẻ nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
62	748	2024-10-06	19:00:00	12	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
63	471	2025-01-02	19:00:00	5	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
64	550	2024-11-28	13:00:00	6	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
65	128	2024-12-08	14:00:00	3	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
66	388	2024-10-16	11:00:00	5	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
67	81	2025-01-27	12:30:00	3	0	Dọn sẵn đĩa và dao cắt bánh	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
68	566	2024-11-18	22:00:00	8	1	Không dùng món ăn quá cay	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
69	301	2024-10-11	13:30:00	6	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
70	850	2024-12-10	12:30:00	9	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
71	644	2024-11-07	20:30:00	12	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
72	634	2025-01-15	19:30:00	7	0	Bàn gần cửa sổ để ngắm cảnh	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
73	907	2024-12-20	14:00:00	4	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
74	883	2024-12-19	22:00:00	7	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
75	371	2025-01-22	13:30:00	7	0	Phục vụ nhanh vì có trẻ em đi cùng	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
76	592	2025-01-19	18:30:00	5	0		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
77	197	2024-11-16	10:30:00	12	1	Có món ăn phù hợp với người lớn tuổi	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
78	722	2024-12-13	13:30:00	6	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
79	72	2024-10-25	10:30:00	12	1	Thêm một đĩa trái cây cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
80	47	2024-12-30	18:30:00	12	1	Dành chỗ ngồi cho nhóm 10 người	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
81	678	2024-10-09	19:30:00	3	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
82	234	2024-10-06	14:00:00	11	1	Cung cấp thực đơn không chứa gluten	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
83	792	2024-12-24	11:00:00	12	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
84	297	2024-10-30	13:00:00	4	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
85	82	2025-01-07	18:30:00	10	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
86	876	2024-11-07	13:00:00	5	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
87	979	2024-10-11	21:00:00	4	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
88	888	2025-01-18	19:30:00	9	0	Tách hóa đơn riêng cho từng người trong nhóm	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
89	104	2024-10-30	20:30:00	8	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
90	948	2025-01-19	12:00:00	6	0		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
91	955	2024-10-13	14:00:00	12	1	Cung cấp thực đơn không chứa gluten	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
92	465	2024-11-18	12:00:00	10	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
93	651	2024-11-05	13:30:00	5	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
94	855	2024-11-28	22:00:00	12	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
95	374	2024-12-21	22:00:00	7	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
96	167	2025-01-15	14:00:00	2	0	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
97	380	2024-11-16	20:00:00	5	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
98	364	2024-10-21	19:30:00	2	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
99	215	2024-11-17	19:00:00	7	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
100	687	2024-11-15	13:30:00	8	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
101	274	2024-10-27	12:00:00	6	1	Tách hóa đơn riêng cho từng người trong nhóm	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
102	971	2024-12-25	21:30:00	3	1	Không thêm muối vào các món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
103	700	2024-11-04	21:00:00	5	1	Không thêm muối vào các món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
104	664	2024-12-29	11:00:00	11	1	Không dùng món ăn quá cay	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
105	74	2025-01-28	10:30:00	7	0	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
106	624	2024-12-27	11:30:00	5	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
107	908	2024-12-22	12:00:00	12	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
108	176	2024-10-10	12:30:00	9	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
109	547	2024-12-17	20:00:00	8	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
110	747	2024-12-21	11:00:00	12	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
111	995	2024-10-22	19:30:00	9	1	Bàn gần cửa sổ để ngắm cảnh	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
112	168	2024-12-08	19:30:00	4	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
113	474	2025-01-02	20:30:00	6	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
114	389	2024-11-01	21:30:00	4	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
115	277	2024-10-21	14:00:00	5	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
116	656	2024-11-29	22:00:00	10	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
117	705	2024-11-18	10:00:00	10	1	Thêm một đĩa trái cây cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
118	571	2024-11-04	11:30:00	6	1	Không thêm muối vào các món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
119	225	2025-01-27	22:00:00	11	0	Không dùng rượu trong món ăn cho trẻ nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
120	702	2024-12-21	14:00:00	8	2	Chuẩn bị thực đơn thuần chay	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
121	333	2024-12-28	18:30:00	11	1	Dọn sẵn đĩa và dao cắt bánh	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
122	864	2024-12-11	11:30:00	8	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
123	787	2024-10-29	18:00:00	7	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
124	795	2024-12-27	20:00:00	5	2	Dọn sẵn đĩa và dao cắt bánh	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
125	58	2024-11-11	12:30:00	4	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
126	235	2025-01-16	20:30:00	10	0	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
127	842	2025-01-07	10:00:00	9	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
128	983	2025-01-08	14:00:00	3	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
129	825	2024-10-08	21:30:00	2	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
130	324	2024-10-30	12:30:00	3	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
131	411	2025-01-14	21:30:00	4	0	Dọn sẵn đĩa và dao cắt bánh	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
132	275	2024-10-05	11:30:00	12	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
133	68	2025-01-12	18:00:00	4	0	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
134	217	2024-11-10	21:30:00	12	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
135	581	2024-11-21	13:00:00	8	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
136	736	2024-11-04	12:00:00	11	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
137	323	2024-10-09	19:00:00	3	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
138	218	2024-10-28	12:30:00	8	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
139	672	2025-01-25	22:00:00	8	0		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
140	512	2025-01-29	21:30:00	11	0	Không thêm muối vào các món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
141	406	2024-12-12	10:00:00	9	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
142	659	2025-01-21	18:30:00	10	0		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
143	470	2024-12-31	21:00:00	6	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
144	147	2024-11-10	10:00:00	10	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
145	272	2024-10-28	11:30:00	2	1	Có món ăn phù hợp với người lớn tuổi	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
146	993	2024-12-23	19:00:00	12	2		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
147	253	2024-12-03	18:00:00	3	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
148	763	2024-11-20	13:30:00	12	1	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
149	975	2025-01-22	10:30:00	10	0		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
150	552	2025-01-26	13:30:00	6	0		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
151	270	2024-12-22	11:00:00	12	1	Không dùng rượu trong món ăn cho trẻ nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
152	765	2024-11-28	11:00:00	7	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
153	599	2024-10-19	21:00:00	3	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
154	439	2024-11-03	11:00:00	6	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
155	598	2024-10-18	22:00:00	8	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
156	409	2024-11-01	12:00:00	4	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
157	926	2025-01-04	12:00:00	9	2	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
158	882	2024-12-11	21:00:00	2	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
159	142	2024-12-08	22:00:00	6	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
160	522	2024-11-03	12:30:00	10	1	Không dùng rượu trong món ăn cho trẻ nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
161	506	2025-01-04	14:00:00	4	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
162	94	2024-12-14	21:30:00	10	1	Tách hóa đơn riêng cho từng người trong nhóm	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
163	774	2024-11-24	20:00:00	3	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
164	49	2025-01-23	13:00:00	12	0	Không dùng rượu trong món ăn cho trẻ nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
165	113	2024-12-14	22:00:00	6	1	Thêm một đĩa trái cây cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
166	157	2024-11-21	13:00:00	12	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
167	643	2024-11-16	18:00:00	10	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
168	959	2024-10-29	19:30:00	11	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
169	812	2024-10-18	19:00:00	5	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
170	697	2024-12-05	20:30:00	4	1	Có món ăn phù hợp với người lớn tuổi	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
171	957	2024-12-03	21:30:00	7	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
172	611	2024-10-12	20:30:00	4	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
173	66	2025-01-05	11:30:00	10	2		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
174	395	2024-10-07	13:30:00	10	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
175	391	2025-01-19	13:30:00	2	0	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
176	964	2024-10-15	11:00:00	11	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
177	480	2024-10-20	18:30:00	7	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
178	542	2024-12-20	10:00:00	9	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
179	258	2024-10-21	22:00:00	2	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
180	567	2025-01-10	13:30:00	3	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
181	12	2024-12-27	13:30:00	7	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
182	831	2024-11-24	10:00:00	6	1	Tách hóa đơn riêng cho từng người trong nhóm	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
183	739	2024-12-16	11:00:00	5	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
184	118	2024-10-09	10:30:00	2	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
185	699	2024-11-19	13:30:00	5	1	Cung cấp thực đơn không chứa gluten	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
186	937	2024-11-18	11:00:00	11	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
187	769	2024-12-16	10:30:00	3	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
188	900	2024-11-29	18:30:00	3	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
189	788	2024-12-07	11:00:00	9	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
190	657	2024-11-02	21:30:00	3	2		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
191	956	2024-12-10	13:30:00	10	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
192	999	2025-01-19	14:00:00	4	0		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
193	932	2025-01-29	21:00:00	4	0		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
194	446	2024-10-02	13:00:00	12	1	Thêm một đĩa trái cây cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
195	162	2024-12-27	22:00:00	9	1	Thêm một đĩa trái cây cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
196	909	2025-01-01	12:00:00	10	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
197	4	2024-10-15	21:00:00	4	2		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
198	740	2024-12-27	13:30:00	6	1	Thêm một đĩa trái cây cho trẻ em	2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
199	737	2025-01-22	21:00:00	10	0		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
200	931	2024-12-08	20:00:00	11	1		2025-01-03 06:09:55.89407	2025-01-03 06:09:55.89407
201	655	2024-12-21	11:30:00	12	1	Bàn gần cửa sổ để ngắm cảnh	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
202	115	2024-10-15	10:00:00	3	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
203	26	2024-10-04	14:00:00	2	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
204	760	2025-01-03	13:30:00	6	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
205	282	2024-11-05	13:30:00	5	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
206	251	2024-11-01	12:00:00	5	1	Bàn gần cửa sổ để ngắm cảnh	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
207	229	2024-10-29	11:30:00	4	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
208	143	2024-10-18	22:00:00	3	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
209	755	2025-01-03	11:00:00	12	2	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
210	105	2024-10-14	20:00:00	10	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
211	693	2024-12-26	10:30:00	3	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
212	759	2025-01-03	10:00:00	11	1	Có món ăn phù hợp với người lớn tuổi	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
213	914	2025-01-23	11:00:00	8	0	Bàn gần cửa sổ để ngắm cảnh	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
214	559	2024-12-09	13:00:00	2	1	Dành chỗ ngồi cho nhóm 10 người	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
215	90	2024-10-12	13:30:00	2	1	Phục vụ nhanh vì có trẻ em đi cùng	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
216	605	2024-12-15	21:30:00	3	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
217	433	2024-11-24	10:00:00	5	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
218	33	2024-10-05	22:00:00	5	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
219	31	2024-10-04	13:00:00	10	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
220	96	2024-10-12	22:00:00	11	2		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
221	224	2024-10-28	20:00:00	2	2	Tách hóa đơn riêng cho từng người trong nhóm	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
222	239	2024-10-30	13:30:00	10	2		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
223	518	2024-12-04	20:30:00	5	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
224	617	2024-12-17	14:00:00	12	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
225	28	2024-10-04	10:00:00	10	1	Không dùng món ăn quá cay	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
226	575	2024-12-11	12:30:00	8	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
227	204	2024-10-26	20:00:00	5	2		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
228	734	2024-12-31	18:30:00	9	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
229	666	2024-12-23	14:00:00	11	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
230	719	2024-12-29	12:00:00	6	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
231	987	2024-12-09	13:00:00	2	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
232	430	2024-11-23	18:30:00	4	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
233	226	2024-10-29	11:30:00	8	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
234	460	2024-11-27	11:00:00	7	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
235	604	2024-12-15	19:30:00	6	2		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
236	285	2024-11-05	11:30:00	4	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
237	829	2025-01-12	19:00:00	5	0	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
238	891	2025-01-20	19:00:00	7	0		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
239	7	2024-10-01	14:00:00	3	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
240	778	2025-01-06	10:30:00	3	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
241	826	2025-01-12	20:30:00	8	0	Dành chỗ ngồi cho nhóm 10 người	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
242	164	2024-10-21	22:00:00	3	2	Chuẩn bị thực đơn thuần chay	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
243	715	2024-12-29	11:30:00	7	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
244	984	2024-11-24	19:30:00	7	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
245	349	2024-11-13	11:00:00	11	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
246	965	2024-11-05	22:00:00	6	2		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
247	160	2024-10-20	18:00:00	2	2		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
248	221	2024-10-28	19:00:00	9	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
249	782	2025-01-31	13:00:00	10	0		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
250	345	2025-01-06	11:00:00	3	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
251	991	2024-11-13	10:30:00	8	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
252	95	2024-10-14	13:30:00	3	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
253	390	2024-10-12	18:00:00	10	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
254	100	2024-11-18	11:00:00	6	1	Phục vụ nhanh vì có trẻ em đi cùng	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
255	368	2024-10-13	13:30:00	12	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
256	868	2024-11-15	11:30:00	11	1	Có món ăn phù hợp với người lớn tuổi	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
257	353	2025-01-17	19:30:00	7	0		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
258	619	2024-11-14	14:00:00	11	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
259	271	2024-12-17	20:30:00	5	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
260	827	2024-11-03	19:00:00	3	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
261	45	2025-01-12	12:30:00	2	0	Không dùng rượu trong món ăn cho trẻ nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
262	748	2024-10-06	19:00:00	12	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
263	471	2025-01-02	19:00:00	5	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
264	550	2024-11-28	13:00:00	6	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
265	128	2024-12-08	14:00:00	3	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
266	388	2024-10-16	11:00:00	5	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
267	81	2025-01-27	12:30:00	3	0	Dọn sẵn đĩa và dao cắt bánh	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
268	566	2024-11-18	22:00:00	8	1	Không dùng món ăn quá cay	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
269	301	2024-10-11	13:30:00	6	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
270	850	2024-12-10	12:30:00	9	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
271	644	2024-11-07	20:30:00	12	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
272	634	2025-01-15	19:30:00	7	0	Bàn gần cửa sổ để ngắm cảnh	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
273	907	2024-12-20	14:00:00	4	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
274	883	2024-12-19	22:00:00	7	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
275	371	2025-01-22	13:30:00	7	0	Phục vụ nhanh vì có trẻ em đi cùng	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
276	592	2025-01-19	18:30:00	5	0		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
277	197	2024-11-16	10:30:00	12	1	Có món ăn phù hợp với người lớn tuổi	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
278	722	2024-12-13	13:30:00	6	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
279	72	2024-10-25	10:30:00	12	1	Thêm một đĩa trái cây cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
280	47	2024-12-30	18:30:00	12	1	Dành chỗ ngồi cho nhóm 10 người	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
281	678	2024-10-09	19:30:00	3	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
282	234	2024-10-06	14:00:00	11	1	Cung cấp thực đơn không chứa gluten	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
283	792	2024-12-24	11:00:00	12	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
284	297	2024-10-30	13:00:00	4	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
285	82	2025-01-07	18:30:00	10	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
286	876	2024-11-07	13:00:00	5	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
287	979	2024-10-11	21:00:00	4	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
288	888	2025-01-18	19:30:00	9	0	Tách hóa đơn riêng cho từng người trong nhóm	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
289	104	2024-10-30	20:30:00	8	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
290	948	2025-01-19	12:00:00	6	0		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
291	955	2024-10-13	14:00:00	12	1	Cung cấp thực đơn không chứa gluten	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
292	465	2024-11-18	12:00:00	10	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
293	651	2024-11-05	13:30:00	5	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
294	855	2024-11-28	22:00:00	12	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
295	374	2024-12-21	22:00:00	7	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
296	167	2025-01-15	14:00:00	2	0	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
297	380	2024-11-16	20:00:00	5	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
298	364	2024-10-21	19:30:00	2	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
299	215	2024-11-17	19:00:00	7	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
300	687	2024-11-15	13:30:00	8	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
301	274	2024-10-27	12:00:00	6	1	Tách hóa đơn riêng cho từng người trong nhóm	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
302	971	2024-12-25	21:30:00	3	1	Không thêm muối vào các món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
303	700	2024-11-04	21:00:00	5	1	Không thêm muối vào các món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
304	664	2024-12-29	11:00:00	11	1	Không dùng món ăn quá cay	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
305	74	2025-01-28	10:30:00	7	0	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
306	624	2024-12-27	11:30:00	5	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
307	908	2024-12-22	12:00:00	12	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
308	176	2024-10-10	12:30:00	9	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
309	547	2024-12-17	20:00:00	8	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
310	747	2024-12-21	11:00:00	12	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
311	995	2024-10-22	19:30:00	9	1	Bàn gần cửa sổ để ngắm cảnh	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
312	168	2024-12-08	19:30:00	4	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
313	474	2025-01-02	20:30:00	6	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
314	389	2024-11-01	21:30:00	4	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
315	277	2024-10-21	14:00:00	5	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
316	656	2024-11-29	22:00:00	10	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
317	705	2024-11-18	10:00:00	10	1	Thêm một đĩa trái cây cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
318	571	2024-11-04	11:30:00	6	1	Không thêm muối vào các món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
319	225	2025-01-27	22:00:00	11	0	Không dùng rượu trong món ăn cho trẻ nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
320	702	2024-12-21	14:00:00	8	2	Chuẩn bị thực đơn thuần chay	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
321	333	2024-12-28	18:30:00	11	1	Dọn sẵn đĩa và dao cắt bánh	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
322	864	2024-12-11	11:30:00	8	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
323	787	2024-10-29	18:00:00	7	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
324	795	2024-12-27	20:00:00	5	2	Dọn sẵn đĩa và dao cắt bánh	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
325	58	2024-11-11	12:30:00	4	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
326	235	2025-01-16	20:30:00	10	0	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
327	842	2025-01-07	10:00:00	9	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
328	983	2025-01-08	14:00:00	3	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
329	825	2024-10-08	21:30:00	2	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
330	324	2024-10-30	12:30:00	3	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
331	411	2025-01-14	21:30:00	4	0	Dọn sẵn đĩa và dao cắt bánh	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
332	275	2024-10-05	11:30:00	12	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
333	68	2025-01-12	18:00:00	4	0	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
334	217	2024-11-10	21:30:00	12	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
335	581	2024-11-21	13:00:00	8	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
336	736	2024-11-04	12:00:00	11	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
337	323	2024-10-09	19:00:00	3	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
338	218	2024-10-28	12:30:00	8	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
339	672	2025-01-25	22:00:00	8	0		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
340	512	2025-01-29	21:30:00	11	0	Không thêm muối vào các món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
341	406	2024-12-12	10:00:00	9	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
342	659	2025-01-21	18:30:00	10	0		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
343	470	2024-12-31	21:00:00	6	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
344	147	2024-11-10	10:00:00	10	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
345	272	2024-10-28	11:30:00	2	1	Có món ăn phù hợp với người lớn tuổi	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
346	993	2024-12-23	19:00:00	12	2		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
347	253	2024-12-03	18:00:00	3	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
348	763	2024-11-20	13:30:00	12	1	Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
349	975	2025-01-22	10:30:00	10	0		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
350	552	2025-01-26	13:30:00	6	0		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
351	270	2024-12-22	11:00:00	12	1	Không dùng rượu trong món ăn cho trẻ nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
352	765	2024-11-28	11:00:00	7	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
353	599	2024-10-19	21:00:00	3	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
354	439	2024-11-03	11:00:00	6	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
355	598	2024-10-18	22:00:00	8	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
356	409	2024-11-01	12:00:00	4	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
357	926	2025-01-04	12:00:00	9	2	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
358	882	2024-12-11	21:00:00	2	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
359	142	2024-12-08	22:00:00	6	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
360	522	2024-11-03	12:30:00	10	1	Không dùng rượu trong món ăn cho trẻ nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
361	506	2025-01-04	14:00:00	4	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
362	94	2024-12-14	21:30:00	10	1	Tách hóa đơn riêng cho từng người trong nhóm	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
363	774	2024-11-24	20:00:00	3	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
364	49	2025-01-23	13:00:00	12	0	Không dùng rượu trong món ăn cho trẻ nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
365	113	2024-12-14	22:00:00	6	1	Thêm một đĩa trái cây cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
366	157	2024-11-21	13:00:00	12	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
367	643	2024-11-16	18:00:00	10	1	Chuẩn bị thực đơn thuần chay	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
368	959	2024-10-29	19:30:00	11	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
369	812	2024-10-18	19:00:00	5	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
370	697	2024-12-05	20:30:00	4	1	Có món ăn phù hợp với người lớn tuổi	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
371	957	2024-12-03	21:30:00	7	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
372	611	2024-10-12	20:30:00	4	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
373	66	2025-01-05	11:30:00	10	2		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
374	395	2024-10-07	13:30:00	10	2	Không dùng rượu trong món ăn cho trẻ nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
375	391	2025-01-19	13:30:00	2	0	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
376	964	2024-10-15	11:00:00	11	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
377	480	2024-10-20	18:30:00	7	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
378	542	2024-12-20	10:00:00	9	1	Không dùng hành hoặc tỏi trong món ăn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
379	258	2024-10-21	22:00:00	2	1	Trang trí bàn ăn theo phong cách tiệc sinh nhật	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
380	567	2025-01-10	13:30:00	3	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
381	12	2024-12-27	13:30:00	7	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
382	831	2024-11-24	10:00:00	6	1	Tách hóa đơn riêng cho từng người trong nhóm	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
383	739	2024-12-16	11:00:00	5	1	Phục vụ trà nóng thay nước lạnh cho người lớn	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
384	118	2024-10-09	10:30:00	2	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
385	699	2024-11-19	13:30:00	5	1	Cung cấp thực đơn không chứa gluten	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
386	937	2024-11-18	11:00:00	11	1	Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
387	769	2024-12-16	10:30:00	3	1	Chuẩn bị bánh sinh nhật cho tiệc gia đình	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
388	900	2024-11-29	18:30:00	3	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
389	788	2024-12-07	11:00:00	9	1	Thêm chỗ để xe đẩy cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
390	657	2024-11-02	21:30:00	3	2		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
391	956	2024-12-10	13:30:00	10	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
392	999	2025-01-19	14:00:00	4	0		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
393	932	2025-01-29	21:00:00	4	0		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
394	446	2024-10-02	13:00:00	12	1	Thêm một đĩa trái cây cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
395	162	2024-12-27	22:00:00	9	1	Thêm một đĩa trái cây cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
396	909	2025-01-01	12:00:00	10	1	Yêu cầu ghế trẻ em cho bé nhỏ	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
397	4	2024-10-15	21:00:00	4	2		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
398	740	2024-12-27	13:30:00	6	1	Thêm một đĩa trái cây cho trẻ em	2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
399	737	2025-01-22	21:00:00	10	0		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
400	931	2024-12-08	20:00:00	11	1		2025-01-03 06:10:00.518836	2025-01-03 06:10:00.518836
420	1000	2025-01-16	15:20:00	8	0		2025-01-16 08:20:56.26192	2025-01-16 08:20:56.26192
\.


--
-- TOC entry 4991 (class 0 OID 32922)
-- Dependencies: 219
-- Data for Name: dish; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dish (dish_id, dish_name, product_category, price, description, created_at, availability) FROM stdin;
D002	Súp hải sản	Khai vị	35000	Súp hải sản là sự kết hợp giữa các loại hải sản tươi như tôm, cua, mực cùng với rau củ, tạo nên vị ngọt đậm đà. Nước dùng trong vắt và sánh mịn, hương vị thơm ngon hòa quyện với độ dai của hải sản, đem lại trải nghiệm tròn vị cho thực khách.	2025-01-03 06:09:44.223236	1
D003	Súp bào ngư vi cá	Khai vị	100000	Là món súp cao cấp, bào ngư và vi cá được ninh chín mềm trong nước dùng đậm đà từ xương, kết hợp cùng các loại gia vị tinh tế. Vị ngọt thanh và hậu vị béo ngậy từ bào ngư vi cá khiến món ăn này trở nên sang trọng, bổ dưỡng, thích hợp cho những buổi tiệc trang trọng.	2025-01-03 06:09:44.223236	1
D004	Súp kem nấm	Khai vị	35000	Súp kem nấm với hương vị ngọt dịu, béo ngậy từ kem tươi, kết hợp cùng nấm tươi giòn ngọt tạo nên món khai vị hấp dẫn. Vị thơm đặc trưng từ nấm và độ sánh mịn của súp khiến món ăn trở nên thanh lịch và dễ chịu, phù hợp với mọi thực khách.	2025-01-03 06:09:44.223236	1
D005	Gỏi ngó sen tôm thịt	Khai vị	80000	Món gỏi ngó sen tôm thịt là sự hòa quyện của ngó sen giòn tươi, tôm ngọt và thịt heo mềm, tất cả thấm đều trong nước mắm chua ngọt đậm đà. Món gỏi này đem lại cảm giác thanh mát và hài hòa, khơi dậy vị giác và chuẩn bị cho các món ăn tiếp theo.	2025-01-03 06:09:44.223236	1
D006	Gỏi bò ngũ sắc	Khai vị	65000	Với nguyên liệu đa dạng từ rau củ nhiều màu sắc như ớt chuông, cà rốt, dưa leo cùng thịt bò mềm dai, món gỏi bò ngũ sắc không chỉ bắt mắt mà còn rất ngon miệng. Gia vị chua ngọt làm món ăn dậy vị, tươi mát và đầy đủ dưỡng chất.	2025-01-03 06:09:44.223236	1
D007	Nộm bò khô đu đủ	Khai vị	70000	Đu đủ bào sợi giòn ngọt, kết hợp với bò khô dai thơm, thêm ít rau thơm và đậu phộng rang, tất cả được trộn đều với nước sốt chua ngọt độc đáo. Món nộm này là sự kết hợp hài hòa giữa vị giòn, ngọt, chua cay nhẹ, tạo cảm giác vui miệng khi thưởng thức.	2025-01-03 06:09:44.223236	1
D008	Nộm sứa	Khai vị	90000	Món nộm sứa tươi mát với sứa giòn sần sật, kèm theo các loại rau thơm, cà rốt, dưa chuột và hành tím. Nước mắm pha chua ngọt tạo nên hương vị thanh mát, hấp dẫn, rất thích hợp cho những ai muốn khởi đầu bữa ăn nhẹ nhàng và tươi mới.	2025-01-03 06:09:44.223236	1
D009	Nộm rau muống	Khai vị	50000	Rau muống non được trộn đều với các gia vị chua ngọt, tạo nên một món nộm giòn tan và dễ ăn. Với hương vị đặc trưng của rau muống cùng chút cay từ ớt và đậm đà của nước mắm, món nộm này là lựa chọn hoàn hảo cho thực khách yêu thích sự giản dị.	2025-01-03 06:09:44.223236	1
D010	Nộm gà hoa chuối	Khai vị	60000	Hoa chuối bào sợi giòn giòn, thịt gà xé nhỏ thấm đều gia vị, cùng với đậu phộng rang và rau thơm tạo nên một món nộm hấp dẫn. Món ăn có vị chua ngọt vừa phải, thơm lừng, kích thích vị giác, đem lại cảm giác dân dã và đậm đà cho bữa ăn.	2025-01-03 06:09:44.223236	1
D011	Bún rối	Món phụ	5000	Những sợi bún trắng ngần, mềm mại và dẻo dai, thường dùng để ăn kèm với các món nước chấm hoặc nước lèo, giúp tăng thêm hương vị và tạo cảm giác ngon miệng, dễ ăn, phù hợp trong các bữa cơm gia đình Việt.	2025-01-03 06:09:44.223236	1
D012	Mì tôm	Món phụ	5000	Mì tôm vàng óng, dai và nhanh chín, là món ăn nhanh quen thuộc và dễ chế biến. Khi kết hợp với các nguyên liệu khác như thịt, rau xanh, hay trứng, mì tôm tạo ra một bữa ăn đơn giản nhưng vẫn ngon lành, tiện lợi.	2025-01-03 06:09:44.223236	1
D013	Miến rong	Món phụ	9000	Miến rong với sợi trong suốt, dai và giòn tự nhiên, thường được chế biến trong các món nước hoặc xào. Miến rong là lựa chọn hoàn hảo cho những ai muốn một món ăn nhẹ nhàng, không gây cảm giác nặng nề nhưng vẫn no lâu.	2025-01-03 06:09:44.223236	1
D014	Sung muối xả ớt	Món phụ	10000	Sung được muối chua với hương thơm đặc trưng của xả và chút cay nhẹ từ ớt. Món sung muối giòn tan, vị chua cay dễ chịu, là món ăn kèm giúp tăng thêm phần hấp dẫn cho bữa cơm, đặc biệt khi dùng chung với thịt cá.	2025-01-03 06:09:44.223236	1
D015	Cà pháo 	Món phụ	7000	Cà pháo nhỏ nhắn, giòn rụm được muối chua với vị đậm đà vừa ăn, thường là món ăn dân dã quen thuộc. Với hương vị thơm mát, cà pháo giúp kích thích vị giác, tăng sự hấp dẫn khi ăn cùng cơm hoặc các món canh.	2025-01-03 06:09:44.223236	1
D016	Dưa chua	Món phụ	8000	Dưa chua làm từ cải bẹ xanh được muối lên men tự nhiên, có vị chua nhẹ, thơm nồng. Món dưa chua không chỉ là món ăn kèm dễ ăn, giúp giải ngán, mà còn có thể tặng hương vị thơm dịu cho các món canh độc đáo.	2025-01-03 06:09:44.223236	1
D017	Bánh tráng	Món phụ	10000	Bánh tráng mỏng và dai nhẹ, có thể được ăn kèm hoặc dùng để cuốn các loại rau, thịt. Với hương vị đơn giản nhưng thơm bùi, bánh tráng làm tăng thêm phần hấp dẫn cho các món cuốn Việt Nam, đặc biệt khi chấm kèm nước chấm đậm đà.	2025-01-03 06:09:44.223236	1
D018	Tóp mỡ	Món phụ	10000	Tóp mỡ là một món chiên vô cùng thơm ngon, được chiên ngập dầu cho đến khi vàng ruộm, giòn rụm. Với hương vị béo ngậy đặc trưng, tóp mỡ là món ăn kèm thú vị cho món cơm, hay bún.	2025-01-03 06:09:44.223236	1
D019	Đậu phụ rán 	Món phụ	5000	Đậu phụ rán vàng, lớp ngoài giòn rụm, bên trong mềm mịn, ngọt bùi, là món ăn dân dã mà hấp dẫn. Đậu phụ rán thường chấm với nước tương hoặc mắm tỏi ớt hay ăn kèm trong các món bún, đem lại cảm giác thanh đạm nhưng vẫn rất ngon miệng.	2025-01-03 06:09:44.223236	1
D020	Giò lụa	Món phụ	8000	Giò lụa được làm từ hai nguyên liệu cơ bản là thịt nạc thăn lợn giã nhuyễn kết hợp với nước mắm ngon, hương thơm nhẹ được gói trong lá chuối và luộc chín và độ giòn vừa phải. Đây là món ăn truyền thống quen thuộc trong mâm cỗ Việt, có thể ăn trực tiếp hoặc kết hợp với các món khác, mang đến hương vị hài hòa, tinh tế.	2025-01-03 06:09:44.223236	1
D021	Nước sấu	Đồ uống	15000	Nước sấu chua thanh, mát lạnh, với vị ngọt nhẹ nhàng từ sấu ngâm đường. Đây là thức uống truyền thống phổ biến, đặc biệt vào mùa hè, giúp giải nhiệt và làm mát cơ thể, mang lại cảm giác sảng khoái.	2025-01-03 06:09:44.223236	1
D022	Nước me	Đồ uống	15000	Nước me chua dịu, pha chút ngọt và hương thơm nhẹ từ me chín, là thức uống giải khát tuyệt vời cho những ngày nóng bức. Hương vị đặc trưng của me khiến món nước này có khả năng giải khát và giúp kích thích vị giác.	2025-01-03 06:09:44.223236	1
D023	Nước mơ	Đồ uống	15000	Nước mơ với vị chua ngọt, hương thơm đặc trưng của mơ ngâm, mang lại cảm giác sảng khoái. Là loại nước giải khát quen thuộc, nước mơ không chỉ ngon mà còn có tác dụng thanh nhiệt, làm dịu cơn khát hiệu quả.	2025-01-03 06:09:44.223236	1
D024	Nước chanh muối	Đồ uống	15000	Nước chanh muối có vị chua mặn vừa phải, kết hợp giữa chanh tươi và chút muối giúp bù khoáng, rất thích hợp để giải nhiệt và hỗ trợ tiêu hóa. Thức uống này giúp cơ thể hồi phục nhanh chóng trong những ngày nắng nóng hoặc sau khi vận động.	2025-01-03 06:09:44.223236	1
D025	Rau má đậu xanh	Đồ uống	20000	Rau má tươi mát kết hợp với đậu xanh bùi béo, tạo thành thức uống dinh dưỡng, tốt cho sức khỏe. Nước rau má đậu xanh không chỉ giúp thanh nhiệt mà còn có tác dụng làm mát gan, giải độc tự nhiên cho cơ thể.	2025-01-03 06:09:44.223236	1
D026	Trà chanh mật ong	Đồ uống	15000	Trà chanh mật ong với vị chua dịu của chanh và vị ngọt thanh từ mật ong, tạo nên thức uống vừa thơm ngon vừa bổ dưỡng. Đây là loại nước uống có tính kháng khuẩn cao, giúp làm dịu cổ họng và tăng cường hệ miễn dịch.	2025-01-03 06:09:44.223236	1
D027	Trà đào cam sả	Đồ uống	20000	Hương thơm nồng nàn của sả, vị ngọt từ đào và chút chua dịu từ cam, tất cả hòa quyện tạo nên ly trà đào cam sả thơm lừng, mát lạnh. Thức uống này không chỉ giải khát mà còn giúp thư giãn tinh thần, rất phù hợp để nhâm nhi.	2025-01-03 06:09:44.223236	1
D028	Trà atiso	Đồ uống	15000	Trà atiso có vị thanh mát, hơi ngọt và dịu nhẹ, là loại thức uống rất tốt cho sức khỏe, đặc biệt là gan và hệ tiêu hóa. Với màu đỏ tự nhiên đẹp mắt và hương vị dễ chịu, trà atiso thích hợp để uống mỗi ngày giúp thanh lọc cơ thể.	2025-01-03 06:09:44.223236	1
D029	Cà phê trứng	Đồ uống	25000	Cà phê trứng là món đặc sản độc đáo với lớp kem trứng béo mịn phủ lên cà phê đậm đà, tạo thành sự hòa quyện tuyệt vời giữa vị ngọt béo và vị đắng nhẹ. Thức uống này đem lại cảm giác vừa ấm áp vừa lạ miệng, thu hút nhiều thực khách yêu cà phê.	2025-01-03 06:09:44.223236	1
D030	Cà phê muối	Đồ uống	20000	Cà phê muối có sự kết hợp tinh tế giữa cà phê đậm đà và chút muối mặn, giúp làm nổi bật hương vị tự nhiên của cà phê. Đây là món uống mang đến trải nghiệm mới mẻ với vị đắng nhẹ nhàng, hậu vị dịu ngọt, rất độc đáo.	2025-01-03 06:09:44.223236	1
D031	Rượu ngô	Đồ uống	120000	Rượu ngô với hương thơm đặc trưng từ ngô được ủ lâu, mang lại vị ngọt dịu, đậm đà của miền núi phía Bắc. Là loại rượu truyền thống, rượu ngô thường có nồng độ nhẹ, dễ uống và rất được ưa chuộng trong các dịp lễ hội.	2025-01-03 06:09:44.223236	1
D032	Rượu mơ	Đồ uống	150000	Rượu mơ thơm dịu, có vị chua ngọt đặc trưng của mơ ngâm, là loại rượu nhẹ nhàng dễ uống. Món rượu này thường dùng trong các bữa tiệc để khai vị hoặc uống thư giãn, rất được yêu thích bởi hương vị đặc trưng và dịu nhẹ.	2025-01-03 06:09:44.223236	1
D033	Bia hơi	Đồ uống	15000	Bia hơi có màu vàng nhạt, bọt mịn, vị đắng nhẹ, là loại bia quen thuộc của người Việt, đặc biệt phổ biến trong các buổi tụ tập bạn bè. Bia hơi mát lạnh và dễ uống, thích hợp cho những buổi gặp gỡ thư giãn, tạo không khí vui tươi và gần gũi.	2025-01-03 06:09:44.223236	1
D034	Bún chả hà nội	Món chính	45000	Từ cái nhìn đầu tiên, bạn có thể liên tưởng ngay đến bún thịt nướng phổ biến ở miền Nam bởi hương vị nước chấm của bún chả Hà Nội hoàn toàn khác biệt. Một phần bún chả bao gồm: bún mềm mịn, nước chấm với hương vị chua ngọt và kèm theo su hào và cà rốt ngâm giấm, thêm vài miếng chả thịt nướng thơm phức với mùi than lửa và hạt tiêu. Khi ăn, hãy kết hợp với rau sống, mỗi thành phần mang một chút riêng biệt nhưng lại hòa quyện với nhau tạo nên một hương vị đậm đà, thật ngon lành không thể cưỡng lại.	2025-01-03 06:09:44.223236	1
D035	Chả cá lã vọng	Món chính	130000	Món ăn truyền thống này được chế biến từ cá lăng - một loại cá giàu chất dinh dưỡng, có thịt ngọt và ít xương. Miếng chả được chiên giòn và thường được thưởng thức kèm theo rau thơm, bún tươi hoặc cơm, phù hợp cho bữa trưa hay bữa tối gia đình. Đặc biệt, để thưởng thức món này đúng điệu, bạn cần kèm theo mắm tôm đặc trưng. Hương vị của chả cá Lã Vọng hứa hẹn sẽ đánh thức vị giác của bạn và ghi sâu vào tâm trí với một hương vị không thể quên.	2025-01-03 06:09:44.223236	1
D036	Cá kho làng vũ đại	Món chính	800000	Món kho cá ở làng Vũ Đại mang trong mình tinh hoa văn hóa và hương vị món ngon truyền thống Việt Nam. Cá được kho với các gia vị tự nhiên như muối, đường, nước mắm, tiêu và các loại gia vị khác. Trong quá trình chuẩn bị, cá sẽ được ướp với các gia vị như gừng, riềng, nước cốt chanh, nước cốt xương lợn và những hương liệu gia truyền đặc biệt. Quá trình kho cá diễn ra chậm rãi, cho phép gia vị thấm vào từng thớ thịt, tạo nên một hương vị thật đậm đà và đặc trưng.	2025-01-03 06:09:44.223236	1
D037	Bánh đa cua Hải Phòng	Món chính	40000	Bát bánh đa với hương thơm đặc trưng, màu sắc hấp dẫn và sợi bánh đa dai mềm, chả lá lốt thơm ngát, gạch cua béo ngậy, làm đủ đạt tiêu chuẩn. Ngoài bát bánh đa truyền thống, bạn cũng có thể áp dụng công thức tương tự để tạo ra những món bánh đa nước khác như bánh đa cua bề bề, bánh đa cua đồng, bánh đa cua biển, bánh đa cua cá rô đồng...	2025-01-03 06:09:44.223236	1
D038	Nem cua bể Haỉ Phòng	Món chính	200000	Món nem cua bể có hình dạng vuông vức, với lớp vỏ bên ngoài là bánh tráng chiên vàng giòn. Bên trong, nó bao gồm một phần nhân được làm từ thịt cua, tôm, mộc nhĩ, nấm hương, thịt nạc dăm, và mỡ gáy xay, được ướp gia vị đậm đà.	2025-01-03 06:09:44.223236	1
D039	Chả mực Hạ Long	Món chính	450000	Mực được tẩm ướp cẩn thận với các nguyên liệu sơ chế, như tỏi, hành, gia vị và các thành phần khác, để tạo ra hương vị thơm ngon đặc trưng. Sau đó, mực được giã và nhào nặn thủ công thành những miếng chả mực tròn trịa. Khi chiên trong dầu nóng, chả mực mang đến màu sắc hấp dẫn, vỏ giòn rụm và hương thơm nồng nàn.	2025-01-03 06:09:44.223236	1
D040	Thịt trâu gác bếp Tây Bắc	Món chính	990000	Thịt trâu gác bếp Tây Bắc ghi điểm bởi sự kết hợp độc đáo giữa vị ngọt và dai của thịt trâu, cùng hương thơm cay nồng và tê đầu lưỡi của các gia vị đặc trưng từ rừng núi. Thịt trâu được chế biến một cách tỉ mỉ và công phu, được ướp gia vị tự nhiên từ các loại thảo mộc, gia vị độc đáo của vùng miền. Quá trình nướng trên lửa than hoặc than củi tạo nên một lớp vỏ ngoài giòn rụm, bên trong thịt trâu thơm ngon và đậm đà.	2025-01-03 06:09:44.223236	1
D041	Gà đồi Tiên Yên Quảng Ninh	Món chính	180000	Đã là một "tín đồ đạo gà" thì không thể bỏ lỡ món gà đồi Tiên Yên. Thịt gà đồi Tiên Yên nổi tiếng với độ săn chắc, hương thơm đặc trưng và béo ngậy mà không bị bở. Điều này bởi gà được nuôi tự nhiên trên địa vực đồi núi, được "chạy bộ" nhiều nên rất "cơ bắp". Khi thưởng thức, bạn sẽ cảm nhận được sự chắc thịt độc đáo của gà đồi Tiên Yên.	2025-01-03 06:09:44.223236	1
D042	Bún cá rô đồng Hà Nam	Món chính	40000	Bún cá Rô Đồng là một món đặc sản đậm đà văn hóa đồng quê của Phủ Lý, Hà Nam. Món ăn này thu hút sự chú ý của thực khách nhờ sự kết hợp tuyệt vời giữa vị béo giòn của cá rô chiên và vị tươi ngọt tự nhiên của rau cải, cà chua, thơm...	2025-01-03 06:09:44.223236	1
D043	Bánh cuốn Phủ Lý	Món chính	30000	Những miếng chả thịt nướng được chế biến từ thịt ba chỉ lợn tươi, được thái mỏng và ướp gia vị thấm đều. Sau đó, chúng được xiên lên những que tre và đặt lên những bếp than hoa đang rực cháy để nướng. Để tạo nên hương vị đặc biệt, chả thịt nướng được quạt đều tay, đảm bảo bên ngoài miếng thịt được cháy sần sật nhưng vẫn giữ được độ mềm mại và ngọt ngào. Trong những ngày đầu đông se lạnh, thưởng thức bánh cuốn kết hợp với bát nước chấm chả nướng nóng hổi thì quả là không còn gì bằng.	2025-01-03 06:09:44.223236	1
D044	Phở Hà Nội	Món chính	45000	Một niềm tự hào với người con đất Việt chắc chắn là món ăn "tinh hoa hội tụ" - phở Việt Nam mà nổi tiếng hơn hết là phở Hà Nội. Phở không chỉ đơn thuần là một món ăn ngon mà còn trở thành "đại sứ ẩm thực" đại diện cho văn hóa tuyệt vời của Việt Nam, ghi dấu ấn trong lòng bạn bè quốc tế.	2025-01-03 06:09:44.223236	1
D045	Mì Quảng	Món chính	45000	Sợi mì mềm mịn, tự hào là thành quả của bột gạo dai ngọt, được tẩm ướp trong nước dùng hương thơm từ xương heo nấu chảy. Đặc biệt, hương vị của mì Quảng được tô điểm bởi những nguyên liệu phong phú như thịt heo, thịt gà, cá lóc, ếch, trứng cút luộc... Từng miếng thịt thơm béo kết hợp với nước dùng tinh túy, tạo nên một sự kết hợp tuyệt vời trên đĩa mì.	2025-01-03 06:09:44.223236	1
D046	Bún cá Nha Trang	Món chính	35000	Món đặc sản với nước dùng trong, lươn lẫn hương vị ngọt thanh, kết hợp với chả cá giòn dai, tạo nên một cảm giác khó quên trên đầu lưỡi. Bún cá Nha Trang là sự kết hợp tuyệt vời của màu sắc và hương vị, hòa quyện trong từng giọt nước dùng hấp dẫn.	2025-01-03 06:09:44.223236	1
D047	Bánh tráng cuốn thịt heo Đà Nẵng	Món chính	130000	Vị ngọt mềm của thịt heo, vị tươi mát của rau cùng với chút chua chua, cay cay từ mắm nêm tạo nên sự kết hợp tuyệt vời trong từng miếng cuốn bánh tráng. Món ăn này mang đến một hương vị độc đáo, khiến ai thưởng thức cũng không thể không say mê.	2025-01-03 06:09:44.223236	1
D048	Súp lươn Nghệ An	Món chính	35000	Mặc dù ra đời muộn hơn so với các món ăn khác, nhưng súp lươn đã chinh phục lòng người bởi sự kết hợp độc đáo giữa thịt lươn dai ngọt và nước dùng béo ngậy. Hương thơm lan tỏa từ nghệ, ớt, tiêu và hương vị cay nồng của hành tăm khiến bất kỳ ai thưởng thức đều không ngừng ca ngợi.	2025-01-03 06:09:44.223236	1
D049	Cao lầu Hội An	Món chính	50000	Cao lầu - một nét chấm phá của ẩm thực phố cổ, và mỗi khi đến phố cổ Hội An, Cao Lầu gần như là một món ăn mà thực khách phải thưởng thức , như một món ăn tinh thần của người dân phố Hội.	2025-01-03 06:09:44.223236	1
D050	Cơm hến Huế	Món chính	20000	Cơm hến là món ăn mang phong vị cung đình của mảnh đất cố đô. Cơm hến đã trở thành một trong những món ngon “khó cưỡng” đối với du khách. Cơm hến không chỉ là món ăn mà còn là một trải nghiệm văn hóa đặc trưng của vùng đất cố đô. Bạn sẽ được thưởng thức hương vị thanh đạm của cơm trắng, kết hợp với hến tươi ngon, có vị ngọt nhẹ và hòa quyện với hương thơm của rau sống. Điểm nhấn của món ăn là nước mắm pha chế đặc biệt, mang đậm hương vị đặc sản Huế.	2025-01-03 06:09:44.223236	1
D051	Bún bò Huế	Món chính	40000	Mỗi miếng thịt bò thăn mềm, thấm đều vị nước dùng đậm đà, kết hợp với sợi bún mềm mịn và các loại rau sống tươi mát, hương vị đặc trưng và hấp dẫn của món bún bò Huế sẽ khiến thực khách không chỉ "xiêu lòng" mà còn nhớ mãi trong lòng.	2025-01-03 06:09:44.223236	1
D052	Bánh xèo tôm nhảy Bình Định	Món chính	40000	Bánh xèo tôm nhảy Bình Định thực sự là một món ăn đặc trưng thể hiện sự giao hòa của ẩm thực ba miền Bắc, Trung và Nam. Với vỏ bánh xèo mềm dai, một đặc trưng của ẩm thực duyên hải Nam Trung Bộ, và đĩa rau ăn kèm gồm rau thơm, giá tươi, rau cải và cải mầm, cùng vị chua ngọt của xoài xanh thái lát, món Bánh xèo tôm nhảy mang đến sự phong phú và hài hòa trong cảm nhận về hương vị.	2025-01-03 06:09:44.223236	1
D053	Chả tôm Thanh Hóa	Món chính	10000	Vị ngon tuyệt của chả tôm Thanh Hóa được thể hiện rõ nhất khi được thưởng thức vào cuối thu và đầu đông. Đó là khoảng thời gian khi gia đình quây quần bên bếp lửa hồng, cùng nhau nướng từng miếng chả tôm thơm phức, tạo nên nét đẹp trong ẩm thực Thanh Hóa.	2025-01-03 06:09:44.223236	1
D054	Bánh canh ghẹ Vũng Tàu	Món chính	50000	Sợi bánh canh trắng đục, mềm mịn và dai ngon, kết hợp với thịt ghẹ xé nhỏ, chả cua, huyết, trứng cút và bề bề (tùy theo quán), cùng với rau sống tươi ngon. Tuy nhiên, "linh hồn" của món bánh canh ghẹ nằm trong nước dùng sệt mà thơm ngào ngạt hương vị hải sản.	2025-01-03 06:09:44.223236	1
D055	Lẩu mắm miền Tây	Món chính	250000	Khi thưởng thức lẩu mắm, bạn sẽ được tận hưởng hương vị tuyệt vời cùng với bún tươi và đa dạng các loại rau thơm mát như rau nhút, điên điển, bông súng và nhiều loại rau khác. Miền Tây với những con sông trù phú đã tạo ra nhiều loại hải sản phong phú, từ đó mà món lẩu mắm được phát triển, mang đến một nét độc đáo và đậm chất của người dân miền sông nước.	2025-01-03 06:09:44.223236	1
D056	Bánh cống Cần Thơ	Món chính	20000	Trong vô vàn thức quà đặc sản miền Tây, món ăn dân dã bánh công Cần Thơ vẫn có một "chỗ đứng" trong lòng biết bao du khách bởi sự hòa quyện tuyệt vời của vị giòn của vỏ bánh, hương vị tươi ngon của tôm, và hương vị chua cay của nước chấm thơm ngon, được kết hợp tuyệt vời với các loại rau sống tươi mát. Dù là một món ăn dân dã, bánh cống đã trở thành một biểu tượng đặc sản không thể thiếu trong hành trình khám phá ẩm thực Cần Thơ.	2025-01-03 06:09:44.223236	1
D057	Bánh khọt Vũng Tàu	Món chính	70000	Bánh khọt với lớp vỏ giòn vàng ươm, ôm lấy phần nhân tôm “siêu to, khổng lồ”, cuốn rau sống rồi chấm với nước mắm chua ngọt “thần thánh”. Đảm bảo mọi giác quan của bạn sẽ bừng tỉnh ngay sau miếng bánh thơm ngon đầu tiên. 	2025-01-03 06:09:44.223236	1
D058	Chè trôi nước	Tráng miệng	15000	Món chè vào những dịp đặc biệt như: tết, lễ sâu bọ hay cúng rằm, cúng thôi nôi… Những viên chè từ gạo nếp mềm dẻo kiểu mochi, thường bọc nhân đậu xanh, vừng đen hoặc vừng dùa bên trong. Được rưới nước đường gừng và hạt vừng, ăn kèm với một chút nước cốt dừa. Vậy nên món chè trôi nước phù hợp khi cơn gió mùa đầu tiên len mình vào thành phố. 	2025-01-03 06:09:44.223236	1
D059	Chè bắp Hội An	Tráng miệng	15000	Chè bắp được nấu từ bắp trồng ở vùng đất Cẩm Nam – Hội An, những trái bắp có hương vị ngon ngọt đặc trưng, vừa dẻo vừa thơm hơn rất nhiều các loại bắp trồng ở vùng đất khác. Chính vì vậy, khi thưởng thức chè bắp Hội An sự bùi bùi, ngọt thanh của bắp kết hợp với sự béo ngậy của nước cốt dừa, thêm phần nhấn nhá với vị thơm vừng, dai dai của bột báng hay giòn ngọt của dừa khô. Món tráng miệng chứa đựng cái nắng vàng ươm như “rải mật” của vùng đất miền Trung nắng gió.	2025-01-03 06:09:44.223236	1
D060	Sữa chua nếp cẩm	Tráng miệng	15000	Sự kết hợp thú vị giữa kết cấu mịn mướt sữa chua và dẻo quánh của nếp cẩm, giữa vị chua thanh và ngọt dịu. Là món tráng miệng hấp dẫn, tốt cho làn da và cả hệ tiêu hóa của bạn. Sữa chua nếp cẩm Ba Vì, Mộc Châu là nổi tiếng với nguyên liệu hoàn toàn tự nhiên, không chất bảo quản và hương vị đúng chuẩn nhất.	2025-01-03 06:09:44.223236	1
D061	Chè sương sa hạt lựu	Tráng miệng	15000	Món chè này được phục vụ trong một chiếc ly cao trang trí từng lớp rực rỡ. Đậu đỏ, đậu xanh, thạch lá dứa, hạt lựu giả và nhiều nguyên liệu bắt mắt khác được xếp chồng lên nhau, phủ đá nghiền và nước cốt dừa đặc lên trên.	2025-01-03 06:09:44.223236	1
D062	Hoa quả dầm	Tráng miệng	15000	Món ăn vặt lành mạnh này bao gồm trái cây tươi các loại như bao gồm mít, kiwi, dưa hấu, táo và thậm chí cả bơ…hòa quyện trong sữa chua, kem béo và đá bào. Đôi khi, thêm thạch lá dứa hoặc khoai dẻo để đa dạng về kết cấu. Yếu tố chính để làm món này ngon tuyệt chính là nguyên liệu tươi ngon và “mùa nào thức ấy”!	2025-01-03 06:09:44.223236	1
D063	Kem trái dừa	Tráng miệng	35000	Kem dừa mát lạnh, ngọt ngào được phục vụ trong quả dừa với bất kỳ loại topping nào bạn thích như: đậu phộng, đậu đỏ, trân châu, sốt caramel, bánh quy hay trái cây tươi. 	2025-01-03 06:09:44.223236	1
D064	Chè khúc bạch	Tráng miệng	20000	Vị chè ngọt dịu và thơm nhẹ, kết cấu núng nính hấp dẫn, món tráng miệng này có thể được coi là món panna cotta của Việt Nam. Phần khúc bạch được cắt thành từng miếng vừa, ăn kèm với: nhãn, vải, hạnh nhân… hài hòa hương vị.	2025-01-03 06:09:44.223236	1
D065	Bánh Flan	Tráng miệng	25000	Bánh Flan (hay Caramen) là chiếc bánh được làm từ sữa và trứng gà đem đến sự mềm mịn, béo ngậy, tan ra trong miệng. Có thể đơn giản kết hợp với cà phê đắng tạo nên sự cân bằng vị giác hay trở thành topping cho chè, trà sữa. Món đồ ngọt xuất hiện trên mọi menu của các hàng quán Việt Nam, khiến bạn khó lòng chối từ.	2025-01-03 06:09:44.223236	1
D066	Bánh su kem	Tráng miệng	15000	Ai lại không thích một chiếc bánh nhân kem núng nính nhỉ? Lớp vỏ mềm mỏng, bên trong ngập nhân với vô số sự chọn lựa: Nhân vani thơm sữa, socola ngọt đậm, matcha nhật thơm trà vị đắng nhẹ, phô mai ngọt ngọt mặn mặn, có cả nhân sầu riêng thơm thoang ngây ngất và béo ngậy.	2025-01-03 06:09:44.223236	1
D067	Kem xôi	Tráng miệng	15000	Xôi lá dứa xanh rất dẻo, thơm lừng kết hợp với kem dừa hơi ngọt tạo nên sự kết hợp vừa vặn đến bất ngờ. Vừa sảng khoái trong ngày nắng nóng, vừa thưởng thức thứ quà vặt truyền thống khi đến Việt Nam.	2025-01-03 06:09:44.223236	1
D001	Súp gà rau củ	Khai vị	30000	Món súp gà với nước dùng thanh ngọt, nấu từ gà thả vườn hầm kỹ, kết hợp với nấm và bắp ngọt tạo nên vị dịu nhẹ và ấm áp. Thịt gà mềm, thơm, đem lại cảm giác dễ chịu và bổ dưỡng, giúp kích thích vị giác cho bữa ăn thêm ngon miệng.	2025-01-03 06:09:44.223236	0
\.


--
-- TOC entry 4992 (class 0 OID 32929)
-- Dependencies: 220
-- Data for Name: order_dishes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_dishes (order_id, dish_id, quantity) FROM stdin;
1	D015	1
1	D004	1
1	D036	1
2	D014	1
2	D012	1
2	D055	1
3	D030	3
4	D004	1
4	D026	2
4	D054	3
5	D001	3
5	D021	2
6	D036	1
6	D020	2
7	D012	2
8	D046	2
9	D034	3
9	D006	1
9	D059	2
10	D038	3
11	D047	1
11	D025	3
11	D009	1
12	D011	1
12	D030	2
13	D059	1
13	D047	2
14	D027	3
14	D035	3
15	D010	1
15	D022	2
15	D032	2
16	D029	1
16	D042	1
17	D041	2
18	D009	3
18	D028	3
19	D028	2
19	D064	3
20	D019	1
20	D034	1
21	D034	2
21	D055	1
21	D052	1
22	D064	1
22	D012	1
22	D007	3
23	D055	3
24	D050	2
25	D060	3
25	D033	3
25	D002	1
26	D035	2
26	D044	2
26	D015	1
27	D001	3
27	D034	1
28	D014	3
28	D039	1
28	D065	1
29	D021	3
29	D001	2
30	D003	2
30	D015	2
31	D008	1
32	D011	3
32	D063	1
32	D009	1
33	D061	3
33	D022	3
33	D034	2
34	D026	3
35	D052	2
35	D048	3
36	D016	1
36	D032	1
37	D003	3
37	D030	1
38	D010	3
39	D008	1
39	D030	2
39	D009	1
40	D031	1
40	D036	3
40	D063	1
41	D061	1
41	D032	1
41	D053	1
42	D056	2
42	D046	2
42	D055	3
43	D013	1
44	D044	1
44	D014	1
45	D058	1
46	D024	2
46	D036	1
47	D057	3
48	D007	3
49	D002	1
49	D012	2
49	D031	2
50	D028	1
50	D052	1
51	D001	2
51	D050	2
52	D055	1
52	D063	1
53	D028	3
53	D008	3
54	D008	3
54	D041	2
54	D007	3
55	D021	1
55	D008	1
55	D066	1
56	D009	1
56	D031	3
56	D052	1
57	D006	3
57	D011	3
57	D054	3
58	D041	3
58	D034	3
58	D027	2
59	D034	2
60	D039	2
61	D010	2
61	D002	3
62	D013	3
62	D010	2
62	D028	1
63	D009	2
63	D032	2
64	D057	3
65	D039	1
65	D002	2
65	D014	1
66	D020	2
67	D027	1
67	D044	3
68	D034	2
68	D065	1
68	D063	1
69	D055	1
69	D036	2
69	D006	1
70	D034	3
70	D021	3
70	D057	2
71	D002	3
71	D015	1
71	D010	3
72	D048	3
73	D019	1
73	D056	2
73	D017	2
74	D046	1
75	D032	3
75	D014	2
75	D046	3
76	D020	1
76	D031	2
76	D021	1
77	D043	2
78	D032	3
78	D035	1
78	D021	2
79	D061	1
80	D059	2
81	D030	1
81	D029	3
82	D052	2
83	D009	2
83	D036	3
84	D052	1
84	D043	2
84	D004	1
85	D034	3
85	D005	2
85	D014	2
86	D041	1
86	D056	2
86	D066	3
87	D033	1
88	D056	3
88	D001	3
88	D067	3
89	D026	1
89	D047	3
89	D056	2
90	D041	3
90	D016	2
90	D039	3
91	D042	3
91	D052	2
92	D017	3
92	D025	2
92	D054	3
93	D023	3
93	D039	1
93	D052	2
94	D027	3
94	D056	3
95	D042	2
95	D060	3
95	D057	1
96	D061	2
96	D022	3
96	D011	3
97	D043	3
97	D012	2
97	D031	1
98	D019	1
99	D032	2
100	D010	3
100	D059	3
100	D054	1
101	D050	1
101	D064	1
101	D052	3
102	D001	1
102	D014	1
102	D055	3
103	D060	1
103	D007	2
103	D032	1
104	D041	3
104	D057	3
105	D055	3
105	D058	2
105	D021	2
106	D032	3
106	D036	2
107	D031	1
107	D036	3
107	D057	2
108	D035	2
109	D011	1
109	D018	1
110	D020	1
110	D028	2
111	D043	2
111	D060	1
112	D054	2
113	D003	1
113	D049	2
113	D062	2
114	D054	2
114	D029	1
115	D056	1
115	D063	2
116	D052	2
116	D022	1
117	D004	3
117	D051	2
117	D011	1
118	D024	2
118	D007	2
119	D028	2
119	D059	2
120	D036	2
120	D054	1
121	D003	2
121	D007	1
122	D009	1
122	D006	1
122	D004	1
123	D020	2
123	D031	3
123	D017	1
124	D028	2
124	D060	1
124	D033	3
125	D015	1
125	D021	3
125	D040	1
126	D049	3
126	D051	1
127	D032	1
128	D039	2
128	D016	3
128	D006	2
129	D048	3
129	D009	2
129	D065	1
130	D063	2
130	D014	2
131	D059	1
131	D020	3
131	D056	3
132	D035	2
132	D062	3
132	D060	3
133	D042	1
133	D032	2
134	D032	3
134	D060	3
135	D049	2
135	D044	2
135	D004	1
136	D028	2
136	D046	2
137	D036	3
137	D002	1
138	D031	3
139	D063	3
139	D031	2
140	D063	1
140	D058	2
140	D003	1
141	D032	3
141	D040	3
142	D061	2
142	D045	3
143	D043	2
143	D046	2
143	D059	2
144	D016	3
145	D041	1
146	D024	3
146	D025	2
146	D028	2
147	D037	2
147	D013	1
147	D025	2
148	D039	1
149	D017	1
149	D036	3
149	D006	2
150	D017	1
150	D063	3
150	D014	2
151	D062	2
151	D057	1
152	D033	2
153	D009	2
154	D010	1
154	D007	1
155	D039	1
155	D011	3
155	D032	2
156	D029	2
156	D067	2
156	D049	2
157	D055	3
157	D040	3
157	D008	1
158	D028	2
159	D011	1
159	D021	3
159	D031	1
160	D001	2
161	D061	1
161	D038	1
162	D037	1
162	D059	3
163	D034	3
164	D026	3
164	D055	1
164	D015	3
165	D035	1
166	D008	1
167	D037	1
167	D057	2
168	D039	3
168	D052	3
168	D035	2
169	D011	2
169	D006	3
170	D033	1
170	D004	1
171	D003	1
171	D035	2
171	D006	3
172	D057	3
172	D036	2
172	D024	3
173	D012	2
173	D061	2
174	D042	1
174	D014	2
175	D064	3
175	D037	2
176	D005	2
176	D059	2
176	D012	2
177	D052	3
178	D060	2
179	D025	3
180	D064	1
180	D057	1
181	D017	2
181	D037	3
182	D016	3
182	D004	3
183	D021	2
184	D002	1
184	D053	1
184	D012	2
185	D020	2
186	D038	2
186	D066	2
186	D035	2
187	D059	3
188	D050	1
189	D066	2
189	D018	2
189	D009	2
190	D035	3
190	D001	2
190	D037	3
191	D063	3
191	D020	2
191	D058	2
192	D049	2
192	D059	1
193	D031	2
193	D050	1
193	D030	2
194	D061	3
194	D049	3
194	D050	1
195	D005	3
195	D017	3
196	D013	1
196	D057	3
197	D002	2
197	D019	3
198	D010	2
199	D044	3
199	D051	1
200	D049	3
200	D041	3
201	D005	1
201	D009	3
202	D037	2
202	D030	1
202	D012	3
203	D013	3
203	D057	2
203	D022	1
204	D042	1
205	D046	2
205	D048	1
206	D053	3
207	D024	1
207	D022	3
207	D023	2
208	D031	1
208	D064	2
208	D019	3
209	D059	3
209	D033	1
210	D037	1
210	D021	2
211	D039	3
211	D055	2
212	D039	2
212	D026	2
213	D031	2
214	D046	3
214	D038	2
214	D003	2
215	D007	3
216	D064	3
216	D037	2
216	D030	1
217	D025	3
217	D033	1
217	D018	3
218	D006	1
218	D040	3
218	D057	2
219	D017	2
219	D012	3
219	D038	2
220	D026	1
221	D047	1
221	D065	2
221	D035	2
222	D044	2
222	D015	1
223	D029	3
224	D051	2
224	D047	1
224	D012	2
225	D016	3
225	D059	3
225	D048	3
226	D049	1
226	D048	3
227	D061	1
228	D042	3
228	D029	2
228	D009	3
229	D053	1
229	D015	1
230	D039	2
231	D013	1
232	D018	2
232	D050	3
232	D059	3
233	D054	2
233	D020	3
233	D013	2
234	D005	1
234	D048	2
235	D031	1
235	D047	3
236	D046	2
236	D008	2
237	D016	2
238	D028	3
239	D003	1
239	D007	1
239	D043	3
240	D009	3
241	D028	1
242	D019	2
242	D001	1
243	D033	1
244	D004	1
245	D046	1
246	D042	2
246	D003	1
246	D023	1
247	D054	2
247	D015	2
247	D009	2
248	D014	1
248	D058	3
248	D065	1
249	D067	3
249	D039	1
249	D059	1
250	D052	3
250	D055	1
251	D057	1
251	D010	2
252	D019	2
252	D009	3
252	D017	3
253	D042	2
253	D049	3
253	D038	3
254	D013	3
254	D015	3
255	D028	1
255	D056	2
255	D058	2
256	D052	3
256	D054	1
257	D055	3
257	D041	2
258	D020	1
258	D061	1
259	D012	2
260	D048	1
261	D008	2
261	D043	2
261	D016	3
262	D007	3
262	D037	2
263	D014	1
263	D065	1
264	D062	2
264	D029	3
264	D014	2
265	D036	3
266	D055	3
267	D004	2
267	D035	3
267	D024	2
268	D045	1
268	D001	1
269	D052	3
269	D009	3
269	D019	1
270	D028	2
271	D059	1
271	D044	2
272	D042	1
272	D011	1
273	D007	3
274	D035	2
275	D055	2
275	D063	2
275	D057	1
276	D015	1
276	D045	2
276	D056	3
277	D063	1
277	D040	2
277	D006	3
278	D001	1
279	D028	2
279	D018	2
280	D016	2
280	D001	3
281	D023	2
281	D017	3
282	D030	1
282	D065	2
282	D046	3
283	D056	1
284	D010	3
284	D041	2
285	D052	1
285	D054	2
285	D038	1
286	D022	3
286	D059	2
287	D056	1
288	D056	3
289	D011	2
289	D051	3
290	D029	1
290	D043	1
291	D015	2
291	D066	2
291	D025	3
292	D019	1
292	D031	2
292	D014	1
293	D020	3
294	D023	3
295	D060	3
295	D058	3
296	D042	2
296	D041	1
296	D020	2
297	D039	3
297	D036	1
298	D065	2
298	D010	2
299	D005	2
299	D008	2
300	D012	3
301	D065	3
301	D050	3
301	D060	3
302	D058	3
303	D025	3
303	D042	1
303	D061	1
304	D014	3
304	D044	1
305	D023	3
305	D006	2
305	D032	2
306	D067	2
306	D021	2
306	D047	2
307	D044	3
307	D007	3
308	D009	1
308	D043	3
309	D050	3
309	D037	3
309	D033	3
310	D043	1
311	D019	3
311	D045	3
311	D040	3
312	D017	2
312	D011	3
313	D043	3
313	D017	3
314	D012	2
314	D055	1
314	D066	2
315	D024	2
315	D028	2
316	D029	1
317	D010	2
318	D065	3
319	D005	3
319	D044	2
319	D017	1
320	D024	3
321	D022	2
321	D057	2
321	D006	3
322	D031	3
322	D057	2
322	D037	1
323	D031	1
323	D040	2
323	D061	3
324	D057	2
324	D060	3
324	D037	3
325	D021	3
325	D026	1
326	D007	2
326	D062	3
327	D067	1
328	D011	2
328	D021	2
329	D019	1
329	D056	2
329	D012	2
330	D054	1
331	D065	1
331	D048	2
332	D048	1
333	D041	1
334	D043	1
334	D019	2
334	D018	2
335	D018	3
335	D061	1
335	D058	1
336	D033	1
337	D055	1
338	D031	1
338	D039	1
339	D054	3
340	D059	2
340	D009	3
340	D015	3
341	D066	3
342	D019	2
343	D001	1
343	D046	3
344	D024	3
344	D011	2
345	D065	3
346	D003	1
346	D050	3
346	D061	2
347	D033	2
347	D003	1
348	D031	3
348	D014	3
349	D018	2
349	D006	3
350	D023	3
350	D060	2
351	D024	3
351	D018	2
351	D009	1
352	D026	1
352	D006	1
353	D040	2
353	D066	3
354	D033	3
354	D005	1
355	D046	3
355	D007	2
356	D016	2
356	D048	2
357	D057	1
357	D050	2
357	D044	3
358	D048	2
358	D067	1
359	D055	3
359	D011	1
359	D056	3
360	D042	1
360	D014	2
361	D038	3
361	D040	3
361	D058	2
362	D057	2
363	D006	3
363	D046	2
364	D008	3
364	D010	3
365	D047	3
365	D066	3
366	D004	1
367	D057	1
367	D005	1
367	D017	3
368	D047	3
368	D050	1
369	D020	2
369	D058	2
369	D048	1
370	D018	2
370	D047	3
370	D051	2
371	D015	1
372	D024	2
372	D064	3
372	D067	1
373	D034	1
373	D058	3
374	D063	1
374	D026	1
375	D058	1
376	D057	3
376	D012	2
376	D041	3
377	D038	2
378	D023	2
379	D029	1
379	D016	1
379	D026	2
380	D047	3
381	D048	3
381	D060	1
381	D017	1
382	D051	3
382	D062	2
383	D010	2
383	D017	3
384	D058	2
385	D067	3
385	D045	3
385	D017	3
386	D017	2
387	D008	1
387	D016	2
387	D067	1
388	D042	3
389	D045	3
390	D011	1
390	D033	3
391	D036	3
391	D017	3
391	D039	1
392	D022	3
392	D020	1
392	D044	1
393	D006	3
394	D034	3
394	D027	3
394	D054	1
395	D038	2
395	D039	1
396	D052	1
396	D039	3
396	D059	1
397	D057	2
398	D060	2
398	D027	3
399	D041	3
400	D045	1
400	D052	2
401	D014	2
401	D041	1
401	D031	2
402	D032	1
402	D019	1
403	D050	1
403	D054	1
404	D041	1
404	D025	2
405	D060	2
405	D064	1
405	D040	1
406	D065	1
406	D059	1
407	D046	2
407	D007	3
407	D037	3
408	D061	1
408	D037	2
408	D002	1
409	D047	2
409	D052	1
410	D007	2
410	D025	3
411	D010	3
411	D050	2
412	D036	1
412	D016	2
412	D017	2
413	D047	1
413	D019	3
414	D052	1
414	D065	1
414	D006	1
415	D043	2
415	D061	1
415	D067	3
416	D018	1
416	D042	2
416	D041	3
417	D039	3
417	D044	3
417	D065	2
418	D039	2
418	D061	2
418	D003	3
419	D054	3
420	D004	2
420	D061	3
421	D030	1
421	D007	3
421	D062	3
422	D049	1
422	D019	3
422	D032	3
423	D025	1
424	D041	1
424	D054	2
425	D027	3
425	D053	2
425	D065	3
426	D008	1
426	D018	3
426	D067	2
427	D062	1
427	D049	2
427	D041	3
428	D046	3
428	D034	2
429	D032	2
430	D039	3
430	D029	1
430	D037	3
431	D063	2
431	D041	3
431	D062	3
432	D037	3
432	D016	3
433	D049	1
433	D051	2
433	D045	1
434	D011	2
434	D045	3
435	D062	1
435	D028	3
436	D035	1
436	D018	3
437	D031	3
437	D032	3
437	D007	1
438	D030	2
438	D007	2
438	D013	3
439	D013	1
439	D018	3
440	D053	3
441	D062	2
441	D026	2
442	D008	3
442	D012	3
443	D005	1
444	D023	2
444	D005	2
445	D038	1
446	D039	3
447	D014	2
447	D043	3
447	D037	3
448	D064	2
448	D018	2
448	D065	1
449	D043	1
450	D059	1
450	D033	3
450	D024	2
512	D001	6
512	D002	4
512	D021	2
514	D002	3
515	D001	1
516	D001	4
516	D002	1
517	D001	4
517	D002	1
518	D001	4
518	D002	1
519	D001	4
519	D002	1
\.


--
-- TOC entry 4993 (class 0 OID 32932)
-- Dependencies: 221
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, user_id, order_type, booking_id, order_date, status, delivery_address, created_at, updated_at) FROM stdin;
1	655	0	1	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
2	115	0	2	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
3	26	0	3	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
4	760	0	4	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
5	282	0	5	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
6	251	0	6	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
7	229	0	7	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
8	143	0	8	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
9	755	0	9	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
10	105	0	10	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
11	693	0	11	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
12	759	0	12	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
13	914	0	13	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
14	559	0	14	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
15	90	0	15	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
16	605	0	16	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
17	433	0	17	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
18	33	0	18	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
19	31	0	19	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
20	96	0	20	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
21	224	0	21	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
22	239	0	22	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
23	518	0	23	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
24	617	0	24	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
25	28	0	25	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
26	575	0	26	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
27	204	0	27	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
28	734	0	28	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
29	666	0	29	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
30	719	0	30	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
31	987	0	31	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
32	430	0	32	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
33	226	0	33	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
34	460	0	34	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
35	604	0	35	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
36	285	0	36	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
37	829	0	37	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
38	891	0	38	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
39	7	0	39	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
40	778	0	40	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
41	826	0	41	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
42	164	0	42	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
43	715	0	43	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
44	984	0	44	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
45	349	0	45	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
46	965	0	46	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
47	160	0	47	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
48	221	0	48	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
49	782	0	49	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
50	345	0	50	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
51	991	0	51	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
52	95	0	52	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
53	390	0	53	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
54	100	0	54	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
55	368	0	55	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
56	868	0	56	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
57	353	0	57	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
58	619	0	58	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
59	271	0	59	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
60	827	0	60	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
61	45	0	61	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
62	748	0	62	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
63	471	0	63	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
64	550	0	64	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
65	128	0	65	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
66	388	0	66	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
67	81	0	67	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
68	566	0	68	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
69	301	0	69	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
70	850	0	70	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
71	644	0	71	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
72	634	0	72	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
73	907	0	73	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
74	883	0	74	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
75	371	0	75	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
76	592	0	76	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
77	197	0	77	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
78	722	0	78	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
79	72	0	79	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
80	47	0	80	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
81	678	0	81	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
82	234	0	82	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
83	792	0	83	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
84	297	0	84	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
85	82	0	85	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
86	876	0	86	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
87	979	0	87	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
88	888	0	88	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
89	104	0	89	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
90	948	0	90	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
91	955	0	91	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
92	465	0	92	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
93	651	0	93	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
94	855	0	94	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
95	374	0	95	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
96	167	0	96	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
97	380	0	97	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
98	364	0	98	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
99	215	0	99	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
100	687	0	100	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
101	274	0	101	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
102	971	0	102	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
103	700	0	103	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
104	664	0	104	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
105	74	0	105	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
106	624	0	106	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
107	908	0	107	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
108	176	0	108	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
109	547	0	109	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
110	747	0	110	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
111	995	0	111	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
112	168	0	112	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
113	474	0	113	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
114	389	0	114	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
115	277	0	115	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
116	656	0	116	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
117	705	0	117	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
118	571	0	118	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
119	225	0	119	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
120	702	0	120	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
121	333	0	121	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
122	864	0	122	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
123	787	0	123	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
124	795	0	124	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
125	58	0	125	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
126	235	0	126	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
127	842	0	127	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
128	983	0	128	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
129	825	0	129	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
130	324	0	130	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
131	411	0	131	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
132	275	0	132	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
133	68	0	133	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
134	217	0	134	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
135	581	0	135	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
136	736	0	136	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
137	323	0	137	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
138	218	0	138	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
139	672	0	139	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
140	512	0	140	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
141	406	0	141	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
142	659	0	142	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
143	470	0	143	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
144	147	0	144	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
145	272	0	145	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
146	993	0	146	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
147	253	0	147	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
148	763	0	148	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
149	975	0	149	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
150	552	0	150	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
151	270	0	151	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
152	765	0	152	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
153	599	0	153	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
154	439	0	154	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
155	598	0	155	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
156	409	0	156	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
157	926	0	157	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
158	882	0	158	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
159	142	0	159	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
160	522	0	160	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
161	506	0	161	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
162	94	0	162	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
163	774	0	163	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
164	49	0	164	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
165	113	0	165	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
166	157	0	166	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
167	643	0	167	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
168	959	0	168	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
169	812	0	169	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
170	697	0	170	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
171	957	0	171	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
172	611	0	172	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
173	66	0	173	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
174	395	0	174	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
175	391	0	175	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
176	964	0	176	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
177	480	0	177	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
178	542	0	178	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
179	258	0	179	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
180	567	0	180	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
181	12	0	181	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
182	831	0	182	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
183	739	0	183	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
184	118	0	184	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
185	699	0	185	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
186	937	0	186	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
187	769	0	187	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
188	900	0	188	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
189	788	0	189	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
190	657	0	190	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
191	956	0	191	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
192	999	0	192	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
193	932	0	193	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
194	446	0	194	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
195	162	0	195	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
196	909	0	196	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
197	4	0	197	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
198	740	0	198	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
199	737	0	199	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
200	931	0	200	2025-01-03 06:11:42.166488	\N	\N	2025-01-03 06:11:42.166488	2025-01-03 06:11:42.166488
201	629	1	\N	2025-01-03 06:11:59.845415	3	9 Nguyễn Huệ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
202	972	1	\N	2025-01-03 06:11:59.845415	4	58 Nguyễn Thái Học, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
203	231	1	\N	2025-01-03 06:11:59.845415	3	45 Hàng Gai, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
204	637	1	\N	2025-01-03 06:11:59.845415	3	34 Nguyễn Chí Thanh, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
205	137	1	\N	2025-01-03 06:11:59.845415	1	1 Trường Chinh, Cầu Giấy	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
206	799	1	\N	2025-01-03 06:11:59.845415	1	5 Nguyễn Thái Học, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
207	381	1	\N	2025-01-03 06:11:59.845415	0	33 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
208	814	1	\N	2025-01-03 06:11:59.845415	3	40 Phan Đình Phùng, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
209	996	1	\N	2025-01-03 06:11:59.845415	3	15 Lý Thái Tổ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
210	776	1	\N	2025-01-03 06:11:59.845415	3	10 Tôn Đức Thắng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
211	257	1	\N	2025-01-03 06:11:59.845415	0	196 Đội Cấn, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
212	195	1	\N	2025-01-03 06:11:59.845415	4	34 Nguyễn Huệ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
213	475	1	\N	2025-01-03 06:11:59.845415	3	30 Tràng Tiền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
214	998	1	\N	2025-01-03 06:11:59.845415	2	43 Bà Triệu, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
215	206	1	\N	2025-01-03 06:11:59.845415	1	1 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
216	681	1	\N	2025-01-03 06:11:59.845415	1	Lotte Center Hanoi, 54 Liễu Giai, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
217	670	1	\N	2025-01-03 06:11:59.845415	3	14 Phan Đình Phùng, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
218	1	1	\N	2025-01-03 06:11:59.845415	3	1 Tràng Tiền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
219	762	1	\N	2025-01-03 06:11:59.845415	3	14 Đinh Tiên Hoàng, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
220	415	1	\N	2025-01-03 06:11:59.845415	2	56 Nguyễn Thái Học, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
221	614	1	\N	2025-01-03 06:11:59.845415	3	15 Quảng An, Tây Hồ	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
222	23	1	\N	2025-01-03 06:11:59.845415	1	56 Đường Láng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
223	145	1	\N	2025-01-03 06:11:59.845415	2	31 Cao Bá Quát, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
224	459	1	\N	2025-01-03 06:11:59.845415	3	47 Quốc Tử Giám, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
225	394	1	\N	2025-01-03 06:11:59.845415	3	45 Đặng Thái Thân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
226	310	1	\N	2025-01-03 06:11:59.845415	3	105 Cầu Giấy, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
227	75	1	\N	2025-01-03 06:11:59.845415	1	15 Phan Bội Châu, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
228	311	1	\N	2025-01-03 06:11:59.845415	3	8 Lê Đại Hành, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
229	717	1	\N	2025-01-03 06:11:59.845415	3	45 Đinh Tiên Hoàng, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
230	103	1	\N	2025-01-03 06:11:59.845415	0	50 Tôn Đức Thắng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
231	112	1	\N	2025-01-03 06:11:59.845415	3	12 Tạ Quang Bửu, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
232	930	1	\N	2025-01-03 06:11:59.845415	1	15 Chợ Đồng Xuân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
233	610	1	\N	2025-01-03 06:11:59.845415	0	56 Cầu Giấy, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
234	88	1	\N	2025-01-03 06:11:59.845415	4	52 Mai Dịch, Cầu Giấy	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
235	673	1	\N	2025-01-03 06:11:59.845415	4	14 Tôn Đức Thắng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
236	163	1	\N	2025-01-03 06:11:59.845415	3	13 Tràng Tiền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
237	169	1	\N	2025-01-03 06:11:59.845415	3	26 Láng Hạ, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
238	840	1	\N	2025-01-03 06:11:59.845415	0	28 Trúc Khê, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
239	595	1	\N	2025-01-03 06:11:59.845415	3	30 Bạch Mai, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
240	692	1	\N	2025-01-03 06:11:59.845415	3	29 Trúc Khê, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
241	210	1	\N	2025-01-03 06:11:59.845415	1	12 Trúc Khê, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
242	339	1	\N	2025-01-03 06:11:59.845415	3	40 Hàng Bài, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
243	667	1	\N	2025-01-03 06:11:59.845415	0	11 Phan Bội Châu, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
244	773	1	\N	2025-01-03 06:11:59.845415	4	26 Nguyễn Huệ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
245	531	1	\N	2025-01-03 06:11:59.845415	2	16 Nguyễn Thái Học, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
246	276	1	\N	2025-01-03 06:11:59.845415	3	50 Tràng Tiền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
247	977	1	\N	2025-01-03 06:11:59.845415	3	6 Tô Hiệu, Cầu Giấy	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
248	928	1	\N	2025-01-03 06:11:59.845415	3	66 Nguyễn Thái Học, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
249	877	1	\N	2025-01-03 06:11:59.845415	3	30 Giảng Võ, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
250	260	1	\N	2025-01-03 06:11:59.845415	1	29 Đào Tấn, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
251	906	1	\N	2025-01-03 06:11:59.845415	4	45 Giảng Võ, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
252	400	1	\N	2025-01-03 06:11:59.845415	3	57B Đinh Tiên Hoàng, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
253	502	1	\N	2025-01-03 06:11:59.845415	4	18 Đường Láng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
254	854	1	\N	2025-01-03 06:11:59.845415	3	Long Biên, Hà Nội	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
255	828	1	\N	2025-01-03 06:11:59.845415	3	2 Hoa Lư, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
256	981	1	\N	2025-01-03 06:11:59.845415	4	26 Bà Triệu, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
257	548	1	\N	2025-01-03 06:11:59.845415	0	12 Hàng Bài, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
258	649	1	\N	2025-01-03 06:11:59.845415	1	99 Chùa Bộc, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
259	565	1	\N	2025-01-03 06:11:59.845415	0	13 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
260	155	1	\N	2025-01-03 06:11:59.845415	3	5 Phan Đình Phùng, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
261	318	1	\N	2025-01-03 06:11:59.845415	3	40 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
262	293	1	\N	2025-01-03 06:11:59.845415	2	16 Tô Hiệu, Cầu Giấy	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
263	83	1	\N	2025-01-03 06:11:59.845415	3	Studio Yoga & Thiền	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
264	431	1	\N	2025-01-03 06:11:59.845415	3	44B Thái Thịnh, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
265	25	1	\N	2025-01-03 06:11:59.845415	2	15 Bạch Mai, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
266	746	1	\N	2025-01-03 06:11:59.845415	3	27 Bà Triệu, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
267	701	1	\N	2025-01-03 06:11:59.845415	1	43 Tô Hiệu, Cầu Giấy	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
268	299	1	\N	2025-01-03 06:11:59.845415	3	6 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
269	913	1	\N	2025-01-03 06:11:59.845415	0	60 Mai Dịch, Cầu Giấy	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
270	288	1	\N	2025-01-03 06:11:59.845415	4	29 Hòa Mã, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
271	10	1	\N	2025-01-03 06:11:59.845415	3	24 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
272	91	1	\N	2025-01-03 06:11:59.845415	1	21 Tôn Đức Thắng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
273	899	1	\N	2025-01-03 06:11:59.845415	0	55 Nguyễn Chí Thanh, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
274	805	1	\N	2025-01-03 06:11:59.845415	3	7 Hoàng Hoa Thám, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
275	76	1	\N	2025-01-03 06:11:59.845415	3	6 Minh Khai, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
276	298	1	\N	2025-01-03 06:11:59.845415	3	19 Trần Quang Khải, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
277	87	1	\N	2025-01-03 06:11:59.845415	3	20 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
278	40	1	\N	2025-01-03 06:11:59.845415	0	56 Trần Duy Hưng, Cầu Giấy	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
279	422	1	\N	2025-01-03 06:11:59.845415	3	14 Lê Duẩn, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
280	904	1	\N	2025-01-03 06:11:59.845415	1	36 Đinh Tiên Hoàng, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
281	646	1	\N	2025-01-03 06:11:59.845415	3	53 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
282	308	1	\N	2025-01-03 06:11:59.845415	3	9 Bạch Mai, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
283	356	1	\N	2025-01-03 06:11:59.845415	3	13 Phạm Ngọc Thạch, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
284	852	1	\N	2025-01-03 06:11:59.845415	0	1 Lý Thường Kiệt, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
285	952	1	\N	2025-01-03 06:11:59.845415	3	3/10 Trần Thái Tông, Cầu Giấy	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
286	280	1	\N	2025-01-03 06:11:59.845415	3	39 Bạch Mai, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
287	936	1	\N	2025-01-03 06:11:59.845415	3	24 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
288	173	1	\N	2025-01-03 06:11:59.845415	3	70 Đường Tôn Đức Thắng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
289	723	1	\N	2025-01-03 06:11:59.845415	3	15 Trúc Khê, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
290	729	1	\N	2025-01-03 06:11:59.845415	3	14 Trần Quang Khải, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
291	593	1	\N	2025-01-03 06:11:59.845415	1	31 Nguyễn Lương Bằng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
292	313	1	\N	2025-01-03 06:11:59.845415	3	5 Tràng Tiền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
293	880	1	\N	2025-01-03 06:11:59.845415	3	2 Phạm Ngọc Thạch, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
294	511	1	\N	2025-01-03 06:11:59.845415	3	18 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
295	246	1	\N	2025-01-03 06:11:59.845415	3	28 Đào Tấn, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
296	124	1	\N	2025-01-03 06:11:59.845415	3	21 Nguyễn Thái Học, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
297	127	1	\N	2025-01-03 06:11:59.845415	3	58 Láng Hạ, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
298	839	1	\N	2025-01-03 06:11:59.845415	3	27 Hồ Tây, Tây Hồ	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
299	539	1	\N	2025-01-03 06:11:59.845415	0	19 Ngọc Hà, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
300	450	1	\N	2025-01-03 06:11:59.845415	1	23 Lê Duẩn, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
301	939	1	\N	2025-01-03 06:11:59.845415	0	1 Giảng Võ, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
302	516	1	\N	2025-01-03 06:11:59.845415	3	11 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
303	586	1	\N	2025-01-03 06:11:59.845415	3	45 Hàng Bài, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
304	69	1	\N	2025-01-03 06:11:59.845415	3	88 Tràng Tiền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
305	857	1	\N	2025-01-03 06:11:59.845415	4	34 Nguyễn Lương Bằng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
306	834	1	\N	2025-01-03 06:11:59.845415	2	33 Lê Thái Tổ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
307	821	1	\N	2025-01-03 06:11:59.845415	3	Tây Hồ, Hà Nội	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
308	129	1	\N	2025-01-03 06:11:59.845415	3	28 Nguyễn Thái Học, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
309	78	1	\N	2025-01-03 06:11:59.845415	2	26 Nguyễn Lương Bằng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
310	507	1	\N	2025-01-03 06:11:59.845415	0	37 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
311	432	1	\N	2025-01-03 06:11:59.845415	2	58 Phan Đình Phùng, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
312	140	1	\N	2025-01-03 06:11:59.845415	1	17 Trúc Khê, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
313	319	1	\N	2025-01-03 06:11:59.845415	4	4 Hàng Bài, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
314	248	1	\N	2025-01-03 06:11:59.845415	3	36 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
315	875	1	\N	2025-01-03 06:11:59.845415	3	21 Giảng Võ, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
316	677	1	\N	2025-01-03 06:11:59.845415	3	8 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
317	562	1	\N	2025-01-03 06:11:59.845415	3	22 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
318	182	1	\N	2025-01-03 06:11:59.845415	1	10 Hồ Tây, Tây Hồ	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
319	530	1	\N	2025-01-03 06:11:59.845415	3	35 Tôn Đức Thắng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
320	238	1	\N	2025-01-03 06:11:59.845415	3	17 Tôn Đức Thắng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
321	892	1	\N	2025-01-03 06:11:59.845415	3	18 Tô Hiệu, Cầu Giấy	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
322	580	1	\N	2025-01-03 06:11:59.845415	3	10 Đặng Thái Thân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
323	320	1	\N	2025-01-03 06:11:59.845415	3	17 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
324	99	1	\N	2025-01-03 06:11:59.845415	1	30 Láng Hạ, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
325	555	1	\N	2025-01-03 06:11:59.845415	2	23 Hàng Bài, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
326	694	1	\N	2025-01-03 06:11:59.845415	3	44 Phan Đình Phùng, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
327	860	1	\N	2025-01-03 06:11:59.845415	3	5 Trúc Khê, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
328	63	1	\N	2025-01-03 06:11:59.845415	3	30 Đinh Tiên Hoàng, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
329	832	1	\N	2025-01-03 06:11:59.845415	0	99 Phan Đình Phùng, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
330	682	1	\N	2025-01-03 06:11:59.845415	3	8 Bà Triệu, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
331	19	1	\N	2025-01-03 06:11:59.845415	3	37A Hai Bà Trưng, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
332	123	1	\N	2025-01-03 06:11:59.845415	2	57 Phan Bội Châu, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
333	307	1	\N	2025-01-03 06:11:59.845415	1	2 Lý Thường Kiệt, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
334	211	1	\N	2025-01-03 06:11:59.845415	3	30 Lý Thường Kiệt, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
335	934	1	\N	2025-01-03 06:11:59.845415	4	27 Lý Thái Tổ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
336	889	1	\N	2025-01-03 06:11:59.845415	3	41 Trúc Khê, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
337	603	1	\N	2025-01-03 06:11:59.845415	3	20 Giảng Võ, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
338	279	1	\N	2025-01-03 06:11:59.845415	3	11 Giảng Võ, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
339	504	1	\N	2025-01-03 06:11:59.845415	3	59 Lý Thái Tổ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
340	901	1	\N	2025-01-03 06:11:59.845415	4	37 Lý Thái Tổ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
341	209	1	\N	2025-01-03 06:11:59.845415	4	42 Hàng Bài, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
342	482	1	\N	2025-01-03 06:11:59.845415	2	10 Tràng Tiền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
343	3	1	\N	2025-01-03 06:11:59.845415	3	56 Chùa Bộc, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
344	493	1	\N	2025-01-03 06:11:59.845415	3	10 Trần Quang Khải, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
345	942	1	\N	2025-01-03 06:11:59.845415	2	68 Phố Tràng Tiền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
346	570	1	\N	2025-01-03 06:11:59.845415	0	50 Lý Thái Tổ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
347	363	1	\N	2025-01-03 06:11:59.845415	3	18 Giảng Võ, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
348	869	1	\N	2025-01-03 06:11:59.845415	3	38 Nguyễn Thái Học, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
349	704	1	\N	2025-01-03 06:11:59.845415	0	7 Lý Thái Tổ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
350	612	1	\N	2025-01-03 06:11:59.845415	2	22 Láng Hạ, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
351	198	1	\N	2025-01-03 06:11:59.845415	4	11 Tô Ngọc Vân, Tây Hồ	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
352	890	1	\N	2025-01-03 06:11:59.845415	2	6 Đinh Tiên Hoàng, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
353	378	1	\N	2025-01-03 06:11:59.845415	1	69 Đội Cấn, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
354	284	1	\N	2025-01-03 06:11:59.845415	3	103 Hàng Bài, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
355	962	1	\N	2025-01-03 06:11:59.845415	4	19 Đào Tấn, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
356	732	1	\N	2025-01-03 06:11:59.845415	2	100 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
357	684	1	\N	2025-01-03 06:11:59.845415	3	27 Hòa Mã, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
358	859	1	\N	2025-01-03 06:11:59.845415	3	17 Giảng Võ, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
359	402	1	\N	2025-01-03 06:11:59.845415	2	36 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
360	73	1	\N	2025-01-03 06:11:59.845415	3	56 Lý Thái Tổ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
361	837	1	\N	2025-01-03 06:11:59.845415	3	12 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
362	742	1	\N	2025-01-03 06:11:59.845415	3	78 Thái Thịnh, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
363	597	1	\N	2025-01-03 06:11:59.845415	3	16 Hoàng Quốc Việt, Cầu Giấy	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
364	631	1	\N	2025-01-03 06:11:59.845415	3	36 Trần Quang Khải, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
365	976	1	\N	2025-01-03 06:11:59.845415	0	23 Trần Quang Khải, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
366	201	1	\N	2025-01-03 06:11:59.845415	3	25 Bạch Mai, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
367	992	1	\N	2025-01-03 06:11:59.845415	3	12 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
368	638	1	\N	2025-01-03 06:11:59.845415	1	58 Lê Duẩn, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
369	107	1	\N	2025-01-03 06:11:59.845415	0	18 Cầu Giấy, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
370	242	1	\N	2025-01-03 06:11:59.845415	3	25 Hồ Tây, Tây Hồ	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
371	951	1	\N	2025-01-03 06:11:59.845415	3	1 Bạch Mai, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
372	756	1	\N	2025-01-03 06:11:59.845415	0	33 Bà Triệu, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
373	898	1	\N	2025-01-03 06:11:59.845415	3	4 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
374	305	1	\N	2025-01-03 06:11:59.845415	2	6 Phạm Ngọc Thạch, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
375	508	1	\N	2025-01-03 06:11:59.845415	3	36 Lý Thường Kiệt, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
376	154	1	\N	2025-01-03 06:11:59.845415	1	57 Phan Chu Trinh, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
377	721	1	\N	2025-01-03 06:11:59.845415	3	12 Tôn Đức Thắng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
378	317	1	\N	2025-01-03 06:11:59.845415	3	22 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
379	731	1	\N	2025-01-03 06:11:59.845415	4	25 Nguyễn Thái Học, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
380	754	1	\N	2025-01-03 06:11:59.845415	1	27 Phan Đình Phùng, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
381	51	1	\N	2025-01-03 06:11:59.845415	3	56 Tô Ngọc Vân, Tây Hồ	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
382	108	1	\N	2025-01-03 06:11:59.845415	1	15 Ngô Quyền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
383	527	1	\N	2025-01-03 06:11:59.845415	4	13 Nguyễn Chí Thanh, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
384	741	1	\N	2025-01-03 06:11:59.845415	3	22 Cầu Giấy, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
385	714	1	\N	2025-01-03 06:11:59.845415	2	50 Bạch Mai, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
386	660	1	\N	2025-01-03 06:11:59.845415	3	14 Giảng Võ, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
387	404	1	\N	2025-01-03 06:11:59.845415	3	35 Nguyễn Chí Thanh, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
388	335	1	\N	2025-01-03 06:11:59.845415	3	50 Chùa Bộc, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
389	264	1	\N	2025-01-03 06:11:59.845415	3	14 Trúc Khê, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
390	800	1	\N	2025-01-03 06:11:59.845415	2	39 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
391	309	1	\N	2025-01-03 06:11:59.845415	0	23 Trúc Khê, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
392	815	1	\N	2025-01-03 06:11:59.845415	3	56 Phan Đình Phùng, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
393	499	1	\N	2025-01-03 06:11:59.845415	4	19 Tràng Tiền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
394	172	1	\N	2025-01-03 06:11:59.845415	3	21 Nguyễn Lương Bằng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
395	383	1	\N	2025-01-03 06:11:59.845415	3	24 Tràng Tiền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
396	574	1	\N	2025-01-03 06:11:59.845415	3	423 Lạc Long Quân, Tây Hồ	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
397	973	1	\N	2025-01-03 06:11:59.845415	3	22 Hàng Bài, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
398	93	1	\N	2025-01-03 06:11:59.845415	3	38 Ngọc Khánh, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
399	13	1	\N	2025-01-03 06:11:59.845415	3	56 Nguyễn Chí Thanh, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
400	576	1	\N	2025-01-03 06:11:59.845415	3	8 Đinh Tiên Hoàng, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
401	712	1	\N	2025-01-03 06:11:59.845415	3	27/52 Tô Ngọc Vân, Tây Hồ	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
402	131	1	\N	2025-01-03 06:11:59.845415	0	19 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
403	97	1	\N	2025-01-03 06:11:59.845415	1	15 Chùa Bộc, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
404	679	1	\N	2025-01-03 06:11:59.845415	3	29 Láng Hạ, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
405	822	1	\N	2025-01-03 06:11:59.845415	3	19 Nguyễn Huệ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
406	636	1	\N	2025-01-03 06:11:59.845415	0	13 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
407	772	1	\N	2025-01-03 06:11:59.845415	1	56 Đào Tấn, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
408	885	1	\N	2025-01-03 06:11:59.845415	3	36 Tôn Đức Thắng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
409	444	1	\N	2025-01-03 06:11:59.845415	0	458 Minh Khai, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
410	784	1	\N	2025-01-03 06:11:59.845415	1	46 Láng Hạ, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
411	315	1	\N	2025-01-03 06:11:59.845415	3	Trung tâm Văn hóa Nghệ thuật Việt Nam	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
412	468	1	\N	2025-01-03 06:11:59.845415	3	7 Tràng Tiền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
413	362	1	\N	2025-01-03 06:11:59.845415	3	32 Láng Hạ, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
414	791	1	\N	2025-01-03 06:11:59.845415	2	28a Điện Biên Phủ, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
415	923	1	\N	2025-01-03 06:11:59.845415	3	25 Nguyễn Lương Bằng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
416	685	1	\N	2025-01-03 06:11:59.845415	2	33 Nguyễn Huệ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
417	385	1	\N	2025-01-03 06:11:59.845415	3	58 Trần Quang Khải, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
418	668	1	\N	2025-01-03 06:11:59.845415	3	78 Bà Triệu, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
419	11	1	\N	2025-01-03 06:11:59.845415	3	13 Trần Quang Khải, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
420	912	1	\N	2025-01-03 06:11:59.845415	3	6 Láng Hạ, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
421	382	1	\N	2025-01-03 06:11:59.845415	3	12 Nguyễn Huệ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
422	135	1	\N	2025-01-03 06:11:59.845415	3	42 Bà Triệu, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
423	175	1	\N	2025-01-03 06:11:59.845415	0	21 Đường Tôn Đức Thắng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
424	338	1	\N	2025-01-03 06:11:59.845415	3	45 Nguyễn Thái Học, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
425	150	1	\N	2025-01-03 06:11:59.845415	2	43 Nguyễn Hữu Huân, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
426	138	1	\N	2025-01-03 06:11:59.845415	2	87 Láng Hạ, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
427	698	1	\N	2025-01-03 06:11:59.845415	4	29 Tràng Tiền, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
428	199	1	\N	2025-01-03 06:11:59.845415	3	27 Cổ Linh, Long Biên	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
429	347	1	\N	2025-01-03 06:11:59.845415	3	22 Tôn Đức Thắng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
430	359	1	\N	2025-01-03 06:11:59.845415	3	30 Lý Thái Tổ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
431	273	1	\N	2025-01-03 06:11:59.845415	3	56 Lý Thường Kiệt, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
432	437	1	\N	2025-01-03 06:11:59.845415	3	56 Tôn Đức Thắng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
433	263	1	\N	2025-01-03 06:11:59.845415	3	12 Bà Triệu, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
434	743	1	\N	2025-01-03 06:11:59.845415	3	20 Đào Tấn, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
435	635	1	\N	2025-01-03 06:11:59.845415	1	17 Hàng Bài, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
436	970	1	\N	2025-01-03 06:11:59.845415	3	7 Nguyễn Lương Bằng, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
437	322	1	\N	2025-01-03 06:11:59.845415	2	17 Phan Bội Châu, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
438	64	1	\N	2025-01-03 06:11:59.845415	0	10 Lê Duẩn, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
439	122	1	\N	2025-01-03 06:11:59.845415	3	43 Nguyễn Thái Học, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
440	811	1	\N	2025-01-03 06:11:59.845415	1	5 Minh Khai, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
441	354	1	\N	2025-01-03 06:11:59.845415	4	12 Đào Tấn, Ba Đình	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
442	56	1	\N	2025-01-03 06:11:59.845415	4	12 Nguyễn Chí Thanh, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
443	5	1	\N	2025-01-03 06:11:59.845415	4	18 Lý Thái Tổ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
444	425	1	\N	2025-01-03 06:11:59.845415	3	10 Nguyễn Huệ, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
445	171	1	\N	2025-01-03 06:11:59.845415	0	72A Nguyễn Trãi, Thanh Xuân	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
446	336	1	\N	2025-01-03 06:11:59.845415	4	33 Bạch Mai, Hai Bà Trưng	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
447	978	1	\N	2025-01-03 06:11:59.845415	3	58 Quốc Tử Giám, Đống Đa	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
448	554	1	\N	2025-01-03 06:11:59.845415	4	15 Lê Duẩn, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
449	535	1	\N	2025-01-03 06:11:59.845415	4	88 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
450	745	1	\N	2025-01-03 06:11:59.845415	3	15 Nguyễn Du, Hoàn Kiếm	2025-01-03 06:11:59.845415	2025-01-03 06:11:59.845415
512	1000	1	\N	2025-01-16 15:20:27.914046	0		2025-01-16 15:20:27.914046	2025-01-16 15:20:27.914046
513	1000	0	420	2025-01-16 15:20:56.643647	\N	\N	2025-01-16 15:20:56.643647	2025-01-16 15:20:56.643647
514	1000	1	\N	2025-01-17 14:50:58.517232	0		2025-01-17 14:50:58.517232	2025-01-17 14:50:58.517232
515	1050	1	\N	2025-01-21 11:16:58.47112	0	ádasd	2025-01-21 11:16:58.47112	2025-01-21 11:16:58.47112
516	1000	1	\N	2025-01-24 15:48:17.125157	0	asd	2025-01-24 15:48:17.125157	2025-01-24 15:48:17.125157
517	1000	1	\N	2025-01-24 15:49:03.526486	0		2025-01-24 15:49:03.526486	2025-01-24 15:49:03.526486
518	1000	1	\N	2025-01-24 15:49:35.576079	0		2025-01-24 15:49:35.576079	2025-01-24 15:49:35.576079
519	1000	1	\N	2025-01-24 15:49:59.047998	0		2025-01-24 15:49:59.047998	2025-01-24 15:49:59.047998
\.


--
-- TOC entry 4995 (class 0 OID 32945)
-- Dependencies: 223
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (payment_id, user_id, order_id, amount, payment_method, payment_status, payment_date) FROM stdin;
1	655	1	842000	0	0	2025-01-03 06:12:16.886015
2	115	2	265000	0	0	2025-01-03 06:12:16.886015
3	26	3	60000	0	1	2025-01-03 06:12:16.886015
4	760	4	215000	0	1	2025-01-03 06:12:16.886015
5	282	5	120000	0	1	2025-01-03 06:12:16.886015
6	251	6	816000	0	1	2025-01-03 06:12:16.886015
7	229	7	10000	0	1	2025-01-03 06:12:16.886015
8	143	8	70000	0	0	2025-01-03 06:12:16.886015
9	755	9	230000	0	1	2025-01-03 06:12:16.886015
10	105	10	600000	0	1	2025-01-03 06:12:16.886015
11	693	11	240000	0	1	2025-01-03 06:12:16.886015
12	759	12	45000	0	1	2025-01-03 06:12:16.886015
13	914	13	275000	0	1	2025-01-03 06:12:16.886015
14	559	14	450000	0	1	2025-01-03 06:12:16.886015
15	90	15	390000	0	1	2025-01-03 06:12:16.886015
16	605	16	65000	0	1	2025-01-03 06:12:16.886015
17	433	17	360000	0	1	2025-01-03 06:12:16.886015
18	33	18	195000	0	1	2025-01-03 06:12:16.886015
19	31	19	90000	0	1	2025-01-03 06:12:16.886015
20	96	20	50000	0	1	2025-01-03 06:12:16.886015
21	224	21	380000	0	2	2025-01-03 06:12:16.886015
22	239	22	235000	0	0	2025-01-03 06:12:16.886015
23	518	23	750000	0	1	2025-01-03 06:12:16.886015
24	617	24	40000	0	0	2025-01-03 06:12:16.886015
25	28	25	125000	0	0	2025-01-03 06:12:16.886015
26	575	26	357000	0	1	2025-01-03 06:12:16.886015
27	204	27	135000	0	1	2025-01-03 06:12:16.886015
28	734	28	505000	0	1	2025-01-03 06:12:16.886015
29	666	29	105000	0	1	2025-01-03 06:12:16.886015
30	719	30	214000	0	0	2025-01-03 06:12:16.886015
31	987	31	90000	0	1	2025-01-03 06:12:16.886015
32	430	32	100000	0	0	2025-01-03 06:12:16.886015
33	226	33	180000	0	0	2025-01-03 06:12:16.886015
34	460	34	45000	0	0	2025-01-03 06:12:16.886015
35	604	35	185000	0	1	2025-01-03 06:12:16.886015
36	285	36	158000	0	1	2025-01-03 06:12:16.886015
37	829	37	320000	0	1	2025-01-03 06:12:16.886015
38	891	38	180000	0	1	2025-01-03 06:12:16.886015
39	7	39	180000	0	1	2025-01-03 06:12:16.886015
40	778	40	2555000	0	1	2025-01-03 06:12:16.886015
41	826	41	175000	0	1	2025-01-03 06:12:16.886015
42	164	42	860000	0	0	2025-01-03 06:12:16.886015
43	715	43	9000	0	0	2025-01-03 06:12:16.886015
44	984	44	55000	0	1	2025-01-03 06:12:16.886015
45	349	45	15000	0	1	2025-01-03 06:12:16.886015
46	965	46	830000	0	1	2025-01-03 06:12:16.886015
47	160	47	210000	0	1	2025-01-03 06:12:16.886015
48	221	48	210000	0	1	2025-01-03 06:12:16.886015
49	782	49	285000	0	0	2025-01-03 06:12:16.886015
50	345	50	55000	0	1	2025-01-03 06:12:16.886015
51	991	51	100000	0	1	2025-01-03 06:12:16.886015
52	95	52	285000	0	1	2025-01-03 06:12:16.886015
53	390	53	315000	0	1	2025-01-03 06:12:16.886015
54	100	54	840000	0	1	2025-01-03 06:12:16.886015
55	368	55	120000	0	0	2025-01-03 06:12:16.886015
56	868	56	450000	0	0	2025-01-03 06:12:16.886015
57	353	57	360000	0	1	2025-01-03 06:12:16.886015
58	619	58	715000	0	1	2025-01-03 06:12:16.886015
59	271	59	90000	0	1	2025-01-03 06:12:16.886015
60	827	60	900000	0	1	2025-01-03 06:12:16.886015
61	45	61	225000	0	1	2025-01-03 06:12:16.886015
62	748	62	162000	0	1	2025-01-03 06:12:16.886015
63	471	63	400000	0	1	2025-01-03 06:12:16.886015
64	550	64	210000	0	1	2025-01-03 06:12:16.886015
65	128	65	530000	0	1	2025-01-03 06:12:16.886015
66	388	66	16000	0	2	2025-01-03 06:12:16.886015
67	81	67	155000	0	1	2025-01-03 06:12:16.886015
68	566	68	150000	0	1	2025-01-03 06:12:16.886015
69	301	69	1915000	0	1	2025-01-03 06:12:16.886015
70	850	70	320000	0	1	2025-01-03 06:12:16.886015
71	644	71	292000	0	1	2025-01-03 06:12:16.886015
72	634	72	105000	0	1	2025-01-03 06:12:16.886015
73	907	73	65000	0	0	2025-01-03 06:12:16.886015
74	883	74	35000	0	1	2025-01-03 06:12:16.886015
75	371	75	575000	0	1	2025-01-03 06:12:16.886015
76	592	76	263000	0	1	2025-01-03 06:12:16.886015
77	197	77	60000	0	1	2025-01-03 06:12:16.886015
78	722	78	610000	0	1	2025-01-03 06:12:16.886015
79	72	79	15000	0	1	2025-01-03 06:12:16.886015
80	47	80	30000	0	2	2025-01-03 06:12:16.886015
81	678	81	95000	0	1	2025-01-03 06:12:16.886015
82	234	82	80000	0	1	2025-01-03 06:12:16.886015
83	792	83	2500000	0	1	2025-01-03 06:12:16.886015
84	297	84	135000	0	1	2025-01-03 06:12:16.886015
85	82	85	315000	0	0	2025-01-03 06:12:16.886015
86	876	86	265000	0	1	2025-01-03 06:12:16.886015
87	979	87	15000	0	1	2025-01-03 06:12:16.886015
88	888	88	195000	0	1	2025-01-03 06:12:16.886015
89	104	89	445000	0	1	2025-01-03 06:12:16.886015
90	948	90	1906000	0	1	2025-01-03 06:12:16.886015
91	955	91	200000	0	1	2025-01-03 06:12:16.886015
92	465	92	220000	0	1	2025-01-03 06:12:16.886015
93	651	93	575000	0	1	2025-01-03 06:12:16.886015
94	855	94	120000	0	1	2025-01-03 06:12:16.886015
95	374	95	195000	0	0	2025-01-03 06:12:16.886015
96	167	96	90000	0	1	2025-01-03 06:12:16.886015
97	380	97	220000	0	1	2025-01-03 06:12:16.886015
98	364	98	5000	0	1	2025-01-03 06:12:16.886015
99	215	99	300000	0	0	2025-01-03 06:12:16.886015
100	687	100	275000	0	1	2025-01-03 06:12:16.886015
101	274	101	160000	0	1	2025-01-03 06:12:16.886015
102	971	102	790000	0	1	2025-01-03 06:12:16.886015
103	700	103	305000	0	2	2025-01-03 06:12:16.886015
104	664	104	750000	0	0	2025-01-03 06:12:16.886015
105	74	105	810000	0	0	2025-01-03 06:12:16.886015
106	624	106	2050000	0	1	2025-01-03 06:12:16.886015
107	908	107	2660000	0	1	2025-01-03 06:12:16.886015
108	176	108	260000	0	0	2025-01-03 06:12:16.886015
109	547	109	15000	0	1	2025-01-03 06:12:16.886015
110	747	110	38000	0	1	2025-01-03 06:12:16.886015
111	995	111	75000	0	1	2025-01-03 06:12:16.886015
112	168	112	100000	0	0	2025-01-03 06:12:16.886015
113	474	113	230000	0	0	2025-01-03 06:12:16.886015
114	389	114	125000	0	1	2025-01-03 06:12:16.886015
115	277	115	90000	0	1	2025-01-03 06:12:16.886015
116	656	116	95000	0	1	2025-01-03 06:12:16.886015
117	705	117	190000	0	0	2025-01-03 06:12:16.886015
118	571	118	170000	0	0	2025-01-03 06:12:16.886015
119	225	119	60000	0	0	2025-01-03 06:12:16.886015
120	702	120	1650000	0	1	2025-01-03 06:12:16.886015
121	333	121	270000	0	1	2025-01-03 06:12:16.886015
122	864	122	150000	0	1	2025-01-03 06:12:16.886015
123	787	123	386000	0	1	2025-01-03 06:12:16.886015
124	795	124	90000	0	1	2025-01-03 06:12:16.886015
125	58	125	1042000	0	1	2025-01-03 06:12:16.886015
126	235	126	190000	0	1	2025-01-03 06:12:16.886015
127	842	127	150000	0	0	2025-01-03 06:12:16.886015
128	983	128	1054000	0	1	2025-01-03 06:12:16.886015
129	825	129	230000	0	1	2025-01-03 06:12:16.886015
130	324	130	90000	0	0	2025-01-03 06:12:16.886015
131	411	131	99000	0	1	2025-01-03 06:12:16.886015
132	275	132	350000	0	1	2025-01-03 06:12:16.886015
133	68	133	340000	0	1	2025-01-03 06:12:16.886015
134	217	134	495000	0	1	2025-01-03 06:12:16.886015
135	581	135	225000	0	1	2025-01-03 06:12:16.886015
136	736	136	100000	0	1	2025-01-03 06:12:16.886015
137	323	137	2435000	0	1	2025-01-03 06:12:16.886015
138	218	138	360000	0	1	2025-01-03 06:12:16.886015
139	672	139	345000	0	1	2025-01-03 06:12:16.886015
140	512	140	165000	0	0	2025-01-03 06:12:16.886015
141	406	141	3420000	0	0	2025-01-03 06:12:16.886015
142	659	142	165000	0	0	2025-01-03 06:12:16.886015
143	470	143	160000	0	1	2025-01-03 06:12:16.886015
144	147	144	24000	0	0	2025-01-03 06:12:16.886015
145	272	145	180000	0	1	2025-01-03 06:12:16.886015
146	993	146	115000	0	1	2025-01-03 06:12:16.886015
147	253	147	129000	0	1	2025-01-03 06:12:16.886015
148	763	148	450000	0	1	2025-01-03 06:12:16.886015
149	975	149	2540000	0	1	2025-01-03 06:12:16.886015
150	552	150	135000	0	0	2025-01-03 06:12:16.886015
151	270	151	100000	0	1	2025-01-03 06:12:16.886015
152	765	152	30000	0	1	2025-01-03 06:12:16.886015
153	599	153	100000	0	1	2025-01-03 06:12:16.886015
154	439	154	130000	0	1	2025-01-03 06:12:16.886015
155	598	155	765000	0	1	2025-01-03 06:12:16.886015
156	409	156	180000	0	1	2025-01-03 06:12:16.886015
157	926	157	3810000	0	1	2025-01-03 06:12:16.886015
158	882	158	30000	0	1	2025-01-03 06:12:16.886015
159	142	159	170000	0	1	2025-01-03 06:12:16.886015
160	522	160	60000	0	1	2025-01-03 06:12:16.886015
161	506	161	215000	0	0	2025-01-03 06:12:16.886015
162	94	162	85000	0	1	2025-01-03 06:12:16.886015
163	774	163	135000	0	1	2025-01-03 06:12:16.886015
164	49	164	316000	0	1	2025-01-03 06:12:16.886015
165	113	165	130000	0	1	2025-01-03 06:12:16.886015
166	157	166	90000	0	2	2025-01-03 06:12:16.886015
167	643	167	180000	0	1	2025-01-03 06:12:16.886015
168	959	168	1730000	0	2	2025-01-03 06:12:16.886015
169	812	169	205000	0	1	2025-01-03 06:12:16.886015
170	697	170	50000	0	0	2025-01-03 06:12:16.886015
171	957	171	555000	0	1	2025-01-03 06:12:16.886015
172	611	172	1855000	0	1	2025-01-03 06:12:16.886015
173	66	173	40000	0	1	2025-01-03 06:12:16.886015
174	395	174	60000	0	1	2025-01-03 06:12:16.886015
175	391	175	140000	0	1	2025-01-03 06:12:16.886015
176	964	176	200000	0	1	2025-01-03 06:12:16.886015
177	480	177	120000	0	2	2025-01-03 06:12:16.886015
178	542	178	30000	0	2	2025-01-03 06:12:16.886015
179	258	179	60000	0	1	2025-01-03 06:12:16.886015
180	567	180	90000	0	1	2025-01-03 06:12:16.886015
181	12	181	140000	0	1	2025-01-03 06:12:16.886015
182	831	182	129000	0	0	2025-01-03 06:12:16.886015
183	739	183	30000	0	1	2025-01-03 06:12:16.886015
184	118	184	55000	0	1	2025-01-03 06:12:16.886015
185	699	185	16000	0	1	2025-01-03 06:12:16.886015
186	937	186	690000	0	0	2025-01-03 06:12:16.886015
187	769	187	45000	0	1	2025-01-03 06:12:16.886015
188	900	188	20000	0	1	2025-01-03 06:12:16.886015
189	788	189	150000	0	1	2025-01-03 06:12:16.886015
190	657	190	570000	0	1	2025-01-03 06:12:16.886015
191	956	191	151000	0	1	2025-01-03 06:12:16.886015
192	999	192	115000	0	1	2025-01-03 06:12:16.886015
193	932	193	300000	0	1	2025-01-03 06:12:16.886015
194	446	194	215000	0	1	2025-01-03 06:12:16.886015
195	162	195	270000	0	1	2025-01-03 06:12:16.886015
196	909	196	219000	0	1	2025-01-03 06:12:16.886015
197	4	197	85000	0	1	2025-01-03 06:12:16.886015
198	740	198	120000	0	1	2025-01-03 06:12:16.886015
199	737	199	175000	0	1	2025-01-03 06:12:16.886015
200	931	200	690000	0	0	2025-01-03 06:12:16.886015
201	629	201	230000	0	1	2025-01-03 06:12:16.886015
202	972	202	115000	0	1	2025-01-03 06:12:16.886015
203	231	203	182000	0	1	2025-01-03 06:12:16.886015
204	637	204	40000	0	0	2025-01-03 06:12:16.886015
205	137	205	105000	0	1	2025-01-03 06:12:16.886015
206	799	206	30000	0	1	2025-01-03 06:12:16.886015
207	381	207	90000	0	1	2025-01-03 06:12:16.886015
208	814	208	175000	0	1	2025-01-03 06:12:16.886015
209	996	209	60000	0	1	2025-01-03 06:12:16.886015
210	776	210	70000	0	1	2025-01-03 06:12:16.886015
211	257	211	1850000	0	1	2025-01-03 06:12:16.886015
212	195	212	930000	0	1	2025-01-03 06:12:16.886015
213	475	213	240000	0	2	2025-01-03 06:12:16.886015
214	998	214	705000	0	1	2025-01-03 06:12:16.886015
215	206	215	210000	0	0	2025-01-03 06:12:16.886015
216	681	216	160000	0	1	2025-01-03 06:12:16.886015
217	670	217	105000	0	1	2025-01-03 06:12:16.886015
218	1	218	3175000	0	1	2025-01-03 06:12:16.886015
219	762	219	435000	0	0	2025-01-03 06:12:16.886015
220	415	220	15000	0	0	2025-01-03 06:12:16.886015
221	614	221	440000	0	1	2025-01-03 06:12:16.886015
222	23	222	97000	0	2	2025-01-03 06:12:16.886015
223	145	223	75000	0	1	2025-01-03 06:12:16.886015
224	459	224	220000	0	1	2025-01-03 06:12:16.886015
225	394	225	174000	0	0	2025-01-03 06:12:16.886015
226	310	226	155000	0	1	2025-01-03 06:12:16.886015
227	75	227	15000	0	1	2025-01-03 06:12:16.886015
228	311	228	320000	0	2	2025-01-03 06:12:16.886015
229	717	229	17000	0	1	2025-01-03 06:12:16.886015
230	103	230	900000	0	1	2025-01-03 06:12:16.886015
231	112	231	9000	0	1	2025-01-03 06:12:16.886015
232	930	232	125000	0	1	2025-01-03 06:12:16.886015
233	610	233	142000	0	0	2025-01-03 06:12:16.886015
234	88	234	150000	0	1	2025-01-03 06:12:16.886015
235	673	235	510000	0	1	2025-01-03 06:12:16.886015
236	163	236	250000	0	1	2025-01-03 06:12:16.886015
237	169	237	16000	0	0	2025-01-03 06:12:16.886015
238	840	238	45000	0	1	2025-01-03 06:12:16.886015
239	595	239	260000	0	1	2025-01-03 06:12:16.886015
240	692	240	150000	0	1	2025-01-03 06:12:16.886015
241	210	241	15000	0	1	2025-01-03 06:12:16.886015
242	339	242	40000	0	1	2025-01-03 06:12:16.886015
243	667	243	15000	0	1	2025-01-03 06:12:16.886015
244	773	244	35000	0	1	2025-01-03 06:12:16.886015
245	531	245	35000	0	1	2025-01-03 06:12:16.886015
246	276	246	195000	0	1	2025-01-03 06:12:16.886015
247	977	247	214000	0	1	2025-01-03 06:12:16.886015
248	928	248	80000	0	1	2025-01-03 06:12:16.886015
249	877	249	510000	0	1	2025-01-03 06:12:16.886015
250	260	250	370000	0	1	2025-01-03 06:12:16.886015
251	906	251	190000	0	1	2025-01-03 06:12:16.886015
252	400	252	190000	0	1	2025-01-03 06:12:16.886015
253	502	253	830000	0	1	2025-01-03 06:12:16.886015
254	854	254	48000	0	1	2025-01-03 06:12:16.886015
255	828	255	85000	0	1	2025-01-03 06:12:16.886015
256	981	256	170000	0	1	2025-01-03 06:12:16.886015
257	548	257	1110000	0	1	2025-01-03 06:12:16.886015
258	649	258	23000	0	0	2025-01-03 06:12:16.886015
259	565	259	10000	0	1	2025-01-03 06:12:16.886015
260	155	260	35000	0	0	2025-01-03 06:12:16.886015
261	318	261	264000	0	0	2025-01-03 06:12:16.886015
262	293	262	290000	0	2	2025-01-03 06:12:16.886015
263	83	263	35000	0	1	2025-01-03 06:12:16.886015
264	431	264	125000	0	0	2025-01-03 06:12:16.886015
265	25	265	2400000	0	1	2025-01-03 06:12:16.886015
266	746	266	750000	0	1	2025-01-03 06:12:16.886015
267	701	267	490000	0	0	2025-01-03 06:12:16.886015
268	299	268	75000	0	1	2025-01-03 06:12:16.886015
269	913	269	275000	0	1	2025-01-03 06:12:16.886015
270	288	270	30000	0	1	2025-01-03 06:12:16.886015
271	10	271	105000	0	1	2025-01-03 06:12:16.886015
272	91	272	45000	0	0	2025-01-03 06:12:16.886015
273	899	273	210000	0	1	2025-01-03 06:12:16.886015
274	805	274	260000	0	1	2025-01-03 06:12:16.886015
275	76	275	640000	0	0	2025-01-03 06:12:16.886015
276	298	276	157000	0	1	2025-01-03 06:12:16.886015
277	87	277	2210000	0	1	2025-01-03 06:12:16.886015
278	40	278	30000	0	0	2025-01-03 06:12:16.886015
279	422	279	50000	0	1	2025-01-03 06:12:16.886015
280	904	280	106000	0	1	2025-01-03 06:12:16.886015
281	646	281	60000	0	1	2025-01-03 06:12:16.886015
282	308	282	175000	0	1	2025-01-03 06:12:16.886015
283	356	283	20000	0	1	2025-01-03 06:12:16.886015
284	852	284	540000	0	0	2025-01-03 06:12:16.886015
285	952	285	340000	0	1	2025-01-03 06:12:16.886015
286	280	286	75000	0	1	2025-01-03 06:12:16.886015
287	936	287	20000	0	1	2025-01-03 06:12:16.886015
288	173	288	60000	0	1	2025-01-03 06:12:16.886015
289	723	289	130000	0	0	2025-01-03 06:12:16.886015
290	729	290	55000	0	1	2025-01-03 06:12:16.886015
291	593	291	104000	0	0	2025-01-03 06:12:16.886015
292	313	292	255000	0	1	2025-01-03 06:12:16.886015
293	880	293	24000	0	1	2025-01-03 06:12:16.886015
294	511	294	45000	0	2	2025-01-03 06:12:16.886015
295	246	295	90000	0	1	2025-01-03 06:12:16.886015
296	124	296	276000	0	1	2025-01-03 06:12:16.886015
297	127	297	2150000	0	1	2025-01-03 06:12:16.886015
298	839	298	170000	0	0	2025-01-03 06:12:16.886015
299	539	299	340000	0	0	2025-01-03 06:12:16.886015
300	450	300	15000	0	1	2025-01-03 06:12:16.886015
301	939	301	180000	1	1	2025-01-03 06:12:16.886015
302	516	302	45000	1	1	2025-01-03 06:12:16.886015
303	586	303	115000	1	1	2025-01-03 06:12:16.886015
304	69	304	75000	1	1	2025-01-03 06:12:16.886015
305	857	305	475000	1	1	2025-01-03 06:12:16.886015
306	834	306	320000	1	0	2025-01-03 06:12:16.886015
307	821	307	345000	1	1	2025-01-03 06:12:16.886015
308	129	308	140000	1	1	2025-01-03 06:12:16.886015
309	78	309	225000	1	1	2025-01-03 06:12:16.886015
310	507	310	30000	1	0	2025-01-03 06:12:16.886015
311	432	311	3120000	1	0	2025-01-03 06:12:16.886015
312	140	312	35000	1	0	2025-01-03 06:12:16.886015
313	319	313	120000	1	0	2025-01-03 06:12:16.886015
314	248	314	290000	1	1	2025-01-03 06:12:16.886015
315	875	315	60000	1	1	2025-01-03 06:12:16.886015
316	677	316	25000	1	0	2025-01-03 06:12:16.886015
317	562	317	120000	1	1	2025-01-03 06:12:16.886015
318	182	318	75000	1	1	2025-01-03 06:12:16.886015
319	530	319	340000	1	1	2025-01-03 06:12:16.886015
320	238	320	45000	1	1	2025-01-03 06:12:16.886015
321	892	321	365000	1	1	2025-01-03 06:12:16.886015
322	580	322	540000	1	1	2025-01-03 06:12:16.886015
323	320	323	2145000	1	1	2025-01-03 06:12:16.886015
324	99	324	305000	1	1	2025-01-03 06:12:16.886015
325	555	325	60000	1	1	2025-01-03 06:12:16.886015
326	694	326	185000	1	1	2025-01-03 06:12:16.886015
327	860	327	15000	1	2	2025-01-03 06:12:16.886015
328	63	328	40000	1	1	2025-01-03 06:12:16.886015
329	832	329	55000	1	0	2025-01-03 06:12:16.886015
330	682	330	50000	1	1	2025-01-03 06:12:16.886015
331	19	331	95000	1	1	2025-01-03 06:12:16.886015
332	123	332	35000	1	1	2025-01-03 06:12:16.886015
333	307	333	180000	1	1	2025-01-03 06:12:16.886015
334	211	334	60000	1	1	2025-01-03 06:12:16.886015
335	934	335	60000	1	1	2025-01-03 06:12:16.886015
336	889	336	15000	1	1	2025-01-03 06:12:16.886015
337	603	337	250000	1	1	2025-01-03 06:12:16.886015
338	279	338	570000	1	0	2025-01-03 06:12:16.886015
339	504	339	150000	1	1	2025-01-03 06:12:16.886015
340	901	340	201000	1	1	2025-01-03 06:12:16.886015
341	209	341	45000	1	1	2025-01-03 06:12:16.886015
342	482	342	10000	1	2	2025-01-03 06:12:16.886015
343	3	343	135000	1	1	2025-01-03 06:12:16.886015
344	493	344	55000	1	0	2025-01-03 06:12:16.886015
345	942	345	75000	1	1	2025-01-03 06:12:16.886015
346	570	346	190000	1	1	2025-01-03 06:12:16.886015
347	363	347	130000	1	1	2025-01-03 06:12:16.886015
348	869	348	390000	1	2	2025-01-03 06:12:16.886015
349	704	349	215000	1	1	2025-01-03 06:12:16.886015
350	612	350	75000	1	1	2025-01-03 06:12:16.886015
351	198	351	115000	1	1	2025-01-03 06:12:16.886015
352	890	352	80000	1	1	2025-01-03 06:12:16.886015
353	378	353	2025000	1	2	2025-01-03 06:12:16.886015
354	284	354	125000	1	1	2025-01-03 06:12:16.886015
355	962	355	245000	1	0	2025-01-03 06:12:16.886015
356	732	356	86000	1	1	2025-01-03 06:12:16.886015
357	684	357	245000	1	1	2025-01-03 06:12:16.886015
358	859	358	85000	1	0	2025-01-03 06:12:16.886015
359	402	359	815000	1	1	2025-01-03 06:12:16.886015
360	73	360	60000	1	1	2025-01-03 06:12:16.886015
361	837	361	3600000	1	1	2025-01-03 06:12:16.886015
362	742	362	140000	1	1	2025-01-03 06:12:16.886015
363	597	363	265000	1	1	2025-01-03 06:12:16.886015
364	631	364	450000	1	1	2025-01-03 06:12:16.886015
365	976	365	435000	1	1	2025-01-03 06:12:16.886015
366	201	366	35000	1	1	2025-01-03 06:12:16.886015
367	992	367	180000	1	0	2025-01-03 06:12:16.886015
368	638	368	410000	1	1	2025-01-03 06:12:16.886015
369	107	369	81000	1	1	2025-01-03 06:12:16.886015
370	242	370	490000	1	1	2025-01-03 06:12:16.886015
371	951	371	7000	1	1	2025-01-03 06:12:16.886015
372	756	372	105000	1	1	2025-01-03 06:12:16.886015
373	898	373	90000	1	0	2025-01-03 06:12:16.886015
374	305	374	50000	1	2	2025-01-03 06:12:16.886015
375	508	375	15000	1	1	2025-01-03 06:12:16.886015
376	154	376	760000	1	1	2025-01-03 06:12:16.886015
377	721	377	400000	1	1	2025-01-03 06:12:16.886015
378	317	378	30000	1	1	2025-01-03 06:12:16.886015
379	731	379	63000	1	0	2025-01-03 06:12:16.886015
380	754	380	390000	1	0	2025-01-03 06:12:16.886015
381	51	381	130000	1	1	2025-01-03 06:12:16.886015
382	108	382	150000	1	1	2025-01-03 06:12:16.886015
383	527	383	150000	1	1	2025-01-03 06:12:16.886015
384	741	384	30000	1	1	2025-01-03 06:12:16.886015
385	714	385	210000	1	1	2025-01-03 06:12:16.886015
386	660	386	20000	1	1	2025-01-03 06:12:16.886015
387	404	387	121000	1	1	2025-01-03 06:12:16.886015
388	335	388	120000	1	1	2025-01-03 06:12:16.886015
389	264	389	135000	1	0	2025-01-03 06:12:16.886015
390	800	390	50000	1	1	2025-01-03 06:12:16.886015
391	309	391	2880000	1	0	2025-01-03 06:12:16.886015
392	815	392	98000	1	1	2025-01-03 06:12:16.886015
393	499	393	195000	1	1	2025-01-03 06:12:16.886015
394	172	394	245000	1	1	2025-01-03 06:12:16.886015
395	383	395	850000	1	0	2025-01-03 06:12:16.886015
396	574	396	1405000	1	1	2025-01-03 06:12:16.886015
397	973	397	140000	1	1	2025-01-03 06:12:16.886015
398	93	398	90000	1	1	2025-01-03 06:12:16.886015
399	13	399	540000	1	1	2025-01-03 06:12:16.886015
400	576	400	125000	1	0	2025-01-03 06:12:16.886015
401	712	401	440000	1	1	2025-01-03 06:12:16.886015
402	131	402	155000	1	2	2025-01-03 06:12:16.886015
403	97	403	70000	1	2	2025-01-03 06:12:16.886015
404	679	404	220000	1	1	2025-01-03 06:12:16.886015
405	822	405	1040000	1	1	2025-01-03 06:12:16.886015
406	636	406	40000	1	1	2025-01-03 06:12:16.886015
407	772	407	400000	1	0	2025-01-03 06:12:16.886015
408	885	408	130000	1	1	2025-01-03 06:12:16.886015
409	444	409	300000	1	1	2025-01-03 06:12:16.886015
410	784	410	200000	1	2	2025-01-03 06:12:16.886015
411	315	411	220000	1	1	2025-01-03 06:12:16.886015
412	468	412	836000	1	0	2025-01-03 06:12:16.886015
413	362	413	145000	1	1	2025-01-03 06:12:16.886015
414	791	414	130000	1	0	2025-01-03 06:12:16.886015
415	923	415	120000	1	1	2025-01-03 06:12:16.886015
416	685	416	630000	1	1	2025-01-03 06:12:16.886015
417	385	417	1535000	1	1	2025-01-03 06:12:16.886015
418	668	418	1230000	1	1	2025-01-03 06:12:16.886015
419	11	419	150000	1	1	2025-01-03 06:12:16.886015
420	912	420	115000	1	1	2025-01-03 06:12:16.886015
421	382	421	275000	1	2	2025-01-03 06:12:16.886015
422	135	422	515000	1	1	2025-01-03 06:12:16.886015
423	175	423	20000	1	1	2025-01-03 06:12:16.886015
424	338	424	280000	1	1	2025-01-03 06:12:16.886015
425	150	425	155000	1	1	2025-01-03 06:12:16.886015
426	138	426	150000	1	1	2025-01-03 06:12:16.886015
427	698	427	655000	1	0	2025-01-03 06:12:16.886015
428	199	428	195000	1	1	2025-01-03 06:12:16.886015
429	347	429	300000	1	1	2025-01-03 06:12:16.886015
430	359	430	1495000	1	1	2025-01-03 06:12:16.886015
431	273	431	655000	1	1	2025-01-03 06:12:16.886015
432	437	432	144000	1	0	2025-01-03 06:12:16.886015
433	263	433	175000	1	0	2025-01-03 06:12:16.886015
434	743	434	145000	1	0	2025-01-03 06:12:16.886015
435	635	435	60000	1	1	2025-01-03 06:12:16.886015
436	970	436	160000	1	1	2025-01-03 06:12:16.886015
437	322	437	880000	1	0	2025-01-03 06:12:16.886015
438	64	438	207000	1	1	2025-01-03 06:12:16.886015
439	122	439	39000	1	2	2025-01-03 06:12:16.886015
440	811	440	30000	1	1	2025-01-03 06:12:16.886015
441	354	441	60000	1	0	2025-01-03 06:12:16.886015
442	56	442	285000	1	1	2025-01-03 06:12:16.886015
443	5	443	80000	1	0	2025-01-03 06:12:16.886015
444	425	444	190000	1	1	2025-01-03 06:12:16.886015
445	171	445	200000	1	1	2025-01-03 06:12:16.886015
446	336	446	1350000	1	1	2025-01-03 06:12:16.886015
447	978	447	230000	1	1	2025-01-03 06:12:16.886015
448	554	448	85000	1	0	2025-01-03 06:12:16.886015
449	535	449	30000	1	0	2025-01-03 06:12:16.886015
450	745	450	90000	1	1	2025-01-03 06:12:16.886015
467	1000	512	350000	1	0	2025-01-16 15:20:28.172394
468	1000	514	105000	1	0	2025-01-17 14:50:58.596804
469	1050	515	30000	1	0	2025-01-21 11:16:58.724634
471	1000	517	155000	1	0	2025-01-24 15:49:03.559718
472	1000	518	155000	1	0	2025-01-24 15:49:35.620315
473	1000	519	155000	1	0	2025-01-24 15:49:59.091478
470	1000	516	155000	1	0	2025-01-24 15:48:17.199683
\.


--
-- TOC entry 5003 (class 0 OID 33063)
-- Dependencies: 231
-- Data for Name: pending_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pending_users (id, name, age, gender, address, email, phone, password, verification_token, expires_at, created_at) FROM stdin;
\.


--
-- TOC entry 4997 (class 0 OID 32952)
-- Dependencies: 225
-- Data for Name: shopping_cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shopping_cart (cart_id, user_id, created_at, updated_at) FROM stdin;
1	1	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
2	2	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
3	3	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
4	4	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
5	5	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
6	6	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
7	7	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
8	8	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
9	9	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
10	10	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
11	11	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
12	12	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
13	13	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
14	14	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
15	15	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
16	16	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
17	17	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
18	18	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
19	19	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
20	20	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
21	21	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
22	22	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
23	23	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
24	24	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
25	25	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
26	26	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
27	27	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
28	28	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
29	29	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
30	30	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
31	31	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
32	32	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
33	33	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
34	34	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
35	35	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
36	36	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
37	37	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
38	38	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
39	39	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
40	40	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
41	41	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
42	42	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
43	43	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
44	44	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
45	45	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
46	46	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
47	47	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
48	48	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
49	49	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
50	50	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
51	51	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
52	52	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
53	53	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
54	54	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
55	55	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
56	56	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
57	57	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
58	58	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
59	59	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
60	60	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
61	61	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
62	62	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
63	63	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
64	64	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
65	65	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
66	66	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
67	67	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
68	68	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
69	69	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
70	70	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
71	71	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
72	72	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
73	73	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
74	74	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
75	75	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
76	76	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
77	77	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
78	78	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
79	79	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
80	80	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
81	81	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
82	82	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
83	83	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
84	84	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
85	85	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
86	86	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
87	87	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
88	88	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
89	89	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
90	90	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
91	91	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
92	92	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
93	93	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
94	94	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
95	95	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
96	96	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
97	97	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
98	98	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
99	99	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
100	100	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
101	101	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
102	102	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
103	103	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
104	104	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
105	105	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
106	106	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
107	107	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
108	108	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
109	109	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
110	110	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
111	111	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
112	112	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
113	113	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
114	114	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
115	115	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
116	116	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
117	117	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
118	118	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
119	119	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
120	120	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
121	121	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
122	122	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
123	123	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
124	124	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
125	125	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
126	126	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
127	127	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
128	128	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
129	129	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
130	130	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
131	131	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
132	132	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
133	133	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
134	134	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
135	135	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
136	136	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
137	137	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
138	138	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
139	139	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
140	140	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
141	141	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
142	142	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
143	143	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
144	144	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
145	145	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
146	146	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
147	147	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
148	148	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
149	149	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
150	150	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
151	151	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
152	152	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
153	153	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
154	154	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
155	155	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
156	156	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
157	157	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
158	158	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
159	159	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
160	160	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
161	161	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
162	162	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
163	163	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
164	164	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
165	165	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
166	166	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
167	167	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
168	168	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
169	169	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
170	170	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
171	171	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
172	172	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
173	173	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
174	174	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
175	175	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
176	176	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
177	177	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
178	178	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
179	179	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
180	180	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
181	181	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
182	182	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
183	183	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
184	184	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
185	185	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
186	186	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
187	187	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
188	188	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
189	189	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
190	190	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
191	191	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
192	192	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
193	193	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
194	194	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
195	195	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
196	196	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
197	197	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
198	198	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
199	199	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
200	200	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
201	201	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
202	202	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
203	203	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
204	204	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
205	205	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
206	206	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
207	207	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
208	208	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
209	209	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
210	210	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
211	211	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
212	212	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
213	213	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
214	214	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
215	215	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
216	216	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
217	217	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
218	218	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
219	219	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
220	220	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
221	221	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
222	222	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
223	223	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
224	224	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
225	225	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
226	226	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
227	227	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
228	228	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
229	229	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
230	230	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
231	231	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
232	232	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
233	233	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
234	234	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
235	235	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
236	236	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
237	237	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
238	238	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
239	239	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
240	240	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
241	241	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
242	242	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
243	243	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
244	244	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
245	245	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
246	246	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
247	247	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
248	248	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
249	249	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
250	250	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
251	251	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
252	252	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
253	253	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
254	254	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
255	255	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
256	256	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
257	257	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
258	258	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
259	259	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
260	260	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
261	261	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
262	262	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
263	263	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
264	264	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
265	265	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
266	266	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
267	267	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
268	268	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
269	269	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
270	270	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
271	271	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
272	272	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
273	273	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
274	274	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
275	275	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
276	276	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
277	277	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
278	278	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
279	279	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
280	280	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
281	281	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
282	282	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
283	283	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
284	284	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
285	285	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
286	286	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
287	287	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
288	288	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
289	289	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
290	290	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
291	291	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
292	292	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
293	293	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
294	294	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
295	295	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
296	296	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
297	297	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
298	298	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
299	299	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
300	300	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
301	301	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
302	302	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
303	303	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
304	304	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
305	305	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
306	306	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
307	307	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
308	308	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
309	309	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
310	310	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
311	311	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
312	312	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
313	313	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
314	314	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
315	315	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
316	316	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
317	317	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
318	318	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
319	319	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
320	320	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
321	321	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
322	322	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
323	323	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
324	324	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
325	325	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
326	326	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
327	327	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
328	328	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
329	329	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
330	330	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
331	331	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
332	332	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
333	333	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
334	334	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
335	335	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
336	336	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
337	337	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
338	338	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
339	339	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
340	340	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
341	341	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
342	342	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
343	343	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
344	344	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
345	345	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
346	346	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
347	347	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
348	348	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
349	349	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
350	350	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
351	351	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
352	352	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
353	353	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
354	354	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
355	355	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
356	356	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
357	357	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
358	358	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
359	359	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
360	360	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
361	361	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
362	362	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
363	363	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
364	364	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
365	365	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
366	366	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
367	367	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
368	368	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
369	369	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
370	370	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
371	371	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
372	372	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
373	373	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
374	374	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
375	375	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
376	376	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
377	377	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
378	378	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
379	379	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
380	380	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
381	381	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
382	382	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
383	383	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
384	384	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
385	385	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
386	386	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
387	387	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
388	388	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
389	389	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
390	390	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
391	391	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
392	392	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
393	393	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
394	394	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
395	395	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
396	396	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
397	397	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
398	398	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
399	399	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
400	400	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
401	401	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
402	402	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
403	403	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
404	404	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
405	405	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
406	406	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
407	407	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
408	408	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
409	409	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
410	410	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
411	411	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
412	412	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
413	413	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
414	414	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
415	415	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
416	416	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
417	417	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
418	418	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
419	419	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
420	420	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
421	421	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
422	422	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
423	423	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
424	424	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
425	425	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
426	426	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
427	427	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
428	428	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
429	429	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
430	430	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
431	431	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
432	432	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
433	433	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
434	434	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
435	435	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
436	436	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
437	437	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
438	438	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
439	439	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
440	440	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
441	441	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
442	442	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
443	443	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
444	444	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
445	445	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
446	446	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
447	447	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
448	448	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
449	449	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
450	450	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
451	451	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
452	452	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
453	453	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
454	454	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
455	455	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
456	456	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
457	457	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
458	458	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
459	459	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
460	460	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
461	461	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
462	462	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
463	463	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
464	464	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
465	465	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
466	466	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
467	467	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
468	468	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
469	469	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
470	470	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
471	471	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
472	472	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
473	473	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
474	474	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
475	475	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
476	476	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
477	477	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
478	478	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
479	479	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
480	480	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
481	481	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
482	482	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
483	483	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
484	484	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
485	485	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
486	486	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
487	487	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
488	488	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
489	489	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
490	490	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
491	491	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
492	492	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
493	493	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
494	494	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
495	495	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
496	496	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
497	497	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
498	498	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
499	499	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
500	500	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
501	501	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
502	502	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
503	503	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
504	504	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
505	505	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
506	506	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
507	507	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
508	508	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
509	509	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
510	510	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
511	511	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
512	512	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
513	513	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
514	514	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
515	515	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
516	516	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
517	517	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
518	518	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
519	519	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
520	520	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
521	521	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
522	522	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
523	523	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
524	524	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
525	525	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
526	526	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
527	527	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
528	528	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
529	529	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
530	530	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
531	531	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
532	532	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
533	533	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
534	534	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
535	535	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
536	536	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
537	537	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
538	538	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
539	539	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
540	540	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
541	541	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
542	542	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
543	543	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
544	544	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
545	545	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
546	546	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
547	547	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
548	548	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
549	549	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
550	550	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
551	551	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
552	552	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
553	553	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
554	554	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
555	555	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
556	556	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
557	557	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
558	558	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
559	559	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
560	560	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
561	561	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
562	562	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
563	563	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
564	564	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
565	565	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
566	566	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
567	567	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
568	568	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
569	569	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
570	570	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
571	571	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
572	572	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
573	573	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
574	574	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
575	575	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
576	576	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
577	577	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
578	578	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
579	579	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
580	580	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
581	581	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
582	582	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
583	583	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
584	584	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
585	585	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
586	586	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
587	587	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
588	588	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
589	589	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
590	590	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
591	591	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
592	592	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
593	593	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
594	594	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
595	595	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
596	596	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
597	597	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
598	598	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
599	599	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
600	600	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
601	601	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
602	602	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
603	603	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
604	604	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
605	605	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
606	606	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
607	607	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
608	608	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
609	609	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
610	610	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
611	611	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
612	612	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
613	613	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
614	614	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
615	615	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
616	616	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
617	617	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
618	618	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
619	619	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
620	620	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
621	621	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
622	622	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
623	623	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
624	624	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
625	625	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
626	626	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
627	627	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
628	628	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
629	629	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
630	630	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
631	631	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
632	632	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
633	633	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
634	634	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
635	635	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
636	636	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
637	637	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
638	638	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
639	639	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
640	640	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
641	641	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
642	642	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
643	643	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
644	644	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
645	645	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
646	646	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
647	647	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
648	648	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
649	649	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
650	650	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
651	651	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
652	652	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
653	653	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
654	654	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
655	655	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
656	656	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
657	657	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
658	658	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
659	659	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
660	660	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
661	661	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
662	662	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
663	663	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
664	664	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
665	665	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
666	666	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
667	667	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
668	668	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
669	669	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
670	670	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
671	671	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
672	672	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
673	673	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
674	674	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
675	675	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
676	676	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
677	677	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
678	678	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
679	679	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
680	680	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
681	681	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
682	682	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
683	683	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
684	684	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
685	685	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
686	686	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
687	687	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
688	688	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
689	689	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
690	690	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
691	691	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
692	692	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
693	693	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
694	694	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
695	695	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
696	696	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
697	697	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
698	698	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
699	699	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
700	700	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
701	701	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
702	702	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
703	703	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
704	704	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
705	705	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
706	706	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
707	707	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
708	708	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
709	709	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
710	710	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
711	711	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
712	712	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
713	713	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
714	714	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
715	715	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
716	716	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
717	717	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
718	718	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
719	719	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
720	720	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
721	721	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
722	722	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
723	723	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
724	724	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
725	725	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
726	726	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
727	727	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
728	728	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
729	729	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
730	730	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
731	731	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
732	732	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
733	733	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
734	734	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
735	735	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
736	736	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
737	737	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
738	738	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
739	739	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
740	740	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
741	741	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
742	742	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
743	743	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
744	744	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
745	745	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
746	746	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
747	747	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
748	748	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
749	749	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
750	750	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
751	751	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
752	752	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
753	753	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
754	754	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
755	755	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
756	756	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
757	757	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
758	758	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
759	759	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
760	760	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
761	761	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
762	762	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
763	763	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
764	764	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
765	765	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
766	766	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
767	767	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
768	768	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
769	769	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
770	770	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
771	771	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
772	772	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
773	773	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
774	774	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
775	775	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
776	776	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
777	777	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
778	778	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
779	779	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
780	780	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
781	781	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
782	782	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
783	783	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
784	784	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
785	785	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
786	786	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
787	787	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
788	788	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
789	789	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
790	790	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
791	791	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
792	792	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
793	793	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
794	794	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
795	795	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
796	796	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
797	797	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
798	798	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
799	799	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
800	800	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
801	801	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
802	802	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
803	803	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
804	804	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
805	805	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
806	806	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
807	807	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
808	808	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
809	809	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
810	810	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
811	811	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
812	812	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
813	813	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
814	814	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
815	815	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
816	816	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
817	817	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
818	818	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
819	819	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
820	820	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
821	821	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
822	822	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
823	823	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
824	824	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
825	825	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
826	826	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
827	827	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
828	828	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
829	829	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
830	830	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
831	831	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
832	832	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
833	833	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
834	834	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
835	835	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
836	836	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
837	837	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
838	838	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
839	839	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
840	840	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
841	841	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
842	842	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
843	843	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
844	844	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
845	845	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
846	846	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
847	847	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
848	848	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
849	849	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
850	850	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
851	851	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
852	852	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
853	853	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
854	854	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
855	855	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
856	856	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
857	857	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
858	858	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
859	859	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
860	860	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
861	861	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
862	862	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
863	863	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
864	864	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
865	865	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
866	866	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
867	867	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
868	868	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
869	869	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
870	870	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
871	871	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
872	872	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
873	873	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
874	874	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
875	875	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
876	876	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
877	877	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
878	878	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
879	879	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
880	880	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
881	881	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
882	882	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
883	883	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
884	884	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
885	885	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
886	886	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
887	887	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
888	888	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
889	889	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
890	890	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
891	891	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
892	892	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
893	893	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
894	894	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
895	895	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
896	896	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
897	897	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
898	898	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
899	899	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
900	900	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
901	901	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
902	902	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
903	903	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
904	904	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
905	905	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
906	906	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
907	907	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
908	908	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
909	909	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
910	910	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
911	911	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
912	912	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
913	913	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
914	914	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
915	915	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
916	916	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
917	917	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
918	918	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
919	919	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
920	920	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
921	921	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
922	922	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
923	923	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
924	924	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
925	925	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
926	926	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
927	927	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
928	928	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
929	929	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
930	930	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
931	931	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
932	932	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
933	933	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
934	934	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
935	935	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
936	936	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
937	937	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
938	938	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
939	939	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
940	940	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
941	941	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
942	942	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
943	943	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
944	944	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
945	945	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
946	946	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
947	947	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
948	948	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
949	949	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
950	950	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
951	951	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
952	952	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
953	953	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
954	954	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
955	955	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
956	956	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
957	957	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
958	958	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
959	959	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
960	960	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
961	961	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
962	962	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
963	963	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
964	964	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
965	965	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
966	966	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
967	967	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
968	968	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
969	969	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
970	970	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
971	971	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
972	972	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
973	973	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
974	974	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
975	975	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
976	976	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
977	977	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
978	978	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
979	979	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
980	980	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
981	981	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
982	982	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
983	983	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
984	984	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
985	985	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
986	986	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
987	987	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
988	988	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
989	989	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
990	990	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
991	991	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
992	992	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
993	993	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
994	994	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
995	995	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
996	996	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
997	997	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
998	998	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
999	999	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
1000	1000	2025-01-03 06:12:38.548666	2025-01-03 06:12:38.548666
1050	1050	2025-01-16 17:11:30.301732	2025-01-16 17:11:30.301732
\.


--
-- TOC entry 4999 (class 0 OID 32958)
-- Dependencies: 227
-- Data for Name: shopping_cart_dishes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shopping_cart_dishes (cart_id, dish_id, quantity) FROM stdin;
2	D014	1
2	D012	1
2	D055	1
3	D030	3
4	D004	1
4	D026	2
4	D054	3
5	D001	3
5	D021	2
6	D036	1
6	D020	2
7	D012	2
8	D046	2
9	D034	3
9	D006	1
9	D059	2
10	D038	3
11	D047	1
11	D025	3
11	D009	1
12	D011	1
12	D030	2
13	D059	1
13	D047	2
14	D027	3
14	D035	3
15	D010	1
15	D022	2
15	D032	2
16	D029	1
16	D042	1
17	D041	2
18	D009	3
18	D028	3
19	D028	2
19	D064	3
20	D019	1
20	D034	1
21	D034	2
21	D055	1
21	D052	1
22	D064	1
22	D012	1
22	D007	3
23	D055	3
24	D050	2
25	D060	3
25	D033	3
25	D002	1
26	D035	2
26	D044	2
26	D015	1
27	D001	3
27	D034	1
28	D014	3
28	D039	1
28	D065	1
29	D021	3
29	D001	2
30	D003	2
30	D015	2
31	D008	1
32	D011	3
32	D063	1
32	D009	1
33	D061	3
33	D022	3
33	D034	2
34	D026	3
35	D052	2
35	D048	3
36	D016	1
36	D032	1
37	D003	3
37	D030	1
38	D010	3
39	D008	1
39	D030	2
39	D009	1
40	D031	1
40	D036	3
40	D063	1
41	D061	1
41	D032	1
41	D053	1
42	D056	2
42	D046	2
42	D055	3
43	D013	1
44	D044	1
44	D014	1
45	D058	1
46	D024	2
46	D036	1
47	D057	3
48	D007	3
49	D002	1
49	D012	2
49	D031	2
50	D028	1
50	D052	1
51	D001	2
51	D050	2
52	D055	1
52	D063	1
53	D028	3
53	D008	3
54	D008	3
54	D041	2
54	D007	3
55	D021	1
55	D008	1
55	D066	1
56	D009	1
56	D031	3
56	D052	1
57	D006	3
57	D011	3
57	D054	3
58	D041	3
58	D034	3
58	D027	2
59	D034	2
60	D039	2
61	D010	2
61	D002	3
62	D013	3
62	D010	2
62	D028	1
63	D009	2
63	D032	2
64	D057	3
65	D039	1
65	D002	2
65	D014	1
66	D020	2
67	D027	1
67	D044	3
68	D034	2
68	D065	1
68	D063	1
69	D055	1
69	D036	2
69	D006	1
70	D034	3
70	D021	3
70	D057	2
71	D002	3
71	D015	1
71	D010	3
72	D048	3
73	D019	1
73	D056	2
73	D017	2
74	D046	1
75	D032	3
75	D014	2
75	D046	3
76	D020	1
76	D031	2
76	D021	1
77	D043	2
78	D032	3
78	D035	1
78	D021	2
79	D061	1
80	D059	2
81	D030	1
81	D029	3
82	D052	2
83	D009	2
83	D036	3
84	D052	1
84	D043	2
84	D004	1
85	D034	3
85	D005	2
85	D014	2
86	D041	1
86	D056	2
86	D066	3
87	D033	1
88	D056	3
88	D001	3
88	D067	3
89	D026	1
89	D047	3
89	D056	2
90	D041	3
90	D016	2
90	D039	3
91	D042	3
91	D052	2
92	D017	3
92	D025	2
92	D054	3
93	D023	3
93	D039	1
93	D052	2
94	D027	3
94	D056	3
95	D042	2
95	D060	3
95	D057	1
96	D061	2
96	D022	3
96	D011	3
97	D043	3
97	D012	2
97	D031	1
98	D019	1
99	D032	2
100	D010	3
100	D059	3
100	D054	1
101	D050	1
101	D064	1
101	D052	3
102	D001	1
102	D014	1
102	D055	3
103	D060	1
103	D007	2
103	D032	1
104	D041	3
104	D057	3
105	D055	3
105	D058	2
105	D021	2
106	D032	3
106	D036	2
107	D031	1
107	D036	3
107	D057	2
108	D035	2
109	D011	1
109	D018	1
110	D020	1
110	D028	2
111	D043	2
111	D060	1
112	D054	2
113	D003	1
113	D049	2
113	D062	2
114	D054	2
114	D029	1
115	D056	1
115	D063	2
116	D052	2
116	D022	1
117	D004	3
117	D051	2
117	D011	1
118	D024	2
118	D007	2
119	D028	2
119	D059	2
120	D036	2
120	D054	1
121	D003	2
121	D007	1
122	D009	1
122	D006	1
122	D004	1
123	D020	2
123	D031	3
123	D017	1
124	D028	2
124	D060	1
124	D033	3
125	D015	1
125	D021	3
125	D040	1
126	D049	3
126	D051	1
127	D032	1
128	D039	2
128	D016	3
128	D006	2
129	D048	3
129	D009	2
129	D065	1
130	D063	2
130	D014	2
131	D059	1
131	D020	3
131	D056	3
132	D035	2
132	D062	3
132	D060	3
133	D042	1
133	D032	2
134	D032	3
134	D060	3
135	D049	2
135	D044	2
135	D004	1
136	D028	2
136	D046	2
137	D036	3
137	D002	1
138	D031	3
139	D063	3
139	D031	2
140	D063	1
140	D058	2
140	D003	1
141	D032	3
141	D040	3
142	D061	2
142	D045	3
143	D043	2
143	D046	2
143	D059	2
144	D016	3
145	D041	1
146	D024	3
146	D025	2
146	D028	2
147	D037	2
147	D013	1
147	D025	2
148	D039	1
149	D017	1
149	D036	3
149	D006	2
150	D017	1
150	D063	3
150	D014	2
151	D062	2
151	D057	1
152	D033	2
153	D009	2
154	D010	1
154	D007	1
155	D039	1
155	D011	3
155	D032	2
156	D029	2
156	D067	2
156	D049	2
157	D055	3
157	D040	3
157	D008	1
158	D028	2
159	D011	1
159	D021	3
159	D031	1
160	D001	2
161	D061	1
161	D038	1
162	D037	1
162	D059	3
163	D034	3
164	D026	3
164	D055	1
164	D015	3
165	D035	1
166	D008	1
167	D037	1
167	D057	2
168	D039	3
168	D052	3
168	D035	2
169	D011	2
169	D006	3
170	D033	1
170	D004	1
171	D003	1
171	D035	2
171	D006	3
172	D057	3
172	D036	2
172	D024	3
173	D012	2
173	D061	2
174	D042	1
174	D014	2
175	D064	3
175	D037	2
176	D005	2
176	D059	2
176	D012	2
177	D052	3
178	D060	2
179	D025	3
180	D064	1
180	D057	1
181	D017	2
181	D037	3
182	D016	3
182	D004	3
183	D021	2
184	D002	1
184	D053	1
184	D012	2
185	D020	2
186	D038	2
186	D066	2
186	D035	2
187	D059	3
188	D050	1
189	D066	2
189	D018	2
189	D009	2
190	D035	3
190	D001	2
190	D037	3
191	D063	3
191	D020	2
191	D058	2
192	D049	2
192	D059	1
193	D031	2
193	D050	1
193	D030	2
194	D061	3
194	D049	3
194	D050	1
195	D005	3
195	D017	3
196	D013	1
196	D057	3
197	D002	2
197	D019	3
198	D010	2
199	D044	3
199	D051	1
200	D049	3
200	D041	3
201	D005	1
201	D009	3
202	D037	2
202	D030	1
202	D012	3
203	D013	3
203	D057	2
203	D022	1
204	D042	1
205	D046	2
205	D048	1
206	D053	3
207	D024	1
207	D022	3
207	D023	2
208	D031	1
208	D064	2
208	D019	3
209	D059	3
209	D033	1
210	D037	1
210	D021	2
211	D039	3
211	D055	2
212	D039	2
212	D026	2
213	D031	2
214	D046	3
214	D038	2
214	D003	2
215	D007	3
216	D064	3
216	D037	2
216	D030	1
217	D025	3
217	D033	1
217	D018	3
218	D006	1
218	D040	3
218	D057	2
219	D017	2
219	D012	3
219	D038	2
220	D026	1
221	D047	1
221	D065	2
221	D035	2
222	D044	2
222	D015	1
223	D029	3
224	D051	2
224	D047	1
224	D012	2
225	D016	3
225	D059	3
225	D048	3
226	D049	1
226	D048	3
227	D061	1
228	D042	3
228	D029	2
228	D009	3
229	D053	1
229	D015	1
230	D039	2
231	D013	1
232	D018	2
232	D050	3
232	D059	3
233	D054	2
233	D020	3
233	D013	2
234	D005	1
234	D048	2
235	D031	1
235	D047	3
236	D046	2
236	D008	2
237	D016	2
238	D028	3
239	D003	1
239	D007	1
239	D043	3
240	D009	3
241	D028	1
242	D019	2
242	D001	1
243	D033	1
244	D004	1
245	D046	1
246	D042	2
246	D003	1
246	D023	1
247	D054	2
247	D015	2
247	D009	2
248	D014	1
248	D058	3
248	D065	1
249	D067	3
249	D039	1
249	D059	1
250	D052	3
250	D055	1
251	D057	1
251	D010	2
252	D019	2
252	D009	3
252	D017	3
253	D042	2
253	D049	3
253	D038	3
254	D013	3
254	D015	3
255	D028	1
255	D056	2
255	D058	2
256	D052	3
256	D054	1
257	D055	3
257	D041	2
258	D020	1
258	D061	1
259	D012	2
260	D048	1
261	D008	2
261	D043	2
261	D016	3
262	D007	3
262	D037	2
263	D014	1
263	D065	1
264	D062	2
264	D029	3
264	D014	2
265	D036	3
266	D055	3
267	D004	2
267	D035	3
267	D024	2
268	D045	1
268	D001	1
269	D052	3
269	D009	3
269	D019	1
270	D028	2
271	D059	1
271	D044	2
272	D042	1
272	D011	1
273	D007	3
274	D035	2
275	D055	2
275	D063	2
275	D057	1
276	D015	1
276	D045	2
276	D056	3
277	D063	1
277	D040	2
277	D006	3
278	D001	1
279	D028	2
279	D018	2
280	D016	2
280	D001	3
281	D023	2
281	D017	3
282	D030	1
282	D065	2
282	D046	3
283	D056	1
284	D010	3
284	D041	2
285	D052	1
285	D054	2
285	D038	1
286	D022	3
286	D059	2
287	D056	1
288	D056	3
289	D011	2
289	D051	3
290	D029	1
290	D043	1
291	D015	2
291	D066	2
291	D025	3
292	D019	1
292	D031	2
292	D014	1
293	D020	3
294	D023	3
295	D060	3
295	D058	3
296	D042	2
296	D041	1
296	D020	2
297	D039	3
297	D036	1
298	D065	2
298	D010	2
299	D005	2
299	D008	2
300	D012	3
301	D065	3
301	D050	3
301	D060	3
302	D058	3
303	D025	3
303	D042	1
303	D061	1
304	D014	3
304	D044	1
305	D023	3
305	D006	2
305	D032	2
306	D067	2
306	D021	2
306	D047	2
307	D044	3
307	D007	3
308	D009	1
308	D043	3
309	D050	3
309	D037	3
309	D033	3
310	D043	1
311	D019	3
311	D045	3
311	D040	3
312	D017	2
312	D011	3
313	D043	3
313	D017	3
314	D012	2
314	D055	1
314	D066	2
315	D024	2
315	D028	2
316	D029	1
317	D010	2
318	D065	3
319	D005	3
319	D044	2
319	D017	1
320	D024	3
321	D022	2
321	D057	2
321	D006	3
322	D031	3
322	D057	2
322	D037	1
323	D031	1
323	D040	2
323	D061	3
324	D057	2
324	D060	3
324	D037	3
325	D021	3
325	D026	1
326	D007	2
326	D062	3
327	D067	1
328	D011	2
328	D021	2
329	D019	1
329	D056	2
329	D012	2
330	D054	1
331	D065	1
331	D048	2
332	D048	1
333	D041	1
334	D043	1
334	D019	2
334	D018	2
335	D018	3
335	D061	1
335	D058	1
336	D033	1
337	D055	1
338	D031	1
338	D039	1
339	D054	3
340	D059	2
340	D009	3
340	D015	3
341	D066	3
342	D019	2
343	D001	1
343	D046	3
344	D024	3
344	D011	2
345	D065	3
346	D003	1
346	D050	3
346	D061	2
347	D033	2
347	D003	1
348	D031	3
348	D014	3
349	D018	2
349	D006	3
350	D023	3
350	D060	2
351	D024	3
351	D018	2
351	D009	1
352	D026	1
352	D006	1
353	D040	2
353	D066	3
354	D033	3
354	D005	1
355	D046	3
355	D007	2
356	D016	2
356	D048	2
357	D057	1
357	D050	2
357	D044	3
358	D048	2
358	D067	1
359	D055	3
359	D011	1
359	D056	3
360	D042	1
360	D014	2
361	D038	3
361	D040	3
361	D058	2
362	D057	2
363	D006	3
363	D046	2
364	D008	3
364	D010	3
365	D047	3
365	D066	3
366	D004	1
367	D057	1
367	D005	1
367	D017	3
368	D047	3
368	D050	1
369	D020	2
369	D058	2
369	D048	1
370	D018	2
370	D047	3
370	D051	2
371	D015	1
372	D024	2
372	D064	3
372	D067	1
373	D034	1
373	D058	3
374	D063	1
374	D026	1
375	D058	1
376	D057	3
376	D012	2
376	D041	3
377	D038	2
378	D023	2
379	D029	1
379	D016	1
379	D026	2
380	D047	3
381	D048	3
381	D060	1
381	D017	1
382	D051	3
382	D062	2
383	D010	2
383	D017	3
384	D058	2
385	D067	3
385	D045	3
385	D017	3
386	D017	2
387	D008	1
387	D016	2
387	D067	1
388	D042	3
389	D045	3
390	D011	1
390	D033	3
391	D036	3
391	D017	3
391	D039	1
392	D022	3
392	D020	1
392	D044	1
393	D006	3
394	D034	3
394	D027	3
394	D054	1
395	D038	2
395	D039	1
396	D052	1
396	D039	3
396	D059	1
397	D057	2
398	D060	2
398	D027	3
399	D041	3
400	D045	1
400	D052	2
401	D014	2
401	D041	1
401	D031	2
402	D032	1
402	D019	1
403	D050	1
403	D054	1
404	D041	1
404	D025	2
405	D060	2
405	D064	1
405	D040	1
406	D065	1
406	D059	1
407	D046	2
407	D007	3
407	D037	3
408	D061	1
408	D037	2
408	D002	1
409	D047	2
409	D052	1
410	D007	2
410	D025	3
411	D010	3
411	D050	2
412	D036	1
412	D016	2
412	D017	2
413	D047	1
413	D019	3
414	D052	1
414	D065	1
414	D006	1
415	D043	2
415	D061	1
415	D067	3
416	D018	1
416	D042	2
416	D041	3
417	D039	3
417	D044	3
417	D065	2
418	D039	2
418	D061	2
418	D003	3
419	D054	3
420	D004	2
420	D061	3
421	D030	1
421	D007	3
421	D062	3
422	D049	1
422	D019	3
422	D032	3
423	D025	1
424	D041	1
424	D054	2
425	D027	3
425	D053	2
425	D065	3
426	D008	1
426	D018	3
426	D067	2
427	D062	1
427	D049	2
427	D041	3
428	D046	3
428	D034	2
429	D032	2
430	D039	3
430	D029	1
430	D037	3
431	D063	2
431	D041	3
431	D062	3
432	D037	3
432	D016	3
433	D049	1
433	D051	2
433	D045	1
434	D011	2
434	D045	3
435	D062	1
435	D028	3
436	D035	1
436	D018	3
437	D031	3
437	D032	3
437	D007	1
438	D030	2
438	D007	2
438	D013	3
439	D013	1
439	D018	3
440	D053	3
441	D062	2
441	D026	2
442	D008	3
442	D012	3
443	D005	1
444	D023	2
444	D005	2
445	D038	1
446	D039	3
447	D014	2
447	D043	3
447	D037	3
448	D064	2
448	D018	2
448	D065	1
449	D043	1
450	D059	1
450	D033	3
450	D024	2
451	D025	3
451	D023	3
452	D055	2
452	D066	1
453	D013	1
453	D024	2
454	D032	2
454	D001	2
455	D058	2
456	D039	2
456	D002	3
457	D031	3
457	D008	1
458	D040	2
458	D021	3
459	D040	2
459	D016	3
459	D038	1
460	D018	2
461	D059	3
462	D048	3
462	D054	3
462	D061	1
463	D011	3
464	D047	3
464	D010	1
465	D065	1
466	D020	3
466	D022	2
466	D042	1
467	D027	3
467	D063	2
467	D012	1
468	D017	2
468	D066	2
469	D008	3
469	D060	1
469	D040	2
470	D001	3
470	D028	1
471	D055	2
472	D009	1
472	D008	2
472	D061	2
473	D018	3
474	D054	2
474	D048	2
474	D049	2
475	D018	3
476	D016	3
476	D023	2
477	D017	1
477	D029	2
477	D001	2
478	D055	1
478	D049	2
478	D030	2
479	D036	1
480	D015	3
480	D005	1
480	D054	1
481	D009	1
482	D005	1
482	D058	3
482	D007	1
483	D057	3
483	D030	1
484	D018	3
485	D030	3
485	D041	3
486	D042	1
486	D031	3
486	D039	3
487	D053	2
488	D008	3
488	D023	3
489	D064	2
489	D007	3
490	D049	2
490	D041	1
490	D054	2
491	D024	1
491	D061	1
492	D019	1
492	D060	3
493	D054	2
493	D018	1
494	D027	3
494	D043	1
495	D048	3
495	D012	3
496	D007	2
497	D006	1
497	D010	3
498	D028	2
498	D062	2
498	D027	1
499	D025	3
500	D062	1
501	D027	3
501	D051	2
501	D031	2
502	D060	2
502	D046	2
503	D066	2
503	D064	1
504	D061	2
504	D041	2
504	D027	2
505	D029	3
506	D003	2
507	D054	1
507	D038	2
507	D020	1
508	D032	3
508	D064	3
509	D044	3
509	D033	3
509	D063	3
510	D059	3
510	D022	2
511	D018	3
512	D063	3
512	D024	1
512	D008	1
513	D007	1
513	D001	3
513	D053	1
514	D020	1
515	D065	2
516	D008	3
516	D062	2
517	D001	3
518	D053	3
518	D002	3
518	D003	2
519	D037	3
519	D003	3
519	D065	2
520	D014	1
521	D020	3
521	D031	3
521	D025	2
522	D035	1
522	D051	2
523	D059	3
523	D032	1
524	D011	1
524	D005	2
525	D049	1
525	D061	3
526	D022	1
527	D056	3
527	D043	1
528	D006	3
528	D030	3
528	D028	2
529	D006	3
529	D010	2
530	D005	1
530	D023	1
530	D041	3
531	D051	1
532	D021	3
532	D031	2
533	D043	3
533	D050	3
533	D018	1
534	D045	2
534	D007	1
534	D013	1
535	D051	1
535	D042	3
536	D058	1
536	D063	2
537	D049	3
537	D056	3
537	D024	3
538	D011	1
538	D038	3
539	D011	2
540	D049	3
541	D020	2
541	D050	1
541	D041	1
542	D040	2
543	D035	1
543	D014	1
544	D056	2
545	D066	1
545	D053	1
545	D014	2
546	D012	1
546	D042	2
546	D050	2
547	D011	3
547	D032	3
548	D049	1
549	D035	2
550	D064	1
550	D019	1
551	D036	2
551	D054	2
552	D047	2
553	D064	3
554	D026	1
554	D059	2
554	D014	1
555	D043	2
555	D049	2
556	D056	2
556	D018	2
557	D026	1
557	D062	2
557	D041	2
558	D063	2
558	D032	2
559	D051	1
559	D047	3
560	D024	3
561	D004	2
561	D060	2
561	D027	3
562	D053	3
563	D018	1
563	D039	2
564	D020	1
564	D055	2
564	D049	3
565	D052	3
565	D065	2
566	D005	1
566	D047	1
566	D011	3
567	D046	3
567	D022	3
567	D006	3
568	D052	1
568	D043	1
568	D056	1
569	D029	3
569	D066	3
570	D029	2
570	D058	2
570	D048	3
571	D065	1
571	D020	2
571	D045	1
572	D054	1
572	D011	3
573	D045	2
574	D059	3
574	D027	2
575	D061	2
575	D013	3
576	D058	2
576	D041	1
576	D009	3
577	D003	2
578	D014	3
578	D022	1
578	D032	3
579	D043	3
580	D060	2
580	D030	3
581	D024	3
582	D056	3
582	D051	3
582	D004	1
583	D055	1
583	D050	3
584	D027	2
585	D009	2
585	D014	2
585	D024	1
586	D015	3
586	D034	2
587	D041	3
587	D050	1
587	D051	2
588	D059	3
588	D023	3
589	D011	2
589	D018	1
590	D040	1
591	D048	3
592	D066	2
593	D018	2
593	D050	1
594	D023	2
594	D022	2
595	D024	2
596	D007	1
596	D046	2
597	D025	2
598	D065	3
598	D064	2
598	D053	2
599	D057	1
599	D063	3
599	D022	1
600	D038	1
601	D029	1
601	D037	2
602	D064	3
602	D066	1
602	D015	2
603	D047	3
603	D006	1
603	D057	2
604	D032	2
605	D058	2
606	D012	1
606	D057	1
607	D045	3
608	D055	1
608	D022	1
608	D018	1
609	D045	2
609	D036	3
609	D022	2
610	D035	3
610	D066	1
611	D053	1
612	D017	1
612	D032	3
613	D032	2
613	D051	1
614	D035	2
614	D054	1
614	D049	3
615	D052	3
616	D036	2
616	D048	2
616	D059	3
617	D012	3
618	D046	3
618	D009	2
619	D055	1
620	D035	2
620	D042	2
621	D017	3
621	D063	1
621	D044	1
622	D059	1
623	D021	2
624	D001	1
624	D055	3
625	D039	1
626	D012	2
626	D047	1
627	D022	2
627	D007	3
628	D030	3
628	D055	1
629	D013	2
629	D001	1
629	D028	1
630	D029	1
630	D067	1
630	D057	3
631	D016	3
631	D055	1
632	D010	2
632	D030	1
633	D014	2
633	D041	1
633	D048	2
634	D019	1
635	D002	2
635	D022	3
635	D057	1
636	D020	1
636	D053	1
636	D057	1
637	D016	3
638	D050	2
638	D045	1
638	D055	1
639	D011	3
639	D032	3
640	D037	1
640	D004	3
640	D039	3
641	D025	3
641	D051	1
641	D038	1
642	D050	1
642	D015	2
643	D010	2
643	D002	1
643	D047	2
644	D054	2
644	D047	1
644	D023	1
645	D009	1
645	D002	1
645	D034	1
646	D065	3
646	D037	3
647	D054	1
647	D055	3
647	D052	3
648	D020	2
648	D036	1
648	D011	3
649	D020	3
650	D051	2
650	D009	3
651	D031	1
651	D008	1
652	D015	3
652	D059	3
653	D040	3
654	D023	3
654	D016	1
654	D002	3
655	D021	2
656	D067	1
656	D034	2
657	D035	3
658	D004	2
659	D035	2
659	D009	3
660	D010	3
660	D064	2
660	D059	1
661	D022	1
661	D048	2
662	D015	1
663	D066	1
663	D001	1
663	D006	1
664	D047	1
664	D050	1
665	D054	1
666	D032	3
666	D054	2
667	D010	1
667	D048	3
668	D007	3
668	D023	1
668	D029	2
669	D060	2
670	D042	3
670	D012	2
671	D048	1
672	D039	2
672	D032	2
673	D064	1
673	D026	1
673	D032	2
674	D030	3
675	D002	1
675	D043	3
676	D040	1
676	D014	3
677	D054	2
678	D019	3
679	D012	1
679	D006	3
680	D048	3
680	D059	1
681	D013	3
681	D065	2
681	D018	1
682	D008	1
682	D056	2
682	D017	2
683	D051	2
683	D042	2
684	D030	1
684	D010	1
685	D014	2
685	D020	2
685	D022	2
686	D016	1
686	D046	2
687	D060	1
687	D034	1
688	D039	3
689	D006	1
689	D028	1
689	D042	3
690	D046	2
691	D007	1
691	D039	1
691	D034	2
692	D032	2
692	D013	1
693	D016	1
694	D029	1
695	D052	2
696	D011	1
696	D034	1
696	D010	1
697	D057	2
697	D017	1
697	D012	1
698	D007	3
698	D022	2
699	D051	2
699	D064	3
699	D004	2
700	D046	1
701	D036	2
702	D020	3
702	D005	3
703	D032	2
703	D038	3
703	D064	2
704	D012	2
705	D018	1
705	D054	3
706	D032	3
706	D003	2
706	D049	2
707	D063	2
707	D045	2
707	D065	2
708	D004	2
709	D029	1
709	D004	2
709	D036	3
710	D030	1
710	D021	1
711	D031	1
711	D035	3
711	D008	2
712	D023	3
712	D031	2
713	D046	3
713	D004	1
713	D019	2
714	D040	1
714	D023	1
714	D063	1
715	D029	1
716	D062	3
716	D001	1
716	D043	1
717	D023	1
717	D042	1
718	D019	1
719	D047	3
719	D010	3
719	D048	2
720	D013	2
720	D044	1
720	D039	1
721	D056	1
721	D063	3
721	D041	3
722	D046	2
722	D029	2
722	D023	3
723	D038	3
723	D017	1
723	D023	3
724	D051	3
724	D005	2
724	D024	3
725	D014	2
726	D043	3
727	D031	2
728	D022	3
728	D012	3
729	D043	2
729	D058	1
729	D002	1
730	D009	1
730	D045	3
730	D033	1
731	D050	2
732	D054	2
732	D022	2
732	D053	2
733	D049	3
733	D013	3
733	D062	3
734	D021	2
735	D005	2
736	D041	2
737	D010	2
738	D049	1
739	D010	3
739	D012	3
739	D044	2
740	D004	3
740	D056	2
740	D022	1
741	D013	2
742	D025	2
743	D034	1
743	D037	1
743	D039	1
744	D063	1
744	D020	2
745	D055	1
746	D062	1
746	D026	1
747	D022	3
748	D011	1
748	D061	2
749	D061	3
749	D063	2
750	D050	1
751	D049	1
751	D048	2
752	D034	2
753	D034	2
753	D029	3
754	D020	3
755	D013	3
755	D011	2
755	D045	3
756	D008	2
757	D054	2
757	D061	2
757	D031	1
758	D005	3
758	D065	3
759	D019	1
759	D016	1
759	D058	1
760	D017	1
761	D011	1
761	D056	3
762	D034	2
763	D009	3
763	D012	2
763	D050	3
764	D036	2
764	D067	1
765	D067	2
765	D054	1
765	D015	1
766	D013	3
766	D014	2
766	D037	2
767	D050	3
767	D063	3
768	D005	2
768	D023	2
769	D052	1
770	D043	1
770	D031	3
771	D035	1
771	D048	2
772	D040	2
772	D036	3
773	D013	2
773	D030	3
773	D018	2
774	D035	3
774	D054	3
775	D025	2
776	D053	3
777	D067	1
777	D048	3
778	D009	2
779	D065	3
779	D052	3
779	D018	1
780	D025	1
781	D032	1
782	D007	3
782	D047	1
783	D048	3
783	D060	2
784	D016	2
784	D004	2
784	D031	3
785	D023	3
785	D061	3
786	D045	2
786	D021	3
787	D012	2
787	D037	1
787	D004	1
788	D028	2
788	D029	3
788	D027	2
789	D003	1
789	D002	3
789	D061	1
790	D002	3
790	D029	2
790	D033	3
791	D036	2
791	D055	2
791	D049	2
792	D060	2
793	D067	1
793	D051	3
793	D014	3
794	D037	3
794	D039	1
795	D009	2
795	D044	3
796	D036	3
796	D034	3
797	D039	3
797	D025	1
797	D020	1
798	D052	3
798	D041	1
798	D018	3
799	D038	2
799	D034	2
800	D005	2
800	D025	3
801	D029	3
801	D061	2
801	D046	1
802	D024	2
802	D038	1
802	D013	3
803	D024	3
803	D043	1
804	D046	1
805	D040	2
805	D054	2
805	D043	3
806	D060	2
806	D016	1
807	D010	3
807	D061	1
807	D025	3
808	D039	1
808	D053	1
809	D026	2
810	D059	2
810	D019	3
811	D011	2
812	D023	3
812	D041	1
813	D058	2
814	D022	3
815	D063	1
816	D056	3
817	D052	2
817	D055	2
818	D005	3
819	D048	1
820	D025	3
820	D003	1
821	D032	2
821	D029	1
821	D045	1
822	D065	1
822	D040	1
823	D039	2
824	D067	2
824	D044	3
825	D044	2
826	D025	2
826	D022	1
827	D029	3
828	D028	3
829	D065	1
830	D047	3
831	D005	3
831	D049	3
831	D033	1
832	D007	1
832	D014	3
832	D003	1
833	D057	1
833	D049	3
834	D061	1
834	D020	3
835	D002	3
835	D039	1
835	D054	3
836	D035	1
836	D018	3
836	D054	3
837	D016	1
837	D037	2
837	D015	1
838	D026	1
838	D034	2
838	D067	3
839	D038	1
839	D021	3
840	D027	2
840	D062	1
841	D002	3
842	D015	3
843	D064	3
843	D020	1
843	D012	3
844	D013	2
844	D033	2
844	D030	2
845	D007	1
845	D013	1
846	D047	2
846	D041	3
847	D013	1
848	D018	3
849	D022	2
849	D043	3
849	D046	2
850	D012	1
850	D048	1
850	D044	2
851	D059	2
851	D035	3
852	D054	1
852	D022	1
853	D008	2
853	D021	3
853	D014	2
854	D057	2
854	D024	3
854	D049	1
855	D017	1
855	D062	2
855	D063	2
856	D009	2
857	D041	3
857	D002	2
857	D029	3
858	D013	2
858	D056	2
858	D032	3
859	D050	1
859	D020	3
859	D007	1
860	D061	1
860	D064	2
860	D022	2
861	D043	2
862	D065	1
863	D049	1
863	D052	2
863	D031	2
864	D058	2
864	D012	2
864	D064	1
865	D003	2
865	D014	2
866	D001	1
867	D039	3
867	D066	3
867	D027	2
868	D047	1
868	D007	2
869	D061	3
869	D047	2
870	D013	3
871	D001	2
872	D038	2
872	D067	3
873	D006	1
874	D018	1
874	D053	2
875	D026	2
875	D025	1
875	D016	2
876	D044	1
877	D006	2
877	D016	2
878	D065	1
878	D018	3
878	D064	3
879	D056	3
880	D066	3
880	D023	3
881	D017	1
882	D042	2
882	D065	2
883	D032	2
883	D036	2
883	D051	2
884	D018	2
885	D066	3
885	D039	3
885	D041	3
886	D028	3
886	D026	3
886	D027	2
887	D045	3
887	D017	3
887	D023	3
888	D042	3
888	D015	2
888	D046	3
889	D054	1
889	D037	3
889	D055	1
890	D049	1
891	D008	1
892	D021	3
892	D037	2
893	D008	3
894	D027	2
894	D005	2
895	D029	3
896	D050	3
896	D031	2
896	D066	3
897	D007	2
897	D049	3
897	D050	2
898	D007	1
898	D002	3
898	D033	2
899	D048	3
900	D026	2
900	D025	1
900	D038	3
901	D024	1
902	D066	1
902	D016	2
902	D049	2
903	D034	3
903	D017	2
903	D021	1
904	D060	1
904	D020	1
905	D007	2
905	D039	3
906	D046	3
906	D010	1
906	D041	1
907	D009	2
907	D065	3
907	D021	3
908	D012	1
908	D045	1
909	D043	1
909	D047	3
909	D038	3
910	D002	3
910	D015	2
911	D031	1
911	D032	3
912	D049	2
912	D015	2
913	D037	2
913	D004	3
913	D067	3
914	D063	2
914	D006	3
915	D042	3
916	D013	1
917	D001	3
917	D009	3
917	D027	1
918	D055	3
918	D014	3
918	D027	3
919	D010	1
919	D020	2
920	D043	1
920	D005	1
920	D012	1
921	D010	2
921	D030	2
922	D058	2
922	D052	2
923	D050	3
924	D001	3
925	D009	2
925	D006	3
925	D010	1
926	D039	2
926	D012	2
927	D051	2
927	D004	1
928	D029	3
928	D018	2
928	D051	3
929	D039	3
930	D048	1
930	D002	1
930	D019	1
931	D051	1
931	D011	3
931	D040	3
932	D045	3
932	D028	3
932	D053	1
933	D024	1
934	D033	1
934	D025	3
934	D015	3
935	D060	3
936	D010	2
936	D038	1
936	D009	1
937	D063	1
937	D043	3
937	D046	3
938	D013	2
939	D009	2
939	D025	2
939	D041	2
940	D040	2
940	D020	2
940	D047	1
941	D041	1
942	D056	2
943	D018	2
943	D043	2
944	D046	2
944	D040	3
945	D023	3
946	D011	3
946	D036	1
946	D018	2
947	D010	3
947	D003	1
947	D065	3
948	D052	3
948	D028	2
948	D005	3
949	D061	2
949	D020	1
949	D047	3
950	D038	3
950	D018	3
950	D060	1
951	D047	1
951	D065	3
952	D022	3
953	D058	1
954	D019	3
955	D062	1
955	D046	2
955	D006	1
956	D034	2
957	D006	3
958	D067	2
959	D061	1
959	D059	1
960	D042	3
960	D014	2
960	D067	3
961	D023	3
961	D049	2
962	D010	2
962	D067	2
963	D067	2
964	D045	2
964	D063	3
965	D065	1
966	D022	1
966	D030	3
967	D036	1
967	D028	1
967	D020	2
968	D016	2
968	D030	3
968	D054	1
969	D062	3
969	D027	1
970	D053	1
970	D003	1
970	D032	3
971	D021	1
971	D018	3
971	D066	1
972	D022	2
973	D067	2
974	D003	1
974	D037	2
974	D011	3
975	D062	1
975	D022	2
976	D019	2
976	D024	1
976	D066	3
977	D044	1
977	D059	2
977	D009	2
978	D014	1
979	D067	3
980	D054	1
980	D020	2
980	D013	3
981	D005	1
981	D065	2
981	D016	3
982	D001	3
983	D056	2
983	D067	1
983	D054	3
984	D055	2
984	D030	2
984	D062	3
985	D013	2
985	D055	2
985	D018	1
986	D037	3
987	D053	1
987	D033	3
987	D025	3
988	D067	1
989	D001	3
989	D049	2
989	D027	2
990	D014	2
990	D020	3
991	D033	3
991	D034	2
991	D055	3
992	D051	2
992	D027	3
993	D062	3
993	D023	3
993	D048	2
994	D040	3
994	D045	2
995	D018	2
995	D016	3
995	D030	1
996	D028	3
997	D044	1
997	D007	2
998	D001	2
998	D012	3
998	D019	2
999	D009	2
1	D002	2
1	D004	1
1	D024	1
1	D001	2
1050	D001	2
1050	D002	1
\.


--
-- TOC entry 5000 (class 0 OID 32961)
-- Dependencies: 228
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, user_name, age, gender, address, email, phone, created_at, updated_at, password, role) FROM stdin;
1	Đặng Thị Như	48	F	15 Chợ Đồng Xuân, Hoàn Kiếm	nhudangthi89606@gmail.com	0361498012	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangnhu382>	0
2	Phạm An Thư	25	F	3/10 Trần Thái Tông, Cầu Giấy	thuphaman31534@gmail.com	0834942591	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamthu333#	0
3	Hồ Thùy Huyền	30	F	35 Tôn Đức Thắng, Đống Đa	huyenhothuy24321@gmail.com	0162531301	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hohuyen600!	0
4	Đặng Thị Lan	45	F	196 Đội Cấn, Ba Đình	landangthi06219@gmail.com	0264480077	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	danglan735.	0
5	Lý Minh Khang	37	M	21 Giảng Võ, Ba Đình	khanglyminh22192@gmail.com	0727603189	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lykhang428|	0
6	Phạm Xuân Đào	39	F	78 Bà Triệu, Hoàn Kiếm	daophamxuan39115@gmail.com	0681483046	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamdao317:	0
7	Nguyễn Quang Lộc	63	M	17 Hàng Bài, Hoàn Kiếm	locnguyenquang71841@gmail.com	0558511989	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenloc802,	0
8	Nguyễn Văn Khang	54	M	1 Bạch Mai, Hai Bà Trưng	khangnguyenvan13869@gmail.com	0529062433	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenkhang939]	0
9	Bùi Quang Thuận	46	M	22 Nguyễn Hữu Huân, Hoàn Kiếm	thuanbuiquang61660@gmail.com	0956069689	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buithuan790-	0
10	Vũ Anh Khoa	19	M	15 Bạch Mai, Hai Bà Trưng	khoavuanh95947@gmail.com	0314084671	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vukhoa737.	0
11	Hoàng Xuân Linh	53	F	21 Nguyễn Thái Học, Ba Đình	linhhoangxuan62108@gmail.com	0574558380	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoanglinh609|	0
12	Ngô Gia Trung	31	M	70 Đường Tôn Đức Thắng, Đống Đa	trungngogia59843@gmail.com	0264648102	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngotrung088?	0
13	Phạm Quang Bách	31	M	88 Nguyễn Du, Hoàn Kiếm	bachphamquang41473@gmail.com	0329749087	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phambach485@	0
14	Lý Quang Minh	47	M	23 Lê Duẩn, Hoàn Kiếm	minhlyquang92869@gmail.com	0337254140	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyminh112|	0
15	Đặng Khánh Huyền	47	F	39 Nguyễn Du, Hoàn Kiếm	huyendangkhanh96106@gmail.com	0117384085	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	danghuyen338.	0
16	Bùi Gia Khoa	31	M	31 Cao Bá Quát, Ba Đình	khoabuigia19751@gmail.com	0818776541	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buikhoa733*	0
17	Võ Thu Hằng	30	F	52 Mai Dịch, Cầu Giấy	hangvothu97775@gmail.com	0435032393	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vohang173^	0
18	Võ Thiên Tiến	59	M	5 Tràng Tiền, Hoàn Kiếm	tienvothien83505@gmail.com	0679082507	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votien877&	0
19	Hồ Minh Tú	29	M	56 Trần Duy Hưng, Cầu Giấy	tuhominh94471@gmail.com	0198552949	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotu807!	0
20	Phan Gia Minh	21	M	56 Đào Tấn, Ba Đình	minhphangia74644@gmail.com	0804201533	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanminh559=	0
21	Đỗ Văn Trung	54	M	14 Trúc Khê, Đống Đa	trungdovan33428@gmail.com	0694827615	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotrung113!	0
22	Lý An Linh	59	F	15 Lê Duẩn, Hoàn Kiếm	linhlyan28216@gmail.com	0329620615	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lylinh673]	0
23	Hoàng Bích Thúy	58	F	25 Nguyễn Thái Học, Ba Đình	thuyhoangbich89184@gmail.com	0941890599	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthuy883:	0
24	Phạm Khánh Trang	50	F	31 Nguyễn Lương Bằng, Đống Đa	trangphamkhanh19284@gmail.com	0697706354	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtrang041*	0
25	Võ Thị Vân	26	F	27 Bà Triệu, Hoàn Kiếm	vanvothi86930@gmail.com	0225513964	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vovan159&	0
26	Phạm Tuệ Thảo	23	F	16 Nguyễn Thái Học, Ba Đình	thaophamtue49299@gmail.com	0287655836	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamthao515+	0
27	Dương Thiên Minh	53	M	16 Nguyễn Thái Học, Ba Đình	minhduongthien98263@gmail.com	0241815477	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongminh616@	0
28	Đỗ Gia Trung	25	M	20 Đào Tấn, Ba Đình	trungdogia30184@gmail.com	0305282729	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotrung729<	0
29	Vũ Khánh Huyền	62	F	33 Nguyễn Hữu Huân, Hoàn Kiếm	huyenvukhanh84320@gmail.com	0287136457	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuhuyen306}	0
30	Huỳnh Thiên Tú	51	M	8 Nguyễn Du, Hoàn Kiếm	tuhuynhthien46934@gmail.com	0204630688	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhtu848*	0
31	Huỳnh Bích Thảo	40	F	13 Nguyễn Chí Thanh, Đống Đa	thaohuynhbich81296@gmail.com	0514879167	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhthao963+	0
32	Lý Xuân Thúy	54	F	33 Nguyễn Huệ, Hoàn Kiếm	thuylyxuan73786@gmail.com	0235297785	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lythuy716.	0
33	Hoàng Anh Tú	29	M	18 Tô Hiệu, Cầu Giấy	tuhoanganh66961@gmail.com	0145415683	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangtu149,	0
34	Bùi Quang Phúc	49	M	58 Quốc Tử Giám, Đống Đa	phucbuiquang66784@gmail.com	0540231390	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buiphuc515/	0
35	Võ Bích Linh	28	F	57 Phan Bội Châu, Hoàn Kiếm	linhvobich73468@gmail.com	0213866033	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	volinh217!	0
36	Đặng Thu Nhung	41	F	26 Nguyễn Huệ, Hoàn Kiếm	nhungdangthu30088@gmail.com	0335669429	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangnhung543?	0
37	Đặng Khánh Như	56	F	19 Trần Quang Khải, Hoàn Kiếm	nhudangkhanh94560@gmail.com	0639887661	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangnhu310/	0
38	Bùi Khánh Trinh	33	F	28 Nguyễn Thái Học, Ba Đình	trinhbuikhanh00425@gmail.com	0205282756	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buitrinh329$	0
39	Đỗ Bích Trang	35	F	36 Tôn Đức Thắng, Đống Đa	trangdobich52827@gmail.com	0157862703	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotrang646%	0
40	Phan Văn Tuấn	25	M	14 Phan Đình Phùng, Ba Đình	tuanphanvan60564@gmail.com	0554002505	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantuan112.	0
41	Hồ Quang Phúc	41	M	4 Hàng Bài, Hoàn Kiếm	phuchoquang02394@gmail.com	0582085298	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hophuc463!	0
42	Hồ Thiên Hồ	30	M	18 Cầu Giấy, Đống Đa	hohothien02656@gmail.com	0153002606	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoho882>	0
43	Phan Gia Phúc	25	M	11 Giảng Võ, Ba Đình	phucphangia09330@gmail.com	0661898140	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanphuc801,	0
44	Lý Văn Phát	65	M	29 Trúc Khê, Đống Đa	phatlyvan17674@gmail.com	0470065963	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyphat522^	0
45	Vũ Thu Thư	34	F	17 Nguyễn Du, Hoàn Kiếm	thuvuthu27266@gmail.com	0396167971	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuthu464|	0
46	Trần Khánh Thúy	24	F	29 Đào Tấn, Ba Đình	thuytrankhanh70530@gmail.com	0440464466	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranthuy327.	0
47	Phan Thu Đào	18	F	14 Phan Đình Phùng, Ba Đình	daophanthu23865@gmail.com	0174440853	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phandao632=	0
48	Vũ Quang Huy	37	M	12 Tôn Đức Thắng, Đống Đa	huyvuquang13598@gmail.com	0303820366	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuhuy321>	0
49	Dương Văn Thuận	32	M	7 Lý Thái Tổ, Hoàn Kiếm	thuanduongvan76071@gmail.com	0776876756	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongthuan688!	0
50	Hồ Khánh Nhung	32	F	2 Lý Thường Kiệt, Hoàn Kiếm	nhunghokhanh25464@gmail.com	0696228620	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honhung981,	0
51	Huỳnh Quang Tùng	33	M	16 Nguyễn Thái Học, Ba Đình	tunghuynhquang85555@gmail.com	0801907464	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhtung783?	0
52	Nguyễn Văn Minh	34	M	19 Đào Tấn, Ba Đình	minhnguyenvan38628@gmail.com	0438199477	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenminh264{	0
53	Lê An Đào	63	F	20 Nguyễn Du, Hoàn Kiếm	daolean94571@gmail.com	0717796882	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ledao409#	0
54	Đỗ Thị Nguyệt	51	F	13 Trần Quang Khải, Hoàn Kiếm	nguyetdothi49041@gmail.com	0457123347	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	donguyet201_	0
55	Đỗ Văn Bảo	58	M	18 Đường Láng, Đống Đa	baodovan56292@gmail.com	0427237588	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dobao296)	0
56	Nguyễn Văn Phát	32	M	12 Tạ Quang Bửu, Hai Bà Trưng	phatnguyenvan54093@gmail.com	0986958182	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenphat813.	0
57	Vũ Thu Ly	44	F	10 Đặng Thái Thân, Hoàn Kiếm	lyvuthu48300@gmail.com	0660135669	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuly141&	0
58	Ngô Anh Hồ	28	M	6 Đinh Tiên Hoàng, Hoàn Kiếm	hongoanh40726@gmail.com	0130490299	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngoho809)	0
59	Đặng Gia Phúc	48	M	15 Bạch Mai, Hai Bà Trưng	phucdanggia28588@gmail.com	0152428680	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangphuc736)	0
60	Lê Văn Nam	37	M	1 Giảng Võ, Ba Đình	namlevan78295@gmail.com	0635383501	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lenam812)	0
61	Lý Gia Tùng	42	M	23 Trần Quang Khải, Hoàn Kiếm	tunglygia73829@gmail.com	0136018972	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytung039-	0
62	Hồ Khánh Như	60	F	100 Nguyễn Du, Hoàn Kiếm	nhuhokhanh95146@gmail.com	0653502523	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honhu727)	0
63	Hoàng Bích Thảo	59	F	36 Nguyễn Hữu Huân, Hoàn Kiếm	thaohoangbich05770@gmail.com	0941306113	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthao542|	0
64	Bùi Xuân Trinh	49	F	17 Hàng Bài, Hoàn Kiếm	trinhbuixuan65843@gmail.com	0622033840	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buitrinh593#	0
65	Phạm Anh Tú	62	M	18 Tô Hiệu, Cầu Giấy	tuphamanh81475@gmail.com	0351233165	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtu627&	0
66	Lý Tuệ Hằng	19	F	23 Lê Duẩn, Hoàn Kiếm	hanglytue43922@gmail.com	0642475896	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyhang580#	0
67	Ngô Thiên Bảo	61	M	14 Phan Đình Phùng, Ba Đình	baongothien08817@gmail.com	0512274228	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngobao117|	0
68	Hồ Quang Khang	35	M	2 Lý Thường Kiệt, Hoàn Kiếm	khanghoquang40815@gmail.com	0832396987	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hokhang246^	0
69	Phạm Thiên Khang	42	M	458 Minh Khai, Hai Bà Trưng	khangphamthien52097@gmail.com	0227480486	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamkhang668=	0
70	Huỳnh Tuệ Ly	27	F	2 Phạm Ngọc Thạch, Đống Đa	lyhuynhtue55253@gmail.com	0881851849	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhly958^	0
71	Phạm Xuân Huyền	20	F	2 Lý Thường Kiệt, Hoàn Kiếm	huyenphamxuan33114@gmail.com	0571416970	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamhuyen435{	0
72	Trần An Thư	39	F	31 Nguyễn Lương Bằng, Đống Đa	thutranan35021@gmail.com	0300920112	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranthu515,	0
73	Phạm Quang Minh	45	M	50 Chùa Bộc, Đống Đa	minhphamquang88715@gmail.com	0988124697	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamminh149^	0
74	Phan Xuân Thúy	28	F	30 Giảng Võ, Ba Đình	thuyphanxuan27265@gmail.com	0211746336	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanthuy845[	0
75	Hoàng Thu Thúy	31	F	458 Minh Khai, Hai Bà Trưng	thuyhoangthu29795@gmail.com	0415485183	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthuy130{	0
76	Nguyễn Gia Tiến	51	M	27 Hồ Tây, Tây Hồ	tiennguyengia91920@gmail.com	0325871378	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentien468*	0
77	Hoàng Xuân Chi	47	F	21 Đường Tôn Đức Thắng, Đống Đa	chihoangxuan67098@gmail.com	0923010779	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangchi839(	0
78	Dương Bích Thảo	40	F	30 Láng Hạ, Đống Đa	thaoduongbich63640@gmail.com	0684865491	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongthao993&	0
79	Lý Quang Thuận	21	M	12 Nguyễn Chí Thanh, Đống Đa	thuanlyquang61674@gmail.com	0624475300	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lythuan121=	0
80	Phạm Gia Nam	30	M	15 Chợ Đồng Xuân, Hoàn Kiếm	namphamgia78431@gmail.com	0716519795	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamnam196]	0
81	Đỗ Văn Tú	39	M	18 Đường Láng, Đống Đa	tudovan41416@gmail.com	0177883522	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotu884]	0
82	Đặng Gia Huy	54	M	72A Nguyễn Trãi, Thanh Xuân	huydanggia71988@gmail.com	0780134470	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	danghuy882[	0
83	Phan Xuân Thư	44	F	9 Nguyễn Huệ, Hoàn Kiếm	thuphanxuan54796@gmail.com	0714411867	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanthu862+	0
84	Lê Quang Minh	28	M	29 Đào Tấn, Ba Đình	minhlequang60805@gmail.com	0723980221	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	leminh450$	0
85	Nguyễn Minh Bảo	33	M	88 Tràng Tiền, Hoàn Kiếm	baonguyenminh85881@gmail.com	0258295120	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenbao735(	0
86	Đỗ Xuân Thảo	49	F	33 Bạch Mai, Hai Bà Trưng	thaodoxuan92641@gmail.com	0626032527	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dothao182+	0
87	Hồ Thùy Đào	61	F	13 Tràng Tiền, Hoàn Kiếm	daohothuy68411@gmail.com	0282607708	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hodao447?	0
88	Ngô Bích Trinh	46	F	15 Phan Bội Châu, Hoàn Kiếm	trinhngobich18487@gmail.com	0809271399	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngotrinh151+	0
89	Hồ Anh Hồ	45	M	50 Tôn Đức Thắng, Đống Đa	hohoanh48490@gmail.com	0942995540	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoho498=	0
90	Bùi Thùy Thư	43	F	34 Nguyễn Lương Bằng, Đống Đa	thubuithuy79490@gmail.com	0482179922	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buithu860>	0
91	Vũ Thùy Nguyệt	37	F	50 Tôn Đức Thắng, Đống Đa	nguyetvuthuy21779@gmail.com	0974658357	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vunguyet934^	0
92	Trần Văn Tiến	34	M	423 Lạc Long Quân, Tây Hồ	tientranvan32607@gmail.com	0714197902	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trantien604:	0
93	Võ Quang Phát	60	M	50 Chùa Bộc, Đống Đa	phatvoquang30876@gmail.com	0889766492	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vophat814#	0
94	Dương Gia Thuận	64	M	10 Trần Quang Khải, Hoàn Kiếm	thuanduonggia20798@gmail.com	0175376942	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongthuan550-	0
95	Trần Xuân Ly	61	F	78 Thái Thịnh, Đống Đa	lytranxuan50883@gmail.com	0443486880	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranly086#	0
96	Dương An Lan	19	F	15 Lê Duẩn, Hoàn Kiếm	landuongan88524@gmail.com	0619916011	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duonglan616|	0
97	Phan Anh Thuận	46	M	6 Đinh Tiên Hoàng, Hoàn Kiếm	thuanphananh69061@gmail.com	0542548575	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanthuan046%	0
98	Lý Thiên Phát	47	M	24 Nguyễn Du, Hoàn Kiếm	phatlythien61187@gmail.com	0415366268	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyphat541>	0
99	Phạm Anh Minh	49	M	14 Lê Duẩn, Ba Đình	minhphamanh83872@gmail.com	0981401344	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamminh242=	0
100	Phan Khánh Hằng	28	F	14 Lê Duẩn, Ba Đình	hangphankhanh17681@gmail.com	0387195810	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanhang288?	0
101	Hoàng Gia Minh	21	M	17 Trúc Khê, Đống Đa	minhhoanggia89838@gmail.com	0874572498	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangminh514.	0
102	Hoàng Xuân Thư	26	F	88 Tràng Tiền, Hoàn Kiếm	thuhoangxuan86593@gmail.com	0349008256	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthu220,	0
103	Trần Thu Hằng	40	F	28a Điện Biên Phủ, Ba Đình	hangtranthu75571@gmail.com	0362430991	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranhang990(	0
104	Lê Quang Tùng	61	M	27 Hồ Tây, Tây Hồ	tunglequang58992@gmail.com	0296106630	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	letung707@	0
105	Trần Anh Nam	60	M	88 Tràng Tiền, Hoàn Kiếm	namtrananh24341@gmail.com	0351239731	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trannam006&	0
106	Ngô Khánh Trinh	60	F	78 Thái Thịnh, Đống Đa	trinhngokhanh76893@gmail.com	0797221917	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngotrinh722|	0
107	Lý Văn Bách	55	M	6 Đinh Tiên Hoàng, Hoàn Kiếm	bachlyvan66532@gmail.com	0784557235	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lybach325-	0
108	Dương Thu Thảo	58	F	1 Tràng Tiền, Hoàn Kiếm	thaoduongthu03763@gmail.com	0663129917	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongthao296#	0
109	Hồ Quang Tú	53	M	16 Tô Hiệu, Cầu Giấy	tuhoquang59670@gmail.com	0831464440	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotu333=	0
110	Lý Bích Chi	46	F	28 Đào Tấn, Ba Đình	chilybich88042@gmail.com	0163879199	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lychi073,	0
111	Lê Minh Minh	54	M	12 Trúc Khê, Đống Đa	minhleminh33243@gmail.com	0200046467	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	leminh908-	0
112	Bùi Thiên Lộc	36	M	15 Trúc Khê, Đống Đa	locbuithien88063@gmail.com	0858249070	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	builoc367!	0
113	Hoàng Văn Lộc	47	M	11 Phan Bội Châu, Hoàn Kiếm	lochoangvan14942@gmail.com	0979972503	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangloc605+	0
114	Đỗ Quang Khoa	63	M	15 Lê Duẩn, Hoàn Kiếm	khoadoquang73079@gmail.com	0400817861	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dokhoa441>	0
115	Huỳnh Bích Trang	47	F	58 Trần Quang Khải, Hoàn Kiếm	tranghuynhbich98061@gmail.com	0794955529	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhtrang689@	0
116	Lý Thùy Hằng	60	F	21 Nguyễn Thái Học, Ba Đình	hanglythuy19545@gmail.com	0491962158	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyhang699<	0
117	Ngô Gia Minh	19	M	3/10 Trần Thái Tông, Cầu Giấy	minhngogia60169@gmail.com	0708019783	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngominh693*	0
118	Lý An Chi	21	F	31 Nguyễn Lương Bằng, Đống Đa	chilyan16486@gmail.com	0222984045	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lychi033)	0
119	Lý Khánh Linh	53	F	38 Nguyễn Thái Học, Ba Đình	linhlykhanh46499@gmail.com	0561822857	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lylinh460,	0
120	Đặng Gia Bách	59	M	12 Trúc Khê, Đống Đa	bachdanggia46964@gmail.com	0380707979	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangbach951^	0
121	Võ Thiên Nam	59	M	35 Nguyễn Chí Thanh, Đống Đa	namvothien57129@gmail.com	0475649331	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vonam404}	0
122	Vũ Xuân Ly	30	F	1 Lý Thường Kiệt, Hoàn Kiếm	lyvuxuan59222@gmail.com	0380452404	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuly156#	0
123	Phạm Thiên Tú	63	M	15 Bạch Mai, Hai Bà Trưng	tuphamthien40946@gmail.com	0717679213	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtu833(	0
124	Ngô Khánh Thảo	31	F	423 Lạc Long Quân, Tây Hồ	thaongokhanh53028@gmail.com	0953326971	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngothao439{	0
125	Đặng Quang Minh	42	M	16 Hoàng Quốc Việt, Cầu Giấy	minhdangquang47342@gmail.com	0483643188	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangminh292?	0
126	Nguyễn Khánh Lan	38	F	6 Phạm Ngọc Thạch, Đống Đa	lannguyenkhanh24706@gmail.com	0898571874	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenlan543!	0
127	Lý Khánh Đào	27	F	43 Nguyễn Thái Học, Ba Đình	daolykhanh52689@gmail.com	0925101435	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lydao347@	0
128	Huỳnh Minh Bách	39	M	37 Nguyễn Hữu Huân, Hoàn Kiếm	bachhuynhminh72464@gmail.com	0360722227	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhbach556&	0
129	Đặng Thị Thư	31	F	30 Láng Hạ, Đống Đa	thudangthi95397@gmail.com	0359102500	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangthu877-	0
130	Phạm Quang Trung	30	M	53 Nguyễn Hữu Huân, Hoàn Kiếm	trungphamquang68907@gmail.com	0880638181	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtrung506?	0
131	Hồ Thị Thúy	45	F	15 Nguyễn Du, Hoàn Kiếm	thuyhothi11913@gmail.com	0433369163	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hothuy256^	0
132	Lý Tuệ Thảo	21	F	38 Ngọc Khánh, Ba Đình	thaolytue77046@gmail.com	0447359980	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lythao757/	0
133	Bùi Thiên Khoa	40	M	45 Hàng Bài, Hoàn Kiếm	khoabuithien90155@gmail.com	0106400331	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buikhoa265;	0
134	Vũ Xuân Thúy	47	F	15 Nguyễn Du, Hoàn Kiếm	thuyvuxuan63260@gmail.com	0144426014	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuthuy043{	0
135	Lê Tuệ Trang	41	F	22 Cầu Giấy, Đống Đa	trangletue26284@gmail.com	0631220803	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	letrang474<	0
136	Hồ Anh Khang	45	M	10 Nguyễn Huệ, Hoàn Kiếm	khanghoanh85771@gmail.com	0273042532	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hokhang280/	0
137	Hoàng Thị Thúy	28	F	5 Tràng Tiền, Hoàn Kiếm	thuyhoangthi08189@gmail.com	0389011415	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthuy153.	0
138	Dương Gia Nam	36	M	36 Đinh Tiên Hoàng, Hoàn Kiếm	namduonggia69304@gmail.com	0776970830	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongnam787;	0
139	Đặng Anh Trung	52	M	6 Nguyễn Hữu Huân, Hoàn Kiếm	trungdanganh99238@gmail.com	0718765765	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangtrung964-	0
140	Đặng Thị Linh	45	F	78 Bà Triệu, Hoàn Kiếm	linhdangthi45747@gmail.com	0872807136	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	danglinh192(	0
141	Lê Gia Phúc	63	M	58 Quốc Tử Giám, Đống Đa	phuclegia79623@gmail.com	0164429635	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lephuc943)	0
142	Phan Anh Bảo	54	M	42 Bà Triệu, Hoàn Kiếm	baophananh49855@gmail.com	0455261571	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanbao492[	0
143	Hồ Thiên Khoa	48	M	14 Lê Duẩn, Ba Đình	khoahothien95848@gmail.com	0939896337	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hokhoa125#	0
144	Vũ Thùy Thảo	26	F	46 Láng Hạ, Đống Đa	thaovuthuy25541@gmail.com	0197830845	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuthao101?	0
145	Nguyễn Thiên Nam	60	M	88 Tràng Tiền, Hoàn Kiếm	namnguyenthien02877@gmail.com	0930938321	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyennam475;	0
146	Võ Quang Tiến	65	M	33 Nguyễn Huệ, Hoàn Kiếm	tienvoquang70221@gmail.com	0901956749	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votien304*	0
147	Bùi Thu Chi	28	F	12 Nguyễn Huệ, Hoàn Kiếm	chibuithu96531@gmail.com	0452653441	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buichi399?	0
148	Bùi Khánh Thúy	58	F	18 Tô Hiệu, Cầu Giấy	thuybuikhanh22708@gmail.com	0594472530	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buithuy401=	0
149	Bùi Thùy Thảo	18	F	7 Lý Thái Tổ, Hoàn Kiếm	thaobuithuy07320@gmail.com	0918377380	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buithao707>	0
150	Đặng Bích Thúy	51	F	14 Lê Duẩn, Ba Đình	thuydangbich01318@gmail.com	0465657228	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangthuy417@	0
151	Phan Anh Tú	48	M	15 Quảng An, Tây Hồ	tuphananh58813@gmail.com	0937367342	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantu835)	0
152	Trần Bích Linh	61	F	8 Lê Đại Hành, Hai Bà Trưng	linhtranbich71813@gmail.com	0901260776	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranlinh371+	0
153	Lê Khánh Hằng	40	F	Lotte Center Hanoi, 54 Liễu Giai, Ba Đình	hanglekhanh44305@gmail.com	0170668986	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lehang713]	0
154	Võ Quang Bảo	26	M	1 Bạch Mai, Hai Bà Trưng	baovoquang82301@gmail.com	0916287965	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vobao388?	0
155	Hoàng Văn Tuấn	34	M	58 Nguyễn Thái Học, Ba Đình	tuanhoangvan27942@gmail.com	0896536939	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangtuan741!	0
156	Nguyễn Thị Ly	26	F	38 Nguyễn Thái Học, Ba Đình	lynguyenthi46719@gmail.com	0122857906	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenly823@	0
157	Võ Gia Phúc	45	M	35 Tôn Đức Thắng, Đống Đa	phucvogia42382@gmail.com	0952261262	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vophuc460=	0
158	Nguyễn An Thúy	37	F	25 Hồ Tây, Tây Hồ	thuynguyenan18078@gmail.com	0104872987	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenthuy471:	0
159	Dương Khánh Trang	50	F	16 Nguyễn Thái Học, Ba Đình	trangduongkhanh90863@gmail.com	0887542593	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongtrang630[	0
160	Trần Quang Minh	47	M	26 Nguyễn Lương Bằng, Đống Đa	minhtranquang34214@gmail.com	0774820581	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranminh629]	0
161	Trần Gia Bảo	39	M	7 Hoàng Hoa Thám, Ba Đình	baotrangia72243@gmail.com	0175813738	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranbao743?	0
162	Vũ An Hằng	54	F	23 Trần Quang Khải, Hoàn Kiếm	hangvuan36951@gmail.com	0349875441	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuhang019&	0
163	Huỳnh Bích Thư	44	F	27 Hồ Tây, Tây Hồ	thuhuynhbich63147@gmail.com	0920333416	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhthu486,	0
164	Ngô Gia Tiến	34	M	45 Hàng Gai, Hoàn Kiếm	tienngogia54529@gmail.com	0689975216	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngotien655)	0
165	Ngô Minh Nam	58	M	8 Bà Triệu, Hoàn Kiếm	namngominh76769@gmail.com	0623782830	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngonam739|	0
166	Bùi Bích Chi	64	F	7 Tràng Tiền, Hoàn Kiếm	chibuibich17534@gmail.com	0783370075	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buichi033[	0
167	Lê Gia Hồ	38	M	11 Tô Ngọc Vân, Tây Hồ	holegia36114@gmail.com	0962049189	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	leho495_	0
168	Đỗ Anh Bách	46	M	1 Tràng Tiền, Hoàn Kiếm	bachdoanh00279@gmail.com	0756500259	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dobach222!	0
169	Phạm Gia Tuấn	65	M	56 Đường Láng, Đống Đa	tuanphamgia37541@gmail.com	0644804290	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtuan834%	0
170	Bùi Minh Tú	18	M	44B Thái Thịnh, Đống Đa	tubuiminh00111@gmail.com	0250681801	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buitu010^	0
171	Hồ Gia Tú	43	M	11 Phan Bội Châu, Hoàn Kiếm	tuhogia83706@gmail.com	0574831428	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotu720,	0
172	Lê Gia Khoa	58	M	36 Đinh Tiên Hoàng, Hoàn Kiếm	khoalegia91941@gmail.com	0895444986	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lekhoa178&	0
173	Hồ Thiên Nam	35	M	25 Nguyễn Lương Bằng, Đống Đa	namhothien25817@gmail.com	0327751295	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honam405]	0
174	Hồ Văn Tú	63	M	22 Nguyễn Du, Hoàn Kiếm	tuhovan72073@gmail.com	0857607315	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotu849)	0
175	Dương Anh Lộc	55	M	50 Tôn Đức Thắng, Đống Đa	locduonganh27669@gmail.com	0192016445	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongloc584]	0
176	Lý Gia Thuận	29	M	22 Láng Hạ, Đống Đa	thuanlygia88635@gmail.com	0163038976	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lythuan794*	0
177	Đỗ Gia Bách	51	M	38 Nguyễn Thái Học, Ba Đình	bachdogia85673@gmail.com	0907325448	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dobach927&	0
178	Bùi Xuân Chi	56	F	38 Nguyễn Thái Học, Ba Đình	chibuixuan06460@gmail.com	0184353024	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buichi672,	0
179	Bùi Thị Chi	18	F	5 Tràng Tiền, Hoàn Kiếm	chibuithi91129@gmail.com	0688084946	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buichi527#	0
180	Đặng An Đào	60	F	15 Ngô Quyền, Hoàn Kiếm	daodangan25965@gmail.com	0311383650	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangdao331<	0
181	Huỳnh An Nguyệt	38	F	50 Lý Thái Tổ, Hoàn Kiếm	nguyethuynhan22334@gmail.com	0654284196	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhnguyet133+	0
182	Huỳnh Văn Thuận	28	M	12 Hàng Bài, Hoàn Kiếm	thuanhuynhvan02665@gmail.com	0223213675	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhthuan465$	0
183	Hoàng Quang Tú	30	M	25 Nguyễn Thái Học, Ba Đình	tuhoangquang89422@gmail.com	0404963628	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangtu324]	0
184	Huỳnh Gia Nam	55	M	22 Hàng Bài, Hoàn Kiếm	namhuynhgia65025@gmail.com	0237201332	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhnam385(	0
185	Lý Quang Tùng	47	M	37 Lý Thái Tổ, Hoàn Kiếm	tunglyquang90851@gmail.com	0129313938	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytung241^	0
186	Đặng Văn Tú	41	M	8 Bà Triệu, Hoàn Kiếm	tudangvan04216@gmail.com	0800401605	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangtu610]	0
187	Huỳnh Khánh Ly	26	F	25 Nguyễn Lương Bằng, Đống Đa	lyhuynhkhanh74616@gmail.com	0446031856	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhly234!	0
188	Vũ Quang Phúc	50	M	23 Trúc Khê, Đống Đa	phucvuquang03727@gmail.com	0415370306	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuphuc616(	0
189	Võ Minh Huy	30	M	22 Cầu Giấy, Đống Đa	huyvominh21478@gmail.com	0379325698	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vohuy735>	0
190	Hồ Khánh Thảo	52	F	33 Nguyễn Hữu Huân, Hoàn Kiếm	thaohokhanh37296@gmail.com	0697754315	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hothao196+	0
191	Dương Văn Lộc	44	M	33 Nguyễn Huệ, Hoàn Kiếm	locduongvan83682@gmail.com	0257527468	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongloc503=	0
192	Trần Khánh Đào	58	F	8 Nguyễn Du, Hoàn Kiếm	daotrankhanh66670@gmail.com	0742361524	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trandao485-	0
193	Hồ Bích Ly	62	F	28 Nguyễn Thái Học, Ba Đình	lyhobich04914@gmail.com	0872911634	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	holy523<	0
194	Trần Thùy Linh	61	F	33 Nguyễn Huệ, Hoàn Kiếm	linhtranthuy64411@gmail.com	0937119881	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranlinh526]	0
195	Hồ Văn Bách	43	M	27 Bà Triệu, Hoàn Kiếm	bachhovan86422@gmail.com	0921940157	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hobach711:	0
196	Dương Xuân Đào	41	F	10 Hồ Tây, Tây Hồ	daoduongxuan31680@gmail.com	0548489186	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongdao288?	0
197	Võ Bích Hằng	34	F	28 Trúc Khê, Đống Đa	hangvobich22983@gmail.com	0116968529	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vohang723%	0
198	Hồ An Ly	33	F	37 Lý Thái Tổ, Hoàn Kiếm	lyhoan84465@gmail.com	0361934590	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	holy840*	0
199	Nguyễn Gia Bảo	46	M	40 Hàng Bài, Hoàn Kiếm	baonguyengia88051@gmail.com	0846682903	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenbao889<	0
200	Đặng Anh Minh	62	M	40 Nguyễn Hữu Huân, Hoàn Kiếm	minhdanganh65049@gmail.com	0779456927	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangminh646>	0
201	Dương An Chi	58	F	11 Giảng Võ, Ba Đình	chiduongan77245@gmail.com	0673227322	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongchi189/	0
202	Phan Xuân Huyền	38	F	25 Hồ Tây, Tây Hồ	huyenphanxuan31815@gmail.com	0961743819	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanhuyen367&	0
203	Lê Quang Tiến	28	M	29 Tràng Tiền, Hoàn Kiếm	tienlequang05028@gmail.com	0125112977	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	letien898+	0
204	Đỗ Thiên Tuấn	52	M	58 Quốc Tử Giám, Đống Đa	tuandothien23914@gmail.com	0739051670	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotuan279+	0
205	Phan An Nguyệt	30	F	10 Tràng Tiền, Hoàn Kiếm	nguyetphanan54256@gmail.com	0140309121	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phannguyet995*	0
206	Đặng Thùy Huyền	62	F	12 Tạ Quang Bửu, Hai Bà Trưng	huyendangthuy28008@gmail.com	0411889694	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	danghuyen701<	0
207	Hồ Anh Khoa	27	M	13 Tràng Tiền, Hoàn Kiếm	khoahoanh08239@gmail.com	0333323766	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hokhoa319>	0
208	Vũ Xuân Trang	63	F	423 Lạc Long Quân, Tây Hồ	trangvuxuan24701@gmail.com	0573233692	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vutrang054(	0
209	Võ Tuệ Thư	51	F	27 Bà Triệu, Hoàn Kiếm	thuvotue85991@gmail.com	0968749220	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vothu361:	0
210	Bùi Khánh Thúy	24	F	10 Đặng Thái Thân, Hoàn Kiếm	thuybuikhanh02596@gmail.com	0379339235	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buithuy564,	0
211	Hồ Thiên Nam	34	M	19 Ngọc Hà, Ba Đình	namhothien42724@gmail.com	0778583197	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honam494&	0
212	Huỳnh Quang Minh	46	M	19 Trần Quang Khải, Hoàn Kiếm	minhhuynhquang55649@gmail.com	0422833381	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhminh751&	0
213	Lý Thu Nguyệt	18	F	12 Đào Tấn, Ba Đình	nguyetlythu71191@gmail.com	0746794732	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lynguyet302}	0
214	Hồ An Hằng	60	F	43 Bà Triệu, Hoàn Kiếm	hanghoan59911@gmail.com	0302187358	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hohang802.	0
215	Đặng Anh Khang	41	M	58 Quốc Tử Giám, Đống Đa	khangdanganh57967@gmail.com	0658719764	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangkhang063.	0
216	Lý An Nguyệt	58	F	28 Trúc Khê, Đống Đa	nguyetlyan49638@gmail.com	0194459932	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lynguyet259&	0
217	Hoàng Gia Bảo	52	M	34 Nguyễn Lương Bằng, Đống Đa	baohoanggia55293@gmail.com	0800187811	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangbao874!	0
218	Huỳnh Khánh Đào	28	F	56 Lý Thái Tổ, Hoàn Kiếm	daohuynhkhanh36418@gmail.com	0804364368	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhdao227#	0
219	Dương Thùy Thư	65	F	22 Nguyễn Du, Hoàn Kiếm	thuduongthuy83566@gmail.com	0257733825	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongthu344?	0
220	Lý Minh Thuận	53	M	7 Hoàng Hoa Thám, Ba Đình	thuanlyminh24363@gmail.com	0361177942	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lythuan009_	0
221	Đỗ Thùy Thảo	25	F	87 Láng Hạ, Đống Đa	thaodothuy38323@gmail.com	0311049286	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dothao862[	0
222	Bùi Xuân Nguyệt	41	F	20 Giảng Võ, Ba Đình	nguyetbuixuan23926@gmail.com	0348182364	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buinguyet352,	0
223	Lê Thị Nguyệt	41	F	32 Láng Hạ, Đống Đa	nguyetlethi75799@gmail.com	0468083636	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lenguyet363{	0
224	Phạm Tuệ Thảo	50	F	30 Đinh Tiên Hoàng, Hoàn Kiếm	thaophamtue81520@gmail.com	0877268544	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamthao889|	0
225	Hoàng Minh Huy	54	M	1 Lý Thường Kiệt, Hoàn Kiếm	huyhoangminh51891@gmail.com	0129624335	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoanghuy157#	0
226	Vũ An Thúy	49	F	Long Biên, Hà Nội	thuyvuan50395@gmail.com	0832834633	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuthuy762,	0
227	Lý Anh Bảo	44	M	99 Phan Đình Phùng, Ba Đình	baolyanh88808@gmail.com	0852697481	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lybao580%	0
228	Lê Thùy Lan	38	F	1 Nguyễn Du, Hoàn Kiếm	lanlethuy81604@gmail.com	0775013579	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lelan109#	0
229	Nguyễn Xuân Vân	33	F	1 Giảng Võ, Ba Đình	vannguyenxuan87847@gmail.com	0773954182	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenvan793|	0
230	Hồ Gia Phát	21	M	26 Bà Triệu, Hoàn Kiếm	phathogia32806@gmail.com	0104884322	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hophat872{	0
231	Phạm Gia Huy	26	M	29 Hòa Mã, Hai Bà Trưng	huyphamgia91092@gmail.com	0148597823	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamhuy661?	0
232	Hồ Anh Bảo	26	M	29 Tràng Tiền, Hoàn Kiếm	baohoanh15504@gmail.com	0487008650	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hobao205%	0
233	Bùi Quang Minh	47	M	30 Bạch Mai, Hai Bà Trưng	minhbuiquang49241@gmail.com	0456924617	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buiminh958_	0
234	Lý An Trang	27	F	7 Lý Thái Tổ, Hoàn Kiếm	tranglyan65127@gmail.com	0957493094	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytrang634<	0
235	Hồ Minh Phúc	49	M	20 Giảng Võ, Ba Đình	phuchominh64841@gmail.com	0670635850	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hophuc836@	0
236	Đặng Minh Phúc	42	M	36 Nguyễn Hữu Huân, Hoàn Kiếm	phucdangminh60914@gmail.com	0526266866	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangphuc348;	0
237	Bùi Gia Nam	34	M	37 Nguyễn Hữu Huân, Hoàn Kiếm	nambuigia34285@gmail.com	0134010648	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buinam710<	0
238	Phạm Quang Trung	64	M	15 Lê Duẩn, Hoàn Kiếm	trungphamquang89694@gmail.com	0646524456	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtrung556}	0
239	Đặng Quang Khoa	65	M	1 Nguyễn Du, Hoàn Kiếm	khoadangquang39367@gmail.com	0160326216	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangkhoa227(	0
240	Lý Thùy Như	32	F	31 Cao Bá Quát, Ba Đình	nhulythuy68866@gmail.com	0518155389	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lynhu920^	0
241	Huỳnh Văn Hồ	30	M	50 Tôn Đức Thắng, Đống Đa	hohuynhvan65436@gmail.com	0518284587	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhho779/	0
242	Hồ Bích Vân	40	F	18 Giảng Võ, Ba Đình	vanhobich66613@gmail.com	0277189948	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hovan820(	0
243	Trần Thùy Trang	56	F	35 Nguyễn Chí Thanh, Đống Đa	trangtranthuy25868@gmail.com	0868464458	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trantrang299_	0
244	Lê Tuệ Nhung	60	F	27 Lý Thái Tổ, Hoàn Kiếm	nhungletue30796@gmail.com	0590190075	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lenhung305&	0
245	Huỳnh Minh Nam	49	M	196 Đội Cấn, Ba Đình	namhuynhminh32893@gmail.com	0574304334	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhnam670^	0
246	Phạm Thùy Nhung	41	F	45 Giảng Võ, Ba Đình	nhungphamthuy98790@gmail.com	0910451885	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamnhung117*	0
247	Lê Văn Bảo	53	M	10 Nguyễn Huệ, Hoàn Kiếm	baolevan87709@gmail.com	0570786430	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lebao592,	0
248	Ngô Bích Lan	30	F	30 Lý Thái Tổ, Hoàn Kiếm	lanngobich51964@gmail.com	0179270066	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngolan468|	0
249	Võ Thiên Tuấn	28	M	58 Phan Đình Phùng, Ba Đình	tuanvothien60568@gmail.com	0243653506	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votuan417<	0
250	Phan Tuệ Đào	32	F	11 Giảng Võ, Ba Đình	daophantue70432@gmail.com	0431333894	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phandao685?	0
251	Nguyễn Anh Minh	49	M	11 Nguyễn Du, Hoàn Kiếm	minhnguyenanh67860@gmail.com	0230548943	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenminh122=	0
252	Trần Minh Lộc	43	M	8 Đinh Tiên Hoàng, Hoàn Kiếm	loctranminh27006@gmail.com	0731099429	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranloc564;	0
253	Lê Tuệ Huyền	53	F	7 Hoàng Hoa Thám, Ba Đình	huyenletue28854@gmail.com	0704602321	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lehuyen714/	0
254	Lê Thiên Tú	39	M	10 Tôn Đức Thắng, Đống Đa	tulethien35427@gmail.com	0111725594	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	letu536*	0
255	Võ An Như	38	F	28 Nguyễn Thái Học, Ba Đình	nhuvoan33269@gmail.com	0438724313	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vonhu083^	0
256	Lê Xuân Lan	22	F	17 Giảng Võ, Ba Đình	lanlexuan54311@gmail.com	0338786751	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lelan989(	0
257	Lê Thiên Minh	25	M	11 Tô Ngọc Vân, Tây Hồ	minhlethien56697@gmail.com	0928279422	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	leminh221<	0
258	Hồ Văn Khoa	56	M	15 Ngô Quyền, Hoàn Kiếm	khoahovan97601@gmail.com	0764660967	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hokhoa417<	0
259	Phạm Văn Phúc	35	M	50 Lý Thái Tổ, Hoàn Kiếm	phucphamvan19621@gmail.com	0540231911	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamphuc931?	0
260	Ngô Minh Thuận	24	M	21 Nguyễn Thái Học, Ba Đình	thuanngominh12533@gmail.com	0202474927	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngothuan096(	0
261	Phạm Xuân Như	65	F	30 Bạch Mai, Hai Bà Trưng	nhuphamxuan29465@gmail.com	0471690851	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamnhu143}	0
262	Phan Thu Thảo	19	F	18 Cầu Giấy, Đống Đa	thaophanthu01765@gmail.com	0746595942	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanthao608,	0
263	Nguyễn Quang Hồ	24	M	56 Lý Thái Tổ, Hoàn Kiếm	honguyenquang49971@gmail.com	0805084670	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenho150<	0
264	Hồ An Trinh	19	F	27 Hòa Mã, Hai Bà Trưng	trinhhoan59797@gmail.com	0497762692	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotrinh262!	0
265	Dương Xuân Trang	25	F	22 Cầu Giấy, Đống Đa	trangduongxuan52365@gmail.com	0752636764	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongtrang356[	0
266	Ngô Anh Bách	64	M	9 Bạch Mai, Hai Bà Trưng	bachngoanh21719@gmail.com	0937779964	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngobach019.	0
267	Đỗ Thu Chi	31	F	27 Lý Thái Tổ, Hoàn Kiếm	chidothu41279@gmail.com	0280499166	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dochi670!	0
268	Đỗ Thiên Khoa	37	M	27 Phan Đình Phùng, Ba Đình	khoadothien62619@gmail.com	0673951072	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dokhoa002)	0
269	Dương Gia Phát	50	M	22 Hàng Bài, Hoàn Kiếm	phatduonggia05254@gmail.com	0557570038	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongphat780|	0
270	Hồ An Thúy	63	F	33 Nguyễn Huệ, Hoàn Kiếm	thuyhoan39966@gmail.com	0302692067	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hothuy277@	0
271	Hoàng Thiên Khang	48	M	8 Lê Đại Hành, Hai Bà Trưng	khanghoangthien87019@gmail.com	0982470716	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangkhang436$	0
272	Bùi Khánh Chi	57	F	13 Tràng Tiền, Hoàn Kiếm	chibuikhanh13808@gmail.com	0261587693	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buichi413?	0
273	Dương Anh Thuận	57	M	14 Giảng Võ, Ba Đình	thuanduonganh36979@gmail.com	0167551241	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongthuan195#	0
274	Nguyễn Gia Tú	20	M	57B Đinh Tiên Hoàng, Hoàn Kiếm	tunguyengia95946@gmail.com	0400483899	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentu789;	0
275	Hoàng Tuệ Ly	52	F	22 Cầu Giấy, Đống Đa	lyhoangtue51860@gmail.com	0928500614	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangly558.	0
276	Hồ Xuân Vân	25	F	25 Hồ Tây, Tây Hồ	vanhoxuan13500@gmail.com	0366559058	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hovan375.	0
277	Trần Thiên Trung	40	M	11 Nguyễn Du, Hoàn Kiếm	trungtranthien54251@gmail.com	0572722406	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trantrung680>	0
278	Lê Bích Nhung	41	F	36 Nguyễn Du, Hoàn Kiếm	nhunglebich04771@gmail.com	0815069228	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lenhung925[	0
279	Ngô Thu Như	40	F	10 Lê Duẩn, Hoàn Kiếm	nhungothu70913@gmail.com	0410240993	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngonhu565>	0
280	Huỳnh Xuân Trang	47	F	32 Láng Hạ, Đống Đa	tranghuynhxuan77750@gmail.com	0339776849	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhtrang098&	0
281	Đỗ Văn Minh	51	M	33 Nguyễn Hữu Huân, Hoàn Kiếm	minhdovan51883@gmail.com	0449001041	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dominh272.	0
282	Huỳnh Tuệ Đào	55	F	30 Giảng Võ, Ba Đình	daohuynhtue48811@gmail.com	0949444414	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhdao919+	0
283	Lý Gia Tùng	40	M	20 Nguyễn Du, Hoàn Kiếm	tunglygia36502@gmail.com	0209896998	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytung190&	0
284	Đặng Minh Phát	36	M	11 Giảng Võ, Ba Đình	phatdangminh02737@gmail.com	0629026536	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangphat645&	0
285	Ngô Văn Trung	57	M	27/52 Tô Ngọc Vân, Tây Hồ	trungngovan15471@gmail.com	0990773571	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngotrung692=	0
286	Vũ Minh Phát	24	M	26 Nguyễn Lương Bằng, Đống Đa	phatvuminh79052@gmail.com	0576811326	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuphat799@	0
287	Hồ Minh Phát	50	M	12 Hàng Bài, Hoàn Kiếm	phathominh81294@gmail.com	0991946963	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hophat692.	0
288	Hoàng Xuân Huyền	23	F	56 Cầu Giấy, Đống Đa	huyenhoangxuan62026@gmail.com	0187760075	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoanghuyen178}	0
289	Vũ Thùy Ly	45	F	17 Nguyễn Du, Hoàn Kiếm	lyvuthuy87461@gmail.com	0466039244	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuly985#	0
290	Phạm Anh Tuấn	43	M	53 Nguyễn Hữu Huân, Hoàn Kiếm	tuanphamanh79082@gmail.com	0539965405	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtuan863!	0
291	Trần Văn Minh	19	M	57B Đinh Tiên Hoàng, Hoàn Kiếm	minhtranvan19085@gmail.com	0977256281	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranminh755]	0
292	Hồ Thu Thư	21	F	13 Phạm Ngọc Thạch, Đống Đa	thuhothu81519@gmail.com	0837936644	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hothu436/	0
293	Nguyễn Khánh Ly	40	F	87 Láng Hạ, Đống Đa	lynguyenkhanh78169@gmail.com	0384794731	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenly522?	0
294	Đỗ An Hằng	51	F	58 Quốc Tử Giám, Đống Đa	hangdoan42069@gmail.com	0234033403	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dohang204-	0
295	Phan Quang Hồ	53	M	18 Lý Thái Tổ, Hoàn Kiếm	hophanquang17212@gmail.com	0974901552	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanho656!	0
296	Lý Xuân Ly	49	F	56 Đường Láng, Đống Đa	lylyxuan96329@gmail.com	0945913886	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyly306@	0
297	Nguyễn Thùy Trang	51	F	17 Trúc Khê, Đống Đa	trangnguyenthuy37721@gmail.com	0247532831	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentrang079=	0
298	Dương Thu Chi	43	F	2 Lý Thường Kiệt, Hoàn Kiếm	chiduongthu72015@gmail.com	0169694751	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongchi249}	0
299	Hoàng Tuệ Lan	31	F	11 Tô Ngọc Vân, Tây Hồ	lanhoangtue18319@gmail.com	0784819763	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoanglan771@	0
300	Phan Văn Phúc	51	M	27 Hòa Mã, Hai Bà Trưng	phucphanvan86161@gmail.com	0983646531	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanphuc144}	0
301	Lê Anh Minh	24	M	14 Tôn Đức Thắng, Đống Đa	minhleanh39718@gmail.com	0245220045	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	leminh660+	0
302	Hoàng Thiên Minh	65	M	29 Hòa Mã, Hai Bà Trưng	minhhoangthien90059@gmail.com	0319936488	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangminh726%	0
303	Hồ Minh Tiến	60	M	37A Hai Bà Trưng, Hoàn Kiếm	tienhominh06156@gmail.com	0251610687	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotien691/	0
304	Võ Xuân Lan	34	F	458 Minh Khai, Hai Bà Trưng	lanvoxuan21243@gmail.com	0313815677	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	volan417,	0
305	Lý Khánh Nhung	27	F	27 Bà Triệu, Hoàn Kiếm	nhunglykhanh26997@gmail.com	0450632217	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lynhung583=	0
306	Phạm Xuân Đào	41	F	30 Láng Hạ, Đống Đa	daophamxuan63621@gmail.com	0450714638	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamdao437.	0
307	Vũ Khánh Huyền	62	F	14 Đinh Tiên Hoàng, Hoàn Kiếm	huyenvukhanh80346@gmail.com	0516121365	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuhuyen247!	0
308	Lê Minh Nam	21	M	11 Giảng Võ, Ba Đình	namleminh09092@gmail.com	0961387234	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lenam027*	0
309	Võ Quang Bảo	27	M	19 Tràng Tiền, Hoàn Kiếm	baovoquang11818@gmail.com	0949620036	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vobao725[	0
310	Vũ Tuệ Hằng	49	F	30 Giảng Võ, Ba Đình	hangvutue41093@gmail.com	0696353497	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuhang615&	0
311	Huỳnh Thị Thảo	39	F	26 Nguyễn Lương Bằng, Đống Đa	thaohuynhthi71126@gmail.com	0699024637	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhthao188)	0
312	Trần Minh Hồ	32	M	25 Bạch Mai, Hai Bà Trưng	hotranminh06249@gmail.com	0334510551	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranho779,	0
313	Huỳnh Thùy Nguyệt	62	F	Lotte Center Hanoi, 54 Liễu Giai, Ba Đình	nguyethuynhthuy46952@gmail.com	0116100988	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhnguyet204(	0
314	Bùi Thiên Tuấn	19	M	1 Tràng Tiền, Hoàn Kiếm	tuanbuithien75956@gmail.com	0707622501	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buituan711(	0
315	Hoàng Thị Thúy	65	F	45 Giảng Võ, Ba Đình	thuyhoangthi65589@gmail.com	0282742433	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthuy005:	0
316	Đặng Gia Trung	23	M	59 Lý Thái Tổ, Hoàn Kiếm	trungdanggia22112@gmail.com	0904841803	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangtrung306&	0
317	Bùi An Chi	63	F	10 Hồ Tây, Tây Hồ	chibuian17009@gmail.com	0296256254	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buichi646:	0
318	Vũ Văn Phát	44	M	34 Nguyễn Lương Bằng, Đống Đa	phatvuvan33712@gmail.com	0539705504	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuphat655%	0
319	Phạm Minh Khang	50	M	50 Tôn Đức Thắng, Đống Đa	khangphamminh25239@gmail.com	0225438811	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamkhang413^	0
320	Bùi Thùy Nguyệt	53	F	Trung tâm Văn hóa Nghệ thuật Việt Nam	nguyetbuithuy80595@gmail.com	0465218574	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buinguyet388{	0
321	Nguyễn Văn Tiến	19	M	45 Giảng Võ, Ba Đình	tiennguyenvan04459@gmail.com	0716045827	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentien327|	0
322	Nguyễn Gia Huy	27	M	72A Nguyễn Trãi, Thanh Xuân	huynguyengia93239@gmail.com	0718438862	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenhuy617}	0
323	Trần Thùy Thảo	24	F	12 Nguyễn Chí Thanh, Đống Đa	thaotranthuy97500@gmail.com	0741474888	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranthao936.	0
324	Hồ An Hằng	43	F	28a Điện Biên Phủ, Ba Đình	hanghoan17685@gmail.com	0188201180	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hohang590<	0
325	Lý An Như	27	F	40 Phan Đình Phùng, Ba Đình	nhulyan59600@gmail.com	0276984414	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lynhu173_	0
326	Ngô Văn Tiến	31	M	14 Trần Quang Khải, Hoàn Kiếm	tienngovan47145@gmail.com	0706776172	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngotien929@	0
327	Lý An Ly	38	F	36 Tôn Đức Thắng, Đống Đa	lylyan98005@gmail.com	0561286137	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyly429&	0
328	Huỳnh Thùy Linh	37	F	14 Giảng Võ, Ba Đình	linhhuynhthuy35625@gmail.com	0942414631	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhlinh132,	0
329	Huỳnh Xuân Lan	64	F	23 Trúc Khê, Đống Đa	lanhuynhxuan60535@gmail.com	0160597348	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhlan799^	0
330	Bùi Thị Trang	45	F	28 Nguyễn Thái Học, Ba Đình	trangbuithi00138@gmail.com	0644334915	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buitrang209/	0
331	Vũ Khánh Linh	55	F	12 Tạ Quang Bửu, Hai Bà Trưng	linhvukhanh68477@gmail.com	0176312651	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vulinh797,	0
332	Nguyễn Tuệ Thư	59	F	50 Chùa Bộc, Đống Đa	thunguyentue76952@gmail.com	0364952600	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenthu874-	0
333	Đặng Tuệ Trang	37	F	19 Ngọc Hà, Ba Đình	trangdangtue02727@gmail.com	0243330916	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangtrang840/	0
334	Võ Quang Bảo	38	M	45 Hàng Bài, Hoàn Kiếm	baovoquang42312@gmail.com	0725228761	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vobao934]	0
335	Huỳnh Quang Minh	30	M	10 Hồ Tây, Tây Hồ	minhhuynhquang71588@gmail.com	0772891413	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhminh142*	0
336	Hoàng Thị Trinh	46	F	19 Tràng Tiền, Hoàn Kiếm	trinhhoangthi69039@gmail.com	0393890900	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangtrinh132_	0
337	Vũ Tuệ Như	47	F	22 Hàng Bài, Hoàn Kiếm	nhuvutue53684@gmail.com	0691939872	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vunhu789/	0
338	Dương Quang Tùng	42	M	19 Nguyễn Huệ, Hoàn Kiếm	tungduongquang77008@gmail.com	0523664415	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongtung727<	0
339	Lý Khánh Ly	41	F	44 Phan Đình Phùng, Ba Đình	lylykhanh41641@gmail.com	0899064302	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyly677*	0
340	Lý Bích Thảo	28	F	37 Nguyễn Hữu Huân, Hoàn Kiếm	thaolybich73592@gmail.com	0791995516	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lythao194|	0
341	Bùi Gia Phúc	39	M	13 Tràng Tiền, Hoàn Kiếm	phucbuigia58398@gmail.com	0548605041	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buiphuc784+	0
342	Lý Thiên Hồ	43	M	26 Bà Triệu, Hoàn Kiếm	holythien05255@gmail.com	0216043254	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyho172]	0
343	Ngô Tuệ Huyền	28	F	20 Giảng Võ, Ba Đình	huyenngotue56716@gmail.com	0610390819	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngohuyen840&	0
344	Phạm Thiên Minh	64	M	15 Lý Thái Tổ, Hoàn Kiếm	minhphamthien99938@gmail.com	0384574194	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamminh489=	0
345	Trần Thiên Tú	61	M	28 Đào Tấn, Ba Đình	tutranthien03053@gmail.com	0928714383	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trantu212(	0
346	Lê Anh Tuấn	52	M	196 Đội Cấn, Ba Đình	tuanleanh70531@gmail.com	0960197086	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	letuan558@	0
347	Lê An Nguyệt	27	F	43 Bà Triệu, Hoàn Kiếm	nguyetlean12562@gmail.com	0217416746	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lenguyet690^	0
348	Võ An Linh	39	F	27 Cổ Linh, Long Biên	linhvoan13417@gmail.com	0178855127	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	volinh800|	0
349	Võ Khánh Trinh	28	F	9 Bạch Mai, Hai Bà Trưng	trinhvokhanh29506@gmail.com	0711681643	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votrinh506}	0
350	Nguyễn Khánh Ly	35	F	12 Nguyễn Huệ, Hoàn Kiếm	lynguyenkhanh69944@gmail.com	0263120383	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenly699;	0
351	Lý Khánh Chi	25	F	16 Hoàng Quốc Việt, Cầu Giấy	chilykhanh37017@gmail.com	0947350608	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lychi717=	0
352	Phạm Quang Nam	24	M	33 Nguyễn Hữu Huân, Hoàn Kiếm	namphamquang26732@gmail.com	0109785375	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamnam299*	0
353	Đỗ Minh Tiến	57	M	58 Nguyễn Thái Học, Ba Đình	tiendominh91791@gmail.com	0673444937	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotien629&	0
354	Đỗ Gia Lộc	33	M	68 Phố Tràng Tiền, Hoàn Kiếm	locdogia97379@gmail.com	0431663588	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	doloc334=	0
355	Võ Văn Phúc	60	M	2 Phạm Ngọc Thạch, Đống Đa	phucvovan82145@gmail.com	0264921593	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vophuc754!	0
356	Dương Thùy Như	18	F	45 Đặng Thái Thân, Hoàn Kiếm	nhuduongthuy39752@gmail.com	0237361204	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongnhu762_	0
357	Hồ Xuân Huyền	52	F	58 Láng Hạ, Đống Đa	huyenhoxuan44912@gmail.com	0440343795	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hohuyen979%	0
358	Phan Thiên Hồ	33	M	15 Phan Bội Châu, Hoàn Kiếm	hophanthien07558@gmail.com	0962181480	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanho884$	0
359	Dương Anh Tuấn	36	M	1 Giảng Võ, Ba Đình	tuanduonganh26924@gmail.com	0575946160	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongtuan113*	0
360	Hoàng Gia Phúc	42	M	1 Bạch Mai, Hai Bà Trưng	phuchoanggia97090@gmail.com	0897048832	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangphuc151@	0
361	Vũ An Thư	41	F	12 Nguyễn Chí Thanh, Đống Đa	thuvuan82270@gmail.com	0176475570	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuthu730}	0
362	Huỳnh Minh Bảo	28	M	15 Quảng An, Tây Hồ	baohuynhminh08925@gmail.com	0784150131	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhbao275{	0
363	Hoàng Thùy Nguyệt	47	F	2 Phạm Ngọc Thạch, Đống Đa	nguyethoangthuy98915@gmail.com	0274742514	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangnguyet699+	0
364	Hoàng Bích Nguyệt	28	F	24 Nguyễn Hữu Huân, Hoàn Kiếm	nguyethoangbich26757@gmail.com	0128851616	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangnguyet916[	0
365	Ngô Khánh Chi	54	F	7 Lý Thái Tổ, Hoàn Kiếm	chingokhanh64346@gmail.com	0465266442	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngochi735}	0
366	Vũ Bích Ly	31	F	5 Tràng Tiền, Hoàn Kiếm	lyvubich20781@gmail.com	0212090882	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuly846)	0
367	Huỳnh Minh Phúc	50	M	13 Tràng Tiền, Hoàn Kiếm	phuchuynhminh24048@gmail.com	0366300546	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhphuc893+	0
368	Phan Gia Lộc	29	M	19 Nguyễn Hữu Huân, Hoàn Kiếm	locphangia42122@gmail.com	0900559078	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanloc766!	0
369	Vũ Minh Huy	27	M	28 Đào Tấn, Ba Đình	huyvuminh11694@gmail.com	0279440600	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuhuy192>	0
370	Ngô Thiên Khoa	37	M	12 Tôn Đức Thắng, Đống Đa	khoangothien61016@gmail.com	0418155499	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngokhoa511?	0
371	Phan Thùy Nhung	61	F	12 Trúc Khê, Đống Đa	nhungphanthuy05695@gmail.com	0975057958	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phannhung310/	0
372	Hồ Thu Đào	60	F	19 Nguyễn Hữu Huân, Hoàn Kiếm	daohothu52488@gmail.com	0703461459	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hodao915]	0
373	Nguyễn Khánh Thảo	62	F	22 Nguyễn Du, Hoàn Kiếm	thaonguyenkhanh47036@gmail.com	0760260766	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenthao840)	0
374	Huỳnh Tuệ Trinh	21	F	13 Nguyễn Chí Thanh, Đống Đa	trinhhuynhtue89508@gmail.com	0416661741	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhtrinh367-	0
375	Hoàng Thùy Thảo	30	F	29 Tràng Tiền, Hoàn Kiếm	thaohoangthuy10564@gmail.com	0175830963	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthao725_	0
376	Hoàng Khánh Vân	34	F	2 Lý Thường Kiệt, Hoàn Kiếm	vanhoangkhanh67884@gmail.com	0992895243	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangvan713$	0
377	Đặng Gia Tiến	42	M	1 Giảng Võ, Ba Đình	tiendanggia48979@gmail.com	0753409401	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangtien450,	0
378	Bùi Quang Khoa	44	M	3/10 Trần Thái Tông, Cầu Giấy	khoabuiquang31531@gmail.com	0689011679	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buikhoa659&	0
379	Đỗ An Thúy	27	F	37 Lý Thái Tổ, Hoàn Kiếm	thuydoan41907@gmail.com	0777040011	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dothuy107/	0
380	Đỗ Minh Thuận	32	M	57 Phan Chu Trinh, Hoàn Kiếm	thuandominh77103@gmail.com	0659360236	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dothuan600;	0
381	Dương Thiên Khoa	41	M	57B Đinh Tiên Hoàng, Hoàn Kiếm	khoaduongthien27002@gmail.com	0801066885	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongkhoa608:	0
382	Phạm Thùy Nguyệt	35	F	16 Hoàng Quốc Việt, Cầu Giấy	nguyetphamthuy93254@gmail.com	0644016149	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamnguyet544;	0
383	Nguyễn Văn Bảo	18	M	18 Cầu Giấy, Đống Đa	baonguyenvan79840@gmail.com	0632182682	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenbao001:	0
384	Huỳnh Thị Vân	61	F	19 Trần Quang Khải, Hoàn Kiếm	vanhuynhthi26682@gmail.com	0211447997	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhvan035_	0
385	Võ An Nguyệt	60	F	4 Hàng Bài, Hoàn Kiếm	nguyetvoan19213@gmail.com	0528255023	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vonguyet574)	0
386	Trần Xuân Lan	19	F	12 Bà Triệu, Hoàn Kiếm	lantranxuan58195@gmail.com	0642883048	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranlan212{	0
387	Nguyễn Anh Bảo	49	M	12 Nguyễn Chí Thanh, Đống Đa	baonguyenanh40631@gmail.com	0632476453	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenbao527)	0
388	Huỳnh Thùy Lan	44	F	22 Cầu Giấy, Đống Đa	lanhuynhthuy75965@gmail.com	0165388476	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhlan770(	0
389	Trần Anh Trung	54	M	18 Nguyễn Hữu Huân, Hoàn Kiếm	trungtrananh43928@gmail.com	0118915734	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trantrung351*	0
390	Hoàng Tuệ Chi	55	F	7 Hoàng Hoa Thám, Ba Đình	chihoangtue33415@gmail.com	0631284381	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangchi889,	0
391	Hồ Thu Linh	24	F	32 Láng Hạ, Đống Đa	linhhothu73079@gmail.com	0383466883	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	holinh545,	0
392	Nguyễn Gia Tiến	57	M	10 Nguyễn Huệ, Hoàn Kiếm	tiennguyengia27070@gmail.com	0471959124	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentien143%	0
393	Phạm Bích Lan	64	F	41 Trúc Khê, Đống Đa	lanphambich90370@gmail.com	0603933551	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamlan346/	0
394	Lê Khánh Lan	25	F	4 Hàng Bài, Hoàn Kiếm	lanlekhanh52900@gmail.com	0983890385	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lelan507,	0
395	Huỳnh Xuân Huyền	47	F	12 Hàng Bài, Hoàn Kiếm	huyenhuynhxuan63519@gmail.com	0508528121	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhhuyen190$	0
396	Bùi Thị Ly	36	F	15 Chợ Đồng Xuân, Hoàn Kiếm	lybuithi28122@gmail.com	0149586555	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buily292]	0
397	Phạm Thu Đào	40	F	88 Tràng Tiền, Hoàn Kiếm	daophamthu89901@gmail.com	0827584432	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamdao687)	0
398	Lý Xuân Linh	47	F	21 Giảng Võ, Ba Đình	linhlyxuan36753@gmail.com	0832798596	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lylinh715>	0
399	Ngô Anh Khang	58	M	18 Lý Thái Tổ, Hoàn Kiếm	khangngoanh27498@gmail.com	0408314674	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngokhang639%	0
400	Lê Thiên Khoa	36	M	45 Nguyễn Thái Học, Ba Đình	khoalethien73916@gmail.com	0752122411	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lekhoa837?	0
401	Lê Văn Khang	37	M	17 Giảng Võ, Ba Đình	khanglevan45033@gmail.com	0954767847	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lekhang302(	0
402	Phan Quang Hồ	64	M	88 Nguyễn Du, Hoàn Kiếm	hophanquang09902@gmail.com	0179004408	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanho049-	0
403	Dương Tuệ Hằng	21	F	6 Phạm Ngọc Thạch, Đống Đa	hangduongtue67424@gmail.com	0943169902	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duonghang149&	0
404	Bùi Xuân Ly	21	F	10 Lê Duẩn, Hoàn Kiếm	lybuixuan69299@gmail.com	0762621020	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buily696#	0
405	Vũ Thùy Đào	35	F	37A Hai Bà Trưng, Hoàn Kiếm	daovuthuy62796@gmail.com	0689835141	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vudao693!	0
406	Nguyễn Văn Tiến	39	M	16 Tô Hiệu, Cầu Giấy	tiennguyenvan49486@gmail.com	0415876171	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentien086=	0
407	Phan Khánh Vân	28	F	6 Nguyễn Hữu Huân, Hoàn Kiếm	vanphankhanh74387@gmail.com	0277216606	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanvan298}	0
408	Nguyễn Gia Hồ	55	M	15 Chùa Bộc, Đống Đa	honguyengia09977@gmail.com	0983183937	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenho718]	0
409	Đỗ An Linh	18	F	36 Đinh Tiên Hoàng, Hoàn Kiếm	linhdoan70325@gmail.com	0720963744	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dolinh967%	0
410	Phan Văn Thuận	34	M	39 Nguyễn Du, Hoàn Kiếm	thuanphanvan02701@gmail.com	0470516398	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanthuan003:	0
411	Vũ Văn Minh	42	M	30 Đinh Tiên Hoàng, Hoàn Kiếm	minhvuvan26604@gmail.com	0532177757	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuminh805[	0
412	Hồ Tuệ Huyền	65	F	15 Chợ Đồng Xuân, Hoàn Kiếm	huyenhotue21502@gmail.com	0133568330	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hohuyen629%	0
413	Lê Khánh Lan	46	F	34 Nguyễn Lương Bằng, Đống Đa	lanlekhanh18933@gmail.com	0520700547	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lelan471@	0
414	Trần Văn Trung	56	M	30 Đinh Tiên Hoàng, Hoàn Kiếm	trungtranvan94907@gmail.com	0208461031	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trantrung240/	0
415	Nguyễn Gia Khang	22	M	8 Đinh Tiên Hoàng, Hoàn Kiếm	khangnguyengia75769@gmail.com	0693959231	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenkhang362!	0
416	Huỳnh Xuân Nguyệt	58	F	35 Nguyễn Chí Thanh, Đống Đa	nguyethuynhxuan74369@gmail.com	0240101308	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhnguyet725.	0
417	Võ Quang Thuận	60	M	11 Tô Ngọc Vân, Tây Hồ	thuanvoquang85371@gmail.com	0155862060	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vothuan249[	0
418	Vũ Thùy Huyền	60	F	19 Trần Quang Khải, Hoàn Kiếm	huyenvuthuy46487@gmail.com	0794109654	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuhuyen296/	0
419	Đỗ Khánh Thúy	43	F	30 Láng Hạ, Đống Đa	thuydokhanh23126@gmail.com	0205888169	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dothuy576|	0
420	Lý Gia Nam	61	M	12 Trúc Khê, Đống Đa	namlygia71891@gmail.com	0294849973	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lynam496:	0
421	Hoàng Văn Hồ	30	M	2 Lý Thường Kiệt, Hoàn Kiếm	hohoangvan42822@gmail.com	0266334702	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangho943)	0
422	Đặng Minh Huy	24	M	58 Lê Duẩn, Hoàn Kiếm	huydangminh37580@gmail.com	0351126640	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	danghuy601{	0
423	Võ Văn Tú	36	M	8 Đinh Tiên Hoàng, Hoàn Kiếm	tuvovan03187@gmail.com	0732111170	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votu647%	0
424	Phan Văn Tuấn	46	M	1 Nguyễn Du, Hoàn Kiếm	tuanphanvan80784@gmail.com	0474502556	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantuan468$	0
425	Lý Văn Phát	62	M	31 Cao Bá Quát, Ba Đình	phatlyvan64415@gmail.com	0373014167	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyphat591%	0
426	Huỳnh Minh Tuấn	28	M	24 Nguyễn Hữu Huân, Hoàn Kiếm	tuanhuynhminh16880@gmail.com	0374086855	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhtuan849#	0
427	Võ Thu Nguyệt	30	F	56 Đường Láng, Đống Đa	nguyetvothu32158@gmail.com	0564706868	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vonguyet738>	0
428	Phan Bích Chi	61	F	25 Nguyễn Thái Học, Ba Đình	chiphanbich12905@gmail.com	0671340873	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanchi839:	0
429	Hoàng Bích Lan	48	F	27 Hòa Mã, Hai Bà Trưng	lanhoangbich93117@gmail.com	0397977446	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoanglan445_	0
430	Phạm Quang Khoa	58	M	13 Nguyễn Chí Thanh, Đống Đa	khoaphamquang29085@gmail.com	0628670260	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamkhoa826:	0
431	Vũ Minh Phúc	35	M	66 Nguyễn Thái Học, Ba Đình	phucvuminh32235@gmail.com	0664890631	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuphuc082,	0
432	Dương An Thúy	61	F	38 Nguyễn Thái Học, Ba Đình	thuyduongan82448@gmail.com	0366047650	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongthuy159_	0
433	Trần Xuân Linh	41	F	8 Lê Đại Hành, Hai Bà Trưng	linhtranxuan87727@gmail.com	0756866022	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranlinh862#	0
434	Dương Thiên Bảo	24	M	29 Láng Hạ, Đống Đa	baoduongthien17579@gmail.com	0203760673	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongbao862{	0
435	Vũ Quang Phát	53	M	40 Phan Đình Phùng, Ba Đình	phatvuquang53956@gmail.com	0590471370	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuphat593)	0
436	Hồ Minh Minh	48	M	12 Nguyễn Du, Hoàn Kiếm	minhhominh07196@gmail.com	0300806759	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hominh663&	0
437	Võ Thiên Bảo	57	M	23 Trần Quang Khải, Hoàn Kiếm	baovothien40810@gmail.com	0163846093	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vobao479>	0
438	Đặng Thiên Khoa	51	M	Trung tâm Văn hóa Nghệ thuật Việt Nam	khoadangthien78789@gmail.com	0970475144	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangkhoa913(	0
439	Phan Gia Nam	48	M	87 Láng Hạ, Đống Đa	namphangia75904@gmail.com	0924408429	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phannam089>	0
440	Phan Thị Đào	45	F	56 Cầu Giấy, Đống Đa	daophanthi72887@gmail.com	0794915381	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phandao870;	0
441	Lê Tuệ Hằng	56	F	24 Nguyễn Du, Hoàn Kiếm	hangletue45175@gmail.com	0372567368	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lehang415>	0
442	Ngô Thùy Đào	19	F	20 Giảng Võ, Ba Đình	daongothuy65651@gmail.com	0649224881	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngodao895&	0
443	Phạm Quang Tuấn	53	M	58 Quốc Tử Giám, Đống Đa	tuanphamquang08741@gmail.com	0315179846	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtuan492)	0
444	Đỗ Thu Nhung	52	F	23 Trúc Khê, Đống Đa	nhungdothu59603@gmail.com	0294310364	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	donhung778&	0
445	Đỗ Thùy Trang	19	F	5 Tràng Tiền, Hoàn Kiếm	trangdothuy40022@gmail.com	0820564327	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotrang495]	0
446	Dương Xuân Hằng	38	F	6 Nguyễn Hữu Huân, Hoàn Kiếm	hangduongxuan92631@gmail.com	0564183754	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duonghang903)	0
447	Hoàng Gia Phát	45	M	25 Bạch Mai, Hai Bà Trưng	phathoanggia60814@gmail.com	0913897396	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangphat282<	0
448	Phan Khánh Huyền	32	F	13 Nguyễn Du, Hoàn Kiếm	huyenphankhanh38465@gmail.com	0830175027	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanhuyen379_	0
449	Vũ Minh Khoa	28	M	26 Nguyễn Lương Bằng, Đống Đa	khoavuminh75039@gmail.com	0104448465	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vukhoa163<	0
450	Hoàng Anh Trung	53	M	56 Cầu Giấy, Đống Đa	trunghoanganh31643@gmail.com	0536263994	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangtrung565#	0
451	Ngô Tuệ Linh	37	F	33 Lê Thái Tổ, Hoàn Kiếm	linhngotue37089@gmail.com	0349184033	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngolinh732=	0
452	Đỗ Minh Minh	52	M	38 Ngọc Khánh, Ba Đình	minhdominh08864@gmail.com	0736377078	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dominh071!	0
453	Lê Quang Huy	43	M	39 Nguyễn Du, Hoàn Kiếm	huylequang79686@gmail.com	0941459791	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lehuy733#	0
454	Huỳnh Thị Đào	46	F	56 Lý Thái Tổ, Hoàn Kiếm	daohuynhthi28757@gmail.com	0200382282	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhdao629+	0
455	Hồ Gia Trung	31	M	42 Hàng Bài, Hoàn Kiếm	trunghogia59185@gmail.com	0571112999	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotrung381}	0
456	Phạm Văn Tú	50	M	46 Láng Hạ, Đống Đa	tuphamvan88737@gmail.com	0351513143	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtu618_	0
457	Phan Gia Tú	19	M	17 Giảng Võ, Ba Đình	tuphangia47030@gmail.com	0130463818	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantu942/	0
458	Ngô Quang Tú	38	M	17 Nguyễn Du, Hoàn Kiếm	tungoquang71252@gmail.com	0882246242	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngotu592>	0
459	Lý Gia Trung	38	M	27 Lý Thái Tổ, Hoàn Kiếm	trunglygia74290@gmail.com	0965283421	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytrung784+	0
460	Lý Anh Huy	57	M	30 Bạch Mai, Hai Bà Trưng	huylyanh89068@gmail.com	0556431196	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyhuy373-	0
461	Đặng Thùy Linh	34	F	19 Đào Tấn, Ba Đình	linhdangthuy70490@gmail.com	0216105407	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	danglinh508]	0
462	Phạm Tuệ Trinh	36	F	27 Hồ Tây, Tây Hồ	trinhphamtue02667@gmail.com	0963253249	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtrinh479(	0
463	Ngô Bích Như	28	F	27 Hồ Tây, Tây Hồ	nhungobich06810@gmail.com	0791943487	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngonhu700^	0
464	Lý Tuệ Đào	22	F	26 Nguyễn Huệ, Hoàn Kiếm	daolytue56159@gmail.com	0438764064	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lydao866&	0
465	Bùi An Linh	31	F	27 Hòa Mã, Hai Bà Trưng	linhbuian78607@gmail.com	0372148293	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	builinh340+	0
466	Hồ Quang Trung	41	M	50 Chùa Bộc, Đống Đa	trunghoquang75478@gmail.com	0691341856	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotrung069*	0
467	Hoàng Minh Hồ	62	M	8 Lê Đại Hành, Hai Bà Trưng	hohoangminh26878@gmail.com	0550823507	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangho318#	0
468	Lý Thiên Nam	27	M	12 Nguyễn Du, Hoàn Kiếm	namlythien78163@gmail.com	0749946731	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lynam068!	0
469	Trần Thu Chi	63	F	58 Nguyễn Thái Học, Ba Đình	chitranthu41141@gmail.com	0452093916	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranchi136[	0
470	Lý Anh Nam	48	M	21 Đường Tôn Đức Thắng, Đống Đa	namlyanh83909@gmail.com	0889688136	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lynam194}	0
471	Hoàng Quang Thuận	28	M	22 Nguyễn Du, Hoàn Kiếm	thuanhoangquang57035@gmail.com	0842781436	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthuan939|	0
472	Vũ Văn Lộc	38	M	2 Phạm Ngọc Thạch, Đống Đa	locvuvan18144@gmail.com	0464112778	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuloc141@	0
473	Hồ Thùy Nhung	32	F	56 Nguyễn Chí Thanh, Đống Đa	nhunghothuy50272@gmail.com	0451357411	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honhung204<	0
474	Trần Gia Phúc	64	M	14 Lê Duẩn, Ba Đình	phuctrangia88278@gmail.com	0397938353	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranphuc094>	0
475	Huỳnh Khánh Trang	57	F	12 Nguyễn Chí Thanh, Đống Đa	tranghuynhkhanh41596@gmail.com	0263629519	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhtrang041_	0
476	Nguyễn Thiên Tú	37	M	22 Tôn Đức Thắng, Đống Đa	tunguyenthien28410@gmail.com	0839924193	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentu383$	0
477	Lý Anh Hồ	55	M	40 Phan Đình Phùng, Ba Đình	holyanh44994@gmail.com	0196936664	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyho091@	0
478	Đỗ Thiên Nam	53	M	22 Nguyễn Hữu Huân, Hoàn Kiếm	namdothien92302@gmail.com	0984383087	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	donam473^	0
479	Bùi Anh Tuấn	41	M	36 Nguyễn Du, Hoàn Kiếm	tuanbuianh70673@gmail.com	0599509836	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buituan368(	0
480	Đỗ Quang Khoa	40	M	19 Tràng Tiền, Hoàn Kiếm	khoadoquang90690@gmail.com	0259860373	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dokhoa990>	0
481	Võ An Thư	54	F	78 Thái Thịnh, Đống Đa	thuvoan44952@gmail.com	0758773368	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vothu033@	0
482	Đỗ Gia Tú	31	M	50 Tôn Đức Thắng, Đống Đa	tudogia54149@gmail.com	0965585104	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotu415=	0
483	Vũ Quang Phát	22	M	34 Nguyễn Huệ, Hoàn Kiếm	phatvuquang27330@gmail.com	0414296347	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuphat851#	0
484	Lý Anh Tiến	55	M	11 Phan Bội Châu, Hoàn Kiếm	tienlyanh57511@gmail.com	0226338174	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytien580<	0
485	Ngô An Chi	22	F	56 Đường Láng, Đống Đa	chingoan23489@gmail.com	0226790804	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngochi105,	0
486	Phạm Xuân Nhung	41	F	10 Tràng Tiền, Hoàn Kiếm	nhungphamxuan43450@gmail.com	0747473241	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamnhung075:	0
487	Hoàng Văn Trung	56	M	Trung tâm Văn hóa Nghệ thuật Việt Nam	trunghoangvan97826@gmail.com	0747700167	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangtrung379^	0
488	Phạm Xuân Trinh	36	F	11 Giảng Võ, Ba Đình	trinhphamxuan52333@gmail.com	0724168470	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtrinh358;	0
489	Lý Thị Đào	30	F	2 Phạm Ngọc Thạch, Đống Đa	daolythi56538@gmail.com	0676304134	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lydao403@	0
490	Ngô Bích Đào	34	F	11 Giảng Võ, Ba Đình	daongobich28068@gmail.com	0293442924	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngodao618!	0
491	Đỗ An Trang	59	F	42 Bà Triệu, Hoàn Kiếm	trangdoan48383@gmail.com	0312919037	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotrang792-	0
492	Lý Anh Tiến	46	M	19 Nguyễn Hữu Huân, Hoàn Kiếm	tienlyanh89589@gmail.com	0490764715	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytien650)	0
493	Nguyễn Khánh Thảo	37	F	88 Nguyễn Du, Hoàn Kiếm	thaonguyenkhanh66389@gmail.com	0731851525	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenthao655;	0
494	Dương Văn Bách	28	M	57 Phan Bội Châu, Hoàn Kiếm	bachduongvan07493@gmail.com	0352501163	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongbach494!	0
495	Hồ Tuệ Nguyệt	18	F	33 Nguyễn Huệ, Hoàn Kiếm	nguyethotue73129@gmail.com	0728099127	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honguyet971(	0
496	Đặng Khánh Chi	49	F	21 Nguyễn Lương Bằng, Đống Đa	chidangkhanh64218@gmail.com	0195643344	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangchi650_	0
497	Đỗ Xuân Chi	24	F	33 Nguyễn Hữu Huân, Hoàn Kiếm	chidoxuan79784@gmail.com	0676290064	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dochi336%	0
498	Nguyễn Gia Nam	43	M	56 Chùa Bộc, Đống Đa	namnguyengia55137@gmail.com	0643143370	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyennam669:	0
499	Phan Văn Phát	22	M	53 Nguyễn Hữu Huân, Hoàn Kiếm	phatphanvan50228@gmail.com	0160697456	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanphat269!	0
500	Dương Gia Tùng	48	M	43 Nguyễn Thái Học, Ba Đình	tungduonggia89753@gmail.com	0731886395	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongtung927{	0
501	Dương Anh Huy	50	M	4 Hàng Bài, Hoàn Kiếm	huyduonganh49613@gmail.com	0678788494	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duonghuy102%	0
502	Dương Xuân Thúy	19	F	Trung tâm Văn hóa Nghệ thuật Việt Nam	thuyduongxuan71983@gmail.com	0696239011	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongthuy707!	0
503	Lê Anh Phát	35	M	5 Nguyễn Thái Học, Ba Đình	phatleanh78071@gmail.com	0503783728	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lephat140+	0
504	Nguyễn Minh Hồ	49	M	29 Hòa Mã, Hai Bà Trưng	honguyenminh02908@gmail.com	0450272053	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenho860<	0
505	Lý Khánh Thư	46	F	22 Tôn Đức Thắng, Đống Đa	thulykhanh01623@gmail.com	0412622508	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lythu142-	0
506	Hoàng An Vân	31	F	17 Trúc Khê, Đống Đa	vanhoangan20060@gmail.com	0982861382	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangvan974)	0
507	Huỳnh Quang Khang	27	M	56 Trần Duy Hưng, Cầu Giấy	khanghuynhquang44836@gmail.com	0231216327	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhkhang177(	0
508	Trần Gia Bách	21	M	9 Bạch Mai, Hai Bà Trưng	bachtrangia70424@gmail.com	0883017961	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranbach738{	0
509	Lê Thu Huyền	58	F	87 Láng Hạ, Đống Đa	huyenlethu88372@gmail.com	0759259758	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lehuyen739+	0
510	Võ Bích Hằng	23	F	1 Tràng Tiền, Hoàn Kiếm	hangvobich15764@gmail.com	0398376263	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vohang723}	0
511	Phạm Bích Chi	19	F	27 Phan Đình Phùng, Ba Đình	chiphambich10905@gmail.com	0651113045	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamchi873%	0
512	Dương Anh Tuấn	27	M	14 Đinh Tiên Hoàng, Hoàn Kiếm	tuanduonganh81500@gmail.com	0179949891	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongtuan526)	0
513	Hoàng Thu Thư	56	F	6 Nguyễn Hữu Huân, Hoàn Kiếm	thuhoangthu80622@gmail.com	0455143506	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthu617(	0
514	Hồ Văn Khang	32	M	42 Hàng Bài, Hoàn Kiếm	khanghovan71141@gmail.com	0290639869	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hokhang682/	0
515	Bùi Văn Bách	35	M	31 Nguyễn Lương Bằng, Đống Đa	bachbuivan79033@gmail.com	0646067003	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buibach891-	0
516	Vũ Gia Hồ	43	M	23 Lê Duẩn, Hoàn Kiếm	hovugia38858@gmail.com	0567893745	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuho689>	0
517	Lý Quang Minh	28	M	10 Tôn Đức Thắng, Đống Đa	minhlyquang42299@gmail.com	0351280580	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyminh322,	0
518	Lê Thu Đào	20	F	26 Nguyễn Huệ, Hoàn Kiếm	daolethu16975@gmail.com	0688309270	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ledao742-	0
519	Nguyễn Minh Khoa	44	M	35 Tôn Đức Thắng, Đống Đa	khoanguyenminh85044@gmail.com	0761634103	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenkhoa953|	0
520	Huỳnh Minh Khang	36	M	12 Tạ Quang Bửu, Hai Bà Trưng	khanghuynhminh23565@gmail.com	0790480711	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhkhang411!	0
521	Lý Quang Tuấn	24	M	58 Lê Duẩn, Hoàn Kiếm	tuanlyquang24158@gmail.com	0677956589	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytuan937*	0
522	Phạm Văn Khang	44	M	196 Đội Cấn, Ba Đình	khangphamvan36378@gmail.com	0311448260	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamkhang286[	0
523	Đỗ Bích Ly	59	F	Long Biên, Hà Nội	lydobich64438@gmail.com	0135328912	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	doly228[	0
524	Lý An Lan	54	F	1 Tràng Tiền, Hoàn Kiếm	lanlyan81710@gmail.com	0563348192	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lylan720]	0
525	Ngô Thị Huyền	56	F	56 Lý Thường Kiệt, Hoàn Kiếm	huyenngothi21143@gmail.com	0791262418	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngohuyen612:	0
526	Huỳnh Minh Hồ	54	M	1 Giảng Võ, Ba Đình	hohuynhminh96267@gmail.com	0356560015	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhho794+	0
527	Huỳnh Minh Bách	42	M	15 Phan Bội Châu, Hoàn Kiếm	bachhuynhminh15183@gmail.com	0475383138	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhbach832@	0
528	Dương Xuân Như	18	F	58 Láng Hạ, Đống Đa	nhuduongxuan49422@gmail.com	0254097023	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongnhu758/	0
529	Phan Thiên Thuận	18	M	2 Phạm Ngọc Thạch, Đống Đa	thuanphanthien89727@gmail.com	0832321800	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanthuan163_	0
530	Bùi Quang Thuận	27	M	17 Hàng Bài, Hoàn Kiếm	thuanbuiquang12930@gmail.com	0838325376	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buithuan218^	0
531	Lý Thiên Trung	44	M	88 Tràng Tiền, Hoàn Kiếm	trunglythien56107@gmail.com	0278880558	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytrung588}	0
532	Dương Bích Huyền	50	F	30 Láng Hạ, Đống Đa	huyenduongbich94685@gmail.com	0485723387	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duonghuyen598.	0
533	Trần Văn Huy	19	M	15 Lê Duẩn, Hoàn Kiếm	huytranvan51345@gmail.com	0216219773	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranhuy900}	0
534	Lê Thiên Nam	25	M	33 Lê Thái Tổ, Hoàn Kiếm	namlethien23234@gmail.com	0709581669	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lenam416{	0
535	Phan An Thảo	22	F	15 Ngô Quyền, Hoàn Kiếm	thaophanan24673@gmail.com	0447589342	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanthao155:	0
536	Võ An Ly	33	F	7 Tràng Tiền, Hoàn Kiếm	lyvoan65050@gmail.com	0329772251	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	voly379[	0
537	Lê Thu Chi	47	F	88 Nguyễn Du, Hoàn Kiếm	chilethu44404@gmail.com	0263843695	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lechi750#	0
538	Phan Quang Minh	38	M	30 Lý Thái Tổ, Hoàn Kiếm	minhphanquang87681@gmail.com	0576939917	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanminh067|	0
539	Trần Thiên Khoa	57	M	6 Láng Hạ, Đống Đa	khoatranthien81334@gmail.com	0264754022	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trankhoa944^	0
540	Lê Xuân Lan	32	F	45 Nguyễn Thái Học, Ba Đình	lanlexuan19010@gmail.com	0503493665	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lelan108?	0
541	Lý Văn Nam	49	M	39 Bạch Mai, Hai Bà Trưng	namlyvan30689@gmail.com	0635869904	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lynam545]	0
542	Đỗ Anh Nam	41	M	27 Hòa Mã, Hai Bà Trưng	namdoanh12718@gmail.com	0810032523	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	donam046.	0
543	Nguyễn Tuệ Chi	25	F	53 Nguyễn Hữu Huân, Hoàn Kiếm	chinguyentue15665@gmail.com	0543913482	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenchi193%	0
544	Hoàng Thiên Khoa	57	M	14 Lê Duẩn, Ba Đình	khoahoangthien66630@gmail.com	0484391309	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangkhoa360?	0
545	Phan Xuân Trinh	65	F	44B Thái Thịnh, Đống Đa	trinhphanxuan51629@gmail.com	0219844921	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantrinh821@	0
546	Dương An Như	26	F	40 Hàng Bài, Hoàn Kiếm	nhuduongan52491@gmail.com	0179832630	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongnhu577(	0
547	Đỗ Khánh Hằng	38	F	12 Nguyễn Du, Hoàn Kiếm	hangdokhanh52061@gmail.com	0331621936	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dohang294=	0
548	Trần Anh Tuấn	56	M	30 Láng Hạ, Đống Đa	tuantrananh54522@gmail.com	0458493606	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trantuan282{	0
549	Đặng Thị Lan	32	F	Studio Yoga & Thiền	landangthi53076@gmail.com	0738573931	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	danglan486#	0
550	Trần Anh Nam	35	M	56 Nguyễn Thái Học, Ba Đình	namtrananh66036@gmail.com	0227082341	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trannam557+	0
551	Ngô Quang Minh	38	M	30 Láng Hạ, Đống Đa	minhngoquang87115@gmail.com	0906877066	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngominh442[	0
552	Dương Khánh Nguyệt	29	F	36 Đinh Tiên Hoàng, Hoàn Kiếm	nguyetduongkhanh54941@gmail.com	0652056581	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongnguyet517;	0
553	Lê An Trang	57	F	21 Nguyễn Lương Bằng, Đống Đa	tranglean14881@gmail.com	0748862756	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	letrang071+	0
554	Nguyễn Anh Bảo	51	M	25 Hồ Tây, Tây Hồ	baonguyenanh94124@gmail.com	0248158917	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenbao295*	0
555	Lý An Huyền	48	F	30 Đinh Tiên Hoàng, Hoàn Kiếm	huyenlyan72029@gmail.com	0480765579	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyhuyen741>	0
556	Võ Thu Đào	55	F	45 Hàng Gai, Hoàn Kiếm	daovothu73507@gmail.com	0437265900	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vodao295[	0
557	Dương Thiên Trung	49	M	33 Lê Thái Tổ, Hoàn Kiếm	trungduongthien23418@gmail.com	0612123360	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongtrung533|	0
558	Phạm Thiên Khang	30	M	32 Láng Hạ, Đống Đa	khangphamthien82699@gmail.com	0651475427	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamkhang907_	0
559	Dương Thu Lan	36	F	58 Nguyễn Thái Học, Ba Đình	landuongthu64777@gmail.com	0148708035	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duonglan723}	0
560	Phan Gia Minh	60	M	50 Lý Thái Tổ, Hoàn Kiếm	minhphangia99159@gmail.com	0570698061	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanminh749?	0
561	Vũ An Chi	33	F	60 Mai Dịch, Cầu Giấy	chivuan65101@gmail.com	0818741487	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuchi453)	0
562	Bùi Gia Phát	54	M	36 Tôn Đức Thắng, Đống Đa	phatbuigia13564@gmail.com	0674767937	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buiphat921@	0
563	Bùi Thiên Thuận	47	M	6 Minh Khai, Hai Bà Trưng	thuanbuithien25004@gmail.com	0847768316	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buithuan236-	0
564	Hoàng Quang Huy	56	M	23 Trần Quang Khải, Hoàn Kiếm	huyhoangquang29418@gmail.com	0610450780	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoanghuy706+	0
565	Huỳnh Minh Huy	32	M	12 Đào Tấn, Ba Đình	huyhuynhminh24492@gmail.com	0329266560	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhhuy273-	0
566	Huỳnh Bích Ly	22	F	47 Quốc Tử Giám, Đống Đa	lyhuynhbich83378@gmail.com	0249517567	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhly989/	0
567	Huỳnh Thiên Minh	41	M	42 Hàng Bài, Hoàn Kiếm	minhhuynhthien32361@gmail.com	0502400946	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhminh345_	0
568	Phạm Khánh Như	45	F	28a Điện Biên Phủ, Ba Đình	nhuphamkhanh30896@gmail.com	0822674726	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamnhu331>	0
569	Dương Thiên Tiến	35	M	423 Lạc Long Quân, Tây Hồ	tienduongthien28153@gmail.com	0530103520	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongtien567[	0
570	Bùi Anh Khoa	65	M	78 Bà Triệu, Hoàn Kiếm	khoabuianh74635@gmail.com	0597868850	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buikhoa995)	0
571	Vũ An Lan	18	F	34 Nguyễn Lương Bằng, Đống Đa	lanvuan81311@gmail.com	0755185413	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vulan226]	0
572	Huỳnh Xuân Huyền	42	F	58 Láng Hạ, Đống Đa	huyenhuynhxuan39465@gmail.com	0833300678	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhhuyen348]	0
573	Võ Anh Minh	48	M	6 Tô Hiệu, Cầu Giấy	minhvoanh40735@gmail.com	0882137796	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vominh298}	0
574	Dương Minh Huy	56	M	21 Nguyễn Lương Bằng, Đống Đa	huyduongminh90386@gmail.com	0610394027	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duonghuy781/	0
575	Đặng Quang Nam	49	M	45 Đặng Thái Thân, Hoàn Kiếm	namdangquang46703@gmail.com	0548813985	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangnam000/	0
576	Trần Văn Minh	27	M	33 Lê Thái Tổ, Hoàn Kiếm	minhtranvan52239@gmail.com	0224518813	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranminh594{	0
577	Võ Anh Tuấn	54	M	31 Nguyễn Lương Bằng, Đống Đa	tuanvoanh63223@gmail.com	0847934544	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votuan303{	0
578	Trần Văn Minh	60	M	21 Tôn Đức Thắng, Đống Đa	minhtranvan99665@gmail.com	0453986060	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranminh961}	0
579	Lê Bích Như	46	F	19 Ngọc Hà, Ba Đình	nhulebich92663@gmail.com	0171696857	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lenhu526$	0
580	Hồ Quang Trung	65	M	52 Mai Dịch, Cầu Giấy	trunghoquang83366@gmail.com	0170564705	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotrung663(	0
581	Võ Quang Nam	44	M	15 Chùa Bộc, Đống Đa	namvoquang25046@gmail.com	0848948362	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vonam622|	0
582	Lê Thiên Hồ	28	M	196 Đội Cấn, Ba Đình	holethien16909@gmail.com	0403638642	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	leho270)	0
583	Vũ Thùy Đào	48	F	5 Minh Khai, Hai Bà Trưng	daovuthuy88068@gmail.com	0549208144	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vudao055}	0
584	Đặng Quang Bách	22	M	458 Minh Khai, Hai Bà Trưng	bachdangquang28619@gmail.com	0537482941	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangbach166_	0
585	Hoàng Văn Bảo	46	M	12 Bà Triệu, Hoàn Kiếm	baohoangvan74866@gmail.com	0800957720	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangbao237<	0
586	Huỳnh Thùy Chi	47	F	43 Bà Triệu, Hoàn Kiếm	chihuynhthuy37874@gmail.com	0693791986	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhchi672_	0
587	Hoàng Thị Trang	19	F	14 Phan Đình Phùng, Ba Đình	tranghoangthi47616@gmail.com	0659192918	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangtrang426!	0
588	Phạm Minh Trung	31	M	21 Tôn Đức Thắng, Đống Đa	trungphamminh03854@gmail.com	0122900526	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtrung902?	0
589	Huỳnh Thu Vân	63	F	15 Chùa Bộc, Đống Đa	vanhuynhthu33963@gmail.com	0727798059	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhvan644-	0
590	Phạm Thiên Hồ	34	M	24 Tràng Tiền, Hoàn Kiếm	hophamthien07091@gmail.com	0812929725	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamho449,	0
591	Bùi Quang Phát	38	M	58 Lê Duẩn, Hoàn Kiếm	phatbuiquang76031@gmail.com	0921869758	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buiphat475+	0
592	Phan An Chi	19	F	10 Tôn Đức Thắng, Đống Đa	chiphanan40837@gmail.com	0354845072	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanchi184.	0
593	Nguyễn Thu Chi	40	F	23 Trúc Khê, Đống Đa	chinguyenthu07645@gmail.com	0152760308	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenchi880]	0
594	Lý Văn Tuấn	50	M	58 Lê Duẩn, Hoàn Kiếm	tuanlyvan69614@gmail.com	0382072974	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytuan946(	0
595	Lê Thùy Như	39	F	27 Hồ Tây, Tây Hồ	nhulethuy35279@gmail.com	0968410574	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lenhu551>	0
596	Đỗ Quang Tú	40	M	9 Bạch Mai, Hai Bà Trưng	tudoquang77206@gmail.com	0511187800	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotu431?	0
597	Phan Thùy Vân	55	F	11 Phan Bội Châu, Hoàn Kiếm	vanphanthuy87604@gmail.com	0630501695	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanvan706]	0
598	Hồ Thu Linh	57	F	12 Tạ Quang Bửu, Hai Bà Trưng	linhhothu23212@gmail.com	0779420898	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	holinh700$	0
599	Bùi Bích Chi	25	F	6 Phạm Ngọc Thạch, Đống Đa	chibuibich45324@gmail.com	0838346252	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buichi928(	0
600	Vũ Văn Trung	56	M	53 Nguyễn Hữu Huân, Hoàn Kiếm	trungvuvan88502@gmail.com	0546490776	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vutrung148_	0
601	Lê Xuân Thảo	20	F	12 Nguyễn Hữu Huân, Hoàn Kiếm	thaolexuan96882@gmail.com	0641788474	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lethao104(	0
602	Đỗ Thùy Trinh	29	F	11 Nguyễn Du, Hoàn Kiếm	trinhdothuy66582@gmail.com	0134132483	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotrinh420%	0
603	Đặng Quang Khoa	62	M	Tây Hồ, Hà Nội	khoadangquang42655@gmail.com	0749346847	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangkhoa466|	0
604	Nguyễn Minh Lộc	20	M	7 Nguyễn Lương Bằng, Đống Đa	locnguyenminh87951@gmail.com	0372370085	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenloc198/	0
605	Huỳnh Khánh Lan	53	F	18 Cầu Giấy, Đống Đa	lanhuynhkhanh73473@gmail.com	0594022679	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhlan500|	0
606	Huỳnh Thiên Minh	45	M	87 Láng Hạ, Đống Đa	minhhuynhthien88894@gmail.com	0336158114	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhminh956(	0
607	Dương Anh Hồ	24	M	87 Láng Hạ, Đống Đa	hoduonganh67120@gmail.com	0538832754	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongho762|	0
608	Dương Xuân Linh	23	F	34 Nguyễn Huệ, Hoàn Kiếm	linhduongxuan15231@gmail.com	0862652646	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duonglinh680@	0
609	Hồ Anh Minh	27	M	19 Nguyễn Hữu Huân, Hoàn Kiếm	minhhoanh35371@gmail.com	0247632231	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hominh076|	0
610	Lê Anh Huy	34	M	27 Hòa Mã, Hai Bà Trưng	huyleanh53605@gmail.com	0198043200	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lehuy079/	0
611	Phan Thiên Minh	24	M	26 Nguyễn Lương Bằng, Đống Đa	minhphanthien55712@gmail.com	0194396802	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanminh709|	0
612	Võ Thu Ly	52	F	58 Láng Hạ, Đống Đa	lyvothu96793@gmail.com	0207260554	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	voly013_	0
613	Nguyễn Minh Khang	42	M	28 Nguyễn Thái Học, Ba Đình	khangnguyenminh22139@gmail.com	0811459646	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenkhang894-	0
614	Hồ Khánh Ly	28	F	33 Nguyễn Huệ, Hoàn Kiếm	lyhokhanh22993@gmail.com	0193759495	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	holy548}	0
615	Bùi Bích Thảo	65	F	105 Cầu Giấy, Đống Đa	thaobuibich56948@gmail.com	0460743275	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buithao391|	0
616	Lý Văn Bách	31	M	13 Phạm Ngọc Thạch, Đống Đa	bachlyvan26177@gmail.com	0807796134	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lybach975_	0
617	Vũ Minh Tuấn	64	M	78 Thái Thịnh, Đống Đa	tuanvuminh65544@gmail.com	0108981016	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vutuan433]	0
618	Hoàng Tuệ Thúy	52	F	17 Giảng Võ, Ba Đình	thuyhoangtue31842@gmail.com	0756600936	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthuy858*	0
619	Trần Khánh Như	45	F	12 Nguyễn Du, Hoàn Kiếm	nhutrankhanh96019@gmail.com	0666332425	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trannhu552&	0
620	Vũ Gia Minh	47	M	12 Hàng Bài, Hoàn Kiếm	minhvugia15447@gmail.com	0457647606	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuminh290%	0
621	Lê Tuệ Nhung	30	F	18 Giảng Võ, Ba Đình	nhungletue22048@gmail.com	0648651692	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lenhung075=	0
622	Vũ Thiên Khang	38	M	13 Nguyễn Du, Hoàn Kiếm	khangvuthien88512@gmail.com	0459307332	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vukhang263]	0
623	Huỳnh Thu Thúy	48	F	56 Cầu Giấy, Đống Đa	thuyhuynhthu48302@gmail.com	0753829482	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhthuy945;	0
624	Hồ Thị Hằng	40	F	18 Tô Hiệu, Cầu Giấy	hanghothi93492@gmail.com	0911494449	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hohang800|	0
625	Đặng Anh Tuấn	24	M	40 Nguyễn Hữu Huân, Hoàn Kiếm	tuandanganh01964@gmail.com	0853561776	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangtuan622?	0
626	Ngô Anh Huy	25	M	33 Lê Thái Tổ, Hoàn Kiếm	huyngoanh28004@gmail.com	0943092002	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngohuy041@	0
627	Vũ Thùy Linh	57	F	56 Nguyễn Thái Học, Ba Đình	linhvuthuy55006@gmail.com	0339299754	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vulinh952;	0
628	Phan Thiên Bách	50	M	19 Trần Quang Khải, Hoàn Kiếm	bachphanthien85154@gmail.com	0937648466	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanbach660(	0
629	Lý Văn Phát	38	M	10 Tràng Tiền, Hoàn Kiếm	phatlyvan21351@gmail.com	0891653121	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyphat834{	0
630	Phan Tuệ Như	62	F	8 Nguyễn Du, Hoàn Kiếm	nhuphantue99418@gmail.com	0798799775	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phannhu356)	0
631	Đặng Xuân Thúy	32	F	36 Lý Thường Kiệt, Hoàn Kiếm	thuydangxuan85861@gmail.com	0769288466	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangthuy826,	0
632	Võ Minh Huy	40	M	12 Tôn Đức Thắng, Đống Đa	huyvominh66602@gmail.com	0277646432	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vohuy505_	0
633	Hoàng Gia Tùng	32	M	12 Đào Tấn, Ba Đình	tunghoanggia12048@gmail.com	0562140039	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangtung616=	0
634	Phan Minh Tú	63	M	11 Phan Bội Châu, Hoàn Kiếm	tuphanminh70173@gmail.com	0821201391	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantu940/	0
635	Ngô Quang Huy	20	M	52 Mai Dịch, Cầu Giấy	huyngoquang76601@gmail.com	0342269470	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngohuy600-	0
636	Hoàng Văn Khoa	64	M	4 Hàng Bài, Hoàn Kiếm	khoahoangvan41758@gmail.com	0527495275	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangkhoa595]	0
637	Võ Thiên Bách	31	M	24 Tràng Tiền, Hoàn Kiếm	bachvothien15994@gmail.com	0664819997	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vobach249%	0
638	Hồ Xuân Thảo	18	F	105 Cầu Giấy, Đống Đa	thaohoxuan32538@gmail.com	0824308799	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hothao981_	0
639	Hoàng Xuân Hằng	33	F	4 Nguyễn Du, Hoàn Kiếm	hanghoangxuan22157@gmail.com	0839169107	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoanghang018<	0
1010	va	22	M	4tp	vvvvv@gm.com	0123456777	2025-01-15 01:09:09.902289	2025-01-15 01:09:09.902289	dragonnest2210@	0
640	Hồ Thị Nguyệt	48	F	26 Bà Triệu, Hoàn Kiếm	nguyethothi34730@gmail.com	0664091440	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honguyet500.	0
641	Phạm Quang Phúc	37	M	44 Phan Đình Phùng, Ba Đình	phucphamquang23047@gmail.com	0914926855	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamphuc116}	0
642	Ngô Minh Thuận	46	M	59 Lý Thái Tổ, Hoàn Kiếm	thuanngominh09310@gmail.com	0158137620	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngothuan649*	0
643	Phan Tuệ Trang	50	F	15 Ngô Quyền, Hoàn Kiếm	trangphantue36071@gmail.com	0842154477	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantrang839#	0
644	Phạm Thiên Khang	19	M	1 Bạch Mai, Hai Bà Trưng	khangphamthien77301@gmail.com	0193477220	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamkhang409>	0
645	Hoàng Tuệ Ly	35	F	69 Đội Cấn, Ba Đình	lyhoangtue19528@gmail.com	0345293821	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangly904$	0
646	Bùi Thùy Vân	18	F	37A Hai Bà Trưng, Hoàn Kiếm	vanbuithuy10270@gmail.com	0679489377	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buivan284%	0
647	Đỗ Thu Trinh	19	F	Trung tâm Văn hóa Nghệ thuật Việt Nam	trinhdothu83535@gmail.com	0400453206	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotrinh438%	0
648	Hoàng Khánh Linh	19	F	Long Biên, Hà Nội	linhhoangkhanh85554@gmail.com	0801870776	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoanglinh886-	0
649	Trần Thùy Ly	27	F	14 Trần Quang Khải, Hoàn Kiếm	lytranthuy61589@gmail.com	0448630527	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranly297>	0
650	Phạm Thị Nguyệt	57	F	26 Nguyễn Lương Bằng, Đống Đa	nguyetphamthi75061@gmail.com	0686215545	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamnguyet600}	0
651	Dương Tuệ Huyền	61	F	6 Nguyễn Hữu Huân, Hoàn Kiếm	huyenduongtue68241@gmail.com	0623751804	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duonghuyen972}	0
652	Phan Anh Phát	38	M	32 Láng Hạ, Đống Đa	phatphananh43203@gmail.com	0517037235	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanphat930!	0
653	Phan Gia Bảo	58	M	6 Láng Hạ, Đống Đa	baophangia50324@gmail.com	0271181092	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanbao625=	0
654	Vũ Minh Phát	46	M	7 Tràng Tiền, Hoàn Kiếm	phatvuminh78776@gmail.com	0447627684	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuphat530.	0
655	Lê Minh Thuận	55	M	13 Nguyễn Hữu Huân, Hoàn Kiếm	thuanleminh98652@gmail.com	0190936025	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lethuan687_	0
656	Hồ Xuân Lan	35	F	9 Bạch Mai, Hai Bà Trưng	lanhoxuan05195@gmail.com	0400292422	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	holan600_	0
657	Phan Bích Nhung	51	F	13 Phạm Ngọc Thạch, Đống Đa	nhungphanbich59975@gmail.com	0339094026	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phannhung374}	0
658	Võ Thiên Minh	20	M	5 Phan Đình Phùng, Ba Đình	minhvothien47221@gmail.com	0993526790	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vominh062@	0
659	Dương Thu Ly	47	F	30 Tràng Tiền, Hoàn Kiếm	lyduongthu53742@gmail.com	0237994768	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongly620@	0
660	Nguyễn Xuân Nguyệt	65	F	56 Tô Ngọc Vân, Tây Hồ	nguyetnguyenxuan75821@gmail.com	0411144651	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyennguyet016(	0
661	Huỳnh Minh Tú	34	M	18 Cầu Giấy, Đống Đa	tuhuynhminh00507@gmail.com	0363071530	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhtu222]	0
662	Vũ Thiên Tùng	42	M	39 Bạch Mai, Hai Bà Trưng	tungvuthien71433@gmail.com	0267849943	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vutung905(	0
663	Ngô Thu Chi	47	F	52 Mai Dịch, Cầu Giấy	chingothu79270@gmail.com	0141484096	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngochi462]	0
664	Phan Khánh Chi	53	F	1 Trường Chinh, Cầu Giấy	chiphankhanh20241@gmail.com	0690194832	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanchi860%	0
665	Phạm Minh Hồ	57	M	57 Phan Chu Trinh, Hoàn Kiếm	hophamminh92009@gmail.com	0547110455	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamho241]	0
666	Dương Thị Ly	22	F	36 Lý Thường Kiệt, Hoàn Kiếm	lyduongthi93024@gmail.com	0164441386	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongly171-	0
667	Đỗ Gia Bách	59	M	10 Lê Duẩn, Hoàn Kiếm	bachdogia31799@gmail.com	0323644983	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dobach138&	0
668	Lý Tuệ Trang	60	F	66 Nguyễn Thái Học, Ba Đình	tranglytue30183@gmail.com	0493463881	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytrang823]	0
669	Đặng Xuân Trinh	35	F	58 Nguyễn Thái Học, Ba Đình	trinhdangxuan46745@gmail.com	0859812988	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangtrinh722<	0
670	Nguyễn Bích Thư	38	F	Long Biên, Hà Nội	thunguyenbich52269@gmail.com	0932884020	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenthu389:	0
671	Lê Thùy Thư	41	F	13 Phạm Ngọc Thạch, Đống Đa	thulethuy77115@gmail.com	0906039898	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lethu830|	0
672	Hồ Thu Vân	28	F	15 Lý Thái Tổ, Hoàn Kiếm	vanhothu12113@gmail.com	0750427627	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hovan548,	0
673	Ngô Quang Huy	64	M	1 Trường Chinh, Cầu Giấy	huyngoquang91625@gmail.com	0835981935	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngohuy063^	0
674	Đỗ Khánh Thúy	52	F	12 Bà Triệu, Hoàn Kiếm	thuydokhanh05519@gmail.com	0107699647	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dothuy692?	0
675	Ngô Thị Hằng	51	F	43 Nguyễn Thái Học, Ba Đình	hangngothi74107@gmail.com	0688023872	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngohang018.	0
676	Bùi Quang Phúc	44	M	12 Nguyễn Huệ, Hoàn Kiếm	phucbuiquang64312@gmail.com	0853182941	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buiphuc620]	0
677	Đỗ Quang Tuấn	46	M	56 Đào Tấn, Ba Đình	tuandoquang09772@gmail.com	0660877191	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotuan380{	0
678	Hoàng Thiên Thuận	55	M	18 Nguyễn Hữu Huân, Hoàn Kiếm	thuanhoangthien87463@gmail.com	0725468636	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthuan312!	0
679	Nguyễn Gia Tuấn	24	M	9 Nguyễn Huệ, Hoàn Kiếm	tuannguyengia37025@gmail.com	0508329098	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentuan015]	0
680	Phan Tuệ Linh	33	F	22 Cầu Giấy, Đống Đa	linhphantue07749@gmail.com	0416662908	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanlinh178$	0
681	Lý Anh Hồ	40	M	40 Nguyễn Hữu Huân, Hoàn Kiếm	holyanh81776@gmail.com	0712262594	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyho060@	0
682	Lê Xuân Thảo	38	F	25 Hồ Tây, Tây Hồ	thaolexuan83112@gmail.com	0562248836	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lethao592{	0
683	Lê Bích Hằng	61	F	17 Trúc Khê, Đống Đa	hanglebich76510@gmail.com	0263104663	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lehang049]	0
684	Vũ Anh Thuận	38	M	43 Tô Hiệu, Cầu Giấy	thuanvuanh29820@gmail.com	0470806803	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuthuan055#	0
685	Bùi Thu Thảo	60	F	23 Trúc Khê, Đống Đa	thaobuithu52455@gmail.com	0181804444	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buithao955=	0
686	Ngô Văn Trung	37	M	34 Nguyễn Lương Bằng, Đống Đa	trungngovan75369@gmail.com	0751589472	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngotrung639=	0
687	Dương Bích Như	34	F	15 Quảng An, Tây Hồ	nhuduongbich77030@gmail.com	0197240301	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongnhu441-	0
688	Đặng Quang Bách	43	M	22 Cầu Giấy, Đống Đa	bachdangquang08349@gmail.com	0849355665	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangbach710,	0
689	Phạm Bích Vân	34	F	59 Lý Thái Tổ, Hoàn Kiếm	vanphambich38474@gmail.com	0257414717	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamvan582{	0
690	Lê An Thúy	65	F	53 Nguyễn Hữu Huân, Hoàn Kiếm	thuylean12489@gmail.com	0354285982	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lethuy866-	0
691	Lý Minh Khoa	27	M	12 Tạ Quang Bửu, Hai Bà Trưng	khoalyminh07389@gmail.com	0380992643	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lykhoa725/	0
692	Đỗ Xuân Thúy	35	F	25 Hồ Tây, Tây Hồ	thuydoxuan36454@gmail.com	0552621344	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dothuy254+	0
693	Đặng Thiên Phát	22	M	43 Tô Hiệu, Cầu Giấy	phatdangthien27191@gmail.com	0640450704	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangphat860]	0
694	Lý Tuệ Nguyệt	28	F	16 Tô Hiệu, Cầu Giấy	nguyetlytue93257@gmail.com	0842206275	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lynguyet767@	0
695	Phan An Đào	58	F	13 Nguyễn Hữu Huân, Hoàn Kiếm	daophanan44198@gmail.com	0819642742	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phandao073]	0
696	Đặng Thu Thảo	50	F	23 Trúc Khê, Đống Đa	thaodangthu32019@gmail.com	0416682695	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangthao008%	0
697	Đỗ An Huyền	19	F	10 Hồ Tây, Tây Hồ	huyendoan74787@gmail.com	0539353593	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dohuyen944,	0
698	Lê Thị Linh	20	F	38 Nguyễn Thái Học, Ba Đình	linhlethi43644@gmail.com	0139933125	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lelinh284_	0
699	Đặng Gia Bách	59	M	70 Đường Tôn Đức Thắng, Đống Đa	bachdanggia73442@gmail.com	0510126629	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangbach579#	0
700	Bùi Gia Trung	60	M	11 Nguyễn Du, Hoàn Kiếm	trungbuigia58087@gmail.com	0761435879	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buitrung612!	0
701	Lê Thiên Nam	32	M	31 Cao Bá Quát, Ba Đình	namlethien25976@gmail.com	0847031539	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lenam121(	0
702	Huỳnh Anh Bảo	27	M	56 Lý Thường Kiệt, Hoàn Kiếm	baohuynhanh69926@gmail.com	0335066134	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhbao939/	0
703	Ngô Minh Nam	59	M	15 Trúc Khê, Đống Đa	namngominh70795@gmail.com	0942387067	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngonam984/	0
704	Vũ Gia Lộc	34	M	15 Ngô Quyền, Hoàn Kiếm	locvugia80750@gmail.com	0950717713	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuloc001-	0
705	Hoàng Anh Phát	33	M	25 Hồ Tây, Tây Hồ	phathoanganh22297@gmail.com	0310633509	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangphat555)	0
706	Phan Thùy Huyền	58	F	10 Nguyễn Huệ, Hoàn Kiếm	huyenphanthuy40597@gmail.com	0778977346	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanhuyen396}	0
707	Hoàng Tuệ Chi	36	F	100 Nguyễn Du, Hoàn Kiếm	chihoangtue09292@gmail.com	0508248832	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangchi721|	0
708	Trần Minh Khoa	18	M	Trung tâm Văn hóa Nghệ thuật Việt Nam	khoatranminh50174@gmail.com	0375546459	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trankhoa791@	0
709	Võ Gia Lộc	60	M	42 Hàng Bài, Hoàn Kiếm	locvogia06088@gmail.com	0689429966	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	voloc082>	0
710	Trần Văn Huy	23	M	17 Trúc Khê, Đống Đa	huytranvan90079@gmail.com	0790838827	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranhuy052%	0
711	Bùi Bích Hằng	28	F	28a Điện Biên Phủ, Ba Đình	hangbuibich71911@gmail.com	0946233517	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buihang193=	0
712	Huỳnh Thùy Lan	26	F	30 Giảng Võ, Ba Đình	lanhuynhthuy71509@gmail.com	0415271949	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhlan754:	0
713	Nguyễn Thu Trinh	45	F	57 Phan Chu Trinh, Hoàn Kiếm	trinhnguyenthu30885@gmail.com	0426056973	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentrinh201+	0
714	Hoàng Thiên Nam	64	M	38 Nguyễn Thái Học, Ba Đình	namhoangthien20292@gmail.com	0333131534	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangnam224%	0
715	Đặng Anh Bách	30	M	21 Nguyễn Lương Bằng, Đống Đa	bachdanganh29723@gmail.com	0990368995	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangbach015<	0
716	Vũ Thùy Nguyệt	61	F	15 Ngô Quyền, Hoàn Kiếm	nguyetvuthuy59232@gmail.com	0406749215	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vunguyet344?	0
717	Vũ Khánh Nguyệt	42	F	14 Trúc Khê, Đống Đa	nguyetvukhanh24004@gmail.com	0749247291	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vunguyet589.	0
718	Lê Gia Tùng	39	M	10 Trần Quang Khải, Hoàn Kiếm	tunglegia38809@gmail.com	0786885429	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	letung035#	0
719	Nguyễn Quang Tiến	38	M	45 Đặng Thái Thân, Hoàn Kiếm	tiennguyenquang57608@gmail.com	0439267919	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentien213-	0
720	Đặng Minh Minh	40	M	10 Hồ Tây, Tây Hồ	minhdangminh85424@gmail.com	0436608327	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangminh743/	0
721	Đặng Văn Hồ	49	M	12 Trúc Khê, Đống Đa	hodangvan41904@gmail.com	0284843500	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangho572.	0
722	Dương Thiên Tuấn	56	M	105 Cầu Giấy, Đống Đa	tuanduongthien14851@gmail.com	0761468149	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongtuan012.	0
723	Nguyễn Văn Hồ	52	M	18 Lý Thái Tổ, Hoàn Kiếm	honguyenvan30513@gmail.com	0557806465	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenho885:	0
724	Bùi Khánh Huyền	56	F	1 Trường Chinh, Cầu Giấy	huyenbuikhanh27459@gmail.com	0462302970	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buihuyen523+	0
725	Đặng Xuân Thúy	24	F	1 Bạch Mai, Hai Bà Trưng	thuydangxuan39280@gmail.com	0922577996	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangthuy747/	0
726	Lê Quang Tiến	24	M	Lotte Center Hanoi, 54 Liễu Giai, Ba Đình	tienlequang61736@gmail.com	0536165406	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	letien407]	0
727	Lê Anh Lộc	57	M	37A Hai Bà Trưng, Hoàn Kiếm	locleanh98117@gmail.com	0793719074	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	leloc883%	0
728	Hồ Bích Như	59	F	33 Bạch Mai, Hai Bà Trưng	nhuhobich77728@gmail.com	0741112497	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honhu022|	0
729	Phạm Thu Thư	29	F	25 Hồ Tây, Tây Hồ	thuphamthu79752@gmail.com	0215615568	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamthu712@	0
730	Nguyễn Khánh Huyền	18	F	28 Đào Tấn, Ba Đình	huyennguyenkhanh25202@gmail.com	0923753627	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenhuyen952.	0
731	Huỳnh Anh Hồ	23	M	69 Đội Cấn, Ba Đình	hohuynhanh39896@gmail.com	0292189468	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhho538{	0
732	Vũ Văn Bách	22	M	58 Nguyễn Thái Học, Ba Đình	bachvuvan51911@gmail.com	0571288652	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vubach772[	0
733	Hồ Xuân Thảo	19	F	50 Tôn Đức Thắng, Đống Đa	thaohoxuan69289@gmail.com	0693311011	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hothao330|	0
734	Vũ Quang Phúc	22	M	30 Lý Thường Kiệt, Hoàn Kiếm	phucvuquang03119@gmail.com	0570118016	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuphuc430{	0
735	Võ Thiên Tùng	43	M	423 Lạc Long Quân, Tây Hồ	tungvothien48833@gmail.com	0110312338	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votung611:	0
736	Vũ Gia Khang	26	M	45 Đinh Tiên Hoàng, Hoàn Kiếm	khangvugia91222@gmail.com	0879961845	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vukhang818|	0
835	Huỳnh Khánh Ly	61	F	4 Hàng Bài, Hoàn Kiếm	lyhuynhkhanh85035@gmail.com	0340603972	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhly936!	0
737	Đặng Quang Lộc	50	M	24 Nguyễn Hữu Huân, Hoàn Kiếm	locdangquang51691@gmail.com	0979094700	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangloc756&	0
738	Phan Văn Tú	55	M	18 Tô Hiệu, Cầu Giấy	tuphanvan17934@gmail.com	0360126577	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantu066^	0
739	Dương Thiên Thuận	18	M	78 Bà Triệu, Hoàn Kiếm	thuanduongthien27906@gmail.com	0815834112	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongthuan001-	0
740	Vũ Thiên Bách	36	M	21 Đường Tôn Đức Thắng, Đống Đa	bachvuthien24894@gmail.com	0703077184	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vubach958|	0
741	Ngô Thiên Huy	53	M	28 Đào Tấn, Ba Đình	huyngothien08403@gmail.com	0413383495	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngohuy044.	0
742	Lý Thu Linh	36	F	40 Nguyễn Hữu Huân, Hoàn Kiếm	linhlythu22323@gmail.com	0425027603	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lylinh548_	0
743	Dương Xuân Thư	27	F	19 Nguyễn Huệ, Hoàn Kiếm	thuduongxuan49526@gmail.com	0323556494	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongthu606#	0
744	Đặng Thiên Khoa	44	M	37 Nguyễn Hữu Huân, Hoàn Kiếm	khoadangthien43856@gmail.com	0422239678	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangkhoa442_	0
745	Vũ Gia Tú	62	M	26 Láng Hạ, Đống Đa	tuvugia84847@gmail.com	0925550547	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vutu664{	0
746	Trần Thiên Khoa	60	M	56 Lý Thái Tổ, Hoàn Kiếm	khoatranthien21578@gmail.com	0762648940	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trankhoa255#	0
747	Lê Thiên Minh	44	M	11 Nguyễn Du, Hoàn Kiếm	minhlethien83033@gmail.com	0132197623	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	leminh033$	0
748	Đỗ Tuệ Thảo	47	F	1 Bạch Mai, Hai Bà Trưng	thaodotue90448@gmail.com	0704397741	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dothao928.	0
749	Vũ Tuệ Thúy	63	F	10 Nguyễn Huệ, Hoàn Kiếm	thuyvutue80472@gmail.com	0650069091	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuthuy011-	0
750	Hoàng Thu Thư	51	F	13 Nguyễn Hữu Huân, Hoàn Kiếm	thuhoangthu57033@gmail.com	0981630317	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthu173=	0
751	Vũ Thiên Minh	29	M	19 Ngọc Hà, Ba Đình	minhvuthien47976@gmail.com	0607988055	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuminh788(	0
752	Hoàng Quang Phát	65	M	53 Nguyễn Hữu Huân, Hoàn Kiếm	phathoangquang55979@gmail.com	0818299809	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangphat923:	0
753	Nguyễn Thị Thư	65	F	Lotte Center Hanoi, 54 Liễu Giai, Ba Đình	thunguyenthi92600@gmail.com	0605661091	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenthu625^	0
754	Phan Tuệ Nhung	41	F	38 Nguyễn Thái Học, Ba Đình	nhungphantue31540@gmail.com	0972304224	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phannhung218(	0
755	Trần Bích Trang	62	F	33 Lê Thái Tổ, Hoàn Kiếm	trangtranbich26901@gmail.com	0833238161	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trantrang718[	0
756	Nguyễn Bích Vân	50	F	12 Nguyễn Chí Thanh, Đống Đa	vannguyenbich00712@gmail.com	0630984606	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenvan080?	0
757	Phạm Khánh Nguyệt	43	F	21 Nguyễn Thái Học, Ba Đình	nguyetphamkhanh64160@gmail.com	0569128532	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamnguyet373#	0
758	Trần Gia Bách	18	M	30 Đinh Tiên Hoàng, Hoàn Kiếm	bachtrangia66651@gmail.com	0307813409	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranbach541@	0
759	Lê Thùy Vân	49	F	88 Tràng Tiền, Hoàn Kiếm	vanlethuy06296@gmail.com	0117320983	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	levan818*	0
760	Vũ Xuân Vân	20	F	16 Nguyễn Thái Học, Ba Đình	vanvuxuan93462@gmail.com	0160900969	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuvan079#	0
761	Phan Anh Trung	30	M	14 Đinh Tiên Hoàng, Hoàn Kiếm	trungphananh65224@gmail.com	0123192059	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantrung534{	0
762	Lê Anh Hồ	57	M	12 Tạ Quang Bửu, Hai Bà Trưng	holeanh91026@gmail.com	0154453739	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	leho059:	0
763	Dương Tuệ Vân	32	F	88 Tràng Tiền, Hoàn Kiếm	vanduongtue89388@gmail.com	0840003320	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongvan006/	0
764	Vũ Bích Thư	57	F	15 Quảng An, Tây Hồ	thuvubich06688@gmail.com	0565310672	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuthu229.	0
765	Đỗ Thiên Phúc	27	M	35 Nguyễn Chí Thanh, Đống Đa	phucdothien33546@gmail.com	0337308894	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dophuc348<	0
766	Đặng Thu Thư	30	F	18 Tô Hiệu, Cầu Giấy	thudangthu85925@gmail.com	0658801187	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangthu242?	0
767	Lý An Đào	20	F	29 Hòa Mã, Hai Bà Trưng	daolyan21671@gmail.com	0253696513	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lydao754$	0
768	Trần Thiên Phúc	47	M	78 Bà Triệu, Hoàn Kiếm	phuctranthien20788@gmail.com	0954720846	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranphuc711(	0
769	Bùi Xuân Trinh	18	F	40 Phan Đình Phùng, Ba Đình	trinhbuixuan43258@gmail.com	0561643367	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buitrinh241(	0
770	Dương Gia Lộc	40	M	57 Phan Chu Trinh, Hoàn Kiếm	locduonggia24356@gmail.com	0995658496	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongloc666!	0
771	Hồ Xuân Trinh	56	F	58 Phan Đình Phùng, Ba Đình	trinhhoxuan33875@gmail.com	0970898139	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotrinh896!	0
772	Hồ An Như	18	F	45 Đinh Tiên Hoàng, Hoàn Kiếm	nhuhoan21114@gmail.com	0302877011	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honhu683,	0
773	Đỗ Gia Tuấn	44	M	45 Đặng Thái Thân, Hoàn Kiếm	tuandogia27055@gmail.com	0748663337	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotuan476|	0
774	Nguyễn Thùy Hằng	29	F	6 Minh Khai, Hai Bà Trưng	hangnguyenthuy99166@gmail.com	0264233818	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenhang545:	0
775	Hồ An Hằng	33	F	21 Giảng Võ, Ba Đình	hanghoan66244@gmail.com	0828134596	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hohang018*	0
776	Hồ Quang Nam	29	M	14 Tôn Đức Thắng, Đống Đa	namhoquang10641@gmail.com	0711500241	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honam902=	0
777	Đỗ Văn Hồ	59	M	19 Tràng Tiền, Hoàn Kiếm	hodovan15964@gmail.com	0165845853	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	doho568#	0
778	Lê Gia Huy	65	M	17 Phan Bội Châu, Hoàn Kiếm	huylegia71531@gmail.com	0555858181	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lehuy719_	0
779	Ngô Bích Hằng	43	F	13 Nguyễn Du, Hoàn Kiếm	hangngobich14433@gmail.com	0717104404	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngohang624{	0
780	Đặng Anh Tiến	24	M	14 Đinh Tiên Hoàng, Hoàn Kiếm	tiendanganh57884@gmail.com	0263167814	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangtien896;	0
781	Vũ Anh Minh	35	M	7 Nguyễn Lương Bằng, Đống Đa	minhvuanh72887@gmail.com	0849231477	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuminh762|	0
782	Phan Tuệ Ly	42	F	12 Đào Tấn, Ba Đình	lyphantue15458@gmail.com	0142119131	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanly476/	0
783	Phan Tuệ Huyền	58	F	56 Đường Láng, Đống Đa	huyenphantue38767@gmail.com	0393703057	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanhuyen464(	0
784	Lý Gia Thuận	52	M	14 Giảng Võ, Ba Đình	thuanlygia57421@gmail.com	0958334260	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lythuan245{	0
785	Hồ Quang Bảo	48	M	30 Đinh Tiên Hoàng, Hoàn Kiếm	baohoquang73695@gmail.com	0772949790	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hobao182/	0
786	Nguyễn Thiên Huy	45	M	38 Nguyễn Thái Học, Ba Đình	huynguyenthien03755@gmail.com	0687863222	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenhuy780/	0
787	Phan Khánh Ly	55	F	57 Phan Bội Châu, Hoàn Kiếm	lyphankhanh51142@gmail.com	0226176413	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanly618:	0
788	Lê Bích Nhung	54	F	13 Nguyễn Chí Thanh, Đống Đa	nhunglebich54891@gmail.com	0217511020	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lenhung740&	0
789	Vũ Thùy Đào	23	F	78 Thái Thịnh, Đống Đa	daovuthuy72341@gmail.com	0814559614	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vudao653{	0
790	Hoàng Bích Lan	47	F	35 Tôn Đức Thắng, Đống Đa	lanhoangbich41844@gmail.com	0523630823	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoanglan815>	0
791	Dương Tuệ Nguyệt	31	F	18 Tô Hiệu, Cầu Giấy	nguyetduongtue50225@gmail.com	0660594176	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongnguyet042%	0
792	Nguyễn Xuân Thảo	56	F	458 Minh Khai, Hai Bà Trưng	thaonguyenxuan23506@gmail.com	0640901821	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenthao521)	0
793	Dương Thùy Đào	42	F	3/10 Trần Thái Tông, Cầu Giấy	daoduongthuy30793@gmail.com	0481507555	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongdao218$	0
794	Hồ Thiên Bảo	58	M	28 Trúc Khê, Đống Đa	baohothien36549@gmail.com	0534118076	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hobao664>	0
795	Hồ Văn Minh	46	M	25 Hồ Tây, Tây Hồ	minhhovan33346@gmail.com	0711675585	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hominh401]	0
796	Nguyễn An Linh	53	F	37A Hai Bà Trưng, Hoàn Kiếm	linhnguyenan22387@gmail.com	0106313543	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenlinh322&	0
797	Ngô Khánh Chi	63	F	18 Tô Hiệu, Cầu Giấy	chingokhanh51178@gmail.com	0635873041	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngochi034/	0
798	Đặng Thị Như	27	F	30 Bạch Mai, Hai Bà Trưng	nhudangthi41001@gmail.com	0658894312	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangnhu234>	0
799	Võ Thu Trinh	31	F	50 Chùa Bộc, Đống Đa	trinhvothu14716@gmail.com	0504287778	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votrinh387|	0
800	Dương Thị Vân	32	F	2 Lý Thường Kiệt, Hoàn Kiếm	vanduongthi13561@gmail.com	0577890079	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongvan632*	0
801	Lý Thị Lan	42	F	45 Hàng Gai, Hoàn Kiếm	lanlythi64640@gmail.com	0752060308	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lylan407_	0
802	Lý Quang Minh	25	M	6 Nguyễn Hữu Huân, Hoàn Kiếm	minhlyquang85783@gmail.com	0734591030	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyminh304[	0
803	Lý Thị Huyền	34	F	23 Trúc Khê, Đống Đa	huyenlythi46354@gmail.com	0954919637	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyhuyen962>	0
804	Nguyễn An Ly	44	F	6 Láng Hạ, Đống Đa	lynguyenan75729@gmail.com	0880008632	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenly725_	0
805	Ngô Tuệ Thảo	38	F	11 Tô Ngọc Vân, Tây Hồ	thaongotue94304@gmail.com	0583289374	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngothao136+	0
806	Ngô Văn Phúc	57	M	30 Láng Hạ, Đống Đa	phucngovan66760@gmail.com	0512702120	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngophuc784|	0
807	Huỳnh Thùy Đào	53	F	56 Chùa Bộc, Đống Đa	daohuynhthuy25388@gmail.com	0938869370	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhdao000}	0
808	Trần Khánh Nhung	42	F	50 Lý Thái Tổ, Hoàn Kiếm	nhungtrankhanh80179@gmail.com	0279387002	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trannhung839[	0
809	Vũ Minh Nam	45	M	29 Láng Hạ, Đống Đa	namvuminh82207@gmail.com	0299492038	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vunam653!	0
810	Phan Thiên Tuấn	31	M	23 Trúc Khê, Đống Đa	tuanphanthien50633@gmail.com	0210960494	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantuan577%	0
811	Phạm Quang Minh	48	M	22 Tôn Đức Thắng, Đống Đa	minhphamquang43408@gmail.com	0905494709	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamminh463?	0
812	Phan Thiên Minh	54	M	32 Láng Hạ, Đống Đa	minhphanthien66553@gmail.com	0400976247	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanminh552!	0
813	Nguyễn Quang Tiến	29	M	10 Đặng Thái Thân, Hoàn Kiếm	tiennguyenquang85086@gmail.com	0922429195	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentien769%	0
814	Đỗ Minh Lộc	65	M	8 Đinh Tiên Hoàng, Hoàn Kiếm	locdominh94875@gmail.com	0497702763	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	doloc187?	0
815	Huỳnh Thiên Trung	34	M	28 Đào Tấn, Ba Đình	trunghuynhthien98026@gmail.com	0127519057	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhtrung145.	0
816	Nguyễn Bích Thảo	51	F	18 Đường Láng, Đống Đa	thaonguyenbich76121@gmail.com	0182246043	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenthao791_	0
817	Phạm Văn Phúc	46	M	37 Lý Thái Tổ, Hoàn Kiếm	phucphamvan07990@gmail.com	0656595724	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamphuc610#	0
818	Ngô An Trang	31	F	18 Đường Láng, Đống Đa	trangngoan06007@gmail.com	0465009427	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngotrang250:	0
819	Võ Thiên Tiến	62	M	17 Giảng Võ, Ba Đình	tienvothien70959@gmail.com	0863706162	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votien830+	0
820	Dương Gia Hồ	37	M	9 Nguyễn Huệ, Hoàn Kiếm	hoduonggia87977@gmail.com	0417183284	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongho839^	0
821	Huỳnh Anh Tùng	36	M	28 Đào Tấn, Ba Đình	tunghuynhanh66086@gmail.com	0375061593	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhtung494&	0
822	Đỗ Thùy Vân	19	F	15 Chùa Bộc, Đống Đa	vandothuy47699@gmail.com	0491015209	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dovan572*	0
823	Hồ An Nguyệt	28	F	35 Tôn Đức Thắng, Đống Đa	nguyethoan90232@gmail.com	0478490486	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honguyet609(	0
824	Vũ Quang Huy	19	M	15 Bạch Mai, Hai Bà Trưng	huyvuquang85402@gmail.com	0519621035	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuhuy793?	0
825	Ngô Bích Vân	18	F	58 Lê Duẩn, Hoàn Kiếm	vanngobich70624@gmail.com	0617381789	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngovan566$	0
826	Dương Minh Tiến	21	M	17 Trúc Khê, Đống Đa	tienduongminh69561@gmail.com	0907368315	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongtien924?	0
827	Bùi Thùy Nhung	37	F	43 Bà Triệu, Hoàn Kiếm	nhungbuithuy77710@gmail.com	0858910941	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buinhung828,	0
828	Phạm Gia Tùng	28	M	56 Đường Láng, Đống Đa	tungphamgia23459@gmail.com	0150404996	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtung379:	0
829	Phạm Anh Minh	26	M	12 Tạ Quang Bửu, Hai Bà Trưng	minhphamanh44069@gmail.com	0787594708	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamminh747#	0
830	Đặng Minh Khoa	65	M	60 Mai Dịch, Cầu Giấy	khoadangminh04136@gmail.com	0670029156	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangkhoa482$	0
831	Lý Gia Minh	61	M	3/10 Trần Thái Tông, Cầu Giấy	minhlygia16343@gmail.com	0635042377	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyminh024&	0
832	Hồ Thị Như	18	F	41 Trúc Khê, Đống Đa	nhuhothi27718@gmail.com	0286943511	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honhu603,	0
833	Ngô Gia Minh	20	M	30 Láng Hạ, Đống Đa	minhngogia20311@gmail.com	0796144632	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngominh453:	0
834	Trần Thị Linh	27	F	33 Bạch Mai, Hai Bà Trưng	linhtranthi14732@gmail.com	0108058352	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranlinh873?	0
836	Phan Xuân Linh	48	F	36 Nguyễn Hữu Huân, Hoàn Kiếm	linhphanxuan36518@gmail.com	0640324154	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanlinh300,	0
837	Bùi Thiên Minh	63	M	33 Nguyễn Hữu Huân, Hoàn Kiếm	minhbuithien49150@gmail.com	0255356751	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buiminh584#	0
838	Huỳnh Bích Hằng	50	F	1 Giảng Võ, Ba Đình	hanghuynhbich96676@gmail.com	0771048143	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhhang917>	0
839	Hoàng Xuân Thúy	31	F	1 Tràng Tiền, Hoàn Kiếm	thuyhoangxuan89780@gmail.com	0506449525	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangthuy512;	0
840	Hoàng Xuân Chi	55	F	44 Phan Đình Phùng, Ba Đình	chihoangxuan98578@gmail.com	0480924674	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangchi342#	0
841	Đỗ Bích Thư	27	F	33 Nguyễn Hữu Huân, Hoàn Kiếm	thudobich85170@gmail.com	0535298902	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dothu727$	0
842	Võ Thị Trinh	20	F	12 Nguyễn Du, Hoàn Kiếm	trinhvothi50154@gmail.com	0919089070	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votrinh617]	0
843	Hồ Thị Hằng	63	F	6 Phạm Ngọc Thạch, Đống Đa	hanghothi69598@gmail.com	0907885292	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hohang478?	0
844	Hồ Bích Trang	34	F	6 Đinh Tiên Hoàng, Hoàn Kiếm	tranghobich13406@gmail.com	0240113558	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotrang986)	0
845	Lý Thị Như	32	F	Lotte Center Hanoi, 54 Liễu Giai, Ba Đình	nhulythi45190@gmail.com	0223814101	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lynhu343{	0
846	Phạm Thu Trinh	50	F	87 Láng Hạ, Đống Đa	trinhphamthu72156@gmail.com	0928257334	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtrinh556[	0
847	Trần Xuân Nhung	26	F	19 Nguyễn Hữu Huân, Hoàn Kiếm	nhungtranxuan21525@gmail.com	0731609058	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trannhung910{	0
848	Hồ Tuệ Chi	21	F	36 Đinh Tiên Hoàng, Hoàn Kiếm	chihotue36514@gmail.com	0908084084	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hochi633<	0
849	Đặng Bích Hằng	27	F	88 Nguyễn Du, Hoàn Kiếm	hangdangbich70527@gmail.com	0992643157	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	danghang833^	0
850	Phan Thiên Tú	38	M	26 Bà Triệu, Hoàn Kiếm	tuphanthien48400@gmail.com	0910526860	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantu911/	0
851	Nguyễn Gia Khang	45	M	18 Lý Thái Tổ, Hoàn Kiếm	khangnguyengia84428@gmail.com	0240843116	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenkhang448{	0
852	Đặng Thiên Minh	56	M	29 Trúc Khê, Đống Đa	minhdangthien38218@gmail.com	0595429246	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangminh429[	0
853	Phan Thiên Tiến	65	M	24 Nguyễn Du, Hoàn Kiếm	tienphanthien23432@gmail.com	0879674131	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantien197|	0
854	Bùi Văn Bách	41	M	6 Nguyễn Hữu Huân, Hoàn Kiếm	bachbuivan11448@gmail.com	0976231218	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buibach457$	0
855	Hồ Thị Nhung	56	F	19 Đào Tấn, Ba Đình	nhunghothi87376@gmail.com	0534528227	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	honhung202?	0
856	Dương Khánh Thúy	54	F	52 Mai Dịch, Cầu Giấy	thuyduongkhanh01877@gmail.com	0308824128	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongthuy449@	0
857	Hồ Bích Trang	19	F	12 Tạ Quang Bửu, Hai Bà Trưng	tranghobich85926@gmail.com	0517302249	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotrang738>	0
858	Nguyễn Bích Trinh	32	F	100 Nguyễn Du, Hoàn Kiếm	trinhnguyenbich78395@gmail.com	0580280715	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentrinh789#	0
859	Phạm Gia Tùng	52	M	18 Lý Thái Tổ, Hoàn Kiếm	tungphamgia10342@gmail.com	0686092386	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamtung710=	0
860	Bùi Thiên Minh	35	M	1 Nguyễn Du, Hoàn Kiếm	minhbuithien76078@gmail.com	0180407039	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buiminh507/	0
861	Huỳnh Anh Bảo	65	M	56 Cầu Giấy, Đống Đa	baohuynhanh65268@gmail.com	0626863671	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhbao091*	0
862	Dương Quang Lộc	48	M	27 Hòa Mã, Hai Bà Trưng	locduongquang25736@gmail.com	0640838337	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongloc258,	0
863	Nguyễn Tuệ Hằng	49	F	18 Nguyễn Hữu Huân, Hoàn Kiếm	hangnguyentue78906@gmail.com	0640740700	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenhang760[	0
864	Bùi Xuân Lan	46	F	29 Trúc Khê, Đống Đa	lanbuixuan63635@gmail.com	0142861189	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	builan099)	0
865	Đặng Xuân Thảo	37	F	1 Giảng Võ, Ba Đình	thaodangxuan90740@gmail.com	0888475933	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangthao308|	0
866	Bùi Thùy Linh	62	F	68 Phố Tràng Tiền, Hoàn Kiếm	linhbuithuy06118@gmail.com	0374898496	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	builinh669$	0
867	Nguyễn Anh Tú	54	M	31 Nguyễn Lương Bằng, Đống Đa	tunguyenanh71554@gmail.com	0614823461	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentu537}	0
868	Đỗ An Huyền	45	F	24 Tràng Tiền, Hoàn Kiếm	huyendoan44300@gmail.com	0536084603	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dohuyen458)	0
869	Nguyễn Minh Trung	62	M	99 Phan Đình Phùng, Ba Đình	trungnguyenminh02292@gmail.com	0888987982	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentrung365%	0
870	Phạm Văn Phát	22	M	43 Tô Hiệu, Cầu Giấy	phatphamvan09896@gmail.com	0751844121	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamphat000]	0
871	Hồ Thu Trang	56	F	46 Láng Hạ, Đống Đa	tranghothu64024@gmail.com	0624411762	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotrang291!	0
872	Lê Thiên Thuận	41	M	69 Đội Cấn, Ba Đình	thuanlethien55350@gmail.com	0450327549	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lethuan494*	0
873	Bùi Gia Nam	43	M	88 Tràng Tiền, Hoàn Kiếm	nambuigia60321@gmail.com	0934841443	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buinam784*	0
874	Ngô Minh Hồ	29	M	56 Trần Duy Hưng, Cầu Giấy	hongominh54352@gmail.com	0986523806	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngoho039|	0
875	Trần Tuệ Linh	36	F	12 Bà Triệu, Hoàn Kiếm	linhtrantue05155@gmail.com	0113756715	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranlinh482-	0
876	Ngô An Trang	41	F	50 Lý Thái Tổ, Hoàn Kiếm	trangngoan13301@gmail.com	0800528894	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngotrang450)	0
877	Ngô An Đào	51	F	Long Biên, Hà Nội	daongoan22787@gmail.com	0475672937	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngodao848/	0
878	Võ Khánh Trinh	59	F	66 Nguyễn Thái Học, Ba Đình	trinhvokhanh98571@gmail.com	0736514741	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votrinh431$	0
879	Hồ Anh Huy	32	M	19 Trần Quang Khải, Hoàn Kiếm	huyhoanh23164@gmail.com	0366209673	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hohuy896(	0
880	Lý Minh Tiến	32	M	50 Lý Thái Tổ, Hoàn Kiếm	tienlyminh14564@gmail.com	0742591452	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytien030}	0
881	Ngô Tuệ Thúy	31	F	41 Trúc Khê, Đống Đa	thuyngotue98566@gmail.com	0832198655	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngothuy037]	0
882	Đỗ Thu Vân	37	F	72A Nguyễn Trãi, Thanh Xuân	vandothu44506@gmail.com	0398799542	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dovan876$	0
883	Vũ Bích Linh	48	F	27 Phan Đình Phùng, Ba Đình	linhvubich52365@gmail.com	0376646551	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vulinh501$	0
884	Lý Khánh Đào	65	F	15 Quảng An, Tây Hồ	daolykhanh98156@gmail.com	0808001371	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lydao902|	0
885	Vũ An Đào	26	F	1 Tràng Tiền, Hoàn Kiếm	daovuan76492@gmail.com	0401355243	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vudao136>	0
886	Nguyễn Thị Thúy	41	F	14 Trần Quang Khải, Hoàn Kiếm	thuynguyenthi66749@gmail.com	0627942924	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenthuy883?	0
887	Bùi Minh Phúc	47	M	45 Đinh Tiên Hoàng, Hoàn Kiếm	phucbuiminh91716@gmail.com	0140899300	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buiphuc491$	0
888	Bùi Minh Nam	57	M	17 Phan Bội Châu, Hoàn Kiếm	nambuiminh88091@gmail.com	0172467394	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buinam336@	0
889	Phạm Khánh Vân	34	F	45 Đinh Tiên Hoàng, Hoàn Kiếm	vanphamkhanh67693@gmail.com	0598736889	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamvan053+	0
890	Bùi Văn Nam	24	M	17 Tôn Đức Thắng, Đống Đa	nambuivan80021@gmail.com	0245695763	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buinam736*	0
891	Võ Thùy Chi	35	F	22 Cầu Giấy, Đống Đa	chivothuy04503@gmail.com	0597748879	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vochi566-	0
892	Ngô Khánh Thảo	52	F	1 Giảng Võ, Ba Đình	thaongokhanh04221@gmail.com	0519163961	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngothao809#	0
893	Dương Tuệ Chi	50	F	27 Cổ Linh, Long Biên	chiduongtue65047@gmail.com	0790576636	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongchi372-	0
894	Bùi Anh Nam	62	M	12 Tôn Đức Thắng, Đống Đa	nambuianh29054@gmail.com	0998937846	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buinam056]	0
895	Đặng Bích Linh	19	F	42 Hàng Bài, Hoàn Kiếm	linhdangbich39094@gmail.com	0160481371	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	danglinh396!	0
896	Đặng Anh Trung	62	M	52 Mai Dịch, Cầu Giấy	trungdanganh96942@gmail.com	0682115152	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangtrung237>	0
897	Nguyễn Văn Khang	25	M	37 Lý Thái Tổ, Hoàn Kiếm	khangnguyenvan53768@gmail.com	0690320863	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenkhang295,	0
898	Lý Văn Bách	54	M	38 Ngọc Khánh, Ba Đình	bachlyvan78616@gmail.com	0153295735	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lybach216(	0
899	Đỗ Thiên Trung	58	M	18 Cầu Giấy, Đống Đa	trungdothien08079@gmail.com	0492835195	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotrung074+	0
900	Phạm Quang Phúc	60	M	19 Tràng Tiền, Hoàn Kiếm	phucphamquang59666@gmail.com	0343284810	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamphuc636{	0
901	Huỳnh Quang Tiến	25	M	22 Láng Hạ, Đống Đa	tienhuynhquang94150@gmail.com	0690490245	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhtien007>	0
902	Ngô Minh Phúc	56	M	39 Bạch Mai, Hai Bà Trưng	phucngominh21246@gmail.com	0249055232	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngophuc352&	0
903	Võ Minh Tú	44	M	20 Đào Tấn, Ba Đình	tuvominh10400@gmail.com	0895336779	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votu697^	0
904	Dương Thu Nguyệt	35	F	45 Đặng Thái Thân, Hoàn Kiếm	nguyetduongthu34739@gmail.com	0373560287	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongnguyet822[	0
905	Lê Xuân Trinh	20	F	40 Phan Đình Phùng, Ba Đình	trinhlexuan91850@gmail.com	0859786050	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	letrinh403:	0
906	Phan Thiên Trung	59	M	14 Trúc Khê, Đống Đa	trungphanthien66846@gmail.com	0209007185	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phantrung343;	0
907	Ngô Xuân Như	19	F	32 Láng Hạ, Đống Đa	nhungoxuan87035@gmail.com	0840047175	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngonhu702?	0
908	Phan Văn Minh	45	M	56 Tôn Đức Thắng, Đống Đa	minhphanvan41847@gmail.com	0781980776	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanminh726[	0
909	Huỳnh Thu Lan	46	F	29 Tràng Tiền, Hoàn Kiếm	lanhuynhthu62781@gmail.com	0248096997	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhlan919/	0
910	Phan Thùy Chi	55	F	18 Nguyễn Hữu Huân, Hoàn Kiếm	chiphanthuy47276@gmail.com	0877283770	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanchi528:	0
911	Huỳnh Khánh Như	43	F	9 Bạch Mai, Hai Bà Trưng	nhuhuynhkhanh49457@gmail.com	0621251817	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhnhu841#	0
912	Lê Gia Tuấn	45	M	15 Lê Duẩn, Hoàn Kiếm	tuanlegia87180@gmail.com	0941503934	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	letuan526:	0
913	Lý Thị Đào	50	F	29 Láng Hạ, Đống Đa	daolythi23777@gmail.com	0202509701	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lydao647)	0
914	Đặng Xuân Ly	21	F	24 Nguyễn Hữu Huân, Hoàn Kiếm	lydangxuan74711@gmail.com	0805809448	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangly476&	0
915	Lê Anh Minh	54	M	6 Đinh Tiên Hoàng, Hoàn Kiếm	minhleanh12512@gmail.com	0478501463	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	leminh610>	0
916	Nguyễn Anh Minh	30	M	13 Nguyễn Chí Thanh, Đống Đa	minhnguyenanh53570@gmail.com	0715882054	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenminh746!	0
917	Lý Văn Bảo	39	M	10 Hồ Tây, Tây Hồ	baolyvan13457@gmail.com	0197370102	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lybao460.	0
918	Huỳnh An Lan	36	F	78 Bà Triệu, Hoàn Kiếm	lanhuynhan54928@gmail.com	0765118918	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhlan959]	0
919	Ngô Quang Minh	23	M	26 Bà Triệu, Hoàn Kiếm	minhngoquang80743@gmail.com	0395987597	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngominh799(	0
920	Đặng Khánh Linh	28	F	15 Lý Thái Tổ, Hoàn Kiếm	linhdangkhanh76334@gmail.com	0411936701	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	danglinh378,	0
921	Vũ Thu Thúy	39	F	20 Giảng Võ, Ba Đình	thuyvuthu63386@gmail.com	0940083494	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuthuy892{	0
922	Lê Gia Minh	21	M	28 Đào Tấn, Ba Đình	minhlegia74379@gmail.com	0559988961	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	leminh732!	0
923	Đặng Bích Thảo	63	F	30 Đinh Tiên Hoàng, Hoàn Kiếm	thaodangbich19233@gmail.com	0989887440	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangthao680<	0
924	Nguyễn Văn Minh	34	M	28 Đào Tấn, Ba Đình	minhnguyenvan82604@gmail.com	0482369934	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenminh691-	0
925	Hồ Thị Trang	45	F	Studio Yoga & Thiền	tranghothi91889@gmail.com	0452067398	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hotrang893{	0
926	Đặng Văn Tú	24	M	28a Điện Biên Phủ, Ba Đình	tudangvan90910@gmail.com	0709418767	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangtu907{	0
927	Nguyễn Anh Bách	58	M	1 Trường Chinh, Cầu Giấy	bachnguyenanh73269@gmail.com	0104945925	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenbach649<	0
928	Võ An Thư	37	F	34 Nguyễn Chí Thanh, Đống Đa	thuvoan96633@gmail.com	0893518606	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vothu832}	0
929	Trần Khánh Chi	59	F	6 Tô Hiệu, Cầu Giấy	chitrankhanh35507@gmail.com	0685742559	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranchi215$	0
930	Bùi Quang Bảo	64	M	27 Cổ Linh, Long Biên	baobuiquang92862@gmail.com	0770195645	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buibao870=	0
931	Đỗ Minh Trung	53	M	2 Phạm Ngọc Thạch, Đống Đa	trungdominh93543@gmail.com	0497143991	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotrung696@	0
932	Lê Bích Hằng	48	F	33 Bà Triệu, Hoàn Kiếm	hanglebich70702@gmail.com	0386538951	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lehang580#	0
933	Nguyễn Gia Tiến	42	M	33 Nguyễn Huệ, Hoàn Kiếm	tiennguyengia31084@gmail.com	0973512193	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyentien775)	0
1011	va	22	M	4tp	va5@gmail.com	0113355779	2025-01-15 01:13:34.619905	2025-01-15 01:13:34.619905	dragonnest2210@	0
934	Đặng Tuệ Chi	28	F	25 Nguyễn Thái Học, Ba Đình	chidangtue88483@gmail.com	0712634186	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangchi311^	0
935	Dương Thị Linh	45	F	59 Lý Thái Tổ, Hoàn Kiếm	linhduongthi29422@gmail.com	0842073110	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duonglinh163.	0
936	Lý An Trinh	29	F	44 Phan Đình Phùng, Ba Đình	trinhlyan64937@gmail.com	0615368710	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytrinh302,	0
937	Lê Văn Minh	39	M	19 Đào Tấn, Ba Đình	minhlevan46234@gmail.com	0119975581	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	leminh921_	0
938	Võ Minh Khoa	29	M	37 Lý Thái Tổ, Hoàn Kiếm	khoavominh28746@gmail.com	0198535730	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vokhoa416>	0
939	Hoàng Tuệ Như	63	F	12 Hàng Bài, Hoàn Kiếm	nhuhoangtue46441@gmail.com	0298634710	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangnhu918?	0
940	Vũ Quang Minh	64	M	15 Chùa Bộc, Đống Đa	minhvuquang41373@gmail.com	0694762479	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuminh291{	0
941	Hồ Tuệ Linh	56	F	6 Nguyễn Hữu Huân, Hoàn Kiếm	linhhotue14362@gmail.com	0877665558	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	holinh864?	0
942	Trần Minh Huy	36	M	1 Lý Thường Kiệt, Hoàn Kiếm	huytranminh27495@gmail.com	0914474002	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	tranhuy572*	0
943	Hoàng Thiên Minh	52	M	45 Đinh Tiên Hoàng, Hoàn Kiếm	minhhoangthien85246@gmail.com	0714415440	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangminh848,	0
944	Đặng Anh Huy	60	M	28 Nguyễn Thái Học, Ba Đình	huydanganh44653@gmail.com	0894820861	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	danghuy754-	0
945	Phan Thùy Lan	50	F	13 Tràng Tiền, Hoàn Kiếm	lanphanthuy56655@gmail.com	0535976298	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanlan625,	0
946	Phạm Khánh Đào	26	F	53 Nguyễn Hữu Huân, Hoàn Kiếm	daophamkhanh88238@gmail.com	0893196668	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamdao913,	0
947	Phan Minh Phúc	20	M	19 Tràng Tiền, Hoàn Kiếm	phucphanminh59312@gmail.com	0479371480	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanphuc755)	0
948	Huỳnh Thiên Huy	55	M	45 Đặng Thái Thân, Hoàn Kiếm	huyhuynhthien48658@gmail.com	0348391394	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhhuy916(	0
949	Đặng Minh Khoa	48	M	196 Đội Cấn, Ba Đình	khoadangminh37857@gmail.com	0672926643	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dangkhoa318/	0
950	Đỗ Thu Thảo	38	F	25 Hồ Tây, Tây Hồ	thaodothu08444@gmail.com	0307251592	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dothao192$	0
951	Ngô Gia Tuấn	36	M	31 Nguyễn Lương Bằng, Đống Đa	tuanngogia90446@gmail.com	0962051546	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngotuan108;	0
952	Phan Văn Huy	41	M	14 Tôn Đức Thắng, Đống Đa	huyphanvan21076@gmail.com	0729081012	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanhuy066@	0
953	Huỳnh Minh Bách	38	M	45 Giảng Võ, Ba Đình	bachhuynhminh69216@gmail.com	0233839335	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	huynhbach578)	0
954	Dương Thùy Nguyệt	39	F	Tây Hồ, Hà Nội	nguyetduongthuy94899@gmail.com	0666432473	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongnguyet462.	0
955	Lý An Lan	61	F	43 Bà Triệu, Hoàn Kiếm	lanlyan79463@gmail.com	0668439213	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lylan843)	0
956	Hồ Gia Khang	62	M	59 Lý Thái Tổ, Hoàn Kiếm	khanghogia68167@gmail.com	0323588378	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hokhang603>	0
957	Hồ Anh Hồ	25	M	56 Phan Đình Phùng, Ba Đình	hohoanh87159@gmail.com	0954963694	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoho643+	0
958	Hoàng Quang Tùng	56	M	30 Giảng Võ, Ba Đình	tunghoangquang96033@gmail.com	0839202488	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangtung509?	0
959	Nguyễn Thị Lan	59	F	14 Phan Đình Phùng, Ba Đình	lannguyenthi27705@gmail.com	0549837670	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	nguyenlan647(	0
960	Dương Thu Thư	44	F	45 Đặng Thái Thân, Hoàn Kiếm	thuduongthu36578@gmail.com	0537032731	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongthu964=	0
961	Phạm Gia Lộc	61	M	19 Đào Tấn, Ba Đình	locphamgia55908@gmail.com	0175942445	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phamloc646}	0
962	Bùi Thiên Phát	50	M	Studio Yoga & Thiền	phatbuithien40013@gmail.com	0636467166	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buiphat413!	0
963	Ngô An Ly	23	F	21 Giảng Võ, Ba Đình	lyngoan75938@gmail.com	0974761249	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngoly974#	0
964	Dương Bích Nguyệt	61	F	43 Nguyễn Hữu Huân, Hoàn Kiếm	nguyetduongbich47839@gmail.com	0723320450	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	duongnguyet480=	0
965	Bùi Văn Bách	53	M	18 Tô Hiệu, Cầu Giấy	bachbuivan37606@gmail.com	0570439439	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buibach728]	0
966	Võ Quang Tùng	19	M	1 Tràng Tiền, Hoàn Kiếm	tungvoquang66373@gmail.com	0412404707	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	votung282?	0
967	Phan Tuệ Lan	29	F	19 Trần Quang Khải, Hoàn Kiếm	lanphantue23657@gmail.com	0183563319	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanlan797.	0
968	Vũ Gia Khoa	57	M	15 Quảng An, Tây Hồ	khoavugia06583@gmail.com	0873841429	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vukhoa407,	0
969	Phan An Huyền	61	F	68 Phố Tràng Tiền, Hoàn Kiếm	huyenphanan55916@gmail.com	0505320101	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanhuyen308@	0
970	Trần Quang Tùng	31	M	16 Tô Hiệu, Cầu Giấy	tungtranquang93519@gmail.com	0993040220	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	trantung590[	0
971	Hoàng Quang Bảo	61	M	14 Tôn Đức Thắng, Đống Đa	baohoangquang22679@gmail.com	0230863205	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangbao356[	0
972	Phan Quang Minh	53	M	105 Cầu Giấy, Đống Đa	minhphanquang51290@gmail.com	0999150714	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanminh427;	0
973	Đỗ Thị Trinh	51	F	14 Lê Duẩn, Ba Đình	trinhdothi90122@gmail.com	0274496724	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotrinh362%	0
974	Ngô Tuệ Thúy	40	F	Lotte Center Hanoi, 54 Liễu Giai, Ba Đình	thuyngotue52878@gmail.com	0542299864	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngothuy832+	0
975	Ngô Văn Bách	40	M	5 Trúc Khê, Đống Đa	bachngovan03764@gmail.com	0343769998	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngobach418%	0
976	Hồ Gia Bảo	20	M	1 Trường Chinh, Cầu Giấy	baohogia18736@gmail.com	0517276279	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hobao371}	0
977	Bùi Khánh Thúy	31	F	88 Nguyễn Du, Hoàn Kiếm	thuybuikhanh68591@gmail.com	0432673613	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buithuy247%	0
978	Lý Gia Tú	30	M	29 Đào Tấn, Ba Đình	tulygia65020@gmail.com	0496110021	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lytu516+	0
979	Vũ Quang Phúc	53	M	50 Chùa Bộc, Đống Đa	phucvuquang25945@gmail.com	0993262221	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuphuc555!	0
980	Đỗ Minh Tùng	56	M	42 Hàng Bài, Hoàn Kiếm	tungdominh74737@gmail.com	0885677500	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dotung537+	0
981	Hoàng Minh Khoa	28	M	6 Láng Hạ, Đống Đa	khoahoangminh27409@gmail.com	0801445809	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hoangkhoa586#	0
982	Đỗ An Linh	18	F	30 Đinh Tiên Hoàng, Hoàn Kiếm	linhdoan28786@gmail.com	0907860025	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dolinh769{	0
983	Ngô An Nhung	51	F	14 Trúc Khê, Đống Đa	nhungngoan98493@gmail.com	0114415492	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	ngonhung073.	0
984	Lý Xuân Thảo	37	F	34 Nguyễn Lương Bằng, Đống Đa	thaolyxuan87903@gmail.com	0260962418	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lythao515,	0
985	Lê Xuân Thảo	36	F	Trung tâm Văn hóa Nghệ thuật Việt Nam	thaolexuan73034@gmail.com	0400169265	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lethao483.	0
986	Võ Thu Đào	29	F	15 Lý Thái Tổ, Hoàn Kiếm	daovothu83274@gmail.com	0859438867	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vodao475{	0
987	Phan Khánh Thúy	22	F	24 Tràng Tiền, Hoàn Kiếm	thuyphankhanh54978@gmail.com	0106443693	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	phanthuy558:	0
988	Hồ Thị Hằng	22	F	17 Tôn Đức Thắng, Đống Đa	hanghothi28991@gmail.com	0830666905	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hohang636!	0
989	Đỗ Thùy Chi	47	F	27 Hồ Tây, Tây Hồ	chidothuy28995@gmail.com	0616445168	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dochi498&	0
990	Đỗ Văn Huy	38	M	22 Hàng Bài, Hoàn Kiếm	huydovan29492@gmail.com	0531348106	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dohuy667_	0
991	Lý An Hằng	28	F	6 Nguyễn Hữu Huân, Hoàn Kiếm	hanglyan36416@gmail.com	0767206837	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lyhang157-	0
992	Vũ Anh Nam	29	M	37 Lý Thái Tổ, Hoàn Kiếm	namvuanh63185@gmail.com	0538349960	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vunam745@	0
993	Đỗ Thiên Phát	23	M	50 Tôn Đức Thắng, Đống Đa	phatdothien73826@gmail.com	0638979101	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	dophat932!	0
994	Lê Thiên Khoa	54	M	58 Nguyễn Thái Học, Ba Đình	khoalethien32076@gmail.com	0430315265	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lekhoa174+	0
995	Hồ Anh Minh	60	M	56 Lý Thái Tổ, Hoàn Kiếm	minhhoanh88786@gmail.com	0757017099	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hominh308$	0
996	Hồ Tuệ Thúy	22	F	18 Giảng Võ, Ba Đình	thuyhotue38231@gmail.com	0258643450	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	hothuy551{	0
997	Vũ Thu Hằng	25	F	31 Cao Bá Quát, Ba Đình	hangvuthu26865@gmail.com	0140339223	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vuhang443$	0
998	Lê Văn Bách	20	M	22 Hàng Bài, Hoàn Kiếm	bachlevan93830@gmail.com	0279374855	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	lebach200^	0
999	Bùi An Đào	43	F	16 Hoàng Quốc Việt, Cầu Giấy	daobuian53967@gmail.com	0881074992	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	buidao624$	0
1000	Võ Khánh Thư	33	F	4 Nguyễn Du, Hoàn Kiếm	thuvokhanh05199@gmail.com	0864281139	2025-01-03 06:09:28.896998	2025-01-03 06:09:28.896998	vothu921/	0
1050	admin	22	M	newAdd	admin@gm.com	0000000000	2025-01-16 17:11:30.272561	2025-01-21 11:11:15.352471	admin@123	1
\.


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 218
-- Name: booking_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_booking_id_seq', 420, true);


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 222
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 519, true);


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 224
-- Name: payment_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_payment_id_seq', 473, true);


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 230
-- Name: pending_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pending_users_id_seq', 48, true);


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 226
-- Name: shopping_cart_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shopping_cart_cart_id_seq', 1004, true);


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 229
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1100, true);


--
-- TOC entry 4807 (class 2606 OID 32977)
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (booking_id);


--
-- TOC entry 4809 (class 2606 OID 32979)
-- Name: dish dish_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish
    ADD CONSTRAINT dish_pkey PRIMARY KEY (dish_id);


--
-- TOC entry 4811 (class 2606 OID 32981)
-- Name: order_dishes order_dishes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_dishes
    ADD CONSTRAINT order_dishes_pkey PRIMARY KEY (order_id, dish_id);


--
-- TOC entry 4813 (class 2606 OID 32983)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 4815 (class 2606 OID 32985)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 4827 (class 2606 OID 33072)
-- Name: pending_users pending_users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_users
    ADD CONSTRAINT pending_users_email_key UNIQUE (email);


--
-- TOC entry 4829 (class 2606 OID 33074)
-- Name: pending_users pending_users_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_users
    ADD CONSTRAINT pending_users_phone_key UNIQUE (phone);


--
-- TOC entry 4831 (class 2606 OID 33070)
-- Name: pending_users pending_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_users
    ADD CONSTRAINT pending_users_pkey PRIMARY KEY (id);


--
-- TOC entry 4833 (class 2606 OID 33076)
-- Name: pending_users pending_users_verification_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_users
    ADD CONSTRAINT pending_users_verification_token_key UNIQUE (verification_token);


--
-- TOC entry 4819 (class 2606 OID 32987)
-- Name: shopping_cart_dishes shopping_cart_dishes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart_dishes
    ADD CONSTRAINT shopping_cart_dishes_pkey PRIMARY KEY (cart_id, dish_id);


--
-- TOC entry 4817 (class 2606 OID 32989)
-- Name: shopping_cart shopping_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_pkey PRIMARY KEY (cart_id);


--
-- TOC entry 4821 (class 2606 OID 32991)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4823 (class 2606 OID 32993)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 4825 (class 2606 OID 32995)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4834 (class 2606 OID 32996)
-- Name: booking booking_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4835 (class 2606 OID 33001)
-- Name: order_dishes order_dishes_dish_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_dishes
    ADD CONSTRAINT order_dishes_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.dish(dish_id);


--
-- TOC entry 4836 (class 2606 OID 33006)
-- Name: order_dishes order_dishes_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_dishes
    ADD CONSTRAINT order_dishes_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- TOC entry 4837 (class 2606 OID 33011)
-- Name: orders orders_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(booking_id) ON DELETE SET NULL;


--
-- TOC entry 4838 (class 2606 OID 33016)
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4839 (class 2606 OID 33021)
-- Name: payment payment_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- TOC entry 4840 (class 2606 OID 33026)
-- Name: payment payment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4842 (class 2606 OID 33031)
-- Name: shopping_cart_dishes shopping_cart_dishes_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart_dishes
    ADD CONSTRAINT shopping_cart_dishes_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.shopping_cart(cart_id) ON DELETE CASCADE;


--
-- TOC entry 4843 (class 2606 OID 33036)
-- Name: shopping_cart_dishes shopping_cart_dishes_dish_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart_dishes
    ADD CONSTRAINT shopping_cart_dishes_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.dish(dish_id);


--
-- TOC entry 4841 (class 2606 OID 33041)
-- Name: shopping_cart shopping_cart_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


-- Completed on 2025-01-24 18:27:19

--
-- PostgreSQL database dump complete
--

