--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2 (Debian 17.2-1.pgdg120+1)

-- SET statement_timeout = 0;
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
-- Name: atlanta_hawks; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.atlanta_hawks (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.atlanta_hawks OWNER TO admin;

--
-- Name: atlanta_hawks_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.atlanta_hawks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.atlanta_hawks_id_seq OWNER TO admin;

--
-- Name: atlanta_hawks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.atlanta_hawks_id_seq OWNED BY public.atlanta_hawks.id;


--
-- Name: atlanta_hawks_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.atlanta_hawks_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.atlanta_hawks_jogadores OWNER TO admin;

--
-- Name: atlanta_hawks_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.atlanta_hawks_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.atlanta_hawks_jogadores_id_seq OWNER TO admin;

--
-- Name: atlanta_hawks_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.atlanta_hawks_jogadores_id_seq OWNED BY public.atlanta_hawks_jogadores.id;


--
-- Name: atlanta_hawks_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.atlanta_hawks_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.atlanta_hawks_lesoes OWNER TO admin;

--
-- Name: atlanta_hawks_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.atlanta_hawks_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.atlanta_hawks_lesoes_id_seq OWNER TO admin;

--
-- Name: atlanta_hawks_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.atlanta_hawks_lesoes_id_seq OWNED BY public.atlanta_hawks_lesoes.id;


--
-- Name: bankrolls; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.bankrolls (
    id integer NOT NULL,
    user_id integer NOT NULL,
    days_option character varying(20),
    days integer NOT NULL,
    bankroll numeric(10,2) NOT NULL,
    target_profit numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    balance numeric(10,2) DEFAULT 0.00
);


-- ALTER TABLE public.bankrolls OWNER TO admin;

--
-- Name: bankrolls_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.bankrolls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.bankrolls_id_seq OWNER TO admin;

--
-- Name: bankrolls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.bankrolls_id_seq OWNED BY public.bankrolls.id;


--
-- Name: bets; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.bets (
    id integer NOT NULL,
    user_id integer NOT NULL,
    game_date text NOT NULL,
    games text NOT NULL,
    choices text NOT NULL,
    odds numeric NOT NULL,
    bet_value numeric NOT NULL,
    lucro numeric NOT NULL,
    outcome text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


-- ALTER TABLE public.bets OWNER TO admin;

--
-- Name: bets_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.bets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.bets_id_seq OWNER TO admin;

--
-- Name: bets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.bets_id_seq OWNED BY public.bets.id;


--
-- Name: betting_plans; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.betting_plans (
    id integer NOT NULL,
    user_id integer NOT NULL,
    days_option character varying(20),
    days integer,
    bankroll numeric(10,2),
    target_profit numeric(10,2)
);


-- ALTER TABLE public.betting_plans OWNER TO admin;

--
-- Name: betting_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.betting_plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.betting_plans_id_seq OWNER TO admin;

--
-- Name: betting_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.betting_plans_id_seq OWNED BY public.betting_plans.id;


--
-- Name: boston_celtics; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.boston_celtics (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.boston_celtics OWNER TO admin;

--
-- Name: boston_celtics_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.boston_celtics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.boston_celtics_id_seq OWNER TO admin;

--
-- Name: boston_celtics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.boston_celtics_id_seq OWNED BY public.boston_celtics.id;


--
-- Name: boston_celtics_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.boston_celtics_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.boston_celtics_jogadores OWNER TO admin;

--
-- Name: boston_celtics_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.boston_celtics_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.boston_celtics_jogadores_id_seq OWNER TO admin;

--
-- Name: boston_celtics_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.boston_celtics_jogadores_id_seq OWNED BY public.boston_celtics_jogadores.id;


--
-- Name: boston_celtics_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.boston_celtics_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.boston_celtics_lesoes OWNER TO admin;

--
-- Name: boston_celtics_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.boston_celtics_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.boston_celtics_lesoes_id_seq OWNER TO admin;

--
-- Name: boston_celtics_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.boston_celtics_lesoes_id_seq OWNED BY public.boston_celtics_lesoes.id;


--
-- Name: brooklyn_nets; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.brooklyn_nets (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.brooklyn_nets OWNER TO admin;

--
-- Name: brooklyn_nets_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.brooklyn_nets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.brooklyn_nets_id_seq OWNER TO admin;

--
-- Name: brooklyn_nets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.brooklyn_nets_id_seq OWNED BY public.brooklyn_nets.id;


--
-- Name: brooklyn_nets_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.brooklyn_nets_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.brooklyn_nets_jogadores OWNER TO admin;

--
-- Name: brooklyn_nets_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.brooklyn_nets_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.brooklyn_nets_jogadores_id_seq OWNER TO admin;

--
-- Name: brooklyn_nets_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.brooklyn_nets_jogadores_id_seq OWNED BY public.brooklyn_nets_jogadores.id;


--
-- Name: brooklyn_nets_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.brooklyn_nets_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.brooklyn_nets_lesoes OWNER TO admin;

--
-- Name: brooklyn_nets_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.brooklyn_nets_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.brooklyn_nets_lesoes_id_seq OWNER TO admin;

--
-- Name: brooklyn_nets_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.brooklyn_nets_lesoes_id_seq OWNED BY public.brooklyn_nets_lesoes.id;


--
-- Name: charlotte_hornets; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.charlotte_hornets (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.charlotte_hornets OWNER TO admin;

--
-- Name: charlotte_hornets_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.charlotte_hornets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.charlotte_hornets_id_seq OWNER TO admin;

--
-- Name: charlotte_hornets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.charlotte_hornets_id_seq OWNED BY public.charlotte_hornets.id;


--
-- Name: charlotte_hornets_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.charlotte_hornets_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.charlotte_hornets_jogadores OWNER TO admin;

--
-- Name: charlotte_hornets_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.charlotte_hornets_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.charlotte_hornets_jogadores_id_seq OWNER TO admin;

--
-- Name: charlotte_hornets_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.charlotte_hornets_jogadores_id_seq OWNED BY public.charlotte_hornets_jogadores.id;


--
-- Name: charlotte_hornets_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.charlotte_hornets_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.charlotte_hornets_lesoes OWNER TO admin;

--
-- Name: charlotte_hornets_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.charlotte_hornets_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.charlotte_hornets_lesoes_id_seq OWNER TO admin;

--
-- Name: charlotte_hornets_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.charlotte_hornets_lesoes_id_seq OWNED BY public.charlotte_hornets_lesoes.id;


--
-- Name: chicago_bulls; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.chicago_bulls (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.chicago_bulls OWNER TO admin;

--
-- Name: chicago_bulls_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.chicago_bulls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.chicago_bulls_id_seq OWNER TO admin;

--
-- Name: chicago_bulls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.chicago_bulls_id_seq OWNED BY public.chicago_bulls.id;


--
-- Name: chicago_bulls_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.chicago_bulls_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.chicago_bulls_jogadores OWNER TO admin;

--
-- Name: chicago_bulls_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.chicago_bulls_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.chicago_bulls_jogadores_id_seq OWNER TO admin;

--
-- Name: chicago_bulls_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.chicago_bulls_jogadores_id_seq OWNED BY public.chicago_bulls_jogadores.id;


--
-- Name: chicago_bulls_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.chicago_bulls_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.chicago_bulls_lesoes OWNER TO admin;

--
-- Name: chicago_bulls_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.chicago_bulls_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.chicago_bulls_lesoes_id_seq OWNER TO admin;

--
-- Name: chicago_bulls_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.chicago_bulls_lesoes_id_seq OWNED BY public.chicago_bulls_lesoes.id;


--
-- Name: cleveland_cavaliers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.cleveland_cavaliers (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.cleveland_cavaliers OWNER TO admin;

--
-- Name: cleveland_cavaliers_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.cleveland_cavaliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.cleveland_cavaliers_id_seq OWNER TO admin;

--
-- Name: cleveland_cavaliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.cleveland_cavaliers_id_seq OWNED BY public.cleveland_cavaliers.id;


--
-- Name: cleveland_cavaliers_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.cleveland_cavaliers_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.cleveland_cavaliers_jogadores OWNER TO admin;

--
-- Name: cleveland_cavaliers_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.cleveland_cavaliers_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.cleveland_cavaliers_jogadores_id_seq OWNER TO admin;

--
-- Name: cleveland_cavaliers_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.cleveland_cavaliers_jogadores_id_seq OWNED BY public.cleveland_cavaliers_jogadores.id;


--
-- Name: cleveland_cavaliers_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.cleveland_cavaliers_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.cleveland_cavaliers_lesoes OWNER TO admin;

--
-- Name: cleveland_cavaliers_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.cleveland_cavaliers_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.cleveland_cavaliers_lesoes_id_seq OWNER TO admin;

--
-- Name: cleveland_cavaliers_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.cleveland_cavaliers_lesoes_id_seq OWNED BY public.cleveland_cavaliers_lesoes.id;


--
-- Name: dallas_mavericks; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dallas_mavericks (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.dallas_mavericks OWNER TO admin;

--
-- Name: dallas_mavericks_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.dallas_mavericks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.dallas_mavericks_id_seq OWNER TO admin;

--
-- Name: dallas_mavericks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.dallas_mavericks_id_seq OWNED BY public.dallas_mavericks.id;


--
-- Name: dallas_mavericks_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dallas_mavericks_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.dallas_mavericks_jogadores OWNER TO admin;

--
-- Name: dallas_mavericks_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.dallas_mavericks_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.dallas_mavericks_jogadores_id_seq OWNER TO admin;

--
-- Name: dallas_mavericks_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.dallas_mavericks_jogadores_id_seq OWNED BY public.dallas_mavericks_jogadores.id;


--
-- Name: dallas_mavericks_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dallas_mavericks_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.dallas_mavericks_lesoes OWNER TO admin;

--
-- Name: dallas_mavericks_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.dallas_mavericks_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.dallas_mavericks_lesoes_id_seq OWNER TO admin;

--
-- Name: dallas_mavericks_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.dallas_mavericks_lesoes_id_seq OWNED BY public.dallas_mavericks_lesoes.id;


--
-- Name: denver_nuggets; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.denver_nuggets (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.denver_nuggets OWNER TO admin;

--
-- Name: denver_nuggets_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.denver_nuggets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.denver_nuggets_id_seq OWNER TO admin;

--
-- Name: denver_nuggets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.denver_nuggets_id_seq OWNED BY public.denver_nuggets.id;


--
-- Name: denver_nuggets_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.denver_nuggets_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.denver_nuggets_jogadores OWNER TO admin;

--
-- Name: denver_nuggets_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.denver_nuggets_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.denver_nuggets_jogadores_id_seq OWNER TO admin;

--
-- Name: denver_nuggets_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.denver_nuggets_jogadores_id_seq OWNED BY public.denver_nuggets_jogadores.id;


--
-- Name: denver_nuggets_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.denver_nuggets_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.denver_nuggets_lesoes OWNER TO admin;

--
-- Name: denver_nuggets_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.denver_nuggets_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.denver_nuggets_lesoes_id_seq OWNER TO admin;

--
-- Name: denver_nuggets_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.denver_nuggets_lesoes_id_seq OWNED BY public.denver_nuggets_lesoes.id;


--
-- Name: detroit_pistons; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.detroit_pistons (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.detroit_pistons OWNER TO admin;

--
-- Name: detroit_pistons_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.detroit_pistons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.detroit_pistons_id_seq OWNER TO admin;

--
-- Name: detroit_pistons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.detroit_pistons_id_seq OWNED BY public.detroit_pistons.id;


--
-- Name: detroit_pistons_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.detroit_pistons_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.detroit_pistons_jogadores OWNER TO admin;

--
-- Name: detroit_pistons_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.detroit_pistons_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.detroit_pistons_jogadores_id_seq OWNER TO admin;

--
-- Name: detroit_pistons_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.detroit_pistons_jogadores_id_seq OWNED BY public.detroit_pistons_jogadores.id;


--
-- Name: detroit_pistons_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.detroit_pistons_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.detroit_pistons_lesoes OWNER TO admin;

--
-- Name: detroit_pistons_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.detroit_pistons_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.detroit_pistons_lesoes_id_seq OWNER TO admin;

--
-- Name: detroit_pistons_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.detroit_pistons_lesoes_id_seq OWNED BY public.detroit_pistons_lesoes.id;


--
-- Name: golden_state_warriors; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.golden_state_warriors (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.golden_state_warriors OWNER TO admin;

--
-- Name: golden_state_warriors_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.golden_state_warriors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.golden_state_warriors_id_seq OWNER TO admin;

--
-- Name: golden_state_warriors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.golden_state_warriors_id_seq OWNED BY public.golden_state_warriors.id;


--
-- Name: golden_state_warriors_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.golden_state_warriors_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.golden_state_warriors_jogadores OWNER TO admin;

--
-- Name: golden_state_warriors_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.golden_state_warriors_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.golden_state_warriors_jogadores_id_seq OWNER TO admin;

--
-- Name: golden_state_warriors_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.golden_state_warriors_jogadores_id_seq OWNED BY public.golden_state_warriors_jogadores.id;


--
-- Name: golden_state_warriors_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.golden_state_warriors_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.golden_state_warriors_lesoes OWNER TO admin;

--
-- Name: golden_state_warriors_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.golden_state_warriors_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.golden_state_warriors_lesoes_id_seq OWNER TO admin;

--
-- Name: golden_state_warriors_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.golden_state_warriors_lesoes_id_seq OWNED BY public.golden_state_warriors_lesoes.id;


--
-- Name: houston_rockets; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.houston_rockets (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.houston_rockets OWNER TO admin;

--
-- Name: houston_rockets_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.houston_rockets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.houston_rockets_id_seq OWNER TO admin;

--
-- Name: houston_rockets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.houston_rockets_id_seq OWNED BY public.houston_rockets.id;


--
-- Name: houston_rockets_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.houston_rockets_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.houston_rockets_jogadores OWNER TO admin;

--
-- Name: houston_rockets_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.houston_rockets_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.houston_rockets_jogadores_id_seq OWNER TO admin;

--
-- Name: houston_rockets_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.houston_rockets_jogadores_id_seq OWNED BY public.houston_rockets_jogadores.id;


--
-- Name: houston_rockets_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.houston_rockets_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.houston_rockets_lesoes OWNER TO admin;

--
-- Name: houston_rockets_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.houston_rockets_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.houston_rockets_lesoes_id_seq OWNER TO admin;

--
-- Name: houston_rockets_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.houston_rockets_lesoes_id_seq OWNED BY public.houston_rockets_lesoes.id;


--
-- Name: indiana_pacers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.indiana_pacers (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.indiana_pacers OWNER TO admin;

--
-- Name: indiana_pacers_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.indiana_pacers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.indiana_pacers_id_seq OWNER TO admin;

--
-- Name: indiana_pacers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.indiana_pacers_id_seq OWNED BY public.indiana_pacers.id;


--
-- Name: indiana_pacers_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.indiana_pacers_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.indiana_pacers_jogadores OWNER TO admin;

--
-- Name: indiana_pacers_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.indiana_pacers_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.indiana_pacers_jogadores_id_seq OWNER TO admin;

--
-- Name: indiana_pacers_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.indiana_pacers_jogadores_id_seq OWNED BY public.indiana_pacers_jogadores.id;


--
-- Name: indiana_pacers_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.indiana_pacers_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.indiana_pacers_lesoes OWNER TO admin;

--
-- Name: indiana_pacers_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.indiana_pacers_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.indiana_pacers_lesoes_id_seq OWNER TO admin;

--
-- Name: indiana_pacers_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.indiana_pacers_lesoes_id_seq OWNED BY public.indiana_pacers_lesoes.id;


--
-- Name: links; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.links (
    id integer NOT NULL,
    team_name character varying(255) NOT NULL,
    link character varying(255) NOT NULL,
    event_time character varying(50) NOT NULL
);


-- ALTER TABLE public.links OWNER TO admin;

--
-- Name: links_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.links_id_seq OWNER TO admin;

--
-- Name: links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.links_id_seq OWNED BY public.links.id;


--
-- Name: los_angeles_clippers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.los_angeles_clippers (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.los_angeles_clippers OWNER TO admin;

--
-- Name: los_angeles_clippers_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.los_angeles_clippers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.los_angeles_clippers_id_seq OWNER TO admin;

--
-- Name: los_angeles_clippers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.los_angeles_clippers_id_seq OWNED BY public.los_angeles_clippers.id;


--
-- Name: los_angeles_clippers_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.los_angeles_clippers_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.los_angeles_clippers_jogadores OWNER TO admin;

--
-- Name: los_angeles_clippers_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.los_angeles_clippers_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.los_angeles_clippers_jogadores_id_seq OWNER TO admin;

--
-- Name: los_angeles_clippers_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.los_angeles_clippers_jogadores_id_seq OWNED BY public.los_angeles_clippers_jogadores.id;


--
-- Name: los_angeles_clippers_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.los_angeles_clippers_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.los_angeles_clippers_lesoes OWNER TO admin;

--
-- Name: los_angeles_clippers_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.los_angeles_clippers_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.los_angeles_clippers_lesoes_id_seq OWNER TO admin;

--
-- Name: los_angeles_clippers_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.los_angeles_clippers_lesoes_id_seq OWNED BY public.los_angeles_clippers_lesoes.id;


--
-- Name: los_angeles_lakers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.los_angeles_lakers (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.los_angeles_lakers OWNER TO admin;

--
-- Name: los_angeles_lakers_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.los_angeles_lakers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.los_angeles_lakers_id_seq OWNER TO admin;

--
-- Name: los_angeles_lakers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.los_angeles_lakers_id_seq OWNED BY public.los_angeles_lakers.id;


--
-- Name: los_angeles_lakers_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.los_angeles_lakers_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.los_angeles_lakers_jogadores OWNER TO admin;

--
-- Name: los_angeles_lakers_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.los_angeles_lakers_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.los_angeles_lakers_jogadores_id_seq OWNER TO admin;

--
-- Name: los_angeles_lakers_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.los_angeles_lakers_jogadores_id_seq OWNED BY public.los_angeles_lakers_jogadores.id;


--
-- Name: los_angeles_lakers_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.los_angeles_lakers_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.los_angeles_lakers_lesoes OWNER TO admin;

--
-- Name: los_angeles_lakers_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.los_angeles_lakers_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.los_angeles_lakers_lesoes_id_seq OWNER TO admin;

--
-- Name: los_angeles_lakers_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.los_angeles_lakers_lesoes_id_seq OWNED BY public.los_angeles_lakers_lesoes.id;


--
-- Name: memphis_grizzlies; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.memphis_grizzlies (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.memphis_grizzlies OWNER TO admin;

--
-- Name: memphis_grizzlies_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.memphis_grizzlies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.memphis_grizzlies_id_seq OWNER TO admin;

--
-- Name: memphis_grizzlies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.memphis_grizzlies_id_seq OWNED BY public.memphis_grizzlies.id;


--
-- Name: memphis_grizzlies_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.memphis_grizzlies_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.memphis_grizzlies_jogadores OWNER TO admin;

--
-- Name: memphis_grizzlies_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.memphis_grizzlies_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.memphis_grizzlies_jogadores_id_seq OWNER TO admin;

--
-- Name: memphis_grizzlies_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.memphis_grizzlies_jogadores_id_seq OWNED BY public.memphis_grizzlies_jogadores.id;


--
-- Name: memphis_grizzlies_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.memphis_grizzlies_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.memphis_grizzlies_lesoes OWNER TO admin;

--
-- Name: memphis_grizzlies_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.memphis_grizzlies_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.memphis_grizzlies_lesoes_id_seq OWNER TO admin;

--
-- Name: memphis_grizzlies_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.memphis_grizzlies_lesoes_id_seq OWNED BY public.memphis_grizzlies_lesoes.id;


--
-- Name: miami_heat; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.miami_heat (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.miami_heat OWNER TO admin;

--
-- Name: miami_heat_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.miami_heat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.miami_heat_id_seq OWNER TO admin;

--
-- Name: miami_heat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.miami_heat_id_seq OWNED BY public.miami_heat.id;


--
-- Name: miami_heat_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.miami_heat_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.miami_heat_jogadores OWNER TO admin;

--
-- Name: miami_heat_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.miami_heat_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.miami_heat_jogadores_id_seq OWNER TO admin;

--
-- Name: miami_heat_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.miami_heat_jogadores_id_seq OWNED BY public.miami_heat_jogadores.id;


--
-- Name: miami_heat_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.miami_heat_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.miami_heat_lesoes OWNER TO admin;

--
-- Name: miami_heat_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.miami_heat_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.miami_heat_lesoes_id_seq OWNER TO admin;

--
-- Name: miami_heat_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.miami_heat_lesoes_id_seq OWNED BY public.miami_heat_lesoes.id;


--
-- Name: milwaukee_bucks; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.milwaukee_bucks (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.milwaukee_bucks OWNER TO admin;

--
-- Name: milwaukee_bucks_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.milwaukee_bucks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.milwaukee_bucks_id_seq OWNER TO admin;

--
-- Name: milwaukee_bucks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.milwaukee_bucks_id_seq OWNED BY public.milwaukee_bucks.id;


--
-- Name: milwaukee_bucks_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.milwaukee_bucks_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.milwaukee_bucks_jogadores OWNER TO admin;

--
-- Name: milwaukee_bucks_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.milwaukee_bucks_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.milwaukee_bucks_jogadores_id_seq OWNER TO admin;

--
-- Name: milwaukee_bucks_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.milwaukee_bucks_jogadores_id_seq OWNED BY public.milwaukee_bucks_jogadores.id;


--
-- Name: milwaukee_bucks_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.milwaukee_bucks_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.milwaukee_bucks_lesoes OWNER TO admin;

--
-- Name: milwaukee_bucks_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.milwaukee_bucks_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.milwaukee_bucks_lesoes_id_seq OWNER TO admin;

--
-- Name: milwaukee_bucks_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.milwaukee_bucks_lesoes_id_seq OWNED BY public.milwaukee_bucks_lesoes.id;


--
-- Name: minnesota_timberwolves; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.minnesota_timberwolves (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.minnesota_timberwolves OWNER TO admin;

--
-- Name: minnesota_timberwolves_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.minnesota_timberwolves_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.minnesota_timberwolves_id_seq OWNER TO admin;

--
-- Name: minnesota_timberwolves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.minnesota_timberwolves_id_seq OWNED BY public.minnesota_timberwolves.id;


--
-- Name: minnesota_timberwolves_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.minnesota_timberwolves_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.minnesota_timberwolves_jogadores OWNER TO admin;

--
-- Name: minnesota_timberwolves_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.minnesota_timberwolves_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.minnesota_timberwolves_jogadores_id_seq OWNER TO admin;

--
-- Name: minnesota_timberwolves_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.minnesota_timberwolves_jogadores_id_seq OWNED BY public.minnesota_timberwolves_jogadores.id;


--
-- Name: minnesota_timberwolves_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.minnesota_timberwolves_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.minnesota_timberwolves_lesoes OWNER TO admin;

--
-- Name: minnesota_timberwolves_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.minnesota_timberwolves_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.minnesota_timberwolves_lesoes_id_seq OWNER TO admin;

--
-- Name: minnesota_timberwolves_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.minnesota_timberwolves_lesoes_id_seq OWNED BY public.minnesota_timberwolves_lesoes.id;


--
-- Name: nba_classificacao; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.nba_classificacao (
    id integer NOT NULL,
    rank integer NOT NULL,
    team_name character varying(255) NOT NULL
);


-- ALTER TABLE public.nba_classificacao OWNER TO admin;

--
-- Name: nba_classificacao_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.nba_classificacao_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.nba_classificacao_id_seq OWNER TO admin;

--
-- Name: nba_classificacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.nba_classificacao_id_seq OWNED BY public.nba_classificacao.id;


--
-- Name: new_orleans_pelicans; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.new_orleans_pelicans (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.new_orleans_pelicans OWNER TO admin;

--
-- Name: new_orleans_pelicans_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.new_orleans_pelicans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.new_orleans_pelicans_id_seq OWNER TO admin;

--
-- Name: new_orleans_pelicans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.new_orleans_pelicans_id_seq OWNED BY public.new_orleans_pelicans.id;


--
-- Name: new_orleans_pelicans_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.new_orleans_pelicans_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.new_orleans_pelicans_jogadores OWNER TO admin;

--
-- Name: new_orleans_pelicans_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.new_orleans_pelicans_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.new_orleans_pelicans_jogadores_id_seq OWNER TO admin;

--
-- Name: new_orleans_pelicans_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.new_orleans_pelicans_jogadores_id_seq OWNED BY public.new_orleans_pelicans_jogadores.id;


--
-- Name: new_orleans_pelicans_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.new_orleans_pelicans_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.new_orleans_pelicans_lesoes OWNER TO admin;

--
-- Name: new_orleans_pelicans_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.new_orleans_pelicans_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.new_orleans_pelicans_lesoes_id_seq OWNER TO admin;

--
-- Name: new_orleans_pelicans_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.new_orleans_pelicans_lesoes_id_seq OWNED BY public.new_orleans_pelicans_lesoes.id;


--
-- Name: new_york_knicks; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.new_york_knicks (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.new_york_knicks OWNER TO admin;

--
-- Name: new_york_knicks_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.new_york_knicks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.new_york_knicks_id_seq OWNER TO admin;

--
-- Name: new_york_knicks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.new_york_knicks_id_seq OWNED BY public.new_york_knicks.id;


--
-- Name: new_york_knicks_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.new_york_knicks_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.new_york_knicks_jogadores OWNER TO admin;

--
-- Name: new_york_knicks_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.new_york_knicks_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.new_york_knicks_jogadores_id_seq OWNER TO admin;

--
-- Name: new_york_knicks_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.new_york_knicks_jogadores_id_seq OWNED BY public.new_york_knicks_jogadores.id;


--
-- Name: new_york_knicks_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.new_york_knicks_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.new_york_knicks_lesoes OWNER TO admin;

--
-- Name: new_york_knicks_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.new_york_knicks_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.new_york_knicks_lesoes_id_seq OWNER TO admin;

--
-- Name: new_york_knicks_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.new_york_knicks_lesoes_id_seq OWNED BY public.new_york_knicks_lesoes.id;


--
-- Name: odds; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.odds (
    id integer NOT NULL,
    data_jogo timestamp without time zone NOT NULL,
    time_home character varying(255) NOT NULL,
    time_away character varying(255) NOT NULL,
    home_odds numeric NOT NULL,
    away_odds numeric NOT NULL,
    over_dois_meio numeric,
    over_odds numeric
);


-- ALTER TABLE public.odds OWNER TO admin;

--
-- Name: odds_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.odds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.odds_id_seq OWNER TO admin;

--
-- Name: odds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.odds_id_seq OWNED BY public.odds.id;


--
-- Name: oklahoma_city_thunder; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.oklahoma_city_thunder (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.oklahoma_city_thunder OWNER TO admin;

--
-- Name: oklahoma_city_thunder_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.oklahoma_city_thunder_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.oklahoma_city_thunder_id_seq OWNER TO admin;

--
-- Name: oklahoma_city_thunder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.oklahoma_city_thunder_id_seq OWNED BY public.oklahoma_city_thunder.id;


--
-- Name: oklahoma_city_thunder_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.oklahoma_city_thunder_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.oklahoma_city_thunder_jogadores OWNER TO admin;

--
-- Name: oklahoma_city_thunder_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.oklahoma_city_thunder_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.oklahoma_city_thunder_jogadores_id_seq OWNER TO admin;

--
-- Name: oklahoma_city_thunder_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.oklahoma_city_thunder_jogadores_id_seq OWNED BY public.oklahoma_city_thunder_jogadores.id;


--
-- Name: oklahoma_city_thunder_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.oklahoma_city_thunder_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.oklahoma_city_thunder_lesoes OWNER TO admin;

--
-- Name: oklahoma_city_thunder_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.oklahoma_city_thunder_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.oklahoma_city_thunder_lesoes_id_seq OWNER TO admin;

--
-- Name: oklahoma_city_thunder_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.oklahoma_city_thunder_lesoes_id_seq OWNED BY public.oklahoma_city_thunder_lesoes.id;


--
-- Name: orlando_magic; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.orlando_magic (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.orlando_magic OWNER TO admin;

--
-- Name: orlando_magic_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.orlando_magic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.orlando_magic_id_seq OWNER TO admin;

--
-- Name: orlando_magic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.orlando_magic_id_seq OWNED BY public.orlando_magic.id;


--
-- Name: orlando_magic_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.orlando_magic_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.orlando_magic_jogadores OWNER TO admin;

--
-- Name: orlando_magic_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.orlando_magic_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.orlando_magic_jogadores_id_seq OWNER TO admin;

--
-- Name: orlando_magic_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.orlando_magic_jogadores_id_seq OWNED BY public.orlando_magic_jogadores.id;


--
-- Name: orlando_magic_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.orlando_magic_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.orlando_magic_lesoes OWNER TO admin;

--
-- Name: orlando_magic_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.orlando_magic_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.orlando_magic_lesoes_id_seq OWNER TO admin;

--
-- Name: orlando_magic_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.orlando_magic_lesoes_id_seq OWNED BY public.orlando_magic_lesoes.id;


--
-- Name: philadelphia_76ers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.philadelphia_76ers (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.philadelphia_76ers OWNER TO admin;

--
-- Name: philadelphia_76ers_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.philadelphia_76ers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.philadelphia_76ers_id_seq OWNER TO admin;

--
-- Name: philadelphia_76ers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.philadelphia_76ers_id_seq OWNED BY public.philadelphia_76ers.id;


--
-- Name: philadelphia_76ers_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.philadelphia_76ers_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.philadelphia_76ers_jogadores OWNER TO admin;

--
-- Name: philadelphia_76ers_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.philadelphia_76ers_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.philadelphia_76ers_jogadores_id_seq OWNER TO admin;

--
-- Name: philadelphia_76ers_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.philadelphia_76ers_jogadores_id_seq OWNED BY public.philadelphia_76ers_jogadores.id;


--
-- Name: philadelphia_76ers_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.philadelphia_76ers_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.philadelphia_76ers_lesoes OWNER TO admin;

--
-- Name: philadelphia_76ers_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.philadelphia_76ers_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.philadelphia_76ers_lesoes_id_seq OWNER TO admin;

--
-- Name: philadelphia_76ers_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.philadelphia_76ers_lesoes_id_seq OWNED BY public.philadelphia_76ers_lesoes.id;


--
-- Name: phoenix_suns; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.phoenix_suns (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.phoenix_suns OWNER TO admin;

--
-- Name: phoenix_suns_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.phoenix_suns_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.phoenix_suns_id_seq OWNER TO admin;

--
-- Name: phoenix_suns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.phoenix_suns_id_seq OWNED BY public.phoenix_suns.id;


--
-- Name: phoenix_suns_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.phoenix_suns_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.phoenix_suns_jogadores OWNER TO admin;

--
-- Name: phoenix_suns_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.phoenix_suns_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.phoenix_suns_jogadores_id_seq OWNER TO admin;

--
-- Name: phoenix_suns_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.phoenix_suns_jogadores_id_seq OWNED BY public.phoenix_suns_jogadores.id;


--
-- Name: phoenix_suns_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.phoenix_suns_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.phoenix_suns_lesoes OWNER TO admin;

--
-- Name: phoenix_suns_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.phoenix_suns_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.phoenix_suns_lesoes_id_seq OWNER TO admin;

--
-- Name: phoenix_suns_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.phoenix_suns_lesoes_id_seq OWNED BY public.phoenix_suns_lesoes.id;


--
-- Name: portland_trail_blazers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.portland_trail_blazers (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.portland_trail_blazers OWNER TO admin;

--
-- Name: portland_trail_blazers_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.portland_trail_blazers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.portland_trail_blazers_id_seq OWNER TO admin;

--
-- Name: portland_trail_blazers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.portland_trail_blazers_id_seq OWNED BY public.portland_trail_blazers.id;


--
-- Name: portland_trail_blazers_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.portland_trail_blazers_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.portland_trail_blazers_jogadores OWNER TO admin;

--
-- Name: portland_trail_blazers_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.portland_trail_blazers_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.portland_trail_blazers_jogadores_id_seq OWNER TO admin;

--
-- Name: portland_trail_blazers_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.portland_trail_blazers_jogadores_id_seq OWNED BY public.portland_trail_blazers_jogadores.id;


--
-- Name: portland_trail_blazers_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.portland_trail_blazers_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.portland_trail_blazers_lesoes OWNER TO admin;

--
-- Name: portland_trail_blazers_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.portland_trail_blazers_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.portland_trail_blazers_lesoes_id_seq OWNER TO admin;

--
-- Name: portland_trail_blazers_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.portland_trail_blazers_lesoes_id_seq OWNED BY public.portland_trail_blazers_lesoes.id;


--
-- Name: sacramento_kings; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.sacramento_kings (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.sacramento_kings OWNER TO admin;

--
-- Name: sacramento_kings_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.sacramento_kings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.sacramento_kings_id_seq OWNER TO admin;

--
-- Name: sacramento_kings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.sacramento_kings_id_seq OWNED BY public.sacramento_kings.id;


--
-- Name: sacramento_kings_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.sacramento_kings_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.sacramento_kings_jogadores OWNER TO admin;

--
-- Name: sacramento_kings_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.sacramento_kings_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.sacramento_kings_jogadores_id_seq OWNER TO admin;

--
-- Name: sacramento_kings_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.sacramento_kings_jogadores_id_seq OWNED BY public.sacramento_kings_jogadores.id;


--
-- Name: sacramento_kings_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.sacramento_kings_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.sacramento_kings_lesoes OWNER TO admin;

--
-- Name: sacramento_kings_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.sacramento_kings_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.sacramento_kings_lesoes_id_seq OWNER TO admin;

--
-- Name: sacramento_kings_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.sacramento_kings_lesoes_id_seq OWNED BY public.sacramento_kings_lesoes.id;


--
-- Name: san_antonio_spurs; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.san_antonio_spurs (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.san_antonio_spurs OWNER TO admin;

--
-- Name: san_antonio_spurs_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.san_antonio_spurs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.san_antonio_spurs_id_seq OWNER TO admin;

--
-- Name: san_antonio_spurs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.san_antonio_spurs_id_seq OWNED BY public.san_antonio_spurs.id;


--
-- Name: san_antonio_spurs_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.san_antonio_spurs_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.san_antonio_spurs_jogadores OWNER TO admin;

--
-- Name: san_antonio_spurs_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.san_antonio_spurs_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.san_antonio_spurs_jogadores_id_seq OWNER TO admin;

--
-- Name: san_antonio_spurs_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.san_antonio_spurs_jogadores_id_seq OWNED BY public.san_antonio_spurs_jogadores.id;


--
-- Name: san_antonio_spurs_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.san_antonio_spurs_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.san_antonio_spurs_lesoes OWNER TO admin;

--
-- Name: san_antonio_spurs_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.san_antonio_spurs_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.san_antonio_spurs_lesoes_id_seq OWNER TO admin;

--
-- Name: san_antonio_spurs_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.san_antonio_spurs_lesoes_id_seq OWNED BY public.san_antonio_spurs_lesoes.id;


--
-- Name: toronto_raptors; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.toronto_raptors (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.toronto_raptors OWNER TO admin;

--
-- Name: toronto_raptors_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.toronto_raptors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.toronto_raptors_id_seq OWNER TO admin;

--
-- Name: toronto_raptors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.toronto_raptors_id_seq OWNED BY public.toronto_raptors.id;


--
-- Name: toronto_raptors_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.toronto_raptors_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.toronto_raptors_jogadores OWNER TO admin;

--
-- Name: toronto_raptors_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.toronto_raptors_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.toronto_raptors_jogadores_id_seq OWNER TO admin;

--
-- Name: toronto_raptors_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.toronto_raptors_jogadores_id_seq OWNED BY public.toronto_raptors_jogadores.id;


--
-- Name: toronto_raptors_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.toronto_raptors_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.toronto_raptors_lesoes OWNER TO admin;

--
-- Name: toronto_raptors_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.toronto_raptors_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.toronto_raptors_lesoes_id_seq OWNER TO admin;

--
-- Name: toronto_raptors_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.toronto_raptors_lesoes_id_seq OWNED BY public.toronto_raptors_lesoes.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL
);


-- ALTER TABLE public.users OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.users_id_seq OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: utah_jazz; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.utah_jazz (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.utah_jazz OWNER TO admin;

--
-- Name: utah_jazz_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.utah_jazz_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.utah_jazz_id_seq OWNER TO admin;

--
-- Name: utah_jazz_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.utah_jazz_id_seq OWNED BY public.utah_jazz.id;


--
-- Name: utah_jazz_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.utah_jazz_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.utah_jazz_jogadores OWNER TO admin;

--
-- Name: utah_jazz_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.utah_jazz_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.utah_jazz_jogadores_id_seq OWNER TO admin;

--
-- Name: utah_jazz_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.utah_jazz_jogadores_id_seq OWNED BY public.utah_jazz_jogadores.id;


--
-- Name: utah_jazz_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.utah_jazz_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.utah_jazz_lesoes OWNER TO admin;

--
-- Name: utah_jazz_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.utah_jazz_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.utah_jazz_lesoes_id_seq OWNER TO admin;

--
-- Name: utah_jazz_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.utah_jazz_lesoes_id_seq OWNED BY public.utah_jazz_lesoes.id;


--
-- Name: washington_wizards; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.washington_wizards (
    id integer NOT NULL,
    datahora character varying(50) NOT NULL,
    home_team character varying(255) NOT NULL,
    home_score character varying(10),
    away_team character varying(255) NOT NULL,
    away_score character varying(10),
    home_team_q1 character varying(10),
    home_team_q2 character varying(10),
    home_team_q3 character varying(10),
    home_team_q4 character varying(10),
    away_team_q1 character varying(10),
    away_team_q2 character varying(10),
    away_team_q3 character varying(10),
    away_team_q4 character varying(10)
);


-- ALTER TABLE public.washington_wizards OWNER TO admin;

--
-- Name: washington_wizards_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.washington_wizards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.washington_wizards_id_seq OWNER TO admin;

--
-- Name: washington_wizards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.washington_wizards_id_seq OWNED BY public.washington_wizards.id;


--
-- Name: washington_wizards_jogadores; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.washington_wizards_jogadores (
    data_hora character varying(50) NOT NULL,
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    team character varying(255),
    points integer,
    total_rebounds integer,
    assists integer,
    minutes_played integer,
    field_goals_made integer,
    field_goals_attempted integer,
    two_point_made integer,
    two_point_attempted integer,
    three_point_made integer,
    three_point_attempted integer,
    free_throws_made integer,
    free_throws_attempted integer,
    plus_minus integer,
    offensive_rebounds integer,
    defensive_rebounds integer,
    personal_fouls integer,
    steals integer,
    turnovers integer,
    shots_blocked integer,
    blocks_against integer,
    technical_fouls integer
);


-- ALTER TABLE public.washington_wizards_jogadores OWNER TO admin;

--
-- Name: washington_wizards_jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.washington_wizards_jogadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.washington_wizards_jogadores_id_seq OWNER TO admin;

--
-- Name: washington_wizards_jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.washington_wizards_jogadores_id_seq OWNED BY public.washington_wizards_jogadores.id;


--
-- Name: washington_wizards_lesoes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.washington_wizards_lesoes (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    injury_status character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


-- ALTER TABLE public.washington_wizards_lesoes OWNER TO admin;

--
-- Name: washington_wizards_lesoes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.washington_wizards_lesoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.washington_wizards_lesoes_id_seq OWNER TO admin;

--
-- Name: washington_wizards_lesoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

-- ALTER SEQUENCE public.washington_wizards_lesoes_id_seq OWNED BY public.washington_wizards_lesoes.id;


--
-- Name: atlanta_hawks id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.atlanta_hawks ALTER COLUMN id SET DEFAULT nextval('public.atlanta_hawks_id_seq'::regclass);


--
-- Name: atlanta_hawks_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.atlanta_hawks_jogadores ALTER COLUMN id SET DEFAULT nextval('public.atlanta_hawks_jogadores_id_seq'::regclass);


--
-- Name: atlanta_hawks_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.atlanta_hawks_lesoes ALTER COLUMN id SET DEFAULT nextval('public.atlanta_hawks_lesoes_id_seq'::regclass);


--
-- Name: bankrolls id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.bankrolls ALTER COLUMN id SET DEFAULT nextval('public.bankrolls_id_seq'::regclass);


--
-- Name: bets id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.bets ALTER COLUMN id SET DEFAULT nextval('public.bets_id_seq'::regclass);


--
-- Name: betting_plans id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.betting_plans ALTER COLUMN id SET DEFAULT nextval('public.betting_plans_id_seq'::regclass);


--
-- Name: boston_celtics id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.boston_celtics ALTER COLUMN id SET DEFAULT nextval('public.boston_celtics_id_seq'::regclass);


--
-- Name: boston_celtics_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.boston_celtics_jogadores ALTER COLUMN id SET DEFAULT nextval('public.boston_celtics_jogadores_id_seq'::regclass);


--
-- Name: boston_celtics_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.boston_celtics_lesoes ALTER COLUMN id SET DEFAULT nextval('public.boston_celtics_lesoes_id_seq'::regclass);


--
-- Name: brooklyn_nets id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.brooklyn_nets ALTER COLUMN id SET DEFAULT nextval('public.brooklyn_nets_id_seq'::regclass);


--
-- Name: brooklyn_nets_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.brooklyn_nets_jogadores ALTER COLUMN id SET DEFAULT nextval('public.brooklyn_nets_jogadores_id_seq'::regclass);


--
-- Name: brooklyn_nets_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.brooklyn_nets_lesoes ALTER COLUMN id SET DEFAULT nextval('public.brooklyn_nets_lesoes_id_seq'::regclass);


--
-- Name: charlotte_hornets id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.charlotte_hornets ALTER COLUMN id SET DEFAULT nextval('public.charlotte_hornets_id_seq'::regclass);


--
-- Name: charlotte_hornets_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.charlotte_hornets_jogadores ALTER COLUMN id SET DEFAULT nextval('public.charlotte_hornets_jogadores_id_seq'::regclass);


--
-- Name: charlotte_hornets_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.charlotte_hornets_lesoes ALTER COLUMN id SET DEFAULT nextval('public.charlotte_hornets_lesoes_id_seq'::regclass);


--
-- Name: chicago_bulls id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.chicago_bulls ALTER COLUMN id SET DEFAULT nextval('public.chicago_bulls_id_seq'::regclass);


--
-- Name: chicago_bulls_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.chicago_bulls_jogadores ALTER COLUMN id SET DEFAULT nextval('public.chicago_bulls_jogadores_id_seq'::regclass);


--
-- Name: chicago_bulls_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.chicago_bulls_lesoes ALTER COLUMN id SET DEFAULT nextval('public.chicago_bulls_lesoes_id_seq'::regclass);


--
-- Name: cleveland_cavaliers id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.cleveland_cavaliers ALTER COLUMN id SET DEFAULT nextval('public.cleveland_cavaliers_id_seq'::regclass);


--
-- Name: cleveland_cavaliers_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.cleveland_cavaliers_jogadores ALTER COLUMN id SET DEFAULT nextval('public.cleveland_cavaliers_jogadores_id_seq'::regclass);


--
-- Name: cleveland_cavaliers_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.cleveland_cavaliers_lesoes ALTER COLUMN id SET DEFAULT nextval('public.cleveland_cavaliers_lesoes_id_seq'::regclass);


--
-- Name: dallas_mavericks id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.dallas_mavericks ALTER COLUMN id SET DEFAULT nextval('public.dallas_mavericks_id_seq'::regclass);


--
-- Name: dallas_mavericks_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.dallas_mavericks_jogadores ALTER COLUMN id SET DEFAULT nextval('public.dallas_mavericks_jogadores_id_seq'::regclass);


--
-- Name: dallas_mavericks_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.dallas_mavericks_lesoes ALTER COLUMN id SET DEFAULT nextval('public.dallas_mavericks_lesoes_id_seq'::regclass);


--
-- Name: denver_nuggets id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.denver_nuggets ALTER COLUMN id SET DEFAULT nextval('public.denver_nuggets_id_seq'::regclass);


--
-- Name: denver_nuggets_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.denver_nuggets_jogadores ALTER COLUMN id SET DEFAULT nextval('public.denver_nuggets_jogadores_id_seq'::regclass);


--
-- Name: denver_nuggets_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.denver_nuggets_lesoes ALTER COLUMN id SET DEFAULT nextval('public.denver_nuggets_lesoes_id_seq'::regclass);


--
-- Name: detroit_pistons id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.detroit_pistons ALTER COLUMN id SET DEFAULT nextval('public.detroit_pistons_id_seq'::regclass);


--
-- Name: detroit_pistons_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.detroit_pistons_jogadores ALTER COLUMN id SET DEFAULT nextval('public.detroit_pistons_jogadores_id_seq'::regclass);


--
-- Name: detroit_pistons_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.detroit_pistons_lesoes ALTER COLUMN id SET DEFAULT nextval('public.detroit_pistons_lesoes_id_seq'::regclass);


--
-- Name: golden_state_warriors id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.golden_state_warriors ALTER COLUMN id SET DEFAULT nextval('public.golden_state_warriors_id_seq'::regclass);


--
-- Name: golden_state_warriors_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.golden_state_warriors_jogadores ALTER COLUMN id SET DEFAULT nextval('public.golden_state_warriors_jogadores_id_seq'::regclass);


--
-- Name: golden_state_warriors_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.golden_state_warriors_lesoes ALTER COLUMN id SET DEFAULT nextval('public.golden_state_warriors_lesoes_id_seq'::regclass);


--
-- Name: houston_rockets id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.houston_rockets ALTER COLUMN id SET DEFAULT nextval('public.houston_rockets_id_seq'::regclass);


--
-- Name: houston_rockets_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.houston_rockets_jogadores ALTER COLUMN id SET DEFAULT nextval('public.houston_rockets_jogadores_id_seq'::regclass);


--
-- Name: houston_rockets_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.houston_rockets_lesoes ALTER COLUMN id SET DEFAULT nextval('public.houston_rockets_lesoes_id_seq'::regclass);


--
-- Name: indiana_pacers id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.indiana_pacers ALTER COLUMN id SET DEFAULT nextval('public.indiana_pacers_id_seq'::regclass);


--
-- Name: indiana_pacers_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.indiana_pacers_jogadores ALTER COLUMN id SET DEFAULT nextval('public.indiana_pacers_jogadores_id_seq'::regclass);


--
-- Name: indiana_pacers_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.indiana_pacers_lesoes ALTER COLUMN id SET DEFAULT nextval('public.indiana_pacers_lesoes_id_seq'::regclass);


--
-- Name: links id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.links ALTER COLUMN id SET DEFAULT nextval('public.links_id_seq'::regclass);


--
-- Name: los_angeles_clippers id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.los_angeles_clippers ALTER COLUMN id SET DEFAULT nextval('public.los_angeles_clippers_id_seq'::regclass);


--
-- Name: los_angeles_clippers_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.los_angeles_clippers_jogadores ALTER COLUMN id SET DEFAULT nextval('public.los_angeles_clippers_jogadores_id_seq'::regclass);


--
-- Name: los_angeles_clippers_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.los_angeles_clippers_lesoes ALTER COLUMN id SET DEFAULT nextval('public.los_angeles_clippers_lesoes_id_seq'::regclass);


--
-- Name: los_angeles_lakers id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.los_angeles_lakers ALTER COLUMN id SET DEFAULT nextval('public.los_angeles_lakers_id_seq'::regclass);


--
-- Name: los_angeles_lakers_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.los_angeles_lakers_jogadores ALTER COLUMN id SET DEFAULT nextval('public.los_angeles_lakers_jogadores_id_seq'::regclass);


--
-- Name: los_angeles_lakers_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.los_angeles_lakers_lesoes ALTER COLUMN id SET DEFAULT nextval('public.los_angeles_lakers_lesoes_id_seq'::regclass);


--
-- Name: memphis_grizzlies id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.memphis_grizzlies ALTER COLUMN id SET DEFAULT nextval('public.memphis_grizzlies_id_seq'::regclass);


--
-- Name: memphis_grizzlies_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.memphis_grizzlies_jogadores ALTER COLUMN id SET DEFAULT nextval('public.memphis_grizzlies_jogadores_id_seq'::regclass);


--
-- Name: memphis_grizzlies_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.memphis_grizzlies_lesoes ALTER COLUMN id SET DEFAULT nextval('public.memphis_grizzlies_lesoes_id_seq'::regclass);


--
-- Name: miami_heat id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.miami_heat ALTER COLUMN id SET DEFAULT nextval('public.miami_heat_id_seq'::regclass);


--
-- Name: miami_heat_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.miami_heat_jogadores ALTER COLUMN id SET DEFAULT nextval('public.miami_heat_jogadores_id_seq'::regclass);


--
-- Name: miami_heat_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.miami_heat_lesoes ALTER COLUMN id SET DEFAULT nextval('public.miami_heat_lesoes_id_seq'::regclass);


--
-- Name: milwaukee_bucks id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.milwaukee_bucks ALTER COLUMN id SET DEFAULT nextval('public.milwaukee_bucks_id_seq'::regclass);


--
-- Name: milwaukee_bucks_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.milwaukee_bucks_jogadores ALTER COLUMN id SET DEFAULT nextval('public.milwaukee_bucks_jogadores_id_seq'::regclass);


--
-- Name: milwaukee_bucks_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.milwaukee_bucks_lesoes ALTER COLUMN id SET DEFAULT nextval('public.milwaukee_bucks_lesoes_id_seq'::regclass);


--
-- Name: minnesota_timberwolves id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.minnesota_timberwolves ALTER COLUMN id SET DEFAULT nextval('public.minnesota_timberwolves_id_seq'::regclass);


--
-- Name: minnesota_timberwolves_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.minnesota_timberwolves_jogadores ALTER COLUMN id SET DEFAULT nextval('public.minnesota_timberwolves_jogadores_id_seq'::regclass);


--
-- Name: minnesota_timberwolves_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.minnesota_timberwolves_lesoes ALTER COLUMN id SET DEFAULT nextval('public.minnesota_timberwolves_lesoes_id_seq'::regclass);


--
-- Name: nba_classificacao id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.nba_classificacao ALTER COLUMN id SET DEFAULT nextval('public.nba_classificacao_id_seq'::regclass);


--
-- Name: new_orleans_pelicans id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.new_orleans_pelicans ALTER COLUMN id SET DEFAULT nextval('public.new_orleans_pelicans_id_seq'::regclass);


--
-- Name: new_orleans_pelicans_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.new_orleans_pelicans_jogadores ALTER COLUMN id SET DEFAULT nextval('public.new_orleans_pelicans_jogadores_id_seq'::regclass);


--
-- Name: new_orleans_pelicans_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.new_orleans_pelicans_lesoes ALTER COLUMN id SET DEFAULT nextval('public.new_orleans_pelicans_lesoes_id_seq'::regclass);


--
-- Name: new_york_knicks id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.new_york_knicks ALTER COLUMN id SET DEFAULT nextval('public.new_york_knicks_id_seq'::regclass);


--
-- Name: new_york_knicks_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.new_york_knicks_jogadores ALTER COLUMN id SET DEFAULT nextval('public.new_york_knicks_jogadores_id_seq'::regclass);


--
-- Name: new_york_knicks_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.new_york_knicks_lesoes ALTER COLUMN id SET DEFAULT nextval('public.new_york_knicks_lesoes_id_seq'::regclass);


--
-- Name: odds id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.odds ALTER COLUMN id SET DEFAULT nextval('public.odds_id_seq'::regclass);


--
-- Name: oklahoma_city_thunder id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.oklahoma_city_thunder ALTER COLUMN id SET DEFAULT nextval('public.oklahoma_city_thunder_id_seq'::regclass);


--
-- Name: oklahoma_city_thunder_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.oklahoma_city_thunder_jogadores ALTER COLUMN id SET DEFAULT nextval('public.oklahoma_city_thunder_jogadores_id_seq'::regclass);


--
-- Name: oklahoma_city_thunder_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.oklahoma_city_thunder_lesoes ALTER COLUMN id SET DEFAULT nextval('public.oklahoma_city_thunder_lesoes_id_seq'::regclass);


--
-- Name: orlando_magic id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.orlando_magic ALTER COLUMN id SET DEFAULT nextval('public.orlando_magic_id_seq'::regclass);


--
-- Name: orlando_magic_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.orlando_magic_jogadores ALTER COLUMN id SET DEFAULT nextval('public.orlando_magic_jogadores_id_seq'::regclass);


--
-- Name: orlando_magic_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.orlando_magic_lesoes ALTER COLUMN id SET DEFAULT nextval('public.orlando_magic_lesoes_id_seq'::regclass);


--
-- Name: philadelphia_76ers id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.philadelphia_76ers ALTER COLUMN id SET DEFAULT nextval('public.philadelphia_76ers_id_seq'::regclass);


--
-- Name: philadelphia_76ers_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.philadelphia_76ers_jogadores ALTER COLUMN id SET DEFAULT nextval('public.philadelphia_76ers_jogadores_id_seq'::regclass);


--
-- Name: philadelphia_76ers_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.philadelphia_76ers_lesoes ALTER COLUMN id SET DEFAULT nextval('public.philadelphia_76ers_lesoes_id_seq'::regclass);


--
-- Name: phoenix_suns id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.phoenix_suns ALTER COLUMN id SET DEFAULT nextval('public.phoenix_suns_id_seq'::regclass);


--
-- Name: phoenix_suns_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.phoenix_suns_jogadores ALTER COLUMN id SET DEFAULT nextval('public.phoenix_suns_jogadores_id_seq'::regclass);


--
-- Name: phoenix_suns_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.phoenix_suns_lesoes ALTER COLUMN id SET DEFAULT nextval('public.phoenix_suns_lesoes_id_seq'::regclass);


--
-- Name: portland_trail_blazers id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.portland_trail_blazers ALTER COLUMN id SET DEFAULT nextval('public.portland_trail_blazers_id_seq'::regclass);


--
-- Name: portland_trail_blazers_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.portland_trail_blazers_jogadores ALTER COLUMN id SET DEFAULT nextval('public.portland_trail_blazers_jogadores_id_seq'::regclass);


--
-- Name: portland_trail_blazers_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.portland_trail_blazers_lesoes ALTER COLUMN id SET DEFAULT nextval('public.portland_trail_blazers_lesoes_id_seq'::regclass);


--
-- Name: sacramento_kings id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.sacramento_kings ALTER COLUMN id SET DEFAULT nextval('public.sacramento_kings_id_seq'::regclass);


--
-- Name: sacramento_kings_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.sacramento_kings_jogadores ALTER COLUMN id SET DEFAULT nextval('public.sacramento_kings_jogadores_id_seq'::regclass);


--
-- Name: sacramento_kings_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.sacramento_kings_lesoes ALTER COLUMN id SET DEFAULT nextval('public.sacramento_kings_lesoes_id_seq'::regclass);


--
-- Name: san_antonio_spurs id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.san_antonio_spurs ALTER COLUMN id SET DEFAULT nextval('public.san_antonio_spurs_id_seq'::regclass);


--
-- Name: san_antonio_spurs_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.san_antonio_spurs_jogadores ALTER COLUMN id SET DEFAULT nextval('public.san_antonio_spurs_jogadores_id_seq'::regclass);


--
-- Name: san_antonio_spurs_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.san_antonio_spurs_lesoes ALTER COLUMN id SET DEFAULT nextval('public.san_antonio_spurs_lesoes_id_seq'::regclass);


--
-- Name: toronto_raptors id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.toronto_raptors ALTER COLUMN id SET DEFAULT nextval('public.toronto_raptors_id_seq'::regclass);


--
-- Name: toronto_raptors_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.toronto_raptors_jogadores ALTER COLUMN id SET DEFAULT nextval('public.toronto_raptors_jogadores_id_seq'::regclass);


--
-- Name: toronto_raptors_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.toronto_raptors_lesoes ALTER COLUMN id SET DEFAULT nextval('public.toronto_raptors_lesoes_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: utah_jazz id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.utah_jazz ALTER COLUMN id SET DEFAULT nextval('public.utah_jazz_id_seq'::regclass);


--
-- Name: utah_jazz_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.utah_jazz_jogadores ALTER COLUMN id SET DEFAULT nextval('public.utah_jazz_jogadores_id_seq'::regclass);


--
-- Name: utah_jazz_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.utah_jazz_lesoes ALTER COLUMN id SET DEFAULT nextval('public.utah_jazz_lesoes_id_seq'::regclass);


--
-- Name: washington_wizards id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.washington_wizards ALTER COLUMN id SET DEFAULT nextval('public.washington_wizards_id_seq'::regclass);


--
-- Name: washington_wizards_jogadores id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.washington_wizards_jogadores ALTER COLUMN id SET DEFAULT nextval('public.washington_wizards_jogadores_id_seq'::regclass);


--
-- Name: washington_wizards_lesoes id; Type: DEFAULT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.washington_wizards_lesoes ALTER COLUMN id SET DEFAULT nextval('public.washington_wizards_lesoes_id_seq'::regclass);


--
-- Data for Name: atlanta_hawks; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.atlanta_hawks (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	18.04.2024	Chicago Bulls	131	Atlanta Hawks	116	40	33	37	21	22	45	25	24
2	13.07.2024	Washington Wizards	94	Atlanta Hawks	88	14	26	26	28	23	19	23	23
3	15.07.2024	Atlanta Hawks	76	San Antonio Spurs	79	17	20	18	21	21	15	20	23
4	18.07.2024	Atlanta Hawks	86	Los Angeles Lakers	87	20	21	31	14	21	23	19	24
5	19.07.2024\nApós Prol.	Chicago Bulls	103	Atlanta Hawks	99	24	34	18	20	17	25	26	28
6	20.07.2024	Atlanta Hawks	82	New York Knicks	90	21	17	22	22	18	25	24	23
7	09.10.2024	Atlanta Hawks	131	Indiana Pacers	130	35	23	41	32	31	32	35	32
8	15.10.2024	Atlanta Hawks	89	Philadelphia 76ers	104	23	25	19	22	23	31	21	29
9	17.10.2024	Miami Heat	120	Atlanta Hawks	111	34	32	37	17	32	37	15	27
10	18.10.2024	Oklahoma City Thunder	104	Atlanta Hawks	99	27	22	28	27	28	23	28	20
11	24.10.2024	Atlanta Hawks	120	Brooklyn Nets	116	30	21	32	37	24	31	28	33
12	26.10.2024	Atlanta Hawks	125	Charlotte Hornets	120	28	34	26	37	16	42	27	35
13	27.10.2024	Oklahoma City Thunder	128	Atlanta Hawks	104	23	34	32	39	27	31	28	18
14	28.10.2024	Atlanta Hawks	119	Washington Wizards	121	28	33	22	36	25	29	30	37
15	30.10.2024	Washington Wizards	133	Atlanta Hawks	120	33	24	36	40	34	31	27	28
16	01.11.2024	Atlanta Hawks	115	Sacramento Kings	123	26	33	31	25	33	36	33	21
17	04.11.2024	New Orleans Pelicans	111	Atlanta Hawks	126	30	29	26	26	33	25	35	33
18	05.11.2024	Atlanta Hawks	93	Boston Celtics	123	30	23	22	18	35	40	28	20
19	07.11.2024	Atlanta Hawks	121	New York Knicks	116	26	39	24	32	22	39	28	27
20	09.11.2024	Detroit Pistons	122	Atlanta Hawks	121	40	26	29	27	23	30	32	36
21	10.11.2024	Atlanta Hawks	113	Chicago Bulls	125	37	33	28	15	24	36	30	35
22	13.11.2024	Boston Celtics	116	Atlanta Hawks	117	31	34	26	25	29	25	30	33
23	16.11.2024	Atlanta Hawks	129	Washington Wizards	117	29	30	35	35	39	11	25	42
24	17.11.2024	Portland Trail Blazers	114	Atlanta Hawks	110	21	35	38	20	33	31	17	29
25	19.11.2024	Sacramento Kings	108	Atlanta Hawks	109	31	35	27	15	32	32	25	20
26	21.11.2024	Golden State Warriors	120	Atlanta Hawks	97	41	26	23	30	22	20	33	22
27	23.11.2024	Chicago Bulls	136	Atlanta Hawks	122	28	30	41	37	25	26	33	38
28	26.11.2024	Atlanta Hawks	119	Dallas Mavericks	129	31	36	28	24	28	33	35	33
29	28.11.2024	Cleveland Cavaliers	124	Atlanta Hawks	135	35	29	31	29	35	26	37	37
30	29.11.2024	Atlanta Hawks	117	Cleveland Cavaliers	101	29	23	39	26	27	23	23	28
31	30.11.2024	Charlotte Hornets	104	Atlanta Hawks	107	32	18	26	28	29	26	22	30
32	03.12.2024	Atlanta Hawks	124	New Orleans Pelicans	112	26	32	34	32	28	31	26	27
33	05.12.2024	Milwaukee Bucks	104	Atlanta Hawks	119	35	24	28	17	38	32	29	20
34	07.12.2024\nApós Prol.	Atlanta Hawks	134	Los Angeles Lakers	132	26	38	30	25	29	35	33	22
35	08.12.2024	Atlanta Hawks	111	Denver Nuggets	141	23	25	36	27	38	33	35	35
36	12.12.2024	New York Knicks	100	Atlanta Hawks	108	28	26	18	28	22	25	34	27
37	14.12.2024	Milwaukee Bucks	110	Atlanta Hawks	102	26	29	27	28	28	21	34	19
38	20.12.2024\nApós Prol.	San Antonio Spurs	133	Atlanta Hawks	126	36	24	30	30	29	37	21	33
39	22.12.2024	Atlanta Hawks	112	Memphis Grizzlies	128	27	22	27	36	43	30	27	28
40	24.12.2024	Atlanta Hawks	117	Minnesota Timberwolves	104	35	17	30	35	19	36	30	19
41	27.12.2024	Atlanta Hawks	141	Chicago Bulls	133	21	32	38	50	33	31	44	25
42	28.12.2024	Atlanta Hawks	120	Miami Heat	110	35	26	32	27	28	30	26	26
43	29.12.2024	Toronto Raptors	107	Atlanta Hawks	136	25	33	24	25	35	29	40	32
44	02.01. 02:00	Denver Nuggets	139	Atlanta Hawks	120	40	34	41	24	33	38	24	25
45	04.01. 03:30	Los Angeles Lakers	119	Atlanta Hawks	102	31	34	31	23	28	29	29	16
46	05.01. 03:30	Los Angeles Clippers	131	Atlanta Hawks	105	29	45	24	33	28	26	22	29
47	08.01. 02:00	Utah Jazz	121	Atlanta Hawks	124	32	30	27	32	36	29	28	31
48	10.01. 02:00	Phoenix Suns	123	Atlanta Hawks	115	38	30	30	25	31	41	20	23
49	15.01. 00:30	Atlanta Hawks	122	Phoenix Suns	117	33	31	25	33	31	25	31	30
50	16.01. 01:00	Chicago Bulls	94	Atlanta Hawks	110	25	22	31	16	27	34	25	24
\.


--
-- Data for Name: atlanta_hawks_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.atlanta_hawks_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 01:00	1	Wallace K.	ATL	27	6	6	2306	10	18	0	0	4	7	3	3	29	1	5	3	4	1	0	0	0
16.01.2025 01:00	2	Plowden D.	ATL	19	4	0	1515	7	8	0	0	5	6	0	0	9	3	1	4	0	1	0	0	0
16.01.2025 01:00	3	Daniels D.	ATL	18	8	3	2023	7	16	0	0	1	4	3	7	9	5	3	1	3	2	1	0	0
16.01.2025 01:00	4	Okongwu O.	ATL	14	13	7	1617	5	9	0	0	1	1	3	5	8	3	10	2	1	2	1	0	0
16.01.2025 01:00	5	Capela C.	ATL	11	10	1	1263	5	11	0	0	0	0	1	2	8	1	9	2	0	0	1	0	0
16.01.2025 01:00	6	Krejci V.	ATL	11	3	6	1764	4	10	0	0	1	5	2	2	21	0	3	1	0	1	2	0	0
16.01.2025 01:00	7	Roddy D.	ATL	4	6	2	1412	2	11	0	0	0	5	0	0	7	1	5	0	3	1	0	0	0
16.01.2025 01:00	8	Bogdanovic B.	ATL	3	0	1	1196	1	10	0	0	1	9	0	0	-6	0	0	1	0	1	0	0	0
16.01.2025 01:00	9	Mathews G.	ATL	3	1	2	1304	0	7	0	0	0	6	3	3	-5	0	1	1	0	0	0	0	0
15.01.2025 00:30	10	Young T.	ATL	43	3	5	2287	13	31	0	0	6	12	11	14	10	2	1	2	3	6	0	0	0
15.01.2025 00:30	11	Okongwu O.	ATL	22	21	1	1690	9	14	0	0	0	0	4	5	12	10	11	0	1	1	0	0	0
15.01.2025 00:30	12	Mathews G.	ATL	19	3	1	1599	6	10	0	0	5	8	2	3	18	1	2	5	0	1	0	0	0
15.01.2025 00:30	13	Krejci V.	ATL	15	5	6	2074	6	9	0	0	3	6	0	0	-1	1	4	2	2	0	0	0	0
15.01.2025 00:30	14	Bogdanovic B.	ATL	9	0	3	1553	3	13	0	0	2	9	1	2	11	0	0	2	0	0	0	0	0
15.01.2025 00:30	15	Daniels D.	ATL	9	4	3	2019	4	11	0	0	1	3	0	0	-10	2	2	4	3	1	0	0	0
15.01.2025 00:30	16	Capela C.	ATL	3	8	0	1190	1	2	0	0	0	0	1	2	-7	0	8	1	1	0	1	0	0
15.01.2025 00:30	17	Risacher Z.	ATL	2	4	0	1039	1	5	0	0	0	2	0	0	-11	1	3	4	0	2	0	0	0
15.01.2025 00:30	18	Roddy D.	ATL	0	6	3	949	0	3	0	0	0	1	0	0	3	3	3	1	0	1	2	0	0
10.01.2025 02:00	19	Young T.	ATL	21	2	7	2030	6	15	0	0	1	4	8	9	-15	0	2	0	1	3	0	0	0
10.01.2025 02:00	20	Bogdanovic B.	ATL	17	2	3	1679	7	11	0	0	3	6	0	0	8	0	2	2	2	1	0	0	0
10.01.2025 02:00	21	Daniels D.	ATL	13	4	3	2184	6	12	0	0	1	2	0	0	-9	2	2	2	3	0	0	0	0
10.01.2025 02:00	22	Hunter D.	ATL	12	3	4	1622	3	9	0	0	2	7	4	4	-11	0	3	4	2	3	0	0	0
10.01.2025 02:00	23	Krejci V.	ATL	12	3	6	1583	4	8	0	0	3	5	1	1	-10	0	3	2	1	1	0	0	0
10.01.2025 02:00	24	Roddy D.	ATL	11	0	0	611	4	5	0	0	3	3	0	0	-2	0	0	2	0	0	0	0	0
10.01.2025 02:00	25	Capela C.	ATL	10	11	2	1554	4	11	0	0	0	0	2	2	-13	4	7	4	1	1	2	0	0
10.01.2025 02:00	26	Okongwu O.	ATL	8	5	6	1320	4	7	0	0	0	1	0	0	7	1	4	1	0	1	1	0	0
10.01.2025 02:00	27	Mathews G.	ATL	6	0	1	656	2	4	0	0	2	4	0	0	1	0	0	1	0	0	0	0	0
10.01.2025 02:00	28	Risacher Z.	ATL	5	2	0	1161	2	4	0	0	0	0	1	1	4	1	1	1	1	1	0	0	0
08.01.2025 02:00	29	Young T.	ATL	24	2	20	2194	6	16	0	0	3	10	9	10	4	0	2	1	0	2	1	0	0
08.01.2025 02:00	30	Capela C.	ATL	18	6	0	1515	9	11	0	0	0	0	0	0	-1	2	4	2	0	1	3	0	0
08.01.2025 02:00	31	Hunter D.	ATL	17	4	1	1646	5	11	0	0	4	7	3	5	-12	1	3	3	0	2	0	0	0
08.01.2025 02:00	32	Daniels D.	ATL	16	6	7	2111	7	12	0	0	2	4	0	0	2	1	5	4	2	1	2	0	0
08.01.2025 02:00	33	Risacher Z.	ATL	14	6	0	1433	6	14	0	0	2	4	0	0	8	3	3	2	0	0	0	0	0
08.01.2025 02:00	34	Krejci V.	ATL	13	4	0	1334	5	6	0	0	3	4	0	0	7	0	4	4	1	0	0	0	0
08.01.2025 02:00	35	Bogdanovic B.	ATL	11	1	3	1684	4	10	0	0	3	7	0	0	-3	1	0	3	0	3	0	0	0
08.01.2025 02:00	36	Mathews G.	ATL	9	6	1	1119	4	13	0	0	1	8	0	0	8	2	4	0	2	1	1	0	0
08.01.2025 02:00	37	Okongwu O.	ATL	2	9	3	1364	1	5	0	0	0	0	0	0	2	2	7	3	1	0	4	0	0
05.01.2025 03:30	38	Young T.	ATL	20	4	14	2030	7	16	0	0	4	9	2	3	-7	0	4	2	1	3	0	0	0
05.01.2025 03:30	39	Hunter D.	ATL	18	3	2	1705	6	16	0	0	4	11	2	2	-11	0	3	1	1	3	0	0	0
05.01.2025 03:30	40	Mathews G.	ATL	15	8	3	1536	4	10	0	0	4	10	3	3	-10	2	6	2	1	4	0	0	0
05.01.2025 03:30	41	Risacher Z.	ATL	13	5	3	1691	5	11	0	0	1	4	2	2	-11	1	4	2	1	2	0	0	0
05.01.2025 03:30	42	Daniels D.	ATL	11	3	1	1774	5	10	0	0	0	1	1	2	-25	1	2	1	3	2	1	0	0
05.01.2025 03:30	43	Krejci V.	ATL	9	2	2	1706	3	8	0	0	3	6	0	0	-26	0	2	2	1	4	0	0	0
05.01.2025 03:30	44	Roddy D.	ATL	9	3	2	1078	3	4	0	0	0	1	3	3	-14	1	2	1	2	0	1	0	0
05.01.2025 03:30	45	Capela C.	ATL	6	7	1	1111	3	5	0	0	0	0	0	2	-15	2	5	0	1	4	1	0	0
05.01.2025 03:30	46	Okongwu O.	ATL	4	8	2	1463	2	7	0	0	0	3	0	0	-7	1	7	1	0	0	1	0	0
05.01.2025 03:30	47	Barlow D.	ATL	0	0	0	306	0	1	0	0	0	1	0	0	-4	0	0	0	0	0	0	0	0
04.01.2025 03:30	48	Young T.	ATL	33	0	9	2157	10	22	0	0	3	9	10	12	-8	0	0	1	1	3	0	0	0
04.01.2025 03:30	49	Johnson J.	ATL	19	8	1	1979	8	13	0	0	1	3	2	2	-8	2	6	2	0	3	1	0	0
04.01.2025 03:30	50	Okongwu O.	ATL	14	11	2	1432	7	12	0	0	0	1	0	0	-7	7	4	4	0	0	1	0	0
04.01.2025 03:30	51	Daniels D.	ATL	13	3	4	1856	6	14	0	0	1	5	0	1	-19	0	3	1	5	0	0	0	0
04.01.2025 03:30	52	Capela C.	ATL	8	7	2	1347	4	8	0	0	0	0	0	0	-8	3	4	5	0	0	0	0	0
04.01.2025 03:30	53	Risacher Z.	ATL	7	3	0	1516	3	8	0	0	0	2	1	1	-8	0	3	3	1	1	0	0	0
04.01.2025 03:30	54	Bogdanovic B.	ATL	5	2	3	1383	2	6	0	0	1	4	0	0	-6	0	2	1	3	0	0	0	0
04.01.2025 03:30	55	Hunter D.	ATL	3	3	1	1632	1	12	0	0	0	6	1	2	-11	1	2	4	0	1	0	0	0
04.01.2025 03:30	56	Barlow D.	ATL	0	1	0	101	0	0	0	0	0	0	0	0	-2	0	1	0	0	0	0	0	0
04.01.2025 03:30	57	Mathews G.	ATL	0	0	0	896	0	4	0	0	0	4	0	0	-6	0	0	1	0	0	1	0	0
04.01.2025 03:30	58	Roddy D.	ATL	0	1	0	101	0	1	0	0	0	0	0	0	-2	0	1	0	0	0	0	0	0
02.01.2025 02:00	59	Young T.	ATL	30	4	9	1816	8	17	0	0	4	10	10	12	-25	0	4	1	2	4	0	0	0
02.01.2025 02:00	60	Hunter D.	ATL	20	4	3	1566	7	14	0	0	3	5	3	5	-10	2	2	0	3	2	0	0	0
02.01.2025 02:00	61	Krejci V.	ATL	14	6	5	1702	5	12	0	0	3	8	1	1	3	1	5	5	0	0	2	0	0
02.01.2025 02:00	62	Risacher Z.	ATL	13	3	2	1899	6	12	0	0	1	6	0	0	-17	3	0	1	0	1	1	0	0
02.01.2025 02:00	63	Roddy D.	ATL	10	1	2	1024	4	7	0	0	2	3	0	0	5	0	1	1	0	2	0	0	0
02.01.2025 02:00	64	Daniels D.	ATL	9	5	6	1800	4	17	0	0	1	7	0	0	-17	3	2	1	3	0	0	0	0
02.01.2025 02:00	65	Mathews G.	ATL	9	5	3	1713	4	8	0	0	1	4	0	1	-15	1	4	3	0	2	1	0	0
02.01.2025 02:00	66	Okongwu O.	ATL	9	7	2	1463	4	6	0	0	1	3	0	0	-9	1	6	3	1	0	1	0	0
02.01.2025 02:00	67	Capela C.	ATL	4	7	1	1175	2	4	0	0	0	0	0	2	-13	1	6	1	1	2	0	0	0
02.01.2025 02:00	68	Barlow D.	ATL	2	2	1	242	1	3	0	0	0	0	0	0	3	0	2	0	0	0	0	0	0
29.12.2024 23:00	69	Young T.	ATL	34	2	10	1944	10	21	0	0	7	13	7	7	39	0	2	2	1	5	2	0	0
29.12.2024 23:00	70	Hunter D.	ATL	22	3	2	1337	8	11	0	0	2	3	4	7	11	1	2	2	3	1	0	0	0
29.12.2024 23:00	71	Johnson J.	ATL	15	4	3	1984	6	14	0	0	1	5	2	4	37	0	4	3	6	3	1	0	0
29.12.2024 23:00	72	Okongwu O.	ATL	15	4	0	1086	6	8	0	0	0	1	3	5	15	2	2	2	2	0	1	0	0
29.12.2024 23:00	73	Risacher Z.	ATL	14	7	2	1603	5	8	0	0	2	3	2	2	19	5	2	3	2	2	1	0	0
29.12.2024 23:00	74	Capela C.	ATL	11	12	2	1595	4	6	0	0	0	0	3	4	15	4	8	4	2	0	0	0	0
29.12.2024 23:00	75	Mathews G.	ATL	11	2	6	1378	2	9	0	0	2	7	5	6	15	0	2	3	0	0	2	0	0
29.12.2024 23:00	76	Wallace K.	ATL	9	1	2	936	3	8	0	0	3	6	0	0	-10	0	1	0	2	1	0	0	0
29.12.2024 23:00	77	Krejci V.	ATL	5	4	3	1781	2	7	0	0	1	5	0	0	14	1	3	0	3	1	1	0	0
29.12.2024 23:00	78	Barlow D.	ATL	0	0	0	199	0	1	0	0	0	0	0	0	-1	0	0	0	0	0	0	0	0
29.12.2024 23:00	79	Roddy D.	ATL	0	1	0	557	0	2	0	0	0	2	0	0	-9	1	0	0	1	1	0	0	0
28.12.2024 20:00	80	Johnson J.	ATL	28	13	5	2119	13	20	0	0	2	3	0	1	18	4	9	4	0	0	2	0	0
28.12.2024 20:00	81	Hunter D.	ATL	26	5	2	1719	8	14	0	0	4	7	6	7	15	0	5	2	1	0	0	0	0
28.12.2024 20:00	82	Mathews G.	ATL	18	2	2	1632	5	8	0	0	4	7	4	5	16	0	2	3	1	1	0	0	0
28.12.2024 20:00	83	Young T.	ATL	11	1	15	2211	3	13	0	0	2	9	3	4	17	0	1	0	1	3	0	0	0
28.12.2024 20:00	84	Nance L.	ATL	10	10	1	1598	4	6	0	0	0	1	2	2	13	2	8	0	2	4	0	0	0
28.12.2024 20:00	85	Risacher Z.	ATL	9	4	1	1637	4	12	0	0	1	4	0	0	-12	2	2	1	0	1	0	0	0
28.12.2024 20:00	86	Krejci V.	ATL	7	3	5	1391	2	6	0	0	1	4	2	2	-5	1	2	3	0	1	0	0	0
28.12.2024 20:00	87	Capela C.	ATL	6	7	1	1282	3	3	0	0	0	0	0	1	-3	0	7	1	1	1	0	0	0
28.12.2024 20:00	88	Wallace K.	ATL	5	2	2	811	2	4	0	0	1	2	0	0	-9	0	2	2	1	0	0	0	0
27.12.2024 00:30	89	Johnson J.	ATL	30	15	4	2343	11	16	0	0	0	2	8	9	7	5	10	2	2	2	0	0	0
27.12.2024 00:30	90	Young T.	ATL	27	2	13	2324	8	17	0	0	4	11	7	7	20	1	1	2	2	2	0	0	0
27.12.2024 00:30	91	Hunter D.	ATL	25	6	1	1673	6	14	0	0	3	7	10	10	9	1	5	1	1	2	1	0	0
27.12.2024 00:30	92	Risacher Z.	ATL	16	5	3	1408	5	12	0	0	3	7	3	4	1	1	4	5	1	3	0	0	0
27.12.2024 00:30	93	Daniels D.	ATL	15	7	4	1994	6	9	0	0	3	5	0	0	17	1	6	0	1	1	0	0	0
27.12.2024 00:30	94	Nance L.	ATL	12	1	1	1375	5	9	0	0	2	4	0	0	-15	0	1	2	1	0	1	0	0
27.12.2024 00:30	95	Capela C.	ATL	8	4	2	1505	3	3	0	0	0	0	2	2	23	1	3	0	0	0	1	0	0
27.12.2024 00:30	96	Mathews G.	ATL	5	3	0	1116	1	7	0	0	1	7	2	2	-19	2	1	1	1	1	1	0	0
27.12.2024 00:30	97	Krejci V.	ATL	3	1	4	662	1	2	0	0	1	2	0	0	-3	0	1	0	0	1	1	0	0
24.12.2024 00:30	98	Young T.	ATL	29	2	7	1878	8	15	0	0	4	7	9	12	9	0	2	2	0	5	0	0	0
24.12.2024 00:30	99	Mathews G.	ATL	25	2	1	1557	7	8	0	0	7	8	4	5	6	0	2	2	2	1	1	0	0
24.12.2024 00:30	100	Hunter D.	ATL	19	4	2	1705	5	9	0	0	3	7	6	6	15	0	4	3	0	3	0	0	0
24.12.2024 00:30	101	Johnson J.	ATL	17	11	7	2100	8	14	0	0	0	3	1	1	5	2	9	2	2	1	0	0	0
24.12.2024 00:30	102	Daniels D.	ATL	10	4	4	2043	4	10	0	0	1	2	1	2	16	0	4	1	8	2	2	0	0
24.12.2024 00:30	103	Nance L.	ATL	6	4	2	1266	2	4	0	0	2	4	0	0	8	0	4	1	2	0	3	0	0
24.12.2024 00:30	104	Risacher Z.	ATL	5	0	1	1151	2	5	0	0	1	4	0	0	-1	0	0	1	0	3	0	0	0
24.12.2024 00:30	105	Capela C.	ATL	4	8	2	1530	2	6	0	0	0	0	0	0	7	4	4	2	1	3	0	0	0
24.12.2024 00:30	106	Krejci V.	ATL	2	3	1	1002	1	2	0	0	0	1	0	0	4	0	3	0	0	2	0	0	0
24.12.2024 00:30	107	Roddy D.	ATL	0	0	0	84	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
24.12.2024 00:30	108	Wallace K.	ATL	0	0	0	84	0	0	0	0	0	0	0	0	-2	0	0	0	0	1	0	0	0
22.12.2024 00:30	109	Hunter D.	ATL	26	2	0	1454	9	14	0	0	1	5	7	7	-22	0	2	1	0	1	0	0	0
22.12.2024 00:30	110	Daniels D.	ATL	15	3	6	1767	6	9	0	0	3	5	0	0	-19	1	2	0	6	5	1	0	0
22.12.2024 00:30	111	Johnson J.	ATL	13	11	8	1981	4	12	0	0	1	3	4	5	-16	1	10	0	2	3	0	0	1
22.12.2024 00:30	112	Risacher Z.	ATL	10	2	1	1325	3	7	0	0	1	3	3	4	-1	1	1	1	0	1	0	0	0
22.12.2024 00:30	113	Capela C.	ATL	8	8	0	1120	4	10	0	0	0	0	0	2	-4	2	6	0	0	2	2	0	0
22.12.2024 00:30	114	Bogdanovic B.	ATL	7	0	3	1495	2	5	0	0	1	4	2	2	-16	0	0	3	0	3	0	0	0
22.12.2024 00:30	115	Krejci V.	ATL	7	0	3	1186	2	4	0	0	1	3	2	2	-2	0	0	5	1	2	0	0	0
22.12.2024 00:30	116	Nance L.	ATL	7	10	4	1436	2	8	0	0	1	6	2	2	-21	1	9	3	1	3	3	0	0
22.12.2024 00:30	117	Mathews G.	ATL	6	1	0	363	2	3	0	0	2	3	0	0	6	0	1	0	0	1	0	0	0
22.12.2024 00:30	118	Roddy D.	ATL	5	2	0	552	2	3	0	0	1	2	0	0	10	0	2	0	0	1	0	0	0
22.12.2024 00:30	119	Wallace K.	ATL	5	1	4	1397	2	4	0	0	1	3	0	0	-4	0	1	0	0	3	0	0	0
22.12.2024 00:30	120	Barlow D.	ATL	3	1	0	324	1	1	0	0	1	1	0	0	9	0	1	1	1	0	0	0	0
\.


--
-- Data for Name: atlanta_hawks_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.atlanta_hawks_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Bufkin Kobe	Lesionado	2025-01-16 10:42:52.464439
2	Young Trae	Lesionado	2025-01-16 10:42:52.467603
3	Hunter De'Andre	Lesionado	2025-01-16 10:42:52.470235
4	Johnson Jalen	Lesionado	2025-01-16 10:42:52.473001
5	Nance Larry	Lesionado	2025-01-16 10:42:52.475529
6	Risacher Zaccharie	Lesionado	2025-01-16 10:42:52.477896
\.


--
-- Data for Name: bankrolls; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.bankrolls (id, user_id, days_option, days, bankroll, target_profit, created_at, updated_at, balance) FROM stdin;
\.


--
-- Data for Name: bets; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.bets (id, user_id, game_date, games, choices, odds, bet_value, lucro, outcome, created_at) FROM stdin;
49	1	07/01/2025, 00:30<br>07/01/2025, 00:30	Brooklyn Nets x Indiana Pacers<br>New York Knicks x Orlando Magic	Vencedor: Casa	1.45	37.04	16.67	Vencedor	2025-01-07 00:11:59.076568
50	1	07/01/2025, 00:00<br>07/01/2025, 00:00<br>07/01/2025, 00:30<br>07/01/2025, 00:30<br>07/01/2025, 00:30<br>07/01/2025, 01:00<br>07/01/2025, 01:00<br>07/01/2025, 01:00<br>07/01/2025, 03:00	Detroit Pistons x Portland Trail Blazers<br>Philadelphia 76ers x Phoenix Suns<br>Brooklyn Nets x Indiana Pacers<br>New York Knicks x Orlando Magic<br>Toronto Raptors x Milwaukee Bucks<br>Chicago Bulls x San Antonio Spurs<br>Memphis Grizzlies x Dallas Mavericks<br>Minnesota Timberwolves x Los Angeles Clippers<br>Sacramento Kings x Miami Heat	Vencedor: Visitante	41.33	0.41	0	Perdeu	2025-01-07 02:28:04.287808
\.


--
-- Data for Name: betting_plans; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.betting_plans (id, user_id, days_option, days, bankroll, target_profit) FROM stdin;
1	1	fixa	7	70.00	50.00
\.


--
-- Data for Name: boston_celtics; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.boston_celtics (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	13.07.2024	Boston Celtics	114	Miami Heat	119	32	21	29	32	28	33	28	30
2	16.07.2024	Los Angeles Lakers	74	Boston Celtics	88	17	17	15	25	19	31	15	23
3	17.07.2024	Charlotte Hornets	84	Boston Celtics	89	19	20	21	24	19	14	23	33
4	19.07.2024	Boston Celtics	90	Dallas Mavericks	101	22	23	24	21	30	25	21	25
5	21.07.2024	Boston Celtics	98	Philadelphia 76ers	103	33	19	21	25	30	19	34	20
6	04.10.2024	Denver Nuggets	103	Boston Celtics	107	32	31	17	23	25	31	23	28
7	06.10.2024	Boston Celtics	130	Denver Nuggets	104	34	33	42	21	29	31	16	28
8	13.10.2024	Boston Celtics	139	Philadelphia 76ers	89	40	31	37	31	18	30	15	26
9	14.10.2024	Boston Celtics	115	Toronto Raptors	111	41	28	22	24	20	17	32	42
10	16.10.2024	Toronto Raptors	119	Boston Celtics	118	46	20	31	22	27	40	19	32
11	23.10.2024	Boston Celtics	132	New York Knicks	109	43	31	39	19	24	31	32	22
12	25.10.2024	Washington Wizards	102	Boston Celtics	122	32	22	19	29	33	31	34	24
13	27.10.2024	Detroit Pistons	118	Boston Celtics	124	31	31	31	25	42	31	21	30
14	28.10.2024	Boston Celtics	119	Milwaukee Bucks	108	28	25	37	29	29	27	26	26
15	30.10.2024\nApós Prol.	Indiana Pacers	135	Boston Celtics	132	35	32	33	24	31	26	29	38
16	01.11.2024	Charlotte Hornets	109	Boston Celtics	124	25	42	19	23	40	31	21	32
17	02.11.2024	Charlotte Hornets	103	Boston Celtics	113	24	26	24	29	38	30	17	28
18	05.11.2024	Atlanta Hawks	93	Boston Celtics	123	30	23	22	18	35	40	28	20
19	07.11.2024	Boston Celtics	112	Golden State Warriors	118	24	16	41	31	19	32	31	36
20	09.11.2024\nApós Prol.	Boston Celtics	108	Brooklyn Nets	104	24	25	27	18	28	23	27	16
21	10.11.2024	Milwaukee Bucks	107	Boston Celtics	113	40	29	15	23	30	28	29	26
22	13.11.2024	Boston Celtics	116	Atlanta Hawks	117	31	34	26	25	29	25	30	33
23	14.11.2024	Brooklyn Nets	114	Boston Celtics	139	34	26	29	25	32	33	38	36
24	17.11.2024\nApós Prol.	Boston Celtics	126	Toronto Raptors	123	28	28	30	28	26	28	31	29
25	20.11.2024	Boston Celtics	120	Cleveland Cavaliers	117	26	39	28	27	20	28	40	29
26	23.11.2024	Washington Wizards	96	Boston Celtics	108	27	24	21	24	29	20	26	33
27	24.11.2024	Boston Celtics	107	Minnesota Timberwolves	105	24	31	29	23	27	25	21	32
28	26.11.2024	Boston Celtics	126	Los Angeles Clippers	94	27	51	21	27	20	29	29	16
29	30.11.2024	Chicago Bulls	129	Boston Celtics	138	30	37	29	33	39	28	29	42
30	01.12.2024	Cleveland Cavaliers	115	Boston Celtics	111	28	23	21	43	24	25	35	27
31	03.12.2024	Boston Celtics	108	Miami Heat	89	28	32	25	23	25	20	18	26
32	05.12.2024	Boston Celtics	130	Detroit Pistons	120	39	33	31	27	24	34	30	32
33	07.12.2024	Boston Celtics	111	Milwaukee Bucks	105	29	24	25	33	27	30	25	23
34	08.12.2024	Boston Celtics	121	Memphis Grizzlies	127	27	27	35	32	31	35	28	33
35	13.12.2024	Boston Celtics	123	Detroit Pistons	99	27	32	34	30	16	28	24	31
36	15.12.2024	Washington Wizards	98	Boston Celtics	112	23	29	20	26	34	33	24	21
37	20.12.2024	Boston Celtics	108	Chicago Bulls	117	25	32	29	22	21	33	28	35
38	22.12.2024	Chicago Bulls	98	Boston Celtics	123	28	26	23	21	28	33	32	30
39	24.12.2024	Orlando Magic	108	Boston Celtics	104	21	22	36	29	32	26	21	25
40	25.12.2024	Boston Celtics	114	Philadelphia 76ers	118	25	33	24	32	30	36	16	36
41	28.12.2024	Boston Celtics	142	Indiana Pacers	105	39	28	36	39	22	23	33	27
42	29.12.2024	Boston Celtics	114	Indiana Pacers	123	29	29	33	23	27	38	33	25
43	31.12.2024	Boston Celtics	125	Toronto Raptors	71	23	22	45	35	12	23	18	18
44	03.01. 00:30	Minnesota Timberwolves	115	Boston Celtics	118	35	16	34	30	28	34	29	27
45	04.01. 01:00	Houston Rockets	86	Boston Celtics	109	31	25	16	14	37	28	17	27
46	05.01. 20:30	Oklahoma City Thunder	105	Boston Celtics	92	32	23	21	29	35	30	15	12
47	08.01. 03:00	Denver Nuggets	106	Boston Celtics	118	25	32	26	23	37	20	31	30
48	11.01. 00:30	Boston Celtics	97	Sacramento Kings	114	27	28	21	21	34	19	23	38
49	12.01. 23:00	Boston Celtics	120	New Orleans Pelicans	119	29	33	28	30	35	26	27	31
50	16.01. 00:30	Toronto Raptors	110	Boston Celtics	97	25	30	33	22	29	24	29	15
\.


--
-- Data for Name: boston_celtics_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.boston_celtics_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 00:30	1	Pritchard P.	BOS	20	2	4	1851	7	11	0	0	4	8	2	3	6	2	0	3	1	0	0	0	0
16.01.2025 00:30	2	Porzingis K.	BOS	18	8	3	2086	7	11	0	0	4	5	0	2	-17	1	7	3	1	3	2	0	0
16.01.2025 00:30	3	Tatum J.	BOS	16	10	7	2172	5	15	0	0	3	9	3	5	-1	1	9	2	0	1	1	0	0
16.01.2025 00:30	4	Holiday J.	BOS	12	6	2	1875	5	11	0	0	0	3	2	2	-13	3	3	2	1	1	0	0	0
16.01.2025 00:30	5	Brown J.	BOS	10	7	4	1958	4	16	0	0	1	1	1	2	-23	2	5	3	1	2	0	0	0
16.01.2025 00:30	6	Horford A.	BOS	10	2	2	1245	4	10	0	0	2	8	0	0	1	0	2	0	0	0	4	0	0
16.01.2025 00:30	7	White D.	BOS	6	0	1	1275	2	9	0	0	1	7	1	2	-29	0	0	1	0	2	0	0	0
16.01.2025 00:30	8	Hauser S.	BOS	3	6	0	1005	1	6	0	0	1	5	0	0	0	2	4	1	2	0	0	0	0
16.01.2025 00:30	9	Kornet L.	BOS	2	3	1	604	1	2	0	0	0	0	0	0	7	2	1	1	0	0	1	0	0
16.01.2025 00:30	10	Queta N.	BOS	0	0	0	82	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0
16.01.2025 00:30	11	Springer J.	BOS	0	0	0	83	0	0	0	0	0	0	0	2	1	0	0	0	0	0	0	0	0
16.01.2025 00:30	12	Tillman X.	BOS	0	1	0	82	0	0	0	0	0	0	0	0	1	0	1	0	0	0	0	0	0
16.01.2025 00:30	13	Walsh J.	BOS	0	0	0	82	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0
12.01.2025 23:00	14	Tatum J.	BOS	38	11	1	2174	14	30	0	0	2	10	8	10	-9	3	8	1	1	3	1	0	0
12.01.2025 23:00	15	Porzingis K.	BOS	19	11	1	2033	7	19	0	0	3	9	2	3	-8	6	5	2	0	1	3	0	0
12.01.2025 23:00	16	Brown J.	BOS	16	8	7	2316	6	14	0	0	0	2	4	4	0	2	6	3	0	4	0	0	0
12.01.2025 23:00	17	Horford A.	BOS	11	7	0	1363	4	6	0	0	3	4	0	0	-3	1	6	1	0	0	1	0	0
12.01.2025 23:00	18	Pritchard P.	BOS	11	1	4	1430	4	10	0	0	3	8	0	0	12	0	1	1	0	0	0	0	0
12.01.2025 23:00	19	Holiday J.	BOS	8	4	6	1908	3	8	0	0	1	4	1	2	-1	2	2	1	1	1	1	0	0
12.01.2025 23:00	20	Kornet L.	BOS	8	7	1	825	4	6	0	0	0	0	0	0	13	2	5	5	0	0	0	0	0
12.01.2025 23:00	21	White D.	BOS	6	4	2	1818	1	6	0	0	0	5	4	4	-1	2	2	3	3	2	1	0	0
12.01.2025 23:00	22	Hauser S.	BOS	3	2	1	533	1	2	0	0	1	2	0	0	2	0	2	1	0	0	0	0	0
11.01.2025 00:30	23	Brown J.	BOS	28	1	5	2106	9	19	0	0	1	5	9	11	-9	1	0	2	1	1	1	0	0
11.01.2025 00:30	24	Porzingis K.	BOS	22	10	0	1751	6	15	0	0	4	7	6	7	-8	1	9	2	0	0	2	0	0
11.01.2025 00:30	25	Tatum J.	BOS	15	12	5	2103	5	13	0	0	3	7	2	3	-11	0	12	3	0	8	0	0	0
11.01.2025 00:30	26	Pritchard P.	BOS	9	2	2	1647	4	11	0	0	1	7	0	0	-8	1	1	3	1	1	0	0	0
11.01.2025 00:30	27	Hauser S.	BOS	7	2	1	774	3	6	0	0	1	4	0	0	-8	1	1	0	0	2	1	0	0
11.01.2025 00:30	28	Kornet L.	BOS	6	6	2	925	3	4	0	0	0	0	0	0	-4	3	3	0	1	1	0	0	0
11.01.2025 00:30	29	Holiday J.	BOS	5	5	2	1677	2	4	0	0	1	2	0	0	-18	0	5	1	1	1	1	0	0
11.01.2025 00:30	30	White D.	BOS	3	1	3	1641	1	8	0	0	0	6	1	1	-9	0	1	1	1	0	2	0	0
11.01.2025 00:30	31	Horford A.	BOS	2	4	1	1392	1	4	0	0	0	3	0	0	-1	1	3	1	0	0	0	0	0
11.01.2025 00:30	32	Queta N.	BOS	0	0	0	128	0	0	0	0	0	0	0	0	-3	0	0	0	0	0	0	0	0
11.01.2025 00:30	33	Springer J.	BOS	0	0	0	128	0	0	0	0	0	0	0	0	-3	0	0	1	0	0	0	0	0
11.01.2025 00:30	34	Tillman X.	BOS	0	0	1	128	0	0	0	0	0	0	0	0	-3	0	0	0	0	1	0	0	0
08.01.2025 03:00	35	Tatum J.	BOS	29	4	6	2279	11	23	0	0	1	9	6	6	23	0	4	2	1	2	2	0	0
08.01.2025 03:00	36	Porzingis K.	BOS	25	11	3	2046	9	18	0	0	1	3	6	8	14	5	6	1	2	1	1	0	0
08.01.2025 03:00	37	Holiday J.	BOS	19	3	7	1927	6	12	0	0	3	7	4	4	10	0	3	1	2	0	1	0	0
08.01.2025 03:00	38	Brown J.	BOS	14	8	8	2307	6	13	0	0	0	1	2	2	5	0	8	3	0	4	0	0	0
08.01.2025 03:00	39	Hauser S.	BOS	9	2	1	1063	3	5	0	0	3	5	0	0	0	1	1	1	0	1	1	0	0
08.01.2025 03:00	40	Horford A.	BOS	9	7	0	2022	3	5	0	0	3	5	0	0	15	2	5	1	4	1	0	0	0
08.01.2025 03:00	41	Queta N.	BOS	8	0	0	473	4	5	0	0	0	0	0	0	-10	0	0	1	1	0	0	0	0
08.01.2025 03:00	42	Pritchard P.	BOS	3	3	4	1174	1	6	0	0	1	5	0	0	-4	2	1	0	1	2	0	0	0
08.01.2025 03:00	43	Kornet L.	BOS	2	3	1	1050	1	1	0	0	0	0	0	0	5	1	2	2	0	0	2	0	0
08.01.2025 03:00	44	Springer J.	BOS	0	0	0	59	0	0	0	0	0	0	0	0	2	0	0	1	0	0	0	0	0
05.01.2025 20:30	45	Tatum J.	BOS	26	10	1	2332	7	17	0	0	2	6	10	12	-12	1	9	1	2	2	0	0	0
05.01.2025 20:30	46	Brown J.	BOS	21	3	3	2377	8	19	0	0	1	6	4	4	-7	0	3	2	1	3	1	0	0
05.01.2025 20:30	47	Porzingis K.	BOS	19	9	1	1758	6	12	0	0	1	6	6	6	-17	4	5	5	1	4	0	0	0
05.01.2025 20:30	48	White D.	BOS	11	4	4	2235	4	13	0	0	2	11	1	2	-8	0	4	1	1	3	3	0	0
05.01.2025 20:30	49	Horford A.	BOS	6	8	1	1472	2	6	0	0	2	5	0	0	-1	2	6	1	1	2	0	0	0
05.01.2025 20:30	50	Kornet L.	BOS	4	4	0	879	2	2	0	0	0	0	0	0	-2	1	3	2	0	0	1	0	0
05.01.2025 20:30	51	Hauser S.	BOS	3	1	0	665	1	5	0	0	1	5	0	0	-4	0	1	1	0	0	0	0	0
05.01.2025 20:30	52	Holiday J.	BOS	2	8	6	2029	1	6	0	0	0	4	0	0	-11	3	5	4	0	2	0	0	0
05.01.2025 20:30	53	Pritchard P.	BOS	0	1	1	653	0	5	0	0	0	3	0	0	-3	1	0	1	0	0	0	0	0
04.01.2025 01:00	54	White D.	BOS	23	4	2	2086	8	16	0	0	6	12	1	2	27	2	2	0	0	3	2	0	0
04.01.2025 01:00	55	Pritchard P.	BOS	20	4	2	1934	8	10	0	0	4	6	0	0	21	1	3	1	0	0	1	0	0
04.01.2025 01:00	56	Tatum J.	BOS	20	6	5	1977	7	19	0	0	4	10	2	2	11	1	5	1	1	3	0	0	0
04.01.2025 01:00	57	Holiday J.	BOS	14	4	3	1666	5	9	0	0	2	5	2	2	16	0	4	0	1	2	1	0	0
04.01.2025 01:00	58	Porzingis K.	BOS	11	5	2	1656	3	8	0	0	2	3	3	4	10	1	4	3	0	1	2	0	1
04.01.2025 01:00	59	Kornet L.	BOS	9	10	4	1411	4	7	0	0	0	0	1	4	23	6	4	2	1	1	1	0	0
04.01.2025 01:00	60	Peterson D.	BOS	5	1	1	293	2	2	0	0	1	1	0	0	2	0	1	0	0	0	0	0	0
04.01.2025 01:00	61	Queta N.	BOS	5	2	1	1171	2	3	0	0	0	0	1	2	1	1	1	4	0	1	0	0	0
04.01.2025 01:00	62	Springer J.	BOS	2	0	0	232	0	0	0	0	0	0	2	2	2	0	0	2	1	0	0	0	0
04.01.2025 01:00	63	Hauser S.	BOS	0	3	0	1164	0	1	0	0	0	1	0	0	2	0	3	0	1	0	0	0	0
04.01.2025 01:00	64	Tillman X.	BOS	0	0	0	293	0	0	0	0	0	0	0	0	2	0	0	0	1	1	1	0	0
04.01.2025 01:00	65	Walsh J.	BOS	0	2	0	517	0	2	0	0	0	1	0	0	-2	0	2	0	0	2	0	0	0
03.01.2025 00:30	66	Tatum J.	BOS	33	8	9	2289	13	27	0	0	6	17	1	2	3	0	8	2	3	2	0	0	1
03.01.2025 00:30	67	White D.	BOS	26	2	2	2211	10	20	0	0	5	10	1	1	3	0	2	2	0	0	2	0	0
03.01.2025 00:30	68	Hauser S.	BOS	15	3	2	1638	5	11	0	0	5	11	0	0	-10	1	2	1	0	0	0	0	0
03.01.2025 00:30	69	Holiday J.	BOS	11	3	8	2339	4	9	0	0	3	7	0	0	1	2	1	4	2	0	0	0	0
03.01.2025 00:30	70	Horford A.	BOS	9	5	4	2089	4	8	0	0	1	5	0	0	-2	3	2	2	0	0	2	0	0
03.01.2025 00:30	71	Pritchard P.	BOS	9	2	4	1482	3	8	0	0	2	6	1	2	5	1	1	1	1	0	0	0	0
03.01.2025 00:30	72	Queta N.	BOS	8	5	0	1290	4	5	0	0	0	0	0	0	17	3	2	1	1	1	0	0	0
03.01.2025 00:30	73	Kornet L.	BOS	7	3	1	669	3	3	0	0	0	0	1	1	0	0	3	3	1	0	0	0	0
03.01.2025 00:30	74	Walsh J.	BOS	0	0	0	393	0	1	0	0	0	1	0	0	-2	0	0	0	1	0	0	0	0
31.12.2024 20:00	75	Tatum J.	BOS	23	8	3	1762	6	13	0	0	4	9	7	11	38	0	8	2	1	3	0	0	0
31.12.2024 20:00	76	Pritchard P.	BOS	19	6	4	1376	7	13	0	0	5	8	0	0	36	1	5	1	3	2	0	0	0
31.12.2024 20:00	77	White D.	BOS	16	4	3	1642	6	8	0	0	3	3	1	2	29	0	4	2	1	2	4	0	0
31.12.2024 20:00	78	Holiday J.	BOS	14	1	4	1505	5	8	0	0	4	5	0	0	25	1	0	0	3	0	0	0	0
31.12.2024 20:00	79	Brown J.	BOS	12	9	3	1528	6	13	0	0	0	2	0	0	11	5	4	1	1	3	0	0	0
31.12.2024 20:00	80	Hauser S.	BOS	12	2	1	1070	4	7	0	0	4	7	0	0	28	0	2	0	0	0	0	0	0
31.12.2024 20:00	81	Walsh J.	BOS	10	1	2	720	4	6	0	0	1	1	1	2	17	0	1	1	0	0	0	0	0
31.12.2024 20:00	82	Queta N.	BOS	8	4	0	1118	4	5	0	0	0	0	0	0	16	3	1	1	1	0	2	0	0
31.12.2024 20:00	83	Peterson D.	BOS	5	4	2	720	2	3	0	0	1	2	0	0	17	0	4	0	0	1	0	0	0
31.12.2024 20:00	84	Kornet L.	BOS	2	4	2	783	1	2	0	0	0	0	0	0	17	1	3	0	0	1	0	0	0
31.12.2024 20:00	85	Springer J.	BOS	2	0	1	374	1	1	0	0	0	0	0	0	6	0	0	1	0	1	0	0	0
31.12.2024 20:00	86	Tillman X.	BOS	2	0	0	544	1	1	0	0	0	0	0	0	10	0	0	0	2	0	1	0	0
31.12.2024 20:00	87	Horford A.	BOS	0	6	4	1258	0	7	0	0	0	6	0	0	20	0	6	1	2	0	0	0	0
29.12.2024 23:00	88	Brown J.	BOS	31	4	6	2185	13	21	0	0	2	6	3	5	-10	0	4	3	1	2	0	0	0
29.12.2024 23:00	89	Tatum J.	BOS	22	9	6	2473	8	17	0	0	2	10	4	5	-21	2	7	3	3	3	1	0	0
29.12.2024 23:00	90	Pritchard P.	BOS	21	4	3	1662	7	13	0	0	5	8	2	2	-2	1	3	2	0	2	0	0	0
29.12.2024 23:00	91	White D.	BOS	17	3	3	2329	7	15	0	0	3	11	0	0	-20	1	2	4	0	1	1	0	0
29.12.2024 23:00	92	Hauser S.	BOS	9	0	3	1180	3	6	0	0	3	6	0	0	0	0	0	1	1	0	0	0	0
29.12.2024 23:00	93	Queta N.	BOS	6	3	1	311	2	2	0	0	0	0	2	3	3	2	1	2	0	0	0	0	0
29.12.2024 23:00	94	Horford A.	BOS	5	5	3	1839	2	12	0	0	1	10	0	0	-14	0	5	5	0	0	0	0	0
29.12.2024 23:00	95	Peterson D.	BOS	2	0	0	145	1	1	0	0	0	0	0	0	6	0	0	0	0	0	0	0	0
29.12.2024 23:00	96	Kornet L.	BOS	1	9	0	822	0	1	0	0	0	0	1	2	-3	1	8	0	0	0	3	0	0
29.12.2024 23:00	97	Springer J.	BOS	0	1	1	145	0	2	0	0	0	1	0	0	6	0	1	0	0	0	0	0	0
29.12.2024 23:00	98	Tillman X.	BOS	0	0	0	145	0	1	0	0	0	1	0	0	6	0	0	0	0	0	0	0	0
29.12.2024 23:00	99	Walsh J.	BOS	0	3	0	1164	0	2	0	0	0	1	0	2	4	1	2	2	1	0	1	0	0
28.12.2024 00:30	100	Brown J.	BOS	44	5	3	2235	16	24	0	0	6	11	6	6	30	3	2	0	4	1	0	0	0
28.12.2024 00:30	101	Tatum J.	BOS	22	13	4	1899	7	15	0	0	3	10	5	6	21	1	12	2	3	1	0	0	0
28.12.2024 00:30	102	Pritchard P.	BOS	18	8	10	1897	7	16	0	0	4	10	0	0	25	5	3	5	1	0	1	0	0
28.12.2024 00:30	103	Horford A.	BOS	13	5	2	1200	4	8	0	0	3	6	2	2	23	1	4	0	0	2	1	0	0
28.12.2024 00:30	104	Walsh J.	BOS	9	5	2	1256	2	3	0	0	2	3	3	4	16	2	3	2	0	1	1	0	0
28.12.2024 00:30	105	White D.	BOS	9	3	6	1797	3	8	0	0	3	8	0	0	24	0	3	1	0	2	2	0	0
28.12.2024 00:30	106	Queta N.	BOS	6	2	0	553	2	3	0	0	0	0	2	3	3	2	0	2	0	1	1	0	0
28.12.2024 00:30	107	Springer J.	BOS	6	1	0	463	0	0	0	0	0	0	6	6	9	0	1	2	0	0	0	0	0
28.12.2024 00:30	108	Tillman X.	BOS	5	1	0	300	2	4	0	0	1	2	0	0	2	0	1	0	0	0	0	0	0
28.12.2024 00:30	109	Hauser S.	BOS	4	2	2	1170	2	8	0	0	0	5	0	0	12	1	1	1	0	0	0	0	0
28.12.2024 00:30	110	Kornet L.	BOS	3	5	1	1127	1	2	0	0	0	0	1	2	11	2	3	1	1	1	0	0	0
28.12.2024 00:30	111	Peterson D.	BOS	3	2	1	503	1	1	0	0	1	1	0	0	9	1	1	3	0	1	0	0	0
25.12.2024 22:00	112	Tatum J.	BOS	32	15	4	2511	11	20	0	0	4	8	6	7	5	2	13	2	1	3	1	0	0
25.12.2024 22:00	113	Brown J.	BOS	23	7	4	2570	10	23	0	0	3	6	0	3	-1	1	6	4	2	5	0	0	0
25.12.2024 22:00	114	White D.	BOS	21	3	4	1975	8	15	0	0	5	10	0	0	-5	0	3	3	0	4	0	0	0
25.12.2024 22:00	115	Horford A.	BOS	17	4	2	2004	6	13	0	0	5	10	0	0	22	0	4	3	0	0	1	0	0
25.12.2024 22:00	116	Porzingis K.	BOS	9	2	3	794	3	8	0	0	3	6	0	0	-13	0	2	1	0	0	0	0	0
25.12.2024 22:00	117	Kornet L.	BOS	6	10	2	1217	3	4	0	0	0	0	0	1	-1	6	4	1	0	0	2	0	0
25.12.2024 22:00	118	Pritchard P.	BOS	4	3	5	1994	1	9	0	0	0	8	2	2	-12	2	1	2	0	1	0	0	0
25.12.2024 22:00	119	Queta N.	BOS	2	5	0	473	1	2	0	0	0	0	0	0	-1	1	4	1	0	0	0	0	0
25.12.2024 22:00	120	Hauser S.	BOS	0	2	0	807	0	1	0	0	0	1	0	0	-12	1	1	1	0	0	0	0	0
25.12.2024 22:00	121	Walsh J.	BOS	0	0	0	55	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
24.12.2024 00:00	122	Brown J.	BOS	35	9	4	2213	15	29	0	0	1	7	4	6	6	2	7	4	3	5	0	0	0
24.12.2024 00:00	123	Porzingis K.	BOS	17	4	0	2214	2	10	0	0	0	4	13	14	-8	1	3	3	0	1	2	0	1
24.12.2024 00:00	124	White D.	BOS	17	4	4	2426	5	12	0	0	3	7	4	5	-5	0	4	3	3	5	0	0	0
24.12.2024 00:00	125	Holiday J.	BOS	16	8	0	1986	7	12	0	0	2	5	0	0	-4	1	7	2	3	5	2	0	0
24.12.2024 00:00	126	Horford A.	BOS	8	6	2	2094	3	10	0	0	1	5	1	2	2	1	5	0	1	0	0	0	0
24.12.2024 00:00	127	Pritchard P.	BOS	7	3	1	1266	3	7	0	0	1	5	0	0	-12	1	2	1	0	2	0	0	0
24.12.2024 00:00	128	Kornet L.	BOS	4	5	0	1214	2	4	0	0	0	0	0	0	6	2	3	0	1	0	1	0	1
24.12.2024 00:00	129	Hauser S.	BOS	0	2	2	987	0	0	0	0	0	0	0	0	-5	0	2	3	2	0	0	0	0
\.


--
-- Data for Name: boston_celtics_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.boston_celtics_lesoes (id, player_name, injury_status, date) FROM stdin;
\.


--
-- Data for Name: brooklyn_nets; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.brooklyn_nets (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	13.04.2024	New York Knicks	111	Brooklyn Nets	107	14	40	30	27	30	33	13	31
2	14.04.2024	Philadelphia 76ers	107	Brooklyn Nets	86	22	33	26	26	23	21	20	22
3	13.07.2024\nApós Prol.	Indiana Pacers	95	Brooklyn Nets	97	21	20	20	28	17	16	27	29
4	14.07.2024	Los Angeles Clippers	87	Brooklyn Nets	78	31	13	18	25	18	15	8	37
5	16.07.2024	Brooklyn Nets	92	New York Knicks	85	11	28	18	35	28	15	19	23
6	19.07.2024\nApós Prol.	Brooklyn Nets	102	Orlando Magic	100	18	31	26	20	23	18	31	23
7	21.07.2024	Brooklyn Nets	90	Charlotte Hornets	97	21	27	22	20	19	31	26	21
8	09.10.2024	Los Angeles Clippers	115	Brooklyn Nets	106	35	20	28	32	18	39	19	30
9	15.10.2024	Brooklyn Nets	131	Washington Wizards	92	28	27	34	42	20	26	24	22
10	17.10.2024	Philadelphia 76ers	117	Brooklyn Nets	95	33	29	25	30	22	34	23	16
11	19.10.2024	Brooklyn Nets	112	Toronto Raptors	116	30	20	29	33	31	22	38	25
12	24.10.2024	Atlanta Hawks	120	Brooklyn Nets	116	30	21	32	37	24	31	28	33
13	26.10.2024	Orlando Magic	116	Brooklyn Nets	101	22	27	32	35	23	23	25	30
14	27.10.2024	Brooklyn Nets	115	Milwaukee Bucks	102	27	21	35	32	25	20	33	24
15	29.10.2024\nApós Prol.	Brooklyn Nets	139	Denver Nuggets	144	40	32	27	26	27	36	33	29
16	31.10.2024	Memphis Grizzlies	106	Brooklyn Nets	119	29	33	28	16	34	33	24	28
17	01.11.2024	Brooklyn Nets	120	Chicago Bulls	112	37	31	24	28	30	30	30	22
18	03.11.2024	Brooklyn Nets	92	Detroit Pistons	106	25	32	20	15	29	23	31	23
19	05.11.2024	Brooklyn Nets	106	Memphis Grizzlies	104	23	27	33	23	30	19	30	25
20	09.11.2024\nApós Prol.	Boston Celtics	108	Brooklyn Nets	104	24	25	27	18	28	23	27	16
21	10.11.2024	Cleveland Cavaliers	105	Brooklyn Nets	100	34	23	13	35	28	27	27	18
22	12.11.2024	New Orleans Pelicans	105	Brooklyn Nets	107	22	34	29	20	26	28	27	26
23	14.11.2024	Brooklyn Nets	114	Boston Celtics	139	34	26	29	25	32	33	38	36
24	16.11.2024	New York Knicks	124	Brooklyn Nets	122	37	31	32	24	32	27	23	40
25	18.11.2024	New York Knicks	114	Brooklyn Nets	104	30	30	35	19	29	28	24	23
26	20.11.2024	Brooklyn Nets	116	Charlotte Hornets	115	23	31	31	31	37	22	28	28
27	23.11.2024	Philadelphia 76ers	113	Brooklyn Nets	98	29	24	26	34	24	26	27	21
28	25.11.2024	Sacramento Kings	103	Brooklyn Nets	108	28	29	31	15	37	28	23	20
29	26.11.2024	Golden State Warriors	120	Brooklyn Nets	128	30	37	25	28	34	24	29	41
30	28.11.2024	Phoenix Suns	117	Brooklyn Nets	127	37	26	21	33	34	29	33	31
31	30.11.2024	Brooklyn Nets	100	Orlando Magic	123	29	20	22	29	33	28	35	27
32	01.12.2024	Brooklyn Nets	92	Orlando Magic	100	29	21	19	23	26	24	25	25
33	03.12.2024	Chicago Bulls	128	Brooklyn Nets	102	29	27	36	36	29	21	22	30
34	05.12.2024	Brooklyn Nets	99	Indiana Pacers	90	24	27	24	24	17	18	35	20
35	08.12.2024	Brooklyn Nets	113	Milwaukee Bucks	118	25	27	34	27	27	24	35	32
36	14.12.2024	Memphis Grizzlies	135	Brooklyn Nets	119	39	30	38	28	36	20	39	24
37	17.12.2024	Brooklyn Nets	101	Cleveland Cavaliers	130	17	23	37	24	37	35	32	26
38	20.12.2024	Toronto Raptors	94	Brooklyn Nets	101	24	22	30	18	24	28	18	31
39	22.12.2024	Brooklyn Nets	94	Utah Jazz	105	24	21	18	31	19	31	25	30
40	24.12.2024	Miami Heat	110	Brooklyn Nets	95	39	19	25	27	28	29	21	17
41	27.12.2024	Milwaukee Bucks	105	Brooklyn Nets	111	25	34	23	23	27	24	25	35
42	28.12.2024	Brooklyn Nets	87	San Antonio Spurs	96	22	19	21	25	11	30	33	22
43	29.12.2024	Orlando Magic	102	Brooklyn Nets	101	21	22	25	34	27	34	22	18
44	02.01. 00:30	Toronto Raptors	130	Brooklyn Nets	113	26	39	29	36	33	31	27	22
45	03.01. 01:00	Milwaukee Bucks	110	Brooklyn Nets	113	23	31	31	25	30	36	28	19
46	04.01. 23:00	Brooklyn Nets	94	Philadelphia 76ers	123	19	28	19	28	29	35	27	32
47	07.01. 00:30	Brooklyn Nets	99	Indiana Pacers	113	22	17	31	29	24	31	23	35
48	09.01. 00:30	Brooklyn Nets	98	Detroit Pistons	113	25	24	21	28	27	32	32	22
49	11.01. 02:00	Denver Nuggets	124	Brooklyn Nets	105	32	33	29	30	36	23	20	26
50	13.01. 01:00\nApós Prol.	Utah Jazz	112	Brooklyn Nets	111	26	23	36	17	27	21	30	24
51	15.01. 03:00	Portland Trail Blazers	114	Brooklyn Nets	132	30	31	27	26	40	26	32	34
52	16.01. 03:30	Los Angeles Clippers	126	Brooklyn Nets	67	21	37	44	24	21	14	16	16
\.


--
-- Data for Name: brooklyn_nets_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.brooklyn_nets_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 03:30	1	Wilson J.	BRO	16	3	1	2018	5	10	0	0	1	4	5	5	-35	0	3	4	0	1	0	0	0
16.01.2025 03:30	2	Sharpe D.	BRO	12	14	3	1695	5	13	0	0	0	1	2	7	-12	8	6	1	1	4	1	0	0
16.01.2025 03:30	3	Martin T.	BRO	8	4	4	2216	3	16	0	0	2	8	0	0	-56	3	1	3	1	4	0	0	0
16.01.2025 03:30	4	Evbuomwan T.	BRO	7	3	2	1723	3	8	0	0	0	1	1	1	-24	1	2	3	1	4	0	0	0
16.01.2025 03:30	5	Johnson K.	BRO	6	0	0	1297	2	9	0	0	0	3	2	4	-35	0	0	1	0	2	0	0	0
16.01.2025 03:30	6	Beekman R.	BRO	5	4	3	1278	2	6	0	0	1	3	0	0	-6	0	4	0	2	0	0	0	0
16.01.2025 03:30	7	Clowney N.	BRO	4	2	0	1330	1	6	0	0	0	4	2	2	-44	1	1	2	0	2	0	0	0
16.01.2025 03:30	8	Williams Z.	BRO	4	4	0	1280	2	4	0	0	0	1	0	1	-38	0	4	2	2	3	0	0	0
16.01.2025 03:30	9	Whitehead D.	BRO	3	0	0	568	1	4	0	0	1	3	0	0	-4	0	0	0	0	0	0	0	0
16.01.2025 03:30	10	Claxton N.	BRO	2	5	2	995	1	7	0	0	0	0	0	2	-41	2	3	0	2	0	1	0	0
15.01.2025 03:00	11	Johnson C.	BRO	24	1	2	1613	10	18	0	0	2	9	2	2	7	0	1	0	0	1	1	0	0
15.01.2025 03:00	12	Clowney N.	BRO	20	5	2	1752	7	10	0	0	4	7	2	2	13	1	4	3	2	2	1	0	0
15.01.2025 03:00	13	Johnson K.	BRO	20	3	4	1737	7	12	0	0	3	6	3	4	12	0	3	1	1	2	0	0	0
15.01.2025 03:00	14	Wilson J.	BRO	14	4	1	1350	6	8	0	0	2	3	0	0	11	2	2	3	1	0	0	0	0
15.01.2025 03:00	15	Russell D.	BRO	13	3	9	1243	3	11	0	0	3	6	4	4	11	0	3	2	4	1	0	0	0
15.01.2025 03:00	16	Williams Z.	BRO	13	7	1	1654	4	7	0	0	3	4	2	2	6	3	4	2	2	1	0	0	0
15.01.2025 03:00	17	Evbuomwan T.	BRO	10	4	1	1100	4	6	0	0	1	2	1	2	10	1	3	3	0	0	0	0	0
15.01.2025 03:00	18	Sharpe D.	BRO	8	7	1	1074	4	7	0	0	0	1	0	0	2	1	6	1	1	0	0	0	0
15.01.2025 03:00	19	Martin T.	BRO	5	1	3	1193	2	5	0	0	1	3	0	0	6	0	1	1	0	2	0	0	0
15.01.2025 03:00	20	Simmons B.	BRO	5	9	11	1576	2	6	0	0	0	0	1	2	6	2	7	5	0	2	0	0	0
15.01.2025 03:00	21	Beekman R.	BRO	0	0	1	54	0	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0
15.01.2025 03:00	22	Whitehead D.	BRO	0	0	0	54	0	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0
13.01.2025 01:00	23	Evbuomwan T.	BRO	22	5	1	1433	7	8	0	0	2	3	6	9	-2	1	4	2	0	2	0	0	0
13.01.2025 01:00	24	Williams Z.	BRO	19	6	2	1916	4	11	0	0	3	7	8	8	1	0	6	3	1	0	0	0	0
13.01.2025 01:00	25	Claxton N.	BRO	14	12	4	2216	5	12	0	0	0	0	4	8	4	5	7	0	0	0	1	0	0
13.01.2025 01:00	26	Simmons B.	BRO	14	6	9	1898	7	11	0	0	0	0	0	0	10	2	4	1	0	2	2	0	0
13.01.2025 01:00	27	Sharpe D.	BRO	12	4	0	964	5	7	0	0	0	1	2	3	-5	1	3	3	0	1	0	0	0
13.01.2025 01:00	28	Martin T.	BRO	11	8	3	2114	5	13	0	0	1	6	0	2	3	3	5	2	1	2	1	0	0
13.01.2025 01:00	29	Johnson K.	BRO	8	4	3	1274	3	9	0	0	2	7	0	0	-2	1	3	3	2	0	0	0	0
13.01.2025 01:00	30	Wilson J.	BRO	7	3	1	1449	2	7	0	0	1	5	2	2	-7	0	3	1	1	1	1	0	0
13.01.2025 01:00	31	Beekman R.	BRO	4	1	2	696	1	4	0	0	1	4	1	2	-8	0	1	0	0	0	0	0	0
13.01.2025 01:00	32	Clowney N.	BRO	0	5	1	1940	0	10	0	0	0	7	0	1	1	2	3	2	0	0	0	0	0
11.01.2025 02:00	33	Johnson K.	BRO	22	4	4	2155	8	21	0	0	4	12	2	2	-9	1	3	2	1	2	1	0	0
11.01.2025 02:00	34	Martin T.	BRO	19	4	2	1908	6	14	0	0	4	9	3	3	-3	1	3	1	0	2	1	0	0
11.01.2025 02:00	35	Clowney N.	BRO	14	5	2	1791	3	9	0	0	1	5	7	7	-25	1	4	2	1	0	0	0	0
11.01.2025 02:00	36	Claxton N.	BRO	10	6	1	1593	5	8	0	0	0	0	0	2	-26	1	5	2	3	1	2	0	0
11.01.2025 02:00	37	Evbuomwan T.	BRO	10	2	1	1349	4	9	0	0	2	5	0	0	8	1	1	2	1	2	1	0	0
11.01.2025 02:00	38	Simmons B.	BRO	10	4	7	1307	5	7	0	0	0	0	0	0	-17	0	4	4	1	4	0	0	0
11.01.2025 02:00	39	Williams Z.	BRO	10	5	3	1386	3	8	0	0	2	6	2	4	-16	2	3	2	2	2	0	0	1
11.01.2025 02:00	40	Sharpe D.	BRO	7	5	3	1156	3	7	0	0	0	3	1	1	0	2	3	4	0	0	0	0	0
11.01.2025 02:00	41	Beekman R.	BRO	3	1	2	742	1	2	0	0	1	1	0	0	11	1	0	0	0	1	0	0	0
11.01.2025 02:00	42	Wilson J.	BRO	0	3	1	1013	0	5	0	0	0	4	0	0	-18	0	3	5	0	3	0	0	0
09.01.2025 00:30	43	Clowney N.	BRO	29	6	3	2223	9	20	0	0	5	11	6	6	-12	0	6	1	2	1	0	0	0
09.01.2025 00:30	44	Claxton N.	BRO	14	6	3	1808	6	11	0	0	0	1	2	2	-11	2	4	5	1	0	3	0	0
09.01.2025 00:30	45	Evbuomwan T.	BRO	13	7	1	1741	4	7	0	0	0	1	5	5	-7	3	4	0	1	1	0	0	0
09.01.2025 00:30	46	Martin T.	BRO	12	10	4	1956	4	12	0	0	4	9	0	2	-17	2	8	0	1	4	0	0	0
09.01.2025 00:30	47	Williams Z.	BRO	11	5	3	1667	4	13	0	0	1	7	2	2	-14	1	4	4	1	4	0	0	0
09.01.2025 00:30	48	Johnson K.	BRO	10	1	3	1663	3	10	0	0	2	4	2	2	-8	0	1	4	1	2	0	0	0
09.01.2025 00:30	49	Wilson J.	BRO	7	2	2	1898	2	7	0	0	1	6	2	2	-1	1	1	0	1	2	0	0	0
09.01.2025 00:30	50	Beekman R.	BRO	2	1	5	1444	1	6	0	0	0	0	0	0	-5	0	1	1	2	1	1	0	0
07.01.2025 00:30	51	Sharpe D.	BRO	16	13	5	1345	8	13	0	0	0	1	0	0	9	9	4	2	0	0	0	0	0
07.01.2025 00:30	52	Martin T.	BRO	15	5	1	1823	6	12	0	0	1	3	2	4	-11	3	2	0	1	3	0	0	0
07.01.2025 00:30	53	Clowney N.	BRO	14	4	1	1729	4	15	0	0	3	10	3	3	-9	1	3	4	0	1	0	0	0
07.01.2025 00:30	54	Johnson K.	BRO	12	4	5	1903	4	10	0	0	2	3	2	2	-22	1	3	3	4	5	0	0	0
07.01.2025 00:30	55	Williams Z.	BRO	10	8	4	1546	4	8	0	0	2	5	0	0	-20	0	8	4	1	1	1	0	0
07.01.2025 00:30	56	Beekman R.	BRO	9	0	0	1061	4	9	0	0	1	2	0	0	3	0	0	0	0	0	0	0	0
07.01.2025 00:30	57	Evbuomwan T.	BRO	8	6	1	1439	4	7	0	0	0	1	0	2	2	0	6	2	0	2	1	0	0
07.01.2025 00:30	58	Wilson J.	BRO	8	4	3	1857	4	11	0	0	0	4	0	0	-1	4	0	1	0	1	0	0	0
07.01.2025 00:30	59	Claxton N.	BRO	4	7	3	1535	2	10	0	0	0	1	0	0	-23	2	5	2	2	1	1	0	0
07.01.2025 00:30	60	Whitehead D.	BRO	3	0	0	162	1	3	0	0	1	3	0	0	2	0	0	1	0	0	0	0	0
04.01.2025 23:00	61	Williams Z.	BRO	19	3	2	1297	6	8	0	0	4	6	3	4	-19	0	3	1	1	2	1	0	0
04.01.2025 23:00	62	Martin T.	BRO	16	5	3	1754	6	18	0	0	1	7	3	4	-19	1	4	1	0	0	0	0	0
04.01.2025 23:00	63	Johnson K.	BRO	15	8	8	2180	5	14	0	0	2	5	3	4	-16	1	7	3	1	2	0	0	0
04.01.2025 23:00	64	Wilson J.	BRO	11	4	0	1983	4	11	0	0	3	8	0	0	-20	1	3	6	0	3	0	0	0
04.01.2025 23:00	65	Claxton N.	BRO	10	5	0	1404	5	8	0	0	0	1	0	0	-21	1	4	2	0	2	0	0	0
04.01.2025 23:00	66	Beekman R.	BRO	7	1	0	1075	3	4	0	0	0	1	1	1	-8	0	1	1	1	4	1	0	0
04.01.2025 23:00	67	Russell D.	BRO	5	1	4	848	1	4	0	0	1	2	2	3	-11	0	1	0	2	3	0	0	0
04.01.2025 23:00	68	Sharpe D.	BRO	5	5	2	1502	2	8	0	0	1	4	0	1	-6	1	4	2	0	1	1	0	0
04.01.2025 23:00	69	Clowney N.	BRO	3	6	2	1116	1	3	0	0	1	3	0	0	-14	1	5	2	1	4	0	0	0
04.01.2025 23:00	70	Evbuomwan T.	BRO	3	1	1	1241	1	4	0	0	1	4	0	2	-11	0	1	3	0	1	1	0	0
03.01.2025 01:00	71	Johnson C.	BRO	26	5	0	2321	10	16	0	0	6	12	0	0	-2	2	3	1	0	5	0	0	0
03.01.2025 01:00	72	Thomas C.	BRO	24	7	2	1312	8	22	0	0	2	11	6	6	-1	3	4	1	2	1	0	0	0
03.01.2025 01:00	73	Claxton N.	BRO	16	11	2	1996	5	9	0	0	0	0	6	8	-1	1	10	3	1	0	1	0	0
03.01.2025 01:00	74	Wilson J.	BRO	13	4	1	2219	6	13	0	0	1	4	0	0	-21	2	2	3	2	2	0	0	0
03.01.2025 01:00	75	Russell D.	BRO	11	3	12	1673	3	11	0	0	0	4	5	5	1	0	3	2	2	1	0	0	0
03.01.2025 01:00	76	Johnson K.	BRO	9	9	1	1681	3	7	0	0	1	2	2	3	-6	2	7	4	0	2	1	0	0
03.01.2025 01:00	77	Williams Z.	BRO	8	6	1	1111	2	5	0	0	2	4	2	2	12	2	4	2	0	1	1	0	0
03.01.2025 01:00	78	Sharpe D.	BRO	6	6	4	1193	1	3	0	0	0	1	4	4	17	2	4	4	0	2	0	0	0
03.01.2025 01:00	79	Martin T.	BRO	0	0	3	894	0	2	0	0	0	1	0	0	16	0	0	1	1	0	0	0	0
02.01.2025 00:30	80	Johnson C.	BRO	24	1	3	1665	7	12	0	0	3	5	7	7	-17	1	0	3	1	3	0	0	0
02.01.2025 00:30	81	Russell D.	BRO	22	2	8	1561	9	13	0	0	2	6	2	2	2	0	2	3	1	3	2	0	0
02.01.2025 00:30	82	Johnson K.	BRO	17	1	0	1743	6	18	0	0	3	12	2	2	-11	0	1	2	1	1	0	0	0
02.01.2025 00:30	83	Claxton N.	BRO	16	10	4	1808	7	11	0	0	0	1	2	3	-17	0	10	0	0	0	0	0	0
02.01.2025 00:30	84	Sharpe D.	BRO	11	8	2	1072	5	6	0	0	0	1	1	1	0	1	7	2	2	2	0	0	0
02.01.2025 00:30	85	Wilson J.	BRO	10	1	0	1889	3	11	0	0	1	5	3	3	-10	1	0	3	0	1	0	0	0
02.01.2025 00:30	86	Clowney N.	BRO	5	3	0	1695	2	5	0	0	1	4	0	0	-16	1	2	0	1	0	0	0	0
02.01.2025 00:30	87	Lewis M.	BRO	3	0	0	65	1	1	0	0	1	1	0	0	-1	0	0	0	0	0	0	0	0
02.01.2025 00:30	88	Martin T.	BRO	2	4	4	1200	1	4	0	0	0	2	0	0	3	0	4	1	1	0	0	0	0
02.01.2025 00:30	89	Simmons B.	BRO	2	2	6	1470	1	6	0	0	0	0	0	0	-18	0	2	3	1	1	0	0	0
02.01.2025 00:30	90	Beekman R.	BRO	1	0	1	232	0	0	0	0	0	0	1	2	0	0	0	0	0	0	0	0	0
29.12.2024 20:30	91	Thomas C.	BRO	25	6	5	1474	6	18	0	0	3	7	10	11	8	1	5	1	0	2	0	0	0
29.12.2024 20:30	92	Wilson J.	BRO	16	1	1	1870	4	5	0	0	4	5	4	4	5	0	1	4	1	1	0	0	0
29.12.2024 20:30	93	Johnson K.	BRO	14	3	2	1991	5	11	0	0	1	5	3	4	-5	2	1	3	1	2	0	0	0
29.12.2024 20:30	94	Clowney N.	BRO	13	2	0	1662	4	7	0	0	3	5	2	2	-4	0	2	1	0	2	0	0	0
29.12.2024 20:30	95	Johnson C.	BRO	9	3	4	1479	3	9	0	0	2	5	1	1	1	1	2	1	3	2	0	0	0
29.12.2024 20:30	96	Sharpe D.	BRO	8	6	1	984	4	9	0	0	0	2	0	0	18	2	4	1	1	0	2	0	0
29.12.2024 20:30	97	Claxton N.	BRO	6	5	1	1892	2	5	0	0	0	0	2	4	-19	1	4	4	1	2	0	0	0
29.12.2024 20:30	98	Simmons B.	BRO	6	7	7	1833	3	6	0	0	0	0	0	0	-22	1	6	2	0	2	0	0	0
29.12.2024 20:30	99	Martin T.	BRO	4	5	1	1215	1	3	0	0	0	1	2	2	13	1	4	2	0	1	1	0	0
28.12.2024 00:30	100	Johnson K.	BRO	25	4	3	2197	10	20	0	0	4	10	1	2	6	1	3	2	1	3	1	0	0
28.12.2024 00:30	101	Milton S.	BRO	16	3	12	2058	5	9	0	0	3	6	3	4	7	0	3	3	1	1	0	0	0
28.12.2024 00:30	102	Martin T.	BRO	13	6	0	1141	6	14	0	0	1	7	0	0	-9	1	5	1	1	2	0	0	0
28.12.2024 00:30	103	Claxton N.	BRO	11	10	0	1972	5	13	0	0	0	2	1	1	-5	4	6	2	3	4	2	0	0
28.12.2024 00:30	104	Wilson J.	BRO	11	2	3	2363	4	13	0	0	3	6	0	0	-12	0	2	4	0	2	0	0	0
28.12.2024 00:30	105	Clowney N.	BRO	5	5	1	1441	2	6	0	0	1	4	0	0	-13	1	4	5	1	1	0	0	0
28.12.2024 00:30	106	Sharpe D.	BRO	4	6	2	778	2	5	0	0	0	0	0	0	3	3	3	2	1	1	1	0	0
28.12.2024 00:30	107	Finney-Smith D.	BRO	2	9	0	1628	1	7	0	0	0	4	0	1	-6	2	7	1	0	1	0	0	0
28.12.2024 00:30	108	Beekman R.	BRO	0	0	1	822	0	3	0	0	0	2	0	0	-16	0	0	2	0	1	0	0	0
27.12.2024 01:00	109	Johnson C.	BRO	29	5	3	2111	8	13	0	0	4	6	9	9	8	1	4	1	0	6	0	0	0
27.12.2024 01:00	110	Clowney N.	BRO	20	4	2	1838	7	10	0	0	6	9	0	0	10	1	3	1	1	2	0	0	0
27.12.2024 01:00	111	Milton S.	BRO	20	2	0	1374	7	10	0	0	4	6	2	3	-6	1	1	1	1	2	0	0	0
27.12.2024 01:00	112	Claxton N.	BRO	13	7	3	1860	5	12	0	0	0	2	3	6	7	2	5	0	2	1	0	0	0
27.12.2024 01:00	113	Johnson K.	BRO	12	4	1	1813	5	15	0	0	2	9	0	0	0	0	4	4	2	0	1	0	0
27.12.2024 01:00	114	Simmons B.	BRO	8	4	9	1739	4	9	0	0	0	0	0	0	16	1	3	1	1	6	0	0	0
27.12.2024 01:00	115	Martin T.	BRO	5	5	2	1046	1	4	0	0	0	2	3	4	-4	0	5	1	0	1	0	0	0
27.12.2024 01:00	116	Wilson J.	BRO	4	4	5	1898	2	7	0	0	0	4	0	0	6	1	3	1	0	1	0	0	0
27.12.2024 01:00	117	Beekman R.	BRO	0	0	0	37	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
27.12.2024 01:00	118	Sharpe D.	BRO	0	3	0	684	0	2	0	0	0	0	0	0	-7	2	1	1	1	2	0	0	0
\.


--
-- Data for Name: brooklyn_nets_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.brooklyn_nets_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Claxton Nicolas	Lesionado	2025-01-16 10:43:12.042233
2	Melton De'Anthony	Lesionado	2025-01-16 10:43:12.120918
3	Russell D'Angelo	Lesionado	2025-01-16 10:43:12.122888
4	Thomas Cameron	Lesionado	2025-01-16 10:43:12.124603
5	Johnson Cameron	Lesionado	2025-01-16 10:43:12.126755
6	Lewis Maxwell	Lesionado	2025-01-16 10:43:12.129115
7	Watford Trendon	Lesionado	2025-01-16 10:43:12.131427
\.


--
-- Data for Name: charlotte_hornets; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.charlotte_hornets (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	10.07.2024	Sacramento Kings	82	Charlotte Hornets	86	17	28	9	28	20	20	24	22
2	13.07.2024	New York Knicks	90	Charlotte Hornets	94	12	28	23	27	23	24	20	27
3	16.07.2024	Denver Nuggets	66	Charlotte Hornets	80	15	21	15	15	22	17	20	21
4	17.07.2024	Charlotte Hornets	84	Boston Celtics	89	19	20	21	24	19	14	23	33
5	20.07.2024	Charlotte Hornets	84	Portland Trail Blazers	68	20	16	25	23	13	16	8	31
6	21.07.2024	Brooklyn Nets	90	Charlotte Hornets	97	21	27	22	20	19	31	26	21
7	06.10.2024	Charlotte Hornets	109	New York Knicks	111	35	26	29	19	29	32	26	24
8	09.10.2024	Charlotte Hornets	111	Miami Heat	108	29	29	31	22	28	34	19	27
9	11.10.2024	Memphis Grizzlies	94	Charlotte Hornets	119	32	17	22	23	35	27	20	37
10	16.10.2024	New York Knicks	111	Charlotte Hornets	105	24	41	27	19	30	33	26	16
11	18.10.2024\nApós Prol.	Indiana Pacers	121	Charlotte Hornets	116	29	20	24	33	25	36	24	21
12	24.10.2024	Houston Rockets	105	Charlotte Hornets	110	26	34	23	22	21	28	30	31
13	26.10.2024	Atlanta Hawks	125	Charlotte Hornets	120	28	34	26	37	16	42	27	35
14	27.10.2024	Charlotte Hornets	106	Miami Heat	114	23	25	24	34	23	33	27	31
15	30.10.2024	Charlotte Hornets	138	Toronto Raptors	133	30	34	39	35	16	43	37	37
16	01.11.2024	Charlotte Hornets	109	Boston Celtics	124	25	42	19	23	40	31	21	32
17	02.11.2024	Charlotte Hornets	103	Boston Celtics	113	24	26	24	29	38	30	17	28
18	05.11.2024	Minnesota Timberwolves	114	Charlotte Hornets	93	24	33	34	23	24	21	26	22
19	07.11.2024	Charlotte Hornets	108	Detroit Pistons	107	23	23	31	31	24	21	31	31
20	09.11.2024	Charlotte Hornets	103	Indiana Pacers	83	29	15	30	29	26	18	22	17
21	11.11.2024\nApós Prol.	Philadelphia 76ers	107	Charlotte Hornets	105	16	30	30	21	15	30	21	31
22	13.11.2024	Orlando Magic	114	Charlotte Hornets	89	31	27	31	25	29	18	19	23
23	16.11.2024	Charlotte Hornets	115	Milwaukee Bucks	114	33	26	27	29	39	24	27	24
24	17.11.2024	Cleveland Cavaliers	128	Charlotte Hornets	114	38	34	30	26	28	31	40	15
25	20.11.2024	Brooklyn Nets	116	Charlotte Hornets	115	23	31	31	31	37	22	28	28
26	22.11.2024\nApós Prol.	Charlotte Hornets	123	Detroit Pistons	121	33	30	30	16	27	32	20	30
27	24.11.2024	Milwaukee Bucks	125	Charlotte Hornets	119	28	31	37	29	28	23	34	34
28	26.11.2024	Charlotte Hornets	84	Orlando Magic	95	25	21	16	22	18	24	16	37
29	28.11.2024	Charlotte Hornets	94	Miami Heat	98	26	13	19	36	26	24	25	23
30	29.11.2024	Charlotte Hornets	98	New York Knicks	99	23	26	23	26	15	31	25	28
31	30.11.2024	Charlotte Hornets	104	Atlanta Hawks	107	32	18	26	28	29	26	22	30
32	04.12.2024	Charlotte Hornets	104	Philadelphia 76ers	110	20	24	25	35	32	23	25	30
33	06.12.2024	New York Knicks	125	Charlotte Hornets	101	30	35	38	22	32	30	16	23
34	07.12.2024	Charlotte Hornets	102	Cleveland Cavaliers	116	18	34	31	19	40	23	30	23
35	08.12.2024	Indiana Pacers	109	Charlotte Hornets	113	24	38	20	27	28	35	20	30
36	14.12.2024	Chicago Bulls	109	Charlotte Hornets	95	31	28	23	27	26	18	23	28
37	17.12.2024	Charlotte Hornets	108	Philadelphia 76ers	121	23	26	30	29	31	23	41	26
38	20.12.2024	Washington Wizards	123	Charlotte Hornets	114	29	31	27	36	30	28	28	28
39	21.12.2024	Philadelphia 76ers	108	Charlotte Hornets	98	41	17	27	23	23	23	25	27
40	24.12.2024	Charlotte Hornets	101	Houston Rockets	114	15	16	35	35	31	31	30	22
41	27.12.2024	Washington Wizards	113	Charlotte Hornets	110	34	34	28	17	29	25	33	23
42	28.12.2024	Charlotte Hornets	94	Oklahoma City Thunder	106	22	24	28	20	28	33	29	16
43	31.12.2024\nApós Prol.	Charlotte Hornets	108	Chicago Bulls	115	24	22	25	27	15	37	21	25
44	04.01. 00:00	Detroit Pistons	98	Charlotte Hornets	94	26	26	32	14	31	34	17	12
45	05.01. 23:00	Cleveland Cavaliers	115	Charlotte Hornets	105	29	34	28	24	23	25	30	27
46	08.01. 00:00	Charlotte Hornets	115	Phoenix Suns	104	22	37	29	27	29	17	37	21
47	13.01. 02:00	Phoenix Suns	120	Charlotte Hornets	113	28	34	31	27	34	28	36	15
48	16.01. 02:00	Utah Jazz	112	Charlotte Hornets	117	33	29	25	25	26	29	25	37
\.


--
-- Data for Name: charlotte_hornets_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.charlotte_hornets_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 02:00	1	Williams M.	CHA	31	13	2	2175	12	14	0	0	0	0	7	10	17	6	7	1	2	0	1	0	0
16.01.2025 02:00	2	Ball La.	CHA	27	6	9	2343	11	21	0	0	2	9	3	3	16	0	6	4	0	6	3	0	0
16.01.2025 02:00	3	Bridges M.	CHA	25	10	4	2335	9	16	0	0	3	7	4	4	25	2	8	3	1	1	1	0	0
16.01.2025 02:00	4	Miller B.	CHA	20	5	3	1983	8	18	0	0	3	10	1	4	12	2	3	2	3	5	1	0	0
16.01.2025 02:00	5	Martin Co.	CHA	9	2	0	1403	3	6	0	0	3	4	0	0	-2	0	2	0	0	2	0	0	0
16.01.2025 02:00	6	Green J.	CHA	3	3	1	1326	1	2	0	0	1	2	0	0	11	1	2	1	0	0	0	0	0
16.01.2025 02:00	7	Micic V.	CHA	2	3	3	596	1	1	0	0	0	0	0	0	-9	0	3	1	0	2	0	0	0
16.01.2025 02:00	8	Curry S.	CHA	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
16.01.2025 02:00	9	Gibson T.	CHA	0	1	0	429	0	0	0	0	0	0	0	0	-16	0	1	2	0	0	0	0	0
16.01.2025 02:00	10	Salaun T.	CHA	0	1	1	820	0	2	0	0	0	2	0	0	-16	0	1	1	0	1	0	0	0
16.01.2025 02:00	11	Smith N.	CHA	0	1	4	989	0	5	0	0	0	5	0	0	-13	0	1	1	0	1	0	0	0
13.01.2025 02:00	12	Ball La.	CHA	25	6	11	2371	9	25	0	0	5	17	2	2	3	1	5	3	3	3	1	0	0
13.01.2025 02:00	13	Williams M.	CHA	24	16	4	1766	9	12	0	0	0	0	6	10	8	6	10	2	0	3	1	0	1
13.01.2025 02:00	14	Bridges M.	CHA	21	5	5	1922	8	15	0	0	3	5	2	2	8	0	5	3	0	2	0	0	0
13.01.2025 02:00	15	Miller B.	CHA	19	4	6	2000	6	16	0	0	3	8	4	4	-3	1	3	4	0	1	0	0	0
13.01.2025 02:00	16	Smith N.	CHA	8	3	0	1053	3	10	0	0	2	4	0	0	-15	0	3	1	1	2	0	0	0
13.01.2025 02:00	17	Martin Co.	CHA	5	3	1	1508	1	3	0	0	1	2	2	2	-12	1	2	2	2	1	0	0	0
13.01.2025 02:00	18	Micic V.	CHA	5	1	1	509	2	2	0	0	1	1	0	0	-10	0	1	2	0	1	0	0	0
13.01.2025 02:00	19	Richards N.	CHA	4	5	2	1074	2	4	0	0	0	0	0	0	-13	4	1	0	1	1	0	0	1
13.01.2025 02:00	20	Green J.	CHA	2	7	0	1813	1	4	0	0	0	3	0	0	5	2	5	2	3	1	0	0	0
13.01.2025 02:00	21	Salaun T.	CHA	0	2	0	384	0	1	0	0	0	0	0	0	-6	0	2	1	0	1	0	0	0
08.01.2025 00:00	22	Ball La.	CHA	32	10	7	2109	12	28	0	0	5	16	3	5	0	5	5	3	4	1	0	0	0
08.01.2025 00:00	23	Bridges M.	CHA	21	7	3	2206	8	17	0	0	2	5	3	3	5	1	6	4	2	1	0	0	0
08.01.2025 00:00	24	Richards N.	CHA	15	12	0	1518	4	6	0	0	0	0	7	8	23	5	7	2	0	2	3	0	0
08.01.2025 00:00	25	Miller B.	CHA	13	3	2	1955	5	16	0	0	3	12	0	0	0	0	3	3	1	4	1	0	0
08.01.2025 00:00	26	Williams M.	CHA	9	10	3	1293	2	7	0	0	0	0	5	5	-12	4	6	1	0	3	0	0	0
08.01.2025 00:00	27	Smith N.	CHA	8	4	3	1266	3	8	0	0	2	6	0	0	11	1	3	0	0	0	0	0	0
08.01.2025 00:00	28	Green J.	CHA	5	6	0	776	1	3	0	0	1	2	2	2	1	3	3	4	1	0	0	0	0
08.01.2025 00:00	29	Martin Co.	CHA	4	5	3	1729	1	5	0	0	0	2	2	2	15	1	4	2	1	0	1	0	0
08.01.2025 00:00	30	Micic V.	CHA	4	0	2	874	1	5	0	0	0	2	2	2	6	0	0	0	0	0	0	0	0
08.01.2025 00:00	31	Salaun T.	CHA	4	2	0	674	1	3	0	0	0	2	2	2	6	0	2	0	0	0	0	0	0
05.01.2025 23:00	32	Ball La.	CHA	24	3	4	1992	7	20	0	0	3	11	7	9	-7	1	2	3	0	3	0	0	1
05.01.2025 23:00	33	Miller B.	CHA	24	2	2	1900	8	14	0	0	6	10	2	3	-27	1	1	2	0	1	1	0	0
05.01.2025 23:00	34	Smith N.	CHA	18	5	2	1163	7	12	0	0	4	6	0	0	7	0	5	1	0	0	1	0	0
05.01.2025 23:00	35	Bridges M.	CHA	11	8	3	1589	5	14	0	0	1	6	0	0	-14	1	7	3	1	1	0	0	0
05.01.2025 23:00	36	Williams M.	CHA	11	9	1	1700	4	7	0	0	0	0	3	3	-9	1	8	5	1	2	1	0	0
05.01.2025 23:00	37	Martin Co.	CHA	8	6	5	1295	4	5	0	0	0	0	0	0	12	1	5	2	4	2	0	0	0
05.01.2025 23:00	38	Salaun T.	CHA	6	9	1	1354	2	8	0	0	1	5	1	2	6	5	4	1	1	2	0	0	0
05.01.2025 23:00	39	Simpson K.	CHA	2	1	0	782	1	4	0	0	0	1	0	0	2	1	0	1	0	2	0	0	0
05.01.2025 23:00	40	Gibson T.	CHA	1	0	0	479	0	0	0	0	0	0	1	2	8	0	0	0	0	0	1	0	0
05.01.2025 23:00	41	Green J.	CHA	0	1	1	1339	0	4	0	0	0	3	0	0	-13	1	0	0	2	1	0	0	0
05.01.2025 23:00	42	Micic V.	CHA	0	0	0	321	0	1	0	0	0	0	0	0	-8	0	0	0	0	1	0	0	0
05.01.2025 23:00	43	Richards N.	CHA	0	4	0	486	0	2	0	0	0	0	0	0	-7	1	3	0	0	0	0	0	0
04.01.2025 00:00	44	Bridges M.	CHA	20	9	5	2349	5	16	0	0	3	7	7	9	-3	0	9	2	2	6	1	0	0
04.01.2025 00:00	45	Williams M.	CHA	18	9	1	1699	7	12	0	0	0	1	4	5	-14	4	5	3	0	3	1	0	0
04.01.2025 00:00	46	Richards N.	CHA	10	4	5	1037	4	7	0	0	0	0	2	3	11	2	2	0	0	1	2	0	0
04.01.2025 00:00	47	Curry S.	CHA	9	3	2	1432	3	5	0	0	2	4	1	1	-5	0	3	1	1	1	0	0	0
04.01.2025 00:00	48	Green J.	CHA	9	4	2	2109	3	8	0	0	1	5	2	2	-5	1	3	2	1	1	0	0	0
04.01.2025 00:00	49	Salaun T.	CHA	9	1	1	1160	4	7	0	0	0	3	1	3	0	0	1	0	2	1	0	0	0
04.01.2025 00:00	50	Simpson K.	CHA	8	3	1	1533	3	10	0	0	2	4	0	2	-5	2	1	1	2	0	0	0	0
04.01.2025 00:00	51	Martin Co.	CHA	4	7	2	1202	2	5	0	0	0	0	0	2	3	0	7	1	0	0	2	0	0
04.01.2025 00:00	52	Micic V.	CHA	4	3	5	1443	1	8	0	0	0	5	2	3	-1	0	3	0	0	4	0	0	0
04.01.2025 00:00	53	Smith N.	CHA	3	2	1	436	1	2	0	0	1	1	0	0	-1	0	2	0	0	0	0	0	0
31.12.2024 00:00	54	Bridges M.	CHA	31	12	8	2171	13	32	0	0	2	13	3	3	2	1	11	2	0	3	0	0	0
31.12.2024 00:00	55	Williams M.	CHA	20	12	2	1880	9	9	0	0	0	0	2	2	12	2	10	1	2	1	3	0	0
31.12.2024 00:00	56	Curry S.	CHA	17	2	1	2000	7	13	0	0	3	7	0	0	-2	1	1	2	0	2	0	0	0
31.12.2024 00:00	57	Green J.	CHA	14	6	1	2271	4	8	0	0	3	6	3	3	1	3	3	5	0	2	0	0	0
31.12.2024 00:00	58	Micic V.	CHA	7	3	7	2096	1	13	0	0	1	8	4	5	5	0	3	2	2	2	0	0	0
31.12.2024 00:00	59	Jeffries D.	CHA	6	3	0	1306	3	4	0	0	0	0	0	0	-6	0	3	1	1	0	1	0	0
31.12.2024 00:00	60	Simpson K.	CHA	6	2	1	849	2	7	0	0	0	4	2	3	-13	0	2	0	2	1	0	0	0
31.12.2024 00:00	61	Salaun T.	CHA	3	8	2	1009	1	6	0	0	1	3	0	0	-9	0	8	3	0	0	0	0	0
31.12.2024 00:00	62	Richards N.	CHA	2	2	0	768	1	2	0	0	0	0	0	2	-13	0	2	3	0	2	2	0	0
31.12.2024 00:00	63	Wong I.	CHA	2	3	1	1021	1	7	0	0	0	2	0	2	-6	2	1	0	1	1	0	0	0
31.12.2024 00:00	64	Diabate M.	CHA	0	3	0	529	0	0	0	0	0	0	0	0	-6	0	3	1	0	0	0	0	0
28.12.2024 23:00	65	Bridges M.	CHA	19	10	6	2309	5	16	0	0	1	8	8	8	-3	1	9	1	1	3	2	0	0
28.12.2024 23:00	66	Micic V.	CHA	16	2	4	1755	6	13	0	0	4	7	0	0	-13	0	2	1	1	5	0	0	0
28.12.2024 23:00	67	Curry S.	CHA	12	2	0	1319	4	8	0	0	1	2	3	3	-19	1	1	1	0	0	1	0	0
28.12.2024 23:00	68	Williams M.	CHA	12	10	2	1335	4	9	0	0	0	0	4	5	-15	2	8	3	0	1	1	0	0
28.12.2024 23:00	69	Green J.	CHA	10	2	1	2355	3	9	0	0	3	6	1	2	-12	0	2	3	3	2	0	0	0
28.12.2024 23:00	70	Wong I.	CHA	10	0	1	1125	2	8	0	0	0	3	6	6	1	0	0	1	1	1	0	0	0
28.12.2024 23:00	71	Salaun T.	CHA	9	5	1	1885	3	10	0	0	1	4	2	2	-1	1	4	3	1	2	1	0	0
28.12.2024 23:00	72	Jeffries D.	CHA	5	3	1	772	2	5	0	0	1	4	0	0	-1	1	2	2	0	2	0	0	0
28.12.2024 23:00	73	Richards N.	CHA	1	7	0	715	0	1	0	0	0	0	1	2	0	2	5	1	0	1	0	0	0
28.12.2024 23:00	74	Diabate M.	CHA	0	3	1	830	0	1	0	0	0	0	0	0	3	0	3	0	2	1	0	0	0
27.12.2024 00:00	75	Ball La.	CHA	31	6	6	2275	12	27	0	0	4	13	3	3	-10	0	6	2	1	5	0	0	0
27.12.2024 00:00	76	Bridges M.	CHA	22	14	6	2023	8	17	0	0	4	9	2	2	1	1	13	0	1	2	2	0	0
27.12.2024 00:00	77	Miller B.	CHA	18	3	9	2182	6	21	0	0	4	12	2	2	6	0	3	3	1	1	0	0	0
27.12.2024 00:00	78	Williams M.	CHA	16	8	5	1588	8	11	0	0	0	0	0	0	6	2	6	4	1	0	0	0	0
27.12.2024 00:00	79	Micic V.	CHA	6	0	1	605	2	3	0	0	2	3	0	0	7	0	0	1	1	1	0	0	0
27.12.2024 00:00	80	Richards N.	CHA	6	5	1	959	2	5	0	0	0	0	2	3	-3	1	4	4	0	3	0	0	0
27.12.2024 00:00	81	Salaun T.	CHA	6	4	0	793	2	3	0	0	2	2	0	0	1	2	2	0	0	0	0	0	0
27.12.2024 00:00	82	Green J.	CHA	3	3	2	1792	1	2	0	0	1	2	0	2	-6	2	1	3	1	1	2	0	0
27.12.2024 00:00	83	Martin Co.	CHA	2	4	1	1113	0	1	0	0	0	0	2	2	-1	2	2	4	0	2	0	0	0
27.12.2024 00:00	84	Diabate M.	CHA	0	3	0	326	0	1	0	0	0	0	0	0	-5	1	2	0	0	2	0	0	0
27.12.2024 00:00	85	Jeffries D.	CHA	0	0	0	419	0	1	0	0	0	0	0	0	-14	0	0	1	0	1	0	0	0
27.12.2024 00:00	86	Wong I.	CHA	0	0	0	325	0	2	0	0	0	1	0	0	3	0	0	1	0	0	0	0	0
24.12.2024 00:00	87	Bridges M.	CHA	24	8	3	1740	9	17	0	0	2	6	4	4	-7	0	8	0	1	2	0	0	0
24.12.2024 00:00	88	Ball La.	CHA	23	5	8	1829	9	18	0	0	5	11	0	0	-6	1	4	1	0	0	1	0	0
24.12.2024 00:00	89	Diabate M.	CHA	14	5	0	958	6	6	0	0	0	0	2	4	12	1	4	0	0	0	0	0	0
24.12.2024 00:00	90	Williams M.	CHA	12	9	3	1143	4	8	0	0	0	0	4	5	-14	2	7	3	1	1	0	0	0
24.12.2024 00:00	91	Martin Co.	CHA	6	5	4	1890	3	10	0	0	0	5	0	0	-3	2	3	1	2	2	2	0	0
24.12.2024 00:00	92	Richards N.	CHA	6	4	0	779	1	3	0	0	0	0	4	7	-11	0	4	3	0	0	0	0	0
24.12.2024 00:00	93	Jeffries D.	CHA	4	1	0	1148	1	6	0	0	0	2	2	2	-13	1	0	3	2	1	2	0	0
24.12.2024 00:00	94	Smith N.	CHA	4	0	0	206	1	1	0	0	1	1	1	2	6	0	0	0	0	0	0	0	0
24.12.2024 00:00	95	Green J.	CHA	3	2	1	1836	1	4	0	0	1	4	0	0	-6	1	1	3	0	1	0	0	1
24.12.2024 00:00	96	Micic V.	CHA	3	0	2	858	1	6	0	0	1	4	0	0	-15	0	0	0	0	2	0	0	0
24.12.2024 00:00	97	Wong I.	CHA	2	2	2	484	1	4	0	0	0	1	0	0	-1	2	0	0	1	0	0	0	0
24.12.2024 00:00	98	Curry S.	CHA	0	0	0	389	0	2	0	0	0	0	0	0	-1	0	0	0	0	0	0	0	0
24.12.2024 00:00	99	Salaun T.	CHA	0	3	2	1140	0	4	0	0	0	2	0	0	-6	1	2	1	1	2	1	0	0
21.12.2024 00:00	100	Micic V.	CHA	20	1	4	1987	7	14	0	0	3	8	3	3	-9	0	1	0	0	1	0	0	0
21.12.2024 00:00	101	Bridges M.	CHA	15	7	1	1724	4	13	0	0	1	7	6	6	-19	1	6	2	1	5	2	0	0
21.12.2024 00:00	102	Jeffries D.	CHA	12	5	1	1778	5	9	0	0	2	4	0	0	6	1	4	3	1	0	1	0	0
21.12.2024 00:00	103	Martin Co.	CHA	11	5	3	1216	5	10	0	0	1	3	0	0	-14	0	5	2	2	1	0	0	0
21.12.2024 00:00	104	Wong I.	CHA	11	1	4	936	4	7	0	0	1	2	2	4	2	1	0	1	0	2	0	0	0
21.12.2024 00:00	105	Richards N.	CHA	10	6	3	1772	4	7	0	0	0	0	2	4	-14	2	4	3	0	3	1	0	0
21.12.2024 00:00	106	Salaun T.	CHA	8	8	5	1412	3	8	0	0	2	5	0	0	3	4	4	2	2	1	0	0	0
21.12.2024 00:00	107	Diabate M.	CHA	7	7	0	1108	2	4	0	0	0	0	3	4	4	3	4	2	0	1	0	0	0
21.12.2024 00:00	108	Green J.	CHA	4	3	0	1950	2	4	0	0	0	1	0	0	-6	1	2	4	1	3	0	0	0
21.12.2024 00:00	109	Curry S.	CHA	0	1	1	517	0	2	0	0	0	1	0	0	-3	0	1	0	0	0	0	0	0
20.12.2024 00:00	110	Ball La.	CHA	34	4	13	2012	11	32	0	0	3	18	9	10	3	1	3	3	4	1	0	0	0
20.12.2024 00:00	111	Bridges M.	CHA	16	8	3	1913	7	16	0	0	0	4	2	3	-7	1	7	2	0	2	0	0	0
20.12.2024 00:00	112	Williams M.	CHA	16	8	1	1144	7	12	0	0	0	0	2	3	3	3	5	1	1	0	1	0	0
20.12.2024 00:00	113	Martin Co.	CHA	14	2	1	1557	5	9	0	0	1	5	3	3	-12	1	1	0	2	2	0	0	0
20.12.2024 00:00	114	Curry S.	CHA	8	4	3	1905	3	9	0	0	2	7	0	0	4	1	3	4	3	0	0	0	0
20.12.2024 00:00	115	Richards N.	CHA	8	7	1	1013	3	6	0	0	0	0	2	4	-13	5	2	2	0	0	0	0	0
20.12.2024 00:00	116	Green J.	CHA	5	2	2	1434	2	7	0	0	1	4	0	0	0	2	0	5	0	1	0	0	0
20.12.2024 00:00	117	Diabate M.	CHA	4	7	2	695	2	2	0	0	0	0	0	0	3	4	3	2	0	0	1	0	0
20.12.2024 00:00	118	Micic V.	CHA	4	3	1	955	1	4	0	0	0	0	2	2	-17	2	1	1	2	1	0	0	0
20.12.2024 00:00	119	Salaun T.	CHA	3	4	1	967	1	5	0	0	1	4	0	0	-2	2	2	1	0	0	0	0	0
20.12.2024 00:00	120	Wong I.	CHA	2	3	2	805	1	4	0	0	0	1	0	2	-7	0	3	0	0	1	0	0	0
17.12.2024 00:00	121	Bridges M.	CHA	24	6	4	1694	10	19	0	0	2	8	2	3	2	1	5	1	0	3	0	0	0
17.12.2024 00:00	122	Richards N.	CHA	19	5	0	914	7	9	0	0	0	0	5	6	-5	1	4	2	1	3	1	0	0
17.12.2024 00:00	123	Ball La.	CHA	15	5	11	1550	5	15	0	0	3	8	2	4	-10	0	5	3	4	3	0	0	0
17.12.2024 00:00	124	Miller B.	CHA	12	4	4	1872	4	9	0	0	2	7	2	3	-3	0	4	2	0	2	1	0	0
17.12.2024 00:00	125	Green J.	CHA	10	2	0	1789	4	8	0	0	2	6	0	1	-11	1	1	4	4	1	1	0	0
17.12.2024 00:00	126	Martin Co.	CHA	10	5	2	1739	4	7	0	0	2	5	0	0	-9	1	4	5	2	1	1	0	0
17.12.2024 00:00	127	Williams M.	CHA	7	3	3	1024	3	5	0	0	0	0	1	2	-11	1	2	3	0	1	3	0	1
17.12.2024 00:00	128	Wong I.	CHA	7	2	0	813	3	4	0	0	1	1	0	0	2	2	0	2	0	1	0	0	0
17.12.2024 00:00	129	Diabate M.	CHA	4	3	0	942	2	2	0	0	0	0	0	0	3	2	1	3	1	1	0	0	0
17.12.2024 00:00	130	Micic V.	CHA	0	1	5	967	0	3	0	0	0	1	0	0	-14	0	1	1	0	3	0	0	0
17.12.2024 00:00	131	Salaun T.	CHA	0	2	1	1096	0	2	0	0	0	2	0	2	-9	0	2	1	0	1	1	0	0
\.


--
-- Data for Name: charlotte_hornets_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.charlotte_hornets_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Mann Tre	Lesionado	2025-01-16 10:43:21.876333
2	Williams Grant	Lesionado	2025-01-16 10:43:21.893695
\.


--
-- Data for Name: chicago_bulls; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.chicago_bulls (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	13.07.2024	Chicago Bulls	96	Milwaukee Bucks	89	26	24	30	16	27	19	20	23
2	15.07.2024	Golden State Warriors	92	Chicago Bulls	82	24	19	27	22	23	17	19	23
3	16.07.2024	Detroit Pistons	85	Chicago Bulls	77	17	21	24	23	31	13	20	13
4	19.07.2024\nApós Prol.	Chicago Bulls	103	Atlanta Hawks	99	24	34	18	20	17	25	26	28
5	21.07.2024	Los Angeles Lakers	107	Chicago Bulls	81	39	17	16	35	18	18	22	23
6	09.10.2024	Cleveland Cavaliers	112	Chicago Bulls	116	31	36	18	27	24	30	34	28
7	13.10.2024	Chicago Bulls	121	Memphis Grizzlies	124	28	37	28	28	28	23	40	33
8	15.10.2024	Milwaukee Bucks	111	Chicago Bulls	107	24	35	32	20	34	34	15	24
9	17.10.2024	Chicago Bulls	125	Minnesota Timberwolves	123	30	41	27	27	33	25	32	33
10	19.10.2024\nApós Prol.	Chicago Bulls	139	Cleveland Cavaliers	137	25	29	38	38	31	30	32	37
11	24.10.2024	New Orleans Pelicans	123	Chicago Bulls	111	29	30	36	28	25	33	25	28
12	26.10.2024	Milwaukee Bucks	122	Chicago Bulls	133	32	32	31	27	30	33	39	31
13	27.10.2024	Chicago Bulls	95	Oklahoma City Thunder	114	21	18	26	30	26	33	29	26
14	29.10.2024	Memphis Grizzlies	123	Chicago Bulls	126	32	36	32	23	22	32	39	33
15	31.10.2024	Chicago Bulls	102	Orlando Magic	99	18	34	34	16	33	29	25	12
16	01.11.2024	Brooklyn Nets	120	Chicago Bulls	112	37	31	24	28	30	30	30	22
17	05.11.2024	Chicago Bulls	126	Utah Jazz	135	27	26	40	33	30	32	33	40
18	07.11.2024	Dallas Mavericks	119	Chicago Bulls	99	32	24	32	31	24	21	23	31
19	08.11.2024	Chicago Bulls	119	Minnesota Timberwolves	135	34	31	30	24	28	28	34	45
20	10.11.2024	Atlanta Hawks	113	Chicago Bulls	125	37	33	28	15	24	36	30	35
21	12.11.2024	Chicago Bulls	113	Cleveland Cavaliers	119	35	31	26	21	34	33	28	24
22	14.11.2024	New York Knicks	123	Chicago Bulls	124	22	25	38	38	29	30	31	34
23	16.11.2024	Cleveland Cavaliers	144	Chicago Bulls	126	49	28	30	37	34	39	29	24
24	18.11.2024	Chicago Bulls	107	Houston Rockets	143	26	26	26	29	27	41	40	35
25	19.11.2024	Detroit Pistons	112	Chicago Bulls	122	25	32	28	27	36	29	28	29
26	21.11.2024	Milwaukee Bucks	122	Chicago Bulls	106	36	33	29	24	30	27	33	16
27	23.11.2024	Chicago Bulls	136	Atlanta Hawks	122	28	30	41	37	25	26	33	38
28	24.11.2024	Chicago Bulls	131	Memphis Grizzlies	142	22	38	38	33	30	34	45	33
29	27.11.2024	Washington Wizards	108	Chicago Bulls	127	29	18	34	27	21	40	35	31
30	28.11.2024	Orlando Magic	133	Chicago Bulls	119	38	35	32	28	25	29	34	31
31	30.11.2024	Chicago Bulls	129	Boston Celtics	138	30	37	29	33	39	28	29	42
32	03.12.2024	Chicago Bulls	128	Brooklyn Nets	102	29	27	36	36	29	21	22	30
33	06.12.2024	San Antonio Spurs	124	Chicago Bulls	139	22	35	40	27	36	37	35	31
34	07.12.2024	Chicago Bulls	123	Indiana Pacers	132	35	19	39	30	31	36	36	29
35	08.12.2024	Chicago Bulls	100	Philadelphia 76ers	108	33	17	29	21	23	39	26	20
36	14.12.2024	Chicago Bulls	109	Charlotte Hornets	95	31	28	23	27	26	18	23	28
37	17.12.2024	Toronto Raptors	121	Chicago Bulls	122	25	25	34	37	33	20	42	27
38	20.12.2024	Boston Celtics	108	Chicago Bulls	117	25	32	29	22	21	33	28	35
39	22.12.2024	Chicago Bulls	98	Boston Celtics	123	28	26	23	21	28	33	32	30
40	24.12.2024	Chicago Bulls	91	Milwaukee Bucks	112	17	28	27	19	33	26	33	20
41	27.12.2024	Atlanta Hawks	141	Chicago Bulls	133	21	32	38	50	33	31	44	25
42	29.12.2024	Chicago Bulls	116	Milwaukee Bucks	111	33	29	21	33	25	35	24	27
43	31.12.2024\nApós Prol.	Charlotte Hornets	108	Chicago Bulls	115	24	22	25	27	15	37	21	25
44	02.01. 00:00	Washington Wizards	125	Chicago Bulls	107	27	28	36	34	25	26	29	27
45	05.01. 01:00	Chicago Bulls	139	New York Knicks	126	29	34	41	35	33	39	17	37
46	07.01. 01:00	Chicago Bulls	114	San Antonio Spurs	110	20	30	32	32	29	36	30	15
47	09.01. 00:00	Indiana Pacers	129	Chicago Bulls	113	29	34	37	29	18	26	32	37
48	11.01. 01:00	Chicago Bulls	138	Washington Wizards	105	36	32	41	29	26	32	24	23
49	12.01. 20:30	Chicago Bulls	119	Sacramento Kings	124	30	33	32	24	32	29	36	27
50	15.01. 01:00	Chicago Bulls	113	New Orleans Pelicans	119	33	26	27	27	29	24	33	33
51	16.01. 01:00	Chicago Bulls	94	Atlanta Hawks	110	25	22	31	16	27	34	25	24
\.


--
-- Data for Name: chicago_bulls_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.chicago_bulls_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 01:00	1	White C.	CHI	16	2	6	1952	5	14	0	0	1	7	5	5	-12	0	2	2	1	3	1	0	0
16.01.2025 01:00	2	LaVine Z.	CHI	15	6	7	2130	7	13	0	0	1	2	0	0	-10	0	6	2	2	3	0	0	0
16.01.2025 01:00	3	Vucevic N.	CHI	14	16	4	2050	6	14	0	0	0	3	2	2	-3	4	12	2	0	3	0	0	0
16.01.2025 01:00	4	Phillips J.	CHI	10	4	0	827	4	5	0	0	0	1	2	2	0	2	2	0	0	1	0	0	0
16.01.2025 01:00	5	Williams P.	CHI	10	2	0	1472	4	8	0	0	2	3	0	0	-14	0	2	0	0	0	0	0	0
16.01.2025 01:00	6	Dosunmu A.	CHI	9	3	2	1507	4	7	0	0	0	1	1	1	12	1	2	1	2	1	0	0	0
16.01.2025 01:00	7	Buzelis M.	CHI	8	5	0	1049	4	8	0	0	0	3	0	0	-18	0	5	1	0	0	3	0	0
16.01.2025 01:00	8	Giddey J.	CHI	7	10	3	1788	3	8	0	0	1	2	0	0	-20	0	10	3	0	3	1	0	0
16.01.2025 01:00	9	Smith J.	CHI	5	4	0	744	2	6	0	0	1	3	0	0	-11	1	3	1	0	2	0	0	0
16.01.2025 01:00	10	Carter J.	CHI	0	0	0	256	0	2	0	0	0	1	0	0	5	0	0	1	0	1	0	0	0
16.01.2025 01:00	11	Duarte C.	CHI	0	1	0	86	0	0	0	0	0	0	0	0	-2	0	1	0	0	0	0	0	0
16.01.2025 01:00	12	Horton-Tucker T.	CHI	0	0	0	203	0	1	0	0	0	1	0	0	-5	0	0	0	0	1	0	0	0
16.01.2025 01:00	13	Terry D.	CHI	0	0	1	336	0	2	0	0	0	0	0	0	-2	0	0	2	0	2	0	0	0
15.01.2025 01:00	14	LaVine Z.	CHI	25	7	5	2282	10	22	0	0	4	6	1	3	6	0	7	2	1	5	0	0	0
15.01.2025 01:00	15	Vucevic N.	CHI	22	15	2	2122	10	16	0	0	1	2	1	2	6	7	8	3	1	3	1	0	0
15.01.2025 01:00	16	White C.	CHI	22	3	4	2019	8	17	0	0	1	8	5	5	-6	0	3	3	0	0	0	0	0
15.01.2025 01:00	17	Smith J.	CHI	13	4	0	832	6	9	0	0	1	4	0	0	-17	3	1	2	0	1	0	0	0
15.01.2025 01:00	18	Ball L.	CHI	11	8	6	1490	4	10	0	0	3	8	0	0	10	3	5	4	1	3	1	0	0
15.01.2025 01:00	19	Williams P.	CHI	8	1	1	1203	3	7	0	0	2	4	0	0	-19	0	1	2	0	1	1	0	0
15.01.2025 01:00	20	Giddey J.	CHI	7	13	12	2027	2	12	0	0	1	6	2	2	-8	5	8	2	4	2	1	0	0
15.01.2025 01:00	21	Buzelis M.	CHI	5	4	0	716	2	6	0	0	1	3	0	0	-2	0	4	0	0	0	0	0	0
15.01.2025 01:00	22	Horton-Tucker T.	CHI	0	0	0	494	0	1	0	0	0	0	0	0	6	0	0	0	0	0	0	0	0
15.01.2025 01:00	23	Phillips J.	CHI	0	2	1	847	0	2	0	0	0	2	0	0	1	0	2	0	0	0	2	0	0
15.01.2025 01:00	24	Terry D.	CHI	0	0	0	368	0	0	0	0	0	0	0	0	-7	0	0	1	1	0	0	0	0
12.01.2025 20:30	25	LaVine Z.	CHI	36	10	4	2250	12	24	0	0	5	8	7	7	5	2	8	0	1	2	0	0	0
12.01.2025 20:30	26	Vucevic N.	CHI	18	7	3	1987	8	15	0	0	1	4	1	3	2	1	6	4	1	2	0	0	0
12.01.2025 20:30	27	Ball L.	CHI	15	1	3	1543	5	9	0	0	5	8	0	0	-3	0	1	2	0	0	1	0	0
12.01.2025 20:30	28	Giddey J.	CHI	12	11	7	2191	4	9	0	0	1	2	3	4	2	2	9	4	1	3	0	0	0
12.01.2025 20:30	29	Horton-Tucker T.	CHI	10	2	0	1043	3	8	0	0	3	4	1	2	-12	0	2	1	0	0	0	0	0
12.01.2025 20:30	30	Smith J.	CHI	9	5	1	893	3	8	0	0	1	4	2	3	-7	1	4	2	0	0	0	0	0
12.01.2025 20:30	31	Williams P.	CHI	8	5	5	2052	3	12	0	0	1	5	1	1	-3	0	5	2	1	0	2	0	0
12.01.2025 20:30	32	Buzelis M.	CHI	5	2	0	770	2	2	0	0	1	1	0	0	-3	1	1	2	0	0	0	0	0
12.01.2025 20:30	33	Phillips J.	CHI	4	1	0	787	2	3	0	0	0	0	0	0	-8	1	0	0	0	0	0	0	0
12.01.2025 20:30	34	Terry D.	CHI	2	1	3	884	1	3	0	0	0	1	0	0	2	0	1	1	0	0	1	0	0
11.01.2025 01:00	35	LaVine Z.	CHI	33	5	3	1977	14	21	0	0	3	7	2	4	34	0	5	0	1	1	0	0	0
11.01.2025 01:00	36	Vucevic N.	CHI	23	13	6	1626	9	12	0	0	4	6	1	3	29	3	10	1	0	0	1	0	0
11.01.2025 01:00	37	Smith J.	CHI	15	6	4	1049	5	6	0	0	3	4	2	3	3	2	4	1	0	0	1	0	0
11.01.2025 01:00	38	White C.	CHI	15	4	6	1675	5	12	0	0	3	9	2	2	11	1	3	0	0	4	1	0	0
11.01.2025 01:00	39	Ball L.	CHI	12	1	6	1326	4	7	0	0	4	7	0	0	14	1	0	1	3	1	1	0	0
11.01.2025 01:00	40	Giddey J.	CHI	12	13	7	1894	5	11	0	0	2	4	0	0	23	2	11	0	3	1	0	0	0
11.01.2025 01:00	41	Horton-Tucker T.	CHI	12	3	3	879	5	8	0	0	2	4	0	0	13	0	3	2	0	2	0	0	0
11.01.2025 01:00	42	Buzelis M.	CHI	8	3	0	940	3	4	0	0	2	3	0	0	13	0	3	2	0	2	2	0	0
11.01.2025 01:00	43	Carter J.	CHI	4	1	0	239	1	1	0	0	0	0	2	2	6	0	1	0	0	0	1	0	0
11.01.2025 01:00	44	Phillips J.	CHI	2	2	0	773	1	3	0	0	0	1	0	0	10	1	1	0	0	0	0	0	0
11.01.2025 01:00	45	Williams P.	CHI	2	3	3	1164	1	8	0	0	0	4	0	0	8	1	2	3	3	2	0	0	0
11.01.2025 01:00	46	Duarte C.	CHI	0	0	0	205	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0
11.01.2025 01:00	47	Terry D.	CHI	0	1	1	653	0	2	0	0	0	0	0	0	0	0	1	2	1	0	0	0	0
09.01.2025 00:00	48	LaVine Z.	CHI	31	4	4	2095	12	20	0	0	2	6	5	6	-20	0	4	2	0	3	1	0	0
09.01.2025 00:00	49	White C.	CHI	19	2	5	1863	8	17	0	0	3	10	0	1	-13	0	2	2	0	2	0	0	0
09.01.2025 00:00	50	Smith J.	CHI	13	7	3	1011	4	4	0	0	2	2	3	3	3	2	5	3	0	2	1	0	0
09.01.2025 00:00	51	Vucevic N.	CHI	10	7	1	1616	5	9	0	0	0	0	0	0	-22	2	5	1	0	1	2	0	0
09.01.2025 00:00	52	Giddey J.	CHI	9	5	5	1307	4	7	0	0	1	2	0	0	-8	2	3	2	1	5	0	0	1
09.01.2025 00:00	53	Horton-Tucker T.	CHI	8	0	0	610	3	4	0	0	1	1	1	1	11	0	0	0	1	0	0	0	0
09.01.2025 00:00	54	Phillips J.	CHI	6	2	0	893	2	4	0	0	1	2	1	2	4	1	1	2	0	1	0	0	0
09.01.2025 00:00	55	Ball L.	CHI	5	3	1	1155	2	6	0	0	1	5	0	0	-7	0	3	1	2	2	1	0	0
09.01.2025 00:00	56	Duarte C.	CHI	5	3	3	866	2	5	0	0	1	2	0	0	-8	1	2	2	0	0	0	0	0
09.01.2025 00:00	57	Buzelis M.	CHI	2	2	0	783	1	2	0	0	0	1	0	0	2	1	1	4	1	0	0	0	0
09.01.2025 00:00	58	Terry D.	CHI	2	1	1	502	1	3	0	0	0	1	0	0	-8	0	1	2	1	0	0	0	0
09.01.2025 00:00	59	Williams P.	CHI	2	3	0	1283	0	5	0	0	0	3	2	4	-21	0	3	3	0	2	1	0	0
09.01.2025 00:00	60	Carter J.	CHI	1	0	0	416	0	0	0	0	0	0	1	2	7	0	0	0	0	0	0	0	0
07.01.2025 01:00	61	LaVine Z.	CHI	35	10	8	2375	13	25	0	0	3	6	6	7	13	1	9	1	1	2	0	0	0
07.01.2025 01:00	62	Vucevic N.	CHI	24	11	3	2021	10	22	0	0	2	9	2	2	3	4	7	2	1	0	0	0	0
07.01.2025 01:00	63	White C.	CHI	23	2	4	2167	9	18	0	0	3	6	2	2	7	0	2	3	4	2	0	0	0
07.01.2025 01:00	64	Williams P.	CHI	12	1	3	2058	4	7	0	0	3	5	1	2	6	0	1	2	1	2	1	0	0
07.01.2025 01:00	65	Smith J.	CHI	9	8	1	859	3	11	0	0	1	6	2	2	1	5	3	0	0	0	0	0	0
07.01.2025 01:00	66	Giddey J.	CHI	6	7	3	1876	3	12	0	0	0	2	0	0	-2	2	5	0	2	2	1	0	0
07.01.2025 01:00	67	Ball L.	CHI	5	4	2	1447	2	4	0	0	1	3	0	0	7	1	3	1	3	3	0	0	0
07.01.2025 01:00	68	Buzelis M.	CHI	0	1	1	733	0	3	0	0	0	2	0	0	-3	1	0	0	0	0	2	0	0
07.01.2025 01:00	69	Phillips J.	CHI	0	1	0	537	0	0	0	0	0	0	0	0	-4	0	1	0	0	0	0	0	0
07.01.2025 01:00	70	Terry D.	CHI	0	2	0	327	0	0	0	0	0	0	0	0	-8	0	2	0	0	2	0	0	0
05.01.2025 01:00	71	LaVine Z.	CHI	33	4	7	2149	13	21	0	0	3	6	4	4	7	1	3	0	1	2	0	0	0
05.01.2025 01:00	72	White C.	CHI	33	2	3	2010	11	17	0	0	9	11	2	2	10	1	1	0	0	2	0	0	0
05.01.2025 01:00	73	Vucevic N.	CHI	22	12	3	2041	10	19	0	0	1	4	1	1	6	4	8	5	1	2	0	0	0
05.01.2025 01:00	74	Giddey J.	CHI	15	10	8	1836	5	10	0	0	3	3	2	2	10	0	10	2	1	2	1	0	0
05.01.2025 01:00	75	Smith J.	CHI	10	5	1	839	3	7	0	0	2	6	2	2	7	1	4	5	0	0	2	0	0
05.01.2025 01:00	76	Ball L.	CHI	8	2	6	1521	3	7	0	0	1	4	1	2	10	0	2	2	2	0	0	0	0
05.01.2025 01:00	77	Phillips J.	CHI	7	1	1	902	3	4	0	0	1	1	0	0	12	1	0	0	1	0	0	0	0
05.01.2025 01:00	78	Williams P.	CHI	5	5	5	2096	1	5	0	0	0	2	3	3	-6	0	5	2	0	1	1	0	0
05.01.2025 01:00	79	Buzelis M.	CHI	2	1	0	121	0	0	0	0	0	0	2	2	4	1	0	1	0	0	0	0	0
05.01.2025 01:00	80	Horton-Tucker T.	CHI	2	0	1	173	1	1	0	0	0	0	0	0	0	0	0	0	0	2	0	0	0
05.01.2025 01:00	81	Terry D.	CHI	2	1	1	712	1	3	0	0	0	0	0	0	5	0	1	4	0	1	0	0	0
02.01.2025 00:00	82	LaVine Z.	CHI	32	1	3	1873	12	20	0	0	3	8	5	7	2	0	1	2	2	3	1	0	0
02.01.2025 00:00	83	White C.	CHI	17	2	6	1860	5	11	0	0	2	6	5	5	-22	0	2	3	1	4	0	0	0
02.01.2025 00:00	84	Vucevic N.	CHI	12	13	6	1909	5	17	0	0	2	9	0	0	-2	2	11	2	0	1	0	0	0
02.01.2025 00:00	85	Horton-Tucker T.	CHI	7	3	0	955	3	5	0	0	1	2	0	0	-18	1	2	1	0	0	1	0	0
02.01.2025 00:00	86	Williams P.	CHI	7	3	3	1363	3	6	0	0	1	4	0	0	-3	0	3	0	1	2	0	0	0
02.01.2025 00:00	87	Giddey J.	CHI	6	7	2	1576	3	8	0	0	0	1	0	0	-17	3	4	1	1	5	1	0	0
02.01.2025 00:00	88	Terry D.	CHI	6	1	3	1112	2	3	0	0	1	2	1	2	-7	0	1	1	1	2	0	0	0
02.01.2025 00:00	89	Ball L.	CHI	5	8	4	1348	2	7	0	0	1	6	0	0	-6	1	7	1	3	1	1	0	0
02.01.2025 00:00	90	Buzelis M.	CHI	5	4	0	852	2	5	0	0	1	3	0	0	2	1	3	0	1	1	1	0	0
02.01.2025 00:00	91	Phillips J.	CHI	4	0	0	469	2	3	0	0	0	1	0	0	-2	0	0	0	0	0	0	0	0
02.01.2025 00:00	92	Carter J.	CHI	3	0	1	261	1	1	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0
02.01.2025 00:00	93	Smith J.	CHI	3	2	0	822	1	6	0	0	1	4	0	0	-17	0	2	2	1	1	1	0	0
31.12.2024 00:00	94	White C.	CHI	23	10	9	2454	8	24	0	0	1	11	6	7	-3	1	9	2	1	3	0	0	0
31.12.2024 00:00	95	Craig T.	CHI	18	5	2	1288	6	10	0	0	5	7	1	2	12	2	3	1	1	0	0	0	0
31.12.2024 00:00	96	Williams P.	CHI	17	3	0	1937	5	11	0	0	5	10	2	2	-9	1	2	2	0	1	0	0	0
31.12.2024 00:00	97	Vucevic N.	CHI	16	13	3	2091	6	14	0	0	3	7	1	3	-4	2	11	3	1	2	0	0	0
31.12.2024 00:00	98	Giddey J.	CHI	13	12	6	1827	4	16	0	0	1	9	4	4	-4	5	7	0	1	2	0	0	0
31.12.2024 00:00	99	Smith J.	CHI	11	5	0	1089	5	10	0	0	1	6	0	0	11	1	4	1	1	0	1	0	0
31.12.2024 00:00	100	Terry D.	CHI	5	4	3	1168	1	4	0	0	1	3	2	4	5	0	4	0	0	1	0	0	0
31.12.2024 00:00	101	Ball L.	CHI	4	3	5	1554	1	3	0	0	1	3	1	3	25	1	2	3	3	1	0	0	0
31.12.2024 00:00	102	Horton-Tucker T.	CHI	4	5	3	1206	2	6	0	0	0	3	0	0	20	1	4	3	3	2	2	0	0
31.12.2024 00:00	103	Buzelis M.	CHI	2	2	0	626	1	6	0	0	0	1	0	0	3	0	2	1	0	0	1	0	0
31.12.2024 00:00	104	Phillips J.	CHI	2	1	0	660	0	0	0	0	0	0	2	2	-21	0	1	1	0	1	0	0	0
29.12.2024 01:00	105	Giddey J.	CHI	23	15	10	1769	9	15	0	0	2	6	3	4	18	2	13	1	1	2	1	0	0
29.12.2024 01:00	106	Vucevic N.	CHI	23	13	5	2305	10	24	0	0	3	7	0	0	3	5	8	2	1	1	0	0	0
29.12.2024 01:00	107	White C.	CHI	22	2	4	2051	9	16	0	0	1	5	3	3	12	0	2	3	0	1	1	0	0
29.12.2024 01:00	108	LaVine Z.	CHI	15	6	7	2075	5	12	0	0	1	4	4	6	7	0	6	0	0	3	0	0	0
29.12.2024 01:00	109	Ball L.	CHI	9	3	3	1169	3	5	0	0	3	4	0	0	-17	0	3	3	1	2	0	0	0
29.12.2024 01:00	110	Williams P.	CHI	9	2	1	1721	4	8	0	0	1	1	0	0	12	0	2	1	1	1	2	0	0
29.12.2024 01:00	111	Craig T.	CHI	6	3	0	673	2	8	0	0	2	7	0	0	-1	1	2	1	0	0	0	0	0
29.12.2024 01:00	112	Carter J.	CHI	5	1	1	370	1	2	0	0	1	2	2	2	-4	0	1	0	0	0	0	0	0
29.12.2024 01:00	113	Buzelis M.	CHI	2	3	0	778	1	2	0	0	0	0	0	0	-4	2	1	1	0	0	2	0	0
29.12.2024 01:00	114	Terry D.	CHI	2	3	2	1011	1	2	0	0	0	0	0	2	-6	1	2	3	0	1	0	0	0
29.12.2024 01:00	115	Horton-Tucker T.	CHI	0	0	0	195	0	0	0	0	0	0	0	0	5	0	0	1	0	0	0	0	0
29.12.2024 01:00	116	Phillips J.	CHI	0	1	0	283	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0
27.12.2024 00:30	117	LaVine Z.	CHI	37	5	7	2164	14	25	0	0	7	9	2	2	-8	1	4	3	1	7	1	0	0
27.12.2024 00:30	118	Carter J.	CHI	26	4	5	2157	9	15	0	0	7	11	1	2	7	0	4	3	1	2	0	0	0
27.12.2024 00:30	119	White C.	CHI	23	3	9	2063	8	13	0	0	5	8	2	2	-16	0	3	3	1	3	0	0	0
27.12.2024 00:30	120	Vucevic N.	CHI	19	8	3	2164	9	13	0	0	1	1	0	0	-8	2	6	4	2	0	0	0	0
27.12.2024 00:30	121	Williams P.	CHI	11	3	4	1629	5	10	0	0	1	6	0	0	-19	1	2	0	3	0	0	0	0
27.12.2024 00:30	122	Smith J.	CHI	8	6	0	716	4	5	0	0	0	0	0	0	0	1	5	2	0	0	0	0	0
27.12.2024 00:30	123	Craig T.	CHI	7	4	0	815	3	5	0	0	1	3	0	0	-9	2	2	3	0	0	0	0	0
27.12.2024 00:30	124	Phillips J.	CHI	2	3	1	809	1	5	0	0	0	1	0	0	15	2	1	2	0	0	0	0	0
27.12.2024 00:30	125	Horton-Tucker T.	CHI	0	0	6	1335	0	6	0	0	0	3	0	0	14	0	0	2	0	1	0	0	0
27.12.2024 00:30	126	Terry D.	CHI	0	0	1	548	0	1	0	0	0	1	0	0	-16	0	0	4	0	1	0	0	0
24.12.2024 01:00	127	Vucevic N.	CHI	17	12	3	1858	7	16	0	0	2	8	1	2	-15	2	10	1	1	1	0	0	0
24.12.2024 01:00	128	LaVine Z.	CHI	14	6	3	2017	5	13	0	0	1	6	3	3	-18	0	6	0	1	3	0	0	0
24.12.2024 01:00	129	Smith J.	CHI	14	7	2	1007	6	11	0	0	1	5	1	1	-10	2	5	2	0	2	0	0	0
24.12.2024 01:00	130	Williams P.	CHI	13	4	1	1374	5	8	0	0	3	6	0	0	1	0	4	2	0	0	0	0	0
24.12.2024 01:00	131	White C.	CHI	10	2	3	2044	4	11	0	0	2	6	0	0	-13	1	1	0	1	3	0	0	0
24.12.2024 01:00	132	Terry D.	CHI	8	3	1	984	4	7	0	0	0	2	0	0	-5	2	1	2	1	0	0	0	0
24.12.2024 01:00	133	Dosunmu A.	CHI	5	4	11	2027	2	9	0	0	0	5	1	2	-19	0	4	2	2	4	0	0	0
24.12.2024 01:00	134	Buzelis M.	CHI	4	2	1	921	1	4	0	0	1	3	1	2	2	1	1	1	0	1	1	0	0
24.12.2024 01:00	135	Duarte C.	CHI	2	2	1	252	1	2	0	0	0	0	0	0	1	0	2	0	0	0	0	0	0
24.12.2024 01:00	136	Horton-Tucker T.	CHI	2	3	1	805	0	4	0	0	0	3	2	2	-10	0	3	2	2	0	0	0	0
24.12.2024 01:00	137	Phillips J.	CHI	2	1	0	859	1	4	0	0	0	3	0	0	-20	1	0	3	0	1	0	0	0
24.12.2024 01:00	138	Carter J.	CHI	0	0	0	252	0	1	0	0	0	1	0	0	1	0	0	0	1	0	0	0	0
\.


--
-- Data for Name: chicago_bulls_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.chicago_bulls_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Sanogo Adama	Lesionado	2025-01-16 10:43:32.410072
2	Ball Lonzo	Lesionado	2025-01-16 10:43:32.426771
3	Dosunmu Ayo	Lesionado	2025-01-16 10:43:32.429664
4	Craig Torrey	Lesionado	2025-01-16 10:43:32.432229
\.


--
-- Data for Name: cleveland_cavaliers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.cleveland_cavaliers (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	16.05.2024	Boston Celtics	113	Cleveland Cavaliers	98	28	30	27	28	28	24	26	20
2	12.07.2024	Orlando Magic	106	Cleveland Cavaliers	79	36	26	25	19	21	20	16	22
3	14.07.2024	Milwaukee Bucks	81	Cleveland Cavaliers	112	21	16	27	17	38	34	20	20
4	18.07.2024	Cleveland Cavaliers	85	Golden State Warriors	96	22	16	20	27	26	28	21	21
5	19.07.2024	Cleveland Cavaliers	89	Los Angeles Lakers	93	20	30	22	17	24	22	22	25
6	20.07.2024	Cleveland Cavaliers	100	Indiana Pacers	93	22	16	28	34	18	20	27	28
7	09.10.2024	Cleveland Cavaliers	112	Chicago Bulls	116	31	36	18	27	24	30	34	28
8	11.10.2024	Cleveland Cavaliers	117	Indiana Pacers	129	31	39	18	29	28	41	32	28
9	17.10.2024	Detroit Pistons	108	Cleveland Cavaliers	92	28	32	21	27	34	27	14	17
10	19.10.2024\nApós Prol.	Chicago Bulls	139	Cleveland Cavaliers	137	25	29	38	38	31	30	32	37
11	24.10.2024	Toronto Raptors	106	Cleveland Cavaliers	136	32	17	30	27	33	36	36	31
12	26.10.2024	Cleveland Cavaliers	113	Detroit Pistons	101	28	37	26	22	29	26	24	22
13	27.10.2024	Washington Wizards	116	Cleveland Cavaliers	135	25	28	28	35	28	31	38	38
14	28.10.2024	New York Knicks	104	Cleveland Cavaliers	110	18	34	26	26	22	23	29	36
15	30.10.2024	Cleveland Cavaliers	134	Los Angeles Lakers	110	42	25	32	35	23	25	31	31
16	01.11.2024	Cleveland Cavaliers	120	Orlando Magic	109	34	29	32	25	16	28	34	31
17	03.11.2024	Milwaukee Bucks	113	Cleveland Cavaliers	114	38	24	22	29	30	31	26	27
18	05.11.2024	Cleveland Cavaliers	116	Milwaukee Bucks	114	35	38	16	27	31	29	31	23
19	07.11.2024	New Orleans Pelicans	122	Cleveland Cavaliers	131	34	25	29	34	29	30	40	32
20	09.11.2024	Cleveland Cavaliers	136	Golden State Warriors	117	39	44	29	24	22	20	41	34
21	10.11.2024	Cleveland Cavaliers	105	Brooklyn Nets	100	34	23	13	35	28	27	27	18
22	12.11.2024	Chicago Bulls	113	Cleveland Cavaliers	119	35	31	26	21	34	33	28	24
23	14.11.2024	Philadelphia 76ers	106	Cleveland Cavaliers	114	27	27	24	28	31	17	34	32
24	16.11.2024	Cleveland Cavaliers	144	Chicago Bulls	126	49	28	30	37	34	39	29	24
25	17.11.2024	Cleveland Cavaliers	128	Charlotte Hornets	114	38	34	30	26	28	31	40	15
26	20.11.2024	Boston Celtics	120	Cleveland Cavaliers	117	26	39	28	27	20	28	40	29
27	21.11.2024	Cleveland Cavaliers	128	New Orleans Pelicans	100	29	40	36	23	24	31	18	27
28	25.11.2024	Cleveland Cavaliers	122	Toronto Raptors	108	38	27	31	26	22	33	35	18
29	28.11.2024	Cleveland Cavaliers	124	Atlanta Hawks	135	35	29	31	29	35	26	37	37
30	29.11.2024	Atlanta Hawks	117	Cleveland Cavaliers	101	29	23	39	26	27	23	23	28
31	01.12.2024	Cleveland Cavaliers	115	Boston Celtics	111	28	23	21	43	24	25	35	27
32	04.12.2024	Cleveland Cavaliers	118	Washington Wizards	87	35	25	26	32	20	22	25	20
33	06.12.2024	Cleveland Cavaliers	126	Denver Nuggets	114	37	29	36	24	27	35	25	27
34	07.12.2024	Charlotte Hornets	102	Cleveland Cavaliers	116	18	34	31	19	40	23	30	23
35	08.12.2024	Miami Heat	122	Cleveland Cavaliers	113	21	38	31	32	25	26	29	33
36	14.12.2024	Cleveland Cavaliers	115	Washington Wizards	105	25	32	30	28	25	29	26	25
37	17.12.2024	Brooklyn Nets	101	Cleveland Cavaliers	130	17	23	37	24	37	35	32	26
38	21.12.2024	Cleveland Cavaliers	124	Milwaukee Bucks	101	29	40	34	21	20	31	25	25
39	22.12.2024	Cleveland Cavaliers	126	Philadelphia 76ers	99	30	36	33	27	30	25	21	23
40	24.12.2024	Cleveland Cavaliers	124	Utah Jazz	113	29	31	39	25	27	29	32	25
41	28.12.2024	Denver Nuggets	135	Cleveland Cavaliers	149	38	27	36	34	40	40	36	33
42	31.12.2024	Golden State Warriors	95	Cleveland Cavaliers	113	27	11	27	30	26	20	37	30
43	01.01. 02:00	Los Angeles Lakers	110	Cleveland Cavaliers	122	30	23	25	32	34	24	29	35
44	04.01. 01:30	Dallas Mavericks	122	Cleveland Cavaliers	134	21	32	32	37	32	37	31	34
45	05.01. 23:00	Cleveland Cavaliers	115	Charlotte Hornets	105	29	34	28	24	23	25	30	27
46	09.01. 00:00	Cleveland Cavaliers	129	Oklahoma City Thunder	122	25	37	41	26	32	27	43	20
47	10.01. 00:00	Cleveland Cavaliers	132	Toronto Raptors	126	27	34	37	34	33	28	42	23
48	12.01. 23:00	Cleveland Cavaliers	93	Indiana Pacers	108	19	34	18	22	21	19	37	31
49	15.01. 00:00	Indiana Pacers	117	Cleveland Cavaliers	127	30	31	28	28	37	25	38	27
50	17.01. 00:30	Oklahoma City Thunder	134	Cleveland Cavaliers	114	32	43	44	15	14	35	32	33
\.


--
-- Data for Name: cleveland_cavaliers_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.cleveland_cavaliers_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
15.01.2025 00:00	1	Mitchell D.	CLE	35	9	3	1879	12	23	0	0	3	9	8	8	13	2	7	3	2	2	0	0	0
15.01.2025 00:00	2	Garland D.	CLE	24	1	7	2094	9	18	0	0	2	8	4	6	7	1	0	3	1	4	0	0	0
15.01.2025 00:00	3	Mobley E.	CLE	22	13	1	1954	8	12	0	0	3	4	3	5	11	3	10	1	0	1	1	0	0
15.01.2025 00:00	4	Allen J.	CLE	16	9	2	1920	5	6	0	0	0	0	6	6	9	0	9	2	1	1	1	0	0
15.01.2025 00:00	5	Strus M.	CLE	13	4	4	1309	4	8	0	0	4	7	1	2	5	0	4	2	1	0	1	0	0
15.01.2025 00:00	6	LeVert C.	CLE	7	5	7	1605	1	6	0	0	1	4	4	4	9	4	1	0	2	3	2	0	0
15.01.2025 00:00	7	Niang G.	CLE	7	3	0	1043	3	5	0	0	1	3	0	0	-3	2	1	2	0	1	0	0	0
15.01.2025 00:00	8	Merrill S.	CLE	3	1	0	729	1	5	0	0	1	5	0	0	-7	1	0	0	0	1	0	0	0
15.01.2025 00:00	9	Okoro I.	CLE	0	1	1	402	0	3	0	0	0	1	0	0	2	0	1	2	1	0	0	0	0
15.01.2025 00:00	10	Porter C.	CLE	0	0	0	89	0	0	0	0	0	0	0	0	-4	0	0	0	0	1	0	0	0
15.01.2025 00:00	11	Tyson J.	CLE	0	0	0	89	0	0	0	0	0	0	0	0	-4	0	0	0	0	0	0	0	0
15.01.2025 00:00	12	Wade D.	CLE	0	3	0	1287	0	3	0	0	0	3	0	0	12	1	2	3	0	0	1	0	0
12.01.2025 23:00	13	Garland D.	CLE	20	1	7	1741	7	16	0	0	3	9	3	3	-3	0	1	3	0	4	0	0	0
12.01.2025 23:00	14	Mitchell D.	CLE	19	3	1	1850	7	17	0	0	3	7	2	2	-3	2	1	2	2	3	0	0	0
12.01.2025 23:00	15	Mobley E.	CLE	16	12	1	1850	6	10	0	0	1	2	3	3	-3	0	12	1	0	0	1	0	0
12.01.2025 23:00	16	Allen J.	CLE	11	9	3	1523	3	6	0	0	0	0	5	6	-8	3	6	1	0	1	1	0	0
12.01.2025 23:00	17	Niang G.	CLE	7	0	0	1175	3	6	0	0	1	4	0	0	-12	0	0	2	1	2	1	0	0
12.01.2025 23:00	18	Thompson T.	CLE	4	0	0	164	2	2	0	0	0	0	0	0	2	0	0	0	0	0	0	0	0
12.01.2025 23:00	19	Merrill S.	CLE	3	2	5	707	1	5	0	0	1	5	0	0	0	0	2	1	0	0	0	0	0
12.01.2025 23:00	20	Okoro I.	CLE	3	0	2	1089	1	5	0	0	0	2	1	2	-3	0	0	2	0	0	1	0	0
12.01.2025 23:00	21	Strus M.	CLE	3	4	1	1377	1	6	0	0	1	5	0	0	-23	0	4	2	0	2	0	0	0
12.01.2025 23:00	22	Wade D.	CLE	3	9	1	1249	1	5	0	0	1	5	0	0	-7	1	8	2	1	0	0	0	0
12.01.2025 23:00	23	LeVert C.	CLE	2	4	2	1347	0	3	0	0	0	2	2	2	-19	0	4	2	0	1	1	0	0
12.01.2025 23:00	24	Porter C.	CLE	2	0	0	164	1	1	0	0	0	0	0	0	2	0	0	0	0	0	0	0	0
12.01.2025 23:00	25	Tyson J.	CLE	0	0	1	164	0	1	0	0	0	0	0	0	2	0	0	0	0	0	0	0	0
10.01.2025 00:00	26	Garland D.	CLE	40	2	9	2137	14	22	0	0	4	7	8	9	18	0	2	0	2	3	0	0	0
10.01.2025 00:00	27	Mobley E.	CLE	21	11	6	1933	7	11	0	0	3	5	4	6	-1	4	7	1	1	2	0	0	0
10.01.2025 00:00	28	Allen J.	CLE	18	15	3	1710	8	9	0	0	0	0	2	4	8	6	9	1	1	0	2	0	0
10.01.2025 00:00	29	LeVert C.	CLE	18	3	5	2186	6	12	0	0	4	9	2	2	1	1	2	1	0	1	1	0	0
10.01.2025 00:00	30	Strus M.	CLE	12	2	3	1496	4	7	0	0	4	7	0	0	-2	1	1	0	1	2	0	0	0
10.01.2025 00:00	31	Jerome T.	CLE	8	2	1	1207	2	5	0	0	0	1	4	4	-12	2	0	0	2	1	0	0	0
10.01.2025 00:00	32	Niang G.	CLE	8	0	1	806	3	8	0	0	2	5	0	0	-13	0	0	2	0	1	0	0	0
10.01.2025 00:00	33	Wade D.	CLE	5	5	2	1719	2	6	0	0	1	5	0	0	12	1	4	1	1	1	0	0	0
10.01.2025 00:00	34	Merrill S.	CLE	2	0	0	754	1	4	0	0	0	2	0	0	13	0	0	4	0	0	0	0	0
10.01.2025 00:00	35	Okoro I.	CLE	0	2	1	452	0	5	0	0	0	4	0	0	6	1	1	1	0	0	0	0	0
09.01.2025 00:00	36	Allen J.	CLE	25	12	6	1926	9	11	0	0	0	0	7	10	7	8	4	1	3	0	1	0	0
09.01.2025 00:00	37	Mobley E.	CLE	21	10	7	2109	8	13	0	0	0	3	5	7	8	2	8	2	1	3	1	0	0
09.01.2025 00:00	38	Garland D.	CLE	18	1	7	1939	7	15	0	0	2	6	2	2	7	0	1	2	0	2	0	0	0
09.01.2025 00:00	39	Strus M.	CLE	17	3	5	1577	6	7	0	0	5	6	0	0	1	1	2	2	0	3	0	0	0
09.01.2025 00:00	40	Jerome T.	CLE	15	2	1	706	6	7	0	0	0	0	3	4	2	1	1	1	2	3	0	0	0
09.01.2025 00:00	41	Mitchell D.	CLE	11	6	4	2109	3	16	0	0	2	7	3	4	8	1	5	4	0	1	0	0	0
09.01.2025 00:00	42	Wade D.	CLE	11	3	1	1234	4	5	0	0	3	4	0	0	0	0	3	3	0	2	0	0	0
09.01.2025 00:00	43	LeVert C.	CLE	8	2	2	1181	3	9	0	0	2	5	0	0	-9	0	2	1	0	0	0	0	0
09.01.2025 00:00	44	Niang G.	CLE	3	2	2	838	1	5	0	0	1	3	0	0	-1	0	2	3	0	1	0	0	0
09.01.2025 00:00	45	Okoro I.	CLE	0	0	1	781	0	2	0	0	0	2	0	0	12	0	0	1	1	0	0	0	0
05.01.2025 23:00	46	Garland D.	CLE	25	3	2	1756	8	14	0	0	4	7	5	5	9	0	3	3	1	2	0	0	0
05.01.2025 23:00	47	Allen J.	CLE	19	11	2	1686	9	10	0	0	0	0	1	2	5	5	6	0	0	1	2	0	0
05.01.2025 23:00	48	Mitchell D.	CLE	19	3	4	1756	8	16	0	0	3	7	0	0	3	0	3	2	0	1	0	0	0
05.01.2025 23:00	49	Mobley E.	CLE	17	5	1	1884	6	13	0	0	1	6	4	5	10	1	4	1	1	1	2	0	0
05.01.2025 23:00	50	Niang G.	CLE	10	2	3	1102	4	7	0	0	2	5	0	0	6	0	2	5	0	3	0	0	0
05.01.2025 23:00	51	Strus M.	CLE	9	3	4	1486	3	9	0	0	1	5	2	2	24	0	3	0	0	1	1	0	0
05.01.2025 23:00	52	Jerome T.	CLE	8	4	5	1210	3	10	0	0	2	5	0	0	13	1	3	2	2	0	0	0	0
05.01.2025 23:00	53	Wade D.	CLE	6	4	2	1307	2	4	0	0	2	4	0	0	17	1	3	2	0	0	0	0	0
05.01.2025 23:00	54	LeVert C.	CLE	2	5	6	1481	1	6	0	0	0	3	0	0	-1	1	4	2	1	2	0	0	0
05.01.2025 23:00	55	Porter C.	CLE	0	0	0	183	0	0	0	0	0	0	0	0	-9	0	0	0	0	0	0	0	0
05.01.2025 23:00	56	Thompson T.	CLE	0	0	0	183	0	1	0	0	0	0	0	2	-9	0	0	0	0	0	0	0	0
05.01.2025 23:00	57	Thor J.	CLE	0	0	0	183	0	0	0	0	0	0	0	0	-9	0	0	0	0	1	0	0	0
05.01.2025 23:00	58	Tyson J.	CLE	0	1	0	183	0	2	0	0	0	1	0	0	-9	0	1	0	0	0	0	0	0
04.01.2025 01:30	59	Mobley E.	CLE	34	10	4	1772	14	21	0	0	3	6	3	4	32	2	8	3	0	0	2	0	0
04.01.2025 01:30	60	LeVert C.	CLE	17	4	2	1529	7	15	0	0	2	7	1	3	15	0	4	1	2	0	1	0	0
04.01.2025 01:30	61	Garland D.	CLE	16	4	9	1733	6	12	0	0	2	5	2	2	24	0	4	1	1	1	0	0	0
04.01.2025 01:30	62	Mitchell D.	CLE	15	0	6	1604	5	11	0	0	2	7	3	3	3	0	0	1	2	2	0	0	0
04.01.2025 01:30	63	Niang G.	CLE	15	2	3	1215	6	9	0	0	3	5	0	0	9	0	2	1	0	2	0	0	0
04.01.2025 01:30	64	Allen J.	CLE	11	9	0	1341	5	10	0	0	0	0	1	2	5	3	6	4	0	0	1	0	0
04.01.2025 01:30	65	Wade D.	CLE	10	3	1	1584	4	5	0	0	2	3	0	0	-6	0	3	5	0	0	2	0	0
04.01.2025 01:30	66	Jerome T.	CLE	9	2	5	1168	3	5	0	0	1	2	2	2	-6	0	2	1	0	0	0	0	0
04.01.2025 01:30	67	Thor J.	CLE	3	2	0	247	1	2	0	0	0	0	1	2	-7	2	0	0	0	1	0	0	0
04.01.2025 01:30	68	Porter C.	CLE	2	0	0	247	0	1	0	0	0	0	2	2	-7	0	0	1	0	0	1	0	0
04.01.2025 01:30	69	Strus M.	CLE	2	6	7	1466	1	5	0	0	0	4	0	0	12	3	3	1	0	0	0	0	0
04.01.2025 01:30	70	Thompson T.	CLE	0	2	0	247	0	1	0	0	0	0	0	0	-7	0	2	0	0	0	0	0	0
04.01.2025 01:30	71	Tyson J.	CLE	0	2	1	247	0	1	0	0	0	1	0	0	-7	0	2	1	0	1	0	0	0
01.01.2025 02:00	72	Allen J.	CLE	27	14	1	1878	12	14	0	0	0	0	3	4	12	3	11	0	1	1	3	0	0
01.01.2025 02:00	73	Mitchell D.	CLE	26	4	4	1931	8	20	0	0	6	13	4	5	9	1	3	0	0	3	0	0	0
01.01.2025 02:00	74	Mobley E.	CLE	20	6	1	1900	8	14	0	0	2	4	2	2	7	1	5	1	1	2	1	0	0
01.01.2025 02:00	75	Strus M.	CLE	15	3	4	1584	5	9	0	0	4	8	1	1	5	1	2	5	0	0	2	0	0
01.01.2025 02:00	76	Garland D.	CLE	14	2	14	1923	5	16	0	0	2	8	2	2	10	0	2	1	2	3	1	0	0
01.01.2025 02:00	77	Niang G.	CLE	9	3	1	1093	3	5	0	0	2	3	1	2	-3	1	2	1	0	0	0	0	0
01.01.2025 02:00	78	Jerome T.	CLE	5	6	2	837	2	6	0	0	1	3	0	0	6	1	5	1	0	1	0	0	0
01.01.2025 02:00	79	LeVert C.	CLE	3	1	2	1357	1	4	0	0	1	3	0	0	4	0	1	2	1	1	1	0	0
01.01.2025 02:00	80	Wade D.	CLE	3	9	2	1443	1	4	0	0	0	3	1	1	9	2	7	2	0	0	0	0	0
01.01.2025 02:00	81	Merrill S.	CLE	0	0	1	454	0	1	0	0	0	1	0	0	1	0	0	2	0	0	0	0	0
31.12.2024 03:00	82	Garland D.	CLE	25	3	8	1714	10	17	0	0	3	8	2	4	23	0	3	2	2	0	0	0	0
31.12.2024 03:00	83	Mitchell D.	CLE	23	3	4	1641	9	19	0	0	5	11	0	0	8	0	3	0	0	1	0	0	0
31.12.2024 03:00	84	Allen J.	CLE	12	9	1	1483	6	9	0	0	0	0	0	0	22	3	6	5	1	1	2	0	0
31.12.2024 03:00	85	Jerome T.	CLE	10	2	4	1174	3	10	0	0	2	5	2	2	12	1	1	2	1	0	0	0	1
31.12.2024 03:00	86	Wade D.	CLE	10	13	0	1519	4	7	0	0	2	5	0	0	22	3	10	3	1	0	2	0	0
31.12.2024 03:00	87	LeVert C.	CLE	9	1	1	1263	3	9	0	0	2	4	1	2	4	0	1	0	2	2	0	0	0
31.12.2024 03:00	88	Mobley E.	CLE	7	7	1	1480	2	6	0	0	1	4	2	2	5	1	6	5	1	6	2	0	0
31.12.2024 03:00	89	Merrill S.	CLE	5	2	0	825	2	4	0	0	1	2	0	0	7	1	1	4	0	1	0	0	0
31.12.2024 03:00	90	Niang G.	CLE	3	3	5	1188	1	3	0	0	1	2	0	0	5	0	3	4	1	1	0	0	0
31.12.2024 03:00	91	Strus M.	CLE	3	4	1	1133	1	6	0	0	1	5	0	0	-2	0	4	0	1	3	0	0	0
31.12.2024 03:00	92	Porter C.	CLE	2	1	0	245	1	2	0	0	0	0	0	0	-4	0	1	0	0	0	0	0	0
31.12.2024 03:00	93	Thompson T.	CLE	2	2	0	245	1	1	0	0	0	0	0	0	-4	1	1	0	0	1	0	0	0
31.12.2024 03:00	94	Thor J.	CLE	2	1	0	245	1	2	0	0	0	1	0	0	-4	0	1	0	0	0	0	0	0
31.12.2024 03:00	95	Tyson J.	CLE	0	3	0	245	0	1	0	0	0	0	0	0	-4	1	2	0	0	0	0	0	0
28.12.2024 02:00	96	Mitchell D.	CLE	33	5	6	1821	10	17	0	0	6	12	7	7	4	2	3	2	1	3	0	0	0
28.12.2024 02:00	97	Mobley E.	CLE	26	5	6	1863	9	13	0	0	4	6	4	6	-1	1	4	4	0	1	1	0	0
28.12.2024 02:00	98	Garland D.	CLE	25	2	7	1890	10	18	0	0	2	8	3	4	13	0	2	1	4	2	0	0	0
28.12.2024 02:00	99	Allen J.	CLE	22	10	4	1849	10	13	0	0	0	0	2	2	18	3	7	2	3	2	1	0	0
28.12.2024 02:00	100	LeVert C.	CLE	13	3	3	1386	5	10	0	0	3	4	0	0	3	1	2	1	0	0	0	0	0
28.12.2024 02:00	101	Wade D.	CLE	11	3	4	1548	3	4	0	0	3	4	2	2	19	1	2	1	0	1	2	0	0
28.12.2024 02:00	102	Merrill S.	CLE	9	3	0	1120	3	4	0	0	3	4	0	0	10	0	3	1	0	0	2	0	0
28.12.2024 02:00	103	Strus M.	CLE	5	4	1	1429	2	5	0	0	1	4	0	0	-5	0	4	4	1	1	0	0	0
28.12.2024 02:00	104	Niang G.	CLE	3	1	3	959	1	5	0	0	1	3	0	0	-4	0	1	1	0	0	0	0	0
28.12.2024 02:00	105	Jerome T.	CLE	2	0	4	439	1	6	0	0	0	3	0	1	15	0	0	0	1	0	0	0	0
28.12.2024 02:00	106	Tyson J.	CLE	0	1	1	96	0	0	0	0	0	0	0	0	-2	0	1	0	0	0	0	0	0
24.12.2024 00:00	107	Garland D.	CLE	23	3	8	1961	8	14	0	0	3	6	4	5	21	1	2	1	1	2	0	0	0
24.12.2024 00:00	108	Mitchell D.	CLE	22	3	7	2022	7	15	0	0	4	8	4	5	17	0	3	2	3	1	0	0	0
24.12.2024 00:00	109	Mobley E.	CLE	22	10	4	2022	9	17	0	0	3	5	1	2	17	2	8	2	1	2	3	0	0
24.12.2024 00:00	110	Merrill S.	CLE	20	1	4	1438	6	12	0	0	6	11	2	2	2	1	0	2	3	1	0	0	0
24.12.2024 00:00	111	LeVert C.	CLE	11	3	1	1436	3	6	0	0	1	3	4	5	6	1	2	3	0	0	0	0	0
24.12.2024 00:00	112	Niang G.	CLE	8	7	3	1275	3	8	0	0	2	6	0	0	-1	1	6	4	1	2	0	0	0
24.12.2024 00:00	113	Allen J.	CLE	7	6	2	1614	2	6	0	0	0	0	3	4	10	2	4	1	0	1	0	0	0
24.12.2024 00:00	114	Jerome T.	CLE	5	0	2	834	2	7	0	0	1	5	0	0	-7	0	0	3	0	0	0	0	0
24.12.2024 00:00	115	Tyson J.	CLE	4	1	0	493	2	3	0	0	0	0	0	0	-6	0	1	2	1	0	0	0	0
24.12.2024 00:00	116	Strus M.	CLE	2	6	2	1305	1	3	0	0	0	2	0	0	-4	2	4	3	0	0	0	0	1
22.12.2024 01:00	117	Garland D.	CLE	26	5	4	1555	9	11	0	0	6	7	2	2	7	1	4	2	1	2	0	0	0
22.12.2024 01:00	118	Mobley E.	CLE	22	13	7	1811	10	14	0	0	1	2	1	5	10	3	10	1	2	1	1	0	0
22.12.2024 01:00	119	Mitchell D.	CLE	19	4	5	1674	7	16	0	0	4	10	1	1	8	0	4	0	0	4	0	0	0
22.12.2024 01:00	120	Niang G.	CLE	13	5	2	1642	5	9	0	0	3	5	0	0	18	1	4	5	0	0	0	0	1
22.12.2024 01:00	121	LeVert C.	CLE	12	1	3	1316	5	11	0	0	2	6	0	0	36	0	1	1	2	3	0	0	0
22.12.2024 01:00	122	Jerome T.	CLE	11	4	4	1437	4	11	0	0	3	7	0	0	20	2	2	2	0	1	0	0	0
22.12.2024 01:00	123	Tyson J.	CLE	8	3	1	852	3	5	0	0	1	1	1	2	16	2	1	2	0	0	0	0	0
22.12.2024 01:00	124	Allen J.	CLE	6	6	2	1487	2	5	0	0	0	0	2	3	7	1	5	1	1	2	0	0	0
22.12.2024 01:00	125	Wade D.	CLE	6	4	2	1492	2	3	0	0	2	3	0	0	15	0	4	1	2	0	0	0	0
22.12.2024 01:00	126	Porter C.	CLE	2	1	1	315	1	3	0	0	0	0	0	0	-4	1	0	1	0	0	0	0	0
22.12.2024 01:00	127	Thompson T.	CLE	1	2	0	315	0	0	0	0	0	0	1	2	-4	1	1	1	0	0	0	0	0
22.12.2024 01:00	128	Merrill S.	CLE	0	1	0	504	0	2	0	0	0	2	0	0	6	1	0	1	0	0	0	0	0
21.12.2024 00:30	129	Mitchell D.	CLE	27	4	6	1633	9	15	0	0	3	7	6	8	21	0	4	1	2	0	0	0	0
21.12.2024 00:30	130	Garland D.	CLE	16	4	5	1480	6	15	0	0	4	6	0	0	16	2	2	0	1	3	0	0	0
21.12.2024 00:30	131	Mobley E.	CLE	15	7	4	1633	6	10	0	0	0	2	3	3	21	2	5	2	0	2	0	0	0
21.12.2024 00:30	132	Wade D.	CLE	15	5	2	1256	5	6	0	0	4	5	1	1	19	0	5	2	2	0	0	0	0
21.12.2024 00:30	133	Jerome T.	CLE	13	4	4	947	5	10	0	0	3	7	0	0	-1	2	2	0	2	2	0	0	0
21.12.2024 00:30	134	Allen J.	CLE	10	10	0	1480	5	6	0	0	0	0	0	0	16	1	9	1	2	1	0	0	0
21.12.2024 00:30	135	Strus M.	CLE	9	0	2	1147	3	8	0	0	3	8	0	0	20	0	0	2	0	0	0	0	0
21.12.2024 00:30	136	LeVert C.	CLE	7	2	4	1108	3	7	0	0	1	4	0	0	18	0	2	1	1	2	0	0	0
21.12.2024 00:30	137	Merrill S.	CLE	5	3	1	1149	2	6	0	0	1	5	0	0	0	0	3	0	0	2	0	0	0
21.12.2024 00:30	138	Niang G.	CLE	5	2	1	999	2	4	0	0	1	2	0	0	13	0	2	0	1	0	0	0	0
21.12.2024 00:30	139	Thompson T.	CLE	2	6	0	553	0	3	0	0	0	0	2	2	-10	2	4	0	0	0	0	0	0
21.12.2024 00:30	140	Porter C.	CLE	0	1	1	462	0	0	0	0	0	0	0	0	-8	0	1	0	0	0	0	0	0
21.12.2024 00:30	141	Tyson J.	CLE	0	0	0	553	0	1	0	0	0	1	0	0	-10	0	0	1	0	3	0	0	0
\.


--
-- Data for Name: cleveland_cavaliers_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.cleveland_cavaliers_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Jerome Ty	Lesionado	2025-01-16 10:43:42.012191
2	Bates Emoni	Lesionado	2025-01-16 10:43:42.014176
3	Travers Luke	Lesionado	2025-01-16 10:43:42.01567
\.


--
-- Data for Name: dallas_mavericks; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dallas_mavericks (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	18.06.2024	Boston Celtics	106	Dallas Mavericks	88	28	39	19	20	18	28	21	21
2	14.07.2024	Dallas Mavericks	89	Utah Jazz	90	18	22	30	19	19	20	25	26
3	16.07.2024	Memphis Grizzlies	108	Dallas Mavericks	88	30	23	34	21	11	23	22	32
4	17.07.2024	Dallas Mavericks	79	Miami Heat	92	21	11	25	22	14	23	24	31
5	19.07.2024	Boston Celtics	90	Dallas Mavericks	101	22	23	24	21	30	25	21	25
6	21.07.2024	Dallas Mavericks	79	Oklahoma City Thunder	88	20	22	12	25	16	22	25	25
7	08.10.2024	Dallas Mavericks	116	Memphis Grizzlies	121	29	31	30	26	32	28	33	28
8	11.10.2024	Dallas Mavericks	102	Utah Jazz	107	18	29	33	22	24	36	32	15
9	15.10.2024	Los Angeles Clippers	110	Dallas Mavericks	96	25	31	27	27	26	25	24	21
10	18.10.2024	Dallas Mavericks	109	Milwaukee Bucks	84	21	33	29	26	22	16	20	26
11	25.10.2024	Dallas Mavericks	120	San Antonio Spurs	109	20	27	40	33	22	27	31	29
12	27.10.2024	Phoenix Suns	114	Dallas Mavericks	102	28	35	28	23	26	29	25	22
13	29.10.2024	Dallas Mavericks	110	Utah Jazz	102	27	22	33	28	19	24	27	32
14	29.10.2024	Minnesota Timberwolves	114	Dallas Mavericks	120	34	25	23	32	26	35	32	27
15	01.11.2024	Dallas Mavericks	102	Houston Rockets	108	21	23	28	30	34	23	31	20
16	04.11.2024	Dallas Mavericks	108	Orlando Magic	85	30	35	23	20	22	18	21	24
17	05.11.2024	Dallas Mavericks	127	Indiana Pacers	134	29	30	36	32	36	27	33	38
18	07.11.2024	Dallas Mavericks	119	Chicago Bulls	99	32	24	32	31	24	21	23	31
19	09.11.2024	Dallas Mavericks	113	Phoenix Suns	114	26	24	33	30	36	27	24	27
20	11.11.2024	Denver Nuggets	122	Dallas Mavericks	120	35	25	37	25	29	34	31	26
21	13.11.2024	Golden State Warriors	120	Dallas Mavericks	117	33	26	37	24	27	36	26	28
22	15.11.2024	Utah Jazz	115	Dallas Mavericks	113	27	34	38	16	28	36	21	28
23	17.11.2024	Dallas Mavericks	110	San Antonio Spurs	93	23	32	38	17	28	23	18	24
24	18.11.2024	Oklahoma City Thunder	119	Dallas Mavericks	121	34	24	34	27	39	27	31	24
25	20.11.2024	Dallas Mavericks	132	New Orleans Pelicans	91	44	19	34	35	29	22	18	22
26	23.11.2024	Denver Nuggets	120	Dallas Mavericks	123	31	22	36	31	33	40	22	28
27	24.11.2024\nApós Prol.	Miami Heat	123	Dallas Mavericks	118	33	23	33	25	28	23	33	30
28	26.11.2024	Atlanta Hawks	119	Dallas Mavericks	129	31	36	28	24	28	33	35	33
29	28.11.2024	Dallas Mavericks	129	New York Knicks	114	28	32	30	39	15	23	33	43
30	01.12.2024	Utah Jazz	94	Dallas Mavericks	106	22	27	27	18	40	16	30	20
31	02.12.2024	Portland Trail Blazers	131	Dallas Mavericks	137	29	29	39	34	25	36	39	37
32	04.12.2024	Dallas Mavericks	121	Memphis Grizzlies	116	25	35	22	39	26	31	38	21
33	06.12.2024	Washington Wizards	101	Dallas Mavericks	137	22	28	27	24	31	37	34	35
34	08.12.2024	Toronto Raptors	118	Dallas Mavericks	125	28	26	33	31	35	35	30	25
35	11.12.2024	Oklahoma City Thunder	118	Dallas Mavericks	104	32	25	33	28	24	30	19	31
36	16.12.2024	Golden State Warriors	133	Dallas Mavericks	143	33	41	33	26	46	35	33	29
37	20.12.2024	Dallas Mavericks	95	Los Angeles Clippers	118	30	19	28	18	24	26	39	29
38	22.12.2024	Dallas Mavericks	113	Los Angeles Clippers	97	23	31	20	39	22	18	26	31
39	24.12.2024	Dallas Mavericks	132	Portland Trail Blazers	108	28	34	40	30	31	22	23	32
40	25.12.2024	Dallas Mavericks	99	Minnesota Timberwolves	105	24	16	28	31	26	31	33	15
41	28.12.2024	Phoenix Suns	89	Dallas Mavericks	98	25	14	25	25	28	27	17	26
42	29.12.2024	Portland Trail Blazers	126	Dallas Mavericks	122	36	33	28	29	25	34	23	40
43	31.12.2024	Sacramento Kings	110	Dallas Mavericks	100	23	33	27	27	37	23	17	23
44	02.01. 01:00	Houston Rockets	110	Dallas Mavericks	99	24	37	28	21	30	22	23	24
45	04.01. 01:30	Dallas Mavericks	122	Cleveland Cavaliers	134	21	32	32	37	32	37	31	34
46	07.01. 01:00	Memphis Grizzlies	119	Dallas Mavericks	104	26	30	31	32	36	19	25	24
47	08.01. 00:30	Dallas Mavericks	118	Los Angeles Lakers	97	24	31	34	29	27	23	26	21
48	10.01. 00:30	Dallas Mavericks	117	Portland Trail Blazers	111	20	33	28	36	28	30	31	22
49	12.01. 20:00	Dallas Mavericks	101	Denver Nuggets	112	32	29	28	12	17	41	21	33
50	15.01. 02:30	Dallas Mavericks	99	Denver Nuggets	118	21	24	22	32	36	35	20	27
51	16.01. 01:00	New Orleans Pelicans	119	Dallas Mavericks	116	33	30	24	32	27	34	30	25
\.


--
-- Data for Name: dallas_mavericks_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dallas_mavericks_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 01:00	1	Gafford D.	DAL	27	12	2	1800	12	13	0	0	0	0	3	4	-5	3	9	1	0	1	2	0	0
16.01.2025 01:00	2	Hardy J.	DAL	21	5	2	1522	7	13	0	0	4	6	3	4	11	0	5	1	1	2	0	0	0
16.01.2025 01:00	3	Dinwiddie S.	DAL	20	5	4	2269	6	17	0	0	3	8	5	5	-4	1	4	2	3	1	0	0	0
16.01.2025 01:00	4	Grimes Q.	DAL	14	2	2	1112	6	11	0	0	1	4	1	2	0	0	2	1	1	0	0	0	0
16.01.2025 01:00	5	Washington P. J.	DAL	14	14	2	2309	4	11	0	0	1	4	5	8	-4	3	11	3	1	4	0	0	0
16.01.2025 01:00	6	Thompson K.	DAL	12	1	2	1550	5	12	0	0	2	9	0	0	-10	0	1	1	0	3	0	0	0
16.01.2025 01:00	7	Marshall N.	DAL	7	2	10	1816	3	7	0	0	1	2	0	0	-14	0	2	3	2	2	0	0	0
16.01.2025 01:00	8	Prosper O.	DAL	1	4	1	625	0	3	0	0	0	1	1	2	8	1	3	2	0	0	0	0	0
16.01.2025 01:00	9	Kleber M.	DAL	0	0	1	869	0	0	0	0	0	0	0	0	2	0	0	3	1	1	1	0	0
16.01.2025 01:00	10	Powell D.	DAL	0	0	1	211	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
16.01.2025 01:00	11	Williams B.	DAL	0	0	0	317	0	3	0	0	0	1	0	0	1	0	0	0	0	1	0	0	0
15.01.2025 02:30	12	Gafford D.	DAL	13	4	1	1142	5	8	0	0	0	0	3	4	-6	1	3	3	0	1	1	0	0
15.01.2025 02:30	13	Irving K.	DAL	11	4	2	1820	4	18	0	0	0	3	3	4	-17	1	3	1	4	1	1	0	0
15.01.2025 02:30	14	Marshall N.	DAL	11	2	4	1306	5	8	0	0	0	2	1	1	-7	0	2	1	0	1	0	0	0
15.01.2025 02:30	15	Grimes Q.	DAL	10	0	5	1595	3	8	0	0	2	6	2	2	0	0	0	1	3	0	0	0	0
15.01.2025 02:30	16	Kleber M.	DAL	10	1	3	1091	4	7	0	0	2	4	0	0	-17	1	0	2	0	0	0	0	0
15.01.2025 02:30	17	Prosper O.	DAL	10	2	1	856	4	6	0	0	1	3	1	4	10	0	2	0	1	1	1	0	0
15.01.2025 02:30	18	Dinwiddie S.	DAL	8	2	2	1204	3	4	0	0	1	2	1	1	-16	0	2	0	1	1	0	0	0
15.01.2025 02:30	19	Thompson K.	DAL	8	3	0	1244	3	8	0	0	2	6	0	0	-13	0	3	1	0	2	1	0	0
15.01.2025 02:30	20	Hardy J.	DAL	5	2	4	1219	2	9	0	0	0	3	1	2	-4	1	1	3	1	4	0	0	0
15.01.2025 02:30	21	Washington P. J.	DAL	5	8	4	1578	2	10	0	0	0	2	1	2	-19	3	5	2	2	1	1	0	0
15.01.2025 02:30	22	Lively D.	DAL	4	0	0	236	2	3	0	0	0	0	0	0	-4	0	0	0	0	0	1	0	0
15.01.2025 02:30	23	Williams B.	DAL	3	0	0	252	1	1	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0
15.01.2025 02:30	24	Powell D.	DAL	1	2	1	857	0	0	0	0	0	0	1	2	-2	1	1	3	2	0	0	0	0
12.01.2025 20:00	25	Thompson K.	DAL	25	6	2	2094	9	19	0	0	6	13	1	1	1	0	6	0	1	1	1	0	0
12.01.2025 20:00	26	Dinwiddie S.	DAL	16	4	10	2354	4	13	0	0	0	3	8	10	-17	1	3	3	1	2	0	0	0
12.01.2025 20:00	27	Marshall N.	DAL	16	6	2	1838	7	12	0	0	2	5	0	0	16	0	6	2	3	1	0	0	0
12.01.2025 20:00	28	Lively D.	DAL	14	5	8	1602	6	8	0	0	0	0	2	2	5	2	3	5	0	3	2	0	0
12.01.2025 20:00	29	Gafford D.	DAL	8	3	0	896	2	7	0	0	0	0	4	6	-7	1	2	3	0	0	1	0	0
12.01.2025 20:00	30	Washington P. J.	DAL	8	6	2	2245	3	9	0	0	0	2	2	4	2	1	5	1	1	0	1	0	0
12.01.2025 20:00	31	Kleber M.	DAL	6	3	0	1170	2	5	0	0	2	5	0	0	-26	3	0	3	0	1	0	0	0
12.01.2025 20:00	32	Hardy J.	DAL	5	0	3	933	1	7	0	0	1	3	2	2	-3	0	0	2	1	0	0	0	0
12.01.2025 20:00	33	Grimes Q.	DAL	3	4	0	1118	1	4	0	0	1	3	0	0	-22	0	4	1	0	4	0	0	0
12.01.2025 20:00	34	Prosper O.	DAL	0	0	0	150	0	1	0	0	0	0	0	0	-4	0	0	0	0	0	0	0	0
10.01.2025 00:30	35	Hardy J.	DAL	25	0	2	1756	10	18	0	0	5	9	0	1	13	0	0	2	1	2	0	0	0
10.01.2025 00:30	36	Washington P. J.	DAL	23	14	1	2103	5	13	0	0	2	5	11	11	3	2	12	3	3	2	1	0	0
10.01.2025 00:30	37	Lively D.	DAL	21	16	1	2084	9	13	0	0	0	0	3	3	15	7	9	3	0	2	3	0	0
10.01.2025 00:30	38	Dinwiddie S.	DAL	17	5	5	2096	5	12	0	0	1	5	6	8	7	0	5	1	1	0	0	0	0
10.01.2025 00:30	39	Grimes Q.	DAL	13	4	4	1612	5	12	0	0	2	6	1	1	2	1	3	3	1	2	0	0	0
10.01.2025 00:30	40	Marshall N.	DAL	11	2	4	1575	5	9	0	0	0	1	1	1	-6	0	2	2	0	2	0	0	0
10.01.2025 00:30	41	Thompson K.	DAL	3	3	4	1307	1	6	0	0	0	4	1	1	2	2	1	1	1	2	0	0	0
10.01.2025 00:30	42	Gafford D.	DAL	2	4	2	601	0	3	0	0	0	0	2	2	-4	2	2	2	0	2	3	0	0
10.01.2025 00:30	43	Kleber M.	DAL	2	2	1	707	0	0	0	0	0	0	2	2	-9	0	2	1	0	0	0	0	0
10.01.2025 00:30	44	Prosper O.	DAL	0	3	2	559	0	2	0	0	0	0	0	0	7	2	1	0	1	0	0	0	0
08.01.2025 00:30	45	Grimes Q.	DAL	23	9	6	1749	8	17	0	0	6	11	1	2	13	1	8	2	1	0	0	0	0
08.01.2025 00:30	46	Washington P. J.	DAL	22	8	0	2357	9	14	0	0	3	3	1	2	13	1	7	2	1	1	0	0	0
08.01.2025 00:30	47	Dinwiddie S.	DAL	19	6	8	2110	8	15	0	0	1	5	2	2	24	1	5	1	1	3	0	0	0
08.01.2025 00:30	48	Hardy J.	DAL	15	3	2	1323	6	11	0	0	3	6	0	0	13	1	2	3	1	0	0	0	0
08.01.2025 00:30	49	Thompson K.	DAL	13	0	2	1721	5	10	0	0	3	6	0	0	19	0	0	0	1	3	0	0	0
08.01.2025 00:30	50	Lively D.	DAL	7	6	3	1160	3	3	0	0	0	0	1	2	-4	2	4	5	0	1	0	0	0
08.01.2025 00:30	51	Marshall N.	DAL	7	5	2	1738	2	11	0	0	1	6	2	2	-13	3	2	1	1	1	0	0	0
08.01.2025 00:30	52	Kleber M.	DAL	5	3	5	1768	2	3	0	0	1	1	0	0	21	1	2	2	1	1	0	0	0
08.01.2025 00:30	53	Williams B.	DAL	4	0	0	86	2	2	0	0	0	0	0	0	4	0	0	0	0	0	0	0	0
08.01.2025 00:30	54	Prosper O.	DAL	3	3	1	302	0	0	0	0	0	0	3	4	11	1	2	0	0	0	0	0	0
08.01.2025 00:30	55	Powell D.	DAL	0	1	0	86	0	0	0	0	0	0	0	0	4	0	1	0	0	0	0	0	0
07.01.2025 01:00	56	Washington P. J.	DAL	17	10	5	1907	7	22	0	0	2	8	1	1	-18	2	8	5	3	2	0	0	0
07.01.2025 01:00	57	Marshall N.	DAL	16	6	3	1964	5	15	0	0	2	6	4	5	-8	1	5	2	2	2	0	0	0
07.01.2025 01:00	58	Hardy J.	DAL	15	3	2	1271	5	10	0	0	3	5	2	2	2	0	3	2	1	4	1	0	0
07.01.2025 01:00	59	Thompson K.	DAL	15	4	3	1596	5	16	0	0	3	8	2	2	-18	1	3	0	0	1	2	0	0
07.01.2025 01:00	60	Lively D.	DAL	14	12	1	1971	7	11	0	0	0	0	0	0	-17	5	7	3	0	0	3	0	0
07.01.2025 01:00	61	Grimes Q.	DAL	9	6	6	1561	4	13	0	0	1	6	0	0	-10	0	6	1	1	2	0	0	0
07.01.2025 01:00	62	Dinwiddie S.	DAL	6	1	3	1774	2	3	0	0	2	2	0	0	-9	0	1	4	0	2	0	0	0
07.01.2025 01:00	63	Gafford D.	DAL	5	1	0	470	2	3	0	0	0	0	1	3	6	0	1	2	0	0	1	0	0
07.01.2025 01:00	64	Kleber M.	DAL	4	2	1	1352	2	3	0	0	0	1	0	0	3	0	2	3	0	1	1	0	0
07.01.2025 01:00	65	Powell D.	DAL	2	5	1	384	1	2	0	0	0	0	0	0	-2	4	1	0	0	1	0	0	0
07.01.2025 01:00	66	Williams B.	DAL	1	0	0	75	0	0	0	0	0	0	1	2	-2	0	0	0	0	0	0	0	0
07.01.2025 01:00	67	Prosper O.	DAL	0	0	0	75	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
04.01.2025 01:30	68	Grimes Q.	DAL	26	2	6	1954	9	14	0	0	1	5	7	7	2	1	1	2	1	2	0	0	0
04.01.2025 01:30	69	Hardy J.	DAL	17	3	3	1498	6	11	0	0	2	4	3	4	-19	1	2	5	0	1	1	0	0
04.01.2025 01:30	70	Thompson K.	DAL	16	3	3	1710	4	13	0	0	4	10	4	4	-9	0	3	0	1	0	0	0	0
04.01.2025 01:30	71	Washington P. J.	DAL	15	7	1	1858	6	18	0	0	1	7	2	3	-15	1	6	1	0	2	1	0	0
04.01.2025 01:30	72	Williams B.	DAL	13	3	2	1205	4	9	0	0	2	4	3	4	8	1	2	1	0	1	0	0	0
04.01.2025 01:30	73	Gafford D.	DAL	12	8	2	1010	5	6	0	0	0	0	2	4	-2	5	3	0	0	1	1	0	0
04.01.2025 01:30	74	Lively D.	DAL	7	11	3	1623	3	5	0	0	0	0	1	2	-17	4	7	2	0	1	1	0	0
04.01.2025 01:30	75	Morris Mark.	DAL	5	1	1	247	2	5	0	0	1	4	0	0	7	0	1	1	0	0	0	0	0
04.01.2025 01:30	76	Prosper O.	DAL	4	4	1	449	1	5	0	0	0	1	2	2	-7	3	1	1	1	1	0	0	0
04.01.2025 01:30	77	Gortman J.	DAL	3	0	1	247	1	3	0	0	1	3	0	0	7	0	0	1	0	0	0	0	0
04.01.2025 01:30	78	Dinwiddie S.	DAL	2	4	5	1403	1	7	0	0	0	3	0	0	-16	1	3	1	0	3	0	0	0
04.01.2025 01:30	79	Kleber M.	DAL	2	4	1	949	1	4	0	0	0	3	0	0	-6	3	1	1	0	0	0	0	0
04.01.2025 01:30	80	Powell D.	DAL	0	3	0	247	0	0	0	0	0	0	0	0	7	1	2	1	0	0	0	0	0
02.01.2025 01:00	81	Grimes Q.	DAL	17	5	3	1811	6	13	0	0	2	7	3	4	-5	1	4	0	0	1	1	0	0
02.01.2025 01:00	82	Irving K.	DAL	16	7	2	2235	7	13	0	0	0	2	2	3	-16	0	7	4	3	4	2	0	0
02.01.2025 01:00	83	Thompson K.	DAL	16	5	1	1902	6	11	0	0	4	8	0	0	-21	1	4	3	1	5	0	0	0
02.01.2025 01:00	84	Hardy J.	DAL	11	0	3	1243	4	6	0	0	2	3	1	5	7	0	0	0	1	3	0	0	0
02.01.2025 01:00	85	Dinwiddie S.	DAL	8	1	2	1463	3	7	0	0	2	4	0	2	1	0	1	1	0	3	0	0	0
02.01.2025 01:00	86	Lively D.	DAL	8	6	6	1223	4	5	0	0	0	0	0	0	5	1	5	4	1	0	4	0	0
02.01.2025 01:00	87	Prosper O.	DAL	6	3	0	421	3	3	0	0	0	0	0	0	-1	1	2	1	1	0	0	0	0
02.01.2025 01:00	88	Washington P. J.	DAL	6	3	1	968	3	8	0	0	0	1	0	0	-4	0	3	1	0	0	1	0	0
02.01.2025 01:00	89	Kleber M.	DAL	5	2	1	1775	2	4	0	0	1	2	0	0	-15	1	1	4	1	2	1	0	0
02.01.2025 01:00	90	Gafford D.	DAL	4	4	0	705	2	4	0	0	0	0	0	0	-27	1	3	2	1	2	1	0	0
02.01.2025 01:00	91	Powell D.	DAL	2	2	0	417	0	0	0	0	0	0	2	2	13	0	2	0	0	0	2	0	0
02.01.2025 01:00	92	Gortman J.	DAL	0	0	0	114	0	1	0	0	0	1	0	0	4	0	0	0	0	0	0	0	0
02.01.2025 01:00	93	Williams B.	DAL	0	0	0	123	0	0	0	0	0	0	0	0	4	0	0	0	0	0	0	0	0
31.12.2024 03:00	94	Dinwiddie S.	DAL	30	3	6	2130	8	18	0	0	3	6	11	12	-9	0	3	1	1	2	0	0	0
31.12.2024 03:00	95	Washington P. J.	DAL	28	4	1	2284	8	20	0	0	4	9	8	10	0	0	4	4	1	2	2	0	0
31.12.2024 03:00	96	Grimes Q.	DAL	11	7	3	1975	4	12	0	0	3	7	0	0	-18	1	6	1	0	4	1	0	0
31.12.2024 03:00	97	Williams B.	DAL	10	1	2	1178	4	6	0	0	0	2	2	2	-6	0	1	1	1	2	0	0	0
31.12.2024 03:00	98	Gafford D.	DAL	8	6	0	1650	3	5	0	0	0	0	2	2	-12	0	6	5	1	3	5	0	0
31.12.2024 03:00	99	Hardy J.	DAL	8	3	0	1249	3	7	0	0	2	3	0	1	-8	0	3	4	0	1	2	0	0
31.12.2024 03:00	100	Gortman J.	DAL	5	2	1	500	2	3	0	0	0	0	1	2	10	0	2	3	1	3	0	0	0
31.12.2024 03:00	101	Edwards K.	DAL	0	0	0	129	0	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0
31.12.2024 03:00	102	Kleber M.	DAL	0	4	1	1765	0	3	0	0	0	3	0	0	-4	0	4	0	0	0	1	0	0
31.12.2024 03:00	103	Powell D.	DAL	0	5	2	1010	0	0	0	0	0	0	0	0	2	1	4	1	2	0	2	0	0
31.12.2024 03:00	104	Prosper O.	DAL	0	1	1	530	0	2	0	0	0	1	0	0	-8	0	1	0	1	0	0	0	0
29.12.2024 03:00	105	Irving K.	DAL	46	2	2	2318	16	26	0	0	5	12	9	9	-17	1	1	1	2	4	1	0	0
29.12.2024 03:00	106	Dinwiddie S.	DAL	17	8	4	2119	5	13	0	0	2	6	5	5	3	0	8	5	0	1	0	0	0
29.12.2024 03:00	107	Gafford D.	DAL	15	9	0	1695	6	8	0	0	0	0	3	4	-5	4	5	4	1	3	5	0	0
29.12.2024 03:00	108	Grimes Q.	DAL	15	6	3	1663	5	10	0	0	3	5	2	2	1	2	4	3	1	0	1	0	0
29.12.2024 03:00	109	Thompson K.	DAL	12	1	1	2060	5	17	0	0	2	8	0	0	4	0	1	3	1	1	0	0	0
29.12.2024 03:00	110	Hardy J.	DAL	11	4	1	1011	4	7	0	0	3	6	0	0	-11	0	4	2	0	1	0	0	0
29.12.2024 03:00	111	Prosper O.	DAL	4	2	1	799	1	3	0	0	0	0	2	6	1	1	1	0	1	1	0	0	0
29.12.2024 03:00	112	Powell D.	DAL	2	0	2	475	1	2	0	0	0	0	0	0	-7	0	0	1	0	1	1	0	0
29.12.2024 03:00	113	Edwards K.	DAL	0	0	0	16	0	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0
29.12.2024 03:00	114	Gortman J.	DAL	0	0	1	283	0	1	0	0	0	0	0	0	7	0	0	0	0	0	0	0	0
29.12.2024 03:00	115	Kleber M.	DAL	0	8	5	1961	0	2	0	0	0	1	0	0	1	2	6	2	0	1	2	0	0
28.12.2024 02:00	116	Irving K.	DAL	20	4	5	2378	6	21	0	0	5	10	3	3	12	0	4	4	1	5	0	0	0
28.12.2024 02:00	117	Gafford D.	DAL	16	5	1	1737	7	11	0	0	0	0	2	2	8	2	3	4	0	1	2	0	0
28.12.2024 02:00	118	Dinwiddie S.	DAL	15	3	3	1361	5	12	0	0	1	5	4	4	4	0	3	0	2	1	1	0	0
28.12.2024 02:00	119	Kleber M.	DAL	15	7	2	1573	5	7	0	0	1	2	4	4	4	1	6	0	1	0	0	0	0
28.12.2024 02:00	120	Thompson K.	DAL	11	6	5	1894	4	9	0	0	1	6	2	2	17	0	6	1	1	1	1	0	0
28.12.2024 02:00	121	Grimes Q.	DAL	8	5	1	1739	3	9	0	0	2	5	0	0	-10	1	4	0	0	2	0	0	0
28.12.2024 02:00	122	Washington P. J.	DAL	7	3	2	1192	2	5	0	0	2	4	1	2	10	1	2	3	0	4	0	0	1
28.12.2024 02:00	123	Marshall N.	DAL	4	3	2	1119	2	3	0	0	0	0	0	0	10	0	3	1	0	1	0	0	1
28.12.2024 02:00	124	Prosper O.	DAL	2	1	0	332	1	2	0	0	0	1	0	0	-1	0	1	0	1	0	0	0	0
28.12.2024 02:00	125	Edwards K.	DAL	0	0	0	52	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
28.12.2024 02:00	126	Gortman J.	DAL	0	0	0	52	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
28.12.2024 02:00	127	Hardy J.	DAL	0	0	0	52	0	1	0	0	0	1	0	0	-2	0	0	0	0	0	0	0	0
28.12.2024 02:00	128	Powell D.	DAL	0	4	3	919	0	0	0	0	0	0	0	0	-3	2	2	2	0	0	1	0	0
25.12.2024 19:30	129	Irving K.	DAL	39	5	2	2235	14	27	0	0	5	14	6	6	-4	1	4	1	0	2	1	0	0
25.12.2024 19:30	130	Doncic L.	DAL	14	5	2	973	5	9	0	0	3	5	1	1	-6	1	4	1	1	3	0	0	0
25.12.2024 19:30	131	Thompson K.	DAL	12	4	1	1715	4	12	0	0	4	10	0	0	2	0	4	0	2	2	2	0	0
25.12.2024 19:30	132	Grimes Q.	DAL	10	7	2	1457	4	9	0	0	2	5	0	0	-10	3	4	1	0	0	1	0	0
25.12.2024 19:30	133	Washington P. J.	DAL	7	7	2	2413	3	8	0	0	1	4	0	0	-3	2	5	1	1	1	1	0	0
25.12.2024 19:30	134	Lively D.	DAL	6	10	3	1804	3	7	0	0	0	0	0	0	6	4	6	3	1	2	2	0	0
25.12.2024 19:30	135	Kleber M.	DAL	5	2	1	1355	2	3	0	0	1	1	0	0	10	0	2	3	0	1	0	0	0
25.12.2024 19:30	136	Marshall N.	DAL	4	2	0	823	1	3	0	0	0	0	2	2	-7	0	2	1	0	1	0	0	0
25.12.2024 19:30	137	Dinwiddie S.	DAL	2	1	2	848	0	7	0	0	0	4	2	2	-9	0	1	0	1	0	0	0	0
25.12.2024 19:30	138	Gafford D.	DAL	0	0	0	777	0	2	0	0	0	0	0	0	-9	0	0	2	0	0	1	0	0
\.


--
-- Data for Name: dallas_mavericks_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dallas_mavericks_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Lively Dereck	Lesionado	2025-01-16 10:43:49.825582
2	Exum Dante	Lesionado	2025-01-16 10:43:49.83161
3	Irving Kyrie	Lesionado	2025-01-16 10:43:49.840396
4	Doncic Luka	Lesionado	2025-01-16 10:43:49.849387
\.


--
-- Data for Name: denver_nuggets; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.denver_nuggets (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	17.05.2024	Minnesota Timberwolves	115	Denver Nuggets	70	31	28	27	29	14	26	21	9
2	20.05.2024	Denver Nuggets	90	Minnesota Timberwolves	98	24	29	14	23	19	19	28	32
3	13.07.2024	Los Angeles Clippers	88	Denver Nuggets	78	17	24	19	28	16	22	19	21
4	15.07.2024	Toronto Raptors	84	Denver Nuggets	81	20	17	28	19	24	19	20	18
5	16.07.2024	Denver Nuggets	66	Charlotte Hornets	80	15	21	15	15	22	17	20	21
6	18.07.2024	Denver Nuggets	86	Indiana Pacers	71	18	24	17	27	13	13	26	19
7	21.07.2024	Denver Nuggets	91	New Orleans Pelicans	82	29	13	26	23	8	26	19	29
8	04.10.2024	Denver Nuggets	103	Boston Celtics	107	32	31	17	23	25	31	23	28
9	06.10.2024	Boston Celtics	130	Denver Nuggets	104	34	33	42	21	29	31	16	28
10	14.10.2024	Denver Nuggets	114	Phoenix Suns	118	33	27	30	24	26	25	37	30
11	16.10.2024	Denver Nuggets	94	Oklahoma City Thunder	124	33	20	18	23	30	32	25	37
12	18.10.2024	Minnesota Timberwolves	126	Denver Nuggets	132	22	37	32	35	25	43	29	35
13	25.10.2024	Denver Nuggets	87	Oklahoma City Thunder	102	24	27	17	19	31	27	27	17
14	26.10.2024	Denver Nuggets	104	Los Angeles Clippers	109	19	23	29	33	27	21	22	39
15	28.10.2024\nApós Prol.	Toronto Raptors	125	Denver Nuggets	127	30	32	26	26	29	25	29	31
16	29.10.2024\nApós Prol.	Brooklyn Nets	139	Denver Nuggets	144	40	32	27	26	27	36	33	29
17	02.11.2024	Minnesota Timberwolves	119	Denver Nuggets	116	33	31	27	28	29	32	24	31
18	03.11.2024	Denver Nuggets	129	Utah Jazz	103	37	28	34	30	26	30	19	28
19	05.11.2024	Denver Nuggets	121	Toronto Raptors	119	34	25	29	33	37	27	29	26
20	07.11.2024	Denver Nuggets	124	Oklahoma City Thunder	122	30	25	40	29	32	34	29	27
21	09.11.2024	Denver Nuggets	135	Miami Heat	122	40	31	33	31	27	33	30	32
22	11.11.2024	Denver Nuggets	122	Dallas Mavericks	120	35	25	37	25	29	34	31	26
23	16.11.2024	New Orleans Pelicans	101	Denver Nuggets	94	32	27	19	23	22	32	18	22
24	17.11.2024	Memphis Grizzlies	105	Denver Nuggets	90	28	27	29	21	25	18	21	26
25	20.11.2024	Memphis Grizzlies	110	Denver Nuggets	122	24	33	21	32	31	37	24	30
26	23.11.2024	Denver Nuggets	120	Dallas Mavericks	123	31	22	36	31	33	40	22	28
27	24.11.2024	Los Angeles Lakers	102	Denver Nuggets	127	27	36	15	24	31	26	37	33
28	26.11.2024	Denver Nuggets	118	New York Knicks	145	24	29	34	31	36	40	37	32
29	28.11.2024	Utah Jazz	103	Denver Nuggets	122	35	18	23	27	34	29	37	22
30	02.12.2024	Los Angeles Clippers	126	Denver Nuggets	122	32	27	33	34	23	36	31	32
31	04.12.2024	Denver Nuggets	119	Golden State Warriors	115	33	24	33	29	31	26	28	30
32	06.12.2024	Cleveland Cavaliers	126	Denver Nuggets	114	37	29	36	24	27	35	25	27
33	08.12.2024	Washington Wizards	122	Denver Nuggets	113	36	33	30	23	29	28	36	20
34	08.12.2024	Atlanta Hawks	111	Denver Nuggets	141	23	25	36	27	38	33	35	35
35	14.12.2024	Denver Nuggets	120	Los Angeles Clippers	98	29	19	35	37	22	25	22	29
36	17.12.2024	Sacramento Kings	129	Denver Nuggets	130	21	47	35	26	41	34	21	34
37	20.12.2024	Portland Trail Blazers	126	Denver Nuggets	124	30	36	38	22	35	31	21	37
38	23.12.2024\nApós Prol.	New Orleans Pelicans	129	Denver Nuggets	132	29	38	26	26	28	31	22	38
39	24.12.2024	Denver Nuggets	117	Phoenix Suns	90	27	28	45	17	26	25	28	11
40	26.12.2024	Phoenix Suns	110	Denver Nuggets	100	38	20	27	25	34	22	22	22
41	28.12.2024	Denver Nuggets	135	Cleveland Cavaliers	149	38	27	36	34	40	40	36	33
42	29.12.2024	Denver Nuggets	134	Detroit Pistons	121	36	31	47	20	38	23	28	32
43	31.12.2024	Utah Jazz	121	Denver Nuggets	132	37	29	23	32	36	28	34	34
44	02.01. 02:00	Denver Nuggets	139	Atlanta Hawks	120	40	34	41	24	33	38	24	25
45	04.01. 02:00	Denver Nuggets	110	San Antonio Spurs	113	30	22	38	20	32	28	27	26
46	05.01. 01:00\nApós Prol.	San Antonio Spurs	111	Denver Nuggets	122	27	28	37	16	30	24	27	27
47	08.01. 03:00	Denver Nuggets	106	Boston Celtics	118	25	32	26	23	37	20	31	30
48	09.01. 02:00	Denver Nuggets	126	Los Angeles Clippers	103	33	33	32	28	19	31	27	26
49	11.01. 02:00	Denver Nuggets	124	Brooklyn Nets	105	32	33	29	30	36	23	20	26
50	12.01. 20:00	Dallas Mavericks	101	Denver Nuggets	112	32	29	28	12	17	41	21	33
51	15.01. 02:30	Dallas Mavericks	99	Denver Nuggets	118	21	24	22	32	36	35	20	27
52	16.01. 02:00	Denver Nuggets	108	Houston Rockets	128	23	25	33	27	28	41	33	26
\.


--
-- Data for Name: denver_nuggets_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.denver_nuggets_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 02:00	1	Braun C.	DEN	22	5	1	2089	10	11	0	0	2	3	0	0	-17	2	3	2	0	1	0	0	0
16.01.2025 02:00	2	Murray J.	DEN	22	3	5	1778	8	14	0	0	4	5	2	2	-17	0	3	2	0	5	0	0	0
16.01.2025 02:00	3	Westbrook R.	DEN	17	4	2	1481	6	14	0	0	3	5	2	2	-15	3	1	3	1	5	0	0	0
16.01.2025 02:00	4	Strawther J. L.	DEN	10	1	3	1484	3	9	0	0	2	6	2	2	-4	0	1	2	0	3	0	0	0
16.01.2025 02:00	5	Watson P.	DEN	10	3	0	1365	4	8	0	0	1	3	1	2	-7	0	3	0	0	1	3	0	0
16.01.2025 02:00	6	Porter M.	DEN	8	3	0	1421	2	4	0	0	0	2	4	7	-20	1	2	2	0	2	1	0	0
16.01.2025 02:00	7	Saric D.	DEN	8	4	5	1132	3	4	0	0	0	0	2	4	-2	1	3	1	0	0	0	0	0
16.01.2025 02:00	8	Tyson H.	DEN	4	2	0	450	1	3	0	0	1	2	1	2	2	1	1	1	0	0	0	0	0
16.01.2025 02:00	9	Alexander T.	DEN	3	1	1	350	1	4	0	0	1	2	0	0	1	0	1	1	1	0	0	0	0
16.01.2025 02:00	10	Nnaji Z.	DEN	2	1	0	350	1	1	0	0	0	0	0	0	1	0	1	0	0	0	0	0	0
16.01.2025 02:00	11	Pickett J.	DEN	2	1	5	1102	1	3	0	0	0	1	0	0	-3	0	1	0	1	0	0	0	0
16.01.2025 02:00	12	Jordan D.	DEN	0	8	0	1398	0	0	0	0	0	0	0	0	-19	1	7	2	1	1	3	0	0
15.01.2025 02:30	13	Murray J.	DEN	45	2	6	2219	18	26	0	0	5	9	4	4	14	0	2	0	2	5	0	0	0
15.01.2025 02:30	14	Porter M.	DEN	13	6	2	1574	5	9	0	0	3	4	0	0	20	1	5	0	1	1	0	0	0
15.01.2025 02:30	15	Jokic N.	DEN	10	14	10	1736	4	7	0	0	1	2	1	2	23	2	12	3	2	1	0	0	0
15.01.2025 02:30	16	Watson P.	DEN	9	5	1	1619	2	6	0	0	1	3	4	4	10	0	5	2	1	1	1	0	0
15.01.2025 02:30	17	Westbrook R.	DEN	9	6	3	1575	3	11	0	0	1	3	2	2	22	2	4	2	2	4	1	0	0
15.01.2025 02:30	18	Gordon A.	DEN	8	2	0	1054	2	9	0	0	0	3	4	4	-1	2	0	2	1	0	1	0	0
15.01.2025 02:30	19	Jordan D.	DEN	8	6	2	936	3	4	0	0	0	0	2	4	0	3	3	0	0	2	1	0	0
15.01.2025 02:30	20	Braun C.	DEN	6	4	0	1755	3	6	0	0	0	1	0	0	21	1	3	2	0	0	3	0	0
15.01.2025 02:30	21	Nnaji Z.	DEN	4	1	0	208	1	1	0	0	0	0	2	2	-4	0	1	0	0	2	0	0	0
15.01.2025 02:30	22	Pickett J.	DEN	3	0	0	252	1	1	0	0	1	1	0	0	0	0	0	1	0	1	0	0	0
15.01.2025 02:30	23	Strawther J. L.	DEN	3	3	3	1059	1	3	0	0	1	3	0	0	-2	0	3	4	0	1	0	0	0
15.01.2025 02:30	24	Alexander T.	DEN	0	1	0	205	0	0	0	0	0	0	0	0	-4	0	1	1	0	0	0	0	0
15.01.2025 02:30	25	Tyson H.	DEN	0	1	1	208	0	0	0	0	0	0	0	0	-4	0	1	3	0	0	0	0	0
12.01.2025 20:00	26	Westbrook R.	DEN	21	10	7	2019	10	17	0	0	0	2	1	3	-3	2	8	3	1	4	2	0	0
12.01.2025 20:00	27	Jokic N.	DEN	19	18	9	2318	6	13	0	0	0	2	7	9	-2	4	14	4	2	4	0	0	0
12.01.2025 20:00	28	Murray J.	DEN	17	2	2	1918	7	18	0	0	2	6	1	3	-5	0	2	4	0	1	0	0	0
12.01.2025 20:00	29	Gordon A.	DEN	13	6	2	1102	6	7	0	0	1	2	0	0	23	1	5	0	0	1	1	0	0
12.01.2025 20:00	30	Porter M.	DEN	13	4	1	1521	5	13	0	0	1	8	2	2	2	3	1	3	1	0	0	0	0
12.01.2025 20:00	31	Watson P.	DEN	10	6	1	1977	3	5	0	0	2	3	2	2	30	0	6	0	1	2	1	0	0
12.01.2025 20:00	32	Braun C.	DEN	8	4	0	1453	4	9	0	0	0	4	0	0	-19	3	1	2	0	1	0	0	0
12.01.2025 20:00	33	Jordan D.	DEN	6	5	0	562	3	3	0	0	0	0	0	1	13	2	3	0	0	0	1	0	0
12.01.2025 20:00	34	Strawther J. L.	DEN	5	0	1	1530	2	9	0	0	1	5	0	0	16	0	0	3	1	0	0	0	0
11.01.2025 02:00	35	Jokic N.	DEN	35	12	15	2291	14	21	0	0	1	1	6	8	33	5	7	1	4	1	0	0	0
11.01.2025 02:00	36	Westbrook R.	DEN	25	11	10	2182	8	17	0	0	2	5	7	9	21	4	7	3	1	2	1	0	0
11.01.2025 02:00	37	Porter M.	DEN	17	6	1	2049	7	16	0	0	2	9	1	2	19	2	4	0	2	1	2	0	0
11.01.2025 02:00	38	Strawther J. L.	DEN	12	1	0	1879	4	9	0	0	2	5	2	2	14	0	1	4	0	1	0	0	0
11.01.2025 02:00	39	Braun C.	DEN	11	7	0	1745	4	7	0	0	1	1	2	2	18	0	7	3	1	1	0	0	0
11.01.2025 02:00	40	Watson P.	DEN	10	7	5	2080	3	5	0	0	0	0	4	5	8	0	7	3	2	5	2	0	0
11.01.2025 02:00	41	Murray J.	DEN	7	0	3	969	2	5	0	0	1	2	2	2	0	0	0	0	1	3	0	0	0
11.01.2025 02:00	42	Pickett J.	DEN	5	1	0	574	2	4	0	0	0	1	1	1	-1	0	1	2	0	0	0	0	0
11.01.2025 02:00	43	Jordan D.	DEN	2	4	0	589	1	3	0	0	0	0	0	2	-14	1	3	2	1	0	0	0	0
11.01.2025 02:00	44	Tyson H.	DEN	0	0	0	42	0	0	0	0	0	0	0	0	-3	0	0	0	0	0	0	0	0
09.01.2025 02:00	45	Murray J.	DEN	21	3	9	2023	7	13	0	0	4	6	3	3	24	0	3	1	1	2	1	0	0
09.01.2025 02:00	46	Porter M.	DEN	19	8	2	1629	8	12	0	0	3	5	0	0	15	0	8	1	1	2	0	0	1
09.01.2025 02:00	47	Westbrook R.	DEN	19	6	8	1766	8	16	0	0	1	5	2	5	18	2	4	3	0	3	0	0	1
09.01.2025 02:00	48	Strawther J. L.	DEN	16	4	2	1899	5	10	0	0	4	8	2	2	18	0	4	3	0	1	0	0	0
09.01.2025 02:00	49	Braun C.	DEN	15	2	1	1706	6	8	0	0	2	2	1	1	11	0	2	4	1	0	0	0	0
09.01.2025 02:00	50	Jordan D.	DEN	12	9	2	1398	5	6	0	0	0	0	2	3	17	2	7	2	2	0	0	0	0
09.01.2025 02:00	51	Watson P.	DEN	9	4	1	1442	4	10	0	0	0	2	1	3	17	0	4	3	1	1	2	0	0
09.01.2025 02:00	52	Saric D.	DEN	7	7	2	1215	3	8	0	0	1	4	0	0	11	3	4	2	1	2	0	0	0
09.01.2025 02:00	53	Pickett J.	DEN	6	0	0	267	2	2	0	0	2	2	0	0	-5	0	0	0	0	0	0	0	0
09.01.2025 02:00	54	Nnaji Z.	DEN	2	0	0	267	1	1	0	0	0	0	0	0	-5	0	0	2	0	0	0	0	0
09.01.2025 02:00	55	Alexander T.	DEN	0	1	2	267	0	2	0	0	0	1	0	0	-5	0	1	0	0	0	0	0	0
09.01.2025 02:00	56	Tyson H.	DEN	0	1	0	521	0	1	0	0	0	0	0	0	-1	0	1	3	0	0	0	0	0
08.01.2025 03:00	57	Westbrook R.	DEN	26	9	6	2006	9	18	0	0	4	9	4	5	-10	3	6	2	1	8	1	0	0
08.01.2025 03:00	58	Murray J.	DEN	19	4	4	2352	8	17	0	0	1	5	2	2	-3	2	2	3	2	1	0	0	0
08.01.2025 03:00	59	Strawther J. L.	DEN	19	2	2	1615	8	15	0	0	3	6	0	0	-3	1	1	2	1	1	0	0	0
08.01.2025 03:00	60	Porter M.	DEN	15	10	3	2156	5	13	0	0	2	7	3	4	-16	1	9	1	0	1	0	0	0
08.01.2025 03:00	61	Watson P.	DEN	14	4	0	2021	5	9	0	0	2	3	2	2	-3	2	2	3	1	1	4	0	0
08.01.2025 03:00	62	Braun C.	DEN	12	4	2	1711	5	10	0	0	2	5	0	0	-11	2	2	3	1	2	0	0	0
08.01.2025 03:00	63	Jordan D.	DEN	1	5	1	1179	0	1	0	0	0	0	1	2	1	2	3	2	0	1	0	0	0
08.01.2025 03:00	64	Alexander T.	DEN	0	0	0	23	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
08.01.2025 03:00	65	Nnaji Z.	DEN	0	0	0	299	0	2	0	0	0	0	0	0	-8	0	0	0	0	0	0	0	0
08.01.2025 03:00	66	Pickett J.	DEN	0	0	0	23	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
08.01.2025 03:00	67	Saric D.	DEN	0	1	4	992	0	2	0	0	0	1	0	0	-7	0	1	1	0	1	1	0	0
08.01.2025 03:00	68	Tyson H.	DEN	0	0	0	23	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
05.01.2025 01:00	69	Jokic N.	DEN	46	9	10	2599	19	35	0	0	3	8	5	6	7	4	5	3	2	2	2	0	0
05.01.2025 01:00	70	Porter M.	DEN	28	10	2	2778	9	17	0	0	4	9	6	7	21	2	8	1	0	1	0	0	0
05.01.2025 01:00	71	Murray J.	DEN	13	6	6	2266	6	17	0	0	1	3	0	0	4	0	6	3	5	1	1	0	0
05.01.2025 01:00	72	Westbrook R.	DEN	9	10	6	2176	4	11	0	0	1	4	0	0	5	4	6	3	3	1	1	0	1
05.01.2025 01:00	73	Braun C.	DEN	8	2	3	1624	4	8	0	0	0	1	0	0	-15	0	2	2	1	0	1	0	0
05.01.2025 01:00	74	Watson P.	DEN	8	8	3	2031	2	6	0	0	0	3	4	6	21	1	7	0	0	1	2	0	0
05.01.2025 01:00	75	Strawther J. L.	DEN	5	5	2	1557	1	9	0	0	1	5	2	2	7	0	5	2	0	0	0	0	0
05.01.2025 01:00	76	Jordan D.	DEN	3	6	0	581	1	4	0	0	0	0	1	2	4	3	3	2	0	1	0	0	0
05.01.2025 01:00	77	Pickett J.	DEN	2	2	0	230	1	1	0	0	0	0	0	0	4	0	2	0	0	0	0	0	0
05.01.2025 01:00	78	Tyson H.	DEN	0	0	0	58	0	0	0	0	0	0	0	0	-3	0	0	1	0	0	0	0	0
04.01.2025 02:00	79	Jokic N.	DEN	41	18	9	2199	15	36	0	0	3	10	8	9	7	4	14	3	2	2	0	0	0
04.01.2025 02:00	80	Porter M.	DEN	22	4	1	2506	9	14	0	0	4	8	0	0	7	1	3	0	0	1	2	0	0
04.01.2025 02:00	81	Murray J.	DEN	14	4	7	2193	6	17	0	0	2	5	0	0	-7	1	3	1	0	2	0	0	0
04.01.2025 02:00	82	Braun C.	DEN	11	8	5	2565	3	10	0	0	2	6	3	4	0	1	7	2	0	0	2	0	0
04.01.2025 02:00	83	Strawther J. L.	DEN	11	1	1	1377	4	7	0	0	3	6	0	0	1	0	1	2	1	0	0	0	0
04.01.2025 02:00	84	Westbrook R.	DEN	9	6	8	1874	4	7	0	0	1	2	0	2	6	1	5	5	2	3	0	0	0
04.01.2025 02:00	85	Watson P.	DEN	2	2	2	1117	1	4	0	0	0	1	0	1	-10	1	1	0	2	0	2	0	0
04.01.2025 02:00	86	Jordan D.	DEN	0	2	0	248	0	1	0	0	0	0	0	0	-8	1	1	0	0	0	0	0	0
04.01.2025 02:00	87	Tyson H.	DEN	0	1	0	321	0	1	0	0	0	1	0	0	-11	0	1	0	0	0	1	0	0
02.01.2025 02:00	88	Jokic N.	DEN	23	17	15	1771	8	16	0	0	1	1	6	6	31	3	14	2	0	2	1	0	0
02.01.2025 02:00	89	Murray J.	DEN	21	3	2	2131	6	14	0	0	2	5	7	7	11	1	2	1	2	2	1	0	0
02.01.2025 02:00	90	Porter M.	DEN	21	4	2	1459	8	14	0	0	5	9	0	0	24	0	4	1	1	1	0	0	0
02.01.2025 02:00	91	Westbrook R.	DEN	16	2	11	1537	5	6	0	0	1	2	5	5	24	0	2	3	0	2	0	0	0
02.01.2025 02:00	92	Braun C.	DEN	15	3	4	1908	7	9	0	0	0	1	1	1	23	0	3	3	0	0	0	0	0
02.01.2025 02:00	93	Strawther J. L.	DEN	13	6	2	1806	6	12	0	0	1	5	0	0	4	0	6	2	2	1	1	0	0
02.01.2025 02:00	94	Watson P.	DEN	11	0	1	1441	4	10	0	0	1	4	2	2	3	0	0	2	2	2	1	0	0
02.01.2025 02:00	95	Jordan D.	DEN	8	7	3	907	4	4	0	0	0	0	0	0	-6	0	7	1	1	1	1	0	0
02.01.2025 02:00	96	Pickett J.	DEN	7	1	4	794	3	5	0	0	1	2	0	0	-4	0	1	1	0	1	0	0	0
02.01.2025 02:00	97	Jones S.	DEN	2	0	0	202	1	2	0	0	0	1	0	0	-6	0	0	0	0	0	0	0	0
02.01.2025 02:00	98	Nnaji Z.	DEN	2	0	0	202	1	2	0	0	0	0	0	0	-6	0	0	0	0	0	0	0	0
02.01.2025 02:00	99	Tyson H.	DEN	0	0	0	242	0	0	0	0	0	0	0	0	-3	0	0	0	0	0	0	0	0
31.12.2024 02:00	100	Jokic N.	DEN	36	22	11	2298	14	33	0	0	3	9	5	6	20	7	15	0	4	2	0	0	0
31.12.2024 02:00	101	Porter M.	DEN	21	6	2	2085	8	18	0	0	3	6	2	3	13	5	1	4	0	0	0	0	0
31.12.2024 02:00	102	Braun C.	DEN	20	2	2	2168	9	12	0	0	0	1	2	2	20	0	2	3	2	0	1	0	0
31.12.2024 02:00	103	Murray J.	DEN	20	4	10	2234	7	17	0	0	2	6	4	4	-9	1	3	2	2	3	1	0	0
31.12.2024 02:00	104	Westbrook R.	DEN	16	10	10	1964	7	7	0	0	0	0	2	2	23	3	7	3	4	0	0	0	0
31.12.2024 02:00	105	Watson P.	DEN	13	4	1	1582	6	9	0	0	1	3	0	0	-2	0	4	1	0	1	1	0	0
31.12.2024 02:00	106	Strawther J. L.	DEN	4	2	1	1069	1	5	0	0	0	3	2	2	5	1	1	2	1	1	0	0	0
31.12.2024 02:00	107	Jordan D.	DEN	2	1	1	582	1	2	0	0	0	0	0	0	-9	0	1	1	0	0	0	0	0
31.12.2024 02:00	108	Tyson H.	DEN	0	0	0	418	0	2	0	0	0	2	0	0	-6	0	0	1	0	0	0	0	0
29.12.2024 02:00	109	Jokic N.	DEN	37	9	8	2234	11	17	0	0	4	5	11	14	25	1	8	4	0	2	0	0	0
29.12.2024 02:00	110	Murray J.	DEN	34	5	4	2374	12	21	0	0	4	7	6	7	24	1	4	1	1	1	3	0	0
29.12.2024 02:00	111	Porter M.	DEN	26	3	0	2023	9	14	0	0	5	7	3	4	5	1	2	1	0	1	0	0	0
29.12.2024 02:00	112	Braun C.	DEN	10	4	3	1777	2	4	0	0	0	1	6	6	13	2	2	3	3	0	1	0	0
29.12.2024 02:00	113	Westbrook R.	DEN	8	9	8	1832	4	6	0	0	0	1	0	0	13	2	7	4	2	6	0	0	0
29.12.2024 02:00	114	Jordan D.	DEN	6	3	0	646	2	2	0	0	0	0	2	4	-12	0	3	0	0	1	1	0	0
29.12.2024 02:00	115	Strawther J. L.	DEN	6	3	1	1353	3	9	0	0	0	4	0	0	-5	0	3	3	1	1	0	0	0
29.12.2024 02:00	116	Watson P.	DEN	5	1	3	1369	2	6	0	0	0	1	1	1	-6	0	1	2	2	0	1	0	0
29.12.2024 02:00	117	Tyson H.	DEN	2	3	2	792	1	3	0	0	0	1	0	0	8	1	2	0	0	1	0	0	0
28.12.2024 02:00	118	Jokic N.	DEN	27	14	13	2145	12	19	0	0	0	3	3	4	-15	3	11	1	3	1	0	0	0
28.12.2024 02:00	119	Murray J.	DEN	27	3	11	2423	10	20	0	0	3	6	4	4	-9	0	3	3	2	4	0	0	0
28.12.2024 02:00	120	Porter M.	DEN	18	4	3	1916	6	11	0	0	5	8	1	2	-5	1	3	5	0	1	0	0	0
28.12.2024 02:00	121	Watson P.	DEN	18	1	2	1539	6	8	0	0	2	2	4	5	-16	0	1	0	1	0	1	0	0
28.12.2024 02:00	122	Braun C.	DEN	16	2	1	1913	7	9	0	0	2	4	0	0	-21	1	1	4	1	1	0	0	0
28.12.2024 02:00	123	Strawther J. L.	DEN	11	3	0	1391	4	8	0	0	1	2	2	2	6	1	2	0	0	2	0	0	0
28.12.2024 02:00	124	Westbrook R.	DEN	11	4	7	1771	5	13	0	0	1	5	0	0	-13	0	4	3	1	4	0	0	0
28.12.2024 02:00	125	Jordan D.	DEN	4	7	1	639	2	4	0	0	0	0	0	1	-1	3	4	3	0	0	2	0	0
28.12.2024 02:00	126	Tyson H.	DEN	3	1	0	375	1	3	0	0	1	1	0	0	-2	0	1	1	0	0	0	0	0
28.12.2024 02:00	127	Jones S.	DEN	0	0	0	96	0	0	0	0	0	0	0	0	2	0	0	0	0	0	0	0	0
28.12.2024 02:00	128	Nnaji Z.	DEN	0	0	0	96	0	0	0	0	0	0	0	0	2	0	0	0	0	0	0	0	0
28.12.2024 02:00	129	Pickett J.	DEN	0	0	1	96	0	0	0	0	0	0	0	0	2	0	0	0	0	0	0	0	0
\.


--
-- Data for Name: denver_nuggets_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.denver_nuggets_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Jokic Nikola	Lesionado	2025-01-16 10:44:02.831016
2	Cancar Vlatko	Lesionado	2025-01-16 10:44:02.832999
3	Holmes Daron	Lesionado	2025-01-16 10:44:02.834572
\.


--
-- Data for Name: detroit_pistons; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.detroit_pistons (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	14.04.2024	San Antonio Spurs	123	Detroit Pistons	95	29	34	30	30	23	17	23	32
2	14.07.2024	Philadelphia 76ers	94	Detroit Pistons	81	18	23	23	30	16	21	26	18
3	15.07.2024	Houston Rockets	73	Detroit Pistons	87	16	20	28	9	13	24	26	24
4	16.07.2024	Detroit Pistons	85	Chicago Bulls	77	17	21	24	23	31	13	20	13
5	20.07.2024	Detroit Pistons	90	New York Knicks	91	27	18	18	27	28	27	21	15
6	22.07.2024	Utah Jazz	97	Detroit Pistons	87	27	40	17	13	18	21	33	15
7	07.10.2024	Detroit Pistons	120	Milwaukee Bucks	87	28	32	31	29	39	19	21	8
8	09.10.2024	Detroit Pistons	97	Phoenix Suns	105	29	17	20	31	36	17	31	21
9	12.10.2024	Phoenix Suns	91	Detroit Pistons	109	29	21	24	17	40	25	23	21
10	14.10.2024	Golden State Warriors	111	Detroit Pistons	93	31	29	26	25	17	24	28	24
11	17.10.2024	Detroit Pistons	108	Cleveland Cavaliers	92	28	32	21	27	34	27	14	17
12	24.10.2024	Detroit Pistons	109	Indiana Pacers	115	31	27	32	19	25	24	33	33
13	26.10.2024	Cleveland Cavaliers	113	Detroit Pistons	101	28	37	26	22	29	26	24	22
14	27.10.2024	Detroit Pistons	118	Boston Celtics	124	31	31	31	25	42	31	21	30
15	28.10.2024	Miami Heat	106	Detroit Pistons	98	28	36	14	28	30	23	26	19
16	30.10.2024	Philadelphia 76ers	95	Detroit Pistons	105	26	19	22	28	22	32	31	20
17	01.11.2024	Detroit Pistons	98	New York Knicks	128	13	33	28	24	39	30	35	24
18	03.11.2024	Brooklyn Nets	92	Detroit Pistons	106	25	32	20	15	29	23	31	23
19	05.11.2024	Detroit Pistons	115	Los Angeles Lakers	103	33	34	16	32	22	31	24	26
20	07.11.2024	Charlotte Hornets	108	Detroit Pistons	107	23	23	31	31	24	21	31	31
21	09.11.2024	Detroit Pistons	122	Atlanta Hawks	121	40	26	29	27	23	30	32	36
22	10.11.2024	Detroit Pistons	99	Houston Rockets	101	17	28	19	35	20	23	29	29
23	13.11.2024\nApós Prol.	Detroit Pistons	123	Miami Heat	121	32	25	34	20	21	30	31	29
24	14.11.2024\nApós Prol.	Milwaukee Bucks	127	Detroit Pistons	120	24	23	38	26	27	33	24	27
25	16.11.2024	Toronto Raptors	95	Detroit Pistons	99	27	25	26	17	32	23	18	26
26	17.11.2024	Washington Wizards	104	Detroit Pistons	124	18	35	26	25	28	37	37	22
27	19.11.2024	Detroit Pistons	112	Chicago Bulls	122	25	32	28	27	36	29	28	29
28	22.11.2024\nApós Prol.	Charlotte Hornets	123	Detroit Pistons	121	33	30	30	16	27	32	20	30
29	24.11.2024	Orlando Magic	111	Detroit Pistons	100	33	23	32	23	21	32	26	21
30	26.11.2024	Detroit Pistons	102	Toronto Raptors	100	29	19	24	30	22	26	32	20
31	28.11.2024	Memphis Grizzlies	131	Detroit Pistons	111	34	37	33	27	35	18	24	34
32	30.11.2024	Indiana Pacers	106	Detroit Pistons	130	24	29	20	33	33	30	29	38
33	01.12.2024	Detroit Pistons	96	Philadelphia 76ers	111	20	32	17	27	37	20	32	22
34	04.12.2024	Detroit Pistons	107	Milwaukee Bucks	128	31	28	29	19	36	42	32	18
35	05.12.2024	Boston Celtics	130	Detroit Pistons	120	39	33	31	27	24	34	30	32
36	08.12.2024	New York Knicks	111	Detroit Pistons	120	23	35	27	26	39	30	20	31
37	13.12.2024	Boston Celtics	123	Detroit Pistons	99	27	32	34	30	16	28	24	31
38	17.12.2024\nApós Prol.	Detroit Pistons	125	Miami Heat	124	33	30	34	17	32	27	22	33
39	20.12.2024	Detroit Pistons	119	Utah Jazz	126	19	35	32	33	48	19	30	29
40	22.12.2024	Phoenix Suns	125	Detroit Pistons	133	26	33	35	31	41	23	39	30
41	24.12.2024	Los Angeles Lakers	114	Detroit Pistons	117	32	32	28	22	34	28	31	24
42	27.12.2024	Sacramento Kings	113	Detroit Pistons	114	37	31	23	22	34	19	24	37
43	29.12.2024	Denver Nuggets	134	Detroit Pistons	121	36	31	47	20	38	23	28	32
44	02.01. 00:00	Detroit Pistons	105	Orlando Magic	96	31	34	19	21	21	28	26	21
45	04.01. 00:00	Detroit Pistons	98	Charlotte Hornets	94	26	26	32	14	31	34	17	12
46	05.01. 00:00	Detroit Pistons	119	Minnesota Timberwolves	105	33	22	41	23	28	15	38	24
47	07.01. 00:00	Detroit Pistons	118	Portland Trail Blazers	115	23	28	37	30	28	32	30	25
48	09.01. 00:30	Brooklyn Nets	98	Detroit Pistons	113	25	24	21	28	27	32	32	22
49	10.01. 00:00	Detroit Pistons	104	Golden State Warriors	107	23	24	27	30	25	32	25	25
50	12.01. 00:00	Detroit Pistons	123	Toronto Raptors	114	32	33	34	24	32	34	27	21
51	14.01. 00:30	New York Knicks	119	Detroit Pistons	124	26	37	27	29	37	22	36	29
52	17.01. 00:00	Detroit Pistons	100	Indiana Pacers	111	26	30	25	19	29	40	23	19
\.


--
-- Data for Name: detroit_pistons_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.detroit_pistons_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
14.01.2025 00:30	1	Cunningham C.	DET	36	2	4	1923	14	27	0	0	4	8	4	4	4	0	2	4	1	2	0	0	0
14.01.2025 00:30	2	Beasley M.	DET	22	2	1	1058	7	13	0	0	6	8	2	3	10	1	1	1	1	0	0	0	0
14.01.2025 00:30	3	Harris T.	DET	11	8	3	2166	3	12	0	0	1	3	4	4	12	2	6	1	3	0	0	0	0
14.01.2025 00:30	4	Thompson A.	DET	11	7	1	1539	4	7	0	0	1	2	2	2	-1	0	7	2	2	1	0	0	0
14.01.2025 00:30	5	Duren J.	DET	10	8	3	1173	4	4	0	0	0	0	2	2	-9	4	4	6	0	1	0	0	0
14.01.2025 00:30	6	Hardaway T.	DET	10	4	3	2122	4	12	0	0	2	8	0	0	5	0	4	0	0	0	0	0	0
14.01.2025 00:30	7	Sasser M.	DET	7	0	4	934	3	5	0	0	1	2	0	0	1	0	0	0	1	3	0	0	0
14.01.2025 00:30	8	Stewart I.	DET	7	4	0	1708	3	5	0	0	0	1	1	1	14	3	1	2	0	1	2	0	0
14.01.2025 00:30	9	Holland R.	DET	6	2	1	870	3	4	0	0	0	1	0	0	-6	0	2	1	0	1	0	0	0
14.01.2025 00:30	10	Fontecchio S.	DET	4	3	0	907	1	3	0	0	0	1	2	2	-5	1	2	4	0	2	0	0	0
12.01.2025 00:00	11	Hardaway T.	DET	27	3	1	1896	9	13	0	0	7	8	2	3	22	0	3	0	2	1	0	0	0
12.01.2025 00:00	12	Cunningham C.	DET	22	10	17	2228	8	17	0	0	2	4	4	5	23	1	9	4	1	8	2	0	0
12.01.2025 00:00	13	Beasley M.	DET	18	3	2	1630	6	10	0	0	4	5	2	4	0	0	3	3	1	2	0	0	0
12.01.2025 00:00	14	Harris T.	DET	17	7	3	2090	6	12	0	0	2	5	3	3	12	0	7	2	0	1	1	0	0
12.01.2025 00:00	15	Duren J.	DET	10	9	2	1699	3	4	0	0	0	0	4	4	12	1	8	5	0	1	1	0	0
12.01.2025 00:00	16	Fontecchio S.	DET	9	3	0	929	4	8	0	0	1	3	0	0	-8	1	2	2	0	0	0	0	0
12.01.2025 00:00	17	Stewart I.	DET	6	3	5	1181	3	6	0	0	0	0	0	0	-3	2	1	1	0	1	1	0	0
12.01.2025 00:00	18	Thompson A.	DET	6	4	3	1195	2	5	0	0	1	2	1	2	9	0	4	3	3	1	0	0	0
12.01.2025 00:00	19	Sasser M.	DET	5	0	1	657	2	4	0	0	1	2	0	0	-16	0	0	1	0	0	0	0	0
12.01.2025 00:00	20	Holland R.	DET	3	4	1	895	1	5	0	0	1	4	0	0	-6	2	2	1	1	0	0	0	0
10.01.2025 00:00	21	Cunningham C.	DET	32	6	8	2412	12	21	0	0	3	6	5	8	9	1	5	2	3	4	1	0	0
10.01.2025 00:00	22	Beasley M.	DET	21	4	2	2174	8	21	0	0	4	14	1	1	0	1	3	4	0	1	0	0	0
10.01.2025 00:00	23	Harris T.	DET	13	4	4	1945	6	8	0	0	1	3	0	0	8	0	4	2	0	2	1	0	0
10.01.2025 00:00	24	Holland R.	DET	11	1	1	1187	3	9	0	0	3	8	2	2	-1	0	1	3	0	1	0	0	0
10.01.2025 00:00	25	Thompson A.	DET	9	2	3	994	3	4	0	0	1	1	2	2	-8	0	2	3	2	0	1	0	0
10.01.2025 00:00	26	Duren J.	DET	8	12	3	1860	3	6	0	0	0	0	2	3	13	1	11	4	2	2	3	0	0
10.01.2025 00:00	27	Stewart I.	DET	4	5	1	1024	2	5	0	0	0	1	0	0	-16	2	3	0	0	0	1	0	1
10.01.2025 00:00	28	Fontecchio S.	DET	3	3	2	1630	1	7	0	0	1	4	0	0	-5	1	2	1	0	2	0	0	0
10.01.2025 00:00	29	Sasser M.	DET	3	3	1	940	1	5	0	0	1	2	0	0	-10	1	2	0	0	2	0	0	0
10.01.2025 00:00	30	Moore W.	DET	0	0	0	234	0	0	0	0	0	0	0	0	-5	0	0	0	0	0	0	0	0
09.01.2025 00:30	31	Beasley M.	DET	23	2	5	1977	9	17	0	0	4	11	1	1	23	0	2	3	2	1	0	0	0
09.01.2025 00:30	32	Fontecchio S.	DET	17	5	2	1421	7	11	0	0	3	5	0	0	10	1	4	2	1	1	0	0	0
09.01.2025 00:30	33	Sasser M.	DET	15	1	3	1294	5	9	0	0	5	7	0	0	18	1	0	3	0	1	0	0	0
09.01.2025 00:30	34	Cunningham C.	DET	13	5	5	1405	6	10	0	0	0	3	1	2	6	1	4	1	1	4	0	0	0
09.01.2025 00:30	35	Hardaway T.	DET	10	3	1	1369	2	6	0	0	2	4	4	4	8	0	3	2	0	2	1	0	0
09.01.2025 00:30	36	Harris T.	DET	9	3	5	1552	4	9	0	0	1	3	0	0	23	0	3	0	0	1	2	0	0
09.01.2025 00:30	37	Duren J.	DET	8	9	3	1298	3	5	0	0	0	0	2	4	12	2	7	1	2	1	2	0	0
09.01.2025 00:30	38	Holland R.	DET	8	5	3	1674	4	7	0	0	0	2	0	1	-5	0	5	3	0	0	0	0	0
09.01.2025 00:30	39	Stewart I.	DET	6	4	2	1209	3	5	0	0	0	0	0	0	8	2	2	2	2	0	4	0	0
09.01.2025 00:30	40	Moore W.	DET	2	0	1	390	1	3	0	0	0	0	0	0	-7	0	0	0	0	0	0	0	0
09.01.2025 00:30	41	Reed P.	DET	2	3	0	373	1	2	0	0	0	0	0	0	-5	0	3	1	1	1	0	0	0
09.01.2025 00:30	42	Jenkins D.	DET	0	0	0	181	0	2	0	0	0	2	0	0	-9	0	0	0	0	1	0	0	0
09.01.2025 00:30	43	Klintman B.	DET	0	2	0	257	0	0	0	0	0	0	0	0	-7	0	2	2	0	0	0	0	0
07.01.2025 00:00	44	Cunningham C.	DET	32	6	9	2324	11	23	0	0	4	10	6	6	8	0	6	2	2	4	0	0	0
07.01.2025 00:00	45	Hardaway T.	DET	26	0	0	1970	10	15	0	0	6	9	0	0	9	0	0	1	0	0	0	0	0
07.01.2025 00:00	46	Harris T.	DET	17	5	3	2227	5	8	0	0	2	3	5	5	9	1	4	0	1	1	0	0	0
07.01.2025 00:00	47	Duren J.	DET	14	12	4	1645	7	11	0	0	0	0	0	0	2	6	6	0	0	3	0	0	0
07.01.2025 00:00	48	Fontecchio S.	DET	10	6	0	1288	3	8	0	0	2	5	2	3	-3	3	3	0	1	2	0	0	0
07.01.2025 00:00	49	Holland R.	DET	8	2	1	886	3	4	0	0	0	1	2	2	-7	1	1	5	2	2	1	0	0
07.01.2025 00:00	50	Beasley M.	DET	5	3	1	1733	1	10	0	0	1	9	2	4	-15	1	2	2	2	1	0	0	0
07.01.2025 00:00	51	Sasser M.	DET	4	3	5	920	1	6	0	0	0	3	2	2	1	0	3	1	1	0	1	0	0
07.01.2025 00:00	52	Stewart I.	DET	2	6	0	868	1	7	0	0	0	3	0	0	-11	5	1	3	0	0	2	0	0
07.01.2025 00:00	53	Moore W.	DET	0	2	0	172	0	1	0	0	0	0	0	0	10	0	2	1	0	1	0	0	0
07.01.2025 00:00	54	Reed P.	DET	0	0	0	367	0	1	0	0	0	0	0	0	12	0	0	0	0	0	0	0	0
05.01.2025 00:00	55	Cunningham C.	DET	40	6	9	2289	15	29	0	0	4	8	6	7	24	0	6	3	1	3	0	0	0
05.01.2025 00:00	56	Beasley M.	DET	23	2	1	2003	8	17	0	0	6	14	1	2	4	0	2	1	3	1	0	0	0
05.01.2025 00:00	57	Harris T.	DET	16	11	4	2019	5	13	0	0	2	5	4	4	9	2	9	5	0	4	0	0	0
05.01.2025 00:00	58	Thompson A.	DET	10	10	2	1539	5	5	0	0	0	0	0	0	16	3	7	2	6	1	0	0	0
05.01.2025 00:00	59	Holland R.	DET	8	2	1	1016	2	3	0	0	0	0	4	4	16	1	1	2	0	2	0	0	0
05.01.2025 00:00	60	Stewart I.	DET	8	6	3	1507	4	8	0	0	0	1	0	0	11	1	5	2	0	0	1	0	1
05.01.2025 00:00	61	Hardaway T.	DET	7	2	3	1993	3	9	0	0	1	6	0	1	-2	0	2	1	0	0	0	0	0
05.01.2025 00:00	62	Duren J.	DET	5	7	3	1373	2	4	0	0	0	0	1	2	3	5	2	5	2	0	1	0	1
05.01.2025 00:00	63	Sasser M.	DET	2	1	0	661	1	5	0	0	0	4	0	0	-11	1	0	1	0	1	0	0	0
04.01.2025 00:00	64	Harris T.	DET	24	10	1	2164	9	16	0	0	4	5	2	2	10	3	7	1	3	1	1	0	1
04.01.2025 00:00	65	Cunningham C.	DET	18	5	5	1726	8	20	0	0	1	3	1	2	1	0	5	5	2	2	1	0	0
04.01.2025 00:00	66	Beasley M.	DET	12	2	3	1871	5	16	0	0	1	10	1	1	7	0	2	2	1	1	0	0	0
04.01.2025 00:00	67	Hardaway T.	DET	11	2	1	2031	3	10	0	0	3	8	2	4	-1	0	2	4	2	1	0	0	0
04.01.2025 00:00	68	Duren J.	DET	10	14	1	1483	5	9	0	0	0	0	0	0	-1	7	7	5	0	2	3	0	1
04.01.2025 00:00	69	Holland R.	DET	9	3	1	650	4	8	0	0	1	3	0	0	-1	0	3	3	0	2	0	0	0
04.01.2025 00:00	70	Stewart I.	DET	5	7	0	1094	2	3	0	0	1	2	0	0	3	2	5	1	1	0	2	0	0
04.01.2025 00:00	71	Thompson A.	DET	4	5	0	859	2	3	0	0	0	0	0	2	-6	2	3	0	0	2	0	0	0
04.01.2025 00:00	72	Sasser M.	DET	3	3	5	1310	1	5	0	0	1	4	0	0	-1	0	3	4	0	2	0	0	0
04.01.2025 00:00	73	Reed P.	DET	2	0	1	304	0	0	0	0	0	0	2	2	2	0	0	1	2	0	0	0	0
04.01.2025 00:00	74	Moore W.	DET	0	0	3	908	0	3	0	0	0	2	0	0	7	0	0	1	2	0	0	0	0
02.01.2025 00:00	75	Ivey J.	DET	22	1	4	1605	8	11	0	0	5	6	1	2	9	0	1	0	1	5	0	0	0
02.01.2025 00:00	76	Cunningham C.	DET	19	8	9	2060	7	14	0	0	4	6	1	2	-3	1	7	2	0	5	1	0	0
02.01.2025 00:00	77	Duren J.	DET	18	11	1	1604	9	10	0	0	0	0	0	0	13	3	8	3	1	1	0	0	0
02.01.2025 00:00	78	Harris T.	DET	17	8	2	2092	7	9	0	0	2	4	1	2	19	2	6	3	0	1	1	0	0
02.01.2025 00:00	79	Hardaway T.	DET	12	2	3	1950	4	11	0	0	0	4	4	5	16	1	1	2	0	1	0	0	0
02.01.2025 00:00	80	Stewart I.	DET	7	8	3	1276	2	5	0	0	1	2	2	2	-4	0	8	3	0	0	1	0	0
02.01.2025 00:00	81	Thompson A.	DET	6	5	1	1486	3	9	0	0	0	2	0	2	3	1	4	2	5	5	0	0	0
02.01.2025 00:00	82	Beasley M.	DET	2	6	1	1324	0	7	0	0	0	4	2	2	-4	1	5	1	0	4	0	0	0
02.01.2025 00:00	83	Holland R.	DET	2	0	1	609	1	2	0	0	0	0	0	0	-8	0	0	2	0	1	0	0	0
02.01.2025 00:00	84	Sasser M.	DET	0	0	0	394	0	1	0	0	0	1	0	0	4	0	0	0	0	0	0	0	0
29.12.2024 02:00	85	Cunningham C.	DET	17	2	8	1595	7	18	0	0	1	8	2	2	-11	1	1	3	0	3	0	0	0
29.12.2024 02:00	86	Ivey J.	DET	17	3	1	1249	7	9	0	0	2	3	1	1	-17	1	2	0	0	3	0	0	0
29.12.2024 02:00	87	Beasley M.	DET	14	2	1	1111	5	11	0	0	3	9	1	2	-12	1	1	2	0	0	0	0	0
29.12.2024 02:00	88	Duren J.	DET	12	7	2	1194	5	8	0	0	0	0	2	4	-8	3	4	4	0	1	0	0	0
29.12.2024 02:00	89	Holland R.	DET	12	2	0	1186	5	9	0	0	1	1	1	2	0	0	2	2	0	0	0	0	0
29.12.2024 02:00	90	Thompson A.	DET	10	7	2	1443	5	8	0	0	0	0	0	1	12	4	3	3	1	1	0	0	0
29.12.2024 02:00	91	Hardaway T.	DET	8	1	1	1083	2	3	0	0	1	1	3	3	-12	0	1	1	0	0	0	0	0
29.12.2024 02:00	92	Harris T.	DET	7	2	1	1410	2	6	0	0	1	4	2	2	-8	1	1	2	0	0	0	0	0
29.12.2024 02:00	93	Reed P.	DET	7	2	2	720	2	5	0	0	0	2	3	4	12	0	2	2	4	0	1	0	0
29.12.2024 02:00	94	Moore W.	DET	6	5	4	720	2	5	0	0	0	2	2	2	12	2	3	0	1	0	0	0	0
29.12.2024 02:00	95	Sasser M.	DET	5	1	2	910	2	4	0	0	1	3	0	0	0	1	0	2	2	3	0	0	0
29.12.2024 02:00	96	Fontecchio S.	DET	3	3	2	813	1	6	0	0	1	4	0	0	-16	1	2	0	0	1	0	0	0
29.12.2024 02:00	97	Stewart I.	DET	3	4	3	966	1	3	0	0	1	2	0	0	-17	0	4	4	0	0	0	0	0
27.12.2024 03:00	98	Cunningham C.	DET	33	4	10	2291	9	24	0	0	4	11	11	12	8	0	4	4	0	3	0	0	0
27.12.2024 03:00	99	Beasley M.	DET	22	2	2	1633	7	16	0	0	6	11	2	2	-3	1	1	3	0	0	0	0	0
27.12.2024 03:00	100	Ivey J.	DET	19	6	0	1975	7	13	0	0	3	7	2	3	-1	3	3	2	0	3	1	0	0
27.12.2024 03:00	101	Duren J.	DET	13	10	3	1918	5	8	0	0	0	0	3	4	-11	2	8	2	2	1	2	0	0
27.12.2024 03:00	102	Reed P.	DET	7	3	2	772	3	3	0	0	1	1	0	0	12	0	3	4	2	0	1	0	0
27.12.2024 03:00	103	Thompson A.	DET	7	8	0	1098	3	5	0	0	0	0	1	2	-1	2	6	2	0	1	0	0	0
27.12.2024 03:00	104	Hardaway T.	DET	6	4	3	1398	2	8	0	0	2	7	0	0	11	1	3	0	0	0	0	0	0
27.12.2024 03:00	105	Harris T.	DET	4	3	2	1623	1	7	0	0	0	2	2	2	3	0	3	2	0	0	0	0	0
27.12.2024 03:00	106	Sasser M.	DET	3	0	1	454	1	2	0	0	1	2	0	0	5	0	0	2	1	0	0	0	0
27.12.2024 03:00	107	Fontecchio S.	DET	0	3	2	839	0	3	0	0	0	3	0	0	-3	1	2	1	1	1	0	0	0
27.12.2024 03:00	108	Holland R.	DET	0	1	0	399	0	2	0	0	0	0	0	0	-15	0	1	0	0	1	0	0	0
24.12.2024 03:30	109	Beasley M.	DET	21	5	0	1547	8	15	0	0	5	10	0	0	11	0	5	1	2	0	0	0	0
24.12.2024 03:30	110	Cunningham C.	DET	20	5	10	2116	9	25	0	0	0	5	2	2	-11	2	3	2	1	5	0	0	0
24.12.2024 03:30	111	Ivey J.	DET	18	3	2	1743	8	15	0	0	2	4	0	0	5	0	3	2	2	2	0	0	0
24.12.2024 03:30	112	Hardaway T.	DET	15	0	0	1489	5	8	0	0	2	5	3	3	-10	0	0	1	0	2	0	0	0
24.12.2024 03:30	113	Fontecchio S.	DET	13	2	0	1163	4	4	0	0	2	2	3	3	19	0	2	1	0	1	0	0	0
24.12.2024 03:30	114	Holland R.	DET	10	4	1	764	5	7	0	0	0	1	0	0	14	1	3	1	1	0	0	0	0
24.12.2024 03:30	115	Thompson A.	DET	8	5	0	974	4	5	0	0	0	0	0	0	-4	3	2	2	0	0	0	0	0
24.12.2024 03:30	116	Duren J.	DET	6	9	2	1646	1	2	0	0	0	0	4	4	-19	3	6	3	1	2	1	0	0
24.12.2024 03:30	117	Harris T.	DET	6	1	4	1754	3	10	0	0	0	3	0	0	-10	0	1	3	2	0	2	0	0
24.12.2024 03:30	118	Reed P.	DET	0	3	5	1204	0	1	0	0	0	0	0	0	20	1	2	4	3	0	2	0	0
22.12.2024 02:00	119	Cunningham C.	DET	28	1	13	2161	9	19	0	0	3	8	7	9	7	0	1	4	2	4	2	0	0
22.12.2024 02:00	120	Ivey J.	DET	20	8	8	1796	7	14	0	0	4	6	2	2	6	4	4	2	1	1	0	0	0
22.12.2024 02:00	121	Beasley M.	DET	18	2	0	1593	6	15	0	0	5	11	1	2	-3	0	2	0	3	2	0	0	0
22.12.2024 02:00	122	Duren J.	DET	17	11	2	2016	7	7	0	0	0	0	3	5	4	3	8	2	0	2	0	0	0
22.12.2024 02:00	123	Hardaway T.	DET	16	1	2	1717	6	10	0	0	4	6	0	0	13	0	1	1	1	0	0	0	0
22.12.2024 02:00	124	Fontecchio S.	DET	10	1	0	885	4	7	0	0	2	4	0	0	1	1	0	2	1	1	0	0	0
22.12.2024 02:00	125	Harris T.	DET	10	3	2	1750	3	5	0	0	1	2	3	4	11	0	3	2	0	1	1	0	0
22.12.2024 02:00	126	Reed P.	DET	6	3	2	819	3	4	0	0	0	1	0	0	0	2	1	1	2	0	1	0	0
22.12.2024 02:00	127	Holland R.	DET	4	3	1	813	2	4	0	0	0	1	0	0	-4	0	3	2	1	0	0	0	0
22.12.2024 02:00	128	Thompson A.	DET	4	2	1	850	2	4	0	0	0	0	0	0	5	0	2	3	2	2	0	0	0
\.


--
-- Data for Name: detroit_pistons_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.detroit_pistons_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Ivey Jaden	Lesionado	2025-01-16 10:44:18.106649
\.


--
-- Data for Name: golden_state_warriors; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.golden_state_warriors (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	14.07.2024	Golden State Warriors	90	Phoenix Suns	73	32	18	24	16	19	14	22	18
2	15.07.2024	Golden State Warriors	92	Chicago Bulls	82	24	19	27	22	23	17	19	23
3	18.07.2024	Cleveland Cavaliers	85	Golden State Warriors	96	22	16	20	27	26	28	21	21
4	20.07.2024	Oklahoma City Thunder	83	Golden State Warriors	90	18	19	20	26	22	18	23	27
5	21.07.2024	Miami Heat	102	Golden State Warriors	99	22	23	20	37	19	28	23	29
6	06.10.2024	Los Angeles Clippers	90	Golden State Warriors	91	26	23	22	19	23	30	16	22
7	10.10.2024	Sacramento Kings	112	Golden State Warriors	122	27	41	23	21	31	35	34	22
8	12.10.2024	Golden State Warriors	109	Sacramento Kings	106	34	21	26	28	30	28	26	22
9	14.10.2024	Golden State Warriors	111	Detroit Pistons	93	31	29	26	25	17	24	28	24
10	16.10.2024	Los Angeles Lakers	97	Golden State Warriors	111	28	23	19	27	31	27	25	28
11	19.10.2024	Golden State Warriors	132	Los Angeles Lakers	74	36	30	38	28	18	22	22	12
12	24.10.2024	Portland Trail Blazers	104	Golden State Warriors	140	21	29	22	32	21	41	38	40
13	26.10.2024	Utah Jazz	86	Golden State Warriors	127	24	18	28	16	32	24	38	33
14	28.10.2024	Golden State Warriors	104	Los Angeles Clippers	112	34	20	25	25	34	25	27	26
15	30.10.2024	Golden State Warriors	124	New Orleans Pelicans	106	14	33	40	37	31	20	28	27
16	31.10.2024	Golden State Warriors	104	New Orleans Pelicans	89	28	20	31	25	20	24	22	23
17	03.11.2024\nApós Prol.	Houston Rockets	121	Golden State Warriors	127	20	23	37	39	38	33	25	23
18	05.11.2024	Washington Wizards	112	Golden State Warriors	125	20	25	36	31	29	25	39	32
19	07.11.2024	Boston Celtics	112	Golden State Warriors	118	24	16	41	31	19	32	31	36
20	09.11.2024	Cleveland Cavaliers	136	Golden State Warriors	117	39	44	29	24	22	20	41	34
21	11.11.2024	Oklahoma City Thunder	116	Golden State Warriors	127	33	25	21	37	26	39	42	20
22	13.11.2024	Golden State Warriors	120	Dallas Mavericks	117	33	26	37	24	27	36	26	28
23	16.11.2024	Golden State Warriors	123	Memphis Grizzlies	118	29	26	38	30	28	20	30	40
24	19.11.2024	Los Angeles Clippers	102	Golden State Warriors	99	27	29	19	27	22	23	27	27
25	21.11.2024	Golden State Warriors	120	Atlanta Hawks	97	41	26	23	30	22	20	33	22
26	23.11.2024	New Orleans Pelicans	108	Golden State Warriors	112	30	33	21	24	34	28	25	25
27	24.11.2024	San Antonio Spurs	104	Golden State Warriors	94	17	21	33	33	29	21	31	13
28	26.11.2024	Golden State Warriors	120	Brooklyn Nets	128	30	37	25	28	34	24	29	41
29	28.11.2024	Golden State Warriors	101	Oklahoma City Thunder	105	23	27	33	18	39	23	22	21
30	01.12.2024	Phoenix Suns	113	Golden State Warriors	105	35	31	19	28	29	20	29	27
31	04.12.2024	Denver Nuggets	119	Golden State Warriors	115	33	24	33	29	31	26	28	30
32	06.12.2024	Golden State Warriors	99	Houston Rockets	93	18	31	24	26	22	21	23	27
33	07.12.2024	Golden State Warriors	90	Minnesota Timberwolves	107	31	15	26	18	31	25	22	29
34	09.12.2024	Golden State Warriors	114	Minnesota Timberwolves	106	21	28	44	21	30	28	32	16
35	12.12.2024	Houston Rockets	91	Golden State Warriors	90	20	24	24	23	18	19	32	21
36	16.12.2024	Golden State Warriors	133	Dallas Mavericks	143	33	41	33	26	46	35	33	29
37	20.12.2024	Memphis Grizzlies	144	Golden State Warriors	93	37	32	40	35	15	23	21	34
38	22.12.2024	Minnesota Timberwolves	103	Golden State Warriors	113	15	22	38	28	26	24	29	34
39	24.12.2024	Golden State Warriors	105	Indiana Pacers	111	32	22	31	20	33	29	27	22
40	26.12.2024	Golden State Warriors	113	Los Angeles Lakers	115	23	29	24	37	23	32	29	31
41	28.12.2024	Los Angeles Clippers	102	Golden State Warriors	92	19	30	32	21	21	22	19	30
42	29.12.2024	Golden State Warriors	109	Phoenix Suns	105	34	27	21	27	27	38	22	18
43	31.12.2024	Golden State Warriors	95	Cleveland Cavaliers	113	27	11	27	30	26	20	37	30
44	03.01. 03:00	Golden State Warriors	139	Philadelphia 76ers	105	35	33	35	36	19	33	26	27
45	05.01. 01:30	Golden State Warriors	121	Memphis Grizzlies	113	30	28	34	29	29	25	32	27
46	06.01. 01:30	Golden State Warriors	99	Sacramento Kings	129	21	30	24	24	36	39	30	24
47	08.01. 03:00	Golden State Warriors	98	Miami Heat	114	23	25	30	20	29	32	23	30
48	10.01. 00:00	Detroit Pistons	104	Golden State Warriors	107	23	24	27	30	25	32	25	25
49	11.01. 00:00	Indiana Pacers	108	Golden State Warriors	96	27	23	30	28	24	21	25	26
50	14.01. 00:30	Toronto Raptors	104	Golden State Warriors	101	28	24	23	29	26	24	28	23
51	16.01. 02:30	Minnesota Timberwolves	115	Golden State Warriors	116	12	30	36	37	34	21	32	29
\.


--
-- Data for Name: golden_state_warriors_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.golden_state_warriors_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 02:30	1	Curry S.	GSW	31	1	8	2240	10	21	0	0	7	12	4	4	-1	1	0	1	1	1	0	0	0
16.01.2025 02:30	2	Wiggins A.	GSW	24	5	2	2124	6	16	0	0	2	8	10	12	-5	2	3	2	2	3	0	0	0
16.01.2025 02:30	3	Hield B.	GSW	18	1	0	1763	6	11	0	0	3	6	3	3	8	0	1	2	3	2	2	0	0
16.01.2025 02:30	4	Schroder D.	GSW	12	1	3	1486	5	11	0	0	2	3	0	0	-4	0	1	6	2	2	0	0	0
16.01.2025 02:30	5	Moody M.	GSW	11	4	1	1496	4	6	0	0	3	4	0	0	7	0	4	5	0	0	0	0	0
16.01.2025 02:30	6	Payton G.	GSW	7	6	1	1120	3	3	0	0	0	0	1	2	-4	0	6	3	0	1	0	0	0
16.01.2025 02:30	7	Santos G.	GSW	5	7	3	1286	2	5	0	0	1	3	0	0	5	1	6	4	0	0	0	0	0
16.01.2025 02:30	8	Jackson-Davis T.	GSW	4	15	2	1593	2	7	0	0	0	0	0	0	2	9	6	2	0	2	2	0	0
16.01.2025 02:30	9	Looney K.	GSW	4	5	6	1292	2	2	0	0	0	0	0	0	-3	1	4	1	0	1	1	0	0
14.01.2025 00:30	10	Curry S.	GSW	26	7	7	2100	9	17	0	0	4	10	4	4	0	1	6	2	1	4	0	0	0
14.01.2025 00:30	11	Wiggins A.	GSW	20	3	1	2110	6	13	0	0	4	9	4	6	4	1	2	2	1	2	0	0	0
14.01.2025 00:30	12	Anderson K.	GSW	13	2	2	1055	4	5	0	0	2	2	3	3	-1	0	2	1	1	0	0	0	0
14.01.2025 00:30	13	Schroder D.	GSW	12	3	4	1430	5	12	0	0	2	6	0	0	6	1	2	1	1	2	0	0	0
14.01.2025 00:30	14	Looney K.	GSW	10	9	1	1070	5	9	0	0	0	0	0	0	-8	4	5	2	1	0	0	0	0
14.01.2025 00:30	15	Hield B.	GSW	8	2	3	1983	3	13	0	0	2	10	0	0	6	0	2	1	4	2	1	0	0
14.01.2025 00:30	16	Waters III L.	GSW	8	9	0	1310	2	6	0	0	2	4	2	3	-9	1	8	0	0	1	1	0	0
14.01.2025 00:30	17	Jackson-Davis T.	GSW	3	6	3	1813	1	4	0	0	0	0	1	4	6	3	3	2	1	3	0	0	0
14.01.2025 00:30	18	Moody M.	GSW	1	2	0	831	0	6	0	0	0	3	1	2	-10	0	2	0	1	0	1	0	0
14.01.2025 00:30	19	Santos G.	GSW	0	3	2	698	0	3	0	0	0	2	0	0	-9	3	0	3	0	0	1	0	0
11.01.2025 00:00	20	Hield B.	GSW	17	4	5	2078	6	19	0	0	3	12	2	2	-16	0	4	2	0	1	0	0	0
11.01.2025 00:00	21	Spencer P.	GSW	17	3	1	1220	7	12	0	0	1	3	2	2	-2	1	2	1	0	3	0	0	0
11.01.2025 00:00	22	Schroder D.	GSW	12	2	4	1722	5	13	0	0	1	6	1	1	-10	0	2	4	2	3	0	0	1
11.01.2025 00:00	23	Santos G.	GSW	11	3	3	1438	4	5	0	0	2	2	1	2	9	1	2	2	2	1	0	0	0
11.01.2025 00:00	24	Jackson-Davis T.	GSW	9	10	1	1635	3	6	0	0	0	0	3	4	-6	3	7	1	2	0	1	0	0
11.01.2025 00:00	25	Anderson K.	GSW	8	7	5	1557	4	9	0	0	0	2	0	0	-23	2	5	1	1	1	1	0	0
11.01.2025 00:00	26	Moody M.	GSW	7	1	2	1377	3	11	0	0	1	5	0	0	7	1	0	3	2	1	0	0	0
11.01.2025 00:00	27	Waters III L.	GSW	7	5	2	2128	3	8	0	0	1	5	0	1	-13	1	4	3	0	2	0	0	0
11.01.2025 00:00	28	Post Q.	GSW	6	0	0	429	2	4	0	0	1	2	1	1	6	0	0	0	0	0	0	0	0
11.01.2025 00:00	29	Looney K.	GSW	2	7	2	816	1	4	0	0	0	1	0	0	-12	2	5	2	2	1	0	0	0
10.01.2025 00:00	30	Hield B.	GSW	19	5	3	1917	7	15	0	0	5	11	0	0	0	1	4	2	1	0	0	0	0
10.01.2025 00:00	31	Curry S.	GSW	17	10	6	2168	5	21	0	0	2	14	5	5	-14	2	8	0	2	3	0	0	0
10.01.2025 00:00	32	Jackson-Davis T.	GSW	14	10	3	1577	7	9	0	0	0	0	0	2	16	2	8	1	0	1	0	0	0
10.01.2025 00:00	33	Santos G.	GSW	13	5	3	1537	4	6	0	0	4	6	1	2	7	3	2	3	2	4	0	0	0
10.01.2025 00:00	34	Schroder D.	GSW	13	0	6	2087	5	11	0	0	1	5	2	2	7	0	0	5	1	2	1	0	1
10.01.2025 00:00	35	Waters III L.	GSW	11	2	0	1150	4	7	0	0	3	6	0	0	6	0	2	0	0	1	1	0	0
10.01.2025 00:00	36	Looney K.	GSW	8	8	3	1244	4	6	0	0	0	0	0	1	-14	3	5	3	2	0	1	0	0
10.01.2025 00:00	37	Green D.	GSW	7	5	4	1924	3	9	0	0	0	3	1	2	-2	2	3	4	1	4	3	0	0
10.01.2025 00:00	38	Anderson K.	GSW	4	4	3	564	2	5	0	0	0	1	0	0	7	2	2	0	0	0	0	0	0
10.01.2025 00:00	39	Spencer P.	GSW	1	0	1	232	0	0	0	0	0	0	1	2	2	0	0	0	0	0	1	0	0
08.01.2025 03:00	40	Curry S.	GSW	31	7	0	2004	11	22	0	0	8	17	1	1	-10	0	7	2	1	4	2	0	0
08.01.2025 03:00	41	Jackson-Davis T.	GSW	19	7	0	2126	9	12	0	0	0	0	1	1	-15	3	4	0	2	0	1	0	0
08.01.2025 03:00	42	Hield B.	GSW	11	8	5	1437	4	12	0	0	2	9	1	2	-7	1	7	1	1	0	0	0	0
08.01.2025 03:00	43	Wiggins A.	GSW	9	5	1	1475	4	10	0	0	1	3	0	0	-7	2	3	2	1	1	1	0	0
08.01.2025 03:00	44	Green D.	GSW	7	10	10	1613	3	9	0	0	0	3	1	1	-9	1	9	2	0	1	0	0	0
08.01.2025 03:00	45	Waters III L.	GSW	6	2	0	1128	3	8	0	0	0	4	0	0	-12	0	2	2	1	1	0	0	0
08.01.2025 03:00	46	Anderson K.	GSW	5	5	4	1604	2	7	0	0	1	2	0	0	-4	2	3	3	3	1	2	0	0
08.01.2025 03:00	47	Schroder D.	GSW	5	3	7	1732	2	10	0	0	1	7	0	0	-13	0	3	2	0	1	0	0	0
08.01.2025 03:00	48	Moody M.	GSW	3	3	1	911	1	6	0	0	1	4	0	0	-7	2	1	1	0	0	0	0	0
08.01.2025 03:00	49	Spencer P.	GSW	2	1	0	185	1	1	0	0	0	0	0	0	2	0	1	0	0	1	0	0	0
08.01.2025 03:00	50	Santos G.	GSW	0	1	0	185	0	1	0	0	0	1	0	0	2	0	1	0	0	0	0	0	0
06.01.2025 01:30	51	Curry S.	GSW	26	7	0	1782	8	12	0	0	4	8	6	6	-17	0	7	3	1	4	0	0	0
06.01.2025 01:30	52	Wiggins A.	GSW	18	4	1	1561	7	13	0	0	1	3	3	4	-23	1	3	3	0	2	0	0	0
06.01.2025 01:30	53	Moody M.	GSW	13	1	2	1566	5	10	0	0	3	6	0	0	-5	0	1	1	2	2	0	0	0
06.01.2025 01:30	54	Green D.	GSW	10	4	4	1514	4	8	0	0	2	4	0	0	-15	1	3	3	2	5	1	0	0
06.01.2025 01:30	55	Looney K.	GSW	9	5	0	937	4	7	0	0	0	0	1	2	-6	4	1	1	2	1	1	0	0
06.01.2025 01:30	56	Hield B.	GSW	7	3	3	1106	3	7	0	0	1	5	0	0	-25	0	3	2	0	2	0	0	0
06.01.2025 01:30	57	Waters III L.	GSW	5	2	0	1188	2	5	0	0	1	4	0	0	-3	0	2	0	1	0	0	0	0
06.01.2025 01:30	58	Spencer P.	GSW	4	1	4	720	1	4	0	0	0	1	2	4	0	0	1	0	1	0	0	0	0
06.01.2025 01:30	59	Schroder D.	GSW	3	2	2	1258	1	7	0	0	0	2	1	2	-22	1	1	1	0	1	0	0	0
06.01.2025 01:30	60	Anderson K.	GSW	2	2	2	981	1	2	0	0	0	0	0	0	-18	1	1	2	0	1	1	0	0
06.01.2025 01:30	61	Santos G.	GSW	2	2	1	720	1	3	0	0	0	2	0	0	0	1	1	2	1	1	0	0	0
06.01.2025 01:30	62	Jackson-Davis T.	GSW	0	2	3	1067	0	3	0	0	0	0	0	0	-16	0	2	3	0	3	0	0	0
05.01.2025 01:30	63	Wiggins A.	GSW	24	2	3	2173	9	17	0	0	3	10	3	3	10	0	2	1	4	2	0	0	0
05.01.2025 01:30	64	Schroder D.	GSW	17	3	9	2156	6	15	0	0	3	6	2	4	13	1	2	1	1	3	0	0	1
05.01.2025 01:30	65	Waters III L.	GSW	16	3	2	1676	6	7	0	0	4	5	0	0	-5	0	3	2	1	1	1	0	0
05.01.2025 01:30	66	Hield B.	GSW	14	2	3	1414	5	9	0	0	4	7	0	0	18	1	1	2	0	3	0	0	0
05.01.2025 01:30	67	Kuminga J.	GSW	13	2	2	918	4	6	0	0	3	3	2	4	0	0	2	0	0	4	0	0	0
05.01.2025 01:30	68	Jackson-Davis T.	GSW	11	9	5	1676	5	13	0	0	0	0	1	1	12	3	6	2	3	1	0	0	0
05.01.2025 01:30	69	Green D.	GSW	9	2	3	1836	3	7	0	0	3	6	0	0	10	1	1	4	2	2	1	0	1
05.01.2025 01:30	70	Moody M.	GSW	8	0	0	534	2	3	0	0	2	3	2	3	-11	0	0	2	0	0	0	0	0
05.01.2025 01:30	71	Anderson K.	GSW	7	3	3	1293	3	5	0	0	1	3	0	1	-2	1	2	2	1	1	2	0	0
05.01.2025 01:30	72	Spencer P.	GSW	2	3	2	724	1	2	0	0	0	0	0	0	-5	2	1	2	1	1	1	0	0
03.01.2025 03:00	73	Curry S.	GSW	30	6	10	1789	11	15	0	0	8	8	0	0	32	1	5	1	1	2	0	0	0
03.01.2025 03:00	74	Kuminga J.	GSW	20	5	5	1523	8	11	0	0	2	3	2	3	25	0	5	2	1	1	0	0	0
03.01.2025 03:00	75	Green D.	GSW	15	6	7	1835	6	10	0	0	1	5	2	2	30	0	6	3	0	3	3	0	0
03.01.2025 03:00	76	Schroder D.	GSW	15	4	6	1519	5	9	0	0	3	4	2	2	17	2	2	4	2	0	0	0	0
03.01.2025 03:00	77	Wiggins A.	GSW	15	7	4	1564	6	11	0	0	1	4	2	2	20	1	6	2	0	1	1	0	0
03.01.2025 03:00	78	Moody M.	GSW	12	2	0	926	4	5	0	0	4	5	0	0	13	0	2	2	0	1	0	0	0
03.01.2025 03:00	79	Waters III L.	GSW	10	2	1	940	4	7	0	0	2	4	0	0	-2	0	2	2	0	0	1	0	0
03.01.2025 03:00	80	Anderson K.	GSW	8	1	0	451	3	3	0	0	0	0	2	3	1	0	1	0	0	1	0	0	0
03.01.2025 03:00	81	Looney K.	GSW	6	2	1	451	3	3	0	0	0	0	0	1	1	0	2	0	1	1	1	0	0
03.01.2025 03:00	82	Hield B.	GSW	3	1	1	1241	1	5	0	0	1	5	0	0	17	0	1	3	0	0	0	0	0
03.01.2025 03:00	83	Jackson-Davis T.	GSW	3	5	3	1259	1	5	0	0	0	0	1	2	14	1	4	3	0	1	1	0	0
03.01.2025 03:00	84	Santos G.	GSW	2	0	1	451	1	2	0	0	0	1	0	0	1	0	0	0	0	0	1	0	0
03.01.2025 03:00	85	Spencer P.	GSW	0	2	2	451	0	1	0	0	0	0	0	0	1	0	2	0	0	0	0	0	0
31.12.2024 03:00	86	Moody M.	GSW	19	2	1	1233	7	8	0	0	3	4	2	2	2	0	2	0	1	1	0	0	0
31.12.2024 03:00	87	Kuminga J.	GSW	18	10	2	1917	4	15	0	0	0	2	10	14	-5	2	8	3	1	0	1	0	0
31.12.2024 03:00	88	Jackson-Davis T.	GSW	16	16	2	1714	6	14	0	0	0	0	4	4	-23	6	10	2	0	2	2	0	0
31.12.2024 03:00	89	Schroder D.	GSW	12	4	3	1819	4	11	0	0	2	4	2	2	-24	1	3	2	0	4	0	0	0
31.12.2024 03:00	90	Curry S.	GSW	11	2	3	1745	4	14	0	0	3	11	0	0	-2	0	2	1	1	1	1	0	0
31.12.2024 03:00	91	Wiggins A.	GSW	11	3	2	1636	5	9	0	0	1	5	0	0	-20	0	3	2	0	2	2	0	0
31.12.2024 03:00	92	Green D.	GSW	2	8	5	1504	1	10	0	0	0	2	0	2	-8	3	5	2	1	3	2	0	0
31.12.2024 03:00	93	Hield B.	GSW	2	3	0	1127	1	8	0	0	0	3	0	0	-9	1	2	0	0	1	0	0	0
31.12.2024 03:00	94	Post Q.	GSW	2	1	0	279	1	2	0	0	0	1	0	0	1	1	0	0	0	0	0	0	0
31.12.2024 03:00	95	Waters III L.	GSW	2	2	0	868	0	6	0	0	0	5	2	2	-4	0	2	2	0	0	0	0	0
31.12.2024 03:00	96	Santos G.	GSW	0	1	0	279	0	1	0	0	0	1	0	0	1	0	1	0	0	0	0	0	0
31.12.2024 03:00	97	Spencer P.	GSW	0	3	2	279	0	1	0	0	0	0	0	0	1	0	3	0	1	0	0	0	0
29.12.2024 01:30	98	Kuminga J.	GSW	34	9	3	2067	12	20	0	0	2	5	8	12	9	5	4	4	1	1	0	0	0
29.12.2024 01:30	99	Curry S.	GSW	22	6	6	2103	9	22	0	0	4	13	0	0	20	2	4	3	1	5	0	0	0
29.12.2024 01:30	100	Green D.	GSW	16	8	7	2089	6	9	0	0	3	5	1	1	18	1	7	1	2	1	1	0	0
29.12.2024 01:30	101	Jackson-Davis T.	GSW	16	10	2	1393	6	11	0	0	0	0	4	4	-11	4	6	1	1	0	4	0	0
29.12.2024 01:30	102	Schroder D.	GSW	11	3	3	2018	4	13	0	0	1	7	2	2	-1	1	2	1	0	2	0	0	0
29.12.2024 01:30	103	Wiggins A.	GSW	7	7	3	2346	3	12	0	0	1	6	0	0	13	2	5	2	1	1	2	0	0
29.12.2024 01:30	104	Waters III L.	GSW	3	4	1	815	1	3	0	0	1	2	0	0	-13	2	2	2	1	1	0	0	0
29.12.2024 01:30	105	Hield B.	GSW	0	0	1	887	0	7	0	0	0	7	0	0	2	0	0	1	1	0	0	0	0
29.12.2024 01:30	106	Podziemski B.	GSW	0	2	0	682	0	1	0	0	0	0	0	0	-17	1	1	2	0	0	0	0	0
28.12.2024 03:00	107	Kuminga J.	GSW	34	10	5	2206	11	19	0	0	1	3	11	14	-5	4	6	1	2	3	1	0	0
28.12.2024 03:00	108	Jackson-Davis T.	GSW	15	9	2	1848	7	12	0	0	0	0	1	2	-12	6	3	1	2	2	0	0	0
28.12.2024 03:00	109	Moody M.	GSW	11	2	1	1465	4	11	0	0	1	5	2	2	6	0	2	4	3	1	0	0	0
28.12.2024 03:00	110	Podziemski B.	GSW	10	2	5	1833	4	9	0	0	2	5	0	0	6	0	2	2	3	0	0	0	0
28.12.2024 03:00	111	Schroder D.	GSW	7	1	5	1415	3	11	0	0	0	6	1	2	-16	0	1	0	0	3	0	0	0
28.12.2024 03:00	112	Anderson K.	GSW	5	6	1	887	2	4	0	0	1	2	0	0	-7	4	2	0	2	1	0	0	0
28.12.2024 03:00	113	Hield B.	GSW	5	9	0	1299	2	8	0	0	1	6	0	0	-16	2	7	2	0	1	0	0	0
28.12.2024 03:00	114	Wiggins A.	GSW	5	2	2	1415	2	11	0	0	1	3	0	0	-16	1	1	0	0	1	1	0	0
28.12.2024 03:00	115	Looney K.	GSW	0	4	0	723	0	2	0	0	0	0	0	0	0	2	2	3	0	1	0	0	0
28.12.2024 03:00	116	Post Q.	GSW	0	0	1	48	0	1	0	0	0	1	0	0	2	0	0	0	0	0	0	0	0
28.12.2024 03:00	117	Santos G.	GSW	0	1	1	290	0	1	0	0	0	1	0	0	-8	0	1	2	0	1	0	0	0
28.12.2024 03:00	118	Waters III L.	GSW	0	1	1	971	0	6	0	0	0	6	0	0	16	0	1	1	2	0	0	0	1
26.12.2024 01:00	119	Curry S.	GSW	38	1	6	2137	14	24	0	0	8	15	2	2	-1	0	1	3	0	4	0	0	0
26.12.2024 01:00	120	Wiggins A.	GSW	21	12	3	2114	8	19	0	0	3	7	2	2	4	5	7	1	0	0	1	0	0
26.12.2024 01:00	121	Kuminga J.	GSW	14	6	0	1661	4	10	0	0	0	4	6	8	-17	0	6	1	1	1	0	0	0
26.12.2024 01:00	122	Jackson-Davis T.	GSW	11	9	4	1567	5	7	0	0	0	0	1	3	11	3	6	1	0	2	2	0	0
26.12.2024 01:00	123	Schroder D.	GSW	11	2	5	1701	3	10	0	0	3	6	2	2	4	0	2	4	1	1	0	0	0
26.12.2024 01:00	124	Podziemski B.	GSW	6	3	1	1449	2	5	0	0	2	3	0	0	2	0	3	0	0	1	0	0	0
26.12.2024 01:00	125	Hield B.	GSW	5	0	0	1047	2	6	0	0	1	5	0	0	-4	0	0	2	0	1	1	0	0
26.12.2024 01:00	126	Payton G.	GSW	4	1	0	392	2	2	0	0	0	0	0	0	-4	0	1	1	0	0	0	0	0
26.12.2024 01:00	127	Green D.	GSW	3	10	6	2044	1	6	0	0	1	5	0	0	2	4	6	5	0	2	4	0	0
26.12.2024 01:00	128	Looney K.	GSW	0	0	1	288	0	0	0	0	0	0	0	0	-7	0	0	0	0	0	0	0	0
\.


--
-- Data for Name: golden_state_warriors_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.golden_state_warriors_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Jackson-Davis Trayce	Lesionado	2025-01-16 10:44:30.992603
2	Payton Gary	Lesionado	2025-01-16 10:44:30.995468
3	Podziemski Brandin	Lesionado	2025-01-16 10:44:30.997252
4	Anderson Kyle	Lesionado	2025-01-16 10:44:30.999451
5	Green Draymond	Lesionado	2025-01-16 10:44:31.001434
6	Kuminga Jonathan	Lesionado	2025-01-16 10:44:31.004363
\.


--
-- Data for Name: houston_rockets; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.houston_rockets (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	13.04.2024	Portland Trail Blazers	107	Houston Rockets	116	24	16	35	32	23	31	30	32
2	14.04.2024	Los Angeles Clippers	105	Houston Rockets	116	21	30	32	22	24	24	37	31
3	13.07.2024	Los Angeles Lakers	80	Houston Rockets	99	26	19	16	19	26	28	26	19
4	14.07.2024	Washington Wizards	91	Houston Rockets	109	23	21	28	19	29	30	22	28
5	15.07.2024	Houston Rockets	73	Detroit Pistons	87	16	20	28	9	13	24	26	24
6	19.07.2024	Houston Rockets	83	Minnesota Timberwolves	93	16	23	22	22	29	17	18	29
7	22.07.2024	Portland Trail Blazers	105	Houston Rockets	95	20	28	33	24	27	13	27	28
8	08.10.2024	Utah Jazz	122	Houston Rockets	113	12	37	39	34	22	40	22	29
9	10.10.2024\nApós Prol.	Oklahoma City Thunder	113	Houston Rockets	122	29	31	20	26	20	27	32	27
10	16.10.2024	Houston Rockets	118	New Orleans Pelicans	98	30	34	26	28	23	27	33	15
11	18.10.2024	Houston Rockets	129	San Antonio Spurs	107	31	37	37	24	31	18	32	26
12	24.10.2024	Houston Rockets	105	Charlotte Hornets	110	26	34	23	22	21	28	30	31
13	26.10.2024	Houston Rockets	128	Memphis Grizzlies	108	38	21	39	30	38	27	18	25
14	27.10.2024	San Antonio Spurs	109	Houston Rockets	106	38	24	25	22	31	10	28	37
15	29.10.2024	San Antonio Spurs	101	Houston Rockets	106	15	30	30	26	29	33	25	19
16	01.11.2024	Dallas Mavericks	102	Houston Rockets	108	21	23	28	30	34	23	31	20
17	03.11.2024\nApós Prol.	Houston Rockets	121	Golden State Warriors	127	20	23	37	39	38	33	25	23
18	05.11.2024	Houston Rockets	109	New York Knicks	97	31	30	20	28	26	30	19	22
19	07.11.2024	Houston Rockets	127	San Antonio Spurs	100	31	32	31	33	19	19	33	29
20	09.11.2024	Oklahoma City Thunder	126	Houston Rockets	107	31	44	23	28	31	20	25	31
21	10.11.2024	Detroit Pistons	99	Houston Rockets	101	17	28	19	35	20	23	29	29
22	12.11.2024	Houston Rockets	107	Washington Wizards	92	30	27	25	25	28	21	20	23
23	14.11.2024	Houston Rockets	111	Los Angeles Clippers	103	28	33	28	22	28	28	23	24
24	16.11.2024	Houston Rockets	125	Los Angeles Clippers	104	29	37	28	31	21	25	29	29
25	18.11.2024	Chicago Bulls	107	Houston Rockets	143	26	26	26	29	27	41	40	35
26	19.11.2024	Milwaukee Bucks	101	Houston Rockets	100	27	30	26	18	28	17	35	20
27	21.11.2024	Houston Rockets	130	Indiana Pacers	113	30	32	36	32	23	30	24	36
28	23.11.2024	Houston Rockets	116	Portland Trail Blazers	88	31	34	31	20	20	25	28	15
29	24.11.2024	Houston Rockets	98	Portland Trail Blazers	104	21	29	21	27	26	26	21	31
30	27.11.2024\nApós Prol.	Minnesota Timberwolves	111	Houston Rockets	117	26	21	31	24	32	25	27	18
31	28.11.2024\nApós Prol.	Philadelphia 76ers	115	Houston Rockets	122	24	27	31	26	35	20	33	20
32	02.12.2024	Houston Rockets	119	Oklahoma City Thunder	116	33	29	29	28	28	32	36	20
33	04.12.2024	Sacramento Kings	120	Houston Rockets	111	21	33	42	24	28	27	29	27
34	06.12.2024	Golden State Warriors	99	Houston Rockets	93	18	31	24	26	22	21	23	27
35	09.12.2024	Los Angeles Clippers	106	Houston Rockets	117	28	24	31	23	30	34	31	22
36	12.12.2024	Houston Rockets	91	Golden State Warriors	90	20	24	24	23	18	19	32	21
37	15.12.2024	Oklahoma City Thunder	111	Houston Rockets	96	18	23	34	36	20	22	27	27
38	20.12.2024	Houston Rockets	133	New Orleans Pelicans	113	39	27	33	34	25	27	27	34
39	22.12.2024	Toronto Raptors	110	Houston Rockets	114	35	22	26	27	24	27	33	30
40	24.12.2024	Charlotte Hornets	101	Houston Rockets	114	15	16	35	35	31	31	30	22
41	27.12.2024	New Orleans Pelicans	111	Houston Rockets	128	22	21	31	37	39	22	41	26
42	28.12.2024	Houston Rockets	112	Minnesota Timberwolves	113	21	31	32	28	22	35	19	37
43	30.12.2024	Houston Rockets	100	Miami Heat	104	27	23	32	18	31	22	28	23
44	02.01. 01:00	Houston Rockets	110	Dallas Mavericks	99	24	37	28	21	30	22	23	24
45	04.01. 01:00	Houston Rockets	86	Boston Celtics	109	31	25	16	14	37	28	17	27
46	06.01. 00:00	Houston Rockets	119	Los Angeles Lakers	115	36	31	24	28	22	27	40	26
47	08.01. 00:00	Washington Wizards	112	Houston Rockets	135	30	25	24	33	20	37	40	38
48	10.01. 01:00	Memphis Grizzlies	115	Houston Rockets	119	36	27	29	23	45	23	33	18
49	14.01. 01:00	Houston Rockets	120	Memphis Grizzlies	118	23	34	30	33	30	30	32	26
50	16.01. 02:00	Denver Nuggets	108	Houston Rockets	128	23	25	33	27	28	41	33	26
51	17.01. 03:00	Sacramento Kings	132	Houston Rockets	127	26	35	29	42	25	27	33	42
\.


--
-- Data for Name: houston_rockets_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.houston_rockets_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 02:00	1	Green J.	HOU	34	1	5	1776	10	16	0	0	6	10	8	8	13	1	0	2	0	1	1	0	0
16.01.2025 02:00	2	Sengun A.	HOU	20	9	8	1539	9	21	0	0	0	1	2	2	17	3	6	1	2	1	0	0	0
16.01.2025 02:00	3	VanVleet F.	HOU	16	1	8	2107	6	13	0	0	4	9	0	0	18	0	1	3	3	0	0	0	0
16.01.2025 02:00	4	Whitmore C.	HOU	16	9	1	1436	7	11	0	0	2	4	0	0	5	2	7	1	1	1	1	0	0
16.01.2025 02:00	5	Thompson A.	HOU	11	9	0	2081	4	8	0	0	0	0	3	7	20	3	6	2	4	2	2	0	0
16.01.2025 02:00	6	Williams N.	HOU	9	0	1	350	4	4	0	0	1	1	0	0	-1	0	0	1	1	0	0	0	0
16.01.2025 02:00	7	Green Je.	HOU	8	2	0	1234	3	6	0	0	2	5	0	0	13	0	2	4	0	0	1	0	0
16.01.2025 02:00	8	Brooks D.	HOU	6	1	0	1572	2	5	0	0	2	4	0	0	17	0	1	1	2	1	0	0	0
16.01.2025 02:00	9	Tate J.	HOU	6	4	1	1053	3	5	0	0	0	1	0	0	-6	3	1	3	0	0	0	0	0
16.01.2025 02:00	10	Adams S.	HOU	2	3	1	427	1	1	0	0	0	0	0	0	6	2	1	0	0	1	1	0	0
16.01.2025 02:00	11	Holiday A.	HOU	0	0	2	450	0	1	0	0	0	1	0	0	-2	0	0	1	1	0	0	0	0
16.01.2025 02:00	12	Sheppard R.	HOU	0	1	1	375	0	3	0	0	0	2	0	0	0	0	1	0	0	1	0	0	0
14.01.2025 01:00	13	Green J.	HOU	42	3	4	2408	13	18	0	0	5	6	11	11	8	0	3	1	1	3	0	0	0
14.01.2025 01:00	14	Thompson A.	HOU	19	13	4	2469	7	15	0	0	1	3	4	7	3	4	9	1	2	4	5	0	0
14.01.2025 01:00	15	Sengun A.	HOU	17	8	5	1934	7	17	0	0	0	1	3	6	6	3	5	5	3	6	1	0	0
14.01.2025 01:00	16	Whitmore C.	HOU	16	1	1	1289	6	9	0	0	4	7	0	0	12	0	1	1	1	1	0	0	0
14.01.2025 01:00	17	Brooks D.	HOU	9	5	2	2344	3	11	0	0	2	8	1	2	-11	2	3	5	4	1	0	0	0
14.01.2025 01:00	18	VanVleet F.	HOU	9	2	9	2175	2	5	0	0	2	3	3	4	-2	0	2	3	1	2	1	0	0
14.01.2025 01:00	19	Holiday A.	HOU	6	1	0	547	2	4	0	0	2	3	0	0	3	0	1	0	0	2	0	0	0
14.01.2025 01:00	20	Adams S.	HOU	2	7	1	783	1	2	0	0	0	0	0	1	3	6	1	0	0	2	1	0	0
14.01.2025 01:00	21	Tate J.	HOU	0	0	2	451	0	0	0	0	0	0	0	0	-12	0	0	0	1	1	0	0	0
10.01.2025 01:00	22	Sengun A.	HOU	32	14	5	2110	12	20	0	0	1	1	7	15	2	5	9	4	0	3	1	0	0
10.01.2025 01:00	23	Green J.	HOU	27	2	3	2293	11	21	0	0	4	8	1	2	-1	1	1	0	3	3	1	0	0
10.01.2025 01:00	24	VanVleet F.	HOU	22	1	4	2435	8	13	0	0	3	7	3	3	2	0	1	4	4	3	0	0	0
10.01.2025 01:00	25	Tate J.	HOU	12	4	0	1107	3	6	0	0	2	3	4	8	5	3	1	4	1	0	0	0	0
10.01.2025 01:00	26	Thompson A.	HOU	10	7	5	2130	2	6	0	0	0	0	6	7	-4	0	7	4	1	0	1	0	0
10.01.2025 01:00	27	Whitmore C.	HOU	9	2	0	900	3	14	0	0	2	6	1	2	4	1	1	0	3	1	0	0	0
10.01.2025 01:00	28	Brooks D.	HOU	5	5	4	2077	2	15	0	0	1	8	0	0	5	2	3	4	1	0	0	0	1
10.01.2025 01:00	29	Holiday A.	HOU	2	0	0	598	0	1	0	0	0	1	2	2	7	0	0	1	0	0	0	0	0
10.01.2025 01:00	30	Adams S.	HOU	0	9	0	746	0	0	0	0	0	0	0	2	0	4	5	2	0	2	0	0	0
08.01.2025 00:00	31	Green J.	HOU	29	8	2	1807	10	22	0	0	7	15	2	2	21	2	6	0	2	1	0	0	0
08.01.2025 00:00	32	Sengun A.	HOU	26	10	6	1781	12	23	0	0	0	2	2	2	29	4	6	2	2	4	0	0	0
08.01.2025 00:00	33	Thompson A.	HOU	20	15	5	2467	7	8	0	0	0	0	6	6	19	4	11	1	3	0	0	0	0
08.01.2025 00:00	34	VanVleet F.	HOU	19	1	12	2283	7	15	0	0	2	9	3	3	17	1	0	3	4	2	1	0	0
08.01.2025 00:00	35	Whitmore C.	HOU	17	1	0	1073	6	8	0	0	3	3	2	2	2	1	0	0	1	0	0	0	0
08.01.2025 00:00	36	Brooks D.	HOU	11	1	2	1100	4	8	0	0	3	4	0	0	-7	1	0	4	0	0	0	0	0
08.01.2025 00:00	37	Green Je.	HOU	7	1	0	584	2	4	0	0	0	2	3	4	-6	0	1	1	0	0	0	0	0
08.01.2025 00:00	38	Holiday A.	HOU	4	2	3	1389	1	3	0	0	0	1	2	2	31	2	0	4	2	1	0	0	0
08.01.2025 00:00	39	Tate J.	HOU	2	1	0	865	1	4	0	0	0	1	0	0	10	1	0	1	1	0	0	0	0
08.01.2025 00:00	40	Adams S.	HOU	0	6	0	685	0	1	0	0	0	0	0	2	-7	2	4	1	0	1	0	0	0
08.01.2025 00:00	41	Landale J.	HOU	0	3	1	183	0	0	0	0	0	0	0	0	3	1	2	0	0	0	0	0	0
08.01.2025 00:00	42	Williams N.	HOU	0	0	0	183	0	1	0	0	0	1	0	0	3	0	0	0	0	1	1	0	0
06.01.2025 00:00	43	Green J.	HOU	33	6	4	1970	12	24	0	0	5	12	4	4	-5	1	5	5	0	0	1	0	0
06.01.2025 00:00	44	Thompson A.	HOU	23	16	3	2435	11	19	0	0	0	3	1	4	1	6	10	2	1	4	0	0	0
06.01.2025 00:00	45	VanVleet F.	HOU	15	2	2	2542	5	12	0	0	3	8	2	3	-5	0	2	1	1	0	1	0	0
06.01.2025 00:00	46	Sengun A.	HOU	14	6	4	1885	6	14	0	0	0	2	2	4	-14	2	4	4	0	2	0	0	0
06.01.2025 00:00	47	Adams S.	HOU	8	9	1	994	3	4	0	0	0	0	2	4	17	7	2	2	1	0	1	0	0
06.01.2025 00:00	48	Whitmore C.	HOU	8	4	0	981	3	8	0	0	2	5	0	0	6	0	4	1	0	0	1	0	0
06.01.2025 00:00	49	Holiday A.	HOU	7	0	0	732	3	7	0	0	1	3	0	0	10	0	0	0	0	0	0	0	0
06.01.2025 00:00	50	Tate J.	HOU	6	1	2	901	2	3	0	0	2	3	0	0	14	1	0	5	0	0	0	0	0
06.01.2025 00:00	51	Brooks D.	HOU	5	5	3	1960	2	8	0	0	1	4	0	0	-4	1	4	2	0	0	0	0	0
04.01.2025 01:00	52	Green J.	HOU	27	3	1	2102	10	21	0	0	5	13	2	2	-24	0	3	3	0	1	2	0	0
04.01.2025 01:00	53	Sengun A.	HOU	14	7	3	1725	6	15	0	0	0	1	2	2	-28	2	5	4	1	4	1	0	0
04.01.2025 01:00	54	Whitmore C.	HOU	11	6	1	2029	4	17	0	0	1	9	2	2	-12	1	5	0	1	1	0	0	0
04.01.2025 01:00	55	Brooks D.	HOU	10	2	0	1808	4	13	0	0	2	6	0	0	-10	1	1	5	1	0	0	0	0
04.01.2025 01:00	56	VanVleet F.	HOU	8	1	3	1825	3	7	0	0	1	3	1	1	-15	0	1	3	0	1	0	0	0
04.01.2025 01:00	57	Green Je.	HOU	7	5	0	1722	2	3	0	0	1	2	2	2	-16	0	5	3	1	1	0	0	0
04.01.2025 01:00	58	Adams S.	HOU	6	4	1	411	2	4	0	0	0	0	2	2	8	4	0	0	0	0	0	0	0
04.01.2025 01:00	59	Landale J.	HOU	3	2	0	293	1	3	0	0	0	0	1	1	-2	1	1	0	0	0	0	0	0
04.01.2025 01:00	60	Holiday A.	HOU	0	3	0	1117	0	4	0	0	0	1	0	0	-7	2	1	1	1	2	0	0	0
04.01.2025 01:00	61	Sheppard R.	HOU	0	0	0	293	0	0	0	0	0	0	0	0	-2	0	0	0	1	1	0	0	0
04.01.2025 01:00	62	Tate J.	HOU	0	4	0	1075	0	1	0	0	0	1	0	0	-7	3	1	2	0	0	1	0	0
02.01.2025 01:00	63	Sengun A.	HOU	23	6	4	2205	9	16	0	0	0	1	5	8	21	0	6	2	6	4	0	0	0
02.01.2025 01:00	64	Green J.	HOU	22	5	0	2264	9	21	0	0	0	3	4	5	18	0	5	3	1	2	0	0	0
02.01.2025 01:00	65	Brooks D.	HOU	19	6	1	2388	6	15	0	0	3	8	4	4	9	2	4	3	1	0	0	0	0
02.01.2025 01:00	66	Whitmore C.	HOU	18	3	1	1440	7	9	0	0	3	4	1	1	12	0	3	2	1	2	0	0	0
02.01.2025 01:00	67	Smith Jr. J.	HOU	12	2	0	1370	5	8	0	0	1	2	1	2	-4	1	1	1	2	2	1	0	0
02.01.2025 01:00	68	VanVleet F.	HOU	5	5	7	2508	1	8	0	0	0	4	3	3	16	0	5	3	5	2	0	0	0
02.01.2025 01:00	69	Adams S.	HOU	4	4	0	443	2	3	0	0	0	0	0	0	-2	1	3	0	0	0	0	0	0
02.01.2025 01:00	70	Holiday A.	HOU	4	1	1	906	2	4	0	0	0	2	0	0	-8	0	1	2	0	0	0	0	0
02.01.2025 01:00	71	Tate J.	HOU	3	3	2	876	1	5	0	0	1	1	0	0	-7	0	3	2	1	0	0	0	0
30.12.2024 00:00	72	Brooks D.	HOU	22	4	0	2380	8	20	0	0	5	12	1	1	8	1	3	2	0	1	1	0	0
30.12.2024 00:00	73	Green J.	HOU	19	3	2	2058	6	20	0	0	1	8	6	7	-10	2	1	2	0	1	0	0	0
30.12.2024 00:00	74	Sengun A.	HOU	18	18	6	2087	8	14	0	0	0	1	2	2	4	5	13	4	1	5	1	0	0
30.12.2024 00:00	75	VanVleet F.	HOU	16	7	6	2294	6	17	0	0	4	10	0	0	4	2	5	4	3	3	2	0	0
30.12.2024 00:00	76	Smith Jr. J.	HOU	7	3	0	1577	2	8	0	0	2	5	1	1	-4	1	2	2	0	2	0	0	0
30.12.2024 00:00	77	Whitmore C.	HOU	7	3	0	691	3	7	0	0	1	2	0	0	6	0	3	0	0	0	0	0	0
30.12.2024 00:00	78	Thompson A.	HOU	5	5	5	1906	2	4	0	0	0	1	1	2	-17	3	2	3	1	0	0	0	0
30.12.2024 00:00	79	Adams S.	HOU	4	9	3	749	2	3	0	0	0	0	0	0	-6	5	4	1	0	0	0	0	0
30.12.2024 00:00	80	Holiday A.	HOU	2	0	2	658	1	4	0	0	0	1	0	0	-5	0	0	3	0	0	0	0	0
28.12.2024 01:00	81	Sengun A.	HOU	38	12	1	2451	16	25	0	0	0	1	6	10	-6	8	4	4	1	2	0	0	0
28.12.2024 01:00	82	Thompson A.	HOU	20	11	1	2338	9	12	0	0	0	1	2	2	-4	2	9	4	1	3	1	0	0
28.12.2024 01:00	83	VanVleet F.	HOU	18	6	7	2313	6	16	0	0	5	10	1	3	0	1	5	2	0	3	1	0	0
28.12.2024 01:00	84	Green J.	HOU	14	2	6	2335	5	15	0	0	3	6	1	2	6	0	2	0	0	2	0	0	0
28.12.2024 01:00	85	Smith Jr. J.	HOU	12	7	1	2552	5	12	0	0	2	8	0	0	4	2	5	1	0	2	1	0	0
28.12.2024 01:00	86	Tate J.	HOU	6	6	0	981	3	6	0	0	0	1	0	0	4	2	4	4	2	1	0	0	0
28.12.2024 01:00	87	Whitmore C.	HOU	4	3	1	695	1	5	0	0	0	3	2	2	-8	0	3	1	0	0	0	0	0
28.12.2024 01:00	88	Adams S.	HOU	0	1	1	168	0	1	0	0	0	0	0	0	0	1	0	0	1	0	0	0	0
28.12.2024 01:00	89	Holiday A.	HOU	0	0	1	321	0	0	0	0	0	0	0	0	5	0	0	0	2	0	0	0	0
28.12.2024 01:00	90	Sheppard R.	HOU	0	0	0	246	0	0	0	0	0	0	0	0	-6	0	0	0	0	1	0	0	0
27.12.2024 01:00	91	Green J.	HOU	30	2	2	1776	12	21	0	0	6	11	0	0	30	0	2	1	2	0	0	0	0
27.12.2024 01:00	92	Whitmore C.	HOU	27	4	1	1634	9	16	0	0	4	8	5	6	8	1	3	0	1	0	0	0	0
27.12.2024 01:00	93	VanVleet F.	HOU	25	6	4	1543	8	15	0	0	7	12	2	2	14	4	2	2	1	2	0	0	0
27.12.2024 01:00	94	Sengun A.	HOU	10	13	6	1510	5	11	0	0	0	2	0	0	19	3	10	2	0	3	0	0	0
27.12.2024 01:00	95	Tate J.	HOU	10	2	0	1048	4	6	0	0	0	1	2	2	23	0	2	2	0	1	0	0	0
27.12.2024 01:00	96	Thompson A.	HOU	9	10	3	1836	4	8	0	0	0	3	1	2	22	6	4	0	1	3	5	0	0
27.12.2024 01:00	97	Green Je.	HOU	6	2	0	534	2	3	0	0	1	2	1	2	-11	1	1	1	0	0	0	0	0
27.12.2024 01:00	98	Smith Jr. J.	HOU	6	6	0	1699	1	7	0	0	0	3	4	4	6	2	4	3	0	2	1	0	0
27.12.2024 01:00	99	Adams S.	HOU	2	5	0	648	1	1	0	0	0	0	0	1	9	0	5	1	0	1	1	0	0
27.12.2024 01:00	100	Holiday A.	HOU	2	0	1	534	0	0	0	0	0	0	2	2	-11	0	0	0	1	0	1	0	0
27.12.2024 01:00	101	Sheppard R.	HOU	1	4	2	1104	0	8	0	0	0	4	1	2	-13	1	3	1	1	0	0	0	0
27.12.2024 01:00	102	Landale J.	HOU	0	0	0	534	0	1	0	0	0	1	0	0	-11	0	0	1	0	3	1	0	0
24.12.2024 00:00	103	Smith Jr. J.	HOU	21	11	2	2075	7	14	0	0	2	5	5	6	25	3	8	1	0	1	0	0	0
24.12.2024 00:00	104	VanVleet F.	HOU	20	5	6	1746	8	16	0	0	3	8	1	1	16	0	5	2	0	2	1	0	0
24.12.2024 00:00	105	Thompson A.	HOU	19	11	3	2282	8	16	0	0	2	6	1	1	17	5	6	0	1	2	3	0	0
24.12.2024 00:00	106	Whitmore C.	HOU	17	8	0	1627	7	16	0	0	3	8	0	0	1	3	5	1	2	4	1	0	0
24.12.2024 00:00	107	Sengun A.	HOU	16	8	4	1609	5	11	0	0	1	2	5	5	10	4	4	2	0	1	1	0	0
24.12.2024 00:00	108	Green J.	HOU	6	2	1	1457	3	8	0	0	0	3	0	0	10	0	2	1	0	0	0	0	0
24.12.2024 00:00	109	Tate J.	HOU	6	1	2	882	1	2	0	0	1	2	3	4	11	0	1	3	0	0	0	0	0
24.12.2024 00:00	110	Holiday A.	HOU	4	0	0	183	2	4	0	0	0	1	0	0	-4	0	0	0	0	1	0	0	2
24.12.2024 00:00	111	Sheppard R.	HOU	3	4	2	1134	1	7	0	0	1	6	0	0	-3	1	3	3	1	0	1	0	0
24.12.2024 00:00	112	Adams S.	HOU	2	8	3	695	1	1	0	0	0	0	0	2	4	4	4	2	0	0	1	0	0
24.12.2024 00:00	113	Green Je.	HOU	0	1	0	394	0	2	0	0	0	1	0	0	-14	0	1	1	0	0	0	0	0
24.12.2024 00:00	114	Landale J.	HOU	0	1	0	316	0	2	0	0	0	0	0	0	-8	1	0	0	0	0	0	0	0
22.12.2024 23:00	115	Brooks D.	HOU	27	6	2	2220	6	12	0	0	2	7	13	14	-7	2	4	4	3	6	0	0	0
22.12.2024 23:00	116	Green J.	HOU	22	7	2	2015	9	20	0	0	2	8	2	3	-3	1	6	0	0	2	0	0	1
22.12.2024 23:00	117	Sengun A.	HOU	17	10	5	1961	7	14	0	0	0	2	3	5	4	3	7	2	3	5	2	0	0
22.12.2024 23:00	118	Smith Jr. J.	HOU	15	9	0	2223	4	9	0	0	1	3	6	6	10	3	6	2	1	3	3	0	0
22.12.2024 23:00	119	Whitmore C.	HOU	11	4	1	860	5	10	0	0	1	2	0	0	13	2	2	0	1	1	0	0	0
22.12.2024 23:00	120	Thompson A.	HOU	10	5	2	1386	4	7	0	0	0	0	2	3	7	3	2	1	0	2	0	0	0
22.12.2024 23:00	121	Tate J.	HOU	7	2	1	910	3	6	0	0	0	0	1	2	14	2	0	3	2	0	0	0	0
22.12.2024 23:00	122	Sheppard R.	HOU	3	2	0	373	1	1	0	0	1	1	0	0	-3	0	2	0	0	1	0	0	0
22.12.2024 23:00	123	VanVleet F.	HOU	2	8	5	2250	1	10	0	0	0	5	0	0	-5	2	6	2	2	1	0	0	0
22.12.2024 23:00	124	Landale J.	HOU	0	0	0	202	0	0	0	0	0	0	0	0	-10	0	0	0	0	0	0	0	0
\.


--
-- Data for Name: houston_rockets_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.houston_rockets_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Eason Tari	Lesionado	2025-01-16 10:44:43.666613
2	Smith Jr. Jabari	Lesionado	2025-01-16 10:44:43.669322
\.


--
-- Data for Name: indiana_pacers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.indiana_pacers (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	13.07.2024\nApós Prol.	Indiana Pacers	95	Brooklyn Nets	97	21	20	20	28	17	16	27	29
2	14.07.2024	Indiana Pacers	94	Minnesota Timberwolves	105	28	16	27	23	26	25	27	27
3	16.07.2024	Phoenix Suns	94	Indiana Pacers	98	26	28	18	22	24	20	29	25
4	18.07.2024	Denver Nuggets	86	Indiana Pacers	71	18	24	17	27	13	13	26	19
5	20.07.2024	Cleveland Cavaliers	100	Indiana Pacers	93	22	16	28	34	18	20	27	28
6	09.10.2024	Atlanta Hawks	131	Indiana Pacers	130	35	23	41	32	31	32	35	32
7	11.10.2024	Cleveland Cavaliers	117	Indiana Pacers	129	31	39	18	29	28	41	32	28
8	15.10.2024	Indiana Pacers	116	Memphis Grizzlies	120	17	32	29	38	31	29	31	29
9	18.10.2024\nApós Prol.	Indiana Pacers	121	Charlotte Hornets	116	29	20	24	33	25	36	24	21
10	24.10.2024	Detroit Pistons	109	Indiana Pacers	115	31	27	32	19	25	24	33	33
11	26.10.2024	New York Knicks	123	Indiana Pacers	98	25	36	34	28	24	21	19	34
12	27.10.2024\nApós Prol.	Indiana Pacers	114	Philadelphia 76ers	118	23	35	20	27	28	24	27	26
13	28.10.2024	Orlando Magic	119	Indiana Pacers	115	35	36	22	26	36	23	39	17
14	30.10.2024\nApós Prol.	Indiana Pacers	135	Boston Celtics	132	35	32	33	24	31	26	29	38
15	02.11.2024	New Orleans Pelicans	125	Indiana Pacers	118	35	27	33	30	35	27	27	29
16	05.11.2024	Dallas Mavericks	127	Indiana Pacers	134	29	30	36	32	36	27	33	38
17	07.11.2024	Indiana Pacers	118	Orlando Magic	111	38	23	26	31	26	31	28	26
18	09.11.2024	Charlotte Hornets	103	Indiana Pacers	83	29	15	30	29	26	18	22	17
19	10.11.2024	Indiana Pacers	132	New York Knicks	121	29	29	34	40	26	35	33	27
20	14.11.2024	Orlando Magic	94	Indiana Pacers	90	18	23	27	26	27	18	27	18
21	16.11.2024	Indiana Pacers	111	Miami Heat	124	29	26	30	26	26	35	37	26
22	17.11.2024	Indiana Pacers	119	Miami Heat	110	28	24	33	34	20	29	26	35
23	19.11.2024	Toronto Raptors	130	Indiana Pacers	119	34	35	27	34	27	30	25	37
24	21.11.2024	Houston Rockets	130	Indiana Pacers	113	30	32	36	32	23	30	24	36
25	23.11.2024	Milwaukee Bucks	129	Indiana Pacers	117	34	24	35	36	22	22	35	38
26	24.11.2024	Indiana Pacers	115	Washington Wizards	103	31	26	35	23	28	31	28	16
27	26.11.2024	Indiana Pacers	114	New Orleans Pelicans	110	29	30	28	27	25	32	26	27
28	28.11.2024	Indiana Pacers	121	Portland Trail Blazers	114	26	34	36	25	31	29	25	29
29	30.11.2024	Indiana Pacers	106	Detroit Pistons	130	24	29	20	33	33	30	29	38
30	01.12.2024	Memphis Grizzlies	136	Indiana Pacers	121	28	34	40	34	45	23	23	30
31	04.12.2024	Toronto Raptors	122	Indiana Pacers	111	31	34	28	29	23	25	36	27
32	05.12.2024	Brooklyn Nets	99	Indiana Pacers	90	24	27	24	24	17	18	35	20
33	07.12.2024	Chicago Bulls	123	Indiana Pacers	132	35	19	39	30	31	36	36	29
34	08.12.2024	Indiana Pacers	109	Charlotte Hornets	113	24	38	20	27	28	35	20	30
35	14.12.2024	Philadelphia 76ers	107	Indiana Pacers	121	22	28	33	24	31	30	29	31
36	15.12.2024	Indiana Pacers	119	New Orleans Pelicans	104	31	28	40	20	28	14	38	24
37	20.12.2024	Phoenix Suns	111	Indiana Pacers	120	29	30	24	28	32	28	37	23
38	22.12.2024	Sacramento Kings	95	Indiana Pacers	122	23	29	26	17	21	31	35	35
39	24.12.2024	Golden State Warriors	105	Indiana Pacers	111	32	22	31	20	33	29	27	22
40	27.12.2024	Indiana Pacers	114	Oklahoma City Thunder	120	29	32	23	30	19	34	30	37
41	28.12.2024	Boston Celtics	142	Indiana Pacers	105	39	28	36	39	22	23	33	27
42	29.12.2024	Boston Celtics	114	Indiana Pacers	123	29	29	33	23	27	38	33	25
43	31.12.2024	Indiana Pacers	112	Milwaukee Bucks	120	28	36	27	21	30	23	35	32
44	03.01. 00:30	Miami Heat	115	Indiana Pacers	128	25	25	33	32	38	28	41	21
45	05.01. 00:00	Indiana Pacers	126	Phoenix Suns	108	30	26	40	30	29	27	28	24
46	07.01. 00:30	Brooklyn Nets	99	Indiana Pacers	113	22	17	31	29	24	31	23	35
47	09.01. 00:00	Indiana Pacers	129	Chicago Bulls	113	29	34	37	29	18	26	32	37
48	11.01. 00:00	Indiana Pacers	108	Golden State Warriors	96	27	23	30	28	24	21	25	26
49	12.01. 23:00	Cleveland Cavaliers	93	Indiana Pacers	108	19	34	18	22	21	19	37	31
50	15.01. 00:00	Indiana Pacers	117	Cleveland Cavaliers	127	30	31	28	28	37	25	38	27
51	17.01. 00:00	Detroit Pistons	100	Indiana Pacers	111	26	30	25	19	29	40	23	19
\.


--
-- Data for Name: indiana_pacers_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.indiana_pacers_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
15.01.2025 00:00	1	Siakam P.	IND	23	7	4	2024	10	16	0	0	2	2	1	1	-11	2	5	2	1	1	0	0	0
15.01.2025 00:00	2	Mathurin B.	IND	19	4	2	1889	8	12	0	0	3	6	0	1	-10	1	3	3	1	3	1	0	0
15.01.2025 00:00	3	Turner M.	IND	17	5	0	1773	5	11	0	0	1	4	6	6	-20	1	4	3	1	1	0	0	0
15.01.2025 00:00	4	Walker J.	IND	11	5	1	1074	4	8	0	0	1	4	2	2	-7	1	4	4	0	0	1	0	0
15.01.2025 00:00	5	McConnell T.J.	IND	10	1	8	1276	5	11	0	0	0	0	0	0	3	1	0	2	1	0	0	0	0
15.01.2025 00:00	6	Nembhard A.	IND	10	4	9	1978	4	12	0	0	0	1	2	5	-18	1	3	1	3	2	0	0	0
15.01.2025 00:00	7	Toppin O.	IND	10	3	3	1179	4	9	0	0	2	3	0	0	-1	0	3	0	1	1	0	0	0
15.01.2025 00:00	8	Bryant T.	IND	8	5	1	1018	3	5	0	0	2	3	0	0	6	2	3	1	0	2	0	0	0
15.01.2025 00:00	9	Sheppard B.	IND	7	3	2	1922	1	6	0	0	1	4	4	5	-4	0	3	2	1	1	1	0	0
15.01.2025 00:00	10	Dennis R.	IND	2	0	0	89	0	1	0	0	0	1	2	2	4	0	0	0	1	0	0	0	0
15.01.2025 00:00	11	Furphy J.	IND	0	0	0	89	0	0	0	0	0	0	0	0	4	0	0	0	0	0	0	0	0
15.01.2025 00:00	12	Johnson J.	IND	0	0	0	89	0	0	0	0	0	0	0	0	4	0	0	0	0	0	0	0	0
12.01.2025 23:00	13	Nembhard A.	IND	19	2	4	1690	7	11	0	0	2	4	3	4	-4	0	2	2	2	3	0	0	0
12.01.2025 23:00	14	Siakam P.	IND	18	9	2	1863	8	21	0	0	0	5	2	2	6	3	6	1	1	1	2	0	0
12.01.2025 23:00	15	Turner M.	IND	15	10	1	1718	5	10	0	0	2	6	3	5	3	3	7	4	0	0	0	0	0
12.01.2025 23:00	16	Mathurin B.	IND	12	3	3	1987	5	15	0	0	2	7	0	2	14	0	3	3	0	1	1	0	0
12.01.2025 23:00	17	Toppin O.	IND	12	2	1	1052	5	10	0	0	1	4	1	2	10	0	2	1	3	1	0	0	0
12.01.2025 23:00	18	Bryant T.	IND	11	3	1	1162	5	5	0	0	1	1	0	1	12	1	2	1	0	0	2	0	0
12.01.2025 23:00	19	Walker J.	IND	8	12	2	1292	3	5	0	0	2	3	0	0	21	2	10	3	2	0	1	0	0
12.01.2025 23:00	20	McConnell T.J.	IND	6	4	8	1027	2	6	0	0	0	1	2	2	18	0	4	2	0	2	0	0	0
12.01.2025 23:00	21	Sheppard B.	IND	5	2	3	1335	2	4	0	0	1	2	0	0	11	0	2	4	2	1	0	0	0
12.01.2025 23:00	22	Haliburton T.	IND	2	1	5	1110	1	5	0	0	0	2	0	0	-14	0	1	0	1	1	1	0	0
12.01.2025 23:00	23	Furphy J.	IND	0	2	0	164	0	0	0	0	0	0	0	0	-2	0	2	1	0	0	0	0	0
11.01.2025 00:00	24	Haliburton T.	IND	25	2	10	2095	8	10	0	0	2	4	7	7	18	0	2	1	3	5	0	0	0
11.01.2025 00:00	25	Siakam P.	IND	25	10	0	1795	12	16	0	0	1	4	0	2	21	3	7	1	1	1	0	0	0
11.01.2025 00:00	26	Mathurin B.	IND	21	10	2	2047	9	18	0	0	3	8	0	0	22	1	9	2	0	2	0	0	0
11.01.2025 00:00	27	Turner M.	IND	11	7	2	1759	3	9	0	0	1	4	4	6	21	0	7	2	1	1	3	0	0
11.01.2025 00:00	28	McConnell T.J.	IND	10	2	6	1018	4	8	0	0	0	0	2	2	5	0	2	1	0	2	1	0	0
11.01.2025 00:00	29	Bryant T.	IND	5	4	1	1010	2	3	0	0	1	2	0	0	-4	1	3	0	2	0	2	0	0
11.01.2025 00:00	30	Sheppard B.	IND	5	2	0	1207	2	6	0	0	1	3	0	0	-7	0	2	2	0	0	0	0	0
11.01.2025 00:00	31	Nembhard A.	IND	4	4	5	1751	2	6	0	0	0	0	0	2	12	2	2	1	1	1	0	0	1
11.01.2025 00:00	32	Toppin O.	IND	2	4	1	974	1	3	0	0	0	2	0	0	-4	0	4	1	0	1	2	0	0
11.01.2025 00:00	33	Dennis R.	IND	0	0	0	111	0	0	0	0	0	0	0	0	-5	0	0	0	0	1	0	0	0
11.01.2025 00:00	34	Furphy J.	IND	0	0	0	111	0	0	0	0	0	0	0	0	-5	0	0	0	0	0	0	0	0
11.01.2025 00:00	35	Johnson J.	IND	0	0	0	111	0	0	0	0	0	0	0	0	-5	0	0	1	0	0	0	0	0
11.01.2025 00:00	36	Walker J.	IND	0	3	0	411	0	3	0	0	0	0	0	0	-9	1	2	1	0	1	0	0	0
09.01.2025 00:00	37	Siakam P.	IND	26	6	3	1718	11	17	0	0	3	7	1	3	10	2	4	0	0	2	0	0	0
09.01.2025 00:00	38	Bryant T.	IND	22	8	1	1669	9	16	0	0	2	4	2	2	21	5	3	2	2	0	0	0	0
09.01.2025 00:00	39	Haliburton T.	IND	16	3	13	1812	7	13	0	0	2	3	0	0	25	0	3	1	2	1	0	0	0
09.01.2025 00:00	40	Nembhard A.	IND	14	6	5	1865	5	11	0	0	0	3	4	5	20	0	6	3	2	2	0	0	1
09.01.2025 00:00	41	Toppin O.	IND	12	5	2	1384	5	9	0	0	1	4	1	2	11	1	4	3	0	0	0	0	0
09.01.2025 00:00	42	Walker J.	IND	12	2	3	1154	5	7	0	0	1	2	1	3	-11	0	2	2	1	1	1	0	0
09.01.2025 00:00	43	Mathurin B.	IND	8	3	4	1490	3	12	0	0	0	4	2	2	23	2	1	2	1	0	0	0	0
09.01.2025 00:00	44	Sheppard B.	IND	7	7	0	1251	3	5	0	0	1	2	0	0	-7	3	4	4	0	0	0	0	0
09.01.2025 00:00	45	Freeman E.	IND	6	4	1	960	2	3	0	0	0	0	2	4	-9	1	3	2	0	1	0	0	0
09.01.2025 00:00	46	McConnell T.J.	IND	6	2	5	982	2	7	0	0	0	0	2	3	-2	1	1	0	3	1	0	0	0
09.01.2025 00:00	47	Jackson Q.	IND	0	0	0	86	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
07.01.2025 00:30	48	Haliburton T.	IND	23	2	8	1915	5	12	0	0	4	7	9	9	10	0	2	2	1	3	1	0	0
07.01.2025 00:30	49	Mathurin B.	IND	20	3	2	1882	8	14	0	0	3	6	1	2	16	0	3	3	0	3	0	0	0
07.01.2025 00:30	50	Siakam P.	IND	19	6	2	1424	7	16	0	0	0	3	5	5	14	1	5	2	0	0	0	0	0
07.01.2025 00:30	51	Toppin O.	IND	11	5	0	1294	4	6	0	0	1	2	2	2	2	1	4	1	0	1	0	0	0
07.01.2025 00:30	52	Turner M.	IND	10	5	1	1847	4	7	0	0	2	4	0	0	13	2	3	1	3	1	3	0	0
07.01.2025 00:30	53	Bryant T.	IND	8	3	2	1033	3	4	0	0	1	2	1	1	1	1	2	2	0	0	1	0	0
07.01.2025 00:30	54	McConnell T.J.	IND	8	1	2	1028	3	4	0	0	0	0	2	2	1	0	1	2	2	0	0	0	0
07.01.2025 00:30	55	Nembhard A.	IND	8	5	3	1876	3	8	0	0	1	4	1	2	12	0	5	2	2	1	0	0	0
07.01.2025 00:30	56	Walker J.	IND	4	3	1	645	2	4	0	0	0	1	0	0	5	0	3	1	0	0	0	0	0
07.01.2025 00:30	57	Furphy J.	IND	2	0	0	162	1	1	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
07.01.2025 00:30	58	Johnson J.	IND	0	0	0	96	0	0	0	0	0	0	0	0	-1	0	0	0	0	0	0	0	0
07.01.2025 00:30	59	Sheppard B.	IND	0	2	1	1198	0	3	0	0	0	2	0	0	-1	0	2	1	0	1	0	0	0
05.01.2025 00:00	60	Haliburton T.	IND	27	5	8	1970	8	19	0	0	5	12	6	7	13	1	4	0	2	0	1	0	0
05.01.2025 00:00	61	Turner M.	IND	20	6	1	1635	9	17	0	0	2	6	0	0	16	2	4	0	1	0	3	0	0
05.01.2025 00:00	62	Siakam P.	IND	15	9	4	2044	7	17	0	0	1	5	0	0	18	1	8	1	0	1	0	0	0
05.01.2025 00:00	63	Mathurin B.	IND	13	10	4	2069	5	10	0	0	1	3	2	2	23	1	9	4	0	0	0	0	0
05.01.2025 00:00	64	Toppin O.	IND	12	3	2	983	3	6	0	0	0	2	6	6	4	3	0	1	2	1	0	0	0
05.01.2025 00:00	65	Sheppard B.	IND	10	2	1	1144	2	5	0	0	2	5	4	4	6	1	1	0	0	0	0	0	0
05.01.2025 00:00	66	Nembhard A.	IND	9	3	7	1807	3	3	0	0	2	2	1	2	20	1	2	4	1	2	0	0	0
05.01.2025 00:00	67	McConnell T.J.	IND	8	3	4	1073	4	9	0	0	0	0	0	0	-2	0	3	4	0	1	0	0	0
05.01.2025 00:00	68	Walker J.	IND	7	0	1	848	3	4	0	0	1	2	0	0	-7	0	0	1	1	0	0	0	0
05.01.2025 00:00	69	Bryant T.	IND	5	6	3	773	2	6	0	0	1	3	0	0	-1	3	3	1	0	1	0	0	0
05.01.2025 00:00	70	Furphy J.	IND	0	0	0	54	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
03.01.2025 00:30	71	Haliburton T.	IND	33	5	15	2081	13	21	0	0	6	13	1	3	26	1	4	1	2	0	1	0	0
03.01.2025 00:30	72	Turner M.	IND	21	5	2	2078	8	15	0	0	2	5	3	4	14	1	4	3	1	0	2	0	0
03.01.2025 00:30	73	Siakam P.	IND	18	11	4	1914	8	13	0	0	1	2	1	4	13	4	7	1	0	0	0	0	1
03.01.2025 00:30	74	Mathurin B.	IND	12	2	1	1778	5	12	0	0	1	5	1	1	15	1	1	1	0	3	0	0	0
03.01.2025 00:30	75	Toppin O.	IND	12	6	0	1219	5	9	0	0	2	4	0	0	2	1	5	1	0	1	0	0	0
03.01.2025 00:30	76	Walker J.	IND	12	1	1	799	3	6	0	0	3	3	3	4	-13	0	1	2	1	0	0	0	0
03.01.2025 00:30	77	McConnell T.J.	IND	8	1	4	1133	4	7	0	0	0	0	0	0	3	0	1	2	1	2	0	0	0
03.01.2025 00:30	78	Nembhard A.	IND	6	6	6	1747	3	7	0	0	0	2	0	0	10	3	3	1	1	0	0	0	0
03.01.2025 00:30	79	Bryant T.	IND	3	0	1	427	1	3	0	0	1	3	0	0	1	0	0	1	0	0	0	0	0
03.01.2025 00:30	80	Sheppard B.	IND	3	2	1	1193	1	3	0	0	1	3	0	0	-4	2	0	2	3	0	1	0	0
03.01.2025 00:30	81	Furphy J.	IND	0	0	0	31	0	0	0	0	0	0	0	0	-2	0	0	1	0	0	0	0	0
31.12.2024 20:00	82	Mathurin B.	IND	25	9	2	2218	10	18	0	0	3	5	2	5	-11	2	7	3	1	6	1	0	0
31.12.2024 20:00	83	Siakam P.	IND	20	7	4	1860	6	14	0	0	3	7	5	8	-5	0	7	3	0	1	0	0	0
31.12.2024 20:00	84	Turner M.	IND	16	10	2	2003	7	12	0	0	2	5	0	0	-2	4	6	3	0	2	1	0	0
31.12.2024 20:00	85	Haliburton T.	IND	12	7	7	2318	3	13	0	0	1	6	5	6	-6	2	5	2	1	1	2	0	0
31.12.2024 20:00	86	Walker J.	IND	11	1	1	935	3	5	0	0	1	3	4	4	-2	0	1	2	3	0	1	0	0
31.12.2024 20:00	87	Nembhard A.	IND	10	2	3	1900	4	14	0	0	2	5	0	0	2	0	2	4	0	2	0	0	0
31.12.2024 20:00	88	McConnell T.J.	IND	6	3	5	980	3	5	0	0	0	1	0	2	-10	0	3	0	2	3	0	0	0
31.12.2024 20:00	89	Sheppard B.	IND	5	7	0	1137	2	5	0	0	1	4	0	0	1	0	7	2	1	0	1	0	0
31.12.2024 20:00	90	Toppin O.	IND	4	2	2	745	1	3	0	0	0	1	2	4	-13	0	2	0	0	1	1	0	0
31.12.2024 20:00	91	Bryant T.	IND	3	2	0	304	1	1	0	0	0	0	1	1	6	1	1	1	0	0	0	0	0
29.12.2024 23:00	92	Haliburton T.	IND	31	6	7	2168	11	19	0	0	1	6	8	9	13	0	6	0	1	0	0	0	0
29.12.2024 23:00	93	Nembhard A.	IND	17	8	8	1997	6	12	0	0	1	1	4	5	23	1	7	3	0	2	1	0	0
29.12.2024 23:00	94	Siakam P.	IND	17	8	6	1851	6	11	0	0	1	2	4	4	10	0	8	3	3	2	1	0	0
29.12.2024 23:00	95	Mathurin B.	IND	14	5	1	1767	6	8	0	0	1	1	1	1	9	1	4	2	0	2	0	0	0
29.12.2024 23:00	96	Turner M.	IND	13	6	3	1957	5	8	0	0	0	1	3	4	12	1	5	0	0	0	0	0	0
29.12.2024 23:00	97	Walker J.	IND	12	5	0	1518	4	8	0	0	3	5	1	2	3	0	5	1	0	1	0	0	0
29.12.2024 23:00	98	Bryant T.	IND	8	3	0	923	4	6	0	0	0	1	0	0	-3	3	0	2	1	0	0	0	0
29.12.2024 23:00	99	Sheppard B.	IND	8	4	1	1268	3	8	0	0	2	5	0	0	-4	2	2	5	0	0	0	0	0
29.12.2024 23:00	100	McConnell T.J.	IND	3	5	1	815	1	6	0	0	0	1	1	2	-10	3	2	1	1	2	0	0	0
29.12.2024 23:00	101	Furphy J.	IND	0	0	0	68	0	0	0	0	0	0	0	0	-4	0	0	0	0	0	0	0	0
29.12.2024 23:00	102	Jackson Q.	IND	0	0	0	68	0	1	0	0	0	0	0	0	-4	0	0	0	0	0	0	0	0
28.12.2024 00:30	103	Haliburton T.	IND	19	4	9	1778	6	13	0	0	3	8	4	4	-27	0	4	0	0	2	0	0	0
28.12.2024 00:30	104	Mathurin B.	IND	18	6	2	1915	6	13	0	0	1	2	5	6	-25	3	3	4	0	1	0	0	0
28.12.2024 00:30	105	Walker J.	IND	15	0	5	1705	5	10	0	0	1	4	4	6	-22	0	0	3	2	1	0	0	0
28.12.2024 00:30	106	Siakam P.	IND	14	9	1	1429	5	11	0	0	3	6	1	2	-17	2	7	1	1	1	0	0	0
28.12.2024 00:30	107	Bryant T.	IND	12	7	0	1127	5	7	0	0	2	4	0	0	-11	1	6	0	1	2	1	0	0
28.12.2024 00:30	108	McConnell T.J.	IND	8	0	4	1178	4	11	0	0	0	2	0	0	-13	0	0	0	0	2	0	0	0
28.12.2024 00:30	109	Turner M.	IND	8	5	0	1371	3	7	0	0	1	4	1	2	-23	3	2	3	0	3	0	0	0
28.12.2024 00:30	110	Johnson J.	IND	4	0	0	382	2	3	0	0	0	0	0	1	-3	0	0	2	0	0	1	0	0
28.12.2024 00:30	111	Jackson Q.	IND	3	0	3	539	0	0	0	0	0	0	3	4	-7	0	0	3	0	0	0	0	0
28.12.2024 00:30	112	Freeman E.	IND	2	2	0	382	1	3	0	0	0	1	0	0	-3	1	1	0	0	0	0	0	0
28.12.2024 00:30	113	Sheppard B.	IND	2	2	1	1182	1	7	0	0	0	4	0	0	-18	1	1	2	0	0	0	0	0
28.12.2024 00:30	114	Furphy J.	IND	0	4	2	1412	0	6	0	0	0	4	0	0	-16	2	2	2	1	0	1	0	0
27.12.2024 00:00	115	Nembhard A.	IND	23	9	7	1716	9	17	0	0	1	5	4	4	-3	2	7	2	0	2	1	0	0
27.12.2024 00:00	116	Siakam P.	IND	22	10	3	1871	7	14	0	0	5	7	3	4	3	1	9	4	0	1	0	0	0
27.12.2024 00:00	117	Mathurin B.	IND	18	6	3	2343	5	13	0	0	2	5	6	8	4	2	4	6	0	1	1	0	0
27.12.2024 00:00	118	McConnell T.J.	IND	13	3	3	1158	6	9	0	0	1	2	0	0	-5	0	3	0	0	1	0	0	0
27.12.2024 00:00	119	Turner M.	IND	12	11	2	1979	4	13	0	0	1	6	3	6	-5	4	7	2	0	2	5	0	0
27.12.2024 00:00	120	Walker J.	IND	12	5	0	913	5	10	0	0	2	4	0	0	-16	1	4	2	0	1	1	0	0
27.12.2024 00:00	121	Sheppard B.	IND	5	1	2	1306	2	3	0	0	1	2	0	0	-1	0	1	2	1	2	0	0	0
27.12.2024 00:00	122	Toppin O.	IND	5	3	0	409	2	2	0	0	1	1	0	0	2	0	3	1	0	0	0	0	0
27.12.2024 00:00	123	Haliburton T.	IND	4	2	8	2117	2	6	0	0	0	2	0	0	-13	1	1	1	0	1	0	0	0
27.12.2024 00:00	124	Bryant T.	IND	0	1	0	588	0	2	0	0	0	2	0	0	4	0	1	1	0	0	0	0	0
24.12.2024 03:00	125	Turner M.	IND	23	10	1	2072	9	14	0	0	3	7	2	2	18	2	8	1	0	2	3	0	0
24.12.2024 03:00	126	Siakam P.	IND	20	5	1	2057	9	18	0	0	1	4	1	1	0	1	4	5	2	1	0	0	0
24.12.2024 03:00	127	Haliburton T.	IND	16	6	12	2302	6	11	0	0	2	7	2	2	28	0	6	0	2	1	0	0	0
24.12.2024 03:00	128	Nembhard A.	IND	15	4	3	1999	6	13	0	0	1	4	2	2	4	1	3	2	0	4	0	0	0
24.12.2024 03:00	129	McConnell T.J.	IND	13	0	5	1222	5	10	0	0	3	3	0	0	-18	0	0	1	0	2	1	0	0
24.12.2024 03:00	130	Mathurin B.	IND	12	5	2	2146	5	14	0	0	1	5	1	2	27	1	4	5	0	1	0	0	0
24.12.2024 03:00	131	Toppin O.	IND	8	4	1	1108	4	6	0	0	0	1	0	0	4	0	4	1	2	0	0	0	0
24.12.2024 03:00	132	Bryant T.	IND	2	3	1	597	0	3	0	0	0	2	2	2	-10	2	1	1	1	0	0	0	0
24.12.2024 03:00	133	Walker J.	IND	2	2	0	249	1	1	0	0	0	0	0	0	-1	0	2	0	0	0	0	0	0
24.12.2024 03:00	134	Sheppard B.	IND	0	4	0	648	0	2	0	0	0	2	0	0	-22	1	3	0	0	0	0	0	0
\.


--
-- Data for Name: indiana_pacers_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.indiana_pacers_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Wiseman James	Lesionado	2025-01-16 10:44:57.19635
2	Haliburton Tyrese	Lesionado	2025-01-16 10:44:57.19896
3	Jackson Isaiah	Lesionado	2025-01-16 10:44:57.20125
4	Mathurin Bennedict	Lesionado	2025-01-16 10:44:57.20341
5	Nesmith Aaron	Lesionado	2025-01-16 10:44:57.205753
\.


--
-- Data for Name: links; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.links (id, team_name, link, event_time) FROM stdin;
521	Boston Celtics	https://www.flashscore.pt/equipa/boston-celtics/KYD9hVEm/	18.01. 00:00
522	Orlando Magic	https://www.flashscore.pt/equipa/orlando-magic/QZMS36Dn/	18.01. 00:00
523	New York Knicks	https://www.flashscore.pt/equipa/new-york-knicks/WCNO4nbt/	18.01. 00:30
524	Minnesota Timberwolves	https://www.flashscore.pt/equipa/minnesota-timberwolves/KjBIVQcI/	18.01. 00:30
525	Chicago Bulls	https://www.flashscore.pt/equipa/chicago-bulls/bPjc49q0/	18.01. 01:00
526	Charlotte Hornets	https://www.flashscore.pt/equipa/charlotte-hornets/xftMikUg/	18.01. 01:00
527	Miami Heat	https://www.flashscore.pt/equipa/miami-heat/CQ7AXnT5/	18.01. 01:00
528	Denver Nuggets	https://www.flashscore.pt/equipa/denver-nuggets/CxvW27TI/	18.01. 01:00
529	Milwaukee Bucks	https://www.flashscore.pt/equipa/milwaukee-bucks/QTBEW6rC/	18.01. 01:00
530	Toronto Raptors	https://www.flashscore.pt/equipa/toronto-raptors/CxtbCMdU/	18.01. 01:00
531	New Orleans Pelicans	https://www.flashscore.pt/equipa/new-orleans-pelicans/U3yc9SkP/	18.01. 01:00
532	Utah Jazz	https://www.flashscore.pt/equipa/utah-jazz/hGuCX5Su/	18.01. 01:00
533	Dallas Mavericks	https://www.flashscore.pt/equipa/dallas-mavericks/YouS3mEC/	18.01. 01:30
534	Oklahoma City Thunder	https://www.flashscore.pt/equipa/oklahoma-city-thunder/0fHFHEWD/	18.01. 01:30
535	San Antonio Spurs	https://www.flashscore.pt/equipa/san-antonio-spurs/IwmkErSH/	18.01. 02:30
536	Memphis Grizzlies	https://www.flashscore.pt/equipa/memphis-grizzlies/U1I5YSDa/	18.01. 02:30
537	Los Angeles Lakers	https://www.flashscore.pt/equipa/los-angeles-lakers/ngegZ8bg/	18.01. 03:30
538	Brooklyn Nets	https://www.flashscore.pt/equipa/brooklyn-nets/bsAMUpDO/	18.01. 03:30
539	Detroit Pistons	https://www.flashscore.pt/equipa/detroit-pistons/UcjMRj6J/	18.01. 21:00
540	Phoenix Suns	https://www.flashscore.pt/equipa/phoenix-suns/M1Gy2pra/	18.01. 21:00
541	Boston Celtics	https://www.flashscore.pt/equipa/boston-celtics/KYD9hVEm/	19.01. 00:00
542	Atlanta Hawks	https://www.flashscore.pt/equipa/atlanta-hawks/xAO4gBas/	19.01. 00:00
543	Indiana Pacers	https://www.flashscore.pt/equipa/indiana-pacers/YPohMUTt/	19.01. 00:00
544	Philadelphia 76ers	https://www.flashscore.pt/equipa/philadelphia-76ers/vwRW2QSh/	19.01. 00:00
545	Golden State Warriors	https://www.flashscore.pt/equipa/golden-state-warriors/SxUtXqch/	19.01. 01:30
546	Washington Wizards	https://www.flashscore.pt/equipa/washington-wizards/W6vGWPsn/	19.01. 01:30
547	Minnesota Timberwolves	https://www.flashscore.pt/equipa/minnesota-timberwolves/KjBIVQcI/	19.01. 02:00
548	Cleveland Cavaliers	https://www.flashscore.pt/equipa/cleveland-cavaliers/xGk13Tb6/	19.01. 02:00
549	Portland Trail Blazers	https://www.flashscore.pt/equipa/portland-trail-blazers/4Awl14c5/	19.01. 03:00
550	Houston Rockets	https://www.flashscore.pt/equipa/houston-rockets/Sr9PQALP/	19.01. 03:00
\.


--
-- Data for Name: los_angeles_clippers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.los_angeles_clippers (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	13.07.2024	Los Angeles Clippers	88	Denver Nuggets	78	17	24	19	28	16	22	19	21
2	14.07.2024	Los Angeles Clippers	87	Brooklyn Nets	78	31	13	18	25	18	15	8	37
3	17.07.2024	Milwaukee Bucks	97	Los Angeles Clippers	112	22	23	31	21	28	30	30	24
4	19.07.2024	Utah Jazz	88	Los Angeles Clippers	105	19	21	24	24	13	30	27	35
5	21.07.2024	Memphis Grizzlies	99	Los Angeles Clippers	98	25	24	24	26	19	35	13	31
6	06.10.2024	Los Angeles Clippers	90	Golden State Warriors	91	26	23	22	19	23	30	16	22
7	09.10.2024	Los Angeles Clippers	115	Brooklyn Nets	106	35	20	28	32	18	39	19	30
8	12.10.2024	Los Angeles Clippers	101	Portland Trail Blazers	99	23	26	27	25	24	26	28	21
9	15.10.2024	Los Angeles Clippers	110	Dallas Mavericks	96	25	31	27	27	26	25	24	21
10	18.10.2024	Los Angeles Clippers	113	Sacramento Kings	91	30	35	20	28	20	18	31	22
11	24.10.2024\nApós Prol.	Los Angeles Clippers	113	Phoenix Suns	116	22	17	35	29	23	24	25	31
12	26.10.2024	Denver Nuggets	104	Los Angeles Clippers	109	19	23	29	33	27	21	22	39
13	28.10.2024	Golden State Warriors	104	Los Angeles Clippers	112	34	20	25	25	34	25	27	26
14	31.10.2024	Los Angeles Clippers	105	Portland Trail Blazers	106	26	24	35	20	24	30	28	24
15	01.11.2024	Los Angeles Clippers	119	Phoenix Suns	125	37	33	23	26	20	32	39	34
16	03.11.2024	Los Angeles Clippers	92	Oklahoma City Thunder	105	28	29	21	14	19	34	28	24
17	05.11.2024	Los Angeles Clippers	113	San Antonio Spurs	104	14	34	34	31	40	16	30	18
18	07.11.2024	Los Angeles Clippers	110	Philadelphia 76ers	98	24	27	33	26	27	24	17	30
19	09.11.2024	Sacramento Kings	98	Los Angeles Clippers	107	28	17	28	25	34	17	27	29
20	10.11.2024	Los Angeles Clippers	105	Toronto Raptors	103	28	24	29	24	22	25	23	33
21	12.11.2024	Oklahoma City Thunder	134	Los Angeles Clippers	128	25	41	33	35	24	29	41	34
22	14.11.2024	Houston Rockets	111	Los Angeles Clippers	103	28	33	28	22	28	28	23	24
23	16.11.2024	Houston Rockets	125	Los Angeles Clippers	104	29	37	28	31	21	25	29	29
24	18.11.2024	Los Angeles Clippers	116	Utah Jazz	105	35	31	30	20	25	20	29	31
25	19.11.2024	Los Angeles Clippers	102	Golden State Warriors	99	27	29	19	27	22	23	27	27
26	21.11.2024	Los Angeles Clippers	104	Orlando Magic	93	29	28	30	17	25	29	21	18
27	23.11.2024	Los Angeles Clippers	104	Sacramento Kings	88	26	25	25	28	12	17	35	24
28	24.11.2024	Philadelphia 76ers	99	Los Angeles Clippers	125	27	23	22	27	39	23	35	28
29	26.11.2024	Boston Celtics	126	Los Angeles Clippers	94	27	51	21	27	20	29	29	16
30	28.11.2024	Washington Wizards	96	Los Angeles Clippers	121	26	18	25	27	37	24	27	33
31	30.11.2024	Minnesota Timberwolves	93	Los Angeles Clippers	92	26	27	19	21	25	22	21	24
32	02.12.2024	Los Angeles Clippers	126	Denver Nuggets	122	32	27	33	34	23	36	31	32
33	04.12.2024	Los Angeles Clippers	127	Portland Trail Blazers	105	36	27	28	36	31	27	20	27
34	05.12.2024	Los Angeles Clippers	80	Minnesota Timberwolves	108	14	18	18	30	33	26	27	22
35	09.12.2024	Los Angeles Clippers	106	Houston Rockets	117	28	24	31	23	30	34	31	22
36	14.12.2024	Denver Nuggets	120	Los Angeles Clippers	98	29	19	35	37	22	25	22	29
37	17.12.2024	Los Angeles Clippers	144	Utah Jazz	107	44	37	34	29	20	27	33	27
38	20.12.2024	Dallas Mavericks	95	Los Angeles Clippers	118	30	19	28	18	24	26	39	29
39	22.12.2024	Dallas Mavericks	113	Los Angeles Clippers	97	23	31	20	39	22	18	26	31
40	24.12.2024	Memphis Grizzlies	110	Los Angeles Clippers	114	30	28	32	20	28	23	40	23
41	28.12.2024	Los Angeles Clippers	102	Golden State Warriors	92	19	30	32	21	21	22	19	30
42	31.12.2024	New Orleans Pelicans	113	Los Angeles Clippers	116	37	25	28	23	31	25	31	29
43	01.01. 00:00	San Antonio Spurs	122	Los Angeles Clippers	86	31	32	28	31	17	26	20	23
44	03.01. 01:00	Oklahoma City Thunder	116	Los Angeles Clippers	98	22	26	42	26	30	22	20	26
45	05.01. 03:30	Los Angeles Clippers	131	Atlanta Hawks	105	29	45	24	33	28	26	22	29
46	07.01. 01:00	Minnesota Timberwolves	108	Los Angeles Clippers	106	16	30	31	31	27	26	23	30
47	09.01. 02:00	Denver Nuggets	126	Los Angeles Clippers	103	33	33	32	28	19	31	27	26
48	14.01. 03:30	Los Angeles Clippers	109	Miami Heat	98	28	15	36	30	35	13	20	30
49	16.01. 03:30	Los Angeles Clippers	126	Brooklyn Nets	67	21	37	44	24	21	14	16	16
\.


--
-- Data for Name: los_angeles_clippers_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.los_angeles_clippers_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 03:30	1	Leonard K.	LAC	23	2	0	1429	8	11	0	0	0	1	7	7	46	0	2	0	1	1	0	0	0
16.01.2025 03:30	2	Harden J.	LAC	21	6	11	1380	6	10	0	0	3	5	6	6	36	0	6	1	2	1	0	0	0
16.01.2025 03:30	3	Powell N.	LAC	18	1	2	1323	7	10	0	0	3	4	1	2	47	0	1	3	3	3	0	0	0
16.01.2025 03:30	4	Coffey A.	LAC	13	5	1	1887	4	9	0	0	3	6	2	2	19	0	5	1	1	1	0	0	0
16.01.2025 03:30	5	Jones D.	LAC	11	3	0	1126	4	7	0	0	0	1	3	3	42	0	3	0	1	0	0	0	0
16.01.2025 03:30	6	Zubac I.	LAC	11	9	4	1323	4	6	0	0	0	0	3	3	48	3	6	2	1	2	1	0	0
16.01.2025 03:30	7	Hyland N.	LAC	9	3	5	861	3	6	0	0	1	4	2	2	10	0	3	2	2	2	0	0	0
16.01.2025 03:30	8	Bamba M.	LAC	7	7	1	1055	2	5	0	0	1	4	2	2	7	1	6	4	0	1	0	0	0
16.01.2025 03:30	9	Jones K.	LAC	6	3	0	861	3	4	0	0	0	0	0	0	10	0	3	1	0	1	1	0	0
16.01.2025 03:30	10	Mann T.	LAC	5	2	0	502	2	3	0	0	1	1	0	0	4	1	1	2	0	0	1	0	0
16.01.2025 03:30	11	Miller J.	LAC	2	1	0	861	0	2	0	0	0	0	2	3	10	0	1	0	1	1	0	0	0
16.01.2025 03:30	12	Batum N.	LAC	0	3	1	1023	0	3	0	0	0	3	0	0	13	1	2	1	1	0	0	0	0
16.01.2025 03:30	13	Dunn K.	LAC	0	1	1	769	0	3	0	0	0	3	0	0	3	0	1	0	0	1	0	0	0
14.01.2025 03:30	14	Powell N.	LAC	29	6	1	2158	12	17	0	0	5	8	0	0	8	0	6	2	3	0	0	0	0
14.01.2025 03:30	15	Harden J.	LAC	26	5	11	2216	9	17	0	0	6	10	2	2	13	0	5	2	1	4	1	0	0
14.01.2025 03:30	16	Zubac I.	LAC	21	20	1	1926	10	13	0	0	0	0	1	3	3	4	16	0	0	1	2	0	0
14.01.2025 03:30	17	Jones D.	LAC	9	0	1	941	4	7	0	0	0	2	1	3	8	0	0	1	1	1	0	0	0
14.01.2025 03:30	18	Leonard K.	LAC	6	5	1	1244	3	9	0	0	0	3	0	0	2	1	4	0	2	0	0	0	0
14.01.2025 03:30	19	Porter K.	LAC	6	0	4	962	3	10	0	0	0	1	0	0	2	0	0	1	0	2	1	0	0
14.01.2025 03:30	20	Bamba M.	LAC	5	7	0	498	2	3	0	0	1	2	0	0	4	1	6	1	0	1	0	0	0
14.01.2025 03:30	21	Coffey A.	LAC	5	0	0	1477	1	5	0	0	1	3	2	2	2	0	0	2	2	0	0	0	0
14.01.2025 03:30	22	Dunn K.	LAC	2	0	8	1536	1	10	0	0	0	6	0	0	10	0	0	4	1	2	0	0	0
14.01.2025 03:30	23	Batum N.	LAC	0	5	1	1442	0	2	0	0	0	1	0	0	3	1	4	2	1	0	2	0	0
09.01.2025 02:00	24	Powell N.	LAC	30	4	1	1699	8	17	0	0	4	10	10	13	-16	0	4	2	0	0	0	0	0
09.01.2025 02:00	25	Harden J.	LAC	16	3	4	1643	5	15	0	0	2	8	4	5	-17	0	3	0	0	5	1	0	0
09.01.2025 02:00	26	Porter K.	LAC	10	0	1	916	4	7	0	0	1	4	1	4	-13	0	0	0	2	0	1	0	0
09.01.2025 02:00	27	Zubac I.	LAC	10	8	3	1717	2	4	0	0	0	0	6	7	-21	1	7	1	0	2	1	0	0
09.01.2025 02:00	28	Brown K.	LAC	6	3	0	661	2	2	0	0	1	1	1	1	0	0	3	0	0	0	0	0	0
09.01.2025 02:00	29	Coffey A.	LAC	6	0	1	2005	2	11	0	0	0	3	2	2	-12	0	0	0	1	0	0	0	0
09.01.2025 02:00	30	Miller J.	LAC	6	5	0	917	1	5	0	0	0	0	4	4	1	2	3	1	0	1	0	0	0
09.01.2025 02:00	31	Hyland N.	LAC	5	2	2	560	1	4	0	0	1	4	2	2	4	1	1	0	0	0	0	0	0
09.01.2025 02:00	32	Bamba M.	LAC	4	8	0	924	1	5	0	0	0	2	2	2	1	2	6	0	1	0	2	0	0
09.01.2025 02:00	33	Jones D.	LAC	4	2	0	875	2	3	0	0	0	1	0	0	-11	0	2	4	0	0	0	0	0
09.01.2025 02:00	34	Batum N.	LAC	3	2	1	559	1	2	0	0	1	2	0	0	-12	1	1	2	2	0	0	0	0
09.01.2025 02:00	35	Mann T.	LAC	3	0	0	747	1	4	0	0	1	2	0	0	-11	0	0	2	1	2	0	0	0
09.01.2025 02:00	36	Dunn K.	LAC	0	3	1	1177	0	1	0	0	0	1	0	0	-8	2	1	3	1	1	1	0	0
07.01.2025 01:00	37	Powell N.	LAC	25	6	1	2298	7	17	0	0	2	5	9	10	-8	2	4	1	1	3	0	0	0
07.01.2025 01:00	38	Harden J.	LAC	22	8	8	2244	8	22	0	0	3	11	3	5	-5	2	6	4	2	4	2	0	0
07.01.2025 01:00	39	Zubac I.	LAC	17	16	2	2108	7	11	0	0	0	0	3	3	-2	3	13	2	1	2	6	0	1
07.01.2025 01:00	40	Jones D.	LAC	10	2	1	1528	3	5	0	0	1	2	3	4	13	0	2	1	1	0	0	0	0
07.01.2025 01:00	41	Coffey A.	LAC	9	4	1	1222	3	9	0	0	1	2	2	2	9	4	0	3	0	0	0	0	0
07.01.2025 01:00	42	Leonard K.	LAC	8	2	2	1241	3	11	0	0	2	5	0	0	-17	1	1	1	1	1	0	0	0
07.01.2025 01:00	43	Porter K.	LAC	7	6	7	1130	3	5	0	0	1	2	0	1	8	1	5	1	1	2	0	0	0
07.01.2025 01:00	44	Batum N.	LAC	3	3	0	778	1	2	0	0	1	2	0	0	-4	0	3	3	1	1	0	0	0
07.01.2025 01:00	45	Mann T.	LAC	3	0	1	590	1	2	0	0	1	2	0	0	6	0	0	0	1	0	0	0	0
07.01.2025 01:00	46	Dunn K.	LAC	2	2	0	1261	1	5	0	0	0	4	0	0	-10	1	1	3	0	0	2	0	0
05.01.2025 03:30	47	Powell N.	LAC	20	4	1	1752	8	16	0	0	4	10	0	0	28	0	4	0	2	2	0	0	0
05.01.2025 03:30	48	Zubac I.	LAC	18	18	4	1911	9	11	0	0	0	0	0	1	25	4	14	3	0	1	1	0	0
05.01.2025 03:30	49	Coffey A.	LAC	17	4	2	1763	5	14	0	0	3	8	4	4	18	0	4	1	0	0	0	0	0
05.01.2025 03:30	50	Porter K.	LAC	15	3	7	1116	6	7	0	0	0	0	3	4	16	0	3	3	2	1	0	0	0
05.01.2025 03:30	51	Jones D.	LAC	12	3	0	1317	6	11	0	0	0	3	0	0	1	1	2	1	3	0	0	0	0
05.01.2025 03:30	52	Leonard K.	LAC	12	3	1	1165	4	11	0	0	3	5	1	3	22	1	2	1	1	2	0	0	0
05.01.2025 03:30	53	Mann T.	LAC	12	3	2	962	5	5	0	0	2	2	0	0	-4	0	3	1	1	1	0	0	0
05.01.2025 03:30	54	Harden J.	LAC	10	2	15	1764	3	9	0	0	1	5	3	4	10	0	2	2	2	4	0	0	0
05.01.2025 03:30	55	Brown K.	LAC	5	4	1	306	2	2	0	0	0	0	1	1	4	0	4	0	0	1	0	0	0
05.01.2025 03:30	56	Batum N.	LAC	4	0	1	663	2	4	0	0	0	2	0	0	-3	0	0	2	1	0	0	0	0
05.01.2025 03:30	57	Dunn K.	LAC	2	3	0	763	1	2	0	0	0	0	0	0	1	0	3	2	1	3	1	0	0
05.01.2025 03:30	58	Jones K.	LAC	2	0	0	306	1	1	0	0	0	0	0	0	4	0	0	1	0	0	1	0	0
05.01.2025 03:30	59	Miller J.	LAC	2	0	2	306	1	1	0	0	0	0	0	0	4	0	0	0	2	1	0	0	0
05.01.2025 03:30	60	Hyland N.	LAC	0	1	0	306	0	2	0	0	0	1	0	0	4	1	0	0	0	1	0	0	0
03.01.2025 01:00	61	Coffey A.	LAC	26	3	2	2118	10	14	0	0	6	8	0	0	-10	1	2	1	1	4	0	0	0
03.01.2025 01:00	62	Bamba M.	LAC	12	8	0	952	5	6	0	0	2	3	0	0	-3	1	7	1	0	2	0	0	0
03.01.2025 01:00	63	Porter K.	LAC	11	3	3	1459	3	11	0	0	0	3	5	7	-7	1	2	0	0	1	1	0	0
03.01.2025 01:00	64	Zubac I.	LAC	11	9	2	1385	5	9	0	0	0	0	1	3	-23	1	8	1	0	2	0	0	0
03.01.2025 01:00	65	Miller J.	LAC	10	4	5	1385	4	8	0	0	1	5	1	2	1	1	3	1	3	1	0	0	0
03.01.2025 01:00	66	Dunn K.	LAC	8	2	5	1658	3	7	0	0	2	3	0	0	-26	0	2	2	0	1	0	0	0
03.01.2025 01:00	67	Jones D.	LAC	6	6	1	1408	3	7	0	0	0	2	0	0	-21	3	3	2	0	1	0	0	0
03.01.2025 01:00	68	Jones K.	LAC	6	3	1	431	3	3	0	0	0	0	0	0	10	1	2	1	0	1	0	0	0
03.01.2025 01:00	69	Powell N.	LAC	6	1	2	1655	1	11	0	0	0	5	4	5	-26	0	1	4	0	6	0	0	0
03.01.2025 01:00	70	Hyland N.	LAC	2	1	2	431	1	4	0	0	0	2	0	0	10	0	1	1	1	0	0	0	0
03.01.2025 01:00	71	Batum N.	LAC	0	2	1	989	0	1	0	0	0	1	0	0	0	0	2	2	1	0	0	0	0
03.01.2025 01:00	72	Brown K.	LAC	0	3	1	529	0	0	0	0	0	0	0	0	5	1	2	2	0	0	0	0	0
01.01.2025 00:00	73	Harden J.	LAC	17	3	1	1528	5	11	0	0	2	6	5	6	-27	1	2	1	1	5	1	0	0
01.01.2025 00:00	74	Powell N.	LAC	15	5	2	1580	4	12	0	0	3	10	4	4	-19	0	5	0	2	1	0	0	0
01.01.2025 00:00	75	Coffey A.	LAC	14	2	0	1692	6	12	0	0	2	4	0	0	-14	0	2	1	1	0	0	0	0
01.01.2025 00:00	76	Dunn K.	LAC	7	2	1	1356	3	6	0	0	1	3	0	0	-16	0	2	2	1	1	0	0	0
01.01.2025 00:00	77	Hyland N.	LAC	7	1	2	1040	2	10	0	0	1	6	2	2	-9	0	1	1	0	1	0	0	0
01.01.2025 00:00	78	Jones D.	LAC	6	2	0	1268	2	5	0	0	1	3	1	2	-19	1	1	1	0	1	0	0	0
01.01.2025 00:00	79	Brown K.	LAC	5	0	0	720	2	6	0	0	1	1	0	0	-8	0	0	1	0	0	1	0	0
01.01.2025 00:00	80	Zubac I.	LAC	5	7	2	1330	2	7	0	0	0	0	1	2	-19	2	5	2	0	1	0	0	0
01.01.2025 00:00	81	Jones K.	LAC	4	4	1	1040	2	6	0	0	0	2	0	0	-9	1	3	1	0	0	1	0	0
01.01.2025 00:00	82	Bamba M.	LAC	2	2	1	430	1	4	0	0	0	3	0	0	-11	1	1	1	0	0	0	0	0
01.01.2025 00:00	83	Miller J.	LAC	2	6	3	849	0	1	0	0	0	0	2	2	-7	2	4	0	2	1	0	0	0
01.01.2025 00:00	84	Porter K.	LAC	2	4	4	804	1	6	0	0	0	2	0	0	-12	1	3	2	0	1	0	0	0
01.01.2025 00:00	85	Batum N.	LAC	0	3	0	763	0	1	0	0	0	1	0	0	-10	1	2	2	0	1	0	0	0
31.12.2024 01:00	86	Powell N.	LAC	35	3	2	2409	13	27	0	0	4	12	5	6	3	1	2	1	2	2	0	0	0
31.12.2024 01:00	87	Harden J.	LAC	27	2	4	2159	6	14	0	0	5	10	10	12	3	0	2	3	1	7	0	0	0
31.12.2024 01:00	88	Zubac I.	LAC	20	16	4	2160	9	13	0	0	0	0	2	5	-4	7	9	0	1	0	1	0	0
31.12.2024 01:00	89	Jones D.	LAC	11	3	2	1891	5	11	0	0	1	6	0	0	4	1	2	2	2	1	1	0	0
31.12.2024 01:00	90	Dunn K.	LAC	7	3	6	1925	3	7	0	0	1	5	0	0	-5	2	1	2	2	2	1	0	0
31.12.2024 01:00	91	Coffey A.	LAC	6	3	0	1255	1	3	0	0	0	1	4	4	0	0	3	2	0	1	0	0	0
31.12.2024 01:00	92	Porter K.	LAC	5	2	4	968	2	9	0	0	1	2	0	0	6	0	2	3	0	2	0	0	0
31.12.2024 01:00	93	Batum N.	LAC	3	5	2	1180	1	1	0	0	1	1	0	0	7	1	4	1	3	1	0	0	0
31.12.2024 01:00	94	Bamba M.	LAC	2	3	0	453	1	1	0	0	0	0	0	0	1	2	1	0	0	0	0	0	0
28.12.2024 03:00	95	Powell N.	LAC	26	3	1	2411	10	20	0	0	2	7	4	4	18	0	3	4	2	4	1	0	0
28.12.2024 03:00	96	Harden J.	LAC	18	3	7	2330	6	14	0	0	2	8	4	4	8	1	2	3	1	6	1	0	1
28.12.2024 03:00	97	Zubac I.	LAC	17	11	2	2157	8	9	0	0	0	0	1	3	5	1	10	2	0	2	5	0	0
28.12.2024 03:00	98	Jones D.	LAC	14	6	2	1771	7	12	0	0	0	2	0	0	8	2	4	1	2	1	0	0	0
28.12.2024 03:00	99	Dunn K.	LAC	13	7	4	2053	5	8	0	0	2	5	1	2	14	1	6	3	1	5	0	0	0
28.12.2024 03:00	100	Coffey A.	LAC	11	2	0	1538	3	7	0	0	3	5	2	2	-1	0	2	3	0	0	1	0	0
28.12.2024 03:00	101	Batum N.	LAC	3	5	3	1203	1	3	0	0	1	3	0	0	-2	1	4	1	0	2	1	0	0
28.12.2024 03:00	102	Bamba M.	LAC	0	2	0	723	0	0	0	0	0	0	0	0	5	0	2	1	0	0	1	0	0
28.12.2024 03:00	103	Miller J.	LAC	0	0	0	214	0	2	0	0	0	2	0	0	-5	0	0	1	0	1	0	0	0
24.12.2024 01:00	104	Powell N.	LAC	29	3	2	2200	10	20	0	0	4	8	5	7	13	0	3	4	2	4	0	0	0
24.12.2024 01:00	105	Harden J.	LAC	21	8	9	2148	6	16	0	0	1	6	8	10	-2	2	6	4	1	4	0	0	0
24.12.2024 01:00	106	Zubac I.	LAC	20	20	1	2379	10	18	0	0	0	0	0	1	17	9	11	3	3	1	1	0	0
24.12.2024 01:00	107	Jones D.	LAC	13	2	0	1308	5	11	0	0	0	2	3	3	4	2	0	3	2	0	1	0	0
24.12.2024 01:00	108	Porter K.	LAC	13	6	4	1221	5	14	0	0	1	3	2	2	1	1	5	4	2	3	0	0	0
24.12.2024 01:00	109	Dunn K.	LAC	7	4	2	1622	3	9	0	0	1	3	0	0	5	1	3	2	3	1	0	0	1
24.12.2024 01:00	110	Batum N.	LAC	6	5	4	1653	2	2	0	0	2	2	0	0	-2	0	5	2	1	2	1	0	0
24.12.2024 01:00	111	Coffey A.	LAC	5	5	0	1497	1	5	0	0	0	2	3	3	-2	0	5	2	0	1	0	0	0
24.12.2024 01:00	112	Bamba M.	LAC	0	1	0	372	0	1	0	0	0	1	0	0	-14	0	1	4	0	1	3	0	0
22.12.2024 01:30	113	Powell N.	LAC	28	5	2	2495	8	22	0	0	3	11	9	10	-12	1	4	3	1	1	1	0	0
22.12.2024 01:30	114	Harden J.	LAC	19	8	3	2213	6	18	0	0	2	9	5	5	-4	0	8	2	1	7	1	0	0
22.12.2024 01:30	115	Porter K.	LAC	19	2	3	1643	8	12	0	0	2	4	1	2	-16	1	1	3	1	4	0	0	0
22.12.2024 01:30	116	Zubac I.	LAC	13	15	3	2032	6	10	0	0	0	0	1	2	-2	4	11	2	1	2	1	0	0
22.12.2024 01:30	117	Dunn K.	LAC	9	3	3	2010	3	7	0	0	3	6	0	0	-8	1	2	1	2	1	1	0	0
22.12.2024 01:30	118	Jones D.	LAC	4	4	1	1046	2	6	0	0	0	4	0	0	-3	0	4	1	1	1	2	0	0
22.12.2024 01:30	119	Batum N.	LAC	3	0	2	892	0	0	0	0	0	0	3	3	-8	0	0	1	1	0	0	0	0
22.12.2024 01:30	120	Bamba M.	LAC	2	2	0	613	1	5	0	0	0	2	0	0	-10	1	1	0	0	1	1	0	0
22.12.2024 01:30	121	Coffey A.	LAC	0	1	1	1296	0	1	0	0	0	1	0	0	-9	0	1	1	0	0	0	0	1
22.12.2024 01:30	122	Jones K.	LAC	0	0	0	80	0	0	0	0	0	0	0	0	-4	0	0	0	0	0	0	0	0
22.12.2024 01:30	123	Miller J.	LAC	0	0	0	80	0	0	0	0	0	0	0	0	-4	0	0	0	0	0	0	0	0
20.12.2024 01:30	124	Powell N.	LAC	29	7	5	2254	10	19	0	0	4	8	5	5	17	1	6	2	3	2	0	0	0
20.12.2024 01:30	125	Harden J.	LAC	24	4	7	2146	6	14	0	0	2	5	10	10	19	1	3	2	1	6	0	0	0
20.12.2024 01:30	126	Zubac I.	LAC	21	15	5	1999	10	13	0	0	0	0	1	2	15	3	12	2	2	1	0	0	0
20.12.2024 01:30	127	Coffey A.	LAC	16	3	0	1494	7	10	0	0	2	4	0	0	10	0	3	3	0	1	0	0	0
20.12.2024 01:30	128	Porter K.	LAC	12	4	0	1184	5	11	0	0	2	4	0	0	4	0	4	2	0	2	0	0	0
20.12.2024 01:30	129	Jones D.	LAC	8	1	1	1211	3	4	0	0	2	2	0	0	14	0	1	2	1	0	1	0	0
20.12.2024 01:30	130	Batum N.	LAC	3	4	3	1373	1	5	0	0	1	5	0	0	5	1	3	2	0	0	1	0	0
20.12.2024 01:30	131	Dunn K.	LAC	3	1	6	1506	1	5	0	0	1	3	0	0	11	0	1	3	1	1	0	0	0
20.12.2024 01:30	132	Bamba M.	LAC	2	7	2	881	1	4	0	0	0	2	0	0	8	2	5	2	0	0	1	0	0
20.12.2024 01:30	133	Jones K.	LAC	0	1	1	176	0	0	0	0	0	0	0	0	6	0	1	0	0	0	0	0	0
20.12.2024 01:30	134	Miller J.	LAC	0	0	0	176	0	0	0	0	0	0	0	0	6	0	0	0	1	0	0	0	0
\.


--
-- Data for Name: los_angeles_clippers_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.los_angeles_clippers_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Tucker P. J.	Lesionado	2025-01-16 10:45:10.832192
\.


--
-- Data for Name: los_angeles_lakers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.los_angeles_lakers (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	13.07.2024	Los Angeles Lakers	80	Houston Rockets	99	26	19	16	19	26	28	26	19
2	16.07.2024	Los Angeles Lakers	74	Boston Celtics	88	17	17	15	25	19	31	15	23
3	18.07.2024	Atlanta Hawks	86	Los Angeles Lakers	87	20	21	31	14	21	23	19	24
4	19.07.2024	Cleveland Cavaliers	89	Los Angeles Lakers	93	20	30	22	17	24	22	22	25
5	21.07.2024	Los Angeles Lakers	107	Chicago Bulls	81	39	17	16	35	18	18	22	23
6	05.10.2024	Los Angeles Lakers	107	Minnesota Timberwolves	124	23	26	39	19	36	22	37	29
7	07.10.2024	Los Angeles Lakers	114	Phoenix Suns	118	34	35	23	22	25	32	28	33
8	11.10.2024	Milwaukee Bucks	102	Los Angeles Lakers	107	23	35	24	20	26	26	22	33
9	16.10.2024	Los Angeles Lakers	97	Golden State Warriors	111	28	23	19	27	31	27	25	28
10	18.10.2024\nApós Prol.	Phoenix Suns	122	Los Angeles Lakers	128	30	37	23	23	35	27	20	31
11	19.10.2024	Golden State Warriors	132	Los Angeles Lakers	74	36	30	38	28	18	22	22	12
12	23.10.2024	Los Angeles Lakers	110	Minnesota Timberwolves	103	22	33	27	28	23	19	32	29
13	26.10.2024	Los Angeles Lakers	123	Phoenix Suns	116	23	29	35	36	38	23	24	31
14	27.10.2024	Los Angeles Lakers	131	Sacramento Kings	127	28	36	23	44	26	34	34	33
15	29.10.2024	Phoenix Suns	109	Los Angeles Lakers	105	25	25	26	33	34	14	35	22
16	30.10.2024	Cleveland Cavaliers	134	Los Angeles Lakers	110	42	25	32	35	23	25	31	31
17	01.11.2024	Toronto Raptors	125	Los Angeles Lakers	131	19	32	37	37	43	33	23	32
18	05.11.2024	Detroit Pistons	115	Los Angeles Lakers	103	33	34	16	32	22	31	24	26
19	07.11.2024	Memphis Grizzlies	131	Los Angeles Lakers	114	35	24	36	36	27	26	28	33
20	09.11.2024	Los Angeles Lakers	116	Philadelphia 76ers	106	36	32	28	20	29	31	21	25
21	11.11.2024	Los Angeles Lakers	123	Toronto Raptors	103	26	27	35	35	34	21	27	21
22	14.11.2024	Los Angeles Lakers	128	Memphis Grizzlies	123	38	27	26	37	26	38	32	27
23	16.11.2024	San Antonio Spurs	115	Los Angeles Lakers	120	30	30	26	29	31	37	25	27
24	17.11.2024	New Orleans Pelicans	99	Los Angeles Lakers	104	30	26	15	28	21	25	29	29
25	20.11.2024	Los Angeles Lakers	124	Utah Jazz	118	34	23	40	27	22	22	31	43
26	22.11.2024	Los Angeles Lakers	118	Orlando Magic	119	38	29	21	30	36	24	29	30
27	24.11.2024	Los Angeles Lakers	102	Denver Nuggets	127	27	36	15	24	31	26	37	33
28	27.11.2024	Phoenix Suns	127	Los Angeles Lakers	100	31	31	36	29	25	35	18	22
29	28.11.2024	San Antonio Spurs	101	Los Angeles Lakers	119	23	24	30	24	32	26	34	27
30	30.11.2024	Los Angeles Lakers	93	Oklahoma City Thunder	101	24	24	21	24	32	19	20	30
31	02.12.2024	Utah Jazz	104	Los Angeles Lakers	105	27	29	25	23	26	32	28	19
32	03.12.2024	Minnesota Timberwolves	109	Los Angeles Lakers	80	22	34	23	30	20	24	20	16
33	05.12.2024	Miami Heat	134	Los Angeles Lakers	93	34	35	36	29	26	26	20	21
34	07.12.2024\nApós Prol.	Atlanta Hawks	134	Los Angeles Lakers	132	26	38	30	25	29	35	33	22
35	09.12.2024	Los Angeles Lakers	107	Portland Trail Blazers	98	22	37	18	30	28	17	29	24
36	14.12.2024	Minnesota Timberwolves	97	Los Angeles Lakers	87	32	18	27	20	23	21	22	21
37	16.12.2024	Los Angeles Lakers	116	Memphis Grizzlies	110	30	34	22	30	20	26	31	33
38	20.12.2024	Sacramento Kings	100	Los Angeles Lakers	113	28	30	22	20	37	25	24	27
39	21.12.2024	Sacramento Kings	99	Los Angeles Lakers	103	26	27	24	22	31	25	25	22
40	24.12.2024	Los Angeles Lakers	114	Detroit Pistons	117	32	32	28	22	34	28	31	24
41	26.12.2024	Golden State Warriors	113	Los Angeles Lakers	115	23	29	24	37	23	32	29	31
42	29.12.2024	Los Angeles Lakers	132	Sacramento Kings	122	40	25	42	25	31	35	24	32
43	01.01. 02:00	Los Angeles Lakers	110	Cleveland Cavaliers	122	30	23	25	32	34	24	29	35
44	03.01. 03:30	Los Angeles Lakers	114	Portland Trail Blazers	106	27	33	28	26	31	20	24	31
45	04.01. 03:30	Los Angeles Lakers	119	Atlanta Hawks	102	31	34	31	23	28	29	29	16
46	06.01. 00:00	Houston Rockets	119	Los Angeles Lakers	115	36	31	24	28	22	27	40	26
47	08.01. 00:30	Dallas Mavericks	118	Los Angeles Lakers	97	24	31	34	29	27	23	26	21
48	14.01. 03:30	Los Angeles Lakers	102	San Antonio Spurs	126	26	36	27	13	28	25	36	37
49	16.01. 03:00	Los Angeles Lakers	117	Miami Heat	108	34	20	29	34	38	28	19	23
\.


--
-- Data for Name: los_angeles_lakers_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.los_angeles_lakers_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 03:00	1	Hachimura R.	LAL	23	8	1	1996	9	15	0	0	2	5	3	4	10	2	6	2	1	2	0	0	0
16.01.2025 03:00	2	Davis A.	LAL	22	11	4	2198	10	21	0	0	1	3	1	2	7	2	9	0	2	1	2	0	0
16.01.2025 03:00	3	James L.	LAL	22	5	9	2289	9	15	0	0	3	6	1	2	14	1	4	0	2	2	0	0	0
16.01.2025 03:00	4	Christie M.	LAL	16	3	0	2227	6	12	0	0	3	7	1	2	10	0	3	0	2	0	1	0	0
16.01.2025 03:00	5	Reaves A.	LAL	14	3	14	2114	5	9	0	0	2	3	2	2	14	0	3	4	3	1	0	0	0
16.01.2025 03:00	6	Vincent G.	LAL	14	1	4	1556	6	9	0	0	2	5	0	0	0	0	1	3	1	0	1	0	0
16.01.2025 03:00	7	Hayes J.	LAL	4	1	0	851	2	3	0	0	0	0	0	0	2	1	0	1	1	0	0	0	0
16.01.2025 03:00	8	Knecht D.	LAL	2	2	1	828	0	4	0	0	0	4	2	2	-4	0	2	1	0	0	0	0	0
16.01.2025 03:00	9	Milton S.	LAL	0	0	0	341	0	2	0	0	0	1	0	0	-8	0	0	1	0	0	0	0	0
14.01.2025 03:30	10	Davis A.	LAL	30	13	2	1943	13	18	0	0	2	5	2	4	-21	8	5	4	2	2	2	0	0
14.01.2025 03:30	11	James L.	LAL	18	5	8	1926	7	11	0	0	2	3	2	4	-15	1	4	3	1	7	1	0	0
14.01.2025 03:30	12	Reaves A.	LAL	12	5	8	2009	4	13	0	0	2	7	2	2	-18	1	4	3	0	4	0	0	0
14.01.2025 03:30	13	Christie M.	LAL	10	1	1	1854	4	11	0	0	2	8	0	1	-13	0	1	0	0	1	0	0	0
14.01.2025 03:30	14	Hachimura R.	LAL	9	3	1	1774	3	6	0	0	3	4	0	0	-16	0	3	1	2	1	0	0	0
14.01.2025 03:30	15	Vincent G.	LAL	7	2	1	1042	3	6	0	0	1	3	0	0	-3	1	1	1	1	3	0	0	0
14.01.2025 03:30	16	Knecht D.	LAL	5	3	1	829	1	5	0	0	0	4	3	3	-1	0	3	1	1	0	0	0	0
14.01.2025 03:30	17	Finney-Smith D.	LAL	4	3	0	1210	1	4	0	0	1	3	1	2	-13	1	2	1	2	1	0	0	0
14.01.2025 03:30	18	Hayes J.	LAL	4	1	1	765	2	4	0	0	0	1	0	0	-4	1	0	2	0	0	1	0	0
14.01.2025 03:30	19	Reddish C.	LAL	3	4	0	922	1	7	0	0	1	4	0	0	-11	2	2	1	0	0	0	0	0
14.01.2025 03:30	20	Olivari Q.	LAL	0	0	1	126	0	2	0	0	0	2	0	0	-5	0	0	0	0	0	0	0	0
08.01.2025 00:30	21	Davis A.	LAL	21	12	3	2115	7	18	0	0	0	2	7	9	-19	2	10	1	0	2	2	0	0
08.01.2025 00:30	22	James L.	LAL	18	10	8	2092	6	12	0	0	1	4	5	6	-12	0	10	0	1	2	0	0	0
08.01.2025 00:30	23	Reaves A.	LAL	15	2	1	1925	5	14	0	0	4	11	1	2	-25	0	2	1	3	1	0	0	0
08.01.2025 00:30	24	Knecht D.	LAL	13	0	0	958	5	8	0	0	2	5	1	2	-8	0	0	1	0	1	1	0	0
08.01.2025 00:30	25	Christie M.	LAL	12	1	3	1823	5	9	0	0	1	4	1	1	-22	1	0	2	1	2	1	0	0
08.01.2025 00:30	26	Finney-Smith D.	LAL	11	3	0	1708	3	4	0	0	3	4	2	2	3	0	3	1	0	1	0	0	0
08.01.2025 00:30	27	Hachimura R.	LAL	6	1	2	1551	3	5	0	0	0	2	0	0	-8	1	0	2	1	1	0	0	0
08.01.2025 00:30	28	Hayes J.	LAL	1	3	1	699	0	1	0	0	0	0	1	2	-5	1	2	4	1	0	2	0	0
08.01.2025 00:30	29	James Jr. B.	LAL	0	0	0	86	0	0	0	0	0	0	0	0	-4	0	0	0	0	0	0	0	0
08.01.2025 00:30	30	Vincent G.	LAL	0	1	2	1443	0	4	0	0	0	3	0	0	-5	0	1	1	0	0	0	0	0
06.01.2025 00:00	31	Davis A.	LAL	30	13	2	2308	10	18	0	0	2	4	8	8	7	4	9	5	0	4	5	0	0
06.01.2025 00:00	32	James L.	LAL	21	13	9	2163	8	16	0	0	4	7	1	2	-13	1	12	4	1	2	0	0	0
06.01.2025 00:00	33	Reaves A.	LAL	21	0	10	2479	6	13	0	0	3	6	6	7	12	0	0	2	0	0	0	0	0
06.01.2025 00:00	34	Christie M.	LAL	14	6	2	2325	4	8	0	0	2	5	4	4	14	1	5	2	1	1	0	0	0
06.01.2025 00:00	35	Finney-Smith D.	LAL	13	2	2	1552	5	9	0	0	2	6	1	1	-6	1	1	3	2	0	0	0	0
06.01.2025 00:00	36	Hachimura R.	LAL	13	1	0	1681	5	9	0	0	3	6	0	2	4	1	0	2	0	1	0	0	0
06.01.2025 00:00	37	Hayes J.	LAL	2	2	1	356	0	2	0	0	0	0	2	2	-7	1	1	2	0	0	0	0	0
06.01.2025 00:00	38	Milton S.	LAL	1	1	0	298	0	0	0	0	0	0	1	2	-16	1	0	0	0	2	0	0	0
06.01.2025 00:00	39	Knecht D.	LAL	0	1	0	1022	0	3	0	0	0	2	0	0	-3	0	1	0	0	0	0	0	0
06.01.2025 00:00	40	Reddish C.	LAL	0	0	0	216	0	0	0	0	0	0	0	0	-12	0	0	1	0	0	0	0	0
04.01.2025 03:30	41	James L.	LAL	30	3	8	1800	13	20	0	0	2	5	2	2	4	0	3	3	0	3	0	0	0
04.01.2025 03:30	42	Reaves A.	LAL	20	7	6	2319	6	18	0	0	3	7	5	6	18	4	3	1	0	6	0	0	0
04.01.2025 03:30	43	Davis A.	LAL	18	19	4	2238	6	17	0	0	0	2	6	7	17	4	15	2	3	4	3	0	0
04.01.2025 03:30	44	Hachimura R.	LAL	13	8	1	1469	6	9	0	0	1	3	0	1	10	3	5	2	0	1	1	0	0
04.01.2025 03:30	45	Knecht D.	LAL	13	4	1	897	4	7	0	0	3	4	2	2	6	1	3	2	1	1	0	0	0
04.01.2025 03:30	46	Christie M.	LAL	9	4	2	1951	3	4	0	0	1	2	2	3	14	1	3	4	0	2	1	0	0
04.01.2025 03:30	47	Finney-Smith D.	LAL	8	5	0	1404	3	5	0	0	2	3	0	0	12	3	2	5	0	0	0	0	0
04.01.2025 03:30	48	Hayes J.	LAL	3	1	0	642	1	2	0	0	0	0	1	2	0	0	1	0	0	0	0	0	0
04.01.2025 03:30	49	Reddish C.	LAL	3	1	1	770	1	2	0	0	1	2	0	0	1	1	0	1	0	0	0	0	0
04.01.2025 03:30	50	Milton S.	LAL	2	4	4	809	0	3	0	0	0	2	2	2	1	0	4	1	0	1	1	0	0
04.01.2025 03:30	51	James Jr. B.	LAL	0	0	1	101	0	1	0	0	0	0	0	0	2	0	0	0	0	0	0	0	0
03.01.2025 03:30	52	James L.	LAL	38	3	8	2172	15	25	0	0	7	10	1	2	4	1	2	1	0	4	0	0	0
03.01.2025 03:30	53	Christie M.	LAL	28	3	2	1895	9	16	0	0	5	9	5	5	8	0	3	0	2	0	1	0	0
03.01.2025 03:30	54	Reaves A.	LAL	15	8	11	2186	5	15	0	0	2	9	3	3	10	2	6	3	2	3	0	0	0
03.01.2025 03:30	55	Koloko C. J.	LAL	8	8	3	1110	4	8	0	0	0	0	0	0	8	6	2	2	1	0	0	0	0
03.01.2025 03:30	56	Hachimura R.	LAL	6	4	3	1404	2	6	0	0	0	4	2	2	-3	1	3	1	0	2	0	0	0
03.01.2025 03:30	57	Knecht D.	LAL	6	1	0	1015	2	6	0	0	0	3	2	2	-3	1	0	4	0	1	0	0	0
03.01.2025 03:30	58	Hayes J.	LAL	4	6	0	1071	2	4	0	0	0	0	0	0	5	2	4	3	1	1	1	0	0
03.01.2025 03:30	59	Milton S.	LAL	4	3	0	979	2	5	0	0	0	3	0	0	2	0	3	0	0	0	0	0	0
03.01.2025 03:30	60	Finney-Smith D.	LAL	3	4	2	1440	1	6	0	0	1	4	0	0	11	2	2	3	1	1	0	0	0
03.01.2025 03:30	61	Reddish C.	LAL	2	3	1	1128	1	3	0	0	0	1	0	0	-2	0	3	0	1	0	1	0	0
01.01.2025 02:00	62	Reaves A.	LAL	35	9	10	2277	11	20	0	0	1	4	12	13	-3	1	8	2	1	4	0	0	0
01.01.2025 02:00	63	Davis A.	LAL	28	13	4	2224	12	23	0	0	2	4	2	2	-6	1	12	2	3	1	2	0	0
01.01.2025 02:00	64	James L.	LAL	23	4	7	2052	9	17	0	0	3	6	2	2	-11	0	4	1	0	2	1	0	0
01.01.2025 02:00	65	Hachimura R.	LAL	7	5	0	1823	3	10	0	0	0	3	1	2	-17	3	2	1	1	1	0	0	0
01.01.2025 02:00	66	Milton S.	LAL	6	2	0	605	2	4	0	0	2	4	0	0	-9	0	2	1	0	0	0	0	0
01.01.2025 02:00	67	Christie M.	LAL	5	1	2	1703	2	6	0	0	1	5	0	0	-17	0	1	3	1	0	0	0	0
01.01.2025 02:00	68	Knecht D.	LAL	4	3	1	1329	2	8	0	0	0	5	0	0	-3	1	2	0	0	0	0	0	0
01.01.2025 02:00	69	Finney-Smith D.	LAL	2	2	2	1224	1	4	0	0	0	2	0	0	7	2	0	2	0	0	0	0	0
01.01.2025 02:00	70	Reddish C.	LAL	0	4	0	1163	0	3	0	0	0	2	0	0	-1	0	4	0	1	0	0	0	0
29.12.2024 03:30	71	Davis A.	LAL	36	15	8	2335	12	16	0	0	1	1	11	13	21	2	13	2	0	2	0	0	0
29.12.2024 03:30	72	Reaves A.	LAL	26	6	16	2556	9	16	0	0	3	4	5	8	15	1	5	3	0	5	0	0	0
29.12.2024 03:30	73	Hachimura R.	LAL	21	4	0	2054	7	11	0	0	4	5	3	3	-1	0	4	1	1	1	2	0	0
29.12.2024 03:30	74	Knecht D.	LAL	18	2	1	1973	6	10	0	0	2	5	4	4	9	0	2	0	0	0	0	0	0
29.12.2024 03:30	75	Christie M.	LAL	16	1	2	1930	5	8	0	0	3	5	3	3	-7	0	1	5	2	0	1	0	0
29.12.2024 03:30	76	Russell D.	LAL	9	2	4	1695	4	10	0	0	1	4	0	0	4	0	2	1	0	1	0	0	0
29.12.2024 03:30	77	Koloko C. J.	LAL	4	1	0	287	2	2	0	0	0	0	0	0	-4	1	0	1	0	1	0	0	0
29.12.2024 03:30	78	Reddish C.	LAL	2	1	2	1155	1	3	0	0	0	1	0	2	4	0	1	0	1	0	0	0	0
29.12.2024 03:30	79	Vincent G.	LAL	0	1	0	415	0	1	0	0	0	1	0	0	9	0	1	0	0	1	0	0	0
26.12.2024 01:00	80	James L.	LAL	31	4	10	2218	12	22	0	0	2	4	5	5	4	0	4	3	2	1	1	0	0
26.12.2024 01:00	81	Reaves A.	LAL	26	10	10	2200	8	20	0	0	4	10	6	6	-4	2	8	0	1	3	0	0	0
26.12.2024 01:00	82	Hachimura R.	LAL	18	4	1	2346	6	12	0	0	5	7	1	1	-5	1	3	4	0	1	1	0	0
26.12.2024 01:00	83	Christie M.	LAL	16	4	2	2041	5	13	0	0	2	8	4	4	-8	0	4	2	0	1	0	0	0
26.12.2024 01:00	84	Knecht D.	LAL	13	7	2	1518	5	9	0	0	1	5	2	2	13	2	5	0	0	0	1	0	0
26.12.2024 01:00	85	Vincent G.	LAL	5	3	3	1761	2	7	0	0	1	6	0	0	3	0	3	3	0	1	0	0	0
26.12.2024 01:00	86	Reddish C.	LAL	4	1	2	1350	2	4	0	0	0	2	0	0	7	1	0	2	2	1	0	0	0
26.12.2024 01:00	87	Koloko C. J.	LAL	2	6	0	534	1	1	0	0	0	0	0	0	7	4	2	0	0	1	1	0	0
26.12.2024 01:00	88	Davis A.	LAL	0	2	0	432	0	3	0	0	0	0	0	0	-7	1	1	0	1	0	0	0	0
24.12.2024 03:30	89	James L.	LAL	28	11	11	2126	10	16	0	0	2	4	6	7	-1	2	9	1	0	2	0	0	0
24.12.2024 03:30	90	Davis A.	LAL	19	10	6	2316	7	14	0	0	1	3	4	8	15	3	7	1	2	3	2	0	1
24.12.2024 03:30	91	Christie M.	LAL	17	1	0	1994	6	10	0	0	3	4	2	2	10	0	1	1	2	1	0	0	0
24.12.2024 03:30	92	Reaves A.	LAL	12	7	2	2213	5	9	0	0	2	5	0	0	16	0	7	2	2	6	0	0	0
24.12.2024 03:30	93	Hachimura R.	LAL	10	1	1	1718	3	8	0	0	0	2	4	4	-5	0	1	1	1	1	0	0	0
24.12.2024 03:30	94	Vincent G.	LAL	9	2	1	1128	3	5	0	0	3	5	0	0	-22	0	2	1	0	2	0	0	0
24.12.2024 03:30	95	Knecht D.	LAL	7	2	1	943	2	4	0	0	1	2	2	2	-10	1	1	1	0	0	0	0	0
24.12.2024 03:30	96	Reddish C.	LAL	7	4	1	1031	3	3	0	0	1	1	0	0	-5	0	4	1	1	1	1	0	0
24.12.2024 03:30	97	Russell D.	LAL	5	0	5	931	1	5	0	0	1	4	2	2	-13	0	0	1	0	2	0	0	0
21.12.2024 23:00	98	James L.	LAL	32	7	6	2065	13	24	0	0	1	8	5	6	10	0	7	2	4	4	0	0	0
21.12.2024 23:00	99	Russell D.	LAL	20	4	5	1822	7	13	0	0	3	7	3	4	1	0	4	2	0	1	0	0	0
21.12.2024 23:00	100	Reaves A.	LAL	16	4	5	2156	6	14	0	0	1	7	3	5	10	2	2	1	0	2	0	0	1
21.12.2024 23:00	101	Davis A.	LAL	10	15	5	2239	4	10	0	0	0	0	2	4	-2	2	13	2	0	5	3	0	0
21.12.2024 23:00	102	Hachimura R.	LAL	9	11	1	2303	4	8	0	0	1	5	0	0	10	3	8	2	1	0	1	0	0
21.12.2024 23:00	103	Vincent G.	LAL	6	0	0	955	2	3	0	0	2	3	0	0	-4	0	0	2	1	0	0	0	0
21.12.2024 23:00	104	Christie M.	LAL	5	3	0	1059	2	4	0	0	1	2	0	0	3	0	3	1	2	0	0	0	0
21.12.2024 23:00	105	Reddish C.	LAL	5	4	0	1300	2	7	0	0	0	3	1	2	0	2	2	1	2	0	2	0	0
21.12.2024 23:00	106	Knecht D.	LAL	0	0	1	299	0	0	0	0	0	0	0	0	-6	0	0	0	0	1	0	0	0
21.12.2024 23:00	107	Koloko C. J.	LAL	0	0	0	203	0	0	0	0	0	0	0	0	-2	0	0	1	0	0	0	0	0
20.12.2024 03:00	108	Reaves A.	LAL	25	6	5	2095	7	14	0	0	3	7	8	9	9	0	6	0	2	1	0	0	0
20.12.2024 03:00	109	Davis A.	LAL	21	18	4	2120	7	19	0	0	0	1	7	9	19	6	12	0	3	3	6	0	0
20.12.2024 03:00	110	James L.	LAL	19	6	7	2045	8	21	0	0	1	4	2	2	13	0	6	1	0	2	1	0	0
20.12.2024 03:00	111	Russell D.	LAL	16	6	1	1371	7	15	0	0	2	6	0	0	1	1	5	2	1	0	1	0	0
20.12.2024 03:00	112	Vincent G.	LAL	12	5	3	1346	4	5	0	0	4	5	0	0	4	2	3	4	0	0	0	0	0
20.12.2024 03:00	113	Hachimura R.	LAL	10	5	2	2194	3	9	0	0	1	4	3	4	21	1	4	1	0	4	1	0	0
20.12.2024 03:00	114	Christie M.	LAL	8	4	0	1683	1	3	0	0	1	3	5	6	17	3	1	2	2	0	0	0	0
20.12.2024 03:00	115	Knecht D.	LAL	2	1	0	611	1	4	0	0	0	2	0	0	-4	0	1	1	0	0	0	0	0
20.12.2024 03:00	116	Koloko C. J.	LAL	0	1	0	250	0	2	0	0	0	0	0	0	-6	0	1	1	0	0	1	0	0
20.12.2024 03:00	117	Reddish C.	LAL	0	0	0	685	0	1	0	0	0	1	0	0	-9	0	0	4	0	0	0	0	0
\.


--
-- Data for Name: los_angeles_lakers_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.los_angeles_lakers_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Hood-Schifino Jalen	Lesionado	2025-01-16 10:45:23.578139
2	James Jr. Bronny	Lesionado	2025-01-16 10:45:23.580255
3	Davis Anthony	Lesionado	2025-01-16 10:45:23.581846
4	James LeBron	Lesionado	2025-01-16 10:45:23.583779
5	Vanderbilt Jarred	Lesionado	2025-01-16 10:45:23.586028
6	Wood Christian	Lesionado	2025-01-16 10:45:23.588298
\.


--
-- Data for Name: memphis_grizzlies; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.memphis_grizzlies (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	18.07.2024	Orlando Magic	98	Memphis Grizzlies	104	24	16	34	24	33	24	18	29
2	18.07.2024	New Orleans Pelicans	77	Memphis Grizzlies	88	25	18	16	18	25	18	23	22
3	21.07.2024	Memphis Grizzlies	99	Los Angeles Clippers	98	25	24	24	26	19	35	13	31
4	23.07.2024\nApós Prol.	Miami Heat	120	Memphis Grizzlies	118	24	30	33	26	25	32	37	19
5	08.10.2024	Dallas Mavericks	116	Memphis Grizzlies	121	29	31	30	26	32	28	33	28
6	11.10.2024	Memphis Grizzlies	94	Charlotte Hornets	119	32	17	22	23	35	27	20	37
7	13.10.2024	Chicago Bulls	121	Memphis Grizzlies	124	28	37	28	28	28	23	40	33
8	15.10.2024	Indiana Pacers	116	Memphis Grizzlies	120	17	32	29	38	31	29	31	29
9	19.10.2024	Memphis Grizzlies	109	Miami Heat	114	24	38	29	18	28	32	25	29
10	24.10.2024	Utah Jazz	124	Memphis Grizzlies	126	23	27	36	38	29	32	32	33
11	26.10.2024	Houston Rockets	128	Memphis Grizzlies	108	38	21	39	30	38	27	18	25
12	27.10.2024	Memphis Grizzlies	124	Orlando Magic	111	34	35	21	34	24	19	35	33
13	29.10.2024	Memphis Grizzlies	123	Chicago Bulls	126	32	36	32	23	22	32	39	33
14	31.10.2024	Memphis Grizzlies	106	Brooklyn Nets	119	29	33	28	16	34	33	24	28
15	01.11.2024	Memphis Grizzlies	122	Milwaukee Bucks	99	40	30	29	23	24	24	22	29
16	02.11.2024	Philadelphia 76ers	107	Memphis Grizzlies	124	28	24	23	32	24	35	33	32
17	05.11.2024	Brooklyn Nets	106	Memphis Grizzlies	104	23	27	33	23	30	19	30	25
18	07.11.2024	Memphis Grizzlies	131	Los Angeles Lakers	114	35	24	36	36	27	26	28	33
19	09.11.2024	Memphis Grizzlies	128	Washington Wizards	104	34	32	32	30	24	25	22	33
20	11.11.2024	Portland Trail Blazers	89	Memphis Grizzlies	134	17	27	24	21	31	33	42	28
21	14.11.2024	Los Angeles Lakers	128	Memphis Grizzlies	123	38	27	26	37	26	38	32	27
22	16.11.2024	Golden State Warriors	123	Memphis Grizzlies	118	29	26	38	30	28	20	30	40
23	17.11.2024	Memphis Grizzlies	105	Denver Nuggets	90	28	27	29	21	25	18	21	26
24	20.11.2024	Memphis Grizzlies	110	Denver Nuggets	122	24	33	21	32	31	37	24	30
25	21.11.2024	Memphis Grizzlies	117	Philadelphia 76ers	111	31	32	27	27	31	22	28	30
26	24.11.2024	Chicago Bulls	131	Memphis Grizzlies	142	22	38	38	33	30	34	45	33
27	26.11.2024	Memphis Grizzlies	123	Portland Trail Blazers	98	36	29	27	31	24	30	21	23
28	28.11.2024	Memphis Grizzlies	131	Detroit Pistons	111	34	37	33	27	35	18	24	34
29	29.11.2024	Memphis Grizzlies	120	New Orleans Pelicans	109	32	35	25	28	28	28	26	27
30	01.12.2024	Memphis Grizzlies	136	Indiana Pacers	121	28	34	40	34	45	23	23	30
31	04.12.2024	Dallas Mavericks	121	Memphis Grizzlies	116	25	35	22	39	26	31	38	21
32	06.12.2024	Memphis Grizzlies	115	Sacramento Kings	110	33	30	23	29	32	30	24	24
33	08.12.2024	Boston Celtics	121	Memphis Grizzlies	127	27	27	35	32	31	35	28	33
34	09.12.2024	Washington Wizards	112	Memphis Grizzlies	140	26	29	27	30	34	38	39	29
35	14.12.2024	Memphis Grizzlies	135	Brooklyn Nets	119	39	30	38	28	36	20	39	24
36	16.12.2024	Los Angeles Lakers	116	Memphis Grizzlies	110	30	34	22	30	20	26	31	33
37	20.12.2024	Memphis Grizzlies	144	Golden State Warriors	93	37	32	40	35	15	23	21	34
38	22.12.2024	Atlanta Hawks	112	Memphis Grizzlies	128	27	22	27	36	43	30	27	28
39	24.12.2024	Memphis Grizzlies	110	Los Angeles Clippers	114	30	28	32	20	28	23	40	23
40	27.12.2024	Memphis Grizzlies	155	Toronto Raptors	126	43	35	43	34	35	35	30	26
41	28.12.2024	New Orleans Pelicans	124	Memphis Grizzlies	132	25	36	27	36	32	42	30	28
42	30.12.2024	Oklahoma City Thunder	130	Memphis Grizzlies	106	34	42	26	28	31	19	24	32
43	01.01. 02:00	Phoenix Suns	112	Memphis Grizzlies	117	26	29	31	26	36	33	22	26
44	04.01. 03:00	Sacramento Kings	138	Memphis Grizzlies	133	46	32	24	36	32	40	28	33
45	05.01. 01:30	Golden State Warriors	121	Memphis Grizzlies	113	30	28	34	29	29	25	32	27
46	07.01. 01:00	Memphis Grizzlies	119	Dallas Mavericks	104	26	30	31	32	36	19	25	24
47	10.01. 01:00	Memphis Grizzlies	115	Houston Rockets	119	36	27	29	23	45	23	33	18
48	12.01. 01:00	Minnesota Timberwolves	125	Memphis Grizzlies	127	33	32	38	22	35	29	35	28
49	14.01. 01:00	Houston Rockets	120	Memphis Grizzlies	118	23	34	30	33	30	30	32	26
50	16.01. 01:00	San Antonio Spurs	115	Memphis Grizzlies	129	30	33	25	27	28	23	43	35
\.


--
-- Data for Name: memphis_grizzlies_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.memphis_grizzlies_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 01:00	1	Bane D.	MEM	21	3	2	1974	8	13	0	0	2	4	3	3	9	2	1	2	2	0	1	0	0
16.01.2025 01:00	2	Morant J.	MEM	21	4	12	1884	9	13	0	0	1	2	2	2	22	0	4	3	2	2	0	0	0
16.01.2025 01:00	3	Aldama S.	MEM	20	10	2	1593	9	15	0	0	1	3	1	2	20	3	7	1	0	0	0	0	0
16.01.2025 01:00	4	Jackson J.	MEM	19	6	2	1856	8	24	0	0	2	8	1	2	1	2	4	4	0	2	2	0	0
16.01.2025 01:00	5	Kennard L.	MEM	15	9	3	1789	5	9	0	0	5	9	0	0	15	1	8	1	0	1	0	0	0
16.01.2025 01:00	6	Huff J.	MEM	11	1	0	651	4	6	0	0	3	5	0	0	-1	0	1	1	0	0	1	0	1
16.01.2025 01:00	7	Edey Z.	MEM	6	5	0	992	3	6	0	0	0	0	0	0	0	2	3	1	1	2	0	0	0
16.01.2025 01:00	8	Clarke B.	MEM	5	5	2	639	2	4	0	0	0	0	1	2	10	1	4	0	1	1	1	0	0
16.01.2025 01:00	9	Wells J.	MEM	5	1	0	1283	1	7	0	0	1	5	2	2	5	0	1	3	0	0	0	0	0
16.01.2025 01:00	10	LaRavia J.	MEM	3	4	0	589	1	3	0	0	1	1	0	0	-12	2	2	2	0	0	0	0	0
16.01.2025 01:00	11	Pippen Jr S.	MEM	3	4	5	1150	1	3	0	0	0	1	1	4	1	1	3	1	1	0	0	0	0
14.01.2025 01:00	12	Morant J.	MEM	29	3	4	2228	11	24	0	0	4	11	3	6	11	0	3	2	4	7	0	0	0
14.01.2025 01:00	13	Bane D.	MEM	25	3	2	2045	9	13	0	0	4	5	3	3	-11	1	2	1	2	3	0	0	0
14.01.2025 01:00	14	Jackson J.	MEM	17	2	3	1805	6	12	0	0	1	3	4	6	-3	0	2	5	3	2	1	0	0
14.01.2025 01:00	15	Wells J.	MEM	14	0	0	1802	5	8	0	0	3	4	1	2	-3	0	0	2	2	0	0	0	0
14.01.2025 01:00	16	LaRavia J.	MEM	12	7	0	1262	5	7	0	0	2	3	0	0	-10	3	4	2	2	1	0	0	0
14.01.2025 01:00	17	Clarke B.	MEM	6	4	0	1462	2	5	0	0	0	0	2	2	-16	2	2	4	1	1	0	0	0
14.01.2025 01:00	18	Aldama S.	MEM	5	2	3	1076	2	5	0	0	0	2	1	2	4	0	2	1	2	0	0	0	0
14.01.2025 01:00	19	Kennard L.	MEM	4	1	2	618	2	4	0	0	0	1	0	0	10	1	0	0	0	1	0	0	0
14.01.2025 01:00	20	Pippen Jr S.	MEM	4	2	1	686	2	3	0	0	0	1	0	0	-3	0	2	2	0	0	0	0	0
14.01.2025 01:00	21	Edey Z.	MEM	2	7	0	1416	1	4	0	0	0	2	0	0	11	1	6	6	1	2	1	0	0
12.01.2025 01:00	22	Jackson J.	MEM	33	8	1	2036	13	24	0	0	2	5	5	7	6	4	4	3	1	2	0	0	0
12.01.2025 01:00	23	Bane D.	MEM	21	5	5	1907	8	14	0	0	4	8	1	1	4	0	5	2	2	3	0	0	0
12.01.2025 01:00	24	Wells J.	MEM	13	2	2	1871	4	13	0	0	3	9	2	3	0	1	1	0	3	0	0	0	0
12.01.2025 01:00	25	Morant J.	MEM	12	5	4	1805	5	19	0	0	0	4	2	2	1	2	3	4	1	5	0	0	0
12.01.2025 01:00	26	Aldama S.	MEM	11	1	1	969	4	7	0	0	3	4	0	0	-4	0	1	0	0	0	0	0	0
12.01.2025 01:00	27	Kennard L.	MEM	11	5	5	1320	3	8	0	0	2	4	3	3	-3	3	2	1	1	0	0	0	0
12.01.2025 01:00	28	Clarke B.	MEM	10	4	1	1116	5	6	0	0	0	0	0	0	16	2	2	3	0	0	1	0	0
12.01.2025 01:00	29	Edey Z.	MEM	8	9	2	1178	3	7	0	0	1	2	1	1	-8	7	2	3	0	1	1	0	0
12.01.2025 01:00	30	Pippen Jr S.	MEM	5	3	4	939	2	4	0	0	0	0	1	2	0	0	3	2	3	0	0	0	0
12.01.2025 01:00	31	LaRavia J.	MEM	3	2	0	798	1	3	0	0	1	2	0	0	4	1	1	2	1	1	0	0	0
12.01.2025 01:00	32	Huff J.	MEM	0	2	0	461	0	3	0	0	0	3	0	0	-6	1	1	0	1	1	1	0	0
10.01.2025 01:00	33	Morant J.	MEM	27	3	3	1748	9	22	0	0	1	5	8	11	-7	1	2	2	1	4	0	0	0
10.01.2025 01:00	34	Jackson J.	MEM	21	8	4	2043	9	15	0	0	1	4	2	3	6	2	6	2	2	3	6	0	1
10.01.2025 01:00	35	Bane D.	MEM	16	4	4	1646	6	10	0	0	2	5	2	3	-6	0	4	4	2	4	0	0	0
10.01.2025 01:00	36	Aldama S.	MEM	12	9	0	1393	4	12	0	0	2	6	2	5	-2	3	6	1	1	2	0	0	0
10.01.2025 01:00	37	Kennard L.	MEM	11	0	2	1500	4	7	0	0	3	5	0	0	13	0	0	0	0	0	0	0	0
10.01.2025 01:00	38	Clarke B.	MEM	8	4	1	1043	4	5	0	0	0	0	0	0	3	2	2	6	2	0	0	0	0
10.01.2025 01:00	39	Huff J.	MEM	8	2	1	604	2	3	0	0	0	1	4	4	-11	0	2	3	0	2	0	0	0
10.01.2025 01:00	40	Edey Z.	MEM	4	3	0	1056	1	1	0	0	1	1	1	2	-4	0	3	5	0	0	1	0	0
10.01.2025 01:00	41	LaRavia J.	MEM	4	5	2	1180	2	4	0	0	0	2	0	0	9	1	4	1	0	0	1	0	0
10.01.2025 01:00	42	Wells J.	MEM	4	3	1	1377	1	5	0	0	0	3	2	2	-20	1	2	1	0	2	0	0	0
10.01.2025 01:00	43	Pippen Jr S.	MEM	0	2	2	807	0	0	0	0	0	0	0	0	-1	0	2	3	1	2	0	0	0
07.01.2025 01:00	44	Jackson J.	MEM	35	13	5	2051	13	23	0	0	1	2	8	12	9	5	8	2	3	2	1	0	0
07.01.2025 01:00	45	Pippen Jr S.	MEM	18	5	4	1693	6	13	0	0	3	7	3	4	9	1	4	2	5	1	1	0	0
07.01.2025 01:00	46	Wells J.	MEM	17	11	1	2095	3	11	0	0	1	5	10	11	18	2	9	1	0	0	0	0	0
07.01.2025 01:00	47	Kennard L.	MEM	13	4	4	1465	5	9	0	0	3	5	0	0	10	0	4	1	0	2	0	0	0
07.01.2025 01:00	48	Huff J.	MEM	11	1	1	1658	4	7	0	0	3	6	0	0	18	0	1	1	2	2	0	0	0
07.01.2025 01:00	49	LaRavia J.	MEM	7	2	4	1648	1	4	0	0	0	2	5	6	13	0	2	1	0	2	0	0	0
07.01.2025 01:00	50	Clarke B.	MEM	6	2	1	894	3	7	0	0	0	0	0	1	4	0	2	4	1	1	1	0	0
07.01.2025 01:00	51	Konchar J.	MEM	5	13	2	1350	2	6	0	0	0	3	1	1	0	3	10	1	0	0	0	0	0
07.01.2025 01:00	52	Edey Z.	MEM	4	3	0	795	2	4	0	0	0	1	0	0	-5	2	1	1	0	3	2	0	0
07.01.2025 01:00	53	Spencer C.	MEM	3	0	1	613	1	3	0	0	1	3	0	0	-2	0	0	1	0	0	0	0	0
07.01.2025 01:00	54	Kawamura Y.	MEM	0	1	1	138	0	1	0	0	0	1	0	0	1	0	1	2	0	0	0	0	0
05.01.2025 01:30	55	Jackson J.	MEM	23	9	2	2162	11	21	0	0	0	3	1	1	-10	1	8	4	2	4	1	0	0
05.01.2025 01:30	56	Bane D.	MEM	22	4	10	2111	9	20	0	0	2	8	2	2	-10	0	4	0	2	8	1	0	1
05.01.2025 01:30	57	LaRavia J.	MEM	17	4	10	1920	5	8	0	0	1	2	6	8	1	1	3	2	0	3	0	0	0
05.01.2025 01:30	58	Pippen Jr S.	MEM	12	5	1	1603	4	9	0	0	3	4	1	2	-7	4	1	2	2	1	1	0	0
05.01.2025 01:30	59	Clarke B.	MEM	10	6	0	1560	5	7	0	0	0	0	0	0	4	2	4	4	1	0	1	0	0
05.01.2025 01:30	60	Huff J.	MEM	9	2	0	919	3	4	0	0	3	4	0	0	0	0	2	3	0	1	3	0	0
05.01.2025 01:30	61	Wells J.	MEM	8	6	4	2118	4	13	0	0	0	5	0	0	-10	2	4	1	2	2	0	0	0
05.01.2025 01:30	62	Spencer C.	MEM	7	1	1	779	3	4	0	0	0	1	1	1	3	0	1	0	0	0	0	0	0
05.01.2025 01:30	63	Edey Z.	MEM	5	6	1	1228	2	2	0	0	0	0	1	2	-11	2	4	2	0	3	0	0	0
04.01.2025 03:00	64	Wells J.	MEM	30	5	2	2168	11	16	0	0	8	9	0	0	-4	3	2	1	0	0	0	0	0
04.01.2025 03:00	65	Jackson J.	MEM	28	6	5	2042	9	21	0	0	3	9	7	10	-5	0	6	6	0	4	1	0	0
04.01.2025 03:00	66	Bane D.	MEM	22	7	8	2093	7	14	0	0	0	4	8	8	-1	1	6	2	2	5	1	0	0
04.01.2025 03:00	67	Pippen Jr S.	MEM	16	2	5	1500	4	6	0	0	3	5	5	5	-21	0	2	4	1	4	0	0	0
04.01.2025 03:00	68	Clarke B.	MEM	11	8	0	1381	3	6	0	0	0	0	5	6	-2	4	4	0	0	1	1	0	0
04.01.2025 03:00	69	Kennard L.	MEM	11	8	9	1895	3	10	0	0	2	5	3	3	13	2	6	2	1	1	0	0	0
04.01.2025 03:00	70	Edey Z.	MEM	9	7	0	1308	4	10	0	0	0	1	1	2	0	3	4	3	0	1	1	0	0
04.01.2025 03:00	71	LaRavia J.	MEM	6	3	2	942	2	2	0	0	1	1	1	2	1	0	3	0	1	0	0	0	0
04.01.2025 03:00	72	Huff J.	MEM	0	1	0	191	0	0	0	0	0	0	0	0	-3	0	1	0	0	0	0	0	0
04.01.2025 03:00	73	Konchar J.	MEM	0	4	0	880	0	4	0	0	0	3	0	0	-3	1	3	2	0	1	0	0	0
01.01.2025 02:00	74	Jackson J.	MEM	38	11	4	2274	12	24	0	0	4	9	10	17	8	2	9	3	2	5	1	0	0
01.01.2025 02:00	75	Bane D.	MEM	31	5	7	2213	13	25	0	0	4	8	1	3	2	1	4	4	0	4	1	0	0
01.01.2025 02:00	76	Kennard L.	MEM	17	7	4	1722	5	8	0	0	3	6	4	4	9	2	5	2	2	0	0	0	0
01.01.2025 02:00	77	Wells J.	MEM	11	6	2	1904	3	12	0	0	2	8	3	4	8	3	3	4	1	3	0	0	0
01.01.2025 02:00	78	Huff J.	MEM	8	3	0	1117	3	7	0	0	2	5	0	0	-3	0	3	2	0	0	1	0	0
01.01.2025 02:00	79	Konchar J.	MEM	7	12	4	2134	3	7	0	0	0	2	1	1	-1	4	8	5	1	0	1	0	0
01.01.2025 02:00	80	Pippen Jr S.	MEM	2	2	3	1292	0	5	0	0	0	3	2	2	-6	1	1	4	1	3	2	0	0
01.01.2025 02:00	81	Spencer C.	MEM	2	3	3	974	1	4	0	0	0	3	0	0	9	2	1	3	2	1	0	0	0
01.01.2025 02:00	82	Castleton C.	MEM	1	3	0	769	0	2	0	0	0	0	1	2	-1	2	1	2	1	1	0	0	0
30.12.2024 00:00	83	Bane D.	MEM	22	9	4	1747	7	15	0	0	3	8	5	6	-19	1	8	2	0	2	0	0	0
30.12.2024 00:00	84	Huff J.	MEM	17	1	2	1021	7	11	0	0	3	6	0	0	-16	1	0	1	0	3	0	0	0
30.12.2024 00:00	85	Kennard L.	MEM	16	5	3	1617	6	12	0	0	4	9	0	0	-22	2	3	0	0	4	0	0	0
30.12.2024 00:00	86	Jackson J.	MEM	13	5	4	1521	3	17	0	0	0	6	7	8	-9	2	3	4	1	3	1	0	0
30.12.2024 00:00	87	Kawamura Y.	MEM	10	3	3	661	4	5	0	0	2	3	0	0	5	0	3	1	0	0	0	0	0
30.12.2024 00:00	88	Pippen Jr S.	MEM	10	3	6	1429	4	7	0	0	1	2	1	2	-19	2	1	1	1	4	1	0	0
30.12.2024 00:00	89	Spencer C.	MEM	7	5	4	1337	1	5	0	0	1	3	4	4	0	2	3	1	0	1	0	0	0
30.12.2024 00:00	90	Konchar J.	MEM	4	15	1	2063	2	8	0	0	0	5	0	0	-8	3	12	1	3	1	2	0	0
30.12.2024 00:00	91	Wells J.	MEM	4	2	1	1514	2	12	0	0	0	7	0	0	-14	1	1	2	1	1	0	0	0
30.12.2024 00:00	92	Castleton C.	MEM	3	1	0	661	1	4	0	0	0	2	1	1	5	0	1	1	0	0	0	0	0
30.12.2024 00:00	93	LaRavia J.	MEM	0	2	2	829	0	1	0	0	0	0	0	0	-23	2	0	1	0	2	0	0	0
28.12.2024 01:00	94	Jackson J.	MEM	33	5	3	2110	11	21	0	0	4	6	7	7	32	2	3	1	4	4	3	0	0
28.12.2024 01:00	95	Morant J.	MEM	25	2	7	1490	8	11	0	0	3	4	6	7	21	0	2	2	1	3	0	0	0
28.12.2024 01:00	96	Bane D.	MEM	18	4	8	1934	6	13	0	0	2	6	4	4	14	0	4	2	4	1	0	0	0
28.12.2024 01:00	97	Edey Z.	MEM	14	9	2	1630	5	6	0	0	0	1	4	5	5	3	6	3	1	1	2	0	0
28.12.2024 01:00	98	Pippen Jr S.	MEM	13	6	4	1391	4	10	0	0	3	6	2	2	-8	3	3	4	0	1	0	0	0
28.12.2024 01:00	99	Wells J.	MEM	10	2	2	1946	3	10	0	0	1	6	3	4	4	0	2	2	0	0	0	0	0
28.12.2024 01:00	100	Kennard L.	MEM	9	4	3	1189	3	9	0	0	3	7	0	0	-7	0	4	1	0	0	0	0	0
28.12.2024 01:00	101	Huff J.	MEM	7	2	0	760	2	4	0	0	1	3	2	2	-15	0	2	2	0	0	0	0	0
28.12.2024 01:00	102	Clarke B.	MEM	3	4	0	1149	0	1	0	0	0	0	3	4	2	0	4	2	2	1	2	0	0
28.12.2024 01:00	103	Konchar J.	MEM	0	3	1	365	0	3	0	0	0	2	0	0	1	1	2	0	0	1	0	0	0
28.12.2024 01:00	104	LaRavia J.	MEM	0	1	0	436	0	1	0	0	0	0	0	0	-9	0	1	0	0	4	0	0	0
27.12.2024 01:00	105	Edey Z.	MEM	21	16	2	1637	9	15	0	0	1	5	2	5	29	9	7	0	0	0	2	0	0
27.12.2024 01:00	106	Jackson J.	MEM	21	11	6	1918	9	17	0	0	1	3	2	2	28	4	7	2	0	3	3	0	0
27.12.2024 01:00	107	Bane D.	MEM	19	5	2	1401	8	13	0	0	3	6	0	0	22	0	5	3	0	2	1	0	0
27.12.2024 01:00	108	Wells J.	MEM	17	1	1	1426	6	12	0	0	5	10	0	0	20	0	1	1	1	0	0	0	0
27.12.2024 01:00	109	Kennard L.	MEM	15	0	8	1479	4	9	0	0	3	8	4	4	7	0	0	1	1	3	0	0	0
27.12.2024 01:00	110	Morant J.	MEM	15	2	9	1447	5	10	0	0	1	3	4	4	28	0	2	0	0	3	0	0	0
27.12.2024 01:00	111	Pippen Jr S.	MEM	15	2	3	1257	5	12	0	0	1	5	4	5	1	1	1	2	4	2	0	0	0
27.12.2024 01:00	112	Clarke B.	MEM	11	9	0	1210	4	6	0	0	0	0	3	5	5	3	6	3	0	0	1	0	0
27.12.2024 01:00	113	Konchar J.	MEM	9	5	2	968	3	3	0	0	3	3	0	0	5	1	4	1	1	0	1	0	0
27.12.2024 01:00	114	LaRavia J.	MEM	8	9	3	1283	3	9	0	0	0	2	2	4	-3	4	5	5	1	3	0	0	0
27.12.2024 01:00	115	Aldama S.	MEM	4	3	0	198	2	3	0	0	0	0	0	0	3	2	1	0	0	1	0	0	0
27.12.2024 01:00	116	Spencer C.	MEM	0	0	0	176	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
24.12.2024 01:00	117	Jackson J.	MEM	24	6	3	1796	9	26	0	0	1	7	5	9	2	1	5	4	0	1	0	0	0
24.12.2024 01:00	118	Morant J.	MEM	23	6	4	1769	7	21	0	0	2	8	7	8	-12	0	6	0	1	6	1	0	0
24.12.2024 01:00	119	Bane D.	MEM	21	9	7	1912	7	15	0	0	3	7	4	5	0	3	6	3	2	4	0	0	0
24.12.2024 01:00	120	Pippen Jr S.	MEM	13	2	2	1111	5	10	0	0	3	4	0	1	8	1	1	3	0	1	1	0	0
24.12.2024 01:00	121	Aldama S.	MEM	11	7	3	1861	4	9	0	0	3	6	0	1	-10	0	7	1	2	1	2	0	0
24.12.2024 01:00	122	LaRavia J.	MEM	8	6	2	1291	3	5	0	0	2	3	0	0	-7	3	3	3	1	1	0	0	0
24.12.2024 01:00	123	Wells J.	MEM	7	3	2	1677	2	5	0	0	1	4	2	2	2	2	1	2	0	2	0	0	0
24.12.2024 01:00	124	Edey Z.	MEM	3	14	1	1615	1	8	0	0	1	3	0	0	3	7	7	0	1	2	3	0	1
24.12.2024 01:00	125	Clarke B.	MEM	0	2	2	400	0	1	0	0	0	0	0	0	-2	1	1	2	1	0	0	0	0
24.12.2024 01:00	126	Kennard L.	MEM	0	1	0	968	0	0	0	0	0	0	0	0	-4	1	0	0	0	1	0	0	0
\.


--
-- Data for Name: memphis_grizzlies_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.memphis_grizzlies_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Huff Jay	Lesionado	2025-01-16 10:45:37.404185
2	Smart Marcus	Lesionado	2025-01-16 10:45:37.407086
3	Spencer Cam	Lesionado	2025-01-16 10:45:37.409418
4	Williams Vince	Lesionado	2025-01-16 10:45:37.411321
5	Jackson Gregory	Lesionado	2025-01-16 10:45:37.412935
\.


--
-- Data for Name: miami_heat; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.miami_heat (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	07.07.2024	Sacramento Kings	86	Miami Heat	102	20	24	22	20	27	29	20	26
2	11.07.2024	Los Angeles Lakers	76	Miami Heat	80	21	19	18	18	21	15	23	21
3	13.07.2024	Boston Celtics	114	Miami Heat	119	32	21	29	32	28	33	28	30
4	15.07.2024	Miami Heat	102	Oklahoma City Thunder	73	18	23	32	29	20	13	24	16
5	17.07.2024	Dallas Mavericks	79	Miami Heat	92	21	11	25	22	14	23	24	31
6	20.07.2024	Miami Heat	109	Toronto Raptors	73	32	29	26	22	7	17	25	24
7	21.07.2024	Miami Heat	102	Golden State Warriors	99	22	23	20	37	19	28	23	29
8	23.07.2024\nApós Prol.	Miami Heat	120	Memphis Grizzlies	118	24	30	33	26	25	32	37	19
9	09.10.2024	Charlotte Hornets	111	Miami Heat	108	29	29	31	22	28	34	19	27
10	13.10.2024	Miami Heat	101	New Orleans Pelicans	99	22	34	22	23	20	29	18	32
11	16.10.2024	Miami Heat	120	San Antonio Spurs	117	27	32	23	38	21	28	35	33
12	17.10.2024	Miami Heat	120	Atlanta Hawks	111	34	32	37	17	32	37	15	27
13	19.10.2024	Memphis Grizzlies	109	Miami Heat	114	24	38	29	18	28	32	25	29
14	24.10.2024	Miami Heat	97	Orlando Magic	116	32	22	18	25	32	26	39	19
15	27.10.2024	Charlotte Hornets	106	Miami Heat	114	23	25	24	34	23	33	27	31
16	28.10.2024	Miami Heat	106	Detroit Pistons	98	28	36	14	28	30	23	26	19
17	30.10.2024	Miami Heat	107	New York Knicks	116	32	26	22	27	26	26	35	29
18	03.11.2024	Washington Wizards	98	Miami Heat	118	21	27	22	28	31	25	33	29
19	05.11.2024	Miami Heat	110	Sacramento Kings	111	25	36	17	32	22	26	37	26
20	07.11.2024	Phoenix Suns	115	Miami Heat	112	26	29	29	31	25	33	29	25
21	09.11.2024	Denver Nuggets	135	Miami Heat	122	40	31	33	31	27	33	30	32
22	11.11.2024	Minnesota Timberwolves	94	Miami Heat	95	20	31	20	23	27	25	16	27
23	13.11.2024\nApós Prol.	Detroit Pistons	123	Miami Heat	121	32	25	34	20	21	30	31	29
24	16.11.2024	Indiana Pacers	111	Miami Heat	124	29	26	30	26	26	35	37	26
25	17.11.2024	Indiana Pacers	119	Miami Heat	110	28	24	33	34	20	29	26	35
26	19.11.2024	Miami Heat	106	Philadelphia 76ers	89	25	28	35	18	33	23	16	17
27	24.11.2024\nApós Prol.	Miami Heat	123	Dallas Mavericks	118	33	23	33	25	28	23	33	30
28	27.11.2024	Miami Heat	103	Milwaukee Bucks	106	20	31	29	23	31	34	20	21
29	28.11.2024	Charlotte Hornets	94	Miami Heat	98	26	13	19	36	26	24	25	23
30	30.11.2024	Miami Heat	121	Toronto Raptors	111	20	38	38	25	21	40	23	27
31	01.12.2024	Toronto Raptors	119	Miami Heat	116	34	31	33	21	24	36	27	29
32	03.12.2024	Boston Celtics	108	Miami Heat	89	28	32	25	23	25	20	18	26
33	05.12.2024	Miami Heat	134	Los Angeles Lakers	93	34	35	36	29	26	26	20	21
34	08.12.2024	Miami Heat	121	Phoenix Suns	111	26	27	34	34	29	29	24	29
35	13.12.2024	Miami Heat	114	Toronto Raptors	104	23	35	31	25	27	24	25	28
36	17.12.2024\nApós Prol.	Detroit Pistons	125	Miami Heat	124	33	30	34	17	32	27	22	33
37	21.12.2024	Miami Heat	97	Oklahoma City Thunder	104	25	22	23	27	30	20	31	23
38	22.12.2024	Orlando Magic	121	Miami Heat	114	28	28	28	37	40	36	30	8
39	24.12.2024	Miami Heat	110	Brooklyn Nets	95	39	19	25	27	28	29	21	17
40	27.12.2024	Orlando Magic	88	Miami Heat	89	31	21	19	17	22	19	20	28
41	28.12.2024	Atlanta Hawks	120	Miami Heat	110	35	26	32	27	28	30	26	26
42	30.12.2024	Houston Rockets	100	Miami Heat	104	27	23	32	18	31	22	28	23
43	02.01. 00:30	Miami Heat	119	New Orleans Pelicans	108	36	20	34	29	24	27	25	32
44	03.01. 00:30	Miami Heat	115	Indiana Pacers	128	25	25	33	32	38	28	41	21
45	05.01. 01:00	Miami Heat	100	Utah Jazz	136	22	19	25	34	22	40	36	38
46	07.01. 03:00\nApós Prol.	Sacramento Kings	123	Miami Heat	118	23	27	18	34	28	19	31	24
47	08.01. 03:00	Golden State Warriors	98	Miami Heat	114	23	25	30	20	29	32	23	30
48	10.01. 02:00	Utah Jazz	92	Miami Heat	97	27	14	29	22	20	26	22	29
49	12.01. 03:00	Portland Trail Blazers	98	Miami Heat	119	23	25	35	15	29	37	28	25
50	14.01. 03:30	Los Angeles Clippers	109	Miami Heat	98	28	15	36	30	35	13	20	30
51	16.01. 03:00	Los Angeles Lakers	117	Miami Heat	108	34	20	29	34	38	28	19	23
\.


--
-- Data for Name: miami_heat_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.miami_heat_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 03:00	1	Herro T.	MIA	34	4	3	2295	12	18	0	0	7	12	3	3	-10	0	4	1	1	7	0	0	0
16.01.2025 03:00	2	Highsmith H.	MIA	12	3	1	1759	5	10	0	0	2	4	0	0	-14	1	2	1	0	1	2	0	0
16.01.2025 03:00	3	Jovic N.	MIA	12	4	8	1939	4	7	0	0	2	3	2	2	3	1	3	4	0	2	1	0	0
16.01.2025 03:00	4	Jaquez Jr. J.	MIA	11	5	3	1476	3	7	0	0	2	4	3	3	-12	0	5	1	1	1	0	0	0
16.01.2025 03:00	5	Adebayo B.	MIA	10	4	5	1861	3	7	0	0	1	3	3	4	-10	0	4	3	1	3	0	0	0
16.01.2025 03:00	6	Burks A.	MIA	8	2	0	1233	3	3	0	0	2	2	0	0	1	0	2	0	0	2	0	0	0
16.01.2025 03:00	7	Ware K.	MIA	8	11	2	1050	4	7	0	0	0	1	0	0	-1	1	10	0	0	0	2	0	0
16.01.2025 03:00	8	Robinson D.	MIA	7	2	1	1321	2	7	0	0	0	4	3	3	3	0	2	2	0	2	1	0	0
16.01.2025 03:00	9	Rozier T.	MIA	6	2	2	1466	3	7	0	0	0	3	0	0	-5	0	2	1	0	1	0	0	0
14.01.2025 03:30	10	Herro T.	MIA	32	11	7	2226	9	20	0	0	4	13	10	12	-2	0	11	0	0	1	0	0	0
14.01.2025 03:30	11	Ware K.	MIA	19	13	0	1957	7	11	0	0	3	3	2	2	-14	4	9	2	1	1	1	0	0
14.01.2025 03:30	12	Rozier T.	MIA	11	7	2	1386	5	10	0	0	1	3	0	0	-8	2	5	0	0	2	0	0	0
14.01.2025 03:30	13	Jaquez Jr. J.	MIA	10	2	5	1962	4	9	0	0	2	4	0	0	0	0	2	2	1	5	0	0	0
14.01.2025 03:30	14	Highsmith H.	MIA	9	5	2	2185	3	8	0	0	2	7	1	2	-4	0	5	1	3	1	1	0	0
14.01.2025 03:30	15	Love K.	MIA	9	3	0	923	3	8	0	0	3	8	0	0	3	0	3	2	1	0	0	0	0
14.01.2025 03:30	16	Jovic N.	MIA	5	6	3	1674	1	10	0	0	1	7	2	2	-16	2	4	1	1	3	1	0	0
14.01.2025 03:30	17	Robinson D.	MIA	3	2	2	1492	1	5	0	0	1	5	0	0	-8	1	1	1	0	2	0	0	0
14.01.2025 03:30	18	Burks A.	MIA	0	0	1	595	0	4	0	0	0	2	0	0	-6	0	0	0	0	0	0	0	0
12.01.2025 03:00	19	Herro T.	MIA	32	5	5	1899	11	22	0	0	7	14	3	4	9	2	3	1	0	1	0	0	0
12.01.2025 03:00	20	Jovic N.	MIA	21	8	5	1914	8	12	0	0	4	7	1	1	20	1	7	4	1	1	1	0	0
12.01.2025 03:00	21	Highsmith H.	MIA	14	3	4	2202	5	8	0	0	4	5	0	0	13	1	2	1	5	0	0	0	0
12.01.2025 03:00	22	Adebayo B.	MIA	13	11	6	1810	6	13	0	0	1	2	0	0	7	3	8	3	1	1	0	0	0
12.01.2025 03:00	23	Jaquez Jr. J.	MIA	11	5	2	1568	4	9	0	0	0	1	3	5	9	0	5	3	2	2	1	0	0
12.01.2025 03:00	24	Rozier T.	MIA	11	2	4	1754	4	9	0	0	1	5	2	2	9	0	2	2	2	4	0	0	0
12.01.2025 03:00	25	Robinson D.	MIA	8	2	1	974	2	8	0	0	2	5	2	2	7	0	2	1	1	1	0	0	0
12.01.2025 03:00	26	Ware K.	MIA	7	4	0	976	3	6	0	0	0	2	1	2	9	1	3	0	0	0	2	0	0
12.01.2025 03:00	27	Larsson P.	MIA	2	2	0	616	1	4	0	0	0	2	0	0	11	0	2	0	1	0	1	0	0
12.01.2025 03:00	28	Burks A.	MIA	0	0	3	469	0	1	0	0	0	1	0	0	5	0	0	1	0	0	0	0	0
12.01.2025 03:00	29	Christopher J.	MIA	0	0	1	109	0	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0
12.01.2025 03:00	30	Johnson K.	MIA	0	1	0	109	0	0	0	0	0	0	0	0	3	0	1	0	0	0	0	0	0
10.01.2025 02:00	31	Herro T.	MIA	23	7	5	2242	7	17	0	0	4	10	5	5	1	0	7	1	1	1	1	0	0
10.01.2025 02:00	32	Jaquez Jr. J.	MIA	20	7	7	2171	7	11	0	0	3	5	3	4	4	2	5	1	2	3	0	0	0
10.01.2025 02:00	33	Adebayo B.	MIA	15	7	3	1723	6	13	0	0	1	2	2	4	0	2	5	1	3	1	2	0	0
10.01.2025 02:00	34	Jovic N.	MIA	11	6	5	1638	4	13	0	0	2	7	1	2	10	3	3	1	0	1	1	0	0
10.01.2025 02:00	35	Rozier T.	MIA	9	3	1	1969	4	13	0	0	1	8	0	0	-1	1	2	1	1	1	0	0	0
10.01.2025 02:00	36	Ware K.	MIA	8	7	1	1157	4	5	0	0	0	0	0	0	5	4	3	2	1	2	2	0	0
10.01.2025 02:00	37	Burks A.	MIA	6	7	1	1087	2	7	0	0	2	7	0	0	4	1	6	1	1	2	0	0	0
10.01.2025 02:00	38	Highsmith H.	MIA	5	2	2	1319	2	7	0	0	1	6	0	0	-7	0	2	2	0	0	1	0	0
10.01.2025 02:00	39	Robinson D.	MIA	0	3	1	1094	0	5	0	0	0	5	0	0	9	0	3	2	1	3	0	0	0
08.01.2025 03:00	40	Jovic N.	MIA	20	6	4	2053	8	17	0	0	2	8	2	3	25	1	5	0	1	2	0	0	0
08.01.2025 03:00	41	Adebayo B.	MIA	19	9	5	1788	9	14	0	0	1	1	0	1	18	3	6	1	2	1	1	0	0
08.01.2025 03:00	42	Jaquez Jr. J.	MIA	18	5	1	1711	7	12	0	0	1	3	3	4	-3	2	3	0	0	3	0	0	0
08.01.2025 03:00	43	Herro T.	MIA	14	8	3	1580	4	14	0	0	3	9	3	3	-2	0	8	1	1	0	0	0	0
08.01.2025 03:00	44	Robinson D.	MIA	12	1	8	1264	4	6	0	0	4	5	0	0	20	0	1	2	1	1	0	0	0
08.01.2025 03:00	45	Burks A.	MIA	11	4	0	1480	3	6	0	0	3	6	2	3	17	0	4	1	1	0	0	0	0
08.01.2025 03:00	46	Rozier T.	MIA	9	5	5	1924	4	12	0	0	1	4	0	0	14	0	5	2	0	2	1	0	0
08.01.2025 03:00	47	Ware K.	MIA	6	4	1	1092	2	6	0	0	0	1	2	3	-2	2	2	2	0	0	1	0	0
08.01.2025 03:00	48	Highsmith H.	MIA	5	6	5	1400	2	4	0	0	1	3	0	0	-1	1	5	0	0	0	0	0	0
08.01.2025 03:00	49	Christopher J.	MIA	0	0	0	36	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
08.01.2025 03:00	50	Johnson K.	MIA	0	0	0	36	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
08.01.2025 03:00	51	Larsson P.	MIA	0	0	0	36	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
07.01.2025 03:00	52	Herro T.	MIA	26	7	4	2932	11	25	0	0	4	10	0	0	-6	1	6	2	2	3	0	0	0
07.01.2025 03:00	53	Adebayo B.	MIA	18	12	2	2697	6	19	0	0	1	5	5	6	-3	2	10	2	4	2	1	0	0
07.01.2025 03:00	54	Rozier T.	MIA	18	7	3	2481	6	15	0	0	2	8	4	4	-2	2	5	4	1	2	0	0	0
07.01.2025 03:00	55	Jaquez Jr. J.	MIA	16	12	10	2735	7	15	0	0	0	2	2	4	-4	4	8	3	5	3	1	0	0
07.01.2025 03:00	56	Highsmith H.	MIA	14	6	1	2740	5	8	0	0	2	4	2	3	0	2	4	3	0	0	2	0	0
07.01.2025 03:00	57	Jovic N.	MIA	12	3	0	1230	3	8	0	0	0	4	6	6	0	1	2	1	1	0	1	0	0
07.01.2025 03:00	58	Robinson D.	MIA	8	2	4	1497	3	8	0	0	2	7	0	0	-2	0	2	1	0	2	0	0	0
07.01.2025 03:00	59	Ware K.	MIA	6	3	1	783	2	3	0	0	0	1	2	4	-2	0	3	3	0	0	1	0	0
07.01.2025 03:00	60	Larsson P.	MIA	0	1	0	305	0	1	0	0	0	1	0	0	-6	0	1	0	1	1	0	0	0
05.01.2025 01:00	61	Jovic N.	MIA	17	1	3	1412	7	14	0	0	3	5	0	0	-20	0	1	1	2	0	2	0	0
05.01.2025 01:00	62	Robinson D.	MIA	16	2	2	1291	6	12	0	0	3	9	1	1	-24	0	2	1	0	0	0	0	0
05.01.2025 01:00	63	Herro T.	MIA	15	4	6	1761	4	12	0	0	1	8	6	6	-28	0	4	1	1	3	0	0	0
05.01.2025 01:00	64	Jaquez Jr. J.	MIA	13	2	4	2045	3	6	0	0	0	1	7	9	-27	0	2	1	1	2	0	0	0
05.01.2025 01:00	65	Ware K.	MIA	12	4	1	1347	5	9	0	0	2	3	0	0	-12	0	4	0	2	2	0	0	0
05.01.2025 01:00	66	Rozier T.	MIA	8	1	0	1101	4	9	0	0	0	5	0	0	-15	0	1	1	0	1	0	0	0
05.01.2025 01:00	67	Johnson K.	MIA	7	4	1	1185	3	6	0	0	0	2	1	4	-9	1	3	2	1	1	1	0	0
05.01.2025 01:00	68	Christopher J.	MIA	5	0	3	837	2	2	0	0	0	0	1	2	-3	0	0	1	0	2	1	0	0
05.01.2025 01:00	69	Adebayo B.	MIA	4	8	2	1533	0	6	0	0	0	1	4	6	-24	1	7	1	1	3	1	0	0
05.01.2025 01:00	70	Highsmith H.	MIA	2	3	0	976	1	2	0	0	0	0	0	0	-11	2	1	3	1	1	1	0	0
05.01.2025 01:00	71	Larsson P.	MIA	1	2	2	587	0	0	0	0	0	0	1	2	-3	1	1	2	0	0	1	0	0
05.01.2025 01:00	72	Burks A.	MIA	0	1	1	325	0	2	0	0	0	1	0	0	-4	0	1	0	0	0	0	0	0
03.01.2025 00:30	73	Ware K.	MIA	25	0	1	1287	9	11	0	0	3	4	4	5	4	0	0	2	1	1	3	0	0
03.01.2025 00:30	74	Adebayo B.	MIA	20	8	2	1509	8	12	0	0	0	1	4	6	-13	3	5	0	1	1	0	0	0
03.01.2025 00:30	75	Herro T.	MIA	17	3	3	2145	6	12	0	0	3	7	2	2	-4	0	3	2	0	3	0	0	0
03.01.2025 00:30	76	Rozier T.	MIA	16	5	7	1780	6	12	0	0	0	3	4	4	-3	0	5	3	0	3	0	0	0
03.01.2025 00:30	77	Butler J.	MIA	9	2	4	1591	3	6	0	0	1	2	2	2	-27	0	2	0	2	1	0	0	0
03.01.2025 00:30	78	Jovic N.	MIA	8	2	5	1506	3	7	0	0	0	2	2	2	-11	0	2	1	1	1	0	0	0
03.01.2025 00:30	79	Highsmith H.	MIA	6	4	2	1085	3	4	0	0	0	1	0	0	-15	1	3	3	0	1	0	0	0
03.01.2025 00:30	80	Robinson D.	MIA	6	1	4	1089	2	5	0	0	2	4	0	0	-16	0	1	0	0	1	0	0	0
03.01.2025 00:30	81	Johnson K.	MIA	5	6	1	720	2	2	0	0	1	1	0	0	11	0	6	1	0	1	3	0	0
03.01.2025 00:30	82	Burks A.	MIA	3	2	0	530	1	1	0	0	1	1	0	0	-5	0	2	0	0	0	0	0	0
03.01.2025 00:30	83	Christopher J.	MIA	0	2	0	122	0	0	0	0	0	0	0	0	4	0	2	0	0	1	0	0	0
03.01.2025 00:30	84	Jaquez Jr. J.	MIA	0	4	5	914	0	3	0	0	0	0	0	0	6	1	3	1	1	0	0	0	0
03.01.2025 00:30	85	Larsson P.	MIA	0	0	0	122	0	0	0	0	0	0	0	0	4	0	0	0	0	0	0	0	0
02.01.2025 00:30	86	Herro T.	MIA	32	1	4	2414	11	22	0	0	5	12	5	5	13	0	1	1	0	0	0	0	0
02.01.2025 00:30	87	Adebayo B.	MIA	23	9	10	1878	9	14	0	0	0	2	5	5	6	1	8	3	2	4	0	0	0
02.01.2025 00:30	88	Robinson D.	MIA	17	4	3	1509	7	13	0	0	3	7	0	0	7	0	4	2	1	0	0	0	0
02.01.2025 00:30	89	Jaquez Jr. J.	MIA	12	4	4	1396	5	9	0	0	1	1	1	4	2	2	2	2	2	0	0	0	0
02.01.2025 00:30	90	Ware K.	MIA	10	5	1	1002	4	4	0	0	1	1	1	2	5	1	4	2	0	0	1	0	0
02.01.2025 00:30	91	Butler J.	MIA	9	4	2	1484	3	5	0	0	1	2	2	2	9	0	4	1	0	0	0	0	0
02.01.2025 00:30	92	Jovic N.	MIA	8	7	6	2010	3	6	0	0	2	4	0	0	0	0	7	1	0	4	0	0	0
02.01.2025 00:30	93	Burks A.	MIA	6	1	2	1140	1	4	0	0	1	2	3	3	2	0	1	0	0	0	0	0	0
02.01.2025 00:30	94	Highsmith H.	MIA	2	3	2	1567	1	6	0	0	0	3	0	0	11	1	2	4	1	2	0	0	0
30.12.2024 00:00	95	Herro T.	MIA	27	6	9	2218	10	17	0	0	3	7	4	7	13	0	6	2	0	3	0	0	0
30.12.2024 00:00	96	Jovic N.	MIA	18	7	6	1858	5	9	0	0	3	5	5	5	18	2	5	1	0	0	0	0	0
30.12.2024 00:00	97	Highsmith H.	MIA	15	8	2	2253	6	9	0	0	3	6	0	0	10	4	4	1	3	3	1	0	0
30.12.2024 00:00	98	Rozier T.	MIA	14	5	0	2292	6	19	0	0	0	8	2	2	-3	1	4	1	1	2	1	0	0
30.12.2024 00:00	99	Adebayo B.	MIA	12	10	1	2057	4	12	0	0	0	1	4	6	-1	2	8	5	3	2	0	0	0
30.12.2024 00:00	100	Ware K.	MIA	7	7	2	823	3	3	0	0	0	0	1	3	5	1	6	2	0	1	1	0	0
30.12.2024 00:00	101	Love K.	MIA	5	6	1	840	1	7	0	0	0	1	3	4	-13	3	3	1	0	1	0	0	0
30.12.2024 00:00	102	Burks A.	MIA	4	0	0	1075	1	5	0	0	1	5	1	1	-2	0	0	1	0	2	0	0	0
30.12.2024 00:00	103	Jaquez Jr. J.	MIA	2	3	0	984	1	3	0	0	0	0	0	0	-7	2	1	0	0	0	0	0	0
28.12.2024 20:00	104	Herro T.	MIA	28	7	10	2155	8	15	0	0	4	7	8	8	-3	0	7	3	0	2	0	0	0
28.12.2024 20:00	105	Adebayo B.	MIA	17	10	2	2192	8	17	0	0	0	2	1	1	-1	3	7	3	1	2	2	0	0
28.12.2024 20:00	106	Robinson D.	MIA	16	5	5	2300	6	14	0	0	4	10	0	0	10	0	5	3	2	1	0	0	0
28.12.2024 20:00	107	Highsmith H.	MIA	14	6	2	2166	6	8	0	0	2	3	0	0	-11	3	3	4	0	1	0	0	0
28.12.2024 20:00	108	Burks A.	MIA	10	1	1	1157	3	9	0	0	2	6	2	2	-16	0	1	1	1	0	0	0	0
28.12.2024 20:00	109	Rozier T.	MIA	9	5	1	1209	3	8	0	0	1	5	2	2	-9	0	5	0	1	1	2	0	0
28.12.2024 20:00	110	Jaquez Jr. J.	MIA	8	5	1	1264	4	12	0	0	0	5	0	0	-5	1	4	1	3	0	0	0	0
28.12.2024 20:00	111	Jovic N.	MIA	4	2	1	1102	0	3	0	0	0	2	4	5	-11	1	1	2	0	1	0	0	0
28.12.2024 20:00	112	Ware K.	MIA	4	1	0	600	2	3	0	0	0	1	0	0	-8	0	1	0	1	0	0	0	0
28.12.2024 20:00	113	Larsson P.	MIA	0	0	0	255	0	1	0	0	0	0	0	0	4	0	0	2	0	0	0	0	0
27.12.2024 00:00	114	Herro T.	MIA	20	3	2	1923	8	17	0	0	3	6	1	1	-10	0	3	1	1	6	0	0	0
27.12.2024 00:00	115	Burks A.	MIA	17	6	0	1899	4	5	0	0	3	3	6	7	17	1	5	3	3	1	0	0	0
27.12.2024 00:00	116	Jaquez Jr. J.	MIA	15	4	4	1830	4	9	0	0	3	5	4	4	2	2	2	2	5	3	1	0	0
27.12.2024 00:00	117	Rozier T.	MIA	14	4	1	1731	6	14	0	0	1	2	1	2	12	1	3	1	1	2	0	0	0
27.12.2024 00:00	118	Highsmith H.	MIA	9	3	0	1625	3	6	0	0	3	5	0	0	-10	0	3	5	1	2	0	0	0
27.12.2024 00:00	119	Jovic N.	MIA	8	4	5	1420	3	8	0	0	2	4	0	0	5	0	4	0	3	2	0	0	0
27.12.2024 00:00	120	Adebayo B.	MIA	4	9	7	2113	2	10	0	0	0	1	0	0	-3	3	6	4	0	4	5	0	0
27.12.2024 00:00	121	Ware K.	MIA	2	0	1	787	1	4	0	0	0	1	0	0	4	0	0	2	0	0	0	0	0
27.12.2024 00:00	122	Robinson D.	MIA	0	2	1	1072	0	3	0	0	0	3	0	0	-12	0	2	2	0	0	0	0	0
\.


--
-- Data for Name: miami_heat_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.miami_heat_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Adebayo Bam	Lesionado	2025-01-16 10:45:50.499471
2	Ware Kel'el	Lesionado	2025-01-16 10:45:50.501632
3	Butler Jimmy	Lesionado	2025-01-16 10:45:50.503264
4	Richardson Josh	Lesionado	2025-01-16 10:45:50.506572
5	Smith Dru	Lesionado	2025-01-16 10:45:50.50873
\.


--
-- Data for Name: milwaukee_bucks; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.milwaukee_bucks (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	01.05.2024	Milwaukee Bucks	115	Indiana Pacers	92	23	30	34	28	31	17	19	25
2	02.05.2024	Indiana Pacers	120	Milwaukee Bucks	98	33	26	34	27	24	23	31	20
3	13.07.2024	Chicago Bulls	96	Milwaukee Bucks	89	26	24	30	16	27	19	20	23
4	14.07.2024	Milwaukee Bucks	81	Cleveland Cavaliers	112	21	16	27	17	38	34	20	20
5	17.07.2024	Milwaukee Bucks	97	Los Angeles Clippers	112	22	23	31	21	28	30	30	24
6	19.07.2024	Phoenix Suns	115	Milwaukee Bucks	90	31	25	30	29	11	22	29	28
7	20.07.2024	Washington Wizards	91	Milwaukee Bucks	79	29	17	15	30	19	16	31	13
8	07.10.2024	Detroit Pistons	120	Milwaukee Bucks	87	28	32	31	29	39	19	21	8
9	11.10.2024	Milwaukee Bucks	102	Los Angeles Lakers	107	23	35	24	20	26	26	22	33
10	15.10.2024	Milwaukee Bucks	111	Chicago Bulls	107	24	35	32	20	34	34	15	24
11	18.10.2024	Dallas Mavericks	109	Milwaukee Bucks	84	21	33	29	26	22	16	20	26
12	24.10.2024	Philadelphia 76ers	109	Milwaukee Bucks	124	23	24	34	28	22	36	42	24
13	26.10.2024	Milwaukee Bucks	122	Chicago Bulls	133	32	32	31	27	30	33	39	31
14	27.10.2024	Brooklyn Nets	115	Milwaukee Bucks	102	27	21	35	32	25	20	33	24
15	28.10.2024	Boston Celtics	119	Milwaukee Bucks	108	28	25	37	29	29	27	26	26
16	01.11.2024	Memphis Grizzlies	122	Milwaukee Bucks	99	40	30	29	23	24	24	22	29
17	03.11.2024	Milwaukee Bucks	113	Cleveland Cavaliers	114	38	24	22	29	30	31	26	27
18	05.11.2024	Cleveland Cavaliers	116	Milwaukee Bucks	114	35	38	16	27	31	29	31	23
19	08.11.2024	Milwaukee Bucks	123	Utah Jazz	100	31	26	31	35	29	32	16	23
20	09.11.2024	New York Knicks	116	Milwaukee Bucks	94	32	34	25	25	25	22	25	22
21	10.11.2024	Milwaukee Bucks	107	Boston Celtics	113	40	29	15	23	30	28	29	26
22	13.11.2024	Milwaukee Bucks	99	Toronto Raptors	85	26	28	27	18	21	22	24	18
23	14.11.2024\nApós Prol.	Milwaukee Bucks	127	Detroit Pistons	120	24	23	38	26	27	33	24	27
24	16.11.2024	Charlotte Hornets	115	Milwaukee Bucks	114	33	26	27	29	39	24	27	24
25	19.11.2024	Milwaukee Bucks	101	Houston Rockets	100	27	30	26	18	28	17	35	20
26	21.11.2024	Milwaukee Bucks	122	Chicago Bulls	106	36	33	29	24	30	27	33	16
27	23.11.2024	Milwaukee Bucks	129	Indiana Pacers	117	34	24	35	36	22	22	35	38
28	24.11.2024	Milwaukee Bucks	125	Charlotte Hornets	119	28	31	37	29	28	23	34	34
29	27.11.2024	Miami Heat	103	Milwaukee Bucks	106	20	31	29	23	31	34	20	21
30	01.12.2024	Milwaukee Bucks	124	Washington Wizards	114	28	35	29	32	29	29	28	28
31	04.12.2024	Detroit Pistons	107	Milwaukee Bucks	128	31	28	29	19	36	42	32	18
32	05.12.2024	Milwaukee Bucks	104	Atlanta Hawks	119	35	24	28	17	38	32	29	20
33	07.12.2024	Boston Celtics	111	Milwaukee Bucks	105	29	24	25	33	27	30	25	23
34	08.12.2024	Brooklyn Nets	113	Milwaukee Bucks	118	25	27	34	27	27	24	35	32
35	11.12.2024	Milwaukee Bucks	114	Orlando Magic	109	25	35	20	34	33	26	13	37
36	14.12.2024	Milwaukee Bucks	110	Atlanta Hawks	102	26	29	27	28	28	21	34	19
37	18.12.2024	Milwaukee Bucks	97	Oklahoma City Thunder	81	27	24	26	20	28	22	14	17
38	21.12.2024	Cleveland Cavaliers	124	Milwaukee Bucks	101	29	40	34	21	20	31	25	25
39	22.12.2024	Milwaukee Bucks	112	Washington Wizards	101	36	27	23	26	36	14	22	29
40	24.12.2024	Chicago Bulls	91	Milwaukee Bucks	112	17	28	27	19	33	26	33	20
41	27.12.2024	Milwaukee Bucks	105	Brooklyn Nets	111	25	34	23	23	27	24	25	35
42	29.12.2024	Chicago Bulls	116	Milwaukee Bucks	111	33	29	21	33	25	35	24	27
43	31.12.2024	Indiana Pacers	112	Milwaukee Bucks	120	28	36	27	21	30	23	35	32
44	03.01. 01:00	Milwaukee Bucks	110	Brooklyn Nets	113	23	31	31	25	30	36	28	19
45	05.01. 01:00	Milwaukee Bucks	102	Portland Trail Blazers	105	31	20	25	26	28	26	21	30
46	07.01. 00:30	Toronto Raptors	104	Milwaukee Bucks	128	19	28	28	29	28	38	33	29
47	09.01. 02:30	Milwaukee Bucks	121	San Antonio Spurs	105	31	34	26	30	27	19	32	27
48	11.01. 00:00	Orlando Magic	106	Milwaukee Bucks	109	31	20	30	25	29	21	28	31
49	12.01. 20:00	New York Knicks	140	Milwaukee Bucks	106	36	39	33	32	33	29	27	17
50	15.01. 01:00	Milwaukee Bucks	130	Sacramento Kings	115	47	28	27	28	26	28	28	33
51	16.01. 01:00	Milwaukee Bucks	122	Orlando Magic	93	34	28	30	30	16	25	27	25
\.


--
-- Data for Name: milwaukee_bucks_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.milwaukee_bucks_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 01:00	1	Lillard D.	MIL	30	5	4	1829	13	19	0	0	3	3	1	1	27	0	5	1	4	3	0	0	0
16.01.2025 01:00	2	Antetokounmpo G.	MIL	26	11	4	1791	11	15	0	0	0	0	4	8	25	0	11	0	1	6	0	0	0
16.01.2025 01:00	3	Middleton K.	MIL	14	2	6	1267	5	8	0	0	0	1	4	6	19	0	2	1	2	0	0	0	0
16.01.2025 01:00	4	Portis B.	MIL	14	8	0	1407	4	6	0	0	2	3	4	4	16	1	7	3	0	2	1	0	0
16.01.2025 01:00	5	Lopez B.	MIL	13	5	2	1872	5	7	0	0	0	1	3	3	16	0	5	5	0	1	5	0	0
16.01.2025 01:00	6	Beauchamp M.	MIL	6	1	0	297	2	3	0	0	1	1	1	2	5	0	1	0	0	0	0	0	0
16.01.2025 01:00	7	Rollins R.	MIL	6	3	2	917	3	4	0	0	0	0	0	0	3	0	3	1	0	2	2	0	0
16.01.2025 01:00	8	Prince T.	MIL	5	1	1	1223	1	2	0	0	1	1	2	2	10	0	1	2	0	0	0	0	0
16.01.2025 01:00	9	Connaughton P.	MIL	3	1	1	680	1	2	0	0	0	0	1	2	-2	0	1	1	0	1	0	0	0
16.01.2025 01:00	10	Robbins L.	MIL	3	1	0	330	0	0	0	0	0	0	3	4	2	1	0	2	1	2	0	0	0
16.01.2025 01:00	11	Green A.	MIL	2	5	0	998	0	3	0	0	0	1	2	3	24	1	4	2	0	0	0	0	0
16.01.2025 01:00	12	Jackson A.	MIL	0	3	2	905	0	1	0	0	0	0	0	0	2	0	3	1	1	2	0	0	0
16.01.2025 01:00	13	Livingston C.	MIL	0	3	0	339	0	0	0	0	0	0	0	0	0	0	3	1	0	1	0	0	0
16.01.2025 01:00	14	Umude S.	MIL	0	0	0	134	0	0	0	0	0	0	0	0	-1	0	0	0	0	0	1	0	0
16.01.2025 01:00	15	Wright D.	MIL	0	0	2	411	0	2	0	0	0	1	0	0	-1	0	0	0	1	1	1	0	0
15.01.2025 01:00	16	Antetokounmpo G.	MIL	33	11	13	2199	14	23	0	0	0	2	5	7	30	1	10	3	0	3	2	0	0
15.01.2025 01:00	17	Lillard D.	MIL	24	5	7	2106	8	15	0	0	5	8	3	3	14	0	5	2	0	2	1	0	0
15.01.2025 01:00	18	Lopez B.	MIL	21	5	2	2005	8	15	0	0	3	7	2	3	8	0	5	3	1	0	0	0	0
15.01.2025 01:00	19	Green A.	MIL	16	4	1	1805	5	13	0	0	4	12	2	2	9	2	2	2	0	0	0	0	0
15.01.2025 01:00	20	Rollins R.	MIL	10	3	0	1159	4	9	0	0	1	4	1	1	8	0	3	1	1	2	0	0	0
15.01.2025 01:00	21	Prince T.	MIL	9	5	3	1371	3	4	0	0	3	4	0	0	26	0	5	4	0	0	0	0	0
15.01.2025 01:00	22	Portis B.	MIL	8	9	1	1254	4	9	0	0	0	2	0	0	4	2	7	1	0	0	0	0	0
15.01.2025 01:00	23	Connaughton P.	MIL	5	3	5	1052	2	3	0	0	1	2	0	0	5	1	2	1	0	0	0	0	0
15.01.2025 01:00	24	Beauchamp M.	MIL	2	1	0	151	0	2	0	0	0	1	2	2	-6	0	1	0	0	0	0	0	0
15.01.2025 01:00	25	Jackson A.	MIL	2	3	0	845	1	2	0	0	0	1	0	0	-5	2	1	3	0	0	0	0	0
15.01.2025 01:00	26	Livingston C.	MIL	0	1	0	151	0	0	0	0	0	0	0	0	-6	1	0	0	0	0	0	0	0
15.01.2025 01:00	27	Robbins L.	MIL	0	0	0	151	0	1	0	0	0	0	0	0	-6	0	0	1	0	0	1	0	0
15.01.2025 01:00	28	Umude S.	MIL	0	2	0	151	0	3	0	0	0	2	0	0	-6	2	0	0	0	0	0	0	0
12.01.2025 20:00	29	Antetokounmpo G.	MIL	24	13	2	1856	10	21	0	0	0	1	4	10	-20	7	6	3	0	4	1	0	0
12.01.2025 20:00	30	Lillard D.	MIL	22	3	5	2236	8	17	0	0	2	7	4	5	-24	0	3	2	1	6	0	0	0
12.01.2025 20:00	31	Middleton K.	MIL	16	0	5	1476	7	9	0	0	2	4	0	0	1	0	0	3	2	2	0	0	0
12.01.2025 20:00	32	Jackson A.	MIL	9	3	0	635	4	5	0	0	1	1	0	0	-19	3	0	3	0	0	1	0	0
12.01.2025 20:00	33	Connaughton P.	MIL	8	5	2	959	3	6	0	0	0	3	2	2	-7	2	3	1	0	0	0	0	0
12.01.2025 20:00	34	Portis B.	MIL	8	4	0	1138	4	7	0	0	0	1	0	0	-19	1	3	2	0	0	0	0	0
12.01.2025 20:00	35	Green A.	MIL	6	2	1	1485	2	5	0	0	2	5	0	0	-4	0	2	4	0	0	0	0	0
12.01.2025 20:00	36	Beauchamp M.	MIL	5	2	0	679	2	5	0	0	1	2	0	0	-8	1	1	0	1	0	0	0	0
12.01.2025 20:00	37	Lopez B.	MIL	5	1	3	1392	2	7	0	0	1	5	0	0	-22	0	1	0	0	0	1	0	0
12.01.2025 20:00	38	Prince T.	MIL	3	2	3	1392	1	4	0	0	1	3	0	0	-28	0	2	0	1	0	0	0	0
12.01.2025 20:00	39	Robbins L.	MIL	0	1	0	370	0	1	0	0	0	1	0	0	-6	1	0	1	0	1	0	0	0
12.01.2025 20:00	40	Umude S.	MIL	0	2	0	370	0	3	0	0	0	0	0	0	-6	0	2	1	0	1	0	0	0
12.01.2025 20:00	41	Wright D.	MIL	0	1	1	412	0	4	0	0	0	1	0	0	-8	0	1	0	1	0	0	0	0
11.01.2025 00:00	42	Antetokounmpo G.	MIL	41	14	4	2192	19	29	0	0	0	1	3	10	-3	3	11	4	3	3	2	0	0
11.01.2025 00:00	43	Lillard D.	MIL	29	4	7	2381	9	21	0	0	3	7	8	9	4	1	3	4	3	4	0	0	0
11.01.2025 00:00	44	Middleton K.	MIL	11	3	4	1355	5	10	0	0	1	5	0	0	6	0	3	0	1	1	0	0	0
11.01.2025 00:00	45	Portis B.	MIL	11	7	1	1504	5	9	0	0	1	3	0	0	12	0	7	3	1	0	0	0	0
11.01.2025 00:00	46	Lopez B.	MIL	8	3	0	2064	2	5	0	0	1	3	3	4	-3	0	3	1	0	1	3	0	0
11.01.2025 00:00	47	Prince T.	MIL	6	1	0	1543	2	2	0	0	2	2	0	0	-6	0	1	2	1	0	0	0	0
11.01.2025 00:00	48	Trent G.	MIL	3	3	1	1418	1	3	0	0	1	2	0	0	5	0	3	2	0	1	0	0	0
11.01.2025 00:00	49	Green A.	MIL	0	3	0	1139	0	3	0	0	0	1	0	0	7	1	2	0	1	0	0	0	0
11.01.2025 00:00	50	Jackson A.	MIL	0	5	1	804	0	1	0	0	0	1	0	0	-7	2	3	2	0	1	0	0	0
09.01.2025 02:30	51	Lillard D.	MIL	26	5	8	2120	8	13	0	0	4	7	6	6	8	0	5	1	0	2	0	0	0
09.01.2025 02:30	52	Antetokounmpo G.	MIL	25	16	8	2142	11	21	0	0	0	1	3	7	13	3	13	1	0	4	1	0	0
09.01.2025 02:30	53	Lopez B.	MIL	22	7	1	2123	8	17	0	0	5	11	1	1	7	2	5	3	1	0	2	0	0
09.01.2025 02:30	54	Green A.	MIL	14	1	1	1486	5	9	0	0	4	7	0	0	18	0	1	3	1	0	0	0	0
09.01.2025 02:30	55	Trent G.	MIL	14	3	2	1299	5	5	0	0	4	4	0	0	20	0	3	1	2	0	0	0	0
09.01.2025 02:30	56	Middleton K.	MIL	8	5	3	1250	2	7	0	0	1	5	3	4	20	0	5	2	0	0	0	0	0
09.01.2025 02:30	57	Portis B.	MIL	5	11	2	1159	2	12	0	0	0	3	1	2	20	2	9	2	1	1	1	0	0
09.01.2025 02:30	58	Prince T.	MIL	3	4	1	1462	1	3	0	0	1	3	0	0	0	0	4	0	0	2	0	0	0
09.01.2025 02:30	59	Beauchamp M.	MIL	2	1	0	168	1	2	0	0	0	0	0	0	-4	1	0	0	0	0	0	0	0
09.01.2025 02:30	60	Rollins R.	MIL	2	0	0	168	1	2	0	0	0	1	0	0	-4	0	0	1	1	0	0	0	0
09.01.2025 02:30	61	Jackson A.	MIL	0	2	0	687	0	1	0	0	0	0	0	0	-10	2	0	0	0	0	0	0	0
09.01.2025 02:30	62	Robbins L.	MIL	0	1	0	168	0	0	0	0	0	0	0	0	-4	0	1	1	0	1	0	0	0
09.01.2025 02:30	63	Umude S.	MIL	0	1	0	168	0	0	0	0	0	0	0	0	-4	0	1	1	1	0	0	0	0
07.01.2025 00:30	64	Lillard D.	MIL	25	5	3	1543	7	12	0	0	5	8	6	7	20	0	5	0	0	1	0	0	0
07.01.2025 00:30	65	Portis B.	MIL	20	7	3	1366	8	12	0	0	4	6	0	0	9	1	6	2	0	1	0	0	0
07.01.2025 00:30	66	Trent G.	MIL	17	3	1	1436	6	9	0	0	3	5	2	2	14	0	3	3	3	1	0	0	0
07.01.2025 00:30	67	Lopez B.	MIL	16	4	4	1895	6	10	0	0	4	8	0	0	22	0	4	1	1	4	2	0	0
07.01.2025 00:30	68	Antetokounmpo G.	MIL	11	12	13	1727	5	8	0	0	0	1	1	2	27	1	11	1	0	7	0	0	0
07.01.2025 00:30	69	Rollins R.	MIL	10	4	3	1101	4	8	0	0	0	2	2	2	9	0	4	1	0	1	0	0	0
07.01.2025 00:30	70	Prince T.	MIL	8	2	4	1866	3	7	0	0	2	5	0	0	30	0	2	1	3	2	1	0	0
07.01.2025 00:30	71	Green A.	MIL	5	0	1	784	2	3	0	0	1	2	0	0	4	0	0	5	0	0	0	0	0
07.01.2025 00:30	72	Jackson A.	MIL	5	4	3	957	2	3	0	0	1	2	0	0	9	3	1	1	0	2	3	0	0
07.01.2025 00:30	73	Umude S.	MIL	3	2	0	321	1	1	0	0	1	1	0	0	-4	1	1	1	0	0	0	0	0
07.01.2025 00:30	74	Wright D.	MIL	3	0	0	236	1	2	0	0	1	2	0	0	-5	0	0	1	0	0	1	0	0
07.01.2025 00:30	75	Beauchamp M.	MIL	2	0	0	396	1	3	0	0	0	2	0	0	-5	0	0	1	0	1	1	0	0
07.01.2025 00:30	76	Connaughton P.	MIL	2	1	1	396	1	2	0	0	0	0	0	0	-5	0	1	1	0	0	0	0	0
07.01.2025 00:30	77	Robbins L.	MIL	1	2	1	376	0	2	0	0	0	0	1	2	-5	1	1	0	0	1	0	0	0
05.01.2025 01:00	78	Antetokounmpo G.	MIL	31	11	2	2300	14	27	0	0	0	1	3	4	-3	2	9	2	2	4	2	0	0
05.01.2025 01:00	79	Green A.	MIL	21	2	3	1801	7	13	0	0	7	13	0	0	4	0	2	2	1	1	0	0	0
05.01.2025 01:00	80	Lillard D.	MIL	16	2	6	2201	5	15	0	0	2	7	4	5	-2	1	1	1	4	3	0	0	0
05.01.2025 01:00	81	Portis B.	MIL	9	7	1	1533	4	11	0	0	1	4	0	0	-5	1	6	3	3	1	0	0	0
05.01.2025 01:00	82	Jackson A.	MIL	6	3	4	868	3	4	0	0	0	0	0	0	-4	2	1	1	2	0	0	0	0
05.01.2025 01:00	83	Lopez B.	MIL	5	6	0	1393	2	9	0	0	1	6	0	0	1	1	5	0	1	1	1	0	0
05.01.2025 01:00	84	Prince T.	MIL	5	3	5	1323	2	5	0	0	1	4	0	0	1	0	3	0	0	0	0	0	0
05.01.2025 01:00	85	Trent G.	MIL	5	2	0	1081	2	5	0	0	1	3	0	0	-4	0	2	2	0	0	0	0	0
05.01.2025 01:00	86	Middleton K.	MIL	2	7	3	1557	1	5	0	0	0	3	0	0	-4	0	7	2	0	1	0	0	0
05.01.2025 01:00	87	Rollins R.	MIL	2	0	1	343	1	1	0	0	0	0	0	0	1	0	0	0	1	0	0	0	0
03.01.2025 01:00	88	Antetokounmpo G.	MIL	27	13	7	2226	12	24	0	0	0	0	3	10	12	3	10	4	1	3	3	0	0
03.01.2025 01:00	89	Lillard D.	MIL	23	3	7	2418	6	20	0	0	4	13	7	8	-4	1	2	2	1	3	0	0	0
03.01.2025 01:00	90	Portis B.	MIL	15	8	0	1691	4	9	0	0	3	4	4	4	-2	1	7	2	0	4	1	0	0
03.01.2025 01:00	91	Middleton K.	MIL	12	3	2	1442	6	11	0	0	0	3	0	0	-18	0	3	0	1	0	0	0	0
03.01.2025 01:00	92	Trent G.	MIL	10	2	0	1262	2	8	0	0	2	7	4	4	-11	1	1	2	1	1	0	0	0
03.01.2025 01:00	93	Prince T.	MIL	8	3	2	1096	3	6	0	0	2	5	0	0	-4	2	1	2	1	1	0	0	0
03.01.2025 01:00	94	Lopez B.	MIL	7	3	1	1361	3	4	0	0	0	1	1	2	-8	1	2	2	0	1	1	0	0
03.01.2025 01:00	95	Rollins R.	MIL	4	2	1	1121	2	4	0	0	0	2	0	0	-12	1	1	4	0	0	0	0	0
03.01.2025 01:00	96	Connaughton P.	MIL	2	4	1	573	1	3	0	0	0	2	0	0	14	2	2	1	1	0	1	0	0
03.01.2025 01:00	97	Jackson A.	MIL	2	2	0	811	1	1	0	0	0	0	0	0	0	1	1	2	0	1	0	0	1
03.01.2025 01:00	98	Beauchamp M.	MIL	0	3	0	399	0	0	0	0	0	0	0	0	18	0	3	0	0	0	0	0	0
31.12.2024 20:00	99	Antetokounmpo G.	MIL	30	12	5	2089	11	20	0	0	0	0	8	13	12	2	10	4	2	2	0	0	0
31.12.2024 20:00	100	Lopez B.	MIL	16	5	3	1428	7	11	0	0	0	3	2	2	-14	1	4	0	0	1	0	0	0
31.12.2024 20:00	101	Middleton K.	MIL	15	6	7	1848	4	11	0	0	1	4	6	6	2	2	4	4	0	4	0	0	0
31.12.2024 20:00	102	Portis B.	MIL	14	15	3	1856	6	14	0	0	0	2	2	2	15	4	11	0	2	0	0	0	0
31.12.2024 20:00	103	Trent G.	MIL	14	2	1	1721	5	9	0	0	4	5	0	0	5	0	2	1	2	0	0	0	0
31.12.2024 20:00	104	Green A.	MIL	9	2	1	979	3	6	0	0	3	6	0	0	8	1	1	5	0	0	0	0	0
31.12.2024 20:00	105	Lillard D.	MIL	9	4	5	2157	3	14	0	0	3	9	0	0	4	2	2	2	2	4	0	0	0
31.12.2024 20:00	106	Prince T.	MIL	9	3	2	1522	4	9	0	0	1	4	0	1	16	1	2	3	2	1	0	0	0
31.12.2024 20:00	107	Jackson A.	MIL	4	2	0	711	2	3	0	0	0	0	0	0	-6	0	2	3	0	0	0	0	0
31.12.2024 20:00	108	Rollins R.	MIL	0	0	0	89	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
29.12.2024 01:00	109	Lillard D.	MIL	29	6	12	2128	8	19	0	0	3	9	10	10	-4	1	5	2	2	0	0	0	0
29.12.2024 01:00	110	Lopez B.	MIL	22	7	3	2254	9	22	0	0	3	11	1	1	-4	1	6	2	0	0	3	0	0
29.12.2024 01:00	111	Middleton K.	MIL	21	6	4	1656	8	15	0	0	4	6	1	1	-4	0	6	4	0	2	0	0	0
29.12.2024 01:00	112	Portis B.	MIL	14	9	4	2035	5	17	0	0	2	7	2	2	-4	3	6	3	2	1	1	0	0
29.12.2024 01:00	113	Rollins R.	MIL	7	7	1	1277	3	6	0	0	1	1	0	0	3	0	7	2	1	0	2	0	0
29.12.2024 01:00	114	Trent G.	MIL	7	2	1	994	3	8	0	0	1	4	0	0	-7	0	2	1	1	2	0	0	0
29.12.2024 01:00	115	Prince T.	MIL	6	3	0	1224	3	8	0	0	0	3	0	0	-1	0	3	1	0	1	0	0	0
29.12.2024 01:00	116	Green A.	MIL	5	2	1	1464	2	4	0	0	1	3	0	0	-2	0	2	1	0	1	1	0	0
29.12.2024 01:00	117	Jackson A.	MIL	0	1	1	1368	0	3	0	0	0	1	0	0	-2	1	0	0	0	0	0	0	0
27.12.2024 01:00	118	Middleton K.	MIL	21	5	5	1571	8	13	0	0	3	6	2	3	-9	0	5	4	1	7	0	0	0
27.12.2024 01:00	119	Lopez B.	MIL	20	7	2	2039	8	12	0	0	4	5	0	0	-8	2	5	2	2	1	2	0	0
27.12.2024 01:00	120	Portis B.	MIL	18	8	4	2119	7	16	0	0	0	4	4	4	-16	2	6	3	2	4	0	0	0
27.12.2024 01:00	121	Trent G.	MIL	14	3	0	1300	6	10	0	0	2	2	0	0	3	0	3	0	3	3	0	0	0
27.12.2024 01:00	122	Prince T.	MIL	9	3	0	1403	3	9	0	0	3	6	0	2	5	0	3	2	0	1	0	0	0
27.12.2024 01:00	123	Green A.	MIL	8	6	2	1755	3	8	0	0	2	7	0	0	2	1	5	1	0	0	0	0	0
27.12.2024 01:00	124	Jackson A.	MIL	8	3	2	1381	3	5	0	0	0	0	2	3	0	1	2	1	0	1	0	0	0
27.12.2024 01:00	125	Rollins R.	MIL	7	4	3	1741	3	7	0	0	1	5	0	0	-12	2	2	4	3	4	1	0	0
27.12.2024 01:00	126	Wright D.	MIL	0	0	5	1091	0	3	0	0	0	3	0	0	5	0	0	1	1	1	0	0	0
24.12.2024 01:00	127	Lopez B.	MIL	21	2	1	2182	7	12	0	0	3	6	4	4	14	1	1	1	0	0	0	0	0
24.12.2024 01:00	128	Middleton K.	MIL	21	5	5	1402	9	15	0	0	3	5	0	0	15	0	5	2	1	4	0	0	0
24.12.2024 01:00	129	Portis B.	MIL	19	13	6	1938	7	18	0	0	2	6	3	4	15	1	12	3	0	1	0	0	0
24.12.2024 01:00	130	Trent G.	MIL	14	4	0	999	5	10	0	0	4	6	0	0	16	1	3	2	1	0	0	0	0
24.12.2024 01:00	131	Green A.	MIL	10	2	3	1475	3	8	0	0	1	5	3	3	18	0	2	1	0	1	0	0	0
24.12.2024 01:00	132	Wright D.	MIL	9	4	5	1541	3	6	0	0	2	4	1	2	20	1	3	2	2	2	0	0	0
24.12.2024 01:00	133	Rollins R.	MIL	8	5	1	1339	3	6	0	0	2	3	0	0	1	0	5	2	2	2	1	0	0
24.12.2024 01:00	134	Jackson A.	MIL	4	5	1	1390	1	2	0	0	1	1	1	2	3	1	4	1	0	0	0	0	0
24.12.2024 01:00	135	Prince T.	MIL	4	5	2	1390	1	7	0	0	0	5	2	2	10	1	4	1	1	2	0	0	0
24.12.2024 01:00	136	Smith T.	MIL	2	2	0	218	1	1	0	0	0	0	0	0	-1	0	2	0	0	0	0	0	0
24.12.2024 01:00	137	Beauchamp M.	MIL	0	0	0	218	0	1	0	0	0	1	0	0	-1	0	0	0	0	1	0	0	0
24.12.2024 01:00	138	Robbins L.	MIL	0	2	0	218	0	0	0	0	0	0	0	0	-1	1	1	0	0	0	0	0	0
24.12.2024 01:00	139	Umude S.	MIL	0	0	0	90	0	1	0	0	0	1	0	0	-4	0	0	1	0	0	0	0	0
\.


--
-- Data for Name: milwaukee_bucks_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.milwaukee_bucks_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Trent Gary	Lesionado	2025-01-16 10:46:03.818542
2	Middleton Khris	Lesionado	2025-01-16 10:46:03.821846
\.


--
-- Data for Name: minnesota_timberwolves; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.minnesota_timberwolves (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	31.05.2024	Minnesota Timberwolves	103	Dallas Mavericks	124	19	21	33	30	35	34	28	27
2	12.07.2024	Minnesota Timberwolves	81	New Orleans Pelicans	74	24	21	17	19	23	17	16	18
3	14.07.2024	Indiana Pacers	94	Minnesota Timberwolves	105	28	16	27	23	26	25	27	27
4	17.07.2024	Minnesota Timberwolves	90	Philadelphia 76ers	92	22	24	14	30	25	23	28	16
5	19.07.2024	Houston Rockets	83	Minnesota Timberwolves	93	16	23	22	22	29	17	18	29
6	21.07.2024	Minnesota Timberwolves	115	Orlando Magic	100	36	23	21	35	20	28	26	26
7	05.10.2024	Los Angeles Lakers	107	Minnesota Timberwolves	124	23	26	39	19	36	22	37	29
8	12.10.2024	Minnesota Timberwolves	121	Philadelphia 76ers	111	30	40	25	26	22	31	34	24
9	13.10.2024	New York Knicks	115	Minnesota Timberwolves	110	26	29	33	27	21	36	26	27
10	17.10.2024	Chicago Bulls	125	Minnesota Timberwolves	123	30	41	27	27	33	25	32	33
11	18.10.2024	Minnesota Timberwolves	126	Denver Nuggets	132	22	37	32	35	25	43	29	35
12	23.10.2024	Los Angeles Lakers	110	Minnesota Timberwolves	103	22	33	27	28	23	19	32	29
13	25.10.2024	Sacramento Kings	115	Minnesota Timberwolves	117	32	27	29	27	29	26	34	28
14	27.10.2024	Minnesota Timberwolves	112	Toronto Raptors	101	32	24	33	23	18	26	28	29
15	29.10.2024	Minnesota Timberwolves	114	Dallas Mavericks	120	34	25	23	32	26	35	32	27
16	02.11.2024	Minnesota Timberwolves	119	Denver Nuggets	116	33	31	27	28	29	32	24	31
17	03.11.2024	San Antonio Spurs	113	Minnesota Timberwolves	103	32	30	33	18	32	25	25	21
18	05.11.2024	Minnesota Timberwolves	114	Charlotte Hornets	93	24	33	34	23	24	21	26	22
19	08.11.2024	Chicago Bulls	119	Minnesota Timberwolves	135	34	31	30	24	28	28	34	45
20	09.11.2024	Minnesota Timberwolves	127	Portland Trail Blazers	102	35	29	34	29	17	34	24	27
21	11.11.2024	Minnesota Timberwolves	94	Miami Heat	95	20	31	20	23	27	25	16	27
22	13.11.2024	Portland Trail Blazers	122	Minnesota Timberwolves	108	28	32	33	29	17	36	21	34
23	14.11.2024	Portland Trail Blazers	106	Minnesota Timberwolves	98	23	25	28	30	33	15	28	22
24	16.11.2024\nApós Prol.	Sacramento Kings	126	Minnesota Timberwolves	130	27	27	28	33	32	30	36	17
25	17.11.2024	Minnesota Timberwolves	120	Phoenix Suns	117	22	32	32	34	31	33	26	27
26	22.11.2024	Toronto Raptors	110	Minnesota Timberwolves	105	32	20	25	33	27	24	28	26
27	24.11.2024	Boston Celtics	107	Minnesota Timberwolves	105	24	31	29	23	27	25	21	32
28	27.11.2024\nApós Prol.	Minnesota Timberwolves	111	Houston Rockets	117	26	21	31	24	32	25	27	18
29	28.11.2024	Minnesota Timberwolves	104	Sacramento Kings	115	33	24	29	18	31	38	12	34
30	30.11.2024	Minnesota Timberwolves	93	Los Angeles Clippers	92	26	27	19	21	25	22	21	24
31	03.12.2024	Minnesota Timberwolves	109	Los Angeles Lakers	80	22	34	23	30	20	24	20	16
32	05.12.2024	Los Angeles Clippers	80	Minnesota Timberwolves	108	14	18	18	30	33	26	27	22
33	07.12.2024	Golden State Warriors	90	Minnesota Timberwolves	107	31	15	26	18	31	25	22	29
34	09.12.2024	Golden State Warriors	114	Minnesota Timberwolves	106	21	28	44	21	30	28	32	16
35	14.12.2024	Minnesota Timberwolves	97	Los Angeles Lakers	87	32	18	27	20	23	21	22	21
36	16.12.2024	San Antonio Spurs	92	Minnesota Timberwolves	106	19	18	33	22	28	24	24	30
37	20.12.2024	Minnesota Timberwolves	107	New York Knicks	133	33	18	23	33	32	41	31	29
38	22.12.2024	Minnesota Timberwolves	103	Golden State Warriors	113	15	22	38	28	26	24	29	34
39	24.12.2024	Atlanta Hawks	117	Minnesota Timberwolves	104	35	17	30	35	19	36	30	19
40	25.12.2024	Dallas Mavericks	99	Minnesota Timberwolves	105	24	16	28	31	26	31	33	15
41	28.12.2024	Houston Rockets	112	Minnesota Timberwolves	113	21	31	32	28	22	35	19	37
42	30.12.2024	Minnesota Timberwolves	112	San Antonio Spurs	110	25	32	25	30	33	12	37	28
43	01.01. 01:00	Oklahoma City Thunder	113	Minnesota Timberwolves	105	21	25	43	24	24	28	23	30
44	03.01. 00:30	Minnesota Timberwolves	115	Boston Celtics	118	35	16	34	30	28	34	29	27
45	05.01. 00:00	Detroit Pistons	119	Minnesota Timberwolves	105	33	22	41	23	28	15	38	24
46	07.01. 01:00	Minnesota Timberwolves	108	Los Angeles Clippers	106	16	30	31	31	27	26	23	30
47	08.01. 01:00	New Orleans Pelicans	97	Minnesota Timberwolves	104	33	21	21	22	34	20	29	21
48	10.01. 00:00	Orlando Magic	89	Minnesota Timberwolves	104	18	21	23	27	29	23	26	26
49	12.01. 01:00	Minnesota Timberwolves	125	Memphis Grizzlies	127	33	32	38	22	35	29	35	28
50	14.01. 00:00	Washington Wizards	106	Minnesota Timberwolves	120	20	27	32	27	25	26	31	38
51	16.01. 02:30	Minnesota Timberwolves	115	Golden State Warriors	116	12	30	36	37	34	21	32	29
\.


--
-- Data for Name: minnesota_timberwolves_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.minnesota_timberwolves_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 02:30	1	DiVincenzo D.	MIN	28	6	9	2354	9	19	0	0	6	12	4	6	0	4	2	3	1	0	0	0	0
16.01.2025 02:30	2	Edwards A.	MIN	28	8	2	2454	7	19	0	0	4	9	10	11	-2	1	7	1	1	5	1	0	0
16.01.2025 02:30	3	Randle J.	MIN	17	6	1	1644	8	18	0	0	1	3	0	0	-2	4	2	3	1	2	0	0	0
16.01.2025 02:30	4	Reid N.	MIN	15	6	1	1719	5	13	0	0	3	7	2	2	8	2	4	0	0	0	1	0	0
16.01.2025 02:30	5	McDaniels J.	MIN	14	4	4	2132	6	9	0	0	2	3	0	1	-8	3	1	5	1	0	2	0	0
16.01.2025 02:30	6	Gobert R.	MIN	7	10	1	1769	2	2	0	0	0	0	3	5	-4	2	8	2	0	1	2	0	0
16.01.2025 02:30	7	Alexander-Walker N.	MIN	5	1	0	1217	1	3	0	0	1	1	2	2	6	0	1	2	0	1	0	0	0
16.01.2025 02:30	8	Conley M.	MIN	1	0	3	1111	0	3	0	0	0	2	1	2	-3	0	0	1	0	0	1	0	0
14.01.2025 00:00	9	Edwards A.	MIN	41	6	7	2184	14	25	0	0	5	11	8	8	18	2	4	2	3	7	1	0	0
14.01.2025 00:00	10	Randle J.	MIN	20	10	3	1964	8	15	0	0	0	2	4	8	16	3	7	1	0	3	0	0	0
14.01.2025 00:00	11	DiVincenzo D.	MIN	13	3	0	1733	4	15	0	0	3	11	2	2	4	2	1	1	1	3	0	0	0
14.01.2025 00:00	12	Reid N.	MIN	12	5	1	1435	3	5	0	0	3	4	3	4	7	0	5	4	3	0	1	0	0
14.01.2025 00:00	13	Gobert R.	MIN	11	11	2	1954	5	6	0	0	0	0	1	2	11	5	6	1	1	0	1	0	0
14.01.2025 00:00	14	McDaniels J.	MIN	8	8	0	1818	3	8	0	0	0	3	2	2	7	2	6	1	0	2	1	0	0
14.01.2025 00:00	15	Conley M.	MIN	7	5	4	1219	1	3	0	0	1	2	4	5	4	0	5	2	0	1	1	0	0
14.01.2025 00:00	16	Alexander-Walker N.	MIN	6	3	3	1384	2	3	0	0	2	3	0	0	20	0	3	1	0	1	1	0	0
14.01.2025 00:00	17	Minott J.	MIN	2	0	0	409	1	2	0	0	0	1	0	0	-5	0	0	0	0	0	0	0	0
14.01.2025 00:00	18	Clark J.	MIN	0	0	0	75	0	0	0	0	0	0	0	0	-3	0	0	0	0	0	0	0	0
14.01.2025 00:00	19	Garza L.	MIN	0	0	0	75	0	1	0	0	0	0	0	0	-3	0	0	1	0	0	0	0	0
14.01.2025 00:00	20	Miller L.	MIN	0	1	0	75	0	0	0	0	0	0	0	0	-3	0	1	0	0	1	0	0	0
14.01.2025 00:00	21	Newton T.	MIN	0	1	0	75	0	0	0	0	0	0	0	0	-3	0	1	1	0	0	0	0	0
12.01.2025 01:00	22	DiVincenzo D.	MIN	27	10	7	2173	9	14	0	0	6	11	3	3	-1	1	9	2	2	3	0	0	0
12.01.2025 01:00	23	McDaniels J.	MIN	21	6	1	1775	9	12	0	0	3	4	0	0	1	1	5	2	3	1	2	0	0
12.01.2025 01:00	24	Reid N.	MIN	19	6	3	1776	7	10	0	0	5	7	0	0	2	1	5	1	0	2	1	0	0
12.01.2025 01:00	25	Randle J.	MIN	18	8	8	2000	7	13	0	0	1	5	3	4	-5	2	6	3	0	4	0	0	0
12.01.2025 01:00	26	Edwards A.	MIN	15	5	6	2358	4	13	0	0	0	5	7	7	-5	0	5	3	1	6	0	1	0
12.01.2025 01:00	27	Gobert R.	MIN	12	4	4	1720	6	6	0	0	0	0	0	2	3	2	2	3	0	0	1	0	0
12.01.2025 01:00	28	Alexander-Walker N.	MIN	8	2	6	1557	3	10	0	0	1	7	1	3	0	0	2	0	1	1	0	0	0
12.01.2025 01:00	29	Conley M.	MIN	3	0	2	920	1	4	0	0	1	3	0	0	0	0	0	0	0	1	0	0	0
12.01.2025 01:00	30	Minott J.	MIN	2	0	0	121	1	1	0	0	0	0	0	0	-5	0	0	2	0	0	1	0	0
10.01.2025 00:00	31	Randle J.	MIN	23	10	2	1854	8	16	0	0	1	3	6	6	13	4	6	2	0	2	0	0	0
10.01.2025 00:00	32	Edwards A.	MIN	21	3	7	2182	5	19	0	0	4	11	7	9	20	1	2	2	2	2	0	0	0
10.01.2025 00:00	33	Reid N.	MIN	16	3	1	1389	5	9	0	0	2	4	4	6	14	0	3	1	2	0	1	0	0
10.01.2025 00:00	34	DiVincenzo D.	MIN	12	2	4	1468	4	10	0	0	4	7	0	1	-1	1	1	0	2	3	0	0	0
10.01.2025 00:00	35	Gobert R.	MIN	10	12	1	1901	5	8	0	0	0	0	0	2	14	4	8	2	1	0	0	0	0
10.01.2025 00:00	36	Conley M.	MIN	9	4	2	1384	3	7	0	0	1	2	2	2	23	0	4	0	2	1	0	0	0
10.01.2025 00:00	37	McDaniels J.	MIN	7	8	1	1899	1	4	0	0	0	2	5	5	12	2	6	4	0	0	1	0	0
10.01.2025 00:00	38	Garza L.	MIN	4	0	0	188	2	2	0	0	0	0	0	0	-5	0	0	1	0	0	0	0	0
10.01.2025 00:00	39	Alexander-Walker N.	MIN	2	6	3	1296	1	5	0	0	0	2	0	0	2	1	5	2	0	0	0	0	0
10.01.2025 00:00	40	Clark J.	MIN	0	0	0	188	0	1	0	0	0	1	0	0	-5	0	0	1	0	0	0	0	0
10.01.2025 00:00	41	Miller L.	MIN	0	2	0	188	0	2	0	0	0	1	0	0	-5	1	1	1	0	0	0	0	0
10.01.2025 00:00	42	Minott J.	MIN	0	0	0	463	0	2	0	0	0	1	0	0	-7	0	0	3	0	0	1	0	0
08.01.2025 01:00	43	Edwards A.	MIN	32	9	3	2303	10	21	0	0	7	11	5	6	3	1	8	3	2	4	0	0	0
08.01.2025 01:00	44	Randle J.	MIN	16	6	3	2119	6	11	0	0	1	4	3	5	21	0	6	4	2	3	0	0	0
08.01.2025 01:00	45	Reid N.	MIN	13	12	1	1361	6	16	0	0	1	5	0	1	0	6	6	2	0	3	1	0	1
08.01.2025 01:00	46	Alexander-Walker N.	MIN	11	1	2	1050	4	9	0	0	2	6	1	1	9	0	1	1	0	0	0	0	0
08.01.2025 01:00	47	DiVincenzo D.	MIN	10	2	7	1722	4	12	0	0	2	8	0	0	18	0	2	0	3	3	0	0	0
08.01.2025 01:00	48	Conley M.	MIN	8	4	6	1484	2	4	0	0	1	3	3	4	-12	1	3	1	0	1	0	0	0
08.01.2025 01:00	49	Gobert R.	MIN	7	14	4	2125	3	4	0	0	0	0	1	2	-6	2	12	4	0	2	6	0	0
08.01.2025 01:00	50	McDaniels J.	MIN	5	3	0	1871	2	9	0	0	1	6	0	0	0	0	3	2	2	0	1	0	0
08.01.2025 01:00	51	Minott J.	MIN	2	2	0	365	1	3	0	0	0	1	0	0	2	1	1	0	0	0	0	0	0
07.01.2025 01:00	52	Edwards A.	MIN	37	7	8	2230	14	29	0	0	6	13	3	4	4	1	6	2	1	2	0	0	1
07.01.2025 01:00	53	Reid N.	MIN	18	7	3	1874	8	14	0	0	1	5	1	3	-10	1	6	5	1	1	2	0	0
07.01.2025 01:00	54	DiVincenzo D.	MIN	15	9	1	1871	5	12	0	0	3	8	2	2	1	1	8	3	0	2	0	0	0
07.01.2025 01:00	55	Conley M.	MIN	11	4	3	1583	4	8	0	0	2	3	1	1	11	1	3	1	1	1	0	0	0
07.01.2025 01:00	56	McDaniels J.	MIN	11	2	2	1992	4	5	0	0	3	3	0	0	8	0	2	0	2	0	1	0	0
07.01.2025 01:00	57	Gobert R.	MIN	8	18	2	2271	3	8	0	0	0	0	2	5	8	8	10	3	0	2	1	0	0
07.01.2025 01:00	58	Randle J.	MIN	5	6	2	1397	2	10	0	0	0	3	1	2	2	4	2	4	0	3	0	0	0
07.01.2025 01:00	59	Alexander-Walker N.	MIN	3	2	2	909	1	5	0	0	1	3	0	0	-7	1	1	1	0	2	1	0	0
07.01.2025 01:00	60	Ingles J.	MIN	0	0	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0
07.01.2025 01:00	61	Minott J.	MIN	0	0	1	271	0	1	0	0	0	1	0	0	-8	0	0	1	1	1	0	0	0
05.01.2025 00:00	62	Edwards A.	MIN	53	6	2	2667	16	31	0	0	10	15	11	12	-3	1	5	4	0	6	0	0	0
05.01.2025 00:00	63	Randle J.	MIN	17	7	6	2169	6	12	0	0	0	4	5	5	-20	2	5	4	0	3	0	0	0
05.01.2025 00:00	64	Reid N.	MIN	9	3	1	1529	2	7	0	0	2	4	3	4	-7	0	3	2	0	0	0	0	0
05.01.2025 00:00	65	McDaniels J.	MIN	8	5	0	1742	3	6	0	0	1	2	1	1	-2	1	4	4	3	1	0	0	0
05.01.2025 00:00	66	Alexander-Walker N.	MIN	7	2	3	1682	2	8	0	0	2	7	1	2	-8	0	2	3	0	0	2	0	0
05.01.2025 00:00	67	Gobert R.	MIN	6	6	0	1772	3	6	0	0	0	0	0	2	-2	2	4	2	0	3	2	0	0
05.01.2025 00:00	68	DiVincenzo D.	MIN	5	4	3	1570	2	6	0	0	1	5	0	0	-10	1	3	1	2	3	0	0	0
05.01.2025 00:00	69	Conley M.	MIN	0	0	5	1269	0	4	0	0	0	3	0	0	-18	0	0	1	2	1	0	0	0
03.01.2025 00:30	70	Randle J.	MIN	27	8	7	2350	9	16	0	0	5	7	4	4	10	2	6	1	1	4	0	0	0
03.01.2025 00:30	71	Reid N.	MIN	20	5	3	1533	6	11	0	0	4	5	4	4	-4	3	2	1	0	2	0	0	0
03.01.2025 00:30	72	McDaniels J.	MIN	19	8	2	2126	6	12	0	0	4	8	3	3	-6	2	6	1	0	3	0	0	0
03.01.2025 00:30	73	Edwards A.	MIN	15	4	6	2173	5	16	0	0	2	9	3	4	-10	0	4	0	0	2	0	0	0
03.01.2025 00:30	74	DiVincenzo D.	MIN	12	3	3	1715	3	5	0	0	3	5	3	3	-7	0	3	5	0	2	0	0	0
03.01.2025 00:30	75	Minott J.	MIN	7	1	0	679	2	3	0	0	1	2	2	2	7	0	1	1	0	1	2	0	0
03.01.2025 00:30	76	Gobert R.	MIN	6	7	0	1670	3	5	0	0	0	0	0	0	-6	3	4	1	0	0	0	0	0
03.01.2025 00:30	77	Conley M.	MIN	5	2	3	1138	2	4	0	0	1	2	0	0	1	1	1	0	0	1	0	0	0
03.01.2025 00:30	78	Alexander-Walker N.	MIN	4	3	0	1016	1	2	0	0	1	1	1	2	0	0	3	1	0	0	0	0	0
01.01.2025 01:00	79	Edwards A.	MIN	20	7	2	2329	6	12	0	0	4	7	4	4	-3	0	7	3	0	3	1	0	0
01.01.2025 01:00	80	Reid N.	MIN	19	8	1	1975	8	14	0	0	1	5	2	2	-8	2	6	4	1	4	3	0	0
01.01.2025 01:00	81	Conley M.	MIN	16	1	4	1399	5	10	0	0	4	7	2	2	-2	1	0	1	2	1	0	0	0
01.01.2025 01:00	82	Randle J.	MIN	11	6	6	1631	5	12	0	0	1	4	0	0	-7	4	2	1	0	4	1	0	0
01.01.2025 01:00	83	DiVincenzo D.	MIN	10	4	5	1790	3	10	0	0	2	7	2	2	-6	1	3	2	0	2	0	0	0
01.01.2025 01:00	84	Alexander-Walker N.	MIN	8	4	1	1163	3	3	0	0	2	2	0	0	-12	0	4	3	0	5	0	0	0
01.01.2025 01:00	85	Gobert R.	MIN	8	7	1	1865	3	6	0	0	0	0	2	2	3	2	5	2	0	1	2	0	0
01.01.2025 01:00	86	McDaniels J.	MIN	7	6	0	1664	3	8	0	0	1	5	0	0	0	0	6	2	0	3	0	0	0
01.01.2025 01:00	87	Minott J.	MIN	6	0	1	584	3	4	0	0	0	1	0	0	-5	0	0	0	0	0	0	0	0
30.12.2024 02:00	88	DiVincenzo D.	MIN	26	7	4	2021	8	15	0	0	5	10	5	6	23	1	6	1	1	2	0	0	0
30.12.2024 02:00	89	Gobert R.	MIN	17	15	2	1833	6	12	0	0	0	0	5	6	-1	11	4	4	0	1	2	0	0
30.12.2024 02:00	90	Randle J.	MIN	16	4	4	2086	7	16	0	0	0	7	2	2	-9	1	3	1	0	1	0	0	0
30.12.2024 02:00	91	Edwards A.	MIN	14	8	4	2292	6	20	0	0	1	9	1	1	2	1	7	1	0	2	1	0	0
30.12.2024 02:00	92	McDaniels J.	MIN	12	10	1	1924	6	12	0	0	0	4	0	0	-4	4	6	5	1	2	1	0	0
30.12.2024 02:00	93	Reid N.	MIN	11	4	2	1232	5	11	0	0	1	4	0	2	4	0	4	4	1	0	1	0	0
30.12.2024 02:00	94	Alexander-Walker N.	MIN	6	2	2	956	2	5	0	0	2	4	0	0	6	0	2	2	1	2	0	0	0
30.12.2024 02:00	95	Conley M.	MIN	5	2	3	1370	1	5	0	0	1	4	2	2	-11	0	2	3	0	0	0	0	0
30.12.2024 02:00	96	Minott J.	MIN	5	4	1	686	2	4	0	0	1	2	0	0	0	0	4	2	0	0	0	0	0
28.12.2024 01:00	97	Randle J.	MIN	27	8	8	2171	10	16	0	0	5	6	2	2	2	1	7	3	0	5	1	0	0
28.12.2024 01:00	98	Edwards A.	MIN	24	5	3	2118	9	17	0	0	4	8	2	3	-1	0	5	3	0	3	1	0	0
28.12.2024 01:00	99	DiVincenzo D.	MIN	22	4	4	2197	7	12	0	0	6	10	2	2	11	0	4	2	2	2	1	0	0
28.12.2024 01:00	100	Reid N.	MIN	14	2	1	1466	6	12	0	0	1	5	1	3	14	1	1	6	1	2	1	0	0
28.12.2024 01:00	101	Alexander-Walker N.	MIN	11	4	5	1755	4	9	0	0	3	7	0	0	13	0	4	1	0	0	0	0	0
28.12.2024 01:00	102	Gobert R.	MIN	7	9	0	1717	3	5	0	0	0	0	1	6	-18	5	4	2	0	0	2	0	0
28.12.2024 01:00	103	Conley M.	MIN	3	2	2	1419	1	5	0	0	1	4	0	0	-17	1	1	0	2	0	0	0	0
28.12.2024 01:00	104	Minott J.	MIN	3	0	1	349	1	1	0	0	1	1	0	0	6	0	0	1	1	0	0	0	0
28.12.2024 01:00	105	McDaniels J.	MIN	2	5	1	1208	1	6	0	0	0	2	0	0	-5	1	4	4	3	2	0	0	0
25.12.2024 19:30	106	Edwards A.	MIN	26	8	5	2353	11	24	0	0	4	7	0	0	8	1	7	0	2	4	1	0	0
25.12.2024 19:30	107	Randle J.	MIN	23	10	8	2054	6	13	0	0	3	5	8	10	5	2	8	2	0	3	0	0	0
25.12.2024 19:30	108	Gobert R.	MIN	14	10	0	2367	6	7	0	0	0	0	2	2	8	2	8	3	1	1	2	0	0
25.12.2024 19:30	109	DiVincenzo D.	MIN	11	3	1	1481	4	10	0	0	3	7	0	0	0	0	3	1	0	1	0	0	0
25.12.2024 19:30	110	Conley M.	MIN	10	2	3	1540	4	9	0	0	1	5	1	1	1	0	2	2	1	0	0	0	0
25.12.2024 19:30	111	Alexander-Walker N.	MIN	8	3	2	900	3	7	0	0	2	4	0	0	1	0	3	2	1	0	0	0	0
25.12.2024 19:30	112	Reid N.	MIN	6	2	2	1317	3	6	0	0	0	0	0	0	-3	0	2	1	1	1	0	0	0
25.12.2024 19:30	113	McDaniels J.	MIN	5	6	2	2076	2	7	0	0	1	2	0	0	4	3	3	3	2	0	1	0	0
25.12.2024 19:30	114	Minott J.	MIN	2	2	0	312	1	3	0	0	0	2	0	0	6	0	2	0	0	0	1	0	0
\.


--
-- Data for Name: minnesota_timberwolves_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.minnesota_timberwolves_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Shannon Jr. Terrence	Lesionado	2025-01-16 10:46:18.425822
\.


--
-- Data for Name: nba_classificacao; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.nba_classificacao (id, rank, team_name) FROM stdin;
1	1	Oklahoma City Thunder
2	2	Houston Rockets
3	3	Memphis Grizzlies
4	4	Denver Nuggets
5	5	Los Angeles Clippers
6	6	Los Angeles Lakers
7	7	Dallas Mavericks
8	8	Minnesota Timberwolves
9	9	Sacramento Kings
10	10	Golden State Warriors
11	11	Phoenix Suns
12	12	San Antonio Spurs
13	13	Portland Trail Blazers
14	14	Utah Jazz
15	15	New Orleans Pelicans
16	1	Cleveland Cavaliers
17	2	Boston Celtics
18	3	New York Knicks
19	4	Milwaukee Bucks
20	5	Orlando Magic
21	6	Indiana Pacers
22	7	Atlanta Hawks
23	8	Miami Heat
24	9	Detroit Pistons
25	10	Chicago Bulls
26	11	Philadelphia 76ers
27	12	Brooklyn Nets
28	13	Toronto Raptors
29	14	Charlotte Hornets
30	15	Washington Wizards
\.


--
-- Data for Name: new_orleans_pelicans; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.new_orleans_pelicans (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	27.04.2024	New Orleans Pelicans	85	Oklahoma City Thunder	106	19	27	23	16	23	37	25	21
2	30.04.2024	New Orleans Pelicans	89	Oklahoma City Thunder	97	21	22	28	18	21	23	26	27
3	12.07.2024	Minnesota Timberwolves	81	New Orleans Pelicans	74	24	21	17	19	23	17	16	18
4	15.07.2024	New Orleans Pelicans	86	Orlando Magic	91	21	24	22	19	21	14	25	31
5	17.07.2024	San Antonio Spurs	90	New Orleans Pelicans	85	21	24	22	23	21	20	19	25
6	18.07.2024	New Orleans Pelicans	77	Memphis Grizzlies	88	25	18	16	18	25	18	23	22
7	21.07.2024	Denver Nuggets	91	New Orleans Pelicans	82	29	13	26	23	8	26	19	29
8	07.10.2024	New Orleans Pelicans	106	Orlando Magic	104	31	25	25	25	28	26	21	29
9	13.10.2024	Miami Heat	101	New Orleans Pelicans	99	22	34	22	23	20	29	18	32
10	16.10.2024	Houston Rockets	118	New Orleans Pelicans	98	30	34	26	28	23	27	33	15
11	24.10.2024	New Orleans Pelicans	123	Chicago Bulls	111	29	30	36	28	25	33	25	28
12	26.10.2024	Portland Trail Blazers	103	New Orleans Pelicans	105	27	20	37	19	15	22	38	30
13	27.10.2024	Portland Trail Blazers	125	New Orleans Pelicans	103	26	33	34	32	25	22	30	26
14	30.10.2024	Golden State Warriors	124	New Orleans Pelicans	106	14	33	40	37	31	20	28	27
15	31.10.2024	Golden State Warriors	104	New Orleans Pelicans	89	28	20	31	25	20	24	22	23
16	02.11.2024	New Orleans Pelicans	125	Indiana Pacers	118	35	27	33	30	35	27	27	29
17	04.11.2024	New Orleans Pelicans	111	Atlanta Hawks	126	30	29	26	26	33	25	35	33
18	05.11.2024	New Orleans Pelicans	100	Portland Trail Blazers	118	30	25	27	18	21	27	31	39
19	07.11.2024	New Orleans Pelicans	122	Cleveland Cavaliers	131	34	25	29	34	29	30	40	32
20	09.11.2024	Orlando Magic	115	New Orleans Pelicans	88	37	20	28	30	23	24	25	16
21	12.11.2024	New Orleans Pelicans	105	Brooklyn Nets	107	22	34	29	20	26	28	27	26
22	14.11.2024	Oklahoma City Thunder	106	New Orleans Pelicans	88	33	21	28	24	28	22	18	20
23	16.11.2024	New Orleans Pelicans	101	Denver Nuggets	94	32	27	19	23	22	32	18	22
24	17.11.2024	New Orleans Pelicans	99	Los Angeles Lakers	104	30	26	15	28	21	25	29	29
25	20.11.2024	Dallas Mavericks	132	New Orleans Pelicans	91	44	19	34	35	29	22	18	22
26	21.11.2024	Cleveland Cavaliers	128	New Orleans Pelicans	100	29	40	36	23	24	31	18	27
27	23.11.2024	New Orleans Pelicans	108	Golden State Warriors	112	30	33	21	24	34	28	25	25
28	26.11.2024	Indiana Pacers	114	New Orleans Pelicans	110	29	30	28	27	25	32	26	27
29	28.11.2024	New Orleans Pelicans	93	Toronto Raptors	119	20	26	17	30	21	35	31	32
30	29.11.2024	Memphis Grizzlies	120	New Orleans Pelicans	109	32	35	25	28	28	28	26	27
31	01.12.2024	New York Knicks	118	New Orleans Pelicans	85	33	24	36	25	10	18	28	29
32	03.12.2024	Atlanta Hawks	124	New Orleans Pelicans	112	26	32	34	32	28	31	26	27
33	06.12.2024	New Orleans Pelicans	126	Phoenix Suns	124	34	20	45	27	33	32	28	31
34	08.12.2024	New Orleans Pelicans	109	Oklahoma City Thunder	119	23	28	29	29	35	42	22	20
35	09.12.2024	San Antonio Spurs	121	New Orleans Pelicans	116	28	43	21	29	34	28	25	29
36	13.12.2024	New Orleans Pelicans	109	Sacramento Kings	111	26	29	28	26	28	25	38	20
37	15.12.2024	Indiana Pacers	119	New Orleans Pelicans	104	31	28	40	20	28	14	38	24
38	20.12.2024	Houston Rockets	133	New Orleans Pelicans	113	39	27	33	34	25	27	27	34
39	22.12.2024	New Orleans Pelicans	93	New York Knicks	104	28	21	26	18	28	17	33	26
40	23.12.2024\nApós Prol.	New Orleans Pelicans	129	Denver Nuggets	132	29	38	26	26	28	31	22	38
41	27.12.2024	New Orleans Pelicans	111	Houston Rockets	128	22	21	31	37	39	22	41	26
42	28.12.2024	New Orleans Pelicans	124	Memphis Grizzlies	132	25	36	27	36	32	42	30	28
43	31.12.2024	New Orleans Pelicans	113	Los Angeles Clippers	116	37	25	28	23	31	25	31	29
44	02.01. 00:30	Miami Heat	119	New Orleans Pelicans	108	36	20	34	29	24	27	25	32
45	04.01. 01:00	New Orleans Pelicans	132	Washington Wizards	120	29	33	35	35	37	31	29	23
46	05.01. 23:00	Washington Wizards	98	New Orleans Pelicans	110	22	23	25	28	33	27	24	26
47	08.01. 01:00	New Orleans Pelicans	97	Minnesota Timberwolves	104	33	21	21	22	34	20	29	21
48	09.01. 01:00	New Orleans Pelicans	100	Portland Trail Blazers	119	24	18	34	24	40	35	23	21
49	11.01. 00:00	Philadelphia 76ers	115	New Orleans Pelicans	123	24	23	31	37	28	25	34	36
50	12.01. 23:00	Boston Celtics	120	New Orleans Pelicans	119	29	33	28	30	35	26	27	31
51	15.01. 01:00	Chicago Bulls	113	New Orleans Pelicans	119	33	26	27	27	29	24	33	33
52	16.01. 01:00	New Orleans Pelicans	119	Dallas Mavericks	116	33	30	24	32	27	34	30	25
\.


--
-- Data for Name: new_orleans_pelicans_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.new_orleans_pelicans_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 01:00	1	Murray D.	NOP	30	7	7	1981	10	22	0	0	4	10	6	8	9	0	7	1	2	2	0	0	0
16.01.2025 01:00	2	Murphy T.	NOP	24	10	4	2305	7	18	0	0	2	6	8	8	13	6	4	2	1	2	3	0	0
16.01.2025 01:00	3	Green J.	NOP	13	7	1	1619	4	7	0	0	3	5	2	2	8	1	6	4	1	1	0	0	0
16.01.2025 01:00	4	Hawkins J.	NOP	12	3	2	1286	5	9	0	0	2	5	0	0	-9	1	2	2	3	1	0	0	0
16.01.2025 01:00	5	Missi Y.	NOP	12	6	0	1735	5	7	0	0	0	0	2	4	9	3	3	3	1	1	2	0	0
16.01.2025 01:00	6	McCollum C.	NOP	11	0	2	2010	4	14	0	0	1	7	2	2	10	0	0	0	1	2	2	0	0
16.01.2025 01:00	7	Boston B.	NOP	9	3	1	897	4	8	0	0	1	2	0	0	-5	0	3	1	0	0	0	0	0
16.01.2025 01:00	8	Robinson J.	NOP	4	7	1	537	2	3	0	0	0	1	0	0	-6	2	5	2	0	0	0	0	0
16.01.2025 01:00	9	Alvarado J.	NOP	2	1	5	899	1	5	0	0	0	3	0	0	-6	0	1	2	1	0	0	0	0
16.01.2025 01:00	10	Theis D.	NOP	2	5	1	1131	1	4	0	0	0	0	0	0	-8	2	3	3	1	1	1	0	0
15.01.2025 01:00	11	Murphy T.	NOP	32	6	4	2216	9	20	0	0	2	13	12	12	0	0	6	1	3	0	1	0	0
15.01.2025 01:00	12	Williamson Z.	NOP	21	7	9	1433	10	14	0	0	0	0	1	4	7	5	2	3	0	4	1	0	0
15.01.2025 01:00	13	Murray D.	NOP	15	7	7	2055	4	14	0	0	4	11	3	3	-9	1	6	0	1	2	0	0	0
15.01.2025 01:00	14	Alvarado J.	NOP	12	3	3	976	4	8	0	0	4	8	0	0	19	1	2	1	1	0	0	0	0
15.01.2025 01:00	15	Hawkins J.	NOP	9	1	0	1203	4	10	0	0	1	6	0	0	15	0	1	0	0	1	1	0	0
15.01.2025 01:00	16	McCollum C.	NOP	8	4	5	1766	3	13	0	0	2	7	0	0	-8	2	2	3	1	0	0	0	0
15.01.2025 01:00	17	Boston B.	NOP	7	0	0	522	2	5	0	0	1	2	2	2	-5	0	0	0	0	0	0	0	0
15.01.2025 01:00	18	Green J.	NOP	7	4	1	1711	3	6	0	0	0	1	1	1	2	1	3	2	4	0	2	0	0
15.01.2025 01:00	19	Missi Y.	NOP	4	7	0	995	2	2	0	0	0	0	0	0	-1	2	5	1	0	1	0	0	0
15.01.2025 01:00	20	Theis D.	NOP	4	7	3	1523	1	4	0	0	0	2	2	4	10	1	6	2	1	2	0	0	0
12.01.2025 23:00	21	Murphy T.	NOP	30	7	4	2320	10	17	0	0	5	10	5	5	-4	0	7	4	0	3	0	0	0
12.01.2025 23:00	22	Murray D.	NOP	26	9	8	2117	8	19	0	0	6	9	4	5	7	2	7	4	1	1	1	0	0
12.01.2025 23:00	23	Williamson Z.	NOP	16	7	3	1687	5	15	0	0	0	2	6	7	4	1	6	1	5	2	0	0	0
12.01.2025 23:00	24	McCollum C.	NOP	13	4	5	2275	5	15	0	0	1	6	2	3	11	1	3	4	0	1	1	0	0
12.01.2025 23:00	25	Green J.	NOP	10	3	0	1170	4	6	0	0	2	4	0	0	4	1	2	1	2	0	0	0	0
12.01.2025 23:00	26	Alvarado J.	NOP	9	0	0	713	3	5	0	0	3	4	0	0	-8	0	0	1	0	0	0	0	0
12.01.2025 23:00	27	Missi Y.	NOP	7	4	4	1550	2	4	0	0	0	0	3	4	7	1	3	2	0	2	1	0	0
12.01.2025 23:00	28	Theis D.	NOP	6	6	0	1330	2	3	0	0	0	1	2	2	-8	0	6	1	0	0	0	0	0
12.01.2025 23:00	29	Hawkins J.	NOP	2	1	0	771	1	2	0	0	0	1	0	0	-10	0	1	1	0	0	0	0	0
12.01.2025 23:00	30	Boston B.	NOP	0	1	0	467	0	0	0	0	0	0	0	0	-8	0	1	0	0	0	0	0	0
11.01.2025 00:00	31	McCollum C.	NOP	38	3	3	2088	13	24	0	0	6	11	6	11	2	2	1	0	0	1	0	0	1
11.01.2025 00:00	32	Hawkins J.	NOP	21	2	2	1868	7	15	0	0	5	11	2	3	-6	1	1	0	2	0	0	0	0
11.01.2025 00:00	33	Murray D.	NOP	17	10	6	1895	7	17	0	0	2	5	1	2	-5	0	10	2	1	6	0	0	0
11.01.2025 00:00	34	Alvarado J.	NOP	13	2	9	1401	4	8	0	0	3	6	2	2	19	0	2	2	2	1	0	0	0
11.01.2025 00:00	35	Theis D.	NOP	12	4	0	1065	6	9	0	0	0	2	0	0	16	1	3	1	1	0	1	0	0
11.01.2025 00:00	36	Boston B.	NOP	11	2	0	1388	3	7	0	0	2	3	3	4	14	1	1	3	0	0	0	0	0
11.01.2025 00:00	37	Missi Y.	NOP	9	7	0	1815	4	7	0	0	0	0	1	2	-8	3	4	5	1	4	4	0	0
11.01.2025 00:00	38	Green J.	NOP	2	7	6	1536	0	2	0	0	0	1	2	2	-9	3	4	1	0	0	3	0	0
11.01.2025 00:00	39	Robinson J.	NOP	0	7	5	1344	0	2	0	0	0	1	0	0	17	1	6	2	0	0	0	0	0
09.01.2025 01:00	40	McCollum C.	NOP	23	2	2	1626	10	17	0	0	3	7	0	0	-17	0	2	3	0	2	0	0	0
09.01.2025 01:00	41	Murray D.	NOP	20	3	5	1552	8	14	0	0	2	5	2	2	-27	1	2	0	2	4	0	0	0
09.01.2025 01:00	42	Hawkins J.	NOP	10	1	1	1512	4	16	0	0	2	9	0	0	-11	1	0	0	0	3	0	0	0
09.01.2025 01:00	43	Alvarado J.	NOP	9	3	3	1186	3	8	0	0	1	2	2	3	-5	2	1	2	3	3	1	0	0
09.01.2025 01:00	44	Green J.	NOP	9	7	0	1728	3	7	0	0	2	5	1	1	2	2	5	2	0	1	1	0	0
09.01.2025 01:00	45	Reeves A.	NOP	9	0	0	361	3	4	0	0	2	3	1	1	9	0	0	0	1	0	0	0	0
09.01.2025 01:00	46	Boston B.	NOP	6	4	0	1272	3	12	0	0	0	4	0	2	-11	4	0	2	1	3	0	0	0
09.01.2025 01:00	47	Theis D.	NOP	6	6	0	1023	2	3	0	0	0	0	2	2	-2	4	2	1	1	0	0	0	0
09.01.2025 01:00	48	Matkovic K.	NOP	4	4	1	361	2	3	0	0	0	1	0	0	9	1	3	0	1	0	0	0	0
09.01.2025 01:00	49	Missi Y.	NOP	2	7	4	1496	1	2	0	0	0	0	0	0	-26	2	5	0	0	0	1	0	0
09.01.2025 01:00	50	Robinson J.	NOP	2	4	2	1185	1	1	0	0	0	0	0	0	1	1	3	3	0	0	0	0	0
09.01.2025 01:00	51	Jones H.	NOP	0	0	1	1098	0	3	0	0	0	1	0	0	-17	0	0	2	2	1	0	0	0
08.01.2025 01:00	52	Murray D.	NOP	29	2	6	2023	12	20	0	0	2	8	3	6	-1	0	2	2	6	2	1	0	0
08.01.2025 01:00	53	Williamson Z.	NOP	22	6	4	1660	9	15	0	0	0	2	4	9	8	4	2	3	3	4	1	0	0
08.01.2025 01:00	54	Alvarado J.	NOP	13	1	1	1200	4	11	0	0	3	8	2	2	-2	1	0	3	1	3	0	0	0
08.01.2025 01:00	55	Jones H.	NOP	10	6	5	1900	3	9	0	0	2	5	2	2	3	0	6	4	0	2	0	0	0
08.01.2025 01:00	56	Boston B.	NOP	5	4	2	1518	1	6	0	0	1	3	2	2	-12	1	3	1	1	1	0	0	0
08.01.2025 01:00	57	McCollum C.	NOP	5	2	2	1803	1	14	0	0	1	7	2	3	-15	0	2	3	0	0	1	0	0
08.01.2025 01:00	58	Robinson J.	NOP	5	8	1	1251	2	6	0	0	1	3	0	0	-12	1	7	0	1	2	1	0	0
08.01.2025 01:00	59	Hawkins J.	NOP	3	0	0	584	1	4	0	0	1	4	0	0	1	0	0	0	0	0	0	0	0
08.01.2025 01:00	60	Theis D.	NOP	3	8	2	798	1	2	0	0	1	1	0	0	-3	2	6	0	0	0	0	0	0
08.01.2025 01:00	61	Missi Y.	NOP	2	9	0	1663	1	7	0	0	0	0	0	0	-2	4	5	2	0	0	1	0	0
05.01.2025 23:00	62	McCollum C.	NOP	25	3	3	2143	9	18	0	0	6	11	1	2	-5	0	3	1	0	3	1	0	1
05.01.2025 23:00	63	Murphy T.	NOP	22	9	2	1763	8	19	0	0	4	10	2	2	19	3	6	2	2	0	1	0	0
05.01.2025 23:00	64	Missi Y.	NOP	16	7	1	1965	4	5	0	0	0	0	8	8	2	3	4	3	1	1	3	0	1
05.01.2025 23:00	65	Murray D.	NOP	14	10	12	2138	5	14	0	0	1	5	3	4	15	2	8	2	0	4	0	0	0
05.01.2025 23:00	66	Jones H.	NOP	11	4	1	2256	4	8	0	0	1	4	2	2	2	0	4	1	2	1	2	0	0
05.01.2025 23:00	67	Hawkins J.	NOP	6	2	0	737	2	10	0	0	2	7	0	0	17	0	2	1	0	1	0	0	0
05.01.2025 23:00	68	Boston B.	NOP	5	4	1	1117	1	7	0	0	1	4	2	2	-7	1	3	0	0	1	0	0	0
05.01.2025 23:00	69	Theis D.	NOP	5	7	2	915	2	3	0	0	1	2	0	0	10	1	6	0	1	0	1	0	0
05.01.2025 23:00	70	Alvarado J.	NOP	3	0	3	742	1	4	0	0	1	4	0	0	-3	0	0	3	1	0	0	0	0
05.01.2025 23:00	71	Robinson J.	NOP	3	3	1	624	1	2	0	0	1	2	0	0	10	1	2	0	0	0	0	0	0
04.01.2025 01:00	72	McCollum C.	NOP	50	3	2	1840	18	27	0	0	10	16	4	4	21	1	2	2	0	1	0	0	0
04.01.2025 01:00	73	Murphy T.	NOP	17	5	5	2071	5	19	0	0	2	8	5	5	-11	2	3	2	1	1	2	0	0
04.01.2025 01:00	74	Boston B.	NOP	13	4	3	1574	5	7	0	0	1	2	2	2	9	1	3	4	0	1	1	0	0
04.01.2025 01:00	75	Missi Y.	NOP	12	11	3	1947	5	7	0	0	0	0	2	4	3	6	5	2	0	1	1	0	0
04.01.2025 01:00	76	Murray D.	NOP	11	4	12	1697	4	12	0	0	0	2	3	3	-4	1	3	2	3	1	1	0	1
04.01.2025 01:00	77	Jones H.	NOP	10	1	6	1996	4	6	0	0	2	3	0	0	27	0	1	5	2	1	0	0	0
04.01.2025 01:00	78	Theis D.	NOP	7	4	0	927	3	5	0	0	0	1	1	2	9	1	3	2	0	1	0	0	0
04.01.2025 01:00	79	Alvarado J.	NOP	5	2	3	1183	2	6	0	0	1	4	0	0	16	1	1	2	3	0	0	0	0
04.01.2025 01:00	80	Hawkins J.	NOP	4	2	2	991	1	6	0	0	1	4	1	2	-6	0	2	1	0	0	1	0	0
04.01.2025 01:00	81	Robinson J.	NOP	3	1	0	174	1	1	0	0	1	1	0	0	-4	0	1	0	1	0	0	0	0
02.01.2025 00:30	82	Murphy T.	NOP	34	4	3	2342	11	24	0	0	5	15	7	7	-17	1	3	3	0	1	0	0	0
02.01.2025 00:30	83	McCollum C.	NOP	22	4	5	2059	9	16	0	0	1	5	3	5	-12	1	3	1	0	1	1	0	0
02.01.2025 00:30	84	Boston B.	NOP	14	4	1	1213	5	7	0	0	0	1	4	4	11	1	3	1	2	0	0	0	0
02.01.2025 00:30	85	Murray D.	NOP	12	3	7	1878	5	13	0	0	0	5	2	2	-11	0	3	1	0	4	0	0	0
02.01.2025 00:30	86	Hawkins J.	NOP	8	4	1	1212	3	9	0	0	2	5	0	0	-7	1	3	0	1	0	2	0	0
02.01.2025 00:30	87	Jones H.	NOP	8	4	4	2337	3	5	0	0	0	1	2	2	0	0	4	5	1	2	0	0	0
02.01.2025 00:30	88	Missi Y.	NOP	7	4	2	1754	3	3	0	0	0	0	1	2	-12	1	3	3	0	1	1	0	0
02.01.2025 00:30	89	Green J.	NOP	3	1	1	543	1	2	0	0	1	1	0	0	-11	0	1	0	0	1	1	0	0
02.01.2025 00:30	90	Theis D.	NOP	0	3	1	1062	0	1	0	0	0	1	0	0	4	0	3	1	0	0	2	0	0
31.12.2024 01:00	91	McCollum C.	NOP	33	2	4	2346	12	25	0	0	8	14	1	2	6	0	2	2	1	4	0	0	0
31.12.2024 01:00	92	Jones H.	NOP	18	4	5	2006	6	10	0	0	2	3	4	4	7	2	2	4	2	1	0	0	0
31.12.2024 01:00	93	Murphy T.	NOP	18	4	6	2272	6	10	0	0	4	7	2	2	-6	1	3	1	3	2	0	0	0
31.12.2024 01:00	94	Murray D.	NOP	13	10	8	2428	6	16	0	0	1	5	0	0	-2	0	10	4	6	4	0	0	0
31.12.2024 01:00	95	Missi Y.	NOP	12	9	4	2099	4	7	0	0	0	0	4	6	1	3	6	2	0	1	5	0	0
31.12.2024 01:00	96	Green J.	NOP	7	1	1	902	3	3	0	0	1	1	0	0	-6	0	1	3	1	1	0	0	0
31.12.2024 01:00	97	Theis D.	NOP	6	2	1	656	3	3	0	0	0	0	0	0	-3	0	2	1	0	2	0	0	0
31.12.2024 01:00	98	Boston B.	NOP	3	1	0	759	1	3	0	0	1	3	0	0	-5	0	1	3	0	0	0	0	0
31.12.2024 01:00	99	Hawkins J.	NOP	3	2	1	932	1	5	0	0	1	4	0	0	-7	0	2	2	0	1	0	0	0
28.12.2024 01:00	100	Murphy T.	NOP	35	3	4	2330	10	21	0	0	5	12	10	11	-2	0	3	4	0	2	1	0	0
28.12.2024 01:00	101	McCollum C.	NOP	32	5	4	2071	12	22	0	0	3	8	5	5	-16	1	4	5	1	1	1	0	0
28.12.2024 01:00	102	Murray D.	NOP	15	7	9	2318	6	16	0	0	1	4	2	2	-15	1	6	2	3	7	1	0	0
28.12.2024 01:00	103	Theis D.	NOP	11	11	6	1237	3	5	0	0	0	2	5	5	-2	2	9	2	1	1	1	0	0
28.12.2024 01:00	104	Hawkins J.	NOP	9	2	0	905	2	9	0	0	1	4	4	4	-3	0	2	1	2	1	1	0	0
28.12.2024 01:00	105	Boston B.	NOP	7	0	0	667	3	4	0	0	1	1	0	0	13	0	0	0	1	0	0	0	0
28.12.2024 01:00	106	Missi Y.	NOP	6	6	2	1643	3	7	0	0	0	0	0	0	-6	3	3	4	0	3	3	0	0
28.12.2024 01:00	107	Robinson J.	NOP	5	6	2	1381	2	6	0	0	0	4	1	2	-3	3	3	2	2	0	0	0	0
28.12.2024 01:00	108	Jones H.	NOP	4	5	3	1669	2	6	0	0	0	3	0	0	4	2	3	5	3	2	2	0	0
28.12.2024 01:00	109	Green J.	NOP	0	0	0	179	0	0	0	0	0	0	0	0	-10	0	0	0	0	0	0	0	0
27.12.2024 01:00	110	Murphy T.	NOP	21	3	2	1776	7	16	0	0	4	9	3	3	-30	0	3	1	1	1	0	0	0
27.12.2024 01:00	111	Boston B.	NOP	17	6	1	1166	7	14	0	0	1	3	2	3	11	1	5	3	4	2	0	0	0
27.12.2024 01:00	112	Murray D.	NOP	17	4	4	1618	7	15	0	0	2	5	1	2	-20	1	3	0	3	3	0	0	0
27.12.2024 01:00	113	McCollum C.	NOP	13	2	3	1611	5	12	0	0	2	5	1	2	-13	1	1	2	0	1	0	0	0
27.12.2024 01:00	114	Green J.	NOP	11	5	0	1152	5	6	0	0	1	1	0	0	-11	3	2	2	1	1	0	0	0
27.12.2024 01:00	115	Jones H.	NOP	10	6	7	1852	5	13	0	0	0	2	0	0	-4	4	2	2	0	2	0	0	0
27.12.2024 01:00	116	Robinson J.	NOP	9	3	2	761	3	5	0	0	2	4	1	1	11	2	1	1	0	1	0	0	0
27.12.2024 01:00	117	Hawkins J.	NOP	5	0	1	1050	1	8	0	0	0	6	3	5	-23	0	0	0	2	0	0	0	0
27.12.2024 01:00	118	Reeves A.	NOP	4	1	3	534	2	5	0	0	0	1	0	0	11	1	0	0	0	1	0	0	0
27.12.2024 01:00	119	Missi Y.	NOP	2	9	4	1732	1	3	0	0	0	0	0	0	-4	3	6	1	0	0	2	0	0
27.12.2024 01:00	120	Theis D.	NOP	2	5	2	1148	0	2	0	0	0	1	2	2	-13	1	4	4	1	1	0	0	0
\.


--
-- Data for Name: new_orleans_pelicans_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.new_orleans_pelicans_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Ingram Brandon	Lesionado	2025-01-16 10:46:30.409274
2	Jones Herbert	Lesionado	2025-01-16 10:46:30.430542
3	Williamson Zion	Lesionado	2025-01-16 10:46:30.441836
\.


--
-- Data for Name: new_york_knicks; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.new_york_knicks (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	13.07.2024	New York Knicks	90	Charlotte Hornets	94	12	28	23	27	23	24	20	27
2	16.07.2024	Brooklyn Nets	92	New York Knicks	85	11	28	18	35	28	15	19	23
3	17.07.2024	New York Knicks	106	Sacramento Kings	105	23	30	25	28	30	23	22	30
4	20.07.2024	Detroit Pistons	90	New York Knicks	91	27	18	18	27	28	27	21	15
5	20.07.2024	Atlanta Hawks	82	New York Knicks	90	21	17	22	22	18	25	24	23
6	06.10.2024	Charlotte Hornets	109	New York Knicks	111	35	26	29	19	29	32	26	24
7	10.10.2024	New York Knicks	117	Washington Wizards	94	19	35	32	31	22	17	20	35
8	13.10.2024	New York Knicks	115	Minnesota Timberwolves	110	26	29	33	27	21	36	26	27
9	16.10.2024	New York Knicks	111	Charlotte Hornets	105	24	41	27	19	30	33	26	16
10	19.10.2024	Washington Wizards	118	New York Knicks	117	35	28	22	33	29	32	29	27
11	23.10.2024	Boston Celtics	132	New York Knicks	109	43	31	39	19	24	31	32	22
12	26.10.2024	New York Knicks	123	Indiana Pacers	98	25	36	34	28	24	21	19	34
13	28.10.2024	New York Knicks	104	Cleveland Cavaliers	110	18	34	26	26	22	23	29	36
14	30.10.2024	Miami Heat	107	New York Knicks	116	32	26	22	27	26	26	35	29
15	01.11.2024	Detroit Pistons	98	New York Knicks	128	13	33	28	24	39	30	35	24
16	05.11.2024	Houston Rockets	109	New York Knicks	97	31	30	20	28	26	30	19	22
17	07.11.2024	Atlanta Hawks	121	New York Knicks	116	26	39	24	32	22	39	28	27
18	09.11.2024	New York Knicks	116	Milwaukee Bucks	94	32	34	25	25	25	22	25	22
19	10.11.2024	Indiana Pacers	132	New York Knicks	121	29	29	34	40	26	35	33	27
20	13.11.2024	Philadelphia 76ers	99	New York Knicks	111	25	25	25	24	27	27	24	33
21	14.11.2024	New York Knicks	123	Chicago Bulls	124	22	25	38	38	29	30	31	34
22	16.11.2024	New York Knicks	124	Brooklyn Nets	122	37	31	32	24	32	27	23	40
23	18.11.2024	New York Knicks	114	Brooklyn Nets	104	30	30	35	19	29	28	24	23
24	19.11.2024	New York Knicks	134	Washington Wizards	106	40	33	36	25	27	27	21	31
25	21.11.2024	Phoenix Suns	122	New York Knicks	138	28	30	35	29	44	32	34	28
26	23.11.2024	Utah Jazz	121	New York Knicks	106	28	38	21	34	28	23	27	28
27	26.11.2024	Denver Nuggets	118	New York Knicks	145	24	29	34	31	36	40	37	32
28	28.11.2024	Dallas Mavericks	129	New York Knicks	114	28	32	30	39	15	23	33	43
29	29.11.2024	Charlotte Hornets	98	New York Knicks	99	23	26	23	26	15	31	25	28
30	01.12.2024	New York Knicks	118	New Orleans Pelicans	85	33	24	36	25	10	18	28	29
31	04.12.2024	New York Knicks	121	Orlando Magic	106	36	35	35	15	27	24	24	31
32	06.12.2024	New York Knicks	125	Charlotte Hornets	101	30	35	38	22	32	30	16	23
33	08.12.2024	New York Knicks	111	Detroit Pistons	120	23	35	27	26	39	30	20	31
34	10.12.2024	Toronto Raptors	108	New York Knicks	113	27	34	25	22	34	26	23	30
35	12.12.2024	New York Knicks	100	Atlanta Hawks	108	28	26	18	28	22	25	34	27
36	15.12.2024	Orlando Magic	91	New York Knicks	100	22	19	26	24	22	29	24	25
37	20.12.2024	Minnesota Timberwolves	107	New York Knicks	133	33	18	23	33	32	41	31	29
38	22.12.2024	New Orleans Pelicans	93	New York Knicks	104	28	21	26	18	28	17	33	26
39	24.12.2024	New York Knicks	139	Toronto Raptors	125	30	40	41	28	28	24	30	43
40	25.12.2024	New York Knicks	117	San Antonio Spurs	114	28	23	37	29	27	31	25	31
41	28.12.2024	Orlando Magic	85	New York Knicks	108	29	25	14	17	26	28	22	32
42	29.12.2024\nApós Prol.	Washington Wizards	132	New York Knicks	136	33	27	38	21	32	28	30	29
43	31.12.2024	Washington Wizards	106	New York Knicks	126	30	27	31	18	27	32	38	29
44	02.01. 00:30	New York Knicks	119	Utah Jazz	103	24	32	31	32	25	21	33	24
45	04.01. 01:00	Oklahoma City Thunder	117	New York Knicks	107	33	21	26	37	30	36	22	19
46	05.01. 01:00	Chicago Bulls	139	New York Knicks	126	29	34	41	35	33	39	17	37
47	07.01. 00:30	New York Knicks	94	Orlando Magic	103	28	23	17	26	24	29	22	28
48	09.01. 00:30	New York Knicks	112	Toronto Raptors	98	28	27	31	26	24	27	25	22
49	11.01. 00:30	New York Knicks	101	Oklahoma City Thunder	126	17	26	31	27	31	39	32	24
50	12.01. 20:00	New York Knicks	140	Milwaukee Bucks	106	36	39	33	32	33	29	27	17
51	14.01. 00:30	New York Knicks	119	Detroit Pistons	124	26	37	27	29	37	22	36	29
52	16.01. 00:00\nApós Prol.	Philadelphia 76ers	119	New York Knicks	125	21	26	38	24	30	30	25	24
\.


--
-- Data for Name: new_york_knicks_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.new_york_knicks_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 00:00	1	Brunson J.	NYK	38	5	4	2728	14	22	0	0	3	6	7	9	7	1	4	1	2	5	0	0	0
16.01.2025 00:00	2	Bridges M.	NYK	23	2	2	2608	9	19	0	0	5	10	0	0	3	0	2	0	0	1	0	0	0
16.01.2025 00:00	3	Anunoby OG.	NYK	17	4	4	2670	6	16	0	0	3	10	2	2	-2	0	4	1	1	2	0	0	0
16.01.2025 00:00	4	McBride M.	NYK	13	3	3	1307	4	5	0	0	3	4	2	2	5	1	2	1	1	0	0	0	0
16.01.2025 00:00	5	Achiuwa P.	NYK	10	6	1	1808	4	6	0	0	0	0	2	4	9	2	4	2	1	1	3	0	0
16.01.2025 00:00	6	Hart J.	NYK	10	17	12	2965	4	9	0	0	0	3	2	3	10	5	12	3	4	3	0	0	0
16.01.2025 00:00	7	Sims J.	NYK	8	7	0	1366	3	5	0	0	0	0	2	4	-3	6	1	4	0	1	0	0	0
16.01.2025 00:00	8	Payne C.	NYK	6	1	2	448	2	4	0	0	2	4	0	0	1	0	1	2	1	0	0	0	0
14.01.2025 00:30	9	Brunson J.	NYK	31	4	11	2365	12	24	0	0	1	7	6	8	-12	0	4	3	1	4	0	0	0
14.01.2025 00:30	10	Bridges M.	NYK	27	2	1	2221	9	13	0	0	6	8	3	3	-3	1	1	3	0	1	1	0	0
14.01.2025 00:30	11	Towns K.	NYK	26	12	3	2582	7	17	0	0	4	9	8	10	-4	0	12	5	1	6	0	0	0
14.01.2025 00:30	12	Hart J.	NYK	12	14	5	2272	3	5	0	0	1	2	5	6	6	3	11	4	0	1	0	0	0
14.01.2025 00:30	13	Anunoby OG.	NYK	10	3	1	2326	5	9	0	0	0	2	0	0	-8	2	1	4	1	3	0	0	0
14.01.2025 00:30	14	Payne C.	NYK	10	1	2	816	3	7	0	0	2	6	2	2	5	0	1	1	1	2	1	0	0
14.01.2025 00:30	15	McBride M.	NYK	3	1	2	999	1	2	0	0	1	2	0	0	4	1	0	0	0	0	0	0	0
14.01.2025 00:30	16	Achiuwa P.	NYK	0	4	1	578	0	2	0	0	0	0	0	0	-8	3	1	1	1	0	0	0	0
14.01.2025 00:30	17	Shamet L.	NYK	0	1	0	241	0	1	0	0	0	1	0	0	-5	0	1	0	0	0	0	0	0
12.01.2025 20:00	18	Brunson J.	NYK	44	5	6	1727	16	26	0	0	5	10	7	8	23	1	4	0	1	1	0	0	0
12.01.2025 20:00	19	Towns K.	NYK	30	18	4	2132	10	16	0	0	2	5	8	9	28	5	13	3	1	2	0	0	0
12.01.2025 20:00	20	Payne C.	NYK	18	2	2	862	6	10	0	0	4	7	2	2	18	0	2	2	0	0	0	0	0
12.01.2025 20:00	21	Anunoby OG.	NYK	11	1	2	1851	5	12	0	0	1	5	0	1	21	0	1	3	0	2	1	0	0
12.01.2025 20:00	22	Hart J.	NYK	11	11	4	2121	5	5	0	0	1	1	0	0	24	2	9	4	1	3	0	0	0
12.01.2025 20:00	23	Ryan M.	NYK	8	1	0	191	2	2	0	0	2	2	2	2	5	0	1	0	0	0	0	0	0
12.01.2025 20:00	24	Bridges M.	NYK	6	2	6	2238	2	5	0	0	1	4	1	2	17	1	1	1	0	1	2	0	0
12.01.2025 20:00	25	McBride M.	NYK	6	0	2	1180	2	7	0	0	2	6	0	0	7	0	0	1	0	0	0	0	0
12.01.2025 20:00	26	Achiuwa P.	NYK	4	3	1	894	2	2	0	0	0	0	0	0	8	0	3	3	2	0	0	0	0
12.01.2025 20:00	27	Toppin J.	NYK	2	1	0	322	1	2	0	0	0	0	0	0	4	0	1	1	1	1	0	0	0
12.01.2025 20:00	28	Hukporti A.	NYK	0	4	0	321	0	0	0	0	0	0	0	0	4	1	3	0	0	1	1	0	0
12.01.2025 20:00	29	Kolek T.	NYK	0	1	2	191	0	0	0	0	0	0	0	0	5	0	1	0	0	0	0	0	0
12.01.2025 20:00	30	Shamet L.	NYK	0	0	0	370	0	1	0	0	0	1	0	0	6	0	0	0	0	0	0	0	0
11.01.2025 00:30	31	Brunson J.	NYK	27	1	5	1984	7	15	0	0	1	2	12	12	-23	0	1	3	0	4	0	0	0
11.01.2025 00:30	32	Towns K.	NYK	23	10	1	1769	9	16	0	0	1	2	4	4	-10	3	7	3	1	3	0	0	0
11.01.2025 00:30	33	Hart J.	NYK	16	13	2	1828	6	13	0	0	0	1	4	4	-23	6	7	2	3	1	0	0	0
11.01.2025 00:30	34	Payne C.	NYK	11	2	0	896	5	11	0	0	1	4	0	0	-2	1	1	0	1	0	1	0	0
11.01.2025 00:30	35	McBride M.	NYK	7	5	5	1197	3	9	0	0	0	4	1	1	-21	4	1	1	0	0	0	0	0
11.01.2025 00:30	36	Anunoby OG.	NYK	4	3	2	2155	2	8	0	0	0	5	0	0	-6	1	2	2	0	2	0	0	0
11.01.2025 00:30	37	Shamet L.	NYK	3	1	0	914	1	6	0	0	1	5	0	0	-5	0	1	1	1	0	0	0	0
11.01.2025 00:30	38	Achiuwa P.	NYK	2	1	0	348	1	1	0	0	0	0	0	0	-16	0	1	1	0	0	0	0	0
11.01.2025 00:30	39	Hukporti A.	NYK	2	2	0	763	1	2	0	0	0	0	0	0	1	0	2	1	0	0	2	0	0
11.01.2025 00:30	40	Kolek T.	NYK	2	0	1	138	0	2	0	0	0	1	2	2	3	0	0	0	1	0	0	0	0
11.01.2025 00:30	41	Ryan M.	NYK	2	1	0	138	1	2	0	0	0	0	0	0	3	0	1	0	0	0	0	0	0
11.01.2025 00:30	42	Toppin J.	NYK	2	3	0	361	1	2	0	0	0	0	0	0	-3	1	2	0	0	0	0	0	0
11.01.2025 00:30	43	Bridges M.	NYK	0	1	2	1909	0	9	0	0	0	7	0	0	-23	0	1	1	0	0	0	0	0
09.01.2025 00:30	44	Anunoby OG.	NYK	27	2	0	2254	8	13	0	0	4	6	7	8	24	1	1	2	2	2	1	0	0
09.01.2025 00:30	45	Towns K.	NYK	27	13	2	2054	9	14	0	0	3	3	6	6	25	4	9	3	3	2	2	0	0
09.01.2025 00:30	46	Hart J.	NYK	21	11	7	2302	9	14	0	0	2	5	1	2	19	6	5	4	1	1	0	0	0
09.01.2025 00:30	47	Brunson J.	NYK	13	6	7	2093	5	13	0	0	1	4	2	4	20	0	6	1	1	1	0	0	0
09.01.2025 00:30	48	Bridges M.	NYK	10	3	3	2147	4	18	0	0	2	11	0	0	26	1	2	0	1	1	0	0	0
09.01.2025 00:30	49	Shamet L.	NYK	8	2	1	1276	4	8	0	0	0	3	0	0	-4	1	1	4	0	1	0	0	0
09.01.2025 00:30	50	Achiuwa P.	NYK	6	4	1	914	3	5	0	0	0	1	0	0	-2	0	4	0	0	0	1	0	0
09.01.2025 00:30	51	Kolek T.	NYK	0	0	0	147	0	0	0	0	0	0	0	0	-12	0	0	0	0	1	0	0	0
09.01.2025 00:30	52	Payne C.	NYK	0	0	2	681	0	1	0	0	0	0	0	0	9	0	0	0	1	1	0	0	0
09.01.2025 00:30	53	Ryan M.	NYK	0	0	0	147	0	0	0	0	0	0	0	0	-12	0	0	1	0	0	0	0	0
09.01.2025 00:30	54	Sims J.	NYK	0	1	1	238	0	0	0	0	0	0	0	0	-11	1	0	0	0	2	0	0	0
09.01.2025 00:30	55	Toppin J.	NYK	0	1	0	147	0	2	0	0	0	0	0	0	-12	1	0	0	0	0	0	0	0
07.01.2025 00:30	56	Bridges M.	NYK	24	5	2	2543	10	20	0	0	1	7	3	4	-8	0	5	2	0	2	0	0	0
07.01.2025 00:30	57	Brunson J.	NYK	24	1	4	2154	8	21	0	0	0	1	8	10	-3	1	0	6	1	2	0	0	0
07.01.2025 00:30	58	Hart J.	NYK	15	14	2	2503	5	9	0	0	1	3	4	4	-8	3	11	2	2	1	1	0	0
07.01.2025 00:30	59	Achiuwa P.	NYK	10	2	0	1347	5	6	0	0	0	0	0	0	-14	1	1	3	0	1	0	0	0
07.01.2025 00:30	60	Anunoby OG.	NYK	9	4	3	2126	4	11	0	0	0	3	1	2	-6	3	1	1	1	1	1	0	0
07.01.2025 00:30	61	Payne C.	NYK	8	1	2	723	2	7	0	0	2	5	2	2	-3	1	0	1	0	2	0	0	0
07.01.2025 00:30	62	Sims J.	NYK	4	10	2	1768	2	4	0	0	0	0	0	0	-4	2	8	1	0	2	1	0	0
07.01.2025 00:30	63	Shamet L.	NYK	0	1	1	1236	0	3	0	0	0	3	0	0	1	0	1	2	0	1	0	0	0
05.01.2025 01:00	64	Towns K.	NYK	44	16	5	2235	17	29	0	0	3	7	7	10	-5	6	10	3	1	3	0	0	0
05.01.2025 01:00	65	Brunson J.	NYK	33	2	8	1970	11	20	0	0	1	4	10	11	-18	1	1	0	2	1	0	0	0
05.01.2025 01:00	66	Bridges M.	NYK	18	3	1	1996	8	18	0	0	0	5	2	3	-21	3	0	2	0	1	1	0	0
05.01.2025 01:00	67	Anunoby OG.	NYK	12	5	0	1944	5	12	0	0	2	6	0	0	-8	2	3	0	1	3	0	0	0
05.01.2025 01:00	68	Payne C.	NYK	8	0	3	835	3	5	0	0	2	3	0	0	5	0	0	4	0	1	1	0	0
05.01.2025 01:00	69	Achiuwa P.	NYK	5	5	0	1611	2	2	0	0	0	0	1	2	-3	2	3	1	1	1	0	0	0
05.01.2025 01:00	70	Shamet L.	NYK	4	1	0	1010	2	6	0	0	0	2	0	0	-1	1	0	0	1	1	1	0	0
05.01.2025 01:00	71	Hart J.	NYK	2	16	10	2423	0	5	0	0	0	3	2	2	-14	3	13	3	1	2	0	0	0
05.01.2025 01:00	72	Kolek T.	NYK	0	0	0	94	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
05.01.2025 01:00	73	Ryan M.	NYK	0	1	0	94	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0
05.01.2025 01:00	74	Sims J.	NYK	0	0	0	94	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
05.01.2025 01:00	75	Toppin J.	NYK	0	0	0	94	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
04.01.2025 01:00	76	Bridges M.	NYK	24	3	2	2459	10	19	0	0	4	11	0	0	-10	1	2	1	1	2	1	0	0
04.01.2025 01:00	77	Brunson J.	NYK	22	3	9	2408	9	23	0	0	0	5	4	6	-3	1	2	2	1	3	0	0	0
04.01.2025 01:00	78	Anunoby OG.	NYK	20	2	3	2552	7	13	0	0	3	7	3	3	-12	0	2	3	0	1	0	0	0
04.01.2025 01:00	79	Hart J.	NYK	19	7	2	2654	8	15	0	0	2	7	1	2	-12	3	4	4	1	2	1	0	1
04.01.2025 01:00	80	Towns K.	NYK	17	22	4	2538	7	13	0	0	0	0	3	4	-6	4	18	4	3	2	0	0	0
04.01.2025 01:00	81	Achiuwa P.	NYK	3	5	0	477	1	4	0	0	0	1	1	2	-3	2	3	0	0	1	0	0	0
04.01.2025 01:00	82	Shamet L.	NYK	2	0	2	840	1	2	0	0	0	1	0	0	3	0	0	1	1	1	0	0	0
04.01.2025 01:00	83	Payne C.	NYK	0	0	0	472	0	1	0	0	0	0	0	0	-7	0	0	2	0	0	0	0	0
02.01.2025 00:30	84	Towns K.	NYK	31	21	4	2243	10	20	0	0	3	6	8	9	11	2	19	3	1	2	1	0	0
02.01.2025 00:30	85	Bridges M.	NYK	27	1	0	2669	12	17	0	0	2	5	1	2	13	0	1	2	0	0	1	0	0
02.01.2025 00:30	86	Anunoby OG.	NYK	22	3	2	2441	10	16	0	0	1	3	1	3	0	1	2	3	3	2	2	0	0
02.01.2025 00:30	87	Hart J.	NYK	15	14	12	2708	6	12	0	0	1	4	2	3	15	2	12	4	1	6	1	0	0
02.01.2025 00:30	88	Achiuwa P.	NYK	12	3	0	794	5	8	0	0	1	1	1	2	15	0	3	1	1	0	1	0	0
02.01.2025 00:30	89	Payne C.	NYK	8	3	9	2137	2	9	0	0	1	3	3	4	5	1	2	1	3	3	0	0	0
02.01.2025 00:30	90	Kolek T.	NYK	2	1	4	743	1	2	0	0	0	1	0	0	11	0	1	2	0	0	0	0	0
02.01.2025 00:30	91	Shamet L.	NYK	2	1	0	665	1	1	0	0	0	0	0	0	10	0	1	0	1	0	0	0	0
31.12.2024 00:00	92	Towns K.	NYK	32	13	1	1910	13	19	0	0	0	3	6	7	21	5	8	4	1	1	0	0	0
31.12.2024 00:00	93	Hart J.	NYK	23	15	10	2477	7	15	0	0	4	8	5	7	25	4	11	4	2	1	0	0	0
31.12.2024 00:00	94	Anunoby OG.	NYK	18	8	1	2048	5	14	0	0	4	11	4	4	1	2	6	3	0	0	1	0	0
31.12.2024 00:00	95	Brunson J.	NYK	18	3	6	2153	6	17	0	0	1	6	5	5	2	0	3	1	1	2	0	0	0
31.12.2024 00:00	96	Bridges M.	NYK	13	6	6	2148	6	15	0	0	1	6	0	0	7	2	4	1	2	1	0	0	0
31.12.2024 00:00	97	McBride M.	NYK	8	2	6	1066	3	8	0	0	1	3	1	2	6	2	0	2	3	0	0	0	0
31.12.2024 00:00	98	Shamet L.	NYK	6	1	1	658	2	4	0	0	2	2	0	0	15	0	1	1	0	0	0	0	0
31.12.2024 00:00	99	Achiuwa P.	NYK	5	4	0	1162	2	2	0	0	1	1	0	0	-2	0	4	2	0	1	1	0	0
31.12.2024 00:00	100	Payne C.	NYK	3	0	1	402	1	3	0	0	1	3	0	0	10	0	0	1	0	1	0	0	0
31.12.2024 00:00	101	Kolek T.	NYK	0	0	0	108	0	1	0	0	0	1	0	0	4	0	0	0	0	0	0	0	0
31.12.2024 00:00	102	Ryan M.	NYK	0	0	0	52	0	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0
31.12.2024 00:00	103	Sims J.	NYK	0	1	0	108	0	0	0	0	0	0	0	0	4	0	1	0	0	0	0	0	0
31.12.2024 00:00	104	Toppin J.	NYK	0	1	2	108	0	0	0	0	0	0	0	0	4	0	1	0	0	0	0	0	0
29.12.2024 00:00	105	Brunson J.	NYK	55	3	9	2640	18	31	0	0	3	11	16	17	1	0	3	1	0	3	0	0	0
29.12.2024 00:00	106	Towns K.	NYK	30	14	3	2617	13	19	0	0	2	5	2	3	8	3	11	3	0	3	2	0	0
29.12.2024 00:00	107	Bridges M.	NYK	21	3	3	2799	8	14	0	0	3	9	2	2	4	1	2	5	3	3	0	0	0
29.12.2024 00:00	108	Hart J.	NYK	13	11	7	2316	5	10	0	0	0	3	3	3	6	3	8	1	1	2	0	0	0
29.12.2024 00:00	109	Anunoby OG.	NYK	9	4	0	2525	4	12	0	0	1	5	0	0	-2	1	3	1	1	1	0	0	0
29.12.2024 00:00	110	Achiuwa P.	NYK	3	7	2	1140	1	3	0	0	0	1	1	1	6	2	5	1	0	2	0	0	0
29.12.2024 00:00	111	McBride M.	NYK	3	0	1	1146	1	5	0	0	1	4	0	0	-3	0	0	2	0	0	1	0	0
29.12.2024 00:00	112	Payne C.	NYK	2	1	0	336	1	2	0	0	0	1	0	0	0	0	1	0	1	1	0	0	0
29.12.2024 00:00	113	Shamet L.	NYK	0	0	1	381	0	1	0	0	0	1	0	0	0	0	0	0	1	0	0	0	0
28.12.2024 00:00	114	Brunson J.	NYK	26	3	9	2203	11	21	0	0	0	2	4	6	19	1	2	4	2	1	0	0	0
28.12.2024 00:00	115	Hart J.	NYK	23	13	1	2306	7	11	0	0	1	3	8	10	23	3	10	3	2	3	2	0	0
28.12.2024 00:00	116	Bridges M.	NYK	17	2	3	2611	6	12	0	0	0	1	5	6	21	0	2	2	2	2	0	0	0
28.12.2024 00:00	117	Towns K.	NYK	16	8	0	1955	6	10	0	0	2	4	2	4	17	1	7	4	1	4	0	0	0
28.12.2024 00:00	118	Anunoby OG.	NYK	8	5	0	1654	4	8	0	0	0	1	0	0	7	1	4	4	0	3	0	0	0
28.12.2024 00:00	119	Shamet L.	NYK	7	1	0	620	3	4	0	0	1	1	0	0	5	0	1	0	2	0	0	0	0
28.12.2024 00:00	120	Achiuwa P.	NYK	6	6	1	1238	2	2	0	0	0	0	2	4	7	3	3	1	1	3	1	0	0
28.12.2024 00:00	121	McBride M.	NYK	5	5	3	1305	1	4	0	0	0	1	3	4	17	2	3	1	0	2	0	0	0
28.12.2024 00:00	122	Payne C.	NYK	0	0	1	430	0	2	0	0	0	2	0	0	-1	0	0	1	0	0	0	0	0
28.12.2024 00:00	123	Sims J.	NYK	0	1	0	78	0	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0
\.


--
-- Data for Name: new_york_knicks_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.new_york_knicks_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Robinson Mitchell	Lesionado	2025-01-16 10:46:44.116293
2	Sims Jericho	Lesionado	2025-01-16 10:46:44.118392
3	Towns Karl-Anthony	Lesionado	2025-01-16 10:46:44.120037
4	Brunson Jalen	Lesionado	2025-01-16 10:46:44.121564
5	McCullar Kevin	Lesionado	2025-01-16 10:46:44.123282
6	Dadiet Pacome	Lesionado	2025-01-16 10:46:44.125014
\.


--
-- Data for Name: odds; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.odds (id, data_jogo, time_home, time_away, home_odds, away_odds, over_dois_meio, over_odds) FROM stdin;
1	2025-01-18 00:00:00	Boston Celtics	Orlando Magic	1.13	4.9	1.31	200
2	2025-01-18 00:30:00	New York Knicks	Minnesota Timberwolves	1.52	2.32	1.33	208
3	2025-01-18 01:00:00	Chicago Bulls	Charlotte Hornets	1.5	2.35	1.33	225
4	2025-01-18 01:00:00	Miami Heat	Denver Nuggets	1.75	1.93	1.33	214
5	2025-01-18 01:00:00	Milwaukee Bucks	Toronto Raptors	1.18	4.1	1.32	219
6	2025-01-18 01:00:00	New Orleans Pelicans	Utah Jazz	1.15	4.6	1.31	220
7	2025-01-18 01:30:00	Dallas Mavericks	Oklahoma City Thunder	3.2	1.29	1.34	213
8	2025-01-18 02:30:00	San Antonio Spurs	Memphis Grizzlies	2	1.7	1.34	229
9	2025-01-18 03:30:00	Los Angeles Lakers	Brooklyn Nets	1.17	4.25	1.31	205
10	2025-01-18 21:00:00	Detroit Pistons	Phoenix Suns	1.88	1.7	1.75	229
11	2025-01-19 00:00:00	Boston Celtics	Atlanta Hawks	1.14	4.2	1.72	237
12	2025-01-19 00:00:00	Indiana Pacers	Philadelphia 76ers	1.53	2.15	1.75	222
13	2025-01-19 01:30:00	Golden State Warriors	Washington Wizards	1.09	4.9	1.75	224
14	2025-01-19 02:00:00	Minnesota Timberwolves	Cleveland Cavaliers	1.98	1.62	1.75	231
15	2025-01-19 03:00:00	Portland Trail Blazers	Houston Rockets	3.75	1.17	1.72	224
\.


--
-- Data for Name: oklahoma_city_thunder; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.oklahoma_city_thunder (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	14.07.2024	Toronto Raptors	94	Oklahoma City Thunder	69	30	18	14	32	10	17	23	19
2	15.07.2024	Miami Heat	102	Oklahoma City Thunder	73	18	23	32	29	20	13	24	16
3	18.07.2024	Oklahoma City Thunder	99	Phoenix Suns	100	28	27	23	21	22	25	24	29
4	20.07.2024	Oklahoma City Thunder	83	Golden State Warriors	90	18	19	20	26	22	18	23	27
5	21.07.2024	Dallas Mavericks	79	Oklahoma City Thunder	88	20	22	12	25	16	22	25	25
6	08.10.2024	San Antonio Spurs	107	Oklahoma City Thunder	112	22	23	40	22	27	31	29	25
7	10.10.2024\nApós Prol.	Oklahoma City Thunder	113	Houston Rockets	122	29	31	20	26	20	27	32	27
8	11.10.2024	Oklahoma City Thunder (Usa)	117	NZ Breakers (Nzl)	89	34	26	24	33	36	24	16	13
9	16.10.2024	Denver Nuggets	94	Oklahoma City Thunder	124	33	20	18	23	30	32	25	37
10	18.10.2024	Oklahoma City Thunder	104	Atlanta Hawks	99	27	22	28	27	28	23	28	20
11	25.10.2024	Denver Nuggets	87	Oklahoma City Thunder	102	24	27	17	19	31	27	27	17
12	27.10.2024	Chicago Bulls	95	Oklahoma City Thunder	114	21	18	26	30	26	33	29	26
13	27.10.2024	Oklahoma City Thunder	128	Atlanta Hawks	104	23	34	32	39	27	31	28	18
14	31.10.2024	Oklahoma City Thunder	105	San Antonio Spurs	93	26	33	23	23	19	25	26	23
15	02.11.2024	Portland Trail Blazers	114	Oklahoma City Thunder	137	24	44	17	29	37	31	38	31
16	03.11.2024	Los Angeles Clippers	92	Oklahoma City Thunder	105	28	29	21	14	19	34	28	24
17	05.11.2024	Oklahoma City Thunder	102	Orlando Magic	86	39	19	26	18	26	17	15	28
18	07.11.2024	Denver Nuggets	124	Oklahoma City Thunder	122	30	25	40	29	32	34	29	27
19	09.11.2024	Oklahoma City Thunder	126	Houston Rockets	107	31	44	23	28	31	20	25	31
20	11.11.2024	Oklahoma City Thunder	116	Golden State Warriors	127	33	25	21	37	26	39	42	20
21	12.11.2024	Oklahoma City Thunder	134	Los Angeles Clippers	128	25	41	33	35	24	29	41	34
22	14.11.2024	Oklahoma City Thunder	106	New Orleans Pelicans	88	33	21	28	24	28	22	18	20
23	16.11.2024	Oklahoma City Thunder	99	Phoenix Suns	83	29	19	35	16	14	22	24	23
24	18.11.2024	Oklahoma City Thunder	119	Dallas Mavericks	121	34	24	34	27	39	27	31	24
25	20.11.2024	San Antonio Spurs	110	Oklahoma City Thunder	104	32	28	33	17	35	22	20	27
26	21.11.2024	Oklahoma City Thunder	109	Portland Trail Blazers	99	21	26	23	39	23	21	25	30
27	26.11.2024	Sacramento Kings	109	Oklahoma City Thunder	130	30	32	22	25	31	32	34	33
28	28.11.2024	Golden State Warriors	101	Oklahoma City Thunder	105	23	27	33	18	39	23	22	21
29	30.11.2024	Los Angeles Lakers	93	Oklahoma City Thunder	101	24	24	21	24	32	19	20	30
30	02.12.2024	Houston Rockets	119	Oklahoma City Thunder	116	33	29	29	28	28	32	36	20
31	04.12.2024	Oklahoma City Thunder	133	Utah Jazz	106	32	30	40	31	25	25	25	31
32	06.12.2024	Toronto Raptors	92	Oklahoma City Thunder	129	17	25	23	27	34	33	32	30
33	08.12.2024	New Orleans Pelicans	109	Oklahoma City Thunder	119	23	28	29	29	35	42	22	20
34	11.12.2024	Oklahoma City Thunder	118	Dallas Mavericks	104	32	25	33	28	24	30	19	31
35	15.12.2024	Oklahoma City Thunder	111	Houston Rockets	96	18	23	34	36	20	22	27	27
36	18.12.2024	Milwaukee Bucks	97	Oklahoma City Thunder	81	27	24	26	20	28	22	14	17
37	20.12.2024	Orlando Magic	99	Oklahoma City Thunder	105	28	18	28	25	29	36	17	23
38	21.12.2024	Miami Heat	97	Oklahoma City Thunder	104	25	22	23	27	30	20	31	23
39	24.12.2024	Oklahoma City Thunder	123	Washington Wizards	105	29	38	24	32	32	31	24	18
40	27.12.2024	Indiana Pacers	114	Oklahoma City Thunder	120	29	32	23	30	19	34	30	37
41	28.12.2024	Charlotte Hornets	94	Oklahoma City Thunder	106	22	24	28	20	28	33	29	16
42	30.12.2024	Oklahoma City Thunder	130	Memphis Grizzlies	106	34	42	26	28	31	19	24	32
43	01.01. 01:00	Oklahoma City Thunder	113	Minnesota Timberwolves	105	21	25	43	24	24	28	23	30
44	03.01. 01:00	Oklahoma City Thunder	116	Los Angeles Clippers	98	22	26	42	26	30	22	20	26
45	04.01. 01:00	Oklahoma City Thunder	117	New York Knicks	107	33	21	26	37	30	36	22	19
46	05.01. 20:30	Oklahoma City Thunder	105	Boston Celtics	92	32	23	21	29	35	30	15	12
47	09.01. 00:00	Cleveland Cavaliers	129	Oklahoma City Thunder	122	25	37	41	26	32	27	43	20
48	11.01. 00:30	New York Knicks	101	Oklahoma City Thunder	126	17	26	31	27	31	39	32	24
49	12.01. 23:00	Washington Wizards	95	Oklahoma City Thunder	136	25	18	26	26	37	30	37	32
50	15.01. 00:00	Philadelphia 76ers	102	Oklahoma City Thunder	118	21	22	38	21	37	21	29	31
51	17.01. 00:30	Oklahoma City Thunder	134	Cleveland Cavaliers	114	32	43	44	15	14	35	32	33
\.


--
-- Data for Name: oklahoma_city_thunder_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.oklahoma_city_thunder_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
17.01.2025 00:30	1	Gilgeous-Alexander S.	OKC	40	3	8	1754	17	26	0	0	1	5	5	5	32	0	3	1	2	2	0	0	0
17.01.2025 00:30	2	Dort L.	OKC	22	2	2	1182	8	11	0	0	6	9	0	0	12	0	2	4	1	1	1	0	0
17.01.2025 00:30	3	Williams J.	OKC	19	6	5	1807	8	14	0	0	1	4	2	2	29	1	5	2	3	0	2	0	0
17.01.2025 00:30	4	Joe I.	OKC	12	3	0	1283	4	7	0	0	4	7	0	0	14	0	3	2	2	1	0	0	0
17.01.2025 00:30	5	Carlson B.	OKC	11	4	0	1047	4	8	0	0	3	6	0	0	0	1	3	2	0	0	1	0	0
17.01.2025 00:30	6	Caruso A.	OKC	10	1	2	814	3	3	0	0	2	2	2	2	19	0	1	1	3	0	0	0	0
17.01.2025 00:30	7	Wallace C.	OKC	6	6	2	1590	3	6	0	0	0	1	0	0	13	0	6	2	0	1	0	0	0
17.01.2025 00:30	8	Williams J.	OKC	5	5	1	849	2	6	0	0	1	5	0	0	6	2	3	4	0	0	0	0	0
17.01.2025 00:30	9	Wiggins A.	OKC	4	5	3	1971	2	8	0	0	0	1	0	0	8	2	3	1	0	1	0	0	0
17.01.2025 00:30	10	Dieng O.	OKC	3	2	0	554	1	3	0	0	0	2	1	2	-9	1	1	0	0	0	0	0	0
17.01.2025 00:30	11	Williams K.	OKC	2	1	2	703	1	3	0	0	0	2	0	0	0	0	1	0	1	0	0	0	0
17.01.2025 00:30	12	Ducas A.	OKC	0	1	0	423	0	1	0	0	0	1	0	0	-12	1	0	1	0	0	0	0	0
17.01.2025 00:30	13	Flagler A.	OKC	0	0	0	423	0	9	0	0	0	8	0	0	-12	0	0	0	0	0	1	0	0
15.01.2025 00:00	14	Gilgeous-Alexander S.	OKC	32	3	9	1991	12	15	0	0	1	3	7	8	15	1	2	4	2	4	1	0	0
15.01.2025 00:00	15	Williams J.	OKC	24	4	6	2029	8	15	0	0	2	5	6	6	21	1	3	3	3	4	1	0	0
15.01.2025 00:00	16	Wallace C.	OKC	18	5	4	2041	7	10	0	0	2	5	2	2	27	3	2	3	1	1	0	0	0
15.01.2025 00:00	17	Joe I.	OKC	10	1	1	1253	4	8	0	0	2	6	0	0	4	0	1	1	0	1	0	0	0
15.01.2025 00:00	18	Hartenstein I.	OKC	9	16	3	1845	4	7	0	0	0	1	1	2	13	3	13	2	1	2	1	0	0
15.01.2025 00:00	19	Dort L.	OKC	8	2	1	1600	3	8	0	0	2	5	0	0	30	1	1	2	0	2	0	0	0
15.01.2025 00:00	20	Wiggins A.	OKC	6	3	3	946	3	5	0	0	0	1	0	0	-12	1	2	0	0	0	0	0	0
15.01.2025 00:00	21	Williams J.	OKC	5	1	3	800	2	5	0	0	1	4	0	0	-2	0	1	4	1	2	0	0	0
15.01.2025 00:00	22	Carlson B.	OKC	3	0	0	150	1	1	0	0	1	1	0	0	1	0	0	1	0	0	0	0	0
15.01.2025 00:00	23	Caruso A.	OKC	3	1	1	1068	1	4	0	0	1	3	0	0	-15	0	1	2	2	0	1	0	0
15.01.2025 00:00	24	Ducas A.	OKC	0	1	0	94	0	0	0	0	0	0	0	0	-1	0	1	0	0	0	0	0	0
15.01.2025 00:00	25	Williams K.	OKC	0	1	1	583	0	3	0	0	0	2	0	0	-1	0	1	0	0	1	0	0	0
12.01.2025 23:00	26	Gilgeous-Alexander S.	OKC	27	7	4	1808	5	17	0	0	1	4	16	17	30	1	6	3	2	3	0	0	0
12.01.2025 23:00	27	Wiggins A.	OKC	23	9	4	1828	7	12	0	0	2	4	7	8	27	3	6	4	1	1	1	0	0
12.01.2025 23:00	28	Williams J.	OKC	17	6	2	1279	4	13	0	0	1	4	8	8	21	0	6	1	0	3	0	0	0
12.01.2025 23:00	29	Wallace C.	OKC	14	2	5	1787	6	7	0	0	2	3	0	0	22	1	1	1	2	0	0	0	0
12.01.2025 23:00	30	Dort L.	OKC	11	2	1	1444	5	8	0	0	1	3	0	0	14	0	2	2	2	1	0	0	0
12.01.2025 23:00	31	Hartenstein I.	OKC	10	12	2	1300	4	7	0	0	0	0	2	2	20	6	6	1	0	0	0	0	0
12.01.2025 23:00	32	Williams K.	OKC	10	4	1	1316	4	9	0	0	2	4	0	0	25	0	4	3	1	3	0	0	0
12.01.2025 23:00	33	Williams J.	OKC	9	9	4	1448	4	7	0	0	1	4	0	0	19	3	6	1	1	0	2	0	0
12.01.2025 23:00	34	Joe I.	OKC	7	2	2	1210	3	10	0	0	1	6	0	0	19	0	2	4	1	2	0	0	0
12.01.2025 23:00	35	Carlson B.	OKC	5	3	0	490	2	4	0	0	1	2	0	0	4	1	2	2	0	0	1	0	0
12.01.2025 23:00	36	Ducas A.	OKC	3	0	1	490	1	1	0	0	1	1	0	0	4	0	0	0	1	0	0	0	0
11.01.2025 00:30	37	Gilgeous-Alexander S.	OKC	39	3	2	1762	15	21	0	0	1	1	8	8	18	0	3	2	2	2	1	0	0
11.01.2025 00:30	38	Joe I.	OKC	31	1	2	1816	11	16	0	0	8	11	1	1	31	0	1	2	0	1	0	0	0
11.01.2025 00:30	39	Williams J.	OKC	19	4	5	1999	8	16	0	0	0	3	3	4	5	0	4	3	1	1	2	0	0
11.01.2025 00:30	40	Wiggins A.	OKC	8	5	1	1314	4	4	0	0	0	0	0	0	25	1	4	0	1	0	0	0	0
11.01.2025 00:30	41	Dort L.	OKC	6	5	2	1368	2	5	0	0	2	3	0	0	13	2	3	4	1	1	0	0	0
11.01.2025 00:30	42	Hartenstein I.	OKC	6	9	6	1798	2	6	0	0	0	0	2	2	10	1	8	4	2	7	2	0	0
11.01.2025 00:30	43	Wallace C.	OKC	6	2	1	1806	2	7	0	0	1	2	1	2	9	0	2	3	2	0	1	0	0
11.01.2025 00:30	44	Williams K.	OKC	5	7	0	1336	2	8	0	0	0	2	1	1	10	1	6	2	0	1	1	0	0
11.01.2025 00:30	45	Carlson B.	OKC	3	0	0	138	1	1	0	0	1	1	0	0	-3	0	0	0	0	0	0	0	0
11.01.2025 00:30	46	Williams J.	OKC	3	10	1	925	1	4	0	0	1	3	0	0	10	3	7	3	0	2	2	0	0
11.01.2025 00:30	47	Ducas A.	OKC	0	0	0	138	0	1	0	0	0	1	0	0	-3	0	0	0	0	0	0	0	0
09.01.2025 00:00	48	Gilgeous-Alexander S.	OKC	31	5	4	2295	13	27	0	0	1	6	4	4	-1	1	4	5	3	5	2	0	0
09.01.2025 00:00	49	Williams J.	OKC	25	5	9	2154	9	17	0	0	2	7	5	7	-12	1	4	3	3	3	1	0	0
09.01.2025 00:00	50	Hartenstein I.	OKC	18	11	8	1835	8	14	0	0	0	1	2	2	-2	5	6	5	0	2	0	0	0
09.01.2025 00:00	51	Wallace C.	OKC	15	2	3	1852	6	8	0	0	3	3	0	0	2	0	2	4	0	0	0	0	0
09.01.2025 00:00	52	Wiggins A.	OKC	11	2	1	1298	5	7	0	0	1	2	0	0	4	1	1	2	0	1	0	0	0
09.01.2025 00:00	53	Joe I.	OKC	8	7	3	1493	2	6	0	0	2	6	2	2	0	1	6	1	2	0	0	0	0
09.01.2025 00:00	54	Dort L.	OKC	7	4	4	2025	2	6	0	0	1	3	2	2	-15	0	4	3	1	2	2	0	0
09.01.2025 00:00	55	Williams K.	OKC	4	0	1	794	2	4	0	0	0	2	0	0	-9	0	0	1	0	0	0	0	0
09.01.2025 00:00	56	Williams J.	OKC	3	2	2	654	1	1	0	0	1	1	0	0	-2	0	2	0	0	0	0	0	0
05.01.2025 20:30	57	Gilgeous-Alexander S.	OKC	33	11	6	2332	11	23	0	0	3	6	8	8	12	2	9	2	3	3	2	0	0
05.01.2025 20:30	58	Wiggins A.	OKC	15	1	2	1175	6	9	0	0	3	6	0	0	2	0	1	3	0	1	0	0	0
05.01.2025 20:30	59	Dort L.	OKC	14	6	1	2329	5	14	0	0	4	9	0	0	12	2	4	3	1	3	1	0	1
05.01.2025 20:30	60	Wallace C.	OKC	13	3	2	2104	6	13	0	0	1	5	0	0	11	0	3	1	2	0	0	0	0
05.01.2025 20:30	61	Williams J.	OKC	10	6	5	2087	3	10	0	0	1	3	3	4	19	0	6	5	1	4	0	0	0
05.01.2025 20:30	62	Hartenstein I.	OKC	8	10	2	2108	4	9	0	0	0	1	0	1	11	2	8	2	2	2	3	0	0
05.01.2025 20:30	63	Joe I.	OKC	6	2	2	1015	2	5	0	0	2	5	0	0	-5	1	1	0	1	0	0	0	0
05.01.2025 20:30	64	Williams J.	OKC	3	6	2	519	1	2	0	0	1	2	0	0	6	1	5	1	0	2	0	0	0
05.01.2025 20:30	65	Williams K.	OKC	3	1	0	731	1	2	0	0	1	1	0	0	-3	1	0	1	1	0	0	0	0
04.01.2025 01:00	66	Gilgeous-Alexander S.	OKC	33	4	7	2201	12	26	0	0	2	3	7	7	10	1	3	1	1	2	1	0	0
04.01.2025 01:00	67	Williams J.	OKC	20	4	5	2271	8	17	0	0	1	4	3	5	6	0	4	2	2	0	1	0	0
04.01.2025 01:00	68	Wiggins A.	OKC	19	5	2	1493	7	9	0	0	4	6	1	1	8	2	3	1	0	0	2	0	0
04.01.2025 01:00	69	Dort L.	OKC	11	2	1	1951	4	7	0	0	3	5	0	0	9	0	2	5	1	1	1	0	0
04.01.2025 01:00	70	Mitchell A.	OKC	8	1	0	792	3	6	0	0	0	0	2	2	-4	0	1	2	0	0	0	0	0
04.01.2025 01:00	71	Joe I.	OKC	7	2	1	885	3	8	0	0	1	4	0	0	3	0	2	1	2	0	0	0	0
04.01.2025 01:00	72	Williams J.	OKC	6	3	1	477	2	3	0	0	2	3	0	0	3	0	3	1	0	0	1	0	0
04.01.2025 01:00	73	Wallace C.	OKC	5	4	3	1950	1	3	0	0	1	2	2	2	14	1	3	2	2	4	0	0	0
04.01.2025 01:00	74	Hartenstein I.	OKC	4	14	7	1869	2	4	0	0	0	0	0	2	11	2	12	1	1	3	1	0	0
04.01.2025 01:00	75	Williams K.	OKC	4	2	0	511	1	1	0	0	0	0	2	2	-10	1	1	1	0	3	0	0	0
03.01.2025 01:00	76	Gilgeous-Alexander S.	OKC	29	3	8	1807	9	17	0	0	2	5	9	9	19	0	3	1	2	1	0	0	0
03.01.2025 01:00	77	Williams J.	OKC	18	3	4	1776	8	14	0	0	1	3	1	2	33	0	3	0	2	2	1	0	0
03.01.2025 01:00	78	Hartenstein I.	OKC	11	9	6	1409	5	9	0	0	0	1	1	1	23	0	9	4	1	2	2	0	0
03.01.2025 01:00	79	Mitchell A.	OKC	11	2	3	1476	3	6	0	0	1	3	4	4	-8	1	1	1	0	2	0	0	0
03.01.2025 01:00	80	Dort L.	OKC	9	1	0	1404	3	7	0	0	3	7	0	0	26	0	1	3	2	0	0	0	0
03.01.2025 01:00	81	Joe I.	OKC	9	2	0	1052	3	6	0	0	3	6	0	0	-8	0	2	0	0	0	0	0	0
03.01.2025 01:00	82	Wallace C.	OKC	9	2	1	1045	4	6	0	0	1	1	0	0	2	0	2	2	2	0	0	0	0
03.01.2025 01:00	83	Wiggins A.	OKC	9	4	2	1689	4	7	0	0	1	3	0	0	16	2	2	0	0	1	0	0	1
03.01.2025 01:00	84	Williams K.	OKC	7	1	2	872	2	6	0	0	2	3	1	2	3	0	1	2	1	0	0	0	0
03.01.2025 01:00	85	Dieng O.	OKC	2	0	0	190	1	1	0	0	0	0	0	0	-2	0	0	0	1	0	0	0	0
03.01.2025 01:00	86	Williams J.	OKC	2	7	2	1143	1	7	0	0	0	6	0	0	-8	1	6	1	0	0	0	0	0
03.01.2025 01:00	87	Carlson B.	OKC	0	0	1	190	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
03.01.2025 01:00	88	Jones D.	OKC	0	1	0	347	0	0	0	0	0	0	0	2	-4	0	1	0	0	1	0	0	0
01.01.2025 01:00	89	Gilgeous-Alexander S.	OKC	40	3	2	2060	15	23	0	0	3	5	7	9	11	1	2	1	4	3	0	0	0
01.01.2025 01:00	90	Hartenstein I.	OKC	15	10	4	1920	5	10	0	0	0	1	5	5	13	3	7	1	1	0	2	0	0
01.01.2025 01:00	91	Dort L.	OKC	14	6	2	2076	5	12	0	0	4	7	0	0	3	2	4	2	0	1	0	0	0
01.01.2025 01:00	92	Williams J.	OKC	14	7	7	2264	6	12	0	0	1	4	1	4	-10	0	7	3	3	3	0	0	0
01.01.2025 01:00	93	Joe I.	OKC	7	0	1	759	3	6	0	0	1	4	0	0	20	0	0	0	1	0	0	0	0
01.01.2025 01:00	94	Wiggins A.	OKC	7	3	1	820	3	6	0	0	1	2	0	0	-8	0	3	0	1	1	0	0	0
01.01.2025 01:00	95	Wallace C.	OKC	5	2	7	1920	1	8	0	0	0	4	3	4	19	1	1	2	4	0	0	0	0
01.01.2025 01:00	96	Williams K.	OKC	5	2	0	877	2	4	0	0	1	2	0	0	-4	1	1	2	1	1	0	0	0
01.01.2025 01:00	97	Mitchell A.	OKC	3	3	0	1078	1	4	0	0	0	3	1	1	2	1	2	2	0	0	0	0	0
01.01.2025 01:00	98	Williams J.	OKC	3	1	1	626	1	4	0	0	1	4	0	0	-6	0	1	0	1	0	0	0	0
30.12.2024 00:00	99	Gilgeous-Alexander S.	OKC	35	6	7	1684	14	19	0	0	1	5	6	6	27	0	6	1	1	1	4	0	0
30.12.2024 00:00	100	Mitchell A.	OKC	17	1	3	1295	6	11	0	0	3	5	2	2	20	0	1	3	1	0	0	0	0
30.12.2024 00:00	101	Wiggins A.	OKC	16	3	0	1426	6	13	0	0	1	5	3	3	3	0	3	0	2	0	0	0	0
30.12.2024 00:00	102	Williams J.	OKC	14	10	8	1535	7	16	0	0	0	5	0	0	12	4	6	3	2	2	1	0	0
30.12.2024 00:00	103	Hartenstein I.	OKC	12	9	6	1513	6	13	0	0	0	2	0	0	14	2	7	3	0	2	3	0	0
30.12.2024 00:00	104	Williams K.	OKC	12	3	3	692	4	6	0	0	3	4	1	1	15	1	2	3	0	0	0	0	0
30.12.2024 00:00	105	Joe I.	OKC	11	3	0	1330	4	9	0	0	3	8	0	0	21	1	2	2	1	1	0	0	0
30.12.2024 00:00	106	Wallace C.	OKC	5	1	3	1855	2	5	0	0	1	2	0	0	7	0	1	4	2	1	0	0	0
30.12.2024 00:00	107	Williams J.	OKC	5	2	1	580	2	2	0	0	1	1	0	0	-4	0	2	1	0	1	0	0	0
30.12.2024 00:00	108	Dort L.	OKC	3	4	2	1586	1	6	0	0	1	5	0	0	13	1	3	3	0	0	0	0	0
30.12.2024 00:00	109	Carlson B.	OKC	0	1	0	240	0	1	0	0	0	1	0	0	-3	0	1	0	0	1	0	0	0
30.12.2024 00:00	110	Dieng O.	OKC	0	2	1	270	0	2	0	0	0	1	0	0	-3	0	2	0	1	1	0	0	0
30.12.2024 00:00	111	Jones D.	OKC	0	0	1	394	0	0	0	0	0	0	0	0	-2	0	0	1	0	0	1	0	0
28.12.2024 23:00	112	Gilgeous-Alexander S.	OKC	22	4	6	1980	8	15	0	0	1	6	5	6	12	1	3	4	2	6	1	0	0
28.12.2024 23:00	113	Williams J.	OKC	20	3	6	2018	8	21	0	0	1	7	3	3	17	0	3	0	1	1	0	0	0
28.12.2024 23:00	114	Wiggins A.	OKC	17	5	1	1995	6	10	0	0	3	7	2	2	18	3	2	2	2	2	0	0	0
28.12.2024 23:00	115	Hartenstein I.	OKC	12	15	4	1528	6	7	0	0	0	0	0	0	10	1	14	4	1	3	0	0	0
28.12.2024 23:00	116	Mitchell A.	OKC	10	5	4	1894	4	8	0	0	1	2	1	1	7	1	4	1	0	1	0	0	0
28.12.2024 23:00	117	Williams J.	OKC	9	4	6	1352	3	7	0	0	3	6	0	0	2	2	2	3	1	1	0	0	0
28.12.2024 23:00	118	Williams K.	OKC	9	4	1	1322	4	6	0	0	0	0	1	1	2	0	4	1	1	1	0	0	0
28.12.2024 23:00	119	Joe I.	OKC	5	4	0	982	2	7	0	0	1	6	0	1	2	1	3	1	1	0	0	0	0
28.12.2024 23:00	120	Jones D.	OKC	2	3	1	886	1	5	0	0	0	3	0	0	-11	0	3	2	0	0	0	0	0
28.12.2024 23:00	121	Dieng O.	OKC	0	2	0	443	0	2	0	0	0	1	0	0	1	0	2	1	0	0	0	0	0
27.12.2024 00:00	122	Gilgeous-Alexander S.	OKC	45	7	8	2279	15	22	0	0	4	5	11	11	10	0	7	2	1	1	2	0	0
27.12.2024 00:00	123	Williams J.	OKC	20	4	5	2130	8	22	0	0	2	6	2	2	-8	0	4	2	0	2	0	0	0
27.12.2024 00:00	124	Dort L.	OKC	13	7	0	2072	5	13	0	0	3	8	0	0	11	3	4	3	0	0	0	0	0
27.12.2024 00:00	125	Hartenstein I.	OKC	11	13	1	2068	3	6	0	0	0	0	5	8	-4	2	11	2	0	0	1	0	0
27.12.2024 00:00	126	Mitchell A.	OKC	9	1	0	947	4	5	0	0	1	2	0	1	1	0	1	1	1	0	0	0	0
27.12.2024 00:00	127	Williams K.	OKC	9	6	0	996	4	6	0	0	1	2	0	0	13	2	4	0	0	0	0	0	0
27.12.2024 00:00	128	Joe I.	OKC	5	2	2	1010	2	8	0	0	1	7	0	0	0	1	1	2	0	0	0	0	0
27.12.2024 00:00	129	Williams J.	OKC	3	3	1	571	1	3	0	0	1	3	0	0	7	1	2	1	0	0	0	0	0
27.12.2024 00:00	130	Wallace C.	OKC	2	2	1	1793	1	5	0	0	0	2	0	0	-4	0	2	3	2	0	1	0	0
27.12.2024 00:00	131	Wiggins A.	OKC	2	0	2	355	1	4	0	0	0	2	0	0	-3	0	0	1	0	0	0	0	0
27.12.2024 00:00	132	Jones D.	OKC	1	0	0	179	0	1	0	0	0	0	1	2	7	0	0	1	0	0	0	0	0
\.


--
-- Data for Name: oklahoma_city_thunder_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.oklahoma_city_thunder_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Hartenstein Isaiah	Lesionado	2025-01-17 13:54:03.012415
2	Holmgren Chet	Lesionado	2025-01-17 13:54:03.051055
3	Mitchell Ajay	Lesionado	2025-01-17 13:54:03.052846
4	Topic Nikola	Lesionado	2025-01-17 13:54:03.054879
\.


--
-- Data for Name: orlando_magic; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.orlando_magic (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	05.05.2024	Cleveland Cavaliers	106	Orlando Magic	94	18	25	33	30	24	29	15	26
2	12.07.2024	Orlando Magic	106	Cleveland Cavaliers	79	36	26	25	19	21	20	16	22
3	15.07.2024	New Orleans Pelicans	86	Orlando Magic	91	21	24	22	19	21	14	25	31
4	18.07.2024	Orlando Magic	98	Memphis Grizzlies	104	24	16	34	24	33	24	18	29
5	19.07.2024\nApós Prol.	Brooklyn Nets	102	Orlando Magic	100	18	31	26	20	23	18	31	23
6	21.07.2024	Minnesota Timberwolves	115	Orlando Magic	100	36	23	21	35	20	28	26	26
7	07.10.2024	New Orleans Pelicans	106	Orlando Magic	104	31	25	25	25	28	26	21	29
8	10.10.2024	San Antonio Spurs	107	Orlando Magic	97	20	29	30	28	34	22	23	18
9	19.10.2024	Orlando Magic	114	Philadelphia 76ers	99	27	31	27	29	20	35	16	28
10	24.10.2024	Miami Heat	97	Orlando Magic	116	32	22	18	25	32	26	39	19
11	26.10.2024	Orlando Magic	116	Brooklyn Nets	101	22	27	32	35	23	23	25	30
12	27.10.2024	Memphis Grizzlies	124	Orlando Magic	111	34	35	21	34	24	19	35	33
13	28.10.2024	Orlando Magic	119	Indiana Pacers	115	35	36	22	26	36	23	39	17
14	31.10.2024	Chicago Bulls	102	Orlando Magic	99	18	34	34	16	33	29	25	12
15	01.11.2024	Cleveland Cavaliers	120	Orlando Magic	109	34	29	32	25	16	28	34	31
16	04.11.2024	Dallas Mavericks	108	Orlando Magic	85	30	35	23	20	22	18	21	24
17	05.11.2024	Oklahoma City Thunder	102	Orlando Magic	86	39	19	26	18	26	17	15	28
18	07.11.2024	Indiana Pacers	118	Orlando Magic	111	38	23	26	31	26	31	28	26
19	09.11.2024	Orlando Magic	115	New Orleans Pelicans	88	37	20	28	30	23	24	25	16
20	10.11.2024	Orlando Magic	121	Washington Wizards	94	26	35	30	30	22	34	16	22
21	13.11.2024	Orlando Magic	114	Charlotte Hornets	89	31	27	31	25	29	18	19	23
22	14.11.2024	Orlando Magic	94	Indiana Pacers	90	18	23	27	26	27	18	27	18
23	16.11.2024	Orlando Magic	98	Philadelphia 76ers	86	24	19	30	25	21	24	27	14
24	19.11.2024	Phoenix Suns	99	Orlando Magic	109	22	26	20	31	26	38	20	25
25	21.11.2024	Los Angeles Clippers	104	Orlando Magic	93	29	28	30	17	25	29	21	18
26	22.11.2024	Los Angeles Lakers	118	Orlando Magic	119	38	29	21	30	36	24	29	30
27	24.11.2024	Orlando Magic	111	Detroit Pistons	100	33	23	32	23	21	32	26	21
28	26.11.2024	Charlotte Hornets	84	Orlando Magic	95	25	21	16	22	18	24	16	37
29	28.11.2024	Orlando Magic	133	Chicago Bulls	119	38	35	32	28	25	29	34	31
30	30.11.2024	Brooklyn Nets	100	Orlando Magic	123	29	20	22	29	33	28	35	27
31	01.12.2024	Brooklyn Nets	92	Orlando Magic	100	29	21	19	23	26	24	25	25
32	04.12.2024	New York Knicks	121	Orlando Magic	106	36	35	35	15	27	24	24	31
33	05.12.2024	Philadelphia 76ers	102	Orlando Magic	106	22	31	24	25	34	19	24	29
34	07.12.2024	Philadelphia 76ers	102	Orlando Magic	94	25	25	21	31	27	14	18	35
35	08.12.2024	Orlando Magic	115	Phoenix Suns	110	29	28	27	31	34	28	25	23
36	11.12.2024	Milwaukee Bucks	114	Orlando Magic	109	25	35	20	34	33	26	13	37
37	15.12.2024	Orlando Magic	91	New York Knicks	100	22	19	26	24	22	29	24	25
38	20.12.2024	Orlando Magic	99	Oklahoma City Thunder	105	28	18	28	25	29	36	17	23
39	22.12.2024	Orlando Magic	121	Miami Heat	114	28	28	28	37	40	36	30	8
40	24.12.2024	Orlando Magic	108	Boston Celtics	104	21	22	36	29	32	26	21	25
41	27.12.2024	Orlando Magic	88	Miami Heat	89	31	21	19	17	22	19	20	28
42	28.12.2024	Orlando Magic	85	New York Knicks	108	29	25	14	17	26	28	22	32
43	29.12.2024	Orlando Magic	102	Brooklyn Nets	101	21	22	25	34	27	34	22	18
44	02.01. 00:00	Detroit Pistons	105	Orlando Magic	96	31	34	19	21	21	28	26	21
45	04.01. 00:30	Toronto Raptors	97	Orlando Magic	106	24	26	18	29	37	25	26	18
46	05.01. 23:30	Orlando Magic	92	Utah Jazz	105	25	18	19	30	22	21	28	34
47	07.01. 00:30	New York Knicks	94	Orlando Magic	103	28	23	17	26	24	29	22	28
48	10.01. 00:00	Orlando Magic	89	Minnesota Timberwolves	104	18	21	23	27	29	23	26	26
49	11.01. 00:00	Orlando Magic	106	Milwaukee Bucks	109	31	20	30	25	29	21	28	31
50	12.01. 23:00	Orlando Magic	104	Philadelphia 76ers	99	24	25	24	31	21	27	29	22
51	16.01. 01:00	Milwaukee Bucks	122	Orlando Magic	93	34	28	30	30	16	25	27	25
\.


--
-- Data for Name: orlando_magic_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.orlando_magic_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 01:00	1	Banchero P.	ORL	22	5	2	1557	8	20	0	0	2	7	4	5	-25	0	5	2	0	7	1	0	0
16.01.2025 01:00	2	Queen T.	ORL	13	2	3	1654	5	11	0	0	3	6	0	0	-14	0	2	2	4	1	0	0	0
16.01.2025 01:00	3	Carter W.	ORL	12	10	1	1958	3	12	0	0	2	4	4	5	-11	3	7	4	2	0	0	0	0
16.01.2025 01:00	4	Anthony C.	ORL	11	4	9	1642	5	13	0	0	1	5	0	0	-8	1	3	6	0	2	0	0	0
16.01.2025 01:00	5	Black A.	ORL	10	0	4	1810	3	8	0	0	0	2	4	7	-17	0	0	4	2	2	0	0	0
16.01.2025 01:00	6	Isaac J.	ORL	9	3	0	922	4	8	0	0	0	3	1	2	-18	1	2	1	2	0	0	0	0
16.01.2025 01:00	7	Caldwell-Pope K.	ORL	8	2	1	1377	3	9	0	0	2	7	0	0	-14	0	2	0	1	1	0	0	0
16.01.2025 01:00	8	Houstan C.	ORL	8	2	2	1468	2	8	0	0	2	7	2	2	-24	1	1	1	0	0	0	0	0
16.01.2025 01:00	9	da Silva T.	ORL	0	4	1	1324	0	4	0	0	0	3	0	0	-10	3	1	2	1	0	0	0	0
16.01.2025 01:00	10	Joseph C.	ORL	0	0	1	688	0	2	0	0	0	2	0	0	-4	0	0	2	1	0	0	0	0
12.01.2025 23:00	11	Anthony C.	ORL	27	3	4	2258	11	17	0	0	2	6	3	4	-6	1	2	5	2	2	0	0	0
12.01.2025 23:00	12	Banchero P.	ORL	20	8	6	1626	5	8	0	0	1	2	9	11	18	2	6	2	0	6	1	0	0
12.01.2025 23:00	13	Isaac J.	ORL	20	11	1	1626	8	13	0	0	2	4	2	4	1	5	6	1	0	0	2	0	0
12.01.2025 23:00	14	Black A.	ORL	17	6	6	2246	7	18	0	0	0	2	3	6	1	1	5	2	2	3	0	0	0
12.01.2025 23:00	15	Houstan C.	ORL	5	1	0	1542	2	7	0	0	1	6	0	0	-3	0	1	4	1	1	0	0	0
12.01.2025 23:00	16	Bitadze G.	ORL	4	2	1	723	2	3	0	0	0	0	0	0	1	0	2	2	2	1	2	0	0
12.01.2025 23:00	17	Carter W.	ORL	4	4	1	1479	1	4	0	0	0	3	2	3	-6	0	4	4	1	2	1	0	0
12.01.2025 23:00	18	Queen T.	ORL	4	5	3	1852	2	5	0	0	0	3	0	0	9	3	2	1	0	0	2	0	0
12.01.2025 23:00	19	Joseph C.	ORL	3	1	1	987	1	5	0	0	1	4	0	0	10	0	1	1	1	0	1	0	0
12.01.2025 23:00	20	da Silva T.	ORL	0	0	0	61	0	0	0	0	0	0	0	0	0	0	0	1	1	1	0	0	0
11.01.2025 00:00	21	Banchero P.	ORL	34	7	3	1592	11	21	0	0	5	8	7	10	6	0	7	1	2	3	1	0	0
11.01.2025 00:00	22	Anthony C.	ORL	18	7	2	2117	5	15	0	0	3	10	5	8	3	2	5	1	2	2	1	0	0
11.01.2025 00:00	23	da Silva T.	ORL	16	10	2	2398	6	13	0	0	2	7	2	2	-3	3	7	2	0	2	0	0	0
11.01.2025 00:00	24	Black A.	ORL	15	2	2	1211	6	11	0	0	1	4	2	2	-14	1	1	2	0	0	0	0	0
11.01.2025 00:00	25	Isaac J.	ORL	9	4	1	1207	4	10	0	0	1	4	0	0	-6	2	2	1	2	0	2	0	1
11.01.2025 00:00	26	Houstan C.	ORL	5	3	2	1768	2	5	0	0	1	4	0	0	-3	2	1	5	0	0	0	0	0
11.01.2025 00:00	27	Bitadze G.	ORL	4	5	1	1353	2	4	0	0	0	0	0	0	6	1	4	2	0	0	0	0	0
11.01.2025 00:00	28	Caldwell-Pope K.	ORL	3	1	3	683	1	3	0	0	1	2	0	0	8	0	1	0	1	3	0	0	0
11.01.2025 00:00	29	Carter W.	ORL	2	5	3	1527	0	4	0	0	0	1	2	4	-9	1	4	4	1	0	1	0	0
11.01.2025 00:00	30	Howard J.	ORL	0	0	1	435	0	0	0	0	0	0	0	0	-2	0	0	1	0	0	0	0	0
11.01.2025 00:00	31	Queen T.	ORL	0	0	0	109	0	0	0	0	0	0	0	0	-1	0	0	0	0	0	0	0	0
10.01.2025 00:00	32	Bitadze G.	ORL	15	8	2	1819	7	11	0	0	0	1	1	1	-9	1	7	2	1	0	3	0	1
10.01.2025 00:00	33	Houstan C.	ORL	14	1	1	1982	4	7	0	0	4	6	2	2	-4	0	1	3	0	2	0	0	0
10.01.2025 00:00	34	Caldwell-Pope K.	ORL	13	1	2	1982	5	7	0	0	3	4	0	0	-20	0	1	3	1	1	1	0	0
10.01.2025 00:00	35	Anthony C.	ORL	12	3	5	1614	5	13	0	0	0	3	2	3	-13	0	3	1	2	4	2	0	1
10.01.2025 00:00	36	Howard J.	ORL	10	8	4	1387	4	11	0	0	2	9	0	0	-5	2	6	3	0	2	0	0	0
10.01.2025 00:00	37	Carter W.	ORL	8	6	1	1061	3	10	0	0	0	3	2	5	-6	1	5	5	0	0	0	0	0
10.01.2025 00:00	38	da Silva T.	ORL	6	9	2	1430	2	9	0	0	0	5	2	2	3	3	6	1	0	1	0	0	0
10.01.2025 00:00	39	Isaac J.	ORL	4	7	0	898	1	4	0	0	0	2	2	2	-11	3	4	0	0	0	2	0	0
10.01.2025 00:00	40	Black A.	ORL	3	0	1	620	1	5	0	0	0	2	1	2	-6	0	0	2	0	1	1	0	0
10.01.2025 00:00	41	Queen T.	ORL	3	4	1	1257	1	9	0	0	1	5	0	0	-11	3	1	2	0	1	1	0	0
10.01.2025 00:00	42	Joseph C.	ORL	1	0	2	350	0	0	0	0	0	0	1	2	7	0	0	0	0	2	0	0	0
07.01.2025 00:30	43	Anthony C.	ORL	24	7	4	2198	9	18	0	0	3	6	3	4	3	2	5	3	1	2	0	0	0
07.01.2025 00:30	44	Carter W.	ORL	19	2	4	1542	8	11	0	0	3	3	0	0	5	0	2	1	1	1	0	0	0
07.01.2025 00:30	45	Caldwell-Pope K.	ORL	15	4	2	1826	6	10	0	0	3	6	0	0	7	1	3	2	3	2	0	0	0
07.01.2025 00:30	46	Isaac J.	ORL	13	9	1	1528	4	5	0	0	1	1	4	6	7	4	5	1	0	0	2	0	0
07.01.2025 00:30	47	Black A.	ORL	9	1	5	1569	1	5	0	0	0	0	7	8	8	0	1	3	2	1	0	0	0
07.01.2025 00:30	48	Howard J.	ORL	9	1	0	944	4	7	0	0	1	3	0	0	11	0	1	3	0	1	0	0	0
07.01.2025 00:30	49	da Silva T.	ORL	8	6	2	2169	4	12	0	0	0	7	0	0	8	1	5	0	0	0	0	0	0
07.01.2025 00:30	50	Bitadze G.	ORL	6	8	4	1338	3	5	0	0	0	0	0	0	4	1	7	1	0	1	3	0	0
07.01.2025 00:30	51	Houstan C.	ORL	0	1	1	959	0	3	0	0	0	3	0	0	-5	0	1	2	0	1	0	0	0
07.01.2025 00:30	52	Queen T.	ORL	0	0	0	327	0	2	0	0	0	2	0	0	-3	0	0	3	0	0	0	0	0
05.01.2025 23:30	53	Howard J.	ORL	21	2	4	1529	7	16	0	0	4	10	3	3	-7	2	0	0	0	1	0	0	0
05.01.2025 23:30	54	Carter W.	ORL	15	6	2	1157	6	10	0	0	1	3	2	2	-1	2	4	3	2	3	0	0	0
05.01.2025 23:30	55	Anthony C.	ORL	12	4	0	1708	5	14	0	0	2	4	0	0	-8	0	4	5	0	1	3	0	0
05.01.2025 23:30	56	Queen T.	ORL	11	3	6	1508	3	10	0	0	2	5	3	4	-6	1	2	3	3	2	1	0	0
05.01.2025 23:30	57	Bitadze G.	ORL	9	11	4	1723	4	9	0	0	1	2	0	4	-12	5	6	2	1	2	0	0	0
05.01.2025 23:30	58	Houstan C.	ORL	9	2	0	1487	3	10	0	0	3	10	0	0	3	1	1	1	2	0	0	0	0
05.01.2025 23:30	59	da Silva T.	ORL	6	9	2	1840	3	11	0	0	0	4	0	0	-17	3	6	2	0	0	0	0	0
05.01.2025 23:30	60	Joseph C.	ORL	5	0	3	905	2	5	0	0	1	3	0	0	3	0	0	2	0	1	0	0	0
05.01.2025 23:30	61	Caldwell-Pope K.	ORL	2	2	2	1678	1	8	0	0	0	4	0	0	-12	0	2	2	0	1	0	0	1
05.01.2025 23:30	62	Isaac J.	ORL	2	4	2	865	1	5	0	0	0	2	0	0	-8	0	4	1	0	0	0	0	0
04.01.2025 00:30	63	da Silva T.	ORL	25	4	2	2214	9	13	0	0	5	7	2	2	12	3	1	1	2	1	0	0	0
04.01.2025 00:30	64	Caldwell-Pope K.	ORL	15	1	2	1961	6	10	0	0	3	7	0	0	13	0	1	1	2	0	1	0	0
04.01.2025 00:30	65	Bitadze G.	ORL	11	13	7	1804	3	9	0	0	0	2	5	8	6	3	10	3	1	1	3	0	0
04.01.2025 00:30	66	Joseph C.	ORL	11	0	3	997	4	7	0	0	3	5	0	0	2	0	0	0	0	1	0	0	0
04.01.2025 00:30	67	Anthony C.	ORL	9	4	11	2029	4	11	0	0	1	4	0	0	13	1	3	3	1	3	0	0	0
04.01.2025 00:30	68	Isaac J.	ORL	7	4	1	803	2	3	0	0	1	2	2	3	1	1	3	2	0	2	2	0	0
04.01.2025 00:30	69	Carter W.	ORL	6	9	1	1076	2	7	0	0	0	3	2	2	3	1	8	2	1	1	1	0	0
04.01.2025 00:30	70	Houstan C.	ORL	6	3	1	1465	2	5	0	0	2	4	0	0	7	1	2	1	1	0	1	0	0
04.01.2025 00:30	71	Suggs J.	ORL	6	2	1	795	2	7	0	0	2	5	0	0	6	0	2	0	1	1	0	0	0
04.01.2025 00:30	72	Howard J.	ORL	5	0	1	608	1	5	0	0	1	4	2	2	-7	0	0	2	0	1	0	0	0
04.01.2025 00:30	73	Queen T.	ORL	5	2	2	648	2	2	0	0	1	1	0	0	-11	2	0	0	1	0	0	0	0
02.01.2025 00:00	74	Suggs J.	ORL	24	4	3	2029	9	20	0	0	3	9	3	4	-5	1	3	3	3	2	2	0	0
02.01.2025 00:00	75	Caldwell-Pope K.	ORL	21	2	2	2063	8	11	0	0	4	6	1	1	-17	0	2	2	2	2	1	0	0
02.01.2025 00:00	76	Carter W.	ORL	15	8	1	2044	7	15	0	0	0	4	1	2	-11	2	6	3	2	1	1	0	0
02.01.2025 00:00	77	Howard J.	ORL	9	1	0	912	3	4	0	0	0	1	3	4	-1	0	1	1	0	0	0	0	0
02.01.2025 00:00	78	Anthony C.	ORL	8	2	1	798	3	12	0	0	0	3	2	3	1	1	1	2	2	1	0	0	0
02.01.2025 00:00	79	Bitadze G.	ORL	8	3	6	1359	3	8	0	0	0	0	2	4	-6	1	2	2	1	2	0	0	0
02.01.2025 00:00	80	Harris G.	ORL	4	2	0	919	2	5	0	0	0	2	0	0	6	1	1	0	3	1	0	0	0
02.01.2025 00:00	81	Isaac J.	ORL	4	2	1	902	1	5	0	0	0	4	2	2	3	1	1	2	1	2	1	0	0
02.01.2025 00:00	82	Houstan C.	ORL	3	2	1	1638	1	4	0	0	1	4	0	0	6	1	1	3	2	0	0	0	0
02.01.2025 00:00	83	da Silva T.	ORL	0	6	3	1362	0	6	0	0	0	1	0	0	-18	1	5	3	1	1	0	0	0
02.01.2025 00:00	84	Joseph C.	ORL	0	1	0	374	0	1	0	0	0	1	0	0	-3	0	1	0	1	0	0	0	0
29.12.2024 20:30	85	da Silva T.	ORL	21	6	7	2076	8	15	0	0	4	9	1	1	23	3	3	1	0	2	1	0	0
29.12.2024 20:30	86	Bitadze G.	ORL	19	11	5	2034	8	10	0	0	0	1	3	5	9	4	7	4	2	1	1	0	0
29.12.2024 20:30	87	Carter W.	ORL	13	6	1	1608	6	9	0	0	0	1	1	4	-2	1	5	3	0	2	0	0	0
29.12.2024 20:30	88	Houstan C.	ORL	12	0	1	923	3	5	0	0	3	4	3	3	9	0	0	3	1	0	0	0	0
29.12.2024 20:30	89	Anthony C.	ORL	10	3	3	1016	3	11	0	0	2	6	2	2	17	1	2	2	0	0	0	0	0
29.12.2024 20:30	90	Suggs J.	ORL	8	2	2	791	2	7	0	0	0	1	4	5	-4	1	1	3	0	1	0	0	0
29.12.2024 20:30	91	Harris G.	ORL	6	0	2	884	2	4	0	0	2	4	0	2	-13	0	0	1	1	1	0	0	0
29.12.2024 20:30	92	Caldwell-Pope K.	ORL	5	1	5	2042	2	10	0	0	0	4	1	1	17	0	1	2	2	0	1	0	0
29.12.2024 20:30	93	Isaac J.	ORL	5	9	2	1119	2	6	0	0	0	1	1	2	-12	5	4	1	1	2	0	0	0
29.12.2024 20:30	94	Joseph C.	ORL	3	2	1	829	1	3	0	0	1	2	0	0	-7	1	1	1	0	1	0	0	0
29.12.2024 20:30	95	Howard J.	ORL	0	1	1	739	0	3	0	0	0	3	0	0	-18	0	1	1	0	0	0	0	0
29.12.2024 20:30	96	Queen T.	ORL	0	1	0	339	0	0	0	0	0	0	0	0	-14	0	1	1	0	3	0	0	0
28.12.2024 00:00	97	Suggs J.	ORL	27	4	3	1587	10	20	0	0	4	6	3	3	-6	1	3	5	1	3	0	0	0
28.12.2024 00:00	98	Bitadze G.	ORL	14	11	3	1835	6	9	0	0	1	1	1	2	-11	4	7	2	1	4	2	0	0
28.12.2024 00:00	99	Caldwell-Pope K.	ORL	10	0	3	1866	4	11	0	0	1	6	1	1	-10	0	0	1	2	1	0	0	0
28.12.2024 00:00	100	Black A.	ORL	9	3	2	1816	2	9	0	0	0	1	5	5	-9	2	1	4	1	1	0	0	0
28.12.2024 00:00	101	Queen T.	ORL	9	2	3	1560	3	7	0	0	3	7	0	0	-20	1	1	4	0	1	0	0	0
28.12.2024 00:00	102	Isaac J.	ORL	7	5	1	1045	3	9	0	0	0	4	1	1	-16	2	3	3	1	1	0	0	0
28.12.2024 00:00	103	Anthony C.	ORL	5	1	0	361	2	5	0	0	1	1	0	0	-8	0	1	0	0	2	0	0	0
28.12.2024 00:00	104	Carter W.	ORL	2	3	1	1045	1	6	0	0	0	1	0	0	-12	1	2	2	0	0	0	0	0
28.12.2024 00:00	105	Harris G.	ORL	2	0	1	884	1	3	0	0	0	2	0	0	-12	0	0	0	0	0	0	0	0
28.12.2024 00:00	106	da Silva T.	ORL	0	2	2	1671	0	5	0	0	0	3	0	0	-6	0	2	1	0	4	1	0	0
28.12.2024 00:00	107	Houstan C.	ORL	0	0	1	272	0	0	0	0	0	0	0	0	-1	0	0	0	0	0	0	0	0
28.12.2024 00:00	108	Joseph C.	ORL	0	2	0	458	0	3	0	0	0	1	0	0	-4	0	2	1	1	0	0	0	0
27.12.2024 00:00	109	Suggs J.	ORL	29	4	2	1939	10	21	0	0	2	11	7	8	8	0	4	3	1	7	0	0	0
27.12.2024 00:00	110	da Silva T.	ORL	18	6	2	2327	7	12	0	0	1	3	3	3	12	2	4	2	1	4	1	0	0
27.12.2024 00:00	111	Caldwell-Pope K.	ORL	11	2	2	1927	5	8	0	0	1	4	0	0	10	0	2	0	3	1	0	0	0
27.12.2024 00:00	112	Bitadze G.	ORL	10	14	2	1967	4	7	0	0	0	0	2	3	6	5	9	1	3	2	3	0	0
27.12.2024 00:00	113	Queen T.	ORL	8	3	2	2219	4	8	0	0	0	3	0	0	9	1	2	3	3	1	0	0	0
27.12.2024 00:00	114	Carter W.	ORL	5	6	1	913	1	6	0	0	0	2	3	4	-7	0	6	0	0	1	1	0	0
27.12.2024 00:00	115	Joseph C.	ORL	5	0	0	461	2	4	0	0	1	2	0	0	-11	0	0	0	1	0	0	0	0
27.12.2024 00:00	116	Black A.	ORL	2	2	1	839	1	6	0	0	0	2	0	0	-9	1	1	2	0	1	0	0	0
27.12.2024 00:00	117	Anthony C.	ORL	0	3	2	700	0	4	0	0	0	2	0	0	-3	0	3	4	0	4	0	0	0
27.12.2024 00:00	118	Howard J.	ORL	0	0	0	320	0	0	0	0	0	0	0	0	-8	0	0	0	0	0	0	0	0
27.12.2024 00:00	119	Isaac J.	ORL	0	2	0	788	0	1	0	0	0	0	0	0	-12	0	2	0	0	0	1	0	0
24.12.2024 00:00	120	da Silva T.	ORL	18	3	0	2135	6	11	0	0	4	8	2	2	-1	0	3	1	1	1	0	0	0
24.12.2024 00:00	121	Queen T.	ORL	17	1	3	2068	5	9	0	0	3	4	4	4	4	0	1	5	3	3	1	0	0
24.12.2024 00:00	122	Suggs J.	ORL	16	6	5	1747	5	13	0	0	1	5	5	5	5	1	5	2	1	5	2	0	1
24.12.2024 00:00	123	Carter W.	ORL	11	7	4	1613	5	8	0	0	1	1	0	0	7	1	6	1	0	0	2	0	0
24.12.2024 00:00	124	Anthony C.	ORL	10	2	5	1037	4	9	0	0	0	2	2	2	6	0	2	5	0	5	0	0	0
24.12.2024 00:00	125	Black A.	ORL	9	4	3	1384	2	5	0	0	1	2	4	4	2	1	3	2	1	2	0	0	0
24.12.2024 00:00	126	Bitadze G.	ORL	8	9	3	1267	4	7	0	0	0	0	0	0	-3	2	7	3	2	2	2	0	1
24.12.2024 00:00	127	Caldwell-Pope K.	ORL	8	5	2	2050	2	8	0	0	2	6	2	2	1	0	5	3	2	1	2	0	0
24.12.2024 00:00	128	Isaac J.	ORL	7	5	1	812	2	8	0	0	1	4	2	2	0	2	3	1	1	1	0	0	0
24.12.2024 00:00	129	Howard J.	ORL	4	0	0	287	2	5	0	0	0	1	0	0	-1	0	0	1	0	0	0	0	0
\.


--
-- Data for Name: orlando_magic_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.orlando_magic_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Bitadze Goga	Lesionado	2025-01-17 13:54:18.039345
2	Harris Gary	Lesionado	2025-01-17 13:54:18.041668
3	Howard Jett	Lesionado	2025-01-17 13:54:18.043863
4	Suggs Jalen	Lesionado	2025-01-17 13:54:18.04666
5	Wagner Franz	Lesionado	2025-01-17 13:54:18.049166
6	Wagner Moritz	Lesionado	2025-01-17 13:54:18.05258
\.


--
-- Data for Name: philadelphia_76ers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.philadelphia_76ers (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	10.07.2024	Philadelphia 76ers	85	Memphis Grizzlies	87	31	18	18	18	17	32	16	22
2	11.07.2024	Utah Jazz	93	Philadelphia 76ers	85	19	15	33	26	18	26	22	19
3	14.07.2024	Philadelphia 76ers	94	Detroit Pistons	81	18	23	23	30	16	21	26	18
4	16.07.2024	Philadelphia 76ers	95	Portland Trail Blazers	97	25	23	29	18	24	27	26	20
5	17.07.2024	Minnesota Timberwolves	90	Philadelphia 76ers	92	22	24	14	30	25	23	28	16
6	20.07.2024	San Antonio Spurs	80	Philadelphia 76ers	96	12	25	26	17	25	17	22	32
7	21.07.2024	Boston Celtics	98	Philadelphia 76ers	103	33	19	21	25	30	19	34	20
8	08.10.2024	Philadelphia 76ers (Usa)	139	NZ Breakers (Nzl)	84	40	42	31	26	19	26	23	16
9	12.10.2024	Minnesota Timberwolves	121	Philadelphia 76ers	111	30	40	25	26	22	31	34	24
10	13.10.2024	Boston Celtics	139	Philadelphia 76ers	89	40	31	37	31	18	30	15	26
11	15.10.2024	Atlanta Hawks	89	Philadelphia 76ers	104	23	25	19	22	23	31	21	29
12	17.10.2024	Philadelphia 76ers	117	Brooklyn Nets	95	33	29	25	30	22	34	23	16
13	19.10.2024	Orlando Magic	114	Philadelphia 76ers	99	27	31	27	29	20	35	16	28
14	24.10.2024	Philadelphia 76ers	109	Milwaukee Bucks	124	23	24	34	28	22	36	42	24
15	26.10.2024	Toronto Raptors	115	Philadelphia 76ers	107	30	32	21	32	31	25	21	30
16	27.10.2024\nApós Prol.	Indiana Pacers	114	Philadelphia 76ers	118	23	35	20	27	28	24	27	26
17	30.10.2024	Philadelphia 76ers	95	Detroit Pistons	105	26	19	22	28	22	32	31	20
18	02.11.2024	Philadelphia 76ers	107	Memphis Grizzlies	124	28	24	23	32	24	35	33	32
19	05.11.2024	Phoenix Suns	118	Philadelphia 76ers	116	28	37	29	24	26	37	30	23
20	07.11.2024	Los Angeles Clippers	110	Philadelphia 76ers	98	24	27	33	26	27	24	17	30
21	09.11.2024	Los Angeles Lakers	116	Philadelphia 76ers	106	36	32	28	20	29	31	21	25
22	11.11.2024\nApós Prol.	Philadelphia 76ers	107	Charlotte Hornets	105	16	30	30	21	15	30	21	31
23	13.11.2024	Philadelphia 76ers	99	New York Knicks	111	25	25	25	24	27	27	24	33
24	14.11.2024	Philadelphia 76ers	106	Cleveland Cavaliers	114	27	27	24	28	31	17	34	32
25	16.11.2024	Orlando Magic	98	Philadelphia 76ers	86	24	19	30	25	21	24	27	14
26	19.11.2024	Miami Heat	106	Philadelphia 76ers	89	25	28	35	18	33	23	16	17
27	21.11.2024	Memphis Grizzlies	117	Philadelphia 76ers	111	31	32	27	27	31	22	28	30
28	23.11.2024	Philadelphia 76ers	113	Brooklyn Nets	98	29	24	26	34	24	26	27	21
29	24.11.2024	Philadelphia 76ers	99	Los Angeles Clippers	125	27	23	22	27	39	23	35	28
30	28.11.2024\nApós Prol.	Philadelphia 76ers	115	Houston Rockets	122	24	27	31	26	35	20	33	20
31	01.12.2024	Detroit Pistons	96	Philadelphia 76ers	111	20	32	17	27	37	20	32	22
32	04.12.2024	Charlotte Hornets	104	Philadelphia 76ers	110	20	24	25	35	32	23	25	30
33	05.12.2024	Philadelphia 76ers	102	Orlando Magic	106	22	31	24	25	34	19	24	29
34	07.12.2024	Philadelphia 76ers	102	Orlando Magic	94	25	25	21	31	27	14	18	35
35	08.12.2024	Chicago Bulls	100	Philadelphia 76ers	108	33	17	29	21	23	39	26	20
36	14.12.2024	Philadelphia 76ers	107	Indiana Pacers	121	22	28	33	24	31	30	29	31
37	17.12.2024	Charlotte Hornets	108	Philadelphia 76ers	121	23	26	30	29	31	23	41	26
38	21.12.2024	Philadelphia 76ers	108	Charlotte Hornets	98	41	17	27	23	23	23	25	27
39	22.12.2024	Cleveland Cavaliers	126	Philadelphia 76ers	99	30	36	33	27	30	25	21	23
40	24.12.2024	Philadelphia 76ers	111	San Antonio Spurs	106	19	29	36	27	20	25	30	31
41	25.12.2024	Boston Celtics	114	Philadelphia 76ers	118	25	33	24	32	30	36	16	36
42	29.12.2024	Utah Jazz	111	Philadelphia 76ers	114	34	18	29	30	22	35	24	33
43	31.12.2024	Portland Trail Blazers	103	Philadelphia 76ers	125	31	23	18	31	33	31	27	34
44	02.01. 03:00	Sacramento Kings	113	Philadelphia 76ers	107	25	32	23	33	30	27	32	18
45	03.01. 03:00	Golden State Warriors	139	Philadelphia 76ers	105	35	33	35	36	19	33	26	27
46	04.01. 23:00	Brooklyn Nets	94	Philadelphia 76ers	123	19	28	19	28	29	35	27	32
47	07.01. 00:00	Philadelphia 76ers	99	Phoenix Suns	109	23	23	27	26	16	26	36	31
48	09.01. 00:00	Philadelphia 76ers	109	Washington Wizards	103	32	27	29	21	25	23	26	29
49	11.01. 00:00	Philadelphia 76ers	115	New Orleans Pelicans	123	24	23	31	37	28	25	34	36
50	12.01. 23:00	Orlando Magic	104	Philadelphia 76ers	99	24	25	24	31	21	27	29	22
51	15.01. 00:00	Philadelphia 76ers	102	Oklahoma City Thunder	118	21	22	38	21	37	21	29	31
52	16.01. 00:00\nApós Prol.	Philadelphia 76ers	119	New York Knicks	125	21	26	38	24	30	30	25	24
\.


--
-- Data for Name: philadelphia_76ers_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.philadelphia_76ers_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 00:00	1	Maxey T.	PHI	33	6	6	2736	13	32	0	0	2	9	5	5	-9	2	4	3	1	4	1	0	0
16.01.2025 00:00	2	George P.	PHI	26	3	6	2607	9	20	0	0	3	8	5	5	4	0	3	2	3	3	0	0	0
16.01.2025 00:00	3	Oubre K. J.	PHI	16	10	1	2724	7	11	0	0	1	3	1	1	-2	1	9	3	2	2	1	0	0
16.01.2025 00:00	4	Gordon E.	PHI	14	1	2	1271	4	6	0	0	3	5	3	3	-9	0	1	0	0	0	0	0	0
16.01.2025 00:00	5	Edwards J.	PHI	10	2	3	2118	4	6	0	0	2	4	0	0	1	1	1	3	1	0	0	0	0
16.01.2025 00:00	6	Yabusele G.	PHI	9	5	6	2295	4	8	0	0	1	4	0	0	-10	4	1	4	0	2	0	0	0
16.01.2025 00:00	7	Dowtin J.	PHI	7	1	3	861	3	6	0	0	1	2	0	0	-3	0	1	1	1	0	0	0	0
16.01.2025 00:00	8	Bona Adem	PHI	2	6	0	885	1	1	0	0	0	0	0	0	4	3	3	3	0	1	0	0	0
16.01.2025 00:00	9	Council IV R.	PHI	2	1	0	403	1	2	0	0	0	0	0	0	-6	0	1	0	0	0	0	0	0
15.01.2025 00:00	10	Edwards J.	PHI	25	6	4	2101	9	16	0	0	4	9	3	4	3	1	5	1	1	3	0	0	0
15.01.2025 00:00	11	Dowtin J.	PHI	18	5	3	1768	7	14	0	0	2	5	2	2	-4	0	5	2	2	1	1	0	0
15.01.2025 00:00	12	Yabusele G.	PHI	17	7	4	1840	6	9	0	0	3	5	2	4	-18	5	2	3	0	1	0	0	0
15.01.2025 00:00	13	Council IV R.	PHI	13	4	4	2123	5	15	0	0	1	8	2	3	-15	2	2	2	0	6	0	0	0
15.01.2025 00:00	14	Gordon E.	PHI	10	3	1	1696	3	9	0	0	3	8	1	1	-5	1	2	2	1	1	0	0	0
15.01.2025 00:00	15	Oubre K. J.	PHI	8	4	2	1794	2	10	0	0	0	4	4	5	-25	1	3	3	4	1	0	0	0
15.01.2025 00:00	16	Bona Adem	PHI	7	3	0	998	3	3	0	0	0	0	1	1	-3	1	2	3	0	3	0	0	0
15.01.2025 00:00	17	Jackson R.	PHI	4	2	4	1013	2	5	0	0	0	3	0	0	-12	0	2	1	1	5	0	0	0
15.01.2025 00:00	18	Nance P.	PHI	0	1	1	1067	0	3	0	0	0	2	0	0	-1	0	1	1	1	0	0	0	0
12.01.2025 23:00	19	Maxey T.	PHI	29	4	5	2334	7	19	0	0	3	9	12	13	-1	0	4	4	3	6	0	0	0
12.01.2025 23:00	20	George P.	PHI	25	10	6	2228	10	20	0	0	5	8	0	0	11	0	10	6	1	3	0	0	0
12.01.2025 23:00	21	Gordon E.	PHI	14	4	0	1695	4	6	0	0	3	3	3	3	-6	1	3	4	1	1	1	0	0
12.01.2025 23:00	22	Oubre K. J.	PHI	12	4	1	2077	5	11	0	0	0	2	2	2	-4	1	3	3	2	0	0	0	0
12.01.2025 23:00	23	Yabusele G.	PHI	8	3	2	2358	3	6	0	0	0	2	2	2	-16	1	2	4	1	3	1	0	0
12.01.2025 23:00	24	Edwards J.	PHI	7	2	1	1462	3	5	0	0	1	3	0	0	-5	0	2	2	0	1	0	0	0
12.01.2025 23:00	25	Jackson R.	PHI	4	0	1	686	1	2	0	0	0	0	2	2	-7	0	0	0	1	1	0	0	0
12.01.2025 23:00	26	Bona Adem	PHI	0	0	0	903	0	0	0	0	0	0	0	0	4	0	0	1	1	1	1	0	0
12.01.2025 23:00	27	Council IV R.	PHI	0	1	1	345	0	2	0	0	0	2	0	0	2	0	1	0	0	0	1	0	0
12.01.2025 23:00	28	Dowtin J.	PHI	0	1	0	312	0	1	0	0	0	0	0	0	-3	0	1	0	0	0	0	0	0
11.01.2025 00:00	29	Maxey T.	PHI	30	6	12	2438	10	20	0	0	2	8	8	8	0	2	4	1	1	1	0	0	0
11.01.2025 00:00	30	George P.	PHI	25	11	5	2115	10	22	0	0	5	12	0	0	7	1	10	3	2	3	0	0	1
11.01.2025 00:00	31	Oubre K. J.	PHI	21	7	1	2333	7	18	0	0	2	5	5	7	-2	4	3	4	2	1	0	0	0
11.01.2025 00:00	32	Council IV R.	PHI	13	1	0	1043	5	7	0	0	1	3	2	2	-13	1	0	2	0	0	0	0	0
11.01.2025 00:00	33	Jackson R.	PHI	7	2	0	390	2	5	0	0	1	2	2	2	-5	0	2	4	0	0	0	0	0
11.01.2025 00:00	34	Gordon E.	PHI	6	2	1	917	2	4	0	0	2	4	0	0	-17	0	2	0	0	1	0	0	0
11.01.2025 00:00	35	Yabusele G.	PHI	6	7	0	1887	3	5	0	0	0	1	0	0	4	1	6	4	1	2	0	0	0
11.01.2025 00:00	36	Martin Ca.	PHI	5	3	4	2150	2	8	0	0	1	3	0	0	-1	1	2	2	1	0	1	0	1
11.01.2025 00:00	37	Dowtin J.	PHI	2	1	0	315	1	2	0	0	0	0	0	0	-3	0	1	1	0	0	0	0	0
11.01.2025 00:00	38	Bona Adem	PHI	0	2	0	812	0	0	0	0	0	0	0	0	-10	1	1	4	0	1	2	0	0
09.01.2025 00:00	39	Maxey T.	PHI	29	3	6	2313	11	27	0	0	3	14	4	6	13	0	3	2	2	1	0	0	0
09.01.2025 00:00	40	Yabusele G.	PHI	21	8	3	2025	6	11	0	0	5	7	4	4	16	4	4	1	1	1	2	0	0
09.01.2025 00:00	41	Gordon E.	PHI	15	2	1	1853	5	8	0	0	4	7	1	3	12	0	2	2	1	1	0	0	0
09.01.2025 00:00	42	Oubre K. J.	PHI	15	4	4	2300	7	14	0	0	1	6	0	0	12	1	3	3	2	3	2	0	0
09.01.2025 00:00	43	Council IV R.	PHI	8	5	1	1114	3	7	0	0	1	3	1	1	-10	2	3	0	0	0	0	0	0
09.01.2025 00:00	44	Martin Ca.	PHI	8	5	2	2122	4	7	0	0	0	1	0	0	9	0	5	2	1	0	3	0	0
09.01.2025 00:00	45	Jackson R.	PHI	6	1	1	509	2	6	0	0	1	4	1	1	-5	0	1	0	0	1	0	0	0
09.01.2025 00:00	46	Dowtin J.	PHI	3	2	1	567	1	3	0	0	0	0	1	2	-7	0	2	0	1	0	0	0	0
09.01.2025 00:00	47	Bona Adem	PHI	2	3	2	855	0	1	0	0	0	0	2	2	-10	2	1	2	0	0	3	0	0
09.01.2025 00:00	48	Edwards J.	PHI	2	3	0	742	1	4	0	0	0	2	0	0	0	1	2	2	0	0	1	0	0
07.01.2025 00:00	49	Maxey T.	PHI	31	0	10	2634	11	25	0	0	6	14	3	5	-5	0	0	1	2	4	0	0	0
07.01.2025 00:00	50	Oubre K. J.	PHI	26	11	1	2297	9	18	0	0	1	4	7	9	3	3	8	4	0	1	0	0	1
07.01.2025 00:00	51	Yabusele G.	PHI	14	10	1	2176	5	12	0	0	3	8	1	2	-9	5	5	3	0	0	1	0	0
07.01.2025 00:00	52	George P.	PHI	13	9	5	2268	5	18	0	0	3	9	0	0	-8	0	9	2	2	2	0	0	1
07.01.2025 00:00	53	Martin Ca.	PHI	8	7	3	2227	2	6	0	0	1	2	3	6	-5	1	6	4	2	1	1	0	0
07.01.2025 00:00	54	Bona Adem	PHI	4	5	0	673	1	2	0	0	0	0	2	4	-4	1	4	3	0	1	1	0	0
07.01.2025 00:00	55	Edwards J.	PHI	3	3	0	806	1	2	0	0	1	1	0	0	-3	2	1	1	0	0	1	0	0
07.01.2025 00:00	56	Council IV R.	PHI	0	0	0	155	0	2	0	0	0	0	0	0	-8	0	0	0	0	0	0	0	0
07.01.2025 00:00	57	Dowtin J.	PHI	0	0	0	246	0	0	0	0	0	0	0	0	-5	0	0	0	0	0	0	0	0
07.01.2025 00:00	58	Gordon E.	PHI	0	0	0	459	0	1	0	0	0	1	0	0	-3	0	0	0	0	1	0	0	0
07.01.2025 00:00	59	Jackson R.	PHI	0	1	0	459	0	1	0	0	0	1	0	0	-3	0	1	1	0	0	0	0	0
04.01.2025 23:00	60	Embiid J.	PHI	28	12	6	1738	8	16	0	0	2	3	10	10	22	1	11	2	0	3	0	0	1
04.01.2025 23:00	61	Maxey T.	PHI	18	2	7	1908	5	12	0	0	2	6	6	7	20	0	2	0	0	4	0	0	0
04.01.2025 23:00	62	George P.	PHI	17	4	6	1738	6	14	0	0	3	9	2	2	22	0	4	2	2	2	0	0	0
04.01.2025 23:00	63	Martin Ca.	PHI	17	4	3	1491	7	8	0	0	2	3	1	3	18	3	1	3	1	1	1	0	0
04.01.2025 23:00	64	Edwards J.	PHI	11	5	1	1372	4	7	0	0	3	6	0	0	11	1	4	2	0	1	0	0	0
04.01.2025 23:00	65	Jackson R.	PHI	8	2	1	1326	3	9	0	0	2	6	0	0	12	1	1	4	2	1	0	0	0
04.01.2025 23:00	66	Bona Adem	PHI	6	3	1	410	2	2	0	0	0	0	2	4	3	0	3	1	0	2	1	0	0
04.01.2025 23:00	67	Drummond A.	PHI	6	4	0	489	2	4	0	0	0	1	2	2	1	0	4	1	1	1	0	0	0
04.01.2025 23:00	68	Lowry K.	PHI	5	4	4	1447	2	2	0	0	1	1	0	0	15	1	3	2	2	1	0	0	0
04.01.2025 23:00	69	Council IV R.	PHI	4	4	2	531	2	3	0	0	0	1	0	0	6	0	4	0	0	0	0	0	0
04.01.2025 23:00	70	Yabusele G.	PHI	3	6	0	1533	1	4	0	0	0	3	1	2	13	1	5	0	2	0	0	0	0
04.01.2025 23:00	71	Gordon E.	PHI	0	0	0	417	0	1	0	0	0	1	0	0	2	0	0	0	1	1	0	0	0
03.01.2025 03:00	72	Embiid J.	PHI	28	14	2	1858	8	19	0	0	1	3	11	14	-25	3	11	2	1	2	2	0	0
03.01.2025 03:00	73	George P.	PHI	19	2	0	1930	7	12	0	0	3	6	2	2	-26	0	2	2	0	2	0	0	0
03.01.2025 03:00	74	Maxey T.	PHI	14	3	6	1923	4	13	0	0	2	6	4	4	-24	0	3	2	4	3	2	0	0
03.01.2025 03:00	75	Yabusele G.	PHI	13	6	2	1886	4	6	0	0	1	2	4	4	-20	2	4	2	0	0	0	0	0
03.01.2025 03:00	76	Council IV R.	PHI	12	2	1	1608	4	8	0	0	1	4	3	4	-10	1	1	0	0	0	0	0	0
03.01.2025 03:00	77	Dowtin J.	PHI	6	1	2	907	2	5	0	0	0	0	2	4	-9	0	1	2	0	0	0	0	0
03.01.2025 03:00	78	Edwards J.	PHI	4	0	1	551	2	5	0	0	0	3	0	0	-4	0	0	0	1	1	0	0	0
03.01.2025 03:00	79	Gordon E.	PHI	3	1	0	858	1	2	0	0	1	2	0	0	-10	0	1	1	0	0	0	0	0
03.01.2025 03:00	80	Jackson R.	PHI	2	1	1	450	1	3	0	0	0	2	0	0	-5	0	1	0	1	1	0	0	0
03.01.2025 03:00	81	Lowry K.	PHI	2	0	0	576	0	2	0	0	0	1	2	2	-14	0	0	2	1	0	0	0	0
03.01.2025 03:00	82	Martin Ca.	PHI	2	0	2	1302	1	5	0	0	0	2	0	0	-19	0	0	1	2	1	0	0	0
03.01.2025 03:00	83	Bona Adem	PHI	0	3	0	551	0	1	0	0	0	0	0	0	-4	0	3	2	1	1	2	0	0
02.01.2025 03:00	84	George P.	PHI	30	8	5	2175	11	20	0	0	4	7	4	4	-3	1	7	6	0	5	1	0	0
02.01.2025 03:00	85	Maxey T.	PHI	27	2	6	2545	10	23	0	0	3	10	4	4	-9	0	2	3	5	4	1	0	0
02.01.2025 03:00	86	Gordon E.	PHI	14	1	3	1620	5	9	0	0	3	7	1	1	0	0	1	0	0	0	1	0	0
02.01.2025 03:00	87	Martin Ca.	PHI	12	7	4	2343	5	10	0	0	2	4	0	0	-15	3	4	3	3	2	1	0	0
02.01.2025 03:00	88	Drummond A.	PHI	10	9	2	1225	4	6	0	0	0	0	2	4	3	2	7	2	0	2	0	0	0
02.01.2025 03:00	89	Yabusele G.	PHI	8	1	3	1777	3	6	0	0	2	5	0	0	-17	0	1	3	0	0	1	0	0
02.01.2025 03:00	90	Council IV R.	PHI	3	4	0	626	1	3	0	0	0	1	1	1	11	1	3	0	0	2	0	0	0
02.01.2025 03:00	91	Jackson R.	PHI	3	2	0	760	1	3	0	0	1	2	0	0	0	1	1	2	0	0	0	0	0
02.01.2025 03:00	92	Edwards J.	PHI	0	0	0	288	0	1	0	0	0	1	0	0	9	0	0	2	1	0	0	0	0
02.01.2025 03:00	93	Lowry K.	PHI	0	0	1	1041	0	3	0	0	0	3	0	0	-9	0	0	1	1	3	0	0	0
31.12.2024 03:00	94	Embiid J.	PHI	37	9	3	2138	12	21	0	0	1	1	12	13	26	3	6	2	0	4	0	0	0
31.12.2024 03:00	95	Maxey T.	PHI	23	1	3	2152	7	13	0	0	3	7	6	6	14	0	1	4	1	4	0	0	0
31.12.2024 03:00	96	Yabusele G.	PHI	16	4	1	1679	6	9	0	0	2	4	2	3	17	0	4	1	1	2	1	0	0
31.12.2024 03:00	97	Oubre K. J.	PHI	15	5	2	2204	6	10	0	0	0	3	3	3	22	2	3	3	8	2	1	0	1
31.12.2024 03:00	98	George P.	PHI	9	6	4	1370	4	9	0	0	1	3	0	0	20	3	3	5	1	4	0	0	0
31.12.2024 03:00	99	Council IV R.	PHI	7	1	0	816	2	2	0	0	1	1	2	2	-11	0	1	3	0	1	0	0	0
31.12.2024 03:00	100	Martin Ca.	PHI	7	1	2	2259	3	6	0	0	1	2	0	0	27	0	1	3	1	0	1	0	0
31.12.2024 03:00	101	Dowtin J.	PHI	3	2	0	291	1	1	0	0	1	1	0	0	-3	0	2	0	0	1	0	0	0
31.12.2024 03:00	102	Jackson R.	PHI	3	2	4	1072	1	3	0	0	0	1	1	2	3	0	2	1	0	1	0	0	0
31.12.2024 03:00	103	Nance P.	PHI	3	1	0	176	1	1	0	0	1	1	0	0	-2	0	1	3	0	0	0	0	0
31.12.2024 03:00	104	Bona Adem	PHI	2	0	1	243	0	0	0	0	0	0	2	2	-3	0	0	2	0	0	0	0	0
29.12.2024 02:30	105	Embiid J.	PHI	32	5	4	2079	10	21	0	0	1	4	11	13	8	2	3	1	4	4	3	0	0
29.12.2024 02:30	106	Maxey T.	PHI	32	0	6	2439	9	23	0	0	5	13	9	10	-2	0	0	3	2	2	1	0	0
29.12.2024 02:30	107	George P.	PHI	13	3	2	1899	4	11	0	0	2	5	3	5	6	0	3	5	5	1	0	0	0
29.12.2024 02:30	108	Yabusele G.	PHI	12	8	2	1326	4	7	0	0	2	4	2	2	3	5	3	5	0	0	0	0	0
29.12.2024 02:30	109	Oubre K. J.	PHI	9	2	2	1837	3	7	0	0	0	3	3	4	-1	1	1	4	1	1	0	0	0
29.12.2024 02:30	110	Jackson R.	PHI	8	4	1	890	3	5	0	0	2	3	0	0	-1	1	3	1	0	0	0	0	0
29.12.2024 02:30	111	Martin Ca.	PHI	5	6	0	2155	2	5	0	0	1	2	0	1	-7	1	5	2	1	0	2	0	0
29.12.2024 02:30	112	Council IV R.	PHI	3	2	0	650	1	3	0	0	0	1	1	2	0	0	2	1	0	0	1	0	0
29.12.2024 02:30	113	Lowry K.	PHI	0	2	5	1125	0	1	0	0	0	1	0	0	9	0	2	0	2	0	1	0	0
25.12.2024 22:00	114	Maxey T.	PHI	33	4	12	2448	12	23	0	0	3	9	6	6	7	1	3	2	3	3	1	0	0
25.12.2024 22:00	115	Embiid J.	PHI	27	9	2	1845	8	15	0	0	4	5	7	7	-18	1	8	3	0	2	0	0	0
25.12.2024 22:00	116	Martin Ca.	PHI	23	3	2	2263	8	11	0	0	7	9	0	0	8	1	2	3	1	0	0	0	0
25.12.2024 22:00	117	George P.	PHI	12	4	4	2021	4	15	0	0	0	7	4	4	-16	0	4	0	3	1	1	0	0
25.12.2024 22:00	118	Yabusele G.	PHI	12	4	1	1278	4	9	0	0	2	4	2	2	18	1	3	3	1	0	0	0	0
25.12.2024 22:00	119	Lowry K.	PHI	5	3	3	1233	2	4	0	0	1	2	0	0	20	0	3	4	0	0	1	0	0
25.12.2024 22:00	120	Oubre K. J.	PHI	4	8	2	2309	2	6	0	0	0	2	0	0	-10	0	8	1	1	0	2	0	0
25.12.2024 22:00	121	Jackson R.	PHI	2	4	2	1003	1	5	0	0	0	2	0	0	11	1	3	1	1	0	0	0	0
\.


--
-- Data for Name: philadelphia_76ers_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.philadelphia_76ers_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Drummond Andre	Lesionado	2025-01-17 13:54:34.318017
2	Embiid Joel	Lesionado	2025-01-17 13:54:34.320652
3	McCain Jared	Lesionado	2025-01-17 13:54:34.322929
4	Martin Jr. Kenyon	Lesionado	2025-01-17 13:54:34.324771
\.


--
-- Data for Name: phoenix_suns; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.phoenix_suns (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	29.04.2024	Phoenix Suns	116	Minnesota Timberwolves	122	26	35	31	24	25	31	34	32
2	14.07.2024	Golden State Warriors	90	Phoenix Suns	73	32	18	24	16	19	14	22	18
3	16.07.2024	Phoenix Suns	94	Indiana Pacers	98	26	28	18	22	24	20	29	25
4	18.07.2024	Oklahoma City Thunder	99	Phoenix Suns	100	28	27	23	21	22	25	24	29
5	19.07.2024	Phoenix Suns	115	Milwaukee Bucks	90	31	25	30	29	11	22	29	28
6	20.07.2024	Sacramento Kings	87	Phoenix Suns	77	21	17	23	26	20	20	19	18
7	07.10.2024	Los Angeles Lakers	114	Phoenix Suns	118	34	35	23	22	25	32	28	33
8	09.10.2024	Detroit Pistons	97	Phoenix Suns	105	29	17	20	31	36	17	31	21
9	12.10.2024	Phoenix Suns	91	Detroit Pistons	109	29	21	24	17	40	25	23	21
10	14.10.2024	Denver Nuggets	114	Phoenix Suns	118	33	27	30	24	26	25	37	30
11	18.10.2024\nApós Prol.	Phoenix Suns	122	Los Angeles Lakers	128	30	37	23	23	35	27	20	31
12	24.10.2024\nApós Prol.	Los Angeles Clippers	113	Phoenix Suns	116	22	17	35	29	23	24	25	31
13	26.10.2024	Los Angeles Lakers	123	Phoenix Suns	116	23	29	35	36	38	23	24	31
14	27.10.2024	Phoenix Suns	114	Dallas Mavericks	102	28	35	28	23	26	29	25	22
15	29.10.2024	Phoenix Suns	109	Los Angeles Lakers	105	25	25	26	33	34	14	35	22
16	01.11.2024	Los Angeles Clippers	119	Phoenix Suns	125	37	33	23	26	20	32	39	34
17	03.11.2024	Phoenix Suns	103	Portland Trail Blazers	97	22	21	44	16	18	29	18	32
18	05.11.2024	Phoenix Suns	118	Philadelphia 76ers	116	28	37	29	24	26	37	30	23
19	07.11.2024	Phoenix Suns	115	Miami Heat	112	26	29	29	31	25	33	29	25
20	09.11.2024	Dallas Mavericks	113	Phoenix Suns	114	26	24	33	30	36	27	24	27
21	11.11.2024\nApós Prol.	Phoenix Suns	118	Sacramento Kings	127	31	22	29	29	36	24	19	32
22	13.11.2024	Utah Jazz	112	Phoenix Suns	120	21	28	30	33	33	31	23	33
23	14.11.2024	Sacramento Kings	127	Phoenix Suns	104	35	26	32	34	29	27	24	24
24	16.11.2024	Oklahoma City Thunder	99	Phoenix Suns	83	29	19	35	16	14	22	24	23
25	17.11.2024	Minnesota Timberwolves	120	Phoenix Suns	117	22	32	32	34	31	33	26	27
26	19.11.2024	Phoenix Suns	99	Orlando Magic	109	22	26	20	31	26	38	20	25
27	21.11.2024	Phoenix Suns	122	New York Knicks	138	28	30	35	29	44	32	34	28
28	27.11.2024	Phoenix Suns	127	Los Angeles Lakers	100	31	31	36	29	25	35	18	22
29	28.11.2024	Phoenix Suns	117	Brooklyn Nets	127	37	26	21	33	34	29	33	31
30	01.12.2024	Phoenix Suns	113	Golden State Warriors	105	35	31	19	28	29	20	29	27
31	04.12.2024	Phoenix Suns	104	San Antonio Spurs	93	29	23	23	29	19	20	32	22
32	06.12.2024	New Orleans Pelicans	126	Phoenix Suns	124	34	20	45	27	33	32	28	31
33	08.12.2024	Miami Heat	121	Phoenix Suns	111	26	27	34	34	29	29	24	29
34	08.12.2024	Orlando Magic	115	Phoenix Suns	110	29	28	27	31	34	28	25	23
35	14.12.2024	Utah Jazz	126	Phoenix Suns	134	39	32	34	21	38	38	36	22
36	16.12.2024	Phoenix Suns	116	Portland Trail Blazers	109	33	24	26	33	21	30	28	30
37	20.12.2024	Phoenix Suns	111	Indiana Pacers	120	29	30	24	28	32	28	37	23
38	22.12.2024	Phoenix Suns	125	Detroit Pistons	133	26	33	35	31	41	23	39	30
39	24.12.2024	Denver Nuggets	117	Phoenix Suns	90	27	28	45	17	26	25	28	11
40	26.12.2024	Phoenix Suns	110	Denver Nuggets	100	38	20	27	25	34	22	22	22
41	28.12.2024	Phoenix Suns	89	Dallas Mavericks	98	25	14	25	25	28	27	17	26
42	29.12.2024	Golden State Warriors	109	Phoenix Suns	105	34	27	21	27	27	38	22	18
43	01.01. 02:00	Phoenix Suns	112	Memphis Grizzlies	117	26	29	31	26	36	33	22	26
44	05.01. 00:00	Indiana Pacers	126	Phoenix Suns	108	30	26	40	30	29	27	28	24
45	07.01. 00:00	Philadelphia 76ers	99	Phoenix Suns	109	23	23	27	26	16	26	36	31
46	08.01. 00:00	Charlotte Hornets	115	Phoenix Suns	104	22	37	29	27	29	17	37	21
47	10.01. 02:00	Phoenix Suns	123	Atlanta Hawks	115	38	30	30	25	31	41	20	23
48	11.01. 22:00	Phoenix Suns	114	Utah Jazz	106	31	34	22	27	27	27	25	27
49	13.01. 02:00	Phoenix Suns	120	Charlotte Hornets	113	28	34	31	27	34	28	36	15
50	15.01. 00:30	Atlanta Hawks	122	Phoenix Suns	117	33	31	25	33	31	25	31	30
51	17.01. 00:00	Washington Wizards	123	Phoenix Suns	130	21	34	28	40	34	35	35	26
\.


--
-- Data for Name: phoenix_suns_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.phoenix_suns_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
17.01.2025 00:00	1	Booker D.	PHO	37	3	5	2332	10	24	0	0	4	10	13	15	14	1	2	2	2	4	1	0	0
17.01.2025 00:00	2	Durant K.	PHO	23	6	3	1960	8	16	0	0	1	5	6	8	18	1	5	2	1	2	2	0	0
17.01.2025 00:00	3	Allen G.	PHO	21	5	0	1686	8	12	0	0	5	7	0	0	6	0	5	1	3	2	0	0	0
17.01.2025 00:00	4	Dunn R.	PHO	18	11	1	1783	8	12	0	0	2	3	0	0	4	2	9	2	0	1	1	0	0
17.01.2025 00:00	5	Jones T.	PHO	9	3	10	1863	1	5	0	0	1	3	6	6	16	1	2	2	3	2	0	0	0
17.01.2025 00:00	6	O'Neale R.	PHO	9	4	2	1300	3	6	0	0	3	6	0	0	-10	0	4	3	1	1	0	0	0
17.01.2025 00:00	7	Plumlee M.	PHO	6	9	4	1012	3	3	0	0	0	0	0	0	7	3	6	5	0	1	0	0	0
17.01.2025 00:00	8	Morris M.	PHO	4	2	7	915	2	4	0	0	0	0	0	0	-11	1	1	0	0	2	0	0	0
17.01.2025 00:00	9	Bol B.	PHO	3	1	0	268	1	1	0	0	0	0	1	2	-4	1	0	1	0	0	0	0	0
17.01.2025 00:00	10	Ighodaro O.	PHO	0	3	1	1281	0	2	0	0	0	0	0	0	-5	0	3	5	0	1	0	0	0
15.01.2025 00:30	11	Booker D.	PHO	35	5	5	2262	12	23	0	0	7	14	4	4	6	3	2	4	3	5	0	0	0
15.01.2025 00:30	12	Durant K.	PHO	31	8	6	2337	13	20	0	0	0	2	5	7	5	1	7	0	2	3	2	0	0
15.01.2025 00:30	13	Dunn R.	PHO	14	1	0	1297	6	12	0	0	1	4	1	3	5	1	0	4	1	0	1	0	0
15.01.2025 00:30	14	Beal B.	PHO	11	4	3	1682	3	9	0	0	1	4	4	6	-8	0	4	1	1	1	0	0	0
15.01.2025 00:30	15	Allen G.	PHO	9	4	2	1599	3	4	0	0	3	4	0	0	-11	0	4	3	1	1	0	0	0
15.01.2025 00:30	16	Jones T.	PHO	8	1	6	1582	3	5	0	0	1	2	1	2	7	0	1	1	0	0	0	0	0
15.01.2025 00:30	17	Ighodaro O.	PHO	4	5	1	1151	1	4	0	0	0	1	2	4	-8	0	5	0	1	1	0	0	0
15.01.2025 00:30	18	Plumlee M.	PHO	3	5	4	1504	1	2	0	0	0	0	1	1	1	0	5	3	0	1	1	0	0
15.01.2025 00:30	19	O'Neale R.	PHO	2	4	1	986	1	5	0	0	0	4	0	0	-22	1	3	1	1	1	0	0	0
13.01.2025 02:00	20	Booker D.	PHO	30	5	8	2317	10	20	0	0	4	9	6	6	-4	0	5	1	3	1	0	0	0
13.01.2025 02:00	21	Durant K.	PHO	27	8	5	2411	11	24	0	0	2	9	3	3	8	0	8	5	1	1	0	0	0
13.01.2025 02:00	22	Beal B.	PHO	15	3	6	2108	5	12	0	0	2	4	3	4	19	0	3	2	0	1	2	0	0
13.01.2025 02:00	23	Allen G.	PHO	13	1	0	804	4	7	0	0	3	6	2	2	7	0	1	0	2	0	0	0	0
13.01.2025 02:00	24	Dunn R.	PHO	11	6	2	1642	4	5	0	0	3	4	0	0	-17	3	3	2	1	0	0	0	0
13.01.2025 02:00	25	Ighodaro O.	PHO	10	6	2	1813	3	3	0	0	0	0	4	6	19	3	3	2	0	1	1	0	0
13.01.2025 02:00	26	O'Neale R.	PHO	9	4	1	1298	3	7	0	0	2	6	1	1	25	0	4	3	1	4	1	0	0
13.01.2025 02:00	27	Jones T.	PHO	3	1	5	1091	1	5	0	0	1	3	0	0	-15	0	1	0	0	2	0	0	0
13.01.2025 02:00	28	Plumlee M.	PHO	2	5	2	916	1	4	0	0	0	0	0	0	-7	2	3	2	1	2	2	0	0
11.01.2025 22:00	29	Booker D.	PHO	34	5	4	2187	12	20	0	0	6	12	4	4	16	2	3	3	2	3	0	0	0
11.01.2025 22:00	30	Durant K.	PHO	25	5	7	2134	11	19	0	0	1	4	2	3	-9	0	5	1	1	5	0	0	0
11.01.2025 22:00	31	Allen G.	PHO	14	4	4	1828	5	11	0	0	4	10	0	0	11	0	4	1	2	1	0	0	0
11.01.2025 22:00	32	Beal B.	PHO	12	2	3	1864	4	10	0	0	1	5	3	4	-4	0	2	3	0	0	0	0	0
11.01.2025 22:00	33	Dunn R.	PHO	10	5	2	1433	4	8	0	0	1	3	1	2	-1	2	3	4	0	0	1	0	0
11.01.2025 22:00	34	Ighodaro O.	PHO	9	2	0	1389	4	6	0	0	0	0	1	2	-13	1	1	1	2	0	2	0	0
11.01.2025 22:00	35	Plumlee M.	PHO	6	10	0	1374	2	5	0	0	0	0	2	4	22	5	5	2	1	0	0	0	0
11.01.2025 22:00	36	Morris M.	PHO	2	0	0	210	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
11.01.2025 22:00	37	Okogie J.	PHO	2	2	0	440	1	2	0	0	0	0	0	0	8	1	1	0	1	0	1	0	0
11.01.2025 22:00	38	Jones T.	PHO	0	3	6	1541	0	4	0	0	0	3	0	0	10	1	2	2	0	2	0	0	0
10.01.2025 02:00	39	Beal B.	PHO	25	7	2	1987	11	16	0	0	2	5	1	2	-5	2	5	4	3	3	1	0	0
10.01.2025 02:00	40	Allen G.	PHO	23	2	1	1615	7	8	0	0	5	6	4	4	3	0	2	1	0	2	0	0	0
10.01.2025 02:00	41	Durant K.	PHO	23	2	7	2181	9	15	0	0	2	7	3	4	7	0	2	1	0	3	3	0	0
10.01.2025 02:00	42	Booker D.	PHO	20	3	12	2401	9	21	0	0	0	8	2	3	10	0	3	2	1	2	0	0	0
10.01.2025 02:00	43	Jones T.	PHO	16	2	4	1713	6	12	0	0	4	7	0	0	6	1	1	0	1	2	0	0	0
10.01.2025 02:00	44	Dunn R.	PHO	6	7	0	983	3	5	0	0	0	0	0	0	11	2	5	4	0	0	1	0	0
10.01.2025 02:00	45	Ighodaro O.	PHO	4	5	2	1523	2	4	0	0	0	0	0	0	-3	1	4	2	1	1	1	0	0
10.01.2025 02:00	46	Okogie J.	PHO	4	1	0	240	1	1	0	0	0	0	2	2	-1	1	0	0	0	0	0	0	0
10.01.2025 02:00	47	Plumlee M.	PHO	2	10	4	1314	1	1	0	0	0	0	0	0	8	4	6	0	1	3	0	0	0
10.01.2025 02:00	48	Morris M.	PHO	0	3	1	443	0	2	0	0	0	0	0	0	4	1	2	1	0	0	0	0	0
08.01.2025 00:00	49	Booker D.	PHO	39	6	10	2339	14	25	0	0	2	8	9	9	2	1	5	2	0	3	0	0	0
08.01.2025 00:00	50	Durant K.	PHO	26	6	2	2180	8	18	0	0	1	6	9	10	1	1	5	2	0	2	1	0	0
08.01.2025 00:00	51	Beal B.	PHO	10	0	5	1858	5	13	0	0	0	2	0	0	-21	0	0	2	0	1	0	0	0
08.01.2025 00:00	52	Allen G.	PHO	9	3	0	1504	3	7	0	0	3	6	0	0	-17	1	2	1	1	1	1	0	0
08.01.2025 00:00	53	Nurkic J.	PHO	8	3	3	1135	3	6	0	0	2	3	0	0	-22	1	2	5	1	2	1	0	0
08.01.2025 00:00	54	Dunn R.	PHO	6	4	0	1520	3	8	0	0	0	4	0	0	6	1	3	3	0	1	1	0	0
08.01.2025 00:00	55	Jones T.	PHO	4	1	4	1313	2	6	0	0	0	2	0	0	-2	1	0	2	0	1	0	0	0
08.01.2025 00:00	56	Morris M.	PHO	2	4	0	902	1	5	0	0	0	2	0	0	-6	0	4	0	0	0	0	0	0
08.01.2025 00:00	57	Ighodaro O.	PHO	0	2	1	355	0	3	0	0	0	0	0	0	-5	1	1	1	0	0	0	0	0
08.01.2025 00:00	58	Okogie J.	PHO	0	0	0	121	0	0	0	0	0	0	0	0	-6	0	0	1	0	0	0	0	0
08.01.2025 00:00	59	Plumlee M.	PHO	0	13	2	1173	0	1	0	0	0	0	0	0	15	1	12	4	1	0	0	0	0
07.01.2025 00:00	60	Beal B.	PHO	25	3	5	1784	10	15	0	0	3	6	2	2	14	0	3	1	1	0	1	0	0
07.01.2025 00:00	61	Durant K.	PHO	23	6	5	2063	9	14	0	0	3	4	2	3	3	0	6	1	1	3	1	0	0
07.01.2025 00:00	62	Dunn R.	PHO	15	4	1	1623	6	11	0	0	3	6	0	0	-3	0	4	3	0	0	0	0	0
07.01.2025 00:00	63	Booker D.	PHO	10	4	10	2275	3	16	0	0	1	5	3	6	9	0	4	2	2	3	0	0	0
07.01.2025 00:00	64	Ighodaro O.	PHO	8	6	3	1260	4	6	0	0	0	1	0	0	6	2	4	2	0	2	0	0	0
07.01.2025 00:00	65	Morris M.	PHO	7	0	2	1342	2	4	0	0	1	1	2	2	11	0	0	2	0	0	0	0	0
07.01.2025 00:00	66	Allen G.	PHO	6	1	0	867	2	3	0	0	1	1	1	2	3	0	1	1	1	1	0	0	0
07.01.2025 00:00	67	Jones T.	PHO	5	3	2	1175	2	7	0	0	1	4	0	0	1	0	3	0	1	1	0	0	0
07.01.2025 00:00	68	Nurkic J.	PHO	5	7	1	862	1	2	0	0	0	0	3	4	6	1	6	3	0	2	0	0	0
07.01.2025 00:00	69	Okogie J.	PHO	3	3	1	391	1	2	0	0	1	2	0	0	2	0	3	1	0	0	0	0	0
07.01.2025 00:00	70	Plumlee M.	PHO	2	7	2	758	1	1	0	0	0	0	0	0	-2	1	6	2	1	0	2	0	0
05.01.2025 00:00	71	Durant K.	PHO	25	7	7	2250	9	14	0	0	1	3	6	6	-22	0	7	1	0	5	1	0	0
05.01.2025 00:00	72	Booker D.	PHO	20	8	9	2173	7	15	0	0	2	5	4	5	-16	0	8	3	0	1	0	0	0
05.01.2025 00:00	73	Allen G.	PHO	13	4	6	1839	5	10	0	0	3	7	0	0	-12	0	4	2	0	1	1	0	0
05.01.2025 00:00	74	Dunn R.	PHO	13	4	1	1771	6	11	0	0	1	4	0	0	-2	1	3	1	0	0	1	0	0
05.01.2025 00:00	75	Morris M.	PHO	12	0	0	1324	3	5	0	0	2	4	4	4	-1	0	0	0	0	1	0	0	0
05.01.2025 00:00	76	Beal B.	PHO	8	3	3	1977	3	12	0	0	2	3	0	0	-21	2	1	3	1	1	1	0	0
05.01.2025 00:00	77	Okogie J.	PHO	6	3	3	1051	2	4	0	0	0	1	2	2	2	1	2	3	1	0	1	0	0
05.01.2025 00:00	78	Bol B.	PHO	5	1	0	717	2	4	0	0	1	3	0	0	-3	0	1	0	0	0	2	0	0
05.01.2025 00:00	79	Plumlee M.	PHO	4	5	1	1190	1	3	0	0	0	0	2	2	-15	0	5	1	1	2	0	0	0
05.01.2025 00:00	80	Lee D.	PHO	2	1	0	54	0	0	0	0	0	0	2	2	0	1	0	0	0	0	0	0	0
05.01.2025 00:00	81	Washington T.	PHO	0	0	0	54	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
01.01.2025 02:00	82	Durant K.	PHO	29	10	6	2312	11	19	0	0	2	5	5	7	-4	1	9	2	1	3	2	0	0
01.01.2025 02:00	83	Jones T.	PHO	21	4	2	1823	7	15	0	0	2	5	5	6	-10	1	3	3	3	5	0	0	0
01.01.2025 02:00	84	Booker D.	PHO	16	4	9	1821	4	20	0	0	2	8	6	6	-1	1	3	1	1	3	0	0	0
01.01.2025 02:00	85	Morris M.	PHO	12	3	2	1199	5	8	0	0	0	1	2	3	5	1	2	2	1	1	0	0	0
01.01.2025 02:00	86	Plumlee M.	PHO	12	8	3	1634	6	6	0	0	0	0	0	0	-7	2	6	4	0	0	3	0	0
01.01.2025 02:00	87	Okogie J.	PHO	9	2	0	1657	4	7	0	0	1	4	0	1	0	0	2	4	0	1	1	0	0
01.01.2025 02:00	88	Dunn R.	PHO	8	9	3	2096	3	7	0	0	2	5	0	0	5	3	6	3	2	0	2	0	0
01.01.2025 02:00	89	Beal B.	PHO	3	1	2	720	1	5	0	0	0	1	1	2	-10	0	1	1	1	1	0	0	0
01.01.2025 02:00	90	Ighodaro O.	PHO	2	2	1	1036	1	4	0	0	0	0	0	0	1	1	1	5	0	3	2	0	0
01.01.2025 02:00	91	Lee D.	PHO	0	0	0	100	0	1	0	0	0	1	0	0	-4	0	0	0	0	0	0	0	0
29.12.2024 01:30	92	Durant K.	PHO	31	6	3	2228	10	24	0	0	1	5	10	12	-17	2	4	2	0	8	4	0	0
29.12.2024 01:30	93	Beal B.	PHO	28	5	2	2383	12	24	0	0	4	11	0	0	-10	1	4	3	1	0	2	0	0
29.12.2024 01:30	94	Dunn R.	PHO	15	4	1	1590	6	12	0	0	1	6	2	2	6	2	2	2	0	0	2	0	0
29.12.2024 01:30	95	Okogie J.	PHO	11	9	0	1848	4	8	0	0	1	2	2	4	3	6	3	2	2	2	2	0	0
29.12.2024 01:30	96	Jones T.	PHO	8	5	6	1896	3	11	0	0	2	6	0	0	-11	0	5	1	0	1	0	0	0
29.12.2024 01:30	97	Morris M.	PHO	8	1	2	984	3	6	0	0	0	2	2	2	9	0	1	0	1	0	0	0	0
29.12.2024 01:30	98	Ighodaro O.	PHO	2	6	1	1195	1	4	0	0	0	0	0	0	7	2	4	1	2	0	0	0	0
29.12.2024 01:30	99	Plumlee M.	PHO	2	9	6	1567	0	0	0	0	0	0	2	2	-2	1	8	1	1	2	1	0	0
29.12.2024 01:30	100	O'Neale R.	PHO	0	1	0	709	0	3	0	0	0	3	0	0	-5	0	1	1	0	0	1	0	0
28.12.2024 02:00	101	Durant K.	PHO	35	3	0	2262	11	19	0	0	3	4	10	12	-3	0	3	1	0	1	0	0	0
28.12.2024 02:00	102	O'Neale R.	PHO	14	5	4	1817	5	10	0	0	4	9	0	0	-11	0	5	2	2	2	2	0	0
28.12.2024 02:00	103	Beal B.	PHO	11	3	4	2300	5	18	0	0	1	5	0	0	-13	2	1	3	2	4	1	0	0
28.12.2024 02:00	104	Okogie J.	PHO	8	4	1	1298	3	9	0	0	2	5	0	0	0	2	2	1	2	0	1	0	0
28.12.2024 02:00	105	Dunn R.	PHO	5	5	1	1272	2	8	0	0	1	5	0	0	-6	1	4	2	3	0	1	0	0
28.12.2024 02:00	106	Ighodaro O.	PHO	4	3	1	958	2	2	0	0	0	0	0	2	3	0	3	1	1	0	0	0	1
28.12.2024 02:00	107	Plumlee M.	PHO	4	9	2	1070	1	2	0	0	0	0	2	4	0	3	6	3	0	0	0	0	0
28.12.2024 02:00	108	Jones T.	PHO	3	2	6	1444	1	5	0	0	1	4	0	0	-11	2	0	0	0	2	1	0	0
28.12.2024 02:00	109	Nurkic J.	PHO	3	5	2	810	1	4	0	0	1	1	0	0	-10	2	3	3	1	4	1	0	1
28.12.2024 02:00	110	Lee D.	PHO	2	0	0	52	1	2	0	0	0	0	0	0	2	0	0	0	0	0	0	0	0
28.12.2024 02:00	111	Bridges J.	PHO	0	0	0	52	0	0	0	0	0	0	0	0	2	0	0	0	0	0	0	0	0
28.12.2024 02:00	112	Morris M.	PHO	0	3	2	1065	0	4	0	0	0	2	0	0	2	0	3	1	0	0	0	0	0
26.12.2024 03:30	113	Beal B.	PHO	27	2	4	2298	11	21	0	0	3	7	2	4	12	1	1	4	4	3	1	0	0
26.12.2024 03:30	114	Durant K.	PHO	27	4	6	2268	9	26	0	0	0	5	9	9	3	2	2	3	2	0	2	0	0
26.12.2024 03:30	115	Jones T.	PHO	17	3	4	1823	7	9	0	0	3	5	0	0	2	0	3	1	1	1	0	0	0
26.12.2024 03:30	116	Morris M.	PHO	11	2	3	1057	3	8	0	0	1	5	4	4	8	1	1	0	2	0	0	0	0
26.12.2024 03:30	117	Nurkic J.	PHO	8	13	6	1796	3	6	0	0	1	4	1	2	5	3	10	2	0	1	0	0	0
26.12.2024 03:30	118	Okogie J.	PHO	7	2	0	1016	3	6	0	0	1	3	0	0	9	2	0	0	1	0	0	0	0
26.12.2024 03:30	119	O'Neale R.	PHO	5	8	6	1807	2	7	0	0	1	5	0	0	3	1	7	3	2	0	1	0	0
26.12.2024 03:30	120	Plumlee M.	PHO	3	4	1	752	1	1	0	0	0	0	1	1	3	0	4	3	0	2	0	0	0
26.12.2024 03:30	121	Dunn R.	PHO	0	3	1	1251	2	3	0	0	1	2	0	0	3	2	1	1	0	0	0	0	0
26.12.2024 03:30	122	Ighodaro O.	PHO	0	1	0	332	0	1	0	0	0	0	0	0	2	0	1	0	0	0	0	0	0
\.


--
-- Data for Name: phoenix_suns_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.phoenix_suns_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Nurkic Jusuf	Lesionado	2025-01-17 13:54:49.968635
2	Beal Bradley	Lesionado	2025-01-17 13:54:49.970796
3	Okogie Josh	Lesionado	2025-01-17 13:54:49.972329
\.


--
-- Data for Name: portland_trail_blazers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.portland_trail_blazers (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	13.04.2024	Portland Trail Blazers	107	Houston Rockets	116	24	16	35	32	23	31	30	32
2	14.04.2024	Sacramento Kings	121	Portland Trail Blazers	82	30	35	34	22	18	19	21	24
3	14.07.2024	Portland Trail Blazers	77	San Antonio Spurs	83	18	13	24	22	28	23	22	10
4	16.07.2024	Philadelphia 76ers	95	Portland Trail Blazers	97	25	23	29	18	24	27	26	20
5	17.07.2024	Portland Trail Blazers	82	Washington Wizards	80	17	22	27	16	18	20	22	20
6	20.07.2024	Charlotte Hornets	84	Portland Trail Blazers	68	20	16	25	23	13	16	8	31
7	22.07.2024	Portland Trail Blazers	105	Houston Rockets	95	20	28	33	24	27	13	27	28
8	12.10.2024	Los Angeles Clippers	101	Portland Trail Blazers	99	23	26	27	25	24	26	28	21
9	13.10.2024	Sacramento Kings	85	Portland Trail Blazers	105	27	24	18	16	25	35	30	15
10	17.10.2024	Portland Trail Blazers (Usa)	111	Ulm (Ger)	100	28	33	22	28	21	24	29	26
11	19.10.2024	Portland Trail Blazers	124	Utah Jazz	86	29	31	36	28	17	16	22	31
12	24.10.2024	Portland Trail Blazers	104	Golden State Warriors	140	21	29	22	32	21	41	38	40
13	26.10.2024	Portland Trail Blazers	103	New Orleans Pelicans	105	27	20	37	19	15	22	38	30
14	27.10.2024	Portland Trail Blazers	125	New Orleans Pelicans	103	26	33	34	32	25	22	30	26
15	29.10.2024	Sacramento Kings	111	Portland Trail Blazers	98	25	26	38	22	20	23	28	27
16	31.10.2024	Los Angeles Clippers	105	Portland Trail Blazers	106	26	24	35	20	24	30	28	24
17	02.11.2024	Portland Trail Blazers	114	Oklahoma City Thunder	137	24	44	17	29	37	31	38	31
18	03.11.2024	Phoenix Suns	103	Portland Trail Blazers	97	22	21	44	16	18	29	18	32
19	05.11.2024	New Orleans Pelicans	100	Portland Trail Blazers	118	30	25	27	18	21	27	31	39
20	08.11.2024	San Antonio Spurs	118	Portland Trail Blazers	105	33	23	35	27	27	28	24	26
21	09.11.2024	Minnesota Timberwolves	127	Portland Trail Blazers	102	35	29	34	29	17	34	24	27
22	11.11.2024	Portland Trail Blazers	89	Memphis Grizzlies	134	17	27	24	21	31	33	42	28
23	13.11.2024	Portland Trail Blazers	122	Minnesota Timberwolves	108	28	32	33	29	17	36	21	34
24	14.11.2024	Portland Trail Blazers	106	Minnesota Timberwolves	98	23	25	28	30	33	15	28	22
25	17.11.2024	Portland Trail Blazers	114	Atlanta Hawks	110	21	35	38	20	33	31	17	29
26	21.11.2024	Oklahoma City Thunder	109	Portland Trail Blazers	99	21	26	23	39	23	21	25	30
27	23.11.2024	Houston Rockets	116	Portland Trail Blazers	88	31	34	31	20	20	25	28	15
28	24.11.2024	Houston Rockets	98	Portland Trail Blazers	104	21	29	21	27	26	26	21	31
29	26.11.2024	Memphis Grizzlies	123	Portland Trail Blazers	98	36	29	27	31	24	30	21	23
30	28.11.2024	Indiana Pacers	121	Portland Trail Blazers	114	26	34	36	25	31	29	25	29
31	30.11.2024	Portland Trail Blazers	115	Sacramento Kings	106	25	29	33	28	30	20	22	34
32	02.12.2024	Portland Trail Blazers	131	Dallas Mavericks	137	29	29	39	34	25	36	39	37
33	04.12.2024	Los Angeles Clippers	127	Portland Trail Blazers	105	36	27	28	36	31	27	20	27
34	07.12.2024	Portland Trail Blazers	99	Utah Jazz	141	17	27	26	29	33	34	35	39
35	09.12.2024	Los Angeles Lakers	107	Portland Trail Blazers	98	22	37	18	30	28	17	29	24
36	14.12.2024	Portland Trail Blazers	116	San Antonio Spurs	118	25	17	46	28	33	19	28	38
37	16.12.2024	Phoenix Suns	116	Portland Trail Blazers	109	33	24	26	33	21	30	28	30
38	20.12.2024	Portland Trail Blazers	126	Denver Nuggets	124	30	36	38	22	35	31	21	37
39	22.12.2024	San Antonio Spurs	114	Portland Trail Blazers	94	25	35	27	27	20	24	25	25
40	24.12.2024	Dallas Mavericks	132	Portland Trail Blazers	108	28	34	40	30	31	22	23	32
41	27.12.2024	Portland Trail Blazers	122	Utah Jazz	120	23	32	26	41	23	31	34	32
42	29.12.2024	Portland Trail Blazers	126	Dallas Mavericks	122	36	33	28	29	25	34	23	40
43	31.12.2024	Portland Trail Blazers	103	Philadelphia 76ers	125	31	23	18	31	33	31	27	34
44	03.01. 03:30	Los Angeles Lakers	114	Portland Trail Blazers	106	27	33	28	26	31	20	24	31
45	05.01. 01:00	Milwaukee Bucks	102	Portland Trail Blazers	105	31	20	25	26	28	26	21	30
46	07.01. 00:00	Detroit Pistons	118	Portland Trail Blazers	115	23	28	37	30	28	32	30	25
47	09.01. 01:00	New Orleans Pelicans	100	Portland Trail Blazers	119	24	18	34	24	40	35	23	21
48	10.01. 00:30	Dallas Mavericks	117	Portland Trail Blazers	111	20	33	28	36	28	30	31	22
49	12.01. 03:00	Portland Trail Blazers	98	Miami Heat	119	23	25	35	15	29	37	28	25
50	15.01. 03:00	Portland Trail Blazers	114	Brooklyn Nets	132	30	31	27	26	40	26	32	34
51	17.01. 03:00	Portland Trail Blazers	89	Los Angeles Clippers	118	22	16	28	23	32	20	34	32
\.


--
-- Data for Name: portland_trail_blazers_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.portland_trail_blazers_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
17.01.2025 03:00	1	Banton D.	POR	23	3	1	1483	7	17	0	0	4	8	5	6	-13	0	3	1	1	1	0	0	0
17.01.2025 03:00	2	Henderson S.	POR	16	2	6	1948	6	14	0	0	2	7	2	2	-19	0	2	5	1	3	0	0	0
17.01.2025 03:00	3	Ayton D.	POR	14	7	1	1426	7	13	0	0	0	0	0	0	-26	3	4	1	0	1	0	0	0
17.01.2025 03:00	4	Sharpe S.	POR	12	4	4	1372	5	11	0	0	1	3	1	1	-20	2	2	3	1	3	0	0	0
17.01.2025 03:00	5	Murray K.	POR	9	4	1	1761	4	10	0	0	1	4	0	0	-10	3	1	0	0	2	0	0	0
17.01.2025 03:00	6	Rupert R.	POR	5	2	1	394	2	3	0	0	1	1	0	0	0	2	0	0	0	0	0	0	0
17.01.2025 03:00	7	Reath D.	POR	4	0	0	183	1	2	0	0	0	1	2	2	2	0	0	0	0	0	0	0	0
17.01.2025 03:00	8	Williams R.	POR	4	7	2	1060	1	3	0	0	0	0	2	2	-3	2	5	2	0	2	0	0	0
17.01.2025 03:00	9	Walker J.	POR	2	6	1	1179	1	4	0	0	0	2	0	0	-2	2	4	0	3	0	0	0	0
17.01.2025 03:00	10	Camara T.	POR	0	1	2	1543	0	5	0	0	0	3	0	0	-25	0	1	3	2	2	1	0	0
17.01.2025 03:00	11	Minaya J.	POR	0	0	0	259	0	0	0	0	0	0	0	0	2	0	0	0	0	0	0	0	0
17.01.2025 03:00	12	Simons A.	POR	0	1	5	1792	0	9	0	0	0	5	0	0	-31	0	1	2	1	2	0	0	0
15.01.2025 03:00	13	Henderson S.	POR	39	4	6	2329	13	18	0	0	8	10	5	8	-11	2	2	4	2	4	0	0	0
15.01.2025 03:00	14	Camara T.	POR	23	5	2	2297	7	21	0	0	4	11	5	5	2	3	2	2	2	0	2	0	0
15.01.2025 03:00	15	Sharpe S.	POR	21	2	2	2072	9	17	0	0	1	5	2	2	-11	0	2	1	1	2	0	0	0
15.01.2025 03:00	16	Simons A.	POR	11	1	4	1909	3	12	0	0	2	6	3	3	-19	0	1	1	0	2	0	0	0
15.01.2025 03:00	17	Banton D.	POR	10	0	1	1115	3	7	0	0	2	4	2	2	-8	0	0	1	1	0	0	0	0
15.01.2025 03:00	18	Clingan D.	POR	4	14	2	1348	1	1	0	0	0	0	2	2	6	5	9	4	2	4	1	0	0
15.01.2025 03:00	19	Murray K.	POR	4	4	3	1364	2	5	0	0	0	2	0	2	5	3	1	1	0	2	0	0	0
15.01.2025 03:00	20	Ayton D.	POR	2	8	0	1458	1	4	0	0	0	0	0	0	-19	0	8	1	0	1	0	0	0
15.01.2025 03:00	21	Minaya J.	POR	0	0	0	74	0	0	0	0	0	0	0	0	-5	0	0	1	0	0	0	0	0
15.01.2025 03:00	22	Reath D.	POR	0	0	0	74	0	0	0	0	0	0	0	0	-5	0	0	0	0	1	0	0	0
15.01.2025 03:00	23	Rupert R.	POR	0	0	0	74	0	1	0	0	0	0	0	0	-5	0	0	0	0	0	0	0	0
15.01.2025 03:00	24	Walker J.	POR	0	0	0	286	0	0	0	0	0	0	0	0	-20	0	0	0	0	1	0	0	0
12.01.2025 03:00	25	Simons A.	POR	28	4	3	1997	10	23	0	0	7	14	1	1	-1	1	3	2	0	2	0	0	0
12.01.2025 03:00	26	Sharpe S.	POR	22	3	5	2241	7	20	0	0	3	8	5	6	-18	0	3	2	0	6	1	0	0
12.01.2025 03:00	27	Avdija D.	POR	15	12	5	2239	5	14	0	0	1	4	4	4	-16	1	11	1	2	3	1	0	1
12.01.2025 03:00	28	Murray K.	POR	10	3	2	877	5	7	0	0	0	1	0	0	-16	3	0	1	0	0	1	0	0
12.01.2025 03:00	29	Clingan D.	POR	8	10	1	1636	4	6	0	0	0	1	0	0	-2	2	8	1	1	1	2	0	1
12.01.2025 03:00	30	Camara T.	POR	6	10	2	2329	2	7	0	0	0	3	2	4	-7	7	3	3	1	1	1	0	0
12.01.2025 03:00	31	Henderson S.	POR	3	3	3	1276	1	6	0	0	0	4	1	4	-17	0	3	2	1	1	0	0	0
12.01.2025 03:00	32	Reath D.	POR	3	3	1	981	1	6	0	0	1	6	0	0	-11	0	3	2	0	1	0	0	0
12.01.2025 03:00	33	Walker J.	POR	3	0	0	123	1	2	0	0	1	2	0	0	-3	0	0	0	0	0	0	0	0
12.01.2025 03:00	34	Banton D.	POR	0	1	1	332	0	1	0	0	0	0	0	0	-5	0	1	0	0	0	0	0	0
12.01.2025 03:00	35	McGowens B.	POR	0	0	0	123	0	1	0	0	0	1	0	0	-3	0	0	0	0	0	0	0	0
12.01.2025 03:00	36	Minaya J.	POR	0	2	1	123	0	1	0	0	0	0	0	0	-3	2	0	1	1	0	0	0	0
12.01.2025 03:00	37	Rupert R.	POR	0	0	0	123	0	1	0	0	0	1	0	0	-3	0	0	0	0	1	0	0	0
10.01.2025 00:30	38	Sharpe S.	POR	22	8	3	1943	8	19	0	0	3	6	3	3	-15	2	6	5	2	3	1	0	0
10.01.2025 00:30	39	Simons A.	POR	22	1	4	2229	9	22	0	0	4	10	0	0	0	0	1	1	1	1	0	0	0
10.01.2025 00:30	40	Henderson S.	POR	20	2	4	1588	3	7	0	0	2	4	12	12	3	1	1	3	1	2	0	0	0
10.01.2025 00:30	41	Camara T.	POR	11	2	1	1834	4	14	0	0	3	8	0	0	-7	2	0	5	1	1	0	0	0
10.01.2025 00:30	42	Clingan D.	POR	11	11	1	1456	4	4	0	0	1	1	2	3	3	4	7	3	0	0	2	0	0
10.01.2025 00:30	43	Avdija D.	POR	9	8	4	2035	4	12	0	0	1	5	0	2	-13	1	7	2	0	1	0	0	1
10.01.2025 00:30	44	Ayton D.	POR	6	6	1	1248	3	6	0	0	0	0	0	0	-3	1	5	2	1	3	2	0	0
10.01.2025 00:30	45	Banton D.	POR	5	2	3	887	2	6	0	0	1	1	0	0	2	2	0	0	0	0	1	0	0
10.01.2025 00:30	46	Murray K.	POR	5	3	3	1180	2	3	0	0	1	1	0	0	0	1	2	1	0	1	1	0	0
09.01.2025 01:00	47	Avdija D.	POR	26	6	2	1624	10	15	0	0	4	7	2	4	24	3	3	2	1	3	1	0	0
09.01.2025 01:00	48	Sharpe S.	POR	21	1	2	1998	8	13	0	0	4	7	1	1	28	0	1	0	1	2	0	0	0
09.01.2025 01:00	49	Simons A.	POR	17	6	5	1724	7	11	0	0	3	7	0	0	15	1	5	0	1	0	0	0	0
09.01.2025 01:00	50	Camara T.	POR	15	3	5	1761	4	8	0	0	1	4	6	6	23	0	3	3	3	2	1	0	0
09.01.2025 01:00	51	Henderson S.	POR	13	2	5	1753	6	15	0	0	1	5	0	0	4	0	2	2	1	5	0	0	0
09.01.2025 01:00	52	Ayton D.	POR	11	13	3	1623	5	8	0	0	0	0	1	2	26	7	6	1	0	1	1	0	0
09.01.2025 01:00	53	Murray K.	POR	6	1	0	1256	3	6	0	0	0	3	0	0	-5	0	1	1	1	0	0	0	0
09.01.2025 01:00	54	Banton D.	POR	4	1	2	896	2	6	0	0	0	3	0	0	1	0	1	1	2	0	0	0	0
09.01.2025 01:00	55	Williams R.	POR	4	6	0	972	2	3	0	0	0	0	0	0	2	1	5	2	1	0	4	0	0
09.01.2025 01:00	56	Reath D.	POR	2	2	0	223	1	2	0	0	0	0	0	0	-5	2	0	0	0	0	0	0	0
09.01.2025 01:00	57	Rupert R.	POR	0	1	0	285	0	1	0	0	0	0	0	0	-9	1	0	1	0	0	0	0	0
09.01.2025 01:00	58	Walker J.	POR	0	2	0	285	0	0	0	0	0	0	0	0	-9	0	2	1	0	0	0	0	0
07.01.2025 00:00	59	Simons A.	POR	36	2	9	2181	14	21	0	0	8	12	0	0	-2	0	2	3	0	4	0	0	0
07.01.2025 00:00	60	Sharpe S.	POR	20	8	8	2589	8	17	0	0	3	7	1	1	1	1	7	3	2	1	1	0	0
07.01.2025 00:00	61	Ayton D.	POR	18	11	4	2077	9	16	0	0	0	1	0	0	-10	1	10	1	0	1	1	0	1
07.01.2025 00:00	62	Avdija D.	POR	14	4	3	1767	6	13	0	0	1	5	1	1	8	1	3	3	1	1	0	0	0
07.01.2025 00:00	63	Camara T.	POR	12	3	1	2189	5	8	0	0	2	5	0	1	-12	1	2	3	3	4	1	0	0
07.01.2025 00:00	64	Murray K.	POR	11	4	3	1641	4	7	0	0	2	3	1	1	3	1	3	3	0	0	1	0	0
07.01.2025 00:00	65	Clingan D.	POR	4	5	1	803	2	6	0	0	0	1	0	1	7	1	4	2	0	1	0	0	0
07.01.2025 00:00	66	Henderson S.	POR	0	1	3	1153	0	2	0	0	0	1	0	0	-10	1	0	0	0	4	0	0	0
05.01.2025 01:00	67	Simons A.	POR	28	3	8	2437	9	20	0	0	5	12	5	5	10	0	3	1	0	4	0	0	0
05.01.2025 01:00	68	Avdija D.	POR	19	14	4	2555	7	14	0	0	3	8	2	2	6	0	14	3	3	7	0	0	0
05.01.2025 01:00	69	Sharpe S.	POR	16	4	3	1906	7	15	0	0	2	7	0	2	1	1	3	1	1	1	0	0	0
05.01.2025 01:00	70	Camara T.	POR	15	6	2	2001	6	11	0	0	2	4	1	1	-1	1	5	2	1	0	0	0	0
05.01.2025 01:00	71	Ayton D.	POR	10	13	0	2044	5	9	0	0	0	1	0	1	3	2	11	1	1	2	1	0	0
05.01.2025 01:00	72	Henderson S.	POR	9	7	3	1417	3	5	0	0	1	2	2	2	-5	1	6	0	1	3	1	0	0
05.01.2025 01:00	73	Clingan D.	POR	4	5	0	836	2	5	0	0	0	1	0	0	0	2	3	0	0	0	1	0	0
05.01.2025 01:00	74	Murray K.	POR	4	3	1	1204	2	6	0	0	0	1	0	0	1	1	2	1	0	0	0	0	0
03.01.2025 03:30	75	Simons A.	POR	23	3	5	2199	8	17	0	0	4	9	3	3	-5	0	3	2	2	4	0	0	0
03.01.2025 03:30	76	Avdija D.	POR	19	10	4	2159	8	14	0	0	1	3	2	2	5	0	10	1	1	2	0	0	1
03.01.2025 03:30	77	Sharpe S.	POR	19	5	1	2214	6	16	0	0	1	5	6	8	-7	0	5	2	1	3	0	0	0
03.01.2025 03:30	78	Camara T.	POR	18	4	3	2327	8	13	0	0	2	4	0	0	-9	2	2	2	0	0	1	0	0
03.01.2025 03:30	79	Henderson S.	POR	12	5	8	1931	4	7	0	0	1	2	3	4	3	1	4	5	1	3	1	0	0
03.01.2025 03:30	80	Ayton D.	POR	6	6	1	1259	3	4	0	0	0	1	0	0	-14	1	5	1	0	3	0	0	0
03.01.2025 03:30	81	Clingan D.	POR	4	3	1	1037	1	2	0	0	0	0	2	2	-1	2	1	0	0	1	1	0	0
03.01.2025 03:30	82	Murray K.	POR	3	5	1	985	1	3	0	0	0	2	1	2	-10	2	3	2	1	1	1	0	0
03.01.2025 03:30	83	Banton D.	POR	2	1	0	289	1	4	0	0	0	0	0	0	-2	0	1	0	0	1	0	0	0
31.12.2024 03:00	84	Simons A.	POR	25	4	4	1814	9	18	0	0	4	10	3	4	-17	0	4	4	0	1	0	0	0
31.12.2024 03:00	85	Avdija D.	POR	17	7	2	1976	5	9	0	0	2	5	5	5	-21	2	5	3	1	10	0	0	0
31.12.2024 03:00	86	Ayton D.	POR	12	6	3	1791	6	8	0	0	0	1	0	0	-24	3	3	3	0	3	2	0	1
31.12.2024 03:00	87	Camara T.	POR	12	10	1	2036	4	9	0	0	0	2	4	5	-23	6	4	5	2	0	0	0	0
31.12.2024 03:00	88	Sharpe S.	POR	12	1	1	2054	5	14	0	0	1	8	1	2	-25	0	1	3	0	3	0	0	0
31.12.2024 03:00	89	Reath D.	POR	9	1	0	243	2	3	0	0	1	2	4	6	3	0	1	1	0	0	0	0	0
31.12.2024 03:00	90	Henderson S.	POR	6	0	7	1429	2	7	0	0	0	4	2	3	-11	0	0	2	3	3	0	0	0
31.12.2024 03:00	91	Walker J.	POR	5	0	0	243	2	3	0	0	0	1	1	3	3	0	0	0	0	0	0	0	0
31.12.2024 03:00	92	Clingan D.	POR	3	1	2	511	1	2	0	0	0	0	1	2	1	0	1	2	0	3	0	0	0
31.12.2024 03:00	93	Murray K.	POR	2	1	1	911	1	2	0	0	0	1	0	0	8	0	1	0	1	0	0	0	0
31.12.2024 03:00	94	McGowens B.	POR	0	1	0	243	0	0	0	0	0	0	0	0	3	1	0	0	0	0	0	0	0
31.12.2024 03:00	95	Rupert R.	POR	0	0	2	464	0	1	0	0	0	1	0	0	-3	0	0	0	1	0	0	0	0
31.12.2024 03:00	96	Williams R.	POR	0	1	0	685	0	1	0	0	0	1	0	0	-4	0	1	3	0	1	2	0	0
29.12.2024 03:00	97	Sharpe S.	POR	23	5	4	2283	9	18	0	0	2	4	3	3	17	1	4	3	1	0	0	0	0
29.12.2024 03:00	98	Simons A.	POR	22	4	8	2378	8	18	0	0	4	8	2	2	7	0	4	1	0	2	0	0	0
29.12.2024 03:00	99	Avdija D.	POR	21	5	5	1886	6	13	0	0	0	2	9	11	-8	2	3	3	0	2	0	0	0
29.12.2024 03:00	100	Ayton D.	POR	21	16	1	2142	9	15	0	0	0	1	3	4	16	4	12	4	2	4	3	0	0
29.12.2024 03:00	101	Henderson S.	POR	19	4	6	1718	8	15	0	0	2	6	1	3	3	0	4	2	5	1	1	0	0
29.12.2024 03:00	102	Grant J.	POR	14	8	3	2503	4	9	0	0	3	4	3	4	11	2	6	3	0	0	2	0	0
29.12.2024 03:00	103	Clingan D.	POR	4	7	0	738	1	3	0	0	0	1	2	2	-12	4	3	1	0	3	1	0	0
29.12.2024 03:00	104	Murray K.	POR	2	1	0	491	1	1	0	0	0	0	0	0	-6	1	0	0	0	2	0	0	0
29.12.2024 03:00	105	Rupert R.	POR	0	0	0	261	0	0	0	0	0	0	0	0	-8	0	0	2	0	0	0	0	0
27.12.2024 03:00	106	Avdija D.	POR	27	8	6	1857	9	13	0	0	2	4	7	10	11	0	8	4	1	2	1	0	0
27.12.2024 03:00	107	Sharpe S.	POR	27	5	3	1842	11	18	0	0	5	10	0	0	7	0	5	2	0	0	2	0	0
27.12.2024 03:00	108	Ayton D.	POR	18	12	2	2062	8	16	0	0	1	2	1	1	-1	4	8	1	1	1	2	0	1
27.12.2024 03:00	109	Henderson S.	POR	18	0	10	1794	6	12	0	0	3	6	3	4	22	0	0	4	2	1	1	0	0
27.12.2024 03:00	110	Grant J.	POR	14	3	1	1880	3	5	0	0	2	3	6	7	-9	0	3	1	0	2	1	0	0
27.12.2024 03:00	111	Simons A.	POR	8	3	3	1821	3	12	0	0	2	8	0	0	-15	1	2	3	2	3	0	0	0
27.12.2024 03:00	112	Camara T.	POR	6	8	0	1896	3	8	0	0	0	4	0	0	-5	2	6	4	1	1	1	0	0
27.12.2024 03:00	113	Clingan D.	POR	4	4	0	818	2	3	0	0	0	0	0	0	3	2	2	1	2	1	0	0	0
27.12.2024 03:00	114	Murray K.	POR	0	0	1	430	0	2	0	0	0	1	0	0	-3	0	0	0	1	0	0	0	0
24.12.2024 01:30	115	Avdija D.	POR	19	6	3	1377	6	11	0	0	2	4	5	8	-14	4	2	4	0	2	1	0	0
24.12.2024 01:30	116	Ayton D.	POR	16	9	0	1543	8	11	0	0	0	0	0	0	-20	4	5	3	2	1	0	0	0
24.12.2024 01:30	117	Henderson S.	POR	14	6	4	1564	4	11	0	0	2	3	4	4	-12	1	5	5	1	4	0	0	0
24.12.2024 01:30	118	Sharpe S.	POR	13	2	3	1453	6	14	0	0	1	4	0	0	-16	0	2	1	3	1	0	0	0
24.12.2024 01:30	119	Walker J.	POR	13	5	0	478	6	7	0	0	1	1	0	1	5	2	3	0	0	0	0	0	0
24.12.2024 01:30	120	Simons A.	POR	10	0	5	1733	5	12	0	0	0	3	0	0	-22	0	0	2	0	2	0	0	0
24.12.2024 01:30	121	Rupert R.	POR	6	1	0	478	1	2	0	0	0	1	4	4	5	0	1	0	0	1	0	0	0
24.12.2024 01:30	122	Camara T.	POR	5	12	0	1783	2	6	0	0	1	5	0	0	-18	4	8	2	0	1	0	0	0
24.12.2024 01:30	123	Clingan D.	POR	4	3	1	918	2	5	0	0	0	1	0	0	-7	1	2	2	0	1	0	0	0
24.12.2024 01:30	124	Banton D.	POR	3	1	3	768	1	3	0	0	0	2	1	2	0	0	1	0	0	3	0	0	0
24.12.2024 01:30	125	Grant J.	POR	3	1	2	1201	1	7	0	0	1	4	0	0	-14	0	1	2	0	1	0	0	0
24.12.2024 01:30	126	Murray K.	POR	2	2	2	1104	1	4	0	0	0	1	0	0	-7	0	2	4	0	1	0	0	0
\.


--
-- Data for Name: portland_trail_blazers_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.portland_trail_blazers_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Clingan Donovan	Lesionado	2025-01-17 13:55:04.462888
2	Thybulle Matisse	Lesionado	2025-01-17 13:55:04.465767
3	Avdija Deni	Lesionado	2025-01-17 13:55:04.468066
4	Grant Jerami	Lesionado	2025-01-17 13:55:04.47135
\.


--
-- Data for Name: sacramento_kings; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.sacramento_kings (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	12.07.2024	Memphis Grizzlies	103	Sacramento Kings	83	28	27	24	24	19	16	22	26
2	16.07.2024	Sacramento Kings	82	Utah Jazz	70	23	25	17	17	9	16	24	21
3	17.07.2024	New York Knicks	106	Sacramento Kings	105	23	30	25	28	30	23	22	30
4	19.07.2024	Sacramento Kings	69	Washington Wizards	73	19	16	20	14	17	26	14	16
5	20.07.2024	Sacramento Kings	87	Phoenix Suns	77	21	17	23	26	20	20	19	18
6	10.10.2024	Sacramento Kings	112	Golden State Warriors	122	27	41	23	21	31	35	34	22
7	12.10.2024	Golden State Warriors	109	Sacramento Kings	106	34	21	26	28	30	28	26	22
8	13.10.2024	Sacramento Kings	85	Portland Trail Blazers	105	27	24	18	16	25	35	30	15
9	16.10.2024	Utah Jazz	117	Sacramento Kings	114	31	27	29	30	30	26	27	31
10	18.10.2024	Los Angeles Clippers	113	Sacramento Kings	91	30	35	20	28	20	18	31	22
11	25.10.2024	Sacramento Kings	115	Minnesota Timberwolves	117	32	27	29	27	29	26	34	28
12	27.10.2024	Los Angeles Lakers	131	Sacramento Kings	127	28	36	23	44	26	34	34	33
13	29.10.2024	Sacramento Kings	111	Portland Trail Blazers	98	25	26	38	22	20	23	28	27
14	30.10.2024	Utah Jazz	96	Sacramento Kings	113	22	30	14	30	34	27	29	23
15	01.11.2024	Atlanta Hawks	115	Sacramento Kings	123	26	33	31	25	33	36	33	21
16	02.11.2024\nApós Prol.	Toronto Raptors	131	Sacramento Kings	128	37	29	30	24	29	34	23	34
17	05.11.2024	Miami Heat	110	Sacramento Kings	111	25	36	17	32	22	26	37	26
18	07.11.2024	Sacramento Kings	122	Toronto Raptors	107	30	27	32	33	33	21	39	14
19	09.11.2024	Sacramento Kings	98	Los Angeles Clippers	107	28	17	28	25	34	17	27	29
20	11.11.2024\nApós Prol.	Phoenix Suns	118	Sacramento Kings	127	31	22	29	29	36	24	19	32
21	12.11.2024	San Antonio Spurs	116	Sacramento Kings	96	22	38	24	32	26	29	16	25
22	14.11.2024	Sacramento Kings	127	Phoenix Suns	104	35	26	32	34	29	27	24	24
23	16.11.2024\nApós Prol.	Sacramento Kings	126	Minnesota Timberwolves	130	27	27	28	33	32	30	36	17
24	17.11.2024	Sacramento Kings	121	Utah Jazz	117	35	29	26	31	31	32	31	23
25	19.11.2024	Sacramento Kings	108	Atlanta Hawks	109	31	35	27	15	32	32	25	20
26	23.11.2024	Los Angeles Clippers	104	Sacramento Kings	88	26	25	25	28	12	17	35	24
27	25.11.2024	Sacramento Kings	103	Brooklyn Nets	108	28	29	31	15	37	28	23	20
28	26.11.2024	Sacramento Kings	109	Oklahoma City Thunder	130	30	32	22	25	31	32	34	33
29	28.11.2024	Minnesota Timberwolves	104	Sacramento Kings	115	33	24	29	18	31	38	12	34
30	30.11.2024	Portland Trail Blazers	115	Sacramento Kings	106	25	29	33	28	30	20	22	34
31	02.12.2024	Sacramento Kings	125	San Antonio Spurs	127	42	23	32	28	28	30	34	35
32	04.12.2024	Sacramento Kings	120	Houston Rockets	111	21	33	42	24	28	27	29	27
33	06.12.2024	Memphis Grizzlies	115	Sacramento Kings	110	33	30	23	29	32	30	24	24
34	07.12.2024	San Antonio Spurs	113	Sacramento Kings	140	33	26	27	27	33	36	31	40
35	09.12.2024	Sacramento Kings	141	Utah Jazz	97	26	36	43	36	23	22	29	23
36	13.12.2024	New Orleans Pelicans	109	Sacramento Kings	111	26	29	28	26	28	25	38	20
37	17.12.2024	Sacramento Kings	129	Denver Nuggets	130	21	47	35	26	41	34	21	34
38	20.12.2024	Sacramento Kings	100	Los Angeles Lakers	113	28	30	22	20	37	25	24	27
39	21.12.2024	Sacramento Kings	99	Los Angeles Lakers	103	26	27	24	22	31	25	25	22
40	22.12.2024	Sacramento Kings	95	Indiana Pacers	122	23	29	26	17	21	31	35	35
41	27.12.2024	Sacramento Kings	113	Detroit Pistons	114	37	31	23	22	34	19	24	37
42	29.12.2024	Los Angeles Lakers	132	Sacramento Kings	122	40	25	42	25	31	35	24	32
43	31.12.2024	Sacramento Kings	110	Dallas Mavericks	100	23	33	27	27	37	23	17	23
44	02.01. 03:00	Sacramento Kings	113	Philadelphia 76ers	107	25	32	23	33	30	27	32	18
45	04.01. 03:00	Sacramento Kings	138	Memphis Grizzlies	133	46	32	24	36	32	40	28	33
46	06.01. 01:30	Golden State Warriors	99	Sacramento Kings	129	21	30	24	24	36	39	30	24
47	07.01. 03:00\nApós Prol.	Sacramento Kings	123	Miami Heat	118	23	27	18	34	28	19	31	24
48	11.01. 00:30	Boston Celtics	97	Sacramento Kings	114	27	28	21	21	34	19	23	38
49	12.01. 20:30	Chicago Bulls	119	Sacramento Kings	124	30	33	32	24	32	29	36	27
50	15.01. 01:00	Milwaukee Bucks	130	Sacramento Kings	115	47	28	27	28	26	28	28	33
\.


--
-- Data for Name: sacramento_kings_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.sacramento_kings_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
15.01.2025 01:00	1	DeRozan D.	SAC	28	6	4	2158	9	18	0	0	2	4	8	9	-5	0	6	2	1	0	0	0	0
15.01.2025 01:00	2	Fox D.	SAC	20	11	6	2251	9	23	0	0	2	8	0	0	-6	0	11	1	0	4	1	0	0
15.01.2025 01:00	3	Ellis K.	SAC	18	4	1	1842	5	11	0	0	5	8	3	3	-6	3	1	3	1	0	0	0	0
15.01.2025 01:00	4	Sabonis D.	SAC	16	10	9	2169	6	9	0	0	2	2	2	4	-10	2	8	4	1	3	0	0	0
15.01.2025 01:00	5	Murray K.	SAC	11	7	1	2178	4	11	0	0	3	8	0	0	-7	2	5	2	0	0	0	0	0
15.01.2025 01:00	6	Huerter K.	SAC	7	1	1	1088	3	8	0	0	1	4	0	0	-24	0	1	1	0	1	0	0	0
15.01.2025 01:00	7	Lyles T.	SAC	5	1	0	705	2	4	0	0	1	3	0	0	-19	1	0	0	0	0	0	0	0
15.01.2025 01:00	8	Carter D.	SAC	3	2	1	845	1	6	0	0	0	4	1	2	-11	0	2	0	0	0	0	0	0
15.01.2025 01:00	9	McLaughlin J.	SAC	3	1	1	151	1	1	0	0	1	1	0	0	6	0	1	1	0	0	0	0	0
15.01.2025 01:00	10	Jones C.	SAC	2	0	0	151	1	1	0	0	0	0	0	0	6	0	0	0	0	0	1	0	0
15.01.2025 01:00	11	Len A.	SAC	2	2	1	556	1	2	0	0	0	0	0	0	2	1	1	2	1	1	2	0	0
15.01.2025 01:00	12	Crowder J.	SAC	0	0	0	155	0	0	0	0	0	0	0	0	-7	0	0	0	0	0	0	0	0
15.01.2025 01:00	13	Jones I.	SAC	0	0	0	151	0	1	0	0	0	0	0	0	6	0	0	0	0	0	0	0	0
12.01.2025 20:30	14	Fox D.	SAC	26	9	3	1970	9	16	0	0	4	8	4	5	8	4	5	2	0	2	1	0	0
12.01.2025 20:30	15	Sabonis D.	SAC	22	15	8	2266	8	10	0	0	1	2	5	6	-2	3	12	2	0	2	0	0	0
12.01.2025 20:30	16	DeRozan D.	SAC	21	0	3	2222	9	20	0	0	1	3	2	2	6	0	0	2	0	1	0	0	0
12.01.2025 20:30	17	Monk M.	SAC	18	8	9	2227	7	17	0	0	1	7	3	3	-4	1	7	2	2	2	0	0	0
12.01.2025 20:30	18	Murray K.	SAC	14	5	2	2168	5	12	0	0	3	8	1	2	1	0	5	0	1	1	1	0	0
12.01.2025 20:30	19	Ellis K.	SAC	8	2	0	1178	3	5	0	0	2	4	0	0	-3	0	2	2	1	0	0	0	0
12.01.2025 20:30	20	Huerter K.	SAC	7	3	4	627	3	4	0	0	1	1	0	0	1	1	2	1	0	0	0	0	0
12.01.2025 20:30	21	Lyles T.	SAC	6	8	2	1089	3	10	0	0	0	6	0	1	9	1	7	2	0	0	1	0	0
12.01.2025 20:30	22	Carter D.	SAC	2	3	2	653	0	1	0	0	0	0	2	2	9	1	2	1	0	0	0	0	0
11.01.2025 00:30	23	DeRozan D.	SAC	24	4	9	2411	9	26	0	0	2	5	4	5	15	0	4	2	1	0	1	0	0
11.01.2025 00:30	24	Sabonis D.	SAC	23	28	3	2335	10	15	0	0	3	4	0	0	16	8	20	3	0	4	1	0	0
11.01.2025 00:30	25	Monk M.	SAC	22	3	8	2198	9	24	0	0	3	11	1	1	18	1	2	4	1	1	1	0	0
11.01.2025 00:30	26	Murray K.	SAC	19	3	0	2228	7	12	0	0	5	8	0	0	14	1	2	3	2	0	3	0	0
11.01.2025 00:30	27	Carter D.	SAC	11	4	1	1046	4	8	0	0	3	5	0	0	6	0	4	3	0	1	0	0	0
11.01.2025 00:30	28	Lyles T.	SAC	7	11	3	1679	2	5	0	0	1	4	2	2	11	5	6	2	1	1	1	0	0
11.01.2025 00:30	29	Ellis K.	SAC	6	3	2	1375	2	6	0	0	1	5	1	1	4	1	2	1	3	1	1	0	0
11.01.2025 00:30	30	Huerter K.	SAC	2	0	0	1128	1	6	0	0	0	5	0	0	1	0	0	0	3	1	0	0	0
07.01.2025 03:00	31	DeRozan D.	SAC	30	3	4	2816	12	26	0	0	1	4	5	5	24	0	3	3	0	3	1	0	0
07.01.2025 03:00	32	Monk M.	SAC	23	5	6	2911	8	25	0	0	1	9	6	7	7	2	3	3	2	1	0	0	0
07.01.2025 03:00	33	Sabonis D.	SAC	21	18	11	3029	7	16	0	0	2	2	5	7	11	5	13	5	1	6	3	0	0
07.01.2025 03:00	34	Ellis K.	SAC	17	8	3	2911	6	11	0	0	3	7	2	3	7	1	7	4	3	2	1	0	0
07.01.2025 03:00	35	Murray K.	SAC	14	12	1	2608	5	10	0	0	4	6	0	0	16	5	7	2	0	0	1	0	0
07.01.2025 03:00	36	Huerter K.	SAC	7	2	1	909	3	8	0	0	1	4	0	0	-14	0	2	1	1	1	0	0	0
07.01.2025 03:00	37	Lyles T.	SAC	6	6	1	1405	2	8	0	0	1	5	1	2	-20	2	4	0	0	1	0	0	0
07.01.2025 03:00	38	Carter D.	SAC	5	4	3	569	2	4	0	0	0	1	1	2	-2	2	2	1	0	0	2	0	0
07.01.2025 03:00	39	Len A.	SAC	0	2	0	144	0	0	0	0	0	0	0	0	2	1	1	1	0	1	0	0	0
07.01.2025 03:00	40	McDermott D.	SAC	0	0	0	98	0	0	0	0	0	0	0	0	-6	0	0	0	0	0	0	0	0
06.01.2025 01:30	41	Monk M.	SAC	26	3	12	1752	9	14	0	0	5	8	3	3	41	0	3	3	4	4	1	0	0
06.01.2025 01:30	42	Sabonis D.	SAC	22	13	7	1791	10	13	0	0	1	2	1	2	36	3	10	3	0	0	0	0	0
06.01.2025 01:30	43	Huerter K.	SAC	16	1	0	1194	5	7	0	0	4	6	2	2	3	0	1	0	2	1	0	0	0
06.01.2025 01:30	44	Carter D.	SAC	13	7	2	1407	4	11	0	0	2	7	3	4	9	1	6	1	1	2	0	0	0
06.01.2025 01:30	45	DeRozan D.	SAC	12	0	1	1883	5	14	0	0	0	4	2	2	17	0	0	2	1	3	0	0	0
06.01.2025 01:30	46	Ellis K.	SAC	11	1	2	1468	3	7	0	0	1	3	4	4	19	0	1	1	2	0	0	0	0
06.01.2025 01:30	47	Murray K.	SAC	11	4	2	1575	4	11	0	0	3	8	0	0	10	2	2	3	1	0	1	0	0
06.01.2025 01:30	48	Lyles T.	SAC	7	9	1	1453	1	3	0	0	1	2	4	4	33	2	7	3	2	2	0	0	0
06.01.2025 01:30	49	McDermott D.	SAC	6	0	1	399	2	2	0	0	2	2	0	0	-2	0	0	2	0	1	0	0	0
06.01.2025 01:30	50	Robinson O.	SAC	3	2	0	399	1	2	0	0	0	0	1	1	-2	0	2	0	1	1	0	0	0
06.01.2025 01:30	51	Len A.	SAC	2	2	1	576	1	1	0	0	0	0	0	0	-11	1	1	0	0	0	1	0	0
06.01.2025 01:30	52	McLaughlin J.	SAC	0	1	2	503	0	2	0	0	0	1	0	0	-3	1	0	1	1	1	0	0	0
04.01.2025 03:00	53	Monk M.	SAC	31	2	6	2001	11	20	0	0	6	12	3	3	4	0	2	2	1	2	0	0	0
04.01.2025 03:00	54	DeRozan D.	SAC	29	3	5	2269	10	18	0	0	4	7	5	7	10	1	2	4	0	1	1	0	0
04.01.2025 03:00	55	Fox D.	SAC	23	3	5	2389	7	23	0	0	1	8	8	9	2	0	3	4	3	1	0	0	0
04.01.2025 03:00	56	Sabonis D.	SAC	17	10	6	2286	6	11	0	0	3	6	2	2	6	3	7	5	0	1	2	0	0
04.01.2025 03:00	57	Lyles T.	SAC	16	6	1	1322	6	6	0	0	4	4	0	0	6	1	5	1	1	1	2	0	0
04.01.2025 03:00	58	Ellis K.	SAC	13	4	3	2034	5	11	0	0	2	5	1	2	9	2	2	4	3	2	1	0	0
04.01.2025 03:00	59	Huerter K.	SAC	5	3	4	857	2	5	0	0	1	3	0	0	-3	2	1	0	1	1	1	0	0
04.01.2025 03:00	60	Len A.	SAC	4	1	0	594	2	2	0	0	0	0	0	0	-1	1	0	1	1	0	1	0	0
04.01.2025 03:00	61	Carter D.	SAC	0	5	2	648	0	3	0	0	0	2	0	0	-8	0	5	2	0	0	0	0	0
02.01.2025 03:00	62	Fox D.	SAC	35	3	4	2251	13	16	0	0	2	4	7	8	12	0	3	3	0	3	1	0	0
02.01.2025 03:00	63	Monk M.	SAC	20	2	6	1933	5	12	0	0	0	5	10	10	15	0	2	3	1	2	0	0	0
02.01.2025 03:00	64	DeRozan D.	SAC	18	5	1	1895	7	14	0	0	0	1	4	4	-5	1	4	0	2	1	0	0	0
02.01.2025 03:00	65	Sabonis D.	SAC	17	21	7	2201	8	14	0	0	0	0	1	2	13	9	12	3	0	7	0	0	0
02.01.2025 03:00	66	Lyles T.	SAC	12	7	2	1865	4	9	0	0	4	8	0	0	2	0	7	0	2	2	0	0	0
02.01.2025 03:00	67	Ellis K.	SAC	9	1	2	2266	3	8	0	0	3	8	0	0	17	1	0	1	4	0	2	0	0
02.01.2025 03:00	68	Huerter K.	SAC	2	5	0	1100	1	8	0	0	0	3	0	0	-11	2	3	3	0	1	1	0	0
02.01.2025 03:00	69	Len A.	SAC	0	1	2	337	0	1	0	0	0	0	0	0	-12	1	0	1	1	0	0	0	0
02.01.2025 03:00	70	McDermott D.	SAC	0	0	0	552	0	2	0	0	0	2	0	0	-1	0	0	0	1	1	0	0	0
31.12.2024 03:00	71	Fox D.	SAC	33	6	6	2113	13	23	0	0	3	7	4	5	17	2	4	5	1	1	0	0	1
31.12.2024 03:00	72	Sabonis D.	SAC	17	16	7	2005	8	16	0	0	0	1	1	2	-6	7	9	3	1	2	0	0	0
31.12.2024 03:00	73	DeRozan D.	SAC	14	4	2	1530	6	13	0	0	1	2	1	1	-1	0	4	4	0	1	0	0	0
31.12.2024 03:00	74	Lyles T.	SAC	14	4	1	1307	5	9	0	0	3	6	1	1	31	1	3	1	1	0	0	0	1
31.12.2024 03:00	75	Monk M.	SAC	14	7	6	2137	4	14	0	0	1	6	5	6	7	2	5	4	1	6	0	0	0
31.12.2024 03:00	76	Ellis K.	SAC	7	5	0	1199	1	5	0	0	1	3	4	4	-4	1	4	1	2	3	0	0	0
31.12.2024 03:00	77	Len A.	SAC	4	8	0	434	2	7	0	0	0	0	0	0	0	5	3	1	0	0	0	0	0
31.12.2024 03:00	78	Murray K.	SAC	4	6	1	2162	2	8	0	0	0	3	0	0	3	0	6	3	2	1	0	0	0
31.12.2024 03:00	79	Huerter K.	SAC	3	2	1	1177	1	5	0	0	1	4	0	0	11	0	2	1	0	0	1	0	0
31.12.2024 03:00	80	Crawford I.	SAC	0	0	0	84	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
31.12.2024 03:00	81	Jones C.	SAC	0	0	0	84	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
31.12.2024 03:00	82	Jones I.	SAC	0	0	0	84	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
31.12.2024 03:00	83	McLaughlin J.	SAC	0	0	1	84	0	0	0	0	0	0	0	0	-2	0	0	0	0	1	0	0	0
29.12.2024 03:30	84	Fox D.	SAC	29	5	12	2339	12	25	0	0	1	9	4	7	-7	1	4	2	4	3	1	0	0
29.12.2024 03:30	85	DeRozan D.	SAC	25	6	7	2473	12	17	0	0	0	2	1	1	-9	2	4	4	1	1	0	0	0
29.12.2024 03:30	86	Monk M.	SAC	20	6	7	1980	7	16	0	0	3	8	3	3	-12	1	5	3	0	1	0	0	0
29.12.2024 03:30	87	Sabonis D.	SAC	14	12	7	1555	6	13	0	0	2	3	0	0	-3	4	8	6	0	1	0	0	0
29.12.2024 03:30	88	Ellis K.	SAC	11	1	1	804	4	4	0	0	3	3	0	0	7	0	1	1	1	0	1	0	0
29.12.2024 03:30	89	Huerter K.	SAC	9	1	3	1453	4	7	0	0	1	4	0	0	1	0	1	2	1	1	0	0	0
29.12.2024 03:30	90	Lyles T.	SAC	6	5	0	1406	2	8	0	0	0	5	2	2	-4	3	2	3	0	1	0	0	0
29.12.2024 03:30	91	Murray K.	SAC	5	3	0	1714	2	7	0	0	1	6	0	0	-15	2	1	3	0	1	0	0	0
29.12.2024 03:30	92	Len A.	SAC	3	0	1	663	1	1	0	0	0	0	1	2	-8	0	0	2	0	0	0	0	0
29.12.2024 03:30	93	Jones C.	SAC	0	0	0	13	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
27.12.2024 03:00	94	Fox D.	SAC	26	6	4	2305	11	25	0	0	2	7	2	3	-13	1	5	4	0	3	2	0	0
27.12.2024 03:00	95	Lyles T.	SAC	20	8	0	1518	5	8	0	0	4	7	6	8	0	1	7	3	0	1	0	0	0
27.12.2024 03:00	96	DeRozan D.	SAC	19	3	4	2171	7	13	0	0	1	3	4	6	-1	0	3	1	0	1	0	0	0
27.12.2024 03:00	97	Monk M.	SAC	15	1	0	1779	5	11	0	0	3	7	2	2	3	0	1	2	1	2	0	0	0
27.12.2024 03:00	98	Murray K.	SAC	11	12	2	2223	4	11	0	0	1	7	2	2	-4	2	10	3	1	1	1	0	0
27.12.2024 03:00	99	Huerter K.	SAC	8	5	3	1383	2	7	0	0	2	6	2	2	4	2	3	1	1	1	1	0	0
27.12.2024 03:00	100	Ellis K.	SAC	5	2	1	817	2	4	0	0	1	2	0	0	-2	1	1	1	0	2	0	0	0
27.12.2024 03:00	101	Len A.	SAC	4	6	4	1362	1	1	0	0	0	0	2	2	-1	1	5	3	0	1	2	0	0
27.12.2024 03:00	102	Jones I.	SAC	3	0	1	196	1	1	0	0	0	0	1	1	-3	0	0	0	0	1	0	0	0
27.12.2024 03:00	103	Jones C.	SAC	2	1	1	646	1	1	0	0	0	0	0	0	12	0	1	2	0	1	0	0	0
22.12.2024 23:00	104	Fox D.	SAC	23	5	7	2119	7	19	0	0	2	6	7	8	-19	1	4	2	1	2	0	0	0
22.12.2024 23:00	105	Sabonis D.	SAC	17	21	4	1877	8	22	0	0	1	4	0	2	-26	8	13	3	1	2	0	0	0
22.12.2024 23:00	106	Monk M.	SAC	14	4	1	1900	6	16	0	0	2	9	0	0	-19	0	4	1	0	4	2	0	0
22.12.2024 23:00	107	Murray K.	SAC	10	4	2	1706	3	9	0	0	1	4	3	3	-12	0	4	0	0	0	1	0	0
22.12.2024 23:00	108	Huerter K.	SAC	8	5	2	1406	3	5	0	0	1	2	1	2	-12	2	3	1	0	0	0	0	0
22.12.2024 23:00	109	Lyles T.	SAC	8	3	1	1168	3	7	0	0	2	4	0	0	-4	1	2	0	0	0	0	0	0
22.12.2024 23:00	110	Ellis K.	SAC	3	0	0	291	1	2	0	0	1	2	0	0	-2	0	0	0	0	1	0	0	0
22.12.2024 23:00	111	McDermott D.	SAC	3	1	0	1081	1	4	0	0	1	4	0	0	-12	1	0	2	1	0	0	0	0
22.12.2024 23:00	112	McLaughlin J.	SAC	3	0	0	291	1	1	0	0	1	1	0	0	-2	0	0	0	0	1	0	0	0
22.12.2024 23:00	113	DeRozan D.	SAC	2	2	2	1688	1	7	0	0	0	1	0	0	-21	1	1	1	0	0	0	0	0
22.12.2024 23:00	114	Jones C.	SAC	2	1	0	291	1	1	0	0	0	0	0	0	-2	0	1	1	0	0	0	0	0
22.12.2024 23:00	115	Jones I.	SAC	2	1	0	291	0	0	0	0	0	0	2	2	-2	1	0	0	0	0	0	0	0
22.12.2024 23:00	116	Robinson O.	SAC	0	0	1	291	0	3	0	0	0	1	0	0	-2	0	0	0	0	0	0	0	0
21.12.2024 23:00	117	Fox D.	SAC	31	5	7	2254	12	17	0	0	3	5	4	4	-11	1	4	3	1	4	0	0	0
21.12.2024 23:00	118	Sabonis D.	SAC	19	19	5	2220	9	19	0	0	0	2	1	3	0	5	14	2	1	0	0	0	0
21.12.2024 23:00	119	DeRozan D.	SAC	12	4	3	2241	4	10	0	0	1	2	3	3	6	2	2	2	2	2	0	0	0
21.12.2024 23:00	120	Murray K.	SAC	10	4	0	1649	3	9	0	0	2	7	2	2	-2	1	3	4	0	1	0	0	0
21.12.2024 23:00	121	Huerter K.	SAC	9	2	0	1357	4	10	0	0	1	7	0	0	0	0	2	2	2	0	0	0	0
21.12.2024 23:00	122	Monk M.	SAC	7	4	8	2146	3	14	0	0	1	8	0	0	5	0	4	4	1	5	1	0	0
21.12.2024 23:00	123	Ellis K.	SAC	5	2	1	847	2	6	0	0	1	4	0	0	-3	0	2	3	2	0	0	0	0
21.12.2024 23:00	124	Jones I.	SAC	3	3	1	660	1	1	0	0	0	0	1	2	-4	1	2	0	0	1	0	0	0
21.12.2024 23:00	125	Lyles T.	SAC	3	3	0	1023	1	4	0	0	1	2	0	0	-9	1	2	0	1	0	0	0	0
21.12.2024 23:00	126	Len A.	SAC	0	0	0	3	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
\.


--
-- Data for Name: sacramento_kings_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.sacramento_kings_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Monk Malik	Lesionado	2025-01-16 11:08:06.790541
\.


--
-- Data for Name: san_antonio_spurs; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.san_antonio_spurs (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	14.07.2024	Portland Trail Blazers	77	San Antonio Spurs	83	18	13	24	22	28	23	22	10
2	15.07.2024	Atlanta Hawks	76	San Antonio Spurs	79	17	20	18	21	21	15	20	23
3	17.07.2024	San Antonio Spurs	90	New Orleans Pelicans	85	21	24	22	23	21	20	19	25
4	20.07.2024	San Antonio Spurs	80	Philadelphia 76ers	96	12	25	26	17	25	17	22	32
5	22.07.2024	San Antonio Spurs	100	Toronto Raptors	89	24	26	19	31	14	19	19	37
6	08.10.2024	San Antonio Spurs	107	Oklahoma City Thunder	112	22	23	40	22	27	31	29	25
7	10.10.2024	San Antonio Spurs	107	Orlando Magic	97	20	29	30	28	34	22	23	18
8	13.10.2024	San Antonio Spurs	126	Utah Jazz	120	27	25	36	38	29	24	38	29
9	16.10.2024	Miami Heat	120	San Antonio Spurs	117	27	32	23	38	21	28	35	33
10	18.10.2024	Houston Rockets	129	San Antonio Spurs	107	31	37	37	24	31	18	32	26
11	25.10.2024	Dallas Mavericks	120	San Antonio Spurs	109	20	27	40	33	22	27	31	29
12	27.10.2024	San Antonio Spurs	109	Houston Rockets	106	38	24	25	22	31	10	28	37
13	29.10.2024	San Antonio Spurs	101	Houston Rockets	106	15	30	30	26	29	33	25	19
14	31.10.2024	Oklahoma City Thunder	105	San Antonio Spurs	93	26	33	23	23	19	25	26	23
15	01.11.2024	Utah Jazz	88	San Antonio Spurs	106	30	23	14	21	19	28	30	29
16	03.11.2024	San Antonio Spurs	113	Minnesota Timberwolves	103	32	30	33	18	32	25	25	21
17	05.11.2024	Los Angeles Clippers	113	San Antonio Spurs	104	14	34	34	31	40	16	30	18
18	07.11.2024	Houston Rockets	127	San Antonio Spurs	100	31	32	31	33	19	19	33	29
19	08.11.2024	San Antonio Spurs	118	Portland Trail Blazers	105	33	23	35	27	27	28	24	26
20	09.11.2024	San Antonio Spurs	110	Utah Jazz	111	22	23	37	28	25	28	29	29
21	12.11.2024	San Antonio Spurs	116	Sacramento Kings	96	22	38	24	32	26	29	16	25
22	14.11.2024	San Antonio Spurs	139	Washington Wizards	130	32	35	41	31	31	36	24	39
23	16.11.2024	San Antonio Spurs	115	Los Angeles Lakers	120	30	30	26	29	31	37	25	27
24	17.11.2024	Dallas Mavericks	110	San Antonio Spurs	93	23	32	38	17	28	23	18	24
25	20.11.2024	San Antonio Spurs	110	Oklahoma City Thunder	104	32	28	33	17	35	22	20	27
26	22.11.2024	San Antonio Spurs	126	Utah Jazz	118	17	34	34	41	32	35	22	29
27	24.11.2024	San Antonio Spurs	104	Golden State Warriors	94	17	21	33	33	29	21	31	13
28	27.11.2024	Utah Jazz	115	San Antonio Spurs	128	35	31	27	22	32	34	30	32
29	28.11.2024	San Antonio Spurs	101	Los Angeles Lakers	119	23	24	30	24	32	26	34	27
30	02.12.2024	Sacramento Kings	125	San Antonio Spurs	127	42	23	32	28	28	30	34	35
31	04.12.2024	Phoenix Suns	104	San Antonio Spurs	93	29	23	23	29	19	20	32	22
32	06.12.2024	San Antonio Spurs	124	Chicago Bulls	139	22	35	40	27	36	37	35	31
33	07.12.2024	San Antonio Spurs	113	Sacramento Kings	140	33	26	27	27	33	36	31	40
34	09.12.2024	San Antonio Spurs	121	New Orleans Pelicans	116	28	43	21	29	34	28	25	29
35	14.12.2024	Portland Trail Blazers	116	San Antonio Spurs	118	25	17	46	28	33	19	28	38
36	16.12.2024	San Antonio Spurs	92	Minnesota Timberwolves	106	19	18	33	22	28	24	24	30
37	20.12.2024\nApós Prol.	San Antonio Spurs	133	Atlanta Hawks	126	36	24	30	30	29	37	21	33
38	22.12.2024	San Antonio Spurs	114	Portland Trail Blazers	94	25	35	27	27	20	24	25	25
39	24.12.2024	Philadelphia 76ers	111	San Antonio Spurs	106	19	29	36	27	20	25	30	31
40	25.12.2024	New York Knicks	117	San Antonio Spurs	114	28	23	37	29	27	31	25	31
41	28.12.2024	Brooklyn Nets	87	San Antonio Spurs	96	22	19	21	25	11	30	33	22
42	30.12.2024	Minnesota Timberwolves	112	San Antonio Spurs	110	25	32	25	30	33	12	37	28
43	01.01. 00:00	San Antonio Spurs	122	Los Angeles Clippers	86	31	32	28	31	17	26	20	23
44	04.01. 02:00	Denver Nuggets	110	San Antonio Spurs	113	30	22	38	20	32	28	27	26
45	05.01. 01:00\nApós Prol.	San Antonio Spurs	111	Denver Nuggets	122	27	28	37	16	30	24	27	27
46	07.01. 01:00	Chicago Bulls	114	San Antonio Spurs	110	20	30	32	32	29	36	30	15
47	09.01. 02:30	Milwaukee Bucks	121	San Antonio Spurs	105	31	34	26	30	27	19	32	27
48	14.01. 03:30	Los Angeles Lakers	102	San Antonio Spurs	126	26	36	27	13	28	25	36	37
49	16.01. 01:00	San Antonio Spurs	115	Memphis Grizzlies	129	30	33	25	27	28	23	43	35
\.


--
-- Data for Name: san_antonio_spurs_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.san_antonio_spurs_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 01:00	1	Castle S.	SAS	26	3	4	1950	9	21	0	0	2	9	6	7	-14	3	0	3	0	1	0	0	0
16.01.2025 01:00	2	Vassell D.	SAS	21	5	3	2031	7	13	0	0	3	6	4	7	-17	1	4	2	2	2	0	0	0
16.01.2025 01:00	3	Johnson K.	SAS	17	4	1	1568	6	12	0	0	1	4	4	4	-10	0	4	0	0	1	0	0	0
16.01.2025 01:00	4	Wembanyama V.	SAS	13	12	2	2223	5	19	0	0	3	10	0	0	-4	0	12	3	2	1	8	0	0
16.01.2025 01:00	5	Barnes H.	SAS	10	5	2	1780	4	7	0	0	2	4	0	2	-5	1	4	1	0	1	0	0	0
16.01.2025 01:00	6	Champagnie J.	SAS	9	4	2	1311	3	6	0	0	3	5	0	0	4	0	4	1	0	1	1	0	0
16.01.2025 01:00	7	Paul C.	SAS	8	5	5	2094	3	6	0	0	1	4	1	1	-6	0	5	5	0	4	0	0	0
16.01.2025 01:00	8	Jones T.	SAS	6	1	3	786	1	2	0	0	1	1	3	4	-8	0	1	0	0	0	0	0	0
16.01.2025 01:00	9	Bassey C.	SAS	5	5	0	657	2	3	0	0	0	0	1	2	-10	2	3	2	1	0	2	0	0
14.01.2025 03:30	10	Castle S.	SAS	23	4	1	2139	10	16	0	0	1	4	2	4	10	1	3	1	2	2	0	0	0
14.01.2025 03:30	11	Vassell D.	SAS	23	6	4	2039	9	18	0	0	5	9	0	0	22	1	5	1	2	2	0	0	0
14.01.2025 03:30	12	Wembanyama V.	SAS	23	8	5	2036	10	17	0	0	2	6	1	2	26	1	7	1	3	1	2	0	0
14.01.2025 03:30	13	Barnes H.	SAS	17	4	3	1938	5	8	0	0	1	2	6	6	20	2	2	2	1	0	0	0	0
14.01.2025 03:30	14	Paul C.	SAS	13	2	10	1735	3	6	0	0	2	4	5	5	14	0	2	4	4	1	0	0	0
14.01.2025 03:30	15	Johnson K.	SAS	10	2	3	1275	4	6	0	0	1	2	1	1	11	1	1	2	1	2	2	0	0
14.01.2025 03:30	16	Bassey C.	SAS	4	9	1	743	2	3	0	0	0	0	0	0	-5	3	6	2	1	2	1	0	0
14.01.2025 03:30	17	Jones T.	SAS	4	2	2	1019	2	5	0	0	0	0	0	0	5	1	1	1	2	0	0	0	0
14.01.2025 03:30	18	Mamukelashvili S.	SAS	4	1	0	126	1	1	0	0	0	0	2	2	5	1	0	0	0	0	0	0	0
14.01.2025 03:30	19	Branham M.	SAS	3	0	0	126	1	1	0	0	1	1	0	0	5	0	0	0	0	0	0	0	0
14.01.2025 03:30	20	Champagnie J.	SAS	2	1	0	997	1	7	0	0	0	6	0	0	-1	1	0	1	0	0	0	0	0
14.01.2025 03:30	21	Collins Z.	SAS	0	1	0	101	0	1	0	0	0	0	0	0	3	0	1	0	0	0	0	0	0
14.01.2025 03:30	22	Wesley B.	SAS	0	1	1	126	0	1	0	0	0	1	0	0	5	0	1	0	0	0	0	0	0
09.01.2025 02:30	23	Johnson K.	SAS	24	11	1	1520	7	15	0	0	2	5	8	9	-17	5	6	0	0	0	0	0	0
09.01.2025 02:30	24	Paul C.	SAS	18	5	7	1759	6	10	0	0	5	6	1	1	-10	2	3	2	1	0	1	0	0
09.01.2025 02:30	25	Barnes H.	SAS	14	2	1	1521	4	9	0	0	2	7	4	4	-8	0	2	1	1	0	0	0	0
09.01.2025 02:30	26	Vassell D.	SAS	11	9	2	1920	4	17	0	0	3	9	0	0	-9	0	9	0	1	2	0	0	0
09.01.2025 02:30	27	Wembanyama V.	SAS	10	10	1	2004	4	10	0	0	2	6	0	0	-7	4	6	4	2	3	3	0	0
09.01.2025 02:30	28	Champagnie J.	SAS	9	3	1	1603	3	11	0	0	3	9	0	0	-26	0	3	2	0	1	0	0	0
09.01.2025 02:30	29	Mamukelashvili S.	SAS	7	0	0	334	2	5	0	0	1	3	2	3	1	0	0	1	1	0	0	0	0
09.01.2025 02:30	30	Castle S.	SAS	5	0	5	1485	2	12	0	0	0	5	1	2	3	0	0	1	0	1	0	0	0
09.01.2025 02:30	31	Bassey C.	SAS	4	2	0	766	2	3	0	0	0	0	0	0	-9	1	1	2	1	0	1	0	0
09.01.2025 02:30	32	Jones T.	SAS	3	2	5	984	1	2	0	0	0	1	1	1	-10	0	2	1	1	0	0	0	0
09.01.2025 02:30	33	Branham M.	SAS	0	0	0	168	0	0	0	0	0	0	0	0	4	0	0	0	0	0	0	0	0
09.01.2025 02:30	34	Collins Z.	SAS	0	0	1	168	0	1	0	0	0	1	0	0	4	0	0	0	0	1	0	0	0
09.01.2025 02:30	35	Wesley B.	SAS	0	2	0	168	0	0	0	0	0	0	0	0	4	0	2	0	0	1	0	0	0
07.01.2025 01:00	36	Wembanyama V.	SAS	23	14	4	2073	9	22	0	0	4	11	1	2	-6	2	12	3	0	5	8	0	0
07.01.2025 01:00	37	Paul C.	SAS	18	6	9	1962	7	13	0	0	2	6	2	2	-7	1	5	3	0	1	0	0	0
07.01.2025 01:00	38	Champagnie J.	SAS	12	4	0	975	4	9	0	0	4	9	0	0	0	1	3	1	0	0	0	0	0
07.01.2025 01:00	39	Johnson K.	SAS	11	3	1	1307	5	10	0	0	1	4	0	2	-1	1	2	2	1	1	0	0	0
07.01.2025 01:00	40	Sochan J.	SAS	11	4	2	1600	5	7	0	0	1	3	0	0	-2	3	1	1	1	2	1	0	0
07.01.2025 01:00	41	Vassell D.	SAS	11	4	5	2018	5	14	0	0	1	7	0	0	-5	0	4	0	2	4	3	0	0
07.01.2025 01:00	42	Barnes H.	SAS	10	4	2	1778	3	8	0	0	1	4	3	4	-6	1	3	1	1	0	0	0	0
07.01.2025 01:00	43	Castle S.	SAS	10	1	6	1131	4	9	0	0	1	2	1	2	3	1	0	3	1	2	0	0	0
07.01.2025 01:00	44	Bassey C.	SAS	2	5	0	807	1	2	0	0	0	0	0	0	2	1	4	3	0	1	0	0	0
07.01.2025 01:00	45	Jones T.	SAS	2	4	2	749	1	1	0	0	0	0	0	0	2	2	2	1	2	1	0	0	0
05.01.2025 01:00	46	Barnes H.	SAS	22	1	3	1953	8	14	0	0	4	8	2	2	-9	0	1	4	0	0	1	0	0
05.01.2025 01:00	47	Wembanyama V.	SAS	20	23	3	2340	7	19	0	0	2	12	4	4	0	0	23	4	1	4	4	0	0
05.01.2025 01:00	48	Vassell D.	SAS	19	8	3	2311	8	20	0	0	1	6	2	2	-12	4	4	0	1	4	0	0	0
05.01.2025 01:00	49	Castle S.	SAS	10	1	3	945	4	10	0	0	1	4	1	1	-4	0	1	1	0	0	0	0	0
05.01.2025 01:00	50	Champagnie J.	SAS	10	3	1	1363	2	5	0	0	2	3	4	5	-7	1	2	0	0	1	0	0	0
05.01.2025 01:00	51	Johnson K.	SAS	10	8	1	1633	3	8	0	0	1	5	3	4	-14	4	4	2	0	1	1	0	0
05.01.2025 01:00	52	Jones T.	SAS	9	1	6	1092	4	6	0	0	1	2	0	0	1	0	1	3	0	0	0	0	0
05.01.2025 01:00	53	Sochan J.	SAS	5	8	0	1547	2	4	0	0	1	2	0	0	3	2	6	1	1	0	0	0	0
05.01.2025 01:00	54	Collins Z.	SAS	4	4	0	622	2	8	0	0	0	3	0	0	-9	1	3	3	0	0	0	0	1
05.01.2025 01:00	55	Paul C.	SAS	2	0	8	1876	1	9	0	0	0	3	0	0	-2	0	0	1	0	2	1	0	0
05.01.2025 01:00	56	Bassey C.	SAS	0	1	0	218	0	1	0	0	0	0	0	0	-2	1	0	1	0	0	0	0	0
04.01.2025 02:00	57	Wembanyama V.	SAS	35	18	4	2005	14	22	0	0	4	6	3	4	17	3	15	5	1	7	2	0	0
04.01.2025 02:00	58	Vassell D.	SAS	18	6	6	2173	7	16	0	0	1	4	3	6	-18	1	5	0	2	0	0	0	0
04.01.2025 02:00	59	Johnson K.	SAS	16	4	1	1587	6	14	0	0	3	6	1	1	5	2	2	0	0	1	0	0	0
04.01.2025 02:00	60	Champagnie J.	SAS	15	4	0	1500	6	11	0	0	3	6	0	0	-6	2	2	1	0	1	0	0	0
04.01.2025 02:00	61	Barnes H.	SAS	8	4	3	1911	4	10	0	0	0	3	0	0	10	1	3	0	0	1	0	0	0
04.01.2025 02:00	62	Castle S.	SAS	8	3	4	1469	3	8	0	0	1	4	1	2	18	1	2	2	0	1	0	0	0
04.01.2025 02:00	63	Paul C.	SAS	7	8	11	1874	3	11	0	0	1	6	0	0	-6	0	8	1	0	1	0	0	0
04.01.2025 02:00	64	Collins Z.	SAS	4	5	0	875	2	5	0	0	0	1	0	0	-14	3	2	5	1	0	1	0	0
04.01.2025 02:00	65	Jones T.	SAS	2	4	2	1006	1	2	0	0	0	0	0	0	9	1	3	1	0	1	0	0	0
01.01.2025 00:00	66	Wembanyama V.	SAS	27	9	5	1541	10	18	0	0	1	6	6	7	22	1	8	3	1	2	3	0	0
01.01.2025 00:00	67	Johnson K.	SAS	17	6	1	1140	7	11	0	0	1	4	2	2	15	1	5	0	0	1	0	0	0
01.01.2025 00:00	68	Castle S.	SAS	15	4	4	1390	5	8	0	0	0	3	5	6	18	0	4	2	1	1	1	0	0
01.01.2025 00:00	69	Barnes H.	SAS	11	4	1	1485	4	9	0	0	3	4	0	0	22	2	2	1	0	0	0	0	0
01.01.2025 00:00	70	Champagnie J.	SAS	9	2	1	961	3	8	0	0	2	6	1	1	16	1	1	0	0	1	1	0	0
01.01.2025 00:00	71	Vassell D.	SAS	8	3	3	1584	4	14	0	0	0	6	0	0	20	0	3	2	3	0	0	0	0
01.01.2025 00:00	72	Collins Z.	SAS	7	4	4	1004	2	5	0	0	0	2	3	3	14	3	1	1	1	0	0	0	0
01.01.2025 00:00	73	Paul C.	SAS	7	9	4	1209	3	5	0	0	1	2	0	0	19	2	7	1	3	0	0	0	0
01.01.2025 00:00	74	Branham M.	SAS	5	1	0	442	2	4	0	0	1	3	0	0	0	0	1	1	0	0	0	0	0
01.01.2025 00:00	75	Mamukelashvili S.	SAS	4	4	1	472	2	3	0	0	0	1	0	0	2	0	4	1	0	0	1	0	0
01.01.2025 00:00	76	Sochan J.	SAS	4	5	2	913	2	5	0	0	0	1	0	0	14	2	3	1	1	1	0	0	0
01.01.2025 00:00	77	Bassey C.	SAS	2	3	2	335	1	3	0	0	0	0	0	0	0	1	2	1	0	1	0	0	0
01.01.2025 00:00	78	Cissoko S.	SAS	2	0	1	335	1	2	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0
01.01.2025 00:00	79	Jones T.	SAS	2	4	4	1076	1	2	0	0	0	1	0	0	14	2	2	1	0	2	0	0	0
01.01.2025 00:00	80	Wesley B.	SAS	2	0	4	513	1	1	0	0	0	0	0	0	4	0	0	0	0	0	1	0	0
30.12.2024 02:00	81	Wembanyama V.	SAS	34	8	2	2201	13	30	0	0	4	12	4	5	5	2	6	0	1	1	2	0	0
30.12.2024 02:00	82	Barnes H.	SAS	24	5	0	2024	8	9	0	0	3	4	5	5	14	2	3	2	0	0	0	0	0
30.12.2024 02:00	83	Vassell D.	SAS	22	7	4	2177	8	14	0	0	3	7	3	4	5	2	5	1	0	0	0	0	0
30.12.2024 02:00	84	Johnson K.	SAS	13	6	0	1049	5	11	0	0	0	5	3	6	-17	0	6	0	0	0	0	0	0
30.12.2024 02:00	85	Paul C.	SAS	6	5	14	2089	0	6	0	0	0	4	6	6	13	0	5	2	4	0	0	0	0
30.12.2024 02:00	86	Sochan J.	SAS	5	4	1	2246	2	8	0	0	1	3	0	0	-4	1	3	5	0	3	1	0	0
30.12.2024 02:00	87	Bassey C.	SAS	4	2	0	282	1	1	0	0	0	0	2	2	-4	1	1	2	0	0	0	0	0
30.12.2024 02:00	88	Jones T.	SAS	2	3	2	799	1	2	0	0	0	0	0	0	-9	0	3	1	0	0	0	0	0
30.12.2024 02:00	89	Castle S.	SAS	0	0	1	454	0	1	0	0	0	1	0	0	-12	0	0	1	0	4	0	0	0
30.12.2024 02:00	90	Champagnie J.	SAS	0	1	1	682	0	4	0	0	0	2	0	0	2	0	1	1	1	0	1	0	0
30.12.2024 02:00	91	Collins Z.	SAS	0	0	0	397	0	1	0	0	0	1	0	0	-3	0	0	3	0	1	0	0	0
28.12.2024 00:30	92	Wembanyama V.	SAS	19	7	4	2129	7	14	0	0	3	6	2	2	3	0	7	4	0	3	6	0	0
28.12.2024 00:30	93	Champagnie J.	SAS	18	2	1	1202	6	9	0	0	5	7	1	1	17	0	2	0	2	1	0	0	0
28.12.2024 00:30	94	Johnson K.	SAS	15	6	1	1625	5	11	0	0	1	2	4	4	2	3	3	1	2	2	0	0	0
28.12.2024 00:30	95	Sochan J.	SAS	12	14	3	2030	3	7	0	0	0	1	6	8	-1	3	11	2	0	1	1	0	0
28.12.2024 00:30	96	Vassell D.	SAS	10	6	5	2029	4	16	0	0	2	5	0	0	-2	2	4	0	3	1	1	0	0
28.12.2024 00:30	97	Barnes H.	SAS	9	2	0	1343	3	7	0	0	0	2	3	4	7	1	1	0	1	0	0	0	0
28.12.2024 00:30	98	Castle S.	SAS	6	2	1	1139	2	7	0	0	1	2	1	4	-4	1	1	1	1	2	0	0	0
28.12.2024 00:30	99	Paul C.	SAS	5	2	5	1912	2	6	0	0	0	3	1	2	15	0	2	2	0	1	0	0	0
28.12.2024 00:30	100	Jones T.	SAS	2	2	6	991	0	1	0	0	0	1	2	2	8	1	1	1	1	2	0	0	0
25.12.2024 17:00	101	Wembanyama V.	SAS	42	18	4	2423	16	31	0	0	6	16	4	4	7	2	16	1	1	4	4	0	0
25.12.2024 17:00	102	Sochan J.	SAS	21	9	2	2008	8	10	0	0	3	3	2	2	-12	2	7	4	0	5	0	0	0
25.12.2024 17:00	103	Paul C.	SAS	13	6	7	2184	4	8	0	0	3	6	2	2	6	0	6	1	1	1	0	0	0
25.12.2024 17:00	104	Vassell D.	SAS	11	3	5	2144	4	11	0	0	1	4	2	2	-13	2	1	1	0	4	1	0	0
25.12.2024 17:00	105	Champagnie J.	SAS	9	2	1	1553	3	7	0	0	3	7	0	0	-4	0	2	2	0	0	0	0	0
25.12.2024 17:00	106	Jones T.	SAS	7	1	9	973	3	4	0	0	0	0	1	1	10	0	1	1	1	0	0	0	0
25.12.2024 17:00	107	Castle S.	SAS	6	2	3	1013	2	7	0	0	0	1	2	4	-4	0	2	1	0	0	0	0	0
25.12.2024 17:00	108	Barnes H.	SAS	3	1	1	1039	1	3	0	0	0	1	1	2	-10	1	0	1	0	1	1	0	0
25.12.2024 17:00	109	Johnson K.	SAS	2	3	1	1063	1	2	0	0	0	0	0	0	5	1	2	3	0	0	0	0	0
24.12.2024 00:00	110	Wembanyama V.	SAS	26	9	4	2190	9	19	0	0	6	13	2	2	-5	1	8	2	0	5	8	0	0
24.12.2024 00:00	111	Castle S.	SAS	17	3	1	800	7	9	0	0	1	2	2	2	-3	0	3	4	1	2	0	0	0
24.12.2024 00:00	112	Champagnie J.	SAS	15	8	1	1726	5	10	0	0	5	10	0	0	8	0	8	3	0	3	1	0	0
24.12.2024 00:00	113	Sochan J.	SAS	15	8	3	1917	6	9	0	0	0	1	3	3	-11	1	7	1	0	0	0	0	0
24.12.2024 00:00	114	Vassell D.	SAS	15	5	2	1906	4	11	0	0	1	5	6	7	-17	1	4	4	0	0	1	0	0
24.12.2024 00:00	115	Paul C.	SAS	12	4	8	2080	3	9	0	0	2	5	4	4	-2	0	4	3	1	4	0	0	0
24.12.2024 00:00	116	Johnson K.	SAS	4	1	2	1304	2	6	0	0	0	4	0	0	10	0	1	0	0	1	0	0	0
24.12.2024 00:00	117	Jones T.	SAS	2	0	3	865	1	1	0	0	0	0	0	0	10	0	0	1	2	2	1	0	0
24.12.2024 00:00	118	Barnes H.	SAS	0	1	0	1218	0	5	0	0	0	5	0	0	-10	0	1	1	0	0	0	0	0
24.12.2024 00:00	119	Bassey C.	SAS	0	3	0	394	0	2	0	0	0	0	0	0	-5	0	3	2	0	1	1	0	0
22.12.2024 01:30	120	Wembanyama V.	SAS	30	7	3	1785	8	16	0	0	4	8	10	11	23	3	4	0	0	1	10	0	0
22.12.2024 01:30	121	Bassey C.	SAS	16	12	0	1095	7	9	0	0	0	0	2	2	-3	4	8	1	1	1	0	0	0
22.12.2024 01:30	122	Johnson K.	SAS	11	2	1	1234	5	12	0	0	1	4	0	0	5	0	2	0	0	0	1	0	0
22.12.2024 01:30	123	Vassell D.	SAS	11	4	0	1394	5	10	0	0	0	4	1	1	19	0	4	2	2	1	0	0	0
22.12.2024 01:30	124	Sochan J.	SAS	10	7	5	1445	4	10	0	0	0	3	2	2	21	3	4	0	1	1	1	0	0
22.12.2024 01:30	125	Barnes H.	SAS	9	3	1	1339	3	6	0	0	2	3	1	2	11	2	1	0	0	2	0	0	0
22.12.2024 01:30	126	Castle S.	SAS	8	4	5	1213	4	10	0	0	0	2	0	0	19	0	4	2	1	2	0	0	0
22.12.2024 01:30	127	Champagnie J.	SAS	7	3	0	1428	3	7	0	0	1	4	0	0	7	0	3	3	1	3	0	0	0
22.12.2024 01:30	128	Paul C.	SAS	6	4	9	1579	2	6	0	0	2	5	0	0	13	0	4	1	0	0	0	0	0
22.12.2024 01:30	129	Jones T.	SAS	4	3	7	1084	2	2	0	0	0	0	0	0	9	0	3	1	1	0	1	0	0
22.12.2024 01:30	130	Cissoko S.	SAS	2	0	0	201	1	2	0	0	0	1	0	0	-6	0	0	1	0	0	0	0	0
22.12.2024 01:30	131	Branham M.	SAS	0	0	1	201	0	1	0	0	0	1	0	0	-6	0	0	0	0	1	0	0	0
22.12.2024 01:30	132	Mamukelashvili S.	SAS	0	0	0	201	0	1	0	0	0	1	0	0	-6	0	0	0	0	0	0	0	0
22.12.2024 01:30	133	Wesley B.	SAS	0	0	1	201	0	1	0	0	0	0	0	0	-6	0	0	1	0	0	0	0	0
\.


--
-- Data for Name: san_antonio_spurs_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.san_antonio_spurs_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Sochan Jeremy	Lesionado	2025-01-17 13:55:21.614263
2	Minix Riley	Lesionado	2025-01-17 13:55:21.616612
\.


--
-- Data for Name: toronto_raptors; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.toronto_raptors (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	14.07.2024	Toronto Raptors	94	Oklahoma City Thunder	69	30	18	14	32	10	17	23	19
2	15.07.2024	Toronto Raptors	84	Denver Nuggets	81	20	17	28	19	24	19	20	18
3	17.07.2024	Utah Jazz	86	Toronto Raptors	76	19	23	26	18	21	10	20	25
4	20.07.2024	Miami Heat	109	Toronto Raptors	73	32	29	26	22	7	17	25	24
5	22.07.2024	San Antonio Spurs	100	Toronto Raptors	89	24	26	19	31	14	19	19	37
6	07.10.2024	Toronto Raptors	125	Washington Wizards	98	34	22	35	34	16	22	36	24
7	12.10.2024	Washington Wizards	113	Toronto Raptors	95	18	30	34	31	25	22	32	16
8	14.10.2024	Boston Celtics	115	Toronto Raptors	111	41	28	22	24	20	17	32	42
9	16.10.2024	Toronto Raptors	119	Boston Celtics	118	46	20	31	22	27	40	19	32
10	19.10.2024	Brooklyn Nets	112	Toronto Raptors	116	30	20	29	33	31	22	38	25
11	24.10.2024	Toronto Raptors	106	Cleveland Cavaliers	136	32	17	30	27	33	36	36	31
12	26.10.2024	Toronto Raptors	115	Philadelphia 76ers	107	30	32	21	32	31	25	21	30
13	27.10.2024	Minnesota Timberwolves	112	Toronto Raptors	101	32	24	33	23	18	26	28	29
14	28.10.2024\nApós Prol.	Toronto Raptors	125	Denver Nuggets	127	30	32	26	26	29	25	29	31
15	30.10.2024	Charlotte Hornets	138	Toronto Raptors	133	30	34	39	35	16	43	37	37
16	01.11.2024	Toronto Raptors	125	Los Angeles Lakers	131	19	32	37	37	43	33	23	32
17	02.11.2024\nApós Prol.	Toronto Raptors	131	Sacramento Kings	128	37	29	30	24	29	34	23	34
18	05.11.2024	Denver Nuggets	121	Toronto Raptors	119	34	25	29	33	37	27	29	26
19	07.11.2024	Sacramento Kings	122	Toronto Raptors	107	30	27	32	33	33	21	39	14
20	10.11.2024	Los Angeles Clippers	105	Toronto Raptors	103	28	24	29	24	22	25	23	33
21	11.11.2024	Los Angeles Lakers	123	Toronto Raptors	103	26	27	35	35	34	21	27	21
22	13.11.2024	Milwaukee Bucks	99	Toronto Raptors	85	26	28	27	18	21	22	24	18
23	16.11.2024	Toronto Raptors	95	Detroit Pistons	99	27	25	26	17	32	23	18	26
24	17.11.2024\nApós Prol.	Boston Celtics	126	Toronto Raptors	123	28	28	30	28	26	28	31	29
25	19.11.2024	Toronto Raptors	130	Indiana Pacers	119	34	35	27	34	27	30	25	37
26	22.11.2024	Toronto Raptors	110	Minnesota Timberwolves	105	32	20	25	33	27	24	28	26
27	25.11.2024	Cleveland Cavaliers	122	Toronto Raptors	108	38	27	31	26	22	33	35	18
28	26.11.2024	Detroit Pistons	102	Toronto Raptors	100	29	19	24	30	22	26	32	20
29	28.11.2024	New Orleans Pelicans	93	Toronto Raptors	119	20	26	17	30	21	35	31	32
30	30.11.2024	Miami Heat	121	Toronto Raptors	111	20	38	38	25	21	40	23	27
31	01.12.2024	Toronto Raptors	119	Miami Heat	116	34	31	33	21	24	36	27	29
32	04.12.2024	Toronto Raptors	122	Indiana Pacers	111	31	34	28	29	23	25	36	27
33	06.12.2024	Toronto Raptors	92	Oklahoma City Thunder	129	17	25	23	27	34	33	32	30
34	08.12.2024	Toronto Raptors	118	Dallas Mavericks	125	28	26	33	31	35	35	30	25
35	10.12.2024	Toronto Raptors	108	New York Knicks	113	27	34	25	22	34	26	23	30
36	13.12.2024	Miami Heat	114	Toronto Raptors	104	23	35	31	25	27	24	25	28
37	17.12.2024	Toronto Raptors	121	Chicago Bulls	122	25	25	34	37	33	20	42	27
38	20.12.2024	Toronto Raptors	94	Brooklyn Nets	101	24	22	30	18	24	28	18	31
39	22.12.2024	Toronto Raptors	110	Houston Rockets	114	35	22	26	27	24	27	33	30
40	24.12.2024	New York Knicks	139	Toronto Raptors	125	30	40	41	28	28	24	30	43
41	27.12.2024	Memphis Grizzlies	155	Toronto Raptors	126	43	35	43	34	35	35	30	26
42	29.12.2024	Toronto Raptors	107	Atlanta Hawks	136	25	33	24	25	35	29	40	32
43	31.12.2024	Boston Celtics	125	Toronto Raptors	71	23	22	45	35	12	23	18	18
44	02.01. 00:30	Toronto Raptors	130	Brooklyn Nets	113	26	39	29	36	33	31	27	22
45	04.01. 00:30	Toronto Raptors	97	Orlando Magic	106	24	26	18	29	37	25	26	18
46	07.01. 00:30	Toronto Raptors	104	Milwaukee Bucks	128	19	28	28	29	28	38	33	29
47	09.01. 00:30	New York Knicks	112	Toronto Raptors	98	28	27	31	26	24	27	25	22
48	10.01. 00:00	Cleveland Cavaliers	132	Toronto Raptors	126	27	34	37	34	33	28	42	23
49	12.01. 00:00	Detroit Pistons	123	Toronto Raptors	114	32	33	34	24	32	34	27	21
50	14.01. 00:30	Toronto Raptors	104	Golden State Warriors	101	28	24	23	29	26	24	28	23
51	16.01. 00:30	Toronto Raptors	110	Boston Celtics	97	25	30	33	22	29	24	29	15
\.


--
-- Data for Name: toronto_raptors_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.toronto_raptors_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 00:30	1	Barrett R.	TOR	22	10	8	2140	10	18	0	0	1	5	1	4	8	2	8	2	1	2	1	0	0
16.01.2025 00:30	2	Barnes S.	TOR	18	3	9	2148	8	16	0	0	1	5	1	2	11	1	2	1	1	2	2	0	0
16.01.2025 00:30	3	Poeltl J.	TOR	16	11	2	1844	8	8	0	0	0	0	0	0	7	3	8	0	0	0	1	0	0
16.01.2025 00:30	4	Dick G.	TOR	12	3	4	1521	4	9	0	0	2	6	2	2	5	0	3	2	0	1	0	0	0
16.01.2025 00:30	5	Mitchell D.	TOR	10	4	5	1572	4	6	0	0	2	2	0	1	16	0	4	3	2	1	0	0	1
16.01.2025 00:30	6	Shead J.	TOR	8	0	1	916	3	6	0	0	2	4	0	0	2	0	0	2	0	3	0	0	0
16.01.2025 00:30	7	Brown B.	TOR	7	7	0	1247	3	9	0	0	0	2	1	2	2	4	3	4	0	0	0	0	0
16.01.2025 00:30	8	Olynyk K.	TOR	7	3	4	1036	1	3	0	0	1	1	4	4	6	1	2	2	0	0	0	0	0
16.01.2025 00:30	9	Agbaji O.	TOR	5	4	1	739	2	5	0	0	1	3	0	0	-9	1	3	1	0	0	0	0	0
16.01.2025 00:30	10	Boucher C.	TOR	5	9	0	991	2	7	0	0	1	4	0	0	13	1	8	2	0	1	0	0	0
16.01.2025 00:30	11	Battle J.	TOR	0	2	1	246	0	2	0	0	0	2	0	0	4	0	2	0	0	0	0	0	0
14.01.2025 00:30	12	Barnes S.	TOR	23	8	6	2426	9	21	0	0	1	4	4	6	12	2	6	1	2	3	2	0	0
14.01.2025 00:30	13	Boucher C.	TOR	18	7	2	1313	7	9	0	0	3	5	1	2	1	4	3	1	0	0	1	0	0
14.01.2025 00:30	14	Barrett R.	TOR	15	4	5	1578	6	14	0	0	1	3	2	3	6	0	4	3	0	3	0	0	0
14.01.2025 00:30	15	Poeltl J.	TOR	13	13	2	2081	6	11	0	0	0	0	1	2	14	5	8	3	0	2	1	0	0
14.01.2025 00:30	16	Agbaji O.	TOR	12	3	0	1496	5	8	0	0	2	5	0	0	5	1	2	0	0	0	2	0	0
14.01.2025 00:30	17	Dick G.	TOR	12	3	1	1383	4	10	0	0	2	6	2	2	-10	1	2	1	0	1	0	0	0
14.01.2025 00:30	18	Shead J.	TOR	9	1	2	1071	3	6	0	0	3	4	0	0	2	1	0	3	0	1	0	0	0
14.01.2025 00:30	19	Olynyk K.	TOR	2	2	2	633	1	2	0	0	0	0	0	0	-10	0	2	1	0	1	1	0	0
14.01.2025 00:30	20	Brown B.	TOR	0	3	2	823	0	2	0	0	0	1	0	0	-2	0	3	1	1	3	2	0	0
14.01.2025 00:30	21	Mitchell D.	TOR	0	0	6	1596	0	3	0	0	0	1	0	0	-3	0	0	4	0	0	0	0	0
12.01.2025 00:00	22	Quickley I.	TOR	25	2	2	1903	7	20	0	0	4	9	7	7	-24	0	2	0	1	2	0	0	0
12.01.2025 00:00	23	Barnes S.	TOR	16	12	3	2261	5	14	0	0	1	4	5	6	-8	3	9	2	2	1	2	0	0
12.01.2025 00:00	24	Boucher C.	TOR	14	3	1	1199	5	6	0	0	4	5	0	0	4	1	2	1	0	0	0	0	0
12.01.2025 00:00	25	Brown B.	TOR	14	5	3	1176	6	9	0	0	2	2	0	0	2	2	3	1	2	1	0	0	0
12.01.2025 00:00	26	Dick G.	TOR	13	3	2	1771	4	11	0	0	4	8	1	1	-9	1	2	3	0	1	0	0	0
12.01.2025 00:00	27	Barrett R.	TOR	10	6	3	1968	4	16	0	0	0	8	2	6	-17	1	5	4	2	5	0	0	0
12.01.2025 00:00	28	Shead J.	TOR	10	0	5	1011	3	3	0	0	1	1	3	3	17	0	0	2	2	0	0	0	0
12.01.2025 00:00	29	Poeltl J.	TOR	8	12	3	2023	4	10	0	0	0	0	0	4	-10	5	7	3	3	1	1	0	0
12.01.2025 00:00	30	Olynyk K.	TOR	4	2	5	857	2	3	0	0	0	1	0	0	1	2	0	3	0	1	0	0	0
12.01.2025 00:00	31	Walter J.	TOR	0	0	0	231	0	0	0	0	0	0	0	0	-1	0	0	2	0	0	0	0	0
10.01.2025 00:00	32	Barnes S.	TOR	24	10	8	2269	11	20	0	0	0	2	2	4	-7	2	8	3	3	3	0	0	0
10.01.2025 00:00	33	Boucher C.	TOR	23	12	0	1602	9	14	0	0	5	8	0	0	10	3	9	1	1	0	1	0	0
10.01.2025 00:00	34	Barrett R.	TOR	20	5	5	2270	8	15	0	0	2	6	2	3	-15	0	5	2	2	4	0	0	1
10.01.2025 00:00	35	Poeltl J.	TOR	17	7	6	2028	8	10	0	0	0	0	1	4	0	3	4	2	3	0	1	0	0
10.01.2025 00:00	36	Shead J.	TOR	15	0	3	876	6	7	0	0	3	3	0	0	4	0	0	1	0	1	0	0	0
10.01.2025 00:00	37	Dick G.	TOR	11	1	1	1280	5	9	0	0	1	3	0	0	-1	0	1	2	0	1	0	0	0
10.01.2025 00:00	38	Quickley I.	TOR	10	0	7	1820	4	10	0	0	2	6	0	0	-13	0	0	3	0	2	0	0	0
10.01.2025 00:00	39	Walter J.	TOR	4	0	1	924	1	2	0	0	1	2	1	2	5	0	0	2	0	0	0	0	0
10.01.2025 00:00	40	Mitchell D.	TOR	2	2	2	948	1	2	0	0	0	1	0	0	-13	1	1	0	0	0	0	0	0
10.01.2025 00:00	41	Olynyk K.	TOR	0	0	1	383	0	0	0	0	0	0	0	0	0	0	0	1	0	1	0	0	0
09.01.2025 00:30	42	Quickley I.	TOR	22	3	5	1880	7	12	0	0	3	6	5	6	7	0	3	0	1	2	1	0	0
09.01.2025 00:30	43	Barnes S.	TOR	18	5	5	2141	7	15	0	0	2	3	2	2	-13	1	4	2	0	1	4	0	0
09.01.2025 00:30	44	Barrett R.	TOR	16	5	2	1701	7	15	0	0	1	4	1	2	-18	3	2	4	1	2	1	0	0
09.01.2025 00:30	45	Boucher C.	TOR	10	0	0	238	4	4	0	0	2	2	0	0	11	0	0	0	1	0	0	0	0
09.01.2025 00:30	46	Poeltl J.	TOR	8	10	3	1810	4	6	0	0	0	0	0	0	-19	2	8	3	1	4	0	0	0
09.01.2025 00:30	47	Olynyk K.	TOR	7	4	0	1064	3	4	0	0	0	1	1	1	5	1	3	1	1	1	0	0	0
09.01.2025 00:30	48	Agbaji O.	TOR	4	0	1	523	2	2	0	0	0	0	0	0	-5	0	0	0	1	0	0	0	0
09.01.2025 00:30	49	Brown B.	TOR	4	1	0	1275	2	5	0	0	0	1	0	0	-16	0	1	1	0	1	0	0	0
09.01.2025 00:30	50	Shead J.	TOR	4	0	4	981	1	3	0	0	1	2	1	2	-21	0	0	1	0	2	0	0	0
09.01.2025 00:30	51	Dick G.	TOR	3	4	2	1214	1	6	0	0	1	4	0	0	-8	0	4	2	0	3	0	0	0
09.01.2025 00:30	52	Temple G.	TOR	2	0	2	238	0	0	0	0	0	0	2	2	11	0	0	0	1	0	0	0	0
09.01.2025 00:30	53	Mitchell D.	TOR	0	0	0	25	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
09.01.2025 00:30	54	Walter J.	TOR	0	1	1	1310	0	5	0	0	0	3	0	0	-4	1	0	1	2	0	0	0	0
07.01.2025 00:30	55	Barrett R.	TOR	25	9	5	1941	11	18	0	0	2	5	1	4	-19	3	6	0	1	1	0	0	0
07.01.2025 00:30	56	Barnes S.	TOR	21	2	5	1926	10	18	0	0	0	4	1	2	-24	1	1	2	2	5	1	0	0
07.01.2025 00:30	57	Poeltl J.	TOR	12	7	1	1884	6	9	0	0	0	0	0	1	-30	0	7	1	1	1	1	0	0
07.01.2025 00:30	58	Dick G.	TOR	11	3	3	1637	3	12	0	0	3	9	2	2	-15	1	2	2	0	1	1	0	0
07.01.2025 00:30	59	Quickley I.	TOR	11	1	3	1798	3	10	0	0	1	5	4	4	-26	0	1	2	2	2	0	0	0
07.01.2025 00:30	60	Walter J.	TOR	8	2	1	675	3	5	0	0	2	3	0	1	3	1	1	0	0	3	0	0	0
07.01.2025 00:30	61	Mogbo J.	TOR	5	1	0	396	1	1	0	0	1	1	2	2	5	1	0	2	0	0	0	0	0
07.01.2025 00:30	62	Brown B.	TOR	3	3	0	1018	1	3	0	0	0	1	1	1	-8	1	2	2	1	1	0	0	0
07.01.2025 00:30	63	Olynyk K.	TOR	3	1	2	600	1	4	0	0	0	1	1	2	1	0	1	1	1	0	0	0	0
07.01.2025 00:30	64	Shead J.	TOR	3	2	6	1082	1	6	0	0	0	2	1	2	2	1	1	2	2	1	0	0	0
07.01.2025 00:30	65	Agbaji O.	TOR	2	4	1	1443	1	5	0	0	0	4	0	0	-9	1	3	1	1	0	1	0	0
04.01.2025 00:30	66	Poeltl J.	TOR	25	6	2	2010	11	12	0	0	0	0	3	3	-10	2	4	4	1	3	1	0	0
04.01.2025 00:30	67	Barnes S.	TOR	20	9	3	2246	9	19	0	0	2	4	0	2	-3	1	8	1	1	1	0	0	0
04.01.2025 00:30	68	Agbaji O.	TOR	15	3	1	1990	6	9	0	0	3	5	0	0	-7	1	2	1	0	0	0	0	0
04.01.2025 00:30	69	Quickley I.	TOR	11	4	11	2001	4	17	0	0	1	9	2	2	1	0	4	1	0	3	0	0	0
04.01.2025 00:30	70	Dick G.	TOR	8	5	1	1781	2	11	0	0	2	7	2	2	-8	0	5	2	1	1	0	0	0
04.01.2025 00:30	71	Olynyk K.	TOR	6	2	1	870	2	3	0	0	0	0	2	2	1	2	0	2	1	1	0	0	0
04.01.2025 00:30	72	Walter J.	TOR	5	2	0	1102	2	3	0	0	1	2	0	0	-3	0	2	0	0	0	0	0	0
04.01.2025 00:30	73	Mitchell D.	TOR	3	4	2	798	1	2	0	0	1	1	0	0	3	0	4	0	1	0	0	0	0
04.01.2025 00:30	74	Brown B.	TOR	2	1	1	785	0	2	0	0	0	0	2	2	-8	0	1	0	0	0	0	0	0
04.01.2025 00:30	75	Shead J.	TOR	2	1	6	817	1	2	0	0	0	1	0	0	-11	1	0	0	1	2	0	0	0
02.01.2025 00:30	76	Barnes S.	TOR	33	13	5	2282	14	18	0	0	3	4	2	2	14	0	13	3	2	3	1	0	0
02.01.2025 00:30	77	Dick G.	TOR	22	3	2	2193	9	17	0	0	4	8	0	0	22	1	2	1	3	2	0	0	0
02.01.2025 00:30	78	Quickley I.	TOR	21	4	15	1927	7	16	0	0	3	7	4	4	23	0	4	3	0	1	0	0	0
02.01.2025 00:30	79	Agbaji O.	TOR	14	3	2	2231	5	8	0	0	2	2	2	2	23	2	1	3	1	1	2	0	0
02.01.2025 00:30	80	Poeltl J.	TOR	12	9	2	2016	6	10	0	0	0	0	0	0	17	4	5	3	1	0	2	0	0
02.01.2025 00:30	81	Walter J.	TOR	11	3	3	1059	4	6	0	0	2	4	1	2	-4	1	2	1	0	0	0	0	0
02.01.2025 00:30	82	Olynyk K.	TOR	7	2	1	823	3	3	0	0	1	1	0	0	1	0	2	0	0	0	1	0	0
02.01.2025 00:30	83	Shead J.	TOR	7	0	5	1082	3	7	0	0	0	3	1	3	2	0	0	1	1	3	0	0	0
02.01.2025 00:30	84	Boucher C.	TOR	3	1	0	275	1	2	0	0	1	2	0	0	-7	0	1	0	0	0	0	0	0
02.01.2025 00:30	85	Battle J.	TOR	0	0	0	41	0	0	0	0	0	0	0	0	-1	0	0	0	0	0	0	0	0
02.01.2025 00:30	86	Kamka-Chomche U.	TOR	0	0	0	41	0	0	0	0	0	0	0	0	-1	0	0	1	0	0	0	0	0
02.01.2025 00:30	87	Mitchell D.	TOR	0	1	1	389	0	1	0	0	0	1	0	0	-3	0	1	4	0	0	0	0	0
02.01.2025 00:30	88	Mogbo J.	TOR	0	0	0	41	0	0	0	0	0	0	0	0	-1	0	0	0	0	0	0	0	0
31.12.2024 20:00	89	Barnes S.	TOR	16	13	2	1870	7	19	0	0	1	8	1	1	-39	2	11	0	2	6	1	0	0
31.12.2024 20:00	90	Battle J.	TOR	9	3	2	1141	3	8	0	0	3	6	0	0	-20	3	0	2	0	1	0	0	0
31.12.2024 20:00	91	Mitchell D.	TOR	9	2	3	1569	3	4	0	0	2	2	1	2	-18	0	2	2	0	5	0	0	0
31.12.2024 20:00	92	Boucher C.	TOR	7	2	1	866	2	7	0	0	1	4	2	2	-23	0	2	1	1	0	0	0	0
31.12.2024 20:00	93	Poeltl J.	TOR	7	13	3	1782	3	4	0	0	0	0	1	2	-19	4	9	3	2	1	1	0	0
31.12.2024 20:00	94	Brown B.	TOR	6	2	1	1163	2	7	0	0	1	2	1	2	-22	1	1	3	1	0	0	0	0
31.12.2024 20:00	95	Olynyk K.	TOR	5	1	0	589	2	5	0	0	1	2	0	0	-25	1	0	1	0	0	0	0	0
31.12.2024 20:00	96	Shead J.	TOR	5	1	3	1471	2	10	0	0	1	5	0	0	-37	0	1	0	2	3	0	0	0
31.12.2024 20:00	97	Walter J.	TOR	3	2	2	1343	1	10	0	0	0	4	1	2	-26	1	1	1	0	1	1	0	0
31.12.2024 20:00	98	Agbaji O.	TOR	2	3	1	1483	1	7	0	0	0	4	0	0	-17	1	2	1	0	3	1	0	0
31.12.2024 20:00	99	Kamka-Chomche U.	TOR	2	0	0	272	1	1	0	0	0	0	0	0	-7	0	0	1	0	0	0	0	0
31.12.2024 20:00	100	Fernando B.	TOR	0	1	0	237	0	1	0	0	0	0	0	0	-3	0	1	1	0	0	0	0	0
31.12.2024 20:00	101	Lawson A.	TOR	0	1	0	240	0	3	0	0	0	3	0	0	-8	1	0	0	0	0	0	0	0
31.12.2024 20:00	102	Mogbo J.	TOR	0	0	0	374	0	0	0	0	0	0	0	0	-6	0	0	0	0	1	0	0	0
29.12.2024 23:00	103	Barnes S.	TOR	19	8	5	2101	7	12	0	0	0	1	5	5	-34	1	7	1	3	8	0	0	0
29.12.2024 23:00	104	Barrett R.	TOR	17	6	4	1812	5	13	0	0	1	5	6	8	-24	0	6	2	0	3	0	0	0
29.12.2024 23:00	105	Poeltl J.	TOR	13	6	1	1603	5	8	0	0	0	0	3	4	-25	3	3	4	2	4	3	0	0
29.12.2024 23:00	106	Brown B.	TOR	12	3	1	1151	6	12	0	0	0	2	0	0	-6	1	2	1	1	1	0	0	0
29.12.2024 23:00	107	Boucher C.	TOR	9	2	0	733	1	3	0	0	1	2	6	6	1	0	2	1	1	1	0	0	0
29.12.2024 23:00	108	Battle J.	TOR	8	2	0	523	3	6	0	0	2	3	0	0	-1	0	2	0	0	0	0	0	0
29.12.2024 23:00	109	Dick G.	TOR	6	6	1	1471	3	12	0	0	0	3	0	0	-18	2	4	4	2	2	0	0	0
29.12.2024 23:00	110	Olynyk K.	TOR	6	6	2	703	1	4	0	0	0	1	4	4	-1	3	3	4	0	4	0	0	0
29.12.2024 23:00	111	Shead J.	TOR	5	2	6	1507	2	2	0	0	1	1	0	0	-15	1	1	2	0	1	1	0	0
29.12.2024 23:00	112	Walter J.	TOR	5	0	1	972	2	3	0	0	1	2	0	0	-6	0	0	1	1	2	0	0	0
29.12.2024 23:00	113	Mogbo J.	TOR	4	4	1	387	2	4	0	0	0	0	0	0	1	2	2	1	0	2	0	0	0
29.12.2024 23:00	114	Agbaji O.	TOR	3	4	3	1050	1	6	0	0	1	4	0	0	-18	2	2	5	0	2	0	0	0
29.12.2024 23:00	115	Temple G.	TOR	0	3	1	387	0	0	0	0	0	0	0	0	1	0	3	0	0	1	0	0	0
27.12.2024 01:00	116	Barrett R.	TOR	27	9	10	2030	10	18	0	0	2	5	5	7	-14	3	6	2	0	2	0	0	0
27.12.2024 01:00	117	Barnes S.	TOR	26	6	8	2142	10	20	0	0	2	5	4	4	-22	1	5	4	1	3	0	0	0
27.12.2024 01:00	118	Boucher C.	TOR	15	5	0	1285	6	12	0	0	2	5	1	1	-9	3	2	3	0	1	0	0	0
27.12.2024 01:00	119	Dick G.	TOR	14	3	3	1481	6	12	0	0	1	4	1	1	-22	1	2	3	2	3	0	0	0
27.12.2024 01:00	120	Olynyk K.	TOR	14	5	5	1386	6	9	0	0	2	4	0	0	-8	0	5	2	0	2	0	0	0
27.12.2024 01:00	121	Agbaji O.	TOR	10	0	2	1516	4	11	0	0	1	6	1	2	-22	0	0	2	0	0	0	0	0
27.12.2024 01:00	122	Battle J.	TOR	6	0	3	987	2	6	0	0	1	5	1	1	-8	0	0	2	1	1	0	0	0
27.12.2024 01:00	123	Lawson A.	TOR	6	2	0	327	2	3	0	0	1	1	1	2	-4	0	2	0	0	0	0	0	0
27.12.2024 01:00	124	Mitchell D.	TOR	6	0	5	1604	2	6	0	0	2	5	0	0	-13	0	0	1	2	0	0	0	0
27.12.2024 01:00	125	Mogbo J.	TOR	2	6	1	1023	1	7	0	0	0	1	0	0	-17	3	3	3	2	1	3	0	0
27.12.2024 01:00	126	Kamka-Chomche U.	TOR	0	2	1	292	0	1	0	0	0	0	0	0	-2	2	0	1	0	1	0	0	0
27.12.2024 01:00	127	Temple G.	TOR	0	2	1	327	0	3	0	0	0	2	0	0	-4	0	2	0	0	1	0	0	0
24.12.2024 00:30	128	Barnes S.	TOR	24	3	8	2181	10	20	0	0	0	3	4	6	-2	0	3	5	1	5	0	0	0
24.12.2024 00:30	129	Barrett R.	TOR	23	6	6	1998	7	13	0	0	1	4	8	11	-1	0	6	1	0	3	0	0	0
24.12.2024 00:30	130	Boucher C.	TOR	16	3	1	1122	5	6	0	0	4	5	2	2	5	1	2	1	3	0	1	0	0
24.12.2024 00:30	131	Dick G.	TOR	16	5	3	1831	5	13	0	0	2	5	4	4	-6	2	3	3	2	2	0	0	0
24.12.2024 00:30	132	Walter J.	TOR	16	1	0	1496	4	5	0	0	0	1	8	10	-19	0	1	4	0	1	2	0	0
24.12.2024 00:30	133	Mogbo J.	TOR	8	4	2	1358	3	4	0	0	0	0	2	2	-20	0	4	2	0	1	0	0	0
24.12.2024 00:30	134	Olynyk K.	TOR	6	3	2	1102	2	3	0	0	2	2	0	0	7	0	3	4	0	1	0	0	0
24.12.2024 00:30	135	Mitchell D.	TOR	5	0	3	741	2	3	0	0	1	1	0	0	-18	0	0	1	0	1	0	0	0
24.12.2024 00:30	136	Agbaji O.	TOR	4	2	1	1220	2	6	0	0	0	4	0	0	-15	0	2	2	0	0	0	0	0
24.12.2024 00:30	137	Battle J.	TOR	4	2	2	853	1	3	0	0	0	2	2	2	-11	1	1	1	0	0	0	0	0
24.12.2024 00:30	138	Lawson A.	TOR	3	0	0	249	1	1	0	0	1	1	0	0	5	0	0	0	0	0	0	0	0
24.12.2024 00:30	139	Kamka-Chomche U.	TOR	0	1	0	249	0	0	0	0	0	0	0	0	5	0	1	1	0	1	0	0	0
\.


--
-- Data for Name: toronto_raptors_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.toronto_raptors_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Quickley Immanuel	Lesionado	2025-01-17 13:55:36.48403
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users (id, username, email, password) FROM stdin;
1	jpds90	jpsoficial1@gmail.com	$2b$10$2nCVCQPp2FuWTo.wcQImveavXa7rZfNRntdibnMjitm41FqkxcdUO
\.


--
-- Data for Name: utah_jazz; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.utah_jazz (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	11.07.2024	Utah Jazz	93	Philadelphia 76ers	85	19	15	33	26	18	26	22	19
2	14.07.2024	Dallas Mavericks	89	Utah Jazz	90	18	22	30	19	19	20	25	26
3	16.07.2024	Sacramento Kings	82	Utah Jazz	70	23	25	17	17	9	16	24	21
4	17.07.2024	Utah Jazz	86	Toronto Raptors	76	19	23	26	18	21	10	20	25
5	19.07.2024	Utah Jazz	88	Los Angeles Clippers	105	19	21	24	24	13	30	27	35
6	22.07.2024	Utah Jazz	97	Detroit Pistons	87	27	40	17	13	18	21	33	15
7	05.10.2024	Utah Jazz (Usa)	116	NZ Breakers (Nzl)	87	29	34	27	26	29	18	23	17
8	08.10.2024	Utah Jazz	122	Houston Rockets	113	12	37	39	34	22	40	22	29
9	11.10.2024	Dallas Mavericks	102	Utah Jazz	107	18	29	33	22	24	36	32	15
10	13.10.2024	San Antonio Spurs	126	Utah Jazz	120	27	25	36	38	29	24	38	29
11	16.10.2024	Utah Jazz	117	Sacramento Kings	114	31	27	29	30	30	26	27	31
12	19.10.2024	Portland Trail Blazers	124	Utah Jazz	86	29	31	36	28	17	16	22	31
13	24.10.2024	Utah Jazz	124	Memphis Grizzlies	126	23	27	36	38	29	32	32	33
14	26.10.2024	Utah Jazz	86	Golden State Warriors	127	24	18	28	16	32	24	38	33
15	29.10.2024	Dallas Mavericks	110	Utah Jazz	102	27	22	33	28	19	24	27	32
16	30.10.2024	Utah Jazz	96	Sacramento Kings	113	22	30	14	30	34	27	29	23
17	01.11.2024	Utah Jazz	88	San Antonio Spurs	106	30	23	14	21	19	28	30	29
18	03.11.2024	Denver Nuggets	129	Utah Jazz	103	37	28	34	30	26	30	19	28
19	05.11.2024	Chicago Bulls	126	Utah Jazz	135	27	26	40	33	30	32	33	40
20	08.11.2024	Milwaukee Bucks	123	Utah Jazz	100	31	26	31	35	29	32	16	23
21	09.11.2024	San Antonio Spurs	110	Utah Jazz	111	22	23	37	28	25	28	29	29
22	13.11.2024	Utah Jazz	112	Phoenix Suns	120	21	28	30	33	33	31	23	33
23	15.11.2024	Utah Jazz	115	Dallas Mavericks	113	27	34	38	16	28	36	21	28
24	17.11.2024	Sacramento Kings	121	Utah Jazz	117	35	29	26	31	31	32	31	23
25	18.11.2024	Los Angeles Clippers	116	Utah Jazz	105	35	31	30	20	25	20	29	31
26	20.11.2024	Los Angeles Lakers	124	Utah Jazz	118	34	23	40	27	22	22	31	43
27	22.11.2024	San Antonio Spurs	126	Utah Jazz	118	17	34	34	41	32	35	22	29
28	23.11.2024	Utah Jazz	121	New York Knicks	106	28	38	21	34	28	23	27	28
29	27.11.2024	Utah Jazz	115	San Antonio Spurs	128	35	31	27	22	32	34	30	32
30	28.11.2024	Utah Jazz	103	Denver Nuggets	122	35	18	23	27	34	29	37	22
31	01.12.2024	Utah Jazz	94	Dallas Mavericks	106	22	27	27	18	40	16	30	20
32	02.12.2024	Utah Jazz	104	Los Angeles Lakers	105	27	29	25	23	26	32	28	19
33	04.12.2024	Oklahoma City Thunder	133	Utah Jazz	106	32	30	40	31	25	25	25	31
34	07.12.2024	Portland Trail Blazers	99	Utah Jazz	141	17	27	26	29	33	34	35	39
35	09.12.2024	Sacramento Kings	141	Utah Jazz	97	26	36	43	36	23	22	29	23
36	14.12.2024	Utah Jazz	126	Phoenix Suns	134	39	32	34	21	38	38	36	22
37	17.12.2024	Los Angeles Clippers	144	Utah Jazz	107	44	37	34	29	20	27	33	27
38	20.12.2024	Detroit Pistons	119	Utah Jazz	126	19	35	32	33	48	19	30	29
39	22.12.2024	Brooklyn Nets	94	Utah Jazz	105	24	21	18	31	19	31	25	30
40	24.12.2024	Cleveland Cavaliers	124	Utah Jazz	113	29	31	39	25	27	29	32	25
41	27.12.2024	Portland Trail Blazers	122	Utah Jazz	120	23	32	26	41	23	31	34	32
42	29.12.2024	Utah Jazz	111	Philadelphia 76ers	114	34	18	29	30	22	35	24	33
43	31.12.2024	Utah Jazz	121	Denver Nuggets	132	37	29	23	32	36	28	34	34
44	02.01. 00:30	New York Knicks	119	Utah Jazz	103	24	32	31	32	25	21	33	24
45	05.01. 01:00	Miami Heat	100	Utah Jazz	136	22	19	25	34	22	40	36	38
46	05.01. 23:30	Orlando Magic	92	Utah Jazz	105	25	18	19	30	22	21	28	34
47	08.01. 02:00	Utah Jazz	121	Atlanta Hawks	124	32	30	27	32	36	29	28	31
48	10.01. 02:00	Utah Jazz	92	Miami Heat	97	27	14	29	22	20	26	22	29
49	11.01. 22:00	Phoenix Suns	114	Utah Jazz	106	31	34	22	27	27	27	25	27
50	13.01. 01:00\nApós Prol.	Utah Jazz	112	Brooklyn Nets	111	26	23	36	17	27	21	30	24
51	16.01. 02:00	Utah Jazz	112	Charlotte Hornets	117	33	29	25	25	26	29	25	37
\.


--
-- Data for Name: utah_jazz_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.utah_jazz_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
16.01.2025 02:00	1	George K.	UTA	26	4	6	1836	9	22	0	0	5	13	3	5	-1	1	3	3	2	1	0	0	0
16.01.2025 02:00	2	Sensabaugh B.	UTA	19	4	4	1621	7	16	0	0	2	6	3	3	9	1	3	2	0	2	0	0	0
16.01.2025 02:00	3	Collier I.	UTA	11	3	10	1590	4	8	0	0	1	4	2	2	-9	0	3	3	0	5	0	0	0
16.01.2025 02:00	4	Eubanks D.	UTA	11	8	3	1224	5	9	0	0	0	0	1	2	0	2	6	1	1	0	1	0	0
16.01.2025 02:00	5	Kessler W.	UTA	11	8	1	1645	5	7	0	0	0	0	1	4	-5	3	5	2	0	1	2	0	0
16.01.2025 02:00	6	Mills P.	UTA	11	0	1	752	4	5	0	0	3	4	0	0	-7	0	0	0	0	0	0	0	0
16.01.2025 02:00	7	Filipowski K.	UTA	8	2	2	1355	3	5	0	0	2	4	0	0	12	1	1	3	0	0	0	0	0
16.01.2025 02:00	8	Harkless E.	UTA	8	1	2	1310	3	8	0	0	2	6	0	0	11	0	1	1	2	1	0	0	0
16.01.2025 02:00	9	Williams C.	UTA	5	2	1	1812	2	8	0	0	1	4	0	1	-22	0	2	2	0	0	1	0	0
16.01.2025 02:00	10	Potter M.	UTA	2	4	0	1255	1	5	0	0	0	2	0	0	-13	1	3	1	0	0	0	0	0
13.01.2025 01:00	11	Collier I.	UTA	23	7	7	2232	9	16	0	0	3	6	2	2	1	0	7	3	0	2	1	0	0
13.01.2025 01:00	12	Sexton C.	UTA	21	3	5	2278	8	20	0	0	1	3	4	4	-10	2	1	2	1	0	1	0	0
13.01.2025 01:00	13	Mykhailiuk S.	UTA	16	1	3	1008	5	9	0	0	4	7	2	2	14	1	0	2	1	1	0	0	0
13.01.2025 01:00	14	Sensabaugh B.	UTA	16	1	3	1617	5	13	0	0	3	10	3	3	4	0	1	4	0	2	0	0	0
13.01.2025 01:00	15	Filipowski K.	UTA	12	5	2	1234	4	7	0	0	3	4	1	1	3	1	4	0	1	0	0	0	0
13.01.2025 01:00	16	Eubanks D.	UTA	8	9	2	1869	4	5	0	0	0	0	0	2	1	0	9	4	0	1	3	0	0
13.01.2025 01:00	17	Potter M.	UTA	5	5	0	1221	1	4	0	0	1	4	2	2	-11	0	5	4	0	0	1	0	0
13.01.2025 01:00	18	Williams C.	UTA	5	2	2	2243	2	10	0	0	1	6	0	0	-16	0	2	0	1	2	0	0	0
13.01.2025 01:00	19	Harkless E.	UTA	3	3	1	1114	1	5	0	0	1	4	0	2	15	1	2	5	1	1	0	0	0
13.01.2025 01:00	20	Tshiebwe O.	UTA	3	5	0	1084	1	1	0	0	0	0	1	2	4	1	4	6	2	0	0	0	0
11.01.2025 22:00	21	Markkanen L.	UTA	24	4	2	1887	7	18	0	0	3	12	7	8	-6	1	3	4	1	0	0	0	0
11.01.2025 22:00	22	Sexton C.	UTA	20	4	4	1733	8	17	0	0	1	6	3	4	-9	2	2	2	0	2	0	0	0
11.01.2025 22:00	23	Kessler W.	UTA	16	13	0	1871	7	9	0	0	0	0	2	3	-4	7	6	1	0	1	2	0	0
11.01.2025 22:00	24	Mykhailiuk S.	UTA	13	4	7	1112	6	15	0	0	1	8	0	0	2	2	2	0	1	4	0	0	0
11.01.2025 22:00	25	Williams C.	UTA	13	2	2	1298	5	10	0	0	2	4	1	3	7	2	0	3	0	1	0	0	0
11.01.2025 22:00	26	Collier I.	UTA	5	3	8	1616	2	5	0	0	1	2	0	0	-3	1	2	2	1	2	0	0	0
11.01.2025 22:00	27	Potter M.	UTA	5	1	0	1130	2	3	0	0	1	2	0	0	-7	1	0	1	1	0	0	0	0
11.01.2025 22:00	28	Eubanks D.	UTA	4	11	1	1009	2	5	0	0	0	0	0	0	-4	2	9	1	0	1	0	0	0
11.01.2025 22:00	29	Filipowski K.	UTA	4	2	1	1340	2	8	0	0	0	5	0	0	-4	1	1	0	2	2	0	0	0
11.01.2025 22:00	30	Mills P.	UTA	2	2	1	843	1	5	0	0	0	2	0	0	-9	1	1	2	0	0	0	0	0
11.01.2025 22:00	31	Harkless E.	UTA	0	4	0	561	0	1	0	0	0	1	0	0	-3	1	3	2	0	0	0	0	0
10.01.2025 02:00	32	Markkanen L.	UTA	23	5	1	1800	8	24	0	0	6	15	1	2	-2	2	3	0	0	1	1	0	0
10.01.2025 02:00	33	Sexton C.	UTA	23	1	5	1724	9	18	0	0	1	3	4	4	4	0	1	0	1	2	0	0	0
10.01.2025 02:00	34	Kessler W.	UTA	9	15	0	1800	4	5	0	0	0	0	1	2	-2	5	10	2	0	2	2	0	0
10.01.2025 02:00	35	Mills P.	UTA	9	1	1	1080	3	12	0	0	2	9	1	1	-3	0	1	0	2	2	1	0	0
10.01.2025 02:00	36	Collier I.	UTA	8	3	9	2011	3	5	0	0	0	2	2	2	0	1	2	3	0	3	0	0	0
10.01.2025 02:00	37	Eubanks D.	UTA	6	4	3	1080	2	4	0	0	0	0	2	2	-3	1	3	0	0	1	0	0	0
10.01.2025 02:00	38	Juzang J.	UTA	5	6	0	1413	2	9	0	0	1	5	0	0	8	1	5	3	1	1	0	0	0
10.01.2025 02:00	39	Williams C.	UTA	5	0	0	1409	1	3	0	0	1	1	2	2	-18	0	0	5	3	1	2	0	0
10.01.2025 02:00	40	Filipowski K.	UTA	4	11	1	1388	1	3	0	0	0	1	2	2	-1	1	10	1	2	2	1	0	0
10.01.2025 02:00	41	Potter M.	UTA	0	3	0	695	0	0	0	0	0	0	0	0	-8	0	3	1	0	1	0	0	0
08.01.2025 02:00	42	Markkanen L.	UTA	35	2	1	1841	11	21	0	0	8	15	5	6	6	0	2	4	2	2	1	0	0
08.01.2025 02:00	43	Sexton C.	UTA	24	4	3	1837	7	16	0	0	2	3	8	9	4	2	2	3	0	1	0	0	1
08.01.2025 02:00	44	Kessler W.	UTA	21	10	0	1814	8	11	0	0	0	0	5	6	-2	8	2	0	1	0	3	0	0
08.01.2025 02:00	45	Mills P.	UTA	13	1	2	1087	5	14	0	0	3	9	0	0	-1	0	1	0	3	0	0	0	0
08.01.2025 02:00	46	Juzang J.	UTA	11	4	4	1494	4	11	0	0	3	8	0	0	-17	1	3	2	0	0	0	0	0
08.01.2025 02:00	47	Eubanks D.	UTA	4	8	2	1066	1	4	0	0	0	0	2	2	-1	1	7	1	1	5	0	0	0
08.01.2025 02:00	48	Williams C.	UTA	4	3	3	1761	1	6	0	0	0	2	2	2	-2	0	3	2	1	0	0	0	0
08.01.2025 02:00	49	Collier I.	UTA	3	6	9	1570	1	6	0	0	1	4	0	0	-5	1	5	3	0	2	0	0	0
08.01.2025 02:00	50	Filipowski K.	UTA	3	8	1	1031	1	5	0	0	1	5	0	0	12	0	8	1	0	3	0	0	0
08.01.2025 02:00	51	Potter M.	UTA	3	1	0	899	1	2	0	0	1	2	0	0	-9	0	1	1	0	2	0	0	0
05.01.2025 23:30	52	Sensabaugh B.	UTA	27	3	0	1684	11	19	0	0	5	6	0	0	5	2	1	1	0	1	0	0	0
05.01.2025 23:30	53	Sexton C.	UTA	20	4	2	1570	6	18	0	0	3	8	5	5	-4	0	4	2	1	3	0	0	0
05.01.2025 23:30	54	Filipowski K.	UTA	12	7	3	1782	6	8	0	0	0	2	0	1	15	1	6	3	0	1	0	0	0
05.01.2025 23:30	55	Juzang J.	UTA	12	3	3	1351	3	5	0	0	2	4	4	4	8	0	3	4	0	2	1	0	0
05.01.2025 23:30	56	Mykhailiuk S.	UTA	12	4	3	1223	4	9	0	0	1	6	3	3	9	0	4	1	3	3	0	0	0
05.01.2025 23:30	57	Kessler W.	UTA	10	17	2	1731	4	6	0	0	0	0	2	2	1	6	11	3	0	2	1	0	0
05.01.2025 23:30	58	Eubanks D.	UTA	7	3	1	994	3	3	0	0	0	0	1	2	12	0	3	1	1	1	2	0	0
05.01.2025 23:30	59	Potter M.	UTA	3	2	0	1253	1	3	0	0	0	1	1	1	-2	1	1	1	1	1	1	0	0
05.01.2025 23:30	60	Collier I.	UTA	2	5	6	1657	1	8	0	0	0	3	0	0	4	1	4	2	0	5	0	0	0
05.01.2025 23:30	61	Mills P.	UTA	0	2	1	1155	0	2	0	0	0	2	0	0	17	0	2	1	0	3	0	0	0
05.01.2025 01:00	62	Sensabaugh B.	UTA	34	7	2	1535	12	18	0	0	7	11	3	3	18	1	6	4	2	3	0	0	0
05.01.2025 01:00	63	Collins J.	UTA	24	9	3	1698	9	16	0	0	3	4	3	4	30	5	4	3	1	1	3	0	1
05.01.2025 01:00	64	Sexton C.	UTA	17	5	8	1837	7	19	0	0	2	7	1	1	35	2	3	0	1	2	0	0	0
05.01.2025 01:00	65	Markkanen L.	UTA	15	4	3	1598	6	13	0	0	2	6	1	1	20	1	3	1	2	0	0	0	0
05.01.2025 01:00	66	Kessler W.	UTA	14	16	0	1572	6	7	0	0	0	0	2	4	26	7	9	2	0	1	0	0	0
05.01.2025 01:00	67	George K.	UTA	11	6	5	1573	4	10	0	0	3	8	0	0	20	0	6	4	1	5	0	0	0
05.01.2025 01:00	68	Juzang J.	UTA	8	5	0	1252	3	5	0	0	2	4	0	0	7	0	5	1	1	0	0	0	0
05.01.2025 01:00	69	Collier I.	UTA	7	2	6	1462	3	5	0	0	0	1	1	1	17	0	2	2	2	1	1	0	0
05.01.2025 01:00	70	Filipowski K.	UTA	4	3	2	1308	1	2	0	0	0	1	2	2	10	0	3	4	1	1	0	0	0
05.01.2025 01:00	71	Clarkson J.	UTA	2	0	1	166	1	2	0	0	0	1	0	0	2	0	0	0	0	0	0	0	0
05.01.2025 01:00	72	Potter M.	UTA	0	0	1	399	0	3	0	0	0	3	0	0	-5	0	0	0	0	0	0	0	0
02.01.2025 00:30	73	Clarkson J.	UTA	25	4	1	1922	8	19	0	0	3	6	6	9	-10	1	3	1	1	5	2	0	0
02.01.2025 00:30	74	Sexton C.	UTA	25	4	4	1867	10	13	0	0	4	5	1	1	-5	1	3	2	0	4	0	0	0
02.01.2025 00:30	75	Markkanen L.	UTA	16	10	2	2123	6	22	0	0	1	10	3	3	0	3	7	2	2	1	2	0	0
02.01.2025 00:30	76	George K.	UTA	15	1	6	2152	6	13	0	0	3	7	0	0	-6	0	1	1	1	2	0	0	0
02.01.2025 00:30	77	Juzang J.	UTA	10	5	0	1363	3	6	0	0	2	4	2	2	-4	2	3	5	0	0	0	0	0
02.01.2025 00:30	78	Kessler W.	UTA	6	8	5	1809	3	5	0	0	0	1	0	0	-14	3	5	3	1	2	1	0	0
02.01.2025 00:30	79	Sensabaugh B.	UTA	4	4	1	880	2	5	0	0	0	3	0	0	-14	1	3	0	0	0	0	0	0
02.01.2025 00:30	80	Filipowski K.	UTA	2	6	2	666	1	5	0	0	0	1	0	0	-4	3	3	2	0	1	1	0	0
02.01.2025 00:30	81	Collier I.	UTA	0	2	2	672	0	2	0	0	0	2	0	0	-11	0	2	2	2	1	0	0	0
02.01.2025 00:30	82	Mykhailiuk S.	UTA	0	1	0	946	0	6	0	0	0	4	0	0	-12	0	1	1	0	0	0	0	0
31.12.2024 02:00	83	Clarkson J.	UTA	24	5	4	1666	7	15	0	0	3	5	7	7	-7	2	3	2	1	4	0	0	0
31.12.2024 02:00	84	Sexton C.	UTA	22	2	4	1721	9	19	0	0	1	6	3	3	-12	1	1	2	0	2	0	0	0
31.12.2024 02:00	85	Markkanen L.	UTA	17	1	0	1923	5	13	0	0	2	9	5	5	-18	1	0	1	0	2	0	0	0
31.12.2024 02:00	86	Juzang J.	UTA	14	4	1	1371	5	9	0	0	2	5	2	2	13	1	3	1	0	0	0	0	0
31.12.2024 02:00	87	Kessler W.	UTA	12	13	4	2257	6	6	0	0	0	0	0	0	-15	2	11	4	1	2	2	0	0
31.12.2024 02:00	88	Collier I.	UTA	8	4	5	1028	3	4	0	0	1	2	1	1	-5	0	4	1	1	0	0	0	0
31.12.2024 02:00	89	George K.	UTA	7	3	6	1696	3	9	0	0	1	4	0	1	-8	0	3	0	1	3	0	0	0
31.12.2024 02:00	90	Williams C.	UTA	7	1	1	1028	2	3	0	0	2	3	1	2	-7	0	1	1	0	1	0	0	0
31.12.2024 02:00	91	Filipowski K.	UTA	5	1	2	623	2	3	0	0	0	0	1	1	4	0	1	2	2	0	0	0	0
31.12.2024 02:00	92	Sensabaugh B.	UTA	5	3	1	1087	2	5	0	0	1	4	0	0	0	0	3	3	0	2	0	0	0
29.12.2024 02:30	93	Markkanen L.	UTA	23	4	2	1965	8	21	0	0	5	15	2	2	-10	1	3	1	1	3	0	0	0
29.12.2024 02:30	94	Sensabaugh B.	UTA	20	5	2	1473	6	9	0	0	3	5	5	5	-4	0	5	3	0	1	1	0	0
29.12.2024 02:30	95	Sexton C.	UTA	20	6	8	1867	9	16	0	0	2	4	0	0	10	3	3	2	1	2	0	0	0
29.12.2024 02:30	96	Clarkson J.	UTA	17	3	4	1810	7	16	0	0	0	3	3	3	-9	1	2	1	0	2	1	0	0
29.12.2024 02:30	97	Kessler W.	UTA	11	11	0	1775	5	8	0	0	0	0	1	3	-5	5	6	5	0	4	1	0	0
29.12.2024 02:30	98	Eubanks D.	UTA	6	2	1	552	3	3	0	0	0	0	0	0	4	0	2	3	0	1	0	0	1
29.12.2024 02:30	99	Juzang J.	UTA	6	5	1	938	2	5	0	0	2	4	0	0	-10	1	4	1	0	0	0	0	0
29.12.2024 02:30	100	Williams C.	UTA	6	5	1	1390	2	4	0	0	0	1	2	2	16	1	4	5	0	2	0	0	0
29.12.2024 02:30	101	Collier I.	UTA	2	3	4	1162	1	3	0	0	0	2	0	0	-12	1	2	1	0	5	0	0	0
29.12.2024 02:30	102	Filipowski K.	UTA	0	4	1	551	0	2	0	0	0	0	0	0	-5	1	3	2	1	1	0	0	0
29.12.2024 02:30	103	Potter M.	UTA	0	0	3	917	0	2	0	0	0	2	0	0	10	0	0	1	0	0	0	0	0
27.12.2024 03:00	104	Markkanen L.	UTA	25	6	1	1824	8	14	0	0	4	8	5	6	5	3	3	1	3	1	0	0	0
27.12.2024 03:00	105	Sexton C.	UTA	19	1	11	1647	7	19	0	0	3	7	2	2	1	1	0	2	0	1	0	0	0
27.12.2024 03:00	106	Mykhailiuk S.	UTA	18	1	1	1481	6	13	0	0	6	12	0	0	16	0	1	0	1	0	1	0	0
27.12.2024 03:00	107	Eubanks D.	UTA	15	3	0	1056	6	6	0	0	1	1	2	2	-7	1	2	0	0	0	1	0	0
27.12.2024 03:00	108	Juzang J.	UTA	14	5	0	886	4	7	0	0	3	5	3	4	-2	1	4	0	1	0	0	0	0
27.12.2024 03:00	109	Collier I.	UTA	7	8	7	2090	3	10	0	0	1	3	0	1	10	1	7	4	0	6	0	0	0
27.12.2024 03:00	110	Filipowski K.	UTA	6	4	2	1056	2	2	0	0	2	2	0	2	-7	0	4	2	1	2	0	0	0
27.12.2024 03:00	111	Sensabaugh B.	UTA	6	1	2	1034	2	7	0	0	0	3	2	2	-13	0	1	2	1	2	0	0	0
27.12.2024 03:00	112	Kessler W.	UTA	5	16	1	1824	1	5	0	0	0	0	3	6	5	3	13	1	2	0	2	0	0
27.12.2024 03:00	113	Williams C.	UTA	5	1	1	1502	2	3	0	0	1	1	0	0	-18	1	0	4	0	1	1	0	0
24.12.2024 00:00	114	Clarkson J.	UTA	27	6	5	2009	7	17	0	0	3	5	10	11	4	0	6	5	2	4	1	0	0
24.12.2024 00:00	115	Markkanen L.	UTA	26	7	1	1918	7	21	0	0	6	14	6	7	-15	3	4	2	0	1	0	0	0
24.12.2024 00:00	116	Sexton C.	UTA	24	3	5	2180	10	22	0	0	4	10	0	0	-13	1	2	3	1	4	0	0	0
24.12.2024 00:00	117	Mykhailiuk S.	UTA	11	3	3	1523	4	10	0	0	2	5	1	2	-16	0	3	0	1	2	0	0	0
24.12.2024 00:00	118	Potter M.	UTA	11	7	2	1572	4	7	0	0	3	6	0	0	-8	2	5	1	1	1	1	0	0
24.12.2024 00:00	119	Kessler W.	UTA	9	16	3	2307	4	6	0	0	0	1	1	6	-15	8	8	1	0	0	3	0	0
24.12.2024 00:00	120	Juzang J.	UTA	3	1	0	850	1	2	0	0	1	2	0	0	-5	1	0	2	0	2	0	0	0
24.12.2024 00:00	121	Sensabaugh B.	UTA	2	3	2	650	1	4	0	0	0	1	0	0	6	1	2	2	1	0	0	0	0
24.12.2024 00:00	122	Collier I.	UTA	0	1	4	818	0	1	0	0	0	0	0	0	3	1	0	2	0	1	0	0	0
24.12.2024 00:00	123	Filipowski K.	UTA	0	4	2	573	0	2	0	0	0	0	0	0	4	1	3	2	0	1	0	0	0
\.


--
-- Data for Name: utah_jazz_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.utah_jazz_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Markkanen Lauri	Lesionado	2025-01-17 13:55:51.541803
2	Potter Micah	Lesionado	2025-01-17 13:55:51.544455
3	Clarkson Jordan	Lesionado	2025-01-17 13:55:51.547262
4	Juzang Johnny	Lesionado	2025-01-17 13:55:51.549174
5	Sexton Collin	Lesionado	2025-01-17 13:55:51.550913
6	Collins John	Lesionado	2025-01-17 13:55:51.552842
7	Hendricks Taylor	Lesionado	2025-01-17 13:55:51.554963
\.


--
-- Data for Name: washington_wizards; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.washington_wizards (id, datahora, home_team, home_score, away_team, away_score, home_team_q1, home_team_q2, home_team_q3, home_team_q4, away_team_q1, away_team_q2, away_team_q3, away_team_q4) FROM stdin;
1	10.04.2024	Minnesota Timberwolves	130	Washington Wizards	121	26	34	39	31	44	26	24	27
2	13.04.2024	Washington Wizards	127	Chicago Bulls	129	40	22	33	32	33	32	33	31
3	14.04.2024	Boston Celtics	132	Washington Wizards	122	34	35	38	25	30	29	30	33
4	13.07.2024	Washington Wizards	94	Atlanta Hawks	88	14	26	26	28	23	19	23	23
5	14.07.2024	Washington Wizards	91	Houston Rockets	109	23	21	28	19	29	30	22	28
6	17.07.2024	Portland Trail Blazers	82	Washington Wizards	80	17	22	27	16	18	20	22	20
7	19.07.2024	Sacramento Kings	69	Washington Wizards	73	19	16	20	14	17	26	14	16
8	20.07.2024	Washington Wizards	91	Milwaukee Bucks	79	29	17	15	30	19	16	31	13
9	07.10.2024	Toronto Raptors	125	Washington Wizards	98	34	22	35	34	16	22	36	24
10	10.10.2024	New York Knicks	117	Washington Wizards	94	19	35	32	31	22	17	20	35
11	12.10.2024	Washington Wizards	113	Toronto Raptors	95	18	30	34	31	25	22	32	16
12	15.10.2024	Brooklyn Nets	131	Washington Wizards	92	28	27	34	42	20	26	24	22
13	19.10.2024	Washington Wizards	118	New York Knicks	117	35	28	22	33	29	32	29	27
14	25.10.2024	Washington Wizards	102	Boston Celtics	122	32	22	19	29	33	31	34	24
15	27.10.2024	Washington Wizards	116	Cleveland Cavaliers	135	25	28	28	35	28	31	38	38
16	28.10.2024	Atlanta Hawks	119	Washington Wizards	121	28	33	22	36	25	29	30	37
17	30.10.2024	Washington Wizards	133	Atlanta Hawks	120	33	24	36	40	34	31	27	28
18	03.11.2024	Washington Wizards	98	Miami Heat	118	21	27	22	28	31	25	33	29
19	05.11.2024	Washington Wizards	112	Golden State Warriors	125	20	25	36	31	29	25	39	32
20	09.11.2024	Memphis Grizzlies	128	Washington Wizards	104	34	32	32	30	24	25	22	33
21	10.11.2024	Orlando Magic	121	Washington Wizards	94	26	35	30	30	22	34	16	22
22	12.11.2024	Houston Rockets	107	Washington Wizards	92	30	27	25	25	28	21	20	23
23	14.11.2024	San Antonio Spurs	139	Washington Wizards	130	32	35	41	31	31	36	24	39
24	16.11.2024	Atlanta Hawks	129	Washington Wizards	117	29	30	35	35	39	11	25	42
25	17.11.2024	Washington Wizards	104	Detroit Pistons	124	18	35	26	25	28	37	37	22
26	19.11.2024	New York Knicks	134	Washington Wizards	106	40	33	36	25	27	27	21	31
27	23.11.2024	Washington Wizards	96	Boston Celtics	108	27	24	21	24	29	20	26	33
28	24.11.2024	Indiana Pacers	115	Washington Wizards	103	31	26	35	23	28	31	28	16
29	27.11.2024	Washington Wizards	108	Chicago Bulls	127	29	18	34	27	21	40	35	31
30	28.11.2024	Washington Wizards	96	Los Angeles Clippers	121	26	18	25	27	37	24	27	33
31	01.12.2024	Milwaukee Bucks	124	Washington Wizards	114	28	35	29	32	29	29	28	28
32	04.12.2024	Cleveland Cavaliers	118	Washington Wizards	87	35	25	26	32	20	22	25	20
33	06.12.2024	Washington Wizards	101	Dallas Mavericks	137	22	28	27	24	31	37	34	35
34	08.12.2024	Washington Wizards	122	Denver Nuggets	113	36	33	30	23	29	28	36	20
35	09.12.2024	Washington Wizards	112	Memphis Grizzlies	140	26	29	27	30	34	38	39	29
36	14.12.2024	Cleveland Cavaliers	115	Washington Wizards	105	25	32	30	28	25	29	26	25
37	15.12.2024	Washington Wizards	98	Boston Celtics	112	23	29	20	26	34	33	24	21
38	20.12.2024	Washington Wizards	123	Charlotte Hornets	114	29	31	27	36	30	28	28	28
39	22.12.2024	Milwaukee Bucks	112	Washington Wizards	101	36	27	23	26	36	14	22	29
40	24.12.2024	Oklahoma City Thunder	123	Washington Wizards	105	29	38	24	32	32	31	24	18
41	27.12.2024	Washington Wizards	113	Charlotte Hornets	110	34	34	28	17	29	25	33	23
42	29.12.2024\nApós Prol.	Washington Wizards	132	New York Knicks	136	33	27	38	21	32	28	30	29
43	31.12.2024	Washington Wizards	106	New York Knicks	126	30	27	31	18	27	32	38	29
44	02.01. 00:00	Washington Wizards	125	Chicago Bulls	107	27	28	36	34	25	26	29	27
45	04.01. 01:00	New Orleans Pelicans	132	Washington Wizards	120	29	33	35	35	37	31	29	23
46	05.01. 23:00	Washington Wizards	98	New Orleans Pelicans	110	22	23	25	28	33	27	24	26
47	08.01. 00:00	Washington Wizards	112	Houston Rockets	135	30	25	24	33	20	37	40	38
48	09.01. 00:00	Philadelphia 76ers	109	Washington Wizards	103	32	27	29	21	25	23	26	29
49	11.01. 01:00	Chicago Bulls	138	Washington Wizards	105	36	32	41	29	26	32	24	23
50	12.01. 23:00	Washington Wizards	95	Oklahoma City Thunder	136	25	18	26	26	37	30	37	32
51	14.01. 00:00	Washington Wizards	106	Minnesota Timberwolves	120	20	27	32	27	25	26	31	38
52	17.01. 00:00	Washington Wizards	123	Phoenix Suns	130	21	34	28	40	34	35	35	26
\.


--
-- Data for Name: washington_wizards_jogadores; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.washington_wizards_jogadores (data_hora, id, player_name, team, points, total_rebounds, assists, minutes_played, field_goals_made, field_goals_attempted, two_point_made, two_point_attempted, three_point_made, three_point_attempted, free_throws_made, free_throws_attempted, plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls, steals, turnovers, shots_blocked, blocks_against, technical_fouls) FROM stdin;
17.01.2025 00:00	1	George K.	WAS	24	4	4	1873	8	10	0	0	6	8	2	3	11	1	3	6	1	3	0	0	0
17.01.2025 00:00	2	Poole J.	WAS	18	4	4	1586	6	16	0	0	3	10	3	4	-23	0	4	5	2	1	0	0	0
17.01.2025 00:00	3	Sarr A.	WAS	16	9	2	1698	7	17	0	0	1	7	1	2	-14	2	7	1	1	0	2	0	0
17.01.2025 00:00	4	Kispert C.	WAS	14	3	5	1703	7	13	0	0	0	3	0	1	15	1	2	1	1	2	0	0	0
17.01.2025 00:00	5	Coulibaly B.	WAS	13	3	2	2133	4	9	0	0	0	3	5	6	-14	1	2	2	1	3	0	0	0
17.01.2025 00:00	6	Valanciunas J.	WAS	11	8	1	891	4	6	0	0	0	0	3	4	9	2	6	0	0	0	1	0	0
17.01.2025 00:00	7	Champagnie J.	WAS	10	3	0	629	4	6	0	0	2	3	0	0	-3	2	1	3	2	1	0	0	0
17.01.2025 00:00	8	Butler J.	WAS	6	2	2	720	2	4	0	0	0	1	2	2	14	0	2	3	2	0	0	0	0
17.01.2025 00:00	9	Carrington C.	WAS	6	4	3	1563	2	7	0	0	1	5	1	1	-14	0	4	0	1	0	1	0	0
17.01.2025 00:00	10	Kuzma K.	WAS	5	5	5	1604	2	4	0	0	0	1	1	4	-16	3	2	1	2	3	0	0	0
14.01.2025 00:00	11	Kuzma K.	WAS	22	5	5	2129	9	21	0	0	3	8	1	4	-11	0	5	3	3	1	0	0	0
14.01.2025 00:00	12	Poole J.	WAS	20	7	4	1994	8	21	0	0	4	11	0	0	-18	2	5	2	2	5	1	0	0
14.01.2025 00:00	13	Coulibaly B.	WAS	15	1	3	2081	6	10	0	0	2	2	1	1	-18	1	0	2	1	2	0	0	0
14.01.2025 00:00	14	Sarr A.	WAS	13	3	5	1672	4	10	0	0	3	5	2	4	-18	2	1	2	2	1	2	0	0
14.01.2025 00:00	15	George K.	WAS	10	1	3	1051	4	7	0	0	2	5	0	0	-1	0	1	2	2	0	0	0	0
14.01.2025 00:00	16	Carrington C.	WAS	8	5	2	2027	2	9	0	0	2	6	2	2	-17	1	4	2	1	0	0	0	0
14.01.2025 00:00	17	Valanciunas J.	WAS	8	8	4	1126	4	4	0	0	0	0	0	0	1	2	6	3	2	0	0	0	0
14.01.2025 00:00	18	Butler J.	WAS	7	0	0	416	2	4	0	0	1	1	2	2	5	0	0	0	0	1	0	0	0
14.01.2025 00:00	19	Kispert C.	WAS	2	2	1	1070	1	4	0	0	0	2	0	0	-2	0	2	0	0	0	0	0	0
14.01.2025 00:00	20	Gill A.	WAS	1	0	0	82	0	1	0	0	0	0	1	2	3	0	0	0	0	0	0	0	0
14.01.2025 00:00	21	Baldwin P.	WAS	0	1	0	82	0	0	0	0	0	0	0	0	3	0	1	0	0	0	0	0	0
14.01.2025 00:00	22	Champagnie J.	WAS	0	1	0	588	0	0	0	0	0	0	0	0	0	0	1	2	0	1	0	0	0
14.01.2025 00:00	23	Davis J.	WAS	0	0	0	82	0	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0
12.01.2025 23:00	24	Kispert C.	WAS	17	0	0	1416	6	9	0	0	3	5	2	2	-21	0	0	2	0	0	1	0	0
12.01.2025 23:00	25	Poole J.	WAS	13	3	4	1395	3	10	0	0	0	6	7	7	-11	0	3	3	0	6	0	0	0
12.01.2025 23:00	26	Valanciunas J.	WAS	11	8	0	1084	4	5	0	0	1	2	2	2	-19	2	6	3	0	3	0	0	0
12.01.2025 23:00	27	Coulibaly B.	WAS	10	5	1	1734	3	12	0	0	1	7	3	4	-18	1	4	1	2	2	2	0	0
12.01.2025 23:00	28	Sarr A.	WAS	10	6	0	1480	4	7	0	0	2	4	0	0	-20	1	5	1	0	0	2	0	0
12.01.2025 23:00	29	George K.	WAS	8	2	2	1208	0	5	0	0	0	4	8	8	-19	1	1	4	2	0	0	0	0
12.01.2025 23:00	30	Butler J.	WAS	6	4	2	490	2	2	0	0	0	0	2	2	-4	1	3	2	0	1	1	0	0
12.01.2025 23:00	31	Kuzma K.	WAS	6	2	3	1789	2	12	0	0	0	6	2	4	-40	1	1	2	1	3	0	0	0
12.01.2025 23:00	32	Carrington C.	WAS	5	7	7	2062	2	10	0	0	1	6	0	0	-41	0	7	4	0	1	0	0	0
12.01.2025 23:00	33	Gill A.	WAS	4	0	0	316	0	1	0	0	0	0	4	4	-2	0	0	1	0	0	0	0	0
12.01.2025 23:00	34	Baldwin P.	WAS	3	0	0	316	1	2	0	0	1	2	0	0	-2	0	0	0	0	0	0	0	0
12.01.2025 23:00	35	Champagnie J.	WAS	2	2	1	794	1	5	0	0	0	2	0	0	-6	1	1	0	1	0	0	0	0
12.01.2025 23:00	36	Davis J.	WAS	0	0	0	316	0	3	0	0	0	2	0	0	-2	0	0	0	0	0	0	0	0
11.01.2025 01:00	37	Poole J.	WAS	22	2	2	1442	7	13	0	0	6	9	2	2	-15	0	2	0	0	3	0	0	0
11.01.2025 01:00	38	Butler J.	WAS	18	6	4	1237	8	12	0	0	1	2	1	2	-9	2	4	2	0	1	1	0	0
11.01.2025 01:00	39	George K.	WAS	12	4	2	1532	4	11	0	0	4	8	0	0	-15	2	2	2	0	2	1	0	0
11.01.2025 01:00	40	Champagnie J.	WAS	11	2	1	679	4	6	0	0	3	4	0	0	-5	1	1	0	1	0	0	0	0
11.01.2025 01:00	41	Sarr A.	WAS	11	11	1	1588	4	14	0	0	1	4	2	3	-22	3	8	2	0	1	0	0	0
11.01.2025 01:00	42	Coulibaly B.	WAS	7	2	5	1759	3	9	0	0	1	4	0	0	-29	0	2	2	2	2	1	0	0
11.01.2025 01:00	43	Valanciunas J.	WAS	6	9	1	911	3	8	0	0	0	1	0	0	-2	4	5	3	1	2	0	0	0
11.01.2025 01:00	44	Davis J.	WAS	5	0	0	373	2	3	0	0	1	2	0	0	-6	0	0	0	1	0	0	0	0
11.01.2025 01:00	45	Kuzma K.	WAS	5	5	3	1243	1	6	0	0	0	2	3	4	-21	0	5	1	0	3	1	0	0
11.01.2025 01:00	46	Baldwin P.	WAS	3	1	0	370	1	2	0	0	1	2	0	0	-4	0	1	1	0	0	0	0	0
11.01.2025 01:00	47	Holmes R.	WAS	3	1	0	370	1	3	0	0	0	0	1	2	-4	1	0	0	0	0	0	0	0
11.01.2025 01:00	48	Carrington C.	WAS	2	1	3	1339	1	6	0	0	0	5	0	0	-20	0	1	0	1	0	0	0	0
11.01.2025 01:00	49	Gill A.	WAS	0	0	1	213	0	0	0	0	0	0	0	0	-4	0	0	1	0	0	0	0	0
11.01.2025 01:00	50	Kispert C.	WAS	0	1	3	1344	0	5	0	0	0	3	0	0	-9	0	1	1	0	1	0	0	0
09.01.2025 00:00	51	Butler J.	WAS	26	4	7	1206	11	19	0	0	3	3	1	2	7	3	1	1	1	1	0	0	0
09.01.2025 00:00	52	Kispert C.	WAS	23	5	5	2117	8	14	0	0	4	8	3	3	-3	0	5	3	1	1	0	0	0
09.01.2025 00:00	53	Kuzma K.	WAS	16	5	2	1871	7	19	0	0	2	8	0	0	-22	0	5	1	0	3	0	0	0
09.01.2025 00:00	54	Valanciunas J.	WAS	14	14	1	1265	6	13	0	0	1	1	1	1	-18	8	6	3	0	8	1	0	0
09.01.2025 00:00	55	Carrington C.	WAS	8	2	5	1844	4	10	0	0	0	4	0	0	-18	0	2	0	0	1	0	0	0
09.01.2025 00:00	56	Champagnie J.	WAS	5	2	1	997	2	3	0	0	1	1	0	0	12	1	1	2	0	0	1	0	0
09.01.2025 00:00	57	Coulibaly B.	WAS	5	4	2	1832	2	8	0	0	1	1	0	2	-21	3	1	3	0	2	1	0	0
09.01.2025 00:00	58	George K.	WAS	3	4	2	1669	1	6	0	0	1	4	0	0	17	1	3	1	1	1	1	0	0
09.01.2025 00:00	59	Holmes R.	WAS	3	11	1	1599	1	2	0	0	0	0	1	1	16	2	9	4	0	0	2	0	0
08.01.2025 00:00	60	Kispert C.	WAS	23	4	3	1970	7	10	0	0	5	7	4	5	-19	2	2	1	0	1	0	0	0
08.01.2025 00:00	61	Valanciunas J.	WAS	18	4	1	1299	7	11	0	0	0	0	4	4	-6	1	3	2	0	2	0	0	0
08.01.2025 00:00	62	Butler J.	WAS	14	0	5	1299	5	11	0	0	2	4	2	2	-11	0	0	2	1	3	1	0	0
08.01.2025 00:00	63	Carrington C.	WAS	12	4	5	2044	4	8	0	0	4	6	0	1	-15	1	3	2	0	0	0	0	0
08.01.2025 00:00	64	Coulibaly B.	WAS	12	5	1	1804	5	10	0	0	0	3	2	2	-14	3	2	2	0	4	0	0	0
08.01.2025 00:00	65	Kuzma K.	WAS	10	6	2	1010	4	9	0	0	1	4	1	4	2	0	6	0	1	2	0	0	0
08.01.2025 00:00	66	George K.	WAS	9	4	3	1636	4	10	0	0	1	7	0	0	-19	3	1	3	2	2	1	0	0
08.01.2025 00:00	67	Champagnie J.	WAS	7	5	0	1243	2	4	0	0	1	2	2	2	-12	2	3	4	1	0	1	0	0
08.01.2025 00:00	68	Baldwin P.	WAS	5	1	0	257	2	2	0	0	1	1	0	0	-2	1	0	0	0	1	0	0	0
08.01.2025 00:00	69	Sarr A.	WAS	2	9	1	1398	1	12	0	0	0	5	0	0	-14	2	7	3	1	3	1	0	0
08.01.2025 00:00	70	Gill A.	WAS	0	0	0	257	0	1	0	0	0	1	0	0	-2	0	0	0	0	0	0	0	0
08.01.2025 00:00	71	Holmes R.	WAS	0	1	0	183	0	1	0	0	0	0	0	0	-3	1	0	0	0	0	0	0	0
05.01.2025 23:00	72	Kuzma K.	WAS	28	5	1	1850	13	23	0	0	2	5	0	0	-1	1	4	0	2	3	1	0	0
05.01.2025 23:00	73	Sarr A.	WAS	18	11	3	1700	6	9	0	0	3	6	3	5	7	2	9	2	0	2	0	0	0
05.01.2025 23:00	74	Butler J.	WAS	17	4	5	1197	6	12	0	0	1	3	4	5	3	1	3	3	1	2	0	0	0
05.01.2025 23:00	75	Carrington C.	WAS	16	7	4	2012	6	9	0	0	4	7	0	0	1	1	6	1	1	1	0	0	0
05.01.2025 23:00	76	Valanciunas J.	WAS	6	7	2	1180	3	5	0	0	0	0	0	0	-19	1	6	2	0	1	1	0	0
05.01.2025 23:00	77	Kispert C.	WAS	5	1	0	1582	1	10	0	0	0	7	3	3	-20	0	1	2	0	1	1	0	0
05.01.2025 23:00	78	Brogdon M.	WAS	4	3	5	874	2	7	0	0	0	2	0	0	-12	0	3	0	0	1	0	0	0
05.01.2025 23:00	79	Champagnie J.	WAS	3	5	4	1637	1	6	0	0	1	4	0	0	-13	2	3	2	0	1	1	0	0
05.01.2025 23:00	80	George K.	WAS	1	3	1	1618	0	7	0	0	0	6	1	1	-12	1	2	5	1	2	0	0	0
05.01.2025 23:00	81	Davis J.	WAS	0	0	0	314	0	1	0	0	0	1	0	0	4	0	0	0	0	0	0	0	0
05.01.2025 23:00	82	Gill A.	WAS	0	0	0	436	0	0	0	0	0	0	0	0	2	0	0	1	1	1	0	0	0
04.01.2025 01:00	83	Poole J.	WAS	26	4	7	1843	8	18	0	0	3	10	7	8	-1	1	3	4	1	3	0	0	1
04.01.2025 01:00	84	Sarr A.	WAS	19	7	5	1638	7	13	0	0	0	2	5	5	-17	3	4	4	0	2	0	0	0
04.01.2025 01:00	85	Brogdon M.	WAS	16	3	3	1486	4	10	0	0	0	1	8	8	1	1	2	0	0	1	0	0	0
04.01.2025 01:00	86	Kuzma K.	WAS	14	7	1	1709	7	8	0	0	0	1	0	2	-13	1	6	0	1	2	0	0	0
04.01.2025 01:00	87	Champagnie J.	WAS	12	7	1	1793	5	8	0	0	2	4	0	2	-7	2	5	2	3	3	0	0	0
04.01.2025 01:00	88	Valanciunas J.	WAS	9	10	2	1175	4	9	0	0	0	0	1	2	2	3	7	3	0	4	0	0	0
04.01.2025 01:00	89	Carrington C.	WAS	8	3	6	2172	4	8	0	0	0	3	0	0	-27	0	3	1	0	2	0	0	0
04.01.2025 01:00	90	Kispert C.	WAS	8	2	1	1268	3	5	0	0	2	3	0	0	-8	1	1	4	0	1	0	0	0
04.01.2025 01:00	91	George K.	WAS	5	5	1	1048	2	3	0	0	1	2	0	0	-2	2	3	5	1	3	0	0	0
04.01.2025 01:00	92	Baldwin P.	WAS	3	0	0	67	1	1	0	0	1	1	0	0	3	0	0	0	0	0	0	0	0
04.01.2025 01:00	93	Butler J.	WAS	0	0	1	67	0	1	0	0	0	1	0	0	3	0	0	0	0	0	0	0	0
04.01.2025 01:00	94	Davis J.	WAS	0	0	0	67	0	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0
04.01.2025 01:00	95	Gill A.	WAS	0	0	0	67	0	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0
02.01.2025 00:00	96	Poole J.	WAS	30	3	2	1656	10	21	0	0	6	13	4	4	8	1	2	2	3	5	0	0	0
02.01.2025 00:00	97	Champagnie J.	WAS	15	2	1	1247	6	8	0	0	2	3	1	1	3	0	2	2	1	1	0	0	0
02.01.2025 00:00	98	Valanciunas J.	WAS	14	6	6	1292	6	12	0	0	0	0	2	3	13	2	4	2	3	4	0	0	0
02.01.2025 00:00	99	Kispert C.	WAS	13	2	2	1751	5	12	0	0	3	6	0	0	22	1	1	0	0	1	0	0	0
02.01.2025 00:00	100	Brogdon M.	WAS	12	4	6	1668	5	12	0	0	0	1	2	2	12	1	3	1	0	1	1	0	0
02.01.2025 00:00	101	Carrington C.	WAS	11	4	6	1831	4	5	0	0	3	3	0	0	12	0	4	1	1	0	1	0	0
02.01.2025 00:00	102	Sarr A.	WAS	11	10	5	1486	5	11	0	0	1	2	0	1	10	1	9	1	0	2	1	0	0
02.01.2025 00:00	103	George K.	WAS	9	4	0	1225	4	10	0	0	1	6	0	0	8	0	4	1	1	0	0	0	0
02.01.2025 00:00	104	Kuzma K.	WAS	5	5	5	1330	2	3	0	0	0	0	1	1	10	0	5	2	1	0	0	0	0
02.01.2025 00:00	105	Gill A.	WAS	3	0	0	100	1	2	0	0	1	1	0	0	-2	0	0	0	0	0	0	0	0
02.01.2025 00:00	106	Vukcevic T.	WAS	2	1	0	100	1	1	0	0	0	0	0	0	-2	1	0	1	0	0	0	0	0
02.01.2025 00:00	107	Butler J.	WAS	0	0	1	100	0	0	0	0	0	0	0	0	-2	0	0	0	0	0	0	0	0
02.01.2025 00:00	108	Coulibaly B.	WAS	0	1	2	514	0	1	0	0	0	0	0	0	0	1	0	0	1	1	0	0	0
02.01.2025 00:00	109	Davis J.	WAS	0	0	0	100	0	1	0	0	0	1	0	0	-2	0	0	0	0	0	0	0	0
31.12.2024 00:00	110	Valanciunas J.	WAS	22	8	2	1258	10	13	0	0	1	2	1	1	-7	5	3	4	0	1	1	0	0
31.12.2024 00:00	111	Brogdon M.	WAS	18	6	7	1723	5	11	0	0	1	4	7	7	-15	2	4	1	2	2	0	0	0
31.12.2024 00:00	112	Sarr A.	WAS	18	4	0	1514	7	13	0	0	3	6	1	2	-9	1	3	4	0	2	1	0	0
31.12.2024 00:00	113	Kispert C.	WAS	16	2	1	1389	6	10	0	0	3	6	1	2	-6	2	0	1	1	1	0	0	0
31.12.2024 00:00	114	Kuzma K.	WAS	9	3	3	1255	4	9	0	0	0	3	1	4	4	1	2	3	1	2	0	0	0
31.12.2024 00:00	115	Carrington C.	WAS	6	5	5	1660	2	6	0	0	2	5	0	0	0	0	5	2	1	0	0	0	0
31.12.2024 00:00	116	Coulibaly B.	WAS	6	3	6	1873	1	10	0	0	0	4	4	4	-9	0	3	1	0	2	3	0	0
31.12.2024 00:00	117	George K.	WAS	4	5	0	1502	1	6	0	0	1	5	1	2	-16	0	5	2	0	2	1	0	0
31.12.2024 00:00	118	Champagnie J.	WAS	3	8	0	1498	1	8	0	0	1	6	0	0	-17	0	8	5	1	1	2	0	0
31.12.2024 00:00	119	Butler J.	WAS	2	0	1	296	1	2	0	0	0	0	0	0	-9	0	0	0	0	0	0	0	0
31.12.2024 00:00	120	Gill A.	WAS	2	2	0	108	1	1	0	0	0	0	0	0	-4	1	1	0	0	0	0	0	0
31.12.2024 00:00	121	Baldwin P.	WAS	0	0	0	108	0	0	0	0	0	0	0	0	-4	0	0	0	0	0	0	0	0
31.12.2024 00:00	122	Davis J.	WAS	0	0	0	108	0	2	0	0	0	1	0	0	-4	0	0	0	0	0	0	0	0
31.12.2024 00:00	123	Vukcevic T.	WAS	0	0	0	108	0	1	0	0	0	1	0	0	-4	0	0	0	0	0	0	0	0
29.12.2024 00:00	124	Champagnie J.	WAS	31	10	1	2681	13	15	0	0	5	6	0	0	-4	4	6	4	2	3	0	0	0
29.12.2024 00:00	125	Brogdon M.	WAS	22	3	7	1810	6	15	0	0	3	7	7	8	-3	1	2	2	1	5	0	0	0
29.12.2024 00:00	126	Coulibaly B.	WAS	18	6	6	2207	8	17	0	0	2	4	0	1	0	1	5	5	2	2	1	0	0
29.12.2024 00:00	127	Carrington C.	WAS	17	5	5	2600	8	13	0	0	1	4	0	0	3	0	5	2	0	1	0	0	0
29.12.2024 00:00	128	George K.	WAS	13	3	3	2050	5	11	0	0	3	7	0	0	-3	1	2	3	0	0	1	0	0
29.12.2024 00:00	129	Sarr A.	WAS	12	6	5	1908	3	10	0	0	2	4	4	4	2	2	4	4	0	2	1	0	0
29.12.2024 00:00	130	Kispert C.	WAS	11	3	2	1370	4	9	0	0	1	6	2	2	-7	1	2	0	1	1	0	0	0
29.12.2024 00:00	131	Valanciunas J.	WAS	8	8	3	1274	4	9	0	0	0	0	0	0	-8	1	7	2	1	1	1	0	0
27.12.2024 00:00	132	Poole J.	WAS	25	6	3	2125	7	19	0	0	5	15	6	7	12	2	4	2	1	1	2	0	0
27.12.2024 00:00	133	Coulibaly B.	WAS	20	6	5	1879	6	16	0	0	2	7	6	8	4	0	6	2	0	1	0	0	0
27.12.2024 00:00	134	Sarr A.	WAS	15	3	1	1473	6	11	0	0	3	6	0	2	1	1	2	2	1	1	3	0	0
27.12.2024 00:00	135	Valanciunas J.	WAS	14	12	3	1407	5	8	0	0	0	1	4	4	2	2	10	3	3	2	0	0	0
27.12.2024 00:00	136	Kispert C.	WAS	13	2	2	1818	5	9	0	0	2	6	1	1	1	0	2	2	0	2	0	0	0
27.12.2024 00:00	137	Brogdon M.	WAS	11	3	6	1798	4	13	0	0	0	2	3	4	9	0	3	0	2	1	0	0	0
27.12.2024 00:00	138	Champagnie J.	WAS	8	6	0	796	3	4	0	0	1	2	1	2	-10	2	4	2	1	2	2	0	0
27.12.2024 00:00	139	Carrington C.	WAS	7	1	3	1692	3	6	0	0	1	2	0	0	-7	0	1	4	0	1	0	0	0
27.12.2024 00:00	140	George K.	WAS	0	4	2	1412	0	5	0	0	0	3	0	0	3	1	3	2	1	0	0	0	0
\.


--
-- Data for Name: washington_wizards_lesoes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.washington_wizards_lesoes (id, player_name, injury_status, date) FROM stdin;
1	Brogdon Malcolm	Lesionado	2025-01-17 13:56:06.422113
2	Bagley Marvin	Lesionado	2025-01-17 13:56:06.424166
3	Bey Saddiq	Lesionado	2025-01-17 13:56:06.425512
\.


--
-- Name: atlanta_hawks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.atlanta_hawks_id_seq', 50, true);


--
-- Name: atlanta_hawks_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.atlanta_hawks_jogadores_id_seq', 120, true);


--
-- Name: atlanta_hawks_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.atlanta_hawks_lesoes_id_seq', 6, true);


--
-- Name: bankrolls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.bankrolls_id_seq', 1, false);


--
-- Name: bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.bets_id_seq', 50, true);


--
-- Name: betting_plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.betting_plans_id_seq', 1, true);


--
-- Name: boston_celtics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.boston_celtics_id_seq', 50, true);


--
-- Name: boston_celtics_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.boston_celtics_jogadores_id_seq', 129, true);


--
-- Name: boston_celtics_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.boston_celtics_lesoes_id_seq', 1, false);


--
-- Name: brooklyn_nets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.brooklyn_nets_id_seq', 52, true);


--
-- Name: brooklyn_nets_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.brooklyn_nets_jogadores_id_seq', 118, true);


--
-- Name: brooklyn_nets_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.brooklyn_nets_lesoes_id_seq', 7, true);


--
-- Name: charlotte_hornets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.charlotte_hornets_id_seq', 48, true);


--
-- Name: charlotte_hornets_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.charlotte_hornets_jogadores_id_seq', 131, true);


--
-- Name: charlotte_hornets_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.charlotte_hornets_lesoes_id_seq', 2, true);


--
-- Name: chicago_bulls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.chicago_bulls_id_seq', 51, true);


--
-- Name: chicago_bulls_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.chicago_bulls_jogadores_id_seq', 138, true);


--
-- Name: chicago_bulls_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.chicago_bulls_lesoes_id_seq', 4, true);


--
-- Name: cleveland_cavaliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.cleveland_cavaliers_id_seq', 50, true);


--
-- Name: cleveland_cavaliers_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.cleveland_cavaliers_jogadores_id_seq', 141, true);


--
-- Name: cleveland_cavaliers_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.cleveland_cavaliers_lesoes_id_seq', 3, true);


--
-- Name: dallas_mavericks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.dallas_mavericks_id_seq', 51, true);


--
-- Name: dallas_mavericks_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.dallas_mavericks_jogadores_id_seq', 138, true);


--
-- Name: dallas_mavericks_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.dallas_mavericks_lesoes_id_seq', 4, true);


--
-- Name: denver_nuggets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.denver_nuggets_id_seq', 52, true);


--
-- Name: denver_nuggets_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.denver_nuggets_jogadores_id_seq', 129, true);


--
-- Name: denver_nuggets_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.denver_nuggets_lesoes_id_seq', 3, true);


--
-- Name: detroit_pistons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.detroit_pistons_id_seq', 52, true);


--
-- Name: detroit_pistons_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.detroit_pistons_jogadores_id_seq', 128, true);


--
-- Name: detroit_pistons_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.detroit_pistons_lesoes_id_seq', 1, true);


--
-- Name: golden_state_warriors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.golden_state_warriors_id_seq', 51, true);


--
-- Name: golden_state_warriors_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.golden_state_warriors_jogadores_id_seq', 128, true);


--
-- Name: golden_state_warriors_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.golden_state_warriors_lesoes_id_seq', 6, true);


--
-- Name: houston_rockets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.houston_rockets_id_seq', 51, true);


--
-- Name: houston_rockets_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.houston_rockets_jogadores_id_seq', 124, true);


--
-- Name: houston_rockets_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.houston_rockets_lesoes_id_seq', 2, true);


--
-- Name: indiana_pacers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.indiana_pacers_id_seq', 51, true);


--
-- Name: indiana_pacers_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.indiana_pacers_jogadores_id_seq', 134, true);


--
-- Name: indiana_pacers_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.indiana_pacers_lesoes_id_seq', 5, true);


--
-- Name: links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.links_id_seq', 550, true);


--
-- Name: los_angeles_clippers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.los_angeles_clippers_id_seq', 49, true);


--
-- Name: los_angeles_clippers_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.los_angeles_clippers_jogadores_id_seq', 134, true);


--
-- Name: los_angeles_clippers_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.los_angeles_clippers_lesoes_id_seq', 1, true);


--
-- Name: los_angeles_lakers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.los_angeles_lakers_id_seq', 49, true);


--
-- Name: los_angeles_lakers_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.los_angeles_lakers_jogadores_id_seq', 117, true);


--
-- Name: los_angeles_lakers_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.los_angeles_lakers_lesoes_id_seq', 6, true);


--
-- Name: memphis_grizzlies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.memphis_grizzlies_id_seq', 50, true);


--
-- Name: memphis_grizzlies_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.memphis_grizzlies_jogadores_id_seq', 126, true);


--
-- Name: memphis_grizzlies_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.memphis_grizzlies_lesoes_id_seq', 5, true);


--
-- Name: miami_heat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.miami_heat_id_seq', 51, true);


--
-- Name: miami_heat_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.miami_heat_jogadores_id_seq', 122, true);


--
-- Name: miami_heat_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.miami_heat_lesoes_id_seq', 5, true);


--
-- Name: milwaukee_bucks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.milwaukee_bucks_id_seq', 51, true);


--
-- Name: milwaukee_bucks_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.milwaukee_bucks_jogadores_id_seq', 139, true);


--
-- Name: milwaukee_bucks_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.milwaukee_bucks_lesoes_id_seq', 2, true);


--
-- Name: minnesota_timberwolves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.minnesota_timberwolves_id_seq', 51, true);


--
-- Name: minnesota_timberwolves_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.minnesota_timberwolves_jogadores_id_seq', 114, true);


--
-- Name: minnesota_timberwolves_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.minnesota_timberwolves_lesoes_id_seq', 1, true);


--
-- Name: nba_classificacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.nba_classificacao_id_seq', 30, true);


--
-- Name: new_orleans_pelicans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.new_orleans_pelicans_id_seq', 52, true);


--
-- Name: new_orleans_pelicans_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.new_orleans_pelicans_jogadores_id_seq', 120, true);


--
-- Name: new_orleans_pelicans_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.new_orleans_pelicans_lesoes_id_seq', 3, true);


--
-- Name: new_york_knicks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.new_york_knicks_id_seq', 52, true);


--
-- Name: new_york_knicks_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.new_york_knicks_jogadores_id_seq', 123, true);


--
-- Name: new_york_knicks_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.new_york_knicks_lesoes_id_seq', 6, true);


--
-- Name: odds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.odds_id_seq', 15, true);


--
-- Name: oklahoma_city_thunder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.oklahoma_city_thunder_id_seq', 51, true);


--
-- Name: oklahoma_city_thunder_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.oklahoma_city_thunder_jogadores_id_seq', 132, true);


--
-- Name: oklahoma_city_thunder_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.oklahoma_city_thunder_lesoes_id_seq', 4, true);


--
-- Name: orlando_magic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.orlando_magic_id_seq', 51, true);


--
-- Name: orlando_magic_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.orlando_magic_jogadores_id_seq', 129, true);


--
-- Name: orlando_magic_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.orlando_magic_lesoes_id_seq', 6, true);


--
-- Name: philadelphia_76ers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.philadelphia_76ers_id_seq', 52, true);


--
-- Name: philadelphia_76ers_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.philadelphia_76ers_jogadores_id_seq', 121, true);


--
-- Name: philadelphia_76ers_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.philadelphia_76ers_lesoes_id_seq', 4, true);


--
-- Name: phoenix_suns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.phoenix_suns_id_seq', 51, true);


--
-- Name: phoenix_suns_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.phoenix_suns_jogadores_id_seq', 122, true);


--
-- Name: phoenix_suns_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.phoenix_suns_lesoes_id_seq', 3, true);


--
-- Name: portland_trail_blazers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.portland_trail_blazers_id_seq', 51, true);


--
-- Name: portland_trail_blazers_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.portland_trail_blazers_jogadores_id_seq', 126, true);


--
-- Name: portland_trail_blazers_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.portland_trail_blazers_lesoes_id_seq', 4, true);


--
-- Name: sacramento_kings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.sacramento_kings_id_seq', 50, true);


--
-- Name: sacramento_kings_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.sacramento_kings_jogadores_id_seq', 126, true);


--
-- Name: sacramento_kings_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.sacramento_kings_lesoes_id_seq', 1, true);


--
-- Name: san_antonio_spurs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.san_antonio_spurs_id_seq', 49, true);


--
-- Name: san_antonio_spurs_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.san_antonio_spurs_jogadores_id_seq', 133, true);


--
-- Name: san_antonio_spurs_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.san_antonio_spurs_lesoes_id_seq', 2, true);


--
-- Name: toronto_raptors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.toronto_raptors_id_seq', 51, true);


--
-- Name: toronto_raptors_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.toronto_raptors_jogadores_id_seq', 139, true);


--
-- Name: toronto_raptors_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.toronto_raptors_lesoes_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: utah_jazz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.utah_jazz_id_seq', 51, true);


--
-- Name: utah_jazz_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.utah_jazz_jogadores_id_seq', 123, true);


--
-- Name: utah_jazz_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.utah_jazz_lesoes_id_seq', 7, true);


--
-- Name: washington_wizards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.washington_wizards_id_seq', 52, true);


--
-- Name: washington_wizards_jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.washington_wizards_jogadores_id_seq', 140, true);


--
-- Name: washington_wizards_lesoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.washington_wizards_lesoes_id_seq', 3, true);


--
-- Name: atlanta_hawks_jogadores atlanta_hawks_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.atlanta_hawks_jogadores
    ADD CONSTRAINT atlanta_hawks_jogadores_pkey PRIMARY KEY (id);


--
-- Name: atlanta_hawks_lesoes atlanta_hawks_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.atlanta_hawks_lesoes
    ADD CONSTRAINT atlanta_hawks_lesoes_pkey PRIMARY KEY (id);


--
-- Name: atlanta_hawks atlanta_hawks_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.atlanta_hawks
    ADD CONSTRAINT atlanta_hawks_pkey PRIMARY KEY (id);


--
-- Name: bankrolls bankrolls_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.bankrolls
    ADD CONSTRAINT bankrolls_pkey PRIMARY KEY (id);


--
-- Name: bets bets_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.bets
    ADD CONSTRAINT bets_pkey PRIMARY KEY (id);


--
-- Name: betting_plans betting_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.betting_plans
    ADD CONSTRAINT betting_plans_pkey PRIMARY KEY (id);


--
-- Name: boston_celtics_jogadores boston_celtics_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.boston_celtics_jogadores
    ADD CONSTRAINT boston_celtics_jogadores_pkey PRIMARY KEY (id);


--
-- Name: boston_celtics_lesoes boston_celtics_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.boston_celtics_lesoes
    ADD CONSTRAINT boston_celtics_lesoes_pkey PRIMARY KEY (id);


--
-- Name: boston_celtics boston_celtics_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.boston_celtics
    ADD CONSTRAINT boston_celtics_pkey PRIMARY KEY (id);


--
-- Name: brooklyn_nets_jogadores brooklyn_nets_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.brooklyn_nets_jogadores
    ADD CONSTRAINT brooklyn_nets_jogadores_pkey PRIMARY KEY (id);


--
-- Name: brooklyn_nets_lesoes brooklyn_nets_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.brooklyn_nets_lesoes
    ADD CONSTRAINT brooklyn_nets_lesoes_pkey PRIMARY KEY (id);


--
-- Name: brooklyn_nets brooklyn_nets_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.brooklyn_nets
    ADD CONSTRAINT brooklyn_nets_pkey PRIMARY KEY (id);


--
-- Name: charlotte_hornets_jogadores charlotte_hornets_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.charlotte_hornets_jogadores
    ADD CONSTRAINT charlotte_hornets_jogadores_pkey PRIMARY KEY (id);


--
-- Name: charlotte_hornets_lesoes charlotte_hornets_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.charlotte_hornets_lesoes
    ADD CONSTRAINT charlotte_hornets_lesoes_pkey PRIMARY KEY (id);


--
-- Name: charlotte_hornets charlotte_hornets_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.charlotte_hornets
    ADD CONSTRAINT charlotte_hornets_pkey PRIMARY KEY (id);


--
-- Name: chicago_bulls_jogadores chicago_bulls_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.chicago_bulls_jogadores
    ADD CONSTRAINT chicago_bulls_jogadores_pkey PRIMARY KEY (id);


--
-- Name: chicago_bulls_lesoes chicago_bulls_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.chicago_bulls_lesoes
    ADD CONSTRAINT chicago_bulls_lesoes_pkey PRIMARY KEY (id);


--
-- Name: chicago_bulls chicago_bulls_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.chicago_bulls
    ADD CONSTRAINT chicago_bulls_pkey PRIMARY KEY (id);


--
-- Name: cleveland_cavaliers_jogadores cleveland_cavaliers_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.cleveland_cavaliers_jogadores
    ADD CONSTRAINT cleveland_cavaliers_jogadores_pkey PRIMARY KEY (id);


--
-- Name: cleveland_cavaliers_lesoes cleveland_cavaliers_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.cleveland_cavaliers_lesoes
    ADD CONSTRAINT cleveland_cavaliers_lesoes_pkey PRIMARY KEY (id);


--
-- Name: cleveland_cavaliers cleveland_cavaliers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.cleveland_cavaliers
    ADD CONSTRAINT cleveland_cavaliers_pkey PRIMARY KEY (id);


--
-- Name: dallas_mavericks_jogadores dallas_mavericks_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.dallas_mavericks_jogadores
    ADD CONSTRAINT dallas_mavericks_jogadores_pkey PRIMARY KEY (id);


--
-- Name: dallas_mavericks_lesoes dallas_mavericks_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.dallas_mavericks_lesoes
    ADD CONSTRAINT dallas_mavericks_lesoes_pkey PRIMARY KEY (id);


--
-- Name: dallas_mavericks dallas_mavericks_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.dallas_mavericks
    ADD CONSTRAINT dallas_mavericks_pkey PRIMARY KEY (id);


--
-- Name: denver_nuggets_jogadores denver_nuggets_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.denver_nuggets_jogadores
    ADD CONSTRAINT denver_nuggets_jogadores_pkey PRIMARY KEY (id);


--
-- Name: denver_nuggets_lesoes denver_nuggets_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.denver_nuggets_lesoes
    ADD CONSTRAINT denver_nuggets_lesoes_pkey PRIMARY KEY (id);


--
-- Name: denver_nuggets denver_nuggets_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.denver_nuggets
    ADD CONSTRAINT denver_nuggets_pkey PRIMARY KEY (id);


--
-- Name: detroit_pistons_jogadores detroit_pistons_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.detroit_pistons_jogadores
    ADD CONSTRAINT detroit_pistons_jogadores_pkey PRIMARY KEY (id);


--
-- Name: detroit_pistons_lesoes detroit_pistons_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.detroit_pistons_lesoes
    ADD CONSTRAINT detroit_pistons_lesoes_pkey PRIMARY KEY (id);


--
-- Name: detroit_pistons detroit_pistons_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.detroit_pistons
    ADD CONSTRAINT detroit_pistons_pkey PRIMARY KEY (id);


--
-- Name: golden_state_warriors_jogadores golden_state_warriors_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.golden_state_warriors_jogadores
    ADD CONSTRAINT golden_state_warriors_jogadores_pkey PRIMARY KEY (id);


--
-- Name: golden_state_warriors_lesoes golden_state_warriors_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.golden_state_warriors_lesoes
    ADD CONSTRAINT golden_state_warriors_lesoes_pkey PRIMARY KEY (id);


--
-- Name: golden_state_warriors golden_state_warriors_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.golden_state_warriors
    ADD CONSTRAINT golden_state_warriors_pkey PRIMARY KEY (id);


--
-- Name: houston_rockets_jogadores houston_rockets_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.houston_rockets_jogadores
    ADD CONSTRAINT houston_rockets_jogadores_pkey PRIMARY KEY (id);


--
-- Name: houston_rockets_lesoes houston_rockets_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.houston_rockets_lesoes
    ADD CONSTRAINT houston_rockets_lesoes_pkey PRIMARY KEY (id);


--
-- Name: houston_rockets houston_rockets_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.houston_rockets
    ADD CONSTRAINT houston_rockets_pkey PRIMARY KEY (id);


--
-- Name: indiana_pacers_jogadores indiana_pacers_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.indiana_pacers_jogadores
    ADD CONSTRAINT indiana_pacers_jogadores_pkey PRIMARY KEY (id);


--
-- Name: indiana_pacers_lesoes indiana_pacers_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.indiana_pacers_lesoes
    ADD CONSTRAINT indiana_pacers_lesoes_pkey PRIMARY KEY (id);


--
-- Name: indiana_pacers indiana_pacers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.indiana_pacers
    ADD CONSTRAINT indiana_pacers_pkey PRIMARY KEY (id);


--
-- Name: links links_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- Name: los_angeles_clippers_jogadores los_angeles_clippers_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.los_angeles_clippers_jogadores
    ADD CONSTRAINT los_angeles_clippers_jogadores_pkey PRIMARY KEY (id);


--
-- Name: los_angeles_clippers_lesoes los_angeles_clippers_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.los_angeles_clippers_lesoes
    ADD CONSTRAINT los_angeles_clippers_lesoes_pkey PRIMARY KEY (id);


--
-- Name: los_angeles_clippers los_angeles_clippers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.los_angeles_clippers
    ADD CONSTRAINT los_angeles_clippers_pkey PRIMARY KEY (id);


--
-- Name: los_angeles_lakers_jogadores los_angeles_lakers_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.los_angeles_lakers_jogadores
    ADD CONSTRAINT los_angeles_lakers_jogadores_pkey PRIMARY KEY (id);


--
-- Name: los_angeles_lakers_lesoes los_angeles_lakers_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.los_angeles_lakers_lesoes
    ADD CONSTRAINT los_angeles_lakers_lesoes_pkey PRIMARY KEY (id);


--
-- Name: los_angeles_lakers los_angeles_lakers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.los_angeles_lakers
    ADD CONSTRAINT los_angeles_lakers_pkey PRIMARY KEY (id);


--
-- Name: memphis_grizzlies_jogadores memphis_grizzlies_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.memphis_grizzlies_jogadores
    ADD CONSTRAINT memphis_grizzlies_jogadores_pkey PRIMARY KEY (id);


--
-- Name: memphis_grizzlies_lesoes memphis_grizzlies_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.memphis_grizzlies_lesoes
    ADD CONSTRAINT memphis_grizzlies_lesoes_pkey PRIMARY KEY (id);


--
-- Name: memphis_grizzlies memphis_grizzlies_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.memphis_grizzlies
    ADD CONSTRAINT memphis_grizzlies_pkey PRIMARY KEY (id);


--
-- Name: miami_heat_jogadores miami_heat_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.miami_heat_jogadores
    ADD CONSTRAINT miami_heat_jogadores_pkey PRIMARY KEY (id);


--
-- Name: miami_heat_lesoes miami_heat_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.miami_heat_lesoes
    ADD CONSTRAINT miami_heat_lesoes_pkey PRIMARY KEY (id);


--
-- Name: miami_heat miami_heat_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.miami_heat
    ADD CONSTRAINT miami_heat_pkey PRIMARY KEY (id);


--
-- Name: milwaukee_bucks_jogadores milwaukee_bucks_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.milwaukee_bucks_jogadores
    ADD CONSTRAINT milwaukee_bucks_jogadores_pkey PRIMARY KEY (id);


--
-- Name: milwaukee_bucks_lesoes milwaukee_bucks_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.milwaukee_bucks_lesoes
    ADD CONSTRAINT milwaukee_bucks_lesoes_pkey PRIMARY KEY (id);


--
-- Name: milwaukee_bucks milwaukee_bucks_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.milwaukee_bucks
    ADD CONSTRAINT milwaukee_bucks_pkey PRIMARY KEY (id);


--
-- Name: minnesota_timberwolves_jogadores minnesota_timberwolves_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.minnesota_timberwolves_jogadores
    ADD CONSTRAINT minnesota_timberwolves_jogadores_pkey PRIMARY KEY (id);


--
-- Name: minnesota_timberwolves_lesoes minnesota_timberwolves_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.minnesota_timberwolves_lesoes
    ADD CONSTRAINT minnesota_timberwolves_lesoes_pkey PRIMARY KEY (id);


--
-- Name: minnesota_timberwolves minnesota_timberwolves_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.minnesota_timberwolves
    ADD CONSTRAINT minnesota_timberwolves_pkey PRIMARY KEY (id);


--
-- Name: nba_classificacao nba_classificacao_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.nba_classificacao
    ADD CONSTRAINT nba_classificacao_pkey PRIMARY KEY (id);


--
-- Name: new_orleans_pelicans_jogadores new_orleans_pelicans_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.new_orleans_pelicans_jogadores
    ADD CONSTRAINT new_orleans_pelicans_jogadores_pkey PRIMARY KEY (id);


--
-- Name: new_orleans_pelicans_lesoes new_orleans_pelicans_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.new_orleans_pelicans_lesoes
    ADD CONSTRAINT new_orleans_pelicans_lesoes_pkey PRIMARY KEY (id);


--
-- Name: new_orleans_pelicans new_orleans_pelicans_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.new_orleans_pelicans
    ADD CONSTRAINT new_orleans_pelicans_pkey PRIMARY KEY (id);


--
-- Name: new_york_knicks_jogadores new_york_knicks_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.new_york_knicks_jogadores
    ADD CONSTRAINT new_york_knicks_jogadores_pkey PRIMARY KEY (id);


--
-- Name: new_york_knicks_lesoes new_york_knicks_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.new_york_knicks_lesoes
    ADD CONSTRAINT new_york_knicks_lesoes_pkey PRIMARY KEY (id);


--
-- Name: new_york_knicks new_york_knicks_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.new_york_knicks
    ADD CONSTRAINT new_york_knicks_pkey PRIMARY KEY (id);


--
-- Name: odds odds_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.odds
    ADD CONSTRAINT odds_pkey PRIMARY KEY (id);


--
-- Name: oklahoma_city_thunder_jogadores oklahoma_city_thunder_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.oklahoma_city_thunder_jogadores
    ADD CONSTRAINT oklahoma_city_thunder_jogadores_pkey PRIMARY KEY (id);


--
-- Name: oklahoma_city_thunder_lesoes oklahoma_city_thunder_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.oklahoma_city_thunder_lesoes
    ADD CONSTRAINT oklahoma_city_thunder_lesoes_pkey PRIMARY KEY (id);


--
-- Name: oklahoma_city_thunder oklahoma_city_thunder_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.oklahoma_city_thunder
    ADD CONSTRAINT oklahoma_city_thunder_pkey PRIMARY KEY (id);


--
-- Name: orlando_magic_jogadores orlando_magic_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.orlando_magic_jogadores
    ADD CONSTRAINT orlando_magic_jogadores_pkey PRIMARY KEY (id);


--
-- Name: orlando_magic_lesoes orlando_magic_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.orlando_magic_lesoes
    ADD CONSTRAINT orlando_magic_lesoes_pkey PRIMARY KEY (id);


--
-- Name: orlando_magic orlando_magic_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.orlando_magic
    ADD CONSTRAINT orlando_magic_pkey PRIMARY KEY (id);


--
-- Name: philadelphia_76ers_jogadores philadelphia_76ers_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.philadelphia_76ers_jogadores
    ADD CONSTRAINT philadelphia_76ers_jogadores_pkey PRIMARY KEY (id);


--
-- Name: philadelphia_76ers_lesoes philadelphia_76ers_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.philadelphia_76ers_lesoes
    ADD CONSTRAINT philadelphia_76ers_lesoes_pkey PRIMARY KEY (id);


--
-- Name: philadelphia_76ers philadelphia_76ers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.philadelphia_76ers
    ADD CONSTRAINT philadelphia_76ers_pkey PRIMARY KEY (id);


--
-- Name: phoenix_suns_jogadores phoenix_suns_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.phoenix_suns_jogadores
    ADD CONSTRAINT phoenix_suns_jogadores_pkey PRIMARY KEY (id);


--
-- Name: phoenix_suns_lesoes phoenix_suns_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.phoenix_suns_lesoes
    ADD CONSTRAINT phoenix_suns_lesoes_pkey PRIMARY KEY (id);


--
-- Name: phoenix_suns phoenix_suns_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.phoenix_suns
    ADD CONSTRAINT phoenix_suns_pkey PRIMARY KEY (id);


--
-- Name: portland_trail_blazers_jogadores portland_trail_blazers_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.portland_trail_blazers_jogadores
    ADD CONSTRAINT portland_trail_blazers_jogadores_pkey PRIMARY KEY (id);


--
-- Name: portland_trail_blazers_lesoes portland_trail_blazers_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.portland_trail_blazers_lesoes
    ADD CONSTRAINT portland_trail_blazers_lesoes_pkey PRIMARY KEY (id);


--
-- Name: portland_trail_blazers portland_trail_blazers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.portland_trail_blazers
    ADD CONSTRAINT portland_trail_blazers_pkey PRIMARY KEY (id);


--
-- Name: sacramento_kings_jogadores sacramento_kings_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.sacramento_kings_jogadores
    ADD CONSTRAINT sacramento_kings_jogadores_pkey PRIMARY KEY (id);


--
-- Name: sacramento_kings_lesoes sacramento_kings_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.sacramento_kings_lesoes
    ADD CONSTRAINT sacramento_kings_lesoes_pkey PRIMARY KEY (id);


--
-- Name: sacramento_kings sacramento_kings_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.sacramento_kings
    ADD CONSTRAINT sacramento_kings_pkey PRIMARY KEY (id);


--
-- Name: san_antonio_spurs_jogadores san_antonio_spurs_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.san_antonio_spurs_jogadores
    ADD CONSTRAINT san_antonio_spurs_jogadores_pkey PRIMARY KEY (id);


--
-- Name: san_antonio_spurs_lesoes san_antonio_spurs_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.san_antonio_spurs_lesoes
    ADD CONSTRAINT san_antonio_spurs_lesoes_pkey PRIMARY KEY (id);


--
-- Name: san_antonio_spurs san_antonio_spurs_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.san_antonio_spurs
    ADD CONSTRAINT san_antonio_spurs_pkey PRIMARY KEY (id);


--
-- Name: toronto_raptors_jogadores toronto_raptors_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.toronto_raptors_jogadores
    ADD CONSTRAINT toronto_raptors_jogadores_pkey PRIMARY KEY (id);


--
-- Name: toronto_raptors_lesoes toronto_raptors_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.toronto_raptors_lesoes
    ADD CONSTRAINT toronto_raptors_lesoes_pkey PRIMARY KEY (id);


--
-- Name: toronto_raptors toronto_raptors_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.toronto_raptors
    ADD CONSTRAINT toronto_raptors_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: utah_jazz_jogadores utah_jazz_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.utah_jazz_jogadores
    ADD CONSTRAINT utah_jazz_jogadores_pkey PRIMARY KEY (id);


--
-- Name: utah_jazz_lesoes utah_jazz_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.utah_jazz_lesoes
    ADD CONSTRAINT utah_jazz_lesoes_pkey PRIMARY KEY (id);


--
-- Name: utah_jazz utah_jazz_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.utah_jazz
    ADD CONSTRAINT utah_jazz_pkey PRIMARY KEY (id);


--
-- Name: washington_wizards_jogadores washington_wizards_jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.washington_wizards_jogadores
    ADD CONSTRAINT washington_wizards_jogadores_pkey PRIMARY KEY (id);


--
-- Name: washington_wizards_lesoes washington_wizards_lesoes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.washington_wizards_lesoes
    ADD CONSTRAINT washington_wizards_lesoes_pkey PRIMARY KEY (id);


--
-- Name: washington_wizards washington_wizards_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

-- ALTER TABLE ONLY public.washington_wizards
    ADD CONSTRAINT washington_wizards_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

