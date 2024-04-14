--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(40) NOT NULL,
    x integer,
    y integer,
    size numeric(4,1) NOT NULL,
    description text,
    has_life boolean DEFAULT false,
    is_spherical boolean DEFAULT false
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(40) NOT NULL,
    x integer,
    y integer,
    size numeric(4,1) NOT NULL,
    description text,
    has_life boolean DEFAULT false,
    is_spherical boolean DEFAULT false,
    planet_id integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(40) NOT NULL,
    x integer,
    y integer,
    size numeric(4,1) NOT NULL,
    description text,
    has_life boolean DEFAULT false,
    is_spherical boolean DEFAULT false,
    star_id integer NOT NULL
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(40) NOT NULL,
    x integer,
    y integer,
    size numeric(4,1) NOT NULL,
    description text,
    has_life boolean DEFAULT false,
    is_spherical boolean DEFAULT false,
    galaxy_id integer NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: star_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star_type (
    star_type_id integer NOT NULL,
    name character varying(30) NOT NULL,
    color character varying(30) NOT NULL
);


ALTER TABLE public.star_type OWNER TO freecodecamp;

--
-- Name: star_type_star_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_type_star_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_type_star_type_id_seq OWNER TO freecodecamp;

--
-- Name: star_type_star_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_type_star_type_id_seq OWNED BY public.star_type.star_type_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: star_type star_type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type ALTER COLUMN star_type_id SET DEFAULT nextval('public.star_type_star_type_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'M31', NULL, NULL, 300.0, NULL, false, false);
INSERT INTO public.galaxy VALUES (2, 'M33', NULL, NULL, 350.0, NULL, false, false);
INSERT INTO public.galaxy VALUES (3, 'M104', NULL, NULL, 400.0, NULL, false, false);
INSERT INTO public.galaxy VALUES (4, 'M87', NULL, NULL, 405.0, NULL, false, false);
INSERT INTO public.galaxy VALUES (5, 'M51', NULL, NULL, 600.0, NULL, false, false);
INSERT INTO public.galaxy VALUES (6, 'milk way', NULL, NULL, 350.0, NULL, true, false);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', NULL, NULL, 5.0, NULL, false, false, 3);
INSERT INTO public.moon VALUES (2, 'Phobos', NULL, NULL, 5.0, NULL, false, false, 4);
INSERT INTO public.moon VALUES (3, 'Deimos', NULL, NULL, 2.0, NULL, false, false, 4);
INSERT INTO public.moon VALUES (4, 'Io', NULL, NULL, 7.0, NULL, false, false, 5);
INSERT INTO public.moon VALUES (5, 'Europa', NULL, NULL, 7.0, NULL, false, false, 5);
INSERT INTO public.moon VALUES (6, 'Ganumede', NULL, NULL, 6.0, NULL, false, false, 5);
INSERT INTO public.moon VALUES (7, 'Callisto', NULL, NULL, 6.0, NULL, false, false, 5);
INSERT INTO public.moon VALUES (8, 'Mimas', NULL, NULL, 8.0, NULL, false, false, 6);
INSERT INTO public.moon VALUES (9, 'Encoladus', NULL, NULL, 8.0, NULL, false, false, 6);
INSERT INTO public.moon VALUES (10, 'Ththys', NULL, NULL, 8.0, NULL, false, false, 6);
INSERT INTO public.moon VALUES (11, 'Dione', NULL, NULL, 8.0, NULL, false, false, 8);
INSERT INTO public.moon VALUES (12, 'Rhes', NULL, NULL, 5.0, NULL, false, false, 6);
INSERT INTO public.moon VALUES (13, 'Titan', NULL, NULL, 15.0, NULL, false, false, 6);
INSERT INTO public.moon VALUES (14, 'Huperion', NULL, NULL, 5.0, NULL, false, false, 6);
INSERT INTO public.moon VALUES (15, 'Puch', NULL, NULL, 2.0, NULL, false, false, 7);
INSERT INTO public.moon VALUES (16, 'Miranda', NULL, NULL, 2.0, NULL, false, false, 7);
INSERT INTO public.moon VALUES (17, 'Ariel', NULL, NULL, 6.0, NULL, false, false, 7);
INSERT INTO public.moon VALUES (18, 'Umbriael', NULL, NULL, 6.0, NULL, false, false, 7);
INSERT INTO public.moon VALUES (19, 'Titania', NULL, NULL, 2.0, NULL, false, false, 7);
INSERT INTO public.moon VALUES (20, 'Oberon', NULL, NULL, 3.0, NULL, false, false, 7);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', NULL, NULL, 10.0, NULL, false, false, 1);
INSERT INTO public.planet VALUES (2, 'Venus', NULL, NULL, 20.0, NULL, false, false, 1);
INSERT INTO public.planet VALUES (3, 'Earth', NULL, NULL, 30.0, NULL, false, false, 1);
INSERT INTO public.planet VALUES (4, 'Mars', NULL, NULL, 25.0, NULL, false, false, 1);
INSERT INTO public.planet VALUES (5, 'Jupiter', NULL, NULL, 35.0, NULL, false, false, 1);
INSERT INTO public.planet VALUES (6, 'Saturn', NULL, NULL, 30.0, NULL, false, false, 1);
INSERT INTO public.planet VALUES (7, 'Uranus', NULL, NULL, 19.0, NULL, false, false, 1);
INSERT INTO public.planet VALUES (8, 'Neptune', NULL, NULL, 20.0, NULL, false, false, 1);
INSERT INTO public.planet VALUES (9, 'X1', NULL, NULL, 30.0, NULL, false, false, 2);
INSERT INTO public.planet VALUES (10, 'X2', NULL, NULL, 25.0, NULL, false, false, 2);
INSERT INTO public.planet VALUES (11, 'X3', NULL, NULL, 35.0, NULL, false, false, 2);
INSERT INTO public.planet VALUES (12, 'Y1', NULL, NULL, 30.0, NULL, false, false, 3);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (2, 'S10', NULL, NULL, 40.0, NULL, false, false, 1);
INSERT INTO public.star VALUES (3, 'S50', NULL, NULL, 40.0, NULL, false, false, 2);
INSERT INTO public.star VALUES (4, 'S25', NULL, NULL, 60.0, NULL, false, false, 3);
INSERT INTO public.star VALUES (5, 'S21', NULL, NULL, 35.0, NULL, false, false, 4);
INSERT INTO public.star VALUES (6, 'S18', NULL, NULL, 25.0, NULL, false, false, 5);
INSERT INTO public.star VALUES (1, 'Sun', NULL, NULL, 10.0, NULL, false, false, 6);


--
-- Data for Name: star_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star_type VALUES (1, 'M', 'red');
INSERT INTO public.star_type VALUES (2, 'K', 'orange');
INSERT INTO public.star_type VALUES (3, 'G', 'white');


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: star_type_star_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_type_star_type_id_seq', 3, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: star_type star_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type
    ADD CONSTRAINT star_type_name_key UNIQUE (name);


--
-- Name: star_type star_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type
    ADD CONSTRAINT star_type_pkey PRIMARY KEY (star_type_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

