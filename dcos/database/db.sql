DROP DATABASE IF EXISTS pentakill;
CREATE DATABASE pentakill DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
use pentakill;


DROP TABLE IF EXISTS `ms_sms_log`;
CREATE TABLE ms_sms_log (
log_id INT(11) UNSIGNED AUTO_INCREMENT COMMENT '��־ID',
op_type TINYINT(1) NOT NULL COMMENT '�������ͣ�1���͡�2��֤',
mobilephone CHAR(11) NOT NULL COMMENT '�ֻ�����',
sms_txt CHAR(200) NOT NULL COMMENT '��������',
sms_code CHAR(6) NOT NULL DEFAULT '' COMMENT '��֤�롣����Ƿ���֤����ţ���ֵΪ���ַ���',
is_destroy TINYINT(1) NOT NULL DEFAULT '0' COMMENT '�Ƿ���֤�ɹ��������١�1�ǡ�0��',
created_time INT(11) UNSIGNED NOT NULL COMMENT '����ʱ��',
PRIMARY KEY(log_id),
KEY(mobilephone)
)ENGINE = InnoDB DEFAULT CHARSET = 'UTF8' COMMENT '���ŷ���/��֤��־��';


# ÿ�ܸ��±���һ�Σ����·ݱ�����ʷ���ݡ�
DROP TABLE IF EXISTS ms_log;
CREATE TABLE ms_log(
	log_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����',
	log_type TINYINT(1) NOT NULL DEFAULT '0' COMMENT '��־���ͣ��μ�models\Log����',
	log_user_id INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�����û�ID',
	log_time INT(11) UNSIGNED NOT NULL COMMENT '��־����ʱ��',
	errcode INT(11) NOT NULL DEFAULT '0' COMMENT '������',
	content TEXT COMMENT '��־����',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '��־����ʱ��',
	PRIMARY KEY(log_id)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT 'ϵͳ��־��';


# �ֵ����ͱ�
DROP TABLE IF EXISTS ms_dict_type;
CREATE TABLE ms_dict_type(
	dict_type_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����',
	type_code CHAR(50) NOT NULL COMMENT '�ֵ����ͱ���',
    type_name CHAR(50) NOT NULL COMMENT '�ֵ���������',
	value_more TINYINT(1) NOT NULL COMMENT 'ֵ�Ƿ���У�1�ǡ�0�� ',
	value_type CHAR(20) NOT NULL COMMENT '�ֵ�ֵ����:',
    description CHAR(200) NOT NULL DEFAULT '' COMMENT '�ֵ���������',
    status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '״̬��0ʧЧ��1��Ч��2ɾ��',
    created_by INT(11) UNSIGNED NOT NULL COMMENT '���ʹ�����',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '���ʹ���ʱ��',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�����޸���',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�����޸�ʱ��',
	PRIMARY KEY(dict_type_id),
	KEY `type_code` (type_code)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '�ֵ����ͱ�';

# �ֵ����ݱ�
DROP TABLE IF EXISTS ms_dict;
CREATE TABLE ms_dict(
	dict_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����',
	dict_type_id INT(11) UNSIGNED NOT NULL COMMENT '����',
	dict_code CHAR(50) NOT NULL COMMENT '�ֵ����',
    dict_value CHAR(255) NOT NULL DEFAULT '' COMMENT '�ֵ�ֵ',
    description CHAR(255) NOT NULL DEFAULT '' COMMENT '�ֵ���������',
    listorder SMALLINT(1) NOT NULL DEFAULT '0' COMMENT '����С��ǰ',
    status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '״̬��0ʧЧ��1��Ч��2ɾ��',
    created_by INT(11) UNSIGNED NOT NULL COMMENT '���ʹ�����',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '���ʹ���ʱ��',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�����޸���',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�����޸�ʱ��',
	PRIMARY KEY(dict_id),
	KEY(dict_type_id)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '�ֵ����ݱ�';
INSERT INTO ms_dict (`dict_type_id`, `dict_code`, `dict_value`, `description`, `listorder`, `status`, `created_by`, `created_time`, `modified_by`, `modified_time`) 
VALUES 
('1', '1', '���·���', '���·����ֵ��ñ���ġ���Ϊ����Ӱ��˷���������ӷ��ࡣ��ȷʵҪ����������ID��Ӧ�ı�ms_category�ķ����Ƿ���ֵ��������봦��֮���ٱ����ֵ��', '0', '1', '1', unix_timestamp(now()), '0', '0'),
('1', '2', '�������ӷ���', '���������ı���ֵ����Ϊ�����������ӷ������ݻ�ʧȥ������', '0', '1', '1', unix_timestamp(now()), '0', '0'),
('1', '3', '��Ʒ����', '���������ı���ֵ����Ϊ�����������ӷ������ݻ�ʧȥ������', '0', '1', '1', unix_timestamp(now()), '0', '0'),
('2', '1', '���ĺ�', '���ĺš�', '0', '1', '1', unix_timestamp(now()), '0', '0'),
('2', '2', '�����', '����š�', '0', '1', '1', unix_timestamp(now()), '0', '0'),
('3', '3', '��ҵ��', '��ҵ�š�', '0', '1', '1', unix_timestamp(now()), '0', '0');



# ϵͳ���ñ�
# һЩ��Ҫ��̬�޸ĵ����á�
DROP TABLE IF EXISTS ms_config;
CREATE TABLE ms_config(
	config_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����',
	ctitle CHAR(255) NOT NULL COMMENT '���ñ���',
	cname CHAR(255) NOT NULL COMMENT '����',
	cvalue CHAR(255) NOT NULL DEFAULT '' COMMENT '��������ֵ',
	description CHAR(255) NOT NULL DEFAULT '' COMMENT '��������',
    status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '״̬��0ʧЧ��1��Ч��2ɾ��',
    created_by INT(11) UNSIGNED NOT NULL COMMENT '���ʹ�����',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '���ʹ���ʱ��',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�����޸���',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�����޸�ʱ��',
	PRIMARY KEY(config_id),
	KEY `cname` (cname)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT 'ϵͳ���ñ�';

INSERT INTO `ms_config` VALUES ('1', '������¼', 'is_unique_login', '1', '1�ǡ�0�񡣼�ͬһʱ���˺�ֻ����һ���ط���¼���������˺��������ط���¼��', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('2', '��վ����', 'site_name', '������', '', '1', '1', '1474353609', '0', '0');
INSERT INTO `ms_config` VALUES ('3', 'PC��¼��ʱʱ��(����)', 'pc_logout_time', '30', '��¼��ʱʱ�䡣�����ϴ�������ʱ����ڵ�ǰָ��ʱ������ڽ���¼��ʱ���˳���¼', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('4', '�����̨����', 'backend_domain_name', 'http://dev-backend.yesnophp.com/', '�漰����վҳ�����Դ�����ӵ�ַ', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('5', 'ǰ̨����', 'frontend_domain_name', 'http://dev-frontend.yesnophp.com/', '�漰����վҳ�����Դ�����ӵ�ַ', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('6', '΢������', 'wx_domain_name', 'http://dev-wx.yesnophp.com/', '�漰����վҳ�����Դ�����ӵ�ַ', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('7', '�ӿ�����', 'api_domain_name', 'http://dev-api.yesnophp.com/', '�漰����վҳ�����Դ�����ӵ�ַ', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('8', '��̬��Դ����', 'statics_domain_name', 'http://dev-statics.yesnophp.com/', '�漰����վҳ�����Դ�����ӵ�ַ', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('9', '�̼���������', 'shop_domain_name', 'http://dev-shop.yesnophp.com/', '�漰����վҳ����̼����ĵ����ӵ�ַ', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('10', '�˻���������', 'account_domain_name', 'http://dev-account.yesnophp.com/', '�漰����վҳ����˻����ĵ����ӵ�ַ', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('11', 'ͼƬ�ļ���Դ����', 'files_domain_name', 'http://dev-files.yesnophp.com/', '�漰����վͼƬ�ļ�����', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('12', '�û�Ȩ��cookie������', 'user_auth_cookie_domain_name', '.yesnophp.com', '�����������������������Զ���¼', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('13', 'APP��¼��ʱʱ��(��)', 'app_logout_time', '30', '��¼��ʱʱ�䡣�����ϴ�������ʱ����ڵ�ǰָ��ʱ������ڽ���¼��ʱ���˳���¼', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('14', '����Աcookie������', 'admin_cookie_domain', '.dev-backend.yesnophp.com', 'Ϊ����cookieֵ��ǰ̨ʹ�ã����õ�������ǹ����̨��������', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('15', '��̨��¼��ʱʱ��(����)', 'admin_logout_time', '30', '��ʱ����Ҫ���µ�¼', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('16', 'ϵͳά��״̬', 'system_status', '1', '�������̨֮��ĵط�ά��״̬��1��������0�ǹر�ϵͳ', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('17', 'ϵͳҵ�����еȼ�', 'system_service_level', '0', 'ʾ����1,8 ��1:ע�Ṧ�ܡ�2:��¼���ܡ�4:�һ����롢8:�����޸ġ�16:֧�����ܡ�32:���Ź��ܡ�64:�ʼ����ܡ�128:���۹��ܡ�256:�ϴ����ܡ�512:�����鿴���ܡ�1024:���ֹ��ܡ�2048:API�ӿڡ�4096:΢��Ӧ�á�8192:�ر�ȫվ������̨��', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('18', 'luosimao����KEY', 'luosimao_sms_key', '5d68e2564cc9deac5bc8d74935dc4e8c', 'luosimao���ŷ���KEY��', '1', '1', unix_timestamp(now()), '0', '0');
INSERT INTO `ms_config` VALUES ('19', 'ʡ����JSON�ļ����°汾', 'district_json_version', '', 'ʡ����JSON�ļ����°汾', '1', '1', unix_timestamp(now()), '0', '0');


# �ļ���
# �ϴ���ͼƬ����Ƶ���ļ���¼�ڴ˱��С�
# ����ǹ�����ͼƬ��ͼƬ�����ǹ̶��ġ�˽�е���ͼƬ�����Ƕ�̬���ɵġ�
DROP TABLE IF EXISTS ms_files;
CREATE TABLE ms_files(
	file_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����',
	file_name CHAR(50) NOT NULL COMMENT '�ļ�����',
	file_type TINYINT(1) NOT NULL COMMENT '�ļ����ͣ�1-ͼƬ��2-�����ļ�',
	file_size INT(11) UNSIGNED NOT NULL COMMENT '�ļ���С����λ��(byte)',
	file_md5 CHAR(32) NOT NULL COMMENT '�ļ�md5ֵ',
	user_type TINYINT(1) NOT NULL COMMENT '�û����ͣ�1����Ա��2��ͨ�û�',
	user_id INT(11) UNSIGNED NOT NULL COMMENT '�û�ID',
	status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '״̬��0ʧЧ��1��Ч��2ɾ��',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '����ʱ��',
	PRIMARY KEY(file_id)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '�ļ���';


# ����Ա��
DROP TABLE IF EXISTS ms_admin;
CREATE TABLE ms_admin(
	admin_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����ԱID',
	realname CHAR(20) NOT NULL COMMENT '��ʵ����',
	username CHAR(20) NOT NULL COMMENT '�˺�',
	password CHAR(32) NOT NULL COMMENT '����',
	salt CHAR(6) NOT NULL COMMENT '������',
	mobilephone CHAR(11) NOT NULL DEFAULT '' COMMENT '�ֻ�����',
	roleid SMALLINT(3) NOT NULL DEFAULT '0' COMMENT '��ɫID',
	lastlogintime INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '����¼ʱ���',
	status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '״̬��0ʧЧ��1��Ч��2ɾ��',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '����ʱ��',
	PRIMARY KEY(admin_id),
	KEY(username),
	KEY(mobilephone)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '����Ա��';
INSERT INTO ms_admin (admin_id, realname, username, password, salt, status, created_time, roleid)
VALUES(1, '��������Ա', 'admin', 'c7935cc8ee50b752345290d8cf136827', 'abcdef', 1, unix_timestamp(now()), 1);


# ����Ա��¼��ʷ��	
DROP TABLE IF EXISTS ms_admin_login_history;
CREATE TABLE `ms_admin_login_history` (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����',
  admin_id INT(11) UNSIGNED NOT NULL COMMENT '����ԱID',
  browser_type CHAR(10) NOT NULL COMMENT '��������͡�tabletƽ�塢phone�ֻ���computer����',
  user_agent VARCHAR(200) NOT NULL COMMENT '�����UA',
  ip CHAR(15) NOT NULL COMMENT '��¼IP',
  address VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'IP��Ӧ�ĵ�ַ��Ϣ',
  created_time INT(11) UNSIGNED NOT NULL COMMENT '��¼ʱ��',
  PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '����Ա��¼��ʷ��';


# ��ɫ��	
DROP TABLE IF EXISTS ms_admin_role;
CREATE TABLE ms_admin_role(
	roleid INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '��ɫID',
	rolename CHAR(20) NOT NULL COMMENT '��ɫ����',
	listorder SMALLINT(3) NOT NULL DEFAULT '0' COMMENT '����С��ǰ��',
	description CHAR(255) NOT NULL DEFAULT '' COMMENT '��ɫ˵��',
	status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '״̬��0ʧЧ��1��Ч��2ɾ��',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '����ʱ��',
	is_default TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'Ĭ�Ͻ�ɫӵ�����Ȩ�ޡ�����ɾ����Ĭ�Ͻ�ɫ����������Աֻ�����ڴ˽�ɫ�������û����ɷ���˽�ɫ',
	PRIMARY KEY(roleid)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '��ɫ��';
INSERT INTO ms_admin_role (roleid, rolename, status, is_default, created_time) VALUES(1, '��������Ա', 1, 1, unix_timestamp(now()));


# ��ɫȨ�ޱ�	
DROP TABLE IF EXISTS ms_admin_role_priv;
CREATE TABLE `ms_admin_role_priv` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����',
  `roleid` SMALLINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '��ɫID',
  `menu_id` INT(11) UNSIGNED NOT NULL COMMENT '�˵�ID',
  PRIMARY KEY(id),
  KEY(roleid)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '��ɫȨ�ޱ�';

# �һ������¼��
DROP TABLE IF EXISTS ms_find_pwd;
CREATE TABLE ms_find_pwd(
	id INT(11) NOT NULL AUTO_INCREMENT COMMENT '����ID',
	user_id INT(11) UNSIGNED NOT NULL COMMENT '�û�ID',
	find_type TINYINT(1) NOT NULL COMMENT '�һ��������ͣ�1�ֻ����һء�2�����һ�',
	to_account CHAR(50) NOT NULL COMMENT '�ֻ������������',
	code CHAR(6) NOT NULL COMMENT '��֤��',
	check_times SMALLINT(3) NOT NULL DEFAULT '0' COMMENT '��֤����',
	is_ok TINYINT(1) NOT NULL DEFAULT '0' COMMENT '���һ�η���֤ͨ����ǡ�0δʹ�á�1��ͨ����֤��2δ��֤ͨ��',
	ip CHAR(15) NOT NULL COMMENT 'IP��ַ',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '����ʱ��',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�޸�ʱ��',
	PRIMARY KEY(id),
	KEY(find_type, to_account)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '�һ������¼��';

# ���±�
DROP TABLE IF EXISTS ms_news;
CREATE TABLE `ms_news` (
	news_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����ID������',
	cat_id INT(11) UNSIGNED NOT NULL COMMENT '����ID����Ӧms_category.cat_id',
	title CHAR(50) NOT NULL COMMENT '���±���',
	code CHAR(20) NOT NULL COMMENT '���±���(ֻ������ĸ�����»��ߺ���)',
	intro CHAR(250) NOT NULL COMMENT '���¼�顣Ҳ��SEO�е�description',
	keywords CHAR(50) NOT NULL DEFAULT '' COMMENT '���¹ؼ��ʡ�Ҳ��SEO�е�keywords',
	image_url CHAR(100) NOT NULL DEFAULT '' COMMENT '�����б�ͼƬ',
	source CHAR(20) NOT NULL DEFAULT '' COMMENT '������Դ',
	display TINYINT(1) NOT NULL DEFAULT '0' COMMENT '�����Ƿ���ʾ��1��ʾ��0����',
	status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '����״̬��0��Ч��1������2ɾ��',
	listorder SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT '����С��������',
	hits INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '���·�����',
	created_by INT(11) UNSIGNED NOT NULL COMMENT '������',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '����ʱ��',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�޸���',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�޸�ʱ��',
	PRIMARY KEY(news_id),
	KEY(created_time),
	KEY(created_by)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '���±�';

# ���¸���
DROP TABLE IF EXISTS ms_news_data;
CREATE TABLE `ms_news_data` (
	news_id INT(11) UNSIGNED NOT NULL COMMENT '����ID',
	content TEXT COMMENT '��������',
	PRIMARY KEY(news_id)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '���¸���';


# �������ӱ�
# ͨ��һ��URL��ͳһ��ת��Щ�������ӡ�����ͳ�ơ�
DROP TABLE IF EXISTS ms_link;
CREATE TABLE `ms_link` (
	link_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����',
	link_name VARCHAR(50) NOT NULL COMMENT '������������',
	link_url VARCHAR(100) NOT NULL COMMENT '��������URL',
	cat_id INT(11) UNSIGNED NOT NULL COMMENT '�������ӷ���ID����Ӧms_category.cat_id',
	image_url VARCHAR(100) NOT NULL DEFAULT '' COMMENT '��������ͼƬ',
	display TINYINT(1) NOT NULL DEFAULT '0' COMMENT '�Ƿ���ʾ��1��ʾ��0����',
	status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '״̬��0��Ч��1������2ɾ��',
	listorder SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT '����С��������',
	hits INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'URL�����',
	created_by INT(11) UNSIGNED NOT NULL COMMENT '������',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '����ʱ��',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�޸���',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�޸�ʱ��',
	PRIMARY KEY(link_id)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '�������ӱ�';


# ���λ�ýӱ�
DROP TABLE IF EXISTS ms_ad_position;
CREATE TABLE `ms_ad_position` (
	pos_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����',
	pos_name VARCHAR(50) NOT NULL COMMENT '���λ������',
	pos_code VARCHAR(50) NOT NULL COMMENT '���λ�ñ��롣ͨ����������ȡ�������',
	pos_ad_count SMALLINT(5) NOT NULL COMMENT '�ù��λ����ʾ��չʾ��������',
	status TINYINT(1) NOT NULL COMMENT '״̬��0��Ч��1������2ɾ��',
	created_by INT(11) UNSIGNED NOT NULL COMMENT '������',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '����ʱ��',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�޸���',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�޸�ʱ��',
	PRIMARY KEY(pos_id)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '���λ�ýӱ�';

# ����
DROP TABLE IF EXISTS ms_ad;
CREATE TABLE `ms_ad` (
	ad_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����',
	ad_name VARCHAR(50) NOT NULL COMMENT '�������',
	pos_id INT(11) UNSIGNED NOT NULL COMMENT '���λ�á���Ӧms_ad_postion.pos_id',
	ad_image_url VARCHAR(100) NOT NULL COMMENT '���ͼƬ',
	ad_url VARCHAR(100) NOT NULL COMMENT '���ͼƬURL��ת��ַ',
	start_time INT(11) UNSIGNED NOT NULL COMMENT '�����Чʱ��',
	end_time INT(11) UNSIGNED NOT NULL COMMENT '���ʧЧʱ��',
	display TINYINT(1) NOT NULL DEFAULT '1' COMMENT '��ʾ״̬��1��ʾ��0����',
	status TINYINT(1) NOT NULL COMMENT '״̬��0��Ч��1������2ɾ��',
	listorder SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT '����С��������',
	remark VARCHAR(255) NOT NULL DEFAULT '' COMMENT '��ע',
	created_by INT(11) UNSIGNED NOT NULL COMMENT '������',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '����ʱ��',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�޸���',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�޸�ʱ��',
	PRIMARY KEY(ad_id)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '����';


# �����
# ���и�����IDΪ0�ķ��࣬����һ����ͬ�����ⶥ������IDΪ0��
DROP TABLE IF EXISTS `ms_category`;
CREATE TABLE ms_category(
	cat_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '����ID',
	cat_name VARCHAR(50) NOT NULL COMMENT '��������',
	cat_type SMALLINT(3) NOT NULL COMMENT '�������͡���category_type_list�ֵ䡣',
	parentid INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '������ID',
	lv SMALLINT(3) NOT NULL COMMENT '�˵��㼶',
	cat_code VARCHAR(50) NOT NULL COMMENT '����code��',
	is_out_url TINYINT(1) NOT NULL DEFAULT '0' COMMENT '�Ƿ��ⲿ���ӣ�1�ǡ�0��',
	out_url VARCHAR(255) NOT NULL DEFAULT '' COMMENT '�ⲿ���ӵ�ַ',
	display TINYINT(1) NOT NULL DEFAULT '0' COMMENT '��ʾ״̬��1�ǡ�0��',
	status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '״̬��0��Ч��1������2ɾ��',
	listorder SMALLINT(5) NOT NULL DEFAULT '0' COMMENT '����ֵ��С�������С�',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�޸���',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '�޸�ʱ���',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '����ʱ���',
	created_by INT(11) UNSIGNED NOT NULL COMMENT '����Ա�˺�ID',
	PRIMARY KEY(cat_id),
	KEY(cat_code)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '�����';


# ��̨�˵���
DROP TABLE IF EXISTS ms_menu;
CREATE TABLE `ms_menu` (
  `menu_id` SMALLINT(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(40) NOT NULL DEFAULT '',
  `parentid` SMALLINT(6) NOT NULL DEFAULT '0',
  `m` CHAR(50) NOT NULL DEFAULT '',
  `c` CHAR(50) NOT NULL DEFAULT '',
  `a` CHAR(50) NOT NULL DEFAULT '',
  `data` CHAR(255) NOT NULL DEFAULT '',
  `listorder` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0',
  `display` ENUM('1','0') NOT NULL DEFAULT '1',
  PRIMARY KEY (`menu_id`),
  KEY `listorder` (`listorder`),
  KEY `parentid` (`parentid`),
  KEY `module` (`m`,`c`,`a`)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '��̨�˵���';


INSERT INTO `ms_menu` (`menu_id`, `name`, `parentid`, `m`, `c`, `a`, `data`, `listorder`, `display`)
VALUES

(1000, '���ù���', 0,'','','','',0,'1'),
(1001, '���ù���', 1000,'','','','',0,'1'),
(1002, '�޸�����', 1001, 'Index','Admin','editPwd','',0,'1'),
(1003, '��¼��ʷ', 1001, 'Index','Admin','loginHistory','',0,'1'),
(1004, '�����̨��ҳ', 1001, 'Index','Index','Index','',0,'0'),
(1005, '�����̨Ajax��ȡ�˵�', 1001, 'Index','Index','leftMenu','',0,'0'),
(1006, '�����̨�Ҳ�Ĭ��ҳ', 1001, 'Index','Index','right','',0,'0'),
(1007, '�����̨���м', 1001, 'Index','Index','arrow','',0,'0'),
(1008, '�ļ��ϴ�', '1001', 'Index', 'Index', 'upload', '', '0', '0'),
(1009, '������ҳ', '1001', 'Index', 'Index', 'createHomePage', '', '0', '1'),

(2000, 'ϵͳ����',0,'','','','',0,'1'),
(2001, 'ϵͳ����',2000,'','','','',0,'1'),
(2002, '�ֵ����',2001,'Index','Dict','index','',0,'1'),
(2003, '����ֵ�����',2001,'Index','Dict','addType','',0,'0'),
(2004, '�༭�ֵ�����',2001,'Index','Dict','editType','',0,'0'),
(2005, 'ɾ���ֵ�����',2001,'Index','Dict','deleteType','',0,'0'),
(2006, '�ֵ��б�',2001,'Index','Dict','dict','',0,'0'),
(2007, 'ɾ���ֵ�',2001,'Index','Dict','delete','',0,'0'),
(2008, '����ֵ�',2001,'Index','Dict','add','',0,'0'),
(2009, '�����ֵ�',2001,'Index','Dict','edit','',0,'0'),
(2010, '�ֵ���������',2001,'Index','Dict','sortType','',0,'0'),
(2011, '�ֵ�����',2001,'Index','Dict','sortDict','',0,'0'),
(2012, '�ֵ仺�����',2001,'Index','Dict','ClearCache','',0,'0'),
(2013, '���ù���', 2001, 'Index','Config','index','',0,'1'),
(2014, '�������', 2001, 'Index','Config','add','',0,'0'),
(2015, '�༭����', 2001, 'Index','Config','edit','',0,'0'),
(2016, 'ɾ������', 2001, 'Index','Config','delete','',0,'0'),
(2017, '��������', 2001, 'Index','Config','sort','',0,'0'),
(2018, '���û������', 2001, 'Index','Config','ClearCache','',0,'0'),
(2019, '�˵��б�', 2001, 'Index','Menu','index','',0,'1'),
(2020, '��Ӳ˵�', 2001, 'Index','Menu','add','',0,'0'),
(2021, '�༭�˵�', 2001, 'Index','Menu','edit','',0,'0'),
(2022, 'ɾ���˵�', 2001, 'Index','Menu','delete','',0,'0'),
(2023, '�˵�����', 2001, 'Index','Menu','sort','',0,'0'),

(2200, '���дʹ���', 2000,'Index','Sensitive','','',0,'1'),
(2201, '���д��б�', 2200,'Index','Sensitive','index','',0,'1'),
(2202, '������д�', 2200,'Index','Sensitive','add','',0,'0'),
(2203, '�������д�', 2200,'Index','Sensitive','edit','',0,'0'),
(2204, '���д�ɾ��', 2200,'Index','Sensitive','delete','',0,'0'),

(2300,'IP��ֹ', 2000,'Index','Ip','','',0,'1'),
(2301,'����IP�б�',2300,'Index','Ip','index','',0,'1'),
(2302,'���IP',2300,'Index','Ip','add','',0,'0'),
(2303,'ɾ��IP',2300,'Index','Ip','delete','',0,'0'),

(2400, 'ʡ��������', 2000, 'Index','District','','',0,'1'),
(2401, '���ʡ����', 2400, 'Index','District','add','',0,'0'),
(2402, '�༭ʡ����', 2400, 'Index','District','edit','',0,'0'),
(2403, 'ɾ��ʡ����', 2400, 'Index','District','delete','',0,'0'),
(2404, 'ʡ��������', 2400, 'Index','District','sort','',0,'0'),
(2405, 'ʡ�����б�', 2400,'Index','District','index','',0,'1'),
(2406, '����ʡ����JSON�ļ�', 2400,'Index','District','createJsonFile','',0,'0'),

(2500, '��־����', 2000,'Index','Log','','',0,'1'),
(2501, '��־�鿴', 2500,'Index','Log','index','',0,'1'),

(2700, '�ļ�����', 2000, 'Index','File','','',0,'1'),
(2701, '�ļ��б�', 2700, 'Index','File','index','',0,'1'),
(2702, '�����ļ�', 2700, 'Index','File','edit','',0,'0'),
(2703, '����ļ�', 2700, 'Index','File','add','',0,'0'),
(2704, 'ɾ���ļ�', 2700, 'Index','File','delete','',0,'0'),


(3000, 'Ȩ�޹���',0,'','','','',0,'1'),

(3001, '����Ա����', 3000, 'Index','Admin','','',0,'1'),
(3002, '����Ա�б�', 3001, 'Index','Admin','index','',0,'1'),
(3003, '��ӹ���Ա', 3002, 'Index','Admin','add','',0,'0'),
(3004, '���¹���Ա', 3003, 'Index','Admin','edit','',0,'0'),
(3005, 'ɾ������Ա', 3004, 'Index','Admin','delete','',0,'0'),

(3100, '��ɫ����', 3000,'Index','Role','','',0,'1'),
(3101, '��ɫ�б�', 3100,'Index','Role','index','',0,'1'),
(3102, '��ӽ�ɫ', 3100,'Index','Role','add','',0,'0'),
(3103, '���½�ɫ', 3100,'Index','Role','update','',0,'0'),
(3104, 'ɾ����ɫ', 3100,'Index','Role','delete','',0,'0'),
(3105, '��ɫ��Ȩ', 3100,'Index','Role','setPermission','',0,'0'),


(4000, '���ݹ���',0,'','','','',0,'1'),

(4001, '�������', 4000, 'Index','Category','','',0,'1'),
(4002, '�����б�', 4001, 'Index','Category','index','',0,'1'),
(4003, '��ӷ���', 4001, 'Index','Category','add','',0,'0'),
(4004, '���·���', 4001, 'Index','Category','edit','',0,'0'),
(4005, 'ɾ������', 4001, 'Index','Category','delete','',0,'0'),
(4006, '��������', 4001, 'Index','Category','sort','',0,'0'),

(4100, '���¹���', 4000, 'Index','News','','',0,'1'),
(4101, '�����б�', 4100, 'Index','News','index','',0,'1'),
(4102, '�������', 4100, 'Index','News','add','',0,'0'),
(4103, '��������', 4100, 'Index','News','edit','',0,'0'),
(4104, 'ɾ������', 4100, 'Index','News','sort','',0,'0'),
(4105, '��������', 4100, 'Index','News','sort','',0,'0'),

(4200, '��������', 4000, 'Index','Link','','',0,'1'),
(4201, '���������б�', 4200,'Index','Link','index','',0,'1'),
(4202, '�����������', 4200,'Index','Link','add','',0,'0'),
(4203, '������������', 4200,'Index','Link','edit','',0,'0'),
(4204, 'ɾ����������', 4200,'Index','Link','delete','',0,'0'),
(4205, '������������', 4200,'Index','Link','sort','',0,'0'),

(4300, '������', 4000,'Index','Ad','','',0,'1'),
(4301, '���λ���б�',4300,'Index','Ad','positionList','',0,'1'),
(4302, '��ӹ��λ��',4300,'Index','Ad','positionAdd','',0,'0'),
(4303, '���¹��λ��',4300,'Index','Ad','positionEdit','',0,'0'),
(4304, 'ɾ�����λ��',4300,'Index','Ad','positionDelete','',0,'0'),
(4305, '����б�',4300,'Index','Ad','index','',0,'0'),
(4306, '��ӹ��',4300,'Index','Ad','add','',0,'0'),
(4307, '���¹��',4300,'Index','Ad','edit','',0,'0'),
(4308, 'ɾ�����',4300,'Index','Ad','delete','',0,'0'),
(4309, '�������',4300,'Index','Ad','sort','',0,'0'),



(5000, '�û�����',0,'','','','',0,'1'),

(5001, '�û�����',5000,'Index','User','','',0,'1'),
(5002, '�û��б�',5001,'Index','User','index','',0,'1'),
(5003, '����û�',5001,'Index','User','add','',0,'0'),
(5004, '�����û�',5001,'Index','User','edit','',0,'0'),
(5005, '�����û�',5001,'Index','User','forbid','',0,'0'),
(5006, '�鿴�û�����',5001,'Index','User','view','',0,'0'),
(5007, '����û�',5001,'Index','User','unforbid','',0,'0'),

(6000, '������Ӧ��', 0,'','','','',0,'1'),
(6001, '���ںŹ���',6000,'Index','WeChat','','',0,'1'),
(6002, '���ں��б�',6001,'Index','WeChat','accountList','',0,'1'),
(6003, '��ӹ��ں�',6001,'Index','WeChat','addCccount','',0,'0'),
(6004, '�༭���ں�',6001,'Index','WeChat','editAccount','',0,'0'),
(6005, 'ɾ�����ں�',6001,'Index','WeChat','deleteAccount','',0,'0'),
(6006, '���ںŲ˵��б�',6001,'Index','WeChat','accountMenuList','',0,'0'),
(6007, '��ӹ��ںŲ˵�',6001,'Index','WeChat','addAccountMenu','',0,'0'),
(6008, '�޸Ĺ��ںŲ˵�',6001,'Index','WeChat','editAccountMenu','',0,'0'),
(6009, 'ɾ�����ںŲ˵�',6001,'Index','WeChat','deleteAccountMenu','',0,'0'),
(6010, '���Ͳ˵���΢�Ź��ں�',6001,'Index','WeChat','pushAccountMenuToWeChat','',0,'0'),
(6011, 'ͼ���زĹ���', 6001, 'Index', 'WeChat', 'imageTextList', '', '0', '0'),
(6012, 'ͼ�������б�', 6001, 'Index', 'WeChat', 'invoice', '', '0', '0'),
(6013, '���ͼ��', 6001, 'Index', 'WeChat', 'addImageText', '', '0', '0'),
(6014, 'ɾ��ͼ��', 6001, 'Index', 'WeChat', 'deleteImageText', '', '0', '0'),
(6015, 'ͼ�������б�', 6001, 'Index', 'WeChat', 'imageTextArticleList', '', '0', '0'),
(6016, '���ͼ������', 6001, 'Index', 'WeChat', 'addImageTextArticle', '', '0', '0'),
(6017, '�༭ͼ������', 6001, 'Index', 'WeChat', 'editImageTextArticle', '', '0', '0'),
(6018, 'ɾ��ͼ������', 6001, 'Index', 'WeChat', 'deleteImageTextArticle', '', '0', '0'),

(7000, '�̳ǹ���', 0,'','','','',0,'1'),
(7001, '�̳ǹ���',7000,'Index','Shop','','',0,'1'),
(7002, '�̼��б�',7001,'Index','Shop','list','',0,'1'),
(7003, '����̼�',7001,'Index','Shop','add','',0,'0'),
(7004, '�༭�̼�',7001,'Index','Shop','edit','',0,'0'),
(7005, '�̼�ɾ��',7001,'Index','Shop','delete','',0,'0'),
(7007, '��Ʒ�б�',7001,'Index','Goods','list','',0,'1'),
(7008, '��Ʒɾ��',7001,'Index','Goods','delete','',0,'0'),
(7009, '�����б�',7001,'Index','Order','list','',0,'1'),
(7010, '�����б�',7001,'Index','comment','list','',0,'1'),
(7011, '����ɾ��', 7001, 'Index', 'comment', 'delete', '', '0', '0');
