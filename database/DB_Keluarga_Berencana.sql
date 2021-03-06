PGDMP         7                 x            DB_Keluarga_Berencana    12.1    12.1                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                        0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            !           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            "           1262    32957    DB_Keluarga_Berencana    DATABASE     ?   CREATE DATABASE "DB_Keluarga_Berencana" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Indonesian_Indonesia.1252' LC_CTYPE = 'Indonesian_Indonesia.1252';
 '   DROP DATABASE "DB_Keluarga_Berencana";
                postgres    false            ?            1255    33009    funcGetDataReport()    FUNCTION     a  CREATE FUNCTION public."funcGetDataReport"() RETURNS TABLE(row_number integer, nama_propinsi character varying, pil bigint, kondom bigint, iud bigint, jumlah bigint)
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN QUERY
		select * from 
	(
		select a."Id_Propinsi" as ROW_NUMBER,a."Nama_Propinsi", SUM(case when(b."Id_Kontrasepsi" = 1) then b."Jumlah_Pemakai" else 0 end) as Pil,
			SUM(case when(b."Id_Kontrasepsi" = 2) then b."Jumlah_Pemakai" else 0 end) as Kondom,
			SUM(case when(b."Id_Kontrasepsi" = 3) then b."Jumlah_Pemakai" else 0 end) as IUD,
			COALESCE(SUM("Jumlah_Pemakai"), 0) as Jumlah
		from "LIST_PROPINSI" a 
		left join "LIST_PEMAKAI_KONTRASEPSI" b on a."Id_Propinsi" = b."Id_Propinsi" 
		left join "LIST_KONTRASEPSI" c on b."Id_Kontrasepsi" = c."Id_Kontrasepsi" 
		group by a."Id_Propinsi", a."Nama_Propinsi"
	) a
	order by ROW_NUMBER asc;

END
$$;
 ,   DROP FUNCTION public."funcGetDataReport"();
       public          postgres    false            ?            1255    33004 .   proctransactionsave(integer, integer, integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.proctransactionsave(integer, integer, integer)
    LANGUAGE plpgsql
    AS $_$
BEGIN
   insert into "LIST_PEMAKAI_KONTRASEPSI"
   	("Id_Propinsi", "Id_Kontrasepsi", "Jumlah_Pemakai")
	values($1, $2, $3);
 
    COMMIT;
END;
$_$;
 F   DROP PROCEDURE public.proctransactionsave(integer, integer, integer);
       public          postgres    false            ?            1259    32968    LIST_KONTRASEPSI    TABLE     |   CREATE TABLE public."LIST_KONTRASEPSI" (
    "Id_Kontrasepsi" integer NOT NULL,
    "Nama_Kontrasepsi" character varying
);
 &   DROP TABLE public."LIST_KONTRASEPSI";
       public         heap    postgres    false            ?            1259    32966 #   LIST_KONTRASEPSI_Id_Kontrasepsi_seq    SEQUENCE     ?   CREATE SEQUENCE public."LIST_KONTRASEPSI_Id_Kontrasepsi_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public."LIST_KONTRASEPSI_Id_Kontrasepsi_seq";
       public          postgres    false    205            #           0    0 #   LIST_KONTRASEPSI_Id_Kontrasepsi_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public."LIST_KONTRASEPSI_Id_Kontrasepsi_seq" OWNED BY public."LIST_KONTRASEPSI"."Id_Kontrasepsi";
          public          postgres    false    204            ?            1259    32987    LIST_PEMAKAI_KONTRASEPSI    TABLE     ?   CREATE TABLE public."LIST_PEMAKAI_KONTRASEPSI" (
    "Id_List" integer NOT NULL,
    "Id_Propinsi" integer,
    "Id_Kontrasepsi" integer,
    "Jumlah_Pemakai" integer
);
 .   DROP TABLE public."LIST_PEMAKAI_KONTRASEPSI";
       public         heap    postgres    false            ?            1259    32985 $   LIST_PEMAKAI_KONTRASEPSI_Id_List_seq    SEQUENCE     ?   CREATE SEQUENCE public."LIST_PEMAKAI_KONTRASEPSI_Id_List_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public."LIST_PEMAKAI_KONTRASEPSI_Id_List_seq";
       public          postgres    false    207            $           0    0 $   LIST_PEMAKAI_KONTRASEPSI_Id_List_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public."LIST_PEMAKAI_KONTRASEPSI_Id_List_seq" OWNED BY public."LIST_PEMAKAI_KONTRASEPSI"."Id_List";
          public          postgres    false    206            ?            1259    32960    LIST_PROPINSI    TABLE     x   CREATE TABLE public."LIST_PROPINSI" (
    "Id_Propinsi" integer NOT NULL,
    "Nama_Propinsi" character varying(100)
);
 #   DROP TABLE public."LIST_PROPINSI";
       public         heap    postgres    false            ?            1259    32958    LIST_PROPINSI_Id_Propinsi_seq    SEQUENCE     ?   CREATE SEQUENCE public."LIST_PROPINSI_Id_Propinsi_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public."LIST_PROPINSI_Id_Propinsi_seq";
       public          postgres    false    203            %           0    0    LIST_PROPINSI_Id_Propinsi_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public."LIST_PROPINSI_Id_Propinsi_seq" OWNED BY public."LIST_PROPINSI"."Id_Propinsi";
          public          postgres    false    202            ?
           2604    32971    LIST_KONTRASEPSI Id_Kontrasepsi    DEFAULT     ?   ALTER TABLE ONLY public."LIST_KONTRASEPSI" ALTER COLUMN "Id_Kontrasepsi" SET DEFAULT nextval('public."LIST_KONTRASEPSI_Id_Kontrasepsi_seq"'::regclass);
 R   ALTER TABLE public."LIST_KONTRASEPSI" ALTER COLUMN "Id_Kontrasepsi" DROP DEFAULT;
       public          postgres    false    204    205    205            ?
           2604    32990     LIST_PEMAKAI_KONTRASEPSI Id_List    DEFAULT     ?   ALTER TABLE ONLY public."LIST_PEMAKAI_KONTRASEPSI" ALTER COLUMN "Id_List" SET DEFAULT nextval('public."LIST_PEMAKAI_KONTRASEPSI_Id_List_seq"'::regclass);
 S   ALTER TABLE public."LIST_PEMAKAI_KONTRASEPSI" ALTER COLUMN "Id_List" DROP DEFAULT;
       public          postgres    false    206    207    207            ?
           2604    32963    LIST_PROPINSI Id_Propinsi    DEFAULT     ?   ALTER TABLE ONLY public."LIST_PROPINSI" ALTER COLUMN "Id_Propinsi" SET DEFAULT nextval('public."LIST_PROPINSI_Id_Propinsi_seq"'::regclass);
 L   ALTER TABLE public."LIST_PROPINSI" ALTER COLUMN "Id_Propinsi" DROP DEFAULT;
       public          postgres    false    203    202    203                      0    32968    LIST_KONTRASEPSI 
   TABLE DATA           R   COPY public."LIST_KONTRASEPSI" ("Id_Kontrasepsi", "Nama_Kontrasepsi") FROM stdin;
    public          postgres    false    205   P(                 0    32987    LIST_PEMAKAI_KONTRASEPSI 
   TABLE DATA           r   COPY public."LIST_PEMAKAI_KONTRASEPSI" ("Id_List", "Id_Propinsi", "Id_Kontrasepsi", "Jumlah_Pemakai") FROM stdin;
    public          postgres    false    207   ?(                 0    32960    LIST_PROPINSI 
   TABLE DATA           I   COPY public."LIST_PROPINSI" ("Id_Propinsi", "Nama_Propinsi") FROM stdin;
    public          postgres    false    203   )       &           0    0 #   LIST_KONTRASEPSI_Id_Kontrasepsi_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public."LIST_KONTRASEPSI_Id_Kontrasepsi_seq"', 9, true);
          public          postgres    false    204            '           0    0 $   LIST_PEMAKAI_KONTRASEPSI_Id_List_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public."LIST_PEMAKAI_KONTRASEPSI_Id_List_seq"', 28, true);
          public          postgres    false    206            (           0    0    LIST_PROPINSI_Id_Propinsi_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public."LIST_PROPINSI_Id_Propinsi_seq"', 9, true);
          public          postgres    false    202            ?
           2606    32976 &   LIST_KONTRASEPSI LIST_KONTRASEPSI_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public."LIST_KONTRASEPSI"
    ADD CONSTRAINT "LIST_KONTRASEPSI_pkey" PRIMARY KEY ("Id_Kontrasepsi");
 T   ALTER TABLE ONLY public."LIST_KONTRASEPSI" DROP CONSTRAINT "LIST_KONTRASEPSI_pkey";
       public            postgres    false    205            ?
           2606    32992 6   LIST_PEMAKAI_KONTRASEPSI LIST_PEMAKAI_KONTRASEPSI_pkey 
   CONSTRAINT        ALTER TABLE ONLY public."LIST_PEMAKAI_KONTRASEPSI"
    ADD CONSTRAINT "LIST_PEMAKAI_KONTRASEPSI_pkey" PRIMARY KEY ("Id_List");
 d   ALTER TABLE ONLY public."LIST_PEMAKAI_KONTRASEPSI" DROP CONSTRAINT "LIST_PEMAKAI_KONTRASEPSI_pkey";
       public            postgres    false    207            ?
           2606    32965     LIST_PROPINSI LIST_PROPINSI_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public."LIST_PROPINSI"
    ADD CONSTRAINT "LIST_PROPINSI_pkey" PRIMARY KEY ("Id_Propinsi");
 N   ALTER TABLE ONLY public."LIST_PROPINSI" DROP CONSTRAINT "LIST_PROPINSI_pkey";
       public            postgres    false    203            ?
           2606    32993 E   LIST_PEMAKAI_KONTRASEPSI LIST_PEMAKAI_KONTRASEPSI_Id_Kontrasepsi_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."LIST_PEMAKAI_KONTRASEPSI"
    ADD CONSTRAINT "LIST_PEMAKAI_KONTRASEPSI_Id_Kontrasepsi_fkey" FOREIGN KEY ("Id_Kontrasepsi") REFERENCES public."LIST_KONTRASEPSI"("Id_Kontrasepsi") ON DELETE CASCADE;
 s   ALTER TABLE ONLY public."LIST_PEMAKAI_KONTRASEPSI" DROP CONSTRAINT "LIST_PEMAKAI_KONTRASEPSI_Id_Kontrasepsi_fkey";
       public          postgres    false    207    205    2708            ?
           2606    32998 B   LIST_PEMAKAI_KONTRASEPSI LIST_PEMAKAI_KONTRASEPSI_Id_Propinsi_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."LIST_PEMAKAI_KONTRASEPSI"
    ADD CONSTRAINT "LIST_PEMAKAI_KONTRASEPSI_Id_Propinsi_fkey" FOREIGN KEY ("Id_Propinsi") REFERENCES public."LIST_PROPINSI"("Id_Propinsi") ON DELETE CASCADE;
 p   ALTER TABLE ONLY public."LIST_PEMAKAI_KONTRASEPSI" DROP CONSTRAINT "LIST_PEMAKAI_KONTRASEPSI_Id_Propinsi_fkey";
       public          postgres    false    2706    207    203               "   x?3????2????K???2??u?????? W??         z   x?=?KCAб???ϣ?^??u?T??(???3??R?`???:'????qD??3?#?+???2????$3?J??M?@??/bq9P??Ay!]|???4áA?k?@?M?+2???(!          m   x?3?tLN??2?.?M,I-JT-I,J?2F8?%\&?A???\??ީ?9???y
`3N??ܤL.sN?ļ?l??Ԝ̒Ҽt.???9?%?y\??>?? ?=... ??&?     