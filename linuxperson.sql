--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

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

--
-- Name: linuxperson; Type: SCHEMA; Schema: -; Owner: linuxperson
--

CREATE SCHEMA linuxperson;


ALTER SCHEMA linuxperson OWNER TO linuxperson;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: linuxcommand; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxcommand (
    cid bigint NOT NULL,
    command character varying(128),
    args character varying(512),
    description character varying(512),
    detail text
);


ALTER TABLE linuxperson.linuxcommand OWNER TO linuxperson;

--
-- Name: linuxcommandandfilerelation; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxcommandandfilerelation (
    cid bigint,
    fid bigint
);


ALTER TABLE linuxperson.linuxcommandandfilerelation OWNER TO linuxperson;

--
-- Name: linuxcommandcurrentcid; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxcommandcurrentcid (
    current bigint
);


ALTER TABLE linuxperson.linuxcommandcurrentcid OWNER TO linuxperson;

--
-- Name: linuxcommandcurrentpid; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxcommandcurrentpid (
    current bigint
);


ALTER TABLE linuxperson.linuxcommandcurrentpid OWNER TO linuxperson;

--
-- Name: linuxcommandn_cid_seq; Type: SEQUENCE; Schema: linuxperson; Owner: linuxperson
--

CREATE SEQUENCE linuxperson.linuxcommandn_cid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE linuxperson.linuxcommandn_cid_seq OWNER TO linuxperson;

--
-- Name: linuxcommandn_cid_seq; Type: SEQUENCE OWNED BY; Schema: linuxperson; Owner: linuxperson
--

ALTER SEQUENCE linuxperson.linuxcommandn_cid_seq OWNED BY linuxperson.linuxcommand.cid;


--
-- Name: linuxcommandop; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxcommandop (
    cid bigint NOT NULL,
    oid integer NOT NULL,
    option character varying(255),
    description text
);


ALTER TABLE linuxperson.linuxcommandop OWNER TO linuxperson;

--
-- Name: linuxcommandotherchunk; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxcommandotherchunk (
    cid bigint,
    tid bigint,
    title character varying(255),
    description text
);


ALTER TABLE linuxperson.linuxcommandotherchunk OWNER TO linuxperson;

--
-- Name: linuxcommandotherchunktabledata; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxcommandotherchunktabledata (
    cid bigint,
    tid bigint,
    col integer,
    "row" integer,
    data text,
    issize character varying(1) DEFAULT 'F'::character varying,
    CONSTRAINT linuxcommandotherchunktabledata_issize_check CHECK ((((issize)::text = 'T'::text) OR ((issize)::text = 'F'::text)))
);


ALTER TABLE linuxperson.linuxcommandotherchunktabledata OWNER TO linuxperson;

--
-- Name: linuxcommandotherchunktableheader; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxcommandotherchunktableheader (
    cid bigint,
    tid bigint,
    header character varying(1024)
);


ALTER TABLE linuxperson.linuxcommandotherchunktableheader OWNER TO linuxperson;

--
-- Name: linuxcommandpage; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxcommandpage (
    pid bigint NOT NULL,
    pagename character varying(255),
    description text,
    detail text
);


ALTER TABLE linuxperson.linuxcommandpage OWNER TO linuxperson;

--
-- Name: linuxcommandpagen_pid_seq; Type: SEQUENCE; Schema: linuxperson; Owner: linuxperson
--

CREATE SEQUENCE linuxperson.linuxcommandpagen_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE linuxperson.linuxcommandpagen_pid_seq OWNER TO linuxperson;

--
-- Name: linuxcommandpagen_pid_seq; Type: SEQUENCE OWNED BY; Schema: linuxperson; Owner: linuxperson
--

ALTER SEQUENCE linuxperson.linuxcommandpagen_pid_seq OWNED BY linuxperson.linuxcommandpage.pid;


--
-- Name: linuxcommandpagerelation; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxcommandpagerelation (
    pid bigint NOT NULL,
    cid bigint NOT NULL
);


ALTER TABLE linuxperson.linuxcommandpagerelation OWNER TO linuxperson;

--
-- Name: linuxfile; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxfile (
    fid bigint NOT NULL,
    filepath character varying(256),
    description character varying(512),
    detail text
);


ALTER TABLE linuxperson.linuxfile OWNER TO linuxperson;

--
-- Name: linuxfile_fid_seq; Type: SEQUENCE; Schema: linuxperson; Owner: linuxperson
--

CREATE SEQUENCE linuxperson.linuxfile_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE linuxperson.linuxfile_fid_seq OWNER TO linuxperson;

--
-- Name: linuxfile_fid_seq; Type: SEQUENCE OWNED BY; Schema: linuxperson; Owner: linuxperson
--

ALTER SEQUENCE linuxperson.linuxfile_fid_seq OWNED BY linuxperson.linuxfile.fid;


--
-- Name: linuxfilecurrentfid; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxfilecurrentfid (
    current bigint
);


ALTER TABLE linuxperson.linuxfilecurrentfid OWNER TO linuxperson;

--
-- Name: linuxfileinfo; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxfileinfo (
    fid bigint,
    tid bigint,
    title character varying(255),
    description text
);


ALTER TABLE linuxperson.linuxfileinfo OWNER TO linuxperson;

--
-- Name: linuxfilepagerelation; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxfilepagerelation (
    fid bigint,
    pid bigint
);


ALTER TABLE linuxperson.linuxfilepagerelation OWNER TO linuxperson;

--
-- Name: linuxfiletabledata; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxfiletabledata (
    fid bigint,
    tid bigint,
    col integer,
    "row" integer,
    data text,
    issize character varying(1)
);


ALTER TABLE linuxperson.linuxfiletabledata OWNER TO linuxperson;

--
-- Name: linuxfiletableheader; Type: TABLE; Schema: linuxperson; Owner: linuxperson
--

CREATE TABLE linuxperson.linuxfiletableheader (
    fid bigint,
    tid bigint,
    header character varying(1024)
);


ALTER TABLE linuxperson.linuxfiletableheader OWNER TO linuxperson;

--
-- Name: linuxcommand cid; Type: DEFAULT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommand ALTER COLUMN cid SET DEFAULT nextval('linuxperson.linuxcommandn_cid_seq'::regclass);


--
-- Name: linuxcommandpage pid; Type: DEFAULT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandpage ALTER COLUMN pid SET DEFAULT nextval('linuxperson.linuxcommandpagen_pid_seq'::regclass);


--
-- Name: linuxfile fid; Type: DEFAULT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxfile ALTER COLUMN fid SET DEFAULT nextval('linuxperson.linuxfile_fid_seq'::regclass);


--
-- Data for Name: linuxcommand; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxcommand (cid, command, args, description, detail) FROM stdin;
188	ntpq			
189	logger			
190	mail			
19	cp	[オプション] <コピー対象> <コピー先>	ファイルやディレクトリのコピー	
20	mv	[オプション] <移動対象...> <移動先>	ファイル・ディレクトリの移動	
25	gzip	[オプション] <ファイル名...>	gz形式で圧縮を行う	
26	gunzip	[オプション] <圧縮ファイル>	gz形式のファイルを解凍する	
27	bzip2	[オプション] <ファイル>	bzip2形式で圧縮を行う	
31	unxz	<ファイル名>	xz形式を解凍する	
32	dd	<オペランド...> [オプション]	ファイルの取り込み、書き込みを行う	
6	history	[オプション]	コマンドの履歴を表示する	コマンドの履歴を確認するときに使うが、実行するときは<br><br>!履歴番号で行う<br><br>また履歴は履歴ファイルに保存され、上限行数に達することで自動的に若い番号から消えてゆく
7	source	<ファイル名>[引数[,…]]	スクリプトファイルを反映する	bashのスクリプトファイルを反映させ、また環境変数等を即座に反映させたいときによく用いる<br><br>またsourceのコマンド部分だけ.に変えるだけで実行でもできる
4	echo	[オプション...][文字列や変数など]...	標準出力を行う	echoコマンドは普通に使っても文字列を表示するだけであるが、変数の値を表示したいときや、あるファイルに追記したいときなど<br><br>演算子を組み合わせることで、ちょっとしたときに使える<br><br>
9	env	[オプション][一時有効環境変数名=値][コマンド]	環境変数を表示、設定をする 省略すると一覧が表示される	
2	whatis	<コマンド名>	概要部分だけ検索する	makewhatisコマンドを実行することで概要部分を更新してくれる
3	apropos	<コマンド名>	一部一致するだけでも表示する	
5	uname	[オプション]	システム情報を出力する	
34	cat			
35	more			
36	od			
37	nl			
38	less			
39	bzcat			
40	zcat			
41	xzcat			
42	md5sum			
43	sha256sum			
44	sha512sum			
45	wc			
46	split			
47	cut			
48	tr			
49	sed			
50	join			
51	paste			
52	uniq			
53	head			
54	tail			
55	expand			
56	unexpand			
57	sort			
58	tac			
59	fmt			
60	pr			
61	grep			
62	egrep			
63	fgrep			
64	vi			
65	yum			
66	yumdownloader			
67	yum-utils			
68	rpm			
69	rpm2cpio			
70	apt			
71	apt-get			
72	apt-cache			
73	aptitude			
74	dpkg			
75	dpkg-reconfigure			
76	ps			
77	top			
78	pstree			
79	free			
80	jobs			
81	uptime			
82	fg			
83	bg			
84	nohup			
85	watch			
86	sleep			
87	kill			
88	pkill			
89	pgrep			
90	skill			
91	snice			
92	xkill			
93	killall			
94	nice			
95	renice			
96	screen			
97	tmux			
98	fdisk			
99	gdisk			
100	parted			
102	mkswap			
103	swapon			
104	swapoff			
105	df			
106	du			
107	fsck			
108	e2fsck			
110	tune2fs			
111	debugfs			
112	dumpe2fs			
113	mount			
114	umount			
115	chmod			
116	umask			
117	chattr			
118	chown			
119	ln			
120	locate			
121	which			
122	whereis			
123	updatedb			
124	quota			
125	repquota			
126	quotacheck			
127	edquota			
128	setquota			
129	quotaon			
130	quotaoff			
10	printenv	[オプション]<変数名>	環境変数の内容を表示する	
11	export	[オプション][変数名[=値]...]	シェル、環境変数を設定する	
12	alias	<名前="コマンド">	エイリアスの登録を行う	コマンドを省略して別名に定義したいときに扱う<br>
13	unalias	<名前>	エイリアスの解除を行う	
131	ldd			
132	ldconfig			
133	chgrp			
134	lsmod			
135	lsblk			
136	lspci			
137	lscpu			
138	lsipc			
139	lsscsi			
140	lsusb			
141	modprobe			
142	dmesg			
143	journalctl			
144	init			
145	telinit			
146	runlevel			
147	shutdown			
148	wall			
149	halt			
150	reboot			
151	systemctl			
152	grub-install			
153	grub-mkconfig			
154	test			
155	read			
156	seq			
157	exec			
158	crontab			
159	at			
160	atq			
161	batch			
162	locale			
163	iconv			
164	tzselect			
165	tzconfig			
166	timedatectl			
167	ifconfig			
168	ifup			
169	ifdown			
170	ip			
171	route			
172	netstat			
173	traceroute			
174	tracepath			
175	hostname			
176	host			
177	dig			
178	nslookup			
179	nc			
180	nmcli			
181	hostnamecli			
182	ftp			
183	telnet			
184	ping			
185	date			
186	hwclock			
187	ntpdate			
236	pwd		カレントディレクトリを表示する	環境変数PWDから参照し、表示しているだけ
15	ls	[オプション]<ファイル、ディレクトリ>	ファイル・ディレクトリの一覧を出力する	
14	cd	[オプション][ディレクトリ]	カレントディレクトリを変更する	よく使われるコマンドの一つで、ls->cdの順序でよく行われる<br>ワイルドカードを付与して移動したいディレクトリに移動できるが、複数ある場合は移動できないため、正確に指定する必要がある<br>シュートカットは次のとおり<br>/ ルートディレクトリ<br>. カレントディレクトリ<br>.. 親ディレクトリ<br>~/ ホームディレクトリ
18	touch	[オプション]<ディレクトリ名>	ファイルのタイムスタンプを作成する<br>無いときは空ファイルを作成する	
257	service			
8	set	[オプション]	シェルの設定を確認、変更をする	省略すると一覧を表示する<br><br>
256	fuser			
244	netserver	[オプション]	ネットワークのスループットを計測する　デフォルトポートは12865	
246	iptables		ipパケットも確認する	
248	nfsiostat		ネットワークファイル共有の機能を計測する 主にunix系に使用される	
241	iostat	[オプション][更新の間隔[回数]]	CPUの使用率とI/Oデバイスの使用状況を表示する	
101	mkfs	[オプション] <デバイスファイル> [ブロックサイズ]	ファイルシステムを構築する	LinuxのファイルシステムはVFSと呼ばれる仕組みによって、異なるファイルシステムであっても、同じ操作が可能になっている<br>mkfsコマンドは主に、オプションを指定することで種類を指定できるが、mkfs.<ファイルシステム>でも可能<br>どちらが使いやすいか分からないが、違いは特にない<br>注意:実行すると、フォーマットされるのでバックアップを生成してから実行するのが良い(最も新品なら不要ではあるが)
252	XFS	参照	ジャーナリングファイルシステム	UNIX用に開発されたファイルシステムでSilicon社によってリリースされている<br>最大ボリュームサイズ、ファイルサイズ共に8EB<br>注意すべきはカーネルが対応しているかどうか見る必要がある<br>modprobe xfsを実行することで分かる
22	file	[オプション] <ファイル...>	ファイルの形式を調べる	
28	bunzip	[オプション]<圧縮ファイル>	bz形式のファイルを解凍する	
30	xz	[オプション] <ファイル名> <圧縮>	xz形式に圧縮する	
33	tee	[オプション] <ファイル名>	標準入力から読み込みファイルに書き込み、次のコマンドへ実行結果を引き寄せる	
254	cryptsetup			
250	sync		ディスクバッファ領域にあるデータをディスクに書き込む	
240	iotop	[オプション]	プロセスごとのI/O使用率を表示する	I/O使用率のtop版と考えても良い
243	sadf	[オプション] -- [sarコマンドのオプション]	sadcによるログを区切りテキスト(CSV)やXML形式で出力することができる	
1	man	[オプション] [セクション番号]  <キーワード>	オンラインマニュアル　コマンドに関する情報を出力する	
191	mailq			
192	sendmail			
193	lpr			
194	lpq			
195	lprm			
196	su			
197	sudo			
198	users			
199	groups			
200	useradd			
201	usermod			
202	userdel			
203	groupadd			
204	groupmod			
205	groupdel			
206	passwd			
207	gpasswd			
208	id			
209	chsh			
210	getent			
211	chage			
212	lsof			
213	nmap			
214	ulimit			
215	visudo			
216	who			
217	w			
218	last			
219	inetd			
220	xinetd			
221	ssh			
222	ssh-keygen			
223	ssh-agent			
224	ssh-add			
225	gpg			
226	Xorg			
227	X-config			
228	xhost			
229	startx			
230	xinit			
231	showrgb			
232	xlsclients			
233	xwininfo			
234	xdpyinfo			
235	xvidtune			
16	mkdir	[オプション]<ディレクトリ名>	ディレクトリを新規作成する	作成するが、もし存在するなら作成は行われない
17	rmdir	[オプション] <ディレクトリ>	ディレクトリを削除する	文字通り、削除してくれるが空のディレクトリしか削除ができない<br>もし、中身ごと削除したいなら rm -r コマンドと打つべき
21	rm	[オプション] <対象>	ファイル、ディレクトリを削除する	ディレクトリもできるが、条件はディレクトリが空であること<br>中身ごと削除するときは-rオプションを使用すること
24	tar	[オプション] <ファイル...>	tarアーカイブ	圧縮や回答を行う際に、tarはよく使われる(unix,linuxだが)<br>tarコマンドを使用することで、ファイル群をまとめてアーカイブにして一つのファイルにする<br>注意:あくまでまとめているだけなので、圧縮を行っているわけではない<br>もし圧縮をしたいならオプションを使用するか別コマンドで圧縮するしかない
23	find	[オプション] <検索対象ディレクトリパス> [式]	ファイルを検索する	
242	sar	<オプション> [-s 開始時刻] [-e 終了時刻][-f ログファイル] [表示間隔(秒)[回数]]	システム統計情報のレポートを得ることができる	sysstatサービスが有効だと、sadcによるログが/var/log/saディレクトリ以下のsaXXファイルに格納される(XXは日付を表す2桁の数字)
29	cpio	 <フラグ> [オプション] [<|> アーカイブ]	アーカイブ関係	正体不明のアーカイブコマンドであるため情報不足中
237	xargs			
245	netpref		netserverを実行しているホストに接続する	
251	mkisofs			
255	LUKS			
238	vmstat	[表示間隔(秒)][回数]	メモリ、仮想メモリ、ブロックデバイス等の詳細な状態を継続的に監視する	
239	htop	[オプション]	topコマンドを改良したコマンド	topコマンドにゲージを表示し、さらに詳細に出力されている
247	iptraf-ng		ネットワークインターフェースのトラフィックを確認する	
249	cifsiostat		ネットワークファイル共有の機能を計測する 主にwindows系に使用される	
253	btrfs	<コマンド> [引数]	RAID搭載可能なジャーナリングファイルシステム	ZFSに影響を受けたファイルシステムで、スナップショットやコピーオンライトの機能を持ち、多くのLinuxファイルシステムの制約を受けないことが期待されている<br>RAIDを搭載することができるため、可用性、信頼性を高めることができる
109	mke2fs	[オプション] <デバイスファイル> [ブロック]	ext2,3,4ファイルシステムの構築	extだけを構築するファイルシステムで、それ以外のファイルシステムを指定することできない
\.


--
-- Data for Name: linuxcommandandfilerelation; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxcommandandfilerelation (cid, fid) FROM stdin;
\.


--
-- Data for Name: linuxcommandcurrentcid; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxcommandcurrentcid (current) FROM stdin;
258
\.


--
-- Data for Name: linuxcommandcurrentpid; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxcommandcurrentpid (current) FROM stdin;
1
\.


--
-- Data for Name: linuxcommandop; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxcommandop (cid, oid, option, description) FROM stdin;
7	1		
22	0	-b	行の最初にファイル名を出力しない
22	1	-i	mimeタイプ文字列で出力する
22	2	-f <リストファイル名>	リストファイルからファイルを調べる
22	3	-L	シンボリックリンクの参照元を調べる
22	4	-z	圧縮ファイルの中も検査する
22	5	-N	出力時に空白の追加しない
241	0	-c	CPU使用率のみを出力する
241	1	-d	デバイス使用率のみを出力する
252	0		
23	0	-P	シンボリックリンクをたどらない（デフォルト）
23	1	-L	全てのシンボリックリンクをたどる
23	2	-H	コマンドラインで指定したシンボリックリンクをたどる
23	3	-D <オプション>	診断用のデバッグ情報
23	4	-O<1|2|3>	最適化レベル
25	0	-d	解凍
25	1	-c	圧縮ファイルを標準出力
2	1		
3	1		
25	2	-r	ディレクトリ内の全てのファイルを圧縮
253	0	下記参照	下記参照
5	1	-a(--all)	全ての情報を出力する
5	2	-s(-kernel-name)	カーネル名を出力する
5	3	-n(--nodename)	ネットワークのホスト名を出力する
5	4	-r(--kernel-release)	カーネルのリリースを出力する
5	5	-v(--kernel-version)	カーネルのバージョンを出力する
5	6	-m(--machine)	マシンのハードウェア名を出力する
5	7	-p(--processor)	プロセッサのタイプを出力する
5	8	-i	ハードウェアプラットフォームの情報を出力する
5	9	-o	OS情報を出力する
30	0	-d	展開
30	1	-k	元のファイルを削除しない
30	2	-l	圧縮ファイルの情報を表示する
33	0	-a	追記モード
256	1		
6	0	-c	履歴を全部消す
6	1	-d<番号>	指定した番号の履歴を消す
6	2	-r<ファイル>	履歴ファイルを読み込みその内容を履歴として追加する
6	3	-a	履歴ファイルに現在のセッションの履歴を追加する
6	4	-n	履歴ファイルからまだ読み込まれていない行を全て読み込む
6	5	-w<ファイル>	現在の履歴をファイルに上書きする
6	6	整数値	履歴の末尾から指定した行数分を表示する
34	1		
35	1		
36	1		
37	1		
38	1		
39	1		
40	1		
41	1		
42	1		
43	1		
44	1		
45	1		
46	1		
47	1		
48	1		
49	1		
50	1		
51	1		
52	1		
53	1		
54	1		
55	1		
56	1		
57	1		
58	1		
59	1		
60	1		
61	1		
62	1		
63	1		
64	1		
65	1		
66	1		
67	1		
68	1		
69	1		
70	1		
71	1		
72	1		
73	1		
74	1		
75	1		
76	1		
77	1		
78	1		
79	1		
80	1		
81	1		
82	1		
83	1		
84	1		
85	1		
86	1		
87	1		
88	1		
89	1		
90	1		
91	1		
92	1		
93	1		
94	1		
95	1		
96	1		
97	1		
98	1		
99	1		
100	1		
102	1		
103	1		
104	1		
105	1		
106	1		
107	1		
108	1		
110	1		
111	1		
112	1		
113	1		
114	1		
115	1		
116	1		
117	1		
118	1		
119	1		
120	1		
121	1		
122	1		
123	1		
124	1		
125	1		
126	1		
127	1		
128	1		
129	1		
130	1		
131	1		
132	1		
133	1		
134	1		
135	1		
136	1		
137	1		
138	1		
139	1		
140	1		
141	1		
16	0	-m <パーミッション>(--mode=パーミッション)	ディレクトリのパーミッションを設定する
16	1	-P(--parent)	サブディレクトリごと作成する
16	2	-v(--verbose)	作成するたびにメッセージを出力する
16	3	-Z	強制アクセス用
16	4	--context	強制アクセス用
241	2	-g <グループ名>	グループごとに出力し、最終的に合計を出力する
241	3	-h	読みやすい表示形式にする
241	4	-k	KB単位で出力する
241	5	-m	MB単位で出力する
241	6	-N	デバイスマッパーの名称で表示する
241	7	-p <デバイス>	デバイスマッパーの名称で表示する
241	8	-t	計測した時刻を出力する
241	9	-T	合計のみ出力 -gとともに使用すること
241	10	-x	拡張ディスク統計情報を出力する
241	11	-y	繰り返し表示する際に、最初に表示されるシステム起動時からの統計情報を省略する
241	12	-z	表示対象の期間に使用されていないデバイスは表示しない
26	0	-c	標準出力
26	1	-f	上書き
26	2	-r	ディレクトリを再帰的に処理
257	1		
31	0		
254	1		
250	0	-d	ファイルデータだけ　メタデータは行わない
250	1	-f	ファイルシステム内のファイルに書き込む
239	0	-d <秒>	更新にどのくらいかけるか
239	1	-C	色を付けない
239	2	-u <ユーザー名>	ユーザー名で実行しているユーザープロセスを表示する
239	3	-p	ページマップとメモリに関することを記載する
244	0	-4	IPv4
244	1	-6	IPv6
244	2	-d	デバッグモード
244	3	-h	文字列で表示し、終了する
244	4	-p <ポート番号>	ポート番号を指定する
244	5	-L <名前,ファミリー>	ローカル名かIPアドレスを指定し、IPアドレスのグループによってソケットを制御する
247	0		
8	0	-o[シェルオプション]	シェルオプションを有効にする<br>シェルオプションを省略すると設定したシェルオプションをonと表示する
8	1	-o[シェルオプション]	シェルオプションを無効にする<br>シェルオプションを省略すると現在と同様に設定するためのコマンド列を一覧表示する
8	2	--(-)	オプションの終わり<br>--と-以降は全てファイル名やsetコマンドのオプション以外の引数として扱う
4	0	-n	改行を行わない
4	1	-e	エスケープ処理を有効にする
4	2	-E	エスケープ処理を無効にする
9	0	-i(--ignore-environment)	環境変数が設定されていない状態でコマンドを実行する
9	1	-u <変数名>(--unset=変数名)	指定した環境変数が設定されていない状態でコマンドを実行する
9	2	-0(--null)	改行しない(単純に改行コードをnull文字にするだけ)
10	0	-0	改行しない
11	0	-f	シェル関数を参照する
11	1	-n	指定した環境変数をシェル変数に変える
11	2	-p	全てのエクスポートされた変数と関数を全て一覧表示する。但し変数名は指定できない
12	0		
13	0		
14	0	-P	指定したディレクトリがシンボリックリンクの場合、シンボリックリンクの移動先に移動する
14	1	-L	指定したディレクトリがシンボリックリンクの場合、シンボリックリンクに移動する
15	0	-l	詳しく出力する
240	0		
242	0	-A	全ての項目を表示する
242	1	-b	ディスクの入出力と転送レート情報を表示する
242	2	-c	プロセスの生成回数を表示する
242	3	-f <ファイル>	ログファイルを指定する
242	4	-n <DEV>	ネットワーク関連の情報を表示する
242	5	-n <EDEV>	ネットワーク関連のエラー情報を表示する
27	0	-<1-9>	圧縮する際にブロックを100-900kbにする
27	1	-d	解凍
27	2	-c	標準出力
27	3	-k	キープする
29	0	-A	既存のアーカイブファイルに追加
29	1	-d	必要なときにディレクトリの作成
29	2	-r	ファイルを対話的に変更
29	3	-t	コピーせず、入力内容の一覧表示
29	4	-v	ファイル名の一覧の表示
32	0		
242	6	-r	メモリとスワップ関連の情報を表示する
1	0	-a	一致した全てのマニュアルページを表示する
1	1	-f	概要部分だけ検索する
251	1		
255	1		
238	0		
242	7	-u	CPU関連の情報を表示する
242	8	-P <id|ALL>	CPUごとの情報を表示する
242	9	-R	メモリごとの統計情報を表示する
242	10	-W	スワップの情報を表示する
245	0		
248	0		
1	2	-k	一部一致するだけでも表示する
1	3	-w	マニュアルがあるファイルをパスとして表示する
101	0	-V	詳細な情報を表示する
101	1	-t <ファイルシステムの種類>	作成するファイルシステムのタイプを指定する 省略するとext2が用いられる
101	2	-c	ファイルシステムを作成する前に、デバイスに対して不良ブロックの検査を行う
101	3	-v	詳細な表示を出力する
101	4	-l <ファイル名>	不良ブロックのリストをファイルから読み込む
109	8	-t <ext2|ext3|ext4>	ファイルシステムを選択する ext系のみ
15	1	-h	読みやすいサイズ表記になる(バイト数/単位)(単位)
15	2	-l	1KB単位
15	3	-c	状態変更時刻を使ってソートを行う(-t|-lが必要)
15	4	-u	最終アクセス時刻を使ってソートを行う(-t|-lが必要)
15	5	-F	名前の後ろに識別子を表示する
15	6	-p	ディレクトリのみ/を付けて表示
15	7	-i	iノード番号を各ファイルの前に表示する
15	8	-s	ファイルのブロック数
15	9	-a	隠しファイルも表示する
15	10	-A	同じく表示するが、.と..を除く
15	11	-d	ディレクトリそのものを表示する
15	12	-H	シンボリックリンクなら、リンク先の情報を表示する
15	13	-r(-R)	サブディレクトリの中も表示する
15	14	-L	不明
243	0	-j	json形式で出力する
243	1	-x	XML形式で出力する
243	2	-t	ローカル日時で表示する(UTFではない)
246	0		
249	0		
236	1		
17	0	--ignore-fail-on-non-empty	ディレクトリに関連する障害を無視する
17	1	-p(--parents)	対象のディレクトリの親ディレクトリが空ならそれも対象に入れる
17	2	-v(--verbose)	削除したことを出力する
24	0	複数に分かれているため分割	複数に分かれているため分割
28	0		
237	1		
18	0	-a	アクセス時刻のみ更新する
18	1	-c(--no-create)	空ファイルを作成しない
18	2	-d <日付文字列>(--date=日付文字列)	日付文字列を日付に変換する
18	3	-f	不明
18	4	-h(--no-deferefence)	不明
18	5	-m	変更時刻のみ更新する
18	6	-r <ファイル>(--reference=<ファイル>)	ファイルの時刻を更新する
18	7	-t <[[CC]YY]MMDDHHMM.SS]>	指定されたタイムスタンプにファイルの時刻を更新する
18	8	--time=<atime|-mtime>	指定されたワードによってアクセス、変更時刻を更新する
19	0	-a(--archive)	構造や属性を保持して、コピーする
19	1	--attributes-only	属性だけコピーする
19	2	--backup[=コントロール]	コピー先にバックアップを作成する
19	3	-b	--backupに等しい
19	4	--copy-contents	不明
19	5	-d	シンボリックリンクをシンボリックリンクとしてコピー
19	6	-f	コピー先に同じ名前があっても上書きする
19	7	-i	上書きするか尋ねる
19	8	-H	不明
19	9	-l	コピーではなくハードリンクを作成する
19	10	-L	対象にシンボリックリンクを辿る?
19	11	-n	
19	12	-P	コピー元のシンボリックリンクを辿らない
19	13	-p	属性を保持してコピー
19	14	-r(-R)	ディレクトリ内のファイルもコピーする
19	15	-u	新しいファイルでコピーなら上書きをする
20	0	-b	上書き、削除されるファイルのバックアップを作成する
20	1	-f(--force)	移動先に同じファイル名が存在しても上書きする
20	2	-i(--interactive)	上書きする前に確認する
20	3	-u	新しいファイルなら上書きする
21	0	-d	ディレクトリごと削除する スーパーユーザーのみ可能
21	1	-f	確認せずに削除する
21	2	-i	確認してから削除する
21	3	-r	ディレクトリごと削除する
109	0	-b <ブロックサイズ>	ブロックサイズを指定する（1024/2048/4096）省略時は適切な値に設定される
109	1	-c	ファイルシステム作成前に不良ブロックをチェックする
109	2	-f <フラグメントサイズ>	フラグメントサイズSIZEをバイト単位で指定する
109	3	-g <ブロック数>	ブロックグループに含まれるブロック数BLOCKSを指定する（デフォルトで最適値）
109	4	-i <バイト>	何バイトあたりに1つのiノードを作成するか、バイト数BYTESを指定する
109	5	-j	ext3ファイルシステムを作成する
109	6	-m <サイズ>	スーパーユーザーのみが利用できる予約ブロックのパーセンテージRESERVEDを指定する（デフォルトは5%）
109	7	-n	実際には何も行わない
\.


--
-- Data for Name: linuxcommandotherchunk; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxcommandotherchunk (cid, tid, title, description) FROM stdin;
8	0	シェルオプション	
4	0	エスケープ文字	-eが有効になっているときにのみ処理される
22	0	リストファイル	対象ファイルのパス名しか書かれていないファイルのこと　テキストで作成可能<br>例<br>/home/user/panama.txt<br>/home/user/banana.pdf<br>/home/user/bird.tar
242	0	sar -bの結果	
242	1	sar -n DEV/EDEVの結果	
242	2	sar -n EDEV	
242	3	sar -rの結果	
242	4	sadcコマンド	システム状態をバイナリとして保存する
242	5	sa1	sysstatでcrontabによってデータを収集する<br>収集された結果は、sadcコマンドによってバイナリ形式に追記される
242	6	sa2	sa1からデータを取得し、テキストデータにしてくれるシェルスクリプト
23	0	式について	式というざっくりとした省略可能な引数だが条件式、アクションなど色々とある<br>そのため、複数に分けて記載する
23	1	アクション	
23	2	グローバルオプション	
23	3	位置オプション	
23	4	演算子	
23	5	テスト	
24	0	オプション:形式	
24	1	オプション:アーカイブ関係	アーカイブに関するオプション　一つしか使用できず同時使用はできない
24	2	オプション:共通	複数指定ができる
29	0	フラグについて	
32	0	オペランド	
101	0	ファイルシステムの種類	
1	0	セクション番号	
109	0	ext2/3について	ext2は上限サイズは2TB(当初は2GB)<br>255バイトまでのファイル名、可変長のディレクトリエントリに対応している<br>一部の領域はrootに割り当てられているため、メンテナンスが支障なく可能<br>仮に、満杯になってもrootによるメンテナンスが可能<br>ジャーナリング機能が付いていないため、復旧に時間が掛かる<br>ファイルをinodeという番号に振って、管理する方式<br>早い話、リスト構造で管理していることになる<br><br>ext2のパーティションをマウントしたままext3に変換できる(ただし、ジャーナリングを有効にできない)<br>ジャーナリングを付けれる<br>複数のブロックに跨るディレクトリに対してのツリーベースのディレクトリインデックス<br>オンラインファイルシステムリサイズ(拡張のみ)<br>短所は、ext2からext3に変換したファイルシステムはext3の機能を使用することができない<br>ファイルシステムに書き込みが行われている間は、fsckコマンドを実行できない<br>日付範囲が2038年1月1日に対応していないが、解決した
109	1	ext4について	最大1EiBまでのボリュームサイズと、最大16TiBまでのファイルサイズをサポートする。
252	0	コマンドについて	xfs_XXという形になっているため、引数はコマンドごとに異なる
253	0	特徴	Btrfsは耐障害性、修復機能や容易な管理に焦点を合わせている
253	1	コマンド	コマンドは全て省略形に縮めることができますが、スクリプトの中では完全なコマンド名を使うことを指定します。全てのコマンドグループにはそれぞれ btrfs-group という名前のマニュアルページが存在します。<br>コマンド名が曖昧な場合、候補となるオプションのリストが出力されます。
253	2	balance	
253	3	check	
253	4	device	
253	5	filesystem	
253	6	inspect-internal\t	
253	7	property	
253	8	qgroup	
253	9	quota	
253	10	receive	
253	11	replace	
253	12	rescue	
253	13	restore	
253	14	scrub	
253	15	send	
253	16	subvolume	
\.


--
-- Data for Name: linuxcommandotherchunktabledata; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxcommandotherchunktabledata (cid, tid, col, "row", data, issize) FROM stdin;
24	0	0	0	-z	F
24	0	0	1	gzip形式	F
24	0	1	0	-j	F
24	0	1	1	bzip2形式	F
24	0	2	0	-Z	F
24	0	2	1	compress形式	F
24	0	\N	\N	3,2	T
24	1	0	0	アーカイブの内容の一覧表示する	F
24	1	0	1	-x	F
24	1	1	0	アーカイブを展開する	F
24	1	1	1	-c	F
24	1	2	0	新しいアーカイブを作成する	F
24	1	2	1	-r	F
24	1	3	0	アーカイブの最後にファイルを追加する	F
24	1	3	1	-A	F
24	1	4	0	アーカイブにtarアーカイブを追加する	F
24	1	4	1	-u	F
24	1	5	0	アーカイブのファイルを更新する	F
24	1	5	1	-d	F
24	1	6	0	アーカイブとファイルを比較する	F
24	1	6	1	--delete	F
24	1	7	0	アーカイブから削除する	F
24	1	7	1	-t	F
24	1	\N	\N	8,2	T
24	2	0	0	-f <アーカイブファイル>	F
24	2	0	1	アーカイブファイルを指定	F
24	2	1	0	-C <ディレクトリパス>	F
24	2	1	1	カレントディレクトリからディレクトリパスに変更する	F
24	2	2	0	-h	F
24	2	2	1	シンボリックリンクを辿る	F
24	2	3	0	-k	F
24	2	3	1	既存のファイルを置き換えない	F
24	2	4	0	-U	F
24	2	4	1	ファイルを上書きする前に削除する	F
24	2	5	0	-X <ファイル>	F
24	2	5	1	ファイルから指定ファイルを除外する	F
24	2	6	0	-v	F
24	2	6	1	処理したファイルを詳しく出力する	F
24	2	7	0	-w	F
24	2	7	1	アーカイブを書きだした後に検証する	F
24	2	\N	\N	8,2	T
101	0	0	0	ext2	F
101	0	0	1	Linux用のファイルシステム	F
101	0	1	0	ext3	F
101	0	1	1	ext2にジャーナリング機能を加えたファイルシステム	F
101	0	2	0	ext4	F
8	0	22	0	keyword	F
8	0	22	1	-k	F
8	0	22	2	コマンド名の前にある代入文だけでなく、引数として指定した全ての代入文も、そのコマンドに対する環境変数に追加する	F
8	0	23	0	noexec	F
8	0	23	1	-n	F
8	0	23	2	 \tコマンドを読み込むだけで実行しない	F
8	0	24	0	onecmd	F
8	0	24	1	-t	F
8	0	24	2	 \tコマンドを1つ読み込み、実行してから終了する	F
8	0	25	0	privileged	F
8	0	25	1	-p	F
8	0	25	2	特権モード。シェル関数や変数を環境から継承せず、実効ユーザーも再設定しない	F
8	0	\N	\N	26,3	T
4	0	0	0	&#92;&#92;	F
4	0	0	1	バックスラッシュ	F
4	0	1	0	&#92;a	F
4	0	1	1	アラート	F
4	0	2	0	&#92;b	F
4	0	2	1	バックスペース	F
4	0	3	0	&#92;c	F
4	0	3	1	以降の出力を抑える	F
4	0	4	0	&#92;e	F
4	0	4	1	エスケープ文字	F
4	0	5	0	&#92;f	F
4	0	5	1	フォームフィード	F
4	0	6	0	&#92;n	F
4	0	6	1	改行	F
4	0	7	0	&#92;t	F
4	0	7	1	水平タブ	F
4	0	8	0	&#92;v	F
4	0	8	1	垂直タブ	F
4	0	9	0	&#92;&#92;	F
4	0	9	1	バックスラッシュ	F
4	0	10	0	&#92;0nnn	F
4	0	10	1	ASCIIの8進数コード	F
4	0	11	0	&#92;xHH	F
4	0	11	1	ASCIIの16進数コード	F
4	0	\N	\N	12,2	T
23	2	4	0	深さの始点が一致するところのディレクトリに処理する	F
23	2	4	1	-help	F
23	2	\N	\N	5,2	T
23	3	0	0	-datstart	F
23	3	0	1		F
23	3	1	0	-regextype type	F
23	3	1	1	-regexか-iregexで指定でき、正規表現で検索を行う	F
23	3	2	0	-warn,-nowarn	F
23	3	2	1	警告の表示、非表示	F
23	3	\N	\N	3,2	T
23	4	0	0		F
23	4	\N	\N	1,1	T
23	5	0	0	+<数値>	F
23	5	0	1	nより大きい	F
23	5	1	0	-<数値>	F
23	5	1	1	nより小さい	F
23	5	2	0	<数値>	F
29	0	0	0	-i [オプション] <パターン>	F
252	0	0	0	xfs_admin	F
252	0	0	1	[オプション] <デバイスファイル>	F
252	0	0	2	XFSファイルシステムのパラメータを変更する	F
252	0	1	0	xfs_bmap	F
252	0	1	1	a	F
252	0	1	2	b	F
252	0	2	0	xfs_copy	F
252	0	2	1	[オプション] <デバイスファイル>[ デバイスファイル...>	F
252	0	2	2	XFSファイルシステムのコピーを行う	F
252	0	3	0	xfs_db	F
252	0	3	1	a	F
252	0	3	2	b	F
252	0	4	0	xfs_estimate	F
252	0	4	1	a	F
8	0	0	0	allexport	F
8	0	0	1	-a	F
8	0	0	2	シェル変数の定義と同時にexportし、環境変数としても使用可能にする	F
8	0	1	0	braceexpand	F
8	0	1	1	-B	F
8	0	1	2	ブレース展開を実行する(デフォルト)	F
8	0	2	0	noglob	F
8	0	2	1	-f	F
8	0	2	2	*などによるパス名展開を無効にする	F
252	0	4	2	b	F
252	0	5	0	xfs_freeze	F
253	1	13	1	a	F
8	0	3	0	nounset	F
8	0	3	1	-u	F
8	0	3	2	パラメーター展開中に、設定していない変数があったらエラーする	F
8	0	4	0	noclobber	F
8	0	4	1	-C	F
8	0	4	2	リダイレクトで既存のファイルを上書きしない	F
8	0	5	0	ignoreeof	F
8	0	5	1	なし	F
8	0	5	2	CTRL+Dで終了しない	F
8	0	6	0	physical	F
8	0	6	1	-P	F
8	0	6	2	cdコマンドなどでシンボリックリンクをたどらずに物理的なディレクトリ名を使用する	F
8	0	7	0	emacs	F
8	0	7	1	なし	F
8	0	7	2	コマンド行の編集操作をEmacs形式にする(デフォルト)	F
8	0	8	0	vi	F
8	0	8	1	なし	F
8	0	8	2	コマンド行の編集操作をviコマンド形式にする	F
8	0	9	0	posix	F
8	0	9	1	なし	F
8	0	9	2	bashの動作のうち、デフォルトの動作がPOSIX準拠になるように変更する	F
8	0	10	0	history	F
8	0	10	1	なし	F
8	0	10	2	コマンド履歴を有効にする	F
8	0	11	0	histexpand	F
8	0	11	1	-H	F
8	0	11	2	!番号によるヒストリの参照を行う	F
8	0	12	0	monitor	F
8	0	12	1	-m	F
8	0	12	2	監視モード。バックグラウンドジョブの結果を表示する	F
8	0	13	0	notify	F
8	0	13	1	-b	F
8	0	13	2	終了したバックグラウンドジョブの結果をすぐに表示する	F
8	0	14	0	hashall	F
8	0	14	1	-h	F
8	0	14	2	コマンドのパスを全て記憶する	F
8	0	15	0	errexit	F
8	0	15	1	-e	F
8	0	15	2	パイプやサブシェルで実行したコマンドが1つでもエラーになったら直ちにシェルを終了する	F
8	0	16	0	pipefail	F
8	0	16	1	なし	F
8	0	16	2	 \tパイプラインの返り値を、最後のエラー終了値（0以外で終了した際の値、全ての実行が成功した場合は0）にする	F
8	0	17	0	errtrace	F
8	0	17	1	-E	F
8	0	17	2	エラーをトレースする(シェル関数で、ERRトラップを継承する)	F
8	0	18	0	functrace	F
8	0	18	1	-T	F
8	0	18	2	デバッグをトレースする(シェル関数で、DEBUGトラップを継承する)	F
8	0	19	0	verbose	F
8	0	19	1	-v	F
8	0	19	2	シェルの入力業を表示する	F
8	0	20	0	xtrace	F
8	0	20	1	-x	F
8	0	20	2	トレース情報として、シェルが実行したコマンドとその引数を出力する。情報の先頭にはシェル変数PS4の値を使用	F
8	0	21	0	interactive-comments	F
8	0	21	1	なし	F
8	0	21	2	「#」以降をコメントとして扱う（デフォルトで有効）	F
23	2	0	0	findの使い方を表示する	F
23	2	0	1	-mount	F
23	2	1	0	他のファイルシステムに処理をしない	F
23	2	1	1	-depth(-d)	F
23	2	2	0	ディレクトリの中身を処理する	F
23	2	2	1	-maxdepth <深さ>	F
23	2	3	0	深さの終点が一致するところのディレクトリに処理する	F
23	2	3	1	-mindepth <深さ>	F
23	5	2	1	nである	F
23	5	3	0	-amin <分>	F
23	5	3	1	ファイルの最終アクセス日時がn分前であればtrue	F
23	5	4	0	-anewer <比較ファイル>	F
23	5	4	1	ファイルの最終アクセス日時が、比較ファイルの内容更新日時よりも新しければtrue	F
23	5	5	0	-atime <日>	F
23	5	5	1	ファイルの最終アクセス日時が、n日前ならtrue	F
23	5	6	0	-cmin <分>	F
23	5	6	1	ファイルの最終ステータス更新日時がn分前であればtrue	F
23	5	7	0	-cnewer <比較ファイル>	F
23	5	7	1	ファイルの最終ステータス変更日時が、比較ファイルの内容更新日時よりも新しければtrue	F
23	5	8	0	-ctime <日>	F
23	5	8	1	ファイルの最終ステータス変更日時が、n日前ならtrue	F
23	5	9	0	-empty	F
23	5	9	1	ファイルが空ならtrue	F
23	5	10	0	-executable	F
23	5	10	1	実行可能なファイル、検索可能なファイルにマッチする	F
23	5	11	0	-false	F
23	5	11	1	常にfalse	F
23	5	12	0	-fstype <種類>	F
23	5	12	1	ファイルシステムのタイプ	F
23	5	13	0	-gid <GID>	F
23	5	13	1	ファイルのグループID番号	F
23	5	14	0	-group <グループ名>	F
23	5	14	1	ファイルのグループ名	F
23	5	15	0	ilname <パターン>	F
23	5	15	1	不明	F
23	5	16	0	-iname <パターン>	F
23	5	16	1	ファイル名の大文字小文字区別せずに検索する	F
23	5	17	0	-inum <inode番号>	F
23	5	17	1	ファイルのinode番号が一致するならtrue	F
23	5	18	0	-ipath <ファイルパス名>	F
23	5	18	1	後述	F
23	5	19	0	-iregex <パターン>	F
23	5	19	1	後述	F
23	5	20	0	-links <数>	F
23	5	20	1	ファイルのハードリンク数が	F
23	5	21	0	-lname <パターン>	F
23	5	21	1	ファイルがシンボリックリンクでリンク先が指定されたパターンに一致するならtrue	F
23	5	22	0	-mmin <分>	F
23	5	22	1	ファイルの最終内容更新日時がn分前ならtrue	F
23	5	23	0	-mtime <日>	F
23	5	23	1	ファイルの最終内容更新日時がn日前ならtrue	F
23	5	24	0	-name <パターン>	F
23	5	24	1	ファイル、ディレクトリ名がパターンに一致するならtrue	F
23	5	25	0	-newer <対象ファイル>	F
23	5	25	1	ファイルが対象ファイルよりも新しいならtrue	F
23	5	26	0	-nogroup	F
23	5	26	1	ファイルのグループID番号に対応するグループが存在するしないならtrue	F
23	5	27	0	-nouser	F
23	5	27	1	ファイルのユーザーID番号に対応するユーザーが存在するしないならtrue	F
23	5	28	0	-path <パターン>	F
23	5	28	1	ファイル名が一致するならtrue	F
23	5	29	0	-perm <パーミッション>	F
23	5	29	1	パーミッションが一致したファイルだけtrue	F
23	5	30	0	-readable	F
23	5	30	1	読み込み可能なファイルならtrue	F
23	5	31	0	-regex <パターン>	F
23	5	31	1	正規表現に一致したファイルだけtrue	F
23	5	32	0	-size <n[bcwLMG]>	F
23	5	32	1	ファイルサイズが一致しているならtrue	F
23	5	33	0	-true	F
23	5	33	1	常にtrue	F
23	5	34	0	-type <タイプ>	F
23	5	34	1	ファイルのタイプが一致しているならtrue<br>b ブロックスペシャルファイル<br>c キャラクタスペシャルファイル<br>d ディレクトリ<br>p 名前付きパイプ<br> f 通常のファイル<br> l シンボリックリンク<br> s ソケット	F
23	5	35	0	-uid <ユーザーID>	F
23	5	35	1	ファイル所有者のユーザーID番号が一致しているならtrue	F
23	5	36	0	-used <日>	F
23	5	36	1	ファイルが最後にアクセスしたのが、最終ステータス変更日時よりn日後ならtrue	F
23	5	37	0	-user <ユーザー名>	F
23	5	37	1	ファイル所有者名が一致しているならtrue	F
23	5	38	0	-writable	F
23	5	38	1	書き込み可能なファイルならtrue	F
23	5	\N	\N	39,2	T
29	0	0	1	アーカイブからファイルを抽出	F
29	0	1	0	-o [オプション]	F
29	0	1	1	アーカイブの作成	F
29	0	2	0	-p [オプション] <ディレクトリ>	F
29	0	2	1	ファイルを別のディレクトリにコピー	F
29	0	\N	\N	3,2	T
101	0	2	1	ext3を機能拡張したファイルシステム	F
101	0	3	0	ReiserFS	F
101	0	3	1	Linux用のファイルシステム	F
101	0	4	0	JFS	F
101	0	4	1	IBMによって開発されたジャーナリングファイルシステム	F
101	0	5	0	XFS	F
32	0	0	0	bs=バイト数	F
32	0	0	1	一回にバイト数ずつ読み書きする	F
32	0	1	0	cbs=バイト数	F
32	0	1	1	一回にバイト数に変換する	F
32	0	2	0	count=N	F
32	0	2	1	N回分繰り返す	F
32	0	3	0	conv=リスト:	F
32	0	3	1		F
32	0	4	0	if=ファイル・デバイスファイル	F
32	0	4	1	標準入力の代わりにファイル・デバイスから	F
32	0	5	0	ibs=入力バイト数	F
32	0	5	1	一回に入力バイト数ずつ読み込む(デフォルト:512)	F
32	0	6	0	of=ファイル・デバイスファイル	F
32	0	6	1	標準出力の代わりにファイル・デバイスから	F
32	0	7	0	fbs=出力バイト数	F
32	0	7	1	一回に出力バイト数ずつ書き込む(デフォルト:512)	F
32	0	\N	\N	8,2	T
101	0	5	1	SGIによって開発されたジャーナリングファイルシステム	F
101	0	6	0	Btrfs	F
101	0	6	1	Linux向けの堅牢なファイルシステム	F
101	0	7	0	ISO9660	F
101	0	7	1	CD-ROMのファイルシステム	F
101	0	8	0	UDF	F
101	0	8	1	DVD等のファイルシステム	F
101	0	9	0	F2FS	F
101	0	9	1	SSD等のフラッシュメモリ向けファイルシステム	F
101	0	10	0	msdos	F
101	0	10	1	MS-DOSのファイルシステム	F
101	0	11	0	FAT/FAT32	F
101	0	11	1	フラッシュメモリ等で使われるファイルシステム	F
101	0	12	0	NTFS	F
101	0	12	1	Windowsが使用するファイルシステム	F
101	0	13	0	hpfs	F
101	0	13	1	OS/2のファイルシステム	F
101	0	14	0	HFS	F
101	0	14	1	MacOSのファイルシステム	F
101	0	15	0	HFS+	F
101	0	15	1	MacOS8.1以降のファイルシステム	F
101	0	16	0	NFS	F
101	0	16	1	ネットワークファイルシステウ	F
101	0	17	0	CIFS	F
101	0	17	1	Windowsのネットワーク共有を扱うファイルシステム	F
101	0	18	0	procfs	F
101	0	18	1	プロセス情報を扱う仮想ファイルシステム	F
101	0	19	0	sysfs	F
101	0	19	1	デバイス情報を扱う仮想ファイルシステム	F
101	0	20	0	tmpfs	F
101	0	20	1	仮想メモリベースのファイルシステム	F
101	0	21	0	devpfs	F
101	0	21	1	擬似端末を制御するための仮想ファイルシステム	F
101	0	22	0	usbfs	F
101	0	22	1	USBデバイス監視用のファイルシステム	F
101	0	23	0	cramfs	F
101	0	23	1	組み込みシステムなどで使われる圧縮ファイルシステム	F
101	0	\N	\N	24,2	T
252	0	5	1	[オプション] <デバイスファイル>	F
252	0	5	2	XFSファイルシステムのアクセス中断や、再開を行う	F
252	0	6	0	xfs_fsr	F
252	0	6	1	a	F
252	0	6	2	b	F
252	0	7	0	xfs_growfs	F
252	0	7	1	a	F
252	0	7	2	b	F
252	0	8	0	xfs_info	F
252	0	8	1	[オプション] <マウントポイント>	F
252	0	8	2	XFSファイルシステムの詳細情報を出力する	F
252	0	9	0	xfs_io	F
252	0	9	1	a	F
252	0	9	2	b	F
252	0	10	0	xfs_logprint	F
252	0	10	1	a	F
252	0	10	2	b	F
252	0	11	0	xfs_mdrestore	F
252	0	11	1	a	F
252	0	11	2	b	F
252	0	12	0	xfs_metadump	F
1	0	0	0	1	F
1	0	0	1	コマンド	F
1	0	1	0	2	F
1	0	1	1	システムコール	F
1	0	2	0	3	F
1	0	2	1	ライブラリ関数	F
1	0	3	0	4	F
1	0	3	1	デバイス・デバイスドライバ	F
1	0	4	0	5	F
1	0	4	1	ファイルフォーマット	F
1	0	5	0	6	F
1	0	5	1	ゲーム	F
1	0	6	0	7	F
1	0	6	1	その他	F
1	0	7	0	8	F
1	0	7	1	システム管理	F
1	0	8	0	9	F
1	0	8	1	新しく追加されたマニュアル	F
1	0	\N	\N	9,2	T
252	0	12	1	a	F
252	0	12	2	b	F
252	0	13	0	xfs_mkfile	F
252	0	13	1	a	F
252	0	13	2	b	F
252	0	14	0	xfs_ncheck	F
252	0	14	1	a	F
252	0	14	2	b	F
252	0	15	0	xfs_quota	F
252	0	15	1	[オプション] <デバイスファイル>	F
252	0	15	2	XFSファイルシステムのクォータ	F
252	0	16	0	xfs_repair	F
252	0	16	1	[オプション] <デバイスファイル>	F
252	0	16	2	XFSファイルシステムの修復	F
252	0	17	0	xfs_rtcp	F
252	0	17	1	a	F
242	0	0	0	tps	F
242	0	0	1	I/O転送リクエスト数/秒	F
242	0	1	0	rtps	F
242	0	1	1	ディスク読み込みリクエスト数/秒	F
242	0	2	0	wtps	F
242	0	2	1	ディスク書き込みリクエスト数/秒	F
242	0	3	0	bread/s	F
242	0	3	1	ディスク読み込みブロック数/秒	F
242	0	4	0	bwrtn/s	F
242	0	4	1	ディスク書き込みブロック数/秒	F
242	0	\N	\N	5,2	T
242	1	0	0	IFACE	F
242	1	0	1	ネットワークインターフェース名	F
242	1	1	0	rxpck/s	F
242	1	1	1	受信パケット数/秒	F
242	1	2	0	txpck/s	F
242	1	2	1	送信パケット数/秒	F
242	1	3	0	rxkB/s	F
242	1	3	1	受信キロバイト数/秒	F
242	1	4	0	txkB/s	F
242	1	4	1	送信キロバイト数/秒	F
242	1	5	0	rxcmp/s	F
242	1	5	1	圧縮パケットの受信バイト数/秒	F
242	1	6	0	txcmp/s	F
242	1	6	1	圧縮パケットの送信バイト数/秒	F
242	1	7	0	rxcst/s	F
242	1	7	1	マルチキャストパケットの受信パケット数/秒	F
242	1	\N	\N	8,2	T
242	2	0	0	IFACE	F
242	2	0	1	ネットワークインターフェース名	F
242	2	1	0	rxerr/s	F
242	2	1	1	受信エラーパケット数/秒	F
242	2	2	0	txerr/s	F
242	2	2	1	送信エラーパケット数/秒	F
242	2	3	0	coll/s	F
242	2	3	1	衝突パケット数/秒	F
242	2	4	0	rxdrop/s	F
242	2	4	1	バッファ不足による受信取りこぼしパケット数/秒	F
242	2	5	0	txdrop/s	F
242	2	5	1	バッファ不足による送信取りこぼしパケット数/秒	F
242	2	6	0	txcarr/s	F
242	2	6	1	送信時のキャリアエラーパケット数/秒	F
242	2	7	0	rxfram/s	F
242	2	7	1	受信時のフレーム同期エラーパケット数/秒	F
242	2	8	0	rxfifo/s	F
242	2	8	1	受信時のFIFOオーバーランパケット数/秒	F
242	2	9	0	txfifo/s	F
242	2	9	1	送信時のFIFOオーバーランパケット数/秒	F
242	2	\N	\N	10,2	T
242	3	0	0	kbmemused	F
242	3	0	1	使用中のメモリ(KB)	F
242	3	1	0	%memused	F
242	3	1	1	メモリの使用率	F
242	3	2	0	kbbuffers	F
242	3	2	1	バッファの使用量(KB)	F
242	3	3	0	kbcached	F
242	3	3	1	キャッシュの使用量(KB)	F
242	3	4	0	kbcommit	F
242	3	4	1	現在必要とされているメモリ総量(KB)	F
242	3	5	0	%commit	F
242	3	5	1	メモリ総量(RAM+スワップ)における必要メモリ量の割合(%)	F
242	3	6	0	kbactive	F
242	3	6	1	activeなメモリ(最近利用された頻度が高いページ)	F
242	3	7	0	kbinact	F
242	3	7	1	inactiveなメモリ(メモリが不足すると解放されるページ)	F
242	3	8	0	kbdirty	F
242	3	8	1	dirtyなメモリ(ディスクに同期されていない(まだ書き込まれていない)状態のページ	F
242	3	\N	\N	9,2	T
242	4	0	0		F
242	4	\N	\N	1,1	T
242	5	0	0		F
242	5	\N	\N	1,1	T
242	6	0	0		F
242	6	\N	\N	1,1	T
109	0	0	0		F
109	0	\N	\N	1,1	T
109	1	0	0	エクステント	F
109	1	0	1	a	F
109	1	1	0	永続的な事前確保	F
109	1	1	1	a	F
109	1	2	0	遅延確保	F
109	1	2	1	a	F
109	1	3	0	サブディレクトリの32000個制限の撤廃	F
109	1	3	1	a	F
109	1	4	0	ジャーナルのチェックサム	F
109	1	4	1	a	F
109	1	5	0	オンラインのデフラグメンテーション	F
109	1	5	1	e4defrag により、マウント中（オンライン）でのデフラグが可能になった。	F
109	1	6	0	より高速なファイルシステムチェック	F
109	1	6	1	a	F
109	1	7	0	マルチブロックの確保	F
109	1	7	1	a	F
109	1	8	0	タイムスタンプの改良	F
109	1	8	1	ナノ秒単位で記録ができるようになった	F
109	1	\N	\N	9,2	T
252	0	17	2	b	F
252	0	18	0	xfsdump	F
252	0	18	1	[オプション] <デバイスファイル>	F
252	0	18	2	XFSファイルシステムのバックアップ	F
252	0	\N	\N	19,3	T
253	0	9	0	ソリッドステートドライブ (SSD) 最適化モード（マウントオプションで有効化される）	F
253	0	9	1	a	F
253	0	10	0	オンラインデフラグメンテーション	F
253	0	10	1	a	F
253	0	11	0	シードデバイスのサポート	F
253	0	11	1	a	F
253	0	12	0	オフライン重複排除（ユーザ空間のツールが必要）	F
253	0	12	1	a	F
253	0	13	0	オンラインバランシング	F
253	0	13	1	a	F
253	0	14	0	オンラインボリューム拡張及び縮小	F
253	0	14	1	a	F
253	0	15	0	オンラインデバイスの追加と削除	F
253	0	15	1	a	F
253	0	16	0	サブボリュームのクオータ	F
253	0	16	1	a	F
253	0	\N	\N	17,2	T
253	1	0	0	balance	F
253	1	0	1	a	F
253	1	0	2	単体、複数のデバイス間にまたがるBtrfsファイルシステムのチャンクを再配置する	F
253	1	1	0	check	F
253	1	1	1	a	F
253	1	1	2	Btrfsファイルシステムのオフラインチェックを実行する	F
253	1	2	0	device	F
253	1	2	1	a	F
253	1	2	2	Btrfs によって管理するデバイスを管理・追加・削除・スキャンします。	F
253	1	3	0	filesystem	F
253	1	3	1	a	F
253	1	3	2	ラベルの設定や同期など btrfs ファイルシステムを管理します。	F
253	1	4	0	inspect-internal	F
253	1	4	1	a	F
253	1	4	2	開発者・ハッカー用のデバッグツール。	F
253	1	5	0	property	F
253	1	5	1	a	F
253	1	5	2	btrfs オブジェクトのプロパティを取得・設定	F
253	1	6	0	qgroup	F
253	1	6	1	a	F
253	1	6	2	btrfs ファイルシステムのクォータグループ (qgroup) を管理。	F
253	1	7	0	quota	F
253	1	7	1	a	F
253	1	7	2	btrfs ファイルシステムのクォータを管理。クォータの有効化や再スキャンなど。	F
253	1	8	0	receive	F
253	1	8	1	a	F
253	1	8	2	標準入力やファイルからサブボリュームデータを受信して復元など。	F
253	1	9	0	replace	F
253	1	9	1	a	F
253	1	9	2	btrfs デバイスの置換	F
253	1	10	0	rescue	F
253	1	10	1	a	F
253	1	10	2	破損した btrfs ファイルシステムの救出を試みる	F
253	1	11	0	restore	F
253	1	11	1	a	F
253	1	11	2	破損した btrfs ファイルシステムからファイルの復元を試みる。	F
253	1	12	0	scrub	F
253	1	12	1	a	F
253	1	12	2	btrfs ファイルシステムのチェック。	F
253	1	13	0	send	F
253	0	0	0	空間効率の良い小さなファイルの格納と、空間効率の良いインデックス付きディレクトリ	F
253	0	0	1	a	F
253	0	1	0	動的なinodeの割り当て（ファイルシステムの作成時に設定されるファイル数の最大値がない）	F
253	0	1	1	a	F
253	0	2	0	サブボリューム（複数の内部的なルートディレクトリ）	F
253	0	2	1	a	F
253	0	3	0	（強い完全性の保証のための）データとメタデータのチェックサム	F
253	0	3	1	a	F
253	0	4	0	圧縮 (gzip, LZO, Zstd)	F
253	0	4	1	a	F
253	0	5	0	すべてのデータとメタデータに対するコピーオンライトのロギング	F
253	0	5	1	a	F
253	0	6	0	いくつかのRAIDアルゴリズム (RAID-0, RAID-1, RAID-5, RAID-6, RAID-10) とともに、複数のデバイスをサポートするためのデバイスマッパとの強い統合	F
253	0	6	1	a	F
253	0	7	0	効率的な増分バックアップ(send/receive)	F
253	0	7	1	a	F
253	0	8	0	ext3、ext4からbtrfsへのファイルシステムのアップグレードと、アップグレード時点への逆変換	F
253	0	8	1	a	F
253	1	13	2	バックアップ用などにサブボリュームデータを標準出力やファイルに送信。	F
253	1	14	0	subvolume	F
253	1	14	1	a	F
253	1	14	2	btrfs サブボリュームを作成・削除・確認・管理	F
253	1	\N	\N	15,3	T
253	2	0	0		F
253	2	\N	\N	1,1	T
253	3	0	0		F
253	3	\N	\N	1,1	T
253	4	0	0		F
253	4	\N	\N	1,1	T
253	5	0	0		F
253	5	\N	\N	1,1	T
253	6	0	0		F
253	6	\N	\N	1,1	T
253	7	0	0		F
253	7	\N	\N	1,1	T
253	8	0	0		F
253	8	\N	\N	1,1	T
253	9	0	0		F
253	9	\N	\N	1,1	T
253	10	0	0		F
253	10	\N	\N	1,1	T
253	11	0	0		F
253	11	\N	\N	1,1	T
253	12	0	0		F
253	12	\N	\N	1,1	T
253	13	0	0		F
253	13	\N	\N	1,1	T
253	14	0	0		F
253	14	\N	\N	1,1	T
253	15	0	0		F
253	15	\N	\N	1,1	T
253	16	0	0		F
253	16	\N	\N	1,1	T
\.


--
-- Data for Name: linuxcommandotherchunktableheader; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxcommandotherchunktableheader (cid, tid, header) FROM stdin;
101	0	種類,特徴
109	0	
109	1	特徴,備考
8	0	シェルオプション,オプション,意味
4	0	エスケープ文字,意味
1	0	セクション番号,内容
252	0	コマンド,引数,説明
22	0	
242	0	項目,説明
242	1	項目,説明
242	2	項目,説明
242	3	kbmemfree,空きメモリ(KB)
242	4	
242	5	
242	6	
23	0	
23	1	
23	2	オプション,意味
23	3	書式,意味
23	4	
23	5	オプション,意味
24	0	オプション,意味
24	1	オプション,意味
24	2	オプション,意味
29	0	オプション,意味
32	0	オペランド,意味
253	0	特徴,説明、備考
253	1	コマンド,引数,説明
253	2	
253	3	
253	4	
253	5	
253	6	
253	7	
253	8	
253	9	
253	10	
253	11	
253	12	
253	13	
253	14	
253	15	
253	16	
\.


--
-- Data for Name: linuxcommandpage; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxcommandpage (pid, pagename, description, detail) FROM stdin;
\.


--
-- Data for Name: linuxcommandpagerelation; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxcommandpagerelation (pid, cid) FROM stdin;
\.


--
-- Data for Name: linuxfile; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxfile (fid, filepath, description, detail) FROM stdin;
123	/home/ユーザー/.ssh/authorized_keys		
124	/home/ユーザー/.gnupg/pubring.gpg		
125	/home/ユーザー/.gnupg/secring.gpg		
132	/etc/X11/xinit/Xclients		
133	/etc/X11/xinit/xinitrc		
134	/etc/X11/xinit/xinitrc.d/		
135	/home/ユーザー/.xinitrc		
136	/etc/X11/xdm/Xsession		
3	/etc/profile	全ユーザーの環境変数を設定するスクリプトファイル	環境変数を反映させるためのスクリプトファイルで、1番目に実行される
1	/etc/bash.bashrc	全ユーザーのbash起動時の処理 Debian系	bash起動時に、このスクリプトファイルに記載されているコマンド等を自動的に実行することができる<br>但し、条件があり、/home/ユーザー/.bashrcが存在していなかった場合のみ実行される<br>4番目に実行される
2	/etc/bashrc	全ユーザーのbash起動時の処理 RedHat系	bash起動時に、このスクリプトファイルに記載されているコマンド等を自動的に実行することができる<br>但し、条件があり、/home/ユーザー/.bashrcが存在していなかった場合のみ実行される<br>4番目に実行される
4	/home/ユーザー/.bash_profile	ユーザーの環境変数を設定するスクリプトファイル	ユーザーが独自に環境変数を事前に設定することができるスクリプトファイル\r\n2番目に起動される
5	/home/ユーザー/.bash_login	.bash_profileが存在しないときに使用されるスクリプトファイル	.bash_profileが存在しない場合、次に起動されるスクリプトファイル\r\n中身は、.bash_profileと同じ
6	/home/ユーザー/.profile	.bash_loginが存在しないときに起動されるスクリプトファイル	.bash_loginが存在しない場合、次に起動されるスクリプトファイル\r\n.bash_profileと同じ内容
7	/home/ユーザー/.bashrc	ユーザーのbash起動時の処理を行うスクリプトファイル	bash起動時(ログイン)に自動的に起動されるスクリプトファイル\r\nユーザーが独自に起動させることができ、また全ユーザーとは独立して処理を行える
8	/home/ユーザー/.bash_logout	bashからログアウトする際に自動的に処理されるスクリプトファイル	bashからログアウトすると、自動的に実行されるスクリプトファイル\r\n.bashrcとは異なり、CLIやGUIとは異なる\r\nGUIの場合は、直接ログアウトする必要がある
9	/etc/yum.conf	パッケージマネージャーのyumの設定ファイル	RedHat系のディストリビューションでお馴染みのパッケージマネージャーのyumの設定ファイル\r\nこの設定ファイルから編集をすることで、プロキシを通すことができるようになる(要検証)\r\n
10	/etc/yum.repos.d	yumのリポジトリファイル	yumはパッケージを取得する際に、必ずリポジトリのURLからアクセスしパッケージDBを更新している\r\nそのため、ネットワーク接続が必要となる\r\nしかし、デフォルトのリポジトリでは存在しないパッケージを取得する際はこのファイルを登録する必要がある
11	/etc/apt/sources.list	aptの設定ファイル	
12	/etc/apt/apt.conf.d	aptの設定ファイル	
13	/var/lib/apt/lists	aptの設定ファイル	
137	/etc/X11/xdm/Xresources		
138	/home/ユーザー/.Xsession		
139	/home/ユーザー/.Xresources		
14	/boot	起動に関するファイル構造・パーティション	ブートストラッププロセス中に使用されたファイルと共にカーネルが存在し、Linuxを起動させるのに必要なブートローダーの設定もこの中に存在する
15	/home	ユーザーごとのディレクトリ・パーティション	ユーザーごとの独立したホームディレクトリを格納する\r\nユーザーを追加すると自動的にホームディレクトリを生成することができる
16	/usr	プログラム、ライブラリ、ドキュメントが格納されるディレクトリ・パーティション	
17	/var	アプリ用のコンテンツ、ダウンロード、更新用パッケージ、ログファイル、メールなどが格納されるディレクトリ・パーティション	
18	/tmp	一時的に使用する作業用ファイルが配置されるディレクトリ・パーティション	一時ファイルを格納するディレクトリ、もし開発するならユーザーの手間を考えてここに配置しよう\r\nなぜならば、Linuxを起動、終了するたびに自動で一時ファイルを削除してくれるからだ
19	/	ルートパーティション	Linuxのパーティションでは、ルートパーティションが存在しrootユーザーの許可が必要となる\r\nしかし、それはファイルを配置する等を行う場合である\r\n全てのディレクトリ構造から始まるパーティションでもある\r\n
20	/opt		
21	/sbin		
22	/bin		
23	/usr/sbin		
24	/usr/bin		
25	/boot/grub/grub.conf		
26	/boot/grub/menu.lst		
27	/boot/grub/grub.cfg		
28	/etc/grub.d		
29	/etc/default/grub		
30	/sys		
31	/proc		
32	/dev		
33	/etc/inittab		
34	/etc/init.d		
35	/etc/rc.d/rc.sysinit		
36	/etc/rc.d/rc		
37	/etc/rc(1-6).d		
38	/var/log/messages		
39	/var/log/boot.log		
40	/var/log/dmesg		
41	/etc/rc.d/init.d		
42	/etc/systemd/system/default.target		
43	/etc/fstab		
44	/etc/mtab		
45	/lib		
46	/media		
47	/mnt		
48	/srv		
49	/root		
50	/usr/lib		
51	/usr/share		
52	/usr/local		
53	/etc/ld.so.conf		
54	/etc/crontab		
55	/var/spool/cron		
56	/etc/cron.d		
57	/etc/cron.hourly		
58	/etc/cron.daily		
59	/etc/cron.weekly		
60	/etc/cron.monthly		
61	/etc/cron.allow		
62	/etc/cron.deny		
63	/etc/at.allow		
64	/etc/at.deny		
65	/usr/share/zoneinfo		
66	/etc/localtime		
67	/etc/services		
68	/etc/hostname		
69	/etc/hosts		
70	/etc/resolv.conf		
71	/etc/host.conf		
72	/etc/nsswitch.conf		
73	/etc/sysconfig/network		
74	/etc/sysconfig/network-scripts/ifcfg-eth0		
75	/etc/network/interfaces		
76	/proc/sys/net/ipv4/ip_forward		
77	/etc/init.d/ntpd.start		
78	/etc/ntp.conf		
79	/etc/rsyslog.conf		
80	/etc/rsyslog.d/*.conf		
81	/etc/syslog.conf		
82	/var/log/secure		
83	/var/log/cron		
84	/var/log/maillog		
85	/var/log/spooler		
86	/etc/logrotate.conf		
87	/var/run/log/journal		
88	/var/log/journal		
89	/etc/init.d/sendmail		
90	/etc/init.d/postfix		
91	/etc/init.d/exim4		
92	/etc/init.d/qmail		
93	/home/ユーザー/.forward		
94	/var/spool/mqueue		
95	/var/spool/mail		
96	/etc/cups		
97	/etc/cups/cupsd.conf		
98	/etc/sudoers		
99	/var/log/wtmp		
100	/var/run/utmp		
101	/etc/passwd		
102	/etc/shadow		
103	/etc/skel/		
104	/etc/udev/rules.d		
105	/etc/inetd.conf		
106	/etc/xinetd.conf		
107	/etc/xinetd.d		
108	/etc/init.d/xinetd		
109	/etc/hosts.allow		
110	/etc/hosts.deny		
111	/etc/sshrc		
112	/home/ユーザー/.ssh/.config		
113	/etc/ssh/sshd_config		
114	/etc/ssh/ssh_host_key		
115	/etc/ssh/ssh_host_dsa_key		
116	/etc/ssh/ssh_host_rsa_key		
117	/etc/ssh/ssh_host_key.pub		
118	/etc/ssh/ssh_host_dsa_key.pub		
119	/etc/ssh/ssh_host_rsa_key.pub		
120	/home/ユーザー/.ssh/known_hosts		
121	/home/ユーザー/.ssh/id_rsa		
122	/home/ユーザー/.ssh/id_rsa.id		
126	/etc/X11/xorg.conf		
127	/etc/X11/xorg.conf.d		
128	/root/X11/xorg.conf		
129	/etc/X11/xdm		
130	/etc/X11/kdm		
131	/etc/X11/gdm		
\.


--
-- Data for Name: linuxfilecurrentfid; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxfilecurrentfid (current) FROM stdin;
140
\.


--
-- Data for Name: linuxfileinfo; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxfileinfo (fid, tid, title, description) FROM stdin;
\.


--
-- Data for Name: linuxfilepagerelation; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxfilepagerelation (fid, pid) FROM stdin;
\.


--
-- Data for Name: linuxfiletabledata; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxfiletabledata (fid, tid, col, "row", data, issize) FROM stdin;
\.


--
-- Data for Name: linuxfiletableheader; Type: TABLE DATA; Schema: linuxperson; Owner: linuxperson
--

COPY linuxperson.linuxfiletableheader (fid, tid, header) FROM stdin;
\.


--
-- Name: linuxcommandn_cid_seq; Type: SEQUENCE SET; Schema: linuxperson; Owner: linuxperson
--

SELECT pg_catalog.setval('linuxperson.linuxcommandn_cid_seq', 258, true);


--
-- Name: linuxcommandpagen_pid_seq; Type: SEQUENCE SET; Schema: linuxperson; Owner: linuxperson
--

SELECT pg_catalog.setval('linuxperson.linuxcommandpagen_pid_seq', 1, true);


--
-- Name: linuxfile_fid_seq; Type: SEQUENCE SET; Schema: linuxperson; Owner: linuxperson
--

SELECT pg_catalog.setval('linuxperson.linuxfile_fid_seq', 140, true);


--
-- Name: linuxcommand linuxcommand_command_key; Type: CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommand
    ADD CONSTRAINT linuxcommand_command_key UNIQUE (command);


--
-- Name: linuxcommand linuxcommandn_pkey; Type: CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommand
    ADD CONSTRAINT linuxcommandn_pkey PRIMARY KEY (cid);


--
-- Name: linuxcommandop linuxcommandopn_pkey; Type: CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandop
    ADD CONSTRAINT linuxcommandopn_pkey PRIMARY KEY (cid, oid);


--
-- Name: linuxcommandpagerelation linuxcommandpage_pkey; Type: CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandpagerelation
    ADD CONSTRAINT linuxcommandpage_pkey PRIMARY KEY (pid, cid);


--
-- Name: linuxcommandpage linuxcommandpagen_pkey; Type: CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandpage
    ADD CONSTRAINT linuxcommandpagen_pkey PRIMARY KEY (pid);


--
-- Name: linuxfile linuxfile_filepath_key; Type: CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxfile
    ADD CONSTRAINT linuxfile_filepath_key UNIQUE (filepath);


--
-- Name: linuxfile linuxfile_pkey; Type: CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxfile
    ADD CONSTRAINT linuxfile_pkey PRIMARY KEY (fid);


--
-- Name: linuxcommandandfilerelation linuxcommandandfilerelation_cid_fkey; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandandfilerelation
    ADD CONSTRAINT linuxcommandandfilerelation_cid_fkey FOREIGN KEY (cid) REFERENCES linuxperson.linuxcommand(cid);


--
-- Name: linuxcommandandfilerelation linuxcommandandfilerelation_fid_fkey; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandandfilerelation
    ADD CONSTRAINT linuxcommandandfilerelation_fid_fkey FOREIGN KEY (fid) REFERENCES linuxperson.linuxfile(fid);


--
-- Name: linuxcommandop linuxcommandop_cid_fkey; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandop
    ADD CONSTRAINT linuxcommandop_cid_fkey FOREIGN KEY (cid) REFERENCES linuxperson.linuxcommand(cid);


--
-- Name: linuxcommandotherchunk linuxcommandotherchunk_cid_fkey; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandotherchunk
    ADD CONSTRAINT linuxcommandotherchunk_cid_fkey FOREIGN KEY (cid) REFERENCES linuxperson.linuxcommand(cid);


--
-- Name: linuxcommandotherchunk linuxcommandotherchunk_cid_fkey1; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandotherchunk
    ADD CONSTRAINT linuxcommandotherchunk_cid_fkey1 FOREIGN KEY (cid) REFERENCES linuxperson.linuxcommand(cid);


--
-- Name: linuxcommandotherchunktabledata linuxcommandotherchunktabledata_cid_fkey; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandotherchunktabledata
    ADD CONSTRAINT linuxcommandotherchunktabledata_cid_fkey FOREIGN KEY (cid) REFERENCES linuxperson.linuxcommand(cid);


--
-- Name: linuxcommandotherchunktabledata linuxcommandotherchunktabledata_cid_fkey1; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandotherchunktabledata
    ADD CONSTRAINT linuxcommandotherchunktabledata_cid_fkey1 FOREIGN KEY (cid) REFERENCES linuxperson.linuxcommand(cid);


--
-- Name: linuxcommandotherchunktableheader linuxcommandotherchunktableheader_cid_fkey; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandotherchunktableheader
    ADD CONSTRAINT linuxcommandotherchunktableheader_cid_fkey FOREIGN KEY (cid) REFERENCES linuxperson.linuxcommand(cid);


--
-- Name: linuxcommandotherchunktableheader linuxcommandotherchunktableheader_cid_fkey1; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandotherchunktableheader
    ADD CONSTRAINT linuxcommandotherchunktableheader_cid_fkey1 FOREIGN KEY (cid) REFERENCES linuxperson.linuxcommand(cid);


--
-- Name: linuxcommandpagerelation linuxcommandpagerelation_cid_fkey; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandpagerelation
    ADD CONSTRAINT linuxcommandpagerelation_cid_fkey FOREIGN KEY (cid) REFERENCES linuxperson.linuxcommand(cid);


--
-- Name: linuxcommandpagerelation linuxcommandpagerelation_pid_fkey; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxcommandpagerelation
    ADD CONSTRAINT linuxcommandpagerelation_pid_fkey FOREIGN KEY (pid) REFERENCES linuxperson.linuxcommandpage(pid);


--
-- Name: linuxfilepagerelation linuxfilepagerelation_fid_fkey; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxfilepagerelation
    ADD CONSTRAINT linuxfilepagerelation_fid_fkey FOREIGN KEY (fid) REFERENCES linuxperson.linuxfile(fid);


--
-- Name: linuxfilepagerelation linuxfilepagerelation_pid_fkey; Type: FK CONSTRAINT; Schema: linuxperson; Owner: linuxperson
--

ALTER TABLE ONLY linuxperson.linuxfilepagerelation
    ADD CONSTRAINT linuxfilepagerelation_pid_fkey FOREIGN KEY (pid) REFERENCES linuxperson.linuxcommandpage(pid);


--
-- PostgreSQL database dump complete
--

